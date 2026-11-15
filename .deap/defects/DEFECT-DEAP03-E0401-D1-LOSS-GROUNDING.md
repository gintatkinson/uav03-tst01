# Defect Dossier: DEFECT-DEAP03-E0401-D1-LOSS-GROUNDING Pass 1 D1 Loss Grounding Rejection

## 1. Metadata
- **Defect ID**: `DEFECT-DEAP03-E0401-D1-LOSS-GROUNDING`
- **Severity**: Critical
- **Pillar**: Test & Traceability Integrity
- **Target Component**: `.deap/bin/compile-sysml` (D1 Pass 1) and
  `.deap/bin/verify-baseline` (`audit`)
- **Labels**: `type::defect`, `status::open`, `safety::hazardous`, `assurance::ring1`,
  `verification::unit-test`

## 2. Normative Anchor
- **SysML QName**: `Avenger5_Safety::loss01_LaunchCrewOrPublicHarm` (referencing
  `Avenger5_Architecture::launchCrew`, `Avenger5_ConOps::oa04`, and
  `Avenger5_Architecture::avenger5System::scLaunchCrewZeroInadvertentEnable`)
- **Safety / Requirement Ref**: `L-01` (`H-01`, `H-02`, `H-04`; `SC-01`..`SC-07`;
  `REQ-01`..`REQ-07`; `OA-04`)
- **Standard Clause**: OMG SysML v2.0 / KerML 1.0, OMG RAAML v1.0 (`STPA::Loss`),
  ISO/IEC/IEEE 29148 (`StakeholderConcern`), DO-330 `TQL-1` / `TQL-5` (`D1` grounding)

## 3. Minimal Deterministic Reproducer
1. Preconditions and sealed IR baseline:
   - Workspace holds pure 7-bit LF ASCII schemas under `schema/avenger5_uas/` and foundation
     libraries `schema/lib/ISQ.sysml` and `schema/lib/RAAML.sysml`.
   - Stages 1, 2, and 4 pass cleanly on the sealed IR snapshot (`.deap/ir.snapshot.bin`):
     - `./.deap/bin/ingest-sysml check --workspace . --schema-dir schema` -> exit `0`
     - `./.deap/bin/ingest-sysml seal --workspace . --schema-dir schema` targeting
       `.deap/ir.snapshot.bin` -> exit `0`
     - `./.deap/bin/assemble-conops project` -> exit `0` (`C1..C9` `PASS`, `conopsView` `C10`
       present; `docs/conops/CONOPS.md` renders `launchCrew` and `OA-04`, and
       `docs/conops/MISSION_INTENT.md` renders `scLaunchCrewZeroInadvertentEnable`)
     - `./.deap/bin/reconcile-backlog project` and `sync` (`--provider offline`) -> exit `0`
   - `Avenger5_Safety::loss01_LaunchCrewOrPublicHarm` (IR `node 710`) specializes
     `scLaunchCrewZeroInadvertentEnable`, declares `stakeholder st`, and annotates `L-01`.
2. Tested SysML v2 / RAAML v1.0 constructs that STILL trigger `DEAP_E0401` on `L-01`:
   - Variant 1: `stakeholder st subsets Avenger5_Architecture::launchCrew;` inside
     `requirement loss01_...` plus:
     `@RAAML::STPA::Loss { lossId = "L-01"; severity = 5; stakeholderRef = "launchCrew"; }`
   - Variant 2: Unquoted QName/path references:
     `stakeholderRef = Avenger5_Architecture::launchCrew;`, `Avenger5_ConOps::oa04;`, and
     `Avenger5_Architecture::avenger5System.esad;`
   - Variant 3: String QName/OA IDs:
     `stakeholderRef = "Avenger5_Architecture::launchCrew";` and `stakeholderRef = "OA-04";`
   - Variant 4: `allocate loss01_LaunchCrewOrPublicHarm to Avenger5_ConOps::oa04;`
   - Variant 5:
     `view conopsView { expose Avenger5_Architecture::launchCrew; expose Avenger5_ConOps::oa01; }`
   - Variant 6: `concern def LaunchCrewSafetyConcern :> RAAML::LifecycleAssuranceObjective`
     plus `concern lcConcern01` and `stakeholderRef = "lcConcern01";`
   - Parser check: `use case ... { objective ... }` fails Stage 1 frontend parser `DEAP_E0202`.
3. Self-contained reproduction commands (Stages 1, 2, 3, and 5):

```sh
./.deap/bin/ingest-sysml check --workspace . --schema-dir schema
./.deap/bin/ingest-sysml seal --workspace . --schema-dir schema \
  --out-snapshot .deap/ir.snapshot.bin
./.deap/bin/assemble-conops project --workspace . --snapshot .deap/ir.snapshot.bin \
  --out-dir docs/conops --receipt .deap/conops.receipt.json
./.deap/bin/compile-sysml check --workspace . --snapshot .deap/ir.snapshot.bin \
  --conops-receipt .deap/conops.receipt.json --out-docs docs \
  --out-contracts crates/mission-contracts/src/generated \
  --out-kani verification/mission-kani/src/generated \
  --receipt .deap/compile.receipt.json --message-format json
./.deap/bin/verify-baseline audit --workspace . --schema-scope all \
  --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b \
  --message-format json
```

## 4. Expected vs Actual
- **Expected**: After Stage 1 seals `.deap/ir.snapshot.bin` and Stage 2 passes `C1..C10` with
  `Avenger5_Architecture::launchCrew` (`RAAML::ExternalActor`) and `Avenger5_ConOps::oa04`
  (`RAAML::OperationalActivity`, `OA-04`) present in `PreStpaOps`, Pass 1 `D1` in
  `./.deap/bin/compile-sysml` and `./.deap/bin/verify-baseline audit` resolve the sealed
  `PreStpaOps` stakeholder/concern/activity witness on `loss01_LaunchCrewOrPublicHarm` (`L-01`)
  and advance past Pass 1, or emit a documented schema contract identifying a valid form.
- **Actual**: Stages 1, 2, and 4 exit `0`, while Stage 3 `compile-sysml check` and Stage 5
  `verify-baseline audit` both fail with exit code `13` across all six tested constructs:

```text
[DEAP_E0401] (node 710) D1: @Loss `L-01` lacks PreStpaOps stakeholder or activity reference
"explanation":"STPA grounding morphism D1 (loss to stakeholder concern) failed."
```

  Stage 5 `verify-baseline audit --schema-scope all --message-format json` exits `13` with
  diagnostic `"[DEAP_E0401] DEAP_E0401"`.

## 5. Root Cause & Boundary Analysis
1. **5-Whys Analysis**:
   - **Why 1**: `compile-sysml check` (Pass 1 `D1`) and `verify-baseline audit` reject
     `node 710` (`Avenger5_Safety::loss01_LaunchCrewOrPublicHarm`) with `DEAP_E0401`, reporting
     that `@Loss` `L-01` lacks a `PreStpaOps` stakeholder or activity reference.
   - **Why 2**: Stage 2 `assemble-conops` already resolves `Avenger5_Architecture::launchCrew`
     (`ExternalActor`, `C1` `PASS`), `Avenger5_ConOps::oa04` (`OperationalActivity` `OA-04`, `C3`
     and `C4` `PASS`), and `scLaunchCrewZeroInadvertentEnable` (which declares
     `stakeholder crew subsets launchCrew;`) from `.deap/ir.snapshot.bin`, yet Stage 3
     `compile-sysml` and Stage 5 `verify-baseline audit` fail morphism `D1`
     (`Loss -> StakeholderConcern / PreStpaOps`).
   - **Why 3**: Stage 1 `ingest-sysml` parses and seals six distinct SysML v2 / RAAML v1.0
     grounding attempts (`stakeholder st subsets ...`, unquoted QName/path attributes, string
     QName/OA IDs, `allocate loss01 to oa04`, `view conopsView { expose ... }`, and
     `concern def :> RAAML::LifecycleAssuranceObjective`), whereas `use case ... { objective ... }`
     is rejected upfront by the frontend parser (`DEAP_E0202`). None of the six frontend-valid
     AST/IR encodings satisfies the `D1` predicate inside `compile-sysml` or `verify-baseline`.
   - **Why 4**: `schema/lib/RAAML.sysml` declares `@RAAML::STPA::Loss` with only
     `attribute stakeholderRef : Str;` and defines no `RAAML::StakeholderConcern` metaclass,
     leaving no canonical library contract bridging `PreStpaOps` (`assemble-conops`) to `STPA`
     (`compile-sysml` Pass 1 `D1` and `verify-baseline audit`).
   - **Why 5 (Root Cause)**: A semantic contract discontinuity across the inter-binary IR
     boundary prevents `compile-sysml` (`D1` Pass 1) and `verify-baseline audit` from resolving
     `PreStpaOps` stakeholders (`ExternalActor` / `stakeholder ... subsets`), concerns, or
     activities (`OA-04`) that Stage 1 sealed and Stage 2 verified as complete (`C1..C10`).
2. **Boundary & Invariant Violated**:
   - **Pipeline Boundary**: `Stage 1 (ingest-sysml seal)` + `Stage 2 (assemble-conops C1..C10)`
     -> `Stage 3 (compile-sysml D1 Pass 1)` and `Stage 5 (verify-baseline audit)`.
   - **Assurance Boundary**: `DO-330 TQL-1` (`assemble-conops`, `compile-sysml`) vs
     `DO-330 TQL-5` (`verify-baseline audit`) consistency over `.deap/ir.snapshot.bin`, blocking
     downstream `#![no_std]` contract generation and full `--schema-scope all` `audit`.

## 6. Downstream Impact
- **Blocked Stage 3 Safety Passes & Codegen**: Pass 1 `DEAP_E0401` aborts Passes 2..5
  (`EMV2`, `FMEDA`, `ZBDD-FTA`, `RTA`), preventing synthesis of `.deap/compile.receipt.json`,
  `docs/safety/`, `docs/interfaces/`, `crates/mission-contracts/src/generated/` (`#![no_std]`
  Ring-1/Ring-2 contracts for `esad`, `powerMeter`, `pl40Interlocks`, `rtaMonitor`, `fcc`, `eps`,
  `navSuite`, `actuators`), and `verification/mission-kani/src/generated/` Kani proof harnesses.
- **Blocked Stage 5 TQL-5 Verification**: `verify-baseline audit --schema-scope all` exits `13`,
  preventing `STAGE5_AUDIT: PASS` and `setup-hooks` verification in customer mission repos.
- **Stalled Avionics & Flight-Control Binding**: Downstream Ring-1 simplex guards, ESAD
  RS-485/DSC interlocks, PL-40 launch interlocks, and Cube orange+ CAN 1/CAN 2 control loops
  cannot bind to generated mission contracts or close `V-TRACE` (`L-01`..`L-03` -> `H-01`..`H-05`
  -> `SC-01`..`SC-07` -> `REQ-01`..`REQ-07` -> `TEST-01`..`TEST-07`).
- **Governance Deadlock**: `V-DRIFT` prohibits hand-editing `docs/safety/`,
  `crates/mission-contracts/src/generated/`, or `verification/mission-kani/src/generated/`.

## 7. Proposed Upstream Fix & Verification Test
1. **Minimal Surgical Upstream Fix**:
   - Align `.deap/bin/compile-sysml` (Pass 1 `D1`, `TQL-1`) and `.deap/bin/verify-baseline`
     (`audit`, `TQL-5`) with `.deap/ir.snapshot.bin` so `D1` resolves `@RAAML::STPA::Loss` to
     sealed `PreStpaOps` targets whenever any valid SysML v2 / RAAML v1.0 witness resolves:
     1. `@RAAML::STPA::Loss.stakeholderRef` string matching a sealed `RAAML::ExternalActor`
        identifier/QName, `RAAML::OperationalActivity` `oaId`/QName, or `concern` identifier/QName.
     2. Nested `stakeholder <id> subsets <ExternalActor>;` child edge under the loss node.
     3. Supertype specialization (`:>`) referencing a `concern` whose `stakeholder` subsets a
        sealed `RAAML::ExternalActor`.
     4. Explicit `allocate <Loss> to <OperationalActivity>;` edge targeting a sealed activity.
   - Preserve fail-closed `DEAP_E0401` when no witness resolves to an existing `PreStpaOps`
     element, and either support `use case ... { objective ... }` in `ingest-sysml` (`DEAP_E0202`)
     or specify the exact canonical `D1` pattern in `schema/lib/RAAML.sysml`.
2. **TDD Regression Test & Verification Assertions**:
   - **RED Fixture**: Minimal schema with `launchCrew` (`ExternalActor`), `oa04` (`OA-04`),
     `scLaunchCrewZeroInadvertentEnable`, and `loss01_LaunchCrewOrPublicHarm` (`L-01`); verify
     current binaries emit `DEAP_E0401` (exit `13`) on `node 710`.
   - **GREEN Matrix & Negative Case**: Assert `compile-sysml check` (`TQL-1`) and
     `verify-baseline audit` (`TQL-5`) exit `0` across all 4 witness encodings and emit
     `DEAP_E0401` on a negative fixture with dangling `stakeholderRef = "unknownActor"`.
   - **Parity & Gate Assertion**: Assert `compile_d1(ir) == audit_d1(ir)` across positive and
     negative fixtures, then re-verify full workspace closure (`compile-sysml build`,
     `verify-baseline audit --schema-scope all`, and `verify-baseline perimeter --schema-scope all`
     exiting `0`).
