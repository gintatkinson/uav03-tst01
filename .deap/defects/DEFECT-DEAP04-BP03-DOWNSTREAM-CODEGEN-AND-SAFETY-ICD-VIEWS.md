# Defect Dossier: DEFECT-DEAP04-BP03 COMPILE_SYSML Self-Host Leak & Safety/ICD Views

## 1. Metadata
- **Defect ID**: `DEFECT-DEAP04-BP03-DOWNSTREAM-CODEGEN-AND-SAFETY-ICD-VIEWS`
- **Severity**: Critical
- **Pillar**: Test & Traceability Integrity
- **Target Component**: `gintatkinson/deap04@1db490b`:
  - `blueprints/COMPILE_SYSML_BLUEPRINT.md` (Sec 3.4 L143-157, Sec 4 L192-225)
  - `blueprints/RAAML_V1_SPECIFICATION.md` (Sec 2.2 L67-81, Sec 5.1 L187-240)
  - Flowdown: `crates/deap-codegen-rust` (reproduced in `deap03` `.deap/bin/compile-sysml`)
- **Labels**: `type::defect`, `status::open`, `safety::hazardous`, `assurance::ring1`,
  `verification::unit-test`

## 2. Normative Anchor
- **SysML QName**: `Avenger5_Architecture::*`, `Avenger5_Safety::*`, `Avenger5_Verification::*`
- **Safety / Requirement Ref**: `L-01..03`, `H-01..05`, `CA-01..06`, `UCA-01..24`, `REQ-01..07`
- **Standard Clause**: DO-178C, ISO 26262, SAE ARP4761, IEEE 1558, DO-330 `TQL-1`

## 3. Minimal Deterministic Reproducer
1. Downstream `uav03-tst01@fcd873a` execution (flags required to avoid `DEAP_E0104`):

```sh
./.deap/bin/compile-sysml build --workspace . --snapshot .deap/ir.snapshot.bin \
  --conops-receipt .deap/conops.receipt.json --out-docs docs \
  --out-contracts crates/mission-contracts/src/generated \
  --out-kani verification/mission-kani/src/generated \
  --receipt .deap/compile.receipt.json
```

2. Inspect generated artifacts in `uav03-tst01@fcd873a` and `deap04@1db490b`:
   - `uav03-tst01/crates/mission-contracts/src/generated/mod.rs` L1-84 (402 lines total)
   - `uav03-tst01/verification/mission-kani/src/generated/mod.rs` L10-23 (110 lines total)
   - `uav03-tst01/docs/designs/DESIGN_CONTRACTS.md` L12-13 (30 lines total)
   - `uav03-tst01/docs/safety/SAFETY_CASE.md` L18-59 (59 lines total)
   - `uav03-tst01/docs/conops/CONOPS.md` L142-184 & `docs/interfaces/ICD_02_*.md` (21 lines)
   - `deap04@1db490b`: `docs/safety/SAFETY_CASE_AND_RAAML.md` (572 B),
     `docs/interfaces/INTERFACE_CONTROL_DOCUMENT.md` (813 B)

## 4. Expected vs Actual
- **Expected**:
  - Downstream `--out-contracts` and `--out-kani` synthesize standalone `#![no_std]` mission
    contracts bound strictly to customer `@CodegenTarget` (`mission_contracts`) and `REQ-01..07`
    with zero `deap_*` upstream compiler crate dependencies.
  - `SAFETY_CASE.md` and `ICD_01`/`ICD_02` render full per-item STPA (`L`, `H`, `CA`, `24 UCA`,
    `24 LS`, `7 SC`, `24 CSC`), `EMV2`, 4-way `FMEDA`, `FTA`, `RMA`, and signal contracts, and `C8`
    fails closed on unannotated `flow`s.
- **Actual**:
  - `crates/mission-contracts/src/generated/mod.rs` L19-24 emits upstream self-host imports
    `use deap_diag::ErrorCode; use deap_isq::CanF64;` and hardcodes `LAO-15` / `REQ-15` /
    `TEST-15` / `[REQ-23]` instead of Avenger 5 `REQ-01..07`.
  - `verification/mission-kani/src/generated/mod.rs` L10-23 hardcodes
    `use deap_contracts::generated::...;` (forbidden in `downstream-consumer` repos).
  - `DESIGN_CONTRACTS.md` L12-13 hardcodes `crates/deap-contracts/...` and
    `verification/kani-proofs/...` paths despite `--out-contracts` / `--out-kani` flags.
  - `SAFETY_CASE.md` prints only integer counts (`Verified Losses (D1): 3`, `Verified UCAs (D4):
    24`) and omits all STPA hazards, UCAs, loss scenarios, safety/controller constraints, `EMV2`,
    and `RMA` detail tables.
  - `C8` passes despite 34 unannotated flows (`d04..d30`) printing `[-, -, -]` in `CONOPS.md` and
    absent from `ICD_02_MASTER_SIGNAL_DICTIONARY.md`.

## 5. Root Cause & Boundary Analysis
1. **5-Whys Root Cause**:
   - **Why 1**: Generated downstream mission Rust contracts reference `deap_contracts` / `REQ-15`,
     `SAFETY_CASE.md` omits STPA tables, and `C8` passes with 34 `[-, -, -]` dummy flows.
   - **Why 2**: `crates/deap-codegen-rust` hardcodes self-host compiler templates and emits only
     summary metrics for `SAFETY_CASE.md` and `DESIGN_CONTRACTS.md`.
   - **Why 3**: `COMPILE_SYSML_BLUEPRINT.md` Sec 3.4 specifies Pass 4 target synthesis exclusively
     around meta-circular self-hosting (`Stage 0 -> Stage 3`, FLS IDs, fuzzers, dylint) and
     allocates one sentence (L154-156) to all Layer 4 Markdown projections.
   - **Why 4**: `COMPILE_SYSML_BLUEPRINT.md` and `RAAML_V1_SPECIFICATION.md` never distinguish
     `UPSTREAM_SPEC_CORE_COMPILER` self-host emission from `DOWNSTREAM_CUSTOMER_PROJECT` standalone
     contract generation, nor require per-row STPA/EMV2/RMA tables or `100%` `flow` signal typing.
   - **Why 5 (Root Cause)**: Self-hosting assumptions baked into `COMPILE_SYSML_BLUEPRINT.md`
     Sec 3.4 and omitted Layer 4 safety/ICD schema contracts.
2. **Boundary & Invariant Violated**:
   - Poly-repo zero-upstream-source boundary (`N_up_src == 0`), `V-TRACE` Layer 4 completeness,
     and `C8` signal contract totality.

## 6. Downstream Impact
- Generated `crates/mission-contracts/src/generated/mod.rs` and `verification/mission-kani/`
  cannot compile standalone in downstream repos without copying forbidden `deap_*` crates.
- Generated `SAFETY_CASE.md` cannot be audited by safety assessors without STPA UCA/SC tables.

## 7. Proposed Upstream Fix & Verification Test
1. **Minimal Surgical Upstream Fix**:
   - Update `COMPILE_SYSML_BLUEPRINT.md` Sec 3.4 & Sec 4 to specify distinct `self-host` vs
     `downstream-standalone` codegen profiles emitting zero `deap_*` identifiers or
     `LAO-15`/`REQ-15` constants in downstream mode, and honoring
     `--out-contracts`/`--out-kani` paths in `DESIGN_CONTRACTS.md`.
   - Mandate full STPA (`L`, `H`, `CA`, `UCA`, `LS`, `SC`, `CSC`), `EMV2`, `FMEDA`, `FTA`, and
     `RMA` tables in `SAFETY_CASE.md`, plus complete pinout/protocol/signal tables in `ICD_01/02`.
   - Enforce fail-closed `DEAP_E0327` (`C8`) when any `flow` lacks
     `@RAAML::ThreeRing::SignalContract`.
2. **TDD Regression Test & Verification Assertions**:
   - Run `cargo check --no-default-features` on a standalone downstream crate consuming
     `compile-sysml` output with zero `deap_*` path dependencies in `Cargo.toml`.
   - Assert `SAFETY_CASE.md` contains every `L-*`, `H-*`, `UCA-*`, `SC-*`, `CSC-*` ID from IR,
     and assert `check` rejects any `flow` missing `@SignalContract`.
