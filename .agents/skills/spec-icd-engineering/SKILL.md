---
name: spec-icd-engineering
description: "Models physical/logical ports, bus protocols, signal contracts, and cross-ring safety boundaries in SysML v2 (schema/<domain>/) and compiles Level 1C ICD projections via ./.deap/bin/compile-sysml."
compatibility: "Requires ./.deap/bin/ingest-sysml and ./.deap/bin/compile-sysml."
metadata:
  title: "Logical Interface Specification & ICD Engineering (Worker ICD)"
  category: architecture
  risk: medium
  source: custom
  version: "3.0"
---

# Logical Interface Specification & ICD Engineering (Worker ICD)

Use this skill to model subsystem boundaries, directional ports, payload `item def` types, `@SignalContract`, and `@CrossRingBoundary` contracts in `schema/<domain>/*.sysml` and synthesize Level 1C interface artifacts (`docs/interfaces/`) plus `#![no_std]` Rust signal contracts via `./.deap/bin/compile-sysml`.

## Downstream `compile-sysml` Mandatory Flag Invariant

EVERY `./.deap/bin/compile-sysml` invocation (`check` or `build`) MUST explicitly pass `--out-contracts crates/mission-contracts/src/generated --out-kani verification/mission-kani/src/generated` so downstream workspaces never create forbidden `crates/deap-contracts/` directories (`DEAP_E0104`).

## SysML v2 Interface & Signal Contract Modeling

1. **Ports & Topology (`port def`, `interface def`, `connection`, `flow`)**:
   - Declare typed `port def` and directional `port` instances on `SystemOfInterest`, `Subsystem`, `ControlledProcess`, and `ExternalActor` boundaries.
   - Bind communicating endpoints via `connect` / `flow` declarations so zero dangling interface signals exist.
   - Cite exact OEM datasheet/ICD page anchors (`<icd_file>#p<page>`) in `doc /* ... */` blocks and in `docs/reference/extracted/*.md`.

2. **Signal Contracts (`@RAAML::ThreeRing::SignalContract`)**:
   Every safety-relevant or mission-critical signal/attribute MUST carry:
   - `sigId`: Unique identifier (e.g. `"SIG-FCC-ESAD-001"`).
   - `unitSym`: Coherent ISQ ASCII symbol (e.g. `"V"`, `"A"`, `"m/s"`, `"rad"`, `"s"`, `"Hz"`, `"Pa"`, `"K"`, `"1"`).
   - `minVal`, `maxVal`: Valid physical envelope bounds grounded in OEM ICD/datasheet specifications.
   - `safeVal`: Deterministic fail-safe default asserted on cold init, timeout, CRC error, or `SafeHold`.
   - `rateHz`: Nominal periodic frequency in `Hz` (or equivalent reciprocal max period for aperiodic discrete interlocks, noting aperiodic bounds in `doc /* ... */`).
   - `maxLatencyS`: Maximum transport/handling latency in coherent seconds (`s`).

3. **Cross-Ring Boundary Guarding (`@RAAML::ThreeRing::CrossRingBoundary`)**:
   - Annotate interfaces crossing assurance rings (e.g. Ring-3 GCS or mission autonomy `->` Ring-2 flight controller, or Ring-2 `->` Ring-1 ESAD/launcher safety interlocks) with `@RAAML::ThreeRing::CrossRingBoundary { srcRing = RingLevel::...; dstRing = RingLevel::...; crc32c = true; missMax = ...; watchdogS = ... [s]; }`.
   - Pair high-criticality links with `RAAML::RTA::Crc32cUndetectedRate` parameters and `STPA` `@UnsafeControlAction` / `@SafetyConstraint` links.

4. **Logical vs Physical Layer Discipline**:
   - Keep `schema/<domain>/` pure 7-bit LF ASCII (`0x20..=0x7E` + `0x0A`, zero tabs).
   - Model physical electrical/connector/pinout facts (such as OEM MIL-DTL-38999 or harness pin assignments) in `docs/reference/extracted/<icd_slug>.md` with `<file>#p<page>` provenance, while binding logical ports, voltage/current/timing envelopes, CRC/watchdog bounds, and fail-safe interlock semantics cleanly in SysML v2 `port def`, `item def`, `@SignalContract`, and `@CrossRingBoundary`.

## Deterministic Compilation & Inspection

Never hand-edit `docs/interfaces/*.md`. Seal `schema/`, run ConOps projection, compile safety & ICD projections, and verify zero drift:

```sh
./.deap/bin/ingest-sysml seal --workspace . --schema-dir schema --out-snapshot .deap/ir.snapshot.bin && echo "STAGE1_SEAL: PASS"
./.deap/bin/assemble-conops project --workspace . --snapshot .deap/ir.snapshot.bin --out-dir docs/conops --receipt .deap/conops.receipt.json && echo "STAGE2_CONOPS: PASS"
./.deap/bin/compile-sysml check --workspace . --snapshot .deap/ir.snapshot.bin --conops-receipt .deap/conops.receipt.json --out-docs docs --out-contracts crates/mission-contracts/src/generated --out-kani verification/mission-kani/src/generated && echo "COMPILE_CHECK: PASS"
./.deap/bin/compile-sysml build --workspace . --snapshot .deap/ir.snapshot.bin --conops-receipt .deap/conops.receipt.json --out-docs docs --out-contracts crates/mission-contracts/src/generated --out-kani verification/mission-kani/src/generated --receipt .deap/compile.receipt.json && echo "COMPILE_BUILD: PASS"
```
