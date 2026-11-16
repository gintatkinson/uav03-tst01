| Attribute | Specification Detail |
| :--- | :--- |
| **Issue ID** | #16 |
| **Title** | User Story 12: Command Esad Abort And Self Destruct |
| **Type** | user-story |
| **Parent Epic** | [EPIC-04-MissionPayloadsCommsAndOrdnanceSafety](../epics/EPIC-04-MissionPayloadsCommsAndOrdnanceSafety.md) |
| **SysML Interaction** | `INT_06_EoIrSeekerTrackAndTerminalDive` |
| **SysML Test Case** | `Test_CommandEsadAbortAndSelfDestruct` |
| **Generation Mode** | subagent |
| **Specification Source** | [schema/model.sysml](../../schema/model.sysml) |

# User Story 12: Command Esad Abort And Self Destruct

## User Story

As a `PayloadOperator`, I want to invoke `CommandEsadAbortAndSelfDestruct(in holdDurationSec: Real, in slideConfirmed: Boolean, in gcsTimeoutActive: Boolean, out hvDischarged: Boolean, out faultLockedOut: Boolean)` on `EoIrSeekerAndTrackerUnit`, so that `EoIrSeekerAndTrackerUnit` satisfies formal requirement `REQ_L_04` while enforcing `EsadInputVoltageAndBrownoutConstraint (in vdcInV : Real && attribute invariantExpr : String = "vdcInV >= 14.0 and vdcInV <= 32.0")`.

## Architectural Realization (3-Layer Definition of Done)

### Layer 1: Domain State & Data Model
- Domain state attributes on `EoIrSeekerAndTrackerUnit`: `gimbalModel: String`, `trackerComputeModel: String`, `videoWidthPx: Integer`, `videoHeightPx: Integer`, `zoomFactor: Real`, `pitchMinDeg: Real`, `pitchMaxDeg: Real`, `yawRollMinDeg: Real`, `yawRollMaxDeg: Real`, `engagementSpeedCapMs: Real`, `trackHoldMinSec: Real`, `trackHoldMaxSec: Real`, `maxTargetElevAtStartDeg: Real`, `shallowApproachAngleDeg: Real`, `terminalCepMaxM: Real`, `terminalCepMaxCm: Real`.
- Action `CommandEsadAbortAndSelfDestruct` typed data contract: input arguments (`holdDurationSec: Real`, `slideConfirmed: Boolean`, `gcsTimeoutActive: Boolean`), output values (`hvDischarged: Boolean`, `faultLockedOut: Boolean`).
- Declared lifecycle state model: `EsadSafeArmState`, `SafePowerOff`, `BootAndPbit`, `SafeRbfInstalled`, `FaultLockout`, `SafeRbfRemoved`, `ArmStage1TimerWait`, `ArmStage2Armed`, `HvChargedReady`, `DetonatedOrAborted`, `PaceC2LinkState`, `AlternateDtcOmniLocal`, `PrimaryDtcDirTracking`, `ContingencyGnssDeniedDrFlight`, `EmergencyLostLinkRtlHolding`.

### Layer 2: Logic & State Management
- Behavioral execution contract: invokes `CommandEsadAbortAndSelfDestruct(in holdDurationSec: Real, in slideConfirmed: Boolean, in gcsTimeoutActive: Boolean, out hvDischarged: Boolean, out faultLockedOut: Boolean)` on `EoIrSeekerAndTrackerUnit` with atomic precondition verification.
- State transition management: `SafePowerOff -> BootAndPbit` (trigger `eps14VAppliedWithRbf3Installed`).
- Formal constraints and requirements enforced: `EsadInputVoltageAndBrownoutConstraint (in vdcInV : Real && attribute invariantExpr : String = "vdcInV >= 14.0 and vdcInV <= 32.0")`, `EsadRs485ProtocolTimingConstraint (in baudBps : Integer && in pollHz : Real && in replyMs : Real && in timeoutMs : Real && attribute invariantExpr : String = "baudBps == 115200 and pollHz == 100.0 and replyMs <= 5.0 and timeoutMs <= 10.0")`, `EsadRbf3PowerBeforePullConstraint (in uavPoweredBeforeRbf3Pull : Boolean && in umbResistanceOhm : Real && attribute invariantExpr : String = "uavPoweredBeforeRbf3Pull == true and umbResistanceOhm < 0.5")`, `EsadSafeDistanceExceedConstraint (in safeDistanceExceeded : Boolean && in ss1Sensed : Boolean && attribute invariantExpr : String = "safeDistanceExceeded == true and ss1Sensed == true")`, `WarheadMassAndPbitHvSafetyConstraint (in warheadMassKg : Real && in pbitHvV : Real && in fireHvV : Real && attribute invariantExpr : String = "warheadMassKg <= 5.0 and pbitHvV < 50.0 and fireHvV >= 0.0 and fireHvV <= 1800.0")`, `EngagementSpeedAndTrackHoldConstraint (in airspeedMs : Real && in trackHoldSec : Real && in cepM : Real && attribute invariantExpr : String = "airspeedMs <= 55.0 and trackHoldSec >= 2.0 and trackHoldSec <= 5.0 and cepM <= 0.5")`, `REQ_L_04`, `REQ_H_04`, `REQ_H_05`, `REQ_UCA_05`, `REQ_UCA_06`, `REQ_UCA_07`, `REQ_SC_09`, `REQ_SC_10`, `REQ_SC_11`, `REQ_SC_12`, `REQ_SAF_04`, `REQ_SAF_06`, `REQ_SAF_07`, `REQ_SAF_10`.

### Layer 3: Presentation & Actuator Interface Binding
- Component port bindings on `EoIrSeekerAndTrackerUnit`: `gimbalPowerIn: RegulatedRailInPort (in)`, `serialFc: UartSerialPort (inout)`, `ethSwitch: EthernetFabricPort (inout)`.
- Interaction binding (`INT_06_EoIrSeekerTrackAndTerminalDive`): routes `CommandEsadAbortAndSelfDestruct` invocation from `PayloadOperator` to `EoIrSeekerAndTrackerUnit` and returns `Boolean`.
- Diagnostic fault surface: reports deterministic rejection diagnostics to `PayloadOperator` across the declared interface boundary when guard or invariant checks fail.

## UML Sequence Diagram

```mermaid
sequenceDiagram
    autonumber
    actor PayloadOperator
    participant OnboardEthernetAndC2RadioUnit
    participant EoIrSeekerAndTrackerUnit
    PayloadOperator->>OnboardEthernetAndC2RadioUnit: CommandEsadAbortAndSelfDestruct()
    OnboardEthernetAndC2RadioUnit->>EoIrSeekerAndTrackerUnit: CommandEsadAbortAndSelfDestruct()
    EoIrSeekerAndTrackerUnit-->>OnboardEthernetAndC2RadioUnit: Boolean
    OnboardEthernetAndC2RadioUnit-->>PayloadOperator: StatusReport
```

## Acceptance Criteria (BDD)
- [ ] AC-US-12-01: Given `EoIrSeekerAndTrackerUnit` is in declared state `SafePowerOff` with typed input arguments (`holdDurationSec: Real`, `slideConfirmed: Boolean`, `gcsTimeoutActive: Boolean`), When `PayloadOperator` invokes `CommandEsadAbortAndSelfDestruct` on `EoIrSeekerAndTrackerUnit`, Then `EoIrSeekerAndTrackerUnit` validates and binds the request against `EoIrSeekerAndTrackerUnit` domain state (`gimbalModel: String`, `trackerComputeModel: String`, `videoWidthPx: Integer`, `videoHeightPx: Integer`, `zoomFactor: Real`, `pitchMinDeg: Real`, `pitchMaxDeg: Real`, `yawRollMinDeg: Real`, `yawRollMaxDeg: Real`, `engagementSpeedCapMs: Real`, `trackHoldMinSec: Real`, `trackHoldMaxSec: Real`, `maxTargetElevAtStartDeg: Real`, `shallowApproachAngleDeg: Real`, `terminalCepMaxM: Real`, `terminalCepMaxCm: Real`) and transitions to `BootAndPbit`.
- [ ] AC-US-12-02: Given `EoIrSeekerAndTrackerUnit` active state management during `CommandEsadAbortAndSelfDestruct`, When `EoIrSeekerAndTrackerUnit` evaluates formal constraint `EsadInputVoltageAndBrownoutConstraint (in vdcInV : Real && attribute invariantExpr : String = "vdcInV >= 14.0 and vdcInV <= 32.0")`, Then `EoIrSeekerAndTrackerUnit` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-12-03: Given `EoIrSeekerAndTrackerUnit` active state management during `CommandEsadAbortAndSelfDestruct`, When `EoIrSeekerAndTrackerUnit` evaluates formal constraint `EsadRs485ProtocolTimingConstraint (in baudBps : Integer && in pollHz : Real && in replyMs : Real && in timeoutMs : Real && attribute invariantExpr : String = "baudBps == 115200 and pollHz == 100.0 and replyMs <= 5.0 and timeoutMs <= 10.0")`, Then `EoIrSeekerAndTrackerUnit` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-12-04: Given `EoIrSeekerAndTrackerUnit` active state management during `CommandEsadAbortAndSelfDestruct`, When `EoIrSeekerAndTrackerUnit` evaluates formal constraint `EsadRbf3PowerBeforePullConstraint (in uavPoweredBeforeRbf3Pull : Boolean && in umbResistanceOhm : Real && attribute invariantExpr : String = "uavPoweredBeforeRbf3Pull == true and umbResistanceOhm < 0.5")`, Then `EoIrSeekerAndTrackerUnit` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-12-05: Given `EoIrSeekerAndTrackerUnit` active state management during `CommandEsadAbortAndSelfDestruct`, When `EoIrSeekerAndTrackerUnit` evaluates formal constraint `EsadSafeDistanceExceedConstraint (in safeDistanceExceeded : Boolean && in ss1Sensed : Boolean && attribute invariantExpr : String = "safeDistanceExceeded == true and ss1Sensed == true")`, Then `EoIrSeekerAndTrackerUnit` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-12-06: Given `EoIrSeekerAndTrackerUnit` active state management during `CommandEsadAbortAndSelfDestruct`, When `EoIrSeekerAndTrackerUnit` evaluates formal constraint `WarheadMassAndPbitHvSafetyConstraint (in warheadMassKg : Real && in pbitHvV : Real && in fireHvV : Real && attribute invariantExpr : String = "warheadMassKg <= 5.0 and pbitHvV < 50.0 and fireHvV >= 0.0 and fireHvV <= 1800.0")`, Then `EoIrSeekerAndTrackerUnit` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-12-07: Given `EoIrSeekerAndTrackerUnit` ingress port binding (`gimbalPowerIn: RegulatedRailInPort`, `serialFc: UartSerialPort`, `ethSwitch: EthernetFabricPort`), When `EoIrSeekerAndTrackerUnit` completes `CommandEsadAbortAndSelfDestruct`, Then `EoIrSeekerAndTrackerUnit` materializes verified output (`hvDischarged: Boolean`, `faultLockedOut: Boolean`) and delivers `Boolean` across egress port (`serialFc: UartSerialPort`, `ethSwitch: EthernetFabricPort`) to `PayloadOperator`.
- [ ] AC-US-12-08: Given violated formal constraint `EsadInputVoltageAndBrownoutConstraint (in vdcInV : Real && attribute invariantExpr : String = "vdcInV >= 14.0 and vdcInV <= 32.0")`, When `PayloadOperator` invokes `CommandEsadAbortAndSelfDestruct` on `EoIrSeekerAndTrackerUnit`, Then `EoIrSeekerAndTrackerUnit` rejects the request without partial state mutation, preserves prior verified state, and emits a deterministic fault diagnostic across the interface binding.

## Required Features
- [ ] #41 - [Feature 10: [Mission Payloads Comms And Ordnance Safety] OnboardEthernetAndC2RadioUnit](../features/FEAT-10-OnboardEthernetAndC2RadioUnit.md)
- [ ] #42 - [Feature 11: [Mission Payloads Comms And Ordnance Safety] EoIrSeekerAndTrackerUnit](../features/FEAT-11-EoIrSeekerAndTrackerUnit.md)

## Source References
Operational concept definitions and system sequence interaction models:
- System Architecture Model: `schema/model.sysml`
- Normative Systems Engineering Standard: ISO/IEC/IEEE 29148:2018 §6.4.2 Concept of Operations

Authoritative user story flows and interaction lifelines derive from `schema/model.sysml` pursuant to ISO/IEC/IEEE 29148.
