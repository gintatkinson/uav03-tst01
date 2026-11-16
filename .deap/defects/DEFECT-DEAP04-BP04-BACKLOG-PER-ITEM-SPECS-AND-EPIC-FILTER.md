# Defect Dossier: DEFECT-DEAP04-BP04 RECONCILE_BACKLOG Per-Item Specs & Epic Filtering

## 1. Metadata
- **Defect ID**: `DEFECT-DEAP04-BP04-BACKLOG-PER-ITEM-SPECS-AND-EPIC-FILTER`
- **Severity**: Critical
- **Pillar**: Test & Traceability Integrity
- **Target Component**: `gintatkinson/deap04@1db490b`:
  - `blueprints/RECONCILE_BACKLOG_BLUEPRINT.md` (Sec 3 L85-120, Sec 4 L121-176, Sec 5 L177-215)
  - Flowdown: `crates/deap-backlog-sync` (reproduced in `deap03` `.deap/bin/reconcile-backlog`)
- **Labels**: `type::defect`, `status::open`, `safety::major`, `assurance::ring2`,
  `verification::unit-test`

## 2. Normative Anchor
- **SysML QName**: `Avenger5_Architecture::*`, `Avenger5_ConOps::scn01..03`,
  `Avenger5_Verification::req01..07`
- **Safety / Requirement Ref**: `EPIC-01..124`, `FEAT-01..44`, `US-01..08`, `UC-01..03`,
  `WBS_MASTER`
- **Standard Clause**: MIL-STD-881E, ISO/IEC/IEEE 29148, DO-330 `TQL-1`

## 3. Minimal Deterministic Reproducer
1. Reproducer command in `gintatkinson/uav03-tst01@fcd873a`:

```sh
./.deap/bin/reconcile-backlog project --workspace . --snapshot .deap/ir.snapshot.bin \
  --docs-dir docs --schema-dir schema --provider offline
wc -l docs/epics/EPICS.md docs/features/FEATURES.md docs/user-stories/USER_STORIES.md \
  docs/use-cases/USE_CASES.md docs/wbs/WBS_MASTER.md
```

2. Evidence in `uav03-tst01@fcd873a` and `gintatkinson/deap04@1db490b`:
   - `uav03-tst01/docs/epics/EPICS.md` (130 lines, `EPIC-01..EPIC-124`)
   - `uav03-tst01/docs/features/FEATURES.md` (50 lines, `FEAT-01..FEAT-44`)
   - `uav03-tst01/docs/user-stories/USER_STORIES.md` (62 lines, `US-01..US-08`)
   - `uav03-tst01/docs/use-cases/USE_CASES.md` (9 lines, `UC-01..UC-03`)
   - `uav03-tst01/docs/wbs/WBS_MASTER.md` (L3 `Total Critical Path Makespan C_max: 1.000000 s`)
   - `deap04@1db490b`: `docs/epics/EPICS_AND_ROADMAP.md` (1,771 B),
     `docs/features/FEATURE_BACKLOG.md` (2,058 B), `docs/use-cases/USE_CASES.md` (3,076 B)

## 4. Expected vs Actual
- **Expected**:
  - Only `RAAML::Subsystem` / `SystemOfInterest` parts become Epics, inheriting declared
    `@AssuranceRing` (`Ring-1` on `esad`, `powerMeter`, `rtaMonitor`) and `@AssuranceTier`.
  - Features, BDD User Stories (with sequence/state lifelines and component failure modes),
    Use Cases (with nominal/degraded/emergency `step01..step15` flows), and `WBS` durations
    project full `DEAP01`/`DEAP02` specification files allocated cleanly across subsystems.
- **Actual**:
  - `EPICS.md`, `FEATURES.md`, and `USER_STORIES.md` hardcode `Ring-2 | TQL-2` on every row,
    ignoring `@AssuranceRing { ring = RingLevel::Ring1; }` on `esad`, `powerMeter`, `rtaMonitor`.
  - `EPICS.md` sweeps `ExternalActor`s (`EPIC-16..21`) and 103 safety `part` usages (`uca*`, `ls*`,
    `csc*`, `fmeda*`, `ftaGate*`) into empty `"Subsystem Realization"` Epics (`EPIC-22..124`).
  - `FEATURES.md` leaves 43 of 44 Features empty (`FEAT-02..44`), while all 8 stories dump into
    `FEAT-01` (`Deg_GnssDeniedOrLinkLoss`) under `EPIC-01` (`airframe`) with hardcoded
    `1.000000 s` WBS durations.
  - `USE_CASES.md` (9 lines) replaces `scn01..03` steps with 1-line boilerplate (`"Execute
    <QName> within nominal ISQ envelope | Shed non-essential load..."`).

## 5. Root Cause & Boundary Analysis
1. **5-Whys Root Cause**:
   - **Why 1**: `EPICS.md` contains 103 bogus safety Epics, `Ring-1` tags are overwritten with
     `Ring-2 | TQL-2`, 43 Features are empty, and `USE_CASES.md` is 9 lines of boilerplate.
   - **Why 2**: `crates/deap-backlog-sync` filters Epics by raw `Part` node family, hardcodes
     default ring/tier strings and `1.0 s` durations, and emits single summary tables only.
   - **Why 3**: `RECONCILE_BACKLOG_BLUEPRINT.md` Sec 3 & Sec 4 specify abstract zero-orphan and
     Kahn WBS equations without classifier filters for Epics/Features or concrete per-item Layer 4
     specification schemas.
   - **Why 4**: Neither Sec 3 nor Sec 5 ports `DEAP01`'s per-item `epic-*.md`, `feat-*.md`,
     `us-*.md` (BDD + AST lifelines + failure modes), or `uc-*.md` (step-by-step scenario flows)
     rendering contracts, nor reads `@AssuranceRing` / `@AssuranceTier` / `@RmaTask` metadata.
   - **Why 5 (Root Cause)**: Missing classifier-role partitioning and per-item Layer 4 document
     contracts in `RECONCILE_BACKLOG_BLUEPRINT.md`.
2. **Boundary & Invariant Violated**:
   - `RECONCILE_BACKLOG_BLUEPRINT.md` Sec 3.2 (monotonic Ring/Tier inheritance; downgraded
     `Ring-1` -> `Ring-2`) and `V-TRACE` per-item specification completeness.

## 6. Downstream Impact
- Mission backlog projects unusable summary stubs with inverted assurance levels (`Ring-1` ESAD
  and RTA monitors mislabeled `Ring-2 | TQL-2`), stalling downstream worker implementation.

## 7. Proposed Upstream Fix & Verification Test
1. **Minimal Surgical Upstream Fix**:
   - Amend `RECONCILE_BACKLOG_BLUEPRINT.md` Sec 3 & Sec 4 to:
     (a) Restrict Epic generation strictly to `SystemOfInterest` / `Subsystem` classifiers
     (excluding `ExternalActor`, `ControlledProcess`, and `@RAAML::STPA`/`FMEDA`/`FTA` nodes).
     (b) Mandate reading `@AssuranceRing`, `@AssuranceTier`, and timing annotations from IR (fail
     closed on unannotated subsystem targets instead of defaulting `Ring-2 | TQL-2 | 1.0 s`).
     (c) Route requirements and user stories by `subject` / `allocate` target subsystem, and restore
     `DEAP01`-grade per-item `docs/{epics,features,user-stories,use-cases}/` Markdown outputs.
2. **TDD Regression Test & Verification Assertions**:
   - Assert `esad` Epic/Feature/Story inherit `Ring-1 | TQL-1` (never `Ring-2 | TQL-2`), assert zero
     `uca*`/`fmeda*` Epics exist, and assert `USE_CASES.md` (or `uc-*.md`) renders all scenario
     actions (`step01..step15`) and actors rather than fixed boilerplate strings.
