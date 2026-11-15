package Avenger5_Safety {
  doc /* Top-down STPA control-theoretic hazard analysis, bottom-up EMV2/4-way FMEDA/FTA, and RTA CTMC/RiskLattice/CRC-32C/RMA assurance evaluators. */

  private import ISQ::*;
  private import RAAML::*;
  private import Avenger5_Quantities::*;
  private import Avenger5_Architecture::*;
  private import Avenger5_ConOps::*;

  requirement loss01_LaunchCrewOrPublicHarm :> Avenger5_Architecture::avenger5System::scLaunchCrewZeroInadvertentEnable {
    doc /* System Loss L-01: Unintended ESAD actuation or airframe excursion injuring launch crew or uninvolved personnel. */
    @RAAML::STPA::Loss { lossId = "L-01"; severity = 5; stakeholderRef = "launchCrew"; }
    stakeholder st subsets Avenger5_Architecture::launchCrew;
  }

  requirement loss02_MissionAirworthinessLoss :> Avenger5_Architecture::avenger5System::scAirworthinessContainment {
    doc /* System Loss L-02: Uncontrolled flight termination, crash, or runway/rail launch failure damaging aircraft. */
    @RAAML::STPA::Loss { lossId = "L-02"; severity = 5; stakeholderRef = "pilot"; }
    stakeholder st subsets Avenger5_Architecture::pilot;
  }

  requirement loss03_MissionPayloadIntegrityLoss :> Avenger5_Architecture::avenger5System::scAirworthinessContainment {
    doc /* System Loss L-03: Inability to maintain controlled payload continuity or mission safe-state integrity. */
    @RAAML::STPA::Loss { lossId = "L-03"; severity = 4; stakeholderRef = "payloadOp"; }
    stakeholder st subsets Avenger5_Architecture::payloadOp;
  }

  part hazard01_PrematureEsadSwitchState {
    doc /* Hazard H-01: Inadvertent ESAD high-voltage switch closure or premature RBF/arm transition prior to verified safe separation. */
    @RAAML::STPA::Hazard {
      hazardId = "H-01";
      lossRefs = "L-01,L-02";
      envNegation = "Inadvertent ESAD high-voltage switch closure or premature RBF/arm transition prior to verified safe separation.";
    }
  }

  part hazard02_FlightEnvelopeDeparture {
    doc /* Hazard H-02: Uncontrolled airframe departure from flight envelope (stall < 24 m/s, overspeed > 55 m/s, or PL-40 misfire). */
    @RAAML::STPA::Hazard {
      hazardId = "H-02";
      lossRefs = "L-01,L-02";
      envNegation = "Uncontrolled airframe departure from flight envelope (stall < 24 m/s, overspeed > 55 m/s, or PL-40 misfire).";
    }
  }

  part hazard03_AutopilotOrCan2ChainLoss {
    doc /* Hazard H-03: Loss of Cube orange+ stabilization or CAN 2 series roll-servo / mag / pitot string in flight. */
    @RAAML::STPA::Hazard {
      hazardId = "H-03";
      lossRefs = "L-02,L-03";
      envNegation = "Loss of Cube orange+ stabilization or CAN 2 series roll-servo / mag / pitot string in flight.";
    }
  }

  part hazard04_GeofenceOrSpoofExcursion {
    doc /* Hazard H-04: Geofence excursion into excluded zone or collision due to spoofed GNSS / unmitigated C2 loss. */
    @RAAML::STPA::Hazard {
      hazardId = "H-04";
      lossRefs = "L-01,L-02";
      envNegation = "Geofence excursion into excluded zone or collision due to spoofed GNSS / unmitigated C2 loss.";
    }
  }

  part hazard05_EsadBrownoutOrBusLoss {
    doc /* Hazard H-05: ESAD brownout or silent telemetry loss across 14 V min-boundary EPS rail or unguarded RS-485 bus [GAP-01]. */
    @RAAML::STPA::Hazard {
      hazardId = "H-05";
      lossRefs = "L-02,L-03";
      envNegation = "ESAD brownout / silent telemetry loss across 14 V min-boundary EPS rail or unguarded RS-485 bus [GAP-01].";
    }
  }

  action ca01_EsadInterlockAndPowerGate {
    doc /* CA-01: Sequential RBF #2/#3 removal, EPS 14 V enable, and ESAD PBIT handshake (OA-03). */
    @RAAML::STPA::ControlAction { caId = "CA-01"; srcRank = 1.2; dstRank = 3.8; opsRef = "OA-03"; }
  }

  action ca02_Pl40PneumaticReleaseCommand {
    doc /* CA-02: Dual-switch PL-40 pneumatic catapult launch valve release (OA-04). */
    @RAAML::STPA::ControlAction { caId = "CA-02"; srcRank = 1.2; dstRank = 4.0; opsRef = "OA-04"; }
  }

  action ca03_TerminalApproachAndEnableGate {
    doc /* CA-03: SwarmC2 dual Slide-to-Confirm approval and RPI DSC_IN1 / RS-485 enable assertion (OA-07). */
    @RAAML::STPA::ControlAction { caId = "CA-03"; srcRank = 1.0; dstRank = 3.8; opsRef = "OA-07"; }
  }

  action ca04_ApproachAbortAndWaveoffCommand {
    doc /* CA-04: Pilot or FCC automated Abort Approach climb/loiter waveoff command (OA-07). */
    @RAAML::STPA::ControlAction { caId = "CA-04"; srcRank = 1.0; dstRank = 3.0; opsRef = "OA-07"; }
  }

  action ca05_DroneCanSurfaceActuation {
    doc /* CA-05: Cube orange+ CAN 1 fin and CAN 2 wing servo actuation commands (OA-05). */
    @RAAML::STPA::ControlAction { caId = "CA-05"; srcRank = 3.0; dstRank = 4.2; opsRef = "OA-05"; }
  }

  action ca06_GeofenceAndSpoofContingencySwitch {
    doc /* CA-06: GNSS disable dead-reckoning switch and polygon geofence boundary enforcement (OA-06). */
    @RAAML::STPA::ControlAction { caId = "CA-06"; srcRank = 2.0; dstRank = 3.0; opsRef = "OA-06"; }
  }

  part uca01_PrematureRbf3Removal {
    doc /* UCA-01: Wrong timing or order during OA-03 ESAD RBF #3 removal. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-01";
      caId = "CA-01";
      guideword = StpaGuideword::WrongTimingOrOrder;
      stateContext = "ESAD RBF #3 removed before Power RBF #2 and initial power-on PBIT pass [A5 Prep#p23].";
      hazardRef = "H-01";
    }
  }

  part uca02_DscOrRs485BeforeSafeSep {
    doc /* UCA-02: Unsafe enable provided prior to Arm Stage 2 safe separation. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-02";
      caId = "CA-03";
      guideword = StpaGuideword::ProvidedUnsafe;
      stateContext = "RPI asserts DSC_IN1 or RS-485 Arm Enable prior to verified Arm Stage 2 safe separation [ESAD ICD#p23].";
      hazardRef = "H-01";
    }
  }

  part uca03_Pl40TriggeredOutOfEnvelope {
    doc /* UCA-03: Unsafe PL-40 release provided with pin installed or pressure/crew unsafe. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-03";
      caId = "CA-02";
      guideword = StpaGuideword::ProvidedUnsafe;
      stateContext = "PL-40 triggered with carriage pin installed, prop unfolded, pressure out of 13-14 bar, or crew forward of rear foot.";
      hazardRef = "H-02";
    }
  }

  part uca04_Can2SeriesChainOmission {
    doc /* UCA-04: CAN 2 series actuator/sensor command omitted due to splitter break. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-04";
      caId = "CA-05";
      guideword = StpaGuideword::NotProvided;
      stateContext = "CAN 2 series splitter open circuit severs wing servos #5-#8 plus dual RM3100 mag/baro and SKYE2 pitot [GAP-01/Block Diagram].";
      hazardRef = "H-03";
    }
  }

  part uca05_LateApproachAbort {
    doc /* UCA-05: Excessive duration during Nom_TerminalApproach or delayed Abort Approach command. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-05";
      caId = "CA-04";
      guideword = StpaGuideword::DurationTooShortOrLong;
      stateContext = "Dive speed exceeds 55 m/s during Nom_TerminalApproach or late Abort Approach after safe waveoff window expires [A5 Manual#p88-p90].";
      hazardRef = "H-02";
    }
  }

  part uca06_Esad14VRailDroop {
    doc /* UCA-06: Regulated 14 V supply not sustained to ESAD J100 rail under load. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-06";
      caId = "CA-01";
      guideword = StpaGuideword::NotProvided;
      stateContext = "14 V EPS rail droops below ESAD 14.0 V GE_POW minimum under RS-485/HV charger transient [GAP-01].";
      hazardRef = "H-05";
    }
  }

  part uca07_SpoofedGnssOrGeofenceOmission {
    doc /* UCA-07: Spoofed GNSS accepted or geofence diversion omitted during C2/GNSS degradation. */
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-07";
      caId = "CA-06";
      guideword = StpaGuideword::NotProvided;
      stateContext = "System accepts inconsistent GNSS fixes or delays polygon geofence/RTL containment past exclusion margin [A5 Manual#p51, p63].";
      hazardRef = "H-04";
    }
  }

  part ls01_RbfOrderHumanSlip {
    doc /* Loss Scenario LS-01 for UCA-01. */
    @RAAML::STPA::LossScenario { lsId = "LS-01"; ucaId = "UCA-01"; scenarioClass = ScenarioClass::Class2ExecutionOrPlant; opsRef = "OA-03"; }
  }

  part ls02_PrematureRpiEnable {
    doc /* Loss Scenario LS-02 for UCA-02. */
    @RAAML::STPA::LossScenario { lsId = "LS-02"; ucaId = "UCA-02"; scenarioClass = ScenarioClass::Class1FeedbackOrController; opsRef = "OA-07"; }
  }

  part ls03_Pl40InterlockBypass {
    doc /* Loss Scenario LS-03 for UCA-03. */
    @RAAML::STPA::LossScenario { lsId = "LS-03"; ucaId = "UCA-03"; scenarioClass = ScenarioClass::Class2ExecutionOrPlant; opsRef = "OA-04"; }
  }

  part ls04_Can2ConnectorSeparation {
    doc /* Loss Scenario LS-04 for UCA-04. */
    @RAAML::STPA::LossScenario { lsId = "LS-04"; ucaId = "UCA-04"; scenarioClass = ScenarioClass::Class2ExecutionOrPlant; opsRef = "OA-05"; }
  }

  part ls05_ApproachAirspeedOverrun {
    doc /* Loss Scenario LS-05 for UCA-05. */
    @RAAML::STPA::LossScenario { lsId = "LS-05"; ucaId = "UCA-05"; scenarioClass = ScenarioClass::Class1FeedbackOrController; opsRef = "OA-07"; }
  }

  part ls06_EpsEsadBrownout {
    doc /* Loss Scenario LS-06 for UCA-06. */
    @RAAML::STPA::LossScenario { lsId = "LS-06"; ucaId = "UCA-06"; scenarioClass = ScenarioClass::Class2ExecutionOrPlant; opsRef = "OA-05"; }
  }

  part ls07_GnssSpoofAndLinkTimeout {
    doc /* Loss Scenario LS-07 for UCA-07. */
    @RAAML::STPA::LossScenario { lsId = "LS-07"; ucaId = "UCA-07"; scenarioClass = ScenarioClass::Class1FeedbackOrController; opsRef = "OA-06"; }
  }

  part sc01_EnforceRbfPowerOrder {
    doc /* Safety Constraint SC-01 mitigating H-01 during OA-03. */
    @RAAML::STPA::SafetyConstraint { scId = "SC-01"; hazardRef = "H-01"; fttiS = 0.010 [s]; opsRef = "OA-03"; }
  }

  part sc02_EnforceSafeSepBeforeDsc {
    doc /* Safety Constraint SC-02 mitigating H-01 during OA-07. */
    @RAAML::STPA::SafetyConstraint { scId = "SC-02"; hazardRef = "H-01"; fttiS = 0.005 [s]; opsRef = "OA-07"; }
  }

  part sc03_EnforcePl40LaunchEnvelope {
    doc /* Safety Constraint SC-03 mitigating H-02 during OA-04. */
    @RAAML::STPA::SafetyConstraint { scId = "SC-03"; hazardRef = "H-02"; fttiS = 0.050 [s]; opsRef = "OA-04"; }
  }

  part sc04_EnforceCan2FallbackControl {
    doc /* Safety Constraint SC-04 mitigating H-03 during OA-05. */
    @RAAML::STPA::SafetyConstraint { scId = "SC-04"; hazardRef = "H-03"; fttiS = 0.020 [s]; opsRef = "OA-05"; }
  }

  part sc05_EnforceApproachSpeedAndAbort {
    doc /* Safety Constraint SC-05 mitigating H-02 during OA-07. */
    @RAAML::STPA::SafetyConstraint { scId = "SC-05"; hazardRef = "H-02"; fttiS = 0.050 [s]; opsRef = "OA-07"; }
  }

  part sc06_EnforceEsadRailAndCrcWatchdog {
    doc /* Safety Constraint SC-06 mitigating H-05 during OA-05. */
    @RAAML::STPA::SafetyConstraint { scId = "SC-06"; hazardRef = "H-05"; fttiS = 0.010 [s]; opsRef = "OA-05"; }
  }

  part sc07_EnforceGeofenceAndInsFallback {
    doc /* Safety Constraint SC-07 mitigating H-04 during OA-06. */
    @RAAML::STPA::SafetyConstraint { scId = "SC-07"; hazardRef = "H-04"; fttiS = 0.020 [s]; opsRef = "OA-06"; }
  }

  part csc01_Rbf3PowerLockoutGuard {
    doc /* Controller Constraint CSC-01 for UCA-01. */
    @RAAML::STPA::ControllerConstraint { cscId = "CSC-01"; ucaId = "UCA-01"; negatedGuard = "MUST NOT allow ESAD RBF #3 removal while Power RBF #2 is inserted or PBIT incomplete"; opsRef = "OA-03"; }
  }

  part csc02_DscArmStage2Guard {
    doc /* Controller Constraint CSC-02 for UCA-02. */
    @RAAML::STPA::ControllerConstraint { cscId = "CSC-02"; ucaId = "UCA-02"; negatedGuard = "MUST NOT drive DSC_IN1 or RS485 ArmEnable until SafeDistanceExceed and ArmStage2 verified"; opsRef = "OA-07"; }
  }

  part csc03_Pl40TriggerInterlockGuard {
    doc /* Controller Constraint CSC-03 for UCA-03. */
    @RAAML::STPA::ControllerConstraint { cscId = "CSC-03"; ucaId = "UCA-03"; negatedGuard = "MUST NOT fire PL-40 outside 13-14 bar, with carriage pin inserted, or props unfolded"; opsRef = "OA-04"; }
  }

  part csc04_Can2LossFallbackGuard {
    doc /* Controller Constraint CSC-04 for UCA-04. */
    @RAAML::STPA::ControllerConstraint { cscId = "CSC-04"; ucaId = "UCA-04"; negatedGuard = "MUST trigger dead-reckoning / fin-only stabilization if CAN 2 chain heartbeat stalls"; opsRef = "OA-05"; }
  }

  part csc05_ApproachAirspeedCapGuard {
    doc /* Controller Constraint CSC-05 for UCA-05. */
    @RAAML::STPA::ControllerConstraint { cscId = "CSC-05"; ucaId = "UCA-05"; negatedGuard = "MUST clamp target airspeed <= 55 m/s in Nom_TerminalApproach and command Abort Approach on overrun"; opsRef = "OA-07"; }
  }

  part csc06_EsadUndervoltageInhibitGuard {
    doc /* Controller Constraint CSC-06 for UCA-06. */
    @RAAML::STPA::ControllerConstraint { cscId = "CSC-06"; ucaId = "UCA-06"; negatedGuard = "MUST hold ESAD SAFE and raise telemetry warning if ESAD VDC_IN drops <= 14.0 V"; opsRef = "OA-05"; }
  }

  part csc07_GeofenceAndSpoofRejectionGuard {
    doc /* Controller Constraint CSC-07 for UCA-07. */
    @RAAML::STPA::ControllerConstraint { cscId = "CSC-07"; ucaId = "UCA-07"; negatedGuard = "MUST isolate inconsistent GNSS and command polygon SafeHold/RTL turn before boundary breach"; opsRef = "OA-06"; }
  }

  part errSrc01_Can2DaisyChain {
    @RAAML::EMV2::Emv2ErrorSource {
      errId = "ERR-CAN2-DAISYCHAIN";
      devClass = Emv2DeviationClass::Omission;
      subQual = ShardSubQualifier::SilentDrop;
      baseRatePerS = 0.0000010 [s^-1];
    }
  }

  part errSrc02_EsadRailDroop {
    @RAAML::EMV2::Emv2ErrorSource {
      errId = "ERR-ESAD-RAIL-14V-DROOP";
      devClass = Emv2DeviationClass::ValueDeviation;
      subQual = ShardSubQualifier::ValueLow;
      baseRatePerS = 0.0000005 [s^-1];
    }
  }

  part errSrc03_GnssSpoofDrift {
    @RAAML::EMV2::Emv2ErrorSource {
      errId = "ERR-GNSS-SPOOF-DRIFT";
      devClass = Emv2DeviationClass::ValueDeviation;
      subQual = ShardSubQualifier::ValueCorrupt;
      baseRatePerS = 0.0000020 [s^-1];
    }
  }

  part prop01_Rs485Corrupt {
    @RAAML::EMV2::Emv2Propagation {
      propId = "PROP-RS485-CORRUPT";
      inDev = Emv2DeviationClass::ValueDeviation;
      outDev = Emv2DeviationClass::Commission;
      portRef = "Avenger5_Architecture::avenger5System::esad::rs485Bus";
    }
  }

  part hyperedge01_Can2SeriesBus {
    @RAAML::EMV2::Emv2Hyperedge {
      edgeId = "EDGE-CAN2-SERIES-BUS";
      topology = HyperedgeTopology::Broadcast1ToN;
      betaCcf = 0.05;
      groupRatePerS = 0.0000015 [s^-1];
    }
  }

  part fmeda01_FccLockup {
    @RAAML::FMEDA::FmedaMode {
      fmId = "FM-01-FCC-LOCKUP";
      severity = 5;
      alphaShare = 0.30;
      betaHaz = 0.40;
      dcPrimary = 0.99;
      dcLatent = 0.90;
      hft = 1;
      lambdaCompPerS = 0.0000010 [s^-1];
      ctmcSimplex = true;
    }
  }

  part fmeda02_EsadInterlock {
    @RAAML::FMEDA::FmedaMode {
      fmId = "FM-02-ESAD-INTERLOCK";
      severity = 5;
      alphaShare = 0.20;
      betaHaz = 0.35;
      dcPrimary = 0.995;
      dcLatent = 0.95;
      hft = 1;
      lambdaCompPerS = 0.0000005 [s^-1];
      ctmcSimplex = true;
    }
  }

  part fmeda03_Can2DaisyChain {
    @RAAML::FMEDA::FmedaMode {
      fmId = "FM-03-CAN2-DAISYCHAIN";
      severity = 4;
      alphaShare = 0.25;
      betaHaz = 0.50;
      dcPrimary = 0.95;
      dcLatent = 0.85;
      hft = 0;
      lambdaCompPerS = 0.0000020 [s^-1];
      ctmcSimplex = false;
    }
  }

  part fmeda04_Eps14VRail {
    @RAAML::FMEDA::FmedaMode {
      fmId = "FM-04-EPS-14V-RAIL";
      severity = 4;
      alphaShare = 0.25;
      betaHaz = 0.45;
      dcPrimary = 0.96;
      dcLatent = 0.88;
      hft = 0;
      lambdaCompPerS = 0.0000012 [s^-1];
      ctmcSimplex = false;
    }
  }

  part ftaGate01_TopInadvEnable {
    @RAAML::FTA::FaultTreeGate {
      gateId = "FTG-TOP-INADV-ENABLE";
      gateKind = FaultTreeGateKind::AndGate;
      kRequired = 3;
      nInputs = 3;
      ccfBeta = 0.02;
    }
  }

  part ftaGate02_LossOfControl {
    @RAAML::FTA::FaultTreeGate {
      gateId = "FTG-LOSS-OF-CONTROL";
      gateKind = FaultTreeGateKind::OrGate;
      kRequired = 1;
      nInputs = 2;
      ccfBeta = 0.05;
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
      in lambdaPrim = 0.0000010 [s^-1];
      in lambdaMon = 0.0000002 [s^-1];
      in lambdaSw = 0.0000001 [s^-1];
      in betaCcf = 0.02;
      in dcMon = 0.99;
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
