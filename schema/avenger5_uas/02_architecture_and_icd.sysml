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
    @RAAML::ThreeRing::CrossRingBoundary {
      srcRing = RingLevel::Ring3;
      dstRing = RingLevel::Ring1;
      crc32c = true;
      missMax = 3;
      watchdogS = 0.030 [s];
    }
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
    port c2CmdOut : ~EthernetIpPort;
  }

  part def PayloadOperator :> RAAML::ExternalActor {
    doc /* Human Payload operator supervising EO/IR target tracking and safety release approval [A5 Manual#p27, p84, p93]. */
    @RAAML::ThreeRing::AuthorityRank { rho = 1.5; roleName = "PayloadOperator"; }
    port payloadCmdOut : ~EthernetIpPort;
  }

  part def LaunchCrewAssistant :> RAAML::ExternalActor {
    doc /* Physical launch assistant performing PL-40 pressurization, RBF pin removals #1-#3, and dual-switch release [A5 Prep#p5-p24; PL-40#p25]. */
    @RAAML::ThreeRing::AuthorityRank { rho = 1.2; roleName = "LaunchAssistant"; }
    port manualInterlockOut : ~DiscreteInterlockPort;
    port launcherOperateOut : ~PneumaticLaunchPort;
  }

  part def TacticalC2Network :> RAAML::ExternalActor {
    doc /* External BMS systems (SitaWare HQ, ATAK, DELTA) consuming telemetry reports [A5 Manual#p7, p67]. */
    @RAAML::ThreeRing::AuthorityRank { rho = 2.0; roleName = "ExternalBMS"; }
    port takFeedIn : EthernetIpPort;
  }

  part def XWingAirframePlant :> RAAML::ControlledProcess {
    doc /* Avenger 5 X-wing pusher airframe (1.8 m span, 1.6 m length, 17 kg MTOW, yaw skid-turn) [Spec Sheet#p3; Block Diagram#p1]. */
    @RAAML::ThreeRing::AuthorityRank { rho = 5.0; roleName = "XWingAirframePlant"; }
    port aeroSurfaceIn : DroneCanBusPort;
    port launchImpulseIn : PneumaticLaunchPort;
    port airDataOut : ~DroneCanBusPort;
    port opticalSceneOut : ~EthernetIpPort;
  }

  part def PL40PneumaticCatapultPlant :> RAAML::ControlledProcess {
    doc /* ELI PL-40 3-section pneumatic rail catapult (12 deg elevation, 5 m rail, 14 bar max compressor) [PL-40#p37, p41]. */
    @RAAML::ThreeRing::AuthorityRank { rho = 5.0; roleName = "PL40CatapultPlant"; }
    port airSupplyIn : PneumaticLaunchPort;
    port crewManualIn : PneumaticLaunchPort;
    port aircraftImpulseOut : ~PneumaticLaunchPort;
    port launcherStateOut : ~PneumaticLaunchPort;
  }

  part def MissionPayloadPlant :> RAAML::ControlledProcess {
    doc /* Modular mission payload (~4.98 kg measured in holder, max 5 kg) controlled in-line by ESAD J401 [A5 Prep#p10; ESAD ICD#p12]. */
    @RAAML::ThreeRing::AuthorityRank { rho = 5.0; roleName = "MissionPayloadPlant"; }
    port payloadEnableIn : DiscreteInterlockPort;
    port umbilicalStateOut : ~DiscreteInterlockPort;
  }

  part def EsadSafetyUnit :> RAAML::Subsystem {
    doc /* Artron ESAD board (J100 16-pin, J102 10-pin, J401 HV safety switch) enforcing SS1/SS2/DS/UMB/HV states [ESAD ICD#p5-p27]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring1; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
    @RAAML::ThreeRing::AuthorityRank { rho = 2.0; roleName = "EsadSafetyUnit"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }

    attribute esadSupplyV : Avenger5_Quantities::SI_Domain::Voltage_V = 14.0 [V];
    attribute esadDscArmEnableV : Avenger5_Quantities::SI_Domain::Voltage_V = 0.0 [V];
    attribute umbilicalResOhm : Avenger5_Quantities::SI_Domain::Resistance_Ohm = 0.25 [Ohm];

    port rs485Bus : Rs485EsadPort;
    port rs485ReplyOut : ~Rs485EsadPort;
    port esadPwrIn : PowerRailPort;
    port dscArmIn : DiscreteInterlockPort;
    port rbf3KeyIn : DiscreteInterlockPort;
    port rtaInhibitIn : DiscreteInterlockPort;
    port umbilicalFbIn : DiscreteInterlockPort;
    port hvOut : ~DiscreteInterlockPort;
  }

  part def PowerMeterAndRbfSwitch :> RAAML::Subsystem {
    doc /* Main DC bus switch controlled by UAV Power R.B.F. #2 key, protected by 200 A automotive fuse, monitoring ESC UART [Block Diagram#p1]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring1; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
    @RAAML::ThreeRing::AuthorityRank { rho = 2.0; roleName = "PowerMeterAndRbfSwitch"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }

    attribute mainBusVoltageV : Avenger5_Quantities::SI_Domain::Voltage_V = 49.5 [V];

    port rbf2KeyIn : DiscreteInterlockPort;
    port can1Port : DroneCanBusPort;
    port epsFeedOut : ~PowerRailPort;
  }

  part def Pl40InterlockAssembly :> RAAML::Subsystem {
    doc /* PL-40 launch safety interlocks: carriage lock pin, manual Valve 4, dual-switch >= 2 s release, piston over-accel cutoff [PL-40#p18-p26]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring1; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier2; }
    @RAAML::ThreeRing::AuthorityRank { rho = 2.0; roleName = "Pl40InterlockAssembly"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }

    attribute tankPressurePa : Avenger5_Quantities::SI_Domain::Pressure_Pa = 1350000.0 [Pa];

    port crewIn : DiscreteInterlockPort;
    port catapultFbIn : PneumaticLaunchPort;
    port pneumaticOut : ~PneumaticLaunchPort;
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

    port can1Monitor : DroneCanBusPort;
    port esadWatch : Rs485EsadPort;
    port safetyOverrideOut : ~DroneCanBusPort;
    port esadInhibitOut : ~DiscreteInterlockPort;
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
    @RAAML::RTA::RmaTask {
      taskId = "RMA-FCC-NAV-EKF2";
      priority = 2;
      wcetS = 0.0012 [s];
      blockingS = 0.0002 [s];
      periodS = 0.010 [s];
      deadlineS = 0.010 [s];
    }

    port can1BusOut : ~DroneCanBusPort;
    port can2SensorIn : DroneCanBusPort;
    port can2WingOut : ~DroneCanBusPort;
    port rtaInhibitIn : DroneCanBusPort;
    port rpiSerialPort : SerialTelemetryPort;
    port rpiSerialOut : ~SerialTelemetryPort;
    port gnssSerialPort : SerialTelemetryPort;
    port radioSerialPort : SerialTelemetryPort;
    port trip6SerialPort : SerialTelemetryPort;
  }

  part def ElectronicPowerSystemEps :> RAAML::Subsystem {
    doc /* EPS DC/DC and MCU distribution module outputting 8V servos, 12V radio, 14V ESAD, 50V igniters, and sensor rails [Block Diagram#p1]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring2; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier2; }
    @RAAML::ThreeRing::AuthorityRank { rho = 3.0; roleName = "EpsPowerModule"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }

    port busIn : PowerRailPort;
    port can1Ctrl : DroneCanBusPort;
    port esadOut : ~PowerRailPort;
    port radioOut : ~PowerRailPort;
    port servoPwrOut : ~PowerRailPort;
  }

  part def NavigationAndAirDataSuite :> RAAML::Subsystem {
    doc /* Septentrio Asterx-m3 pro GNSS + Talysman TW3972EXF antenna + 2x mRo RM3100 mag/baro + CUAV SKYE2 heated pitot [Block Diagram#p1]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring2; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier2; }
    @RAAML::ThreeRing::AuthorityRank { rho = 3.0; roleName = "NavigationAirDataSuite"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }

    attribute indicatedAirspeedMps : Avenger5_Quantities::SI_Domain::Speed_m_per_s = 31.0 [m/s];

    port airDataIn : DroneCanBusPort;
    port gnssSerialOut : ~SerialTelemetryPort;
    port can2SensorOut : ~DroneCanBusPort;
  }

  part def DroneCanActuationAndPropulsion :> RAAML::Subsystem {
    doc /* 4x HV6160-DroneCAN fins on CAN 1 (yaw/pitch) + 4x HV6160-DroneCAN wings on CAN 2 series chain (roll) + IBEX160/AXI 5345/16 [Block Diagram#p1]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring2; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
    @RAAML::ThreeRing::AuthorityRank { rho = 3.0; roleName = "DroneCanActuation"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }

    port can1FinIn : DroneCanBusPort;
    port can2WingIn : DroneCanBusPort;
    port servoPwrIn : PowerRailPort;
    port aeroSurfaceOut : ~DroneCanBusPort;
  }

  part def CompanionComputeRpiCm5 :> RAAML::Subsystem {
    doc /* RPI CM5004032 companion computer + ETH switch bridging SwarmC2 IP network to Cube orange+ and ESAD RS-485/GPIO [Block Diagram#p1]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring3; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier2; }
    @RAAML::ThreeRing::AuthorityRank { rho = 4.0; roleName = "CompanionRpiCm5"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-5"; noStd = false; isPassiveSubstrate = true; }
    @RAAML::RTA::RmaTask {
      taskId = "RMA-RPI-ESAD-POLL";
      priority = 3;
      wcetS = 0.0015 [s];
      blockingS = 0.0005 [s];
      periodS = 0.010 [s];
      deadlineS = 0.010 [s];
    }

    port fccSerialOut : ~SerialTelemetryPort;
    port fccTelemetryIn : SerialTelemetryPort;
    port ethFabric : EthernetIpPort;
    port ethTlmOut : ~EthernetIpPort;
    port esadRs485Out : ~Rs485EsadPort;
    port esadRs485In : Rs485EsadPort;
    port esadDscOut : ~DiscreteInterlockPort;
  }

  part def EoIrSeekerSubsystem :> RAAML::Subsystem {
    doc /* Nighthawk2UZ 2-axis EO/IR gimbal (1280x720, X40 zoom) + Trip6 camera compute module (target track + geolocation) [Spec Sheet#p3; Block Diagram#p1]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring3; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier3; }
    @RAAML::ThreeRing::AuthorityRank { rho = 4.0; roleName = "EoIrSeeker"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-5"; noStd = false; isPassiveSubstrate = true; }

    port opticalIn : EthernetIpPort;
    port ethLinkOut : ~EthernetIpPort;
    port serialLinkOut : ~SerialTelemetryPort;
  }

  part def C2DatalinkSubsystem :> RAAML::Subsystem {
    doc /* DTC 4.4-5.0 GHz AES-256 FHSS radio (2 W / 2x1 W, 2x MPSL4400) + MARS 23 dBi ground antenna and 0.5 deg rotator [Spec Sheet#p3; A5 Manual#p11, p74]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring3; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier2; }
    @RAAML::ThreeRing::AuthorityRank { rho = 4.0; roleName = "C2DatalinkRadio"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-5"; noStd = false; isPassiveSubstrate = true; }

    attribute c2RssiDbm : Real64 = -65.0;

    port radioPwrIn : PowerRailPort;
    port onboardEthOut : ~EthernetIpPort;
    port onboardEthIn : EthernetIpPort;
    port onboardSerialOut : ~SerialTelemetryPort;
    port rfToGcs : EthernetIpPort;
    port rfToGcsOut : ~EthernetIpPort;
  }

  part def SwarmC2GroundStation :> RAAML::Subsystem {
    doc /* Rugged Windows 11 tablets (Panasonic FZ-G2) + Radio BOX + Ground BOX running SwarmC2 mission/safety C2 [Spec Sheet#p3; A5 Manual#p11-p14]. */
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring3; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier3; }
    @RAAML::ThreeRing::AuthorityRank { rho = 4.0; roleName = "SwarmC2Gcs"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-5"; noStd = false; isPassiveSubstrate = true; }
    @RAAML::ThreeRing::CrossRingBoundary {
      srcRing = RingLevel::Ring3;
      dstRing = RingLevel::Ring2;
      crc32c = true;
      missMax = 5;
      watchdogS = 1.000 [s];
    }

    port operatorIn : EthernetIpPort;
    port rfDatalinkOut : ~EthernetIpPort;
    port rfTlmIn : EthernetIpPort;
    port takSyncOut : ~EthernetIpPort;
  }

  part def Avenger5UasSystem :> RAAML::SystemOfInterest {
    doc /* Complete Avenger 5 V2.5 UAS, PL-40 Pneumatic Launcher, SwarmC2 GCS, and ESAD Safety System boundary definition. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier2Arch; docPath = "docs/interfaces"; }
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring1; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
    @RAAML::ThreeRing::AuthorityRank { rho = 1.0; roleName = "Avenger5SystemRoot"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }

    port extCmdIn : EthernetIpPort;
    port extTakOut : ~EthernetIpPort;
    port extInterlockIn : DiscreteInterlockPort;

    port toAirframeCmdOut : ~DroneCanBusPort;
    port fromAirframeSensIn : DroneCanBusPort;
    port fromAirframeOpticalIn : EthernetIpPort;

    port toCatapultCmdOut : ~PneumaticLaunchPort;
    port fromCatapultStatIn : PneumaticLaunchPort;

    port toPayloadHvOut : ~DiscreteInterlockPort;
    port fromPayloadStatIn : DiscreteInterlockPort;
  }

  part pilot : GcsPilotOperator {
    @RAAML::ThreeRing::AuthorityRank { rho = 1.0; roleName = "PilotOperator"; }
  }

  part payloadOp : PayloadOperator {
    @RAAML::ThreeRing::AuthorityRank { rho = 1.5; roleName = "PayloadOperator"; }
  }

  part launchCrew : LaunchCrewAssistant {
    @RAAML::ThreeRing::AuthorityRank { rho = 1.2; roleName = "LaunchAssistant"; }
  }

  part bmsNet : TacticalC2Network {
    @RAAML::ThreeRing::AuthorityRank { rho = 2.0; roleName = "ExternalBMS"; }
  }

  part airframe : XWingAirframePlant {
    @RAAML::ThreeRing::AuthorityRank { rho = 5.0; roleName = "XWingAirframePlant"; }
  }

  part catapult : PL40PneumaticCatapultPlant {
    @RAAML::ThreeRing::AuthorityRank { rho = 5.0; roleName = "PL40CatapultPlant"; }
  }

  part payloadBay : MissionPayloadPlant {
    @RAAML::ThreeRing::AuthorityRank { rho = 5.0; roleName = "MissionPayloadPlant"; }
  }

  part avenger5System : Avenger5UasSystem {
    doc /* Instantiated single SystemOfInterest root containing all internal subsystems, concerns, connections, and flows. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier2Arch; docPath = "docs/interfaces"; }
    @RAAML::ThreeRing::AssuranceRing { ring = RingLevel::Ring1; }
    @RAAML::ThreeRing::AssuranceTier { tier = TierLevel::Tier1; }
    @RAAML::ThreeRing::AuthorityRank { rho = 1.0; roleName = "Avenger5SystemRoot"; }
    @RAAML::ThreeRing::CodegenTarget { crateName = "mission_contracts"; tqlLevel = "TQL-1"; noStd = true; isPassiveSubstrate = false; }

    port extCmdIn : EthernetIpPort;
    port extTakOut : ~EthernetIpPort;
    port extInterlockIn : DiscreteInterlockPort;

    port toAirframeCmdOut : ~DroneCanBusPort;
    port fromAirframeSensIn : DroneCanBusPort;
    port fromAirframeOpticalIn : EthernetIpPort;

    port toCatapultCmdOut : ~PneumaticLaunchPort;
    port fromCatapultStatIn : PneumaticLaunchPort;

    port toPayloadHvOut : ~DiscreteInterlockPort;
    port fromPayloadStatIn : DiscreteInterlockPort;

    concern scLaunchCrewZeroInadvertentEnable : StakeholderConcern {
      doc /* Launch crew and range safety authority require positive two-stage RBF and safe-separation interlocks preventing uncommanded HV activation. */
    }
    concern scAirworthinessContainment : StakeholderConcern {
      doc /* Airworthiness regulator requires polygon geofence containment, stall/overspeed margin protection, and bounded lost-link RTL behavior. */
    }

    part envelopes : Avenger5_Quantities::GroundedPlatformEnvelope;

    part esad : EsadSafetyUnit {
      @RAAML::ThreeRing::AuthorityRank { rho = 2.0; roleName = "EsadSafetyUnit"; }
    }
    part powerMeter : PowerMeterAndRbfSwitch {
      @RAAML::ThreeRing::AuthorityRank { rho = 2.0; roleName = "PowerMeterAndRbfSwitch"; }
    }
    part pl40Interlocks : Pl40InterlockAssembly {
      @RAAML::ThreeRing::AuthorityRank { rho = 2.0; roleName = "Pl40InterlockAssembly"; }
    }
    part rtaMonitor : RtaSimplexSafetyMonitor {
      @RAAML::ThreeRing::AuthorityRank { rho = 2.0; roleName = "RtaSimplexMonitor"; }
    }

    part fcc : FlightControllerCubeOrangePlus {
      @RAAML::ThreeRing::AuthorityRank { rho = 3.0; roleName = "FlightControllerCube"; }
    }
    part eps : ElectronicPowerSystemEps {
      @RAAML::ThreeRing::AuthorityRank { rho = 3.0; roleName = "EpsPowerModule"; }
    }
    part navSuite : NavigationAndAirDataSuite {
      @RAAML::ThreeRing::AuthorityRank { rho = 3.0; roleName = "NavigationAirDataSuite"; }
    }
    part actuators : DroneCanActuationAndPropulsion {
      @RAAML::ThreeRing::AuthorityRank { rho = 3.0; roleName = "DroneCanActuation"; }
    }

    part rpi : CompanionComputeRpiCm5 {
      @RAAML::ThreeRing::AuthorityRank { rho = 4.0; roleName = "CompanionRpiCm5"; }
    }
    part seeker : EoIrSeekerSubsystem {
      @RAAML::ThreeRing::AuthorityRank { rho = 4.0; roleName = "EoIrSeeker"; }
    }
    part datalink : C2DatalinkSubsystem {
      @RAAML::ThreeRing::AuthorityRank { rho = 4.0; roleName = "C2DatalinkRadio"; }
    }
    part gcs : SwarmC2GroundStation {
      @RAAML::ThreeRing::AuthorityRank { rho = 4.0; roleName = "SwarmC2Gcs"; }
    }

    connection c04 connect gcs.rfDatalinkOut to datalink.rfToGcs;
    connection c04_fb connect datalink.rfToGcsOut to gcs.rfTlmIn;
    connection c05 connect datalink.onboardEthOut to rpi.ethFabric;
    connection c05_fb connect rpi.ethTlmOut to datalink.onboardEthIn;
    connection c06 connect datalink.onboardSerialOut to fcc.radioSerialPort;
    connection c07 connect seeker.ethLinkOut to rpi.ethFabric;
    connection c08 connect seeker.serialLinkOut to fcc.trip6SerialPort;
    connection c09 connect rpi.fccSerialOut to fcc.rpiSerialPort;
    connection c09_fb connect fcc.rpiSerialOut to rpi.fccTelemetryIn;
    connection c10 connect navSuite.gnssSerialOut to fcc.gnssSerialPort;
    connection c11 connect navSuite.can2SensorOut to fcc.can2SensorIn;

    connection c12 connect fcc.can1BusOut to powerMeter.can1Port;
    connection c13 connect fcc.can1BusOut to eps.can1Ctrl;
    connection c14 connect fcc.can1BusOut to actuators.can1FinIn;
    connection c15 connect fcc.can2WingOut to actuators.can2WingIn;

    connection c16 connect fcc.can1BusOut to rtaMonitor.can1Monitor;
    connection c16_cmd connect rtaMonitor.safetyOverrideOut to fcc.rtaInhibitIn;
    connection c16_esad connect rtaMonitor.esadInhibitOut to esad.rtaInhibitIn;
    connection c17 connect rpi.esadRs485Out to esad.rs485Bus;
    connection c17_fb connect esad.rs485ReplyOut to rpi.esadRs485In;
    connection c18 connect rpi.esadRs485Out to rtaMonitor.esadWatch;
    connection c19 connect rpi.esadDscOut to esad.dscArmIn;

    connection c20 connect powerMeter.epsFeedOut to eps.busIn;
    connection c21 connect eps.esadOut to esad.esadPwrIn;
    connection c22 connect eps.radioOut to datalink.radioPwrIn;
    connection c22_srv connect eps.servoPwrOut to actuators.servoPwrIn;

    connection c28 connect actuators.aeroSurfaceOut to airframe.aeroSurfaceIn;
    connection c28_fb connect airframe.airDataOut to navSuite.airDataIn;
    connection c28_opt connect airframe.opticalSceneOut to seeker.opticalIn;
    connection c27 connect pl40Interlocks.pneumaticOut to catapult.airSupplyIn;
    connection c27_fb connect catapult.launcherStateOut to pl40Interlocks.catapultFbIn;
    connection c30 connect esad.hvOut to payloadBay.payloadEnableIn;
    connection c30_fb connect payloadBay.umbilicalStateOut to esad.umbilicalFbIn;

    flow f01_EsadRs485Poll from rpi.esadRs485Out.rs485Frame to esad.rs485Bus.rs485Frame {
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
    flow f02_Esad14VPwr from eps.esadOut.powerFlow to esad.esadPwrIn.powerFlow {
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
    flow f03_EsadDscArm from rpi.esadDscOut.interlockSig to esad.dscArmIn.interlockSig {
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
    flow f04_MainBusV from powerMeter.epsFeedOut.powerFlow to eps.busIn.powerFlow {
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
    flow f05_Can1FinCmd from fcc.can1BusOut.canFlow to actuators.can1FinIn.canFlow {
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
    flow f06_Can2WingCmd from fcc.can2WingOut.canFlow to actuators.can2WingIn.canFlow {
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
    flow f07_Pl40Pressure from pl40Interlocks.pneumaticOut.launchFlow to catapult.airSupplyIn.launchFlow {
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

  connection c01 connect pilot.c2CmdOut to avenger5System.extCmdIn;
  connection c02 connect payloadOp.payloadCmdOut to avenger5System.extCmdIn;
  connection c03 connect avenger5System.extTakOut to bmsNet.takFeedIn;
  connection c23 connect launchCrew.manualInterlockOut to avenger5System.extInterlockIn;
  connection c26 connect launchCrew.launcherOperateOut to catapult.crewManualIn;
  connection c29 connect catapult.aircraftImpulseOut to airframe.launchImpulseIn;
  connection c_af_out connect avenger5System.toAirframeCmdOut to airframe.aeroSurfaceIn;
  connection c_af_in connect airframe.airDataOut to avenger5System.fromAirframeSensIn;
  connection c_af_opt connect airframe.opticalSceneOut to avenger5System.fromAirframeOpticalIn;
  connection c_cat_out connect avenger5System.toCatapultCmdOut to catapult.airSupplyIn;
  connection c_cat_in connect catapult.launcherStateOut to avenger5System.fromCatapultStatIn;
  connection c_pay_out connect avenger5System.toPayloadHvOut to payloadBay.payloadEnableIn;
  connection c_pay_in connect payloadBay.umbilicalStateOut to avenger5System.fromPayloadStatIn;
}
