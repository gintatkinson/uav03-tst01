package Avenger5_Safety {
  doc /* Top-down STPA control-theoretic hazard analysis, bottom-up EMV2/4-way FMEDA/FTA, and RTA CTMC/RiskLattice/CRC-32C/RMA assurance evaluators. */

  private import ISQ::*;
  private import RAAML::*;
  private import Avenger5_Quantities::*;
  private import Avenger5_Architecture::*;
  private import Avenger5_ConOps::*;

  requirement def LossesAndHazards {
    doc /* Canonical System Losses L-01..L-03 and Hazards H-01..H-06 under MIL-STD-882E and JARUS SORA. */

    @RAAML::STPA::Loss { lossId = "L-01"; severity = 5; stakeholderRef = "LaunchCrewAndPublic"; }
    @RAAML::STPA::Loss { lossId = "L-02"; severity = 5; stakeholderRef = "MissionAirworthiness"; }
    @RAAML::STPA::Loss { lossId = "L-03"; severity = 4; stakeholderRef = "MissionPayloadIntegrity"; }

    @RAAML::STPA::Hazard {
      hazardId = "H-01";
      lossRefs = "L-01,L-02";
      envNegation = "Inadvertent ESAD initiation or premature RBF/arm transition prior to verified safe separation.";
    }
    @RAAML::STPA::Hazard {
      hazardId = "H-02";
      lossRefs = "L-01,L-02";
      envNegation = "Uncontrolled airframe departure from flight envelope (stall < 24 m/s, overspeed > 55 m/s, or PL-40 misfire).";
    }
    @RAAML::STPA::Hazard {
      hazardId = "H-03";
      lossRefs = "L-02,L-03";
      envNegation = "Loss of Cube orange+ stabilization or CAN 2 series roll-servo / mag / pitot string in flight.";
    }
    @RAAML::STPA::Hazard {
      hazardId = "H-04";
      lossRefs = "L-01,L-02";
      envNegation = "Geofence excursion into excluded zone or collision due to spoofed GNSS / unmitigated C2 loss.";
    }
    @RAAML::STPA::Hazard {
      hazardId = "H-05";
      lossRefs = "L-02,L-03";
      envNegation = "ESAD brownout / silent telemetry loss across 14 V min-boundary EPS rail or unguarded RS-485 bus [GAP-01].";
    }
  }

  requirement def StpaControlAnalysis {
    doc /* Control Actions CA-01..05, Unsafe Control Actions UCA-01..06, Loss Scenarios LS-01..06, Safety Constraints SC-01..06, and Controller Constraints CSC-01..06. */

    @RAAML::STPA::ControlAction { caId = "CA-01"; srcRank = 0.8; dstRank = 0.2; opsRef = "OA-03"; }
    @RAAML::STPA::ControlAction { caId = "CA-02"; srcRank = 1.0; dstRank = 0.3; opsRef = "OA-04"; }
    @RAAML::STPA::ControlAction { caId = "CA-03"; srcRank = 0.9; dstRank = 0.2; opsRef = "OA-07"; }
    @RAAML::STPA::ControlAction { caId = "CA-04"; srcRank = 1.0; dstRank = 0.5; opsRef = "OA-06"; }
    @RAAML::STPA::ControlAction { caId = "CA-05"; srcRank = 0.7; dstRank = 0.2; opsRef = "OA-05"; }

    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-01";
      caId = "CA-01";
      guideword = StpaGuideword::WrongTimingOrOrder;
      stateContext = "ESAD RBF #3 removed before Power RBF #2 and initial power-on PBIT pass [A5 Prep#p23].";
      hazardRef = "H-01";
    }
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-02";
      caId = "CA-03";
      guideword = StpaGuideword::ProvidedUnsafe;
      stateContext = "RPI asserts DSC_IN1 or RS-485 Arm Enable prior to verified Arm Stage 2 safe separation [ESAD ICD#p23].";
      hazardRef = "H-01";
    }
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-03";
      caId = "CA-02";
      guideword = StpaGuideword::ProvidedUnsafe;
      stateContext = "PL-40 triggered with carriage pin installed, prop unfolded, pressure out of 13-14 bar, or crew forward of rear foot.";
      hazardRef = "H-02";
    }
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-04";
      caId = "CA-05";
      guideword = StpaGuideword::NotProvided;
      stateContext = "CAN 2 series splitter open circuit severs wing servos #5-#8 plus dual RM3100 mag/baro and SKYE2 pitot [GAP-01/Block Diagram].";
      hazardRef = "H-03";
    }
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-05";
      caId = "CA-04";
      guideword = StpaGuideword::DurationTooShortOrLong;
      stateContext = "Dive speed exceeds 55 m/s during ATTACK or late Abort Engaging after safe abort window expires [A5 Manual#p88-p90].";
      hazardRef = "H-02";
    }
    @RAAML::STPA::UnsafeControlAction {
      ucaId = "UCA-06";
      caId = "CA-01";
      guideword = StpaGuideword::NotProvided;
      stateContext = "14 V EPS rail droops below ESAD 14.0 V GE_POW minimum under Rs-485/HV charger transient [GAP-01].";
      hazardRef = "H-05";
    }

    @RAAML::STPA::LossScenario { lsId = "LS-01"; ucaId = "UCA-01"; scenarioClass = ScenarioClass::Class2ExecutionOrPlant; opsRef = "OA-03"; }
    @RAAML::STPA::LossScenario { lsId = "LS-02"; ucaId = "UCA-02"; scenarioClass = ScenarioClass::Class1FeedbackOrController; opsRef = "OA-07"; }
    @RAAML::STPA::LossScenario { lsId = "LS-03"; ucaId = "UCA-03"; scenarioClass = ScenarioClass::Class2ExecutionOrPlant; opsRef = "OA-04"; }
    @RAAML::STPA::LossScenario { lsId = "LS-04"; ucaId = "UCA-04"; scenarioClass = ScenarioClass::Class2ExecutionOrPlant; opsRef = "OA-05"; }
    @RAAML::STPA::LossScenario { lsId = "LS-05"; ucaId = "UCA-05"; scenarioClass = ScenarioClass::Class1FeedbackOrController; opsRef = "OA-07"; }
    @RAAML::STPA::LossScenario { lsId = "LS-06"; ucaId = "UCA-06"; scenarioClass = ScenarioClass::Class2ExecutionOrPlant; opsRef = "OA-05"; }

    @RAAML::STPA::SafetyConstraint { scId = "SC-01"; hazardRef = "H-01"; fttiS = 0.010 [s]; opsRef = "OA-03"; }
    @RAAML::STPA::SafetyConstraint { scId = "SC-02"; hazardRef = "H-01"; fttiS = 0.005 [s]; opsRef = "OA-07"; }
    @RAAML::STPA::SafetyConstraint { scId = "SC-03"; hazardRef = "H-02"; fttiS = 0.050 [s]; opsRef = "OA-04"; }
    @RAAML::STPA::SafetyConstraint { scId = "SC-04"; hazardRef = "H-03"; fttiS = 0.020 [s]; opsRef = "OA-05"; }
    @RAAML::STPA::SafetyConstraint { scId = "SC-05"; hazardRef = "H-02"; fttiS = 0.050 [s]; opsRef = "OA-07"; }
    @RAAML::STPA::SafetyConstraint { scId = "SC-06"; hazardRef = "H-05"; fttiS = 0.010 [s]; opsRef = "OA-05"; }

    @RAAML::STPA::ControllerConstraint { cscId = "CSC-01"; ucaId = "UCA-01"; negatedGuard = "MUST NOT allow ESAD RBF #3 removal while Power RBF #2 is inserted or PBIT incomplete"; opsRef = "OA-03"; }
    @RAAML::STPA::ControllerConstraint { cscId = "CSC-02"; ucaId = "UCA-02"; negatedGuard = "MUST NOT drive DSC_IN1 or RS485 ArmEnable until SafeDistanceExceed and ArmStage2 verified"; opsRef = "OA-07"; }
    @RAAML::STPA::ControllerConstraint { cscId = "CSC-03"; ucaId = "UCA-03"; negatedGuard = "MUST NOT fire PL-40 outside 13-14 bar, with carriage pin inserted, or props unfolded"; opsRef = "OA-04"; }
    @RAAML::STPA::ControllerConstraint { cscId = "CSC-04"; ucaId = "UCA-04"; negatedGuard = "MUST trigger dead-reckoning / fin-only stabilization if CAN 2 chain heartbeat stalls"; opsRef = "OA-05"; }
    @RAAML::STPA::ControllerConstraint { cscId = "CSC-05"; ucaId = "UCA-05"; negatedGuard = "MUST clamp target airspeed <= 55 m/s in ATTACK and command Abort Engaging on overrun"; opsRef = "OA-07"; }
    @RAAML::STPA::ControllerConstraint { cscId = "CSC-06"; ucaId = "UCA-06"; negatedGuard = "MUST hold ESAD SAFE and raise telemetry warning if ESAD VDC_IN drops <= 14.0 V"; opsRef = "OA-05"; }
  }

  part def Emv2FmedaAndFtaModels {
    doc /* Bottom-up EMV2 error propagations, 4-way IEC 61508 FMEDA modes, and FTA gate structure grounded on FMECA catalog baselines. */

    @RAAML::EMV2::Emv2ErrorSource {
      errId = "ERR-CAN2-DAISYCHAIN";
      devClass = Emv2DeviationClass::Omission;
      subQual = ShardSubQualifier::SilentDrop;
      baseRatePerS = 0.0000010 [s^-1];
    }
    @RAAML::EMV2::Emv2ErrorSource {
      errId = "ERR-ESAD-RAIL-14V-DROOP";
      devClass = Emv2DeviationClass::ValueDeviation;
      subQual = ShardSubQualifier::ValueLow;
      baseRatePerS = 0.0000005 [s^-1];
    }
    @RAAML::EMV2::Emv2ErrorSource {
      errId = "ERR-GNSS-SPOOF-DRIFT";
      devClass = Emv2DeviationClass::ValueDeviation;
      subQual = ShardSubQualifier::ValueCorrupt;
      baseRatePerS = 0.0000020 [s^-1];
    }

    @RAAML::EMV2::Emv2Propagation {
      propId = "PROP-RS485-CORRUPT";
      inDev = Emv2DeviationClass::ValueDeviation;
      outDev = Emv2DeviationClass::Commission;
      portRef = "Avenger5_Architecture::EsadSafetyUnit::rs485Bus";
    }
    @RAAML::EMV2::Emv2Hyperedge {
      edgeId = "EDGE-CAN2-SERIES-BUS";
      topology = HyperedgeTopology::Broadcast1ToN;
      betaCcf = 0.05;
      groupRatePerS = 0.0000015 [s^-1];
    }

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

    @RAAML::FTA::FaultTreeGate {
      gateId = "FTG-TOP-INADV-ARM";
      gateKind = FaultTreeGateKind::AndGate;
      kRequired = 3;
      nInputs = 3;
      ccfBeta = 0.02;
    }
    @RAAML::FTA::FaultTreeGate {
      gateId = "FTG-LOSS-OF-CONTROL";
      gateKind = FaultTreeGateKind::OrGate;
      kRequired = 1;
      nInputs = 2;
      ccfBeta = 0.05;
    }

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
}
