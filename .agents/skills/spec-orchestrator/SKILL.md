---
name: spec-orchestrator
description: "Orchestrates the end-to-end deap03 specification engineering workflow from Step 0.0 brownfield OEM/PDF ingestion in docs/reference/ through canonical SysML v2.0 + ISQ + RAAML v1.0 authoring and deterministic 5-stage execution of ./.deap/bin/*."
compatibility: "Requires ./.deap/bin/{ingest-sysml,assemble-conops,compile-sysml,reconcile-backlog,verify-baseline} and git."
metadata:
  title: "Autonomous Specification Orchestrator (deap03 Master Command)"
  category: orchestration
  risk: medium
  source: custom
  version: "3.0"
---

# Autonomous Specification Orchestrator (deap03 Master Command)

Use this skill as the master coordination workflow for transforming unstructured customer manuals, OEM datasheets, and normative standards into verified `SysML v2.0 + ISQ + RAAML v1.0` schemas and deterministic `deap03` projections via `./.deap/bin/*`.

## Core Perimeter & Pipeline Invariants

1. **Single Source of Truth (`schema/`)**: Canonical semantics live strictly in `schema/lib/{ISQ,RAAML}.sysml` (read-only foundation libraries) and customer domain packages under `schema/<domain>/*.sysml`. Never hand-edit compiler-projected documents (`docs/conops/{CONOPS,MISSION_INTENT}.md`, `docs/interfaces/`, `docs/safety/`, `docs/epics/`, `docs/features/`, `docs/user-stories/`, `docs/use-cases/`, `docs/agile/`, `docs/annex/`, or `crates/mission-contracts/src/generated/`).
2. **Downstream `compile-sysml` Output Rule**: `compile-sysml` defaults `--out-contracts` to `crates/deap-contracts/src/generated`, which triggers `UpstreamSourceLeak` (`DEAP_E0104`) in downstream workspaces. EVERY invocation of `./.deap/bin/compile-sysml` (`check`, `build`, `supersede-seed`, `inject-docstrings`) MUST explicitly pass `--out-contracts crates/mission-contracts/src/generated --out-kani verification/mission-kani/src/generated`.
3. **Zero Symlinks & Zero Upstream Leakage**: Operate strictly inside the downstream workspace using real directories (zero symbolic links anywhere outside `.git/`). Never create or copy upstream `crates/deap-*`, `blueprints/`, legacy `.pipeline/`, `rules/`, root `skills/`, `scripts/*.py`, or `target/release/`.
4. **Pure 7-Bit LF ASCII**: Every `.md`, `.yml`, `.yaml`, and `.sysml` file MUST contain only printable ASCII (`0x20..=0x7E`) and Unix LF (`0x0A`) with zero tabs (`0x09`) and zero CR (`0x0D`). Use `<=`, `>=`, `->`, `degC`, `lambda`, and `delta` instead of Unicode glyphs.

## Bounded Context Slicing (`O(k)`)

Do not load entire large snapshots or projected markdown dumps into agent context. Query bounded `k`-hop semantic slices directly from the toolchain before dispatching item workers:

```sh
./.deap/bin/ingest-sysml slice <QNAME_OR_NODE> --workspace . --schema-dir schema
./.deap/bin/assemble-conops slice <QNAME_OR_NODE> --workspace . --snapshot .deap/ir.snapshot.bin
./.deap/bin/reconcile-backlog slice <QNAME_OR_NODE> --workspace . --snapshot .deap/ir.snapshot.bin
```

## Step 0.0: Worker 00 -- Brownfield / OEM Reference Document Ingestion

For customer projects starting from prose manuals, PDF datasheets, ICDs, block diagrams, or BOM spreadsheets under `docs/reference/`:

1. **Inventory Inputs**: List all customer `.pdf`, `.md`, `.txt`, `.csv`, and table files in `docs/reference/` (preserving `docs/reference/.gitkeep`).
2. **Context-Isolated Extraction Dispatch**: Dispatch fresh `research` or `self` subagents per document or subsystem group so large binary PDFs never bloat the coordinator context. Instruct each worker to read only its assigned document(s) and return verbatim physical evidence with `<pdf_filename>#p<page>` citations.
3. **Ground Extraction Tables in `docs/reference/extracted/<slug>.md`**: Synthesize pure 7-bit LF ASCII Markdown pipe-table extraction records containing:
   - Physical dimensions, mass, inertia, operating ceilings, propulsion/power/energy budgets, and thermal limits.
   - Subsystem interconnect topology, bus protocols, signal dictionaries, timing/latency rates, pin/channel safety interlocks, and fail-safe defaults.
   - Pre-flight checklists, Go/No-Go criteria, launcher/recovery envelopes, emergency contingency rules, and crew hazard procedures.
   - Every table row MUST cite `<file>#p<page>`. Where an OEM datasheet omits an assurance input (such as piece-part failure rate `lambda`, diagnostic coverage `dc`, common-cause `beta`, or WCET), record the unresolved engineering gap explicitly and budget conservative catalog baselines only with explicit provenance tagging (`docs/catalogs/...` vs OEM datasheet).
4. **Lift to Canonical SysML v2 Domain Packages**: Using `.agents/skills/schema-specification-engineering/SKILL.md`, `.agents/skills/spec-conops-engineering/SKILL.md`, `.agents/skills/spec-icd-engineering/SKILL.md`, `.agents/skills/spec-user-story-engineering/SKILL.md`, and `.agents/skills/spec-usecase-engineering/SKILL.md`, author modular domain models under `schema/<domain>/*.sysml` importing `ISQ::*` and `RAAML::*`.

## Deterministic 5-Stage `deap03` Execution Workflow

Execute Stages 1 through 5 strictly in sequence. Pass `--message-format json` when diagnosing failures.

### Stage 1: SysML v2 / RAAML Frontend Check & Snapshot Seal

Validate all schema packages and seal the canonical IR snapshot `.deap/ir.snapshot.bin`:

```sh
./.deap/bin/ingest-sysml check --workspace . --schema-dir schema && echo "STAGE1_CHECK: PASS"
./.deap/bin/ingest-sysml seal --workspace . --schema-dir schema --out-snapshot .deap/ir.snapshot.bin && echo "STAGE1_SEAL: PASS"
```

### Stage 2: Pre-STPA ConOps & Mission Intent Projection

Verify operational completeness (`C1..C7` + `C9`, METL, operational modes, emergency rules) and project `docs/conops/{CONOPS,MISSION_INTENT}.md` plus `.deap/conops.receipt.json`:

```sh
./.deap/bin/assemble-conops check --workspace . --snapshot .deap/ir.snapshot.bin && echo "STAGE2_CHECK: PASS"
./.deap/bin/assemble-conops project --workspace . --snapshot .deap/ir.snapshot.bin --out-dir docs/conops --receipt .deap/conops.receipt.json && echo "STAGE2_CONOPS: PASS"
```

### Stage 3: 5-Pass Safety Compiler & `#![no_std]` Contract Synthesis

Run the 5-pass STPA / EMV2 / FMEDA / ZBDD-FTA / RTA compiler, verify safety invariants, and emit documentation, contracts, and Kani harnesses into downstream-safe directories:

```sh
./.deap/bin/compile-sysml check --workspace . --snapshot .deap/ir.snapshot.bin --conops-receipt .deap/conops.receipt.json --out-docs docs --out-contracts crates/mission-contracts/src/generated --out-kani verification/mission-kani/src/generated && echo "STAGE3_CHECK: PASS"
./.deap/bin/compile-sysml build --workspace . --snapshot .deap/ir.snapshot.bin --conops-receipt .deap/conops.receipt.json --out-docs docs --out-contracts crates/mission-contracts/src/generated --out-kani verification/mission-kani/src/generated --receipt .deap/compile.receipt.json && echo "STAGE3_COMPILE: PASS"
```

### Stage 4: Agile / WBS Projection & Backlog Reconciliation

Project Epics, Features, User Stories, Use Cases, and WBS/M3.5 annexes into `docs/`, then run 3-way Merkle sync (default `--provider offline`, or `--provider github` / `--provider gitlab` when configured):

```sh
./.deap/bin/reconcile-backlog project --workspace . --snapshot .deap/ir.snapshot.bin --docs-dir docs --schema-dir schema --provider offline && echo "STAGE4_BACKLOG: PASS"
./.deap/bin/reconcile-backlog sync --workspace . --snapshot .deap/ir.snapshot.bin --docs-dir docs --schema-dir schema --provider offline && echo "STAGE4_SYNC: PASS"
```

### Stage 5: Independent `DO-330 TQL-5` Baseline Audit & Perimeter Gate

Verify manifest signature parity, domain traceability/quantitative closure (`audit`), downstream zero-source perimeter compliance (`--schema-scope all`), and full domain Git hooks:

```sh
./.deap/bin/verify-baseline verify-manifest --workspace . --manifest .deap/update-manifest.json --bundle-dir .deap/bin --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b && echo "MANIFEST: PASS"
./.deap/bin/verify-baseline audit --workspace . && echo "STAGE5_AUDIT: PASS"
./.deap/bin/verify-baseline perimeter --workspace . --perimeter-role downstream-consumer --schema-scope all --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b && echo "STAGE5_PERIMETER_ALL: PASS"
./.deap/bin/verify-baseline setup-hooks --workspace . --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b && echo "FULL_SSOT_HOOKS: PASS"
```

## Error Recovery & Adversarial Audit Protocol

1. **No Manual Bypass Edits**: Never manually patch compiler-projected `docs/` files to silence an audit failure (`V-DRIFT` rejects drift). Fix the canonical `schema/<domain>/*.sysml` model or extraction gap and re-run Stages 1..5.
2. **Structured Diagnostics (`debug-protocol`)**: Capture JSON diagnostics (`--message-format json`), isolate the offending `QNAME` via `./.deap/bin/ingest-sysml slice <QNAME>`, and apply `.agents/skills/debug-protocol/SKILL.md`.
3. **Confirmed Toolchain / Compiler Faults (`adversarial-code-auditor`)**: If a failure stems from a reproducible `deap03` binary fault rather than invalid schema syntax, dispatch `.agents/skills/adversarial-code-auditor/SKILL.md` to produce a verified 7-section `DEAP_E0525` Defect Dossier under `.deap/defects/` (`<= 100` columns/line, pure 7-bit LF ASCII).

## Orchestration Completion Checklist

- [ ] `docs/reference/.gitkeep` and `docs/reference/extracted/*.md` cite `<file>#p<page>` for all OEM parameters and log all engineering gaps.
- [ ] `schema/<domain>/*.sysml` compiles cleanly (`STAGE1_CHECK: PASS`, `STAGE1_SEAL: PASS`).
- [ ] `assemble-conops project` exits 0 (`STAGE2_CONOPS: PASS`).
- [ ] `compile-sysml build` passes with downstream `--out-contracts` and `--out-kani` (`STAGE3_COMPILE: PASS`).
- [ ] `reconcile-backlog project` exits 0 (`STAGE4_BACKLOG: PASS`).
- [ ] `verify-baseline audit` and `perimeter --schema-scope all` exit 0 (`STAGE5_AUDIT: PASS`, `STAGE5_PERIMETER_ALL: PASS`).
- [ ] Full domain Git hooks installed via `verify-baseline setup-hooks` (`FULL_SSOT_HOOKS: PASS`).
