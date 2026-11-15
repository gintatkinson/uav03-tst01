---
name: spec-user-story-engineering
description: "Models behavioral allocations, verification test cases, and WBS/Agile backlog traceability in SysML v2 and reconciles docs/agile/, docs/annex/, and docs/user-stories/ via ./.deap/bin/reconcile-backlog."
compatibility: "Requires ./.deap/bin/reconcile-backlog, ./.deap/bin/ingest-sysml, and ./.deap/bin/verify-baseline."
metadata:
  title: "Specification User Story, WBS & Backlog Reconciliation (Worker 1D / P4-P5)"
  category: architecture
  risk: low
  source: custom
  version: "3.0"
---

# Specification User Story, WBS & Backlog Reconciliation

Use this skill to close requirement-to-verification behavioral traceability in `schema/<domain>/`, project the complete Agile/WBS documentation matrix (`docs/epics/`, `docs/features/`, `docs/user-stories/`, `docs/use-cases/`, `docs/agile/`, `docs/annex/`, `docs/management/`), and run deterministic 3-way Merkle tracker reconciliation via `./.deap/bin/reconcile-backlog`.

## Behavioral, Calculation & Verification Modeling (`schema/<domain>/`)

1. **Behavioral Extraction from Canonical AST**:
   - Capture state transitions (`LifecycleStateMachine` + `@LifecycleRole`), algorithmic derivations (`calc def` with coherent ISQ units), cross-ring timings (`@RmaTask`), and signal guards (`@SignalContract`) inside `schema/<domain>/*.sysml`.
2. **Requirement & Test Case Triad Closure (`V-TRACE`)**:
   - Annotate requirements with `@RAAML::ThreeRing::TraceReq { reqId = "REQ-..."; rationale = "..."; }`.
   - Bind every requirement and safety constraint to formal verification cases specializing `RAAML::VerificationTestCase` annotated with `@RAAML::ThreeRing::VerificationTest { testId = "TC-..."; reqId = "REQ-..."; method = "HardwareInLoop" | "FormalAnalysis" | "UnitTest" | "Inspection"; }`.
3. **WBS & Monotone Admissible Reconciliation (`A_adm`)**:
   - `reconcile-backlog` derives WBS packages, Epics, Features, User Stories, Use Cases, and M3.5 annexes deterministically from `.deap/ir.snapshot.bin`.
   - When tracking status changes in downstream repositories, `reconcile-backlog sync` enforces monotone admissible state progression `A_adm` against `.deap/ancestor.snapshot.bin` without allowing drift between `schema/`, `docs/`, and the active tracker store.

## Projection, Slicing & Multi-Provider Sync Commands

Inspect bounded backlog slices first to avoid unnecessary file reads, project offline WBS/Agile artifacts, and synchronize against the configured tracker (`offline`, `github`, or `gitlab`):

```sh
./.deap/bin/reconcile-backlog slice <QNAME_OR_NODE> --workspace . --snapshot .deap/ir.snapshot.bin
./.deap/bin/reconcile-backlog project --workspace . --snapshot .deap/ir.snapshot.bin --docs-dir docs --schema-dir schema --provider offline && echo "BACKLOG_PROJECT: PASS"
./.deap/bin/reconcile-backlog sync --workspace . --snapshot .deap/ir.snapshot.bin --docs-dir docs --schema-dir schema --provider offline && echo "BACKLOG_SYNC: PASS"
./.deap/bin/reconcile-backlog tracker --workspace . --snapshot .deap/ir.snapshot.bin --docs-dir docs --schema-dir schema --provider offline && echo "TRACKER_CHECK: PASS"
```

When GitHub or self-managed GitLab tracker sync is requested in a downstream project with remote credentials configured:

```sh
./.deap/bin/reconcile-backlog sync --workspace . --snapshot .deap/ir.snapshot.bin --docs-dir docs --schema-dir schema --provider github --project "<owner>/<repo>" --token "$GITHUB_TOKEN" && echo "GITHUB_SYNC: PASS"
./.deap/bin/reconcile-backlog sync --workspace . --snapshot .deap/ir.snapshot.bin --docs-dir docs --schema-dir schema --provider gitlab --endpoint "https://gitlab.internal.example/api/v4" --project "<group>/<repo>" --ca-bundle /path/to/ca-bundle.pem --token "$GITLAB_TOKEN" && echo "GITLAB_SYNC: PASS"
```

## Non-Closure & Pure 7-Bit ASCII Rules

- Never hand-edit projected files in `docs/epics/`, `docs/features/`, `docs/user-stories/`, `docs/use-cases/`, `docs/agile/`, or `docs/annex/`. Update `schema/` and re-run `reconcile-backlog project`.
- Never use auto-closing keywords (`fix #`, `fixes #`, `close #`, `resolve #`) in commit messages; reserve issue closure for Product Owner validation while agents mark verified items `status:fixed-resolved` (or `status::fixed-resolved`) with `(#<id>)` references.
- Verify all authored files under `schema/` and `docs/` (excluding binary reference PDFs) comply with pure 7-bit LF ASCII.
