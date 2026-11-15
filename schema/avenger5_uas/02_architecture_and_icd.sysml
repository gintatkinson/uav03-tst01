package Avenger5_Architecture {
  doc /* 3-Ring structural decomposition, conjugated ports, SignalContract flows, and CrossRingBoundary contracts from Avenger5 V2.5, PL-40, and ESAD ICD. */

  private import ISQ::*;
  private import RAAML::*;
  private import Avenger5_Quantities::*;

  item def Rs485ControlFrame {
    doc /* ESAD RS-485 frame at 115200 bps 8N1 (100 Hz polling, <= 5 ms reply, CRC-16 XModem) [ESAD ICD#p14-p16]. */
    attribute cmdByte : Int64;
  }

  item def DCBusPowerItem {
    doc /* Regulated DC bus supply flow. */
    attribute railVoltageV : Avenger5_Quantities::SI_Domain::Voltage_V;
  }

  item def DroneCanFrameItem {
    doc /* DroneCAN servo command or sensor telemetry packet. */
    attribute frameRateHz : Frequency_Hz;
  }

  item def PneumaticImpulseItem {
    doc /* PL-40 pneumatic launch force and carriage lock state. */
    attribute tankPressurePa : Avenger5_Quantities::SI_Domain::Pressure_Pa;
  }

  item def DiscreteSafetySignalItem {
    doc /* Hardwired RBF pin state, DSC_IN1 1 kHz arm pulse, or J401 HV safety switch output. */
    attribute activeState : Bool;
  }

  item def IpTelemetryCommandItem {
    doc /* Switched Ethernet or Serial C2/video/GNSS telemetry frame. */
    attribute linkOk : Bool;
  }

  connection def CommandLoopConn {
    doc /* Closed-loop command pathway classifier for C9 monotone authority ranking. */
  }

  connection def FeedbackLoopConn {
    doc /* Closed-loop sensor and telemetry feedback pathway classifier for C9 monotone authority ranking. */
  }

  connection def CommandFlow {
    doc /* Closed-loop command flow contract classifier for C8 parity. */
  }

  connection def FeedbackFlow {
    doc /* Closed-loop telemetry and sensor feedback flow contract classifier for C8 parity. */
  }

  port def PowerRailPort {
    doc /* Regulated or switched DC power supply interface. */
    in item powerFlow : DCBusPowerItem;
  }

  port def DroneCanBusPort {
    doc /* DroneCAN redundant actuation and sensor interface (CAN 1 or CAN 2). */
    in item canFlow : DroneCanFrameItem;
  }

  port def Rs485EsadPort {
    doc /* ESAD J100 pins 9-10 RS-485 115200 bps 8N1 half-duplex master/slave link [ESAD ICD#p14-p16]. */
    in item rs485Frame : Rs485ControlFrame;
  }

  port def DiscreteInterlockPort {
    doc /* Hardwired Remove-Before-Flight key, umbilical loop, or DSC_IN1 1 kHz interlock enable [ESAD ICD#p14]. */
    in item interlockSig : DiscreteSafetySignalItem;
  }

  port def EthernetIpPort {
    doc /* Onboard Ethernet switch fabric linking RPI CM5004032, Trip6, DTC Radio, and Ext USB/ETH [Block Diagram#p1]. */
    in item ipFlow : IpTelemetryCommandItem;
  }

  port def SerialTelemetryPort {
    doc /* Point-to-point UART/Serial interface connecting Cube orange+, GNSS, Trip6, RPI, and DTC Radio [Block Diagram#p1]. */
    in item serialFlow : IpTelemetryCommandItem;
  }

  port def PneumaticLaunchPort {
    doc /* PL-40 compressed air delivery and mechanical carriage/trigger interface [PL-40#p21-p26]. */
    in item launchFlow : PneumaticImpulseItem;
  }

  concern def StakeholderConcern {
    doc /* Stakeholder safety, airworthiness, and operational boundary concern per ISO/IEC/IEEE 29148. */
  }

  part def GcsPilotOperator :> RAAML::ExternalActor {
    doc /* Human Pilot operator using SwarmC2 tablet layout and Slide-to-Confirm controls [A5 Manual#p27, p93]. */
    @RAAML::ThreeRing::AuthorityRank { rho = 1.0; roleName = "PilotOperator"; }
    out port c2CmdOut : ~EthernetIpPort;
    in port c2TlmIn : EthernetIpPort;
  }

  part def PayloadOperator :> RAAML::ExternalActor {
    doc /* Human Payload operator supervising EO/IR target tracking and safety release approval [A5 Manual#p27, p84, p93]. */
    @RAAML::ThreeRing::AuthorityRank { rho = 1.5; roleName = "PayloadOperator"; }
    out port payloadCmdOut : ~EthernetIpPort;
    in port videoFeedIn : EthernetIpPort;
  }

  part def LaunchCrewAssistant :> RAAML::ExternalActor {
    doc /* Physical launch assistant performing PL-40 pressurization, RBF pin removals #1-#3, and dual-switch release [A5 Prep#p5-p24; PL-40#p25]. */
    @RAAML::ThreeRing::AuthorityRank { rho = 1.2; roleName = "LaunchAssistant"; }
    out port manualInterlockOut : ~DiscreteInterlockPort;
    in port interlockStatIn : DiscreteInterlockPort;
    out port launcherOperateOut : ~PneumaticLaunchPort;
    in port launcherStatIn : PneumaticLaunchPort;
  }

  part def TacticalC2Network :> RAAML::ExternalActor {
    doc /* External BMS systems (SitaWare HQ, ATAK, DELTA) consuming telemetry reports [A5 Manual#p7, p67]. */
    @RAAML::ThreeRing::AuthorityRank { rho = 2.0; roleName = "ExternalBMS"; }
    out port bmsTaskOut : ~EthernetIpPort;
    in port takFeedIn : EthernetIpPort;
  }

  part def XWingAirframePlant :> RAAML::ControlledProcess {
    doc /* Avenger 5 X-wing pusher airframe (1.8 m span, 1.6 m length, 17 kg MTOW, yaw skid-turn) [Spec Sheet#p3; Block Diagram#p1]. */
    @RAAML::ThreeRing::AuthorityRank { rho = 5.0; roleName = "XWingAirframePlant"; }
    in port aeroSurfaceIn : DroneCanBusPort;
    in port launchImpulseIn : PneumaticLaunchPort;
    out port airDataOut : ~DroneCanBusPort;
    out port aeroLoadFbkOut : ~DroneCanBusPort;
    out port launchClearFbkOut : ~PneumaticLaunchPort;
    out port opticalSceneOut : ~EthernetIpPort;
  }

  part def PL40PneumaticCatapultPlant {
    doc /* ELI PL-40 3-section pneumatic rail catapult (12 deg elevation, 5 m rail, 14 bar max compressor) [PL-40#p37, p41]. */
    @RAAML::ThreeRing::AuthorityRank { rho = 5.0; roleName = "PL40CatapultPlant"; }
    in port airSupplyIn : PneumaticLaunchPort;
    in port crewManualIn : PneumaticLaunchPort;
    out port aircraftImpulseOut : ~PneumaticLaunchPort;
    out port launcherStateOut : ~PneumaticLaunchPort;
  }

  part def MissionPayloadPlant {
    doc /* Modular mission payload (~4.98 kg measured in holder, max 5 kg) controlled in-line by ESAD J401 [A5 Prep#p10; ESAD ICD#p12]. */
    @RAAML::ThreeRing::AuthorityRank { rho = 5.0; roleName = "MissionPayloadPlant"; }
    in port payloadEnableIn : DiscreteInterlockPort;
    out port umbilicalStateOut : ~DiscreteInterlockPort;
  }

  part def EsadSafetyUnit :> RAAML::Subsystem {
    doc /* Artron ESAD board (J100 16-pin, J102 10-pin, J401 HV safety switch) enforcing SS1/SS2/DS/UMB/HV states [ESAD ICD#p5-p27]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring1; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
    @RAAML::ThreeRing::AuthorityRank { rho = 3.8; roleName = "EsadSafetyUnit"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }

    attribute esadSupplyV : Avenger5_Quantities::SI_Domain::Voltage_V = 14.0 [V];
    attribute esadDscArmEnableV : Avenger5_Quantities::SI_Domain::Voltage_V = 0.0 [V];
    attribute umbilicalResOhm : Avenger5_Quantities::SI_Domain::Resistance_Ohm = 0.25 [Ohm];

    in port rs485Bus : Rs485EsadPort;
    out port rs485ReplyOut : ~Rs485EsadPort;
    in port esadPwrIn : PowerRailPort;
    in port dscArmIn : DiscreteInterlockPort;
    in port rbf3KeyIn : DiscreteInterlockPort;
    in port rtaInhibitIn : DiscreteInterlockPort;
    in port umbilicalFbIn : DiscreteInterlockPort;
    in port launchUmbIn : DiscreteInterlockPort;
    out port interlockStatOut : ~DiscreteInterlockPort;
    out port hvOut : ~DiscreteInterlockPort;
  }

  part def PowerMeterAndRbfSwitch :> RAAML::Subsystem {
    doc /* Main DC bus switch controlled by UAV Power R.B.F. #2 key, protected by 200 A automotive fuse, monitoring ESC UART [Block Diagram#p1]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring1; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
    @RAAML::ThreeRing::AuthorityRank { rho = 3.2; roleName = "PowerMeterAndRbfSwitch"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }

    attribute mainBusVoltageV : Avenger5_Quantities::SI_Domain::Voltage_V = 49.5 [V];

    in port rbf2KeyIn : DiscreteInterlockPort;
    in port can1Port : DroneCanBusPort;
    in port epsStatIn : PowerRailPort;
    out port can1TlmOut : ~DroneCanBusPort;
    out port epsFeedOut : ~PowerRailPort;
  }

  part def Pl40InterlockAssembly :> RAAML::Subsystem {
    doc /* PL-40 launch safety interlocks: carriage lock pin, manual Valve 4, dual-switch >= 2 s release, piston over-accel cutoff [PL-40#p18-p26]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring1; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier2; }
    @RAAML::ThreeRing::AuthorityRank { rho = 4.0; roleName = "Pl40InterlockAssembly"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }

    attribute tankPressurePa : Avenger5_Quantities::SI_Domain::Pressure_Pa = 1350000.0 [Pa];

    in port crewIn : DiscreteInterlockPort;
    in port fccLaunchPermIn : DroneCanBusPort;
    out port fccLaunchStatOut : ~DroneCanBusPort;
    in port catapultFbIn : PneumaticLaunchPort;
    in port afClearIn : PneumaticLaunchPort;
    out port pneumaticOut : ~PneumaticLaunchPort;
    out port railLaunchCmdOut : ~PneumaticLaunchPort;
    out port esadClearOut : ~DiscreteInterlockPort;
  }

  part def RtaSimplexSafetyMonitor :> RAAML::Subsystem {
    doc /* Ring-1 formal runtime assurance simplex guard enforcing Geofence, <=55 m/s dive speed cap, and ESAD safe-state invariants. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring1; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
    @RAAML::ThreeRing::AuthorityRank { rho = 2.0; roleName = "RtaSimplexMonitor"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }
    @RAAML::RTA::RtaSimplexMonitor {
      monId = "RTA-A5-SIMPLEX";
      gammaDecayPerS = 2.0 [s^-1];
      tSwitchS = 0.010 [s];
      tRollbackS = 0.020 [s];
      hFloor = 0.05;
    }

    in port can1Monitor : DroneCanBusPort;
    in port esadWatch : Rs485EsadPort;
    out port safetyOverrideOut : ~DroneCanBusPort;
    out port esadInhibitOut : ~DiscreteInterlockPort;
  }

  part def FlightControllerCubeOrangePlus :> RAAML::Subsystem {
    doc /* ASTK A5 V2.5 Cube orange+ primary autopilot executing EKF2, attitude/yaw-skid control, and CAN 1/CAN 2 buses [Block Diagram#p1]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring2; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
    @RAAML::ThreeRing::AuthorityRank { rho = 3.0; roleName = "FlightControllerCube"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }
    @RAAML::RTA::RmaTask {
      taskId = "RMA-FCC-ATTITUDE";
      priority = 1;
      wcetS = 0.0008 [s];
      blockingS = 0.0002 [s];
      periodS = 0.004 [s];
      deadlineS = 0.004 [s];
    }

    out port can1BusOut : ~DroneCanBusPort;
    in port can1FbkIn : DroneCanBusPort;
    in port can2SensorIn : DroneCanBusPort;
    out port can2WingOut : ~DroneCanBusPort;
    in port rtaInhibitIn : DroneCanBusPort;
    in port rpiSerialPort : SerialTelemetryPort;
    out port rpiSerialOut : ~SerialTelemetryPort;
    in port gnssSerialPort : SerialTelemetryPort;
    in port radioSerialPort : SerialTelemetryPort;
    out port radioSerialOut : ~SerialTelemetryPort;
    in port trip6SerialPort : SerialTelemetryPort;
    out port trip6SerialOut : ~SerialTelemetryPort;
  }

  part def ElectronicPowerSystemEps :> RAAML::Subsystem {
    doc /* EPS DC/DC and MCU distribution module outputting 8V servos, 12V radio, 14V ESAD, 50V igniters, and sensor rails [Block Diagram#p1]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring2; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier2; }
    @RAAML::ThreeRing::AuthorityRank { rho = 3.4; roleName = "EpsPowerModule"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }

    in port busIn : PowerRailPort;
    in port can1Ctrl : DroneCanBusPort;
    in port actLoadFbkIn : PowerRailPort;
    out port can1TlmOut : ~DroneCanBusPort;
    out port epsStatOut : ~PowerRailPort;
    out port esadOut : ~PowerRailPort;
    out port radioOut : ~PowerRailPort;
    out port servoPwrOut : ~PowerRailPort;
  }

  part def NavigationAndAirDataSuite :> RAAML::Subsystem {
    doc /* Septentrio Asterx-m3 pro GNSS + Talysman TW3972EXF antenna + 2x mRo RM3100 mag/baro + CUAV SKYE2 heated pitot [Block Diagram#p1]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring2; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier2; }
    @RAAML::ThreeRing::AuthorityRank { rho = 2.8; roleName = "NavigationAirDataSuite"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }
    @RAAML::RTA::RmaTask {
      taskId = "RMA-FCC-NAV-EKF2";
      priority = 2;
      wcetS = 0.0012 [s];
      blockingS = 0.0002 [s];
      periodS = 0.010 [s];
      deadlineS = 0.010 [s];
    }

    attribute indicatedAirspeedMps : Avenger5_Quantities::SI_Domain::Speed_m_per_s = 31.0 [m/s];

    in port airDataIn : DroneCanBusPort;
    out port gnssSerialOut : ~SerialTelemetryPort;
    out port can2SensorOut : ~DroneCanBusPort;
  }

  part def DroneCanActuationAndPropulsion :> RAAML::Subsystem {
    doc /* 4x HV6160-DroneCAN fins on CAN 1 (yaw/pitch) + 4x HV6160-DroneCAN wings on CAN 2 series chain (roll) + IBEX160/AXI 5345/16 [Block Diagram#p1]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring2; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
    @RAAML::ThreeRing::AuthorityRank { rho = 4.2; roleName = "DroneCanActuation"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }

    in port can1FinIn : DroneCanBusPort;
    in port can2WingIn : DroneCanBusPort;
    in port servoPwrIn : PowerRailPort;
    in port afLoadIn : DroneCanBusPort;
    out port can1FbkOut : ~DroneCanBusPort;
    out port servoLoadOut : ~PowerRailPort;
    out port aeroSurfaceOut : ~DroneCanBusPort;
  }

  part def CompanionComputeRpiCm5 :> RAAML::Subsystem {
    doc /* RPI CM5004032 companion computer + ETH switch bridging SwarmC2 IP network to Cube orange+ and ESAD RS-485/GPIO [Block Diagram#p1]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring3; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier2; }
    @RAAML::ThreeRing::AuthorityRank { rho = 2.5; roleName = "CompanionRpiCm5"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-5"; noStd = false; isPassiveSubstrate = true; }
    @RAAML::RTA::RmaTask {
      taskId = "RMA-RPI-ESAD-POLL";
      priority = 3;
      wcetS = 0.0015 [s];
      blockingS = 0.0005 [s];
      periodS = 0.010 [s];
      deadlineS = 0.010 [s];
    }

    out port fccSerialOut : ~SerialTelemetryPort;
    in port fccTelemetryIn : SerialTelemetryPort;
    in port ethFabric : EthernetIpPort;
    out port ethTlmOut : ~EthernetIpPort;
    out port seekerEthOut : ~EthernetIpPort;
    out port esadRs485Out : ~Rs485EsadPort;
    in port esadRs485In : Rs485EsadPort;
    out port esadDscOut : ~DiscreteInterlockPort;
  }

  part def EoIrSeekerSubsystem :> RAAML::Subsystem {
    doc /* Nighthawk2UZ 2-axis EO/IR gimbal (1280x720, X40 zoom) + Trip6 camera compute module (target track + geolocation) [Spec Sheet#p3; Block Diagram#p1]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring3; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier3; }
    @RAAML::ThreeRing::AuthorityRank { rho = 2.7; roleName = "EoIrSeeker"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-5"; noStd = false; isPassiveSubstrate = true; }

    in port opticalIn : EthernetIpPort;
    in port ethCmdIn : EthernetIpPort;
    out port ethLinkOut : ~EthernetIpPort;
    in port serialCmdIn : SerialTelemetryPort;
    out port serialLinkOut : ~SerialTelemetryPort;
  }

  part def C2DatalinkSubsystem :> RAAML::Subsystem {
    doc /* DTC 4.4-5.0 GHz AES-256 FHSS radio (2 W / 2x1 W, 2x MPSL4400) + MARS 23 dBi ground antenna and 0.5 deg rotator [Spec Sheet#p3; A5 Manual#p11, p74]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring3; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier2; }
    @RAAML::ThreeRing::AuthorityRank { rho = 2.3; roleName = "C2DatalinkRadio"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-5"; noStd = false; isPassiveSubstrate = true; }

    attribute c2RssiDbm : Real64 = -65.0;

    in port radioPwrIn : PowerRailPort;
    out port onboardEthOut : ~EthernetIpPort;
    in port onboardEthIn : EthernetIpPort;
    out port onboardSerialOut : ~SerialTelemetryPort;
    in port onboardSerialIn : SerialTelemetryPort;
    in port rfToGcs : EthernetIpPort;
    out port rfToGcsOut : ~EthernetIpPort;
  }

  part def SwarmC2GroundStation :> RAAML::Subsystem {
    doc /* Rugged Windows 11 tablets (Panasonic FZ-G2) + Radio BOX + Ground BOX running SwarmC2 mission/safety C2 [Spec Sheet#p3; A5 Manual#p11-p14]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring3; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier3; }
    @RAAML::ThreeRing::AuthorityRank { rho = 2.1; roleName = "SwarmC2Gcs"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-5"; noStd = false; isPassiveSubstrate = true; }

    in port operatorIn : EthernetIpPort;
    out port operatorTlmOut : ~EthernetIpPort;
    out port rfDatalinkOut : ~EthernetIpPort;
    in port rfTlmIn : EthernetIpPort;
    out port takSyncOut : ~EthernetIpPort;
    in port bmsIn : EthernetIpPort;
  }

  part def Avenger5UasSystem :> RAAML::SystemOfInterest {
    doc /* Complete Avenger 5 V2.5 UAS, PL-40 Pneumatic Launcher, SwarmC2 GCS, and ESAD Safety System boundary definition. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier2Arch; docPath = "docs/interfaces"; }
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring1; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
    @RAAML::ThreeRing::AuthorityRank { rho = 1.0; roleName = "Avenger5SystemRoot"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }

    in port extCmdIn : EthernetIpPort;
    out port extTlmOut : ~EthernetIpPort;
    out port extTakOut : ~EthernetIpPort;
    in port extBmsIn : EthernetIpPort;
    in port extInterlockIn : DiscreteInterlockPort;
    out port extInterlockStatOut : ~DiscreteInterlockPort;
    in port extLauncherCmdIn : PneumaticLaunchPort;
    out port extLauncherStatOut : ~PneumaticLaunchPort;

    out port toAirframeCmdOut : ~DroneCanBusPort;
    in port fromAirframeSensIn : DroneCanBusPort;
    in port fromAirframeOpticalIn : EthernetIpPort;

    out port toCatapultCmdOut : ~PneumaticLaunchPort;
    in port fromCatapultStatIn : PneumaticLaunchPort;

    out port toPayloadHvOut : ~DiscreteInterlockPort;
    in port fromPayloadStatIn : DiscreteInterlockPort;
  }

  part pilot : RAAML::ExternalActor {
    @RAAML::ThreeRing::AuthorityRank { rho = 1.0; roleName = "PilotOperator"; }
    out port c2CmdOut : ~EthernetIpPort;
    in port c2TlmIn : EthernetIpPort;
  }

  part payloadOp : RAAML::ExternalActor {
    @RAAML::ThreeRing::AuthorityRank { rho = 1.5; roleName = "PayloadOperator"; }
    out port payloadCmdOut : ~EthernetIpPort;
    in port videoFeedIn : EthernetIpPort;
  }

  part launchCrew : RAAML::ExternalActor {
    @RAAML::ThreeRing::AuthorityRank { rho = 1.2; roleName = "LaunchAssistant"; }
    out port manualInterlockOut : ~DiscreteInterlockPort;
    in port interlockStatIn : DiscreteInterlockPort;
    out port launcherOperateOut : ~PneumaticLaunchPort;
    in port launcherStatIn : PneumaticLaunchPort;
  }

  part bmsNet : RAAML::ExternalActor {
    @RAAML::ThreeRing::AuthorityRank { rho = 2.0; roleName = "ExternalBMS"; }
    out port bmsTaskOut : ~EthernetIpPort;
    in port takFeedIn : EthernetIpPort;
  }

  part airframe : RAAML::ControlledProcess {
    @RAAML::ThreeRing::AuthorityRank { rho = 5.0; roleName = "XWingAirframePlant"; }
    in port aeroSurfaceIn : DroneCanBusPort;
    in port launchImpulseIn : PneumaticLaunchPort;
    out port airDataOut : ~DroneCanBusPort;
    out port aeroLoadFbkOut : ~DroneCanBusPort;
    out port launchClearFbkOut : ~PneumaticLaunchPort;
    out port opticalSceneOut : ~EthernetIpPort;
  }

  part catapult : RAAML::ExternalActor {
    @RAAML::ThreeRing::AuthorityRank { rho = 5.0; roleName = "PL40CatapultPlant"; }
    in port airSupplyIn : PneumaticLaunchPort;
    in port crewManualIn : PneumaticLaunchPort;
    out port aircraftImpulseOut : ~PneumaticLaunchPort;
    out port launcherStateOut : ~PneumaticLaunchPort;
  }

  part payloadBay : RAAML::ExternalActor {
    @RAAML::ThreeRing::AuthorityRank { rho = 5.0; roleName = "MissionPayloadPlant"; }
    in port payloadEnableIn : DiscreteInterlockPort;
    out port umbilicalStateOut : ~DiscreteInterlockPort;
  }

  part avenger5System : RAAML::SystemOfInterest {
    doc /* Instantiated single SystemOfInterest root containing all internal subsystems, concerns, connections, and flows. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier2Arch; docPath = "docs/interfaces"; }
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring1; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
    @RAAML::ThreeRing::AuthorityRank { rho = 1.0; roleName = "Avenger5SystemRoot"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }

    in port extCmdIn : EthernetIpPort;
    out port extTlmOut : ~EthernetIpPort;
    out port extTakOut : ~EthernetIpPort;
    in port extBmsIn : EthernetIpPort;
    in port extInterlockIn : DiscreteInterlockPort;
    out port extInterlockStatOut : ~DiscreteInterlockPort;
    in port extLauncherCmdIn : PneumaticLaunchPort;
    out port extLauncherStatOut : ~PneumaticLaunchPort;

    out port toAirframeCmdOut : ~DroneCanBusPort;
    in port fromAirframeSensIn : DroneCanBusPort;
    in port fromAirframeOpticalIn : EthernetIpPort;

    out port toCatapultCmdOut : ~PneumaticLaunchPort;
    in port fromCatapultStatIn : PneumaticLaunchPort;

    out port toPayloadHvOut : ~DiscreteInterlockPort;
    in port fromPayloadStatIn : DiscreteInterlockPort;

    concern scLaunchCrewZeroInadvertentEnable : StakeholderConcern {
      doc /* Launch crew and range safety authority require positive two-stage RBF and safe-separation interlocks preventing uncommanded HV activation. */
      stakeholder crew subsets launchCrew;
    }
    concern scAirworthinessContainment : StakeholderConcern {
      doc /* Airworthiness regulator requires polygon geofence containment, stall/overspeed margin protection, and bounded lost-link RTL behavior. */
      stakeholder pilotActor subsets pilot;
      stakeholder payActor subsets payloadOp;
    }

    part envelopes : Avenger5_Quantities::GroundedPlatformEnvelope;

    part esad : RAAML::Subsystem {
      @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring1; }
      @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
      @RAAML::ThreeRing::AuthorityRank { rho = 3.8; roleName = "EsadSafetyUnit"; }
      @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }
      in port rs485Bus : Rs485EsadPort;
      out port rs485ReplyOut : ~Rs485EsadPort;
      in port esadPwrIn : PowerRailPort;
      in port dscArmIn : DiscreteInterlockPort;
      in port rbf3KeyIn : DiscreteInterlockPort;
      in port rtaInhibitIn : DiscreteInterlockPort;
      in port umbilicalFbIn : DiscreteInterlockPort;
      in port launchUmbIn : DiscreteInterlockPort;
      out port interlockStatOut : ~DiscreteInterlockPort;
      out port hvOut : ~DiscreteInterlockPort;
    }
    part powerMeter : RAAML::Subsystem {
      @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring1; }
      @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
      @RAAML::ThreeRing::AuthorityRank { rho = 3.2; roleName = "PowerMeterAndRbfSwitch"; }
      @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }
      in port rbf2KeyIn : DiscreteInterlockPort;
      in port can1Port : DroneCanBusPort;
      in port epsStatIn : PowerRailPort;
      out port can1TlmOut : ~DroneCanBusPort;
      out port epsFeedOut : ~PowerRailPort;
    }
    part pl40Interlocks : RAAML::Subsystem {
      @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring1; }
      @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier2; }
      @RAAML::ThreeRing::AuthorityRank { rho = 4.0; roleName = "Pl40InterlockAssembly"; }
      @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }
      in port crewIn : DiscreteInterlockPort;
      in port fccLaunchPermIn : DroneCanBusPort;
      out port fccLaunchStatOut : ~DroneCanBusPort;
      in port catapultFbIn : PneumaticLaunchPort;
      in port afClearIn : PneumaticLaunchPort;
      out port pneumaticOut : ~PneumaticLaunchPort;
      out port railLaunchCmdOut : ~PneumaticLaunchPort;
      out port esadClearOut : ~DiscreteInterlockPort;
    }
    part rtaMonitor : RAAML::Subsystem {
      @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring1; }
      @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
      @RAAML::ThreeRing::AuthorityRank { rho = 2.0; roleName = "RtaSimplexMonitor"; }
      @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }
      @RAAML::RTA::RtaSimplexMonitor {
        monId = "RTA-A5-SIMPLEX";
        gammaDecayPerS = 2.0 [s^-1];
        tSwitchS = 0.010 [s];
        tRollbackS = 0.020 [s];
        hFloor = 0.05;
      }
      in port can1Monitor : DroneCanBusPort;
      in port esadWatch : Rs485EsadPort;
      out port safetyOverrideOut : ~DroneCanBusPort;
      out port esadInhibitOut : ~DiscreteInterlockPort;
    }

    part fcc : RAAML::Subsystem {
      @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring2; }
      @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
      @RAAML::ThreeRing::AuthorityRank { rho = 3.0; roleName = "FlightControllerCube"; }
      @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }
      @RAAML::RTA::RmaTask {
        taskId = "RMA-FCC-ATTITUDE";
        priority = 1;
        wcetS = 0.0008 [s];
        blockingS = 0.0002 [s];
        periodS = 0.004 [s];
        deadlineS = 0.004 [s];
      }
      out port can1BusOut : ~DroneCanBusPort;
      in port can1FbkIn : DroneCanBusPort;
      in port can2SensorIn : DroneCanBusPort;
      out port can2WingOut : ~DroneCanBusPort;
      in port rtaInhibitIn : DroneCanBusPort;
      in port rpiSerialPort : SerialTelemetryPort;
      out port rpiSerialOut : ~SerialTelemetryPort;
      in port gnssSerialPort : SerialTelemetryPort;
      in port radioSerialPort : SerialTelemetryPort;
      out port radioSerialOut : ~SerialTelemetryPort;
      in port trip6SerialPort : SerialTelemetryPort;
      out port trip6SerialOut : ~SerialTelemetryPort;
    }
    part eps : RAAML::Subsystem {
      @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring2; }
      @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier2; }
      @RAAML::ThreeRing::AuthorityRank { rho = 3.4; roleName = "EpsPowerModule"; }
      @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }
      in port busIn : PowerRailPort;
      in port can1Ctrl : DroneCanBusPort;
      in port actLoadFbkIn : PowerRailPort;
      out port can1TlmOut : ~DroneCanBusPort;
      out port epsStatOut : ~PowerRailPort;
      out port esadOut : ~PowerRailPort;
      out port radioOut : ~PowerRailPort;
      out port servoPwrOut : ~PowerRailPort;
    }
    part navSuite : RAAML::Subsystem {
      @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring2; }
      @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier2; }
      @RAAML::ThreeRing::AuthorityRank { rho = 2.8; roleName = "NavigationAirDataSuite"; }
      @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }
      @RAAML::RTA::RmaTask {
        taskId = "RMA-FCC-NAV-EKF2";
        priority = 2;
        wcetS = 0.0012 [s];
        blockingS = 0.0002 [s];
        periodS = 0.010 [s];
        deadlineS = 0.010 [s];
      }
      in port airDataIn : DroneCanBusPort;
      out port gnssSerialOut : ~SerialTelemetryPort;
      out port can2SensorOut : ~DroneCanBusPort;
    }
    part actuators : RAAML::Subsystem {
      @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring2; }
      @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
      @RAAML::ThreeRing::AuthorityRank { rho = 4.2; roleName = "DroneCanActuation"; }
      @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }
      in port can1FinIn : DroneCanBusPort;
      in port can2WingIn : DroneCanBusPort;
      in port servoPwrIn : PowerRailPort;
      in port afLoadIn : DroneCanBusPort;
      out port can1FbkOut : ~DroneCanBusPort;
      out port servoLoadOut : ~PowerRailPort;
      out port aeroSurfaceOut : ~DroneCanBusPort;
    }

    part rpi : RAAML::Subsystem {
      @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring3; }
      @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier2; }
      @RAAML::ThreeRing::AuthorityRank { rho = 2.5; roleName = "CompanionRpiCm5"; }
      @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-5"; noStd = false; isPassiveSubstrate = true; }
      @RAAML::RTA::RmaTask {
        taskId = "RMA-RPI-ESAD-POLL";
        priority = 3;
        wcetS = 0.0015 [s];
        blockingS = 0.0005 [s];
        periodS = 0.010 [s];
        deadlineS = 0.010 [s];
      }
      out port fccSerialOut : ~SerialTelemetryPort;
      in port fccTelemetryIn : SerialTelemetryPort;
      in port ethFabric : EthernetIpPort;
      out port ethTlmOut : ~EthernetIpPort;
      out port seekerEthOut : ~EthernetIpPort;
      out port esadRs485Out : ~Rs485EsadPort;
      in port esadRs485In : Rs485EsadPort;
      out port esadDscOut : ~DiscreteInterlockPort;
    }
    part seeker : RAAML::Subsystem {
      @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring3; }
      @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier3; }
      @RAAML::ThreeRing::AuthorityRank { rho = 2.7; roleName = "EoIrSeeker"; }
      @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-5"; noStd = false; isPassiveSubstrate = true; }
      in port opticalIn : EthernetIpPort;
      in port ethCmdIn : EthernetIpPort;
      out port ethLinkOut : ~EthernetIpPort;
      in port serialCmdIn : SerialTelemetryPort;
      out port serialLinkOut : ~SerialTelemetryPort;
    }
    part datalink : RAAML::Subsystem {
      @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring3; }
      @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier2; }
      @RAAML::ThreeRing::AuthorityRank { rho = 2.3; roleName = "C2DatalinkRadio"; }
      @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-5"; noStd = false; isPassiveSubstrate = true; }
      in port radioPwrIn : PowerRailPort;
      out port onboardEthOut : ~EthernetIpPort;
      in port onboardEthIn : EthernetIpPort;
      out port onboardSerialOut : ~SerialTelemetryPort;
      in port onboardSerialIn : SerialTelemetryPort;
      in port rfToGcs : EthernetIpPort;
      out port rfToGcsOut : ~EthernetIpPort;
    }
    part gcs : RAAML::Subsystem {
      @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring3; }
      @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier3; }
      @RAAML::ThreeRing::AuthorityRank { rho = 2.1; roleName = "SwarmC2Gcs"; }
      @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-5"; noStd = false; isPassiveSubstrate = true; }
      in port operatorIn : EthernetIpPort;
      out port operatorTlmOut : ~EthernetIpPort;
      out port rfDatalinkOut : ~EthernetIpPort;
      in port rfTlmIn : EthernetIpPort;
      out port takSyncOut : ~EthernetIpPort;
      in port bmsIn : EthernetIpPort;
    }

    flow d04_gcs_to_dl of IpTelemetryCommandItem from gcs.rfDatalinkOut to datalink.rfToGcs;
    flow d04_dl_to_gcs of IpTelemetryCommandItem from datalink.rfToGcsOut to gcs.rfTlmIn;
    flow d05_dl_to_rpi of IpTelemetryCommandItem from datalink.onboardEthOut to rpi.ethFabric;
    flow d05_rpi_to_dl of IpTelemetryCommandItem from rpi.ethTlmOut to datalink.onboardEthIn;
    flow d06_dl_to_fcc of IpTelemetryCommandItem from datalink.onboardSerialOut to fcc.radioSerialPort;
    flow d06_fcc_to_dl of IpTelemetryCommandItem from fcc.radioSerialOut to datalink.onboardSerialIn;
    flow d07_seeker_to_rpi of IpTelemetryCommandItem from seeker.ethLinkOut to rpi.ethFabric;
    flow d07_rpi_to_seeker of IpTelemetryCommandItem from rpi.seekerEthOut to seeker.ethCmdIn;
    flow d08_seeker_to_fcc of IpTelemetryCommandItem from seeker.serialLinkOut to fcc.trip6SerialPort;
    flow d08_fcc_to_seeker of IpTelemetryCommandItem from fcc.trip6SerialOut to seeker.serialCmdIn;
    flow d09_rpi_to_fcc of IpTelemetryCommandItem from rpi.fccSerialOut to fcc.rpiSerialPort;
    flow d09_fcc_to_rpi of IpTelemetryCommandItem from fcc.rpiSerialOut to rpi.fccTelemetryIn;
    flow d10_nav_to_fcc of IpTelemetryCommandItem from navSuite.gnssSerialOut to fcc.gnssSerialPort;
    flow d11_nav_to_fcc of DroneCanFrameItem from navSuite.can2SensorOut to fcc.can2SensorIn;
    flow d12_fcc_to_pm of DroneCanFrameItem from fcc.can1BusOut to powerMeter.can1Port;
    flow d12_pm_to_fcc of DroneCanFrameItem from powerMeter.can1TlmOut to fcc.can1FbkIn;
    flow d13_fcc_to_eps of DroneCanFrameItem from fcc.can1BusOut to eps.can1Ctrl;
    flow d13_eps_to_fcc of DroneCanFrameItem from eps.can1TlmOut to fcc.can1FbkIn;
    flow d14_fcc_to_act of DroneCanFrameItem from fcc.can1BusOut to actuators.can1FinIn;
    flow d14_act_to_fcc : FeedbackFlow of DroneCanFrameItem from actuators.can1FbkOut to fcc.can1FbkIn {
      @RAAML::ThreeRing::SignalContract {
        sigId = "SIG-ACT-FCC-CAN1-FBK";
        unitSym = "Hz";
        minVal = 0.0;
        maxVal = 250.0;
        safeVal = 0.0;
        rateHz = 100.0 [Hz];
        maxLatencyS = 0.010 [s];
      }
    }
    flow d15_fcc_to_act of DroneCanFrameItem from fcc.can2WingOut to actuators.can2WingIn;
    flow d15_fcc_to_pl40 of DroneCanFrameItem from fcc.can1BusOut to pl40Interlocks.fccLaunchPermIn;
    flow d15_pl40_to_fcc of DroneCanFrameItem from pl40Interlocks.fccLaunchStatOut to fcc.can1FbkIn;
    flow d16_fcc_to_rta of DroneCanFrameItem from fcc.can1BusOut to rtaMonitor.can1Monitor;
    flow d16_rta_to_fcc of DroneCanFrameItem from rtaMonitor.safetyOverrideOut to fcc.rtaInhibitIn;
    flow d16_rta_to_esad of DiscreteSafetySignalItem from rtaMonitor.esadInhibitOut to esad.rtaInhibitIn;
    flow d17_esad_to_pl40 of DiscreteSafetySignalItem from esad.interlockStatOut to pl40Interlocks.crewIn;
    flow d17_pl40_to_esad : FeedbackFlow of DiscreteSafetySignalItem from pl40Interlocks.esadClearOut to esad.launchUmbIn;
    flow d18_rpi_to_rta : FeedbackFlow of Rs485ControlFrame from rpi.esadRs485Out to rtaMonitor.esadWatch;
    flow d20_eps_to_pm : FeedbackFlow of DCBusPowerItem from eps.epsStatOut to powerMeter.epsStatIn;
    flow d22_eps_to_act : CommandFlow of DCBusPowerItem from eps.servoPwrOut to actuators.servoPwrIn;
    flow d22_act_to_eps : FeedbackFlow of DCBusPowerItem from actuators.servoLoadOut to eps.actLoadFbkIn;
    flow d17_esad_to_rpi : FeedbackFlow of Rs485ControlFrame from esad.rs485ReplyOut to rpi.esadRs485In {
      @RAAML::ThreeRing::SignalContract {
        sigId = "SIG-ESAD-RPI-RS485-FBK";
        unitSym = "Hz";
        minVal = 0.0;
        maxVal = 100.0;
        safeVal = 0.0;
        rateHz = 100.0 [Hz];
        maxLatencyS = 0.005 [s];
      }
    }
    flow d28_act_to_af : CommandFlow of DroneCanFrameItem from actuators.aeroSurfaceOut to airframe.aeroSurfaceIn {
      @RAAML::ThreeRing::SignalContract {
        sigId = "SIG-ACT-AF-SURFACE-CMD";
        unitSym = "Hz";
        minVal = 0.0;
        maxVal = 250.0;
        safeVal = 0.0;
        rateHz = 250.0 [Hz];
        maxLatencyS = 0.004 [s];
      }
    }
    flow d28_af_to_act : FeedbackFlow of DroneCanFrameItem from airframe.aeroLoadFbkOut to actuators.afLoadIn {
      @RAAML::ThreeRing::SignalContract {
        sigId = "SIG-AF-ACT-LOAD-FBK";
        unitSym = "Hz";
        minVal = 0.0;
        maxVal = 250.0;
        safeVal = 0.0;
        rateHz = 250.0 [Hz];
        maxLatencyS = 0.004 [s];
      }
    }
    flow d29_pl40_to_af : CommandFlow of PneumaticImpulseItem from pl40Interlocks.railLaunchCmdOut to airframe.launchImpulseIn;
    flow d29_af_to_pl40 : FeedbackFlow of PneumaticImpulseItem from airframe.launchClearFbkOut to pl40Interlocks.afClearIn;
    flow d28_af_to_nav : FeedbackFlow of DroneCanFrameItem from airframe.airDataOut to navSuite.airDataIn {
      @RAAML::ThreeRing::SignalContract {
        sigId = "SIG-AF-NAV-AIRDATA-FBK";
        unitSym = "m/s";
        minVal = 0.0;
        maxVal = 80.0;
        safeVal = 24.0;
        rateHz = 50.0 [Hz];
        maxLatencyS = 0.020 [s];
      }
    }
    flow d28_af_to_seeker : FeedbackFlow of IpTelemetryCommandItem from airframe.opticalSceneOut to seeker.opticalIn {
      @RAAML::ThreeRing::SignalContract {
        sigId = "SIG-AF-SEEKER-OPTICAL-FBK";
        unitSym = "Hz";
        minVal = 0.0;
        maxVal = 60.0;
        safeVal = 0.0;
        rateHz = 30.0 [Hz];
        maxLatencyS = 0.033 [s];
      }
    }
    flow d27_cat_to_pl40 of PneumaticImpulseItem from catapult.launcherStateOut to pl40Interlocks.catapultFbIn;
    flow d27_pl40_to_cat_man of PneumaticImpulseItem from pl40Interlocks.pneumaticOut to catapult.crewManualIn;
    flow d30_esad_to_pay of DiscreteSafetySignalItem from esad.hvOut to payloadBay.payloadEnableIn;
    flow d30_pay_to_esad of DiscreteSafetySignalItem from payloadBay.umbilicalStateOut to esad.umbilicalFbIn;

    connection fl01_pilot_to_gcs connect pilot.c2CmdOut to gcs.operatorIn;
    connection fl01_gcs_to_pilot connect gcs.operatorTlmOut to pilot.c2TlmIn;
    connection fl02_payop_to_gcs connect payloadOp.payloadCmdOut to gcs.operatorIn;
    connection fl02_gcs_to_payop connect gcs.operatorTlmOut to payloadOp.videoFeedIn;
    connection fl03_gcs_to_bms connect gcs.takSyncOut to bmsNet.takFeedIn;
    connection fl03_bms_to_gcs connect bmsNet.bmsTaskOut to gcs.bmsIn;
    connection fl23_crew_to_esad connect launchCrew.manualInterlockOut to esad.rbf3KeyIn;
    connection fl23_crew_to_pm connect launchCrew.manualInterlockOut to powerMeter.rbf2KeyIn;
    connection fl23_crew_to_pl40 connect launchCrew.manualInterlockOut to pl40Interlocks.crewIn;
    connection fl23_esad_to_crew connect esad.interlockStatOut to launchCrew.interlockStatIn;
    connection fl26_crew_to_cat connect launchCrew.launcherOperateOut to pl40Interlocks.catapultFbIn;
    connection fl26_pl40_to_crew connect pl40Interlocks.pneumaticOut to launchCrew.launcherStatIn;

    connection fl04_gcs_to_dl : CommandLoopConn connect gcs.rfDatalinkOut to datalink.rfToGcs;
    connection fl04_dl_to_gcs : FeedbackLoopConn connect datalink.rfToGcsOut to gcs.rfTlmIn;
    connection fl05_dl_to_rpi : CommandLoopConn connect datalink.onboardEthOut to rpi.ethFabric;
    connection fl05_rpi_to_dl : FeedbackLoopConn connect rpi.ethTlmOut to datalink.onboardEthIn;
    connection fl06_dl_to_fcc : CommandLoopConn connect datalink.onboardSerialOut to fcc.radioSerialPort;
    connection fl06_fcc_to_dl : FeedbackLoopConn connect fcc.radioSerialOut to datalink.onboardSerialIn;
    connection fl07_seeker_to_rpi : FeedbackLoopConn connect seeker.ethLinkOut to rpi.ethFabric;
    connection fl07_rpi_to_seeker : CommandLoopConn connect rpi.seekerEthOut to seeker.ethCmdIn;
    connection fl08_seeker_to_fcc : CommandLoopConn connect seeker.serialLinkOut to fcc.trip6SerialPort;
    connection fl08_fcc_to_seeker : FeedbackLoopConn connect fcc.trip6SerialOut to seeker.serialCmdIn;
    connection fl09_rpi_to_fcc : CommandLoopConn connect rpi.fccSerialOut to fcc.rpiSerialPort {
      @RAAML::ThreeRing::CrossRingBoundary {
        srcRing = RingLevel::Ring3;
        dstRing = RingLevel::Ring2;
        crc32c = true;
        missMax = 3;
        watchdogS = 0.050 [s];
      }
    }
    connection fl09_fcc_to_rpi : FeedbackLoopConn connect fcc.rpiSerialOut to rpi.fccTelemetryIn;
    connection fl10_nav_to_fcc : CommandLoopConn connect navSuite.gnssSerialOut to fcc.gnssSerialPort;
    connection fl11_nav_to_fcc : CommandLoopConn connect navSuite.can2SensorOut to fcc.can2SensorIn;

    connection fl12_fcc_to_pm : CommandLoopConn connect fcc.can1BusOut to powerMeter.can1Port;
    connection fl12_pm_to_fcc : FeedbackLoopConn connect powerMeter.can1TlmOut to fcc.can1FbkIn;
    connection fl13_fcc_to_eps : CommandLoopConn connect fcc.can1BusOut to eps.can1Ctrl;
    connection fl13_eps_to_fcc : FeedbackLoopConn connect eps.can1TlmOut to fcc.can1FbkIn;
    connection fl14_fcc_to_act : CommandLoopConn connect fcc.can1BusOut to actuators.can1FinIn;
    connection fl14_act_to_fcc : FeedbackLoopConn connect actuators.can1FbkOut to fcc.can1FbkIn;
    connection fl15_fcc_to_act : CommandLoopConn connect fcc.can2WingOut to actuators.can2WingIn;
    connection fl15_fcc_to_pl40 : CommandLoopConn connect fcc.can1BusOut to pl40Interlocks.fccLaunchPermIn;
    connection fl15_pl40_to_fcc : FeedbackLoopConn connect pl40Interlocks.fccLaunchStatOut to fcc.can1FbkIn;

    connection fl16_fcc_to_rta : FeedbackLoopConn connect fcc.can1BusOut to rtaMonitor.can1Monitor {
      @RAAML::ThreeRing::CrossRingBoundary {
        srcRing = RingLevel::Ring2;
        dstRing = RingLevel::Ring1;
        crc32c = true;
        missMax = 3;
        watchdogS = 0.020 [s];
      }
    }
    connection fl16_rta_to_fcc : CommandLoopConn connect rtaMonitor.safetyOverrideOut to fcc.rtaInhibitIn;
    connection fl16_rta_to_esad : CommandLoopConn connect rtaMonitor.esadInhibitOut to esad.rtaInhibitIn;
    connection fl17_esad_to_pl40 : CommandLoopConn connect esad.interlockStatOut to pl40Interlocks.crewIn;
    connection fl17_pl40_to_esad : FeedbackLoopConn connect pl40Interlocks.esadClearOut to esad.launchUmbIn;
    connection fl17_rpi_to_esad : CommandLoopConn connect rpi.esadRs485Out to esad.rs485Bus {
      @RAAML::ThreeRing::CrossRingBoundary {
        srcRing = RingLevel::Ring3;
        dstRing = RingLevel::Ring1;
        crc32c = true;
        missMax = 3;
        watchdogS = 0.030 [s];
      }
    }
    connection fl17_esad_to_rpi : FeedbackLoopConn connect esad.rs485ReplyOut to rpi.esadRs485In;
    connection fl18_rpi_to_rta : FeedbackLoopConn connect rpi.esadRs485Out to rtaMonitor.esadWatch;
    connection fl19_rpi_to_esad_dsc : CommandLoopConn connect rpi.esadDscOut to esad.dscArmIn {
      @RAAML::ThreeRing::CrossRingBoundary {
        srcRing = RingLevel::Ring3;
        dstRing = RingLevel::Ring1;
        crc32c = true;
        missMax = 2;
        watchdogS = 0.010 [s];
      }
    }

    connection fl20_pm_to_eps : CommandLoopConn connect powerMeter.epsFeedOut to eps.busIn;
    connection fl20_eps_to_pm : FeedbackLoopConn connect eps.epsStatOut to powerMeter.epsStatIn;
    connection fl21_eps_to_esad : CommandLoopConn connect eps.esadOut to esad.esadPwrIn;
    connection fl22_eps_to_dl connect eps.radioOut to datalink.radioPwrIn;
    connection fl22_eps_to_act : CommandLoopConn connect eps.servoPwrOut to actuators.servoPwrIn;
    connection fl22_act_to_eps : FeedbackLoopConn connect actuators.servoLoadOut to eps.actLoadFbkIn;

    connection fl28_act_to_af : CommandLoopConn connect actuators.aeroSurfaceOut to airframe.aeroSurfaceIn;
    connection fl28_af_to_act : FeedbackLoopConn connect airframe.aeroLoadFbkOut to actuators.afLoadIn;
    connection fl28_af_to_nav : FeedbackLoopConn connect airframe.airDataOut to navSuite.airDataIn;
    connection fl28_af_to_seeker : FeedbackLoopConn connect airframe.opticalSceneOut to seeker.opticalIn;
    connection fl29_pl40_to_af : CommandLoopConn connect pl40Interlocks.railLaunchCmdOut to airframe.launchImpulseIn;
    connection fl29_af_to_pl40 : FeedbackLoopConn connect airframe.launchClearFbkOut to pl40Interlocks.afClearIn;
    connection fl27_pl40_to_cat connect pl40Interlocks.pneumaticOut to catapult.airSupplyIn;
    connection fl27_pl40_to_cat_man connect pl40Interlocks.pneumaticOut to catapult.crewManualIn;
    connection fl27_cat_to_pl40 connect catapult.launcherStateOut to pl40Interlocks.catapultFbIn;
    connection fl30_esad_to_pay connect esad.hvOut to payloadBay.payloadEnableIn;
    connection fl30_pay_to_esad connect payloadBay.umbilicalStateOut to esad.umbilicalFbIn;

    flow f01_EsadRs485Poll : CommandFlow of Rs485ControlFrame from rpi.esadRs485Out to esad.rs485Bus {
      @RAAML::ThreeRing::SignalContract {
        sigId = "SIG-RPI-ESAD-RS485";
        unitSym = "Hz";
        minVal = 0.0;
        maxVal = 100.0;
        safeVal = 0.0;
        rateHz = 100.0 [Hz];
        maxLatencyS = 0.005 [s];
      }
    }
    flow f02_Esad14VPwr : CommandFlow of DCBusPowerItem from eps.esadOut to esad.esadPwrIn {
      @RAAML::ThreeRing::SignalContract {
        sigId = "SIG-EPS-ESAD-PWR";
        unitSym = "V";
        minVal = 0.0;
        maxVal = 32.0;
        safeVal = 0.0;
        rateHz = 100.0 [Hz];
        maxLatencyS = 0.010 [s];
      }
    }
    flow f03_EsadDscArm : CommandFlow of DiscreteSafetySignalItem from rpi.esadDscOut to esad.dscArmIn {
      @RAAML::ThreeRing::SignalContract {
        sigId = "SIG-RPI-ESAD-DSC-IN1";
        unitSym = "V";
        minVal = 0.0;
        maxVal = 3.3;
        safeVal = 0.0;
        rateHz = 1000.0 [Hz];
        maxLatencyS = 0.002 [s];
      }
    }
    flow f04_MainBusV : CommandFlow of DCBusPowerItem from powerMeter.epsFeedOut to eps.busIn {
      @RAAML::ThreeRing::SignalContract {
        sigId = "SIG-BAT-MAIN-BUS-V";
        unitSym = "V";
        minVal = 0.0;
        maxVal = 50.4;
        safeVal = 0.0;
        rateHz = 50.0 [Hz];
        maxLatencyS = 0.020 [s];
      }
    }
    flow f05_Can1FinCmd : CommandFlow of DroneCanFrameItem from fcc.can1BusOut to actuators.can1FinIn {
      @RAAML::ThreeRing::SignalContract {
        sigId = "SIG-FCC-CAN1-FIN";
        unitSym = "Hz";
        minVal = 0.0;
        maxVal = 250.0;
        safeVal = 0.0;
        rateHz = 250.0 [Hz];
        maxLatencyS = 0.004 [s];
      }
    }
    flow f06_Can2WingCmd : CommandFlow of DroneCanFrameItem from fcc.can2WingOut to actuators.can2WingIn {
      @RAAML::ThreeRing::SignalContract {
        sigId = "SIG-FCC-CAN2-WING";
        unitSym = "Hz";
        minVal = 0.0;
        maxVal = 250.0;
        safeVal = 0.0;
        rateHz = 250.0 [Hz];
        maxLatencyS = 0.004 [s];
      }
    }
    flow f07_Pl40Pressure : CommandFlow of PneumaticImpulseItem from pl40Interlocks.pneumaticOut to catapult.airSupplyIn {
      @RAAML::ThreeRing::SignalContract {
        sigId = "SIG-PL40-TANK-P";
        unitSym = "Pa";
        minVal = 0.0;
        maxVal = 1400000.0;
        safeVal = 0.0;
        rateHz = 10.0 [Hz];
        maxLatencyS = 0.100 [s];
      }
    }
  }

  connection fc01_pilot_in connect pilot.c2CmdOut to avenger5System.extCmdIn;
  connection fc01_pilot_out connect avenger5System.extTlmOut to pilot.c2TlmIn;
  connection fc02_payop_in connect payloadOp.payloadCmdOut to avenger5System.extCmdIn;
  connection fc02_payop_out connect avenger5System.extTlmOut to payloadOp.videoFeedIn;
  connection fc03_bms_out connect avenger5System.extTakOut to bmsNet.takFeedIn;
  connection fc03_bms_in connect bmsNet.bmsTaskOut to avenger5System.extBmsIn;
  connection fc23_crew_in connect launchCrew.manualInterlockOut to avenger5System.extInterlockIn;
  connection fc23_crew_out connect avenger5System.extInterlockStatOut to launchCrew.interlockStatIn;
  connection fc26_crew_launch_in connect launchCrew.launcherOperateOut to avenger5System.extLauncherCmdIn;
  connection fc26_crew_launch_out connect avenger5System.extLauncherStatOut to launchCrew.launcherStatIn;
  connection fc29_cat_af connect catapult.aircraftImpulseOut to airframe.launchImpulseIn;
  connection fc_af_out connect avenger5System.toAirframeCmdOut to airframe.aeroSurfaceIn;
  connection fc_af_in connect airframe.airDataOut to avenger5System.fromAirframeSensIn;
  connection fc_af_opt connect airframe.opticalSceneOut to avenger5System.fromAirframeOpticalIn;
  connection fc_cat_out connect avenger5System.toCatapultCmdOut to catapult.airSupplyIn;
  connection fc_cat_in connect catapult.launcherStateOut to avenger5System.fromCatapultStatIn;
  connection fc_pay_out connect avenger5System.toPayloadHvOut to payloadBay.payloadEnableIn;
  connection fc_pay_in connect payloadBay.umbilicalStateOut to avenger5System.fromPayloadStatIn;
}
