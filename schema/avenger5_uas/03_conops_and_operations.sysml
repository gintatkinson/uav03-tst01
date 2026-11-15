package Avenger5_ConOps {
  doc /* Pre-STPA ConOps, METL (>= 10), lifecycle state machine with SafeHold reachability, operational activities (>= 12 allocated), scenarios, and emergency rules (>= 7). */

  private import ISQ::*;
  private import RAAML::*;
  private import Avenger5_Quantities::*;
  private import Avenger5_Architecture::*;

  occurrence def OperationalTransition {
    doc /* Operational exchange or state transition occurrence (OPTX) connecting CONOPS operational activities and subsystems. */
  }

  constraint envOperatingEnvelope {
    doc /* Pre-STPA operational environmental envelope (C7): 253.15 K to 323.15 K, <= 12 m/s ground wind, <= 28 m/s cruise wind, <= 5000 m ceiling [Spec Sheet#p3]. */
  }

  view conopsView {
    doc /* Canonical Pre-STPA ConOps viewpoint over operational scenarios, METL, and 3-ring authority hierarchy. */
  }

  state def VehicleAndEsadLifecycle :> RAAML::LifecycleStateMachine {
    doc /* Unified Avenger 5 mission mode and ESAD interlock state machine [A5 Prep#p7-p24; A5 Manual#p59-p90; ESAD ICD#p22]. */

    entry; then Init_SafeAssembly;

    state Init_SafeAssembly {
      @RAAML::ThreeRing::LifecycleRole { role = ModeRole::Init; terminalSafe = false; requiresSupReset = false; }
      doc /* Power RBF #2 and ESAD RBF #3 installed; airframe in transport box or PL-40 rail with carriage pin inserted. */
    }

    state Init_PreFlightPowerOn {
      @RAAML::ThreeRing::LifecycleRole { role = ModeRole::Init; terminalSafe = false; requiresSupReset = false; }
      doc /* Power RBF #2 pulled; Cube orange+, RPI CM5004032, and ESAD powered; ESAD in SAFE state awaiting 8 preconditions before RBF #3 removal. */
    }

    state Nom_AutoCruiseAndSearch {
      @RAAML::ThreeRing::LifecycleRole { role = ModeRole::Nom; terminalSafe = false; requiresSupReset = false; }
      doc /* Launch complete; AUTO/GUIDED/LOITER flight at 30-31 m/s; ESAD transitions Stage 1 -> Stage 2 after safe separation distance exceeded. */
    }

    state Nom_TerminalApproach {
      @RAAML::ThreeRing::LifecycleRole { role = ModeRole::Nom; terminalSafe = false; requiresSupReset = false; }
      doc /* Target tracked on EO 2-5 s, airspeed <= 55 m/s, elevation <= 15 deg, ESAD enabled by dual HITL Slide-to-Confirm. */
    }

    state Deg_GnssDeniedOrLinkLoss {
      @RAAML::ThreeRing::LifecycleRole { role = ModeRole::Deg; terminalSafe = false; requiresSupReset = false; }
      doc /* Dead-reckoning INS (map/camera visual position fixes) or RTL/Rally diversion on GCS failsafe timeout. */
    }

    state SafeHold_AbortOrFaultLatch {
      @RAAML::ThreeRing::LifecycleRole { role = ModeRole::SafeHold; terminalSafe = true; requiresSupReset = true; }
      doc /* Latched SafeHold on ESAD fault/abort (5 s held irreversible safeing), premature RBF #3 fault, or pre-launch scrub safeing [GAP-05]. */
    }

    transition t_init_to_power first Init_SafeAssembly then Init_PreFlightPowerOn;
    transition t_power_to_nom first Init_PreFlightPowerOn then Nom_AutoCruiseAndSearch;
    transition t_nom_to_approach first Nom_AutoCruiseAndSearch then Nom_TerminalApproach;
    transition t_approach_to_nom first Nom_TerminalApproach then Nom_AutoCruiseAndSearch;
    transition t_nom_to_deg first Nom_AutoCruiseAndSearch then Deg_GnssDeniedOrLinkLoss;
    transition t_deg_gnss_spoof first Nom_AutoCruiseAndSearch then Deg_GnssDeniedOrLinkLoss;
    transition t_deg_to_nom first Deg_GnssDeniedOrLinkLoss then Nom_AutoCruiseAndSearch;
    transition t_init_to_safehold first Init_SafeAssembly then SafeHold_AbortOrFaultLatch;
    transition t_power_to_safehold first Init_PreFlightPowerOn then SafeHold_AbortOrFaultLatch;
    transition t_nom_to_safehold first Nom_AutoCruiseAndSearch then SafeHold_AbortOrFaultLatch;
    transition t_nom_geofence_safehold first Nom_AutoCruiseAndSearch then SafeHold_AbortOrFaultLatch;
    transition t_approach_to_safehold first Nom_TerminalApproach then SafeHold_AbortOrFaultLatch;
    transition t_deg_to_safehold first Deg_GnssDeniedOrLinkLoss then SafeHold_AbortOrFaultLatch;
  }

  action def OA01_CatapultAndGcsPrep {
    doc /* PreFlight-SitePrep: Assemble PL-40 at 12 deg into headwind, charge to 13-14 bar, erect and calibrate SwarmC2 antenna rotator. */
  }

  action def OA02_AirframeEsdPayloadBatteryAssembly {
    doc /* PreFlight-Integration: Touch ESD earth point, mount 4.98 kg mission payload with 1.5 mm HEX ESAD leads, verify 49-50 V ID/QR matched 12S2P battery, fold prop rearward. */
  }

  action def OA03_SequentialRbfAndDiagnostics {
    doc /* PreFlight-PowerAndInterlockGate: Remove front RBF #1 then Power RBF #2 (10 m radio separation), pass all 6 SwarmC2 checklist groups, clear danger zone, pull ESAD RBF #3 after power-on PBIT. */
  }

  action def OA04_PneumaticLaunchAndClimb {
    doc /* Launch: Open PL-40 Valve 4, pull carriage safety pin, depress dual switches >= 2 s with crew behind rear anchor foot, climb above 50 m min waypoint alt. */
  }

  action def OA05_CruiseTelemetryAndGeofenceFlight {
    doc /* EnRoute: Maintain AUTO/GUIDED/LOITER navigation inside inclusion and clear of exclusion polygons at 30-31 m/s cruise; poll ESAD RS-485 EXCHANGE at 100 Hz. */
  }

  action def OA06_GnssDeniedSpoofContingency {
    doc /* DegradedOps: Disable spoofed GNSS, navigate by inertial DR with manual map/camera fixes, or execute C2/GPS timeout RTL. */
  }

  action def OA07_TerminalTrackApproachOrWaveoff {
    doc /* Terminal: Verify 6 approach preconditions (EO lock 2-5 s, elevation <= 15 deg, speed <= 55 m/s, ESAD enabled) or trigger Abort Approach / 5 s held Abort. */
  }

  action def OA08_PreLaunchScrubAndHangfireSafing {
    doc /* Contingency-GroundSafeing: Close PL-40 Valve 4, keep trigger covers closed, re-insert carriage pin then ESAD RBF #3, verify PBIT/EXCHANGE SAFE and HV < 50 V before de-powering RBF #2. */
  }

  action def OA09_PreFlightPitotAndCompassCalibration {
    doc /* PreFlight-SensorChecks: Verify CUAV SKYE2 pitot calm airspeed < 3 m/s and airflow test > 10 m/s, dual RM3100 compass consistency, and Septentrio RTK/GNSS fix. */
  }

  action def OA10_AntennaAutoFollowAndRadioControl {
    doc /* EnRoute-Comms: Manage DTC 4.4-5.0 GHz 2 W AES-256 link, OMNI/DIR MARS 23 dBi antenna switching, and 0.5 deg fine rotator calibration in Auto Follow. */
  }

  action def OA11_EsadSafeSeparationTransition {
    doc /* EnRoute-Safety: Confirm umbilical open (SS1), flight timer and safe distance exceeded (SS2), and DSC_IN1 enable lockout enforcement until Stage 2. */
  }

  action def OA12_EmergencyFlightTerminationAndAbort {
    doc /* Emergency-SafeHold: Execute 5 s held irreversible ESAD Abort or flight-termination safeing Slide-to-Confirm, or post-flight auto-discharge return to SAFE state. */
  }

  use case def OperationalScenarioDef {
    doc /* Base scenario definition per Pre-STPA C5 operational thread coverage. */
  }

  occurrence optx01_SwarmC2Uplink : OperationalTransition {
    doc /* OperationalTransition OPTX-01: Supervisory mission, safety-gate, and abort uplink over encrypted 4.4-5.0 GHz C2 link [A5 Manual#p59-p90]. */
  }
  occurrence optx02_EsadSafetyExchange : OperationalTransition {
    doc /* OperationalTransition OPTX-02: 100 Hz RS-485 EXCHANGE / PBIT / HIGHVOLTAGE safety handshake between RPI CM5 and ESAD [ESAD ICD#p15-p27]. */
  }

  state lcEsad : VehicleAndEsadLifecycle;
  state lcPowerMeter : VehicleAndEsadLifecycle;
  state lcPl40Interlocks : VehicleAndEsadLifecycle;
  state lcRtaMonitor : VehicleAndEsadLifecycle;
  state lcFcc : VehicleAndEsadLifecycle;
  state lcEps : VehicleAndEsadLifecycle;
  state lcNavSuite : VehicleAndEsadLifecycle;
  state lcActuators : VehicleAndEsadLifecycle;
  state lcRpi : VehicleAndEsadLifecycle;
  state lcSeeker : VehicleAndEsadLifecycle;
  state lcDatalink : VehicleAndEsadLifecycle;
  state lcGcs : VehicleAndEsadLifecycle;

  allocate lcEsad to Avenger5_Architecture::avenger5System::esad;
  allocate lcPowerMeter to Avenger5_Architecture::avenger5System::powerMeter;
  allocate lcPl40Interlocks to Avenger5_Architecture::avenger5System::pl40Interlocks;
  allocate lcRtaMonitor to Avenger5_Architecture::avenger5System::rtaMonitor;
  allocate lcFcc to Avenger5_Architecture::avenger5System::fcc;
  allocate lcEps to Avenger5_Architecture::avenger5System::eps;
  allocate lcNavSuite to Avenger5_Architecture::avenger5System::navSuite;
  allocate lcActuators to Avenger5_Architecture::avenger5System::actuators;
  allocate lcRpi to Avenger5_Architecture::avenger5System::rpi;
  allocate lcSeeker to Avenger5_Architecture::avenger5System::seeker;
  allocate lcDatalink to Avenger5_Architecture::avenger5System::datalink;
  allocate lcGcs to Avenger5_Architecture::avenger5System::gcs;

  action oa01 : RAAML::OperationalActivity {
    @RAAML::ThreeRing::OperationalActivity {
      oaId = "OA-01";
      phase = "PreFlight-SitePrep";
      summary = "Assemble PL-40 at 12 deg into headwind, charge to 13-14 bar, erect and calibrate SwarmC2 antenna rotator.";
    }
    @RAAML::ThreeRing::ActionPartition { kind = ActionKind::Aux; }
  }
  action oa02 : RAAML::OperationalActivity {
    @RAAML::ThreeRing::OperationalActivity {
      oaId = "OA-02";
      phase = "PreFlight-Integration";
      summary = "Touch ESD earth point, mount 4.98 kg mission payload with 1.5 mm HEX ESAD leads, verify 49-50 V ID/QR matched 12S2P battery, fold prop rearward.";
    }
    @RAAML::ThreeRing::ActionPartition { kind = ActionKind::Aux; }
  }
  action oa03 : RAAML::OperationalActivity {
    @RAAML::ThreeRing::OperationalActivity {
      oaId = "OA-03";
      phase = "PreFlight-PowerAndInterlockGate";
      summary = "Remove front RBF #1 then Power RBF #2 (10 m radio separation), pass all 6 SwarmC2 checklist groups, clear danger zone, pull ESAD RBF #3 after power-on PBIT.";
    }
    @RAAML::ThreeRing::ActionPartition { kind = ActionKind::Focus; }
  }
  action oa04 : RAAML::OperationalActivity {
    @RAAML::ThreeRing::OperationalActivity {
      oaId = "OA-04";
      phase = "Launch";
      summary = "Open PL-40 Valve 4, pull carriage safety pin, depress dual switches >= 2 s with crew behind rear anchor foot, climb above 50 m min waypoint alt.";
    }
    @RAAML::ThreeRing::ActionPartition { kind = ActionKind::Control; }
  }
  action oa05 : RAAML::OperationalActivity {
    @RAAML::ThreeRing::OperationalActivity {
      oaId = "OA-05";
      phase = "EnRoute";
      summary = "Maintain AUTO/GUIDED/LOITER navigation inside inclusion and clear of exclusion polygons at 30-31 m/s cruise; poll ESAD RS-485 EXCHANGE at 100 Hz.";
    }
    @RAAML::ThreeRing::ActionPartition { kind = ActionKind::Control; }
  }
  action oa06 : RAAML::OperationalActivity {
    @RAAML::ThreeRing::OperationalActivity {
      oaId = "OA-06";
      phase = "DegradedOps";
      summary = "Disable spoofed GNSS, navigate by inertial DR with manual map/camera fixes, or execute C2/GPS timeout RTL.";
    }
    @RAAML::ThreeRing::ActionPartition { kind = ActionKind::Control; }
  }
  action oa07 : RAAML::OperationalActivity {
    @RAAML::ThreeRing::OperationalActivity {
      oaId = "OA-07";
      phase = "Terminal";
      summary = "Verify 6 approach preconditions (EO lock 2-5 s, elevation <= 15 deg, speed <= 55 m/s, ESAD enabled) or trigger Abort Approach / 5 s held Abort.";
    }
    @RAAML::ThreeRing::ActionPartition { kind = ActionKind::Focus; }
  }
  action oa08 : RAAML::OperationalActivity {
    @RAAML::ThreeRing::OperationalActivity {
      oaId = "OA-08";
      phase = "Contingency-GroundSafeing";
      summary = "Close PL-40 Valve 4, keep trigger covers closed, re-insert carriage pin then ESAD RBF #3, verify PBIT/EXCHANGE SAFE and HV < 50 V before de-powering RBF #2.";
    }
    @RAAML::ThreeRing::ActionPartition { kind = ActionKind::Ops; }
  }
  action oa09 : RAAML::OperationalActivity {
    @RAAML::ThreeRing::OperationalActivity {
      oaId = "OA-09";
      phase = "PreFlight-SensorChecks";
      summary = "Verify CUAV SKYE2 pitot calm airspeed < 3 m/s and airflow test > 10 m/s, dual RM3100 compass consistency, and Septentrio RTK/GNSS fix.";
    }
    @RAAML::ThreeRing::ActionPartition { kind = ActionKind::Aux; }
  }
  action oa10 : RAAML::OperationalActivity {
    @RAAML::ThreeRing::OperationalActivity {
      oaId = "OA-10";
      phase = "EnRoute-Comms";
      summary = "Manage DTC 4.4-5.0 GHz 2 W AES-256 link, OMNI/DIR MARS 23 dBi antenna switching, and 0.5 deg fine rotator calibration in Auto Follow.";
    }
    @RAAML::ThreeRing::ActionPartition { kind = ActionKind::Ops; }
  }
  action oa11 : RAAML::OperationalActivity {
    @RAAML::ThreeRing::OperationalActivity {
      oaId = "OA-11";
      phase = "EnRoute-Safety";
      summary = "Confirm umbilical open (SS1), flight timer and safe distance exceeded (SS2), and DSC_IN1 enable lockout enforcement until Stage 2.";
    }
    @RAAML::ThreeRing::ActionPartition { kind = ActionKind::Control; }
  }
  action oa12 : RAAML::OperationalActivity {
    @RAAML::ThreeRing::OperationalActivity {
      oaId = "OA-12";
      phase = "Emergency-SafeHold";
      summary = "Execute 5 s held irreversible ESAD Abort or flight-termination safeing Slide-to-Confirm, or post-flight auto-discharge return to SAFE state.";
    }
    @RAAML::ThreeRing::ActionPartition { kind = ActionKind::Control; }
  }

  allocate oa01 to Avenger5_Architecture::avenger5System::pl40Interlocks;
  allocate oa02 to Avenger5_Architecture::avenger5System::powerMeter;
  allocate oa03 to Avenger5_Architecture::avenger5System::esad;
  allocate oa04 to Avenger5_Architecture::avenger5System::pl40Interlocks;
  allocate oa05 to Avenger5_Architecture::avenger5System::fcc;
  allocate oa06 to Avenger5_Architecture::avenger5System::navSuite;
  allocate oa07 to Avenger5_Architecture::avenger5System::seeker;
  allocate oa08 to Avenger5_Architecture::avenger5System::esad;
  allocate oa09 to Avenger5_Architecture::avenger5System::navSuite;
  allocate oa10 to Avenger5_Architecture::avenger5System::datalink;
  allocate oa11 to Avenger5_Architecture::avenger5System::rpi;
  allocate oa12 to Avenger5_Architecture::avenger5System::rtaMonitor;

  use case scn01NominalMission : OperationalScenarioDef {
    doc /* Nominal end-to-end flight scenario: site prep -> RBF sequence -> pneumatic launch -> cruise -> terminal approach. */
    actor crew subsets Avenger5_Architecture::launchCrew;
    actor pilotActor subsets Avenger5_Architecture::pilot;
    actor payActor subsets Avenger5_Architecture::payloadOp;
    action step01 : OA01_CatapultAndGcsPrep;
    action step02 : OA02_AirframeEsdPayloadBatteryAssembly;
    action step03 : OA09_PreFlightPitotAndCompassCalibration;
    action step04 : OA03_SequentialRbfAndDiagnostics;
    action step05 : OA04_PneumaticLaunchAndClimb;
    action step06 : OA10_AntennaAutoFollowAndRadioControl;
    action step07 : OA05_CruiseTelemetryAndGeofenceFlight;
    action step08 : OA11_EsadSafeSeparationTransition;
    action step09 : OA07_TerminalTrackApproachOrWaveoff;
    allocate step01 to Avenger5_Architecture::avenger5System::pl40Interlocks;
    allocate step02 to Avenger5_Architecture::avenger5System::powerMeter;
    allocate step03 to Avenger5_Architecture::avenger5System::navSuite;
    allocate step04 to Avenger5_Architecture::avenger5System::esad;
    allocate step05 to Avenger5_Architecture::avenger5System::pl40Interlocks;
    allocate step06 to Avenger5_Architecture::avenger5System::datalink;
    allocate step07 to Avenger5_Architecture::avenger5System::fcc;
    allocate step08 to Avenger5_Architecture::avenger5System::rpi;
    allocate step09 to Avenger5_Architecture::avenger5System::seeker;
    satisfy Avenger5_Verification::req01;
    satisfy Avenger5_Verification::req02;
    satisfy Avenger5_Verification::req03;
    satisfy Avenger5_Verification::req04;
    satisfy Avenger5_Verification::req05;
    satisfy Avenger5_Verification::req06;
  }

  use case scn02DegradedGnssAndLinkLoss : OperationalScenarioDef {
    doc /* Degraded mission scenario: GNSS spoofing INS dead-reckoning and C2 link timeout RTL/Rally diversion. */
    actor pilotActor subsets Avenger5_Architecture::pilot;
    actor bmsActor subsets Avenger5_Architecture::bmsNet;
    action step10 : OA05_CruiseTelemetryAndGeofenceFlight;
    action step11 : OA06_GnssDeniedSpoofContingency;
    action step12 : OA10_AntennaAutoFollowAndRadioControl;
    allocate step10 to Avenger5_Architecture::avenger5System::fcc;
    allocate step11 to Avenger5_Architecture::avenger5System::navSuite;
    allocate step12 to Avenger5_Architecture::avenger5System::datalink;
    satisfy Avenger5_Verification::req07;
  }

  use case scn03EmergencyAbortAndScrub : OperationalScenarioDef {
    doc /* Emergency mission scenario: approach > 55 m/s waveoff, 5 s irreversible ESAD Abort, and pre-launch scrub safeing [GAP-05]. */
    actor crew subsets Avenger5_Architecture::launchCrew;
    actor pilotActor subsets Avenger5_Architecture::pilot;
    actor payActor subsets Avenger5_Architecture::payloadOp;
    action step13 : OA07_TerminalTrackApproachOrWaveoff;
    action step14 : OA12_EmergencyFlightTerminationAndAbort;
    action step15 : OA08_PreLaunchScrubAndHangfireSafing;
    allocate step13 to Avenger5_Architecture::avenger5System::seeker;
    allocate step14 to Avenger5_Architecture::avenger5System::rtaMonitor;
    allocate step15 to Avenger5_Architecture::avenger5System::esad;
    satisfy Avenger5_Verification::req05;
    satisfy Avenger5_Verification::req07;
  }

  requirement met01_MtowKg : RAAML::MissionEssentialTask {
    subject sys subsets Avenger5_Architecture::avenger5System;
    @RAAML::ThreeRing::MissionTask { metId = "MET-01"; metricName = "MaximumTakeoffWeightKg"; thresholdVal = 17.0; objectiveVal = 16.5; unitSym = "kg"; }
  }
  requirement met02_EnduranceS : RAAML::MissionEssentialTask {
    subject sys subsets Avenger5_Architecture::avenger5System;
    @RAAML::ThreeRing::MissionTask { metId = "MET-02"; metricName = "FlightEnduranceS"; thresholdVal = 4320.0; objectiveVal = 5400.0; unitSym = "s"; }
  }
  requirement met03_RlosRangeM : RAAML::MissionEssentialTask {
    subject sys subsets Avenger5_Architecture::avenger5System;
    @RAAML::ThreeRing::MissionTask { metId = "MET-03"; metricName = "RlosCommandRangeM"; thresholdVal = 60000.0; objectiveVal = 90000.0; unitSym = "m"; }
  }
  requirement met04_TerminalCepM : RAAML::MissionEssentialTask {
    subject sys subsets Avenger5_Architecture::avenger5System;
    @RAAML::ThreeRing::MissionTask { metId = "MET-04"; metricName = "StationaryTerminalCepM"; thresholdVal = 0.50; objectiveVal = 0.30; unitSym = "m"; }
  }
  requirement met05_Pl40PressurePa : RAAML::MissionEssentialTask {
    subject sys subsets Avenger5_Architecture::avenger5System;
    @RAAML::ThreeRing::MissionTask { metId = "MET-05"; metricName = "Pl40NominalPressurePa"; thresholdVal = 1300000.0; objectiveVal = 1400000.0; unitSym = "Pa"; }
  }
  requirement met06_LaunchVelMps : RAAML::MissionEssentialTask {
    subject sys subsets Avenger5_Architecture::avenger5System;
    @RAAML::ThreeRing::MissionTask { metId = "MET-06"; metricName = "Pl40ExitVelocityMps"; thresholdVal = 23.0; objectiveVal = 24.5; unitSym = "m/s"; }
  }
  requirement met07_ServiceCeilingM : RAAML::MissionEssentialTask {
    subject sys subsets Avenger5_Architecture::avenger5System;
    @RAAML::ThreeRing::MissionTask { metId = "MET-07"; metricName = "ServiceCeilingM"; thresholdVal = 3000.0; objectiveVal = 5000.0; unitSym = "m"; }
  }
  requirement met08_GroundWindTolMps : RAAML::MissionEssentialTask {
    subject sys subsets Avenger5_Architecture::avenger5System;
    @RAAML::ThreeRing::MissionTask { metId = "MET-08"; metricName = "GroundWindToleranceMps"; thresholdVal = 10.0; objectiveVal = 12.0; unitSym = "m/s"; }
  }
  requirement met09_CruiseSpeedMps : RAAML::MissionEssentialTask {
    subject sys subsets Avenger5_Architecture::avenger5System;
    @RAAML::ThreeRing::MissionTask { metId = "MET-09"; metricName = "NominalCruiseSpeedMps"; thresholdVal = 30.0; objectiveVal = 31.0; unitSym = "m/s"; }
  }
  requirement met10_BingoEnergyReserveRatio : RAAML::MissionEssentialTask {
    subject sys subsets Avenger5_Architecture::avenger5System;
    @RAAML::ThreeRing::MissionTask { metId = "MET-10"; metricName = "BingoEnergyReserveRatio"; thresholdVal = 0.20; objectiveVal = 0.25; unitSym = "1"; }
  }

  allocate met01_MtowKg to Avenger5_Architecture::avenger5System::actuators;
  allocate met02_EnduranceS to Avenger5_Architecture::avenger5System::eps;
  allocate met03_RlosRangeM to Avenger5_Architecture::avenger5System::gcs;
  allocate met04_TerminalCepM to Avenger5_Architecture::avenger5System::seeker;
  allocate met05_Pl40PressurePa to Avenger5_Architecture::avenger5System::pl40Interlocks;
  allocate met06_LaunchVelMps to Avenger5_Architecture::avenger5System::pl40Interlocks;
  allocate met07_ServiceCeilingM to Avenger5_Architecture::avenger5System::navSuite;
  allocate met08_GroundWindTolMps to Avenger5_Architecture::avenger5System::fcc;
  allocate met09_CruiseSpeedMps to Avenger5_Architecture::avenger5System::fcc;
  allocate met10_BingoEnergyReserveRatio to Avenger5_Architecture::avenger5System::powerMeter;

  occurrence emg01_RbfUnpoweredPbitFault {
    @RAAML::ThreeRing::EmergencyRule { emgId = "EMG-01"; triggerCondition = "ESAD_RBF_REMOVED_UNPOWERED or PBIT_FAULT_BIT0"; targetMode = ModeRole::SafeHold; maxReactionS = 0.010 [s]; }
  }
  occurrence emg02_PrematureDscEnable {
    @RAAML::ThreeRing::EmergencyRule { emgId = "EMG-02"; triggerCondition = "DSC_IN1_RECEIVED_BEFORE_SAFE_SEP_STAGE2"; targetMode = ModeRole::SafeHold; maxReactionS = 0.005 [s]; }
  }
  occurrence emg03_ApproachOverspeedTrackLoss {
    @RAAML::ThreeRing::EmergencyRule { emgId = "EMG-03"; triggerCondition = "APPROACH_AIRSPEED_GT_55_MPS or EO_TRACK_LOST"; targetMode = ModeRole::SafeHold; maxReactionS = 0.050 [s]; }
  }
  occurrence emg04_GcsLinkLossTimeout {
    @RAAML::ThreeRing::EmergencyRule { emgId = "EMG-04"; triggerCondition = "GCS_LINK_LOST_GE_FAILSAFE_TIMEOUT"; targetMode = ModeRole::Deg; maxReactionS = 1.000 [s]; }
  }
  occurrence emg05_GnssSpoofInconsistent {
    @RAAML::ThreeRing::EmergencyRule { emgId = "EMG-05"; triggerCondition = "GNSS_SPOOF_OR_EKF2_INCONSISTENT"; targetMode = ModeRole::Deg; maxReactionS = 0.200 [s]; }
  }
  occurrence emg06_PolygonGeofenceBreach {
    @RAAML::ThreeRing::EmergencyRule { emgId = "EMG-06"; triggerCondition = "POLYGON_GEOFENCE_BREACH_IMMINENT"; targetMode = ModeRole::SafeHold; maxReactionS = 0.020 [s]; }
  }
  occurrence emg07_Pl40PinOrOverAccel {
    @RAAML::ThreeRing::EmergencyRule { emgId = "EMG-07"; triggerCondition = "PL40_CARRIAGE_PIN_IN_ON_TRIGGER or PISTON_OVER_ACCEL"; targetMode = ModeRole::SafeHold; maxReactionS = 0.050 [s]; }
  }
}
