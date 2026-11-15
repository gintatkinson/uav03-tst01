---
name: feature-driven-implementation
description: "Implements verified downstream features serially via TDD (RED-GREEN-REFACTOR) and two-stage review, consuming crates/mission-contracts/src/generated and verification/mission-kani/src/generated, injecting Tier-A docstrings, and checking Dual-Track MBD parity."
compatibility: "Requires ./.deap/bin/{compile-sysml,reconcile-backlog,verify-baseline}, cargo, and git."
metadata:
  title: "Feature-Driven Autonomous Delivery & Closure (deap03)"
  category: implementation
  risk: low
  source: custom
  version: "3.0"
---

# Feature-Driven Autonomous Delivery & Closure (`deap03`)

Use this skill to implement downstream flight, control, safety monitor, persistence, or HMI features serially, strictly grounded in compiled `#![no_std]` contracts (`crates/mission-contracts/src/generated/`) and `verification/mission-kani/src/generated/`.

## Core Delivery Mandates

1. **Serial Single-Feature Execution**: Implement one feature/task at a time from an approved `implementation_plan.md`. Never parallelize conflicting edits over the same crate or UI module.
2. **On-Demand Downstream Profile Loading**:
   - Load `downstream-profiles/README.md` and `downstream-profiles/DOWNSTREAM_INSTALLATION_AND_CI_GUIDE.md` for build/CI/FFI wiring.
   - Load `downstream-profiles/profile-dart-flutter-hmi/{DART_FLUTTER_CODING_STANDARD,SAFETY_CRITICAL_REALTIME_UI_BLUEPRINT,DART_RUST_FFI_SYNTHESIS_PROFILE}.md` ONLY for Ring-3 HMI work under `app_flutter/`.
   - Load `downstream-profiles/profile-target-app-runtime/{RUNTIME_METADATA_ENGINE_BLUEPRINT,PERSISTENCE_ARCHITECTURE_BLUEPRINT}.md` ONLY for metadata/SQLite persistence work (zero production in-memory mocks).
   - Load `downstream-profiles/profile-non-rust-targets/NON_RUST_MULTI_TOOLCHAIN_PROFILES.md` ONLY for Simulink/Stateflow/Embedded Coder, SCADE, SPARK Ada, MISRA C/C++, AADL, or FMI targets.
3. **Strict Downstream Path Rule for `compile-sysml`**: ALWAYS specify `--out-contracts crates/mission-contracts/src/generated --out-kani verification/mission-kani/src/generated`. Never touch or copy into `crates/deap-*` (`DEAP_E0104`).
4. **3-Layer Definition of Done**:
   - Layer 1: Domain State & `#![no_std]` Data Model binding directly to generated SysML contracts.
   - Layer 2: Logic, RTA Simplex monitor guards, and SQLite/register live persistence (no mocks).
   - Layer 3: Middleware, ROS2/PX4 actuator binding, FFI (`include/deap_ffi.h`), or Ring-3 LUI widget binding.

## Workflow Steps

### Step 1: Slice Context & Plan Micro-Tasks
1. Query the target Feature/Part semantic slice via `./.deap/bin/ingest-sysml slice <QNAME> --workspace . --schema-dir schema`.
2. Verify `crates/mission-contracts/src/generated/` and `verification/mission-kani/src/generated/` reflect the current sealed `.deap/ir.snapshot.bin`.
3. Decompose implementation into 2-5 minute vertical micro-tasks in `implementation_plan.md` with exact target files and driving failing tests, obtaining user approval (`PROCEED`) before modifying workspace code.

### Step 2: RED-GREEN-REFACTOR Subagent Loop & Two-Stage Review
For each micro-task, dispatch a context-isolated implementer subagent enforcing:
1. **RED**: Write failing unit/integration/property tests covering happy path plus every off-nominal/safety guard (`EMG-*`, `@SignalContract` bounds, `@SafetyConstraint` limits) and verify they fail for the right reason.
2. **GREEN**: Write minimal clean code consuming generated contract types from `crates/mission-contracts/src/generated` without duplicating logic or leaving panics/allocations in `#![no_std]` Ring-1/Ring-2 loops.
3. **REFACTOR & CLEAN BUILD**: Run `cargo test --workspace` (or `flutter analyze && flutter test` for HMI), ensuring zero warnings and all assertions pass.
4. **Two-Stage Review**:
   - Stage 1 (Spec Compliance): Verify 1:1 match against `schema/` IR, acceptance criteria, live persistence, and 3-layer DoD.
   - Stage 2 (Code Quality): Verify strict typing, zero `dynamic`/`unsafe` surprises, small single-purpose functions, and complete docstrings.

### Step 3: Tier-A AST Docstring Injection
Inject deterministic `syn`-verified DEAP Tier-A docblocks (`Realises`, requirements, and traceability headers) onto implemented public Rust items without hand-patching fragile tags:

```sh
./.deap/bin/compile-sysml inject-docstrings --workspace . --target-dir <REL_DIR> --ir-in .deap/ir.snapshot.bin --conops-receipt .deap/conops.receipt.json --out-docs docs --out-contracts crates/mission-contracts/src/generated --out-kani verification/mission-kani/src/generated && echo "INJECT_DOCSTRINGS: PASS"
```

### Step 4: Dual-Track MBD Synthesis & Numerical Parity (Control / Guidance / RTA Features)
When implementing control laws, stateflow transitions, battery/fuel estimators, or RTA monitors:
- **Track A (Native MATLAB / Simulink / Stateflow)**: Provide programmatic builder `models/scripts/build_<feature_slug>_model.m`, parameter file `models/matlab/<feature_slug>_params.m`, and data dictionary `models/matlab/<feature_slug>_data.sldd` (`FixedStepDiscrete`, deterministic `dt`).
- **Track B (License-Free Rust Digital Twin)**: Implement matching discrete-time twin in Rust crates under `crates/` or `models/rust_twin/` executing offline in `cargo test` with infinity-norm trajectory equivalence `||x_Simulink - x_DigitalTwin||_inf <= 10^-6`.
- **DO-331 Verification Report**: Record MC/DC coverage, state transition truth tables, fault-injection logs, and parity error bounds in `docs/reports/simulink_results/<FEATURE-ID>_simulation_results.md` (pure 7-bit LF ASCII).

### Step 5: Backlog Sync, Baseline Gates & Commit Non-Closure
Run reconciliation, independent `TQL-5` audit, and downstream perimeter checks before committing:

```sh
./.deap/bin/reconcile-backlog sync --workspace . --snapshot .deap/ir.snapshot.bin --docs-dir docs --schema-dir schema --provider offline && echo "BACKLOG_SYNC: PASS"
./.deap/bin/verify-baseline audit --workspace . && echo "AUDIT: PASS"
./.deap/bin/verify-baseline perimeter --workspace . --perimeter-role downstream-consumer --schema-scope all --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b && echo "PERIMETER_ALL: PASS"
```

Use `(#<id>)` or `(refs #<id>)` in commit messages (never auto-closing `fix #` / `close #` keywords) and verify `git diff origin/<branch>` is empty after pushing.
