---
name: adversarial-code-auditor
description: "Performs red-team safety, boundary, arithmetic overflow, concurrency, and no_std contract auditing; emits canonical 7-section deap03 DEAP_E0525 Defect Dossiers in .deap/defects/."
compatibility: "Requires ./.deap/bin/reconcile-backlog and git."
metadata:
  title: "Adversarial Code & Safety Contract Auditor (deap03)"
  category: auditing
  risk: low
  source: custom
  version: "3.0"
---

# Adversarial Code & Safety Contract Auditor (`deap03`)

Use this skill to perform rigorous adversarial audits of `#![no_std]` mission contracts (`crates/mission-contracts/src/generated/`), downstream flight/control/FFI/UI code, Kani verification harnesses, or suspected `deap03` toolchain defects, emitting canonical 7-section `DEAP_E0525` Defect Dossiers.

## 1. Five Correctness & Safety Risk Pillars

| Pillar | Inspection Focus |
| :--- | :--- |
| Memory Safety | Out-of-bounds indexing, UAF, FFI pointer lifetime, `unsafe` invariants, panic paths in `#![no_std]` |
| Resource Lifecycle | Missing `dispose()`, unbounded queues/allocations in real-time loops, socket/FD leaks, timeouts |
| Concurrency & Timing | Priority inversion, RMA/WCRT deadline overrun, ISR/thread races, `ChangeNotifier` post-disposal, TOCTOU |
| Arithmetic & Safety Bounds | Signed/unsigned wrap, division-by-zero, unit mismatch, saturation/NaN handling, failed safe-hold fallback |
| Test & Traceability Integrity | Tests passing without exercising failure invariants, mocked persistence in production, broken `V-TRACE` links |

## 2. Severity Classification & Scoped Labels

Every finding MUST use only approved backticked scoped labels when tagging issues or dossiers:

- `type::defect` | `type::safety-gap` | `type::spec-drift`
- `status::open` | `status::triaged` | `status::fixed-resolved`
- `safety::catastrophic` | `safety::hazardous` | `safety::major` | `safety::minor`
- `assurance::ring1` | `assurance::ring2` | `assurance::ring3`
- `rta::simplex-breach` | `rta::rma-overrun` | `rta::crc-mismatch`
- `verification::kani-required` | `verification::hil-required` | `verification::unit-test`

Never create non-bug suggestions as `bug` or `type::defect` (`debug-protocol` processes defects only).

## 3. Canonical 7-Section `DEAP_E0525` Defect Dossier Format

Save defect dossiers under `.deap/defects/<DEFECT-ID>.md` enforcing strict formatting constraints:
- Pure 7-bit LF ASCII (`0x20..=0x7E` + `0x0A`, zero tabs, zero CR, zero UTF-8 symbols).
- Strict line width limit: EVERY line in `.deap/**/*.md` MUST be `<= 100` columns.
- Exact 7 ordered Markdown H2 headings matching `deap03` (`DEAP_E0525`):

```markdown
# Defect Dossier: [DEFECT-ID] [Short Title]

## 1. Metadata
- **Defect ID**: `[DEFECT-ID]`
- **Severity**: [Critical | Important | Minor]
- **Pillar**: [Memory Safety | Resource Lifecycle | Concurrency & Timing | Arithmetic & Bounds]
- **Target Component**: `[path/to/file.rs:line]`
- **Labels**: `type::defect`, `status::open`, `safety::hazardous`, `assurance::ring2`

## 2. Normative Anchor
- **SysML QName**: `[Package::Element]`
- **Safety / Requirement Ref**: `[H-xx / SC-xx / REQ-xx]`
- **Standard Clause**: `[Standard & Clause]`

## 3. Minimal Deterministic Reproducer
1. State deterministic preconditions and input vector.
2. Provide exact non-mutating reproduction command or unit test snippet (`<= 100` cols).

## 4. Expected vs Actual
- **Expected**: Safe bounded behavior or deterministic diagnostic.
- **Actual**: Exact observed panic, overflow, unsafe action, or diagnostic output.

## 5. Root Cause & Boundary Analysis
Explain causality via 5-Whys and identify exact boundary/ring invariant violated.

## 6. Downstream Impact
List affected callers, control loops, FFI boundaries, or generated projections.

## 7. Proposed Upstream Fix & Verification Test
Specify minimal surgical fix, TDD regression test, and Kani/unit assertion proving closure.
```

## 4. Verification & Legacy Dossier Migration

- Verify line length (`<= 100` columns), pure 7-bit LF ASCII, and balanced Mermaid blocks (if included, diagram first line must declare header such as `sequenceDiagram` or `stateDiagram-v2`, with quoted labels and zero semicolons in `Note` text).
- When migrating historical 8-section dossiers into 7-section `deap03` format:

```sh
./.deap/bin/reconcile-backlog migrate-defects --from-dir <OLD_DIR> --out-file .deap/defects/MIGRATED_DOSSIERS.md --workspace . && echo "MIGRATE_DEFECTS: PASS"
```

- Validate offline tracker store consistency after registering any defect dossier:

```sh
./.deap/bin/reconcile-backlog tracker --workspace . --snapshot .deap/ir.snapshot.bin --docs-dir docs --schema-dir schema --provider offline && echo "TRACKER_CHECK: PASS"
```
