| Attribute | Specification Detail |
| :--- | :--- |
| **Issue ID** | #17 |
| **Title** | User Story 13: Acquire And Track Terminal Target |
| **Type** | user-story |
| **Parent Epic** | [EPIC-04-MissionPayloadsCommsAndOrdnanceSafety](../epics/EPIC-04-MissionPayloadsCommsAndOrdnanceSafety.md) |
| **SysML Interaction** | `INT_06_EoIrSeekerTrackAndTerminalDive` |
| **SysML Test Case** | `Test_AcquireAndTrackTerminalTarget` |
| **Generation Mode** | subagent |
| **Specification Source** | [schema/model.sysml](../../schema/model.sysml) |

# User Story 13: Acquire And Track Terminal Target

## User Story

As a `PayloadOperator`, I want to invoke `AcquireAndTrackTerminalTarget(in trackHoldSec: Real, in airspeedMs: Real, in targetElevDeg: Real, out targetLocked: Boolean, out abortEngaging: Boolean)` on `EoIrSeekerAndTrackerUnit`, so that Stabilize Nighthawk2UZ gimbal (1280x720 Day/Thermal, X40 zoom) and hold Trip6 auto-tracker lock for 2.0-5.0 s; command Abort Engaging if airspeed > 55.0 m/s.

## Architectural Realization (3-Layer Definition of Done)

### Layer 1: Domain State & Data Model
- Domain state attributes on `EoIrSeekerAndTrackerUnit`: `gimbalModel: String`, `trackerComputeModel: String`, `videoWidthPx: Integer`, `videoHeightPx: Integer`, `zoomFactor: Real`, `pitchMinDeg: Real`, `pitchMaxDeg: Real`, `yawRollMinDeg: Real`, `yawRollMaxDeg: Real`, `engagementSpeedCapMs: Real`, `trackHoldMinSec: Real`, `trackHoldMaxSec: Real`, `maxTargetElevAtStartDeg: Real`, `shallowApproachAngleDeg: Real`, `terminalCepMaxM: Real`, `terminalCepMaxCm: Real`.
- Action `AcquireAndTrackTerminalTarget` typed data contract: input arguments (`trackHoldSec: Real`, `airspeedMs: Real`, `targetElevDeg: Real`), output values (`targetLocked: Boolean`, `abortEngaging: Boolean`).
- Declared lifecycle state model: `EsadSafeArmState`, `SafePowerOff`, `BootAndPbit`, `SafeRbfInstalled`, `FaultLockout`, `SafeRbfRemoved`, `ArmStage1TimerWait`, `ArmStage2Armed`, `HvChargedReady`, `DetonatedOrAborted`, `PaceC2LinkState`, `AlternateDtcOmniLocal`, `PrimaryDtcDirTracking`, `ContingencyGnssDeniedDrFlight`, `EmergencyLostLinkRtlHolding`.

### Layer 2: Logic & State Management
- Behavioral execution contract: invokes `AcquireAndTrackTerminalTarget(in trackHoldSec: Real, in airspeedMs: Real, in targetElevDeg: Real, out targetLocked: Boolean, out abortEngaging: Boolean)` on `EoIrSeekerAndTrackerUnit` with atomic precondition verification.
- State transition management: `SafePowerOff -> BootAndPbit` (trigger `eps14VAppliedWithRbf3Installed`).
- Formal constraints and requirements enforced: `EsadInputVoltageAndBrownoutConstraint (in vdcInV : Real && attribute invariantExpr : String = "vdcInV >= 14.0 and vdcInV <= 32.0")`, `EsadRs485ProtocolTimingConstraint (in baudBps : Integer && in pollHz : Real && in replyMs : Real && in timeoutMs : Real && attribute invariantExpr : String = "baudBps == 115200 and pollHz == 100.0 and replyMs <= 5.0 and timeoutMs <= 10.0")`, `EsadRbf3PowerBeforePullConstraint (in uavPoweredBeforeRbf3Pull : Boolean && in umbResistanceOhm : Real && attribute invariantExpr : String = "uavPoweredBeforeRbf3Pull == true and umbResistanceOhm < 0.5")`, `EsadSafeDistanceExceedConstraint (in safeDistanceExceeded : Boolean && in ss1Sensed : Boolean && attribute invariantExpr : String = "safeDistanceExceeded == true and ss1Sensed == true")`, `WarheadMassAndPbitHvSafetyConstraint (in warheadMassKg : Real && in pbitHvV : Real && in fireHvV : Real && attribute invariantExpr : String = "warheadMassKg <= 5.0 and pbitHvV < 50.0 and fireHvV >= 0.0 and fireHvV <= 1800.0")`, `EngagementSpeedAndTrackHoldConstraint (in airspeedMs : Real && in trackHoldSec : Real && in cepM : Real && attribute invariantExpr : String = "airspeedMs <= 55.0 and trackHoldSec >= 2.0 and trackHoldSec <= 5.0 and cepM <= 0.5")`, `REQ_L_04`, `REQ_H_04`, `REQ_H_05`, `REQ_UCA_05`, `REQ_UCA_06`, `REQ_UCA_07`, `REQ_SC_09`, `REQ_SC_10`, `REQ_SC_11`, `REQ_SC_12`, `REQ_SAF_04`, `REQ_SAF_06`, `REQ_SAF_07`, `REQ_SAF_10`.

### Layer 3: Presentation & Actuator Interface Binding
- Component port bindings on `EoIrSeekerAndTrackerUnit`: `gimbalPowerIn: RegulatedRailInPort (in)`, `serialFc: UartSerialPort (inout)`, `ethSwitch: EthernetFabricPort (inout)`.
- Interaction binding (`INT_06_EoIrSeekerTrackAndTerminalDive`): routes `AcquireAndTrackTerminalTarget` invocation from `PayloadOperator` to `EoIrSeekerAndTrackerUnit` and returns `Boolean`.
- Diagnostic fault surface: reports deterministic rejection diagnostics to `PayloadOperator` across the declared interface boundary when guard or invariant checks fail.

## UML Sequence Diagram

```mermaid
sequenceDiagram
    autonumber
    actor PayloadOperator
    participant OnboardEthernetAndC2RadioUnit
    participant EoIrSeekerAndTrackerUnit
    PayloadOperator->>OnboardEthernetAndC2RadioUnit: AcquireAndTrackTerminalTarget()
    OnboardEthernetAndC2RadioUnit->>EoIrSeekerAndTrackerUnit: AcquireAndTrackTerminalTarget()
    EoIrSeekerAndTrackerUnit-->>OnboardEthernetAndC2RadioUnit: Boolean
    OnboardEthernetAndC2RadioUnit-->>PayloadOperator: StatusReport
```

## Acceptance Criteria (BDD)
- [ ] AC-US-13-01: Given `EoIrSeekerAndTrackerUnit` is in declared state `SafePowerOff` with typed input arguments (`trackHoldSec: Real`, `airspeedMs: Real`, `targetElevDeg: Real`), When `PayloadOperator` invokes `AcquireAndTrackTerminalTarget` on `EoIrSeekerAndTrackerUnit`, Then `EoIrSeekerAndTrackerUnit` validates and binds the request against `EoIrSeekerAndTrackerUnit` domain state (`gimbalModel: String`, `trackerComputeModel: String`, `videoWidthPx: Integer`, `videoHeightPx: Integer`, `zoomFactor: Real`, `pitchMinDeg: Real`, `pitchMaxDeg: Real`, `yawRollMinDeg: Real`, `yawRollMaxDeg: Real`, `engagementSpeedCapMs: Real`, `trackHoldMinSec: Real`, `trackHoldMaxSec: Real`, `maxTargetElevAtStartDeg: Real`, `shallowApproachAngleDeg: Real`, `terminalCepMaxM: Real`, `terminalCepMaxCm: Real`) and transitions to `BootAndPbit`.
- [ ] AC-US-13-02: Given `EoIrSeekerAndTrackerUnit` active state management during `AcquireAndTrackTerminalTarget`, When `EoIrSeekerAndTrackerUnit` evaluates formal constraint `EsadInputVoltageAndBrownoutConstraint (in vdcInV : Real && attribute invariantExpr : String = "vdcInV >= 14.0 and vdcInV <= 32.0")`, Then `EoIrSeekerAndTrackerUnit` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-13-03: Given `EoIrSeekerAndTrackerUnit` active state management during `AcquireAndTrackTerminalTarget`, When `EoIrSeekerAndTrackerUnit` evaluates formal constraint `EsadRs485ProtocolTimingConstraint (in baudBps : Integer && in pollHz : Real && in replyMs : Real && in timeoutMs : Real && attribute invariantExpr : String = "baudBps == 115200 and pollHz == 100.0 and replyMs <= 5.0 and timeoutMs <= 10.0")`, Then `EoIrSeekerAndTrackerUnit` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-13-04: Given `EoIrSeekerAndTrackerUnit` active state management during `AcquireAndTrackTerminalTarget`, When `EoIrSeekerAndTrackerUnit` evaluates formal constraint `EsadRbf3PowerBeforePullConstraint (in uavPoweredBeforeRbf3Pull : Boolean && in umbResistanceOhm : Real && attribute invariantExpr : String = "uavPoweredBeforeRbf3Pull == true and umbResistanceOhm < 0.5")`, Then `EoIrSeekerAndTrackerUnit` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-13-05: Given `EoIrSeekerAndTrackerUnit` active state management during `AcquireAndTrackTerminalTarget`, When `EoIrSeekerAndTrackerUnit` evaluates formal constraint `EsadSafeDistanceExceedConstraint (in safeDistanceExceeded : Boolean && in ss1Sensed : Boolean && attribute invariantExpr : String = "safeDistanceExceeded == true and ss1Sensed == true")`, Then `EoIrSeekerAndTrackerUnit` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-13-06: Given `EoIrSeekerAndTrackerUnit` active state management during `AcquireAndTrackTerminalTarget`, When `EoIrSeekerAndTrackerUnit` evaluates formal constraint `WarheadMassAndPbitHvSafetyConstraint (in warheadMassKg : Real && in pbitHvV : Real && in fireHvV : Real && attribute invariantExpr : String = "warheadMassKg <= 5.0 and pbitHvV < 50.0 and fireHvV >= 0.0 and fireHvV <= 1800.0")`, Then `EoIrSeekerAndTrackerUnit` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-13-07: Given `EoIrSeekerAndTrackerUnit` ingress port binding (`gimbalPowerIn: RegulatedRailInPort`, `serialFc: UartSerialPort`, `ethSwitch: EthernetFabricPort`), When `EoIrSeekerAndTrackerUnit` completes `AcquireAndTrackTerminalTarget`, Then `EoIrSeekerAndTrackerUnit` materializes verified output (`targetLocked: Boolean`, `abortEngaging: Boolean`) and delivers `Boolean` across egress port (`serialFc: UartSerialPort`, `ethSwitch: EthernetFabricPort`) to `PayloadOperator`.
- [ ] AC-US-13-08: Given violated formal constraint `EsadInputVoltageAndBrownoutConstraint (in vdcInV : Real && attribute invariantExpr : String = "vdcInV >= 14.0 and vdcInV <= 32.0")`, When `PayloadOperator` invokes `AcquireAndTrackTerminalTarget` on `EoIrSeekerAndTrackerUnit`, Then `EoIrSeekerAndTrackerUnit` rejects the request without partial state mutation, preserves prior verified state, and emits a deterministic fault diagnostic across the interface binding.

## Required Features
- [ ] #41 - [Feature 10: [Mission Payloads Comms And Ordnance Safety] OnboardEthernetAndC2RadioUnit](../features/FEAT-10-OnboardEthernetAndC2RadioUnit.md)
- [ ] #42 - [Feature 11: [Mission Payloads Comms And Ordnance Safety] EoIrSeekerAndTrackerUnit](../features/FEAT-11-EoIrSeekerAndTrackerUnit.md)

## Source References
Operational concept definitions and system sequence interaction models:
- System Architecture Model: `schema/model.sysml`
- Normative Systems Engineering Standard: ISO/IEC/IEEE 29148:2018 §6.4.2 Concept of Operations

Authoritative user story flows and interaction lifelines derive from `schema/model.sysml` pursuant to ISO/IEC/IEEE 29148.
