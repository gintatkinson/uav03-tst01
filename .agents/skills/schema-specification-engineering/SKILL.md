---
name: schema-specification-engineering
description: "Authors canonical deap03 SysML v2.0 + KerML 1.0 + ISQ + OMG RAAML v1.0 models under schema/<domain>/ satisfying C1..C10, D1..D6, V-QUANT, and V-TRACE for deterministic projection."
compatibility: "Works with ./.deap/bin/ingest-sysml, compile-sysml, and verify-baseline."
metadata:
  title: "Schema Specification Engineering (SysML v2 + ISQ + RAAML SSOT)"
  category: modeling
  risk: medium
  source: custom
  version: "3.0"
---

# Schema Specification Engineering (SysML v2.0 + ISQ + RAAML v1.0)

Use this skill to author, partition, and verify canonical `SysML v2.0 + KerML 1.0` structural, operational, safety, and assurance models under `schema/<domain>/*.sysml`. In `deap03`, `schema/` is the 100% Single Source of Truth (SSOT); Epics, Features, ICDs, Safety Analyses, `#![no_std]` contracts, and Kani harnesses compile deterministically from `.deap/ir.snapshot.bin`.

## Foundation Library Boundaries (`schema/lib/`)

1. **Read-Only Foundation Libraries**: NEVER edit `schema/lib/ISQ.sysml` or `schema/lib/RAAML.sysml`. Customer domain packages under `schema/<domain>/` import `private import ISQ::*;` and `private import RAAML::*;`.
2. **Derived ISQ Quantity Types**: `schema/lib/ISQ.sysml` provides base primitives (`Real64`, `Int64`, `Bool`, `Str`) and core SI types (`Dimensionless_Ratio`, `Duration_s`, `Frequency_Hz`, `Rate_PerS`, `Temperature_K`, `PhaseAngle_rad`, `AngularRate_rad_per_s`) plus `InfoUnits` (`ByteCount_B`, `BitCount_bit`, `ByteRate_B_per_s`, `TokenCount`, `LineCount`). Declare additional domain coherent SI types in your domain package extending `ISQ::Real64` with `@ISQ::SiUnit { symbol = "..."; dimL = ...; dimM = ...; dimT = ...; ... }` using strictly affine-free units (`alpha = 1.0`, `beta = 0.0`). Convert OEM `degC` to `K`, `km/h` or `knots` to `m/s`, `bar`/`psi` to `Pa`, `Wh` to `J`, and document raw OEM values in `doc /* ... */`.
3. **RAAML Name Disambiguation (`OperationalActivity`)**: `RAAML` defines both `action def OperationalActivity` (root `RAAML::OperationalActivity`) and `metadata def OperationalActivity` (`RAAML::ThreeRing::OperationalActivity`). Because both are imported into `RAAML::*`, always qualify metadata annotations explicitly as `@RAAML::ThreeRing::OperationalActivity { ... }` and specialize actions from `RAAML::OperationalActivity` (or `action def` directly).

## Canonical Metamodel Elements & Metadata Contracts

Every domain model package MUST cover structural, operational, safety, reliability, real-time, and verification layers:

1. **System Partition & 3-Ring Containment (`ThreeRing`)**:
   - Declare top-level system (`:> RAAML::SystemOfInterest`), subsystems (`:> RAAML::Subsystem`), controlled physical plants (`:> RAAML::ControlledProcess`), and external operators/systems (`:> RAAML::ExternalActor`).
   - Annotate parts and controllers with `@RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring1 | RingLevel::Ring2 | RingLevel::Ring3; }`, `@RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1..Tier5; }`, `@RAAML::ThreeRing::AuthorityRank { rho = ...; roleName = "..."; }`, and `@RAAML::ThreeRing::CodegenTarget` (setting `noStd = true` for Ring-1/Ring-2 `#![no_std]` mission contracts).
   - Annotate requirements and documentation tiers via `@RAAML::ThreeRing::DocTier` and `@RAAML::ThreeRing::TraceReq`.

2. **STPA Control-Theoretic Hazard Analysis (`RAAML::STPA`)**:
   - `@Loss { lossId = "L-01"; severity = 5; stakeholderRef = "..."; }`
   - `@Hazard { hazardId = "H-01"; lossRefs = "L-01"; envNegation = "..."; }`
   - `@ControlAction { caId = "CA-01"; srcRank = ...; dstRank = ...; opsRef = "OA-01"; }`
   - `@UnsafeControlAction { ucaId = "UCA-01"; caId = "CA-01"; guideword = StpaGuideword::...; stateContext = "..."; hazardRef = "H-01"; }`
   - `@LossScenario { lsId = "LS-01"; ucaId = "UCA-01"; scenarioClass = ScenarioClass::...; opsRef = "OA-01"; }`
   - `@SafetyConstraint { scId = "SC-01"; hazardRef = "H-01"; fttiS = ... [s]; opsRef = "OA-01"; }`
   - `@ControllerConstraint { cscId = "CSC-01"; ucaId = "UCA-01"; negatedGuard = "..."; opsRef = "OA-01"; }`

3. **EMV2, 4-Way FMEDA & FTA (`RAAML::EMV2`, `RAAML::FMEDA`, `RAAML::FTA`)**:
   - Model error sources (`@Emv2ErrorSource`), port error propagations (`@Emv2Propagation`), and common-cause hyperedges (`@Emv2Hyperedge`).
   - Annotate hardware/software failure modes with `@FmedaMode` (`alphaShare`, `betaHaz`, `dcPrimary`, `dcLatent`, `hft`, `lambdaCompPerS`, `ctmcSimplex`) satisfying IEC 61508 4-way rate conservation (`RAAML::FMEDA::FmedaRowConserv`) and gate reduction (`@FaultTreeGate`).

4. **RTA Simplex, Risk Lattice & RMA Timing (`RAAML::RTA`)**:
   - Annotate runtime assurance monitors with `@RtaSimplexMonitor` (`gammaDecayPerS`, `tSwitchS`, `tRollbackS`, `hFloor`).
   - Annotate periodic real-time tasks with `@RmaTask` (`priority`, `wcetS`, `blockingS`, `periodS`, `deadlineS`) honoring RMA schedulability bounds (`RmaUtilization`, `RmaWcrtBound`).

## Completeness (`C1..C10`, `D1..D6`), `V-QUANT`, & `V-TRACE` Gates

- **`C1..C10` & `D1..D6` Closure**: Ensure every package, subsystem, port, connection, operational mode, METL task, emergency rule, hazard, UCA, loss scenario, safety constraint, requirement, and verification test case connects without dangling IDs or unreferenced hazards.
- **`V-QUANT` Quantitative Physical Margin Rules**: Every numeric threshold, rate, latency, energy reserve, response time, failure rate, and mass/force limit MUST derive from `docs/reference/extracted/*.md` (or explicitly documented catalog safety baselines) and satisfy physical inequalities (e.g., positive timing/energy margins, conservative `dc` and `beta` bounds, closed-loop phase margin `PhaseMarginEff > 0`).
- **`V-TRACE` Triad Closure**: Every safety hazard (`H-*`) and safety constraint (`SC-*`) MUST trace through a requirement (`requirement def` with `@TraceReq`) down to a formal `verification def` (`:> RAAML::VerificationTestCase`) annotated with `@VerificationTest { testId = "..."; reqId = "..."; method = "..."; }`.

## Authoring & Validation Loop

Keep all `.sysml` files in pure 7-bit LF ASCII (`0x20..=0x7E` + `0x0A`). Validate syntax and safety semantics incrementally using structured JSON diagnostics and semantic slicing before sealing:

```sh
./.deap/bin/ingest-sysml check --workspace . --schema-dir schema --message-format json
./.deap/bin/ingest-sysml seal --workspace . --schema-dir schema --out-snapshot .deap/ir.snapshot.bin && echo "SCHEMA_SEAL: PASS"
./.deap/bin/assemble-conops check --workspace . --snapshot .deap/ir.snapshot.bin && echo "CONOPS_CHECK: PASS"
./.deap/bin/compile-sysml check --workspace . --snapshot .deap/ir.snapshot.bin --conops-receipt .deap/conops.receipt.json --out-docs docs --out-contracts crates/mission-contracts/src/generated --out-kani verification/mission-kani/src/generated && echo "COMPILE_CHECK: PASS"
```
