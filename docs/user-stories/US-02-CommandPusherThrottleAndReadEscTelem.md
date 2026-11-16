| Attribute | Specification Detail |
| :--- | :--- |
| **Issue ID** | #6 |
| **Title** | User Story 02: Command Pusher Throttle And Read Esc Telem |
| **Type** | user-story |
| **Parent Epic** | [EPIC-02-AirframePowerAndPropulsion](../epics/EPIC-02-AirframePowerAndPropulsion.md) |
| **SysML Interaction** | `INT_02_PropulsionThrustAndBingoMonitor` |
| **SysML Test Case** | `Test_CommandPusherThrottleAndReadEscTelem` |
| **Generation Mode** | subagent |
| **Specification Source** | [schema/model.sysml](../../schema/model.sysml) |

# User Story 02: Command Pusher Throttle And Read Esc Telem

## User Story

As a `LaunchAssistant`, I want to invoke `CommandPusherThrottleAndReadEscTelem(in throttleNorm: Real, in flightArmed: Boolean, out escRpm: Real, out escTempDegC: Real, out motorTempDegC: Real, out busCurrentA: Real)` on `PowerMeterAndRbfSwitch`, so that `PowerMeterAndRbfSwitch` satisfies formal requirement `REQ_L_01` while enforcing `MainBatteryPreFlightVoltageConstraint (in packVoltageV : Real && in busVoltageV : Real && attribute invariantExpr : String = "packVoltageV >= 49.0 and packVoltageV <= 50.0 and busVoltageV >= 36.0 and busVoltageV <= 50.4")`.

## Architectural Realization (3-Layer Definition of Done)

### Layer 1: Domain State & Data Model
- Domain state attributes on `PowerMeterAndRbfSwitch`: `rbfKeyId: String`, `busVoltageMinV: Real`, `busVoltageMaxV: Real`, `trunkHarnessLengthCm: Real`, `rbf2RemovedPowersOn: Boolean`, `pullRbf2BeforeRbf3: Boolean`.
- Action `CommandPusherThrottleAndReadEscTelem` typed data contract: input arguments (`throttleNorm: Real`, `flightArmed: Boolean`), output values (`escRpm: Real`, `escTempDegC: Real`, `motorTempDegC: Real`, `busCurrentA: Real`).
- Declared lifecycle state model: `UavFlightLifecycleState`, `PreFlightCheck`, `CatapultLaunch`, `CruiseAndLoiter`, `TargetTrackAndDive`, `EmergencyAbortOrRtb`, `SafePostFlightShutdown`.

### Layer 2: Logic & State Management
- Behavioral execution contract: invokes `CommandPusherThrottleAndReadEscTelem(in throttleNorm: Real, in flightArmed: Boolean, out escRpm: Real, out escTempDegC: Real, out motorTempDegC: Real, out busCurrentA: Real)` on `PowerMeterAndRbfSwitch` with atomic precondition verification.
- State transition management: `PreFlightCheck -> CatapultLaunch` (trigger `launchAuthorizedAndCarriageReleased`).
- Formal constraints and requirements enforced: `MainBatteryPreFlightVoltageConstraint (in packVoltageV : Real && in busVoltageV : Real && attribute invariantExpr : String = "packVoltageV >= 49.0 and packVoltageV <= 50.0 and busVoltageV >= 36.0 and busVoltageV <= 50.4")`, `BingoEnergyReserveConstraint (in reserveRatio : Real && attribute invariantExpr : String = "reserveRatio >= 0.20")`, `FlightEnvelopeSpeedConstraint (in airspeedMs : Real && in engagementActive : Boolean && attribute invariantExpr : String = "airspeedMs >= 24.0 and airspeedMs <= 80.0 and (not engagementActive or airspeedMs <= 55.0)")`, `EpsEsadZeroBrownoutMarginConstraint (in epsEsadOutV : Real && attribute invariantExpr : String = "epsEsadOutV >= 14.0 and epsEsadOutV <= 32.0")`, `ProductionNoParachuteConstraint (in rndRecoveryOptionInstalled : Boolean && attribute invariantExpr : String = "rndRecoveryOptionInstalled == false")`, `REQ_L_01`, `REQ_L_02`, `REQ_H_01`, `REQ_H_02`, `REQ_UCA_01`, `REQ_UCA_02`, `REQ_SC_01`, `REQ_SC_02`, `REQ_SC_03`, `REQ_SC_04`, `REQ_SAF_01`, `REQ_SAF_02`, `REQ_SAF_05`.

### Layer 3: Presentation & Actuator Interface Binding
- Component port bindings on `PowerMeterAndRbfSwitch`: `mainDcIn: MainBatteryDcInPort (in)`, `escDriveOut: EscDriveHarnessOutPort (inout)`, `trunkDcOut970cm: TrunkDcPowerOutPort (out)`, `can1Tap: Can1PowerTapPort (inout)`.
- Interaction binding (`INT_02_PropulsionThrustAndBingoMonitor`): routes `CommandPusherThrottleAndReadEscTelem` invocation from `LaunchAssistant` to `PowerMeterAndRbfSwitch` and returns `Real`.
- Diagnostic fault surface: reports deterministic rejection diagnostics to `LaunchAssistant` across the declared interface boundary when guard or invariant checks fail.

## UML Sequence Diagram

```mermaid
sequenceDiagram
    autonumber
    actor LaunchAssistant
    participant MainBatteryAndFuseUnit
    participant PowerMeterAndRbfSwitch
    LaunchAssistant->>MainBatteryAndFuseUnit: CommandPusherThrottleAndReadEscTelem()
    MainBatteryAndFuseUnit->>PowerMeterAndRbfSwitch: CommandPusherThrottleAndReadEscTelem()
    PowerMeterAndRbfSwitch-->>MainBatteryAndFuseUnit: Real
    MainBatteryAndFuseUnit-->>LaunchAssistant: StatusReport
```

## Acceptance Criteria (BDD)
- [ ] AC-US-02-01: Given `PowerMeterAndRbfSwitch` is in declared state `PreFlightCheck` with typed input arguments (`throttleNorm: Real`, `flightArmed: Boolean`), When `LaunchAssistant` invokes `CommandPusherThrottleAndReadEscTelem` on `PowerMeterAndRbfSwitch`, Then `PowerMeterAndRbfSwitch` validates and binds the request against `PowerMeterAndRbfSwitch` domain state (`rbfKeyId: String`, `busVoltageMinV: Real`, `busVoltageMaxV: Real`, `trunkHarnessLengthCm: Real`, `rbf2RemovedPowersOn: Boolean`, `pullRbf2BeforeRbf3: Boolean`) and transitions to `CatapultLaunch`.
- [ ] AC-US-02-02: Given `PowerMeterAndRbfSwitch` active state management during `CommandPusherThrottleAndReadEscTelem`, When `PowerMeterAndRbfSwitch` evaluates formal constraint `MainBatteryPreFlightVoltageConstraint (in packVoltageV : Real && in busVoltageV : Real && attribute invariantExpr : String = "packVoltageV >= 49.0 and packVoltageV <= 50.0 and busVoltageV >= 36.0 and busVoltageV <= 50.4")`, Then `PowerMeterAndRbfSwitch` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-02-03: Given `PowerMeterAndRbfSwitch` active state management during `CommandPusherThrottleAndReadEscTelem`, When `PowerMeterAndRbfSwitch` evaluates formal constraint `BingoEnergyReserveConstraint (in reserveRatio : Real && attribute invariantExpr : String = "reserveRatio >= 0.20")`, Then `PowerMeterAndRbfSwitch` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-02-04: Given `PowerMeterAndRbfSwitch` active state management during `CommandPusherThrottleAndReadEscTelem`, When `PowerMeterAndRbfSwitch` evaluates formal constraint `FlightEnvelopeSpeedConstraint (in airspeedMs : Real && in engagementActive : Boolean && attribute invariantExpr : String = "airspeedMs >= 24.0 and airspeedMs <= 80.0 and (not engagementActive or airspeedMs <= 55.0)")`, Then `PowerMeterAndRbfSwitch` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-02-05: Given `PowerMeterAndRbfSwitch` active state management during `CommandPusherThrottleAndReadEscTelem`, When `PowerMeterAndRbfSwitch` evaluates formal constraint `EpsEsadZeroBrownoutMarginConstraint (in epsEsadOutV : Real && attribute invariantExpr : String = "epsEsadOutV >= 14.0 and epsEsadOutV <= 32.0")`, Then `PowerMeterAndRbfSwitch` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-02-06: Given `PowerMeterAndRbfSwitch` active state management during `CommandPusherThrottleAndReadEscTelem`, When `PowerMeterAndRbfSwitch` evaluates formal constraint `ProductionNoParachuteConstraint (in rndRecoveryOptionInstalled : Boolean && attribute invariantExpr : String = "rndRecoveryOptionInstalled == false")`, Then `PowerMeterAndRbfSwitch` verifies constraint satisfaction before committing state updates.
- [ ] AC-US-02-07: Given `PowerMeterAndRbfSwitch` ingress port binding (`mainDcIn: MainBatteryDcInPort`, `escDriveOut: EscDriveHarnessOutPort`, `can1Tap: Can1PowerTapPort`), When `PowerMeterAndRbfSwitch` completes `CommandPusherThrottleAndReadEscTelem`, Then `PowerMeterAndRbfSwitch` materializes verified output (`escRpm: Real`, `escTempDegC: Real`, `motorTempDegC: Real`, `busCurrentA: Real`) and delivers `Real` across egress port (`escDriveOut: EscDriveHarnessOutPort`, `trunkDcOut970cm: TrunkDcPowerOutPort`, `can1Tap: Can1PowerTapPort`) to `LaunchAssistant`.
- [ ] AC-US-02-08: Given violated formal constraint `MainBatteryPreFlightVoltageConstraint (in packVoltageV : Real && in busVoltageV : Real && attribute invariantExpr : String = "packVoltageV >= 49.0 and packVoltageV <= 50.0 and busVoltageV >= 36.0 and busVoltageV <= 50.4")`, When `LaunchAssistant` invokes `CommandPusherThrottleAndReadEscTelem` on `PowerMeterAndRbfSwitch`, Then `PowerMeterAndRbfSwitch` rejects the request without partial state mutation, preserves prior verified state, and emits a deterministic fault diagnostic across the interface binding.

## Required Features
- [ ] #33 - [Feature 02: [Airframe Power And Propulsion] MainBatteryAndFuseUnit](../features/FEAT-02-MainBatteryAndFuseUnit.md)
- [ ] #34 - [Feature 03: [Airframe Power And Propulsion] PowerMeterAndRbfSwitch](../features/FEAT-03-PowerMeterAndRbfSwitch.md)

## Source References
Operational concept definitions and system sequence interaction models:
- System Architecture Model: `schema/model.sysml`
- Normative Systems Engineering Standard: ISO/IEC/IEEE 29148:2018 §6.4.2 Concept of Operations

Authoritative user story flows and interaction lifelines derive from `schema/model.sysml` pursuant to ISO/IEC/IEEE 29148.
