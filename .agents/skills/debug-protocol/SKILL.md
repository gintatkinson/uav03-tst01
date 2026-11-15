---
name: debug-protocol
description: "8-step deterministic debugging protocol for runtime bugs, DEAP_E0xxx compiler diagnostics, and test regressions. Use for defects only, not new features."
compatibility: "Works with ./.deap/bin/* --message-format json, cargo test, flutter test, and git."
metadata:
  title: "Recursive Deterministic Debugging Protocol (8-Step Loop)"
  category: debugging
  risk: low
  source: custom
  version: "3.0"
---

# Recursive Deterministic Debugging Protocol (`deap03`)

THIS PROTOCOL IS FOR BUGS, REGRESSIONS, AND DETERMINISTIC `DEAP_E0xxx` FAILURES ONLY.
If the task requests new capability or missing specification coverage, stop and route to `spec-orchestrator` or `feature-driven-implementation`.

## Step 0: Verify Defect Scope

Confirm before debugging:
1. Is existing behavior or a schema/build gate failing against declared `SysML v2` contracts or `deap03` invariants? If yes, proceed.
2. Never edit compiler-projected files under `docs/{conops,interfaces,safety,epics,features,user-stories,use-cases,agile,annex}` or `crates/mission-contracts/src/generated/` as a workaround (`V-DRIFT` rejects manual edits).

## Steps 1-8 Deterministic Isolation & Fix Loop

Every step below MUST preserve strict isolation and empirical evidence (no guessing):

### Step 1: Reproduction & Structured `DEAP_E0xxx` Capture
- Run the failing gate or test with `--message-format json` to capture machine-readable diagnostic codes (`DEAP_E0102`, `DEAP_E0103`, `DEAP_E0104`, `DEAP_E0525`, `DEAP_E0530`, etc.) and exact source spans:

```sh
./.deap/bin/ingest-sysml check --workspace . --schema-dir schema --message-format json
./.deap/bin/assemble-conops check --workspace . --snapshot .deap/ir.snapshot.bin --message-format json
./.deap/bin/compile-sysml check --workspace . --snapshot .deap/ir.snapshot.bin --conops-receipt .deap/conops.receipt.json --out-docs docs --out-contracts crates/mission-contracts/src/generated --out-kani verification/mission-kani/src/generated --message-format json
./.deap/bin/verify-baseline perimeter --workspace . --perimeter-role downstream-consumer --schema-scope all --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b --message-format json
```

### Step 2: Bounded `k`-Hop Context Slicing
- Extract only the localized neighborhood of the failing AST element rather than loading full specs:

```sh
./.deap/bin/ingest-sysml slice <QNAME_OR_NODE> --workspace . --schema-dir schema
```

### Step 3: Ranked Hypothesis Generation
- Rank plausible root causes across upstream `schema/<domain>/` constraints, ISQ unit mismatches, RAAML ID cross-links, generated contract mismatches, concurrency/FFI lifetime issues, or encoding violations.

### Step 4: Empirical Verification & Trace Collection
- Inspect the exact cited file lines (`Schema`, Rust crate, or UI widget), verify inputs and invariants, and eliminate ruled-out hypotheses with raw command output.

### Step 5: Root Cause Isolation (5-Whys)
- Distinguish symptom from root cause (`file:line` or `Package::Element`) and verify the root cause explains 100% of observed symptoms.
- If root cause lies in a frozen `.deap/bin/*` compiler binary rather than workspace inputs, halt remediation and dispatch `.agents/skills/adversarial-code-auditor/SKILL.md` to emit a 7-section `DEAP_E0525` Defect Dossier under `.deap/defects/`.

### Step 6: Minimal Surgical RED-GREEN Fix
1. **RED**: Write or run a minimal deterministic reproducer (failing `cargo test` / Kani bound / minimal check) proving the defect reproduces before touching fix code.
2. **GREEN**: Apply the minimal upstream fix in `schema/<domain>/` or mission source code and re-seal/recompile if `schema/` changed.
3. **CLEAN**: Never leave `.pipeline/`, `scripts/*.py`, symlinks, or non-ASCII bytes in workspace artifacts.

### Step 7: Full Verification Gate
Confirm zero regressions with raw passing output across unit tests, the 5-stage pipeline (when `schema/` or docs changed), and independent baseline gates:

```sh
./.deap/bin/verify-baseline audit --workspace . && echo "AUDIT: PASS"
./.deap/bin/verify-baseline perimeter --workspace . --perimeter-role downstream-consumer --schema-scope all --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b && echo "PERIMETER: PASS"
```

### Step 8: Loop Decision & Non-Closure Rule
- If any proof fails, return to Step 1 (escalate after 3 unsuccessful cycles with full evidence).
- When tracking defects in an issue tracker, mark resolved genuine defects `status:fixed-resolved` (`status::fixed-resolved` on GitLab) with raw verification evidence and `(#<id>)` commit tags; never use auto-closing keywords (`fix #`, `close #`) because `Closed` is reserved for Product Owner sign-off.
