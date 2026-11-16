# Defect Dossier: DEFECT-DEAP03-E0401-D1-LOSS-GROUNDING TQL-5 D1 Loss Grounding Divergence

## 1. Metadata
- **Defect ID**: `DEFECT-DEAP03-E0401-D1-LOSS-GROUNDING`
- **Severity**: Critical
- **Pillar**: Test & Traceability Integrity
- **Target Component**: `.deap/bin/verify-baseline` (`audit`, TQL-5 independent parser)
- **Labels**: `type::defect`, `status::open`, `safety::hazardous`, `assurance::ring1`,
  `verification::unit-test`

## 2. Normative Anchor
- **SysML QName**: `Avenger5_Safety::loss01_LaunchCrewOrPublicHarm` (specializing
  `Avenger5_Architecture::scLaunchCrewZeroInadvertentEnable`)
- **Safety / Requirement Ref**: `L-01`..`L-03` (`H-01`..`H-05`; `SC-01`..`SC-07`;
  `REQ-01`..`REQ-07`)
- **Standard Clause**: OMG SysML v2.0 / KerML 1.0, OMG RAAML v1.0 (`STPA::Loss`),
  ISO/IEC/IEEE 29148 (`StakeholderConcern`), DO-330 `TQL-1` / `TQL-5` (`D1` grounding)

## 3. Minimal Deterministic Reproducer
1. Preconditions and sealed IR baseline:
   - Pure 7-bit LF ASCII schemas reside under `schema/avenger5_uas/` alongside foundation
     libraries `schema/lib/ISQ.sysml` and `schema/lib/RAAML.sysml`.
   - Stages 1, 2, 3 (`TQL-1`), 4, and Stage 5 `perimeter` all exit `0`:
     - `./.deap/bin/ingest-sysml check` & `seal` -> exit `0`
     - `./.deap/bin/assemble-conops check` & `project` -> exit `0` (`C1..C9` `PASS`)
     - `./.deap/bin/compile-sysml check` & `build` -> exit `0` (all 5 passes `S1..S5`:
       `3` Losses, `5` Hazards, `6` Control Actions, `24` UCAs, `24` Loss Scenarios, `7` SCs,
       `24` CSCs, `8` FMEDA modes, `5` ZBDD gates, `RTA` CTMC/RMA, and generated
       `#![no_std]` mission contracts & Kani harnesses)
     - `./.deap/bin/reconcile-backlog project/sync/tracker --provider offline` -> exit `0`
     - `./.deap/bin/verify-baseline perimeter --perimeter-role downstream-consumer`
       `--schema-scope all` -> exit `0`
2. Tested valid SysML v2 / RAAML v1.0 encodings that pass `TQL-1` yet STILL trigger
   `DEAP_E0401` (`exit 13`) in `./.deap/bin/verify-baseline audit`:
   - `@RAAML::STPA::Loss` with `stakeholderRef = "scLaunchCrewZeroInadvertentEnable"` and
     `'references' = "Avenger5_Architecture::...,Avenger5_Architecture::launchCrew,..."`.
   - Full QName `stakeholderRef = "Avenger5_Architecture::...::sc..."` with `satisfy` edges.
   - Package-level `concern scLaunchCrewZeroInadvertentEnable : StakeholderConcern` directly in
     `package Avenger5_Architecture` vs nested inside `part avenger5System`.
   - Probe A: `StakeholderConcern :> RAAML::LifecycleAssuranceObjective`, 2-segment QName
     `stakeholderRef = "Avenger5_Architecture::sc..."`, and `met06_LaunchVelMps` in
     `loss01` `'references'` -> `DEAP_E0401` (`exit 13`).
   - Probe B: actor QNames (`"Avenger5_Architecture::{launchCrew,pilot,payloadOp}"`) plus
     `allocate loss01..03 to Avenger5_Architecture::sc...;` -> `DEAP_E0401` (`exit 13`).
   - Probe C1: 1-to-1 bijective 3 concerns (`scLaunchCrewZeroInadvertentEnable`,
     `scAirworthinessContainment`, `scPayloadContinuityAssurance`) plus `satisfy
     Avenger5_Architecture::sc...;` inside `requirement loss01..03` -> `TQL-1` `exit 0`,
     `verify-baseline audit` `DEAP_E0401` (`exit 13`).
   - Probe C2: `part loss01..03` (matching `part hazard*/uca*/ls*/sc*`) with `satisfy
     Avenger5_Architecture::sc...;` -> `TQL-1` `exit 0`, `verify-baseline audit` `DEAP_E0401`
     (`exit 13`).
   - Control test: unquoted `references = "..."` is rejected by Stage 1 (`DEAP_E0202`).
3. Self-contained non-mutating reproduction command:

```sh
./.deap/bin/compile-sysml check --workspace . --snapshot .deap/ir.snapshot.bin \
  --conops-receipt .deap/conops.receipt.json --out-docs docs \
  --out-contracts crates/mission-contracts/src/generated \
  --out-kani verification/mission-kani/src/generated --message-format json
./.deap/bin/verify-baseline audit --workspace . \
  --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b \
  --message-format json
```

## 4. Expected vs Actual
- **Expected**: Because `.deap/bin/ingest-sysml` (`C1..C9`), `.deap/bin/assemble-conops`,
  and `.deap/bin/compile-sysml` (`TQL-1`, `D1..D6`, `S1..S5`) accept `Avenger5_Safety::loss01`..
  `loss03` grounded to `Avenger5_Architecture::scLaunchCrewZeroInadvertentEnable` and
  `scAirworthinessContainment`, the `TQL-5` oracle (`verify-baseline audit`) resolves the same
  `D1` grounding witness and exits `0`.
- **Actual**: `compile-sysml` exits `0`, whereas `verify-baseline audit` exits `13` with
  `[DEAP_E0401] DEAP_E0401`. Independent `--emit-slice` shows `node 734` (`loss01`) has only
  `Specializes -> Avenger5_Architecture::scLaunchCrewZeroInadvertentEnable` and `node 452`
  (`scLaunchCrewZeroInadvertentEnable`) has `family=Requirement`.

## 5. Root Cause & Boundary Analysis
1. **5-Whys Root Cause**:
   - **Why 1**: `verify-baseline audit` exits `13` (`DEAP_E0401`).
   - **Why 2**: The TQL-5 `D1` check fails to match `@RAAML::STPA::Loss` nodes to any
     valid stakeholder concern target.
   - **Why 3**: Running `verify-baseline audit --schema-dir schema/lib` exits `14`
     (`DEAP_E0531`) against `schema/`'s `h_merkle` and `h_ops` hashes, proving `verify-baseline`
     computes bit-for-bit identical `CanonicalIr` (`h_merkle`) and `h_ops` hashes to Stage 1
     `ingest-sysml` when auditing `schema/`.
   - **Why 4**: However, `verify-baseline audit --emit-slice` on `loss01`, `hazard01`, and
     `ca01` shows the `TQL-5` independent slice graph omits `'references'` metadata edges
     completely and indexes `concern` declarations as `family=Requirement`. Neither
     `Specializes`, `'references'`, `stakeholderRef`, `allocate`, `satisfy`, nor `part loss`
     satisfies the `TQL-5` `D1` check.
   - **Why 5 (Root Cause)**: Divergence inside `verify-baseline`'s own `D1` evaluator over
     an otherwise bit-identical `CanonicalIr` (`h_merkle` / `h_ops` pass `DEAP_E0531`):
     `compile-sysml` (`TQL-1`) resolves `D1` via `PreStpaOps` concerns/actors/references,
     whereas `verify-baseline audit` (`TQL-5`) omits `'references'` edges in its slice graph
     and fails to accept `Specializes`, `allocate`, `satisfy`, or `stakeholderRef` `D1`
     grounding paths.
2. **Boundary & Invariant Violated**:
   - **Assurance Boundary**: `DO-330 TQL-1` (`compile-sysml` Pass 1 `D1`) vs `DO-330 TQL-5`
     (`verify-baseline audit`) `D1` evaluator equivalence over bit-identical `CanonicalIr`.

## 6. Downstream Impact
- Full mission `#![no_std]` contract generation, safety case (`docs/safety/SAFETY_CASE.md`),
  ICDs (`docs/interfaces/`), WBS/Agile projections, and `verify-baseline perimeter`
  (`--schema-scope all`) succeed (`exit 0`).
- However, `.git/hooks/pre-commit` installed by `verify-baseline setup-hooks` executes
  full-domain `verify-baseline audit`, which exits `13` (`DEAP_E0401`) and blocks `git commit`
  without bypassing the hook until upstream `verify-baseline` `D1` parity is restored.

## 7. Proposed Upstream Fix & Verification Test
1. **Minimal Surgical Upstream Fix**:
   - Align `.deap/bin/verify-baseline` (`TQL-5` independent parser and `D1` checker) with
     `ingest-sysml` / `compile-sysml` (`TQL-1`) so `concern` nodes and single-quoted
     `'references'` / `stakeholderRef` / `Specializes` (`:>`) paths on `@RAAML::STPA::Loss`
     resolve identically across both `TQL-1` and `TQL-5`.
   - Preserve fail-closed `DEAP_E0401` when neither `Specializes`, `stakeholder ... subsets`,
     nor `@RAAML::STPA::Loss.stakeholderRef` / `'references'` targets a valid concern or actor.
2. **TDD Regression Test & Verification Assertions**:
   - Assert both `compile-sysml check` and `verify-baseline audit` exit `0` on Avenger 5
     `schema/` and reject a negative fixture with unknown `stakeholderRef` (`exit 13`).
