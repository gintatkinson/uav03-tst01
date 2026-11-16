| Attribute | Specification Detail |
| :--- | :--- |
| **Issue ID** | #20 |
| **Title** | User Story 16: Execute Launch Go No Go And Dual Trigger |
| **Type** | user-story |
| **Parent Epic** | [EPIC-05-GroundLaunchAndCommandSegment](../epics/EPIC-05-GroundLaunchAndCommandSegment.md) |
| **SysML Interaction** | `INT_08_EmergencyScrubAndSafing` |
| **SysML Test Case** | `Test_ExecuteLaunchGoNoGoAndDualTrigger` |
| **Generation Mode** | subagent |
| **Specification Source** | [schema/model.sysml](../../schema/model.sysml) |

# User Story 16: Execute Launch Go No Go And Dual Trigger

## User Story

As a `LaunchAssistant`, I want to invoke `ExecuteLaunchGoNoGoAndDualTrigger(in pressureBar: Real, in uavMassKg: Real, in headwindMs: Real, in redPinRemoved: Boolean, in mainValve4Open: Boolean, in dualSwitchHoldSec: Real, out carriageReleased: Boolean)` on `SwarmC2OperatorConsole`, so that `SwarmC2OperatorConsole` satisfies formal requirement `REQ_H_06` while enforcing `Pl40MassAndExitVelocityConstraint (in uavMassKg : Real && in pressureBar : Real && in exitVelMs : Real && in windMs : Real && attribute invariantExpr : String = "uavMassKg <= 30.0 and pressureBar >= 13.0 and pressureBar <= 14.0 and exitVelMs <= 25.0 and windMs <= 12.0")`.

## Architectural Realization (3-Layer Definition of Done)

### Layer 1: Domain State & Data Model
- Domain state attributes on `SwarmC2OperatorConsole`: `osPlatform: String`, `softwareSuite: String`, `passwordMinChars: Integer`, `missionNameMaxChars: Integer`, `telemetryDetectTimeoutMin: Real`, `waypointAltMinM: Real`, `altitudeSliderMaxM: Real`, `altitudeSliderStepM: Real`, `loiterRadiusMinM: Real`, `gcsFailsafeTimeoutSec: Real`, `esadSelfDestructHoldSec: Real`, `c2ExportFormats: String`.
- Action `ExecuteLaunchGoNoGoAndDualTrigger` typed data contract: input arguments (`pressureBar: Real`, `uavMassKg: Real`, `headwindMs: Real`, `redPinRemoved: Boolean`, `mainValve4Open: Boolean`, `dualSwitchHoldSec: Real`), output values (`carriageReleased: Boolean`).
- Declared lifecycle state model: `Pl40LauncherState`, `DisassembledTransport`, `AnchoredAndLeveled`, `CompressorCharging`, `UvloPause`, `ReadyAt13To14BarPinInstalled`, `DualSwitchFiring`, `RailLaunchReleased`, `ScrubbedSafeDepressurized`.

### Layer 2: Logic & State Management
- Behavioral execution contract: invokes `ExecuteLaunchGoNoGoAndDualTrigger(in pressureBar: Real, in uavMassKg: Real, in headwindMs: Real, in redPinRemoved: Boolean, in mainValve4Open: Boolean, in dualSwitchHoldSec: Real, out carriageReleased: Boolean)` on `SwarmC2OperatorConsole` with atomic precondition verification.
- State transition management: `DisassembledTransport -> AnchoredAndLeveled` (trigger `railAnchoredAndLeveled12Deg`).
- Formal constraints and requirements enforced: `Pl40MassAndExitVelocityConstraint (in uavMassKg : Real && in pressureBar : Real && in exitVelMs : Real && in windMs : Real && attribute invariantExpr : String = "uavMassKg <= 30.0 and pressureBar >= 13.0 and pressureBar <= 14.0 and exitVelMs <= 25.0 and windMs <= 12.0")`, `Pl40UvloAndDualSwitchConstraint (in packVoltageV : Real && in dualHoldSec : Real && attribute invariantExpr : String = "packVoltageV > 14.5 and dualHoldSec >= 2.0")`, `SwarmC2AuthAndMissionBoundsConstraint (in passwordLen : Integer && in missionNameLen : Integer && in waypointAltM : Real && in loiterRadiusM : Real && attribute invariantExpr : String = "passwordLen >= 8 and missionNameLen <= 24 and waypointAltM >= 50.0 and waypointAltM <= 3000.0 and loiterRadiusM >= 300.0")`, `GroundCrewSeparationAndEsdConstraint (in esdGrounded : Boolean && in separationM : Real && attribute invariantExpr : String = "esdGrounded == true and separationM >= 10.0")`, `REQ_H_06`, `REQ_UCA_08`, `REQ_SC_13`, `REQ_SC_14`, `REQ_SC_15`, `REQ_SC_16`, `REQ_SAF_03`, `REQ_SAF_11`, `REQ_SAF_12`.

### Layer 3: Presentation & Actuator Interface Binding
- Component port bindings on `SwarmC2OperatorConsole`: `gcsStationPort: GcsStationControlPort (inout)`.
- Interaction binding (`INT_08_EmergencyScrubAndSafing`): routes `ExecuteLaunchGoNoGoAndDualTrigger` invocation from `LaunchAssistant` to `SwarmC2OperatorConsole` and returns `Boolean`.
- Diagnostic fault surface: reports deterministic rejection diagnostics to `LaunchAssistant` across the declared interface boundary when guard or invariant checks fail.

## UML Sequence Diagram

```mermaid
sequenceDiagram
    autonumber
    actor LaunchAssistant
    participant Pl40PneumaticLauncher
    participant SwarmC2OperatorConsole
    LaunchAssistant->>Pl40PneumaticLauncher: ExecuteLaunchGoNoGoAndDualTrigger()
    Pl40PneumaticLauncher->>SwarmC2OperatorConsole: ExecuteLaunchGoNoGoAndDualTrigger()
    SwarmC2OperatorConsole-->>Pl40PneumaticLauncher: Boolean
    Pl40PneumaticLauncher-->>LaunchAssistant: StatusReport
```

## Acceptance Criteria (BDD)
- [ ] AC-US-16-01: Given `SwarmC2OperatorConsole` is in declared state `DisassembledTransport` with typed input arguments (`pressureBar: Real`, `uavMassKg: Real`, `headwindMs: Real`, `redPinRemoved: Boolean`, `mainValve4Open: Boolean`, `dualSwitchHoldSec: Real`), When `LaunchAssistant` invokes `ExecuteLaunchGoNoGoAndDualTrigger` on `SwarmC2OperatorConsole`, Then `SwarmC2OperatorConsole` validates and binds the request against `SwarmC2OperatorConsole` domain state (`osPlatform: String`, `softwareSuite: String`, `passwordMinChars: Integer`, `missionNameMaxChars: Integer`, `telemetryDetectTimeoutMin: Real`, `waypointAltMinM: Real`, `altitudeSliderMaxM: Real`, `altitudeSliderStepM: Real`, `loiterRadiusMinM: Real`, `gcsFailsafeTimeoutSec: Real`, `esadSelfDestructHoldSec: Real`, `c2ExportFormats: String`) and transitions to `AnchoredAndLeveled`.
- [ ] AC-US-16-02: Given `SwarmC2OperatorConsole` active state management during `ExecuteLaunchGoNoGoAndDualTrigger`, When `SwarmC2OperatorConsole` evaluates formal constraint `Pl40MassAndExitVelocityConstraint (in uavMassKg : Real && in pressureBar : Real && in exitVelMs : Real && in windMs : Real && attribute invariantExpr : String = "uavMassKg <= 30.0 and pressureBar >= 13.0 and pressureBar <= 14.0 and exitVelMs <= 25.0 and windMs <= 12.0")`, Then `SwarmC2OperatorConsole` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-16-03: Given `SwarmC2OperatorConsole` active state management during `ExecuteLaunchGoNoGoAndDualTrigger`, When `SwarmC2OperatorConsole` evaluates formal constraint `Pl40UvloAndDualSwitchConstraint (in packVoltageV : Real && in dualHoldSec : Real && attribute invariantExpr : String = "packVoltageV > 14.5 and dualHoldSec >= 2.0")`, Then `SwarmC2OperatorConsole` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-16-04: Given `SwarmC2OperatorConsole` active state management during `ExecuteLaunchGoNoGoAndDualTrigger`, When `SwarmC2OperatorConsole` evaluates formal constraint `SwarmC2AuthAndMissionBoundsConstraint (in passwordLen : Integer && in missionNameLen : Integer && in waypointAltM : Real && in loiterRadiusM : Real && attribute invariantExpr : String = "passwordLen >= 8 and missionNameLen <= 24 and waypointAltM >= 50.0 and waypointAltM <= 3000.0 and loiterRadiusM >= 300.0")`, Then `SwarmC2OperatorConsole` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-16-05: Given `SwarmC2OperatorConsole` active state management during `ExecuteLaunchGoNoGoAndDualTrigger`, When `SwarmC2OperatorConsole` evaluates formal constraint `GroundCrewSeparationAndEsdConstraint (in esdGrounded : Boolean && in separationM : Real && attribute invariantExpr : String = "esdGrounded == true and separationM >= 10.0")`, Then `SwarmC2OperatorConsole` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-16-06: Given `SwarmC2OperatorConsole` requirement allocation for `ExecuteLaunchGoNoGoAndDualTrigger`, When `SwarmC2OperatorConsole` verifies formal requirement `REQ_H_06`, Then `SwarmC2OperatorConsole` confirms normative requirement satisfaction across execution.
- [ ] AC-US-16-07: Given `SwarmC2OperatorConsole` ingress port binding (`gcsStationPort: GcsStationControlPort`), When `SwarmC2OperatorConsole` completes `ExecuteLaunchGoNoGoAndDualTrigger`, Then `SwarmC2OperatorConsole` materializes verified output (`carriageReleased: Boolean`) and delivers `Boolean` across egress port (`gcsStationPort: GcsStationControlPort`) to `LaunchAssistant`.
- [ ] AC-US-16-08: Given violated formal constraint `Pl40MassAndExitVelocityConstraint (in uavMassKg : Real && in pressureBar : Real && in exitVelMs : Real && in windMs : Real && attribute invariantExpr : String = "uavMassKg <= 30.0 and pressureBar >= 13.0 and pressureBar <= 14.0 and exitVelMs <= 25.0 and windMs <= 12.0")`, When `LaunchAssistant` invokes `ExecuteLaunchGoNoGoAndDualTrigger` on `SwarmC2OperatorConsole`, Then `SwarmC2OperatorConsole` rejects the request without partial state mutation, preserves prior verified state, and emits a deterministic fault diagnostic across the interface binding.

## Required Features
- [ ] #44 - [Feature 13: [Ground Launch And Command Segment] Pl40PneumaticLauncher](../features/FEAT-13-Pl40PneumaticLauncher.md)
- [ ] #45 - [Feature 14: [Ground Launch And Command Segment] SwarmC2OperatorConsole](../features/FEAT-14-SwarmC2OperatorConsole.md)

## Source References
Operational concept definitions and system sequence interaction models:
- System Architecture Model: `schema/model.sysml`
- Normative Systems Engineering Standard: ISO/IEC/IEEE 29148:2018 §6.4.2 Concept of Operations

Authoritative user story flows and interaction lifelines derive from `schema/model.sysml` pursuant to ISO/IEC/IEEE 29148.
