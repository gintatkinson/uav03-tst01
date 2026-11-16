| Attribute | Specification Detail |
| :--- | :--- |
| **Issue ID** | #4 |
| **Title** | Master Signal Flow Dictionary and Safety Invariants |
| **Type** | icd |
| **Interface Level** | Level 1C Logical Interface |
| **Generation Mode** | subagent |
| **Date** | 2026-11-16 |
| **Specification Source** | [../../schema/model.sysml](../../schema/model.sysml) |

# Level 1C: Master Signal Flow Dictionary & Safety Invariants

## 1. Executive Summary & Signal Flow Overview

This Level 1C Logical Interface Specification defines the exhaustive Master Signal Flow Dictionary and safety invariants for the **Avenger 5 V2.5 Uncrewed Aircraft System** (`Avenger5V25IntegratedSystem`). Every signal entry is derived deterministically from the compiled SysML v2 Abstract Syntax Tree in [../../.pipeline/schema.sysml](../../.pipeline/schema.sysml) and binds directly to the `46` boundary ports and `24` logical connections (`CONN-01` through `CONN-24`) declared in [../../docs/interfaces/ICD_01_SYSTEM_INTERFACE_MATRIX.md](../../docs/interfaces/ICD_01_SYSTEM_INTERFACE_MATRIX.md).

All signal attributes maintain strict logical abstraction: physical connector part numbers, pin assignments, wire gauges, hardware hex opcodes, transport frame byte offsets, and serial framing stop parameters are excluded. Operational exchanges `OpTx-01` through `OpTx-24` (OMG UAF v2.0 `OBL-03`) map 1:1 to `CONN-01` through `CONN-24`:
- `OpTx-01` (`CONN-01`), `OpTx-02` (`CONN-02`), `OpTx-03` (`CONN-03`), `OpTx-04` (`CONN-04`), `OpTx-05` (`CONN-05`), `OpTx-06` (`CONN-06`), `OpTx-07` (`CONN-07`), `OpTx-08` (`CONN-08`) govern unregulated `12S2P` power delivery (`36.0` to `50.4 V`, `49.0` to `50.0 V` pre-flight check, `200.0 A` fuse), pusher propulsion drive and telemetry, and EPS regulated rails (`8.0 V` servos, `12.0 V` radio, `14.0 V` ESAD with `0.0 V` brownout margin per `GAP-01`, plus sensor and gimbal rails).
- `OpTx-09` (`CONN-09`), `OpTx-10` (`CONN-10`), `OpTx-11` (`CONN-11`), `OpTx-12` (`CONN-12`), `OpTx-13` (`CONN-13`) enforce physical channel isolation (`CAN 1` power meter, EPS, and tail fins #1 through #4 vs `CAN 2` wing servos #5 through #8, dual `RM3100` mag/baro, and `CUAV SKYE2` pitot).
- `OpTx-14` (`CONN-14`), `OpTx-15` (`CONN-15`), `OpTx-16` (`CONN-16`), `OpTx-17` (`CONN-17`), `OpTx-18` (`CONN-18`), `OpTx-19` (`CONN-19`) connect `Cube orange+` software Simplex Run-Time Assurance (`0` standalone RTA boxes), `RPI CM5004032`, `Septentrio` RTK GNSS, `Trip6` / `Nighthawk2UZ`, and the onboard Ethernet and `DTC` radio switching fabric.
- `OpTx-20` (`CONN-20`), `OpTx-21` (`CONN-21`), `OpTx-22` (`CONN-22`), `OpTx-23` (`CONN-23`), `OpTx-24` (`CONN-24`) specify the `100 Hz` (`115200 bps` `CRC-16 XModem`) ESAD master link, Stage 2 `1000.0 Hz` dual-pulse hardware arm enable, `4.4` to `5.0 GHz` AES-256 FHSS RF datalink, `200.0 m` ground fiber/C2 link, zero-wire `PL-40` mechanical launch coupling, and rigid-body `SS1` launch acceleration pulse.

**Metrology Normalization & Fail-Safe Policy:**
- **Check-26 SI Metrology Conventions:** Pressures use normalized bar ratios `P / 100 kPa` in unit `ratio` (OEM `13.0` to `14.0 bar` launch pressure maps to `[13.0, 14.0] ratio`, `16.0 bar` aux max maps to `16.0 ratio`, and barometric pressure maps to `[0.45, 1.10] ratio`). Temperatures use Kelvin-normalized scalars `T / 1.0 K` in `Dimensionless` (`-20.0 degC` = `253.15`, `25.0 degC` = `298.15`, `50.0 degC` = `323.15`, `125.0 degC` = `398.15`). Rotation angle quantities use `deg`, acceleration uses `m/s^2`, umbilical resistance uses normalized `R / 1.0 Ohm` in `Dimensionless` alongside `mA` sense current, and counts/booleans/enums use `count` or `Dimensionless`.
- **Fail-Safe Defaults:** Cold initialization and link-loss defaults force zero voltage/throttle/HV outputs (`0.0`), `false` arming enables, `true` disarm/abort overrides (`RtaEsadDisarmRequest`, `AbortEngagingOverride`, `EsadRailBrownoutAlert`), and `RTL` / `LostLinkRtb` / `SafePowerOff` states.

## 2. Master Signal Flow Dictionary Table
| Signal ID | Signal Name | Source Port | Dest Port | Data Type | SI Units | Valid Range | Update Rate | Safe Default Value | Schema Citation |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `SIG-BAT-PWRMTR-001` | MainBatteryDcBusVoltage | `PORT-BAT-PROTECTED_DC_OUT` | `PORT-PWRMTR-MAIN_DC_IN` | Float32 | V | [0.0, 50.4] | 50 Hz | 0.0 | `schema/model.sysml#L267` |
| `SIG-BAT-PWRMTR-002` | MainBatteryDcBusCurrent | `PORT-BAT-PROTECTED_DC_OUT` | `PORT-PWRMTR-MAIN_DC_IN` | Float32 | A | [0.0, 200.0] | 50 Hz | 0.0 | `schema/model.sysml#L273` |
| `SIG-PWRMTR-PROP-001` | EscMainDcBusVoltage | `PORT-PWRMTR-ESC_DRIVE_OUT` | `PORT-PROP-ESC_DRIVE_IN` | Float32 | V | [0.0, 50.4] | 50 Hz | 0.0 | `schema/model.sysml#L267` |
| `SIG-PWRMTR-PROP-002` | EscThrottleNormalizedCmd | `PORT-PWRMTR-ESC_DRIVE_OUT` | `PORT-PROP-ESC_DRIVE_IN` | Float32 | ratio | [0.0, 1.0] | 50 Hz | 0.0 | `schema/model.sysml#L280` |
| `SIG-PROP-PWRMTR-001` | EscMotorFrequency | `PORT-PROP-ESC_DRIVE_IN` | `PORT-PWRMTR-ESC_DRIVE_OUT` | Float32 | Hz | [0.0, 500.0] | 50 Hz | 0.0 | `schema/model.sysml#L286` |
| `SIG-PROP-PWRMTR-002` | EscTemperatureNormalized | `PORT-PROP-ESC_DRIVE_IN` | `PORT-PWRMTR-ESC_DRIVE_OUT` | Float32 | Dimensionless | [253.15, 398.15] | 10 Hz | 298.15 | `schema/model.sysml#L287` |
| `SIG-PROP-PWRMTR-003` | PusherMotorTemperatureNorm | `PORT-PROP-ESC_DRIVE_IN` | `PORT-PWRMTR-ESC_DRIVE_OUT` | Float32 | Dimensionless | [253.15, 398.15] | 10 Hz | 298.15 | `schema/model.sysml#L288` |
| `SIG-PROP-PWRMTR-004` | EscBusVoltageFeedback | `PORT-PROP-ESC_DRIVE_IN` | `PORT-PWRMTR-ESC_DRIVE_OUT` | Float32 | V | [0.0, 50.4] | 50 Hz | 0.0 | `schema/model.sysml#L289` |
| `SIG-PROP-PWRMTR-005` | EscBusCurrentFeedback | `PORT-PROP-ESC_DRIVE_IN` | `PORT-PWRMTR-ESC_DRIVE_OUT` | Float32 | A | [0.0, 200.0] | 50 Hz | 0.0 | `schema/model.sysml#L290` |
| `SIG-PWRMTR-EPS-001` | EpsTrunkDcVoltage | `PORT-PWRMTR-TRUNK_DC_OUT` | `PORT-EPS-TRUNK_DC_IN` | Float32 | V | [0.0, 50.4] | 50 Hz | 0.0 | `schema/model.sysml#L372` |
| `SIG-EPS-ACT-001` | ServoRegulatedRailVoltage | `PORT-EPS-SERVO_8V_OUT` | `PORT-ACT-SERVO_8V_IN` | Float32 | V | [0.0, 8.5] | 50 Hz | 0.0 | `schema/model.sysml#L415` |
| `SIG-EPS-COMMS-001` | RadioRegulatedRailVoltage | `PORT-EPS-RADIO_12V_OUT` | `PORT-COMMS-RADIO_12V_IN` | Float32 | V | [0.0, 17.0] | 50 Hz | 0.0 | `schema/model.sysml#L416` |
| `SIG-EPS-ESAD-001` | EsadRegulatedRailVoltage | `PORT-EPS-ESAD_14V_OUT` | `PORT-ESAD-ESAD_14V_IN` | Float32 | V | [0.0, 32.0] | 100 Hz | 0.0 | `schema/model.sysml#L426` |
| `SIG-EPS-NAV-001` | NavSensorRailVoltage | `PORT-EPS-SENSOR_PWR_OUT` | `PORT-NAV-SENSOR_PWR_IN` | Float32 | V | [0.0, 14.0] | 50 Hz | 0.0 | `schema/model.sysml#L427` |
| `SIG-EPS-EOIR-001` | GimbalPayloadRailVoltage | `PORT-EPS-GIMBAL_PWR_OUT` | `PORT-EOIR-GIMBAL_PWR_IN` | Float32 | V | [0.0, 14.0] | 50 Hz | 0.0 | `schema/model.sysml#L428` |
| `SIG-FC-PWRMTR-001` | PusherThrottleSetpoint | `PORT-FC-CAN1_MASTER` | `PORT-PWRMTR-CAN1_TAP` | Float32 | ratio | [0.0, 1.0] | 50 Hz | 0.0 | `schema/model.sysml#L166` |
| `SIG-FC-PWRMTR-002` | PropulsionArmStateCmd | `PORT-FC-CAN1_MASTER` | `PORT-PWRMTR-CAN1_TAP` | Bool | Dimensionless | [false, true] | 50 Hz | false | `schema/model.sysml#L166` |
| `SIG-PWRMTR-FC-001` | MainBusVoltageTelemetry | `PORT-PWRMTR-CAN1_TAP` | `PORT-FC-CAN1_MASTER` | Float32 | V | [0.0, 50.4] | 50 Hz | 0.0 | `schema/model.sysml#L365` |
| `SIG-PWRMTR-FC-002` | MainBusCurrentTelemetry | `PORT-PWRMTR-CAN1_TAP` | `PORT-FC-CAN1_MASTER` | Float32 | A | [0.0, 200.0] | 50 Hz | 0.0 | `schema/model.sysml#L354` |
| `SIG-PWRMTR-FC-003` | BingoEnergyReserveRatio | `PORT-PWRMTR-CAN1_TAP` | `PORT-FC-CAN1_MASTER` | Float32 | ratio | [0.0, 1.0] | 10 Hz | 0.0 | `schema/model.sysml#L177` |
| `SIG-PWRMTR-FC-004` | RemainingEnduranceTime | `PORT-PWRMTR-CAN1_TAP` | `PORT-FC-CAN1_MASTER` | Float32 | s | [0.0, 5400.0] | 1 Hz | 0.0 | `schema/model.sysml#L170` |
| `SIG-PWRMTR-FC-005` | BridgedEscMotorFrequency | `PORT-PWRMTR-CAN1_TAP` | `PORT-FC-CAN1_MASTER` | Float32 | Hz | [0.0, 500.0] | 20 Hz | 0.0 | `schema/model.sysml#L286` |
| `SIG-PWRMTR-FC-006` | BridgedEscTemperatureNorm | `PORT-PWRMTR-CAN1_TAP` | `PORT-FC-CAN1_MASTER` | Float32 | Dimensionless | [253.15, 398.15] | 10 Hz | 298.15 | `schema/model.sysml#L287` |
| `SIG-PWRMTR-FC-007` | BridgedMotorTemperatureNorm | `PORT-PWRMTR-CAN1_TAP` | `PORT-FC-CAN1_MASTER` | Float32 | Dimensionless | [253.15, 398.15] | 10 Hz | 298.15 | `schema/model.sysml#L288` |
| `SIG-FC-EPS-001` | EsadPowerOffCommand | `PORT-FC-CAN1_MASTER` | `PORT-EPS-CAN1_TAP` | Bool | Dimensionless | [false, true] | Aperiodic [1, 10] ms | false | `schema/model.sysml#L168` |
| `SIG-FC-EPS-002` | EpsLoadSwitchEnableMask | `PORT-FC-CAN1_MASTER` | `PORT-EPS-CAN1_TAP` | UInt32 | Dimensionless | [0, 31] | 10 Hz | 0 | `schema/model.sysml#L414` |
| `SIG-EPS-FC-001` | EpsEsad14VRailTelemetry | `PORT-EPS-CAN1_TAP` | `PORT-FC-CAN1_MASTER` | Float32 | V | [0.0, 32.0] | 50 Hz | 0.0 | `schema/model.sysml#L185` |
| `SIG-EPS-FC-002` | EsadRailBrownoutAlert | `PORT-EPS-CAN1_TAP` | `PORT-FC-CAN1_MASTER` | Bool | Dimensionless | [false, true] | 50 Hz | true | `schema/model.sysml#L168` |
| `SIG-EPS-FC-003` | RndRecoveryRailInstalled | `PORT-EPS-CAN1_TAP` | `PORT-FC-CAN1_MASTER` | Bool | Dimensionless | [false, true] | 1 Hz | false | `schema/model.sysml#L419` |
| `SIG-FC-ACT-001` | TailRuddervatorDeflectionCmd | `PORT-FC-CAN1_MASTER` | `PORT-ACT-CAN1_TAIL_FINS` | Float32 | deg | [-30.0, 30.0] | 100 Hz | 0.0 | `schema/model.sysml#L564` |
| `SIG-ACT-FC-001` | TailRuddervatorAngleFeedback | `PORT-ACT-CAN1_TAIL_FINS` | `PORT-FC-CAN1_MASTER` | Float32 | deg | [-30.0, 30.0] | 50 Hz | 0.0 | `schema/model.sysml#L564` |
| `SIG-ACT-FC-002` | TailServoOnlineMask | `PORT-ACT-CAN1_TAIL_FINS` | `PORT-FC-CAN1_MASTER` | UInt32 | Dimensionless | [0, 15] | 10 Hz | 0 | `schema/model.sysml#L660` |
| `SIG-FC-ACT-002` | WingRollServoDeflectionCmd | `PORT-FC-CAN2_MASTER` | `PORT-ACT-CAN2_SPLITTER_IN` | Float32 | deg | [-30.0, 30.0] | 100 Hz | 0.0 | `schema/model.sysml#L564` |
| `SIG-ACT-FC-003` | WingRollServoAngleFeedback | `PORT-ACT-CAN2_SPLITTER_IN` | `PORT-FC-CAN2_MASTER` | Float32 | deg | [-30.0, 30.0] | 50 Hz | 0.0 | `schema/model.sysml#L564` |
| `SIG-ACT-FC-004` | WingServoOnlineMask | `PORT-ACT-CAN2_SPLITTER_IN` | `PORT-FC-CAN2_MASTER` | UInt32 | Dimensionless | [0, 15] | 10 Hz | 0 | `schema/model.sysml#L661` |
| `SIG-ACT-NAV-001` | Can2SensorNodePollSync | `PORT-ACT-CAN2_DAISY_OUT` | `PORT-NAV-CAN2_DAISY_IN` | UInt32 | count | [0, 65535] | 50 Hz | 0 | `schema/model.sysml#L574` |
| `SIG-ACT-NAV-002` | PitotHeaterEnableCmd | `PORT-ACT-CAN2_DAISY_OUT` | `PORT-NAV-CAN2_DAISY_IN` | Bool | Dimensionless | [false, true] | 1 Hz | false | `schema/model.sysml#L649` |
| `SIG-NAV-ACT-001` | PitotIndicatedAirspeed | `PORT-NAV-CAN2_DAISY_IN` | `PORT-ACT-CAN2_DAISY_OUT` | Float32 | m/s | [0.0, 80.0] | 50 Hz | 0.0 | `schema/model.sysml#L461` |
| `SIG-NAV-ACT-002` | DualMagHeadingDeg | `PORT-NAV-CAN2_DAISY_IN` | `PORT-ACT-CAN2_DAISY_OUT` | Float32 | deg | [0.0, 360.0] | 50 Hz | 0.0 | `schema/model.sysml#L647` |
| `SIG-NAV-ACT-003` | DualBaroPressureRatio | `PORT-NAV-CAN2_DAISY_IN` | `PORT-ACT-CAN2_DAISY_OUT` | Float32 | ratio | [0.45, 1.10] | 25 Hz | 1.01325 | `schema/model.sysml#L647` |
| `SIG-NAV-ACT-004` | OnlineMagnetometerCount | `PORT-NAV-CAN2_DAISY_IN` | `PORT-ACT-CAN2_DAISY_OUT` | UInt32 | count | [0, 2] | 10 Hz | 0 | `schema/model.sysml#L461` |
| `SIG-FC-RPI-001` | RtaAirspeedState | `PORT-FC-SERIAL_RPI` | `PORT-RPI-SERIAL_FC` | Float32 | m/s | [0.0, 80.0] | 50 Hz | 0.0 | `schema/model.sysml#L459` |
| `SIG-FC-RPI-002` | RtaDiveAngleState | `PORT-FC-SERIAL_RPI` | `PORT-RPI-SERIAL_FC` | Float32 | deg | [-45.0, 45.0] | 50 Hz | 0.0 | `schema/model.sysml#L459` |
| `SIG-FC-RPI-003` | RtaEsadDisarmRequest | `PORT-FC-SERIAL_RPI` | `PORT-RPI-SERIAL_FC` | Bool | Dimensionless | [false, true] | 100 Hz | true | `schema/model.sysml#L459` |
| `SIG-FC-RPI-004` | GcsLinkLossDuration | `PORT-FC-SERIAL_RPI` | `PORT-RPI-SERIAL_FC` | Float32 | s | [0.0, 600.0] | 10 Hz | 0.0 | `schema/model.sysml#L459` |
| `SIG-FC-RPI-005` | AutopilotLifecycleStateId | `PORT-FC-SERIAL_RPI` | `PORT-RPI-SERIAL_FC` | Enum | Dimensionless | {PreFlightCheck, CatapultLaunch, CruiseAndLoiter, TargetTrackAndDive, EmergencyAbortOrRtb, SafePostFlightShutdown} | 10 Hz | PreFlightCheck | `schema/model.sysml#L243` |
| `SIG-RPI-FC-001` | EsadBusHealthFlag | `PORT-RPI-SERIAL_FC` | `PORT-FC-SERIAL_RPI` | Bool | Dimensionless | [false, true] | 100 Hz | false | `schema/model.sysml#L459` |
| `SIG-RPI-FC-002` | CompanionMissionCommand | `PORT-RPI-SERIAL_FC` | `PORT-FC-SERIAL_RPI` | Enum | Dimensionless | {LOITER, GUIDED, RTL, ABORT_ENGAGING, DISABLE_GNSS} | 10 Hz | RTL | `schema/model.sysml#L603` |
| `SIG-FC-NAV-001` | DisableGnssCommand | `PORT-FC-SERIAL_GNSS` | `PORT-NAV-SERIAL_GNSS` | Bool | Dimensionless | [false, true] | Aperiodic [10, 100] ms | false | `schema/model.sysml#L463` |
| `SIG-NAV-FC-001` | GnssLatitudeDeg | `PORT-NAV-SERIAL_GNSS` | `PORT-FC-SERIAL_GNSS` | Float64 | deg | [-90.0, 90.0] | 10 Hz | 0.0 | `schema/model.sysml#L645` |
| `SIG-NAV-FC-002` | GnssLongitudeDeg | `PORT-NAV-SERIAL_GNSS` | `PORT-FC-SERIAL_GNSS` | Float64 | deg | [-180.0, 180.0] | 10 Hz | 0.0 | `schema/model.sysml#L645` |
| `SIG-NAV-FC-003` | GnssAltitudeMsl | `PORT-NAV-SERIAL_GNSS` | `PORT-FC-SERIAL_GNSS` | Float32 | m | [0.0, 5000.0] | 10 Hz | 0.0 | `schema/model.sysml#L402` |
| `SIG-NAV-FC-004` | GnssGroundSpeed | `PORT-NAV-SERIAL_GNSS` | `PORT-FC-SERIAL_GNSS` | Float32 | m/s | [0.0, 80.0] | 10 Hz | 0.0 | `schema/model.sysml#L399` |
| `SIG-NAV-FC-005` | GnssRtkFixValid | `PORT-NAV-SERIAL_GNSS` | `PORT-FC-SERIAL_GNSS` | Bool | Dimensionless | [false, true] | 10 Hz | false | `schema/model.sysml#L562` |
| `SIG-FC-EOIR-001` | InsAirspeedForSeeker | `PORT-FC-SERIAL_TRIP6` | `PORT-EOIR-SERIAL_FC` | Float32 | m/s | [0.0, 80.0] | 50 Hz | 0.0 | `schema/model.sysml#L705` |
| `SIG-FC-EOIR-002` | AbortEngagingOverride | `PORT-FC-SERIAL_TRIP6` | `PORT-EOIR-SERIAL_FC` | Bool | Dimensionless | [false, true] | 50 Hz | true | `schema/model.sysml#L705` |
| `SIG-EOIR-FC-001` | TargetElevationCueDeg | `PORT-EOIR-SERIAL_FC` | `PORT-FC-SERIAL_TRIP6` | Float32 | deg | [-45.0, 135.0] | 50 Hz | 0.0 | `schema/model.sysml#L937` |
| `SIG-EOIR-FC-002` | TargetAzimuthCueDeg | `PORT-EOIR-SERIAL_FC` | `PORT-FC-SERIAL_TRIP6` | Float32 | deg | [-165.0, 165.0] | 50 Hz | 0.0 | `schema/model.sysml#L939` |
| `SIG-EOIR-FC-003` | AutoTrackerLockHoldDuration | `PORT-EOIR-SERIAL_FC` | `PORT-FC-SERIAL_TRIP6` | Float32 | s | [0.0, 5.0] | 50 Hz | 0.0 | `schema/model.sysml#L942` |
| `SIG-EOIR-FC-004` | AutoTrackerTargetLocked | `PORT-EOIR-SERIAL_FC` | `PORT-FC-SERIAL_TRIP6` | Bool | Dimensionless | [false, true] | 50 Hz | false | `schema/model.sysml#L705` |
| `SIG-FC-COMMS-001` | AutopilotC2TelemetrySeq | `PORT-FC-SERIAL_RADIO_USB` | `PORT-COMMS-FC_SERIAL_USB` | UInt32 | count | [0, 65535] | 20 Hz | 0 | `schema/model.sysml#L552` |
| `SIG-FC-COMMS-002` | RtaMonitorStatusMode | `PORT-FC-SERIAL_RADIO_USB` | `PORT-COMMS-FC_SERIAL_USB` | Enum | Dimensionless | {NominalPrimary, AirspeedClamped, EsadFaultFallback, LostLinkRtb} | 10 Hz | LostLinkRtb | `schema/model.sysml#L521` |
| `SIG-COMMS-FC-001` | GcsWaypointAltitudeCmd | `PORT-COMMS-FC_SERIAL_USB` | `PORT-FC-SERIAL_RADIO_USB` | Float32 | m | [50.0, 3000.0] | Aperiodic [10, 1000] ms | 300.0 | `schema/model.sysml#L1025` |
| `SIG-COMMS-FC-002` | GcsLoiterRadiusCmd | `PORT-COMMS-FC_SERIAL_USB` | `PORT-FC-SERIAL_RADIO_USB` | Float32 | m | [300.0, 3000.0] | Aperiodic [10, 1000] ms | 300.0 | `schema/model.sysml#L1025` |
| `SIG-COMMS-FC-003` | UmbilicalServiceLidLocked | `PORT-COMMS-FC_SERIAL_USB` | `PORT-FC-SERIAL_RADIO_USB` | Bool | Dimensionless | [false, true] | 1 Hz | true | `schema/model.sysml#L558` |
| `SIG-RPI-COMMS-001` | EsadSupervisorStateTelemetry | `PORT-RPI-ETH_SWITCH` | `PORT-COMMS-ETH_RPI` | Enum | Dimensionless | {SafePowerOff, BootAndPbit, SafeRbfInstalled, SafeRbfRemoved, ArmStage1TimerWait, ArmStage2Armed, HvChargedReady, DetonatedOrAborted, FaultLockout} | 20 Hz | SafePowerOff | `schema/model.sysml#L788` |
| `SIG-RPI-COMMS-002` | EsadHvCapacitorTelemetry | `PORT-RPI-ETH_SWITCH` | `PORT-COMMS-ETH_RPI` | Float32 | V | [0.0, 1800.0] | 20 Hz | 0.0 | `schema/model.sysml#L964` |
| `SIG-COMMS-RPI-001` | SwarmC2EsadCommandState | `PORT-COMMS-ETH_RPI` | `PORT-RPI-ETH_SWITCH` | Enum | Dimensionless | {SAFE, ARM_ENABLE, ABORT, SELF_DESTRUCT_HOLD, POWER_OFF_ESAD} | Aperiodic [10, 100] ms | SAFE | `schema/model.sysml#L702` |
| `SIG-COMMS-RPI-002` | EsadSelfDestructHoldTimer | `PORT-COMMS-ETH_RPI` | `PORT-RPI-ETH_SWITCH` | Float32 | s | [0.0, 10.0] | 20 Hz | 0.0 | `schema/model.sysml#L1205` |
| `SIG-EOIR-COMMS-001` | EoIrVideoFrameWidth | `PORT-EOIR-ETH_SWITCH` | `PORT-COMMS-ETH_TRIP6` | UInt32 | count | [1, 1280] | 30 Hz | 1280 | `schema/model.sysml#L854` |
| `SIG-EOIR-COMMS-002` | EoIrVideoFrameHeight | `PORT-EOIR-ETH_SWITCH` | `PORT-COMMS-ETH_TRIP6` | UInt32 | count | [1, 720] | 30 Hz | 720 | `schema/model.sysml#L855` |
| `SIG-EOIR-COMMS-003` | EoIrOpticalZoomRatio | `PORT-EOIR-ETH_SWITCH` | `PORT-COMMS-ETH_TRIP6` | Float32 | ratio | [1.0, 40.0] | 10 Hz | 1.0 | `schema/model.sysml#L856` |
| `SIG-COMMS-EOIR-001` | GimbalZoomSetpointRatio | `PORT-COMMS-ETH_TRIP6` | `PORT-EOIR-ETH_SWITCH` | Float32 | ratio | [1.0, 40.0] | 20 Hz | 1.0 | `schema/model.sysml#L856` |
| `SIG-COMMS-EOIR-002` | RebootGimbalCommand | `PORT-COMMS-ETH_TRIP6` | `PORT-EOIR-ETH_SWITCH` | Bool | Dimensionless | [false, true] | Aperiodic [10, 500] ms | false | `schema/model.sysml#L707` |
| `SIG-RPI-ESAD-001` | EsadOcPollCommandType | `PORT-RPI-ESAD_OC_CTRL` | `PORT-ESAD-OC_CTRL_IN` | Enum | Dimensionless | {EXCHANGE, PBIT, HIGHVOLTAGE, VERSION} | 100 Hz | PBIT | `schema/model.sysml#L858` |
| `SIG-RPI-ESAD-002` | EsadOcStatusControlWord | `PORT-RPI-ESAD_OC_CTRL` | `PORT-ESAD-OC_CTRL_IN` | UInt32 | Dimensionless | [0, 63] | 100 Hz | 0 | `schema/model.sysml#L703` |
| `SIG-RPI-ESAD-003` | EsadDscIn1ArmPulseFreq | `PORT-RPI-ESAD_OC_CTRL` | `PORT-ESAD-OC_CTRL_IN` | Float32 | Hz | [0.0, 1000.0] | Aperiodic [1, 10] ms | 0.0 | `schema/model.sysml#L866` |
| `SIG-RPI-ESAD-004` | EsadDscIn1ArmPulseCount | `PORT-RPI-ESAD_OC_CTRL` | `PORT-ESAD-OC_CTRL_IN` | UInt32 | count | [0, 2] | Aperiodic [1, 10] ms | 0 | `schema/model.sysml#L867` |
| `SIG-RPI-ESAD-005` | EsadDscIn1SignalVoltage | `PORT-RPI-ESAD_OC_CTRL` | `PORT-ESAD-OC_CTRL_IN` | Float32 | V | [0.0, 3.3] | Aperiodic [1, 10] ms | 0.0 | `schema/model.sysml#L868` |
| `SIG-ESAD-RPI-001` | EsadArmStateReport | `PORT-ESAD-OC_CTRL_IN` | `PORT-RPI-ESAD_OC_CTRL` | UInt32 | Dimensionless | [0, 5] | 100 Hz | 0 | `schema/model.sysml#L788` |
| `SIG-ESAD-RPI-002` | EsadFaultStatesFlags | `PORT-ESAD-OC_CTRL_IN` | `PORT-RPI-ESAD_OC_CTRL` | UInt32 | Dimensionless | [0, 511] | 100 Hz | 0 | `schema/model.sysml#L764` |
| `SIG-ESAD-RPI-003` | EsadSafeDistanceExceedFlag | `PORT-ESAD-OC_CTRL_IN` | `PORT-RPI-ESAD_OC_CTRL` | Bool | Dimensionless | [false, true] | 100 Hz | false | `schema/model.sysml#L722` |
| `SIG-ESAD-RPI-004` | EsadFlightTimerElapsed | `PORT-ESAD-OC_CTRL_IN` | `PORT-RPI-ESAD_OC_CTRL` | UInt32 | s | [0, 65535] | 100 Hz | 0 | `schema/model.sysml#L966` |
| `SIG-ESAD-RPI-005` | EsadInternalHvMeasured | `PORT-ESAD-OC_CTRL_IN` | `PORT-RPI-ESAD_OC_CTRL` | Float32 | V | [0.0, 1800.0] | 100 Hz | 0.0 | `schema/model.sysml#L964` |
| `SIG-ESAD-RPI-006` | EsadUmbLoopSenseCurrent | `PORT-ESAD-OC_CTRL_IN` | `PORT-RPI-ESAD_OC_CTRL` | Float32 | mA | [0.0, 20.0] | 10 Hz | 0.0 | `schema/model.sysml#L960` |
| `SIG-ESAD-RPI-007` | EsadUmbResistanceNormalized | `PORT-ESAD-OC_CTRL_IN` | `PORT-RPI-ESAD_OC_CTRL` | Float32 | Dimensionless | [0.0, 0.5] | 10 Hz | 0.0 | `schema/model.sysml#L959` |
| `SIG-COMMS-GRF-001` | AirToGroundRfCarrierFreq | `PORT-COMMS-RF_DATALINK_OUT` | `PORT-GRF-RF_AIR_PORT` | Float32 | GHz | [4.4, 5.0] | 50 Hz | 4.51 | `schema/model.sysml#L847` |
| `SIG-COMMS-GRF-002` | AirRadioTotalTxPower | `PORT-COMMS-RF_DATALINK_OUT` | `PORT-GRF-RF_AIR_PORT` | Float32 | W | [0.0, 2.0] | 10 Hz | 0.0 | `schema/model.sysml#L849` |
| `SIG-COMMS-GRF-003` | AirDownlinkTelemetryRlos | `PORT-COMMS-RF_DATALINK_OUT` | `PORT-GRF-RF_AIR_PORT` | Float32 | km | [0.0, 90.0] | 10 Hz | 0.0 | `schema/model.sysml#L922` |
| `SIG-GRF-COMMS-001` | GroundToAirRfCarrierFreq | `PORT-GRF-RF_AIR_PORT` | `PORT-COMMS-RF_DATALINK_OUT` | Float32 | GHz | [4.4, 5.0] | 50 Hz | 4.51 | `schema/model.sysml#L847` |
| `SIG-GRF-COMMS-002` | GroundRadioTxPower | `PORT-GRF-RF_AIR_PORT` | `PORT-COMMS-RF_DATALINK_OUT` | Float32 | W | [0.0, 2.0] | 10 Hz | 0.0 | `schema/model.sysml#L1211` |
| `SIG-GRF-COMMS-003` | GroundMarsDirAntennaGain | `PORT-GRF-RF_AIR_PORT` | `PORT-COMMS-RF_DATALINK_OUT` | Float32 | dBi | [0.0, 23.0] | 1 Hz | 0.0 | `schema/model.sysml#L1212` |
| `SIG-GCS-GRF-001` | RotatorAzimuthStepCmd | `PORT-GCS-STATION_PORT` | `PORT-GRF-GCS_STATION_PORT` | Float32 | deg | [-180.0, 180.0] | 10 Hz | 0.0 | `schema/model.sysml#L1115` |
| `SIG-GCS-GRF-002` | OperatorAuthPasswordLen | `PORT-GCS-STATION_PORT` | `PORT-GRF-GCS_STATION_PORT` | UInt32 | count | [0, 64] | Aperiodic [10, 1000] ms | 0 | `schema/model.sysml#L1197` |
| `SIG-GCS-GRF-003` | GcsTargetExportFormat5wCff | `PORT-GCS-STATION_PORT` | `PORT-GRF-GCS_STATION_PORT` | Enum | Dimensionless | {NONE, ATAK, SITAWARE_HQ, DELTA} | Aperiodic [10, 1000] ms | NONE | `schema/model.sysml#L1206` |
| `SIG-GRF-GCS-001` | GroundRadioSeparationDist | `PORT-GRF-GCS_STATION_PORT` | `PORT-GCS-STATION_PORT` | Float32 | m | [0.0, 200.0] | 1 Hz | 0.0 | `schema/model.sysml#L1216` |
| `SIG-GRF-GCS-002` | RotatorAzimuthFeedback | `PORT-GRF-GCS_STATION_PORT` | `PORT-GCS-STATION_PORT` | Float32 | deg | [-180.0, 180.0] | 10 Hz | 0.0 | `schema/model.sysml#L1113` |
| `SIG-GRF-GCS-003` | GcsTelemetryDetectAge | `PORT-GRF-GCS_STATION_PORT` | `PORT-GCS-STATION_PORT` | Float32 | min | [0.0, 2.0] | 1 Hz | 2.0 | `schema/model.sysml#L1199` |
| `SIG-PL40-PROP-001` | Pl40RailExitVelocity | `PORT-PL40-MECH_LAUNCH_OUT` | `PORT-PROP-MECH_LAUNCH_IN` | Float32 | m/s | [0.0, 25.0] | Aperiodic [0, 10] ms | 0.0 | `schema/model.sysml#L294` |
| `SIG-PL40-PROP-002` | Pl40PneumaticPressureRatio | `PORT-PL40-MECH_LAUNCH_OUT` | `PORT-PROP-MECH_LAUNCH_IN` | Float32 | ratio | [0.0, 16.0] | 10 Hz | 0.0 | `schema/model.sysml#L1177` |
| `SIG-PL40-PROP-003` | Pl40RailElevationAngle | `PORT-PL40-MECH_LAUNCH_OUT` | `PORT-PROP-MECH_LAUNCH_IN` | Float32 | deg | [0.0, 12.0] | 1 Hz | 0.0 | `schema/model.sysml#L296` |
| `SIG-PL40-PROP-004` | Pl40ElectricalWireCount | `PORT-PL40-MECH_LAUNCH_OUT` | `PORT-PROP-MECH_LAUNCH_IN` | UInt32 | count | [0, 0] | 1 Hz | 0 | `schema/model.sysml#L297` |
| `SIG-PROP-ESAD-001` | InertialSs1LaunchAccel | `PORT-PROP-INERTIAL_SS1_OUT` | `PORT-ESAD-INERTIAL_SS1_IN` | Float32 | m/s^2 | [0.0, 200.0] | Aperiodic [0, 10] ms | 0.0 | `schema/model.sysml#L299` |
| `SIG-PROP-ESAD-002` | InertialSs1WireCount | `PORT-PROP-INERTIAL_SS1_OUT` | `PORT-ESAD-INERTIAL_SS1_IN` | UInt32 | count | [0, 0] | 1 Hz | 0 | `schema/model.sysml#L302` |

## 3. Mathematical Formulations & Safety Invariants

### 3.1 Deterministic Timing, Latency & Watchdog Invariants (`GAP-04`, `GAP-WCET`)

$$
\begin{aligned}
\tau_{\mathrm{transport}} &\le \tau_{\mathrm{latency,max}} \\
\tau_{\mathrm{reply,ESAD}} &\le \tau_{\mathrm{reply,max}} < \tau_{\mathrm{timeout,ESAD}} = \Delta t_{\mathrm{poll}} \\
f_{\mathrm{poll}} &= \frac{1}{\Delta t_{\mathrm{poll}}} \\
\tau_{\mathrm{GCS,loss}} &\ge \tau_{\mathrm{GCS,failsafe}} \implies \mathrm{RTL} \land \mathrm{ESAD}_{\mathrm{disarm}}
\end{aligned}
$$

- Parameter Definitions & Engineering Units:
- $\tau_{\mathrm{transport}}$: End-to-end logical signal transport delay from source port to destination port (ms).
- $\tau_{\mathrm{latency,max}}$: Maximum allowable transport latency bound (`0.0 ms` for passive DC conduction and rigid-body mechanical launch/inertial couplings; `10.0 ms` for `CONN-20` ESAD RS-485 cycle; `UNPRINTED` digital WCET targets tracked for bench sign-off under `REQ_SAF_08`).
- $\tau_{\mathrm{reply,ESAD}}$: Artron ESAD slave reply latency bound (`<= 5.0 ms` on `115200 bps` half-duplex RS-485 with `CRC-16 XModem`).
- $\tau_{\mathrm{timeout,ESAD}}$: Incomplete RS-485 packet watchdog timeout (`<= 10.0 ms`), matching polling period $\Delta t_{\mathrm{poll}}$ = `0.01 s` at $f_{\mathrm{poll}}$ = `100 Hz` (`EsadRs485ProtocolTimingConstraint`).
- $\tau_{\mathrm{GCS,loss}}$ and $\tau_{\mathrm{GCS,failsafe}}$: Sustained C2 link loss duration (`>= 105.0 s` baseline) triggering `EmergencyLostLinkRtlHolding` (`RTL` plus `Disarm ESAD On GCS Timeout`); pre-flight telemetry detect window is `2.0 min`.

### 3.2 Power Integrity, Brownout Margin (`GAP-01`) & Flight Envelope Bounds (`GAP-02`, `GAP-03`)

$$
\begin{aligned}
V_{\mathrm{pre,min}} &\le V_{\mathrm{bat,pre}} \le V_{\mathrm{pre,max}} \\
V_{\mathrm{bus,min}} &\le V_{\mathrm{bus}} \le V_{\mathrm{bus,max}} \\
R_{\mathrm{bingo}} &= \frac{t_{\mathrm{rem}}}{t_{\mathrm{endurance}}} \ge R_{\mathrm{bingo,min}} \\
\Delta V_{\mathrm{brownout}} &= V_{\mathrm{eps,esad}} - V_{\mathrm{esad,min}} \\
v_{\mathrm{stall}} &\le v_{\mathrm{air}} \le v_{\mathrm{VNE}}, \quad v_{\mathrm{engage}} \le v_{\mathrm{cap,dive}}, \quad v_{\mathrm{exit}} \le v_{\mathrm{rail,max}} \\
\Pi_{\mathrm{press}} &= \frac{P}{P_{\mathrm{ref}}}, \quad \Theta_{\mathrm{norm}} = \frac{T}{T_{\mathrm{ref}}}
\end{aligned}
$$

- Parameter Definitions & Engineering Units:
- $V_{\mathrm{bat,pre}}$: Pre-flight `12S2P` pack voltage (`[49.0, 50.0] V`, rejecting legacy `24.0` to `25.0 V` values per `REQ_SAF_05` and `GAP-05`), bounded within operating envelope `[36.0, 50.4] V` for $V_{\mathrm{bus}}$ and protected by `200.0 A` fuse (`MainBatteryPreFlightVoltageConstraint`).
- $R_{\mathrm{bingo}}$: Statutory minimum energy reserve ratio (`>= 0.20`, equal to `1080.0 s` of `5400.0 s` endurance, `BingoEnergyReserveConstraint`).
- $\Delta V_{\mathrm{brownout}}$: EPS-to-ESAD voltage margin (`14.0 V - 14.0 V = 0.0 V` per `GAP-01`), bounded by `[14.0, 32.0] V` on $V_{\mathrm{eps,esad}}$ (`EpsEsadZeroBrownoutMarginConstraint`, `EsadInputVoltageAndBrownoutConstraint`).
- $v_{\mathrm{air}}$, $v_{\mathrm{engage}}$, $v_{\mathrm{exit}}$: Aerodynamic speed bounds (`v_stall = 24.0 m/s` V2.5 / `26.0 m/s` V1, `v_cap,dive = 55.0 m/s` terminal engagement cap, `v_VNE = 80.0 m/s` structural dive limit, `v_rail,max = 25.0 m/s` with `~23.0 m/s` exit at `17.0 kg` MTOW, `FlightEnvelopeSpeedConstraint`, `Pl40MassAndExitVelocityConstraint`).
- $\Pi_{\mathrm{press}}$ and $\Theta_{\mathrm{norm}}$: Check-26 normalized dimensionless ratios where $P_{\mathrm{ref}}$ = `100 kPa` (`13.0` to `14.0` launch `ratio`, `16.0` aux `ratio`) and $T_{\mathrm{ref}}$ = `1.0 K` (`253.15` to `323.15` ambient operating scalar).

## 4. Safety-Critical Signal Allocation & STPA Hazard Mapping

| Signal Ref | Safety Criticality | Hazard Ref | Safety Constraint | Failsafe Action |
| :--- | :--- | :--- | :--- | :--- |
| `SIG-BAT-PWRMTR-001` | Critical (DAL-A) | **H-1**, **H-2** (REQ_H_01, REQ_H_02) | `REQ_SC_01`, `REQ_SAF_05`, `SC-001` | Reject `< 49.0 V` pre-flight (`GAP-05`) and trigger `CriticalBatteryOrGeofenceRtb` below `36.0 V` |
| `SIG-BAT-PWRMTR-002` | Critical (DAL-A) | **H-2** (REQ_H_02) | `REQ_SC_04`, `SC-005` | Open `200.0 A` fuse above `200.0 A` fault current and telemetry-flag overcurrent on `CAN 1` |
| `SIG-PWRMTR-PROP-002` | High (DAL-A) | **H-1**, **H-2** (REQ_H_01, REQ_H_02) | `REQ_SC_01`, `REQ_SC_04`, `SC-006` | Force `0.0` throttle until `RBF #1` removed, prop folded, and `RBF #2` power-on verified |
| `SIG-PROP-PWRMTR-002` | High (DAL-B) | **H-2** (REQ_H_02) | `REQ_SC_04`, `REQ_SAF_11`, `SC-008` | Bridge normalized ESC thermal state to `CAN 1` and command `RTL` on thermal cutoff breach |
| `SIG-EPS-ACT-001` | Critical (DAL-A) | **H-2**, **H-3** (REQ_H_02, REQ_H_03) | `REQ_SC_02`, `REQ_SC_06`, `SC-009` | Monitor `8.0 V` actuator rail on `CAN 1` and trigger `EmergencyAbortOrRtb` on sag |
| `SIG-EPS-COMMS-001` | High (DAL-B) | **H-2**, **H-5** (REQ_H_02, REQ_H_05) | `REQ_SC_12`, `SC-012` | Maintain `12.0 V` (`8.0` to `17.0 V` envelope) and fall back to autonomous `105.0 s` `RTL` if lost |
| `SIG-EPS-ESAD-001` | Critical (DAL-A) | **H-2**, **H-4** (REQ_H_02, REQ_H_04) | `REQ_SC_02`, `REQ_SAF_01`, `SC-011` | Assert `EsadRailBrownoutAlert` below `14.0 V` (`GAP-01`) and cut supply on `Power Off ESAD` |
| `SIG-PWRMTR-FC-003` | High (DAL-A) | **H-4** (REQ_H_02) | `REQ_SC_02`, `SC-013`, `SC-016` | Force autonomous `RTL` when `BingoEnergyReserveRatio <= 0.20` (`1080.0 s` floor) |
| `SIG-FC-EPS-001` | Critical (DAL-A) | **H-3**, **H-12** (REQ_H_04, REQ_H_06) | `REQ_SC_16`, `REQ_SAF_01`, `SC-045` | Assert irreversible `Power Off ESAD` to isolate `14.0 V` rail during scrub or brownout |
| `SIG-EPS-FC-002` | Critical (DAL-A) | **H-3**, **H-4** (REQ_H_02, REQ_H_04) | `REQ_SAF_01`, `SC-009`, `SC-012` | Default `true` on cold init; inhibit arming and trigger `Power Off ESAD` + `RTL` on sag |
| `SIG-EPS-FC-003` | High (DAL-A) | **H-1**, **H-11** (REQ_H_01) | `REQ_SC_03`, `SC-005`, `SC-041` | Enforce `false` (`rndRecoveryOptionInstalled == false`) inhibiting optional `50.0 V` lines |
| `SIG-FC-ACT-001` | Critical (DAL-A) | **H-9** (REQ_H_03) | `REQ_SC_05`, `REQ_SC_06`, `SC-033` | Isolate tail fins on `CAN 1` from `CAN 2` and revert to `0.0 deg` neutral on actuator reset |
| `SIG-FC-ACT-002` | Critical (DAL-A) | **H-9** (REQ_H_03) | `REQ_SC_06`, `SC-034`, `SC-036` | Isolate wing roll servos on `CAN 2` and preserve tail fin pitch/yaw authority on `CAN 1` |
| `SIG-NAV-ACT-001` | Critical (DAL-A) | **H-5**, **H-6** (REQ_H_03, REQ_H_05) | `REQ_SC_05`, `REQ_SC_07`, `SC-021` | Enforce `<= 3.0 m/s` calm / `>= 10.0 m/s` airflow BIT and `<= 55.0 m/s` RTA dive cap |
| `SIG-NAV-ACT-004` | High (DAL-B) | **H-6** (REQ_H_03) | `REQ_SC_07`, `SC-024` | Require `OnlineMagnetometerCount == 2` at pre-flight BIT before launch clearance |
| `SIG-FC-RPI-001` | Critical (DAL-A) | **H-5**, **H-13** (REQ_H_03, REQ_H_05) | `REQ_SC_05`, `REQ_SAF_02`, `SC-017` | Override `Trip6` dive in software Simplex RTA (`0` boxes) when `> 55.0 m/s` (`80.0 m/s` VNE) |
| `SIG-FC-RPI-003` | Critical (DAL-A) | **H-5**, **H-8**, **H-12** (REQ_H_04, REQ_H_05) | `REQ_SC_08`, `REQ_SC_12`, `SC-029` | Default `true` (disarm); command immediate ESAD abort on `> 55.0 m/s` dive or GCS timeout |
| `SIG-RPI-FC-001` | Critical (DAL-A) | **H-8** (REQ_H_03, REQ_H_04) | `REQ_SC_08`, `REQ_SAF_04`, `SC-032` | Default `false`; transition `Cube orange+` to `EsadBusWatchdogFaultFallback` on timeout |
| `SIG-FC-NAV-001` | High (DAL-B) | **H-7** (REQ_H_03) | `REQ_SC_07`, `SC-025`, `SC-026` | Switch EKF2 cleanly to `RM3100` + `SKYE2` INS/DR mode when `DisableGnssCommand == true` |
| `SIG-FC-EOIR-002` | Critical (DAL-A) | **H-13** (REQ_H_05) | `REQ_SC_12`, `SC-049`, `SC-050` | Default `true` (abort); halt terminal dive on `> 55.0 m/s` or track hold `< 2.0 s` |
| `SIG-EOIR-FC-003` | High (DAL-B) | **H-13** (REQ_H_05) | `REQ_SC_12`, `SC-051`, `SC-052` | Require `[2.0, 5.0] s` continuous `Trip6` auto-tracker lock hold prior to terminal attack |
| `SIG-COMMS-FC-001` | High (DAL-B) | **H-18** (REQ_H_06) | `REQ_SC_15`, `SC-071` | Clamp waypoint altitude strictly within `[50.0, 3000.0] m` (`5000.0 m` airframe ceiling) |
| `SIG-COMMS-FC-002` | High (DAL-B) | **H-18** (REQ_H_06) | `REQ_SC_15`, `SC-071` | Enforce loiter radius `>= 300.0 m` (`300.0 m` safe default) to prevent tight-turn stall |
| `SIG-COMMS-FC-003` | High (DAL-B) | **H-5** (REQ_H_01, REQ_H_03) | `REQ_SC_01`, `REQ_SC_15`, `SC-018` | Default `true` (locked); verify service lid sealed prior to flight arming |
| `SIG-COMMS-RPI-002` | Critical (DAL-A) | **H-12** (REQ_H_04, REQ_H_06) | `REQ_SC_16`, `REQ_SAF_12`, `SC-045` | Require `>= 5.0 s` hold plus Slide-to-Confirm prior to ESAD self-destruct or abort |
| `SIG-COMMS-EOIR-002` | Medium (DAL-C) | **H-14** (REQ_H_05) | `REQ_SC_12`, `SC-053`, `SC-054` | Trigger deterministic in-flight `Trip6`/`Nighthawk2UZ` gimbal recovery on video freeze |
| `SIG-RPI-ESAD-001` | Critical (DAL-A) | **H-8**, **H-10** (REQ_H_03, REQ_H_04) | `REQ_SC_08`, `REQ_SAF_04`, `SC-037` | Poll at `100 Hz` (`115200 bps` `CRC-16 XModem`) and lock out ESAD on `> 10.0 ms` gap (`GAP-04`) |
| `SIG-RPI-ESAD-003` | Critical (DAL-A) | **H-8**, **H-11** (REQ_H_04) | `REQ_SC_10`, `SC-042`, `SC-043` | Gate `1000.0 Hz` (`2`-pulse, `2.5` to `3.3 V`) discrete strictly behind `ArmStage2Armed` |
| `SIG-ESAD-RPI-002` | Critical (DAL-A) | **H-10**, **H-11** (REQ_H_04) | `REQ_SC_09`, `REQ_SC_10`, `SC-040` | Latch `FaultLockout` if premature `DSC_IN1` (FaultStates discrete arm flag) or premature `RBF #3` pull occurs |
| `SIG-ESAD-RPI-003` | Critical (DAL-A) | **H-11** (REQ_H_04) | `REQ_SC_11`, `REQ_SAF_07`, `SC-041` | Default `false`; prohibit HV charge until `SS2 Safe Distance Exceed == true` (`GAP-07`) |
| `SIG-ESAD-RPI-005` | Critical (DAL-A) | **H-10**, **H-11** (REQ_H_04) | `REQ_SC_09`, `REQ_SC_11`, `SC-038` | Enforce `< 50.0 V` during `PBIT` and limit `0.0` to `1800.0 V` charge to post-SS2 armed state |
| `SIG-ESAD-RPI-007` | Critical (DAL-A) | **H-10** (REQ_H_04) | `REQ_SC_09`, `REQ_SC_10`, `REQ_SAF_06` | Require `< 0.5` normalized resistance (`< 0.5 Ohm` at `20.0 mA`) until `RBF #2` ON (`GAP-06`) |
| `SIG-COMMS-GRF-001` | High (DAL-B) | **H-18** (REQ_H_05) | `REQ_SC_12`, `REQ_SC_15`, `SC-070` | Maintain `4.4` to `5.0 GHz` AES-256 FHSS link and enter `RTL` + ESAD disarm after `105.0 s` loss |
| `SIG-GCS-GRF-002` | High (DAL-B) | **H-18** (REQ_H_06) | `REQ_SC_15`, `SC-071` | Reject operator command entry when `OperatorAuthPasswordLen < 8` |
| `SIG-GCS-GRF-003` | Low (DAL-C) | **H-19** (REQ_H_05) | `REQ_SC_15`, `SC-073` | Gate `5W`/`CFF` targeting export behind verified coordinates and active C2 link |
| `SIG-GRF-GCS-001` | High (DAL-B) | **H-18** (REQ_H_06) | `REQ_SC_15`, `SC-072` | Enforce `>= 10.0 m` ground radio separation from airframe after ESD ground touch |
| `SIG-PL40-PROP-001` | Critical (DAL-A) | **H-16** (REQ_H_01, REQ_H_06) | `REQ_SC_14`, `REQ_SAF_03`, `SC-061` | Enforce `<= 25.0 m/s` exit ceiling (`~23.0 m/s` at `17.0 kg` MTOW, `GAP-03`) and `Go/No-Go` gate |
| `SIG-PL40-PROP-002` | Critical (DAL-A) | **H-15**, **H-17** (REQ_H_06) | `REQ_SC_13`, `REQ_SC_14`, `REQ_SC_16`, `SC-065` | Require `[13.0, 14.0] ratio` (`13.0` to `14.0 bar`) at firing; bleed to `0.0` on `SAFE_SCRUB_ABORT` |
| `SIG-PL40-PROP-004` | Critical (DAL-A) | **H-16** (REQ_H_06) | `REQ_SC_13`, `SC-062` | Enforce `0` electrical/CAN conductors across mechanical rail (`IF-MECH-001`) |
| `SIG-PROP-ESAD-001` | Critical (DAL-A) | **H-11**, **H-16** (REQ_H_04, REQ_H_06) | `REQ_SC_11`, `REQ_SAF_10`, `SC-044` | Require mechanical `SS1` launch acceleration pulse before transitioning to `ArmStage1TimerWait` |

## 5. Source References

- Structural SysML v2 Schema: [../../.pipeline/schema.sysml](../../.pipeline/schema.sysml)
- Level 1C System Interface Matrix: [../../docs/interfaces/ICD_01_SYSTEM_INTERFACE_MATRIX.md](../../docs/interfaces/ICD_01_SYSTEM_INTERFACE_MATRIX.md)
- STPA Safety & Risk Analysis Matrix: [../../docs/safety/STPA_MATRIX.md](../../docs/safety/STPA_MATRIX.md)
- Cited Normative Research Inventory: [../../docs/research/RESEARCH_INVENTORY.md](../../docs/research/RESEARCH_INVENTORY.md)

/// ObligationWitness: [OBL-03]
/// ObligationWitness: [CTL-03]
