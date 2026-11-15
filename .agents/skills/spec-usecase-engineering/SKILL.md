---
name: spec-usecase-engineering
description: "Models nominal, off-nominal, and contingency system interactions in SysML v2 (OperationalActivity, use case def, ExternalActor, constraints) feeding compile-sysml and reconcile-backlog."
compatibility: "Requires ./.deap/bin/ingest-sysml, compile-sysml, and reconcile-backlog."
metadata:
  title: "Specification Use Case Engineering (System Interaction)"
  category: architecture
  risk: low
  source: custom
  version: "3.0"
---

# Specification Use Case Engineering (System Interaction)

Use this skill to model nominal, degraded, and contingency end-to-end system interactions in `schema/<domain>/*.sysml` and verify/project UML Use Cases cleanly into `docs/use-cases/` via `./.deap/bin/compile-sysml` and `./.deap/bin/reconcile-backlog`.

## SSOT & Non-Drift Rule (`V-DRIFT`)

Never draft or hand-patch standalone `docs/use-cases/uc-*.md` out of synchronization with `schema/`. Author canonical `use case def`, `action def` (`:> RAAML::OperationalActivity`), `state def`, and `ExternalActor` interactions inside `schema/<domain>/*.sysml` first, then run `./.deap/bin/reconcile-backlog project`.

## SysML v2 System Interaction Modeling Rules

1. **Boundary & Actor Allocation**:
   - Explicitly separate system-of-interest `Subsystem` parts from external `ExternalActor` entities (GCS operator, launch crew, range safety officer, airspace/DAA feed).
   - Bind every initiating and participating actor through typed `port` interfaces or `action` parameters.
2. **Operational Activity Qualification**:
   - Specialize operational flow nodes from `RAAML::OperationalActivity`.
   - Always qualify metadata annotations as `@RAAML::ThreeRing::OperationalActivity { oaId = "OA-..."; phase = "..."; summary = "..."; }` (never unqualified `@OperationalActivity`, which collides with `action def OperationalActivity`) paired with `@RAAML::ThreeRing::ActionPartition { kind = ActionKind::Ops | Control | Focus | Aux; }`.
3. **Nominal, Alternate & Contingency Coverage**:
   - Cover the full mission lifecycle: `Init` (pre-flight / launch prep), `Nom` (cruise / payload / recovery), `Deg` (C2 degradation / GNSS denial / propulsion derate), and `SafeHold` (emergency safe abort / ESAD safe-state / RTH).
   - Ensure every validation guard and `@EmergencyRule` trigger in `schema/<domain>/` has a corresponding off-nominal/contingency path linking back to `@SafetyConstraint` and `@ControllerConstraint`.
4. **Traceability Closure (`V-TRACE`)**:
   - Link each use case / operational activity to its realizing structural `part def` subsystems, requirements (`@TraceReq`), and `VerificationTestCase` verification definitions.

## Projection, Slicing & Backlog Sync Commands

Always pass downstream-safe output directories on `compile-sysml` and check generated `docs/use-cases/` after projection:

```sh
./.deap/bin/ingest-sysml slice <QNAME_OR_NODE> --workspace . --schema-dir schema
./.deap/bin/ingest-sysml seal --workspace . --schema-dir schema --out-snapshot .deap/ir.snapshot.bin && echo "STAGE1_SEAL: PASS"
./.deap/bin/assemble-conops project --workspace . --snapshot .deap/ir.snapshot.bin --out-dir docs/conops --receipt .deap/conops.receipt.json && echo "STAGE2_CONOPS: PASS"
./.deap/bin/compile-sysml build --workspace . --snapshot .deap/ir.snapshot.bin --conops-receipt .deap/conops.receipt.json --out-docs docs --out-contracts crates/mission-contracts/src/generated --out-kani verification/mission-kani/src/generated --receipt .deap/compile.receipt.json && echo "STAGE3_COMPILE: PASS"
./.deap/bin/reconcile-backlog project --workspace . --snapshot .deap/ir.snapshot.bin --docs-dir docs --schema-dir schema --provider offline && echo "STAGE4_BACKLOG: PASS"
```

## Pure 7-Bit ASCII & Mermaid Integrity

- Keep all `.sysml` and supporting extraction tables strictly pure 7-bit LF ASCII (`0x20..=0x7E` + `0x0A`, zero tabs, zero CR).
- Quote any diagram node labels containing spaces, slashes, colons, parentheses, or comparison operators, and use valid Mermaid headers (`flowchart TD`, `sequenceDiagram`, `stateDiagram-v2`, `classDiagram`) when authoring design notes.
