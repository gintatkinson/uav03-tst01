doc /* Bijective SysML v2 Single Source of Truth (SSOT) Model for Avenger 5 / Avenger V2.5 Integrated System, compiled from schema/schematic_ledger.json. */
package Avenger5SystemModel {
    state def IntegratedSystemLifecycleState {
        state StagedAndPoweredOff;
        state PreFlightChecksAndArming;
        state LaunchAndAutonomousFlight;
        state TerminalEngagementOrSafeRecovery;
        state PostMissionSafed;
        transition T_Sys_Init first Initial then StagedAndPoweredOff;
        transition T_Sys_BeginPreflight first StagedAndPoweredOff accept rbfPowerOnAndGcsLink if batteryAndMechanicalChecksPassed then PreFlightChecksAndArming;
        transition T_Sys_Launch first PreFlightChecksAndArming accept catapultReleaseCommand if allSixChecklistGroupsAndEsadRbf3Cleared then LaunchAndAutonomousFlight;
        transition T_Sys_Terminal first LaunchAndAutonomousFlight accept terminalEngagementOrRtlCommand if safeSeparationAndMissionModeActive then TerminalEngagementOrSafeRecovery;
        transition T_Sys_Safe first TerminalEngagementOrSafeRecovery accept postMissionDischargeOrImpact then PostMissionSafed;
        transition T_Sys_Term first PostMissionSafed then Terminal;
    }
    package InterfacesAndItemsPackage {
        port def AcMultiphaseInPort {
            attribute direction = "in";
            attribute itemType = "AcMultiphasePowerItem";
            attribute protocol = "IF-AC-MULTIPHASE";
        }
        port def AcMultiphaseOutPort {
            attribute direction = "out";
            attribute itemType = "AcMultiphasePowerItem";
            attribute protocol = "IF-AC-MULTIPHASE";
        }
        port def CanBusInoutPort {
            attribute direction = "inout";
            attribute itemType = "CanBusFrameItem";
            attribute protocol = "IF-CAN-BUS";
        }
        port def CompositePowerVideoInoutPort {
            attribute direction = "inout";
            attribute itemType = "CompositePowerVideoItem";
            attribute protocol = "IF-COMP-PWR-VID";
        }
        port def CompositeSensorHarnessInPort {
            attribute direction = "in";
            attribute itemType = "CompositeSensorHarnessItem";
            attribute protocol = "IF-COMP-SENSOR";
        }
        port def CompositeSensorHarnessOutPort {
            attribute direction = "out";
            attribute itemType = "CompositeSensorHarnessItem";
            attribute protocol = "IF-COMP-SENSOR";
        }
        port def DcPowerInPort {
            attribute direction = "in";
            attribute itemType = "DcPowerRailItem";
            attribute protocol = "IF-DC-POWER";
        }
        port def DcPowerOutPort {
            attribute direction = "out";
            attribute itemType = "DcPowerRailItem";
            attribute protocol = "IF-DC-POWER";
        }
        port def DiscreteGpioInPort {
            attribute direction = "in";
            attribute itemType = "DiscreteGpioSignalItem";
            attribute protocol = "IF-DISCRETE-GPIO";
        }
        port def DiscreteGpioOutPort {
            attribute direction = "out";
            attribute itemType = "DiscreteGpioSignalItem";
            attribute protocol = "IF-DISCRETE-GPIO";
        }
        port def DiscreteGpioInoutPort {
            attribute direction = "inout";
            attribute itemType = "DiscreteGpioSignalItem";
            attribute protocol = "IF-DISCRETE-GPIO";
        }
        port def EthernetIpInoutPort {
            attribute direction = "inout";
            attribute itemType = "EthernetIpPacketItem";
            attribute protocol = "IF-ETHERNET-IP";
        }
        port def HighVoltageFireInPort {
            attribute direction = "in";
            attribute itemType = "HighVoltageFirePulseItem";
            attribute protocol = "IF-HV-FIRE";
        }
        port def HighVoltageFireOutPort {
            attribute direction = "out";
            attribute itemType = "HighVoltageFirePulseItem";
            attribute protocol = "IF-HV-FIRE";
        }
        port def MechanicalStructuralLoadInPort {
            attribute direction = "in";
            attribute itemType = "MechanicalStructuralLoadItem";
            attribute protocol = "IF-MECH-LOAD";
        }
        port def MechanicalStructuralLoadOutPort {
            attribute direction = "out";
            attribute itemType = "MechanicalStructuralLoadItem";
            attribute protocol = "IF-MECH-LOAD";
        }
        port def MechanicalStructuralLoadInoutPort {
            attribute direction = "inout";
            attribute itemType = "MechanicalStructuralLoadItem";
            attribute protocol = "IF-MECH-LOAD";
        }
        port def OpticalFiberInoutPort {
            attribute direction = "inout";
            attribute itemType = "OpticalFiberSignalItem";
            attribute protocol = "IF-OPTICAL-FIBER";
        }
        port def PneumaticPressureInPort {
            attribute direction = "in";
            attribute itemType = "PneumaticPressureAirItem";
            attribute protocol = "IF-PNEUMATIC";
        }
        port def PneumaticPressureOutPort {
            attribute direction = "out";
            attribute itemType = "PneumaticPressureAirItem";
            attribute protocol = "IF-PNEUMATIC";
        }
        port def PwmControlInPort {
            attribute direction = "in";
            attribute itemType = "PwmControlSignalItem";
            attribute protocol = "IF-PWM-CTRL";
        }
        port def PwmControlOutPort {
            attribute direction = "out";
            attribute itemType = "PwmControlSignalItem";
            attribute protocol = "IF-PWM-CTRL";
        }
        port def RfCoaxInPort {
            attribute direction = "in";
            attribute itemType = "RfCoaxSignalItem";
            attribute protocol = "IF-RF-COAX";
        }
        port def RfCoaxOutPort {
            attribute direction = "out";
            attribute itemType = "RfCoaxSignalItem";
            attribute protocol = "IF-RF-COAX";
        }
        port def RfCoaxInoutPort {
            attribute direction = "inout";
            attribute itemType = "RfCoaxSignalItem";
            attribute protocol = "IF-RF-COAX";
        }
        port def RfOverTheAirInoutPort {
            attribute direction = "inout";
            attribute itemType = "RfOverTheAirSignalItem";
            attribute protocol = "IF-RF-OTA";
        }
        port def Rs485DifferentialInoutPort {
            attribute direction = "inout";
            attribute itemType = "Rs485DifferentialFrameItem";
            attribute protocol = "IF-RS485";
        }
        port def UartSerialInPort {
            attribute direction = "in";
            attribute itemType = "UartSerialDataItem";
            attribute protocol = "IF-UART-SERIAL";
        }
        port def UartSerialOutPort {
            attribute direction = "out";
            attribute itemType = "UartSerialDataItem";
            attribute protocol = "IF-UART-SERIAL";
        }
        port def UartSerialInoutPort {
            attribute direction = "inout";
            attribute itemType = "UartSerialDataItem";
            attribute protocol = "IF-UART-SERIAL";
        }
        port def UmbilicalContinuityLoopInoutPort {
            attribute direction = "inout";
            attribute itemType = "UmbilicalContinuityLoopItem";
            attribute protocol = "IF-UMB-LOOP";
        }
        port def UsbBusInoutPort {
            attribute direction = "inout";
            attribute itemType = "UsbBusDataItem";
            attribute protocol = "IF-USB-BUS";
        }
        item def AcMultiphasePowerItem {
            attribute domain : String = "ac_multiphase";
            attribute phaseCount : Integer = 3;
            attribute nominalBusVoltageMaxV : Real = 50.4;
        }
        item def CanBusFrameItem {
            attribute domain : String = "can_bus";
            attribute busArchitecture : String = "DroneCAN / CAN1 & CAN2";
        }
        item def CompositePowerVideoItem {
            attribute domain : String = "composite_power_video";
            attribute signalContent : String = "Gimbal DC power + HDMI EO/IR video";
        }
        item def CompositeSensorHarnessItem {
            attribute domain : String = "composite_sensor_harness";
            attribute signalContent : String = "Motor winding temperature telemetry";
        }
        item def DcPowerRailItem {
            attribute domain : String = "dc_power";
            attribute nominalVoltageRangeDesc : String = "5V / 8V / 12V / 14-32V / 18V / 36-50.4V / 50V DC";
        }
        item def DiscreteGpioSignalItem {
            attribute domain : String = "discrete_gpio";
            attribute signalContent : String = "RBF interlocks, DSC_IN1 arm PWM, ORed IRQ_L, DIST_SPARE";
        }
        item def EthernetIpPacketItem {
            attribute domain : String = "ethernet_ip";
            attribute signalContent : String = "IP Ethernet telemetry, video stream, and C2 switching";
        }
        item def HighVoltageFirePulseItem {
            attribute domain : String = "high_voltage_fire";
            attribute maxVoltageV : Real = 1800.0;
        }
        item def MechanicalStructuralLoadItem {
            attribute domain : String = "mechanical_structural_load";
            attribute signalContent : String = "Propeller torque, launch thrust, RBF covers/straps, explosive shock, ESD bond";
        }
        item def OpticalFiberSignalItem {
            attribute domain : String = "optical_fiber";
            attribute spoolLengthM : Real = 200.0;
        }
        item def PneumaticPressureAirItem {
            attribute domain : String = "pneumatic_pressure";
            attribute nominalLaunchPressureMinPa : Real = 1300000.0;
            attribute nominalLaunchPressureMaxPa : Real = 1400000.0;
        }
        item def PwmControlSignalItem {
            attribute domain : String = "pwm_control";
            attribute signalContent : String = "ESC motor throttle PWM control";
        }
        item def RfCoaxSignalItem {
            attribute domain : String = "rf_coax";
            attribute frequencyRangeDesc : String = "GNSS RF & 4.4-5.0 GHz C2 RF coax";
        }
        item def RfOverTheAirSignalItem {
            attribute domain : String = "rf_over_the_air";
            attribute frequencyMinHz : Real = 4400000000.0;
            attribute frequencyMaxHz : Real = 5000000000.0;
        }
        item def Rs485DifferentialFrameItem {
            attribute domain : String = "rs485_differential";
            attribute baudRateBps : Integer = 115200;
            attribute integrityScheme : String = "CRC-16 XModem";
        }
        item def UartSerialDataItem {
            attribute domain : String = "uart_serial";
            attribute signalContent : String = "ESC telemetry, Trip6/GNSS/RPi/Radio serial, ESAD-Sensor DIST_COMM";
        }
        item def UmbilicalContinuityLoopItem {
            attribute domain : String = "umbilical_continuity_loop";
            attribute senseCurrentA : Real = 0.02;
            attribute maxClosedLoopResistanceOhm : Real = 0.5;
        }
        item def UsbBusDataItem {
            attribute domain : String = "usb_bus";
            attribute signalContent : String = "External USB service interface and optional tablet USB controller";
        }
        item def ITEM_PROTO_ESC_TELEMETRY_UART {
            attribute contractId : String = "PROTO-ESC-TELEMETRY-UART";
            attribute interfaceRef : String = "Telemetry data UART (rpm, temp (esc&mot), Current, Voltage)";
            attribute summary : String = "Unidirectional UART telemetry stream from ESC (IBEX160) to Cube orange+ autopilot";
            attribute integrityScheme : String = "Unspecified in DOC-01 block diagram";
            attribute commandsAndBitfields : String = "rpm (rpm); temp_esc_and_mot; current; voltage";
        }
        item def ITEM_PROTO_MOTOR_TEMP_TELEMETRY {
            attribute contractId : String = "PROTO-MOTOR-TEMP-TELEMETRY";
            attribute interfaceRef : String = "Telemetry (Mot. Temperature)";
            attribute summary : String = "Unidirectional motor temperature sensor telemetry from Motor (AXI 5345/16 HD GOLD LINE V3) to ESC (IBEX160)";
            attribute integrityScheme : String = "Unspecified in DOC-01 block diagram";
            attribute commandsAndBitfields : String = "mot_temperature";
        }
        item def ITEM_PROTO_PWM_ESC_CONTROL {
            attribute contractId : String = "PROTO-PWM-ESC-CONTROL";
            attribute interfaceRef : String = "PWM ESC control";
            attribute summary : String = "Unidirectional PWM motor speed command from Cube orange+ autopilot to ESC (IBEX160)";
            attribute integrityScheme : String = "None (PWM pulse width modulation)";
            attribute commandsAndBitfields : String = "pwm_throttle_cmd";
        }
        item def ITEM_PROTO_POWER_METER_CAN1 {
            attribute contractId : String = "PROTO-POWER-METER-CAN1";
            attribute interfaceRef : String = "CAN 1 120 cm wire (Power meter to Cube orange+)";
            attribute summary : String = "CAN 1 interface delivering battery voltage and current metrics from Power meter to Cube orange+ autopilot";
            attribute integrityScheme : String = "CAN bus hardware CRC (protocol details unspecified in DOC-01)";
            attribute commandsAndBitfields : String = "battery_voltage_and_current_metrics";
        }
        item def ITEM_PROTO_DOC02_RF_C2_LINK {
            attribute contractId : String = "PROTO-DOC02-RF-C2-LINK";
            attribute interfaceRef : String = "4.4-5.0 GHz RF over-the-air link (Ground Antenna to UAV Radio)";
            attribute summary : String = "Bidirectional frequency-hopping RF C2, telemetry, and video link using distinct uplink and downlink frequencies in 4.4-5.0 GHz at 2 W output power up to 60 km RLOS (90 km with relay)";
            attribute integrityScheme : String = "AES-256 encryption with frequency-hopping interference avoidance";
            attribute bitWidth : Integer = 256;
            attribute commandsAndBitfields : String = "direct_uav_control_cmd; continuous_health_monitoring_telemetry; eo_ir_video_stream (1280x720 day / 1280x720 thermal)";
        }
        item def ITEM_PROTO_DOC02_GCS_FIBER_LINK {
            attribute contractId : String = "PROTO-DOC02-GCS-FIBER-LINK";
            attribute interfaceRef : String = "WIRE-DOC02-001 (Connect with 200m fiber optics spool)";
            attribute summary : String = "200 m bidirectional optical fiber spool link connecting GCS Ground BOX (INST-GCS-GROUND-BOX) to GCS Antenna Rotator (INST-GCS-ROTATOR)";
            attribute integrityScheme : String = "Unspecified in DOC-02 spec sheet";
            attribute spoolLengthM : Real = 200.0;
        }
        item def ITEM_PROTO_DOC02_BMS_INTEGRATION {
            attribute contractId : String = "PROTO-DOC02-BMS-INTEGRATION";
            attribute interfaceRef : String = "Integration with Battle Management Systems (SitaWare HQ and ATAK)";
            attribute summary : String = "Coordinated mission execution interface between UDS SwarmC2 ground software and external Battle Management Systems (SitaWare HQ and ATAK)";
            attribute integrityScheme : String = "Unspecified in DOC-02 spec sheet";
            attribute commandsAndBitfields : String = "bms_coordinated_mission_exchange";
        }
        item def ITEM_PROTO_ESAD_RS485 {
            attribute contractId : String = "PROTO-ESAD-RS485";
            attribute interfaceRef : String = "RS-485 2-Wire Half Duplex (ESAD J100 Pins 9,10 RS485_AB_P / RS485_AB_N)";
            attribute summary : String = "Master/slave half-duplex RS-485 bus with OC as master and ESAD as slave; 10-bit UART frame (Start+8N1 LSB-first+Stop); Packet [MsgLen(1B>=5), Header(1B: 0x01 OC->ESAD, 0x02 ESAD->OC), Cmd(1B), Data(0-9B), CRC16(2B)]; reply <= 5 ms, abort incomplete > 10 ms, 100 ms / 100 Hz cycle";
            attribute baudOrBitRateBps : Integer = 115200;
            attribute pollOrUpdateRateHz : Integer = 100;
            attribute timeoutMs : Real = 10.0;
            attribute integrityScheme : String = "CRC-16 XModem bitwise (poly 0x1021, seed 0x0000, [0x10..0x19] -> 0xB987)";
            attribute bitWidth : Integer = 16;
            attribute cmdPbit : String = "0x11 PBIT_CMD (MsgLen=0x05, Hdr=0x01) -> PBITResult (MsgLen=0x07, Hdr=0x02, UINT16 bits 0..15: pbit, dsc_in1, res, ss1, ds, ss2, sensorPwr, detConn, umbConn, impactTrig_OR_proxTrig, accelTest, hvDetect, cpldPwr)";
            attribute cmdExchange : String = "0x10 EXCHANGE_CMD (MsgLen=0x08, Hdr=0x01, OC_Status UINT8 bits 0..5 + SimAccelerationOffset INT16 0.0039 g/LSB) -> EXCHANGE_RESPONSE (MsgLen=0x0E, Hdr=0x02: Flowstatus UINT16, ArmState UINT8 0..5, FaultStates UINT16, FlightTimer UINT16 s, Acceleration INT16 0.0039 g/LSB)";
            attribute cmdWelcome : String = "0xB0 WELCOME (Cmd 0x05/0x01; Resp 0x0C/0x02 ASCII 'WELCOME' 7B)";
            attribute cmdVersion : String = "0x13 VERSION_CMD (0x05/0x01) -> VERSION_RESPONSE (0x0B/0x02 UINT8[6] XXXYYY null-terminated)";
            attribute cmdHighVoltage : String = "0x12 HIGHVOLTAGE_CMD (0x05/0x01) -> High_Voltage_Flags UINT8 bits 0..7 + High_Voltage_Value UINT16 [0..1800] V 1V/LSB";
        }
        item def ITEM_PROTO_ESAD_DSC_IN1 {
            attribute contractId : String = "PROTO-ESAD-DSC-IN1";
            attribute interfaceRef : String = "DSC_IN1 (ESAD J100 Pin 13 Arm Enable Discrete Input)";
            attribute summary : String = "Unidirectional PWM Arm Enable signal from OC to ESAD J100 Pin 13; ANDed with RS-485 digital arm enable only after Arm Stage 2 (SS2 active)";
            attribute pollOrUpdateRateHz : Integer = 1000;
            attribute discreteWaveformSpec : String = "1 ms period, 50% duty cycle, 2 square waves; LOW 0-0.7 VDC, HIGH 2.5-3.3 VDC";
            attribute integrityScheme : String = "Waveform signature plus safety-stage gating (Discrete Arm before Arm Stage 2 triggers FaultStates Bit 4)";
            attribute commandsAndBitfields : String = "DSC_IN1_ARM_ENABLE (J100 Pin 13)";
        }
        item def ITEM_PROTO_ESAD_UMBILICAL_CONTINUITY {
            attribute contractId : String = "PROTO-ESAD-UMBILICAL-CONTINUITY";
            attribute interfaceRef : String = "UMB / UMB_RTN (ESAD J100 Pins 5,6 Umbilical Continuity Loop)";
            attribute summary : String = "ESAD-sourced 20 mA continuity current loop; closed loop (<0.5 Ohm, 22-28 AWG) locks ESAD in Safe Mode and open loop initiates Arm Stage 1";
            attribute discreteWaveformSpec : String = "20 mA sense current, <0.5 Ohm closed-loop resistance (22-28 AWG)";
            attribute integrityScheme : String = "Hardware continuity loop cross-checked continuously against Safety Switch 1 (SS1) state";
            attribute commandsAndBitfields : String = "UMB_CONTINUITY_LOOP (J100 Pins 5,6)";
        }
        item def ITEM_PROTO_ESAD_SENSOR_UART {
            attribute contractId : String = "PROTO-ESAD-SENSOR-UART";
            attribute interfaceRef : String = "DIST_COMM1 / DIST_COMM2 (ESAD J102 Pins 2,3 <-> Sensor Board J1 Pins 3,4)";
            attribute summary : String = "Bidirectional UART communication link between ESAD Board and Proximity Sensor Board over 28 AWG crossover harness";
            attribute integrityScheme : String = "Unspecified in DOC-03";
            attribute commandsAndBitfields : String = "DIST_COMM1_RX (J102 Pin 2 <- J1 Pin 3); DIST_COMM2_TX (J102 Pin 3 -> J1 Pin 4)";
        }
        item def ITEM_PROTO_ESAD_ANALOG_TRIGGER {
            attribute contractId : String = "PROTO-ESAD-ANALOG-TRIGGER";
            attribute interfaceRef : String = "IR_ESAD_L / IRQ_L (Sensor Board J1 Pin 2 -> ESAD J102 Pin 4)";
            attribute summary : String = "Single active trigger line into ESAD FPGA formed by hardware ORing Proximity Sensor Trigger and Impact Switch Trigger on Proximity Sensor Board";
            attribute discreteWaveformSpec : String = "ORed discrete/analog trigger signal IR_ESAD_L -> IRQ_L";
            attribute integrityScheme : String = "None (hardware OR gate on Sensor Board; gated by Mod: Armed on ESAD)";
            attribute commandsAndBitfields : String = "IR_ESAD_L_OR_TRIGGER (J1 Pin 2 -> J102 Pin 4)";
        }
        item def ITEM_PROTO_PL40_CONTROLLER_HMI {
            attribute contractId : String = "PROTO-PL40-CONTROLLER-HMI";
            attribute interfaceRef : String = "Compressor electronic controller (11) illuminated push-buttons (10 ON/OFF green PWR LED, 12 SET red SET LED)";
            attribute summary : String = "Push-button control and dual-LED status encoding across 7 operating/fault states, SET MODE target pressure programming (up to 14 bar non-volatile memory), 0.05 bar pressure hysteresis, and battery over-discharge cutoff (<= 14.5 V) with 5 s recovery delay (> 16 V)";
            attribute timeoutMs : Real = 5000.0;
            attribute integrityScheme : String = "Non-volatile setpoint persistence (cancelled if switched OFF prior to pressing SET) and 0.05 bar pressure hysteresis";
            attribute commandsAndBitfields : String = "LED_TURNED_OFF; LED_TARGET_PRESSURE_REACHED; LED_OVER_TARGET_PRESSURE; LED_PRESSURIZING; LED_SET_MODE_PRESSURIZING; LED_SET_MODE_MAX_14BAR; LED_BATTERY_VOLTAGE_TOO_LOW; CMD_ENTER_AND_SAVE_SET_MODE";
        }
        item def ITEM_PROTO_PL40_REMOTE_TRIGGER {
            attribute contractId : String = "PROTO-PL40-REMOTE-TRIGGER";
            attribute interfaceRef : String = "WIRE-DOC04-004 (Trigger handle 13/15 umbilical cord spool 16 to Remote controlled release valve 3)";
            attribute summary : String = "Dual-switch simultaneous safety trigger over corded umbilical handle; lift both hinged red safety covers, press both launch switches simultaneously, hold >= 2 s until plane exits rail";
            attribute timeoutMs : Real = 2000.0;
            attribute integrityScheme : String = "Mechanical hinged safety covers + two-hand simultaneous dual-switch interlock + red active-command LED";
            attribute commandsAndBitfields : String = "CMD_SIMULTANEOUS_LAUNCH_HOLD; CMD_TRIGGER_RELEASE_CLOSE";
        }
        item def ITEM_PROTO_PL40_LAUNCH_PRESSURE_SCHEDULE {
            attribute contractId : String = "PROTO-PL40-LAUNCH-PRESSURE-SCHEDULE";
            attribute interfaceRef : String = "Main tank (6) pressure gauge (8) & Front rail (4) pneumatic launch schedule (Table 2)";
            attribute summary : String = "Empirical launch velocity (m/s) lookup table across reservoir pressures 5..14 bar (onboard compressor) and 15*..16* bar (auxiliary source) for plane masses 10, 15, 20, and 30 kg, bounded by 25 m/s max allowed launch velocity";
            attribute integrityScheme : String = "Operator pressure-mass verification against 25 m/s velocity ceiling prior to opening main outlet valve (4)";
            attribute tableRowsP05ToP10 : String = "5bar:18.4/15.1/13.1/10.7; 6bar:20.2/16.5/14.3/11.7; 7bar:21.8/17.9/15.5/12.6; 8bar:23.3/19.1/16.5/13.5; 9bar:24.8/20.3/17.6/14.3; 10bar:26.1(>25)/21.3/18.5/15.1";
            attribute tableRowsP11ToP16 : String = "11bar:-/22.4/19.4/15.8; 12bar:-/23.4/20.3/16.5; 13bar:-/24.3/21.1/17.2; 14bar:-/25.3(>25)/21.9/17.9; 15*bar:-/26.1(>25)/22.7/18.5; 16*bar:-/-/23.4/19.1";
        }
        item def ITEM_PROTO_DOC05_SWARMC2_PREFLIGHT {
            attribute contractId : String = "PROTO-DOC05-SWARMC2-PREFLIGHT";
            attribute interfaceRef : String = "GCS-to-UAV RF link and SwarmC2 Pre-flight Checklist UI";
            attribute summary : String = "Bidirectional C2, telemetry, mission planning, video check, and ESAD RBF #3 pre-flight verification interface hosted on SwarmC2 GCS tablets; p.22 4-group UI reconciled with DOC-06 6-group checklist";
            attribute integrityScheme : String = "Automatic SwarmC2 ESAD RBF #3 removal verification and pre-flight check gating";
            attribute commandsAndBitfields : String = "flight_mode_and_arm_badge; system_checks_sensors_ok; battery_voltage_and_current_readout; pitot_airspeed_check; gnss_status_and_takeoff_flag; rf_link_signal_quality; mission_plan_verification; furthest_point_distance (32280 m); esad_rbf3_prompt_and_ready_to_fly; slide_to_arm_and_reset";
        }
        item def ITEM_PROTO_DOC05_BATTERY_ID_QR_MATCH {
            attribute contractId : String = "PROTO-DOC05-BATTERY-ID-QR-MATCH";
            attribute interfaceRef : String = "Battery-to-fuselage identification, QR pairing, and physical seating check";
            attribute summary : String = "Pre-installation verification ensuring matched battery and airframe identifiers, QR codes, and bulkhead/position-marker alignment";
            attribute integrityScheme : String = "Exact alphanumeric ID and QR code equality between battery pack and UAV fuselage";
            attribute commandsAndBitfields : String = "battery_fuselage_id_and_qr_match; battery_bulkhead_and_marker_alignment";
        }
        item def ITEM_PROTO_DOC05_ESAD_RBF3_INTERLOCK {
            attribute contractId : String = "PROTO-DOC05-ESAD-RBF3-INTERLOCK";
            attribute interfaceRef : String = "3 ESAD R.B.F. (XT60E-F Amass) and ESAD 1.5 mm HEX screw terminal payload interface";
            attribute summary : String = "Strict temporal interlock governing ESAD power-on, nominal initial diagnostics, and gated Warhead RBF #3 removal";
            attribute integrityScheme : String = "ESAD PBIT/initial diagnostics + SwarmC2 automatic RBF #3 removal verification";
            attribute commandsAndBitfields : String = "esad_premature_rbf3_fault; esad_ready_to_fly_status";
        }
        item def ITEM_PROTO_SWARMC2_RF_C2_TELEMETRY {
            attribute contractId : String = "PROTO-SWARMC2-RF-C2-TELEMETRY";
            attribute interfaceRef : String = "GCS-to-UAV RF Uplink and UAV-to-GCS RF Downlink (4910 MHz / 60-180 km RLOS)";
            attribute summary : String = "Frequency-hopping RF uplink (commands, flight mode, mission/geofence uploads, safety parameters) and downlink (live UAV telemetry, system logs, EO/IR video); initial connect <= 2 min";
            attribute timeoutMs : Real = 120000.0;
            attribute integrityScheme : String = "Secure radio binding (Bind radios) and configurable GCS/GPS failsafe watchdogs";
            attribute telemetryFields : String = "altitude_msl; air_speed; ground_speed; volts_and_amps_and_soc; wind_estimate; gps_count_and_status; distance_to_return; esc_and_motor_temperature; signal_strength_rssi; flight_time; system_log_message";
            attribute commandFields : String = "arm_uav_cmd; set_flight_mode_cmd; change_altitude_and_airspeed_cmd; mission_and_geofence_upload_cmd; safety_params_save_cmd; gnss_override_and_location_correction_cmd; utilities_maintenance_cmds";
        }
        item def ITEM_PROTO_SWARMC2_ESAD_CONTROL {
            attribute contractId : String = "PROTO-SWARMC2-ESAD-CONTROL";
            attribute interfaceRef : String = "SwarmC2 Munition Control -> GCS -> UAV Autopilot/EPS -> ESAD";
            attribute summary : String = "ESAD 6-state status reporting, EPS ESAD power switching, 2-step arm/disarm, 5-second continuous hold for SELF DESTRUCT and irreversible ABORT, and GCS heartbeat timeout disarming";
            attribute timeoutMs : Real = 5000.0;
            attribute integrityScheme : String = "Hardware ESAD Safety Pin + airborne/safe-distance stage + Slide to confirm / 5 s hold interlocks";
            attribute commandsAndBitfields : String = "esad_operational_state; esad_power_on_off_cmd; esad_arm_disarm_cmd; esad_self_destruct_and_abort_cmd; esad_gcs_ping_timeout; engagement_profile_and_engage_cmd";
        }
        item def ITEM_PROTO_SWARMC2_PAYLOAD_VIDEO_OSD {
            attribute contractId : String = "PROTO-SWARMC2-PAYLOAD-VIDEO-OSD";
            attribute interfaceRef : String = "UAV Gimbal/Payload Compute <-> GCS Video Stream / SwarmC2 Payload Control";
            attribute summary : String = "1280x720 HD EO and IR video downlink with overlaid OSD telemetry bar, multitrack slot selection (0-4), gimbal stabilization modes, and SD card capture";
            attribute integrityScheme : String = "Video Stream Setup configuration in SwarmC2";
            attribute commandsAndBitfields : String = "camera_osd_telemetry_bar; camera_mode_and_display_cmd; ir_imaging_and_nuc_cmd; zoom_multitrack_and_capture_cmd";
        }
        item def ITEM_PROTO_SWARMC2_GCS_ROTATOR_LINK {
            attribute contractId : String = "PROTO-SWARMC2-GCS-ROTATOR-LINK";
            attribute interfaceRef : String = "SwarmC2 <-> GCS Ground BOX / Radio BOX / Rotator";
            attribute summary : String = "GCS battery monitoring, ground/drone radio frequency and 2 W TX control, OMNI/DIR antenna switching, and rotator heading calibration/tracking (0.5 deg fine steps)";
            attribute integrityScheme : String = "Ground station local network session with radio binding";
            attribute commandsAndBitfields : String = "gcs_battery_and_rotator_telemetry; radio_and_rotator_control_cmd";
        }
        item def ITEM_PROTO_SWARMC2_AUTH_AND_TACTICAL_SYNC {
            attribute contractId : String = "PROTO-SWARMC2-AUTH-AND-TACTICAL-SYNC";
            attribute interfaceRef : String = "SwarmC2 Browser Session <-> Ground BOX Server and SitaWare HQ / ATAK / DELTA";
            attribute summary : String = "Call-sign session authentication with short-lived default password rotation window, multi-tablet state sync, MBTiles offline map upload, and tactical report exchange (5W, BDA, CFF)";
            attribute integrityScheme : String = "Password strength enforcement (>=8 chars, upper, lower, digit, special) and server role authentication";
            attribute commandsAndBitfields : String = "operator_auth_and_password_reset; five_whiskey_and_bda_sync; call_for_fire_request; network_and_map_config";
        }
        item def ITEM_PROTO_SWARMC2_SYNCHRO_MATRIX {
            attribute contractId : String = "PROTO-SWARMC2-SYNCHRO-MATRIX";
            attribute interfaceRef : String = "SwarmC2 Main menu -> Navigation -> Synchro Matrix";
            attribute summary : String = "SwarmC2 Main menu -> Navigation -> Synchro Matrix UI entry observed in Sec 3.1 Fig 3.2 (p.16); specific matrix columns and fields are not detailed in DOC-06";
            attribute integrityScheme : String = "Unspecified in DOC-06 Sec 3.1 Fig 3.2 (UI menu entry only)";
            attribute commandsAndBitfields : String = "synchro_matrix_nav_item";
        }
    }
    package BehaviorsAndConstraintsPackage {
        action def Act_Battery12S2PLiMetalBei_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Battery12S2PLiMetalBei_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Battery12S2PLiMetalBei_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Battery12S2PLiMetalBei_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Battery12S2PLiMetalBei_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Battery12S2PLiMetalBei_6(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Battery12S2PLiMetalBei_7(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutomotiveFuse200A_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PowerMeterSwitchSensor_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PowerMeterSwitchSensor_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PowerMeterSwitchSensor_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EscIbex160_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EscIbex160_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EscIbex160_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EscIbex160_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EscIbex160_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_MotorAxi534516HdGoldLineV3_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_MotorAxi534516HdGoldLineV3_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_MotorAxi534516HdGoldLineV3_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_MotorAxi534516HdGoldLineV3_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_MotorAxi534516HdGoldLineV3_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_FoldingPropeller_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_FoldingPropeller_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EpsElectronicPowerSystemModule_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EpsElectronicPowerSystemModule_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EpsElectronicPowerSystemModule_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EpsElectronicPowerSystemModule_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EpsElectronicPowerSystemModule_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EpsElectronicPowerSystemModule_6(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_6(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_7(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_8(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_9(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_10(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_11(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_12(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_13(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_14(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_15(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_16(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_17(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_18(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_19(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_AutopilotCubeOrangePlus_20(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EthSwitch_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_RpiCm5004032_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_CanPowerSplitterPcb_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_CanPowerSplitterPcb_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_ServoHv6160DroneCan_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_ServoHv6160DroneCan_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_ServoHv6160DroneCan_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_ServoHv6160DroneCan_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PitoTubeCuavSkye2_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PitoTubeCuavSkye2_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PitoTubeCuavSkye2_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PitoTubeCuavSkye2_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PitoTubeCuavSkye2_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PitoTubeCuavSkye2_6(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_MagnetometerMroRm3100_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_MagnetometerMroRm3100_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_MagnetometerMroRm3100_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GnssAntennaTalysmanTw3972Exf_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GnssModuleSeptentrioAsterxM3Pro_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GnssModuleSeptentrioAsterxM3Pro_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GnssModuleSeptentrioAsterxM3Pro_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GnssModuleSeptentrioAsterxM3Pro_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GnssModuleSeptentrioAsterxM3Pro_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GimbalNighthawk2Uz_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GimbalNighthawk2Uz_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GimbalNighthawk2Uz_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GimbalNighthawk2Uz_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GimbalNighthawk2Uz_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GimbalNighthawk2Uz_6(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GimbalNighthawk2Uz_7(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GimbalNighthawk2Uz_8(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GimbalNighthawk2Uz_9(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GimbalNighthawk2Uz_10(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GimbalNighthawk2Uz_11(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_CameraComputeModuleTrip6_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_CameraComputeModuleTrip6_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_CameraComputeModuleTrip6_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_CameraComputeModuleTrip6_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_CameraComputeModuleTrip6_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_CameraComputeModuleTrip6_6(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_CameraComputeModuleTrip6_7(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_CameraComputeModuleTrip6_8(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_CameraComputeModuleTrip6_9(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_CameraComputeModuleTrip6_10(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_RadioModuleDtc_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_RadioModuleDtc_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_RadioModuleDtc_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_RadioModuleDtc_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_RadioModuleDtc_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_RadioModuleDtc_6(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_RadioModuleDtc_7(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_RadioModuleDtc_8(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_RadioModuleDtc_9(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_RadioModuleDtc_10(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_RadioAntennaMpsl4400_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_RadioAntennaMpsl4400_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_RadioAntennaMpsl4400_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_RadioAntennaMpsl4400_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_ProximitySensor_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_ProximitySensor_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_ProximitySensor_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_ProximitySensor_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_ProximitySensor_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_ProximitySensor_6(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_ImpactSwitch_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_ParachuteIgniter_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_6(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_7(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_8(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_9(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_10(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_11(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_12(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_13(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_14(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_15(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_16(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadSafeAndArmDevice_17(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_LeefiDetonator_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_WarheadBooster_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Warhead_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Warhead_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Warhead_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Warhead_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Warhead_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Warhead_6(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Warhead_7(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Warhead_8(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Warhead_9(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_ExternalInterfaceBoardUsbEth_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_UavRbfKey_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_UavRbfKey_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_UavRbfKey_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_UavRbfKey_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadRbfKey_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadRbfKey_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadRbfKey_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadRbfKey_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsadUmbilicalLoop_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_EsdGroundingPoint_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_UavUmbilicalAccessPort_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PitotTubeRbfCover_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_SensorProtectiveRbfCover_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GimbalSecuringRbfStrap_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_UavConnectionHookSet_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_UavConnectionHookSet_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_UavConnectionHookSet_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_UavConnectionHookSet_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_BatteryMakita18VBl1860B_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_BatteryMakita18VBl1860B_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_BatteryMakita18VBl1860B_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40CompressorController_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40CompressorController_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40CompressorController_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40CompressorController_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40CompressorController_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40CompressorController_6(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40AirCompressorPump_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40AirCompressorPump_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40MainAirReservoir_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40MainAirReservoir_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40MainAirReservoir_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40MainAirReservoir_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40MainAirReservoir_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40MainAirReservoir_6(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40MainReservoirOutletValve_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40MainReservoirOutletValve_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40RemoteControlledReleaseValve_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40RemoteControlledReleaseValve_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40RemoteControlledReleaseValve_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40RemoteControlledReleaseValve_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40AuxiliaryPressureSource_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40TriggerHandle_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40TriggerHandle_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40TriggerHandle_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40TriggerHandle_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40FrontRailSection_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40FrontRailSection_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40FrontRailSection_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40FrontRailSection_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40FrontRailSection_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40MiddleRailSection_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40MiddleRailSection_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40RearRailSection_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40RearRailSection_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40RearRailSection_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40RearRailSection_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40GroundAnchorAssembly_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40GroundAnchorAssembly_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40GroundAnchorAssembly_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40PullingRope_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40PullingRope_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40CarriageSafetyLockPin_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40CarriageSafetyLockPin_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40LaunchCarriage_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40LaunchCarriage_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40LaunchCarriage_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_Pl40LaunchCarriage_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PanasonicFzG2Tablet_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PanasonicFzG2Tablet_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PanasonicFzG2Tablet_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PanasonicFzG2Tablet_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PanasonicFzG2Tablet_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PanasonicFzG2Tablet_6(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PanasonicFzG2Tablet_7(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PanasonicFzG2Tablet_8(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PanasonicFzG2Tablet_9(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PanasonicFzG2Tablet_10(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PanasonicFzG2Tablet_11(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PanasonicFzG2Tablet_12(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PanasonicFzG2Tablet_13(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_PanasonicFzG2TabletBattery_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_OptionalUsbGameController_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GcsBatteryPack_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GcsGroundBox_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GcsGroundBox_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GcsGroundBox_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GcsRadioBox_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GcsRadioBox_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GcsRadioBox_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GcsAntennaRotator_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GcsAntennaRotator_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GcsAntennaRotator_3(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GcsAntennaRotator_4(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GcsAntennaRotator_5(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_MarsDirectionalAntenna23Dbi_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GitzoTripodWithHead_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GcsOmniAntenna_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_TabletBatteryChargingStation_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_GcsAndUavBatteryCharger_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_FieldMaintenanceKit_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_FieldMaintenanceKit_2(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_TransportationStorageCase_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Act_TubeLauncher_1(in commandActive : Boolean, out functionRealized : Boolean);
        action def Action_INV_DOC03_03(in abortCommandReceived : Boolean, out hvCapacitorDischargedToSafe : Boolean);
        action def Action_INV_DOC06_12(in abortEngagingCommand : Boolean, out guidedLoiterOrRtlActive : Boolean);
        constraint def INV_DOC01_01 {
            in finHorizontalSkidTurnActive : Boolean && attribute invariantExpr : String = "finServos1To4MixedPitchYaw == true and rollBankTurn == false";
        }
        constraint def INV_DOC01_02 {
            in wingHorizonStabilizeActive : Boolean && attribute invariantExpr : String = "wingServos5To8RollLevel == true and yawTurnRoll == false";
        }
        constraint def INV_DOC01_09 {
            in fuseBusV : Real && attribute invariantExpr : String = "fuseRatedCurrentA == 200.0 and fuseBusV >= 36.0 and fuseBusV <= 50.4";
        }
        constraint def INV_DOC01_12 {
            in wingCanSeriesOrderValid : Boolean && attribute invariantExpr : String = "can2SeriesHops == [0, 1, 2, 3] and servoPower8vParallel == true";
        }
        constraint def INV_DOC02_02 {
            in airspeedMps : Real && attribute invariantExpr : String = "stallMps == 24.0 and cruiseMps == 31.0 and maxHorizMps == 42.0 and maxDiveMps == 80.0 and airspeedMps >= 24.0 and airspeedMps <= 80.0";
        }
        constraint def INV_DOC02_03 {
            in serviceCeilingM : Real && attribute invariantExpr : String = "groundWindMps <= 12.0 and cruiseWindMps <= 28.0 and serviceCeilingM <= 5000.0";
        }
        constraint def INV_DOC02_04 {
            in mtowKg : Real && attribute invariantExpr : String = "wingspanM == 1.8 and lengthM == 1.6 and mtowKg <= 17.0";
        }
        constraint def INV_DOC02_05 {
            in operatingTempK : Real && attribute invariantExpr : String = "operatingTempK >= 253.15 and operatingTempK <= 323.15";
        }
        constraint def INV_DOC02_13 {
            in pitchRad : Real && attribute invariantExpr : String = "totalZoom == 40 and dayPx == 1280x720 and irPx == 1280x720 and pitchRad >= -0.7854 and pitchRad <= 2.3562";
        }
        constraint def INV_DOC03_02 {
            in safetySwitchParityValid : Boolean && attribute invariantExpr : String = "(umbOpen == ss1Active) and (safeSepMet == ss2Active) and (armCntStarted == hvActive) and (armCmdRx or !dsSenseActive) and (ss2Active or !dscArmRx) and !ocFaultCmd";
        }
        constraint def INV_DOC03_04 {
            in pbitBit9EqualsBit10 : Boolean && attribute invariantExpr : String = "pbitBit9Impact == pbitBit10Proximity and irqLine == (impactTrigger or proximityTrigger)";
        }
        constraint def INV_DOC03_05 {
            in sensor5vRailGated : Boolean && attribute invariantExpr : String = "sensor5vOnOnlyInPbit500msOrArmed and j102Pins5And10MidTerminated28AwgEpoxy == true";
        }
        constraint def INV_DOC03_06 {
            in proxFovClear : Boolean && attribute invariantExpr : String = "mountHolesM == 2x_M2_Dia2.1_at_14.2mm and txConeRad == 0.034907 and rxMajorRad == 0.216421 and rxMinorRad == 0.094248";
        }
        constraint def INV_DOC04_06 {
            in launchVelocityMps : Real && attribute invariantExpr : String = "launchAngleRad == 0.20944 and maxPayloadKg <= 30.0 and launchVelocityMps <= 25.0";
        }
        constraint def INV_DOC04_07 {
            in leverGapM : Real && attribute invariantExpr : String = "forwardLeversFirst and rearLeversSecond and leverGapM == 0.0 and throttleMotion == 0.0";
        }
        constraint def INV_DOC04_08 {
            in launchesSinceRopeReplace : Integer && attribute invariantExpr : String = "ropeInFurthestSlot and ropeZeroSlack and launchesSinceRopeReplace <= 100";
        }
        constraint def INV_DOC04_09 {
            in cgInEnvelope : Boolean && attribute invariantExpr : String = "cgEnvelopeM == 0.200x0.100 and propBelowSafezone == false";
        }
        constraint def INV_DOC04_11 {
            in batteryVoltageV : Real && attribute invariantExpr : String = "maxTargetPressurePa == 1400000.0 and hysteresisPa == 5000.0 and (batteryVoltageV <= 14.5 implies compressorOff)";
        }
        constraint def INV_DOC04_13 {
            in ambientTempK : Real && attribute invariantExpr : String = "railORingsZeroGap and hoseCamlock90DegLocked and ambientTempK >= 253.15 and ambientTempK <= 323.15";
        }
        constraint def INV_DOC05_04 {
            in warheadMassKg : Real && attribute invariantExpr : String = "warheadMassKg >= 4.96 and warheadMassKg <= 5.00 and ctqComFromShoulderM >= 0.02957 and ctqComFromShoulderM <= 0.03157";
        }
        constraint def INV_DOC05_06 {
            in batterySeatedAndStrapped : Boolean && attribute invariantExpr : String = "strapBuckledBeforeInsert and cablelessEndFirstToBulkhead and yellowMarkerAligned and lockingRingTight";
        }
        constraint def INV_DOC05_08 {
            in wingBoltsTightenedCount : Integer && attribute invariantExpr : String = "frontPreinstalledM6x30RemovedWith10mmKey == 4 and rfCableUnpinchedAtHinge and wingBoltsTightenedCount == 8";
        }
        constraint def INV_DOC05_09 {
            in finStabilisersSeatedCount : Integer && attribute invariantExpr : String = "finStabilisersSeatedCount == 4 and controlHornsInserted and retainingScrewsFingerTightened";
        }
        constraint def INV_DOC05_10 {
            in propellerBladesFoldedRearward : Boolean && attribute invariantExpr : String = "propellerBladesFoldedRearward == true priorToPowerUpAndLaunch";
        }
        constraint def INV_DOC06_08 {
            in targetElevationRad : Real && attribute invariantExpr : String = "warheadState == Armed and validEoTrackS >= 2.0 and targetElevationRad <= 0.261799";
        }
        constraint def INV_DOC06_09 {
            in attackAirspeedMps : Real && attribute invariantExpr : String = "attackAirspeedMps <= 55.0";
        }
        constraint def INV_DOC06_10 {
            in profileLockedInAttack : Boolean && attribute invariantExpr : String = "profileLockedUponAttackEntry == true and changeRequiresAbortAndReengage";
        }
        constraint def INV_DOC06_14 {
            in missionNameLenChars : Integer && attribute invariantExpr : String = "missionNameLenChars <= 24 and takeoffItems == 1 and waypoints >= 1 and minWpAltM >= 50.0 and returnPoints == 1 and geofenceValid";
        }
        constraint def INV_DOC06_16 {
            in uavGroundSepM : Real && attribute invariantExpr : String = "uavGroundSepM >= 10.0 and groundRadioTxW == 2.0 and preflightAntennaMode == Omni";
        }
        constraint def INV_DOC06_20 {
            in calmAirspeedMps : Real && attribute invariantExpr : String = "calmAirspeedMps < 3.0 and blowTestAirspeedMps > 10.0 and sixAxisCompassGreen == true";
        }
        constraint def INV_DOC06_22 {
            in preflightBatteryV : Real && attribute invariantExpr : String = "preflightBatteryV >= 49.0 and preflightBatteryV <= 50.0";
        }
        constraint def ConstraintExcludeParachuteDeploymentInProduction {
            in parachutePopulatedInProduction : Boolean && attribute invariantExpr : String = "parachutePopulatedInProduction == false and igniterWires52_53Active == false";
        }
        constraint def ConstraintExcludeTubeLauncherInProduction {
            in tubeLauncherPopulatedInProduction : Boolean && attribute invariantExpr : String = "tubeLauncherPopulatedInProduction == false and pl40CatapultActive == true";
        }
        constraint def ConstraintExcludeOptionalGcsAndMaintenanceInProduction {
            in optionalKitPopulatedInProduction : Boolean && attribute invariantExpr : String = "optionalUsbController == false and auxPressureSource == false and offlineChargersMaintenanceCasesPopulated == false";
        }
        constraint def ConstraintEsadDocumentedSparePins {
            in esadSparePinsCount : Integer && attribute invariantExpr : String = "esadSparePinsCount == 12 and esadJ100Pins_7_8_11_12_14_15_16_J101_J102Pins_5_10_J401Pins_4_8_Disposition == documented_spare_unconnected";
        }
        constraint def ConstraintProximitySensorDocumentedSparePins {
            in proxSparePinsCount : Integer && attribute invariantExpr : String = "proxSparePinsCount == 1 and proximitySensorJ2AllDisposition == documented_spare_unconnected";
        }
        state def FSM_UAV_MAIN_POWER {
            state PowerOff_RbfInstalled;
            state PowerOn_RbfRemoved;
            transition T_FSM_UAV_MAIN_POWER_Init first Initial then PowerOff_RbfInstalled;
            transition T_FSM_UAV_MAIN_POWER_RemoveUavRbfKey first PowerOff_RbfInstalled accept RemoveUavRbfKeyTrigger if RemoveUavRbfKeyGuard then PowerOn_RbfRemoved;
            transition T_FSM_UAV_MAIN_POWER_InsertUavRbfKey first PowerOn_RbfRemoved accept InsertUavRbfKeyTrigger if InsertUavRbfKeyGuard then PowerOff_RbfInstalled;
            transition T_FSM_UAV_MAIN_POWER_Term first PowerOn_RbfRemoved then Terminal;
        }
        state def FSM_ESAD_SAFE_AND_ARM {
            state AbortedOrSelfDestructed;
            state ArmStage1;
            state ArmStage2;
            state ArmedState;
            state FaultState;
            state FiredState;
            state Inactive;
            state PowerOn_Reset;
            state SafeMode;
            transition T_FSM_ESAD_SAFE_AND_ARM_Init first Initial then Inactive;
            transition T_FSM_ESAD_SAFE_AND_ARM_PowerOnEsadToReset first Inactive accept PowerOnEsadToResetTrigger if PowerOnEsadToResetGuard then PowerOn_Reset;
            transition T_FSM_ESAD_SAFE_AND_ARM_PowerOffEsadGround first SafeMode accept PowerOffEsadGroundTrigger if PowerOffEsadGroundGuard then Inactive;
            transition T_FSM_ESAD_SAFE_AND_ARM_BootToSafeMode first PowerOn_Reset accept BootToSafeModeTrigger if BootToSafeModeGuard then SafeMode;
            transition T_FSM_ESAD_SAFE_AND_ARM_FailPbitToFault first SafeMode accept FailPbitToFaultTrigger if FailPbitToFaultGuard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_DisconnectUmbilicalToStage1 first SafeMode accept DisconnectUmbilicalToStage1Trigger if DisconnectUmbilicalToStage1Guard then ArmStage1;
            transition T_FSM_ESAD_SAFE_AND_ARM_ExceedAccelAndSafeSepToStage2 first ArmStage1 accept ExceedAccelAndSafeSepToStage2Trigger if ExceedAccelAndSafeSepToStage2Guard then ArmStage2;
            transition T_FSM_ESAD_SAFE_AND_ARM_FailSafeSeparationToFault first ArmStage1 accept FailSafeSeparationToFaultTrigger if FailSafeSeparationToFaultGuard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_DualArmEnableToArmed first ArmStage2 accept DualArmEnableToArmedTrigger if DualArmEnableToArmedGuard then ArmedState;
            transition T_FSM_ESAD_SAFE_AND_ARM_AbortToSafeMode first ArmedState accept AbortToSafeModeTrigger if AbortToSafeModeGuard then SafeMode;
            transition T_FSM_ESAD_SAFE_AND_ARM_TriggerFireToDetonate first ArmedState accept TriggerFireToDetonateTrigger if TriggerFireToDetonateGuard then FiredState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckUmbilicalVsSS1_SafeMode first SafeMode accept FaultCheckUmbilicalVsSS1_SafeModeTrigger if FaultCheckUmbilicalVsSS1_SafeModeGuard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckUmbilicalVsSS1_ArmStage1 first ArmStage1 accept FaultCheckUmbilicalVsSS1_ArmStage1Trigger if FaultCheckUmbilicalVsSS1_ArmStage1Guard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckUmbilicalVsSS1_ArmStage2 first ArmStage2 accept FaultCheckUmbilicalVsSS1_ArmStage2Trigger if FaultCheckUmbilicalVsSS1_ArmStage2Guard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckUmbilicalVsSS1_ArmedState first ArmedState accept FaultCheckUmbilicalVsSS1_ArmedStateTrigger if FaultCheckUmbilicalVsSS1_ArmedStateGuard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckSafeSepVsSS2_SafeMode first SafeMode accept FaultCheckSafeSepVsSS2_SafeModeTrigger if FaultCheckSafeSepVsSS2_SafeModeGuard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckSafeSepVsSS2_ArmStage1 first ArmStage1 accept FaultCheckSafeSepVsSS2_ArmStage1Trigger if FaultCheckSafeSepVsSS2_ArmStage1Guard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckSafeSepVsSS2_ArmStage2 first ArmStage2 accept FaultCheckSafeSepVsSS2_ArmStage2Trigger if FaultCheckSafeSepVsSS2_ArmStage2Guard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckSafeSepVsSS2_ArmedState first ArmedState accept FaultCheckSafeSepVsSS2_ArmedStateTrigger if FaultCheckSafeSepVsSS2_ArmedStateGuard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckArmCounterVsHV_SafeMode first SafeMode accept FaultCheckArmCounterVsHV_SafeModeTrigger if FaultCheckArmCounterVsHV_SafeModeGuard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckArmCounterVsHV_ArmStage1 first ArmStage1 accept FaultCheckArmCounterVsHV_ArmStage1Trigger if FaultCheckArmCounterVsHV_ArmStage1Guard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckArmCounterVsHV_ArmStage2 first ArmStage2 accept FaultCheckArmCounterVsHV_ArmStage2Trigger if FaultCheckArmCounterVsHV_ArmStage2Guard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckArmCounterVsHV_ArmedState first ArmedState accept FaultCheckArmCounterVsHV_ArmedStateTrigger if FaultCheckArmCounterVsHV_ArmedStateGuard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckArmCmdVsDS_SafeMode first SafeMode accept FaultCheckArmCmdVsDS_SafeModeTrigger if FaultCheckArmCmdVsDS_SafeModeGuard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckArmCmdVsDS_ArmStage1 first ArmStage1 accept FaultCheckArmCmdVsDS_ArmStage1Trigger if FaultCheckArmCmdVsDS_ArmStage1Guard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckArmCmdVsDS_ArmStage2 first ArmStage2 accept FaultCheckArmCmdVsDS_ArmStage2Trigger if FaultCheckArmCmdVsDS_ArmStage2Guard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckArmCmdVsDS_ArmedState first ArmedState accept FaultCheckArmCmdVsDS_ArmedStateTrigger if FaultCheckArmCmdVsDS_ArmedStateGuard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckEarlyDiscreteArm_SafeMode first SafeMode accept FaultCheckEarlyDiscreteArm_SafeModeTrigger if FaultCheckEarlyDiscreteArm_SafeModeGuard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckEarlyDiscreteArm_ArmStage1 first ArmStage1 accept FaultCheckEarlyDiscreteArm_ArmStage1Trigger if FaultCheckEarlyDiscreteArm_ArmStage1Guard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckEarlyDiscreteArm_ArmStage2 first ArmStage2 accept FaultCheckEarlyDiscreteArm_ArmStage2Trigger if FaultCheckEarlyDiscreteArm_ArmStage2Guard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckEarlyDiscreteArm_ArmedState first ArmedState accept FaultCheckEarlyDiscreteArm_ArmedStateTrigger if FaultCheckEarlyDiscreteArm_ArmedStateGuard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckOcErrorCommand_SafeMode first SafeMode accept FaultCheckOcErrorCommand_SafeModeTrigger if FaultCheckOcErrorCommand_SafeModeGuard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckOcErrorCommand_ArmStage1 first ArmStage1 accept FaultCheckOcErrorCommand_ArmStage1Trigger if FaultCheckOcErrorCommand_ArmStage1Guard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckOcErrorCommand_ArmStage2 first ArmStage2 accept FaultCheckOcErrorCommand_ArmStage2Trigger if FaultCheckOcErrorCommand_ArmStage2Guard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_FaultCheckOcErrorCommand_ArmedState first ArmedState accept FaultCheckOcErrorCommand_ArmedStateTrigger if FaultCheckOcErrorCommand_ArmedStateGuard then FaultState;
            transition T_FSM_ESAD_SAFE_AND_ARM_ReinstallEsadSafetyPin first ArmStage1 accept ReinstallEsadSafetyPinTrigger if ReinstallEsadSafetyPinGuard then SafeMode;
            transition T_FSM_ESAD_SAFE_AND_ARM_PostLandingAutoSafe first ArmStage2 accept PostLandingAutoSafeTrigger if PostLandingAutoSafeGuard then SafeMode;
            transition T_FSM_ESAD_SAFE_AND_ARM_PowerOffEsadAirborne_SafeMode first SafeMode accept PowerOffEsadAirborne_SafeModeTrigger if PowerOffEsadAirborne_SafeModeGuard then AbortedOrSelfDestructed;
            transition T_FSM_ESAD_SAFE_AND_ARM_PowerOffEsadAirborne_ArmStage1 first ArmStage1 accept PowerOffEsadAirborne_ArmStage1Trigger if PowerOffEsadAirborne_ArmStage1Guard then AbortedOrSelfDestructed;
            transition T_FSM_ESAD_SAFE_AND_ARM_PowerOffEsadAirborne_ArmStage2 first ArmStage2 accept PowerOffEsadAirborne_ArmStage2Trigger if PowerOffEsadAirborne_ArmStage2Guard then AbortedOrSelfDestructed;
            transition T_FSM_ESAD_SAFE_AND_ARM_PowerOffEsadAirborne_ArmedState first ArmedState accept PowerOffEsadAirborne_ArmedStateTrigger if PowerOffEsadAirborne_ArmedStateGuard then AbortedOrSelfDestructed;
            transition T_FSM_ESAD_SAFE_AND_ARM_OperatorDisarmEsad first ArmedState accept OperatorDisarmEsadTrigger if OperatorDisarmEsadGuard then ArmStage2;
            transition T_FSM_ESAD_SAFE_AND_ARM_GcsTimeoutDisarmEsad first ArmedState accept GcsTimeoutDisarmEsadTrigger if GcsTimeoutDisarmEsadGuard then ArmStage2;
            transition T_FSM_ESAD_SAFE_AND_ARM_AbortEsadMission first ArmStage2 accept AbortEsadMissionTrigger if AbortEsadMissionGuard then AbortedOrSelfDestructed;
            transition T_FSM_ESAD_SAFE_AND_ARM_AbortEsadMission_ArmedState first ArmedState accept AbortEsadMission_ArmedStateTrigger if AbortEsadMission_ArmedStateGuard then AbortedOrSelfDestructed;
            transition T_FSM_ESAD_SAFE_AND_ARM_SelfDestructEsad first ArmedState accept SelfDestructEsadTrigger if SelfDestructEsadGuard then AbortedOrSelfDestructed;
            transition T_FSM_ESAD_SAFE_AND_ARM_Term first FiredState then Terminal;
            transition T_FSM_ESAD_SAFE_AND_ARM_TermAbort first AbortedOrSelfDestructed then Terminal;
            transition T_FSM_ESAD_SAFE_AND_ARM_TermFault first FaultState then Terminal;
        }
        state def FSM_ESAD_BOOT_PBIT_MODESELECT {
            state PowerOn;
            state WaitWelcome;
            state RunPbit500ms;
            state WaitPbitQuery;
            state ExchangeActive100ms;
            state FlightModeSelected;
            state SimulationModeSelected;
            transition T_FSM_ESAD_BOOT_PBIT_MODESELECT_Init first Initial then PowerOn;
            transition T_FSM_ESAD_BOOT_PBIT_MODESELECT_ResetComplete first PowerOn accept ResetCompleteTrigger if ResetCompleteGuard then WaitWelcome;
            transition T_FSM_ESAD_BOOT_PBIT_MODESELECT_WelcomeHandshakeToPbit first WaitWelcome accept WelcomeHandshakeToPbitTrigger if WelcomeHandshakeToPbitGuard then RunPbit500ms;
            transition T_FSM_ESAD_BOOT_PBIT_MODESELECT_PbitCompleteWaitQuery first RunPbit500ms accept PbitCompleteWaitQueryTrigger if PbitCompleteWaitQueryGuard then WaitPbitQuery;
            transition T_FSM_ESAD_BOOT_PBIT_MODESELECT_PbitQuerySuccessToExchange first WaitPbitQuery accept PbitQuerySuccessToExchangeTrigger if PbitQuerySuccessToExchangeGuard then ExchangeActive100ms;
            transition T_FSM_ESAD_BOOT_PBIT_MODESELECT_TimeoutToFlightMode first ExchangeActive100ms accept TimeoutToFlightModeTrigger if TimeoutToFlightModeGuard then FlightModeSelected;
            transition T_FSM_ESAD_BOOT_PBIT_MODESELECT_SelectSimulationMode first ExchangeActive100ms accept SelectSimulationModeTrigger if SelectSimulationModeGuard then SimulationModeSelected;
            transition T_FSM_ESAD_BOOT_PBIT_MODESELECT_TermFlight first FlightModeSelected then Terminal;
            transition T_FSM_ESAD_BOOT_PBIT_MODESELECT_TermSim first SimulationModeSelected then Terminal;
        }
        state def FSM_DOC02_TERMINAL_ENGAGEMENT {
            state MissionNavigation;
            state TargetDetectionAndTracking;
            state TargetLocked_AutonomousTerminal;
            state LinkInterrupted_AutonomousContinue;
            state SteepTerminalApproach;
            transition T_FSM_DOC02_TERMINAL_ENGAGEMENT_Init first Initial then MissionNavigation;
            transition T_FSM_DOC02_TERMINAL_ENGAGEMENT_DetectAndTrackTarget first MissionNavigation accept DetectAndTrackTargetTrigger if DetectAndTrackTargetGuard then TargetDetectionAndTracking;
            transition T_FSM_DOC02_TERMINAL_ENGAGEMENT_ConfirmTargetLock first TargetDetectionAndTracking accept ConfirmTargetLockTrigger if ConfirmTargetLockGuard then TargetLocked_AutonomousTerminal;
            transition T_FSM_DOC02_TERMINAL_ENGAGEMENT_ProceedOnRadioDisruption first TargetLocked_AutonomousTerminal accept ProceedOnRadioDisruptionTrigger if ProceedOnRadioDisruptionGuard then LinkInterrupted_AutonomousContinue;
            transition T_FSM_DOC02_TERMINAL_ENGAGEMENT_EnterSteepTerminalApproachFromLock first TargetLocked_AutonomousTerminal accept EnterSteepTerminalApproachFromLockTrigger if EnterSteepTerminalApproachFromLockGuard then SteepTerminalApproach;
            transition T_FSM_DOC02_TERMINAL_ENGAGEMENT_EnterSteepTerminalApproachAutonomous first LinkInterrupted_AutonomousContinue accept EnterSteepTerminalApproachAutonomousTrigger if EnterSteepTerminalApproachAutonomousGuard then SteepTerminalApproach;
            transition T_FSM_DOC02_TERMINAL_ENGAGEMENT_Term first SteepTerminalApproach then Terminal;
        }
        state def FSM_DOC02_NAVIGATION_FAILSAFE {
            state AutonomousWaypointNav_GnssNominal;
            state GnssDenied_DeadReckoningCorrection;
            state ProgrammableFailsafeRoute;
            transition T_FSM_DOC02_NAVIGATION_FAILSAFE_Init first Initial then AutonomousWaypointNav_GnssNominal;
            transition T_FSM_DOC02_NAVIGATION_FAILSAFE_EnterGnssDeniedMode first AutonomousWaypointNav_GnssNominal accept EnterGnssDeniedModeTrigger if EnterGnssDeniedModeGuard then GnssDenied_DeadReckoningCorrection;
            transition T_FSM_DOC02_NAVIGATION_FAILSAFE_RestoreNominalGnss first GnssDenied_DeadReckoningCorrection accept RestoreNominalGnssTrigger if RestoreNominalGnssGuard then AutonomousWaypointNav_GnssNominal;
            transition T_FSM_DOC02_NAVIGATION_FAILSAFE_ActivateProgrammableFailsafeFromNominal first AutonomousWaypointNav_GnssNominal accept ActivateProgrammableFailsafeFromNominalTrigger if ActivateProgrammableFailsafeFromNominalGuard then ProgrammableFailsafeRoute;
            transition T_FSM_DOC02_NAVIGATION_FAILSAFE_ActivateProgrammableFailsafeFromDenied first GnssDenied_DeadReckoningCorrection accept ActivateProgrammableFailsafeFromDeniedTrigger if ActivateProgrammableFailsafeFromDeniedGuard then ProgrammableFailsafeRoute;
            transition T_FSM_DOC02_NAVIGATION_FAILSAFE_Term first ProgrammableFailsafeRoute then Terminal;
        }
        state def FSM_PL40_COMPRESSOR_CONTROLLER {
            state TurnedOff;
            state CheckInit;
            state PressurizingToTarget;
            state TargetPressureReached;
            state OverTargetPressureHold;
            state SetModePressurizing;
            state SetModeMaxPressureReached;
            state BatteryOverDischargeCutoff;
            state BatteryRecoveryDelay5s;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_Init first Initial then TurnedOff;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_PowerOnNormal first TurnedOff accept PowerOnNormalTrigger if PowerOnNormalGuard then CheckInit;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_PowerOnEnterSetMode first TurnedOff accept PowerOnEnterSetModeTrigger if PowerOnEnterSetModeGuard then SetModePressurizing;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_InitBatteryTooLow first CheckInit accept InitBatteryTooLowTrigger if InitBatteryTooLowGuard then BatteryOverDischargeCutoff;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_InitNeedPressurization first CheckInit accept InitNeedPressurizationTrigger if InitNeedPressurizationGuard then PressurizingToTarget;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_InitTargetReached first CheckInit accept InitTargetReachedTrigger if InitTargetReachedGuard then TargetPressureReached;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_InitOverTargetPressure first CheckInit accept InitOverTargetPressureTrigger if InitOverTargetPressureGuard then OverTargetPressureHold;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_TargetPressureMet first PressurizingToTarget accept TargetPressureMetTrigger if TargetPressureMetGuard then TargetPressureReached;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_HysteresisOrPostLaunchRecharge first TargetPressureReached accept HysteresisOrPostLaunchRechargeTrigger if HysteresisOrPostLaunchRechargeGuard then PressurizingToTarget;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_OverDischargeCutoffDuringRun first PressurizingToTarget accept OverDischargeCutoffDuringRunTrigger if OverDischargeCutoffDuringRunGuard then BatteryOverDischargeCutoff;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_BatteryVoltageRecovering first BatteryOverDischargeCutoff accept BatteryVoltageRecoveringTrigger if BatteryVoltageRecoveringGuard then BatteryRecoveryDelay5s;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_BatteryRecoveryResume first BatteryRecoveryDelay5s accept BatteryRecoveryResumeTrigger if BatteryRecoveryResumeGuard then PressurizingToTarget;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_SetModeSaveDesiredPressure first SetModePressurizing accept SetModeSaveDesiredPressureTrigger if SetModeSaveDesiredPressureGuard then TargetPressureReached;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_SetModeMax14BarAutoStop first SetModePressurizing accept SetModeMax14BarAutoStopTrigger if SetModeMax14BarAutoStopGuard then SetModeMaxPressureReached;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_SetModeSaveMax14Bar first SetModeMaxPressureReached accept SetModeSaveMax14BarTrigger if SetModeSaveMax14BarGuard then TargetPressureReached;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_SetModeCancelPressurizing first SetModePressurizing accept SetModeCancelPressurizingTrigger if SetModeCancelPressurizingGuard then TurnedOff;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_SetModeCancelAtMax first SetModeMaxPressureReached accept SetModeCancelAtMaxTrigger if SetModeCancelAtMaxGuard then TurnedOff;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_TurnOffFromTarget first TargetPressureReached accept TurnOffFromTargetTrigger if TurnOffFromTargetGuard then TurnedOff;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_TurnOffFromPressurizing first PressurizingToTarget accept TurnOffFromPressurizingTrigger if TurnOffFromPressurizingGuard then TurnedOff;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_TurnOffFromOverTarget first OverTargetPressureHold accept TurnOffFromOverTargetTrigger if TurnOffFromOverTargetGuard then TurnedOff;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_TurnOffFromLowBattery first BatteryOverDischargeCutoff accept TurnOffFromLowBatteryTrigger if TurnOffFromLowBatteryGuard then TurnedOff;
            transition T_FSM_PL40_COMPRESSOR_CONTROLLER_Term first TurnedOff then Terminal;
        }
        state def FSM_PL40_LAUNCH_AND_INTERLOCK {
            state StowedInCases;
            state RailAssembledAndAnchored;
            state HoseConnectedAndPressurizing;
            state PayloadMountedAndLocked;
            state MainValvePressurized_SafetyPinIn;
            state ReadyToFire_SafetyPinRemoved;
            state Launching_TriggerHeld;
            state PostLaunch_MainValveClosed;
            state AbortOrMisfireResetRequired;
            state Disassembled;
            transition T_FSM_PL40_LAUNCH_AND_INTERLOCK_Init first Initial then StowedInCases;
            transition T_FSM_PL40_LAUNCH_AND_INTERLOCK_AssembleAndAnchorLauncher first StowedInCases accept AssembleAndAnchorLauncherTrigger if AssembleAndAnchorLauncherGuard then RailAssembledAndAnchored;
            transition T_FSM_PL40_LAUNCH_AND_INTERLOCK_ConnectHoseAndPressurize first RailAssembledAndAnchored accept ConnectHoseAndPressurizeTrigger if ConnectHoseAndPressurizeGuard then HoseConnectedAndPressurizing;
            transition T_FSM_PL40_LAUNCH_AND_INTERLOCK_MountPayloadAndVerifyZeroGap first HoseConnectedAndPressurizing accept MountPayloadAndVerifyZeroGapTrigger if MountPayloadAndVerifyZeroGapGuard then PayloadMountedAndLocked;
            transition T_FSM_PL40_LAUNCH_AND_INTERLOCK_OpenReservoirOutletValve first PayloadMountedAndLocked accept OpenReservoirOutletValveTrigger if OpenReservoirOutletValveGuard then MainValvePressurized_SafetyPinIn;
            transition T_FSM_PL40_LAUNCH_AND_INTERLOCK_ClearAreaAndRemoveSafetyPin first MainValvePressurized_SafetyPinIn accept ClearAreaAndRemoveSafetyPinTrigger if ClearAreaAndRemoveSafetyPinGuard then ReadyToFire_SafetyPinRemoved;
            transition T_FSM_PL40_LAUNCH_AND_INTERLOCK_TriggerLaunchFire first ReadyToFire_SafetyPinRemoved accept TriggerLaunchFireTrigger if TriggerLaunchFireGuard then Launching_TriggerHeld;
            transition T_FSM_PL40_LAUNCH_AND_INTERLOCK_CompleteLaunchAndCloseMainValve first Launching_TriggerHeld accept CompleteLaunchAndCloseMainValveTrigger if CompleteLaunchAndCloseMainValveGuard then PostLaunch_MainValveClosed;
            transition T_FSM_PL40_LAUNCH_AND_INTERLOCK_MisfireTriggerWithPinInstalled first MainValvePressurized_SafetyPinIn accept MisfireTriggerWithPinInstalledTrigger if MisfireTriggerWithPinInstalledGuard then AbortOrMisfireResetRequired;
            transition T_FSM_PL40_LAUNCH_AND_INTERLOCK_AbortPneumaticOverAccelerationShutoff first Launching_TriggerHeld accept AbortPneumaticOverAccelerationShutoffTrigger if AbortPneumaticOverAccelerationShutoffGuard then AbortOrMisfireResetRequired;
            transition T_FSM_PL40_LAUNCH_AND_INTERLOCK_RestartLaunchPrepAfterAbort first AbortOrMisfireResetRequired accept RestartLaunchPrepAfterAbortTrigger if RestartLaunchPrepAfterAbortGuard then HoseConnectedAndPressurizing;
            transition T_FSM_PL40_LAUNCH_AND_INTERLOCK_PrepareConsecutiveLaunch first PostLaunch_MainValveClosed accept PrepareConsecutiveLaunchTrigger if PrepareConsecutiveLaunchGuard then HoseConnectedAndPressurizing;
            transition T_FSM_PL40_LAUNCH_AND_INTERLOCK_DisassembleAfterLaunch first PostLaunch_MainValveClosed accept DisassembleAfterLaunchTrigger if DisassembleAfterLaunchGuard then Disassembled;
            transition T_FSM_PL40_LAUNCH_AND_INTERLOCK_DisassembleAbortedSetup first RailAssembledAndAnchored accept DisassembleAbortedSetupTrigger if DisassembleAbortedSetupGuard then Disassembled;
            transition T_FSM_PL40_LAUNCH_AND_INTERLOCK_Term first Disassembled then Terminal;
        }
        state def FSM_DOC05_UAV_PREP_AND_ASSEMBLY {
            state EquipmentStagedAndAuthorized;
            state TransportBoxOpened_EsdRequired;
            state EsdEqualized_PayloadBayOpen;
            state WarheadInstalled_PayloadBayLocked;
            state BatteryInstalled_HatchLocked;
            state MountedOnCatapultTrolley;
            state WingsSecured;
            state TailStabilisersSecured;
            state MechanicalCheckPassed_PropFolded;
            transition T_FSM_DOC05_UAV_PREP_AND_ASSEMBLY_Init first Initial then EquipmentStagedAndAuthorized;
            transition T_FSM_DOC05_UAV_PREP_AND_ASSEMBLY_VerifyTrainingStorageAndOpenTransportBox first EquipmentStagedAndAuthorized accept VerifyTrainingStorageAndOpenTransportBoxTrigger if VerifyTrainingStorageAndOpenTransportBoxGuard then TransportBoxOpened_EsdRequired;
            transition T_FSM_DOC05_UAV_PREP_AND_ASSEMBLY_TouchEsdGroundingAndOpenPayloadBay first TransportBoxOpened_EsdRequired accept TouchEsdGroundingAndOpenPayloadBayTrigger if TouchEsdGroundingAndOpenPayloadBayGuard then EsdEqualized_PayloadBayOpen;
            transition T_FSM_DOC05_UAV_PREP_AND_ASSEMBLY_InstallWarheadAndLockPayloadBay first EsdEqualized_PayloadBayOpen accept InstallWarheadAndLockPayloadBayTrigger if InstallWarheadAndLockPayloadBayGuard then WarheadInstalled_PayloadBayLocked;
            transition T_FSM_DOC05_UAV_PREP_AND_ASSEMBLY_InspectMatchAndInstallBattery first WarheadInstalled_PayloadBayLocked accept InspectMatchAndInstallBatteryTrigger if InspectMatchAndInstallBatteryGuard then BatteryInstalled_HatchLocked;
            transition T_FSM_DOC05_UAV_PREP_AND_ASSEMBLY_TwoPersonLiftOntoCatapultTrolley first BatteryInstalled_HatchLocked accept TwoPersonLiftOntoCatapultTrolleyTrigger if TwoPersonLiftOntoCatapultTrolleyGuard then MountedOnCatapultTrolley;
            transition T_FSM_DOC05_UAV_PREP_AND_ASSEMBLY_RotateAndSecureWings first MountedOnCatapultTrolley accept RotateAndSecureWingsTrigger if RotateAndSecureWingsGuard then WingsSecured;
            transition T_FSM_DOC05_UAV_PREP_AND_ASSEMBLY_InstallTailStabilisers first WingsSecured accept InstallTailStabilisersTrigger if InstallTailStabilisersGuard then TailStabilisersSecured;
            transition T_FSM_DOC05_UAV_PREP_AND_ASSEMBLY_ConfirmFoldingPropellerRearward first TailStabilisersSecured accept ConfirmFoldingPropellerRearwardTrigger if ConfirmFoldingPropellerRearwardGuard then MechanicalCheckPassed_PropFolded;
            transition T_FSM_DOC05_UAV_PREP_AND_ASSEMBLY_Term first MechanicalCheckPassed_PropFolded then Terminal;
        }
        state def FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING {
            state AllRbfsInstalled_PoweredOff;
            state FrontRbfs1Removed_PoweredOff;
            state PoweredOn_GcsConnected_Diagnostics;
            state PreFlightNominal_ReadyForRbf3;
            state EsadFault_PrematureRbf3Removal;
            state Hold_NonNominalOrUnauthorized;
            state EsadRbf3Removed_ReadyToFly;
            state LaunchClearedAndConfirmed;
            transition T_FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING_Init first Initial then AllRbfsInstalled_PoweredOff;
            transition T_FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING_RemoveFrontRbfs1 first AllRbfsInstalled_PoweredOff accept RemoveFrontRbfs1Trigger if RemoveFrontRbfs1Guard then FrontRbfs1Removed_PoweredOff;
            transition T_FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING_PrematureEsadRbf3FaultFromOff first AllRbfsInstalled_PoweredOff accept PrematureEsadRbf3FaultFromOffTrigger if PrematureEsadRbf3FaultFromOffGuard then EsadFault_PrematureRbf3Removal;
            transition T_FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING_PrematureEsadRbf3FaultBeforeDiagnostics first FrontRbfs1Removed_PoweredOff accept PrematureEsadRbf3FaultBeforeDiagnosticsTrigger if PrematureEsadRbf3FaultBeforeDiagnosticsGuard then EsadFault_PrematureRbf3Removal;
            transition T_FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING_PrematureEsadRbf3FaultDuringDiagnostics first PoweredOn_GcsConnected_Diagnostics accept PrematureEsadRbf3FaultDuringDiagnosticsTrigger if PrematureEsadRbf3FaultDuringDiagnosticsGuard then EsadFault_PrematureRbf3Removal;
            transition T_FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING_PrematureEsadRbf3FaultDuringHold first Hold_NonNominalOrUnauthorized accept PrematureEsadRbf3FaultDuringHoldTrigger if PrematureEsadRbf3FaultDuringHoldGuard then EsadFault_PrematureRbf3Removal;
            transition T_FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING_RemovePowerRbf2AndLockLids first FrontRbfs1Removed_PoweredOff accept RemovePowerRbf2AndLockLidsTrigger if RemovePowerRbf2AndLockLidsGuard then PoweredOn_GcsConnected_Diagnostics;
            transition T_FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING_VerifyAllEightPreRbf3Conditions first PoweredOn_GcsConnected_Diagnostics accept VerifyAllEightPreRbf3ConditionsTrigger if VerifyAllEightPreRbf3ConditionsGuard then PreFlightNominal_ReadyForRbf3;
            transition T_FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING_HoldOnNonNominalIndication first PoweredOn_GcsConnected_Diagnostics accept HoldOnNonNominalIndicationTrigger if HoldOnNonNominalIndicationGuard then Hold_NonNominalOrUnauthorized;
            transition T_FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING_ResumeDiagnosticsAfterResolution first Hold_NonNominalOrUnauthorized accept ResumeDiagnosticsAfterResolutionTrigger if ResumeDiagnosticsAfterResolutionGuard then PoweredOn_GcsConnected_Diagnostics;
            transition T_FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING_RemoveEsadRbf3AndConfirmReadyToFly first PreFlightNominal_ReadyForRbf3 accept RemoveEsadRbf3AndConfirmReadyToFlyTrigger if RemoveEsadRbf3AndConfirmReadyToFlyGuard then EsadRbf3Removed_ReadyToFly;
            transition T_FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING_HoldIfRbf3UnverifiedOrNotReadyToFly first PreFlightNominal_ReadyForRbf3 accept HoldIfRbf3UnverifiedOrNotReadyToFlyTrigger if HoldIfRbf3UnverifiedOrNotReadyToFlyGuard then Hold_NonNominalOrUnauthorized;
            transition T_FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING_ConfirmSafeDistanceAndExecuteLaunch first EsadRbf3Removed_ReadyToFly accept ConfirmSafeDistanceAndExecuteLaunchTrigger if ConfirmSafeDistanceAndExecuteLaunchGuard then LaunchClearedAndConfirmed;
            transition T_FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING_Term first LaunchClearedAndConfirmed then Terminal;
            transition T_FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING_TermFault first EsadFault_PrematureRbf3Removal then Terminal;
        }
        state def FSM_DOC05_LAUNCH_SITE_AND_CATAPULT_PREP {
            state LaunchAndGcsUnpacked;
            state CatapultAssembledAndPressurized;
            state GcsSetupAndAntennaCalibrated;
            state LaunchAreaClearedAndReady;
            transition T_FSM_DOC05_LAUNCH_SITE_AND_CATAPULT_PREP_Init first Initial then LaunchAndGcsUnpacked;
            transition T_FSM_DOC05_LAUNCH_SITE_AND_CATAPULT_PREP_AssembleAndPressurizePl40 first LaunchAndGcsUnpacked accept AssembleAndPressurizePl40Trigger if AssembleAndPressurizePl40Guard then CatapultAssembledAndPressurized;
            transition T_FSM_DOC05_LAUNCH_SITE_AND_CATAPULT_PREP_SetupAndCalibrateGcs first CatapultAssembledAndPressurized accept SetupAndCalibrateGcsTrigger if SetupAndCalibrateGcsGuard then GcsSetupAndAntennaCalibrated;
            transition T_FSM_DOC05_LAUNCH_SITE_AND_CATAPULT_PREP_ClearPersonnelAndConfirmLaunchSafe first GcsSetupAndAntennaCalibrated accept ClearPersonnelAndConfirmLaunchSafeTrigger if ClearPersonnelAndConfirmLaunchSafeGuard then LaunchAreaClearedAndReady;
            transition T_FSM_DOC05_LAUNCH_SITE_AND_CATAPULT_PREP_Term first LaunchAreaClearedAndReady then Terminal;
        }
        state def FSM_UAV_FLIGHT_MODES {
            state DisarmedPreflight;
            state ArmedPreLaunch;
            state Auto;
            state Cruise;
            state Loiter;
            state Rtl;
            state Manual;
            state Guided;
            state Attack;
            transition T_FSM_UAV_FLIGHT_MODES_Init first Initial then DisarmedPreflight;
            transition T_FSM_UAV_FLIGHT_MODES_ArmUav first DisarmedPreflight accept ArmUavTrigger if ArmUavGuard then ArmedPreLaunch;
            transition T_FSM_UAV_FLIGHT_MODES_LaunchAutoMission first ArmedPreLaunch accept LaunchAutoMissionTrigger if LaunchAutoMissionGuard then Auto;
            transition T_FSM_UAV_FLIGHT_MODES_DefaultRtlIfNoMission first ArmedPreLaunch accept DefaultRtlIfNoMissionTrigger if DefaultRtlIfNoMissionGuard then Rtl;
            transition T_FSM_UAV_FLIGHT_MODES_SelectCruise first Auto accept SelectCruiseTrigger if SelectCruiseGuard then Cruise;
            transition T_FSM_UAV_FLIGHT_MODES_SelectLoiter first Auto accept SelectLoiterTrigger if SelectLoiterGuard then Loiter;
            transition T_FSM_UAV_FLIGHT_MODES_EnterRtl first Auto accept EnterRtlTrigger if EnterRtlGuard then Rtl;
            transition T_FSM_UAV_FLIGHT_MODES_SelectManual first Auto accept SelectManualTrigger if SelectManualGuard then Manual;
            transition T_FSM_UAV_FLIGHT_MODES_EnterGuidedPattern first Auto accept EnterGuidedPatternTrigger if EnterGuidedPatternGuard then Guided;
            transition T_FSM_UAV_FLIGHT_MODES_ResumeAutoFromGuided first Guided accept ResumeAutoFromGuidedTrigger if ResumeAutoFromGuidedGuard then Auto;
            transition T_FSM_UAV_FLIGHT_MODES_SelectAutoFromCruise first Cruise accept SelectAutoFromCruiseTrigger if SelectAutoFromCruiseGuard then Auto;
            transition T_FSM_UAV_FLIGHT_MODES_SelectLoiterFromCruise first Cruise accept SelectLoiterFromCruiseTrigger if SelectLoiterFromCruiseGuard then Loiter;
            transition T_FSM_UAV_FLIGHT_MODES_EnterGuidedFromCruise first Cruise accept EnterGuidedFromCruiseTrigger if EnterGuidedFromCruiseGuard then Guided;
            transition T_FSM_UAV_FLIGHT_MODES_SelectManualFromCruise first Cruise accept SelectManualFromCruiseTrigger if SelectManualFromCruiseGuard then Manual;
            transition T_FSM_UAV_FLIGHT_MODES_EnterRtlFromCruise first Cruise accept EnterRtlFromCruiseTrigger if EnterRtlFromCruiseGuard then Rtl;
            transition T_FSM_UAV_FLIGHT_MODES_SelectAutoFromLoiter first Loiter accept SelectAutoFromLoiterTrigger if SelectAutoFromLoiterGuard then Auto;
            transition T_FSM_UAV_FLIGHT_MODES_SelectCruiseFromLoiter first Loiter accept SelectCruiseFromLoiterTrigger if SelectCruiseFromLoiterGuard then Cruise;
            transition T_FSM_UAV_FLIGHT_MODES_EnterGuidedFromLoiter first Loiter accept EnterGuidedFromLoiterTrigger if EnterGuidedFromLoiterGuard then Guided;
            transition T_FSM_UAV_FLIGHT_MODES_SelectManualFromLoiter first Loiter accept SelectManualFromLoiterTrigger if SelectManualFromLoiterGuard then Manual;
            transition T_FSM_UAV_FLIGHT_MODES_EnterRtlFromLoiter first Loiter accept EnterRtlFromLoiterTrigger if EnterRtlFromLoiterGuard then Rtl;
            transition T_FSM_UAV_FLIGHT_MODES_SelectCruiseFromGuided first Guided accept SelectCruiseFromGuidedTrigger if SelectCruiseFromGuidedGuard then Cruise;
            transition T_FSM_UAV_FLIGHT_MODES_SelectLoiterFromGuided first Guided accept SelectLoiterFromGuidedTrigger if SelectLoiterFromGuidedGuard then Loiter;
            transition T_FSM_UAV_FLIGHT_MODES_SelectManualFromGuided first Guided accept SelectManualFromGuidedTrigger if SelectManualFromGuidedGuard then Manual;
            transition T_FSM_UAV_FLIGHT_MODES_EnterRtlFromGuided first Guided accept EnterRtlFromGuidedTrigger if EnterRtlFromGuidedGuard then Rtl;
            transition T_FSM_UAV_FLIGHT_MODES_SelectAutoFromManual first Manual accept SelectAutoFromManualTrigger if SelectAutoFromManualGuard then Auto;
            transition T_FSM_UAV_FLIGHT_MODES_SelectCruiseFromManual first Manual accept SelectCruiseFromManualTrigger if SelectCruiseFromManualGuard then Cruise;
            transition T_FSM_UAV_FLIGHT_MODES_SelectLoiterFromManual first Manual accept SelectLoiterFromManualTrigger if SelectLoiterFromManualGuard then Loiter;
            transition T_FSM_UAV_FLIGHT_MODES_EnterGuidedFromManual first Manual accept EnterGuidedFromManualTrigger if EnterGuidedFromManualGuard then Guided;
            transition T_FSM_UAV_FLIGHT_MODES_EnterRtlFromManual first Manual accept EnterRtlFromManualTrigger if EnterRtlFromManualGuard then Rtl;
            transition T_FSM_UAV_FLIGHT_MODES_ResumeAutoFromRtl first Rtl accept ResumeAutoFromRtlTrigger if ResumeAutoFromRtlGuard then Auto;
            transition T_FSM_UAV_FLIGHT_MODES_SelectCruiseFromRtl first Rtl accept SelectCruiseFromRtlTrigger if SelectCruiseFromRtlGuard then Cruise;
            transition T_FSM_UAV_FLIGHT_MODES_SelectLoiterFromRtl first Rtl accept SelectLoiterFromRtlTrigger if SelectLoiterFromRtlGuard then Loiter;
            transition T_FSM_UAV_FLIGHT_MODES_EnterGuidedFromRtl first Rtl accept EnterGuidedFromRtlTrigger if EnterGuidedFromRtlGuard then Guided;
            transition T_FSM_UAV_FLIGHT_MODES_SelectManualFromRtl first Rtl accept SelectManualFromRtlTrigger if SelectManualFromRtlGuard then Manual;
            transition T_FSM_UAV_FLIGHT_MODES_EngageAttackModeFromLoiter first Loiter accept EngageAttackModeFromLoiterTrigger if EngageAttackModeFromLoiterGuard then Attack;
            transition T_FSM_UAV_FLIGHT_MODES_EngageAttackModeFromAuto first Auto accept EngageAttackModeFromAutoTrigger if EngageAttackModeFromAutoGuard then Attack;
            transition T_FSM_UAV_FLIGHT_MODES_EngageAttackModeFromGuided first Guided accept EngageAttackModeFromGuidedTrigger if EngageAttackModeFromGuidedGuard then Attack;
            transition T_FSM_UAV_FLIGHT_MODES_AbortEngagingToGuided first Attack accept AbortEngagingToGuidedTrigger if AbortEngagingToGuidedGuard then Guided;
            transition T_FSM_UAV_FLIGHT_MODES_AbortEngagingNoLinkToRtl first Attack accept AbortEngagingNoLinkToRtlTrigger if AbortEngagingNoLinkToRtlGuard then Rtl;
            transition T_FSM_UAV_FLIGHT_MODES_TermAttack first Attack then Terminal;
            transition T_FSM_UAV_FLIGHT_MODES_TermRtl first Rtl then Terminal;
        }
        state def FSM_SWARMC2_APP_AND_AUTH {
            state StandaloneMode;
            state ConnectedLoggedOut;
            state PasswordResetRequired;
            state OperationGroundConfig;
            state OperationUavActive;
            transition T_FSM_SWARMC2_APP_AND_AUTH_Init first Initial then StandaloneMode;
            transition T_FSM_SWARMC2_APP_AND_AUTH_ConnectGroundStation first StandaloneMode accept ConnectGroundStationTrigger if ConnectGroundStationGuard then ConnectedLoggedOut;
            transition T_FSM_SWARMC2_APP_AND_AUTH_DefaultPasswordPrompt first ConnectedLoggedOut accept DefaultPasswordPromptTrigger if DefaultPasswordPromptGuard then PasswordResetRequired;
            transition T_FSM_SWARMC2_APP_AND_AUTH_CompletePasswordReset first PasswordResetRequired accept CompletePasswordResetTrigger if CompletePasswordResetGuard then ConnectedLoggedOut;
            transition T_FSM_SWARMC2_APP_AND_AUTH_RejectOrExpirePasswordReset first PasswordResetRequired accept RejectOrExpirePasswordResetTrigger if RejectOrExpirePasswordResetGuard then ConnectedLoggedOut;
            transition T_FSM_SWARMC2_APP_AND_AUTH_LoginSuccess first ConnectedLoggedOut accept LoginSuccessTrigger if LoginSuccessGuard then OperationGroundConfig;
            transition T_FSM_SWARMC2_APP_AND_AUTH_UavTelemetryDetected first OperationGroundConfig accept UavTelemetryDetectedTrigger if UavTelemetryDetectedGuard then OperationUavActive;
            transition T_FSM_SWARMC2_APP_AND_AUTH_UavLinkLostToGroundConfig first OperationUavActive accept UavLinkLostToGroundConfigTrigger if UavLinkLostToGroundConfigGuard then OperationGroundConfig;
            transition T_FSM_SWARMC2_APP_AND_AUTH_LogoutToConnectedLoggedOut first OperationUavActive accept LogoutToConnectedLoggedOutTrigger if LogoutToConnectedLoggedOutGuard then ConnectedLoggedOut;
            transition T_FSM_SWARMC2_APP_AND_AUTH_LogoutFromGroundConfig first OperationGroundConfig accept LogoutFromGroundConfigTrigger if LogoutFromGroundConfigGuard then ConnectedLoggedOut;
            transition T_FSM_SWARMC2_APP_AND_AUTH_DisconnectUavActiveToStandalone first OperationUavActive accept DisconnectUavActiveToStandaloneTrigger if DisconnectUavActiveToStandaloneGuard then StandaloneMode;
            transition T_FSM_SWARMC2_APP_AND_AUTH_DisconnectGroundConfigToStandalone first OperationGroundConfig accept DisconnectGroundConfigToStandaloneTrigger if DisconnectGroundConfigToStandaloneGuard then StandaloneMode;
            transition T_FSM_SWARMC2_APP_AND_AUTH_DisconnectLoggedOutToStandalone first ConnectedLoggedOut accept DisconnectLoggedOutToStandaloneTrigger if DisconnectLoggedOutToStandaloneGuard then StandaloneMode;
            transition T_FSM_SWARMC2_APP_AND_AUTH_Term first OperationUavActive then Terminal;
        }
        state def FSM_GIMBAL_CAMERA_MODES {
            state RetractedClosed;
            state Stow;
            state Nadir;
            state Ptc;
            state Obs;
            state Grr;
            transition T_FSM_GIMBAL_CAMERA_MODES_Init first Initial then RetractedClosed;
            transition T_FSM_GIMBAL_CAMERA_MODES_OpenGimbal first RetractedClosed accept OpenGimbalTrigger if OpenGimbalGuard then Stow;
            transition T_FSM_GIMBAL_CAMERA_MODES_CloseGimbal first Stow accept CloseGimbalTrigger if CloseGimbalGuard then RetractedClosed;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchStowToNadir first Stow accept SwitchStowToNadirTrigger if SwitchStowToNadirGuard then Nadir;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchStowToPtc first Stow accept SwitchStowToPtcTrigger if SwitchStowToPtcGuard then Ptc;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchStowToObs first Stow accept SwitchStowToObsTrigger if SwitchStowToObsGuard then Obs;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchStowToGrr first Stow accept SwitchStowToGrrTrigger if SwitchStowToGrrGuard then Grr;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchNadirToStow first Nadir accept SwitchNadirToStowTrigger if SwitchNadirToStowGuard then Stow;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchNadirToPtc first Nadir accept SwitchNadirToPtcTrigger if SwitchNadirToPtcGuard then Ptc;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchNadirToObs first Nadir accept SwitchNadirToObsTrigger if SwitchNadirToObsGuard then Obs;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchNadirToGrr first Nadir accept SwitchNadirToGrrTrigger if SwitchNadirToGrrGuard then Grr;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchPtcToStow first Ptc accept SwitchPtcToStowTrigger if SwitchPtcToStowGuard then Stow;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchPtcToNadir first Ptc accept SwitchPtcToNadirTrigger if SwitchPtcToNadirGuard then Nadir;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchPtcToObs first Ptc accept SwitchPtcToObsTrigger if SwitchPtcToObsGuard then Obs;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchPtcToGrr first Ptc accept SwitchPtcToGrrTrigger if SwitchPtcToGrrGuard then Grr;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchObsToStow first Obs accept SwitchObsToStowTrigger if SwitchObsToStowGuard then Stow;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchObsToNadir first Obs accept SwitchObsToNadirTrigger if SwitchObsToNadirGuard then Nadir;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchObsToPtc first Obs accept SwitchObsToPtcTrigger if SwitchObsToPtcGuard then Ptc;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchObsToGrr first Obs accept SwitchObsToGrrTrigger if SwitchObsToGrrGuard then Grr;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchGrrToStow first Grr accept SwitchGrrToStowTrigger if SwitchGrrToStowGuard then Stow;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchGrrToNadir first Grr accept SwitchGrrToNadirTrigger if SwitchGrrToNadirGuard then Nadir;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchGrrToPtc first Grr accept SwitchGrrToPtcTrigger if SwitchGrrToPtcGuard then Ptc;
            transition T_FSM_GIMBAL_CAMERA_MODES_SwitchGrrToObs first Grr accept SwitchGrrToObsTrigger if SwitchGrrToObsGuard then Obs;
            transition T_FSM_GIMBAL_CAMERA_MODES_Term first RetractedClosed then Terminal;
        }
        state def FSM_GNSS_NAVIGATION_MODE {
            state GnssEnabled;
            state GnssDisabledInertialOnly;
            transition T_FSM_GNSS_NAVIGATION_MODE_Init first Initial then GnssEnabled;
            transition T_FSM_GNSS_NAVIGATION_MODE_DisableGnssNavigation first GnssEnabled accept DisableGnssNavigationTrigger if DisableGnssNavigationGuard then GnssDisabledInertialOnly;
            transition T_FSM_GNSS_NAVIGATION_MODE_EnableGnssManual first GnssDisabledInertialOnly accept EnableGnssManualTrigger if EnableGnssManualGuard then GnssEnabled;
            transition T_FSM_GNSS_NAVIGATION_MODE_AutoReenableGnssOnRadioLoss first GnssDisabledInertialOnly accept AutoReenableGnssOnRadioLossTrigger if AutoReenableGnssOnRadioLossGuard then GnssEnabled;
            transition T_FSM_GNSS_NAVIGATION_MODE_Term first GnssEnabled then Terminal;
        }
        state def FSM_PREFLIGHT_CHECKLIST_GATE {
            state IncompleteOrFailed;
            state AllGroupsCompleteReadyToArm;
            state Armed;
            transition T_FSM_PREFLIGHT_CHECKLIST_GATE_Init first Initial then IncompleteOrFailed;
            transition T_FSM_PREFLIGHT_CHECKLIST_GATE_CompleteAllChecklistGroups first IncompleteOrFailed accept CompleteAllChecklistGroupsTrigger if CompleteAllChecklistGroupsGuard then AllGroupsCompleteReadyToArm;
            transition T_FSM_PREFLIGHT_CHECKLIST_GATE_AutomaticCheckDegraded first AllGroupsCompleteReadyToArm accept AutomaticCheckDegradedTrigger if AutomaticCheckDegradedGuard then IncompleteOrFailed;
            transition T_FSM_PREFLIGHT_CHECKLIST_GATE_SlideToArmAccepted first AllGroupsCompleteReadyToArm accept SlideToArmAcceptedTrigger if SlideToArmAcceptedGuard then Armed;
            transition T_FSM_PREFLIGHT_CHECKLIST_GATE_PreArmRejected first AllGroupsCompleteReadyToArm accept PreArmRejectedTrigger if PreArmRejectedGuard then IncompleteOrFailed;
            transition T_FSM_PREFLIGHT_CHECKLIST_GATE_Term first Armed then Terminal;
        }
        state def State_INV_DOC01_06 {
            state UavPowerOff_RbfInserted;
            state UavPowerOn_TelemetryActive;
            transition T_State_INV_DOC01_06_Init first Initial then UavPowerOff_RbfInserted;
            transition T_State_INV_DOC01_06_SwitchOn first UavPowerOff_RbfInserted accept uavRbfKeyRemoved if batteryConnectedThroughFuse then UavPowerOn_TelemetryActive;
            transition T_State_INV_DOC01_06_SwitchOff first UavPowerOn_TelemetryActive accept uavRbfKeyInserted then UavPowerOff_RbfInserted;
            transition T_State_INV_DOC01_06_Term first UavPowerOn_TelemetryActive then Terminal;
        }
        state def State_INV_DOC01_07 {
            state EsadPinInstalled_Safe;
            state EsadPinRemoved_SequencedArming;
            transition T_State_INV_DOC01_07_Init first Initial then EsadPinInstalled_Safe;
            transition T_State_INV_DOC01_07_RemovePin first EsadPinInstalled_Safe accept removeEsadRbfKey if esadPowerAndChecksNominal then EsadPinRemoved_SequencedArming;
            transition T_State_INV_DOC01_07_Term first EsadPinRemoved_SequencedArming then Terminal;
        }
        state def State_INV_DOC02_09 {
            state TrackingAndDetection;
            state TargetLocked_AutonomousTerminal;
            transition T_State_INV_DOC02_09_Init first Initial then TrackingAndDetection;
            transition T_State_INV_DOC02_09_Lock first TrackingAndDetection accept targetLockEstablished if eoIrOrGeolocationValid then TargetLocked_AutonomousTerminal;
            transition T_State_INV_DOC02_09_Term first TargetLocked_AutonomousTerminal then Terminal;
        }
        state def State_INV_DOC03_01 {
            state Stage2_SafeSepVerified;
            state Stage3_DualAndArmed;
            transition T_State_INV_DOC03_01_Init first Initial then Stage2_SafeSepVerified;
            transition T_State_INV_DOC03_01_DualArm first Stage2_SafeSepVerified accept dscIn1AndRs485OcStatusBit2 if umbilicalOpenAndSafeSepMet then Stage3_DualAndArmed;
            transition T_State_INV_DOC03_01_Term first Stage3_DualAndArmed then Terminal;
        }
        state def State_INV_DOC04_04 {
            state CarriagePinned_ValveOpenable;
            state PinRemoved_ImmediateLaunchOnly;
            state TriggerInvalidated_ResetRequired;
            transition T_State_INV_DOC04_04_Init first Initial then CarriagePinned_ValveOpenable;
            transition T_State_INV_DOC04_04_ClearPin first CarriagePinned_ValveOpenable accept removeCarriageSafetyPin if valveOpenedAndLeversUp then PinRemoved_ImmediateLaunchOnly;
            transition T_State_INV_DOC04_04_FaultPinIn first CarriagePinned_ValveOpenable accept triggerPressedWhilePinIn then TriggerInvalidated_ResetRequired;
            transition T_State_INV_DOC04_04_Term first PinRemoved_ImmediateLaunchOnly then Terminal;
        }
        state def State_INV_DOC04_05 {
            state OutletValveClosed_SafeForTubing;
            state OutletValveOpen_LaunchOnly;
            transition T_State_INV_DOC04_05_Init first Initial then OutletValveClosed_SafeForTubing;
            transition T_State_INV_DOC04_05_Open first OutletValveClosed_SafeForTubing accept openMainOutletValve immediatelyBeforeLaunch then OutletValveOpen_LaunchOnly;
            transition T_State_INV_DOC04_05_Close first OutletValveOpen_LaunchOnly accept closeMainOutletValve immediatelyAfterLaunch then OutletValveClosed_SafeForTubing;
            transition T_State_INV_DOC04_05_Term first OutletValveClosed_SafeForTubing then Terminal;
        }
        state def State_INV_DOC04_12 {
            state SafetyCoversClosed;
            state DualSwitchesHeld_Launching;
            transition T_State_INV_DOC04_12_Init first Initial then SafetyCoversClosed;
            transition T_State_INV_DOC04_12_HoldFire first SafetyCoversClosed accept dualSwitchesPressedSimultaneously if safetyCoversOpenAndHoldGe2s then DualSwitchesHeld_Launching;
            transition T_State_INV_DOC04_12_Release first DualSwitchesHeld_Launching accept uavExitedCatapult then SafetyCoversClosed;
            transition T_State_INV_DOC04_12_Term first SafetyCoversClosed then Terminal;
        }
        state def State_INV_DOC05_13 {
            state FrontRbfs1Installed;
            state FrontRbfs1Cleared;
            state PowerRbf2Removed_LidsLocked;
            transition T_State_INV_DOC05_13_Init first Initial then FrontRbfs1Installed;
            transition T_State_INV_DOC05_13_RemoveFront1 first FrontRbfs1Installed accept frontRbfs1Removed if opticsAndPitotUnobstructed then FrontRbfs1Cleared;
            transition T_State_INV_DOC05_13_RemovePower2 first FrontRbfs1Cleared accept powerRbf2RemovedAndCapped if lidsClosedAndLocked then PowerRbf2Removed_LidsLocked;
            transition T_State_INV_DOC05_13_Term first PowerRbf2Removed_LidsLocked then Terminal;
        }
        state def State_INV_DOC05_15 {
            state EsadRbf3Installed_Gated;
            state PrematureRemovalFault;
            state EsadRbf3Removed_ReadyToFly;
            transition T_State_INV_DOC05_15_Init first Initial then EsadRbf3Installed_Gated;
            transition T_State_INV_DOC05_15_PrematureFault first EsadRbf3Installed_Gated accept rbf3RemovedBeforeChecks then PrematureRemovalFault;
            transition T_State_INV_DOC05_15_AuthorizedRemoval first EsadRbf3Installed_Gated accept swarmC2PromptsRbf3Removal if allEightChecksVerified then EsadRbf3Removed_ReadyToFly;
            transition T_State_INV_DOC05_15_Term first EsadRbf3Removed_ReadyToFly then Terminal;
        }
        state def State_INV_DOC06_03 {
            state EsadSupplied;
            state EsadUnrecoverablyPoweredOffAirborne;
            transition T_State_INV_DOC06_03_Init first Initial then EsadSupplied;
            transition T_State_INV_DOC06_03_AirborneOff first EsadSupplied accept powerOffEsadCommand if uavAirborne then EsadUnrecoverablyPoweredOffAirborne;
            transition T_State_INV_DOC06_03_Term first EsadUnrecoverablyPoweredOffAirborne then Terminal;
        }
        state def State_INV_DOC06_04 {
            state EsadInactiveOrSafe;
            state EsadStage1OrStage2;
            state EsadArmedOrFired;
            transition T_State_INV_DOC06_04_Init first Initial then EsadInactiveOrSafe;
            transition T_State_INV_DOC06_04_AdvanceStages first EsadInactiveOrSafe accept pinRemovedAndTakeoffCompleted then EsadStage1OrStage2;
            transition T_State_INV_DOC06_04_EnterArmed first EsadStage1OrStage2 accept armSlideConfirmed if poweredFaultFreeAirborne then EsadArmedOrFired;
            transition T_State_INV_DOC06_04_Term first EsadArmedOrFired then Terminal;
        }
        state def State_INV_DOC06_06 {
            state EsadStage1OrStage2NotArmed;
            state EsadAutoSafeDischarged;
            transition T_State_INV_DOC06_06_Init first Initial then EsadStage1OrStage2NotArmed;
            transition T_State_INV_DOC06_06_AutoSafe first EsadStage1OrStage2NotArmed accept uavNoLongerFlying if esadNotArmed then EsadAutoSafeDischarged;
            transition T_State_INV_DOC06_06_Term first EsadAutoSafeDischarged then Terminal;
        }
        state def State_INV_DOC06_19 {
            state LauncherStagedAndPressurized13To14Bar;
            state OutletValveOpenedAndPinRemoved;
            state PersonnelClearedAndTriggerHeld;
            transition T_State_INV_DOC06_19_Init first Initial then LauncherStagedAndPressurized13To14Bar;
            transition T_State_INV_DOC06_19_PrepareFire first LauncherStagedAndPressurized13To14Bar accept openOutletValveAndRemovePin if uavMountedAndGrounded then OutletValveOpenedAndPinRemoved;
            transition T_State_INV_DOC06_19_Launch first OutletValveOpenedAndPinRemoved accept holdTriggerUntilRailExit if personnelCleared then PersonnelClearedAndTriggerHeld;
            transition T_State_INV_DOC06_19_Term first PersonnelClearedAndTriggerHeld then Terminal;
        }
        capability def Cap_integrated_system;
        capability def Cap_airdata_sensor;
        capability def Cap_antenna_positioner;
        capability def Cap_circuit_protection;
        capability def Cap_companion_computer;
        capability def Cap_electro_optical_gimbal;
        capability def Cap_electromechanical_actuator;
        capability def Cap_energetic_payload;
        capability def Cap_energy_storage;
        capability def Cap_esd_grounding_fixture;
        capability def Cap_external_service_interface;
        capability def Cap_gnss_receiver;
        capability def Cap_mechanical_launch_structure;
        capability def Cap_navigation_sensor;
        capability def Cap_network_switch;
        capability def Cap_operator_console;
        capability def Cap_operator_trigger_unit;
        capability def Cap_passive_antenna;
        capability def Cap_payload_compute_module;
        capability def Cap_pneumatic_compressor_unit;
        capability def Cap_power_distribution_regulator;
        capability def Cap_power_switch_meter;
        capability def Cap_primary_controller;
        capability def Cap_proximity_impact_sensor;
        capability def Cap_pyrotechnic_actuator;
        capability def Cap_rf_transceiver;
        capability def Cap_safe_arm_controller;
        capability def Cap_safety_interlock_key;
        capability def Cap_splitter_distribution_pcb;
        interaction def INT_01_SystemPowerOnAndRbfSequence {
        }
        interaction def INT_02_EsadBootPbitAndRs485Exchange {
        }
        interaction def INT_03_Pl40PneumaticCatapultLaunch {
        }
        interaction def INT_04_WingsCan2DaisyChainControl {
        }
        interaction def INT_05_GcsUavRfC2AndVideoLink {
        }
        interaction def INT_06_AutonomousTerminalEngagement {
        }
        interaction def INT_07_GnssDeniedDeadReckoning {
        }
        interaction def INT_08_LethalPyrotechnicInitiationTrain {
        }
    }
    package RequirementsAndSafetyPackage {
        requirement def REQ_INV_DOC01_03 {
            text = "Autopilot computing board + sensors (Cube orange+) executes main UAV control logic, flight stabilization, and navigation, and estimates attitude, position, and kinematics by fusing internal sensors with external sensor data (GNSS, airspeed, dual magnetometers/barometers).";
            attribute category : String = "sensor_fusion_coupling";
        }
        requirement def REQ_INV_DOC01_04 {
            text = "Each Magnetometer (mRo RM3100) measures UAV heading and also incorporates a barometric sensor used for altitude estimation.";
            attribute category : String = "sensor_fusion_coupling";
        }
        requirement def REQ_INV_DOC01_05 {
            text = "Camera compute module (Trip6) controls the Gimbal, provides video feed and target tracking, produces filtered gimbal kinematic measurements, and computes target position estimation based on provided UAV position data.";
            attribute category : String = "sensor_fusion_coupling";
        }
        requirement def REQ_INV_DOC01_08 {
            text = "ESAD controls in-line initiation of the warhead pyrotechnic train as a high-voltage all-electronic safety device preventing accidental arming or firing by eliminating sensitivities to electromagnetic fields, electrostatic discharge, and stray voltages.";
            attribute category : String = "failsafe_behavior";
        }
        requirement def REQ_INV_DOC01_10 {
            text = "Pito tube (CUAV SKYE2 Airspeed sensor) measures airspeed and includes in-built heating and drainage.";
            attribute category : String = "failsafe_behavior";
        }
        requirement def REQ_INV_DOC01_11 {
            text = "Parachute deployment enclosure (two Igniters powered at 50V to burn the wire holding the payload bay cover where the parachute is installed) is optional for RnD UAV and excluded in production configuration (populated_in_production = false).";
            attribute category : String = "configuration_exclusion";
        }
        requirement def REQ_INV_DOC02_01 {
            text = "Endurance shall reach up to 90 min (5400 s), depending on the mission CONOPs, geolocation, and weather conditions.";
            attribute category : String = "power_margin";
        }
        requirement def REQ_INV_DOC02_06 {
            text = "Precision strike accuracy shall deliver a demonstrated Circular Error Probable (CEP) below 0.5 m (50 cm) against stationary targets, supporting stationary and moving targets via steep terminal approach in complex terrain.";
            attribute category : String = "kinematic_control_law";
        }
        requirement def REQ_INV_DOC02_07 {
            text = "Air vehicle shall exhibit low visual, acoustic, thermal, and radar signatures to improve survivability in contested environments.";
            attribute category : String = "configuration_exclusion";
        }
        requirement def REQ_INV_DOC02_08 {
            text = "Autopilot shall support fully autonomous waypoint navigation, programmable fail safes, GNSS-denied position correction via dead reckoning, and continuous health monitoring.";
            attribute category : String = "failsafe_behavior";
        }
        requirement def REQ_INV_DOC02_10 {
            text = "RF communications shall operate in 4.4-5.0 GHz with distinct uplink and downlink frequencies, 2 W output power, AES-256 encryption, frequency-hopping interference avoidance, and 60 km RLOS (90 km with relay), subject to mission CONOPs, geolocation, and weather.";
            attribute category : String = "failsafe_behavior";
        }
        requirement def REQ_INV_DOC02_11 {
            text = "Navigation instrumentation shall integrate multi-constellation GNSS (GPS/GLONASS/GALILEO) with INS accelerometers, gyroscope, magnetometer, barometer, and heated pitot tube.";
            attribute category : String = "sensor_fusion_coupling";
        }
        requirement def REQ_INV_DOC02_12 {
            text = "Air vehicle propulsion shall be fully electric.";
            attribute category : String = "power_margin";
        }
        requirement def REQ_INV_DOC02_14 {
            text = "Modular payload architecture shall carry up to a 5 kg warhead (Thermobaric, HE, or HEAT) or partner-selected payloads, subject to applicable regulations, export restrictions, and end-user requirements.";
            attribute category : String = "configuration_exclusion";
        }
        requirement def REQ_INV_DOC02_15 {
            text = "Mission Control rugged tablet running Windows 11 and UDS SwarmC2 shall provide mission planning, automatic object tracking and geolocation, integrated video display, direct UAV control, and integration with Battle Management Systems (SitaWare HQ, ATAK, DELTA), operating within GCS alongside Ground BOX (INST-GCS-GROUND-BOX) connected to Rotator (INST-GCS-ROTATOR) via 200 m fiber optics spool.";
            attribute category : String = "sensor_fusion_coupling";
        }
        requirement def REQ_INV_DOC02_16 {
            text = "Ground antenna subsystem shall combine directional and omnidirectional antennas on a rotator that autonomously tracks the UAV.";
            attribute category : String = "kinematic_control_law";
        }
        requirement def REQ_INV_DOC02_17 {
            text = "Air vehicle shall deploy mechanically via a mobile pneumatic launch system; pre-flight ground configuration carries twin red Remove-Before-Flight tags as depicted in launch rail and transport case imagery.";
            attribute category : String = "interlock_sequence";
        }
        requirement def REQ_INV_DOC02_18 {
            text = "Platform administrative metadata: NSN registration in progress; OEM UAB Unmanned Defense Systems (Company code 306079694, Mokslininku St. 2A, LT-08412 Vilnius, Lithuania).";
            attribute category : String = "configuration_exclusion";
        }
        requirement def REQ_INV_DOC03_07 {
            text = "ESAD mounts directly inside the sealed payload enclosure without an additional housing using three M3 (Dia 3.20 mm) holes while leaving 3x Dia 8 mm holes and J101 reserved for Artron; accepts GE_POW 14-32 V DC (28 V nominal), meets STANAG 4187 and MIL-STD-461, and drives LEEFI detonator via J401 (0-1800 V) with MMM1-0054-02AA-0000 spacer and Kapton Film insulation.";
            attribute category : String = "power_margin";
        }
        requirement def REQ_INV_DOC03_08 {
            text = "Detonator firing (Mod: Fired) executes exclusively from Mod: Armed upon receipt of any of three triggers: Impact Switch trigger (IRQ_L), Proximity Sensor trigger (IRQ_L), or OC Trigger (EXCHANGE OC_Status Bit 5).";
            attribute category : String = "failsafe_behavior";
        }
        requirement def REQ_INV_DOC04_01 {
            text = "NEVER launch without payload mounted on the carriage; dry-firing without an aircraft will damage the launcher and endanger surrounding personnel.";
            attribute category : String = "interlock_sequence";
        }
        requirement def REQ_INV_DOC04_02 {
            text = "NEVER launch without securing the launcher's rear leg and 90-degree anchor disk to the ground; backlash can displace the launcher and throw the aircraft off prematurely. Operator must verify soil strength and deploy additional anchors in soft soil.";
            attribute category : String = "interlock_sequence";
        }
        requirement def REQ_INV_DOC04_03 {
            text = "All team members MUST be inside the green SAFETY AREA strictly behind the launcher (clear of the red forward and lateral DANGER ZONE / KEEP CLEAR area) before launching, and operators MUST wear gloves and goggles when servicing the aircraft or launcher.";
            attribute category : String = "interlock_sequence";
        }
        requirement def REQ_INV_DOC04_10 {
            text = "All 4 carriage wheel bearings MUST be replaced every 100 launches (heating threaded area to ~250 deg C / 523.15 K and unscrewing left-hand shaft clockwise, then applying threadlocker and reinstalling counterclockwise), and the rail track groove must be lubricated with white lithium grease (WD-40 White Lithium Grease recommended).";
            attribute category : String = "failsafe_behavior";
        }
        requirement def REQ_INV_DOC05_01 {
            text = "Operators must receive required training and read and understand AVENGER 5 Preparation and Safety Instructions plus all 6 referenced manual classes (AVENGER 5 User Manual, UAV launcher PL-40, Warheaddocumentation, ESAD documentation, storage/transport/handling/maintenance docs, and operating-base safety/regulatory procedures) before assembling, preparing, handling, powering on, or operating the UAV system.";
            attribute category : String = "interlock_sequence";
        }
        requirement def REQ_INV_DOC05_02 {
            text = "After opening the UAV transport box, the operator must touch the yellow-labeled EARTH POINT / GROUNDING ESD grounding stud every time before handling the UAV or its components (including before warhead installation) to equalize electrical potential and prevent electrostatic discharge damage to sensitive electronics.";
            attribute category : String = "failsafe_behavior";
        }
        requirement def REQ_INV_DOC05_03 {
            text = "Warhead storage, transportation, handling, transfer, installation, and operation may be performed only by appropriately trained and authorised personnel after operating-base regulations are completed; payload bay must be opened while UAV remains secured in the transport box and payload cables connected to ESAD using 1.5 mm HEX screw terminals.";
            attribute category : String = "interlock_sequence";
        }
        requirement def REQ_INV_DOC05_05 {
            text = "Prior to installation, the battery must be fully charged and visually inspected for damage, swelling, deformation, leakage, or loose connectors (discard/reject on any abnormality), and both the battery identification number and QR code must exactly match the identification number and QR code on the UAV fuselage.";
            attribute category : String = "power_margin";
        }
        requirement def REQ_INV_DOC05_07 {
            text = "Two persons are required to lift the UAV from the transport box onto the PL-40 catapult trolley with RBF pins kept installed and without applying pressure to wings, control surfaces, or empennage; during wing installation, stabiliser installation, and all RBF removals, operators must support the UAV frame firmly against the trolley so it does not slip out of mounting fixtures.";
            attribute category : String = "failsafe_behavior";
        }
        requirement def REQ_INV_DOC05_11 {
            text = "UAV Launcher PL-40 must be assembled per Catapult User Manual, set to specified launch pressure, and have all catapult sections, fasteners, connections, and locking mechanisms firmly tightened to avoid launch-speed shortfall and unsuccessful launch or UAV loss.";
            attribute category : String = "power_margin";
        }
        requirement def REQ_INV_DOC05_12 {
            text = "Ground control station setup (positioning, securing antenna, connecting and powering on tablets, calibrating antenna per SwarmC2 User Manual, and confirming all GCS components operate nominally) must complete before continuing with UAV preparation.";
            attribute category : String = "interlock_sequence";
        }
        requirement def REQ_INV_DOC05_14 {
            text = "Following automatic power-on with RBF #1 and #2 removed, operators must complete initial diagnostics, GCS checks, and mission verification on SwarmC2 and MUST NOT proceed to the final pre-launch sequence if any system, indication, or parameter is not nominal.";
            attribute category : String = "failsafe_behavior";
        }
        requirement def REQ_INV_DOC05_16 {
            text = "Launch must NOT be initiated until UAV, payload, GCS, and catapult are confirmed ready, all personnel have moved to the designated safe distance clear of the catapult and launch path, and final launch confirmation is executed from the designated safe position.";
            attribute category : String = "failsafe_behavior";
        }
        requirement def REQ_INV_DOC06_01 {
            text = "Slide To Arm remains disabled until all six Pre-Flight Checklist groups complete with no blocking Pre-Arm faults; automatic checklist items re-evaluate continuously while connected and disarmed and immediately disable Slide To Arm if any check fails afterward.";
            attribute category : String = "interlock_sequence";
        }
        requirement def REQ_INV_DOC06_02 {
            text = "Reboot Vehicle command is prohibited during flight and disabled after the UAV is armed; Reboot Gimbal power-cycles only the payload module and may be executed in flight upon fault detection.";
            attribute category : String = "interlock_sequence";
        }
        requirement def REQ_INV_DOC06_05 {
            text = "ESAD SELF DESTRUCT and ABORT commands each require holding the control continuously for 5 s followed by Slide to confirm; ABORT irreversibly shuts down the ESAD so it cannot be turned back on.";
            attribute category : String = "failsafe_behavior";
        }
        requirement def REQ_INV_DOC06_07 {
            text = "When Disarm ESAD On GCS Timeout is enabled and ESAD GCS Timeout is non-zero, ESAD automatically disarms if no GCS ping is received for the configured timeout while armed.";
            attribute category : String = "failsafe_behavior";
        }
        requirement def REQ_INV_DOC06_11 {
            text = "Payload tracker lacks active object detection or automatic re-tracking if lost due to obstruction or low light; upon track loss in ATTACK mode, the UAV flies dead-reckoning from last known target elevation and heading unless manually re-tracked or aborted.";
            attribute category : String = "failsafe_behavior";
        }
        requirement def REQ_INV_DOC06_13 {
            text = "Takeoff without GNSS requires manual initial UAV position and wind estimate entry (wind defaults to 0 m/s); while GNSS is disabled during spoofing, periodic I'm Here (available only when GNSS disabled) or I'm Looking Here corrections are required, and radio link loss automatically re-enables GNSS after GPS Failsafe Timeout.";
            attribute category : String = "sensor_fusion_coupling";
        }
        requirement def REQ_INV_DOC06_15 {
            text = "RTL targets Return/Home point (auto-updated to latest GNSS fix before arming) or nearest Rally Point within range limits according to configured RTL Altitude and RTL Action; MANUAL mode passes RC transmitter inputs unstabilized directly to control surfaces (requires Advanced Display setting).";
            attribute category : String = "failsafe_behavior";
        }
        requirement def REQ_INV_DOC06_17 {
            text = "When Rotator Auto Follow is enabled, UAV must not loiter overhead/around the rotator location to prevent GCS cable tangling or damage; Auto Follow tracks the selected UAV and follows inertial navigational position rather than valid GNSS yellow icon when GNSS is disabled.";
            attribute category : String = "failsafe_behavior";
        }
        requirement def REQ_INV_DOC06_18 {
            text = "SwarmC2 requires Ground Station login with fixed server call signs (Payload or Pilot) when GS link is active, rejects continued use of factory default passwords until rotated within a short-lived authorization window (>=8 chars, upper, lower, digit, special), and syncs state across connected tablets.";
            attribute category : String = "interlock_sequence";
        }
        requirement def REQ_INV_DOC06_21 {
            text = "Gimbal must be set to STOW for takeoff, landing, and idle; virtual joystick gimbal control operates only in Payload layout outside OBS mode; thermal NUC recalibration should execute immediately after takeoff and after altitude changes.";
            attribute category : String = "interlock_sequence";
        }
        requirement def REQ_PROTO_ESC_TELEMETRY_UART {
            text = "EscIbex160 shall transmit unidirectional UART telemetry (rpm, temp_esc_and_mot, current, voltage) to AutopilotCubeOrangePlus.";
            attribute protocolItemRef : String = "ITEM_PROTO_ESC_TELEMETRY_UART";
        }
        requirement def REQ_PROTO_MOTOR_TEMP_TELEMETRY {
            text = "MotorAxi534516HdGoldLineV3 shall provide motor winding/housing temperature sensor telemetry to EscIbex160.";
            attribute protocolItemRef : String = "ITEM_PROTO_MOTOR_TEMP_TELEMETRY";
        }
        requirement def REQ_PROTO_PWM_ESC_CONTROL {
            text = "AutopilotCubeOrangePlus shall issue unidirectional PWM throttle control waveforms to EscIbex160.";
            attribute protocolItemRef : String = "ITEM_PROTO_PWM_ESC_CONTROL";
        }
        requirement def REQ_PROTO_POWER_METER_CAN1 {
            text = "PowerMeterSwitchSensor shall transmit battery voltage and current metrics over CAN 1 (120 cm wire) to AutopilotCubeOrangePlus.";
            attribute protocolItemRef : String = "ITEM_PROTO_POWER_METER_CAN1";
        }
        requirement def REQ_PROTO_DOC02_RF_C2_LINK {
            text = "RadioModuleDtc shall sustain bidirectional frequency-hopping AES-256 RF C2, telemetry, and 1280x720 EO/IR video over 4.4-5.0 GHz at 2 W up to 60 km RLOS (90 km with relay).";
            attribute protocolItemRef : String = "ITEM_PROTO_DOC02_RF_C2_LINK";
        }
        requirement def REQ_PROTO_DOC02_GCS_FIBER_LINK {
            text = "GcsGroundBox and GcsAntennaRotator shall communicate over the 200 m bidirectional optical fiber spool link (WIRE-DOC02-001).";
            attribute protocolItemRef : String = "ITEM_PROTO_DOC02_GCS_FIBER_LINK";
        }
        requirement def REQ_PROTO_DOC02_BMS_INTEGRATION {
            text = "PanasonicFzG2Tablet UDS SwarmC2 shall exchange coordinated mission planning and geolocation data with Battle Management Systems (SitaWare HQ, ATAK, DELTA).";
            attribute protocolItemRef : String = "ITEM_PROTO_DOC02_BMS_INTEGRATION";
        }
        requirement def REQ_PROTO_ESAD_RS485 {
            text = "EsadSafeAndArmDevice shall execute half-duplex 115200 bps 8N1 RS-485 CRC-16 XModem framing with <= 5 ms reply, 10 ms incomplete abort, 100 ms cyclic exchange, and commands 0x10/0x11/0x12/0x13/0xB0.";
            attribute protocolItemRef : String = "ITEM_PROTO_ESAD_RS485";
        }
        requirement def REQ_PROTO_ESAD_DSC_IN1 {
            text = "EsadSafeAndArmDevice J100 Pin 13 DSC_IN1 shall accept 1 ms period 50% duty 2 square waves (LOW 0-0.7 VDC, HIGH 2.5-3.3 VDC) gated strictly after Arm Stage 2.";
            attribute protocolItemRef : String = "ITEM_PROTO_ESAD_DSC_IN1";
        }
        requirement def REQ_PROTO_ESAD_UMBILICAL_CONTINUITY {
            text = "EsadUmbilicalLoop on J100 Pins 5,6 shall sustain a 20 mA continuity loop (<0.5 Ohm closed) cross-checked continuously against Safety Switch 1 (SS1).";
            attribute protocolItemRef : String = "ITEM_PROTO_ESAD_UMBILICAL_CONTINUITY";
        }
        requirement def REQ_PROTO_ESAD_SENSOR_UART {
            text = "ProximitySensor and EsadSafeAndArmDevice shall exchange bidirectional UART telemetry over crossover 28 AWG DIST_COMM1 / DIST_COMM2 lines (J102 Pins 2,3 <-> J1 Pins 3,4).";
            attribute protocolItemRef : String = "ITEM_PROTO_ESAD_SENSOR_UART";
        }
        requirement def REQ_PROTO_ESAD_ANALOG_TRIGGER {
            text = "ProximitySensorBoard shall hardware-OR ProximitySensor and ImpactSwitch triggers onto IR_ESAD_L / IRQ_L (J1 Pin 2 -> J102 Pin 4).";
            attribute protocolItemRef : String = "ITEM_PROTO_ESAD_ANALOG_TRIGGER";
        }
        requirement def REQ_PROTO_PL40_CONTROLLER_HMI {
            text = "Pl40CompressorController shall implement 7 dual-LED HMI states, non-volatile SET MODE target memory up to 14 bar, 0.05 bar hysteresis, and <= 14.5 V over-discharge cutoff with > 16 V 5 s recovery.";
            attribute protocolItemRef : String = "ITEM_PROTO_PL40_CONTROLLER_HMI";
        }
        requirement def REQ_PROTO_PL40_REMOTE_TRIGGER {
            text = "Pl40TriggerHandle shall enforce closed safety covers and simultaneous dual-switch hold >= 2 s until UAV rail exit to actuate the remote release valve.";
            attribute protocolItemRef : String = "ITEM_PROTO_PL40_REMOTE_TRIGGER";
        }
        requirement def REQ_PROTO_PL40_LAUNCH_PRESSURE_SCHEDULE {
            text = "Pl40MainAirReservoir pressure selection shall conform to Table 2 pressure-mass schedule across 5-16 bar and never exceed 25 m/s launch velocity.";
            attribute protocolItemRef : String = "ITEM_PROTO_PL40_LAUNCH_PRESSURE_SCHEDULE";
        }
        requirement def REQ_PROTO_DOC05_SWARMC2_PREFLIGHT {
            text = "PanasonicFzG2Tablet SwarmC2 pre-flight checklist UI shall verify sensors, battery voltage, pitot airspeed, GNSS satellite count, RF RSSI, mission plan (~32280 m furthest point), and ESAD Ready to Fly gating.";
            attribute protocolItemRef : String = "ITEM_PROTO_DOC05_SWARMC2_PREFLIGHT";
        }
        requirement def REQ_PROTO_DOC05_BATTERY_ID_QR_MATCH {
            text = "Battery12S2PLiMetalBei installation shall enforce exact battery-to-fuselage alphanumeric ID and QR code match and yellow marker bulkhead seating.";
            attribute protocolItemRef : String = "ITEM_PROTO_DOC05_BATTERY_ID_QR_MATCH";
        }
        requirement def REQ_PROTO_DOC05_ESAD_RBF3_INTERLOCK {
            text = "EsadRbfKey (3 ESAD R.B.F. XT60E-F Amass) shall enforce post-power-on diagnostics before removal, fault on premature removal, and automated Ready to Fly verification.";
            attribute protocolItemRef : String = "ITEM_PROTO_DOC05_ESAD_RBF3_INTERLOCK";
        }
        requirement def REQ_PROTO_SWARMC2_RF_C2_TELEMETRY {
            text = "AutopilotCubeOrangePlus shall exchange live flight telemetry, system logs, mission/geofence uploads, safety parameters, and flight mode commands with SwarmC2 within 2 min initial link acquisition.";
            attribute protocolItemRef : String = "ITEM_PROTO_SWARMC2_RF_C2_TELEMETRY";
        }
        requirement def REQ_PROTO_SWARMC2_ESAD_CONTROL {
            text = "EpsElectronicPowerSystemModule and AutopilotCubeOrangePlus shall execute SwarmC2 ESAD power switching (irreversible airborne off), 2-step ARM/DISARM, 5 s hold SELF DESTRUCT/ABORT, and GCS timeout disarming.";
            attribute protocolItemRef : String = "ITEM_PROTO_SWARMC2_ESAD_CONTROL";
        }
        requirement def REQ_PROTO_SWARMC2_PAYLOAD_VIDEO_OSD {
            text = "CameraComputeModuleTrip6 shall stream 1280x720 EO/IR video with OSD telemetry overlay, multitrack slots 0-4, stabilization modes, NUC, and SD card capture.";
            attribute protocolItemRef : String = "ITEM_PROTO_SWARMC2_PAYLOAD_VIDEO_OSD";
        }
        requirement def REQ_PROTO_SWARMC2_GCS_ROTATOR_LINK {
            text = "GcsAntennaRotator and GcsRadioBox shall execute SwarmC2 2 W TX power control, OMNI/DIR antenna switching, radio binding, and 0.5 deg fine / Auto Follow tracking.";
            attribute protocolItemRef : String = "ITEM_PROTO_SWARMC2_GCS_ROTATOR_LINK";
        }
        requirement def REQ_PROTO_SWARMC2_AUTH_AND_TACTICAL_SYNC {
            text = "GcsGroundBox shall enforce call-sign authentication (Payload/Pilot), >=8-char password rotation, multi-tablet sync, MBTiles map upload, and 5W/BDA/CFF tactical sync.";
            attribute protocolItemRef : String = "ITEM_PROTO_SWARMC2_AUTH_AND_TACTICAL_SYNC";
        }
        requirement def REQ_PROTO_SWARMC2_SYNCHRO_MATRIX {
            text = "PanasonicFzG2Tablet SwarmC2 UI shall preserve Main menu -> Navigation -> Synchro Matrix entry as documented in DOC-06 Sec 3.1 Fig 3.2.";
            attribute protocolItemRef : String = "ITEM_PROTO_SWARMC2_SYNCHRO_MATRIX";
        }
        requirement def REQ_GAP_DOC01_01 {
            text = "Visual enclosure boxes govern ENC-AUTOPILOT-STACK (EPS and Cube orange+ inside; ETH switch, RPI, GNSS module, and GNSS Antenna in ENC-AIR-VEHICLE) pending confirmation from mechanical/assembly documentation.";
        }
        requirement def REQ_GAP_DOC01_02 {
            text = "Preserved verbatim ('CAN 1 970cm wire' upstream, 'CAN 2' downstream) pending schematic/ICD verification in subsequent document shards.";
        }
        requirement def REQ_GAP_DOC01_03 {
            text = "ENC-PARACHUTE-DEPLOYMENT set to cardinality='0..1', populated_in_production=false (wires active_in_production=false); ENC-LETHAL-PACKAGE set to cardinality='1', populated_in_production=true pending production configuration verification.";
        }
        requirement def REQ_GAP_DOC01_04 {
            text = "Modeled dedicated dc_power edges WIRE-DOC01-01 (INST-EPS.ethSwitchPowerOut -> INST-ETH-SWITCH.dcPowerIn), WIRE-DOC01-02 (INST-EPS.rpiPowerOut -> INST-RPI.dcPowerIn), and WIRE-DOC01-03 (INST-EPS.gnssPowerOut -> INST-GNSS-MODULE.dcPowerIn) per Sidebar/BOM Power-Rail Rule for Law L6 closure.";
        }
        requirement def REQ_GAP_DOC02_01 {
            text = "Anchored to canonical ENC-AIR-VEHICLE (AirVehicleAvengerV25); AVENGER 5 is treated as the commercial product designation for the same platform.";
        }
        requirement def REQ_GAP_DOC02_02 {
            text = "Reconciled without conflict: TYPE-RADIO-DTC aggregates 2x1W per channel into 2 W total output power; both rfOutputPowerPerChannelW (1.0 W) and rfOutputPowerTotalW (2.0 W) are preserved.";
        }
        requirement def REQ_GAP_DOC02_03 {
            text = "DOC-02's functional INS list maps onto DOC-01's concrete hardware instances (INST-CUBE-ORANGE internal IMU, 2x INST-MAG-1/2 mRo RM3100, and INST-PITO-TUBE CUAV SKYE2); no duplicate sensor types minted.";
        }
        requirement def REQ_GAP_DOC02_04 {
            text = "Optical/kinematic hardware parameters (X40 zoom, 1280x720 day/thermal, 2-axis Pitch -45..+135 deg, Yaw/Roll -165..+165 deg) attach to TYPE-GIMBAL-NIGHTHAWK2UZ; airborne tracking/geolocation remains attributed to TYPE-CAMERA-TRIP6 (DOC-01) and ground tracking/geolocation to TYPE-GCS-TABLET (UDS SwarmC2, DOC-02).";
        }
        requirement def REQ_GAP_DOC02_05 {
            text = "Corroborates GAP-DOC01-03 disposition: ENC-PARACHUTE-DEPLOYMENT remains populated_in_production=false (RnD only), while ENC-LETHAL-PACKAGE with up to 5 kg warhead is populated_in_production=true.";
        }
        requirement def REQ_GAP_DOC02_06 {
            text = "Visual evidence in DOC-02 confirms dual RBF interlock hardware modeled in DOC-01.";
        }
        requirement def REQ_GAP_DOC02_07 {
            text = "Ground Control Station and Pneumatic Launch System are added as external_segment enclosures (ENC-GROUND-STATION, ENC-LAUNCH-SYSTEM) and TYPE-RADIO-ANTENNA is extended with rf_over_the_air ports.";
        }
        requirement def REQ_GAP_DOC02_08 {
            text = "Modeled as WIRE-DOC02-001 (optical_fiber, 200 m) between INST-GCS-GROUND-BOX and INST-GCS-ROTATOR inside ENC-GROUND-STATION, with fiberOpticSpoolLengthM placed on TYPE-GCS-GROUND-BOX.";
        }
        requirement def REQ_GAP_DOC03_01 {
            text = "Anchored to ENC-AIR-VEHICLE; retain both platform designations in reconciliations pending customer baseline revision control.";
        }
        requirement def REQ_GAP_DOC03_02 {
            text = "Anchored to INST-EPS -> INST-ESAD (14V sits at the exact 14V minimum limit of ESAD 14-32V rating with 0V lower margin); flag zero undervoltage margin for hardware verification.";
        }
        requirement def REQ_GAP_DOC03_03 {
            text = "Add UMB/UMB_RTN umbilical loop and DSC_IN1 wire from INST-CUBE-ORANGE to INST-ESAD from DOC-03 while retaining INST-ESAD-RBF-KEY from DOC-01 until harness baseline freeze.";
        }
        requirement def REQ_GAP_DOC03_04 {
            text = "Refine during merge to ENC-PROXIMITY-SENSOR-BOARD containing INST-PROXIMITY-SENSOR (power_feed_mode='dedicated_power_port', 5V from INST-ESAD) and INST-IMPACT-SWITCH, retaining all J102-J1 conductors.";
        }
        requirement def REQ_GAP_DOC03_05 {
            text = "Expand ENC-LETHAL-PACKAGE chain during merge to INST-ESAD -> INST-LEEFI-DETONATOR -> INST-BOOSTER -> INST-WARHEAD, superseding direct WIRE-058.";
        }
        requirement def REQ_GAP_DOC03_06 {
            text = "Preserve DOC-01 physical enclosures (ENC-PROPULSION, ENC-AUTOPILOT-STACK); anchor DOC-03 OC to INST-CUBE-ORANGE and GE_POW source to INST-EPS.";
        }
        requirement def REQ_GAP_DOC03_07 {
            text = "Retain all draft ICD specifications verbatim (Section 1.4.6.2 marked 'Suggested as Draft') and flag internal conflicts (100Hz vs 100ms, WELCOME direction, J012 typo, Abort path, VERSION null-termination) for Artron/Excalibur ICD clarification.";
        }
        requirement def REQ_GAP_DOC04_01 {
            text = "Preserved both distinct physical measurements on TYPE-PL40-REAR-RAIL: assembledRailLengthNominalM = 5.0 m (nominal sloped rail length) and assembledRailLengthCadM = 4.938 m (4938 mm horizontal ground-projected footprint at 12 deg elevation).";
        }
        requirement def REQ_GAP_DOC04_02 {
            text = "Modeled 2nd battery (INST-PL40-BATTERY-TRIGGER) supplying dc_power to INST-PL40-TRIGGER-HANDLE per Figure 5-2 while preserving spare-slot/swap duty in instance_attributes pending hardware schematic confirmation.";
        }
        requirement def REQ_GAP_DOC04_03 {
            text = "All 12 rows of Table 2 preserved in PROTO-PL40-LAUNCH-PRESSURE-SCHEDULE; INV-DOC04-06 enforces <= 25 m/s operational ceiling and INST-PL40-AUX-PRESSURE-SOURCE is marked populated_in_production=false (wire active_in_production=false).";
        }
        requirement def REQ_GAP_DOC04_04 {
            text = "Preserved standard configuration dimensions on TYPE-PL40-CARRIAGE and all three hook option geometries (A, B, C) on TYPE-UAV-LAUNCH-HOOKS pending airframe hardpoint option selection for Avenger V2.5.";
        }
        requirement def REQ_GAP_DOC04_05 {
            text = "Recorded Table 1 visual LED states verbatim in PROTO-PL40-CONTROLLER-HMI and unified trigger cover action as opening hinged safety levers/covers before pressing and holding both switches >= 2 s until aircraft exit.";
        }
        requirement def REQ_GAP_DOC04_06 {
            text = "Anchored ENC-AIR-VEHICLE and ENC-LAUNCH-SYSTEM; added INST-UAV-LAUNCH-HOOKS inside ENC-AIR-VEHICLE connected by WIRE-DOC04-018 and flagged merge alignment with DOC-02 launcher and MTOW (17 kg) parameters.";
        }
        requirement def REQ_GAP_DOC04_07 {
            text = "Documented 3 kit anchors and soft-soil expansion requirement on TYPE-PL40-GROUND-ANCHORS and captured engine throttle-up/propulsion/wind coupling in INV-DOC04-07 and INV-DOC04-13.";
        }
        requirement def REQ_GAP_DOC05_01 {
            text = "Anchored DOC-05 to ENC-AIR-VEHICLE (AirVehicleAvengerV25) while preserving AVENGER 5 operational title in oem_exact_label.";
        }
        requirement def REQ_GAP_DOC05_02 {
            text = "Recorded 23.9 V strictly as illustrative UI telemetry from p.22 (consistent with p.4-6 disclaimer) while keeping DOC-01 36-50.4 V authoritative for the 12S2P airframe battery.";
        }
        requirement def REQ_GAP_DOC05_03 {
            text = "Preserved distinct INST-ESAD and INST-WARHEAD inside ENC-LETHAL-PACKAGE, reconciled circular T4 ESAD PCB + 1.5 mm HEX screw-terminal payload cables (WIRE-054..056 cross-referenced to J100/J102 vs XT60E-F Amass on WIRE-057 RBF #3) against DOC-03 Harwin G125 J100/J102.";
        }
        requirement def REQ_GAP_DOC05_04 {
            text = "Anchored XT60E-F Amass attributes accurately on TYPE-UAV-RBF-KEY / INST-UAV-RBF-KEY and TYPE-ESAD-RBF-KEY; modeled closed black oval umbilical access lid on TYPE-UAV-UMBILICAL-PORT / INST-UAV-UMBILICAL-PORT without XT60E-F Amass; linked INST-UAV-UMBILICAL-PORT to INST-ESAD-UMBILICAL via WIRE-DOC05-008.";
        }
        requirement def REQ_GAP_DOC05_05 {
            text = "Captured as wing-hinge RF cable protection constraint INV-DOC05-08 on ENC-WINGS without guessing which specific antenna coax traverses the hinge shown in p.17.";
        }
        requirement def REQ_GAP_DOC05_06 {
            text = "Deferred exact PL-40 launch pressure/power ratings and GCS fiber/power specifications to DOC-04 (UAV launcher PL-40) and DOC-02 / SwarmC2 manual rather than extrapolating unstated interfaces in DOC-05.";
        }
        requirement def REQ_GAP_DOC05_07 {
            text = "Authoritative counts follow the explicit numbered enumerations and photographic hardware counts (3 containers, 4 stabilisers matching 4 fin servos in DOC-01, 3 Front RBF #1 devices).";
        }
        requirement def REQ_GAP_DOC05_08 {
            text = "Reconciled p.22 4-group UI screenshot as collapsed/abbreviated pre-flight view of the full 6-group operational gate (FSM-PREFLIGHT-CHECKLIST-GATE) and preserved Furthest Point distance ~32.28 km (32280 m) in PROTO-DOC05-SWARMC2-PREFLIGHT.";
        }
        requirement def REQ_GAP_DOC05_09 {
            text = "Structurally anchored INST-ESD-GROUNDING-POINT onto external chassis interface INST-EXT-IF-BOARD.esdChassisBond via WIRE-DOC05-009 (mechanical_structural_load domain) to capture EARTH POINT potential equalization.";
        }
        requirement def REQ_GAP_DOC06_01 {
            text = "Anchored ENC-AIR-VEHICLE to DOC-01 canonical AirVehicleAvengerV25 while preserving AVENGER 5 V1 manual designation pending revision reconciliation.";
        }
        requirement def REQ_GAP_DOC06_02 {
            text = "Consistent with production Avenger 5 having no recovery system (Table 1.3 'No'; DOC-01 Parachute deployment populated_in_production = false), while SwarmC2 software documentation includes shared recovery/Deep Stall profiles.";
        }
        requirement def REQ_GAP_DOC06_03 {
            text = "Adopted full 6-state ESAD lifecycle in DOC-06; whether physical impact detection uses an internal ESAD accelerometer/switch or external impact sensor requires ESAD datasheet verification.";
        }
        requirement def REQ_GAP_DOC06_04 {
            text = "Confirmed 2 aircraft RBF keys (UAV R.B.F Key + ESAD R.B.F Key) plus separate Catapult Carriage Safety Pin.";
        }
        requirement def REQ_GAP_DOC06_05 {
            text = "4910 MHz (4.91 GHz) is within 4.4-5 GHz and 2 W corresponds to aggregate 2x1W output (pending radio datasheet confirmation).";
        }
        requirement def REQ_GAP_DOC06_06 {
            text = "Unresolved in DOC-06 whether MANUAL mode RC control is tunnelled via GCS/DTC radio or relies on optional R&D RC hardware not included in Table 1.6.";
        }
        requirement def REQ_GAP_DOC06_07 {
            text = "Split TYPE-GCS-TRIPOD and TYPE-GCS-OMNI-ANTENNA; wired Table 1.6 ODU power, ODU LAN, 15m Ethernet, 0.25m N-type coax; kept Qty 2 active OMNI coax (WIRE-DOC06-015/016) and OMNI OTA (WIRE-DOC06-005/017) active_in_production=true while MARS coax swap (WIRE-DOC06-014) and MARS OTA (WIRE-DOC06-004/018) remain active_in_production=false.";
        }
        requirement def REQ_GAP_DOC06_08 {
            text = "49-50 V (36-50.4 V 12S2P) is authoritative for Avenger 5; lower voltages in example screenshots reflect multi-platform or bench-supply UI captures.";
        }
        requirement def REQ_GAP_DOC06_09 {
            text = "Assigned payload SD recording and gimbal deployment/retraction as functions on TYPE-CAMERA-TRIP6 / TYPE-GIMBAL-NIGHTHAWK2UZ pending payload datasheet verification.";
        }
        requirement def REQ_GAP_DOC06_10 {
            text = "Documented discrepancy between Sec 5.3.1 (unlimited loiter) and Sec 8.1.4 (automatic landing sequence); actual terminal behavior depends on vehicle recovery capability.";
        }
        requirement def REQ_GAP_DOC06_11 {
            text = "All Table 1.7-1.8 items modeled with populated_in_production=false and active_in_production=false maintenance/charging/stowage links (INST-GCS-TABLET-BATT-SPARE-1..2, INST-TABLET-BATTERY-CHARGER, INST-SYSTEM-BATTERY-CHARGER, INST-FIELD-MAINTENANCE-KIT, INST-TRANSPORT-CASE-1..3).";
        }
        requirement def REQ_GAP_DOC06_12 {
            text = "Modeled optional ENC-TUBE-LAUNCHER-OPTION (cardinality='0..1', populated_in_production=false) and INST-TUBE-LAUNCHER with inactive mechanical_structural_load link to INST-UAV-LAUNCH-HOOKS alongside active PL-40 catapult ENC-LAUNCH-SYSTEM.";
        }
        requirement def REQ_GAP_DOC06_13 {
            text = "Preserved both transitions in FSM-ESAD-SAFE-AND-ARM (AbortToSafeMode from ArmedState to SafeMode per DOC-03 ICD, and AbortEsadMission from ArmStage2/ArmedState to AbortedOrSelfDestructed per DOC-06 SwarmC2 UI) pending OEM/ICD harmonization.";
        }
        requirement def REQ_GAP_DOC06_14 {
            text = "Aligned FSM-PREFLIGHT-CHECKLIST-GATE (Sec 7.2.3 pre-arm gate) vs unified FSM-PL40-LAUNCH-AND-INTERLOCK: pre-arm checks verify pin installed while pressurized (13-14 bar), followed after UAV arming by opening outlet valve and removing Carriage Safety Pin immediately before launch trigger.";
        }
        requirement def REQ_GAP_MERGE_01 {
            text = "Reverted WIRE-042 (INST-GNSS-MODULE.serialPort <-> INST-CUBE-ORANGE.gnssSerial) to pure uart_serial, set TYPE-GNSS-ASTERX-M3.power_feed_mode='dedicated_power_port', and added dedicated dc_power wire WIRE-DOC01-03 (INST-EPS.gnssPowerOut -> INST-GNSS-MODULE.dcPowerIn).";
        }
        requirement def REQ_GAP_MERGE_02 {
            text = "Preserved both DOC-06 Table 1.3 attributes (26/30/38/55 m/s) and DOC-02 spec-sheet attributes (24/31/42/80 m/s) on TYPE-CUBE-ORANGE-PLUS alongside INV-DOC06-09 (55 m/s gimbal ceiling), INV-DOC02-02, and TYPE-RADIO-DTC (90 km vs 180 km).";
        }
        requirement def REQ_GAP_MERGE_03 {
            text = "Unified ENC-GROUND-STATION populated with DOC-06 Table 1.6 concrete instances plus split TYPE-GCS-TRIPOD and TYPE-GCS-OMNI-ANTENNA, wired ODU power/LAN/Ethernet/coax, preserved WIRE-DOC02-001 fiber, and routed rf_over_the_air links to INST-RADIO-ANT-1..2.";
        }
        requirement def REQ_GAP_MERGE_04 {
            text = "Consolidated DOC-02, DOC-05, and DOC-06 launcher nodes into DOC-04 ENC-LAUNCH-SYSTEM hierarchy and WIRE-DOC04-001..018; merged DOC-06 CAD dimensions and 13-14 bar operational pressure window onto PL-40 types.";
        }
        requirement def REQ_GAP_MERGE_05 {
            text = "Adopted DOC-03 ENC-PROXIMITY-SENSOR-BOARD and 3-stage pyrotechnic chain (ESAD -> LEEFI -> Booster -> Warhead); integrated DOC-05 mechanical instances, umbilical loop WIRE-DOC05-008, and ESD chassis bond WIRE-DOC05-009.";
        }
        requirement def REQ_GAP_MERGE_06 {
            text = "Closed 100% of active Law L6 supply-graph paths via WIRE-DOC01-01..03 (INST-EPS -> ETH switch, RPI, GNSS) and WIRE-DOC06-006..008 (GCS batteries -> Ground BOX / Radio BOX -> Rotator).";
        }
        use case def UC_00_OperateIntegratedSystem {
            subject Avenger5IntegratedSystem;
            actor SystemOperator;
            objective "Operate Avenger5IntegratedSystem across Cap_integrated_system, INT_01_SystemPowerOnAndRbfSequence, IntegratedSystemLifecycleState, staging, pre-flight, catapult launch, flight, terminal engagement, and post-mission safing.";
        }
        use case def UC_01_PropulsionAndBatteryPower {
            subject PropulsionSubsystem;
            actor FieldTechnician;
            objective "Execute Battery12S2PLiMetalBei inspection, AutomotiveFuse200A protection, PowerMeterSwitchSensor RBF #2 switching, EscIbex160, MotorAxi534516HdGoldLineV3, and FoldingPropeller thrust generation.";
        }
        use case def UC_02_AutopilotFlightAndControl {
            subject AutopilotCubeOrangePlus;
            actor PilotOperator;
            objective "Execute AutopilotCubeOrangePlus flight stabilization, WingsActuatorGroup INT_04_WingsCan2DaisyChainControl, FinsActuatorGroup skid turns, PitoTubeCuavSkye2 airspeed, MagnetometerMroRm3100 heading, and FSM_UAV_FLIGHT_MODES.";
        }
        use case def UC_03_EsadSafeArmAndLethalChain {
            subject LethalPackage;
            actor OrdnanceSpecialist;
            objective "Execute INT_02_EsadBootPbitAndRs485Exchange, INT_08_LethalPyrotechnicInitiationTrain, EsadSafeAndArmDevice 6-state arming interlock, ProximitySensorBoard ORed triggers, LeefiDetonator, WarheadBooster, and Warhead.";
        }
        use case def UC_04_Pl40PneumaticCatapultLaunch {
            subject PneumaticLauncherPl40;
            actor LaunchCrew;
            objective "Execute INT_03_Pl40PneumaticCatapultLaunch, Pl40CompressorUnit pressurization to 13-14 bar, Pl40LauncherRailAssembly anchoring, Pl40CarriageSafetyLockPin gating, and Pl40TriggerHandle >= 2 s dual-switch launch.";
        }
        use case def UC_05_GcsSwarmC2AndRfLink {
            subject GroundControlStation;
            actor PilotAndPayloadOperators;
            objective "Execute INT_05_GcsUavRfC2AndVideoLink across PanasonicFzG2Tablet SwarmC2, GcsGroundBox, GcsRadioBox, GcsAntennaRotator, GcsOmniAntenna, MarsDirectionalAntenna23Dbi, and BMS SitaWare/ATAK/DELTA sync.";
        }
        use case def UC_06_ElectroOpticalGimbalAndTracking {
            subject CameraComputeModuleTrip6;
            actor PayloadOperator;
            objective "Execute INT_06_AutonomousTerminalEngagement across GimbalNighthawk2Uz EO/IR 40x zoom stabilization modes, CameraComputeModuleTrip6 multitrack OSD overlay, and terminal guidance.";
        }
        use case def UC_07_GnssDeniedAndFailsafeOperations {
            subject GnssModuleSeptentrioAsterxM3Pro;
            actor PilotOperator;
            objective "Execute INT_07_GnssDeniedDeadReckoning, FSM_GNSS_NAVIGATION_MODE spoofing mitigation, I'm Here / I'm Looking Here corrections, and programmable RTL/GPS failsafes.";
        }
        use case def UC_08_PreFlightRbfAndEsdProcedures {
            subject AirVehicleAvengerV25;
            actor FieldCrew;
            objective "Execute EsdGroundingPoint potential equalization, Front RBF #1 cover/strap removal, Power RBF #2 and UavUmbilicalAccessPort sealing, and ESAD RBF #3 Ready to Fly gating.";
        }
        use case def UC_09_OptionalConfigurationsAndMaintenance {
            subject TubeLauncherOption;
            actor Maintainer;
            objective "Enforce production exclusion of ParachuteDeploymentPackage, TubeLauncherOption, Pl40AuxiliaryPressureSource, OptionalUsbGameController, offline chargers, FieldMaintenanceKit, and TransportationStorageCase.";
        }
        test case def TC_00_VerifySystemLifecycle {
            subject Avenger5IntegratedSystem;
            verify requirement REQ_INV_DOC02_01;
            objective "Verify IntegratedSystemLifecycleState transitions across staging, pre-flight, launch, engagement, and safing on Avenger5IntegratedSystem.";
            step verifyIntegratedSystemLifecycle;
        }
        test case def TC_REQ_INV_DOC01_03 {
            subject AutopilotCubeOrangePlus;
            verify requirement REQ_INV_DOC01_03;
            objective "Verify REQ_INV_DOC01_03 on AutopilotCubeOrangePlus.";
            step verify_REQ_INV_DOC01_03;
        }
        test case def TC_REQ_INV_DOC01_04 {
            subject MagnetometerMroRm3100;
            verify requirement REQ_INV_DOC01_04;
            objective "Verify REQ_INV_DOC01_04 on MagnetometerMroRm3100.";
            step verify_REQ_INV_DOC01_04;
        }
        test case def TC_REQ_INV_DOC01_05 {
            subject CameraComputeModuleTrip6;
            verify requirement REQ_INV_DOC01_05;
            objective "Verify REQ_INV_DOC01_05 on CameraComputeModuleTrip6.";
            step verify_REQ_INV_DOC01_05;
        }
        test case def TC_REQ_INV_DOC01_08 {
            subject EsadSafeAndArmDevice;
            verify requirement REQ_INV_DOC01_08;
            objective "Verify REQ_INV_DOC01_08 on EsadSafeAndArmDevice.";
            step verify_REQ_INV_DOC01_08;
        }
        test case def TC_REQ_INV_DOC01_10 {
            subject PitoTubeCuavSkye2;
            verify requirement REQ_INV_DOC01_10;
            objective "Verify REQ_INV_DOC01_10 on PitoTubeCuavSkye2.";
            step verify_REQ_INV_DOC01_10;
        }
        test case def TC_REQ_INV_DOC01_11 {
            subject ParachuteDeploymentPackage;
            verify requirement REQ_INV_DOC01_11;
            objective "Verify REQ_INV_DOC01_11 on ParachuteDeploymentPackage.";
            step verify_REQ_INV_DOC01_11;
        }
        test case def TC_REQ_INV_DOC02_01 {
            subject AirVehicleAvengerV25;
            verify requirement REQ_INV_DOC02_01;
            objective "Verify REQ_INV_DOC02_01 on AirVehicleAvengerV25.";
            step verify_REQ_INV_DOC02_01;
        }
        test case def TC_REQ_INV_DOC02_06 {
            subject AirVehicleAvengerV25;
            verify requirement REQ_INV_DOC02_06;
            objective "Verify REQ_INV_DOC02_06 on AirVehicleAvengerV25.";
            step verify_REQ_INV_DOC02_06;
        }
        test case def TC_REQ_INV_DOC02_07 {
            subject AirVehicleAvengerV25;
            verify requirement REQ_INV_DOC02_07;
            objective "Verify REQ_INV_DOC02_07 on AirVehicleAvengerV25.";
            step verify_REQ_INV_DOC02_07;
        }
        test case def TC_REQ_INV_DOC02_08 {
            subject AutopilotCubeOrangePlus;
            verify requirement REQ_INV_DOC02_08;
            objective "Verify REQ_INV_DOC02_08 on AutopilotCubeOrangePlus.";
            step verify_REQ_INV_DOC02_08;
        }
        test case def TC_REQ_INV_DOC02_10 {
            subject RadioModuleDtc;
            verify requirement REQ_INV_DOC02_10;
            objective "Verify REQ_INV_DOC02_10 on RadioModuleDtc.";
            step verify_REQ_INV_DOC02_10;
        }
        test case def TC_REQ_INV_DOC02_11 {
            subject GnssModuleSeptentrioAsterxM3Pro;
            verify requirement REQ_INV_DOC02_11;
            objective "Verify REQ_INV_DOC02_11 on GnssModuleSeptentrioAsterxM3Pro.";
            step verify_REQ_INV_DOC02_11;
        }
        test case def TC_REQ_INV_DOC02_12 {
            subject PropulsionSubsystem;
            verify requirement REQ_INV_DOC02_12;
            objective "Verify REQ_INV_DOC02_12 on PropulsionSubsystem.";
            step verify_REQ_INV_DOC02_12;
        }
        test case def TC_REQ_INV_DOC02_14 {
            subject Warhead;
            verify requirement REQ_INV_DOC02_14;
            objective "Verify REQ_INV_DOC02_14 on Warhead.";
            step verify_REQ_INV_DOC02_14;
        }
        test case def TC_REQ_INV_DOC02_15 {
            subject PanasonicFzG2Tablet;
            verify requirement REQ_INV_DOC02_15;
            objective "Verify REQ_INV_DOC02_15 on PanasonicFzG2Tablet.";
            step verify_REQ_INV_DOC02_15;
        }
        test case def TC_REQ_INV_DOC02_16 {
            subject GcsAntennaRotator;
            verify requirement REQ_INV_DOC02_16;
            objective "Verify REQ_INV_DOC02_16 on GcsAntennaRotator.";
            step verify_REQ_INV_DOC02_16;
        }
        test case def TC_REQ_INV_DOC02_17 {
            subject PneumaticLauncherPl40;
            verify requirement REQ_INV_DOC02_17;
            objective "Verify REQ_INV_DOC02_17 on PneumaticLauncherPl40.";
            step verify_REQ_INV_DOC02_17;
        }
        test case def TC_REQ_INV_DOC02_18 {
            subject AirVehicleAvengerV25;
            verify requirement REQ_INV_DOC02_18;
            objective "Verify REQ_INV_DOC02_18 on AirVehicleAvengerV25.";
            step verify_REQ_INV_DOC02_18;
        }
        test case def TC_REQ_INV_DOC03_07 {
            subject EsadSafeAndArmDevice;
            verify requirement REQ_INV_DOC03_07;
            objective "Verify REQ_INV_DOC03_07 on EsadSafeAndArmDevice.";
            step verify_REQ_INV_DOC03_07;
        }
        test case def TC_REQ_INV_DOC03_08 {
            subject EsadSafeAndArmDevice;
            verify requirement REQ_INV_DOC03_08;
            objective "Verify REQ_INV_DOC03_08 on EsadSafeAndArmDevice.";
            step verify_REQ_INV_DOC03_08;
        }
        test case def TC_REQ_INV_DOC04_01 {
            subject PneumaticLauncherPl40;
            verify requirement REQ_INV_DOC04_01;
            objective "Verify REQ_INV_DOC04_01 on PneumaticLauncherPl40.";
            step verify_REQ_INV_DOC04_01;
        }
        test case def TC_REQ_INV_DOC04_02 {
            subject Pl40GroundAnchorAssembly;
            verify requirement REQ_INV_DOC04_02;
            objective "Verify REQ_INV_DOC04_02 on Pl40GroundAnchorAssembly.";
            step verify_REQ_INV_DOC04_02;
        }
        test case def TC_REQ_INV_DOC04_03 {
            subject PneumaticLauncherPl40;
            verify requirement REQ_INV_DOC04_03;
            objective "Verify REQ_INV_DOC04_03 on PneumaticLauncherPl40.";
            step verify_REQ_INV_DOC04_03;
        }
        test case def TC_REQ_INV_DOC04_10 {
            subject Pl40LaunchCarriage;
            verify requirement REQ_INV_DOC04_10;
            objective "Verify REQ_INV_DOC04_10 on Pl40LaunchCarriage.";
            step verify_REQ_INV_DOC04_10;
        }
        test case def TC_REQ_INV_DOC05_01 {
            subject AirVehicleAvengerV25;
            verify requirement REQ_INV_DOC05_01;
            objective "Verify REQ_INV_DOC05_01 on AirVehicleAvengerV25.";
            step verify_REQ_INV_DOC05_01;
        }
        test case def TC_REQ_INV_DOC05_02 {
            subject EsdGroundingPoint;
            verify requirement REQ_INV_DOC05_02;
            objective "Verify REQ_INV_DOC05_02 on EsdGroundingPoint.";
            step verify_REQ_INV_DOC05_02;
        }
        test case def TC_REQ_INV_DOC05_03 {
            subject Warhead;
            verify requirement REQ_INV_DOC05_03;
            objective "Verify REQ_INV_DOC05_03 on Warhead.";
            step verify_REQ_INV_DOC05_03;
        }
        test case def TC_REQ_INV_DOC05_05 {
            subject Battery12S2PLiMetalBei;
            verify requirement REQ_INV_DOC05_05;
            objective "Verify REQ_INV_DOC05_05 on Battery12S2PLiMetalBei.";
            step verify_REQ_INV_DOC05_05;
        }
        test case def TC_REQ_INV_DOC05_07 {
            subject AirVehicleAvengerV25;
            verify requirement REQ_INV_DOC05_07;
            objective "Verify REQ_INV_DOC05_07 on AirVehicleAvengerV25.";
            step verify_REQ_INV_DOC05_07;
        }
        test case def TC_REQ_INV_DOC05_11 {
            subject Pl40LauncherRailAssembly;
            verify requirement REQ_INV_DOC05_11;
            objective "Verify REQ_INV_DOC05_11 on Pl40LauncherRailAssembly.";
            step verify_REQ_INV_DOC05_11;
        }
        test case def TC_REQ_INV_DOC05_12 {
            subject GroundControlStation;
            verify requirement REQ_INV_DOC05_12;
            objective "Verify REQ_INV_DOC05_12 on GroundControlStation.";
            step verify_REQ_INV_DOC05_12;
        }
        test case def TC_REQ_INV_DOC05_14 {
            subject PanasonicFzG2Tablet;
            verify requirement REQ_INV_DOC05_14;
            objective "Verify REQ_INV_DOC05_14 on PanasonicFzG2Tablet.";
            step verify_REQ_INV_DOC05_14;
        }
        test case def TC_REQ_INV_DOC05_16 {
            subject PneumaticLauncherPl40;
            verify requirement REQ_INV_DOC05_16;
            objective "Verify REQ_INV_DOC05_16 on PneumaticLauncherPl40.";
            step verify_REQ_INV_DOC05_16;
        }
        test case def TC_REQ_INV_DOC06_01 {
            subject AutopilotCubeOrangePlus;
            verify requirement REQ_INV_DOC06_01;
            objective "Verify REQ_INV_DOC06_01 on AutopilotCubeOrangePlus.";
            step verify_REQ_INV_DOC06_01;
        }
        test case def TC_REQ_INV_DOC06_02 {
            subject AutopilotCubeOrangePlus;
            verify requirement REQ_INV_DOC06_02;
            objective "Verify REQ_INV_DOC06_02 on AutopilotCubeOrangePlus.";
            step verify_REQ_INV_DOC06_02;
        }
        test case def TC_REQ_INV_DOC06_05 {
            subject EsadSafeAndArmDevice;
            verify requirement REQ_INV_DOC06_05;
            objective "Verify REQ_INV_DOC06_05 on EsadSafeAndArmDevice.";
            step verify_REQ_INV_DOC06_05;
        }
        test case def TC_REQ_INV_DOC06_07 {
            subject EsadSafeAndArmDevice;
            verify requirement REQ_INV_DOC06_07;
            objective "Verify REQ_INV_DOC06_07 on EsadSafeAndArmDevice.";
            step verify_REQ_INV_DOC06_07;
        }
        test case def TC_REQ_INV_DOC06_11 {
            subject CameraComputeModuleTrip6;
            verify requirement REQ_INV_DOC06_11;
            objective "Verify REQ_INV_DOC06_11 on CameraComputeModuleTrip6.";
            step verify_REQ_INV_DOC06_11;
        }
        test case def TC_REQ_INV_DOC06_13 {
            subject GnssModuleSeptentrioAsterxM3Pro;
            verify requirement REQ_INV_DOC06_13;
            objective "Verify REQ_INV_DOC06_13 on GnssModuleSeptentrioAsterxM3Pro.";
            step verify_REQ_INV_DOC06_13;
        }
        test case def TC_REQ_INV_DOC06_15 {
            subject AutopilotCubeOrangePlus;
            verify requirement REQ_INV_DOC06_15;
            objective "Verify REQ_INV_DOC06_15 on AutopilotCubeOrangePlus.";
            step verify_REQ_INV_DOC06_15;
        }
        test case def TC_REQ_INV_DOC06_17 {
            subject GcsAntennaRotator;
            verify requirement REQ_INV_DOC06_17;
            objective "Verify REQ_INV_DOC06_17 on GcsAntennaRotator.";
            step verify_REQ_INV_DOC06_17;
        }
        test case def TC_REQ_INV_DOC06_18 {
            subject PanasonicFzG2Tablet;
            verify requirement REQ_INV_DOC06_18;
            objective "Verify REQ_INV_DOC06_18 on PanasonicFzG2Tablet.";
            step verify_REQ_INV_DOC06_18;
        }
        test case def TC_REQ_INV_DOC06_21 {
            subject GimbalNighthawk2Uz;
            verify requirement REQ_INV_DOC06_21;
            objective "Verify REQ_INV_DOC06_21 on GimbalNighthawk2Uz.";
            step verify_REQ_INV_DOC06_21;
        }
        test case def TC_REQ_PROTO_ESC_TELEMETRY_UART {
            subject EscIbex160;
            verify requirement REQ_PROTO_ESC_TELEMETRY_UART;
            objective "Verify REQ_PROTO_ESC_TELEMETRY_UART on EscIbex160.";
            step verify_REQ_PROTO_ESC_TELEMETRY_UART;
        }
        test case def TC_REQ_PROTO_MOTOR_TEMP_TELEMETRY {
            subject MotorAxi534516HdGoldLineV3;
            verify requirement REQ_PROTO_MOTOR_TEMP_TELEMETRY;
            objective "Verify REQ_PROTO_MOTOR_TEMP_TELEMETRY on MotorAxi534516HdGoldLineV3.";
            step verify_REQ_PROTO_MOTOR_TEMP_TELEMETRY;
        }
        test case def TC_REQ_PROTO_PWM_ESC_CONTROL {
            subject AutopilotCubeOrangePlus;
            verify requirement REQ_PROTO_PWM_ESC_CONTROL;
            objective "Verify REQ_PROTO_PWM_ESC_CONTROL on AutopilotCubeOrangePlus.";
            step verify_REQ_PROTO_PWM_ESC_CONTROL;
        }
        test case def TC_REQ_PROTO_POWER_METER_CAN1 {
            subject PowerMeterSwitchSensor;
            verify requirement REQ_PROTO_POWER_METER_CAN1;
            objective "Verify REQ_PROTO_POWER_METER_CAN1 on PowerMeterSwitchSensor.";
            step verify_REQ_PROTO_POWER_METER_CAN1;
        }
        test case def TC_REQ_PROTO_DOC02_RF_C2_LINK {
            subject RadioModuleDtc;
            verify requirement REQ_PROTO_DOC02_RF_C2_LINK;
            objective "Verify REQ_PROTO_DOC02_RF_C2_LINK on RadioModuleDtc.";
            step verify_REQ_PROTO_DOC02_RF_C2_LINK;
        }
        test case def TC_REQ_PROTO_DOC02_GCS_FIBER_LINK {
            subject GcsGroundBox;
            verify requirement REQ_PROTO_DOC02_GCS_FIBER_LINK;
            objective "Verify REQ_PROTO_DOC02_GCS_FIBER_LINK on GcsGroundBox.";
            step verify_REQ_PROTO_DOC02_GCS_FIBER_LINK;
        }
        test case def TC_REQ_PROTO_DOC02_BMS_INTEGRATION {
            subject PanasonicFzG2Tablet;
            verify requirement REQ_PROTO_DOC02_BMS_INTEGRATION;
            objective "Verify REQ_PROTO_DOC02_BMS_INTEGRATION on PanasonicFzG2Tablet.";
            step verify_REQ_PROTO_DOC02_BMS_INTEGRATION;
        }
        test case def TC_REQ_PROTO_ESAD_RS485 {
            subject EsadSafeAndArmDevice;
            verify requirement REQ_PROTO_ESAD_RS485;
            objective "Verify REQ_PROTO_ESAD_RS485 on EsadSafeAndArmDevice.";
            step verify_REQ_PROTO_ESAD_RS485;
        }
        test case def TC_REQ_PROTO_ESAD_DSC_IN1 {
            subject EsadSafeAndArmDevice;
            verify requirement REQ_PROTO_ESAD_DSC_IN1;
            objective "Verify REQ_PROTO_ESAD_DSC_IN1 on EsadSafeAndArmDevice.";
            step verify_REQ_PROTO_ESAD_DSC_IN1;
        }
        test case def TC_REQ_PROTO_ESAD_UMBILICAL_CONTINUITY {
            subject EsadUmbilicalLoop;
            verify requirement REQ_PROTO_ESAD_UMBILICAL_CONTINUITY;
            objective "Verify REQ_PROTO_ESAD_UMBILICAL_CONTINUITY on EsadUmbilicalLoop.";
            step verify_REQ_PROTO_ESAD_UMBILICAL_CONTINUITY;
        }
        test case def TC_REQ_PROTO_ESAD_SENSOR_UART {
            subject ProximitySensor;
            verify requirement REQ_PROTO_ESAD_SENSOR_UART;
            objective "Verify REQ_PROTO_ESAD_SENSOR_UART on ProximitySensor.";
            step verify_REQ_PROTO_ESAD_SENSOR_UART;
        }
        test case def TC_REQ_PROTO_ESAD_ANALOG_TRIGGER {
            subject ProximitySensorBoard;
            verify requirement REQ_PROTO_ESAD_ANALOG_TRIGGER;
            objective "Verify REQ_PROTO_ESAD_ANALOG_TRIGGER on ProximitySensorBoard.";
            step verify_REQ_PROTO_ESAD_ANALOG_TRIGGER;
        }
        test case def TC_REQ_PROTO_PL40_CONTROLLER_HMI {
            subject Pl40CompressorController;
            verify requirement REQ_PROTO_PL40_CONTROLLER_HMI;
            objective "Verify REQ_PROTO_PL40_CONTROLLER_HMI on Pl40CompressorController.";
            step verify_REQ_PROTO_PL40_CONTROLLER_HMI;
        }
        test case def TC_REQ_PROTO_PL40_REMOTE_TRIGGER {
            subject Pl40TriggerHandle;
            verify requirement REQ_PROTO_PL40_REMOTE_TRIGGER;
            objective "Verify REQ_PROTO_PL40_REMOTE_TRIGGER on Pl40TriggerHandle.";
            step verify_REQ_PROTO_PL40_REMOTE_TRIGGER;
        }
        test case def TC_REQ_PROTO_PL40_LAUNCH_PRESSURE_SCHEDULE {
            subject Pl40MainAirReservoir;
            verify requirement REQ_PROTO_PL40_LAUNCH_PRESSURE_SCHEDULE;
            objective "Verify REQ_PROTO_PL40_LAUNCH_PRESSURE_SCHEDULE on Pl40MainAirReservoir.";
            step verify_REQ_PROTO_PL40_LAUNCH_PRESSURE_SCHEDULE;
        }
        test case def TC_REQ_PROTO_DOC05_SWARMC2_PREFLIGHT {
            subject PanasonicFzG2Tablet;
            verify requirement REQ_PROTO_DOC05_SWARMC2_PREFLIGHT;
            objective "Verify REQ_PROTO_DOC05_SWARMC2_PREFLIGHT on PanasonicFzG2Tablet.";
            step verify_REQ_PROTO_DOC05_SWARMC2_PREFLIGHT;
        }
        test case def TC_REQ_PROTO_DOC05_BATTERY_ID_QR_MATCH {
            subject Battery12S2PLiMetalBei;
            verify requirement REQ_PROTO_DOC05_BATTERY_ID_QR_MATCH;
            objective "Verify REQ_PROTO_DOC05_BATTERY_ID_QR_MATCH on Battery12S2PLiMetalBei.";
            step verify_REQ_PROTO_DOC05_BATTERY_ID_QR_MATCH;
        }
        test case def TC_REQ_PROTO_DOC05_ESAD_RBF3_INTERLOCK {
            subject EsadRbfKey;
            verify requirement REQ_PROTO_DOC05_ESAD_RBF3_INTERLOCK;
            objective "Verify REQ_PROTO_DOC05_ESAD_RBF3_INTERLOCK on EsadRbfKey.";
            step verify_REQ_PROTO_DOC05_ESAD_RBF3_INTERLOCK;
        }
        test case def TC_REQ_PROTO_SWARMC2_RF_C2_TELEMETRY {
            subject AutopilotCubeOrangePlus;
            verify requirement REQ_PROTO_SWARMC2_RF_C2_TELEMETRY;
            objective "Verify REQ_PROTO_SWARMC2_RF_C2_TELEMETRY on AutopilotCubeOrangePlus.";
            step verify_REQ_PROTO_SWARMC2_RF_C2_TELEMETRY;
        }
        test case def TC_REQ_PROTO_SWARMC2_ESAD_CONTROL {
            subject EpsElectronicPowerSystemModule;
            verify requirement REQ_PROTO_SWARMC2_ESAD_CONTROL;
            objective "Verify REQ_PROTO_SWARMC2_ESAD_CONTROL on EpsElectronicPowerSystemModule.";
            step verify_REQ_PROTO_SWARMC2_ESAD_CONTROL;
        }
        test case def TC_REQ_PROTO_SWARMC2_PAYLOAD_VIDEO_OSD {
            subject CameraComputeModuleTrip6;
            verify requirement REQ_PROTO_SWARMC2_PAYLOAD_VIDEO_OSD;
            objective "Verify REQ_PROTO_SWARMC2_PAYLOAD_VIDEO_OSD on CameraComputeModuleTrip6.";
            step verify_REQ_PROTO_SWARMC2_PAYLOAD_VIDEO_OSD;
        }
        test case def TC_REQ_PROTO_SWARMC2_GCS_ROTATOR_LINK {
            subject GcsAntennaRotator;
            verify requirement REQ_PROTO_SWARMC2_GCS_ROTATOR_LINK;
            objective "Verify REQ_PROTO_SWARMC2_GCS_ROTATOR_LINK on GcsAntennaRotator.";
            step verify_REQ_PROTO_SWARMC2_GCS_ROTATOR_LINK;
        }
        test case def TC_REQ_PROTO_SWARMC2_AUTH_AND_TACTICAL_SYNC {
            subject GcsGroundBox;
            verify requirement REQ_PROTO_SWARMC2_AUTH_AND_TACTICAL_SYNC;
            objective "Verify REQ_PROTO_SWARMC2_AUTH_AND_TACTICAL_SYNC on GcsGroundBox.";
            step verify_REQ_PROTO_SWARMC2_AUTH_AND_TACTICAL_SYNC;
        }
        test case def TC_REQ_PROTO_SWARMC2_SYNCHRO_MATRIX {
            subject PanasonicFzG2Tablet;
            verify requirement REQ_PROTO_SWARMC2_SYNCHRO_MATRIX;
            objective "Verify REQ_PROTO_SWARMC2_SYNCHRO_MATRIX on PanasonicFzG2Tablet.";
            step verify_REQ_PROTO_SWARMC2_SYNCHRO_MATRIX;
        }
        test case def TC_REQ_GAP_DOC01_01 {
            subject AutopilotStackModuleAstkA5V25;
            verify requirement REQ_GAP_DOC01_01;
            objective "Verify REQ_GAP_DOC01_01 on AutopilotStackModuleAstkA5V25.";
            step verify_REQ_GAP_DOC01_01;
        }
        test case def TC_REQ_GAP_DOC01_02 {
            subject CanPowerSplitterPcb;
            verify requirement REQ_GAP_DOC01_02;
            objective "Verify REQ_GAP_DOC01_02 on CanPowerSplitterPcb.";
            step verify_REQ_GAP_DOC01_02;
        }
        test case def TC_REQ_GAP_DOC01_03 {
            subject ParachuteDeploymentPackage;
            verify requirement REQ_GAP_DOC01_03;
            objective "Verify REQ_GAP_DOC01_03 on ParachuteDeploymentPackage.";
            step verify_REQ_GAP_DOC01_03;
        }
        test case def TC_REQ_GAP_DOC01_04 {
            subject EpsElectronicPowerSystemModule;
            verify requirement REQ_GAP_DOC01_04;
            objective "Verify REQ_GAP_DOC01_04 on EpsElectronicPowerSystemModule.";
            step verify_REQ_GAP_DOC01_04;
        }
        test case def TC_REQ_GAP_DOC02_01 {
            subject AirVehicleAvengerV25;
            verify requirement REQ_GAP_DOC02_01;
            objective "Verify REQ_GAP_DOC02_01 on AirVehicleAvengerV25.";
            step verify_REQ_GAP_DOC02_01;
        }
        test case def TC_REQ_GAP_DOC02_02 {
            subject RadioModuleDtc;
            verify requirement REQ_GAP_DOC02_02;
            objective "Verify REQ_GAP_DOC02_02 on RadioModuleDtc.";
            step verify_REQ_GAP_DOC02_02;
        }
        test case def TC_REQ_GAP_DOC02_03 {
            subject AutopilotCubeOrangePlus;
            verify requirement REQ_GAP_DOC02_03;
            objective "Verify REQ_GAP_DOC02_03 on AutopilotCubeOrangePlus.";
            step verify_REQ_GAP_DOC02_03;
        }
        test case def TC_REQ_GAP_DOC02_04 {
            subject GimbalNighthawk2Uz;
            verify requirement REQ_GAP_DOC02_04;
            objective "Verify REQ_GAP_DOC02_04 on GimbalNighthawk2Uz.";
            step verify_REQ_GAP_DOC02_04;
        }
        test case def TC_REQ_GAP_DOC02_05 {
            subject LethalPackage;
            verify requirement REQ_GAP_DOC02_05;
            objective "Verify REQ_GAP_DOC02_05 on LethalPackage.";
            step verify_REQ_GAP_DOC02_05;
        }
        test case def TC_REQ_GAP_DOC02_06 {
            subject UavRbfKey;
            verify requirement REQ_GAP_DOC02_06;
            objective "Verify REQ_GAP_DOC02_06 on UavRbfKey.";
            step verify_REQ_GAP_DOC02_06;
        }
        test case def TC_REQ_GAP_DOC02_07 {
            subject GroundControlStation;
            verify requirement REQ_GAP_DOC02_07;
            objective "Verify REQ_GAP_DOC02_07 on GroundControlStation.";
            step verify_REQ_GAP_DOC02_07;
        }
        test case def TC_REQ_GAP_DOC02_08 {
            subject GcsGroundBox;
            verify requirement REQ_GAP_DOC02_08;
            objective "Verify REQ_GAP_DOC02_08 on GcsGroundBox.";
            step verify_REQ_GAP_DOC02_08;
        }
        test case def TC_REQ_GAP_DOC03_01 {
            subject AirVehicleAvengerV25;
            verify requirement REQ_GAP_DOC03_01;
            objective "Verify REQ_GAP_DOC03_01 on AirVehicleAvengerV25.";
            step verify_REQ_GAP_DOC03_01;
        }
        test case def TC_REQ_GAP_DOC03_02 {
            subject EsadSafeAndArmDevice;
            verify requirement REQ_GAP_DOC03_02;
            objective "Verify REQ_GAP_DOC03_02 on EsadSafeAndArmDevice.";
            step verify_REQ_GAP_DOC03_02;
        }
        test case def TC_REQ_GAP_DOC03_03 {
            subject EsadSafeAndArmDevice;
            verify requirement REQ_GAP_DOC03_03;
            objective "Verify REQ_GAP_DOC03_03 on EsadSafeAndArmDevice.";
            step verify_REQ_GAP_DOC03_03;
        }
        test case def TC_REQ_GAP_DOC03_04 {
            subject ProximitySensorBoard;
            verify requirement REQ_GAP_DOC03_04;
            objective "Verify REQ_GAP_DOC03_04 on ProximitySensorBoard.";
            step verify_REQ_GAP_DOC03_04;
        }
        test case def TC_REQ_GAP_DOC03_05 {
            subject LethalPackage;
            verify requirement REQ_GAP_DOC03_05;
            objective "Verify REQ_GAP_DOC03_05 on LethalPackage.";
            step verify_REQ_GAP_DOC03_05;
        }
        test case def TC_REQ_GAP_DOC03_06 {
            subject AutopilotStackModuleAstkA5V25;
            verify requirement REQ_GAP_DOC03_06;
            objective "Verify REQ_GAP_DOC03_06 on AutopilotStackModuleAstkA5V25.";
            step verify_REQ_GAP_DOC03_06;
        }
        test case def TC_REQ_GAP_DOC03_07 {
            subject EsadSafeAndArmDevice;
            verify requirement REQ_GAP_DOC03_07;
            objective "Verify REQ_GAP_DOC03_07 on EsadSafeAndArmDevice.";
            step verify_REQ_GAP_DOC03_07;
        }
        test case def TC_REQ_GAP_DOC04_01 {
            subject Pl40RearRailSection;
            verify requirement REQ_GAP_DOC04_01;
            objective "Verify REQ_GAP_DOC04_01 on Pl40RearRailSection.";
            step verify_REQ_GAP_DOC04_01;
        }
        test case def TC_REQ_GAP_DOC04_02 {
            subject Pl40TriggerHandle;
            verify requirement REQ_GAP_DOC04_02;
            objective "Verify REQ_GAP_DOC04_02 on Pl40TriggerHandle.";
            step verify_REQ_GAP_DOC04_02;
        }
        test case def TC_REQ_GAP_DOC04_03 {
            subject Pl40AuxiliaryPressureSource;
            verify requirement REQ_GAP_DOC04_03;
            objective "Verify REQ_GAP_DOC04_03 on Pl40AuxiliaryPressureSource.";
            step verify_REQ_GAP_DOC04_03;
        }
        test case def TC_REQ_GAP_DOC04_04 {
            subject UavConnectionHookSet;
            verify requirement REQ_GAP_DOC04_04;
            objective "Verify REQ_GAP_DOC04_04 on UavConnectionHookSet.";
            step verify_REQ_GAP_DOC04_04;
        }
        test case def TC_REQ_GAP_DOC04_05 {
            subject Pl40CompressorController;
            verify requirement REQ_GAP_DOC04_05;
            objective "Verify REQ_GAP_DOC04_05 on Pl40CompressorController.";
            step verify_REQ_GAP_DOC04_05;
        }
        test case def TC_REQ_GAP_DOC04_06 {
            subject PneumaticLauncherPl40;
            verify requirement REQ_GAP_DOC04_06;
            objective "Verify REQ_GAP_DOC04_06 on PneumaticLauncherPl40.";
            step verify_REQ_GAP_DOC04_06;
        }
        test case def TC_REQ_GAP_DOC04_07 {
            subject Pl40GroundAnchorAssembly;
            verify requirement REQ_GAP_DOC04_07;
            objective "Verify REQ_GAP_DOC04_07 on Pl40GroundAnchorAssembly.";
            step verify_REQ_GAP_DOC04_07;
        }
        test case def TC_REQ_GAP_DOC05_01 {
            subject AirVehicleAvengerV25;
            verify requirement REQ_GAP_DOC05_01;
            objective "Verify REQ_GAP_DOC05_01 on AirVehicleAvengerV25.";
            step verify_REQ_GAP_DOC05_01;
        }
        test case def TC_REQ_GAP_DOC05_02 {
            subject Battery12S2PLiMetalBei;
            verify requirement REQ_GAP_DOC05_02;
            objective "Verify REQ_GAP_DOC05_02 on Battery12S2PLiMetalBei.";
            step verify_REQ_GAP_DOC05_02;
        }
        test case def TC_REQ_GAP_DOC05_03 {
            subject EsadSafeAndArmDevice;
            verify requirement REQ_GAP_DOC05_03;
            objective "Verify REQ_GAP_DOC05_03 on EsadSafeAndArmDevice.";
            step verify_REQ_GAP_DOC05_03;
        }
        test case def TC_REQ_GAP_DOC05_04 {
            subject UavUmbilicalAccessPort;
            verify requirement REQ_GAP_DOC05_04;
            objective "Verify REQ_GAP_DOC05_04 on UavUmbilicalAccessPort.";
            step verify_REQ_GAP_DOC05_04;
        }
        test case def TC_REQ_GAP_DOC05_05 {
            subject WingsActuatorGroup;
            verify requirement REQ_GAP_DOC05_05;
            objective "Verify REQ_GAP_DOC05_05 on WingsActuatorGroup.";
            step verify_REQ_GAP_DOC05_05;
        }
        test case def TC_REQ_GAP_DOC05_06 {
            subject PneumaticLauncherPl40;
            verify requirement REQ_GAP_DOC05_06;
            objective "Verify REQ_GAP_DOC05_06 on PneumaticLauncherPl40.";
            step verify_REQ_GAP_DOC05_06;
        }
        test case def TC_REQ_GAP_DOC05_07 {
            subject FinsActuatorGroup;
            verify requirement REQ_GAP_DOC05_07;
            objective "Verify REQ_GAP_DOC05_07 on FinsActuatorGroup.";
            step verify_REQ_GAP_DOC05_07;
        }
        test case def TC_REQ_GAP_DOC05_08 {
            subject PanasonicFzG2Tablet;
            verify requirement REQ_GAP_DOC05_08;
            objective "Verify REQ_GAP_DOC05_08 on PanasonicFzG2Tablet.";
            step verify_REQ_GAP_DOC05_08;
        }
        test case def TC_REQ_GAP_DOC05_09 {
            subject EsdGroundingPoint;
            verify requirement REQ_GAP_DOC05_09;
            objective "Verify REQ_GAP_DOC05_09 on EsdGroundingPoint.";
            step verify_REQ_GAP_DOC05_09;
        }
        test case def TC_REQ_GAP_DOC06_01 {
            subject AirVehicleAvengerV25;
            verify requirement REQ_GAP_DOC06_01;
            objective "Verify REQ_GAP_DOC06_01 on AirVehicleAvengerV25.";
            step verify_REQ_GAP_DOC06_01;
        }
        test case def TC_REQ_GAP_DOC06_02 {
            subject ParachuteDeploymentPackage;
            verify requirement REQ_GAP_DOC06_02;
            objective "Verify REQ_GAP_DOC06_02 on ParachuteDeploymentPackage.";
            step verify_REQ_GAP_DOC06_02;
        }
        test case def TC_REQ_GAP_DOC06_03 {
            subject EsadSafeAndArmDevice;
            verify requirement REQ_GAP_DOC06_03;
            objective "Verify REQ_GAP_DOC06_03 on EsadSafeAndArmDevice.";
            step verify_REQ_GAP_DOC06_03;
        }
        test case def TC_REQ_GAP_DOC06_04 {
            subject EsadRbfKey;
            verify requirement REQ_GAP_DOC06_04;
            objective "Verify REQ_GAP_DOC06_04 on EsadRbfKey.";
            step verify_REQ_GAP_DOC06_04;
        }
        test case def TC_REQ_GAP_DOC06_05 {
            subject RadioModuleDtc;
            verify requirement REQ_GAP_DOC06_05;
            objective "Verify REQ_GAP_DOC06_05 on RadioModuleDtc.";
            step verify_REQ_GAP_DOC06_05;
        }
        test case def TC_REQ_GAP_DOC06_06 {
            subject AutopilotCubeOrangePlus;
            verify requirement REQ_GAP_DOC06_06;
            objective "Verify REQ_GAP_DOC06_06 on AutopilotCubeOrangePlus.";
            step verify_REQ_GAP_DOC06_06;
        }
        test case def TC_REQ_GAP_DOC06_07 {
            subject GcsOmniAntenna;
            verify requirement REQ_GAP_DOC06_07;
            objective "Verify REQ_GAP_DOC06_07 on GcsOmniAntenna.";
            step verify_REQ_GAP_DOC06_07;
        }
        test case def TC_REQ_GAP_DOC06_08 {
            subject Battery12S2PLiMetalBei;
            verify requirement REQ_GAP_DOC06_08;
            objective "Verify REQ_GAP_DOC06_08 on Battery12S2PLiMetalBei.";
            step verify_REQ_GAP_DOC06_08;
        }
        test case def TC_REQ_GAP_DOC06_09 {
            subject CameraComputeModuleTrip6;
            verify requirement REQ_GAP_DOC06_09;
            objective "Verify REQ_GAP_DOC06_09 on CameraComputeModuleTrip6.";
            step verify_REQ_GAP_DOC06_09;
        }
        test case def TC_REQ_GAP_DOC06_10 {
            subject AutopilotCubeOrangePlus;
            verify requirement REQ_GAP_DOC06_10;
            objective "Verify REQ_GAP_DOC06_10 on AutopilotCubeOrangePlus.";
            step verify_REQ_GAP_DOC06_10;
        }
        test case def TC_REQ_GAP_DOC06_11 {
            subject FieldMaintenanceKit;
            verify requirement REQ_GAP_DOC06_11;
            objective "Verify REQ_GAP_DOC06_11 on FieldMaintenanceKit.";
            step verify_REQ_GAP_DOC06_11;
        }
        test case def TC_REQ_GAP_DOC06_12 {
            subject TubeLauncherOption;
            verify requirement REQ_GAP_DOC06_12;
            objective "Verify REQ_GAP_DOC06_12 on TubeLauncherOption.";
            step verify_REQ_GAP_DOC06_12;
        }
        test case def TC_REQ_GAP_DOC06_13 {
            subject EsadSafeAndArmDevice;
            verify requirement REQ_GAP_DOC06_13;
            objective "Verify REQ_GAP_DOC06_13 on EsadSafeAndArmDevice.";
            step verify_REQ_GAP_DOC06_13;
        }
        test case def TC_REQ_GAP_DOC06_14 {
            subject Pl40CarriageSafetyLockPin;
            verify requirement REQ_GAP_DOC06_14;
            objective "Verify REQ_GAP_DOC06_14 on Pl40CarriageSafetyLockPin.";
            step verify_REQ_GAP_DOC06_14;
        }
        test case def TC_REQ_GAP_MERGE_01 {
            subject GnssModuleSeptentrioAsterxM3Pro;
            verify requirement REQ_GAP_MERGE_01;
            objective "Verify REQ_GAP_MERGE_01 on GnssModuleSeptentrioAsterxM3Pro.";
            step verify_REQ_GAP_MERGE_01;
        }
        test case def TC_REQ_GAP_MERGE_02 {
            subject AutopilotCubeOrangePlus;
            verify requirement REQ_GAP_MERGE_02;
            objective "Verify REQ_GAP_MERGE_02 on AutopilotCubeOrangePlus.";
            step verify_REQ_GAP_MERGE_02;
        }
        test case def TC_REQ_GAP_MERGE_03 {
            subject GroundControlStation;
            verify requirement REQ_GAP_MERGE_03;
            objective "Verify REQ_GAP_MERGE_03 on GroundControlStation.";
            step verify_REQ_GAP_MERGE_03;
        }
        test case def TC_REQ_GAP_MERGE_04 {
            subject PneumaticLauncherPl40;
            verify requirement REQ_GAP_MERGE_04;
            objective "Verify REQ_GAP_MERGE_04 on PneumaticLauncherPl40.";
            step verify_REQ_GAP_MERGE_04;
        }
        test case def TC_REQ_GAP_MERGE_05 {
            subject ProximitySensorBoard;
            verify requirement REQ_GAP_MERGE_05;
            objective "Verify REQ_GAP_MERGE_05 on ProximitySensorBoard.";
            step verify_REQ_GAP_MERGE_05;
        }
        test case def TC_REQ_GAP_MERGE_06 {
            subject EpsElectronicPowerSystemModule;
            verify requirement REQ_GAP_MERGE_06;
            objective "Verify REQ_GAP_MERGE_06 on EpsElectronicPowerSystemModule.";
            step verify_REQ_GAP_MERGE_06;
        }
    }
    package LeafComponentsPackage {
        part def Battery12S2PLiMetalBei {
            attribute functionalCategory : String = "energy_storage";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "self_energy_source";
            attribute capabilityRole : String = "Cap_energy_storage";
            attribute realizedActions : String = "Act_Battery12S2PLiMetalBei_1, Act_Battery12S2PLiMetalBei_2, Act_Battery12S2PLiMetalBei_3, Act_Battery12S2PLiMetalBei_4, Act_Battery12S2PLiMetalBei_5, Act_Battery12S2PLiMetalBei_6, Act_Battery12S2PLiMetalBei_7";
            attribute boundConstraints : String = "INV_DOC05_06, INV_DOC06_22";
            attribute boundProtocolItems : String = "ITEM_PROTO_DOC05_BATTERY_ID_QR_MATCH";
            attribute seriesCellCount : Integer = 12;
            attribute parallelCellCount : Integer = 2;
            attribute cellChemistryAndModel : String = "Li metal BEI, cells - maximus20";
            attribute voltageMinV : Real = 36.0;
            attribute voltageMaxV : Real = 50.4;
            attribute isRemovable : Boolean = true;
            attribute examplePackSerialLabels : String = "BATT: 9 SN: 311 4169; BATT: 10 SN: 311 4176";
            attribute identificationMatchRequired : Boolean = true;
            attribute illustrativeUiBatteryVoltageV : Real = 23.9;
            attribute preflightFullChargeVoltageMinV : Real = 49.0;
            attribute preflightFullChargeVoltageMaxV : Real = 50.0;
            port out dcPowerOut : DcPowerOutPort;
            port in dcChargeIn : DcPowerInPort;
            satisfy requirement REQ_INV_DOC05_05;
            satisfy requirement REQ_PROTO_DOC05_BATTERY_ID_QR_MATCH;
            satisfy requirement REQ_GAP_DOC05_02;
            satisfy requirement REQ_GAP_DOC06_08;
        }
        part def AutomotiveFuse200A {
            attribute functionalCategory : String = "circuit_protection";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_circuit_protection";
            attribute realizedActions : String = "Act_AutomotiveFuse200A_1";
            attribute boundConstraints : String = "INV_DOC01_09";
            attribute ratedCurrentA : Real = 200.0;
            port in dcPowerIn : DcPowerInPort;
            port out dcPowerOut : DcPowerOutPort;
        }
        part def PowerMeterSwitchSensor {
            attribute functionalCategory : String = "power_switch_meter";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_power_switch_meter";
            attribute realizedActions : String = "Act_PowerMeterSwitchSensor_1, Act_PowerMeterSwitchSensor_2, Act_PowerMeterSwitchSensor_3";
            attribute boundStateMachines : String = "FSM_UAV_MAIN_POWER, State_INV_DOC01_06";
            attribute boundProtocolItems : String = "ITEM_PROTO_POWER_METER_CAN1";
            attribute interactionBindings : String = "INT_01_SystemPowerOnAndRbfSequence";
            port in dcPowerIn : DcPowerInPort;
            port out dcPowerOutEsc : DcPowerOutPort;
            port out dcPowerOutEps : DcPowerOutPort;
            port out dcPowerOutSplitter : DcPowerOutPort;
            port inout can1Bus : CanBusInoutPort;
            port in rbfInterlockIn : DiscreteGpioInPort;
            satisfy requirement REQ_PROTO_POWER_METER_CAN1;
        }
        part def EscIbex160 {
            attribute functionalCategory : String = "power_distribution_regulator";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_power_distribution_regulator";
            attribute realizedActions : String = "Act_EscIbex160_1, Act_EscIbex160_2, Act_EscIbex160_3, Act_EscIbex160_4, Act_EscIbex160_5";
            attribute boundProtocolItems : String = "ITEM_PROTO_ESC_TELEMETRY_UART";
            port in dcPowerIn : DcPowerInPort;
            port out threePhaseAcOut : AcMultiphaseOutPort;
            port in pwmControlIn : PwmControlInPort;
            port in motTempTelemetryIn : CompositeSensorHarnessInPort;
            port out telemetryUartOut : UartSerialOutPort;
            satisfy requirement REQ_PROTO_ESC_TELEMETRY_UART;
        }
        part def MotorAxi534516HdGoldLineV3 {
            attribute functionalCategory : String = "electromechanical_actuator";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_electromechanical_actuator";
            attribute realizedActions : String = "Act_MotorAxi534516HdGoldLineV3_1, Act_MotorAxi534516HdGoldLineV3_2, Act_MotorAxi534516HdGoldLineV3_3, Act_MotorAxi534516HdGoldLineV3_4, Act_MotorAxi534516HdGoldLineV3_5";
            attribute boundProtocolItems : String = "ITEM_PROTO_MOTOR_TEMP_TELEMETRY";
            port in threePhaseAcIn : AcMultiphaseInPort;
            port out motTempTelemetryOut : CompositeSensorHarnessOutPort;
            port out propellerShaftOut : MechanicalStructuralLoadOutPort;
            satisfy requirement REQ_PROTO_MOTOR_TEMP_TELEMETRY;
        }
        part def FoldingPropeller {
            attribute functionalCategory : String = "electromechanical_actuator";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_electromechanical_actuator";
            attribute realizedActions : String = "Act_FoldingPropeller_1, Act_FoldingPropeller_2";
            attribute boundConstraints : String = "INV_DOC05_10";
            attribute bladeCount : Integer = 2;
            attribute propellerAssemblyCount : Integer = 1;
            attribute propellerBladeSpareCount : Integer = 2;
            port in motorShaftIn : MechanicalStructuralLoadInPort;
            port in sparePropellerIn : MechanicalStructuralLoadInPort;
        }
        part def EpsElectronicPowerSystemModule {
            attribute functionalCategory : String = "power_distribution_regulator";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_power_distribution_regulator";
            attribute realizedActions : String = "Act_EpsElectronicPowerSystemModule_1, Act_EpsElectronicPowerSystemModule_2, Act_EpsElectronicPowerSystemModule_3, Act_EpsElectronicPowerSystemModule_4, Act_EpsElectronicPowerSystemModule_5, Act_EpsElectronicPowerSystemModule_6";
            attribute boundProtocolItems : String = "ITEM_PROTO_SWARMC2_ESAD_CONTROL";
            port in battPowerIn : DcPowerInPort;
            port out stackPowerOut : DcPowerOutPort;
            port out splitterServo8vOut1 : DcPowerOutPort;
            port out splitterServo8vOut2 : DcPowerOutPort;
            port out splitterServo8vOut3 : DcPowerOutPort;
            port out splitterServo8vOut4 : DcPowerOutPort;
            port out finServoPower8vOut : DcPowerOutPort;
            port out pitoPowerOut : DcPowerOutPort;
            port out magPowerOut : DcPowerOutPort;
            port out gimbalTrip6PowerOut : DcPowerOutPort;
            port out radioPower12vOut : DcPowerOutPort;
            port out igniterPower50vOut1 : DcPowerOutPort;
            port out igniterPower50vOut2 : DcPowerOutPort;
            port out esadPower14vOut : DcPowerOutPort;
            port out ethSwitchPowerOut : DcPowerOutPort;
            port out rpiPowerOut : DcPowerOutPort;
            port out gnssPowerOut : DcPowerOutPort;
            satisfy requirement REQ_PROTO_SWARMC2_ESAD_CONTROL;
            satisfy requirement REQ_GAP_DOC01_04;
            satisfy requirement REQ_GAP_MERGE_06;
        }
        part def AutopilotCubeOrangePlus {
            attribute functionalCategory : String = "primary_controller";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_primary_controller";
            attribute realizedActions : String = "Act_AutopilotCubeOrangePlus_1, Act_AutopilotCubeOrangePlus_2, Act_AutopilotCubeOrangePlus_3, Act_AutopilotCubeOrangePlus_4, Act_AutopilotCubeOrangePlus_5, Act_AutopilotCubeOrangePlus_6, Act_AutopilotCubeOrangePlus_7, Act_AutopilotCubeOrangePlus_8, Act_AutopilotCubeOrangePlus_9, Act_AutopilotCubeOrangePlus_10, Act_AutopilotCubeOrangePlus_11, Act_AutopilotCubeOrangePlus_12, Act_AutopilotCubeOrangePlus_13, Act_AutopilotCubeOrangePlus_14, Act_AutopilotCubeOrangePlus_15, Act_AutopilotCubeOrangePlus_16, Act_AutopilotCubeOrangePlus_17, Act_AutopilotCubeOrangePlus_18, Act_AutopilotCubeOrangePlus_19, Act_AutopilotCubeOrangePlus_20, Action_INV_DOC06_12";
            attribute boundStateMachines : String = "FSM_DOC02_NAVIGATION_FAILSAFE, FSM_UAV_FLIGHT_MODES, FSM_PREFLIGHT_CHECKLIST_GATE, State_INV_DOC02_09";
            attribute boundConstraints : String = "INV_DOC06_08, INV_DOC06_10, INV_DOC06_14";
            attribute boundProtocolItems : String = "ITEM_PROTO_PWM_ESC_CONTROL, ITEM_PROTO_SWARMC2_RF_C2_TELEMETRY";
            attribute interactionBindings : String = "INT_04_WingsCan2DaisyChainControl, INT_06_AutonomousTerminalEngagement, INT_07_GnssDeniedDeadReckoning";
            attribute supportsAutonomousWaypointNav : Boolean = true;
            attribute supportsGnssDeniedCorrection : Boolean = true;
            attribute supportsDeadReckoningFailsafe : Boolean = true;
            attribute supportsAutonomousTerminalEngagement : Boolean = true;
            attribute wingspanM : Real = 1.8;
            attribute wingspanCadM : Real = 1.803;
            attribute assembledUavLengthM : Real = 1.6;
            attribute assembledUavLengthCadM : Real = 1.576;
            attribute assembledUavHeightM : Real = 1.1;
            attribute assembledUavHeightCadM : Real = 1.112;
            attribute ruddervatorSpanCadM : Real = 0.529;
            attribute maximumTakeoffWeightKg : Real = 17.0;
            attribute cruiseSpeedMps : Real = 30.0;
            attribute maxHorizontalSpeedMps : Real = 38.0;
            attribute maxDiveSpeedMps : Real = 55.0;
            attribute maxDiveAngleRad : Real = 0.383972;
            attribute minSpeedMps : Real = 26.0;
            attribute nominalFlightTimeS : Real = 5400.0;
            attribute hasRecoverySystem : Boolean = false;
            attribute defaultLoiterRadiusM : Real = 300.0;
            attribute minWaypointAltitudeM : Real = 50.0;
            attribute maxUiAltitudeSliderM : Real = 3000.0;
            attribute uiAirspeedSliderMinMps : Real = 10.0;
            attribute uiAirspeedSliderMaxMps : Real = 30.0;
            attribute engagementMaxStartElevationRad : Real = 0.261799;
            attribute shallowProfileApproachAngleRad : Real = 0.261799;
            attribute targetTrackAcquisitionMinS : Real = 2.0;
            attribute targetTrackAcquisitionMaxS : Real = 5.0;
            attribute maxMissionNameChars : Integer = 24;
            attribute exampleRtlAltitudeM : Real = 100.0;
            attribute exampleGcsFailsafeTimeoutS : Real = 105.0;
            attribute leftWingSectionCount : Integer = 2;
            attribute rightWingSectionCount : Integer = 2;
            attribute ruddervatorCount : Integer = 4;
            attribute windToleranceGroundMaxMS : Real = 12.0;
            attribute windToleranceCruiseMaxMS : Real = 28.0;
            attribute serviceCeilingM : Real = 5000.0;
            attribute operatingTempMinK : Real = 253.15;
            attribute operatingTempMaxK : Real = 323.15;
            attribute circularErrorProbableMaxM : Real = 0.5;
            attribute airframeFinishColor : String = "NAVY Grey / Camouflage";
            attribute stallSpeedSpecMps : Real = 24.0;
            attribute cruiseSpeedSpecMps : Real = 31.0;
            attribute maxHorizontalSpeedSpecMps : Real = 42.0;
            attribute maxDiveSpeedSpecMps : Real = 80.0;
            attribute wingMountBoltSpec : String = "M6 x 30 mm";
            attribute wingFrontPreinstalledBoltCount : Integer = 4;
            attribute wingTotalBoltCount : Integer = 8;
            attribute wingBoltHexKeySizeM : Real = 0.01;
            port in stackPowerIn : DcPowerInPort;
            port inout can1Bus : CanBusInoutPort;
            port inout can2Bus : CanBusInoutPort;
            port out pwmEscOut : PwmControlOutPort;
            port in escTelemetryUartIn : UartSerialInPort;
            port inout trip6Serial : UartSerialInoutPort;
            port inout gnssSerial : UartSerialInoutPort;
            port inout usbPort : UsbBusInoutPort;
            port inout rpiSerial : UartSerialInoutPort;
            port inout radioSerial : UartSerialInoutPort;
            port inout esadRs485 : Rs485DifferentialInoutPort;
            port out esadDiscreteArmOut : DiscreteGpioOutPort;
            satisfy requirement REQ_INV_DOC01_03;
            satisfy requirement REQ_INV_DOC02_08;
            satisfy requirement REQ_INV_DOC06_01;
            satisfy requirement REQ_INV_DOC06_02;
            satisfy requirement REQ_INV_DOC06_15;
            satisfy requirement REQ_PROTO_PWM_ESC_CONTROL;
            satisfy requirement REQ_PROTO_SWARMC2_RF_C2_TELEMETRY;
            satisfy requirement REQ_GAP_DOC02_03;
            satisfy requirement REQ_GAP_DOC06_06;
            satisfy requirement REQ_GAP_DOC06_10;
            satisfy requirement REQ_GAP_MERGE_02;
        }
        part def EthSwitch {
            attribute functionalCategory : String = "network_switch";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_network_switch";
            attribute realizedActions : String = "Act_EthSwitch_1";
            port in dcPowerIn : DcPowerInPort;
            port inout ethExtIf : EthernetIpInoutPort;
            port inout ethRpi : EthernetIpInoutPort;
            port inout ethTrip6 : EthernetIpInoutPort;
            port inout ethRadio : EthernetIpInoutPort;
        }
        part def RpiCm5004032 {
            attribute functionalCategory : String = "companion_computer";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_companion_computer";
            attribute realizedActions : String = "Act_RpiCm5004032_1";
            port in dcPowerIn : DcPowerInPort;
            port inout ethPort : EthernetIpInoutPort;
            port inout serialPort : UartSerialInoutPort;
        }
        part def CanPowerSplitterPcb {
            attribute functionalCategory : String = "splitter_distribution_pcb";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_splitter_distribution_pcb";
            attribute realizedActions : String = "Act_CanPowerSplitterPcb_1, Act_CanPowerSplitterPcb_2";
            attribute boundConstraints : String = "INV_DOC01_12";
            attribute interactionBindings : String = "INT_04_WingsCan2DaisyChainControl";
            port in battPowerIn : DcPowerInPort;
            port in epsServo8vIn1 : DcPowerInPort;
            port in epsServo8vIn2 : DcPowerInPort;
            port in epsServo8vIn3 : DcPowerInPort;
            port in epsServo8vIn4 : DcPowerInPort;
            port inout canUpstream : CanBusInoutPort;
            port out servoPower8vOut6 : DcPowerOutPort;
            port out servoPower8vOut5 : DcPowerOutPort;
            port out servoPower8vOut7 : DcPowerOutPort;
            port out servoPower8vOut8 : DcPowerOutPort;
            port inout can2DaisyOut : CanBusInoutPort;
            satisfy requirement REQ_GAP_DOC01_02;
        }
        part def ServoHv6160DroneCan {
            attribute functionalCategory : String = "electromechanical_actuator";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_electromechanical_actuator";
            attribute realizedActions : String = "Act_ServoHv6160DroneCan_1, Act_ServoHv6160DroneCan_2, Act_ServoHv6160DroneCan_3, Act_ServoHv6160DroneCan_4";
            attribute interactionBindings : String = "INT_04_WingsCan2DaisyChainControl";
            attribute nominalSupplyVoltageV : Real = 8.0;
            port in powerIn8v : DcPowerInPort;
            port inout canBusIn : CanBusInoutPort;
            port inout canBusThruOut : CanBusInoutPort;
        }
        part def PitoTubeCuavSkye2 {
            attribute functionalCategory : String = "airdata_sensor";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_airdata_sensor";
            attribute realizedActions : String = "Act_PitoTubeCuavSkye2_1, Act_PitoTubeCuavSkye2_2, Act_PitoTubeCuavSkye2_3, Act_PitoTubeCuavSkye2_4, Act_PitoTubeCuavSkye2_5, Act_PitoTubeCuavSkye2_6";
            attribute boundConstraints : String = "INV_DOC06_20";
            attribute hasHeating : Boolean = true;
            attribute illustrativeChecklistAirspeedMps : Real = 0.5;
            attribute preflightCalmAirspeedMaxMps : Real = 3.0;
            attribute preflightBlowTestAirspeedMinMps : Real = 10.0;
            port in powerIn : DcPowerInPort;
            port inout can1Bus : CanBusInoutPort;
            port in protectiveCoverIn : MechanicalStructuralLoadInPort;
            satisfy requirement REQ_INV_DOC01_10;
        }
        part def MagnetometerMroRm3100 {
            attribute functionalCategory : String = "navigation_sensor";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_navigation_sensor";
            attribute realizedActions : String = "Act_MagnetometerMroRm3100_1, Act_MagnetometerMroRm3100_2, Act_MagnetometerMroRm3100_3";
            port in powerIn : DcPowerInPort;
            port inout can1Bus : CanBusInoutPort;
            satisfy requirement REQ_INV_DOC01_04;
        }
        part def GnssAntennaTalysmanTw3972Exf {
            attribute functionalCategory : String = "passive_antenna";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_passive_antenna";
            attribute realizedActions : String = "Act_GnssAntennaTalysmanTw3972Exf_1";
            port out rfOut : RfCoaxOutPort;
        }
        part def GnssModuleSeptentrioAsterxM3Pro {
            attribute functionalCategory : String = "gnss_receiver";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_gnss_receiver";
            attribute realizedActions : String = "Act_GnssModuleSeptentrioAsterxM3Pro_1, Act_GnssModuleSeptentrioAsterxM3Pro_2, Act_GnssModuleSeptentrioAsterxM3Pro_3, Act_GnssModuleSeptentrioAsterxM3Pro_4, Act_GnssModuleSeptentrioAsterxM3Pro_5";
            attribute boundStateMachines : String = "FSM_GNSS_NAVIGATION_MODE";
            attribute interactionBindings : String = "INT_07_GnssDeniedDeadReckoning";
            attribute supportedConstellations : String = "GPS/GLONASS/GALILEO";
            attribute illustrativeChecklistSatelliteCount : Integer = 35;
            port in dcPowerIn : DcPowerInPort;
            port in rfIn : RfCoaxInPort;
            port inout serialPort : UartSerialInoutPort;
            satisfy requirement REQ_INV_DOC02_11;
            satisfy requirement REQ_INV_DOC06_13;
            satisfy requirement REQ_GAP_MERGE_01;
        }
        part def GimbalNighthawk2Uz {
            attribute functionalCategory : String = "electro_optical_gimbal";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "in_band_signal_or_composite_cable";
            attribute capabilityRole : String = "Cap_electro_optical_gimbal";
            attribute realizedActions : String = "Act_GimbalNighthawk2Uz_1, Act_GimbalNighthawk2Uz_2, Act_GimbalNighthawk2Uz_3, Act_GimbalNighthawk2Uz_4, Act_GimbalNighthawk2Uz_5, Act_GimbalNighthawk2Uz_6, Act_GimbalNighthawk2Uz_7, Act_GimbalNighthawk2Uz_8, Act_GimbalNighthawk2Uz_9, Act_GimbalNighthawk2Uz_10, Act_GimbalNighthawk2Uz_11";
            attribute boundStateMachines : String = "FSM_GIMBAL_CAMERA_MODES";
            attribute boundConstraints : String = "INV_DOC02_13, INV_DOC06_09";
            attribute interactionBindings : String = "INT_06_AutonomousTerminalEngagement";
            attribute totalZoomFactor : Integer = 40;
            attribute opticalZoomFactor : Integer = 20;
            attribute digitalZoomFactor : Integer = 2;
            attribute dayCameraWidthPx : Integer = 1280;
            attribute dayCameraHeightPx : Integer = 720;
            attribute thermalCameraWidthPx : Integer = 1280;
            attribute thermalCameraHeightPx : Integer = 720;
            attribute stabilizedAxesCount : Integer = 2;
            attribute pitchLimitMinRad : Real = -0.7853981633974483;
            attribute pitchLimitMaxRad : Real = 2.356194490192345;
            attribute yawRollLimitMinRad : Real = -2.8797932657906435;
            attribute yawRollLimitMaxRad : Real = 2.8797932657906435;
            attribute engagementMaxAirspeedLimitMps : Real = 55.0;
            port inout powerHdmiIn : CompositePowerVideoInoutPort;
            port in securingStrapIn : MechanicalStructuralLoadInPort;
            satisfy requirement REQ_INV_DOC06_21;
            satisfy requirement REQ_GAP_DOC02_04;
        }
        part def CameraComputeModuleTrip6 {
            attribute functionalCategory : String = "payload_compute_module";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_payload_compute_module";
            attribute realizedActions : String = "Act_CameraComputeModuleTrip6_1, Act_CameraComputeModuleTrip6_2, Act_CameraComputeModuleTrip6_3, Act_CameraComputeModuleTrip6_4, Act_CameraComputeModuleTrip6_5, Act_CameraComputeModuleTrip6_6, Act_CameraComputeModuleTrip6_7, Act_CameraComputeModuleTrip6_8, Act_CameraComputeModuleTrip6_9, Act_CameraComputeModuleTrip6_10";
            attribute boundProtocolItems : String = "ITEM_PROTO_SWARMC2_PAYLOAD_VIDEO_OSD";
            attribute interactionBindings : String = "INT_06_AutonomousTerminalEngagement";
            attribute multitrackSlotCount : Integer = 5;
            port in powerIn : DcPowerInPort;
            port inout gimbalPowerHdmiOut : CompositePowerVideoInoutPort;
            port inout serialPort : UartSerialInoutPort;
            port inout ethPort : EthernetIpInoutPort;
            satisfy requirement REQ_INV_DOC01_05;
            satisfy requirement REQ_INV_DOC06_11;
            satisfy requirement REQ_PROTO_SWARMC2_PAYLOAD_VIDEO_OSD;
            satisfy requirement REQ_GAP_DOC06_09;
        }
        part def RadioModuleDtc {
            attribute functionalCategory : String = "rf_transceiver";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_rf_transceiver";
            attribute realizedActions : String = "Act_RadioModuleDtc_1, Act_RadioModuleDtc_2, Act_RadioModuleDtc_3, Act_RadioModuleDtc_4, Act_RadioModuleDtc_5, Act_RadioModuleDtc_6, Act_RadioModuleDtc_7, Act_RadioModuleDtc_8, Act_RadioModuleDtc_9, Act_RadioModuleDtc_10";
            attribute boundProtocolItems : String = "ITEM_PROTO_DOC02_RF_C2_LINK";
            attribute interactionBindings : String = "INT_05_GcsUavRfC2AndVideoLink";
            attribute rfFrequencyMinHz : Real = 4400000000.0;
            attribute rfFrequencyMaxHz : Real = 5000000000.0;
            attribute dcInputVoltageMinV : Real = 8.0;
            attribute dcInputVoltageMaxV : Real = 17.0;
            attribute rfOutputChannelCount : Integer = 2;
            attribute rfOutputPowerPerChannelW : Real = 1.0;
            attribute rfOutputPowerTotalW : Real = 2.0;
            attribute encryptionStandard : String = "AES-256";
            attribute rlosDirectRangeM : Real = 60000.0;
            attribute rlosRelayRangeM : Real = 90000.0;
            attribute hasInterferenceAvoidance : Boolean = true;
            attribute usesSplitUplinkDownlinkFreq : Boolean = true;
            attribute configuredDroneTxPowerW : Real = 2.0;
            attribute observedRadioFrequencyHz : Real = 4910000000.0;
            attribute commandControlRangeRlosMinM : Real = 60000.0;
            attribute commandControlRangeRlosMaxM : Real = 180000.0;
            attribute minGroundSeparationFromRadioModuleM : Real = 10.0;
            port in powerIn12v : DcPowerInPort;
            port inout ethPort : EthernetIpInoutPort;
            port inout serialPort : UartSerialInoutPort;
            port inout rfPort1 : RfCoaxInoutPort;
            port inout rfPort2 : RfCoaxInoutPort;
            satisfy requirement REQ_INV_DOC02_10;
            satisfy requirement REQ_PROTO_DOC02_RF_C2_LINK;
            satisfy requirement REQ_GAP_DOC02_02;
            satisfy requirement REQ_GAP_DOC06_05;
        }
        part def RadioAntennaMpsl4400 {
            attribute functionalCategory : String = "passive_antenna";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_passive_antenna";
            attribute realizedActions : String = "Act_RadioAntennaMpsl4400_1, Act_RadioAntennaMpsl4400_2, Act_RadioAntennaMpsl4400_3, Act_RadioAntennaMpsl4400_4";
            port inout rfPort : RfCoaxInoutPort;
            port inout rfOverTheAir : RfOverTheAirInoutPort;
        }
        part def ProximitySensor {
            attribute functionalCategory : String = "proximity_impact_sensor";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_proximity_impact_sensor";
            attribute realizedActions : String = "Act_ProximitySensor_1, Act_ProximitySensor_2, Act_ProximitySensor_3, Act_ProximitySensor_4, Act_ProximitySensor_5, Act_ProximitySensor_6";
            attribute boundConstraints : String = "INV_DOC03_06, ConstraintProximitySensorDocumentedSparePins";
            attribute boundProtocolItems : String = "ITEM_PROTO_ESAD_SENSOR_UART";
            attribute sparePin_J2_ALL : String = "RESERVED_FOR_ARTRON (Sensor Board reserved connector) | documented_spare_unconnected | DOC-03 p.10 Fig 6";
            attribute pcbDrawingCode : String = "PC AB00-0035-00AA-0000 / AB00-0035-00AA-0000";
            attribute j1MatingConnectorModel : String = "Molex 501330-0800 (8-pin)";
            attribute harnessConductorGaugeAwg : Integer = 28;
            attribute nominalSupplyVoltageV : Real = 5.0;
            attribute boardWidthM : Real = 0.044;
            attribute boardCoreHeightM : Real = 0.0214;
            attribute boardOverallHeightM : Real = 0.02239;
            attribute overallDepthM : Real = 0.01483;
            attribute frontOpticsProtrusionM : Real = 0.0077;
            attribute rearConnectorProtrusionM : Real = 0.00554;
            attribute userMountingHoleCount : Integer = 2;
            attribute userMountingHoleDiameterM : Real = 0.0021;
            attribute mountingHoleSpacingM : Real = 0.0142;
            attribute rxConeMajorDivergenceRad : Real = 0.216421;
            attribute rxConeMinorDivergenceRad : Real = 0.094248;
            attribute rxConeSquintAngleRad : Real = 0.047124;
            attribute txConeDivergenceRad : Real = 0.034907;
            attribute txConeSquintAngleRad : Real = 0.0;
            attribute lensApertureM : Real = 0.006;
            attribute focalWidthM : Real = 0.0055;
            attribute pixelMatrixWidthM : Real = 0.0012;
            attribute pixelMatrixHeightM : Real = 0.00052;
            port in powerIn5v : DcPowerInPort;
            port inout uartPort : UartSerialInoutPort;
            port out analogTriggerOut : DiscreteGpioOutPort;
            port inout sensorSpareLine : DiscreteGpioInoutPort;
            port in protectiveCoverIn : MechanicalStructuralLoadInPort;
            satisfy requirement REQ_PROTO_ESAD_SENSOR_UART;
        }
        part def ImpactSwitch {
            attribute functionalCategory : String = "proximity_impact_sensor";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_proximity_impact_sensor";
            attribute realizedActions : String = "Act_ImpactSwitch_1";
            port out impactTriggerOut : DiscreteGpioOutPort;
        }
        part def ParachuteIgniter {
            attribute functionalCategory : String = "pyrotechnic_actuator";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_pyrotechnic_actuator";
            attribute realizedActions : String = "Act_ParachuteIgniter_1";
            attribute nominalFireSupplyVoltageV : Real = 50.0;
            port in powerIn50v : DcPowerInPort;
        }
        part def EsadSafeAndArmDevice {
            attribute functionalCategory : String = "safe_arm_controller";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_safe_arm_controller";
            attribute realizedActions : String = "Act_EsadSafeAndArmDevice_1, Act_EsadSafeAndArmDevice_2, Act_EsadSafeAndArmDevice_3, Act_EsadSafeAndArmDevice_4, Act_EsadSafeAndArmDevice_5, Act_EsadSafeAndArmDevice_6, Act_EsadSafeAndArmDevice_7, Act_EsadSafeAndArmDevice_8, Act_EsadSafeAndArmDevice_9, Act_EsadSafeAndArmDevice_10, Act_EsadSafeAndArmDevice_11, Act_EsadSafeAndArmDevice_12, Act_EsadSafeAndArmDevice_13, Act_EsadSafeAndArmDevice_14, Act_EsadSafeAndArmDevice_15, Act_EsadSafeAndArmDevice_16, Act_EsadSafeAndArmDevice_17, Action_INV_DOC03_03";
            attribute boundStateMachines : String = "FSM_ESAD_SAFE_AND_ARM, FSM_ESAD_BOOT_PBIT_MODESELECT, State_INV_DOC01_07, State_INV_DOC03_01, State_INV_DOC05_15, State_INV_DOC06_03, State_INV_DOC06_04, State_INV_DOC06_06";
            attribute boundConstraints : String = "INV_DOC03_02, INV_DOC03_05, ConstraintEsadDocumentedSparePins";
            attribute boundProtocolItems : String = "ITEM_PROTO_ESAD_RS485, ITEM_PROTO_ESAD_DSC_IN1";
            attribute interactionBindings : String = "INT_02_EsadBootPbitAndRs485Exchange, INT_08_LethalPyrotechnicInitiationTrain";
            attribute sparePin_J100_7 : String = "NA (not used in generic configuration) | documented_spare_unconnected | DOC-03 p.10 Table 1";
            attribute sparePin_J100_8 : String = "NA (not used in generic configuration) | documented_spare_unconnected | DOC-03 p.10 Table 1";
            attribute sparePin_J100_11 : String = "EXT_RS485_P (RS-485 Differential Positive Line Spare) | documented_spare_unconnected | DOC-03 p.10 Table 1";
            attribute sparePin_J100_12 : String = "EXT_RS485_N (RS-485 Differential Negative Line Spare) | documented_spare_unconnected | DOC-03 p.10 Table 1";
            attribute sparePin_J100_14 : String = "DSC_IN2 (Discrete Input 2, unassigned in generic Section 1.4.5) | documented_spare_unconnected | DOC-03 p.10 Table 1";
            attribute sparePin_J100_15 : String = "DSC_OUT1 (Discrete Output 1, unassigned in generic Section 1.4.5) | documented_spare_unconnected | DOC-03 p.10 Table 1";
            attribute sparePin_J100_16 : String = "DSC_OUT2 (Discrete Output 2, unassigned in generic Section 1.4.5) | documented_spare_unconnected | DOC-03 p.10 Table 1";
            attribute sparePin_J101_ALL : String = "RESERVED_FOR_ARTRON (dedicated reserved ESAD connector) | documented_spare_unconnected | DOC-03 p.9 Fig 4";
            attribute sparePin_J102_5 : String = "NA (28AWG wire inserted, isolated and terminated mid-cable, epoxy back-potted) | documented_spare_unconnected | DOC-03 p.13 Table 2";
            attribute sparePin_J102_10 : String = "NA (28AWG wire inserted, isolated and terminated mid-cable, epoxy back-potted) | documented_spare_unconnected | DOC-03 p.13 Table 2";
            attribute sparePin_J401_4 : String = "NA (Pin removed) | documented_spare_unconnected | DOC-03 p.12 Table 3";
            attribute sparePin_J401_8 : String = "NA (Pin removed) | documented_spare_unconnected | DOC-03 p.12 Table 3";
            attribute nominalSupplyVoltageV : Real = 14.0;
            attribute icdDocumentNumber : String = "ICD_AB00-0054-01AA-0005 (Rev 1 / Rev. No: 01, 14.04.2026)";
            attribute pcbDrawingCode : String = "PC AB00-0054-01AA-0000 / AB00-0054-01AA-0000";
            attribute standardsCompatibility : String = "STANAG 4187, MIL-STD-461";
            attribute j100MatingConnectorModel : String = "Harwin G125-2241696F1 (crimps G125-0020005)";
            attribute j102MatingConnectorModel : String = "Harwin G125-2241096F1 (crimps G125-0020005, epoxy back-potted)";
            attribute j401ActivePinCount : Integer = 6;
            attribute detonatorSpacerPartNumber : String = "MMM1-0054-02AA-0000";
            attribute detonatorInsulationMaterial : String = "Kapton Film";
            attribute inputVoltageMinV : Real = 14.0;
            attribute inputVoltageNominalV : Real = 28.0;
            attribute inputVoltageMaxV : Real = 32.0;
            attribute sensorSupplyVoltageV : Real = 5.0;
            attribute umbilicalLoopMaxResistanceOhm : Real = 0.5;
            attribute umbilicalLoopCurrentA : Real = 0.02;
            attribute discreteArmLowMinV : Real = 0.0;
            attribute discreteArmLowMaxV : Real = 0.7;
            attribute discreteArmHighMinV : Real = 2.5;
            attribute discreteArmHighMaxV : Real = 3.3;
            attribute discreteArmPwmPeriodS : Real = 0.001;
            attribute discreteArmPwmDutyCyclePct : Real = 50.0;
            attribute discreteArmPulseCount : Integer = 2;
            attribute highVoltageOutputMaxV : Real = 1800.0;
            attribute pbitHighVoltageThresholdV : Real = 50.0;
            attribute pbitDurationS : Real = 0.5;
            attribute simulationWaitWindowS : Real = 1.0;
            attribute rs485BaudRateBps : Integer = 115200;
            attribute rs485ResponseDeadlineS : Real = 0.005;
            attribute rs485IncompleteTimeoutS : Real = 0.01;
            attribute rs485ExchangePeriodS : Real = 0.1;
            attribute accelerationResolutionMPerS2 : Real = 0.038245935;
            attribute boardDiameterM : Real = 0.062;
            attribute reservedHolesPitchDiameterM : Real = 0.045;
            attribute reservedHoleDiameterM : Real = 0.008;
            attribute overallHeightM : Real = 0.02234;
            attribute topProtrusionHeightM : Real = 0.0155;
            attribute bottomProtrusionHeightM : Real = 0.005;
            attribute userMountingHoleCount : Integer = 3;
            attribute userMountingHoleDiameterM : Real = 0.0032;
            attribute mountingHoleCoordinatesMm : String = "A1(-32.48, -18.75), A2(0, 37.50), A3(32.48, -18.75) mm";
            attribute payloadTerminalHexSizeM : Real = 0.0015;
            attribute pcbEdgeMarking : String = "T4";
            attribute selfDestructHoldDurationS : Real = 5.0;
            attribute abortHoldDurationS : Real = 5.0;
            port in powerIn14v : DcPowerInPort;
            port inout rs485Port : Rs485DifferentialInoutPort;
            port in dscArmEnableIn : DiscreteGpioInPort;
            port inout umbilicalLoop : UmbilicalContinuityLoopInoutPort;
            port out sensorPower5vOut : DcPowerOutPort;
            port inout sensorUartPort : UartSerialInoutPort;
            port in analogTriggerIn : DiscreteGpioInPort;
            port inout sensorSpareLine : DiscreteGpioInoutPort;
            port out hvFireOut : HighVoltageFireOutPort;
            port in rbfInterlockIn : DiscreteGpioInPort;
            satisfy requirement REQ_INV_DOC01_08;
            satisfy requirement REQ_INV_DOC03_07;
            satisfy requirement REQ_INV_DOC03_08;
            satisfy requirement REQ_INV_DOC06_05;
            satisfy requirement REQ_INV_DOC06_07;
            satisfy requirement REQ_PROTO_ESAD_RS485;
            satisfy requirement REQ_PROTO_ESAD_DSC_IN1;
            satisfy requirement REQ_GAP_DOC03_02;
            satisfy requirement REQ_GAP_DOC03_03;
            satisfy requirement REQ_GAP_DOC03_07;
            satisfy requirement REQ_GAP_DOC05_03;
            satisfy requirement REQ_GAP_DOC06_03;
            satisfy requirement REQ_GAP_DOC06_13;
        }
        part def LeefiDetonator {
            attribute functionalCategory : String = "pyrotechnic_actuator";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_pyrotechnic_actuator";
            attribute realizedActions : String = "Act_LeefiDetonator_1";
            attribute spacerPartNumber : String = "MMM1-0054-02AA-0000";
            port in hvFireIn : HighVoltageFireInPort;
            port out detonationOut : MechanicalStructuralLoadOutPort;
        }
        part def WarheadBooster {
            attribute functionalCategory : String = "energetic_payload";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_energetic_payload";
            attribute realizedActions : String = "Act_WarheadBooster_1";
            port in detonationIn : MechanicalStructuralLoadInPort;
            port out detonationOut : MechanicalStructuralLoadOutPort;
        }
        part def Warhead {
            attribute functionalCategory : String = "energetic_payload";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_energetic_payload";
            attribute realizedActions : String = "Act_Warhead_1, Act_Warhead_2, Act_Warhead_3, Act_Warhead_4, Act_Warhead_5, Act_Warhead_6, Act_Warhead_7, Act_Warhead_8, Act_Warhead_9";
            attribute boundConstraints : String = "INV_DOC05_04";
            attribute interactionBindings : String = "INT_08_LethalPyrotechnicInitiationTrain";
            attribute maxMassKg : Real = 5.0;
            attribute warheadVariantOptions : String = "Thermobaric; High explosive (HE); High explosive anti-tank (HEAT); partner-selected payloads";
            attribute assemblyLengthM : Real = 0.173;
            attribute holderClampSpanM : Real = 0.071;
            attribute lowerStepOffsetM : Real = 0.041;
            attribute centerOfMassCtqFromShoulderM : Real = 0.03057;
            attribute centerOfMassCtqToleranceM : Real = 0.001;
            attribute assemblyMassWithoutHolderKg : Real = 4.98;
            attribute assemblyMassToleranceKg : Real = 0.02;
            attribute holderContactDatumSpec : String = "RED FACE TO TOUCH HOLDER WHEN MOUNTED; ALIGN INDICATED SURFACES";
            port in energeticTriggerIn : MechanicalStructuralLoadInPort;
            satisfy requirement REQ_INV_DOC02_14;
            satisfy requirement REQ_INV_DOC05_03;
        }
        part def ExternalInterfaceBoardUsbEth {
            attribute functionalCategory : String = "external_service_interface";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_external_service_interface";
            attribute realizedActions : String = "Act_ExternalInterfaceBoardUsbEth_1";
            port inout ethPort : EthernetIpInoutPort;
            port inout usbPort : UsbBusInoutPort;
            port inout esdChassisBond : MechanicalStructuralLoadInoutPort;
        }
        part def UavRbfKey {
            attribute functionalCategory : String = "safety_interlock_key";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_safety_interlock_key";
            attribute realizedActions : String = "Act_UavRbfKey_1, Act_UavRbfKey_2, Act_UavRbfKey_3, Act_UavRbfKey_4";
            attribute boundStateMachines : String = "State_INV_DOC05_13";
            attribute interactionBindings : String = "INT_01_SystemPowerOnAndRbfSequence";
            attribute rbfSequenceLabel : String = "2 UAV POWER R.B.F.";
            attribute connectorModel : String = "XT60E-F Amass";
            port out rbfInterlockOut : DiscreteGpioOutPort;
            satisfy requirement REQ_GAP_DOC02_06;
        }
        part def EsadRbfKey {
            attribute functionalCategory : String = "safety_interlock_key";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_safety_interlock_key";
            attribute realizedActions : String = "Act_EsadRbfKey_1, Act_EsadRbfKey_2, Act_EsadRbfKey_3, Act_EsadRbfKey_4";
            attribute boundProtocolItems : String = "ITEM_PROTO_DOC05_ESAD_RBF3_INTERLOCK";
            attribute interactionBindings : String = "INT_01_SystemPowerOnAndRbfSequence";
            attribute rbfSequenceLabel : String = "3 ESAD R.B.F.";
            attribute receptacleConnectorModel : String = "XT60E-F Amass";
            port out rbfInterlockOut : DiscreteGpioOutPort;
            satisfy requirement REQ_PROTO_DOC05_ESAD_RBF3_INTERLOCK;
            satisfy requirement REQ_GAP_DOC06_04;
        }
        part def EsadUmbilicalLoop {
            attribute functionalCategory : String = "safety_interlock_key";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_safety_interlock_key";
            attribute realizedActions : String = "Act_EsadUmbilicalLoop_1";
            attribute boundProtocolItems : String = "ITEM_PROTO_ESAD_UMBILICAL_CONTINUITY";
            attribute maxClosedLoopResistanceOhm : Real = 0.5;
            attribute senseCurrentA : Real = 0.02;
            port inout umbilicalLoop : UmbilicalContinuityLoopInoutPort;
            satisfy requirement REQ_PROTO_ESAD_UMBILICAL_CONTINUITY;
        }
        part def EsdGroundingPoint {
            attribute functionalCategory : String = "esd_grounding_fixture";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_esd_grounding_fixture";
            attribute realizedActions : String = "Act_EsdGroundingPoint_1";
            attribute labelMarkings : String = "EARTH POINT / GROUNDING (yellow circular label with ESD triangle 1)";
            port inout esdChassisBond : MechanicalStructuralLoadInoutPort;
            satisfy requirement REQ_INV_DOC05_02;
            satisfy requirement REQ_GAP_DOC05_09;
        }
        part def UavUmbilicalAccessPort {
            attribute functionalCategory : String = "external_service_interface";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_external_service_interface";
            attribute realizedActions : String = "Act_UavUmbilicalAccessPort_1";
            port inout umbilicalLoop : UmbilicalContinuityLoopInoutPort;
            satisfy requirement REQ_GAP_DOC05_04;
        }
        part def PitotTubeRbfCover {
            attribute functionalCategory : String = "safety_interlock_key";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_safety_interlock_key";
            attribute realizedActions : String = "Act_PitotTubeRbfCover_1";
            port out coverMechanicalOut : MechanicalStructuralLoadOutPort;
        }
        part def SensorProtectiveRbfCover {
            attribute functionalCategory : String = "safety_interlock_key";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_safety_interlock_key";
            attribute realizedActions : String = "Act_SensorProtectiveRbfCover_1";
            port out coverMechanicalOut : MechanicalStructuralLoadOutPort;
        }
        part def GimbalSecuringRbfStrap {
            attribute functionalCategory : String = "safety_interlock_key";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_safety_interlock_key";
            attribute realizedActions : String = "Act_GimbalSecuringRbfStrap_1";
            port out restraintMechanicalOut : MechanicalStructuralLoadOutPort;
        }
        part def UavConnectionHookSet {
            attribute functionalCategory : String = "mechanical_launch_structure";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_mechanical_launch_structure";
            attribute realizedActions : String = "Act_UavConnectionHookSet_1, Act_UavConnectionHookSet_2, Act_UavConnectionHookSet_3, Act_UavConnectionHookSet_4";
            attribute optionALeverOuterSpanM : Real = 0.186;
            attribute optionALeverInnerSpanM : Real = 0.178;
            attribute optionABaseSpanM : Real = 0.206;
            attribute optionAThicknessM : Real = 0.008;
            attribute optionAMassKg : Real = 0.004;
            attribute optionASurfaceAreaM2 : Real = 0.00111753;
            attribute optionAMaterialAndCoating : String = "Aluminum 6061-T6, Natural anode";
            attribute optionBPlateLengthM : Real = 0.225;
            attribute optionBHoleSpacingM : Real = 0.155;
            attribute optionBThicknessM : Real = 0.008;
            attribute optionCPinLongitudinalSpacingM : Real = 0.32;
            attribute optionCLeverOuterSpanM : Real = 0.156;
            attribute optionCLeverInnerSpanM : Real = 0.14;
            attribute optionCPinTotalLengthM : Real = 0.0335;
            attribute optionCPinHeadDiameterM : Real = 0.013;
            attribute optionCPinNeckDiameterM : Real = 0.008;
            attribute optionCSurfaceAreaM2 : Real = 0.00139016;
            attribute optionCMaterialAndCoating : String = "AISI 304, Natural anode";
            port in carriageLaunchIn : MechanicalStructuralLoadInPort;
            port in stowageCaseIn : MechanicalStructuralLoadInPort;
            satisfy requirement REQ_GAP_DOC04_04;
        }
        part def BatteryMakita18VBl1860B {
            attribute functionalCategory : String = "energy_storage";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "self_energy_source";
            attribute capabilityRole : String = "Cap_energy_storage";
            attribute realizedActions : String = "Act_BatteryMakita18VBl1860B_1, Act_BatteryMakita18VBl1860B_2, Act_BatteryMakita18VBl1860B_3";
            attribute nominalVoltageV : Real = 18.0;
            attribute capacityC : Real = 21600.0;
            attribute partNumber : String = "BL1860B";
            attribute kitBatteryQuantity : Integer = 2;
            attribute chargeTimeDc18RcS : Real = 3300.0;
            attribute chargeTimeDc18SdS : Real = 7800.0;
            attribute chargingTempMinK : Real = 283.15;
            attribute chargingTempMaxK : Real = 313.15;
            attribute unClassification : String = "UN 3481";
            port out dcPowerOut : DcPowerOutPort;
        }
        part def Pl40CompressorController {
            attribute functionalCategory : String = "primary_controller";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_primary_controller";
            attribute realizedActions : String = "Act_Pl40CompressorController_1, Act_Pl40CompressorController_2, Act_Pl40CompressorController_3, Act_Pl40CompressorController_4, Act_Pl40CompressorController_5, Act_Pl40CompressorController_6";
            attribute boundStateMachines : String = "FSM_PL40_COMPRESSOR_CONTROLLER";
            attribute boundConstraints : String = "INV_DOC04_11";
            attribute boundProtocolItems : String = "ITEM_PROTO_PL40_CONTROLLER_HMI";
            attribute pressureHysteresisPa : Real = 5000.0;
            attribute maxSetPressurePa : Real = 1400000.0;
            attribute maxPressurizationDurationS : Real = 480.0;
            attribute overDischargeCutoffVoltageV : Real = 14.5;
            attribute overDischargeRecoveryVoltageV : Real = 16.0;
            attribute overDischargeRecoveryDelayS : Real = 5.0;
            port in dcPowerIn : DcPowerInPort;
            port out compressorMotorPowerOut : DcPowerOutPort;
            port in tankPressureSenseIn : PneumaticPressureInPort;
            satisfy requirement REQ_PROTO_PL40_CONTROLLER_HMI;
            satisfy requirement REQ_GAP_DOC04_05;
        }
        part def Pl40AirCompressorPump {
            attribute functionalCategory : String = "pneumatic_compressor_unit";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_pneumatic_compressor_unit";
            attribute realizedActions : String = "Act_Pl40AirCompressorPump_1, Act_Pl40AirCompressorPump_2";
            attribute maxOutputPressurePa : Real = 1400000.0;
            port in dcPowerIn : DcPowerInPort;
            port out compressedAirOut : PneumaticPressureOutPort;
        }
        part def Pl40MainAirReservoir {
            attribute functionalCategory : String = "pneumatic_compressor_unit";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_pneumatic_compressor_unit";
            attribute realizedActions : String = "Act_Pl40MainAirReservoir_1, Act_Pl40MainAirReservoir_2, Act_Pl40MainAirReservoir_3, Act_Pl40MainAirReservoir_4, Act_Pl40MainAirReservoir_5, Act_Pl40MainAirReservoir_6";
            attribute boundProtocolItems : String = "ITEM_PROTO_PL40_LAUNCH_PRESSURE_SCHEDULE";
            attribute minSchedulePressurePa : Real = 500000.0;
            attribute maxInternalWorkingPressurePa : Real = 1400000.0;
            attribute maxAuxiliaryWorkingPressurePa : Real = 1600000.0;
            attribute externalFillPortSpec : String = "DIN 8 mm PCP";
            attribute compressorCaseMassKg : Real = 25.0;
            attribute compressorCaseDimensionsM : String = "0.36 x 0.36 x 0.68";
            attribute launchPressureMinPa : Real = 1300000.0;
            attribute launchPressureMaxPa : Real = 1400000.0;
            port in compressorChargeIn : PneumaticPressureInPort;
            port in auxFillIn : PneumaticPressureInPort;
            port out pressureSenseOut : PneumaticPressureOutPort;
            port out reservoirOutletOut : PneumaticPressureOutPort;
            satisfy requirement REQ_PROTO_PL40_LAUNCH_PRESSURE_SCHEDULE;
        }
        part def Pl40MainReservoirOutletValve {
            attribute functionalCategory : String = "pneumatic_compressor_unit";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_pneumatic_compressor_unit";
            attribute realizedActions : String = "Act_Pl40MainReservoirOutletValve_1, Act_Pl40MainReservoirOutletValve_2";
            attribute boundStateMachines : String = "State_INV_DOC04_05";
            port in pneumaticIn : PneumaticPressureInPort;
            port out pneumaticOut : PneumaticPressureOutPort;
        }
        part def Pl40RemoteControlledReleaseValve {
            attribute functionalCategory : String = "pneumatic_compressor_unit";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_pneumatic_compressor_unit";
            attribute realizedActions : String = "Act_Pl40RemoteControlledReleaseValve_1, Act_Pl40RemoteControlledReleaseValve_2, Act_Pl40RemoteControlledReleaseValve_3, Act_Pl40RemoteControlledReleaseValve_4";
            port in pneumaticIn : PneumaticPressureInPort;
            port in solenoidTriggerIn : DcPowerInPort;
            port out tankConnectorOut : PneumaticPressureOutPort;
        }
        part def Pl40AuxiliaryPressureSource {
            attribute functionalCategory : String = "pneumatic_compressor_unit";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_pneumatic_compressor_unit";
            attribute realizedActions : String = "Act_Pl40AuxiliaryPressureSource_1";
            attribute boundConstraints : String = "ConstraintExcludeOptionalGcsAndMaintenanceInProduction";
            attribute maxAuxiliaryPressurePa : Real = 1600000.0;
            port out pneumaticOut : PneumaticPressureOutPort;
            satisfy requirement REQ_GAP_DOC04_03;
        }
        part def Pl40TriggerHandle {
            attribute functionalCategory : String = "operator_trigger_unit";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_operator_trigger_unit";
            attribute realizedActions : String = "Act_Pl40TriggerHandle_1, Act_Pl40TriggerHandle_2, Act_Pl40TriggerHandle_3, Act_Pl40TriggerHandle_4";
            attribute boundStateMachines : String = "State_INV_DOC04_12";
            attribute boundProtocolItems : String = "ITEM_PROTO_PL40_REMOTE_TRIGGER";
            attribute interactionBindings : String = "INT_03_Pl40PneumaticCatapultLaunch";
            attribute minSwitchHoldDurationS : Real = 2.0;
            attribute simultaneousSwitchCount : Integer = 2;
            port in dcPowerIn : DcPowerInPort;
            port out solenoidTriggerOut : DcPowerOutPort;
            satisfy requirement REQ_PROTO_PL40_REMOTE_TRIGGER;
            satisfy requirement REQ_GAP_DOC04_02;
        }
        part def Pl40FrontRailSection {
            attribute functionalCategory : String = "mechanical_launch_structure";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_mechanical_launch_structure";
            attribute realizedActions : String = "Act_Pl40FrontRailSection_1, Act_Pl40FrontRailSection_2, Act_Pl40FrontRailSection_3, Act_Pl40FrontRailSection_4, Act_Pl40FrontRailSection_5";
            attribute frontHeightM : Real = 1.116;
            attribute frontLegStanceWidthM : Real = 0.602;
            attribute launchElevationAngleRad : Real = 0.20944;
            attribute rollerBlockBoltCount : Integer = 4;
            attribute launcherFrontHeightCadM : Real = 1.095;
            port in pneumaticInletIn : PneumaticPressureInPort;
            port out pneumaticCylinderOut : PneumaticPressureOutPort;
            port out ropeDriveOut : MechanicalStructuralLoadOutPort;
        }
        part def Pl40MiddleRailSection {
            attribute functionalCategory : String = "mechanical_launch_structure";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_mechanical_launch_structure";
            attribute realizedActions : String = "Act_Pl40MiddleRailSection_1, Act_Pl40MiddleRailSection_2";
            attribute disassembledRailSectionLengthM : Real = 1.28;
            port in pneumaticIn : PneumaticPressureInPort;
            port out pneumaticOut : PneumaticPressureOutPort;
        }
        part def Pl40RearRailSection {
            attribute functionalCategory : String = "mechanical_launch_structure";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_mechanical_launch_structure";
            attribute realizedActions : String = "Act_Pl40RearRailSection_1, Act_Pl40RearRailSection_2, Act_Pl40RearRailSection_3, Act_Pl40RearRailSection_4";
            attribute boundConstraints : String = "INV_DOC04_13";
            attribute assembledRailLengthNominalM : Real = 5.0;
            attribute assembledRailLengthCadM : Real = 4.938;
            attribute disassembledRailLengthM : Real = 1.28;
            attribute launcherCaseMassKg : Real = 43.0;
            attribute launcherCaseDimensionsM : String = "1.480 x 0.440 x 0.170";
            attribute totalCatapultSetMassKg : Real = 68.0;
            attribute setupTimeS : Real = 300.0;
            attribute workingTempMinK : Real = 253.15;
            attribute workingTempMaxK : Real = 323.15;
            attribute launcherModel : String = "PL-40";
            attribute overallSystemLengthCadM : Real = 5.29;
            attribute launcherFrameLengthCadM : Real = 4.844;
            port in pneumaticIn : PneumaticPressureInPort;
            port in groundAnchorIn : MechanicalStructuralLoadInPort;
            port out railGuideOut : MechanicalStructuralLoadOutPort;
            satisfy requirement REQ_GAP_DOC04_01;
        }
        part def Pl40GroundAnchorAssembly {
            attribute functionalCategory : String = "mechanical_launch_structure";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_mechanical_launch_structure";
            attribute realizedActions : String = "Act_Pl40GroundAnchorAssembly_1, Act_Pl40GroundAnchorAssembly_2, Act_Pl40GroundAnchorAssembly_3";
            attribute kitGroundAnchorCount : Integer = 3;
            port out anchorRetentionOut : MechanicalStructuralLoadOutPort;
            satisfy requirement REQ_INV_DOC04_02;
            satisfy requirement REQ_GAP_DOC04_07;
        }
        part def Pl40PullingRope {
            attribute functionalCategory : String = "mechanical_launch_structure";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_mechanical_launch_structure";
            attribute realizedActions : String = "Act_Pl40PullingRope_1, Act_Pl40PullingRope_2";
            attribute boundConstraints : String = "INV_DOC04_08";
            attribute replacementIntervalLaunches : Integer = 100;
            port in pistonPullIn : MechanicalStructuralLoadInPort;
            port out carriagePullOut : MechanicalStructuralLoadOutPort;
        }
        part def Pl40CarriageSafetyLockPin {
            attribute functionalCategory : String = "safety_interlock_key";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_safety_interlock_key";
            attribute realizedActions : String = "Act_Pl40CarriageSafetyLockPin_1, Act_Pl40CarriageSafetyLockPin_2";
            attribute boundStateMachines : String = "State_INV_DOC04_04";
            port out safetyLockInterlockOut : MechanicalStructuralLoadOutPort;
            satisfy requirement REQ_GAP_DOC06_14;
        }
        part def Pl40LaunchCarriage {
            attribute functionalCategory : String = "mechanical_launch_structure";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_mechanical_launch_structure";
            attribute realizedActions : String = "Act_Pl40LaunchCarriage_1, Act_Pl40LaunchCarriage_2, Act_Pl40LaunchCarriage_3, Act_Pl40LaunchCarriage_4";
            attribute boundConstraints : String = "INV_DOC04_06, INV_DOC04_07, INV_DOC04_09";
            attribute interactionBindings : String = "INT_03_Pl40PneumaticCatapultLaunch";
            attribute maxPayloadMassKg : Real = 30.0;
            attribute maxAllowedLaunchVelocityMPerS : Real = 25.0;
            attribute supportsPullerAircraft : Boolean = true;
            attribute supportsPusherAircraft : Boolean = true;
            attribute ropeAttachmentSlotCount : Integer = 3;
            attribute wheelBearingCount : Integer = 4;
            attribute bearingReplacementLaunches : Integer = 100;
            attribute bearingRemovalHeatTempK : Real = 523.15;
            attribute carriageOverallLengthM : Real = 0.271;
            attribute carriageOverallHeightM : Real = 0.2325;
            attribute leverLongitudinalSpacingM : Real = 0.2085;
            attribute leverOuterSpanM : Real = 0.156;
            attribute leverInnerSpanM : Real = 0.14;
            attribute leverArmTipWidthM : Real = 0.008;
            attribute leverArmLateralExtentM : Real = 0.03;
            attribute carriageWheelTrackWidthM : Real = 0.1352;
            attribute propellerSafezoneFrontHeightM : Real = 0.1555;
            attribute propellerSafezoneRearHeightM : Real = 0.145;
            attribute allowedCgEnvelopeLengthM : Real = 0.2;
            attribute allowedCgEnvelopeHeightM : Real = 0.1;
            port in railGuideIn : MechanicalStructuralLoadInPort;
            port in ropePullIn : MechanicalStructuralLoadInPort;
            port in safetyLockPinIn : MechanicalStructuralLoadInPort;
            port out uavThrustOut : MechanicalStructuralLoadOutPort;
            satisfy requirement REQ_INV_DOC04_10;
        }
        part def PanasonicFzG2Tablet {
            attribute functionalCategory : String = "operator_console";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_operator_console";
            attribute realizedActions : String = "Act_PanasonicFzG2Tablet_1, Act_PanasonicFzG2Tablet_2, Act_PanasonicFzG2Tablet_3, Act_PanasonicFzG2Tablet_4, Act_PanasonicFzG2Tablet_5, Act_PanasonicFzG2Tablet_6, Act_PanasonicFzG2Tablet_7, Act_PanasonicFzG2Tablet_8, Act_PanasonicFzG2Tablet_9, Act_PanasonicFzG2Tablet_10, Act_PanasonicFzG2Tablet_11, Act_PanasonicFzG2Tablet_12, Act_PanasonicFzG2Tablet_13";
            attribute boundStateMachines : String = "FSM_SWARMC2_APP_AND_AUTH";
            attribute boundProtocolItems : String = "ITEM_PROTO_DOC02_BMS_INTEGRATION, ITEM_PROTO_DOC05_SWARMC2_PREFLIGHT, ITEM_PROTO_SWARMC2_SYNCHRO_MATRIX";
            attribute interactionBindings : String = "INT_05_GcsUavRfC2AndVideoLink";
            attribute hardwareType : String = "Rugged tablet";
            attribute operatingSystem : String = "Windows 11";
            attribute missionSoftware : String = "UDS SwarmC2";
            attribute supportedBmsSystems : String = "SitaWare HQ, ATAK, DELTA";
            attribute minPasswordLengthChars : Integer = 8;
            port in dcPowerIn : DcPowerInPort;
            port inout ethPort : EthernetIpInoutPort;
            port inout usbHostPort : UsbBusInoutPort;
            satisfy requirement REQ_INV_DOC02_15;
            satisfy requirement REQ_INV_DOC05_14;
            satisfy requirement REQ_INV_DOC06_18;
            satisfy requirement REQ_PROTO_DOC02_BMS_INTEGRATION;
            satisfy requirement REQ_PROTO_DOC05_SWARMC2_PREFLIGHT;
            satisfy requirement REQ_PROTO_SWARMC2_SYNCHRO_MATRIX;
            satisfy requirement REQ_GAP_DOC05_08;
        }
        part def PanasonicFzG2TabletBattery {
            attribute functionalCategory : String = "energy_storage";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "self_energy_source";
            attribute capabilityRole : String = "Cap_energy_storage";
            attribute realizedActions : String = "Act_PanasonicFzG2TabletBattery_1";
            port out dcPowerOut : DcPowerOutPort;
            port in dcChargeIn : DcPowerInPort;
        }
        part def OptionalUsbGameController {
            attribute functionalCategory : String = "operator_console";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "in_band_signal_or_composite_cable";
            attribute capabilityRole : String = "Cap_operator_console";
            attribute realizedActions : String = "Act_OptionalUsbGameController_1";
            port inout usbPort : UsbBusInoutPort;
        }
        part def GcsBatteryPack {
            attribute functionalCategory : String = "energy_storage";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "self_energy_source";
            attribute capabilityRole : String = "Cap_energy_storage";
            attribute realizedActions : String = "Act_GcsBatteryPack_1";
            attribute illustrativeUiGcsBattery1VoltageV : Real = 20.0;
            attribute illustrativeUiGcsBattery2VoltageV : Real = 16.0;
            port out dcPowerOut : DcPowerOutPort;
            port in dcChargeIn : DcPowerInPort;
        }
        part def GcsGroundBox {
            attribute functionalCategory : String = "companion_computer";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_companion_computer";
            attribute realizedActions : String = "Act_GcsGroundBox_1, Act_GcsGroundBox_2, Act_GcsGroundBox_3";
            attribute boundProtocolItems : String = "ITEM_PROTO_DOC02_GCS_FIBER_LINK, ITEM_PROTO_SWARMC2_AUTH_AND_TACTICAL_SYNC";
            attribute interactionBindings : String = "INT_05_GcsUavRfC2AndVideoLink";
            attribute fiberOpticSpoolLengthM : Real = 200.0;
            attribute gcsEthernetCableLengthM : Real = 15.0;
            attribute gcsOduLanCableLengthM : Real = 3.0;
            attribute gcsOduPowerCableLengthM : Real = 3.0;
            port in dcPowerIn : DcPowerInPort;
            port inout ethPort : EthernetIpInoutPort;
            port inout fiberPort : OpticalFiberInoutPort;
            satisfy requirement REQ_PROTO_DOC02_GCS_FIBER_LINK;
            satisfy requirement REQ_PROTO_SWARMC2_AUTH_AND_TACTICAL_SYNC;
            satisfy requirement REQ_GAP_DOC02_08;
        }
        part def GcsRadioBox {
            attribute functionalCategory : String = "rf_transceiver";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_rf_transceiver";
            attribute realizedActions : String = "Act_GcsRadioBox_1, Act_GcsRadioBox_2, Act_GcsRadioBox_3";
            attribute boundConstraints : String = "INV_DOC06_16";
            attribute interactionBindings : String = "INT_05_GcsUavRfC2AndVideoLink";
            attribute configuredGroundTxPowerW : Real = 2.0;
            attribute observedFrequencyHz : Real = 4910000000.0;
            attribute antennaJumperCableLengthM : Real = 0.25;
            attribute maxInitialLinkAcquireS : Real = 120.0;
            port in dcPowerIn : DcPowerInPort;
            port out dcPowerOut : DcPowerOutPort;
            port inout ethPort : EthernetIpInoutPort;
            port inout rfCoaxPort : RfCoaxInoutPort;
        }
        part def GcsAntennaRotator {
            attribute functionalCategory : String = "antenna_positioner";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_antenna_positioner";
            attribute realizedActions : String = "Act_GcsAntennaRotator_1, Act_GcsAntennaRotator_2, Act_GcsAntennaRotator_3, Act_GcsAntennaRotator_4, Act_GcsAntennaRotator_5";
            attribute boundProtocolItems : String = "ITEM_PROTO_SWARMC2_GCS_ROTATOR_LINK";
            attribute interactionBindings : String = "INT_05_GcsUavRfC2AndVideoLink";
            attribute antennaTypeConfiguration : String = "Directional and omnidirectional";
            attribute hasAutonomousTrackingRotator : Boolean = true;
            attribute fineAdjustStepRad : Real = 0.008727;
            port in dcPowerIn : DcPowerInPort;
            port inout ethPort : EthernetIpInoutPort;
            port in tripodMountIn : MechanicalStructuralLoadInPort;
            port inout fiberPort : OpticalFiberInoutPort;
            satisfy requirement REQ_INV_DOC02_16;
            satisfy requirement REQ_INV_DOC06_17;
            satisfy requirement REQ_PROTO_SWARMC2_GCS_ROTATOR_LINK;
        }
        part def MarsDirectionalAntenna23Dbi {
            attribute functionalCategory : String = "passive_antenna";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_passive_antenna";
            attribute realizedActions : String = "Act_MarsDirectionalAntenna23Dbi_1";
            attribute antennaGainDbi : Real = 23.0;
            port inout rfCoaxPort : RfCoaxInoutPort;
            port inout rfOverTheAir : RfOverTheAirInoutPort;
        }
        part def GitzoTripodWithHead {
            attribute functionalCategory : String = "mechanical_launch_structure";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_mechanical_launch_structure";
            attribute realizedActions : String = "Act_GitzoTripodWithHead_1";
            port out rotatorMountOut : MechanicalStructuralLoadOutPort;
            port in stowageCaseIn : MechanicalStructuralLoadInPort;
        }
        part def GcsOmniAntenna {
            attribute functionalCategory : String = "passive_antenna";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_passive_antenna";
            attribute realizedActions : String = "Act_GcsOmniAntenna_1";
            port inout rfCoaxPort : RfCoaxInoutPort;
            port inout rfOverTheAir : RfOverTheAirInoutPort;
            satisfy requirement REQ_GAP_DOC06_07;
        }
        part def TabletBatteryChargingStation {
            attribute functionalCategory : String = "power_distribution_regulator";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_power_distribution_regulator";
            attribute realizedActions : String = "Act_TabletBatteryChargingStation_1";
            port out dcPowerOut : DcPowerOutPort;
        }
        part def GcsAndUavBatteryCharger {
            attribute functionalCategory : String = "power_distribution_regulator";
            attribute requiresElectricalPower : Boolean = true;
            attribute powerFeedMode : String = "dedicated_power_port";
            attribute capabilityRole : String = "Cap_power_distribution_regulator";
            attribute realizedActions : String = "Act_GcsAndUavBatteryCharger_1";
            port out dcPowerOut : DcPowerOutPort;
        }
        part def FieldMaintenanceKit {
            attribute functionalCategory : String = "external_service_interface";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_external_service_interface";
            attribute realizedActions : String = "Act_FieldMaintenanceKit_1, Act_FieldMaintenanceKit_2";
            attribute boundConstraints : String = "ConstraintExcludeOptionalGcsAndMaintenanceInProduction";
            attribute spareAttachmentBoltsCount : Integer = 30;
            attribute serviceToolSetCount : Integer = 1;
            attribute sparePropellerBladesCount : Integer = 2;
            attribute sparePropellerAssemblyCount : Integer = 1;
            port out spareHardwareOut : MechanicalStructuralLoadOutPort;
            port in stowageCaseIn : MechanicalStructuralLoadInPort;
            satisfy requirement REQ_GAP_DOC06_11;
        }
        part def TransportationStorageCase {
            attribute functionalCategory : String = "mechanical_launch_structure";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_mechanical_launch_structure";
            attribute realizedActions : String = "Act_TransportationStorageCase_1";
            port out stowedHardwareOut : MechanicalStructuralLoadOutPort;
        }
        part def TubeLauncher {
            attribute functionalCategory : String = "mechanical_launch_structure";
            attribute requiresElectricalPower : Boolean = false;
            attribute powerFeedMode : String = "none_passive_or_mechanical";
            attribute capabilityRole : String = "Cap_mechanical_launch_structure";
            attribute realizedActions : String = "Act_TubeLauncher_1";
            port out uavThrustOut : MechanicalStructuralLoadOutPort;
        }
    }
    package SystemArchitecturePackage {
        part def TubeLauncherOption {
            attribute boundaryPlacement : String = "external_segment";
            attribute populatedInProduction : Boolean = false;
            attribute boundConstraints : String = "ConstraintExcludeTubeLauncherInProduction";
            port out bh_WIRE_DOC06_028_from : MechanicalStructuralLoadOutPort;
            satisfy requirement REQ_GAP_DOC06_12;
            connection def CONN_WIRE_DOC06_028_UP_1 {
                connect tubeLauncher.uavThrustOut to bh_WIRE_DOC06_028_from;
            }
            part tubeLauncher : TubeLauncher {
                attribute multiplicity : String = "0..1";
                attribute populatedInProduction : Boolean = false;
            }
        }
        part def GroundControlStation {
            attribute boundaryPlacement : String = "external_segment";
            attribute populatedInProduction : Boolean = true;
            port inout bh_WIRE_DOC06_004_from : RfOverTheAirInoutPort;
            port inout bh_WIRE_DOC06_005_from : RfOverTheAirInoutPort;
            port inout bh_WIRE_DOC06_017_from : RfOverTheAirInoutPort;
            port inout bh_WIRE_DOC06_018_from : RfOverTheAirInoutPort;
            port in bh_WIRE_DOC06_021_to : DcPowerInPort;
            port in bh_WIRE_DOC06_022_to : DcPowerInPort;
            port in bh_WIRE_DOC06_026_to : MechanicalStructuralLoadInPort;
            satisfy requirement REQ_INV_DOC05_12;
            satisfy requirement REQ_GAP_DOC02_07;
            satisfy requirement REQ_GAP_MERGE_03;
            connection def CONN_WIRE_DOC02_001 {
                connect gcsGroundBox.fiberPort to gcsRotator.fiberPort;
            }
            connection def CONN_WIRE_DOC06_001 {
                connect gcsTabletBattery1.dcPowerOut to gcsTablet1.dcPowerIn;
            }
            connection def CONN_WIRE_DOC06_002 {
                connect gcsTabletBattery2.dcPowerOut to gcsTablet2.dcPowerIn;
            }
            connection def CONN_WIRE_DOC06_003 {
                connect gcsTablet1.usbHostPort to optionalUsbGameController.usbPort;
            }
            connection def CONN_WIRE_DOC06_004_UP_1 {
                connect marsDirectionalAntenna.rfOverTheAir to bh_WIRE_DOC06_004_from;
            }
            connection def CONN_WIRE_DOC06_005_UP_1 {
                connect gcsOmniAntenna1.rfOverTheAir to bh_WIRE_DOC06_005_from;
            }
            connection def CONN_WIRE_DOC06_006 {
                connect gcsBattery1.dcPowerOut to gcsGroundBox.dcPowerIn;
            }
            connection def CONN_WIRE_DOC06_007 {
                connect gcsBattery2.dcPowerOut to gcsRadioBox.dcPowerIn;
            }
            connection def CONN_WIRE_DOC06_008 {
                connect gcsRadioBox.dcPowerOut to gcsRotator.dcPowerIn;
            }
            connection def CONN_WIRE_DOC06_009 {
                connect gcsRadioBox.ethPort to gcsRotator.ethPort;
            }
            connection def CONN_WIRE_DOC06_010 {
                connect gcsGroundBox.ethPort to gcsRadioBox.ethPort;
            }
            connection def CONN_WIRE_DOC06_011 {
                connect gcsTablet1.ethPort to gcsGroundBox.ethPort;
            }
            connection def CONN_WIRE_DOC06_012 {
                connect gcsTablet2.ethPort to gcsGroundBox.ethPort;
            }
            connection def CONN_WIRE_DOC06_013 {
                connect gcsTripod.rotatorMountOut to gcsRotator.tripodMountIn;
            }
            connection def CONN_WIRE_DOC06_014 {
                connect gcsRadioBox.rfCoaxPort to marsDirectionalAntenna.rfCoaxPort;
            }
            connection def CONN_WIRE_DOC06_015 {
                connect gcsRadioBox.rfCoaxPort to gcsOmniAntenna1.rfCoaxPort;
            }
            connection def CONN_WIRE_DOC06_016 {
                connect gcsRadioBox.rfCoaxPort to gcsOmniAntenna2.rfCoaxPort;
            }
            connection def CONN_WIRE_DOC06_017_UP_1 {
                connect gcsOmniAntenna2.rfOverTheAir to bh_WIRE_DOC06_017_from;
            }
            connection def CONN_WIRE_DOC06_018_UP_1 {
                connect marsDirectionalAntenna.rfOverTheAir to bh_WIRE_DOC06_018_from;
            }
            connection def CONN_WIRE_DOC06_019 {
                connect tabletBatteryCharger.dcPowerOut to gcsTabletBatterySpare1.dcChargeIn;
            }
            connection def CONN_WIRE_DOC06_020 {
                connect tabletBatteryCharger.dcPowerOut to gcsTabletBatterySpare2.dcChargeIn;
            }
            connection def CONN_WIRE_DOC06_021_DN_1 {
                connect bh_WIRE_DOC06_021_to to gcsBattery1.dcChargeIn;
            }
            connection def CONN_WIRE_DOC06_022_DN_1 {
                connect bh_WIRE_DOC06_022_to to gcsBattery2.dcChargeIn;
            }
            connection def CONN_WIRE_DOC06_026_DN_1 {
                connect bh_WIRE_DOC06_026_to to gcsTripod.stowageCaseIn;
            }
            part gcsTablet1 : PanasonicFzG2Tablet {
            }
            part gcsTablet2 : PanasonicFzG2Tablet {
            }
            part gcsTabletBattery1 : PanasonicFzG2TabletBattery {
            }
            part gcsTabletBattery2 : PanasonicFzG2TabletBattery {
            }
            part optionalUsbGameController : OptionalUsbGameController {
                attribute multiplicity : String = "0..1";
                attribute populatedInProduction : Boolean = false;
            }
            part gcsBattery1 : GcsBatteryPack {
            }
            part gcsBattery2 : GcsBatteryPack {
            }
            part gcsGroundBox : GcsGroundBox {
            }
            part gcsRadioBox : GcsRadioBox {
            }
            part gcsRotator : GcsAntennaRotator {
            }
            part marsDirectionalAntenna : MarsDirectionalAntenna23Dbi {
            }
            part gcsTripod : GitzoTripodWithHead {
            }
            part gcsOmniAntenna1 : GcsOmniAntenna {
            }
            part gcsOmniAntenna2 : GcsOmniAntenna {
            }
            part gcsTabletBatterySpare1 : PanasonicFzG2TabletBattery {
                attribute multiplicity : String = "0..1";
                attribute populatedInProduction : Boolean = false;
            }
            part gcsTabletBatterySpare2 : PanasonicFzG2TabletBattery {
                attribute multiplicity : String = "0..1";
                attribute populatedInProduction : Boolean = false;
            }
            part tabletBatteryCharger : TabletBatteryChargingStation {
                attribute multiplicity : String = "0..1";
                attribute populatedInProduction : Boolean = false;
            }
        }
        part def Pl40CompressorUnit {
            attribute boundaryPlacement : String = "external_segment";
            attribute populatedInProduction : Boolean = true;
            port in bh_WIRE_DOC04_004_to : DcPowerInPort;
            port in bh_WIRE_DOC04_006_to : PneumaticPressureInPort;
            port out bh_WIRE_DOC04_010_from : PneumaticPressureOutPort;
            connection def CONN_WIRE_DOC04_001 {
                connect batteryMain.dcPowerOut to compressorController.dcPowerIn;
            }
            connection def CONN_WIRE_DOC04_002 {
                connect compressorController.compressorMotorPowerOut to compressorPump.dcPowerIn;
            }
            connection def CONN_WIRE_DOC04_004_DN_1 {
                connect bh_WIRE_DOC04_004_to to remoteControlledReleaseValve.solenoidTriggerIn;
            }
            connection def CONN_WIRE_DOC04_005 {
                connect compressorPump.compressedAirOut to mainAirTank.compressorChargeIn;
            }
            connection def CONN_WIRE_DOC04_006_DN_1 {
                connect bh_WIRE_DOC04_006_to to mainAirTank.auxFillIn;
            }
            connection def CONN_WIRE_DOC04_007 {
                connect mainAirTank.pressureSenseOut to compressorController.tankPressureSenseIn;
            }
            connection def CONN_WIRE_DOC04_008 {
                connect mainAirTank.reservoirOutletOut to mainReservoirOutletValve.pneumaticIn;
            }
            connection def CONN_WIRE_DOC04_009 {
                connect mainReservoirOutletValve.pneumaticOut to remoteControlledReleaseValve.pneumaticIn;
            }
            connection def CONN_WIRE_DOC04_010_UP_1 {
                connect remoteControlledReleaseValve.tankConnectorOut to bh_WIRE_DOC04_010_from;
            }
            part batteryMain : BatteryMakita18VBl1860B {
                attribute slotAssignment : String = "Main battery slot (9) on compressor unit";
            }
            part compressorController : Pl40CompressorController {
            }
            part compressorPump : Pl40AirCompressorPump {
            }
            part mainAirTank : Pl40MainAirReservoir {
            }
            part mainReservoirOutletValve : Pl40MainReservoirOutletValve {
            }
            part remoteControlledReleaseValve : Pl40RemoteControlledReleaseValve {
            }
        }
        part def Pl40LauncherRailAssembly {
            attribute boundaryPlacement : String = "external_segment";
            attribute populatedInProduction : Boolean = true;
            port in bh_WIRE_DOC04_010_to : PneumaticPressureInPort;
            port out bh_WIRE_DOC04_018_from : MechanicalStructuralLoadOutPort;
            satisfy requirement REQ_INV_DOC05_11;
            connection def CONN_WIRE_DOC04_010_DN_1 {
                connect bh_WIRE_DOC04_010_to to frontRail.pneumaticInletIn;
            }
            connection def CONN_WIRE_DOC04_011 {
                connect frontRail.pneumaticCylinderOut to middleRail.pneumaticIn;
            }
            connection def CONN_WIRE_DOC04_012 {
                connect middleRail.pneumaticOut to rearRail.pneumaticIn;
            }
            connection def CONN_WIRE_DOC04_013 {
                connect groundAnchors.anchorRetentionOut to rearRail.groundAnchorIn;
            }
            connection def CONN_WIRE_DOC04_014 {
                connect rearRail.railGuideOut to carriage.railGuideIn;
            }
            connection def CONN_WIRE_DOC04_015 {
                connect frontRail.ropeDriveOut to pullingRope.pistonPullIn;
            }
            connection def CONN_WIRE_DOC04_016 {
                connect pullingRope.carriagePullOut to carriage.ropePullIn;
            }
            connection def CONN_WIRE_DOC04_017 {
                connect carriageSafetyLockPin.safetyLockInterlockOut to carriage.safetyLockPinIn;
            }
            connection def CONN_WIRE_DOC04_018_UP_1 {
                connect carriage.uavThrustOut to bh_WIRE_DOC04_018_from;
            }
            part frontRail : Pl40FrontRailSection {
                attribute railLabel : String = "RAIL 3 (SERIAL No 1000 example)";
            }
            part middleRail : Pl40MiddleRailSection {
                attribute railLabel : String = "RAIL 2";
            }
            part rearRail : Pl40RearRailSection {
                attribute railLabel : String = "RAIL 1 (SERIAL No 1000 example)";
            }
            part groundAnchors : Pl40GroundAnchorAssembly {
            }
            part pullingRope : Pl40PullingRope {
            }
            part carriageSafetyLockPin : Pl40CarriageSafetyLockPin {
            }
            part carriage : Pl40LaunchCarriage {
            }
        }
        part def PneumaticLauncherPl40 {
            attribute boundaryPlacement : String = "external_segment";
            attribute populatedInProduction : Boolean = true;
            attribute boundStateMachines : String = "FSM_PL40_LAUNCH_AND_INTERLOCK, FSM_DOC05_LAUNCH_SITE_AND_CATAPULT_PREP, State_INV_DOC06_19";
            attribute interactionBindings : String = "INT_03_Pl40PneumaticCatapultLaunch";
            port out bh_WIRE_DOC04_018_from : MechanicalStructuralLoadOutPort;
            satisfy requirement REQ_INV_DOC02_17;
            satisfy requirement REQ_INV_DOC04_01;
            satisfy requirement REQ_INV_DOC04_03;
            satisfy requirement REQ_INV_DOC05_16;
            satisfy requirement REQ_GAP_DOC04_06;
            satisfy requirement REQ_GAP_DOC05_06;
            satisfy requirement REQ_GAP_MERGE_04;
            connection def CONN_WIRE_DOC04_003 {
                connect batteryTrigger.dcPowerOut to triggerHandle.dcPowerIn;
            }
            connection def CONN_WIRE_DOC04_004_SPAN {
                connect triggerHandle.solenoidTriggerOut to compressorUnit.bh_WIRE_DOC04_004_to;
            }
            connection def CONN_WIRE_DOC04_006_SPAN {
                connect auxiliaryPressureSource.pneumaticOut to compressorUnit.bh_WIRE_DOC04_006_to;
            }
            connection def CONN_WIRE_DOC04_010_SPAN {
                connect compressorUnit.bh_WIRE_DOC04_010_from to launcherRailAssembly.bh_WIRE_DOC04_010_to;
            }
            connection def CONN_WIRE_DOC04_018_UP_2 {
                connect launcherRailAssembly.bh_WIRE_DOC04_018_from to bh_WIRE_DOC04_018_from;
            }
            part launcherRailAssembly : Pl40LauncherRailAssembly {
            }
            part compressorUnit : Pl40CompressorUnit {
            }
            part batteryTrigger : BatteryMakita18VBl1860B {
                attribute slotAssignment : String = "Connected to Trigger handle in Fig 5-2; stored in Spare battery slot (5) and rotated with Main battery after 1st and every 2 launches";
            }
            part auxiliaryPressureSource : Pl40AuxiliaryPressureSource {
                attribute multiplicity : String = "0..1";
                attribute populatedInProduction : Boolean = false;
            }
            part triggerHandle : Pl40TriggerHandle {
            }
        }
        part def LethalPackage {
            attribute boundaryPlacement : String = "interior";
            attribute populatedInProduction : Boolean = true;
            attribute interactionBindings : String = "INT_08_LethalPyrotechnicInitiationTrain";
            port in bh_WIRE_054_to : DcPowerInPort;
            port inout bh_WIRE_055_to : Rs485DifferentialInoutPort;
            port in bh_WIRE_056_to : DiscreteGpioInPort;
            port in bh_WIRE_057_to : DiscreteGpioInPort;
            port in bh_WIRE_DOC03_03_to : DiscreteGpioInPort;
            port inout bh_WIRE_DOC03_04_from : UmbilicalContinuityLoopInoutPort;
            port out bh_WIRE_DOC03_05_from : DcPowerOutPort;
            port inout bh_WIRE_DOC03_06_from : UartSerialInoutPort;
            port in bh_WIRE_DOC03_08_to : DiscreteGpioInPort;
            port inout bh_WIRE_DOC03_09_from : DiscreteGpioInoutPort;
            satisfy requirement REQ_GAP_DOC02_05;
            satisfy requirement REQ_GAP_DOC03_05;
            connection def CONN_WIRE_054_DN_1 {
                connect bh_WIRE_054_to to esad.powerIn14v;
            }
            connection def CONN_WIRE_055_DN_1 {
                connect bh_WIRE_055_to to esad.rs485Port;
            }
            connection def CONN_WIRE_056_DN_1 {
                connect bh_WIRE_056_to to esad.analogTriggerIn;
            }
            connection def CONN_WIRE_057_DN_1 {
                connect bh_WIRE_057_to to esad.rbfInterlockIn;
            }
            connection def CONN_WIRE_DOC03_03_DN_1 {
                connect bh_WIRE_DOC03_03_to to esad.dscArmEnableIn;
            }
            connection def CONN_WIRE_DOC03_04_UP_1 {
                connect esad.umbilicalLoop to bh_WIRE_DOC03_04_from;
            }
            connection def CONN_WIRE_DOC03_05_UP_1 {
                connect esad.sensorPower5vOut to bh_WIRE_DOC03_05_from;
            }
            connection def CONN_WIRE_DOC03_06_UP_1 {
                connect esad.sensorUartPort to bh_WIRE_DOC03_06_from;
            }
            connection def CONN_WIRE_DOC03_08_DN_1 {
                connect bh_WIRE_DOC03_08_to to esad.analogTriggerIn;
            }
            connection def CONN_WIRE_DOC03_09_UP_1 {
                connect esad.sensorSpareLine to bh_WIRE_DOC03_09_from;
            }
            connection def CONN_WIRE_DOC03_10 {
                connect esad.hvFireOut to leefiDetonator.hvFireIn;
            }
            connection def CONN_WIRE_DOC03_11 {
                connect leefiDetonator.detonationOut to warheadBooster.detonationIn;
            }
            connection def CONN_WIRE_DOC03_12 {
                connect warheadBooster.detonationOut to warhead.energeticTriggerIn;
            }
            part esad : EsadSafeAndArmDevice {
            }
            part warhead : Warhead {
            }
            part leefiDetonator : LeefiDetonator {
            }
            part warheadBooster : WarheadBooster {
            }
        }
        part def ParachuteDeploymentPackage {
            attribute boundaryPlacement : String = "interior";
            attribute populatedInProduction : Boolean = false;
            attribute boundConstraints : String = "ConstraintExcludeParachuteDeploymentInProduction";
            port in bh_WIRE_052_to : DcPowerInPort;
            port in bh_WIRE_053_to : DcPowerInPort;
            satisfy requirement REQ_INV_DOC01_11;
            satisfy requirement REQ_GAP_DOC01_03;
            satisfy requirement REQ_GAP_DOC06_02;
            connection def CONN_WIRE_052_DN_1 {
                connect bh_WIRE_052_to to igniter1.powerIn50v;
            }
            connection def CONN_WIRE_053_DN_1 {
                connect bh_WIRE_053_to to igniter2.powerIn50v;
            }
            part igniter1 : ParachuteIgniter {
                attribute multiplicity : String = "0..1";
                attribute populatedInProduction : Boolean = false;
            }
            part igniter2 : ParachuteIgniter {
                attribute multiplicity : String = "0..1";
                attribute populatedInProduction : Boolean = false;
            }
        }
        part def ProximitySensorBoard {
            attribute boundaryPlacement : String = "interior";
            attribute populatedInProduction : Boolean = true;
            attribute boundConstraints : String = "INV_DOC03_04";
            attribute boundProtocolItems : String = "ITEM_PROTO_ESAD_ANALOG_TRIGGER";
            port out bh_WIRE_056_from : DiscreteGpioOutPort;
            port in bh_WIRE_DOC03_05_to : DcPowerInPort;
            port inout bh_WIRE_DOC03_06_to : UartSerialInoutPort;
            port out bh_WIRE_DOC03_08_from : DiscreteGpioOutPort;
            port inout bh_WIRE_DOC03_09_to : DiscreteGpioInoutPort;
            port in bh_WIRE_DOC05_006_to : MechanicalStructuralLoadInPort;
            satisfy requirement REQ_PROTO_ESAD_ANALOG_TRIGGER;
            satisfy requirement REQ_GAP_DOC03_04;
            satisfy requirement REQ_GAP_MERGE_05;
            connection def CONN_WIRE_056_UP_1 {
                connect proximitySensor.analogTriggerOut to bh_WIRE_056_from;
            }
            connection def CONN_WIRE_DOC03_05_DN_1 {
                connect bh_WIRE_DOC03_05_to to proximitySensor.powerIn5v;
            }
            connection def CONN_WIRE_DOC03_06_DN_1 {
                connect bh_WIRE_DOC03_06_to to proximitySensor.uartPort;
            }
            connection def CONN_WIRE_DOC03_08_UP_1 {
                connect impactSwitch.impactTriggerOut to bh_WIRE_DOC03_08_from;
            }
            connection def CONN_WIRE_DOC03_09_DN_1 {
                connect bh_WIRE_DOC03_09_to to proximitySensor.sensorSpareLine;
            }
            connection def CONN_WIRE_DOC05_006_DN_1 {
                connect bh_WIRE_DOC05_006_to to proximitySensor.protectiveCoverIn;
            }
            part proximitySensor : ProximitySensor {
            }
            part impactSwitch : ImpactSwitch {
            }
        }
        part def FinsActuatorGroup {
            attribute boundaryPlacement : String = "interior";
            attribute populatedInProduction : Boolean = true;
            attribute boundConstraints : String = "INV_DOC01_01, INV_DOC05_09";
            port in bh_WIRE_023_to : DcPowerInPort;
            port in bh_WIRE_024_to : DcPowerInPort;
            port in bh_WIRE_025_to : DcPowerInPort;
            port in bh_WIRE_026_to : DcPowerInPort;
            port inout bh_WIRE_027_to : CanBusInoutPort;
            port inout bh_WIRE_028_to : CanBusInoutPort;
            port inout bh_WIRE_029_to : CanBusInoutPort;
            port inout bh_WIRE_030_to : CanBusInoutPort;
            satisfy requirement REQ_GAP_DOC05_07;
            connection def CONN_WIRE_023_DN_1 {
                connect bh_WIRE_023_to to servo2RightUp.powerIn8v;
            }
            connection def CONN_WIRE_024_DN_1 {
                connect bh_WIRE_024_to to servo1LeftUp.powerIn8v;
            }
            connection def CONN_WIRE_025_DN_1 {
                connect bh_WIRE_025_to to servo3RightDown.powerIn8v;
            }
            connection def CONN_WIRE_026_DN_1 {
                connect bh_WIRE_026_to to servo4LeftDown.powerIn8v;
            }
            connection def CONN_WIRE_027_DN_1 {
                connect bh_WIRE_027_to to servo2RightUp.canBusIn;
            }
            connection def CONN_WIRE_028_DN_1 {
                connect bh_WIRE_028_to to servo1LeftUp.canBusIn;
            }
            connection def CONN_WIRE_029_DN_1 {
                connect bh_WIRE_029_to to servo3RightDown.canBusIn;
            }
            connection def CONN_WIRE_030_DN_1 {
                connect bh_WIRE_030_to to servo4LeftDown.canBusIn;
            }
            part servo2RightUp : ServoHv6160DroneCan {
                attribute servoNumber : Integer = 2;
                attribute surfacePosition : String = "Right-up";
            }
            part servo1LeftUp : ServoHv6160DroneCan {
                attribute servoNumber : Integer = 1;
                attribute surfacePosition : String = "Left-up";
            }
            part servo3RightDown : ServoHv6160DroneCan {
                attribute servoNumber : Integer = 3;
                attribute surfacePosition : String = "Right-down";
            }
            part servo4LeftDown : ServoHv6160DroneCan {
                attribute servoNumber : Integer = 4;
                attribute surfacePosition : String = "Left-down";
            }
        }
        part def WingsActuatorGroup {
            attribute boundaryPlacement : String = "interior";
            attribute populatedInProduction : Boolean = true;
            attribute boundConstraints : String = "INV_DOC01_02, INV_DOC05_08";
            attribute interactionBindings : String = "INT_04_WingsCan2DaisyChainControl";
            port in bh_WIRE_015_to : DcPowerInPort;
            port in bh_WIRE_016_to : DcPowerInPort;
            port in bh_WIRE_017_to : DcPowerInPort;
            port in bh_WIRE_018_to : DcPowerInPort;
            port inout bh_WIRE_019_to : CanBusInoutPort;
            satisfy requirement REQ_GAP_DOC05_05;
            connection def CONN_WIRE_015_DN_1 {
                connect bh_WIRE_015_to to servo6RightUp.powerIn8v;
            }
            connection def CONN_WIRE_016_DN_1 {
                connect bh_WIRE_016_to to servo5LeftUp.powerIn8v;
            }
            connection def CONN_WIRE_017_DN_1 {
                connect bh_WIRE_017_to to servo7RightDown.powerIn8v;
            }
            connection def CONN_WIRE_018_DN_1 {
                connect bh_WIRE_018_to to servo8LeftDown.powerIn8v;
            }
            connection def CONN_WIRE_019_DN_1 {
                connect bh_WIRE_019_to to servo6RightUp.canBusIn;
            }
            connection def CONN_WIRE_020 {
                connect servo6RightUp.canBusThruOut to servo5LeftUp.canBusIn;
            }
            connection def CONN_WIRE_021 {
                connect servo5LeftUp.canBusThruOut to servo7RightDown.canBusIn;
            }
            connection def CONN_WIRE_022 {
                connect servo7RightDown.canBusThruOut to servo8LeftDown.canBusIn;
            }
            part servo6RightUp : ServoHv6160DroneCan {
                attribute servoNumber : Integer = 6;
                attribute surfacePosition : String = "Right-up";
            }
            part servo5LeftUp : ServoHv6160DroneCan {
                attribute servoNumber : Integer = 5;
                attribute surfacePosition : String = "Left-up";
            }
            part servo7RightDown : ServoHv6160DroneCan {
                attribute servoNumber : Integer = 7;
                attribute surfacePosition : String = "Right-down";
            }
            part servo8LeftDown : ServoHv6160DroneCan {
                attribute servoNumber : Integer = 8;
                attribute surfacePosition : String = "Left-down";
            }
        }
        part def AutopilotStackModuleAstkA5V25 {
            attribute boundaryPlacement : String = "interior";
            attribute populatedInProduction : Boolean = true;
            port in bh_WIRE_007_to : DcPowerInPort;
            port inout bh_WIRE_008_to : CanBusInoutPort;
            port in bh_WIRE_009_to : UartSerialInPort;
            port out bh_WIRE_010_from : PwmControlOutPort;
            port inout bh_WIRE_013_to : CanBusInoutPort;
            port out bh_WIRE_014A_from : DcPowerOutPort;
            port out bh_WIRE_014B_from : DcPowerOutPort;
            port out bh_WIRE_014C_from : DcPowerOutPort;
            port out bh_WIRE_014D_from : DcPowerOutPort;
            port out bh_WIRE_DOC01_01_from : DcPowerOutPort;
            port out bh_WIRE_DOC01_02_from : DcPowerOutPort;
            port out bh_WIRE_DOC01_03_from : DcPowerOutPort;
            port out bh_WIRE_023_from : DcPowerOutPort;
            port out bh_WIRE_024_from : DcPowerOutPort;
            port out bh_WIRE_025_from : DcPowerOutPort;
            port out bh_WIRE_026_from : DcPowerOutPort;
            port inout bh_WIRE_027_from : CanBusInoutPort;
            port inout bh_WIRE_028_from : CanBusInoutPort;
            port inout bh_WIRE_029_from : CanBusInoutPort;
            port inout bh_WIRE_030_from : CanBusInoutPort;
            port out bh_WIRE_031_from : DcPowerOutPort;
            port inout bh_WIRE_032_to : CanBusInoutPort;
            port out bh_WIRE_033_from : DcPowerOutPort;
            port inout bh_WIRE_034_to : CanBusInoutPort;
            port out bh_WIRE_035_from : DcPowerOutPort;
            port inout bh_WIRE_036_to : CanBusInoutPort;
            port out bh_WIRE_037_from : DcPowerOutPort;
            port inout bh_WIRE_039_to : UartSerialInoutPort;
            port inout bh_WIRE_042_to : UartSerialInoutPort;
            port inout bh_WIRE_044_to : UsbBusInoutPort;
            port inout bh_WIRE_046_from : UartSerialInoutPort;
            port out bh_WIRE_047_from : DcPowerOutPort;
            port inout bh_WIRE_049_to : UartSerialInoutPort;
            port out bh_WIRE_052_from : DcPowerOutPort;
            port out bh_WIRE_053_from : DcPowerOutPort;
            port out bh_WIRE_054_from : DcPowerOutPort;
            port inout bh_WIRE_055_from : Rs485DifferentialInoutPort;
            port out bh_WIRE_DOC03_03_from : DiscreteGpioOutPort;
            satisfy requirement REQ_GAP_DOC01_01;
            satisfy requirement REQ_GAP_DOC03_06;
            connection def CONN_WIRE_007_DN_1 {
                connect bh_WIRE_007_to to epsModule.battPowerIn;
            }
            connection def CONN_WIRE_008_DN_1 {
                connect bh_WIRE_008_to to autopilotCubeOrangePlus.can1Bus;
            }
            connection def CONN_WIRE_009_DN_1 {
                connect bh_WIRE_009_to to autopilotCubeOrangePlus.escTelemetryUartIn;
            }
            connection def CONN_WIRE_010_UP_1 {
                connect autopilotCubeOrangePlus.pwmEscOut to bh_WIRE_010_from;
            }
            connection def CONN_WIRE_011 {
                connect epsModule.stackPowerOut to autopilotCubeOrangePlus.stackPowerIn;
            }
            connection def CONN_WIRE_013_DN_1 {
                connect bh_WIRE_013_to to autopilotCubeOrangePlus.can1Bus;
            }
            connection def CONN_WIRE_014A_UP_1 {
                connect epsModule.splitterServo8vOut1 to bh_WIRE_014A_from;
            }
            connection def CONN_WIRE_014B_UP_1 {
                connect epsModule.splitterServo8vOut2 to bh_WIRE_014B_from;
            }
            connection def CONN_WIRE_014C_UP_1 {
                connect epsModule.splitterServo8vOut3 to bh_WIRE_014C_from;
            }
            connection def CONN_WIRE_014D_UP_1 {
                connect epsModule.splitterServo8vOut4 to bh_WIRE_014D_from;
            }
            connection def CONN_WIRE_DOC01_01_UP_1 {
                connect epsModule.ethSwitchPowerOut to bh_WIRE_DOC01_01_from;
            }
            connection def CONN_WIRE_DOC01_02_UP_1 {
                connect epsModule.rpiPowerOut to bh_WIRE_DOC01_02_from;
            }
            connection def CONN_WIRE_DOC01_03_UP_1 {
                connect epsModule.gnssPowerOut to bh_WIRE_DOC01_03_from;
            }
            connection def CONN_WIRE_023_UP_1 {
                connect epsModule.finServoPower8vOut to bh_WIRE_023_from;
            }
            connection def CONN_WIRE_024_UP_1 {
                connect epsModule.finServoPower8vOut to bh_WIRE_024_from;
            }
            connection def CONN_WIRE_025_UP_1 {
                connect epsModule.finServoPower8vOut to bh_WIRE_025_from;
            }
            connection def CONN_WIRE_026_UP_1 {
                connect epsModule.finServoPower8vOut to bh_WIRE_026_from;
            }
            connection def CONN_WIRE_027_UP_1 {
                connect autopilotCubeOrangePlus.can2Bus to bh_WIRE_027_from;
            }
            connection def CONN_WIRE_028_UP_1 {
                connect autopilotCubeOrangePlus.can2Bus to bh_WIRE_028_from;
            }
            connection def CONN_WIRE_029_UP_1 {
                connect autopilotCubeOrangePlus.can2Bus to bh_WIRE_029_from;
            }
            connection def CONN_WIRE_030_UP_1 {
                connect autopilotCubeOrangePlus.can2Bus to bh_WIRE_030_from;
            }
            connection def CONN_WIRE_031_UP_1 {
                connect epsModule.pitoPowerOut to bh_WIRE_031_from;
            }
            connection def CONN_WIRE_032_DN_1 {
                connect bh_WIRE_032_to to autopilotCubeOrangePlus.can1Bus;
            }
            connection def CONN_WIRE_033_UP_1 {
                connect epsModule.magPowerOut to bh_WIRE_033_from;
            }
            connection def CONN_WIRE_034_DN_1 {
                connect bh_WIRE_034_to to autopilotCubeOrangePlus.can1Bus;
            }
            connection def CONN_WIRE_035_UP_1 {
                connect epsModule.magPowerOut to bh_WIRE_035_from;
            }
            connection def CONN_WIRE_036_DN_1 {
                connect bh_WIRE_036_to to autopilotCubeOrangePlus.can1Bus;
            }
            connection def CONN_WIRE_037_UP_1 {
                connect epsModule.gimbalTrip6PowerOut to bh_WIRE_037_from;
            }
            connection def CONN_WIRE_039_DN_1 {
                connect bh_WIRE_039_to to autopilotCubeOrangePlus.trip6Serial;
            }
            connection def CONN_WIRE_042_DN_1 {
                connect bh_WIRE_042_to to autopilotCubeOrangePlus.gnssSerial;
            }
            connection def CONN_WIRE_044_DN_1 {
                connect bh_WIRE_044_to to autopilotCubeOrangePlus.usbPort;
            }
            connection def CONN_WIRE_046_UP_1 {
                connect autopilotCubeOrangePlus.rpiSerial to bh_WIRE_046_from;
            }
            connection def CONN_WIRE_047_UP_1 {
                connect epsModule.radioPower12vOut to bh_WIRE_047_from;
            }
            connection def CONN_WIRE_049_DN_1 {
                connect bh_WIRE_049_to to autopilotCubeOrangePlus.radioSerial;
            }
            connection def CONN_WIRE_052_UP_1 {
                connect epsModule.igniterPower50vOut1 to bh_WIRE_052_from;
            }
            connection def CONN_WIRE_053_UP_1 {
                connect epsModule.igniterPower50vOut2 to bh_WIRE_053_from;
            }
            connection def CONN_WIRE_054_UP_1 {
                connect epsModule.esadPower14vOut to bh_WIRE_054_from;
            }
            connection def CONN_WIRE_055_UP_1 {
                connect autopilotCubeOrangePlus.esadRs485 to bh_WIRE_055_from;
            }
            connection def CONN_WIRE_DOC03_03_UP_1 {
                connect autopilotCubeOrangePlus.esadDiscreteArmOut to bh_WIRE_DOC03_03_from;
            }
            part epsModule : EpsElectronicPowerSystemModule {
            }
            part autopilotCubeOrangePlus : AutopilotCubeOrangePlus {
            }
        }
        part def PropulsionSubsystem {
            attribute boundaryPlacement : String = "interior";
            attribute populatedInProduction : Boolean = true;
            port in bh_WIRE_003_to : DiscreteGpioInPort;
            port out bh_WIRE_007_from : DcPowerOutPort;
            port inout bh_WIRE_008_from : CanBusInoutPort;
            port out bh_WIRE_009_from : UartSerialOutPort;
            port in bh_WIRE_010_to : PwmControlInPort;
            port out bh_WIRE_012_from : DcPowerOutPort;
            port in bh_WIRE_DOC06_023_to : DcPowerInPort;
            port in bh_WIRE_DOC06_024_to : MechanicalStructuralLoadInPort;
            satisfy requirement REQ_INV_DOC02_12;
            connection def CONN_WIRE_001 {
                connect battery.dcPowerOut to automotiveFuse200A.dcPowerIn;
            }
            connection def CONN_WIRE_002 {
                connect automotiveFuse200A.dcPowerOut to powerMeter.dcPowerIn;
            }
            connection def CONN_WIRE_003_DN_1 {
                connect bh_WIRE_003_to to powerMeter.rbfInterlockIn;
            }
            connection def CONN_WIRE_004 {
                connect powerMeter.dcPowerOutEsc to esc.dcPowerIn;
            }
            connection def CONN_WIRE_005 {
                connect esc.threePhaseAcOut to motor.threePhaseAcIn;
            }
            connection def CONN_WIRE_006 {
                connect motor.motTempTelemetryOut to esc.motTempTelemetryIn;
            }
            connection def CONN_WIRE_007_UP_1 {
                connect powerMeter.dcPowerOutEps to bh_WIRE_007_from;
            }
            connection def CONN_WIRE_008_UP_1 {
                connect powerMeter.can1Bus to bh_WIRE_008_from;
            }
            connection def CONN_WIRE_009_UP_1 {
                connect esc.telemetryUartOut to bh_WIRE_009_from;
            }
            connection def CONN_WIRE_010_DN_1 {
                connect bh_WIRE_010_to to esc.pwmControlIn;
            }
            connection def CONN_WIRE_012_UP_1 {
                connect powerMeter.dcPowerOutSplitter to bh_WIRE_012_from;
            }
            connection def CONN_WIRE_DOC05_004 {
                connect motor.propellerShaftOut to foldingPropeller.motorShaftIn;
            }
            connection def CONN_WIRE_DOC06_023_DN_2 {
                connect bh_WIRE_DOC06_023_to to battery.dcChargeIn;
            }
            connection def CONN_WIRE_DOC06_024_DN_2 {
                connect bh_WIRE_DOC06_024_to to foldingPropeller.sparePropellerIn;
            }
            part battery : Battery12S2PLiMetalBei {
            }
            part automotiveFuse200A : AutomotiveFuse200A {
            }
            part powerMeter : PowerMeterSwitchSensor {
            }
            part esc : EscIbex160 {
            }
            part motor : MotorAxi534516HdGoldLineV3 {
            }
            part foldingPropeller : FoldingPropeller {
            }
        }
        part def AirVehicleAvengerV25 {
            attribute boundaryPlacement : String = "interior";
            attribute populatedInProduction : Boolean = true;
            attribute boundStateMachines : String = "FSM_DOC02_TERMINAL_ENGAGEMENT, FSM_DOC05_UAV_PREP_AND_ASSEMBLY, FSM_DOC05_RBF_POWERON_AND_LAUNCH_GATING";
            attribute boundConstraints : String = "INV_DOC02_02, INV_DOC02_03, INV_DOC02_04, INV_DOC02_05";
            port in bh_WIRE_DOC04_018_to : MechanicalStructuralLoadInPort;
            port inout bh_WIRE_DOC06_004_to : RfOverTheAirInoutPort;
            port inout bh_WIRE_DOC06_005_to : RfOverTheAirInoutPort;
            port inout bh_WIRE_DOC06_017_to : RfOverTheAirInoutPort;
            port inout bh_WIRE_DOC06_018_to : RfOverTheAirInoutPort;
            port in bh_WIRE_DOC06_023_to : DcPowerInPort;
            port in bh_WIRE_DOC06_024_to : MechanicalStructuralLoadInPort;
            port in bh_WIRE_DOC06_025_to : MechanicalStructuralLoadInPort;
            port in bh_WIRE_DOC06_028_to : MechanicalStructuralLoadInPort;
            satisfy requirement REQ_INV_DOC02_01;
            satisfy requirement REQ_INV_DOC02_06;
            satisfy requirement REQ_INV_DOC02_07;
            satisfy requirement REQ_INV_DOC02_18;
            satisfy requirement REQ_INV_DOC05_01;
            satisfy requirement REQ_INV_DOC05_07;
            satisfy requirement REQ_GAP_DOC02_01;
            satisfy requirement REQ_GAP_DOC03_01;
            satisfy requirement REQ_GAP_DOC05_01;
            satisfy requirement REQ_GAP_DOC06_01;
            connection def CONN_WIRE_003_SPAN {
                connect uavRbfKey.rbfInterlockOut to propulsion.bh_WIRE_003_to;
            }
            connection def CONN_WIRE_007_SPAN {
                connect propulsion.bh_WIRE_007_from to autopilotStack.bh_WIRE_007_to;
            }
            connection def CONN_WIRE_008_SPAN {
                connect propulsion.bh_WIRE_008_from to autopilotStack.bh_WIRE_008_to;
            }
            connection def CONN_WIRE_009_SPAN {
                connect propulsion.bh_WIRE_009_from to autopilotStack.bh_WIRE_009_to;
            }
            connection def CONN_WIRE_010_SPAN {
                connect autopilotStack.bh_WIRE_010_from to propulsion.bh_WIRE_010_to;
            }
            connection def CONN_WIRE_012_SPAN {
                connect propulsion.bh_WIRE_012_from to canPowerSplitterPcb.battPowerIn;
            }
            connection def CONN_WIRE_013_SPAN {
                connect canPowerSplitterPcb.canUpstream to autopilotStack.bh_WIRE_013_to;
            }
            connection def CONN_WIRE_014A_SPAN {
                connect autopilotStack.bh_WIRE_014A_from to canPowerSplitterPcb.epsServo8vIn1;
            }
            connection def CONN_WIRE_014B_SPAN {
                connect autopilotStack.bh_WIRE_014B_from to canPowerSplitterPcb.epsServo8vIn2;
            }
            connection def CONN_WIRE_014C_SPAN {
                connect autopilotStack.bh_WIRE_014C_from to canPowerSplitterPcb.epsServo8vIn3;
            }
            connection def CONN_WIRE_014D_SPAN {
                connect autopilotStack.bh_WIRE_014D_from to canPowerSplitterPcb.epsServo8vIn4;
            }
            connection def CONN_WIRE_DOC01_01_SPAN {
                connect autopilotStack.bh_WIRE_DOC01_01_from to ethSwitch.dcPowerIn;
            }
            connection def CONN_WIRE_DOC01_02_SPAN {
                connect autopilotStack.bh_WIRE_DOC01_02_from to rpi.dcPowerIn;
            }
            connection def CONN_WIRE_DOC01_03_SPAN {
                connect autopilotStack.bh_WIRE_DOC01_03_from to gnssModule.dcPowerIn;
            }
            connection def CONN_WIRE_015_SPAN {
                connect canPowerSplitterPcb.servoPower8vOut6 to wings.bh_WIRE_015_to;
            }
            connection def CONN_WIRE_016_SPAN {
                connect canPowerSplitterPcb.servoPower8vOut5 to wings.bh_WIRE_016_to;
            }
            connection def CONN_WIRE_017_SPAN {
                connect canPowerSplitterPcb.servoPower8vOut7 to wings.bh_WIRE_017_to;
            }
            connection def CONN_WIRE_018_SPAN {
                connect canPowerSplitterPcb.servoPower8vOut8 to wings.bh_WIRE_018_to;
            }
            connection def CONN_WIRE_019_SPAN {
                connect canPowerSplitterPcb.can2DaisyOut to wings.bh_WIRE_019_to;
            }
            connection def CONN_WIRE_023_SPAN {
                connect autopilotStack.bh_WIRE_023_from to fins.bh_WIRE_023_to;
            }
            connection def CONN_WIRE_024_SPAN {
                connect autopilotStack.bh_WIRE_024_from to fins.bh_WIRE_024_to;
            }
            connection def CONN_WIRE_025_SPAN {
                connect autopilotStack.bh_WIRE_025_from to fins.bh_WIRE_025_to;
            }
            connection def CONN_WIRE_026_SPAN {
                connect autopilotStack.bh_WIRE_026_from to fins.bh_WIRE_026_to;
            }
            connection def CONN_WIRE_027_SPAN {
                connect autopilotStack.bh_WIRE_027_from to fins.bh_WIRE_027_to;
            }
            connection def CONN_WIRE_028_SPAN {
                connect autopilotStack.bh_WIRE_028_from to fins.bh_WIRE_028_to;
            }
            connection def CONN_WIRE_029_SPAN {
                connect autopilotStack.bh_WIRE_029_from to fins.bh_WIRE_029_to;
            }
            connection def CONN_WIRE_030_SPAN {
                connect autopilotStack.bh_WIRE_030_from to fins.bh_WIRE_030_to;
            }
            connection def CONN_WIRE_031_SPAN {
                connect autopilotStack.bh_WIRE_031_from to pitoTube.powerIn;
            }
            connection def CONN_WIRE_032_SPAN {
                connect pitoTube.can1Bus to autopilotStack.bh_WIRE_032_to;
            }
            connection def CONN_WIRE_033_SPAN {
                connect autopilotStack.bh_WIRE_033_from to magnetometer1.powerIn;
            }
            connection def CONN_WIRE_034_SPAN {
                connect magnetometer1.can1Bus to autopilotStack.bh_WIRE_034_to;
            }
            connection def CONN_WIRE_035_SPAN {
                connect autopilotStack.bh_WIRE_035_from to magnetometer2.powerIn;
            }
            connection def CONN_WIRE_036_SPAN {
                connect magnetometer2.can1Bus to autopilotStack.bh_WIRE_036_to;
            }
            connection def CONN_WIRE_037_SPAN {
                connect autopilotStack.bh_WIRE_037_from to cameraComputeModule.powerIn;
            }
            connection def CONN_WIRE_038 {
                connect cameraComputeModule.gimbalPowerHdmiOut to gimbal.powerHdmiIn;
            }
            connection def CONN_WIRE_039_SPAN {
                connect cameraComputeModule.serialPort to autopilotStack.bh_WIRE_039_to;
            }
            connection def CONN_WIRE_040 {
                connect cameraComputeModule.ethPort to ethSwitch.ethTrip6;
            }
            connection def CONN_WIRE_041 {
                connect gnssAntenna.rfOut to gnssModule.rfIn;
            }
            connection def CONN_WIRE_042_SPAN {
                connect gnssModule.serialPort to autopilotStack.bh_WIRE_042_to;
            }
            connection def CONN_WIRE_043 {
                connect externalInterfaceBoard.ethPort to ethSwitch.ethExtIf;
            }
            connection def CONN_WIRE_044_SPAN {
                connect externalInterfaceBoard.usbPort to autopilotStack.bh_WIRE_044_to;
            }
            connection def CONN_WIRE_045 {
                connect ethSwitch.ethRpi to rpi.ethPort;
            }
            connection def CONN_WIRE_046_SPAN {
                connect autopilotStack.bh_WIRE_046_from to rpi.serialPort;
            }
            connection def CONN_WIRE_047_SPAN {
                connect autopilotStack.bh_WIRE_047_from to radioModule.powerIn12v;
            }
            connection def CONN_WIRE_048 {
                connect radioModule.ethPort to ethSwitch.ethRadio;
            }
            connection def CONN_WIRE_049_SPAN {
                connect radioModule.serialPort to autopilotStack.bh_WIRE_049_to;
            }
            connection def CONN_WIRE_050 {
                connect radioModule.rfPort1 to radioAntenna1.rfPort;
            }
            connection def CONN_WIRE_051 {
                connect radioModule.rfPort2 to radioAntenna2.rfPort;
            }
            connection def CONN_WIRE_052_SPAN {
                connect autopilotStack.bh_WIRE_052_from to parachuteDeployment.bh_WIRE_052_to;
            }
            connection def CONN_WIRE_053_SPAN {
                connect autopilotStack.bh_WIRE_053_from to parachuteDeployment.bh_WIRE_053_to;
            }
            connection def CONN_WIRE_054_SPAN {
                connect autopilotStack.bh_WIRE_054_from to lethalPackage.bh_WIRE_054_to;
            }
            connection def CONN_WIRE_055_SPAN {
                connect autopilotStack.bh_WIRE_055_from to lethalPackage.bh_WIRE_055_to;
            }
            connection def CONN_WIRE_056_SPAN {
                connect proximitySensorBoard.bh_WIRE_056_from to lethalPackage.bh_WIRE_056_to;
            }
            connection def CONN_WIRE_057_SPAN {
                connect esadRbfKey.rbfInterlockOut to lethalPackage.bh_WIRE_057_to;
            }
            connection def CONN_WIRE_DOC03_03_SPAN {
                connect autopilotStack.bh_WIRE_DOC03_03_from to lethalPackage.bh_WIRE_DOC03_03_to;
            }
            connection def CONN_WIRE_DOC03_04_SPAN {
                connect lethalPackage.bh_WIRE_DOC03_04_from to esadUmbilical.umbilicalLoop;
            }
            connection def CONN_WIRE_DOC03_05_SPAN {
                connect lethalPackage.bh_WIRE_DOC03_05_from to proximitySensorBoard.bh_WIRE_DOC03_05_to;
            }
            connection def CONN_WIRE_DOC03_06_SPAN {
                connect lethalPackage.bh_WIRE_DOC03_06_from to proximitySensorBoard.bh_WIRE_DOC03_06_to;
            }
            connection def CONN_WIRE_DOC03_08_SPAN {
                connect proximitySensorBoard.bh_WIRE_DOC03_08_from to lethalPackage.bh_WIRE_DOC03_08_to;
            }
            connection def CONN_WIRE_DOC03_09_SPAN {
                connect lethalPackage.bh_WIRE_DOC03_09_from to proximitySensorBoard.bh_WIRE_DOC03_09_to;
            }
            connection def CONN_WIRE_DOC04_018_DN_1 {
                connect bh_WIRE_DOC04_018_to to uavConnectionHooks.carriageLaunchIn;
            }
            connection def CONN_WIRE_DOC05_005 {
                connect rbfPitotCover.coverMechanicalOut to pitoTube.protectiveCoverIn;
            }
            connection def CONN_WIRE_DOC05_006_SPAN {
                connect rbfSensorCover.coverMechanicalOut to proximitySensorBoard.bh_WIRE_DOC05_006_to;
            }
            connection def CONN_WIRE_DOC05_007 {
                connect rbfGimbalStrap.restraintMechanicalOut to gimbal.securingStrapIn;
            }
            connection def CONN_WIRE_DOC05_008 {
                connect uavUmbilicalPort.umbilicalLoop to esadUmbilical.umbilicalLoop;
            }
            connection def CONN_WIRE_DOC05_009 {
                connect esdGroundingPoint.esdChassisBond to externalInterfaceBoard.esdChassisBond;
            }
            connection def CONN_WIRE_DOC06_004_DN_1 {
                connect bh_WIRE_DOC06_004_to to radioAntenna1.rfOverTheAir;
            }
            connection def CONN_WIRE_DOC06_005_DN_1 {
                connect bh_WIRE_DOC06_005_to to radioAntenna1.rfOverTheAir;
            }
            connection def CONN_WIRE_DOC06_017_DN_1 {
                connect bh_WIRE_DOC06_017_to to radioAntenna2.rfOverTheAir;
            }
            connection def CONN_WIRE_DOC06_018_DN_1 {
                connect bh_WIRE_DOC06_018_to to radioAntenna2.rfOverTheAir;
            }
            connection def CONN_WIRE_DOC06_023_DN_1 {
                connect bh_WIRE_DOC06_023_to to propulsion.bh_WIRE_DOC06_023_to;
            }
            connection def CONN_WIRE_DOC06_024_DN_1 {
                connect bh_WIRE_DOC06_024_to to propulsion.bh_WIRE_DOC06_024_to;
            }
            connection def CONN_WIRE_DOC06_025_DN_1 {
                connect bh_WIRE_DOC06_025_to to uavConnectionHooks.stowageCaseIn;
            }
            connection def CONN_WIRE_DOC06_028_DN_1 {
                connect bh_WIRE_DOC06_028_to to uavConnectionHooks.carriageLaunchIn;
            }
            part propulsion : PropulsionSubsystem {
            }
            part autopilotStack : AutopilotStackModuleAstkA5V25 {
            }
            part wings : WingsActuatorGroup {
            }
            part fins : FinsActuatorGroup {
            }
            part proximitySensorBoard : ProximitySensorBoard {
            }
            part parachuteDeployment : ParachuteDeploymentPackage {
                attribute multiplicity : String = "0..1";
                attribute populatedInProduction : Boolean = false;
            }
            part lethalPackage : LethalPackage {
            }
            part ethSwitch : EthSwitch {
            }
            part rpi : RpiCm5004032 {
            }
            part canPowerSplitterPcb : CanPowerSplitterPcb {
            }
            part pitoTube : PitoTubeCuavSkye2 {
            }
            part magnetometer1 : MagnetometerMroRm3100 {
            }
            part magnetometer2 : MagnetometerMroRm3100 {
            }
            part gnssAntenna : GnssAntennaTalysmanTw3972Exf {
            }
            part gnssModule : GnssModuleSeptentrioAsterxM3Pro {
            }
            part gimbal : GimbalNighthawk2Uz {
            }
            part cameraComputeModule : CameraComputeModuleTrip6 {
            }
            part radioModule : RadioModuleDtc {
            }
            part radioAntenna1 : RadioAntennaMpsl4400 {
            }
            part radioAntenna2 : RadioAntennaMpsl4400 {
            }
            part externalInterfaceBoard : ExternalInterfaceBoardUsbEth {
                attribute boundaryPlacement : String = "boundary_straddling";
            }
            part uavRbfKey : UavRbfKey {
                attribute boundaryPlacement : String = "boundary_straddling";
                attribute connectorModel : String = "XT60E-F Amass";
            }
            part esadRbfKey : EsadRbfKey {
                attribute boundaryPlacement : String = "boundary_straddling";
            }
            part esadUmbilical : EsadUmbilicalLoop {
                attribute boundaryPlacement : String = "boundary_straddling";
            }
            part uavConnectionHooks : UavConnectionHookSet {
            }
            part esdGroundingPoint : EsdGroundingPoint {
                attribute boundaryPlacement : String = "boundary_straddling";
            }
            part uavUmbilicalPort : UavUmbilicalAccessPort {
                attribute boundaryPlacement : String = "boundary_straddling";
            }
            part rbfPitotCover : PitotTubeRbfCover {
            }
            part rbfSensorCover : SensorProtectiveRbfCover {
            }
            part rbfGimbalStrap : GimbalSecuringRbfStrap {
            }
        }
        part def Avenger5IntegratedSystem {
            attribute boundaryPlacement : String = "interior";
            attribute populatedInProduction : Boolean = true;
            attribute capabilityRole : String = "Cap_integrated_system";
            attribute boundStateMachines : String = "IntegratedSystemLifecycleState";
            attribute boundConstraints : String = "ConstraintExcludeOptionalGcsAndMaintenanceInProduction";
            attribute interactionBindings : String = "INT_01_SystemPowerOnAndRbfSequence";
            connection def CONN_WIRE_DOC04_018_SPAN {
                connect launchSystem.bh_WIRE_DOC04_018_from to airVehicle.bh_WIRE_DOC04_018_to;
            }
            connection def CONN_WIRE_DOC06_004_SPAN {
                connect groundControlStation.bh_WIRE_DOC06_004_from to airVehicle.bh_WIRE_DOC06_004_to;
            }
            connection def CONN_WIRE_DOC06_005_SPAN {
                connect groundControlStation.bh_WIRE_DOC06_005_from to airVehicle.bh_WIRE_DOC06_005_to;
            }
            connection def CONN_WIRE_DOC06_017_SPAN {
                connect groundControlStation.bh_WIRE_DOC06_017_from to airVehicle.bh_WIRE_DOC06_017_to;
            }
            connection def CONN_WIRE_DOC06_018_SPAN {
                connect groundControlStation.bh_WIRE_DOC06_018_from to airVehicle.bh_WIRE_DOC06_018_to;
            }
            connection def CONN_WIRE_DOC06_021_SPAN {
                connect systemBatteryCharger.dcPowerOut to groundControlStation.bh_WIRE_DOC06_021_to;
            }
            connection def CONN_WIRE_DOC06_022_SPAN {
                connect systemBatteryCharger.dcPowerOut to groundControlStation.bh_WIRE_DOC06_022_to;
            }
            connection def CONN_WIRE_DOC06_023_SPAN {
                connect systemBatteryCharger.dcPowerOut to airVehicle.bh_WIRE_DOC06_023_to;
            }
            connection def CONN_WIRE_DOC06_024_SPAN {
                connect fieldMaintenanceKit.spareHardwareOut to airVehicle.bh_WIRE_DOC06_024_to;
            }
            connection def CONN_WIRE_DOC06_025_SPAN {
                connect transportCaseUav.stowedHardwareOut to airVehicle.bh_WIRE_DOC06_025_to;
            }
            connection def CONN_WIRE_DOC06_026_SPAN {
                connect transportCaseGcs.stowedHardwareOut to groundControlStation.bh_WIRE_DOC06_026_to;
            }
            connection def CONN_WIRE_DOC06_027 {
                connect transportCaseSpares.stowedHardwareOut to fieldMaintenanceKit.stowageCaseIn;
            }
            connection def CONN_WIRE_DOC06_028_SPAN {
                connect tubeLauncherOption.bh_WIRE_DOC06_028_from to airVehicle.bh_WIRE_DOC06_028_to;
            }
            part airVehicle : AirVehicleAvengerV25 {
            }
            part launchSystem : PneumaticLauncherPl40 {
            }
            part groundControlStation : GroundControlStation {
            }
            part tubeLauncherOption : TubeLauncherOption {
                attribute multiplicity : String = "0..1";
                attribute populatedInProduction : Boolean = false;
            }
            part systemBatteryCharger : GcsAndUavBatteryCharger {
                attribute multiplicity : String = "0..1";
                attribute populatedInProduction : Boolean = false;
            }
            part fieldMaintenanceKit : FieldMaintenanceKit {
                attribute multiplicity : String = "0..1";
                attribute populatedInProduction : Boolean = false;
            }
            part transportCaseUav : TransportationStorageCase {
                attribute multiplicity : String = "0..1";
                attribute populatedInProduction : Boolean = false;
            }
            part transportCaseGcs : TransportationStorageCase {
                attribute multiplicity : String = "0..1";
                attribute populatedInProduction : Boolean = false;
            }
            part transportCaseSpares : TransportationStorageCase {
                attribute multiplicity : String = "0..1";
                attribute populatedInProduction : Boolean = false;
            }
        }
    }
}