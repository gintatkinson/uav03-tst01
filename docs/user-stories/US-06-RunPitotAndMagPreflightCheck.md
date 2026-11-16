| Attribute | Specification Detail |
| :--- | :--- |
| **Issue ID** | #10 |
| **Title** | User Story 06: Run Pitot And Mag Preflight Check |
| **Type** | user-story |
| **Parent Epic** | [EPIC-03-AvionicsGuidanceAndControl](../epics/EPIC-03-AvionicsGuidanceAndControl.md) |
| **SysML Interaction** | `INT_05_GnssDeniedDeadReckoningAndPaceLink` |
| **SysML Test Case** | `Test_RunPitotAndMagPreflightCheck` |
| **Generation Mode** | subagent |
| **Specification Source** | [schema/model.sysml](../../schema/model.sysml) |

# User Story 06: Run Pitot And Mag Preflight Check

## User Story

As a `Pilot`, I want to invoke `RunPitotAndMagPreflightCheck(in calmAirIndicatedMs: Real, in blownAirIndicatedMs: Real, in onlineMagCount: Integer, out airDataValid: Boolean)` on `CompanionComputeRpiCm5`, so that Validate calm-air pitot reading <= 3.0 m/s, indirect airflow check >= 10.0 m/s, and both mRo RM3100 magnetometers online on CAN 2.

## Architectural Realization (3-Layer Definition of Done)

### Layer 1: Domain State & Data Model
- Domain state attributes on `CompanionComputeRpiCm5`: `computeModel: String`, `rs485BaudBps: Integer`, `esadPollFrequencyHz: Real`, `esadPollPeriodSec: Real`, `esadReplyMaxLatencyMs: Real`, `esadIncompleteTimeoutMs: Real`, `crcPolynomial: String`, `dscIn1PulseFreqHz: Real`, `dscIn1PulseCount: Integer`.
- Action `RunPitotAndMagPreflightCheck` typed data contract: input arguments (`calmAirIndicatedMs: Real`, `blownAirIndicatedMs: Real`, `onlineMagCount: Integer`), output values (`airDataValid: Boolean`).
- Declared lifecycle state model: `RtaEnvelopeMonitorState`, `NominalPrimaryEnvelope`, `AirspeedDiveCapClamped`, `EsadBusWatchdogFaultFallback`, `CriticalBatteryOrGeofenceRtb`.

### Layer 2: Logic & State Management
- Behavioral execution contract: invokes `RunPitotAndMagPreflightCheck(in calmAirIndicatedMs: Real, in blownAirIndicatedMs: Real, in onlineMagCount: Integer, out airDataValid: Boolean)` on `CompanionComputeRpiCm5` with atomic precondition verification.
- State transition management: `NominalPrimaryEnvelope -> AirspeedDiveCapClamped` (trigger `airspeedAbove55MsInDive`).
- Formal constraints and requirements enforced: `PitotPreflightCalibrationConstraint (in calmAirMs : Real && in blownAirMs : Real && attribute invariantExpr : String = "calmAirMs <= 3.0 and blownAirMs >= 10.0")`, `CanTopologyIsolationConstraint (in finCount : Integer && in wingCount : Integer && in magCount : Integer && in stubLenCm : Real && attribute invariantExpr : String = "finCount == 4 and wingCount == 4 and magCount == 2 and stubLenCm == 120.0")`, `SimplexRtaSoftwareHostingConstraint (in standaloneRtaBoxCount : Integer && in rtaHostedOnCubeOrangePlus : Boolean && attribute invariantExpr : String = "standaloneRtaBoxCount == 0 and rtaHostedOnCubeOrangePlus == true")`, `REQ_L_03`, `REQ_H_03`, `REQ_UCA_03`, `REQ_UCA_04`, `REQ_SC_05`, `REQ_SC_06`, `REQ_SC_07`, `REQ_SC_08`, `REQ_SAF_08`, `REQ_SAF_09`.

### Layer 3: Presentation & Actuator Interface Binding
- Component port bindings on `CompanionComputeRpiCm5`: `serialFc: UartSerialPort (inout)`, `ethSwitch: EthernetFabricPort (inout)`, `esadOcControl: EsadOcControlBundlePort (inout)`.
- Interaction binding (`INT_05_GnssDeniedDeadReckoningAndPaceLink`): routes `RunPitotAndMagPreflightCheck` invocation from `Pilot` to `CompanionComputeRpiCm5` and returns `Boolean`.
- Diagnostic fault surface: reports deterministic rejection diagnostics to `Pilot` across the declared interface boundary when guard or invariant checks fail.

## UML Sequence Diagram

```mermaid
sequenceDiagram
    autonumber
    actor Pilot
    participant FlightControllerCubeOrangePlus
    participant CompanionComputeRpiCm5
    Pilot->>FlightControllerCubeOrangePlus: RunPitotAndMagPreflightCheck()
    FlightControllerCubeOrangePlus->>CompanionComputeRpiCm5: RunPitotAndMagPreflightCheck()
    CompanionComputeRpiCm5-->>FlightControllerCubeOrangePlus: Boolean
    FlightControllerCubeOrangePlus-->>Pilot: StatusReport
```

## Acceptance Criteria (BDD)
- [ ] AC-US-06-01: Given `CompanionComputeRpiCm5` is in declared state `NominalPrimaryEnvelope` with typed input arguments (`calmAirIndicatedMs: Real`, `blownAirIndicatedMs: Real`, `onlineMagCount: Integer`), When `Pilot` invokes `RunPitotAndMagPreflightCheck` on `CompanionComputeRpiCm5`, Then `CompanionComputeRpiCm5` validates and binds the request against `CompanionComputeRpiCm5` domain state (`computeModel: String`, `rs485BaudBps: Integer`, `esadPollFrequencyHz: Real`, `esadPollPeriodSec: Real`, `esadReplyMaxLatencyMs: Real`, `esadIncompleteTimeoutMs: Real`, `crcPolynomial: String`, `dscIn1PulseFreqHz: Real`, `dscIn1PulseCount: Integer`) and transitions to `AirspeedDiveCapClamped`.
- [ ] AC-US-06-02: Given `CompanionComputeRpiCm5` active state management during `RunPitotAndMagPreflightCheck`, When `CompanionComputeRpiCm5` evaluates formal constraint `PitotPreflightCalibrationConstraint (in calmAirMs : Real && in blownAirMs : Real && attribute invariantExpr : String = "calmAirMs <= 3.0 and blownAirMs >= 10.0")`, Then `CompanionComputeRpiCm5` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-06-03: Given `CompanionComputeRpiCm5` active state management during `RunPitotAndMagPreflightCheck`, When `CompanionComputeRpiCm5` evaluates formal constraint `CanTopologyIsolationConstraint (in finCount : Integer && in wingCount : Integer && in magCount : Integer && in stubLenCm : Real && attribute invariantExpr : String = "finCount == 4 and wingCount == 4 and magCount == 2 and stubLenCm == 120.0")`, Then `CompanionComputeRpiCm5` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-06-04: Given `CompanionComputeRpiCm5` active state management during `RunPitotAndMagPreflightCheck`, When `CompanionComputeRpiCm5` evaluates formal constraint `SimplexRtaSoftwareHostingConstraint (in standaloneRtaBoxCount : Integer && in rtaHostedOnCubeOrangePlus : Boolean && attribute invariantExpr : String = "standaloneRtaBoxCount == 0 and rtaHostedOnCubeOrangePlus == true")`, Then `CompanionComputeRpiCm5` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-06-05: Given `CompanionComputeRpiCm5` requirement allocation for `RunPitotAndMagPreflightCheck`, When `CompanionComputeRpiCm5` verifies formal requirement `REQ_L_03`, Then `CompanionComputeRpiCm5` confirms normative requirement satisfaction across execution.
- [ ] AC-US-06-06: Given `CompanionComputeRpiCm5` requirement allocation for `RunPitotAndMagPreflightCheck`, When `CompanionComputeRpiCm5` verifies formal requirement `REQ_H_03`, Then `CompanionComputeRpiCm5` confirms normative requirement satisfaction across execution.
- [ ] AC-US-06-07: Given `CompanionComputeRpiCm5` ingress port binding (`serialFc: UartSerialPort`, `ethSwitch: EthernetFabricPort`, `esadOcControl: EsadOcControlBundlePort`), When `CompanionComputeRpiCm5` completes `RunPitotAndMagPreflightCheck`, Then `CompanionComputeRpiCm5` materializes verified output (`airDataValid: Boolean`) and delivers `Boolean` across egress port (`serialFc: UartSerialPort`, `ethSwitch: EthernetFabricPort`, `esadOcControl: EsadOcControlBundlePort`) to `Pilot`.
- [ ] AC-US-06-08: Given violated formal constraint `PitotPreflightCalibrationConstraint (in calmAirMs : Real && in blownAirMs : Real && attribute invariantExpr : String = "calmAirMs <= 3.0 and blownAirMs >= 10.0")`, When `Pilot` invokes `RunPitotAndMagPreflightCheck` on `CompanionComputeRpiCm5`, Then `CompanionComputeRpiCm5` rejects the request without partial state mutation, preserves prior verified state, and emits a deterministic fault diagnostic across the interface binding.

## Required Features
- [ ] #37 - [Feature 06: [Avionics Guidance And Control] FlightControllerCubeOrangePlus](../features/FEAT-06-FlightControllerCubeOrangePlus.md)
- [ ] #38 - [Feature 07: [Avionics Guidance And Control] CompanionComputeRpiCm5](../features/FEAT-07-CompanionComputeRpiCm5.md)

## Source References
Operational concept definitions and system sequence interaction models:
- System Architecture Model: `schema/model.sysml`
- Normative Systems Engineering Standard: ISO/IEC/IEEE 29148:2018 §6.4.2 Concept of Operations

Authoritative user story flows and interaction lifelines derive from `schema/model.sysml` pursuant to ISO/IEC/IEEE 29148.
