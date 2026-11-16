package Avenger5_Safety {
  doc /* Top-down STPA control-theoretic hazard analysis, bottom-up EMV2/4-way FMEDA/FTA, and RTA CTMC/RiskLattice/CRC-32C/RMA assurance evaluators. */

  private import ISQ::*;
  private import RAAML::*;
  private import Avenger5_Quantities::*;
  private import Avenger5_Architecture::*;
  private import Avenger5_ConOps::*;

  requirement loss01_LaunchCrewOrPublicHarm :> Avenger5_Architecture::scLaunchCrewZeroInadvertentEnable {
    doc /* System Loss L-01: Unintended ESAD actuation or airframe excursion injuring launch crew or uninvolved personnel. */
    @RAAML::STPA::Loss {
      lossId = "L-01";
      severity = 5;
      stakeholderRef = "scLaunchCrewZeroInadvertentEnable";
      'references' = "Avenger5_Architecture::scLaunchCrewZeroInadvertentEnable,Avenger5_Architecture::launchCrew,Avenger5_ConOps::oa03,Avenger5_ConOps::oa04,Avenger5_ConOps::met06_LaunchVelMps";
    }
    stakeholder st subsets Avenger5_Architecture::launchCrew;
    satisfy Avenger5_Architecture::scLaunchCrewZeroInadvertentEnable;
  }

  requirement loss02_MissionAirworthinessLoss :> Avenger5_Architecture::scAirworthinessContainment {
    doc /* System Loss L-02: Uncontrolled flight termination, crash, or runway/rail launch failure damaging aircraft. */
    @RAAML::STPA::Loss {
      lossId = "L-02";
      severity = 5;
      stakeholderRef = "scAirworthinessContainment";
      'references' = "Avenger5_Architecture::scAirworthinessContainment,Avenger5_Architecture::pilot,Avenger5_ConOps::oa05,Avenger5_ConOps::met02_EnduranceS";
    }
    stakeholder st subsets Avenger5_Architecture::pilot;
    satisfy Avenger5_Architecture::scAirworthinessContainment;
  }

  requirement loss03_MissionPayloadIntegrityLoss :> Avenger5_Architecture::scPayloadContinuityAssurance {
    doc /* System Loss L-03: Inability to maintain controlled payload continuity or mission safe-state integrity. */
    @RAAML::STPA::Loss {
      lossId = "L-03";
      severity = 4;
      stakeholderRef = "scPayloadContinuityAssurance";
      'references' = "Avenger5_Architecture::scPayloadContinuityAssurance,Avenger5_Architecture::payloadOp,Avenger5_ConOps::oa07,Avenger5_ConOps::met04_TerminalCepM";
    }
    stakeholder st subsets Avenger5_Architecture::payloadOp;
    satisfy Avenger5_Architecture::scPayloadContinuityAssurance;
  }

  part hazard01_PrematureEsadSwitchState {
    doc /* Hazard H-01: Inadvertent ESAD high-voltage switch closure or premature RBF/arm transition prior to verified safe separation. */
    @RAAML::STPA::Hazard {
      hazardId = "H-01";
      lossRefs = "L-01,L-02";
      envNegation = "Inadvertent ESAD high-voltage switch closure or premature RBF/arm transition prior to verified safe separation.";
      'references' = "Avenger5_Safety::loss01_LaunchCrewOrPublicHarm,Avenger5_Safety::loss02_MissionAirworthinessLoss,Avenger5_ConOps::envOperatingEnvelope,Avenger5_ConOps::met04_TerminalCepM";
    }
  }

  part hazard02_FlightEnvelopeDeparture {
    doc /* Hazard H-02: Uncontrolled airframe departure from flight envelope (stall < 24 m/s, overspeed > 55 m/s, or PL-40 misfire). */
    @RAAML::STPA::Hazard {
      hazardId = "H-02";
      lossRefs = "L-01,L-02";
      envNegation = "Uncontrolled airframe departure from flight envelope (stall < 24 m/s, overspeed > 55 m/s, or PL-40 misfire).";
      'references' = "Avenger5_Safety::loss01_LaunchCrewOrPublicHarm,Avenger5_Safety::loss02_MissionAirworthinessLoss,Avenger5_ConOps::envOperatingEnvelope,Avenger5_ConOps::met06_LaunchVelMps";
    }
  }

  part hazard03_AutopilotOrCan2ChainLoss {
    doc /* Hazard H-03: Loss of Cube orange+ stabilization or CAN 2 series roll-servo / mag / pitot string in flight. */
    @RAAML::STPA::Hazard {
      hazardId = "H-03";
      lossRefs = "L-02,L-03";
      envNegation = "Loss of Cube orange+ stabilization or CAN 2 series roll-servo / mag / pitot string in flight.";
      'references' = "Avenger5_Safety::loss02_MissionAirworthinessLoss,Avenger5_Safety::loss03_MissionPayloadIntegrityLoss,Avenger5_ConOps::envOperatingEnvelope,Avenger5_ConOps::met09_CruiseSpeedMps";
    }
  }

  part hazard04_GeofenceOrSpoofExcursion {
    doc /* Hazard H-04: Geofence excursion into excluded zone or collision due to spoofed GNSS / unmitigated C2 loss. */
    @RAAML::STPA::Hazard {
      hazardId = "H-04";
      lossRefs = "L-01,L-02";
      envNegation = "Geofence excursion into excluded zone or collision due to spoofed GNSS / unmitigated C2 loss.";
      'references' = "Avenger5_Safety::loss01_LaunchCrewOrPublicHarm,Avenger5_Safety::loss02_MissionAirworthinessLoss,Avenger5_ConOps::envOperatingEnvelope,Avenger5_ConOps::met03_RlosRangeM";
    }
  }

  part hazard05_EsadBrownoutOrBusLoss {
    doc /* Hazard H-05: ESAD brownout or silent telemetry loss across 14 V min-boundary EPS rail or unguarded RS-485 bus [GAP-01]. */
    @RAAML::STPA::Hazard {
      hazardId = "H-05";
      lossRefs = "L-02,L-03";
      envNegation = "ESAD brownout / silent telemetry loss across 14 V min-boundary EPS rail or unguarded RS-485 bus [GAP-01].";
      'references' = "Avenger5_Safety::loss02_MissionAirworthinessLoss,Avenger5_Safety::loss03_MissionPayloadIntegrityLoss,Avenger5_ConOps::envOperatingEnvelope,Avenger5_ConOps::met10_BingoEnergyReserveRatio";
    }
  }

  action ca01_EsadInterlockAndPowerGate {
    doc /* CA-01: Sequential RBF #2/#3 removal, EPS 14 V enable, and ESAD PBIT handshake (OA-03). */
    @RAAML::STPA::ControlAction {
      caId = "CA-01";
      srcRank = 1.2;
      dstRank = 3.8;
      opsRef = "OA-03";
      'references' = "Avenger5_Architecture::launchCrew,Avenger5_Architecture::avenger5System::esad,Avenger5_Architecture::avenger5System::esad::rbf3KeyIn,Avenger5_Architecture::avenger5System::fl23_crew_to_esad,Avenger5_Architecture::avenger5System::f02_Esad14VPwr,Avenger5_ConOps::oa03";
    }
  }

  action ca02_Pl40PneumaticReleaseCommand {
    doc /* CA-02: Dual-switch PL-40 pneumatic catapult launch valve release (OA-04). */
    @RAAML::STPA::ControlAction {
      caId = "CA-02";
      srcRank = 1.2;
      dstRank = 4.0;
      opsRef = "OA-04";
      'references' = "Avenger5_Architecture::launchCrew,Avenger5_Architecture::avenger5System::pl40Interlocks,Avenger5_Architecture::avenger5System::pl40Interlocks::pneumaticOut,Avenger5_Architecture::avenger5System::fl27_pl40_to_cat,Avenger5_Architecture::avenger5System::f07_Pl40Pressure,Avenger5_ConOps::oa04";
    }
  }

  action ca03_TerminalApproachAndEnableGate {
    doc /* CA-03: SwarmC2 dual Slide-to-Confirm approval and RPI DSC_IN1 / RS-485 enable assertion (OA-07). */
    @RAAML::STPA::ControlAction {
      caId = "CA-03";
      srcRank = 1.0;
      dstRank = 3.8;
      opsRef = "OA-07";
      'references' = "Avenger5_Architecture::avenger5System::rpi,Avenger5_Architecture::avenger5System::esad,Avenger5_Architecture::avenger5System::esad::dscArmIn,Avenger5_Architecture::avenger5System::fl19_rpi_to_esad_dsc,Avenger5_Architecture::avenger5System::f03_EsadDscArm,Avenger5_ConOps::oa07";
    }
  }

  action ca04_ApproachAbortAndWaveoffCommand {
    doc /* CA-04: Pilot or FCC automated Abort Approach climb/loiter waveoff command (OA-07). */
    @RAAML::STPA::ControlAction {
      caId = "CA-04";
      srcRank = 1.0;
      dstRank = 3.0;
      opsRef = "OA-07";
      'references' = "Avenger5_Architecture::pilot,Avenger5_Architecture::avenger5System::fcc,Avenger5_Architecture::avenger5System::fcc::radioSerialPort,Avenger5_Architecture::avenger5System::fl06_dl_to_fcc,Avenger5_Architecture::avenger5System::d06_dl_to_fcc,Avenger5_ConOps::oa07";
    }
  }

  action ca05_DroneCanSurfaceActuation {
    doc /* CA-05: Cube orange+ CAN 1 fin and CAN 2 wing servo actuation commands (OA-05). */
    @RAAML::STPA::ControlAction {
      caId = "CA-05";
      srcRank = 3.0;
      dstRank = 4.2;
      opsRef = "OA-05";
      'references' = "Avenger5_Architecture::avenger5System::fcc,Avenger5_Architecture::avenger5System::actuators,Avenger5_Architecture::avenger5System::actuators::can2WingIn,Avenger5_Architecture::avenger5System::fl15_fcc_to_act,Avenger5_Architecture::avenger5System::f06_Can2WingCmd,Avenger5_ConOps::oa05";
    }
  }

  action ca06_GeofenceAndSpoofContingencySwitch {
    doc /* CA-06: GNSS disable dead-reckoning switch and polygon geofence boundary enforcement (OA-06). */
    @RAAML::STPA::ControlAction {
      caId = "CA-06";
      srcRank = 2.0;
      dstRank = 3.0;
      opsRef = "OA-06";
      'references' = "Avenger5_Architecture::avenger5System::navSuite,Avenger5_Architecture::avenger5System::fcc,Avenger5_Architecture::avenger5System::fcc::gnssSerialPort,Avenger5_Architecture::avenger5System::fl10_nav_to_fcc,Avenger5_Architecture::avenger5System::d10_nav_to_fcc,Avenger5_ConOps::oa06";
    }
  }

  part uca01_EsadPbitRailNotProvided {
    doc /* UCA-01: CA-01 NotProvided - 14 V EPS rail or PBIT interlock handshake not sustained to ESAD [GAP-01]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-01";
      caId = "CA-01";
      guideword = StpaGuideword::NotProvided;
      stateContext = "Init_PreFlightPowerOn";
      hazardRef = "H-05";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Init_PreFlightPowerOn,Avenger5_Safety::ca01_EsadInterlockAndPowerGate,Avenger5_Safety::hazard05_EsadBrownoutOrBusLoss";
    }
  }

  part uca02_EsadEnableWithLatchedFault {
    doc /* UCA-02: CA-01 ProvidedUnsafe - EPS 14 V or RBF release asserted with ESAD fault latched or HV >= 50 V [ESAD ICD#p18]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-02";
      caId = "CA-01";
      guideword = StpaGuideword::ProvidedUnsafe;
      stateContext = "Init_PreFlightPowerOn";
      hazardRef = "H-01";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Init_PreFlightPowerOn,Avenger5_Safety::ca01_EsadInterlockAndPowerGate,Avenger5_Safety::hazard01_PrematureEsadSwitchState";
    }
  }

  part uca03_PrematureRbf3Removal {
    doc /* UCA-03: CA-01 WrongTimingOrOrder - ESAD RBF #3 removed before Power RBF #2 and initial power-on PBIT pass [A5 Prep#p23]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-03";
      caId = "CA-01";
      guideword = StpaGuideword::WrongTimingOrOrder;
      stateContext = "Init_SafeAssembly";
      hazardRef = "H-01";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Init_SafeAssembly,Avenger5_Safety::ca01_EsadInterlockAndPowerGate,Avenger5_Safety::hazard01_PrematureEsadSwitchState";
    }
  }

  part uca04_EsadPbitPollWindowExceeded {
    doc /* UCA-04: CA-01 DurationTooShortOrLong - PBIT / RS-485 EXCHANGE poll window truncated or stalled > 10 ms [ESAD ICD#p15]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-04";
      caId = "CA-01";
      guideword = StpaGuideword::DurationTooShortOrLong;
      stateContext = "Init_PreFlightPowerOn";
      hazardRef = "H-05";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Init_PreFlightPowerOn,Avenger5_Safety::ca01_EsadInterlockAndPowerGate,Avenger5_Safety::hazard05_EsadBrownoutOrBusLoss";
    }
  }

  part uca05_Pl40ReleaseNotProvided {
    doc /* UCA-05: CA-02 NotProvided - PL-40 pneumatic valve pressure or release omitted while pusher motor commands thrust [PL-40#p25]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-05";
      caId = "CA-02";
      guideword = StpaGuideword::NotProvided;
      stateContext = "Init_PreFlightPowerOn";
      hazardRef = "H-02";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Init_PreFlightPowerOn,Avenger5_Safety::ca02_Pl40PneumaticReleaseCommand,Avenger5_Safety::hazard02_FlightEnvelopeDeparture";
    }
  }

  part uca06_Pl40TriggeredOutOfEnvelope {
    doc /* UCA-06: CA-02 ProvidedUnsafe - PL-40 triggered with carriage pin in, props unfolded, or pressure outside 13-14 bar [PL-40#p25; GAP-03]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-06";
      caId = "CA-02";
      guideword = StpaGuideword::ProvidedUnsafe;
      stateContext = "Init_PreFlightPowerOn";
      hazardRef = "H-02";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Init_PreFlightPowerOn,Avenger5_Safety::ca02_Pl40PneumaticReleaseCommand,Avenger5_Safety::hazard02_FlightEnvelopeDeparture";
    }
  }

  part uca07_Pl40TriggeredBeforeCrewClear {
    doc /* UCA-07: CA-02 WrongTimingOrOrder - PL-40 released before crew clears behind rear anchor foot or before RBF #3 verify [A5 Prep#p23]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-07";
      caId = "CA-02";
      guideword = StpaGuideword::WrongTimingOrOrder;
      stateContext = "Init_PreFlightPowerOn";
      hazardRef = "H-01";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Init_PreFlightPowerOn,Avenger5_Safety::ca02_Pl40PneumaticReleaseCommand,Avenger5_Safety::hazard01_PrematureEsadSwitchState";
    }
  }

  part uca08_Pl40DualSwitchReleasedEarly {
    doc /* UCA-08: CA-02 DurationTooShortOrLong - PL-40 dual switches released < 2.0 s causing partial rail stroke and stall < 24 m/s [PL-40#p26]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-08";
      caId = "CA-02";
      guideword = StpaGuideword::DurationTooShortOrLong;
      stateContext = "Init_PreFlightPowerOn";
      hazardRef = "H-02";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Init_PreFlightPowerOn,Avenger5_Safety::ca02_Pl40PneumaticReleaseCommand,Avenger5_Safety::hazard02_FlightEnvelopeDeparture";
    }
  }

  part uca09_EsadSafeInhibitNotMaintained {
    doc /* UCA-09: CA-03 NotProvided - ESAD safe-state / inhibit gate not maintained when EO lock or link drops [A5 Manual#p88]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-09";
      caId = "CA-03";
      guideword = StpaGuideword::NotProvided;
      stateContext = "Nom_TerminalApproach";
      hazardRef = "H-01";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Nom_TerminalApproach,Avenger5_Safety::ca03_TerminalApproachAndEnableGate,Avenger5_Safety::hazard01_PrematureEsadSwitchState";
    }
  }

  part uca10_DscOrRs485BeforeSafeSep {
    doc /* UCA-10: CA-03 ProvidedUnsafe - RPI asserts DSC_IN1 or RS-485 Arm Enable prior to verified Arm Stage 2 safe separation [ESAD ICD#p23]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-10";
      caId = "CA-03";
      guideword = StpaGuideword::ProvidedUnsafe;
      stateContext = "Nom_AutoCruiseAndSearch";
      hazardRef = "H-01";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Nom_AutoCruiseAndSearch,Avenger5_Safety::ca03_TerminalApproachAndEnableGate,Avenger5_Safety::hazard01_PrematureEsadSwitchState";
    }
  }

  part uca11_EnableBeforeEoTrackGate {
    doc /* UCA-11: CA-03 WrongTimingOrOrder - Terminal enable asserted before 2-5 s EO seeker lock and elevation <= 15 deg gate [A5 Manual#p84]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-11";
      caId = "CA-03";
      guideword = StpaGuideword::WrongTimingOrOrder;
      stateContext = "Nom_TerminalApproach";
      hazardRef = "H-01";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Nom_TerminalApproach,Avenger5_Safety::ca03_TerminalApproachAndEnableGate,Avenger5_Safety::hazard01_PrematureEsadSwitchState";
    }
  }

  part uca12_DscOrConfirmHoldOutOfWindow {
    doc /* UCA-12: CA-03 DurationTooShortOrLong - DSC_IN1 1 kHz 2-pulse or Slide-to-Confirm timing out of bounds [ESAD ICD#p23]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-12";
      caId = "CA-03";
      guideword = StpaGuideword::DurationTooShortOrLong;
      stateContext = "Nom_TerminalApproach";
      hazardRef = "H-01";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Nom_TerminalApproach,Avenger5_Safety::ca03_TerminalApproachAndEnableGate,Avenger5_Safety::hazard01_PrematureEsadSwitchState";
    }
  }

  part uca13_ApproachAbortNotProvided {
    doc /* UCA-13: CA-04 NotProvided - Abort Approach waveoff omitted when dive airspeed > 55 m/s or EO lock lost [A5 Manual#p88-p90]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-13";
      caId = "CA-04";
      guideword = StpaGuideword::NotProvided;
      stateContext = "Nom_TerminalApproach";
      hazardRef = "H-02";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Nom_TerminalApproach,Avenger5_Safety::ca04_ApproachAbortAndWaveoffCommand,Avenger5_Safety::hazard02_FlightEnvelopeDeparture";
    }
  }

  part uca14_WaveoffCommandsExcessLoad {
    doc /* UCA-14: CA-04 ProvidedUnsafe - Abort Approach pull-up commands pitch/bank exceeding X-wing stall or structural load [Spec Sheet#p3]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-14";
      caId = "CA-04";
      guideword = StpaGuideword::ProvidedUnsafe;
      stateContext = "Nom_TerminalApproach";
      hazardRef = "H-02";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Nom_TerminalApproach,Avenger5_Safety::ca04_ApproachAbortAndWaveoffCommand,Avenger5_Safety::hazard02_FlightEnvelopeDeparture";
    }
  }

  part uca15_LateApproachAbort {
    doc /* UCA-15: CA-04 WrongTimingOrOrder - Abort Approach issued after safe waveoff altitude or standoff window expires [A5 Manual#p90]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-15";
      caId = "CA-04";
      guideword = StpaGuideword::WrongTimingOrOrder;
      stateContext = "Nom_TerminalApproach";
      hazardRef = "H-01";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Nom_TerminalApproach,Avenger5_Safety::ca04_ApproachAbortAndWaveoffCommand,Avenger5_Safety::hazard01_PrematureEsadSwitchState";
    }
  }

  part uca16_AbortHoldReleasedEarly {
    doc /* UCA-16: CA-04 DurationTooShortOrLong - 5 s Abort irreversible safeing hold released < 5.0 s leaving ESAD armed [A5 Manual#p90]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-16";
      caId = "CA-04";
      guideword = StpaGuideword::DurationTooShortOrLong;
      stateContext = "SafeHold_AbortOrFaultLatch";
      hazardRef = "H-01";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::SafeHold_AbortOrFaultLatch,Avenger5_Safety::ca04_ApproachAbortAndWaveoffCommand,Avenger5_Safety::hazard01_PrematureEsadSwitchState";
    }
  }

  part uca17_Can2SeriesChainOmission {
    doc /* UCA-17: CA-05 NotProvided - CAN 2 series splitter open circuit omits wing servos #5-#8 and dual RM3100/SKYE2 frames [Block Diagram#p1]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-17";
      caId = "CA-05";
      guideword = StpaGuideword::NotProvided;
      stateContext = "Nom_AutoCruiseAndSearch";
      hazardRef = "H-03";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Nom_AutoCruiseAndSearch,Avenger5_Safety::ca05_DroneCanSurfaceActuation,Avenger5_Safety::hazard03_AutopilotOrCan2ChainLoss";
    }
  }

  part uca18_SaturatedFinOrWingCommand {
    doc /* UCA-18: CA-05 ProvidedUnsafe - Corrupted or saturated CAN 1/CAN 2 surface command drives stall < 24 m/s or overspeed [Spec Sheet#p3]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-18";
      caId = "CA-05";
      guideword = StpaGuideword::ProvidedUnsafe;
      stateContext = "Nom_AutoCruiseAndSearch";
      hazardRef = "H-02";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Nom_AutoCruiseAndSearch,Avenger5_Safety::ca05_DroneCanSurfaceActuation,Avenger5_Safety::hazard02_FlightEnvelopeDeparture";
    }
  }

  part uca19_DroneCanActuationLate {
    doc /* UCA-19: CA-05 WrongTimingOrOrder - Delayed DroneCAN actuation frame exceeds 4 ms period and phase-margin lag budget [GAP-02]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-19";
      caId = "CA-05";
      guideword = StpaGuideword::WrongTimingOrOrder;
      stateContext = "Nom_AutoCruiseAndSearch";
      hazardRef = "H-03";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Nom_AutoCruiseAndSearch,Avenger5_Safety::ca05_DroneCanSurfaceActuation,Avenger5_Safety::hazard03_AutopilotOrCan2ChainLoss";
    }
  }

  part uca20_ServoBabblingPastFtti {
    doc /* UCA-20: CA-05 DurationTooShortOrLong - Stuck or babbling servo command holds surface deflection past 20 ms FTTI [Block Diagram#p1]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-20";
      caId = "CA-05";
      guideword = StpaGuideword::DurationTooShortOrLong;
      stateContext = "Nom_AutoCruiseAndSearch";
      hazardRef = "H-03";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Nom_AutoCruiseAndSearch,Avenger5_Safety::ca05_DroneCanSurfaceActuation,Avenger5_Safety::hazard03_AutopilotOrCan2ChainLoss";
    }
  }

  part uca21_SpoofedGnssOrGeofenceOmission {
    doc /* UCA-21: CA-06 NotProvided - GNSS disable / polygon geofence RTL containment omitted under spoofing [A5 Manual#p51, p63]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-21";
      caId = "CA-06";
      guideword = StpaGuideword::NotProvided;
      stateContext = "Deg_GnssDeniedOrLinkLoss";
      hazardRef = "H-04";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Deg_GnssDeniedOrLinkLoss,Avenger5_Safety::ca06_GeofenceAndSpoofContingencySwitch,Avenger5_Safety::hazard04_GeofenceOrSpoofExcursion";
    }
  }

  part uca22_DrVectorEntersExclusionZone {
    doc /* UCA-22: CA-06 ProvidedUnsafe - Inertial DR or rally vector commands flight path into geofence exclusion polygon [A5 Manual#p63]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-22";
      caId = "CA-06";
      guideword = StpaGuideword::ProvidedUnsafe;
      stateContext = "Deg_GnssDeniedOrLinkLoss";
      hazardRef = "H-04";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Deg_GnssDeniedOrLinkLoss,Avenger5_Safety::ca06_GeofenceAndSpoofContingencySwitch,Avenger5_Safety::hazard04_GeofenceOrSpoofExcursion";
    }
  }

  part uca23_LateSpoofIsolationSwitch {
    doc /* UCA-23: CA-06 WrongTimingOrOrder - Spoof isolation or C2 failsafe switch delayed past exclusion boundary buffer [A5 Manual#p51]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-23";
      caId = "CA-06";
      guideword = StpaGuideword::WrongTimingOrOrder;
      stateContext = "Deg_GnssDeniedOrLinkLoss";
      hazardRef = "H-04";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Deg_GnssDeniedOrLinkLoss,Avenger5_Safety::ca06_GeofenceAndSpoofContingencySwitch,Avenger5_Safety::hazard04_GeofenceOrSpoofExcursion";
    }
  }

  part uca24_GnssDeniedDrDriftExceeded {
    doc /* UCA-24: CA-06 DurationTooShortOrLong - GNSS-disable dead-reckoning held past INS drift bound without visual fix [A5 Manual#p51]. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-24";
      caId = "CA-06";
      guideword = StpaGuideword::DurationTooShortOrLong;
      stateContext = "Deg_GnssDeniedOrLinkLoss";
      hazardRef = "H-04";
      'references' = "Avenger5_ConOps::VehicleAndEsadLifecycle::Deg_GnssDeniedOrLinkLoss,Avenger5_Safety::ca06_GeofenceAndSpoofContingencySwitch,Avenger5_Safety::hazard04_GeofenceOrSpoofExcursion";
    }
  }

  part ls01_EpsEsad14VBrownout {
    doc /* Loss Scenario LS-01 for UCA-01. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-01";
      ucaId = "UCA-01";
      scenarioClass = ScenarioClass::Class2ExecutionOrPlant;
      opsRef = "OA-03";
      'references' = "Avenger5_Safety::uca01_EsadPbitRailNotProvided,Avenger5_Architecture::avenger5System::esad::esadPwrIn,Avenger5_Architecture::avenger5System::fl21_eps_to_esad,Avenger5_ConOps::oa03";
    }
  }

  part ls02_FaultyEsadPowerEnable {
    doc /* Loss Scenario LS-02 for UCA-02. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-02";
      ucaId = "UCA-02";
      scenarioClass = ScenarioClass::Class1FeedbackOrController;
      opsRef = "OA-03";
      'references' = "Avenger5_Safety::uca02_EsadEnableWithLatchedFault,Avenger5_Architecture::avenger5System::esad::rs485Bus,Avenger5_Architecture::avenger5System::fl17_rpi_to_esad,Avenger5_ConOps::oa03";
    }
  }

  part ls03_RbfOrderHumanSlip {
    doc /* Loss Scenario LS-03 for UCA-03. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-03";
      ucaId = "UCA-03";
      scenarioClass = ScenarioClass::Class2ExecutionOrPlant;
      opsRef = "OA-03";
      'references' = "Avenger5_Safety::uca03_PrematureRbf3Removal,Avenger5_Architecture::avenger5System::esad::rbf3KeyIn,Avenger5_Architecture::avenger5System::fl23_crew_to_esad,Avenger5_ConOps::oa03";
    }
  }

  part ls04_Rs485PollTimeout {
    doc /* Loss Scenario LS-04 for UCA-04. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-04";
      ucaId = "UCA-04";
      scenarioClass = ScenarioClass::Class1FeedbackOrController;
      opsRef = "OA-03";
      'references' = "Avenger5_Safety::uca04_EsadPbitPollWindowExceeded,Avenger5_Architecture::avenger5System::esad::rs485Bus,Avenger5_Architecture::avenger5System::fl17_rpi_to_esad,Avenger5_ConOps::oa03";
    }
  }

  part ls05_Pl40ValveStuckClosed {
    doc /* Loss Scenario LS-05 for UCA-05. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-05";
      ucaId = "UCA-05";
      scenarioClass = ScenarioClass::Class2ExecutionOrPlant;
      opsRef = "OA-04";
      'references' = "Avenger5_Safety::uca05_Pl40ReleaseNotProvided,Avenger5_Architecture::avenger5System::pl40Interlocks::pneumaticOut,Avenger5_Architecture::avenger5System::fl27_pl40_to_cat,Avenger5_ConOps::oa04";
    }
  }

  part ls06_Pl40InterlockBypass {
    doc /* Loss Scenario LS-06 for UCA-06. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-06";
      ucaId = "UCA-06";
      scenarioClass = ScenarioClass::Class2ExecutionOrPlant;
      opsRef = "OA-04";
      'references' = "Avenger5_Safety::uca06_Pl40TriggeredOutOfEnvelope,Avenger5_Architecture::avenger5System::pl40Interlocks::pneumaticOut,Avenger5_Architecture::avenger5System::fl27_pl40_to_cat,Avenger5_ConOps::oa04";
    }
  }

  part ls07_Pl40CrewStandoffViolation {
    doc /* Loss Scenario LS-07 for UCA-07. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-07";
      ucaId = "UCA-07";
      scenarioClass = ScenarioClass::Class2ExecutionOrPlant;
      opsRef = "OA-04";
      'references' = "Avenger5_Safety::uca07_Pl40TriggeredBeforeCrewClear,Avenger5_Architecture::avenger5System::pl40Interlocks::crewIn,Avenger5_Architecture::avenger5System::fl23_crew_to_pl40,Avenger5_ConOps::oa04";
    }
  }

  part ls08_Pl40ShortTriggerPulse {
    doc /* Loss Scenario LS-08 for UCA-08. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-08";
      ucaId = "UCA-08";
      scenarioClass = ScenarioClass::Class2ExecutionOrPlant;
      opsRef = "OA-04";
      'references' = "Avenger5_Safety::uca08_Pl40DualSwitchReleasedEarly,Avenger5_Architecture::avenger5System::pl40Interlocks::pneumaticOut,Avenger5_Architecture::avenger5System::fl26_pl40_to_crew,Avenger5_ConOps::oa04";
    }
  }

  part ls09_EsadInhibitOmittedOnLoss {
    doc /* Loss Scenario LS-09 for UCA-09. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-09";
      ucaId = "UCA-09";
      scenarioClass = ScenarioClass::Class1FeedbackOrController;
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::uca09_EsadSafeInhibitNotMaintained,Avenger5_Architecture::avenger5System::esad::rtaInhibitIn,Avenger5_Architecture::avenger5System::fl16_rta_to_esad,Avenger5_ConOps::oa07";
    }
  }

  part ls10_PrematureRpiEnable {
    doc /* Loss Scenario LS-10 for UCA-10. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-10";
      ucaId = "UCA-10";
      scenarioClass = ScenarioClass::Class1FeedbackOrController;
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::uca10_DscOrRs485BeforeSafeSep,Avenger5_Architecture::avenger5System::esad::dscArmIn,Avenger5_Architecture::avenger5System::fl19_rpi_to_esad_dsc,Avenger5_ConOps::oa07";
    }
  }

  part ls11_PreEoLockEnable {
    doc /* Loss Scenario LS-11 for UCA-11. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-11";
      ucaId = "UCA-11";
      scenarioClass = ScenarioClass::Class1FeedbackOrController;
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::uca11_EnableBeforeEoTrackGate,Avenger5_Architecture::avenger5System::esad::dscArmIn,Avenger5_Architecture::avenger5System::fl19_rpi_to_esad_dsc,Avenger5_ConOps::oa07";
    }
  }

  part ls12_DscPulseTimingDrift {
    doc /* Loss Scenario LS-12 for UCA-12. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-12";
      ucaId = "UCA-12";
      scenarioClass = ScenarioClass::Class1FeedbackOrController;
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::uca12_DscOrConfirmHoldOutOfWindow,Avenger5_Architecture::avenger5System::esad::dscArmIn,Avenger5_Architecture::avenger5System::fl19_rpi_to_esad_dsc,Avenger5_ConOps::oa07";
    }
  }

  part ls13_ApproachAbortOmitted {
    doc /* Loss Scenario LS-13 for UCA-13. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-13";
      ucaId = "UCA-13";
      scenarioClass = ScenarioClass::Class1FeedbackOrController;
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::uca13_ApproachAbortNotProvided,Avenger5_Architecture::avenger5System::fcc::radioSerialPort,Avenger5_Architecture::avenger5System::fl06_dl_to_fcc,Avenger5_ConOps::oa07";
    }
  }

  part ls14_WaveoffOverstressPullup {
    doc /* Loss Scenario LS-14 for UCA-14. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-14";
      ucaId = "UCA-14";
      scenarioClass = ScenarioClass::Class1FeedbackOrController;
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::uca14_WaveoffCommandsExcessLoad,Avenger5_Architecture::avenger5System::fcc::radioSerialPort,Avenger5_Architecture::avenger5System::fl06_dl_to_fcc,Avenger5_ConOps::oa07";
    }
  }

  part ls15_ApproachAirspeedOverrun {
    doc /* Loss Scenario LS-15 for UCA-15. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-15";
      ucaId = "UCA-15";
      scenarioClass = ScenarioClass::Class1FeedbackOrController;
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::uca15_LateApproachAbort,Avenger5_Architecture::avenger5System::fcc::radioSerialPort,Avenger5_Architecture::avenger5System::fl06_dl_to_fcc,Avenger5_ConOps::oa07";
    }
  }

  part ls16_TruncatedAbortSafeHold {
    doc /* Loss Scenario LS-16 for UCA-16. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-16";
      ucaId = "UCA-16";
      scenarioClass = ScenarioClass::Class1FeedbackOrController;
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::uca16_AbortHoldReleasedEarly,Avenger5_Architecture::avenger5System::fcc::radioSerialPort,Avenger5_Architecture::avenger5System::fl06_dl_to_fcc,Avenger5_ConOps::oa07";
    }
  }

  part ls17_Can2ConnectorSeparation {
    doc /* Loss Scenario LS-17 for UCA-17. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-17";
      ucaId = "UCA-17";
      scenarioClass = ScenarioClass::Class2ExecutionOrPlant;
      opsRef = "OA-05";
      'references' = "Avenger5_Safety::uca17_Can2SeriesChainOmission,Avenger5_Architecture::avenger5System::actuators::can2WingIn,Avenger5_Architecture::avenger5System::fl15_fcc_to_act,Avenger5_ConOps::oa05";
    }
  }

  part ls18_SaturatedControlSurfaceCmd {
    doc /* Loss Scenario LS-18 for UCA-18. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-18";
      ucaId = "UCA-18";
      scenarioClass = ScenarioClass::Class1FeedbackOrController;
      opsRef = "OA-05";
      'references' = "Avenger5_Safety::uca18_SaturatedFinOrWingCommand,Avenger5_Architecture::avenger5System::actuators::can2WingIn,Avenger5_Architecture::avenger5System::fl15_fcc_to_act,Avenger5_ConOps::oa05";
    }
  }

  part ls19_DroneCanBusJitterLag {
    doc /* Loss Scenario LS-19 for UCA-19. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-19";
      ucaId = "UCA-19";
      scenarioClass = ScenarioClass::Class1FeedbackOrController;
      opsRef = "OA-05";
      'references' = "Avenger5_Safety::uca19_DroneCanActuationLate,Avenger5_Architecture::avenger5System::actuators::can2WingIn,Avenger5_Architecture::avenger5System::fl15_fcc_to_act,Avenger5_ConOps::oa05";
    }
  }

  part ls20_CanServoBabbleFault {
    doc /* Loss Scenario LS-20 for UCA-20. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-20";
      ucaId = "UCA-20";
      scenarioClass = ScenarioClass::Class2ExecutionOrPlant;
      opsRef = "OA-05";
      'references' = "Avenger5_Safety::uca20_ServoBabblingPastFtti,Avenger5_Architecture::avenger5System::actuators::can2WingIn,Avenger5_Architecture::avenger5System::fl15_fcc_to_act,Avenger5_ConOps::oa05";
    }
  }

  part ls21_GnssSpoofAndLinkTimeout {
    doc /* Loss Scenario LS-21 for UCA-21. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-21";
      ucaId = "UCA-21";
      scenarioClass = ScenarioClass::Class1FeedbackOrController;
      opsRef = "OA-06";
      'references' = "Avenger5_Safety::uca21_SpoofedGnssOrGeofenceOmission,Avenger5_Architecture::avenger5System::fcc::gnssSerialPort,Avenger5_Architecture::avenger5System::fl10_nav_to_fcc,Avenger5_ConOps::oa06";
    }
  }

  part ls22_DrWaypointExclusionViolation {
    doc /* Loss Scenario LS-22 for UCA-22. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-22";
      ucaId = "UCA-22";
      scenarioClass = ScenarioClass::Class1FeedbackOrController;
      opsRef = "OA-06";
      'references' = "Avenger5_Safety::uca22_DrVectorEntersExclusionZone,Avenger5_Architecture::avenger5System::fcc::gnssSerialPort,Avenger5_Architecture::avenger5System::fl10_nav_to_fcc,Avenger5_ConOps::oa06";
    }
  }

  part ls23_DelayedSpoofIsolation {
    doc /* Loss Scenario LS-23 for UCA-23. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-23";
      ucaId = "UCA-23";
      scenarioClass = ScenarioClass::Class1FeedbackOrController;
      opsRef = "OA-06";
      'references' = "Avenger5_Safety::uca23_LateSpoofIsolationSwitch,Avenger5_Architecture::avenger5System::fcc::gnssSerialPort,Avenger5_Architecture::avenger5System::fl10_nav_to_fcc,Avenger5_ConOps::oa06";
    }
  }

  part ls24_UnboundedInsDriftTimeout {
    doc /* Loss Scenario LS-24 for UCA-24. */
    @RAAML::STPA::LossScenario {
      lsId = "LS-24";
      ucaId = "UCA-24";
      scenarioClass = ScenarioClass::Class2ExecutionOrPlant;
      opsRef = "OA-06";
      'references' = "Avenger5_Safety::uca24_GnssDeniedDrDriftExceeded,Avenger5_Architecture::avenger5System::fcc::gnssSerialPort,Avenger5_Architecture::avenger5System::fl10_nav_to_fcc,Avenger5_ConOps::oa06";
    }
  }

  part sc01_EnforceRbfPowerOrder {
    doc /* Safety Constraint SC-01 mitigating H-01 during OA-03. */
    @RAAML::STPA::SafetyConstraint {
      scId = "SC-01";
      hazardRef = "H-01";
      fttiS = 0.050 [s];
      opsRef = "OA-03";
      'references' = "Avenger5_Safety::hazard01_PrematureEsadSwitchState,Avenger5_Architecture::avenger5System::esad::rbf3KeyIn,Avenger5_Safety::ls02_FaultyEsadPowerEnable,Avenger5_Safety::ls03_RbfOrderHumanSlip";
    }
    attribute dtDet = 0.010 [s];
    attribute dtIso = 0.010 [s];
    attribute dtLat = 0.010 [s];
  }

  part sc02_EnforceSafeSepBeforeDsc {
    doc /* Safety Constraint SC-02 mitigating H-01 during OA-07. */
    @RAAML::STPA::SafetyConstraint {
      scId = "SC-02";
      hazardRef = "H-01";
      fttiS = 0.050 [s];
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::hazard01_PrematureEsadSwitchState,Avenger5_Architecture::avenger5System::esad::dscArmIn,Avenger5_Safety::ls09_EsadInhibitOmittedOnLoss,Avenger5_Safety::ls10_PrematureRpiEnable,Avenger5_Safety::ls11_PreEoLockEnable,Avenger5_Safety::ls12_DscPulseTimingDrift";
    }
    attribute dtDet = 0.010 [s];
    attribute dtIso = 0.010 [s];
    attribute dtLat = 0.010 [s];
  }

  part sc03_EnforcePl40LaunchEnvelope {
    doc /* Safety Constraint SC-03 mitigating H-02 during OA-04. */
    @RAAML::STPA::SafetyConstraint {
      scId = "SC-03";
      hazardRef = "H-02";
      fttiS = 0.060 [s];
      opsRef = "OA-04";
      'references' = "Avenger5_Safety::hazard02_FlightEnvelopeDeparture,Avenger5_Architecture::avenger5System::pl40Interlocks::pneumaticOut,Avenger5_Safety::ls05_Pl40ValveStuckClosed,Avenger5_Safety::ls06_Pl40InterlockBypass,Avenger5_Safety::ls07_Pl40CrewStandoffViolation,Avenger5_Safety::ls08_Pl40ShortTriggerPulse";
    }
    attribute dtDet = 0.010 [s];
    attribute dtIso = 0.010 [s];
    attribute dtLat = 0.010 [s];
  }

  part sc04_EnforceCan2FallbackControl {
    doc /* Safety Constraint SC-04 mitigating H-03 during OA-05. */
    @RAAML::STPA::SafetyConstraint {
      scId = "SC-04";
      hazardRef = "H-03";
      fttiS = 0.050 [s];
      opsRef = "OA-05";
      'references' = "Avenger5_Safety::hazard03_AutopilotOrCan2ChainLoss,Avenger5_Architecture::avenger5System::actuators::can2WingIn,Avenger5_Safety::ls17_Can2ConnectorSeparation,Avenger5_Safety::ls18_SaturatedControlSurfaceCmd,Avenger5_Safety::ls19_DroneCanBusJitterLag,Avenger5_Safety::ls20_CanServoBabbleFault";
    }
    attribute dtDet = 0.010 [s];
    attribute dtIso = 0.010 [s];
    attribute dtLat = 0.010 [s];
  }

  part sc05_EnforceApproachSpeedAndAbort {
    doc /* Safety Constraint SC-05 mitigating H-02 during OA-07. */
    @RAAML::STPA::SafetyConstraint {
      scId = "SC-05";
      hazardRef = "H-02";
      fttiS = 0.060 [s];
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::hazard02_FlightEnvelopeDeparture,Avenger5_Architecture::avenger5System::fcc::radioSerialPort,Avenger5_Safety::ls13_ApproachAbortOmitted,Avenger5_Safety::ls14_WaveoffOverstressPullup,Avenger5_Safety::ls15_ApproachAirspeedOverrun,Avenger5_Safety::ls16_TruncatedAbortSafeHold";
    }
    attribute dtDet = 0.010 [s];
    attribute dtIso = 0.010 [s];
    attribute dtLat = 0.010 [s];
  }

  part sc06_EnforceEsadRailAndCrcWatchdog {
    doc /* Safety Constraint SC-06 mitigating H-05 during OA-05. */
    @RAAML::STPA::SafetyConstraint {
      scId = "SC-06";
      hazardRef = "H-05";
      fttiS = 0.050 [s];
      opsRef = "OA-05";
      'references' = "Avenger5_Safety::hazard05_EsadBrownoutOrBusLoss,Avenger5_Architecture::avenger5System::esad::esadPwrIn,Avenger5_Safety::ls01_EpsEsad14VBrownout,Avenger5_Safety::ls04_Rs485PollTimeout";
    }
    attribute dtDet = 0.010 [s];
    attribute dtIso = 0.010 [s];
    attribute dtLat = 0.010 [s];
  }

  part sc07_EnforceGeofenceAndInsFallback {
    doc /* Safety Constraint SC-07 mitigating H-04 during OA-06. */
    @RAAML::STPA::SafetyConstraint {
      scId = "SC-07";
      hazardRef = "H-04";
      fttiS = 0.060 [s];
      opsRef = "OA-06";
      'references' = "Avenger5_Safety::hazard04_GeofenceOrSpoofExcursion,Avenger5_Architecture::avenger5System::fcc::gnssSerialPort,Avenger5_Safety::ls21_GnssSpoofAndLinkTimeout,Avenger5_Safety::ls22_DrWaypointExclusionViolation,Avenger5_Safety::ls23_DelayedSpoofIsolation,Avenger5_Safety::ls24_UnboundedInsDriftTimeout";
    }
    attribute dtDet = 0.010 [s];
    attribute dtIso = 0.010 [s];
    attribute dtLat = 0.010 [s];
  }

  part csc01_EsadUndervoltageInhibitGuard {
    doc /* Controller Constraint CSC-01 for UCA-01. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-01";
      ucaId = "UCA-01";
      negatedGuard = "MUST hold ESAD SAFE and raise telemetry warning if ESAD VDC_IN drops <= 14.0 V";
      opsRef = "OA-03";
      'references' = "Avenger5_Safety::uca01_EsadPbitRailNotProvided";
    }
  }

  part csc02_EsadFaultLatchInhibitGuard {
    doc /* Controller Constraint CSC-02 for UCA-02. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-02";
      ucaId = "UCA-02";
      negatedGuard = "MUST NOT allow ESAD enable or HV charging while FaultStates non-zero or HV >= 50 V";
      opsRef = "OA-03";
      'references' = "Avenger5_Safety::uca02_EsadEnableWithLatchedFault";
    }
  }

  part csc03_Rbf3PowerLockoutGuard {
    doc /* Controller Constraint CSC-03 for UCA-03. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-03";
      ucaId = "UCA-03";
      negatedGuard = "MUST NOT allow ESAD RBF #3 removal while Power RBF #2 is inserted or PBIT incomplete";
      opsRef = "OA-03";
      'references' = "Avenger5_Safety::uca03_PrematureRbf3Removal";
    }
  }

  part csc04_Rs485ExchangeWatchdogGuard {
    doc /* Controller Constraint CSC-04 for UCA-04. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-04";
      ucaId = "UCA-04";
      negatedGuard = "MUST NOT proceed past PBIT if RS-485 EXCHANGE reply exceeds 5 ms or frame timeout 10 ms";
      opsRef = "OA-03";
      'references' = "Avenger5_Safety::uca04_EsadPbitPollWindowExceeded";
    }
  }

  part csc05_Pl40ThrustValveInterlockGuard {
    doc /* Controller Constraint CSC-05 for UCA-05. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-05";
      ucaId = "UCA-05";
      negatedGuard = "MUST NOT command rail launch thrust while PL-40 Valve 4 closed or release omitted";
      opsRef = "OA-04";
      'references' = "Avenger5_Safety::uca05_Pl40ReleaseNotProvided";
    }
  }

  part csc06_Pl40TriggerInterlockGuard {
    doc /* Controller Constraint CSC-06 for UCA-06. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-06";
      ucaId = "UCA-06";
      negatedGuard = "MUST NOT fire PL-40 outside 13-14 bar, with carriage pin inserted, or props unfolded";
      opsRef = "OA-04";
      'references' = "Avenger5_Safety::uca06_Pl40TriggeredOutOfEnvelope";
    }
  }

  part csc07_Pl40CrewStandoffGuard {
    doc /* Controller Constraint CSC-07 for UCA-07. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-07";
      ucaId = "UCA-07";
      negatedGuard = "MUST NOT release PL-40 before crew confirms rear anchor foot standoff and RBF checklist";
      opsRef = "OA-04";
      'references' = "Avenger5_Safety::uca07_Pl40TriggeredBeforeCrewClear";
    }
  }

  part csc08_Pl40DualSwitchHoldGuard {
    doc /* Controller Constraint CSC-08 for UCA-08. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-08";
      ucaId = "UCA-08";
      negatedGuard = "MUST NOT latch launch stroke if dual trigger switches held < 2.0 s";
      opsRef = "OA-04";
      'references' = "Avenger5_Safety::uca08_Pl40DualSwitchReleasedEarly";
    }
  }

  part csc09_EsadSafeHoldOnTrackLossGuard {
    doc /* Controller Constraint CSC-09 for UCA-09. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-09";
      ucaId = "UCA-09";
      negatedGuard = "MUST assert RTA SafeHold inhibit to ESAD immediately upon EO track or link loss";
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::uca09_EsadSafeInhibitNotMaintained";
    }
  }

  part csc10_DscArmStage2Guard {
    doc /* Controller Constraint CSC-10 for UCA-10. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-10";
      ucaId = "UCA-10";
      negatedGuard = "MUST NOT drive DSC_IN1 or RS485 ArmEnable until SafeDistanceExceed and ArmStage2 verified";
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::uca10_DscOrRs485BeforeSafeSep";
    }
  }

  part csc11_EoLockBeforeEnableGuard {
    doc /* Controller Constraint CSC-11 for UCA-11. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-11";
      ucaId = "UCA-11";
      negatedGuard = "MUST NOT assert terminal arm enable prior to 2-5 s EO seeker lock and elevation <= 15 deg";
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::uca11_EnableBeforeEoTrackGate";
    }
  }

  part csc12_DscPulseTimingGuard {
    doc /* Controller Constraint CSC-12 for UCA-12. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-12";
      ucaId = "UCA-12";
      negatedGuard = "MUST NOT accept DSC_IN1 outside 1 kHz 2-pulse timing window or unconfirmed Slide-to-Confirm";
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::uca12_DscOrConfirmHoldOutOfWindow";
    }
  }

  part csc13_ApproachAbortTriggerGuard {
    doc /* Controller Constraint CSC-13 for UCA-13. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-13";
      ucaId = "UCA-13";
      negatedGuard = "MUST trigger Abort Approach waveoff if airspeed > 55 m/s or EO lock fails";
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::uca13_ApproachAbortNotProvided";
    }
  }

  part csc14_WaveoffLoadLimiterGuard {
    doc /* Controller Constraint CSC-14 for UCA-14. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-14";
      ucaId = "UCA-14";
      negatedGuard = "MUST NOT command waveoff pitch or bank angles exceeding airframe stall/load limits";
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::uca14_WaveoffCommandsExcessLoad";
    }
  }

  part csc15_ApproachAirspeedCapGuard {
    doc /* Controller Constraint CSC-15 for UCA-15. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-15";
      ucaId = "UCA-15";
      negatedGuard = "MUST clamp target airspeed <= 55 m/s in Nom_TerminalApproach and command Abort Approach on overrun";
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::uca15_LateApproachAbort";
    }
  }

  part csc16_AbortFiveSecondLatchGuard {
    doc /* Controller Constraint CSC-16 for UCA-16. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-16";
      ucaId = "UCA-16";
      negatedGuard = "MUST NOT clear Abort safeing hold prior to continuous 5.0 s hold confirmation";
      opsRef = "OA-07";
      'references' = "Avenger5_Safety::uca16_AbortHoldReleasedEarly";
    }
  }

  part csc17_Can2LossFallbackGuard {
    doc /* Controller Constraint CSC-17 for UCA-17. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-17";
      ucaId = "UCA-17";
      negatedGuard = "MUST trigger dead-reckoning / fin-only stabilization if CAN 2 chain heartbeat stalls";
      opsRef = "OA-05";
      'references' = "Avenger5_Safety::uca17_Can2SeriesChainOmission";
    }
  }

  part csc18_SurfaceDeflectionEnvelopeGuard {
    doc /* Controller Constraint CSC-18 for UCA-18. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-18";
      ucaId = "UCA-18";
      negatedGuard = "MUST NOT pass saturated or CRC-corrupted CAN 1/CAN 2 surface commands";
      opsRef = "OA-05";
      'references' = "Avenger5_Safety::uca18_SaturatedFinOrWingCommand";
    }
  }

  part csc19_DroneCanPhaseMarginGuard {
    doc /* Controller Constraint CSC-19 for UCA-19. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-19";
      ucaId = "UCA-19";
      negatedGuard = "MUST NOT exceed 4 ms CAN actuation period or drop effective phase margin <= 0";
      opsRef = "OA-05";
      'references' = "Avenger5_Safety::uca19_DroneCanActuationLate";
    }
  }

  part csc20_ServoBabbleIsolationGuard {
    doc /* Controller Constraint CSC-20 for UCA-20. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-20";
      ucaId = "UCA-20";
      negatedGuard = "MUST NOT allow babbling servo actuator command beyond 20 ms FTTI without isolation";
      opsRef = "OA-05";
      'references' = "Avenger5_Safety::uca20_ServoBabblingPastFtti";
    }
  }

  part csc21_GeofenceAndSpoofRejectionGuard {
    doc /* Controller Constraint CSC-21 for UCA-21. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-21";
      ucaId = "UCA-21";
      negatedGuard = "MUST isolate inconsistent GNSS and command polygon SafeHold/RTL turn before boundary breach";
      opsRef = "OA-06";
      'references' = "Avenger5_Safety::uca21_SpoofedGnssOrGeofenceOmission";
    }
  }

  part csc22_ExclusionPolygonVectorGuard {
    doc /* Controller Constraint CSC-22 for UCA-22. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-22";
      ucaId = "UCA-22";
      negatedGuard = "MUST NOT issue DR or Rally trajectory intersecting active exclusion geofence polygons";
      opsRef = "OA-06";
      'references' = "Avenger5_Safety::uca22_DrVectorEntersExclusionZone";
    }
  }

  part csc23_SpoofSwitchLatencyGuard {
    doc /* Controller Constraint CSC-23 for UCA-23. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-23";
      ucaId = "UCA-23";
      negatedGuard = "MUST NOT delay EKF2 spoof rejection beyond 200 ms containment margin";
      opsRef = "OA-06";
      'references' = "Avenger5_Safety::uca23_LateSpoofIsolationSwitch";
    }
  }

  part csc24_GnssDeniedInsDriftGuard {
    doc /* Controller Constraint CSC-24 for UCA-24. */
    @RAAML::STPA::ControllerConstraint {
      cscId = "CSC-24";
      ucaId = "UCA-24";
      negatedGuard = "MUST NOT remain in uncompensated GNSS-denied DR beyond drift margin without visual fix or SafeHold";
      opsRef = "OA-06";
      'references' = "Avenger5_Safety::uca24_GnssDeniedDrDriftExceeded";
    }
  }

  part errSrc01_Can2DaisyChain {
    @RAAML::EMV2::Emv2ErrorSource {
      errId = "ERR-CAN2-DAISYCHAIN";
      devClass = Emv2DeviationClass::Omission;
      subQual = ShardSubQualifier::SilentDrop;
      baseRatePerS = 0.0000010 [s^-1];
      'references' = "Avenger5_Architecture::avenger5System::actuators::can2WingIn";
    }
  }

  part errSrc02_EsadRailDroop {
    @RAAML::EMV2::Emv2ErrorSource {
      errId = "ERR-ESAD-RAIL-14V-DROOP";
      devClass = Emv2DeviationClass::ValueDeviation;
      subQual = ShardSubQualifier::ValueLow;
      baseRatePerS = 0.0000005 [s^-1];
      'references' = "Avenger5_Architecture::avenger5System::esad::rs485Bus,Avenger5_Architecture::avenger5System::esad::esadPwrIn";
    }
  }

  part errSrc03_GnssSpoofDrift {
    @RAAML::EMV2::Emv2ErrorSource {
      errId = "ERR-GNSS-SPOOF-DRIFT";
      devClass = Emv2DeviationClass::ValueDeviation;
      subQual = ShardSubQualifier::ValueCorrupt;
      baseRatePerS = 0.0000020 [s^-1];
      'references' = "Avenger5_Architecture::avenger5System::fcc::gnssSerialPort";
    }
  }

  part prop01_Rs485Corrupt {
    @RAAML::EMV2::Emv2Propagation {
      propId = "PROP-RS485-CORRUPT";
      inDev = Emv2DeviationClass::ValueDeviation;
      outDev = Emv2DeviationClass::Commission;
      portRef = "Avenger5_Architecture::avenger5System::esad::rs485Bus";
      'references' = "Avenger5_Architecture::avenger5System::esad::rs485Bus";
    }
  }

  part hyperedge01_Can2SeriesBus {
    @RAAML::EMV2::Emv2Hyperedge {
      edgeId = "EDGE-CAN2-SERIES-BUS";
      topology = HyperedgeTopology::Broadcast1ToN;
      betaCcf = 0.05;
      groupRatePerS = 0.0000015 [s^-1];
      'references' = "Avenger5_Architecture::avenger5System::fcc::can2WingOut,Avenger5_Architecture::avenger5System::actuators::can2WingIn";
    }
  }

  part fmeda01_FccLockup {
    @RAAML::FMEDA::FmedaMode {
      fmId = "FM-01-FCC-LOCKUP";
      severity = 5;
      alphaShare = 0.15;
      betaHaz = 0.40;
      dcPrimary = 0.995;
      dcLatent = 0.95;
      hft = 1;
      lambdaCompPerS = 0.000000000010 [s^-1];
      ctmcSimplex = true;
      'references' = "Avenger5_ConOps::oa05,Avenger5_Safety::hazard02_FlightEnvelopeDeparture,Avenger5_Safety::hazard04_GeofenceOrSpoofExcursion";
    }
  }

  part fmeda02_EsadInterlock {
    @RAAML::FMEDA::FmedaMode {
      fmId = "FM-02-ESAD-INTERLOCK";
      severity = 5;
      alphaShare = 0.10;
      betaHaz = 0.35;
      dcPrimary = 0.996;
      dcLatent = 0.96;
      hft = 1;
      lambdaCompPerS = 0.000000000005 [s^-1];
      ctmcSimplex = true;
      'references' = "Avenger5_ConOps::oa05,Avenger5_Safety::hazard01_PrematureEsadSwitchState";
    }
  }

  part fmeda05_EsadSafeSepChannel {
    @RAAML::FMEDA::FmedaMode {
      fmId = "FM-05-ESAD-SAFESEP";
      severity = 5;
      alphaShare = 0.10;
      betaHaz = 0.35;
      dcPrimary = 0.996;
      dcLatent = 0.96;
      hft = 1;
      lambdaCompPerS = 0.000000000005 [s^-1];
      ctmcSimplex = true;
      'references' = "Avenger5_ConOps::oa05,Avenger5_Safety::hazard01_PrematureEsadSwitchState";
    }
  }

  part fmeda03_Can2DaisyChain {
    @RAAML::FMEDA::FmedaMode {
      fmId = "FM-03-CAN2-DAISYCHAIN";
      severity = 4;
      alphaShare = 0.15;
      betaHaz = 0.50;
      dcPrimary = 0.994;
      dcLatent = 0.94;
      hft = 1;
      lambdaCompPerS = 0.000000000010 [s^-1];
      ctmcSimplex = true;
      'references' = "Avenger5_ConOps::oa05,Avenger5_Safety::hazard02_FlightEnvelopeDeparture,Avenger5_Safety::hazard03_AutopilotOrCan2ChainLoss";
    }
  }

  part fmeda06_FccCan1Control {
    @RAAML::FMEDA::FmedaMode {
      fmId = "FM-06-FCC-CAN1";
      severity = 4;
      alphaShare = 0.15;
      betaHaz = 0.40;
      dcPrimary = 0.995;
      dcLatent = 0.95;
      hft = 1;
      lambdaCompPerS = 0.000000000010 [s^-1];
      ctmcSimplex = true;
      'references' = "Avenger5_ConOps::oa05,Avenger5_Safety::hazard03_AutopilotOrCan2ChainLoss";
    }
  }

  part fmeda07_NavGnssInsFault {
    @RAAML::FMEDA::FmedaMode {
      fmId = "FM-07-NAV-GNSS-INS";
      severity = 4;
      alphaShare = 0.10;
      betaHaz = 0.45;
      dcPrimary = 0.994;
      dcLatent = 0.94;
      hft = 1;
      lambdaCompPerS = 0.000000000010 [s^-1];
      ctmcSimplex = true;
      'references' = "Avenger5_ConOps::oa05,Avenger5_Safety::hazard04_GeofenceOrSpoofExcursion";
    }
  }

  part fmeda04_Eps14VRail {
    @RAAML::FMEDA::FmedaMode {
      fmId = "FM-04-EPS-14V-RAIL";
      severity = 4;
      alphaShare = 0.15;
      betaHaz = 0.45;
      dcPrimary = 0.994;
      dcLatent = 0.94;
      hft = 1;
      lambdaCompPerS = 0.000000000006 [s^-1];
      ctmcSimplex = true;
      'references' = "Avenger5_ConOps::oa05,Avenger5_Safety::hazard05_EsadBrownoutOrBusLoss";
    }
  }

  part fmeda08_Rs485BusFault {
    @RAAML::FMEDA::FmedaMode {
      fmId = "FM-08-RS485-BUS";
      severity = 4;
      alphaShare = 0.10;
      betaHaz = 0.45;
      dcPrimary = 0.994;
      dcLatent = 0.94;
      hft = 1;
      lambdaCompPerS = 0.000000000006 [s^-1];
      ctmcSimplex = true;
      'references' = "Avenger5_ConOps::oa05,Avenger5_Safety::hazard05_EsadBrownoutOrBusLoss";
    }
  }

  part ftaGate01_H01InadvSwitch {
    @RAAML::FTA::FaultTreeGate {
      gateId = "FTG-01-H01";
      gateKind = FaultTreeGateKind::AndGate;
      kRequired = 2;
      nInputs = 2;
      ccfBeta = 0.01;
      'references' = "Avenger5_Safety::hazard01_PrematureEsadSwitchState,Avenger5_Safety::fmeda02_EsadInterlock,Avenger5_Safety::fmeda05_EsadSafeSepChannel";
    }
  }

  part ftaGate02_H02EnvelopeDep {
    @RAAML::FTA::FaultTreeGate {
      gateId = "FTG-02-H02";
      gateKind = FaultTreeGateKind::AndGate;
      kRequired = 2;
      nInputs = 2;
      ccfBeta = 0.01;
      'references' = "Avenger5_Safety::hazard02_FlightEnvelopeDeparture,Avenger5_Safety::fmeda01_FccLockup,Avenger5_Safety::fmeda03_Can2DaisyChain";
    }
  }

  part ftaGate03_H03Can2Loss {
    @RAAML::FTA::FaultTreeGate {
      gateId = "FTG-03-H03";
      gateKind = FaultTreeGateKind::AndGate;
      kRequired = 2;
      nInputs = 2;
      ccfBeta = 0.01;
      'references' = "Avenger5_Safety::hazard03_AutopilotOrCan2ChainLoss,Avenger5_Safety::fmeda03_Can2DaisyChain,Avenger5_Safety::fmeda06_FccCan1Control";
    }
  }

  part ftaGate04_H04GeofenceExc {
    @RAAML::FTA::FaultTreeGate {
      gateId = "FTG-04-H04";
      gateKind = FaultTreeGateKind::AndGate;
      kRequired = 2;
      nInputs = 2;
      ccfBeta = 0.01;
      'references' = "Avenger5_Safety::hazard04_GeofenceOrSpoofExcursion,Avenger5_Safety::fmeda01_FccLockup,Avenger5_Safety::fmeda07_NavGnssInsFault";
    }
  }

  part ftaGate05_H05EsadBusLoss {
    @RAAML::FTA::FaultTreeGate {
      gateId = "FTG-05-H05";
      gateKind = FaultTreeGateKind::AndGate;
      kRequired = 2;
      nInputs = 2;
      ccfBeta = 0.01;
      'references' = "Avenger5_Safety::hazard05_EsadBrownoutOrBusLoss,Avenger5_Safety::fmeda04_Eps14VRail,Avenger5_Safety::fmeda08_Rs485BusFault";
    }
  }

  part def RtaSafetyCalculators {
    doc /* Coherent SI evaluators for FMEDA conservation, 6-state CTMC bound, Risk Lattice, CRC-32C watchdog, ZCBF flux, RMA utilization/WCRT, and phase margin. */

    calc fmedaCheck : RAAML::FMEDA::FmedaRowConserv {
      in lambdaP = 0.0000010 [s^-1];
      in alphaJ = 0.30;
      in betaJ = 0.40;
      in dcS = 0.99;
      in dcJ = 0.90;
    }

    calc ctmcBound : RAAML::RTA::Ctmc6StateCatProb {
      in lambdaPrim = 0.0000000000010 [s^-1];
      in lambdaMon = 0.0000000000002 [s^-1];
      in lambdaSw = 0.0000000000001 [s^-1];
      in betaCcf = 0.01;
      in dcMon = 0.995;
      in tSwSimplex = 0.010 [s];
      in tRollback = 0.020 [s];
      in tMission = 5400.0 [s];
    }

    calc riskTier : RAAML::RTA::RiskLatticePhi {
      in sev = 5;
      in exp = 3;
      in ctrl = 3;
    }

    calc crcCheck : RAAML::RTA::Crc32cUndetectedRate {
      in lPayloadBits = 256 [bit];
      in rCrcBits = 32 [bit];
      in fTx = 100.0 [Hz];
      in pBitErr = 0.00001;
      in aMult = 1.0;
      in dHamming = 6;
      in nMiss = 3;
      in tFrame = 0.010 [s];
      in tSw = 0.005 [s];
    }

    calc zcbfBarrier : RAAML::RTA::ZcbfFluxEval {
      in hVal = 0.25;
      in lfH = 0.10 [s^-1];
      in lgHU = 0.20 [s^-1];
      in gammaDecay = 2.0 [s^-1];
    }

    calc rmaUtil : RAAML::RTA::RmaUtilization {
      in prevUtil = 0.0;
      in wcetS = 0.0008 [s];
      in blockingS = 0.0002 [s];
      in periodS = 0.004 [s];
    }

    calc rmaWcrt : RAAML::RTA::RmaWcrtBound {
      in wcetS = 0.0008 [s];
      in blockingS = 0.0002 [s];
      in hpInterferenceS = 0.0005 [s];
    }

    calc phaseMargin : RAAML::RTA::PhaseMarginEff {
      in phi0Rad = 0.7854 [rad];
      in omegaCRadPerS = 10.0 [rad/s];
      in rActS = 0.004 [s];
      in tActS = 0.005 [s];
    }
  }

  part rtaSafetyCalculators : RtaSafetyCalculators {
    doc /* Instantiated RTA safety evaluator container for 5-pass verification. */
  }
}
