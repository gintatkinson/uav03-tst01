doc /* Avenger 5 (Avenger V2.5 / ASTK A5 V2.5) Uncrewed Aircraft System Hardware-Faithful SysML v2 Model. Grounded 100% in schema/extracted/{oem_bom,interface_table,parametric_limits}.md. Zero standalone RTA box; zero electrical/CAN wire between PL-40 and UAV; production Recovery System excluded (Optional RnD only). */
package Avenger5V25UasSystem {
    doc /* Root integrated Avenger 5 (Avenger V2.5 / ASTK A5 V2.5 + ELI PL-40 + SwarmC2) composition instantiating all 14 real part defs with zero fake RTA box and strictly mechanical PL-40 launch interface. */
    part def Avenger5V25IntegratedSystem {
        connection def CONN_01 {
            connect batteryAndFuse.protectedDcOut to powerMeter.mainDcIn;
        }
        connection def CONN_02 {
            connect powerMeter.escDriveOut to propulsionAndAirframe.escDriveIn;
        }
        connection def CONN_03 {
            connect powerMeter.trunkDcOut970cm to eps.trunkDcIn;
        }
        connection def CONN_04 {
            connect eps.servo8VOut to surfaceActuators.servo8VIn;
        }
        connection def CONN_05 {
            connect eps.radio12VOut to commsUnit.radio12VIn;
        }
        connection def CONN_06 {
            connect eps.esad14VOut to esadUnit.esad14VIn;
        }
        connection def CONN_07 {
            connect eps.sensorPowerOut to navAirData.sensorPowerIn;
        }
        connection def CONN_08 {
            connect eps.gimbalPowerOut to seekerUnit.gimbalPowerIn;
        }
        connection def CONN_09 {
            connect flightController.can1Master to powerMeter.can1Tap;
        }
        connection def CONN_10 {
            connect flightController.can1Master to eps.can1Tap;
        }
        connection def CONN_11 {
            connect flightController.can1Master to surfaceActuators.can1TailFins;
        }
        connection def CONN_12 {
            connect flightController.can2Master to surfaceActuators.can2SplitterIn;
        }
        connection def CONN_13 {
            connect surfaceActuators.can2DaisyOutToSensors to navAirData.can2DaisyIn;
        }
        connection def CONN_14 {
            connect flightController.serialRpi to companionComputer.serialFc;
        }
        connection def CONN_15 {
            connect flightController.serialGnss to navAirData.serialGnss;
        }
        connection def CONN_16 {
            connect flightController.serialTrip6 to seekerUnit.serialFc;
        }
        connection def CONN_17 {
            connect flightController.serialRadioAndUsbExt to commsUnit.fcSerialAndUsbExt;
        }
        connection def CONN_18 {
            connect companionComputer.ethSwitch to commsUnit.ethRpiPort;
        }
        connection def CONN_19 {
            connect seekerUnit.ethSwitch to commsUnit.ethTrip6Port;
        }
        connection def CONN_20 {
            connect companionComputer.esadOcControl to esadUnit.ocControlIn;
        }
        connection def CONN_21 {
            connect commsUnit.rfDatalinkOut to groundRfStation.rfAirPort;
        }
        connection def CONN_22 {
            connect swarmC2Console.gcsStationPort to groundRfStation.gcsStationPort;
        }
        connection def CONN_23 {
            connect pl40Launcher.mechLaunchOut to propulsionAndAirframe.mechLaunchRailIn;
        }
        connection def CONN_24 {
            connect propulsionAndAirframe.inertialSs1Out to esadUnit.inertialSs1In;
        }
        part batteryAndFuse : MainBatteryAndFuseUnit {
        }
        part powerMeter : PowerMeterAndRbfSwitch {
        }
        part propulsionAndAirframe : ElectricPropulsionUnit {
        }
        part eps : ElectronicPowerSystemEps {
        }
        part flightController : FlightControllerCubeOrangePlus {
        }
        part companionComputer : CompanionComputeRpiCm5 {
        }
        part navAirData : NavigationAndAirDataSuite {
        }
        part surfaceActuators : DroneCanSurfaceActuation {
        }
        part commsUnit : OnboardEthernetAndC2RadioUnit {
        }
        part seekerUnit : EoIrSeekerAndTrackerUnit {
        }
        part esadUnit : ArtronEsadAndSensorUnit {
        }
        part pl40Launcher : Pl40PneumaticLauncher {
        }
        part swarmC2Console : SwarmC2OperatorConsole {
        }
        part groundRfStation : GroundRfStationAndAntennaTracker {
        }
    }
    doc /* Subsystem Package 1 covering Main Battery and 200A Fuse, Power Meter and RBF #2 Switch, Electric Propulsion and Avenger V2.5 Airframe Envelope, and Electronic Power System (EPS). */
    package AirframePowerAndPropulsion {
        port def MainBatteryDcOutPort {
            attribute direction = "out";
            attribute itemType = "MainDcBusPower";
            attribute protocol = "IF-PWR-001, IF-PWR-002 (36.0-50.4 V DC, 200.0 A fuse)";
        }
        port def MainBatteryDcInPort {
            attribute direction = "in";
            attribute itemType = "MainDcBusPower";
            attribute protocol = "IF-PWR-003 (XT60E-F RBF #2 switched DC)";
        }
        port def EscDriveHarnessOutPort {
            attribute direction = "inout";
            attribute itemType = "MainDcBusPower, EscThrottlePwmSignal, EscTelemetryFrame";
            attribute protocol = "IF-PWR-004, IF-PWM-001, IF-SER-005";
        }
        port def EscDriveHarnessInPort {
            attribute direction = "inout";
            attribute itemType = "MainDcBusPower, EscThrottlePwmSignal, EscTelemetryFrame";
            attribute protocol = "IF-PWR-004, IF-PWR-005, IF-PWM-001, IF-SER-005";
        }
        port def TrunkDcPowerOutPort {
            attribute direction = "out";
            attribute itemType = "MainDcBusPower";
            attribute protocol = "IF-PWR-006 (970.0 cm main DC trunk)";
        }
        port def TrunkDcPowerInPort {
            attribute direction = "in";
            attribute itemType = "MainDcBusPower";
            attribute protocol = "IF-PWR-006 (970.0 cm main DC trunk)";
        }
        port def RegulatedRailOutPort {
            attribute direction = "out";
            attribute itemType = "RegulatedRailPower";
            attribute protocol = "IF-PWR-007..011 (8.0 V, 12.0 V, 14.0 V, sensor/gimbal DC rails)";
        }
        port def RegulatedRailInPort {
            attribute direction = "in";
            attribute itemType = "RegulatedRailPower";
            attribute protocol = "IF-PWR-007..011 (Regulated DC rail input)";
        }
        port def Can1PowerTapPort {
            attribute direction = "inout";
            attribute itemType = "CanBusMessageFrame";
            attribute protocol = "IF-CAN1-001 (DroneCAN CAN 1 multi-drop tap)";
        }
        port def MechanicalLaunchRailInPort {
            attribute direction = "in";
            attribute itemType = "MechanicalThrustAndLaunchLoad";
            attribute protocol = "IF-MECH-001 (Strictly mechanical hardpoint; zero electrical wires)";
        }
        port def InertialSs1AccelOutPort {
            attribute direction = "out";
            attribute itemType = "InertialLaunchAccelPulse";
            attribute protocol = "Rigid-body inertial launch acceleration coupling";
        }
        doc /* Verify 12S2P battery 49.0-50.0 V, confirm RBF #1 covers removed and rear prop folded, and pull UAV Power RBF #2 to energize main bus while ESAD RBF #3 remains installed (GAP-05, GAP-06). */
        action def ValidateBatteryAndPowerOnRbf2(in packVoltageV : Real, in rbf1Removed : Boolean, in propFoldedRearward : Boolean, in rbf3StillInstalled : Boolean, out busEnergized : Boolean);
        doc /* Issue PWM throttle command from Power Meter to IBEX160 ESC and bridge UART RPM, temperature, voltage, and current back onto CAN 1. */
        action def CommandPusherThrottleAndReadEscTelem(in throttleNorm : Real, in flightArmed : Boolean, out escRpm : Real, out escTempDegC : Real, out motorTempDegC : Real, out busCurrentA : Real);
        doc /* Regulate 8.0 V servo, 12.0 V radio, 14.0 V ESAD (GAP-01), and sensor/gimbal rails from 970.0 cm DC trunk; isolate ESAD rail on irreversible Power Off ESAD command. */
        action def DistributeRegulatedPowerRails(in mainBusV : Real, in esadPowerOffCmd : Boolean, out servo8V : Real, out radio12V : Real, out esad14V : Real, out esadBrownoutAlert : Boolean);
        doc /* Enforce 0.20 statutory Bingo reserve ratio across 5400.0 s endurance and trigger RTL upon reserve floor or main bus sag below 36.0 V. */
        action def MonitorBingoEnergyReserve(in remainingEnduranceSec : Real, in busVoltageV : Real, out bingoReached : Boolean, out rtlTriggered : Boolean);
        doc /* Main 12S2P pack must read 49.0-50.0 V at pre-flight check (within 36.0-50.4 V envelope), rejecting 24-25 V legacy UI values (GAP-05). */
        constraint def MainBatteryPreFlightVoltageConstraint {
            in packVoltageV : Real && in busVoltageV : Real && attribute invariantExpr : String = "packVoltageV >= 49.0 and packVoltageV <= 50.0 and busVoltageV >= 36.0 and busVoltageV <= 50.4";
        }
        doc /* Statutory minimum 0.20 energy reserve ratio over 5400.0 s endurance (1080.0 s floor). */
        constraint def BingoEnergyReserveConstraint {
            in reserveRatio : Real && attribute invariantExpr : String = "reserveRatio >= 0.20";
        }
        doc /* Enforce 24.0 m/s stall floor (26.0 m/s conservative V1), <= 55.0 m/s terminal engagement cap, <= 80.0 m/s VNE structural dive ceiling (GAP-02). */
        constraint def FlightEnvelopeSpeedConstraint {
            in airspeedMs : Real && in engagementActive : Boolean && attribute invariantExpr : String = "airspeedMs >= 24.0 and airspeedMs <= 80.0 and (not engagementActive or airspeedMs <= 55.0)";
        }
        doc /* GAP-01: EPS 14.0 V nominal output equals ESAD 14.0 V minimum VDC_IN (zero brownout margin across 14.0-32.0 V ICD range). */
        constraint def EpsEsadZeroBrownoutMarginConstraint {
            in epsEsadOutV : Real && attribute invariantExpr : String = "epsEsadOutV >= 14.0 and epsEsadOutV <= 32.0";
        }
        doc /* Production Avenger V2.5 excludes recovery parachute system; 2x 50.0 V RnD igniter lines remain disabled. */
        constraint def ProductionNoParachuteConstraint {
            in rndRecoveryOptionInstalled : Boolean && attribute invariantExpr : String = "rndRecoveryOptionInstalled == false";
        }
        requirement def REQ_L_01 {
            doc /* Loss L1: Human fatality or severe crew injury from unintended warhead detonation or unrestrained PL-40 launch discharge. */
            attribute severity : String = "Catastrophic";
        }
        requirement def REQ_L_02 {
            doc /* Loss L2: Uncontrolled airframe crash or hull destruction outside authorized engagement corridor. */
            attribute severity : String = "Catastrophic";
        }
        requirement def REQ_H_01 {
            doc /* Hazard H1: Premature propulsion energization, reversed RBF sequencing, or insufficient launch airspeed (< 24.0-26.0 m/s) during handling or launch. */
            attribute severity : String = "Catastrophic";
        }
        requirement def REQ_H_02 {
            doc /* Hazard H2: In-flight propulsion loss, main bus sag below 36.0 V, EPS 14.0 V ESAD brownout (GAP-01), or Bingo reserve exhaustion (< 0.20). */
            attribute severity : String = "Hazardous";
        }
        requirement def REQ_UCA_01 {
            doc /* UCA-01: Operator removes UAV Power RBF #2 before RBF #1 cover removal / rear prop folding, or before ESAD pre-arm sequence permits power-on. */
            attribute ucaType : String = "Provided Out of Sequence";
            @TriggersHazard("REQ_H_01");
        }
        requirement def REQ_UCA_02 {
            doc /* UCA-02: EPS fails to sustain 14.0 V ESAD supply under load or Power Meter fails to signal Bingo reserve depletion below 0.20 (1080.0 s). */
            attribute ucaType : String = "Not Provided";
            @TriggersHazard("REQ_H_02");
        }
        requirement def REQ_SC_01 {
            text = "SC-01: Enforce ordered pre-flight interlock: ESD ground -> RBF #1 off -> prop fold rearward -> RBF #2 pull -> 49.0-50.0 V check -> lock both RBF and umbilical lids.";
            @SafetyRealises("REQ_UCA_01");
        }
        requirement def REQ_SC_02 {
            text = "SC-02: Monitor 12S2P voltage (36.0-50.4 V) and 0.20 Bingo reserve continuously on CAN 1 and trigger RTL before reserve depletion or 14.0 V ESAD brownout.";
            @SafetyRealises("REQ_UCA_02");
        }
        requirement def REQ_SC_03 {
            text = "SC-03: Inhibit optional 2x 50.0 V RnD recovery igniter outputs on production Avenger V2.5 (rndRecoveryOptionInstalled == false).";
            @SafetyRealises("REQ_UCA_01");
        }
        requirement def REQ_SC_04 {
            text = "SC-04: Protect main DC bus with 200.0 A automotive fuse and monitor IBEX160 ESC UART RPM, ESC/motor temperature, voltage, and current via CAN 1.";
            @SafetyRealises("REQ_UCA_02");
        }
        requirement def REQ_SAF_01 {
            text = "GAP-01 Mitigation: EPS 14.0 V nominal output has 0.0 V margin above ESAD 14.0 V minimum VDC_IN; enforce brownout telemetry alarm and irreversible Power Off ESAD safing on sag.";
        }
        requirement def REQ_SAF_02 {
            text = "GAP-02 Mitigation: Adopt conservative control envelope across V1/V2.5 specs (24.0-42.0 m/s airspeed, 55.0 m/s engagement speed cap, 80.0 m/s structural VNE, 60.0/90.0 km RLOS).";
        }
        requirement def REQ_SAF_05 {
            text = "GAP-05 Mitigation: Anchor battery UI and health checks strictly to 12S2P 36.0-50.4 V (49.0-50.0 V pre-flight), rejecting legacy 23.9-25.0 V screenshots.";
        }
        doc /* End-to-end air vehicle operational lifecycle from pre-flight checks through catapult launch, cruise/loiter, terminal engagement, abort/RTB, and safe shutdown. States: PreFlightCheck (RBF #1 removed, prop folded, RBF #2 removed, 49.0-50.0 V verified, ESAD PBIT < 50.0 V before RBF #3 pull); CatapultLaunch (PL-40 rail acceleration ~23.0 m/s at 17.0 kg, SS1 inertial sense, pusher climb transition above 26.0 m/s); CruiseAndLoiter (cruise at 30.0-31.0 m/s within 50.0-3000.0 m altitude, >= 300.0 m loiter radius, <= 5000.0 m ceiling); TargetTrackAndDive (Nighthawk2UZ + Trip6 target hold 2.0-5.0 s, shallow 15.0 deg / max 22.0 deg dive, <= 55.0 m/s speed cap, ESAD armed after SS2); EmergencyAbortOrRtb (triggered by Abort Engaging > 55.0 m/s, 105.0 s GCS Failsafe RTL, Bingo <= 0.20 reserve, or 5.0 s ESAD self-destruct hold); SafePostFlightShutdown (ESAD disarmed/discharged < 50.0 V, RBF #3 reinstalled before RBF #2 battery disconnect, lids locked). */
        state def UavFlightLifecycleState {
            state PreFlightCheck;
            state CatapultLaunch;
            state CruiseAndLoiter;
            state TargetTrackAndDive;
            state EmergencyAbortOrRtb;
            state SafePostFlightShutdown;
            transition T_Init first Initial then PreFlightCheck;
            transition T_PreflightToLaunch first PreFlightCheck accept launchAuthorizedAndCarriageReleased then CatapultLaunch;
            transition T_LaunchToCruise first CatapultLaunch accept climbAirspeedAbove26Ms then CruiseAndLoiter;
            transition T_CruiseToEngage first CruiseAndLoiter accept targetLockedAndArmed then TargetTrackAndDive;
            transition T_DiveToAbort first TargetTrackAndDive accept abortEngagingOrSpeedAbove55Ms then EmergencyAbortOrRtb;
            transition T_CruiseToAbort first CruiseAndLoiter accept gcsFailsafeOrBingoReserveReached then EmergencyAbortOrRtb;
            transition T_AbortToShutdown first EmergencyAbortOrRtb accept safeRecoveryOrScrubCompleted then SafePostFlightShutdown;
            transition T_PreflightToShutdown first PreFlightCheck accept scrubAbortCommanded then SafePostFlightShutdown;
            transition T_ShutdownToTerminal first SafePostFlightShutdown then Terminal;
        }
        doc /* Mapped 1:1 to uc-02: Execute ordered Avenger V2.5 pre-flight power-on, voltage verification (49.0-50.0 V), pitot/mag/servo BIT, and ESAD PBIT (< 50.0 V) prior to RBF #3 pull. */
        use case def UC_02_VerifyPreflightPowerAndBit {
            subject MainBatteryAndFuseUnit;
            actor LaunchAssistant;
            actor Pilot;
            objective "Guarantee main bus 49.0-50.0 V, zero premature ESAD RBF #3 removal fault (GAP-06), and healthy avionics/propulsion BIT before PL-40 rail arming.";
        }
        item def MainDcBusPower {
            doc /* Main unregulated 12S2P Li metal DC power bus (36.0-50.4 V, 200.0 A fuse limit). */
            attribute nominalMinV : Real = 36.0;
            attribute nominalMaxV : Real = 50.4;
            attribute preflightCheckMinV : Real = 49.0;
            attribute preflightCheckMaxV : Real = 50.0;
            attribute fuseLimitA : Real = 200.0;
        }
        item def RegulatedRailPower {
            doc /* Regulated DC voltage rail produced by EPS DC/DC converters. */
            attribute railVoltageV : Real = 14.0;
            attribute brownoutMarginV : Real = 0.0;
        }
        item def EscThrottlePwmSignal {
            doc /* Unidirectional PWM throttle command from Power Meter to IBEX160 ESC (IF-PWM-001). */
            attribute throttleNormalized : Real = 0.0;
        }
        item def EscTelemetryFrame {
            doc /* Unidirectional ESC UART telemetry frame: RPM, ESC temp, motor temp, voltage, current (IF-SER-005). */
            attribute motorRpm : Real = 0.0;
            attribute escTempDegC : Real = 25.0;
            attribute motorTempDegC : Real = 25.0;
            attribute busVoltageV : Real = 49.5;
            attribute busCurrentA : Real = 0.0;
        }
        item def MechanicalThrustAndLaunchLoad {
            doc /* Purely mechanical launch rail acceleration impulse or pusher thrust load (IF-MECH-001). Zero electrical conductors. */
            attribute exitVelocityMs : Real = 23.0;
            attribute maxRailVelocityMs : Real = 25.0;
            attribute railElevationDeg : Real = 12.0;
            attribute electricalWireCount : Integer = 0;
        }
        item def InertialLaunchAccelPulse {
            doc /* Rigid-body mechanical launch acceleration transmitted through Avenger V2.5 airframe to ESAD inertial SS1 switch. */
            attribute accelScaleGPerLsb : Real = 0.0039;
            attribute electricalWireCount : Integer = 0;
        }
        item def MainPowerBusInterface {
            doc /* Main 12S2P DC bus from Battery through 200.0 A fuse and Power Meter RBF #2 switch to IBEX160 and 970.0 cm EPS trunk (IF-PWR-001..006). */
            attribute sourceEnd : String = "MainBatteryDcOutPort";
            attribute targetEnd : String = "MainBatteryDcInPort";
        }
        item def PropulsionDriveAndTelemetryInterface {
            doc /* Power Meter to IBEX160 ESC to AXI 5345/16 BLDC motor 3-phase drive, PWM throttle, and UART telemetry return (IF-PWR-004, IF-PWR-005, IF-PWM-001, IF-SER-005). */
            attribute meterEnd : String = "EscDriveHarnessOutPort";
            attribute escEnd : String = "EscDriveHarnessInPort";
        }
        item def EpsRegulatedRailInterface {
            doc /* Regulated DC rails from EPS: 8.0 V servos, 12.0 V DTC radio, 14.0 V ESAD GAP-01, pitot/mag/gimbal rails, optional 2x 50.0 V RnD (IF-PWR-007..011). */
            attribute epsOut : String = "RegulatedRailOutPort";
            attribute loadIn : String = "RegulatedRailInPort";
        }
        doc /* Verify 49.0-50.0 V 12S2P pre-flight check (rejecting 24-25 V), RBF #1 and prop fold ordering, and RBF #2 power-on before RBF #3 pull. */
        test case def TC_01_PreflightPowerAndRbfSequence {
            subject MainBatteryAndFuseUnit;
            verify requirement REQ_SC_01, REQ_SAF_05, REQ_SAF_06;
            objective "Confirm zero premature ESAD fault and valid main bus energization at 49.0-50.0 V.";
            step verifyPackVoltageBetween49And50V;
            step confirmRbf1RemovedAndPropFolded;
            step removeRbf2WhileRbf3Installed;
        }
        doc /* Verify 0.20 Bingo reserve RTL trigger and EPS 14.0 V ESAD brownout alert under maximum actuator and datalink load. */
        test case def TC_02_BingoReserveAndEpsBrownoutMonitor {
            subject ElectronicPowerSystemEps;
            verify requirement REQ_SC_02, REQ_SAF_01;
            objective "Confirm deterministic RTL alert at 0.20 remaining reserve and zero undetected drop below 14.0 V on ESAD GE_POW.";
            step injectMainBusLoadProfile;
            step verifyEsadRailAtOrAbove14V;
            step verifyRtlAlertAt020Reserve;
        }
        doc /* Provide X-wing pusher airframe structural envelope (1.8 m span, 1.6 m length, 1.1 m height, 17.0 kg MTOW, -20.0 to +50.0 degC) and 12S2P Li metal BEI maximus20 primary energy storage (36.0-50.4 V, 200.0 A fuse, 90.0 min / 5400.0 s endurance, 0.20 statutory Bingo reserve). */
        capability def AirframeStructuralAndEnergySupply;
        doc /* Gate main DC bus via UAV Power RBF #2 (XT60E-F), drive rear folding pusher propeller via IBEX160 ESC and AXI 5345/16 BLDC motor across 24.0-80.0 m/s up to 5000.0 m ceiling, and distribute regulated 8.0 V, 12.0 V, 14.0 V, sensor/gimbal, and optional RnD 50.0 V rails via EPS. */
        capability def SwitchedPropulsionAndRegulatedDistribution;
        doc /* Mapped 1:1 to us-01: ESD touch, RBF #1 removal, rear prop fold, 49.0-50.0 V pack verify, RBF #2 removal energizing 36.0-50.4 V bus, Cube orange+ boot, RPI CM5 to ESAD 0xB0 WELCOME and 0x11 PBIT (< 50.0 V) with RBF #3 still installed (GAP-06), pitot 3.0/10.0 m/s check, RM3100 and HV6160 sweep. */
        interaction def INT_01_PreflightPowerAndBit {
        }
        doc /* Mapped 1:1 to us-02: Power Meter PWM throttle to IBEX160 ESC, AXI 5345/16 pusher drive, UART ESC telemetry bridged onto CAN 1, continuous 0.20 Bingo reserve monitoring over 5400.0 s endurance, and EPS 14.0 V ESAD brownout supervision (GAP-01). */
        interaction def INT_02_PropulsionThrustAndBingoMonitor {
        }
        doc /* BOM-AV-002 & BOM-AV-003: Removable 12S2P Li metal BEI maximus20 pack with QR/ID match and 200.0 A inline automotive fuse. Anchored to 36.0-50.4 V and 49.0-50.0 V pre-flight check (GAP-05). */
        part def MainBatteryAndFuseUnit {
            attribute chemistryModel : String = "12S2P Li metal BEI maximus20";
            attribute voltageMinV : Real = 36.0;
            attribute voltageMaxV : Real = 50.4;
            attribute preflightVoltageMinV : Real = 49.0;
            attribute preflightVoltageNominalMaxV : Real = 50.0;
            attribute automotiveFuseRatingA : Real = 200.0;
            attribute maxEnduranceMin : Real = 90.0;
            attribute maxEnduranceSec : Real = 5400.0;
            attribute bingoReserveRatio : Real = 0.2;
            attribute bingoReserveSec : Real = 1080.0;
            attribute legacy24VUiRejected : Boolean = true;
            port out protectedDcOut : MainBatteryDcOutPort;
        }
        doc /* BOM-AV-004 & BOM-AV-005: Integrated V/I Power Meter and main switch gated by UAV Power RBF Key #2 (XT60E-F). Bridges ESC UART telemetry onto CAN 1 and drives 970.0 cm trunk to EPS. */
        part def PowerMeterAndRbfSwitch {
            attribute rbfKeyId : String = "UAV Power R.B.F. Key #2 (XT60E-F)";
            attribute busVoltageMinV : Real = 36.0;
            attribute busVoltageMaxV : Real = 50.4;
            attribute trunkHarnessLengthCm : Real = 970.0;
            attribute rbf2RemovedPowersOn : Boolean = true;
            attribute pullRbf2BeforeRbf3 : Boolean = true;
            port in mainDcIn : MainBatteryDcInPort;
            port inout escDriveOut : EscDriveHarnessOutPort;
            port out trunkDcOut970cm : TrunkDcPowerOutPort;
            port inout can1Tap : Can1PowerTapPort;
        }
        doc /* BOM-AV-001, BOM-AV-006, BOM-AV-007, BOM-AV-008, BOM-AV-025: Avenger V2.5 X-wing pusher airframe envelope, IBEX160 ESC, AXI 5345/16 HD GOLD LINE V3 BLDC motor, rear folding prop, and RBF #1 covers/strap. */
        part def ElectricPropulsionUnit {
            attribute airframeModel : String = "AVENGER V2.5 / ASTK A5 V2.5";
            attribute escModel : String = "IBEX160";
            attribute motorModel : String = "AXI 5345/16 HD GOLD LINE V3";
            attribute wingspanNominalM : Real = 1.8;
            attribute wingspanCadMm : Real = 1803.0;
            attribute lengthNominalM : Real = 1.6;
            attribute lengthCadMm : Real = 1576.0;
            attribute heightNominalM : Real = 1.1;
            attribute heightCadMinMm : Real = 1095.0;
            attribute heightCadMaxMm : Real = 1112.0;
            attribute maxTakeoffWeightKg : Real = 17.0;
            attribute wingBoltDiameterMm : Real = 6.0;
            attribute wingBoltLengthMm : Real = 30.0;
            attribute wingBoltSpannerMm : Real = 10.0;
            attribute airframeLiftCrewMin : Integer = 2;
            attribute stallSpeedV25Ms : Real = 24.0;
            attribute minSpeedV1Ms : Real = 26.0;
            attribute cruiseSpeedV1Ms : Real = 30.0;
            attribute cruiseSpeedV25Ms : Real = 31.0;
            attribute maxHorizSpeedV1Ms : Real = 38.0;
            attribute maxHorizSpeedV25Ms : Real = 42.0;
            attribute targetEngagementSpeedCapMs : Real = 55.0;
            attribute structuralVneSpeedMs : Real = 80.0;
            attribute maxDiveAngleDeg : Real = 22.0;
            attribute shallowApproachAngleDeg : Real = 15.0;
            attribute serviceCeilingM : Real = 5000.0;
            attribute groundWindToleranceMaxMs : Real = 12.0;
            attribute cruiseWindToleranceMaxMs : Real = 28.0;
            attribute operatingTempMinDegC : Real = -20.0;
            attribute operatingTempMaxDegC : Real = 50.0;
            attribute carriagePropSafeZoneMinMm : Real = 145.0;
            attribute carriagePropSafeZoneMaxMm : Real = 155.5;
            port inout escDriveIn : EscDriveHarnessInPort;
            port in mechLaunchRailIn : MechanicalLaunchRailInPort;
            port out inertialSs1Out : InertialSs1AccelOutPort;
        }
        doc /* BOM-AV-009 & BOM-AV-026: DC/DC Converters, Load Switches, and MCU on CAN 1. Converts 36.0-50.4 V trunk to 8.0 V servos, 12.0 V radio, 14.0 V ESAD (GAP-01 zero brownout margin), pitot/mag/gimbal rails, and Optional RnD 2x 50.0 V lines (disabled on production). */
        part def ElectronicPowerSystemEps {
            attribute servoRailVoltageV : Real = 8.0;
            attribute radioRailVoltageV : Real = 12.0;
            attribute esadRailVoltageV : Real = 14.0;
            attribute rndRecoveryRailVoltageV : Real = 50.0;
            attribute rndRecoveryOptionInstalled : Boolean = false;
            attribute productionRecoverySystemInstalled : Boolean = false;
            attribute esadBrownoutMarginV : Real = 0.0;
            port in trunkDcIn : TrunkDcPowerInPort;
            port inout can1Tap : Can1PowerTapPort;
            port out servo8VOut : RegulatedRailOutPort;
            port out radio12VOut : RegulatedRailOutPort;
            port out esad14VOut : RegulatedRailOutPort;
            port out sensorPowerOut : RegulatedRailOutPort;
            port out gimbalPowerOut : RegulatedRailOutPort;
        }
    }
    doc /* Subsystem Package 2 covering Cube orange+ Autopilot & Software Simplex RTA, RPI CM5004032 Companion Computer, GNSS/Mag/Pitot Navigation & Air Data Suite, and DroneCAN Surface Actuation. */
    package AvionicsGuidanceAndControl {
        port def DroneCanBusPort {
            attribute direction = "inout";
            attribute itemType = "CanBusMessageFrame";
            attribute protocol = "IF-CAN1-001, IF-CAN2-001 (DroneCAN)";
        }
        port def UartSerialPort {
            attribute direction = "inout";
            attribute itemType = "UartSerialPacket";
            attribute protocol = "IF-SER-001..004 (Point-to-point UART serial)";
        }
        port def UsbExternalServicePort {
            attribute direction = "inout";
            attribute itemType = "UsbServicePacket";
            attribute protocol = "IF-USB-001 (Lockable umbilical USB)";
        }
        port def SerialAndUsbServicePort {
            attribute direction = "inout";
            attribute itemType = "UartSerialPacket, UsbServicePacket";
            attribute protocol = "IF-SER-004, IF-USB-001";
        }
        port def GnssCoaxRfPort {
            attribute direction = "in";
            attribute itemType = "GnssRfSignal";
            attribute protocol = "IF-RF-002 (Multi-band GNSS coax RF)";
        }
        doc /* Software-resident ASTM F3269-17 Simplex RTA on Cube orange+: clamps dive speed <= 55.0 m/s (<= 80.0 m/s VNE), reacts to ESAD bus faults, and commands RTL on geofence/battery/GCS timeout. */
        action def ExecuteSimplexRtaEnvelopeCheck(in airspeedMs : Real, in diveAngleDeg : Real, in linkLossSec : Real, in esadBusHealthy : Boolean, out clampEngagementSpeed : Boolean, out triggerRtlFailsafe : Boolean, out disarmEsadRequested : Boolean);
        doc /* Validate calm-air pitot reading <= 3.0 m/s, indirect airflow check >= 10.0 m/s, and both mRo RM3100 magnetometers online on CAN 2. */
        action def RunPitotAndMagPreflightCheck(in calmAirIndicatedMs : Real, in blownAirIndicatedMs : Real, in onlineMagCount : Integer, out airDataValid : Boolean);
        doc /* Transition Cube orange+ navigation to INS/DR fallback using RM3100 dual mag/baro and SKYE2 pitot upon GPS Failsafe or operator Disable GNSS command. */
        action def SwitchToGnssDeniedDeadReckoning(in gnssHealthy : Boolean, in disableGnssCommanded : Boolean, out deadReckoningActive : Boolean);
        doc /* Execute RPI CM5004032 100 Hz RS-485 EXCHANGE polling (CRC-16 XModem, <= 5.0 ms reply, <= 10.0 ms timeout) and gate DSC_IN1 1 kHz 2-pulse hardware arming strictly to Arm Stage 2. */
        action def SuperviseEsadOcMasterCycle(in armAuthorized : Boolean, in abortCommanded : Boolean, out exchangeFrameValid : Boolean, out emitDscIn1Pulses : Boolean);
        doc /* Mix pitch/yaw skid-turn onto tail fins #1-#4 (CAN 1) and active roll stabilization onto wings #5-#8 (CAN 2) over 8.0 V EPS rail. */
        action def ActuateTailAndWingSurfaces(in pitchCmd : Real, in yawCmd : Real, in rollCmd : Real, out finCommandedDeg : Real, out wingCommandedDeg : Real);
        doc /* Pre-flight CUAV SKYE2 pitot check must verify <= 3.0 m/s in calm air and >= 10.0 m/s under indirect airflow. */
        constraint def PitotPreflightCalibrationConstraint {
            in calmAirMs : Real && in blownAirMs : Real && attribute invariantExpr : String = "calmAirMs <= 3.0 and blownAirMs >= 10.0";
        }
        doc /* CAN 1 feeds 4x tail fins via 120.0 cm stubs; CAN 2 series-chains splitter -> 4x wing servos -> 2x RM3100 -> pitot. */
        constraint def CanTopologyIsolationConstraint {
            in finCount : Integer && in wingCount : Integer && in magCount : Integer && in stubLenCm : Real && attribute invariantExpr : String = "finCount == 4 and wingCount == 4 and magCount == 2 and stubLenCm == 120.0";
        }
        doc /* Enforces clean-room architecture: zero standalone RTA hardware box; RTA executes on Cube orange+ and ESAD bridge on RPI CM5004032. */
        constraint def SimplexRtaSoftwareHostingConstraint {
            in standaloneRtaBoxCount : Integer && in rtaHostedOnCubeOrangePlus : Boolean && attribute invariantExpr : String = "standaloneRtaBoxCount == 0 and rtaHostedOnCubeOrangePlus == true";
        }
        requirement def REQ_L_03 {
            doc /* Loss L3: Unrecoverable loss of navigation or C2 mission control resulting in flyaway or inability to verify safe abort. */
            attribute severity : String = "Hazardous";
        }
        requirement def REQ_H_03 {
            doc /* Hazard H3: Loss of flight control authority due to RTA envelope exceedance (> 55.0/80.0 m/s), CAN 1/CAN 2 bus saturation, or unflagged pitot/mag corruption. */
            attribute severity : String = "Catastrophic";
        }
        requirement def REQ_UCA_03 {
            doc /* UCA-03: Cube orange+ Simplex RTA fails to abort dive above 55.0 m/s or fails to isolate corrupted airspeed/GNSS sensor data. */
            attribute ucaType : String = "Not Provided";
            @TriggersHazard("REQ_H_03");
        }
        requirement def REQ_UCA_04 {
            doc /* UCA-04: RPI CM5004032 stops 100 Hz RS-485 ESAD heartbeat or exceeds 10.0 ms frame timeout without commanding safe ESAD disarm. */
            attribute ucaType : String = "Provided Too Late";
            @TriggersHazard("REQ_H_03");
        }
        requirement def REQ_SC_05 {
            text = "SC-05: Execute software Simplex RTA supervisor inside Cube orange+ clamping engagement airspeed <= 55.0 m/s and VNE <= 80.0 m/s (zero standalone RTA box).";
            @SafetyRealises("REQ_UCA_03");
        }
        requirement def REQ_SC_06 {
            text = "SC-06: Maintain physical bus separation between CAN 1 (EPS, Power Meter, 4x tail fins) and CAN 2 (splitter, 4x wing panels, 2x RM3100, SKYE2 pitot).";
            @SafetyRealises("REQ_UCA_03");
        }
        requirement def REQ_SC_07 {
            text = "SC-07: Enforce pre-flight SKYE2 pitot bounds (<= 3.0 m/s calm, >= 10.0 m/s airflow) and support GPS Failsafe / manual Disable GNSS INS/DR fallback.";
            @SafetyRealises("REQ_UCA_03");
        }
        requirement def REQ_SC_08 {
            text = "SC-08: RPI CM5004032 shall poll Artron ESAD as sole OC Master at 100 Hz (0.01 s, 115200 bps 8N1, CRC-16 XModem) with 5.0 ms reply and 10.0 ms timeout enforcement.";
            @SafetyRealises("REQ_UCA_04");
        }
        requirement def REQ_SAF_08 {
            text = "GAP-WCET Disposition: Anchor deterministic timing around grounded 100 Hz (0.01 s) ESAD RS-485 cycle while tracking EKF2, CAN 1/2, and Trip6 WCET targets for bench verification.";
        }
        requirement def REQ_SAF_09 {
            text = "GAP-REL Disposition: Parameterize FMECA/FTA piece-part failure rates (lambda/MTBF) using conservative baselines pending OEM supplier MTBF release.";
        }
        doc /* Software-resident ASTM F3269-17 Simplex RTA runtime assurance monitor executing inside Cube orange+ with RPI CM5 ESAD watchdog feedback. States: NominalPrimaryEnvelope (nominal autonomous/C2 envelope within 24.0-42.0 m/s horizontal, <= 5000.0 m ceiling, healthy ESAD 100 Hz bus and C2 link); AirspeedDiveCapClamped (engagement airspeed approaching or exceeding 55.0 m/s cap, 80.0 m/s VNE; Simplex safety controller overrides to Abort Engaging / level pull-up); EsadBusWatchdogFaultFallback (RS-485 incomplete frame > 10.0 ms, CRC-16 mismatch, or ESAD brownout < 14.0 V; RPI CM5 commands immediate ESAD abort / irreversible Power Off ESAD); CriticalBatteryOrGeofenceRtb (Bingo <= 0.20 reserve, bus < 36.0 V, or >= 105.0 s GCS link loss triggers autonomous RTL holding with ESAD disarmed). */
        state def RtaEnvelopeMonitorState {
            state NominalPrimaryEnvelope;
            state AirspeedDiveCapClamped;
            state EsadBusWatchdogFaultFallback;
            state CriticalBatteryOrGeofenceRtb;
            transition T_Init first Initial then NominalPrimaryEnvelope;
            transition T_NomToClamp first NominalPrimaryEnvelope accept airspeedAbove55MsInDive then AirspeedDiveCapClamped;
            transition T_ClampToNom first AirspeedDiveCapClamped accept airspeedRecoveredWithinEnvelope then NominalPrimaryEnvelope;
            transition T_NomToEsadFault first NominalPrimaryEnvelope accept esadWatchdogOrCrcTimeout10Ms then EsadBusWatchdogFaultFallback;
            transition T_NomToRtb first NominalPrimaryEnvelope accept criticalBatteryOrGcsFailsafeOrGeofence then CriticalBatteryOrGeofenceRtb;
            transition T_ClampToRtb first AirspeedDiveCapClamped accept abortEngagementEscalatedToRtl then CriticalBatteryOrGeofenceRtb;
            transition T_EsadFaultToRtb first EsadBusWatchdogFaultFallback accept missionAbortedAfterEsadSafe then CriticalBatteryOrGeofenceRtb;
            transition T_RtbToTerminal first CriticalBatteryOrGeofenceRtb then Terminal;
        }
        doc /* Mapped 1:1 to uc-03: Enforce software ASTM F3269-17 Simplex RTA boundaries on Cube orange+ across DroneCAN CAN 1/CAN 2 actuators, preventing exceedance of 55.0 m/s engagement and 80.0 m/s VNE limits. */
        use case def UC_03_MonitorFlightEnvelopeAndSimplexRta {
            subject FlightControllerCubeOrangePlus;
            actor Pilot;
            objective "Maintain inner-loop aerodynamic stability and automatically abort or clamp dive trajectories exceeding safety thresholds.";
        }
        doc /* Mapped 1:1 to uc-04: Maintain controlled flight and safe ordnance posture during GNSS spoofing/denial (Disable GNSS DR mode) or C2 link loss (105.0 s GCS Failsafe RTL + ESAD disarm). */
        use case def UC_04_ExecuteGnssDeniedAndLostLinkFailsafe {
            subject NavigationAndAirDataSuite;
            actor Pilot;
            objective "Transition seamlessly to RM3100/SKYE2 dead-reckoning and execute Disarm ESAD On GCS Timeout + RTL on sustained C2 loss.";
        }
        item def CanBusMessageFrame {
            doc /* DroneCAN frame carrying actuator commands, power/ESC telemetry, RM3100 mag/baro, or SKYE2 airspeed. */
            attribute busChannel : String = "CAN1_OR_CAN2";
            attribute nodeId : Integer = 1;
        }
        item def UartSerialPacket {
            doc /* Point-to-point internal UART serial packet between Cube orange+ and RPI CM5, Septentrio GNSS, Trip6, or DTC Radio (IF-SER-001..004). */
            attribute channelIndex : Integer = 1;
        }
        item def UsbServicePacket {
            doc /* Ground firmware/config/log USB data behind lockable umbilical lid (IF-USB-001). */
            attribute umbilicalLidLocked : Boolean = true;
        }
        item def GnssRfSignal {
            doc /* Multi-constellation GPS/GLONASS/GALILEO RF feed from Talysman TW3972EXF to Septentrio Asterx-m3 pro (IF-RF-002). */
            attribute rtkFixValid : Boolean = true;
        }
        item def SurfaceDeflectionCommand {
            doc /* Servo actuator position command across 4x tail ruddervators (#1-#4) and 4x wing roll panels (#5-#8). */
            attribute surfaceAngleDeg : Real = 0.0;
        }
        item def Can1StarTapInterface {
            doc /* CAN 1 multi-drop star/tap bus linking Cube orange+, EPS tap, Power Meter tap, and 4x HV6160 tail fin servos via 4x 120.0 cm stubs and 970.0 cm trunk (IF-CAN1-001). */
            attribute masterEnd : String = "DroneCanBusPort";
            attribute nodeEnd : String = "DroneCanBusPort";
        }
        item def Can2SeriesDaisyChainInterface {
            doc /* CAN 2 strict series daisy-chain: Cube orange+ -> CAN/power splitter PCB -> Wings #5->#6->#7->#8 -> Mag #2 -> Mag #1 -> CUAV SKYE2 Pitot (IF-CAN2-001). */
            attribute masterEnd : String = "DroneCanBusPort";
            attribute chainEnd : String = "DroneCanBusPort";
        }
        item def CompanionAutopilotSerialInterface {
            doc /* Bidirectional ASTK point-to-point UART serial link between Cube orange+ and RPI CM5004032 (IF-SER-001). */
            attribute fcEnd : String = "UartSerialPort";
            attribute companionEnd : String = "UartSerialPort";
        }
        doc /* Verify software Simplex RTA on Cube orange+ clamps dive speed <= 55.0 m/s and commands CAN 1 / CAN 2 HV6160 servos cleanly without any standalone RTA box. */
        test case def TC_03_SimplexRtaEnvelopeAndActuation {
            subject FlightControllerCubeOrangePlus;
            verify requirement REQ_SC_05, REQ_SC_06, REQ_SAF_02;
            objective "Confirm Abort Engaging fires above 55.0 m/s and CAN 1 / CAN 2 isolation preserves roll/pitch authority.";
            step verifyZeroStandaloneRtaHardware;
            step injectOverspeedAbove55MsInDive;
            step confirmRtaAbortEngagingAndLevelRecovery;
        }
        doc /* Verify pre-flight pitot thresholds (3.0/10.0 m/s), Disable GNSS INS/DR transition, and 100 Hz RS-485 ESAD watchdog fallback. */
        test case def TC_04_GnssDeniedDrAndPaceLinkFailsafe {
            subject NavigationAndAirDataSuite;
            verify requirement REQ_SC_07, REQ_SC_08;
            objective "Confirm seamless DR fallback on GNSS loss and deterministic ESAD disarm on > 10.0 ms RS-485 watchdog loss.";
            step verifyPitotCalmAndAirflowChecks;
            step triggerDisableGnssAndVerifyDrMode;
            step injectRs485WatchdogTimeout10Ms;
        }
        doc /* Execute EKF2 state estimation, inner-loop stabilization, DroneCAN actuation (CAN 1 fins #1-#4, CAN 2 wings #5-#8), and software-hosted ASTM F3269-17 Simplex RTA monitor + GCS/GPS failsafes on Cube orange+ (zero standalone RTA box). */
        capability def AutonomousFlightControlAndSimplexRta;
        doc /* Execute SwarmC2 IP bridge and 100 Hz RS-485 CRC-16 XModem ESAD master polling + DSC_IN1 arm GPIO on RPI CM5004032, alongside Septentrio RTK GNSS with manual/automatic Disable GNSS INS/DR fallback via dual RM3100 and SKYE2 heated pitot. */
        capability def CompanionSupervisionAndGnssDeniedNav;
        doc /* Mapped 1:1 to us-04: Cube orange+ EKF2 and software Simplex RTA command tail fins #1-#4 (CAN 1 4x 120 cm stubs) and wing panels #5-#8 (CAN 2 splitter daisy-chain), clamping 55.0 m/s engagement cap and 80.0 m/s VNE (GAP-02). */
        interaction def INT_04_AutopilotRtaAndSurfaceActuation {
        }
        doc /* Mapped 1:1 to us-05: Septentrio RTK GNSS loss or SwarmC2 Disable GNSS activates INS/DR mode via 2x RM3100 + SKYE2 pitot, coordinated with PACE C2 switching (DIR -> OMNI -> 105.0 s GCS Failsafe RTL). */
        interaction def INT_05_GnssDeniedDeadReckoningAndPaceLink {
        }
        doc /* BOM-AV-010: Cube orange+ primary autopilot / INS / EKF2 with CAN 1, CAN 2, 4x Serial, and USB Ext behind lockable lid. Hosts software ASTM F3269-17 Simplex RTA monitor and failsafe statecharts (ZERO standalone RTA hardware box). */
        part def FlightControllerCubeOrangePlus {
            attribute autopilotModel : String = "Cube orange+";
            attribute canBusCount : Integer = 2;
            attribute serialPortCount : Integer = 4;
            attribute standaloneRtaBoxCount : Integer = 0;
            attribute simplexRtaSoftwareHosted : Boolean = true;
            attribute gcsFailsafeTimeoutExampleSec : Real = 105.0;
            attribute engagementSpeedCapMs : Real = 55.0;
            attribute structuralVneSpeedMs : Real = 80.0;
            port inout can1Master : DroneCanBusPort;
            port inout can2Master : DroneCanBusPort;
            port inout serialRpi : UartSerialPort;
            port inout serialGnss : UartSerialPort;
            port inout serialTrip6 : UartSerialPort;
            port inout serialRadioAndUsbExt : SerialAndUsbServicePort;
        }
        doc /* BOM-AV-011: RPI CM5004032 companion mission computer (OC Master). Bridges SwarmC2 IP over ETH, communicates with Cube orange+ over Serial, and supervises Artron ESAD over 115200 bps 100 Hz CRC-16 XModem RS-485 plus DSC_IN1 1 kHz 2-pulse arm GPIO. */
        part def CompanionComputeRpiCm5 {
            attribute computeModel : String = "RPI CM5004032";
            attribute rs485BaudBps : Integer = 115200;
            attribute esadPollFrequencyHz : Real = 100.0;
            attribute esadPollPeriodSec : Real = 0.01;
            attribute esadReplyMaxLatencyMs : Real = 5.0;
            attribute esadIncompleteTimeoutMs : Real = 10.0;
            attribute crcPolynomial : String = "CRC-16 XModem (init 0x0000, poly 0x1021)";
            attribute dscIn1PulseFreqHz : Real = 1000.0;
            attribute dscIn1PulseCount : Integer = 2;
            port inout serialFc : UartSerialPort;
            port inout ethSwitch : EthernetFabricPort;
            port inout esadOcControl : EsadOcControlBundlePort;
        }
        doc /* BOM-AV-014..017: Septentrio Asterx-m3 pro RTK GNSS + Talysman TW3972EXF antenna on Serial, plus 2x mRo RM3100 dual mag/baro and heated CUAV SKYE2 pitot on CAN 2 series daisy-chain. Supports Disable GNSS INS/DR fallback. */
        part def NavigationAndAirDataSuite {
            attribute gnssReceiverModel : String = "Septentrio Asterx-m3 pro";
            attribute gnssAntennaModel : String = "Talysman TW3972EXF";
            attribute magBaroModel : String = "mRo RM3100";
            attribute magBaroCount : Integer = 2;
            attribute pitotModel : String = "CUAV SKYE2 heated pitot";
            attribute calmAirPitotMaxMs : Real = 3.0;
            attribute airflowCheckPitotMinMs : Real = 10.0;
            attribute supportsGnssDeniedDr : Boolean = true;
            port inout serialGnss : UartSerialPort;
            port inout can2DaisyIn : DroneCanBusPort;
            port in sensorPowerIn : RegulatedRailInPort;
        }
        doc /* BOM-AV-018..020: 4x HV6160-DroneCAN tail ruddervator servos (#1-#4) on CAN 1 (4x 120.0 cm stubs) plus 4x HV6160-DroneCAN wing roll servos (#5-#8) on CAN 2 series daisy-chain via CAN/power splitter PCB on 8.0 V EPS rail. */
        part def DroneCanSurfaceActuation {
            attribute servoModel : String = "HV6160-DroneCAN";
            attribute tailFinServoCount : Integer = 4;
            attribute wingPanelServoCount : Integer = 4;
            attribute finCan1StubLengthCm : Real = 120.0;
            attribute splitterPcbModel : String = "CAN/power splitter PCB";
            attribute servoSupplyVoltageV : Real = 8.0;
            port inout can1TailFins : DroneCanBusPort;
            port inout can2SplitterIn : DroneCanBusPort;
            port inout can2DaisyOutToSensors : DroneCanBusPort;
            port in servo8VIn : RegulatedRailInPort;
        }
    }
    doc /* Subsystem Package 3 covering Onboard ETH Switch / External Interface / DTC C2 Radio, Nighthawk2UZ + Trip6 EO/IR Seeker, and Artron ESAD + Sensor Board + Warhead Holder. */
    package MissionPayloadsCommsAndOrdnanceSafety {
        port def EthernetFabricPort {
            attribute direction = "inout";
            attribute itemType = "EthernetIpPacket";
            attribute protocol = "IF-ETH-001 (Switched onboard Ethernet IP)";
        }
        port def RfDatalinkAirPort {
            attribute direction = "inout";
            attribute itemType = "RfC2DatalinkSignal";
            attribute protocol = "IF-RF-001 (4.4-5.0 GHz AES-256 FHSS RF)";
        }
        port def EsadOcControlBundlePort {
            attribute direction = "inout";
            attribute itemType = "Rs485EsadProtocolFrame, DscIn1ArmPulseTrain";
            attribute protocol = "IF-ORD-001 (RS-485 115200 bps CRC-16), IF-ORD-002 (DSC_IN1 1 kHz 2-pulse)";
        }
        port def EsadJ100SlavePort {
            attribute direction = "inout";
            attribute itemType = "Rs485EsadProtocolFrame, DscIn1ArmPulseTrain";
            attribute protocol = "IF-ORD-001 (RS-485 Slave), IF-ORD-002 (DSC_IN1 Input)";
        }
        port def InertialSs1AccelInPort {
            attribute direction = "in";
            attribute itemType = "InertialLaunchAccelPulse";
            attribute protocol = "Mechanical inertial SS1 acceleration sense";
        }
        doc /* Receive 0xB0 WELCOME from Artron ESAD, query 0x13 VERSION and 0x11 PBIT, and verify bit 12 internal HV < 50.0 V while RBF #3 UMB (< 0.5 Ohm) remains installed (GAP-06). */
        action def ExecuteEsadBootAndPbit(in vdcInV : Real, in rbf3Installed : Boolean, out welcomeOk : Boolean, out pbitHvUnder50V : Boolean);
        doc /* Execute STANAG 4187 barrier gating: power-before-pull RBF #3 removal -> SS1 launch accel -> SS2 Safe Distance Exceed == 1 (GAP-07) -> Arm Stage 2 DSC_IN1 (1 kHz, 2 pulses) -> 0x12 HIGHVOLTAGE charge (0-1800 V). */
        action def TransitionEsadArmingSequence(in rbf3RemovedAfterPower : Boolean, in ss1LaunchSensed : Boolean, in ss2SafeDistExceeded : Boolean, in dscIn1Valid : Boolean, out armState : Integer, out hvChargedV : Real);
        doc /* Execute >= 5.0 s ESAD self-destruct hold + Slide-to-Confirm, irreversible Power Off ESAD, or Disarm ESAD On GCS Timeout via 0x10 EXCHANGE Abort bits. */
        action def CommandEsadAbortAndSelfDestruct(in holdDurationSec : Real, in slideConfirmed : Boolean, in gcsTimeoutActive : Boolean, out hvDischarged : Boolean, out faultLockedOut : Boolean);
        doc /* Stabilize Nighthawk2UZ gimbal (1280x720 Day/Thermal, X40 zoom) and hold Trip6 auto-tracker lock for 2.0-5.0 s; command Abort Engaging if airspeed > 55.0 m/s. */
        action def AcquireAndTrackTerminalTarget(in trackHoldSec : Real, in airspeedMs : Real, in targetElevDeg : Real, out targetLocked : Boolean, out abortEngaging : Boolean);
        doc /* Execute in-flight Reboot Gimbal command over ETH Switch if Nighthawk2UZ / Trip6 video freezes while keeping external interface lid locked. */
        action def RebootGimbalAndBridgeEthernet(in gimbalFreezeDetected : Boolean, in externalLidLocked : Boolean, out gimbalRecovered : Boolean);
        doc /* GAP-01: Artron ESAD J100 VDC_IN requires 14.0-32.0 V (28.0 V ICD nominal); Avenger V2.5 EPS outputs 14.0 V with zero brownout margin. */
        constraint def EsadInputVoltageAndBrownoutConstraint {
            in vdcInV : Real && attribute invariantExpr : String = "vdcInV >= 14.0 and vdcInV <= 32.0";
        }
        doc /* GAP-04: Strict OC Master / ESAD Slave 115200 bps 8N1 polling at 100 Hz (0.01 s), <= 5.0 ms reply latency, <= 10.0 ms incomplete packet timeout. */
        constraint def EsadRs485ProtocolTimingConstraint {
            in baudBps : Integer && in pollHz : Real && in replyMs : Real && in timeoutMs : Real && attribute invariantExpr : String = "baudBps == 115200 and pollHz == 100.0 and replyMs <= 5.0 and timeoutMs <= 10.0";
        }
        doc /* GAP-06: ESAD RBF #3 (UMB < 0.5 Ohm @ 20 mA) MUST stay installed until UAV Power RBF #2 ON and all 8 pre-arm preconditions pass. */
        constraint def EsadRbf3PowerBeforePullConstraint {
            in uavPoweredBeforeRbf3Pull : Boolean && in umbResistanceOhm : Real && attribute invariantExpr : String = "uavPoweredBeforeRbf3Pull == true and umbResistanceOhm < 0.5";
        }
        doc /* GAP-07: Physical arming requires Safe Distance Exceed == 1 (SS2 active) and SS1 launch accel sensed. */
        constraint def EsadSafeDistanceExceedConstraint {
            in safeDistanceExceeded : Boolean && in ss1Sensed : Boolean && attribute invariantExpr : String = "safeDistanceExceeded == true and ss1Sensed == true";
        }
        doc /* Warhead mass <= 5.0 kg (4.98 +/- 0.02 kg tested), PBIT bit 12 safe HV < 50.0 V, J401 fire envelope 0.0-1800.0 V. */
        constraint def WarheadMassAndPbitHvSafetyConstraint {
            in warheadMassKg : Real && in pbitHvV : Real && in fireHvV : Real && attribute invariantExpr : String = "warheadMassKg <= 5.0 and pbitHvV < 50.0 and fireHvV >= 0.0 and fireHvV <= 1800.0";
        }
        doc /* Engagement airspeed <= 55.0 m/s, Trip6 track hold 2.0-5.0 s, terminal CEP <= 0.5 m. */
        constraint def EngagementSpeedAndTrackHoldConstraint {
            in airspeedMs : Real && in trackHoldSec : Real && in cepM : Real && attribute invariantExpr : String = "airspeedMs <= 55.0 and trackHoldSec >= 2.0 and trackHoldSec <= 5.0 and cepM <= 0.5";
        }
        requirement def REQ_L_04 {
            doc /* Loss L4: Unintended warhead detonation during ground handling/launch or collateral impact outside authorized target. */
            attribute severity : String = "Catastrophic";
        }
        requirement def REQ_H_04 {
            doc /* Hazard H4: Artron ESAD premature arming, HV >= 50.0 V during PBIT, premature DSC_IN1 fault, or out-of-order RBF #3 removal. */
            attribute severity : String = "Catastrophic";
        }
        requirement def REQ_H_05 {
            doc /* Hazard H5: EO/IR gimbal saturation above 55.0 m/s dive speed or prolonged C2 link loss while warhead is armed. */
            attribute severity : String = "Catastrophic";
        }
        requirement def REQ_UCA_05 {
            doc /* UCA-05: Operator removes ESAD RBF #3 before UAV+ESAD power-on, or RPI CM5 asserts DSC_IN1 prior to Arm Stage 2. */
            attribute ucaType : String = "Provided Out of Sequence";
            @TriggersHazard("REQ_H_04");
        }
        requirement def REQ_UCA_06 {
            doc /* UCA-06: SwarmC2 or OC Master commands ESAD HV charging before SS1 launch acceleration and SS2 Safe Distance Exceed == 1. */
            attribute ucaType : String = "Provided Too Early";
            @TriggersHazard("REQ_H_04");
        }
        requirement def REQ_UCA_07 {
            doc /* UCA-07: Autopilot continues terminal engagement above 55.0 m/s without Abort Engaging, or retains ESAD armed across GCS failsafe timeout. */
            attribute ucaType : String = "Provided Unsafely";
            @TriggersHazard("REQ_H_05");
        }
        requirement def REQ_SC_09 {
            text = "SC-09: Enforce power-before-pull ordering (RBF #2 ON -> 0xB0 WELCOME -> 0x11 PBIT < 50.0 V -> 8 preconditions pass -> SwarmC2 prompt to remove RBF #3, GAP-06).";
            @SafetyRealises("REQ_UCA_05");
        }
        requirement def REQ_SC_10 {
            text = "SC-10: Verify J100 UMB continuity < 0.5 Ohm at 20 mA and lock out ESAD (FaultStates bit 4) if DSC_IN1 1 kHz 2-pulse arrives before Arm Stage 2.";
            @SafetyRealises("REQ_UCA_05");
        }
        requirement def REQ_SC_11 {
            text = "SC-11: Gate 0x12 HIGHVOLTAGE charging (0-1800 V) and J401 fire strictly behind SS1 launch accel, SS2 Safe Distance Exceed == 1 (GAP-07), Sensor Board IRQ_L, and OC Arm Enable.";
            @SafetyRealises("REQ_UCA_06");
        }
        requirement def REQ_SC_12 {
            text = "SC-12: Require 2.0-5.0 s EO track hold, enforce <= 55.0 m/s dive Abort Engaging cap, <= 0.5 m CEP, <= 5.0 kg warhead holder mass, and Disarm ESAD On GCS Timeout.";
            @SafetyRealises("REQ_UCA_07");
        }
        requirement def REQ_SAF_04 {
            text = "GAP-04 Mitigation: Bridge RPI CM5004032 (Ring 2) to Artron ESAD (Ring 3) via 100 Hz (0.01 s) 115200 bps RS-485 CRC-16 XModem with 10.0 ms watchdog timeout.";
        }
        requirement def REQ_SAF_06 {
            text = "GAP-06 Mitigation: Prevent ESAD boot fault by keeping ESAD RBF #3 installed until UAV Power RBF #2 and ESAD PBIT complete cleanly.";
        }
        requirement def REQ_SAF_07 {
            text = "GAP-07 Mitigation: Align SwarmC2 UI wording strictly with ESAD ICD Safe Distance Exceed == 1 (SS2 Active) requirement prior to arming.";
        }
        requirement def REQ_SAF_10 {
            text = "GAP-SEPDIST Disposition: Parameterize unprinted safe-separation distance (m), launch g threshold, arming timer (s), M3/M6 torque, and 4980 g holder datum units pending field calibration sign-off.";
        }
        doc /* STANAG 4187 Artron ESAD safe/arm finite state machine enforcing power-before-pull RBF #3 (GAP-06), SS1, SS2 Safe Distance Exceed (GAP-07), DSC_IN1 gating, and fault lockout. States: SafePowerOff (EPS 14.0 V rail unpowered or irreversible Power Off ESAD selected in SwarmC2); BootAndPbit (14.0 V applied with RBF #3 installed, 0xB0 WELCOME emitted, 0x11 PBIT verifies internal HV < 50.0 V); SafeRbfInstalled (PBIT passed, J100 UMB loop < 0.5 Ohm @ 20 mA intact, awaiting 8 preconditions before SwarmC2 RBF #3 removal prompt); SafeRbfRemoved (RBF #3 removed after power-on, mechanical/inertial SS1 and SS2 still unlatched, DSC_IN1 prohibited); ArmStage1TimerWait (PL-40 launch acceleration sensed by SS1, FlightTimer 1 s/LSB and safe-separation distance check counting toward SS2); ArmStage2Armed (SS2 Safe Distance Exceed == 1 satisfied GAP-07, ready for OC Master DSC_IN1 1 kHz 2-pulse arm enable); HvChargedReady (DSC_IN1 validated, 0x12 HIGHVOLTAGE capacitor charged 0-1800 V, J401 armed for Sensor Board J102->J1 ORed IRQ_L or OC Trigger); DetonatedOrAborted (J401 fired upon proximity/impact IRQ_L or 5.0 s Self-Destruct, or safely discharged via Mission/Arm Abort Enable); FaultLockout (latched on RBF #3 pulled before power-on, PBIT HV >= 50.0 V, premature DSC_IN1 FaultStates bit 4, > 10.0 ms RS-485 loss, or 14.0 V brownout). */
        state def EsadSafeArmState {
            state SafePowerOff;
            state BootAndPbit;
            state SafeRbfInstalled;
            state SafeRbfRemoved;
            state ArmStage1TimerWait;
            state ArmStage2Armed;
            state HvChargedReady;
            state DetonatedOrAborted;
            state FaultLockout;
            transition T_Init first Initial then SafePowerOff;
            transition T_OffToBoot first SafePowerOff accept eps14VAppliedWithRbf3Installed then BootAndPbit;
            transition T_BootToSafeRbf first BootAndPbit accept pbitPassedHvUnder50V then SafeRbfInstalled;
            transition T_BootToFault first BootAndPbit accept pbitFailedOrPrematureRbf3Pull then FaultLockout;
            transition T_RbfInToOut first SafeRbfInstalled accept preconditions8PassedAndRbf3Removed then SafeRbfRemoved;
            transition T_RbfOutToStage1 first SafeRbfRemoved accept ss1LaunchAccelSensed then ArmStage1TimerWait;
            transition T_Stage1ToStage2 first ArmStage1TimerWait accept ss2SafeDistanceExceeded then ArmStage2Armed;
            transition T_Stage2ToHv first ArmStage2Armed accept dscIn1TwoPulsesAndOcArmEnable then HvChargedReady;
            transition T_HvToDetonateOrAbort first HvChargedReady accept sensorIrqLOrAbortOrSelfDestruct then DetonatedOrAborted;
            transition T_AnyArmToFault first ArmStage2Armed accept prematureDscIn1OrRs485WatchdogOrBrownout then FaultLockout;
            transition T_HvToSafeOff first DetonatedOrAborted accept hvDischargedAndPowerOffEsad then SafePowerOff;
            transition T_SafeOffToTerminal first SafePowerOff then Terminal;
            transition T_FaultToTerminal first FaultLockout then Terminal;
        }
        doc /* Primary, Alternate, Contingency, and Emergency (PACE) C2 and navigation degradation state machine across DTC 4.4-5.0 GHz antennas and GNSS/INS modes. States: PrimaryDtcDirTracking (Primary RLOS 60.0/90.0 km over DTC 4.4-5.0 GHz AES-256 FHSS using Ground MARS 23 dBi DIR antenna with Auto Follow rotator); AlternateDtcOmniLocal (Alternate ground/launch and close-in local corridor over Ground OMNI antenna >= 10.0 m separation from UAV); ContingencyGnssDeniedDrFlight (Contingency flight under GNSS jamming/spoofing using SwarmC2 Disable GNSS INS/DR via dual RM3100 + SKYE2 pitot while C2 link remains active); EmergencyLostLinkRtlHolding (Emergency GCS Failsafe triggered after link timeout 105.0 s baseline: autonomous RTL and Disarm ESAD On GCS Timeout active). */
        state def PaceC2LinkState {
            state PrimaryDtcDirTracking;
            state AlternateDtcOmniLocal;
            state ContingencyGnssDeniedDrFlight;
            state EmergencyLostLinkRtlHolding;
            transition T_Init first Initial then AlternateDtcOmniLocal;
            transition T_OmniToDir first AlternateDtcOmniLocal accept postLaunchDirRotatorLockAcquired then PrimaryDtcDirTracking;
            transition T_DirToOmni first PrimaryDtcDirTracking accept dirTrackingDegradedNearFieldFallbackOmni then AlternateDtcOmniLocal;
            transition T_DirToGnssDenied first PrimaryDtcDirTracking accept gnssSpoofOrDisableGnssSelected then ContingencyGnssDeniedDrFlight;
            transition T_GnssDeniedToDir first ContingencyGnssDeniedDrFlight accept gnssRtkRestoredAndEnabled then PrimaryDtcDirTracking;
            transition T_DirToEmergencyRtl first PrimaryDtcDirTracking accept gcsLinkLostExceeding105Sec then EmergencyLostLinkRtlHolding;
            transition T_ContingencyToEmergencyRtl first ContingencyGnssDeniedDrFlight accept gcsLinkLostExceeding105Sec then EmergencyLostLinkRtlHolding;
            transition T_EmergencyToOmni first EmergencyLostLinkRtlHolding accept linkReacquiredInReturnCorridor then AlternateDtcOmniLocal;
            transition T_OmniToTerminal first AlternateDtcOmniLocal then Terminal;
            transition T_EmergencyToTerminal first EmergencyLostLinkRtlHolding then Terminal;
        }
        doc /* Mapped 1:1 to uc-05: Acquire, hold (2.0-5.0 s), and dive onto stationary target at <= 55.0 m/s (0.5 m CEP) using Nighthawk2UZ + Trip6, aborting on > 55.0 m/s or lost track. */
        use case def UC_05_TrackAndEngageTargetWithEoIr {
            subject EoIrSeekerAndTrackerUnit;
            actor PayloadOperator;
            objective "Achieve <= 0.5 m terminal accuracy while enforcing <= 55.0 m/s gimbal saturation safety abort.";
        }
        doc /* Mapped 1:1 to uc-06: Supervise Artron ESAD STANAG 4187 arming via RPI CM5 OC Master (RS-485 100 Hz + DSC_IN1) with SS1, SS2 Safe Distance Exceed == 1, RBF #3 power-before-pull, and Sensor Board IRQ_L / J401 HV fire. */
        use case def UC_06_SuperviseEsadArmAndDetonation {
            subject ArtronEsadAndSensorUnit;
            actor PayloadOperator;
            objective "Guarantee zero premature HV output (< 50.0 V PBIT) and strictly gated detonation only after SS1, SS2, DSC_IN1, and IRQ_L / OC Trigger.";
        }
        item def EthernetIpPacket {
            doc /* Bidirectional switched IP packet across RPI CM5, Trip6, DTC Radio, and External Interface Board (IF-ETH-001). */
            attribute payloadBytes : Integer = 1500;
        }
        item def RfC2DatalinkSignal {
            doc /* Over-the-air 4.4-5.0 GHz AES-256 FHSS bidirectional C2 and video datalink (IF-RF-001). */
            attribute freqMinGHz : Real = 4.4;
            attribute freqMaxGHz : Real = 5.0;
            attribute txPowerW : Real = 2.0;
            attribute aesKeyBits : Integer = 256;
        }
        item def EoIrVideoAndGimbalPacket {
            doc /* 1280x720 Day/Thermal HDMI video and power bundle between Nighthawk2UZ gimbal and Trip6 (IF-VID-001). */
            attribute horizPx : Integer = 1280;
            attribute vertPx : Integer = 720;
            attribute zoomFactor : Real = 40.0;
        }
        item def Rs485EsadProtocolFrame {
            doc /* Half-duplex 115200 bps 8N1 RS-485 frame: [Length >= 5][Header 0x01/0x02][Cmd 0x10/0x11/0x12/0x13/0xB0][Data 0..9 B][CRC-16 XModem] (IF-ORD-001). */
            attribute baudRateBps : Integer = 115200;
            attribute minFrameBytes : Integer = 5;
            attribute maxDataBytes : Integer = 9;
        }
        item def DscIn1ArmPulseTrain {
            doc /* Hardware arm enable discrete on J100 pin 13: 1 kHz (1.0 ms period), 50% duty, 2 pulses, 0..0.7 V low, 2.5..3.3 V high (IF-ORD-002). */
            attribute pulseFreqHz : Real = 1000.0;
            attribute pulseCount : Integer = 2;
            attribute highMinV : Real = 2.5;
            attribute highMaxV : Real = 3.3;
        }
        item def OnboardEthernetAndServiceInterface {
            doc /* Switched Ethernet interconnect linking RPI CM5, Trip6, DTC Radio, and External Interface Board USB/ETH behind lockable lid (IF-ETH-001, IF-USB-001). */
            attribute peerAEnd : String = "EthernetFabricPort";
            attribute peerBEnd : String = "EthernetFabricPort";
        }
        item def EsadControlAndInterlockInterface {
            doc /* Ring 2 -> Ring 3 supervised ESAD control interface (GAP-04): RS-485 100 Hz CRC-16 XModem + DSC_IN1 1 kHz 2-pulse + J100 UMB RBF #3 (< 0.5 Ohm @ 20 mA) + J102->J1 sensor board + J401 HV fire (IF-ORD-001..005). */
            attribute ocMasterEnd : String = "EsadOcControlBundlePort";
            attribute esadSlaveEnd : String = "EsadJ100SlavePort";
        }
        doc /* Verify Nighthawk2UZ 1280x720 X40 + Trip6 2.0-5.0 s track hold, <= 55.0 m/s engagement speed cap Abort Engaging, and in-flight Reboot Gimbal recovery. */
        test case def TC_05_EoIrTargetTrackAndSpeedCapAbort {
            subject EoIrSeekerAndTrackerUnit;
            verify requirement REQ_SC_12;
            objective "Confirm engagement aborts cleanly when airspeed exceeds 55.0 m/s or track hold < 2.0 s, and gimbal reboot recovers video over ETH.";
            step verifyTrackHold2To5Seconds;
            step injectAirspeedAbove55MsAndVerifyAbort;
            step executeInFlightRebootGimbal;
        }
        doc /* Verify Artron ESAD 100 Hz RS-485 CRC-16 XModem framing, PBIT < 50.0 V, premature DSC_IN1 Fault bit 4 lockout, SS1/SS2 Safe Distance Exceed, and J401 0-1800 V gate. */
        test case def TC_06_EsadProtocolInterlockAndHvFireGate {
            subject ArtronEsadAndSensorUnit;
            verify requirement REQ_SC_09, REQ_SC_10, REQ_SC_11, REQ_SAF_04, REQ_SAF_07;
            objective "Confirm zero HV charge before SS1 + SS2 + DSC_IN1 and deterministic FaultLockout on out-of-order RBF #3 or DSC_IN1.";
            step verifyPbitSafeHvBelow50V;
            step verifyPrematureDscIn1LatchesFaultBit4;
            step verifySs1AndSs2SafeDistGateHvCharge;
        }
        doc /* Provide 4.4-5.0 GHz AES-256 FHSS C2 and HD video over 2.0 W (2x 1.0 W) dual MPSL4400 antennas (60.0/90.0 km RLOS), internal Ethernet fabric, Nighthawk2UZ 1280x720 Day/Thermal X40 gimbal, and Trip6 auto-tracker (2.0-5.0 s hold, <= 55.0 m/s cap, 0.5 m CEP). */
        capability def EncryptedDatalinkAndEoIrTerminalGuidance;
        doc /* Enforce Artron ESAD (AB00-0054-01AA-0005) STANAG 4187 safe/arm barriers: SS1 launch accel, SS2 safe separation (Safe Distance Exceed == 1, GAP-07), DS proximity/impact IRQ_L, UMB < 0.5 Ohm @ 20 mA RBF #3 (power-before-pull GAP-06), DSC_IN1 1 kHz 2-pulse, RS-485 CRC-16 XModem, and < 50.0 V PBIT / 0-1800 V J401 HV fire into <= 5.0 kg warhead. */
        capability def Stanag4187SafeArmAndOrdnanceInterlock;
        doc /* Mapped 1:1 to us-06: Nighthawk2UZ (1280x720 Day/Thermal X40) and Trip6 (Power+HDMI, ETH, Serial) hold target lock 2.0-5.0 s, execute shallow 15.0 deg / max 22.0 deg dive capped at 55.0 m/s (0.5 m CEP), support Reboot Gimbal recovery, and export 5W/CFF. */
        interaction def INT_06_EoIrSeekerTrackAndTerminalDive {
        }
        doc /* Mapped 1:1 to us-07: RPI CM5 OC Master executes 100 Hz RS-485 0x10 EXCHANGE (CRC-16 XModem), confirms SS1 launch accel, SS2 Safe Distance Exceed == 1 (GAP-07), 14.0 V GE_POW health (GAP-01), Stage 2 DSC_IN1 1 kHz 2-pulse, 0x12 HIGHVOLTAGE charge (0-1800 V), and Sensor Board J102->J1 ORed IRQ_L -> J401 detonation into <= 5.0 kg warhead. */
        interaction def INT_07_EsadDualBarrierArmAndDetonation {
        }
        doc /* BOM-AV-012, BOM-AV-013, BOM-AV-021, BOM-AV-022: Internal ETH Switch + External Interface Board (USB/ETH behind lockable lid) + DTC 4.4-5.0 GHz AES-256 FHSS Radio (2.0 W / 2x 1.0 W, 8.0-17.0 V from 12.0 V EPS rail, 60.0/90.0 km RLOS) + 2x MPSL4400 antennas. */
        part def OnboardEthernetAndC2RadioUnit {
            attribute radioModel : String = "DTC 4.4-5.0 GHz AES-256 FHSS";
            attribute antennaModel : String = "2x MPSL4400";
            attribute freqMinGHz : Real = 4.4;
            attribute freqMaxGHz : Real = 5.0;
            attribute totalTxPowerW : Real = 2.0;
            attribute perAntennaPowerW : Real = 1.0;
            attribute aesBits : Integer = 256;
            attribute inputVoltageMinV : Real = 8.0;
            attribute inputVoltageMaxV : Real = 17.0;
            attribute nominalEpsRailV : Real = 12.0;
            attribute rlosBaselineKm : Real = 60.0;
            attribute rlosExtendedV25Km : Real = 90.0;
            attribute rlosExtendedV1Km : Real = 180.0;
            port in radio12VIn : RegulatedRailInPort;
            port inout fcSerialAndUsbExt : SerialAndUsbServicePort;
            port inout ethRpiPort : EthernetFabricPort;
            port inout ethTrip6Port : EthernetFabricPort;
            port inout rfDatalinkOut : RfDatalinkAirPort;
        }
        doc /* BOM-AV-023 & BOM-AV-024: Nighthawk2UZ 2-axis stabilized gimbal (1280x720 Day/Thermal, X40 zoom, P -45..+135 deg, Y/R +/-165 deg) + Trip6 camera compute (Power+HDMI, ETH, Serial to Cube orange+). */
        part def EoIrSeekerAndTrackerUnit {
            attribute gimbalModel : String = "Nighthawk2UZ";
            attribute trackerComputeModel : String = "Trip6";
            attribute videoWidthPx : Integer = 1280;
            attribute videoHeightPx : Integer = 720;
            attribute zoomFactor : Real = 40.0;
            attribute pitchMinDeg : Real = -45.0;
            attribute pitchMaxDeg : Real = 135.0;
            attribute yawRollMinDeg : Real = -165.0;
            attribute yawRollMaxDeg : Real = 165.0;
            attribute engagementSpeedCapMs : Real = 55.0;
            attribute trackHoldMinSec : Real = 2.0;
            attribute trackHoldMaxSec : Real = 5.0;
            attribute maxTargetElevAtStartDeg : Real = 15.0;
            attribute shallowApproachAngleDeg : Real = 15.0;
            attribute terminalCepMaxM : Real = 0.5;
            attribute terminalCepMaxCm : Real = 50.0;
            port in gimbalPowerIn : RegulatedRailInPort;
            port inout serialFc : UartSerialPort;
            port inout ethSwitch : EthernetFabricPort;
        }
        doc /* BOM-ORD-001..005: Artron ESAD (AB00-0054-01AA-0005, STANAG 4187, MIL-STD-461, 3x M3 75 mm BCD) + ESAD Sensor Board (2x M2, J102->J1 5V0/DIST_COMM1_2/ORed IRQ_L) + Warhead Holder (5.0 kg max, 4.98 +/- 0.02 kg tested, CG 30.57 +/- 1.00, 173.00, 1.5 mm HEX) + RBF #3 UMB (< 0.5 Ohm @ 20 mA) + J401 (0-1800 V, < 50.0 V PBIT safe). */
        part def ArtronEsadAndSensorUnit {
            attribute esadPartNumber : String = "AB00-0054-01AA-0005";
            attribute standardCompliance : String = "STANAG 4187 / MIL-STD-461";
            attribute vdcInMinV : Real = 14.0;
            attribute vdcInNominalIcdV : Real = 28.0;
            attribute vdcInMaxV : Real = 32.0;
            attribute umbMaxResistanceOhm : Real = 0.5;
            attribute umbSenseCurrentMa : Real = 20.0;
            attribute sensorBoardSupplyV : Real = 5.0;
            attribute pbitSafeHvMaxV : Real = 50.0;
            attribute hvOutputMinV : Real = 0.0;
            attribute hvOutputMaxV : Real = 1800.0;
            attribute hvScaleVPerLsb : Real = 1.0;
            attribute flightTimerScaleSecPerLsb : Real = 1.0;
            attribute accelScaleGPerLsb : Real = 0.0039;
            attribute warheadMaxMassKg : Real = 5.0;
            attribute warheadTestedMassKg : Real = 4.98;
            attribute warheadTestedTolKg : Real = 0.02;
            attribute warheadCgCtqNominal : Real = 30.57;
            attribute warheadCgCtqTol : Real = 1.0;
            attribute warheadOverallCtq : Real = 173.0;
            attribute hexToolSizeMm : Real = 1.5;
            attribute esadMountHoleM3Mm : Real = 3.0;
            attribute esadMountBcdMm : Real = 75.0;
            attribute sensorMountHoleM2Mm : Real = 2.0;
            attribute opcodeExchange : String = "0x10 (req 8B, resp 14B)";
            attribute opcodePbit : String = "0x11 (req 5B, resp 7B)";
            attribute opcodeHighVoltage : String = "0x12 (req 5B, resp 8B)";
            attribute opcodeVersion : String = "0x13";
            attribute opcodeWelcome : String = "0xB0";
            port in esad14VIn : RegulatedRailInPort;
            port inout ocControlIn : EsadJ100SlavePort;
            port in inertialSs1In : InertialSs1AccelInPort;
        }
    }
    doc /* Subsystem Package 4 covering ELI PL-40 Rev 2.6 Pneumatic Launcher, SwarmC2 Windows 11 Rugged Tablet Console, and Ground DTC RF Station / MARS Rotator / ESD Grounding. */
    package GroundLaunchAndCommandSegment {
        port def MechLaunchRailOutputPort {
            attribute direction = "out";
            attribute itemType = "MechanicalThrustAndLaunchLoad";
            attribute protocol = "IF-MECH-001 (Strictly mechanical launch rail; zero electrical wires)";
        }
        port def GroundRfAirPort {
            attribute direction = "inout";
            attribute itemType = "RfC2DatalinkSignal";
            attribute protocol = "IF-RF-001 (4.4-5.0 GHz MARS 23 dBi DIR / OMNI RF)";
        }
        port def GcsStationControlPort {
            attribute direction = "inout";
            attribute itemType = "GroundC2TelemetryAndCommandStream, RotatorAzimuthControlSignal";
            attribute protocol = "IF-GND-001 (Wired / 200.0 m fiber IP + Rotator control)";
        }
        doc /* Charge PL-40 air tank to 13.0-14.0 bar (<= 8.0 min, 0.05 bar hysteresis) while monitoring 18.0 V Makita BL1860B packs for <= 14.5 V UVLO cutoff and >= 16.0 V (5.0 s) restart. */
        action def ChargePl40CompressorWithUvloCheck(in packVoltageV : Real, in targetPressureBar : Real, out tankPressureBar : Real, out uvloPaused : Boolean);
        doc /* Verify 13.0-14.0 bar pressure, <= 17.0 kg MTOW (<= 30.0 kg rail limit), <= 12.0 m/s ground headwind, <= 25.0 m/s exit limit (GAP-03), red safety pin pull, Main Valve 4 open, and simultaneous >= 2.0 s dual firing hold. */
        action def ExecuteLaunchGoNoGoAndDualTrigger(in pressureBar : Real, in uavMassKg : Real, in headwindMs : Real, in redPinRemoved : Boolean, in mainValve4Open : Boolean, in dualSwitchHoldSec : Real, out carriageReleased : Boolean);
        doc /* Execute GAP-SCRUB SAFE_SCRUB_ABORT: shut Main Valve 4, bleed pneumatic tank safely, reinstall carriage red safety pin, and command UAV ESAD irreversible Power Off / RBF #3 reinsertion before RBF #2 disconnect. */
        action def DepressurizeAndScrubPl40Launcher(in scrubRequested : Boolean, in mainValve4Closed : Boolean, out tankDepressurizedBar : Real, out redPinReinstalled : Boolean);
        doc /* Enforce Pilot/Payload/Launch Assistant >= 8 char login, ESD grounding touch, >= 10.0 m radio separation, and Antenna Rotator calibration BEFORE touching UAV. */
        action def AuthenticateOperatorAndCalibrateRotator(in roleName : String, in passwordChars : Integer, in esdGrounded : Boolean, in radioSeparationM : Real, out groundReady : Boolean);
        doc /* Format and export 5W / Call For Fire (CFF) targeting data from SwarmC2 to ATAK, SitaWare HQ, or DELTA. */
        action def ExportTargetReport5wCff(in targetCoordsValid : Boolean, in c2Connected : Boolean, out reportExported : Boolean);
        doc /* GAP-03: MTOW <= 30.0 kg (Avenger V2.5 17.0 kg), rail pressure 13.0-14.0 bar, exit velocity <= 25.0 m/s (~23.0 m/s at 17.0 kg), ground headwind <= 12.0 m/s. */
        constraint def Pl40MassAndExitVelocityConstraint {
            in uavMassKg : Real && in pressureBar : Real && in exitVelMs : Real && in windMs : Real && attribute invariantExpr : String = "uavMassKg <= 30.0 and pressureBar >= 13.0 and pressureBar <= 14.0 and exitVelMs <= 25.0 and windMs <= 12.0";
        }
        doc /* Compressor UVLO cuts off <= 14.5 V, requires >= 16.0 V after 5.0 s to restart, and dual firing switches require >= 2.0 s simultaneous hold. */
        constraint def Pl40UvloAndDualSwitchConstraint {
            in packVoltageV : Real && in dualHoldSec : Real && attribute invariantExpr : String = "packVoltageV > 14.5 and dualHoldSec >= 2.0";
        }
        doc /* Role password >= 8 chars, mission name <= 24 chars, waypoint altitude 50.0-3000.0 m, loiter radius >= 300.0 m. */
        constraint def SwarmC2AuthAndMissionBoundsConstraint {
            in passwordLen : Integer && in missionNameLen : Integer && in waypointAltM : Real && in loiterRadiusM : Real && attribute invariantExpr : String = "passwordLen >= 8 and missionNameLen <= 24 and waypointAltM >= 50.0 and waypointAltM <= 3000.0 and loiterRadiusM >= 300.0";
        }
        doc /* Mandatory transport box ESD grounding before handling and >= 10.0 m separation between UAV and Ground Radio Box during prep. */
        constraint def GroundCrewSeparationAndEsdConstraint {
            in esdGrounded : Boolean && in separationM : Real && attribute invariantExpr : String = "esdGrounded == true and separationM >= 10.0";
        }
        requirement def REQ_H_06 {
            doc /* Hazard H6: Uncontrolled PL-40 rail discharge, > 25.0 m/s over-velocity (< 15 kg at 14 bar), sub-stall exit (< 24.0-26.0 m/s), or unbleed hangfire crew approach. */
            attribute severity : String = "Catastrophic";
        }
        requirement def REQ_UCA_08 {
            doc /* UCA-08: Crew triggers PL-40 outside 13.0-14.0 bar / <= 12.0 m/s wind / <= 25.0 m/s exit bounds, or approaches hangfire rail without SAFE_SCRUB_ABORT depressurization and ESAD safing. */
            attribute ucaType : String = "Provided Unsafely";
            @TriggersHazard("REQ_H_06");
        }
        requirement def REQ_SC_13 {
            text = "SC-13: Enforce red carriage safety pin, Main Valve 4 interlock, simultaneous >= 2.0 s dual firing switch hold, and zero electrical/CAN cable between PL-40 and UAV (IF-MECH-001).";
            @SafetyRealises("REQ_UCA_08");
        }
        requirement def REQ_SC_14 {
            text = "SC-14: Enforce 13.0-14.0 bar operating range, <= 25.0 m/s exit limit (GAP-03), 14.5 V compressor UVLO cutoff (> 16.0 V after 5.0 s restart), and 100-launch rope/bearing service interval.";
            @SafetyRealises("REQ_UCA_08");
        }
        requirement def REQ_SC_15 {
            text = "SC-15: Enforce >= 8 char role auth, ESD ground touch, rotator calibration before touching UAV, >= 10.0 m radio separation, 50.0-3000.0 m altitude, >= 300.0 m loiter, and 105.0 s GCS failsafe.";
            @SafetyRealises("REQ_UCA_08");
        }
        requirement def REQ_SC_16 {
            text = "SC-16: Enforce SAFE_SCRUB_ABORT (GAP-SCRUB): 5.0 s ESAD self-destruct/abort hold + irreversible Power Off ESAD, PL-40 Main Valve 4 close & bleed, red pin reinsertion, and RBF #3 before RBF #2 safing.";
            @SafetyRealises("REQ_UCA_08");
        }
        requirement def REQ_SAF_03 {
            text = "GAP-03 Mitigation: Require Go/No-Go launch check validating pusher thrust readiness, 13.0-14.0 bar tank pressure, headwind margin, and <= 25.0 m/s exit limit (~23.0 m/s at 17.0 kg).";
        }
        requirement def REQ_SAF_11 {
            text = "GAP-ENV Disposition: Track unprinted battery energy (Wh/Ah), SoC floor, ESC/motor current/thermal cutoffs, tank volume (L), relief pressure (bar), IP/rain/icing, and standoff distance as explicit calibration limits.";
        }
        requirement def REQ_SAF_12 {
            text = "GAP-SCRUB Mitigation: Formalize SAFE_SCRUB_ABORT hangfire wait, tank depressurization, carriage pin restore, and post-RBF #3 ordnance safing sequence.";
        }
        doc /* Operational and safety state machine for ELI PL-40 Rev 2.6 pneumatic catapult including 14.5 V UVLO pause, dual-switch firing, and scrub depressurization (GAP-03, GAP-SCRUB). States: DisassembledTransport (1.28 m disassembled 3-section rail in 43.0 kg case + 25.0 kg compressor, 68.0 kg total, zero stored pneumatic pressure); AnchoredAndLeveled (5.0 m rail anchored at 602.0 mm front leg span, 12.0 deg elevation, 1116.0 mm height, carriage safety pin installed); CompressorCharging (charging via 2x Makita BL1860B 18.0 V packs <= 8.0 min or DIN 8 mm PCP aux <= 16.0 bar with 0.05 bar auto-cutoff hysteresis); UvloPause (pack voltage <= 14.5 V triggers PWR LED flash cutoff, requires pack swap and >= 16.0 V after 5.0 s wait to restart); ReadyAt13To14BarPinInstalled (tank stabilized at 13.0-14.0 bar, UAV mounted on 145.0-155.5 mm prop-safe carriage, red safety pin installed until final firing prep); DualSwitchFiring (red safety pin removed, Main Valve 4 opened, both safety-covered firing switches held simultaneously >= 2.0 s); RailLaunchReleased (carriage released imparting ~23.0 m/s <= 25.0 m/s cap mechanical acceleration with zero electrical/CAN wires to UAV); ScrubbedSafeDepressurized (GAP-SCRUB safe state: Main Valve 4 closed, tank bled to 0 bar, red safety pin reinserted before crew approaches UAV). */
        state def Pl40LauncherState {
            state DisassembledTransport;
            state AnchoredAndLeveled;
            state CompressorCharging;
            state UvloPause;
            state ReadyAt13To14BarPinInstalled;
            state DualSwitchFiring;
            state RailLaunchReleased;
            state ScrubbedSafeDepressurized;
            transition T_Init first Initial then DisassembledTransport;
            transition T_TransToAnchored first DisassembledTransport accept railAnchoredAndLeveled12Deg then AnchoredAndLeveled;
            transition T_AnchoredToCharge first AnchoredAndLeveled accept compressorStartAuthorized then CompressorCharging;
            transition T_ChargeToUvlo first CompressorCharging accept packVoltageAtOrBelow14_5V then UvloPause;
            transition T_UvloToCharge first UvloPause accept freshPackAbove16VAfter5Sec then CompressorCharging;
            transition T_ChargeToReady first CompressorCharging accept pressureWithin13To14BarAndUavMounted then ReadyAt13To14BarPinInstalled;
            transition T_ReadyToFire first ReadyAt13To14BarPinInstalled accept pinPulledValve4OpenAndGoNoGoPass then DualSwitchFiring;
            transition T_FireToReleased first DualSwitchFiring accept dualSwitchHeldAtLeast2Sec then RailLaunchReleased;
            transition T_ReadyToScrub first ReadyAt13To14BarPinInstalled accept launchScrubbedOrHangfire then ScrubbedSafeDepressurized;
            transition T_FireToScrub first DualSwitchFiring accept hangfireOrSwitchReleasedEarly then ScrubbedSafeDepressurized;
            transition T_ReleasedToTerminal first RailLaunchReleased then Terminal;
            transition T_ScrubbedToTerminal first ScrubbedSafeDepressurized then Terminal;
        }
        doc /* Mapped 1:1 to uc-01: Prepare, pressurize (13.0-14.0 bar), pass Go/No-Go gate (GAP-03), pull carriage red safety pin, open Main Valve 4, hold dual switches >= 2.0 s, and execute purely mechanical PL-40 rail launch. */
        use case def UC_01_ExecutePl40RailLaunch {
            subject Pl40PneumaticLauncher;
            actor LaunchAssistant;
            actor Pilot;
            objective "Achieve safe rail exit velocity (~23.0 m/s at 17.0 kg, <= 25.0 m/s limit) with zero electrical umbilical wires and clean onboard SS1 accel trigger.";
        }
        doc /* Mapped 1:1 to uc-07: Authenticate SwarmC2 operator roles (>= 8 char), enforce ESD and >= 10.0 m separation, calibrate Antenna Rotator (0.5 deg step / Auto Follow) before touching UAV, plan 50.0-3000.0 m / >= 300.0 m loiter missions, and export 5W/CFF to ATAK/SitaWare HQ/DELTA. */
        use case def UC_07_ManageGroundC2RotatorAndDataExport {
            subject SwarmC2OperatorConsole;
            actor Pilot;
            actor PayloadOperator;
            objective "Maintain resilient 4.4-5.0 GHz C2 tracking across OMNI/DIR/200.0 m fiber paths and interoperable tactical reporting.";
        }
        doc /* Mapped 1:1 to uc-08: Execute SAFE_SCRUB_ABORT (GAP-SCRUB) after RBF #3 removal, Main Valve 4 opening, or launch hangfire by safing ESAD, bleeding PL-40 pressure, reinserting red safety pin, and restoring RBF #3 prior to RBF #2 removal. */
        use case def UC_08_ExecuteSafeScrubAndHangfireRecovery {
            subject Pl40PneumaticLauncher;
            actor LaunchAssistant;
            actor Pilot;
            objective "Eliminate stored pneumatic and ordnance energy safely prior to crew approach after any launch abort or hangfire.";
        }
        item def GroundC2TelemetryAndCommandStream {
            doc /* Wired IP or optional 200.0 m fiber optic link between SwarmC2 tablet, Ground Radio Box, and Antenna Rotator (IF-GND-001). */
            attribute fiberSpoolLengthM : Real = 200.0;
        }
        item def RotatorAzimuthControlSignal {
            doc /* Azimuth command for Directional Tracking Antenna Rotator (Auto Follow or 0.5 deg CCW/CW fine step). */
            attribute fineStepDeg : Real = 0.5;
        }
        item def Pl40MechanicalLaunchInterface {
            doc /* IF-MECH-001: Purely mechanical interface between ELI PL-40 5.0 m rail carriage and Avenger V2.5 hardpoints (split hooks / 225 mm bar / M8 pins). ZERO electrical/CAN cable. */
            attribute launcherEnd : String = "MechLaunchRailOutputPort";
            attribute airframeEnd : String = "MechanicalLaunchRailInPort";
        }
        item def GroundStationC2AndFiberInterface {
            doc /* IF-GND-001: SwarmC2 rugged Windows 11 tablet <-> Ground Radio Box & Antenna Rotator via wired C2 or 200.0 m tactical fiber spool; exports 5W/CFF to ATAK, SitaWare HQ, DELTA. */
            attribute consoleEnd : String = "GcsStationControlPort";
            attribute rfStationEnd : String = "GcsStationControlPort";
        }
        item def AirGroundRfDatalinkInterface {
            doc /* IF-RF-001: Over-the-air 4.4-5.0 GHz AES-256 FHSS RF datalink between Airborne DTC Radio (2x MPSL4400) and Ground Radio Box (MARS 23 dBi DIR / OMNI). */
            attribute airEnd : String = "RfDatalinkAirPort";
            attribute groundEnd : String = "GroundRfAirPort";
        }
        doc /* Verify PL-40 13.0-14.0 bar charge, 14.5 V UVLO pause, >= 2.0 s dual firing hold, <= 25.0 m/s exit cap, and strictly mechanical zero-wire interface to UAV. */
        test case def TC_07_Pl40RailChargeLaunchAndZeroWire {
            subject Pl40PneumaticLauncher;
            verify requirement REQ_SC_13, REQ_SC_14, REQ_SAF_03;
            objective "Confirm PL-40 exits within 22.7-23.5 m/s at 17.0 kg with zero electrical/CAN conductors connected to airframe.";
            step verifyZeroElectricalOrCanWiresToUav;
            step verify14_5VCompressorUvloCutoff;
            step verifyDualSwitch2SecAndPressure13To14Bar;
        }
        doc /* Verify SwarmC2 >= 8 char role auth, >= 10.0 m separation, and SAFE_SCRUB_ABORT hangfire depressurization + ESAD safing sequence (GAP-SCRUB). */
        test case def TC_08_EmergencyScrubHangfireAndC2Auth {
            subject SwarmC2OperatorConsole;
            verify requirement REQ_SC_15, REQ_SC_16, REQ_SAF_12;
            objective "Confirm SAFE_SCRUB_ABORT safely removes ESAD HV and PL-40 stored air pressure prior to crew approach.";
            step verifyRoleAuthAndMissionBounds;
            step triggerHangfireAbortOnArmedRail;
            step verifyDepressurizePinAndRbf3Restore;
        }
        doc /* Assemble 5.0 m 12.0 deg PL-40 rail, charge tank to 13.0-14.0 bar via 2x Makita BL1860B (18.0 V, 6000 mAh, 14.5 V UVLO) or 16.0 bar DIN 8 mm PCP aux, enforce red safety pin, Main Valve 4, and >= 2.0 s dual firing hold, and impart <= 25.0 m/s (~23.0 m/s at 17.0 kg) mechanical launch impulse with ZERO electrical/CAN wire to UAV. */
        capability def PneumaticRailCatapultLaunch;
        doc /* Enforce Pilot/Payload/Launch Assistant >= 8 char role auth, ESD grounding, >= 10.0 m UAV-to-radio separation, rotator calibration (Auto Follow + 0.5 deg step), MARS 23 dBi DIR / OMNI + 200.0 m fiber tether, 50.0-3000.0 m mission planning (>= 300.0 m loiter, 105.0 s GCS failsafe, 5.0 s ESAD abort), and 5W/CFF export to ATAK/SitaWare HQ/DELTA. */
        capability def SwarmC2MissionCommandAndGroundRfTracking;
        doc /* Mapped 1:1 to us-03: PL-40 setup (5.0 m, 12.0 deg), Makita BL1860B compressor fill (13.0-14.0 bar, 14.5 V UVLO check), rotator calibration, >= 10.0 m radio separation, RBF #3 pull after 8 preconditions, red pin pull, Main Valve 4 open, >= 2.0 s dual-switch fire, mechanical exit ~23.0 m/s (<= 25.0 m/s GAP-03) with zero wires to UAV, and onboard SS1 accel sense. */
        interaction def INT_03_Pl40RailChargeAndLaunchSequence {
        }
        doc /* Mapped 1:1 to us-08: SAFE_SCRUB_ABORT on hangfire, PL-40 UVLO, ESAD fault, or mission abort (GAP-SCRUB): 5.0 s ESAD abort hold + Slide-to-Confirm / Power Off ESAD, PL-40 Main Valve 4 close & depressurize, red pin reinsert, RBF #3 reinstallation before RBF #2 power disconnect. */
        interaction def INT_08_EmergencyScrubAndSafing {
        }
        doc /* BOM-LCH-001..005: ELI PL-40 Rev 2.6 pneumatic rail catapult (5.0 m / 4938.0 mm rail, 12.0 deg elev, 13.0-14.0 bar launch, 16.0 bar aux PCP, 30.0 kg max MTOW, <= 25.0 m/s exit / ~23.0 m/s at 17.0 kg, 2x Makita BL1860B 18.0 V 6000 mAh / 14.5 V UVLO, red safety pin, Main Valve 4, >= 2.0 s dual switch, ZERO electrical/CAN wire to UAV). */
        part def Pl40PneumaticLauncher {
            attribute launcherModel : String = "ELI Military Simulations PL-40 Rev 2.6";
            attribute railLengthNominalM : Real = 5.0;
            attribute railEnvelopeCadMm : Real = 4938.0;
            attribute packedSectionLengthM : Real = 1.28;
            attribute railElevationDeg : Real = 12.0;
            attribute frontLegSpanMm : Real = 602.0;
            attribute deployedRailHeightMm : Real = 1116.0;
            attribute totalSystemMassKg : Real = 68.0;
            attribute caseMassKg : Real = 43.0;
            attribute compressorMassKg : Real = 25.0;
            attribute maxSupportedMtowKg : Real = 30.0;
            attribute maxExitVelocityMs : Real = 25.0;
            attribute avenger5ExitVelocityMs : Real = 23.0;
            attribute avenger5ExitLowerMs : Real = 22.7;
            attribute avenger5ExitUpperMs : Real = 23.5;
            attribute launchPressureMinBar : Real = 13.0;
            attribute launchPressureMaxBar : Real = 14.0;
            attribute pressureHysteresisBar : Real = 0.05;
            attribute compressorChargeMaxMin : Real = 8.0;
            attribute auxPcpMaxPressureBar : Real = 16.0;
            attribute batteryPackModel : String = "2x Makita BL1860B 18V 6000 mAh";
            attribute batteryNominalV : Real = 18.0;
            attribute batteryCapacityMah : Real = 6000.0;
            attribute uvloCutoffV : Real = 14.5;
            attribute uvloRestartMinV : Real = 16.0;
            attribute uvloRestartDelaySec : Real = 5.0;
            attribute dualSwitchHoldMinSec : Real = 2.0;
            attribute ropeBearingIntervalLaunches : Integer = 100;
            attribute electricalWireToUavCount : Integer = 0;
            port out mechLaunchOut : MechLaunchRailOutputPort;
        }
        doc /* BOM-GCS-001: SwarmC2 C2 software on Windows 11 rugged tablet with Pilot/Payload/Launch Assistant role auth (>= 8 char), 24 char mission name max, 50.0-3000.0 m altitude slider (250.0 m step), 300.0 m loiter min, 2.0 min telemetry timeout, 105.0 s GCS failsafe baseline, 5.0 s ESAD self-destruct hold, and 5W/CFF export to ATAK/SitaWare HQ/DELTA. */
        part def SwarmC2OperatorConsole {
            attribute osPlatform : String = "Windows 11 Rugged Tablet";
            attribute softwareSuite : String = "SwarmC2";
            attribute passwordMinChars : Integer = 8;
            attribute missionNameMaxChars : Integer = 24;
            attribute telemetryDetectTimeoutMin : Real = 2.0;
            attribute waypointAltMinM : Real = 50.0;
            attribute altitudeSliderMaxM : Real = 3000.0;
            attribute altitudeSliderStepM : Real = 250.0;
            attribute loiterRadiusMinM : Real = 300.0;
            attribute gcsFailsafeTimeoutSec : Real = 105.0;
            attribute esadSelfDestructHoldSec : Real = 5.0;
            attribute c2ExportFormats : String = "5W / CFF -> ATAK, SitaWare HQ, DELTA";
            port inout gcsStationPort : GcsStationControlPort;
        }
        doc /* BOM-GCS-002..006: DTC 4.4-5.0 GHz Ground Radio Box (2.0 W, 60.0/90.0 km RLOS), Directional Antenna Rotator (Auto Follow + 0.5 deg step, calibrated BEFORE touching UAV), MARS 23 dBi DIR + OMNI antennas, optional 200.0 m fiber spool, >= 10.0 m crew/UAV separation, and Transport Box ESD grounding point. */
        part def GroundRfStationAndAntennaTracker {
            attribute groundRadioModel : String = "DTC 4.4-5.0 GHz Ground Radio Box";
            attribute dirAntennaGainDbi : Real = 23.0;
            attribute rotatorFineStepDeg : Real = 0.5;
            attribute exampleChannelFreqMHz : Real = 4510.0;
            attribute optionalFiberSpoolM : Real = 200.0;
            attribute minRadioToUavSepM : Real = 10.0;
            attribute esdGroundingMandatory : Boolean = true;
            port inout gcsStationPort : GcsStationControlPort;
            port inout rfAirPort : GroundRfAirPort;
        }
    }
}