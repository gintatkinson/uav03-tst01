| Attribute | Specification Detail |
| :--- | :--- |
| **Issue ID** | #34 |
| **Title** | Feature 03: [Airframe Power And Propulsion] PowerMeterAndRbfSwitch |
| **Type** | feature |
| **Parent Epic** | [EPIC-02-AirframePowerAndPropulsion](../epics/EPIC-02-AirframePowerAndPropulsion.md) |
| **Interface Type** | Physical / Structural / Internal Bus |
| **Schema Containers** | `AirframePowerAndPropulsion::PowerMeterAndRbfSwitch` |
| **Generation Mode** | subagent |
| **Specification Source** | [schema/model.sysml](../../schema/model.sysml) |

# Feature 03: [Airframe Power And Propulsion] PowerMeterAndRbfSwitch

## UML Class Diagram

```mermaid
classDiagram
    class PowerMeterAndRbfSwitch {
        +MainBatteryDcInPort mainDcIn (in)
        +EscDriveHarnessOutPort escDriveOut (inout)
        +TrunkDcPowerOutPort trunkDcOut970cm (out)
        +Can1PowerTapPort can1Tap (inout)
        +String rbfKeyId
        +Real busVoltageMinV
        +Real busVoltageMaxV
        +Real trunkHarnessLengthCm
        +Boolean rbf2RemovedPowersOn
        +Boolean pullRbf2BeforeRbf3
    }
```

## Interface Requirements
### 1. Test Data Shape
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "PowerMeterAndRbfSwitchPayloadSchema",
  "type": "object",
  "properties": {
    "part": {
      "type": "string",
      "const": "PowerMeterAndRbfSwitch"
    },
    "status": {
      "type": "string",
      "enum": ["nominal", "degraded", "fault"]
    },
    "rbfKeyId": {
      "type": "string",
      "x-sysml-type": "String",
      "description": "Declared attribute rbfKeyId (String)",
      "default": "UAV Power R.B.F. Key #2 (XT60E-F)"
    },
    "busVoltageMinV": {
      "type": "number",
      "x-sysml-type": "Real",
      "description": "Declared attribute busVoltageMinV (Real)",
      "default": 36.0
    },
    "busVoltageMaxV": {
      "type": "number",
      "x-sysml-type": "Real",
      "description": "Declared attribute busVoltageMaxV (Real)",
      "default": 50.4
    },
    "trunkHarnessLengthCm": {
      "type": "number",
      "x-sysml-type": "Real",
      "description": "Declared attribute trunkHarnessLengthCm (Real)",
      "default": 970.0
    },
    "rbf2RemovedPowersOn": {
      "type": "boolean",
      "x-sysml-type": "Boolean",
      "description": "Declared attribute rbf2RemovedPowersOn (Boolean)",
      "default": true
    },
    "pullRbf2BeforeRbf3": {
      "type": "boolean",
      "x-sysml-type": "Boolean",
      "description": "Declared attribute pullRbf2BeforeRbf3 (Boolean)",
      "default": true
    },
    "mainDcIn": {
      "type": "object",
      "properties": {
        "direction": { "type": "string", "const": "in" },
        "port_type": { "type": "string", "const": "MainBatteryDcInPort" }
      },
      "required": ["direction", "port_type"]
    },
    "escDriveOut": {
      "type": "object",
      "properties": {
        "direction": { "type": "string", "const": "inout" },
        "port_type": { "type": "string", "const": "EscDriveHarnessOutPort" }
      },
      "required": ["direction", "port_type"]
    },
    "trunkDcOut970cm": {
      "type": "object",
      "properties": {
        "direction": { "type": "string", "const": "out" },
        "port_type": { "type": "string", "const": "TrunkDcPowerOutPort" }
      },
      "required": ["direction", "port_type"]
    },
    "can1Tap": {
      "type": "object",
      "properties": {
        "direction": { "type": "string", "const": "inout" },
        "port_type": { "type": "string", "const": "Can1PowerTapPort" }
      },
      "required": ["direction", "port_type"]
    }
  },
  "required": [
    "part",
    "status",
    "mainDcIn",
    "escDriveOut",
    "trunkDcOut970cm",
    "can1Tap"
  ],
  "additionalProperties": false
}
```

### 2. Validation & Constraints
Declared structural attributes, boundary ports, invariants, and allocated requirements for classifier `PowerMeterAndRbfSwitch`:

| AST Member Kind | Identifier | Declared Type / Direction | Default / Invariant Contract |
| :--- | :--- | :--- | :--- |
| Attribute | `rbfKeyId` | `String` | Declared default in JSON Schema |
| Attribute | `busVoltageMinV` | `Real` | Default `36.0` |
| Attribute | `busVoltageMaxV` | `Real` | Default `50.4` |
| Attribute | `trunkHarnessLengthCm` | `Real` | Default `970.0` |
| Attribute | `rbf2RemovedPowersOn` | `Boolean` | Default `true` |
| Attribute | `pullRbf2BeforeRbf3` | `Boolean` | Default `true` |
| Port | `mainDcIn` | `in MainBatteryDcInPort` | Boundary interface contract |
| Port | `escDriveOut` | `inout EscDriveHarnessOutPort` | Boundary interface contract |
| Port | `trunkDcOut970cm` | `out TrunkDcPowerOutPort` | Boundary interface contract |
| Port | `can1Tap` | `inout Can1PowerTapPort` | Boundary interface contract |
| Requirement | `REQ_L_01` | Allocated Requirement | Allocated requirement obligation |
| Requirement | `REQ_L_02` | Allocated Requirement | Allocated requirement obligation |
| Requirement | `REQ_H_01` | Allocated Requirement | Allocated requirement obligation |
| Requirement | `REQ_H_02` | Allocated Requirement | Allocated requirement obligation |
| Requirement | `REQ_UCA_01` | Allocated Requirement | Allocated requirement obligation |
| Requirement | `REQ_UCA_02` | Allocated Requirement | Allocated requirement obligation |
| Requirement | `REQ_SC_01` | Allocated Requirement | SC-01: Enforce ordered pre-flight interlock: ESD ground -> RBF #1 off -> prop fold rearward -> RBF #2 pull -> 49.0-50.0 V check -> lock both RBF and umbilical lids. |
| Requirement | `REQ_SC_02` | Allocated Requirement | Allocated requirement obligation |
| Requirement | `REQ_SC_03` | Allocated Requirement | SC-03: Inhibit optional 2x 50.0 V RnD recovery igniter outputs on production Avenger V2.5 (rndRecoveryOptionInstalled == false). |
| Requirement | `REQ_SC_04` | Allocated Requirement | Allocated requirement obligation |
| Requirement | `REQ_SAF_01` | Allocated Requirement | Allocated requirement obligation |
| Requirement | `REQ_SAF_02` | Allocated Requirement | Allocated requirement obligation |
| Requirement | `REQ_SAF_05` | Allocated Requirement | GAP-05 Mitigation: Anchor battery UI and health checks strictly to 12S2P 36.0-50.4 V (49.0-50.0 V pre-flight), rejecting legacy 23.9-25.0 V screenshots. |

### 3. Visual Layout & Arrangement
Structural composition and boundary topology for classifier `PowerMeterAndRbfSwitch` organize no nested subparts declared in schema paired with boundary ports `in mainDcIn : MainBatteryDcInPort`, `inout escDriveOut : EscDriveHarnessOutPort`, `out trunkDcOut970cm : TrunkDcPowerOutPort`, `inout can1Tap : Can1PowerTapPort`.

### 4. Interactive Flow & States
Operational lifecycle events and discrete state transitions for PowerMeterAndRbfSwitch.

### Layer 1: Domain State & Signal Model
Classifier `PowerMeterAndRbfSwitch` encapsulates typed domain state attributes `rbfKeyId : String`, `busVoltageMinV : Real`, `busVoltageMaxV : Real`, `trunkHarnessLengthCm : Real`, `rbf2RemovedPowersOn : Boolean`, `pullRbf2BeforeRbf3 : Boolean` alongside operational lifecycle status.

### Layer 2: Logic & Safety State Management
Classifier `PowerMeterAndRbfSwitch` governs stateless structural transition evaluation enforcing invariant obligations `REQ_L_01`, `REQ_L_02`, `REQ_H_01`, `REQ_H_02`, `REQ_UCA_01`, `REQ_UCA_02`, `REQ_SC_01`, `REQ_SC_02`, `REQ_SC_03`, `REQ_SC_04`, `REQ_SAF_01`, `REQ_SAF_02`, `REQ_SAF_05`.

### Layer 3: Presentation & Actuator Interface Binding
Classifier `PowerMeterAndRbfSwitch` binds external and behavioral interfaces across port `in mainDcIn : MainBatteryDcInPort`, port `inout escDriveOut : EscDriveHarnessOutPort`, port `out trunkDcOut970cm : TrunkDcPowerOutPort`, port `inout can1Tap : Can1PowerTapPort`.

### Associated Use Cases & User Stories

#### Associated Use Cases
- None allocated (structural subsystem component)

#### Associated User Stories
- [ ] #5 - [User Story 01: Validate Battery And Power On Rbf2](../user-stories/US-01-ValidateBatteryAndPowerOnRbf2.md)
- [ ] #6 - [User Story 02: Command Pusher Throttle And Read Esc Telem](../user-stories/US-02-CommandPusherThrottleAndReadEscTelem.md)
- [ ] #7 - [User Story 03: Distribute Regulated Power Rails](../user-stories/US-03-DistributeRegulatedPowerRails.md)
- [ ] #8 - [User Story 04: Monitor Bingo Energy Reserve](../user-stories/US-04-MonitorBingoEnergyReserve.md)

## Acceptance Criteria (BDD)
- [ ] AC-01: Given valid `PowerMeterAndRbfSwitch` inputs satisfying `REQ_L_01`, When `PowerMeterAndRbfSwitch` evaluates invariant `REQ_L_01`, Then the invariant holds and verified state is committed.
- [ ] AC-02: Given boundary inputs that violate `REQ_L_01`, When `PowerMeterAndRbfSwitch` evaluates invariant `REQ_L_01`, Then `PowerMeterAndRbfSwitch` rejects the invalid transition and routes a diagnostic via diagnostic port `escDriveOut`.
- [ ] AC-03: Given valid `PowerMeterAndRbfSwitch` inputs satisfying `REQ_L_02`, When `PowerMeterAndRbfSwitch` evaluates invariant `REQ_L_02`, Then the invariant holds and verified state is committed.
- [ ] AC-04: Given boundary inputs that violate `REQ_L_02`, When `PowerMeterAndRbfSwitch` evaluates invariant `REQ_L_02`, Then `PowerMeterAndRbfSwitch` rejects the invalid transition and routes a diagnostic via diagnostic port `escDriveOut`.
- [ ] AC-05: Given valid `PowerMeterAndRbfSwitch` inputs satisfying `REQ_H_01`, When `PowerMeterAndRbfSwitch` evaluates invariant `REQ_H_01`, Then the invariant holds and verified state is committed.
- [ ] AC-06: Given boundary inputs that violate `REQ_H_01`, When `PowerMeterAndRbfSwitch` evaluates invariant `REQ_H_01`, Then `PowerMeterAndRbfSwitch` rejects the invalid transition and routes a diagnostic via diagnostic port `escDriveOut`.
- [ ] AC-07: Given valid `PowerMeterAndRbfSwitch` state satisfying composite invariants (`REQ_H_02`; `REQ_UCA_01`; `REQ_UCA_02`; `REQ_SC_01` (`SC-01: Enforce ordered pre-flight interlock: ESD ground -> RBF #1 off -> prop fold rearward -> RBF #2 pull -> 49.0-50.0 V check -> lock both RBF and umbilical lids.`); `REQ_SC_02`; `REQ_SC_03` (`SC-03: Inhibit optional 2x 50.0 V RnD recovery igniter outputs on production Avenger V2.5 (rndRecoveryOptionInstalled == false).`); `REQ_SC_04`; `REQ_SAF_01`; `REQ_SAF_02`; `REQ_SAF_05` (`GAP-05 Mitigation: Anchor battery UI and health checks strictly to 12S2P 36.0-50.4 V (49.0-50.0 V pre-flight), rejecting legacy 23.9-25.0 V screenshots.`)), When `PowerMeterAndRbfSwitch` evaluates the remaining invariant conjunction, Then all declared invariants hold and verified state is committed.
- [ ] AC-08: Given input state that violates any invariant in (`REQ_H_02`; `REQ_UCA_01`; `REQ_UCA_02`; `REQ_SC_01` (`SC-01: Enforce ordered pre-flight interlock: ESD ground -> RBF #1 off -> prop fold rearward -> RBF #2 pull -> 49.0-50.0 V check -> lock both RBF and umbilical lids.`); `REQ_SC_02`; `REQ_SC_03` (`SC-03: Inhibit optional 2x 50.0 V RnD recovery igniter outputs on production Avenger V2.5 (rndRecoveryOptionInstalled == false).`); `REQ_SC_04`; `REQ_SAF_01`; `REQ_SAF_02`; `REQ_SAF_05` (`GAP-05 Mitigation: Anchor battery UI and health checks strictly to 12S2P 36.0-50.4 V (49.0-50.0 V pre-flight), rejecting legacy 23.9-25.0 V screenshots.`)), When `PowerMeterAndRbfSwitch` evaluates the composite guard, Then `PowerMeterAndRbfSwitch` rejects the invalid state transition and routes a diagnostic via diagnostic port `escDriveOut`.
- [ ] AC-09: Given nominal typed values for `rbfKeyId` (`String`), `busVoltageMinV` (`Real`), `busVoltageMaxV` (`Real`), `trunkHarnessLengthCm` (`Real`), `rbf2RemovedPowersOn` (`Boolean`), `pullRbf2BeforeRbf3` (`Boolean`) across `mainDcIn` (`in MainBatteryDcInPort`), `escDriveOut` (`inout EscDriveHarnessOutPort`), `trunkDcOut970cm` (`out TrunkDcPowerOutPort`), `can1Tap` (`inout Can1PowerTapPort`), When `PowerMeterAndRbfSwitch` executes structural interface processing, Then state and output ports conform to declared schema types.
- [ ] AC-10: Given malformed input frames across `rbfKeyId` (`String`), `busVoltageMinV` (`Real`), `busVoltageMaxV` (`Real`), `trunkHarnessLengthCm` (`Real`), `rbf2RemovedPowersOn` (`Boolean`), `pullRbf2BeforeRbf3` (`Boolean`) or `mainDcIn` (`in MainBatteryDcInPort`), `escDriveOut` (`inout EscDriveHarnessOutPort`), `trunkDcOut970cm` (`out TrunkDcPowerOutPort`), `can1Tap` (`inout Can1PowerTapPort`), When `PowerMeterAndRbfSwitch` boundary validation executes, Then `PowerMeterAndRbfSwitch` rejects the malformed input via diagnostic port `escDriveOut`.

## Source References
Formal component specifications and normative systems engineering requirements:
- System Architecture Model: `schema/model.sysml`
- Normative Systems Engineering Standard: ISO/IEC/IEEE 15288:2023 §6.4.3 Architecture Definition Process

Component behavior and interface definitions derive from `schema/model.sysml` pursuant to ISO/IEC/IEEE 15288.
