# Defect Dossier: DEFECT-DEAP04-BP02 ASSEMBLE_CONOPS_BLUEPRINT ConOps/MissionIntent Collapse

## 1. Metadata
- **Defect ID**: `DEFECT-DEAP04-BP02-CONOPS-AND-MISSION-INTENT-SCHEMA`
- **Severity**: Critical
- **Pillar**: Test & Traceability Integrity
- **Target Component**: `gintatkinson/deap04@1db490b`:
  - `blueprints/ASSEMBLE_CONOPS_BLUEPRINT.md` (Sec 3 L87-137, Sec 4.2 L183-203)
  - Flowdown: `schema/compiler/` -> `crates/deap-conops` (reproduced in `deap03` `assemble-conops`)
- **Labels**: `type::defect`, `status::open`, `safety::major`, `assurance::ring2`,
  `verification::unit-test`

## 2. Normative Anchor
- **SysML QName**: `Avenger5_ConOps::*`, `Avenger5_Architecture::avenger5System::*`
- **Safety / Requirement Ref**: `C1..C10`, `OA-01..12`, `MET-01..10`, `EMG-01..07`, `OPTX-01..02`
- **Standard Clause**: ISO/IEC/IEEE 29148:2018 Sec 5.2.4 & Sec 6.4.2, OMG UAF v2.0, MIL-STD-882E

## 3. Minimal Deterministic Reproducer
1. Compare historical `DEAP01` ConOps baseline (`DEAP-uas-infrastructure-safety@aaf3d5f` /
   `a292fa2^`) against `gintatkinson/uav03-tst01@fcd873a` and `gintatkinson/deap04@1db490b`:
   - `a292fa2^` contained 12 ConOps chapters (`docs/conops/units/conops/01..12_*.md`) and 10
     Mission Intent chapters (`docs/conops/units/mission_intent/01..10_*.md`), assembling into a
     ~1,900-line `CONOPS.md` and ~560-line `MISSION_INTENT.md`.
   - `gintatkinson/deap04@1db490b` `blueprints/ASSEMBLE_CONOPS_BLUEPRINT.md` Sec 4.2 lists only
     5 abstract view names and omits chapter schemas, `OPTX` phase bindings, and `part def`
     `doc` summary inheritance.
   - `deap04/docs/conops/CONOPS_BASELINE.md` is 1,112 B (1 metadata table, 1 Mermaid diagram,
     7 bullets) with zero `MISSION_INTENT.md`.
2. Deterministic reproduction in `uav03-tst01@fcd873a`:

```sh
./.deap/bin/assemble-conops project --workspace . --snapshot .deap/ir.snapshot.bin \
  --out-dir docs/conops --receipt .deap/conops.receipt.json
wc -l docs/conops/CONOPS.md docs/conops/MISSION_INTENT.md
```

## 4. Expected vs Actual
- **Expected**: `assemble-conops` deterministically projects full ISO/IEC/IEEE 29148 12-chapter
  `CONOPS.md` and 10-chapter `MISSION_INTENT.md` (Commander Intent, METL, INCOSE MOE/MOP math,
  Multi-Domain Threat Matrix, PACE C2 Plan, ROE Interlocks, Geozones, Go/No-Go Matrix, Bingo
  Energy Math, Allocation Tags) with populated subsystem descriptions and resolved `OPTX` phases.
- **Actual**:
  - `uav03-tst01/docs/conops/CONOPS.md` collapsed from ~1,900 lines to 203 lines and
    `MISSION_INTENT.md` collapsed to 93 lines, leaving `docs/conops/units/*` orphaned.
  - `CONOPS.md` L57-68 (`## 2. Internal Subsystem Architecture`) prints `-` in `Summary` for all
    12 subsystems (`actuators`..`seeker`) because `doc /* ... */` lives on `part def` types in
    `02_architecture_and_icd.sysml` rather than `part` usages inside `avenger5System`.
  - `CONOPS.md` L93-94 prints `Unknown | Unknown | Pass` for `optx01_SwarmC2Uplink` and
    `optx02_EsadSafetyExchange` `From Phase` and `To Phase`.

## 5. Root Cause & Boundary Analysis
1. **5-Whys Root Cause**:
   - **Why 1**: `CONOPS.md` and `MISSION_INTENT.md` omit core ISO 29148 sections, show `-` on
     all subsystem summaries, and print `Unknown` OPTX phases.
   - **Why 2**: `crates/deap-conops` implements a minimal 6-table dump and reads `doc` only on
     untyped `part` usages without `OPTX` phase-resolution edges.
   - **Why 3**: `ASSEMBLE_CONOPS_BLUEPRINT.md` Sec 4.2 specifies only 5 generic table/diagram
     names without the 12 ConOps / 10 Mission Intent section structure or inheritance laws.
   - **Why 4**: Sec 3 (`M^(0)_ops` stratification) does not specify how `OPTX` `occurrence`
     nodes bind `fromPhase` / `toPhase` or how subsystem `part` usages inherit `part def` `doc`.
   - **Why 5 (Root Cause)**: Blueprint under-specification in `ASSEMBLE_CONOPS_BLUEPRINT.md`
     Sec 3 and Sec 4.2 caused incomplete `deap03`/`deap04` operational projection semantics.
2. **Boundary & Invariant Violated**:
   - `PreStpaOps` (`0x20`) operational completeness (`C1..C10`) and ISO/IEC/IEEE 29148 parity.

## 6. Downstream Impact
- Downstream UAS projects lose PACE C2, ROE interlocks, airspace geozones, Go/No-Go matrices,
  INCOSE MOE/MOP derivations, and bingo energy math when upgrading from `DEAP01` to `deap03/04`.
- `C2` (`>= 1 OPTX`) passes trivially on stub `occurrence` nodes with `Unknown` phases.

## 7. Proposed Upstream Fix & Verification Test
1. **Minimal Surgical Upstream Fix**:
   - Update `ASSEMBLE_CONOPS_BLUEPRINT.md` Sec 3 & Sec 4.2 to mandate the full 12-chapter ConOps
     and 10-chapter Mission Intent projection contract from `M^(0)_ops` (no orphaned `units/`).
   - Define formal `OPTX` source/target phase resolution in `SYSML_V2_SPECIFICATION.md` /
     `RAAML.sysml` and reject (`C2` fail-closed) any `OPTX` resolving to `Unknown` phase.
   - Propagate `part def` `doc /* ... */` summaries to typed `part` usages in `CONOPS.md` Sec 2.
2. **TDD Regression Test & Verification Assertions**:
   - Assert `assemble-conops project` outputs all 12 ConOps sections and 10 Mission Intent
     sections, contains zero `Unknown` OPTX phases and zero `-` summaries for documented `part
     def` subsystems, and fails `check` when an `OPTX` lacks valid `From`/`To` phases.
