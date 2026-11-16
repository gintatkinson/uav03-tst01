package Avenger5_Verification {
  doc /* Requirement traceability (V-TRACE), Certification Objectives, and VerificationTestCases closing all hazards and safety constraints. */

  private import ISQ::*;
  private import RAAML::*;
  private import Avenger5_Architecture::*;
  private import Avenger5_Safety::*;

  requirement def REQ01_EsadRbfPowerSequenceInterlock :> RAAML::LifecycleAssuranceObjective {
    doc /* ESAD RBF #3 MUST remain installed until Power RBF #2 is pulled, UAV + ESAD boot cleanly, and SwarmC2 completes PBIT [A5 Prep#p23]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-01"; rationale = "Closes H-01, UCA-02..UCA-03, SC-01, and STANAG 4187 power-on interlock integrity."; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  requirement def REQ02_EsadSafeSeparationAndDscGate :> RAAML::LifecycleAssuranceObjective {
    doc /* ESAD MUST keep HV < 50 V and reject DSC_IN1 (1 kHz 2-pulse) / RS-485 Arm Enable until Umbilical open (SS1) and Safe Distance Exceeded (SS2) [ESAD ICD#p14-p23]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-02"; rationale = "Closes H-01, UCA-09..UCA-12, SC-02, FaultStates bit 4 & bit 12 invariants."; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  requirement def REQ03_Pl40PneumaticAndStallMarginGate :> RAAML::LifecycleAssuranceObjective {
    doc /* PL-40 launch MUST verify 13-14 bar pressure, exit velocity <= 25 m/s, rear-folded props, carriage pin state, and dual switches >= 2 s [PL-40#p24-p26; GAP-03]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-03"; rationale = "Closes H-01, H-02, UCA-05..UCA-08, SC-03 across catapult-airframe mating envelope."; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  requirement def REQ04_DroneCanSeriesChainSupervision :> RAAML::LifecycleAssuranceObjective {
    doc /* Cube orange+ MUST supervise CAN 1 and CAN 2 series daisy-chain heartbeats (wing servos #5-#8, dual RM3100, SKYE2) with <= 20 ms FTTI [Block Diagram#p1]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-04"; rationale = "Closes H-03, UCA-17..UCA-20, SC-04 across CAN 2 single-string dependency."; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  requirement def REQ05_TerminalApproachAirspeedAndAbort :> RAAML::LifecycleAssuranceObjective {
    doc /* Nom_TerminalApproach mode MUST enforce <= 55 m/s speed limit, 2-5 s EO track hold, <= 15 deg elevation, and deterministic Abort Approach / 5 s Abort hold [A5 Manual#p84-p90]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-05"; rationale = "Closes H-01, H-02, UCA-13..UCA-16, SC-05 terminal seeker tracking and waveoff bounds."; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  requirement def REQ06_Eps14VEsadRailAndRs485Watchdog :> RAAML::LifecycleAssuranceObjective {
    doc /* EPS 14 V ESAD rail MUST maintain >= 14.0 V under transient load (GAP-01) and RPI RS-485 master MUST maintain 100 Hz polling with <= 5 ms reply [ESAD ICD#p14-p15]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/interfaces"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-06"; rationale = "Closes H-05, UCA-01, UCA-04, SC-06 across EPS-to-ESAD J100 and RS-485 bus."; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  requirement def REQ07_GeofenceGnssSpoofAndPreLaunchScrub :> RAAML::LifecycleAssuranceObjective {
    doc /* System MUST enforce polygon Inclusion/Exclusion geofences, INS GNSS-denied fallback, and pre-launch scrub/hangfire safeing SOP (OA-08) [GAP-05]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/use-cases"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-07"; rationale = "Closes H-04, UCA-21..UCA-24, SC-07, EMG-04..EMG-06, and JARUS SORA containment OSOs."; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  verification def TC01_VerifyEsadPowerOnSequenceAndPbit :> RAAML::VerificationTestCase {
    doc /* Verify premature RBF #3 triggers Fault state and post-power-on PBIT confirms HV < 50 V and Ready to Fly [A5 Prep#p23; ESAD ICD#p18]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TEST-01"; reqId = "REQ-01"; method = "HardwareInLoop"; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  verification def TC02_VerifyEsadSafeSepAndDscLockout :> RAAML::VerificationTestCase {
    doc /* Inject early DSC_IN1 (1 kHz 2-pulse) prior to Arm Stage 2 and verify FaultStates bit 4 set and HV blocked < 50 V [ESAD ICD#p23]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TEST-02"; reqId = "REQ-02"; method = "HardwareInLoop"; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  verification def TC03_VerifyPl40PressurePinAndTriggerInterlock :> RAAML::VerificationTestCase {
    doc /* Test PL-40 at 13-14 bar, verify < 2 s trigger release closes valve and trigger with carriage pin in forces full reset [PL-40#p25-p26]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TEST-03"; reqId = "REQ-03"; method = "HardwareInLoop"; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  verification def TC04_VerifyDroneCanSeriesFaultContainment :> RAAML::VerificationTestCase {
    doc /* Simulate open circuit on CAN 2 series splitter and verify Simplex FTTI <= 20 ms switchover and yaw/fin stabilization [Block Diagram#p1]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TEST-04"; reqId = "REQ-04"; method = "FormalAnalysis"; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  verification def TC05_VerifyTerminalSpeedCapAndWaveoff :> RAAML::VerificationTestCase {
    doc /* Verify Nom_TerminalApproach mode clamps <= 55 m/s and Abort Approach triggers safe climb and GUIDED loiter or RTL on link loss [A5 Manual#p88-p90]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TEST-05"; reqId = "REQ-05"; method = "FormalAnalysis"; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  verification def TC06_VerifyEps14VMarginAndRs485CrcTiming :> RAAML::VerificationTestCase {
    doc /* Measure J100 VDC_IN >= 14.0 V during peak load and verify RS-485 115200 bps CRC-16 XModem (0xB987 test vector) <= 5 ms reply [ESAD ICD#p14-p16]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TEST-06"; reqId = "REQ-06"; method = "UnitTest"; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  verification def TC07_VerifyGeofenceGnssSpoofAndScrubSop :> RAAML::VerificationTestCase {
    doc /* Verify Exclusion/Inclusion polygon enforcement, GNSS disable/auto-reenable timeout, and OA-08 scrub/hangfire safeing checklist [A5 Manual#p51, p92]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TEST-07"; reqId = "REQ-07"; method = "Inspection"; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  requirement lao01 : RAAML::LifecycleAssuranceObjective {
    doc /* LAO-01: Assure ESAD RBF #2/#3 removal sequence and PBIT interlock integrity prior to launch readiness. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    subject sys subsets Avenger5_Architecture::avenger5System;
  }

  requirement lao02 : RAAML::LifecycleAssuranceObjective {
    doc /* LAO-02: Assure dual safe-separation environmental gates lock out inadvertent ESAD HV charging and arming. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    subject sys subsets Avenger5_Architecture::avenger5System;
  }

  requirement lao03 : RAAML::LifecycleAssuranceObjective {
    doc /* LAO-03: Assure PL-40 pneumatic catapult launch pressure, pin interlock, and stall margin containment. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    subject sys subsets Avenger5_Architecture::avenger5System;
  }

  requirement lao04 : RAAML::LifecycleAssuranceObjective {
    doc /* LAO-04: Assure DroneCAN series chain supervision and deterministic FTTI <= 20 ms simplex fallback control. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    subject sys subsets Avenger5_Architecture::avenger5System;
  }

  requirement lao05 : RAAML::LifecycleAssuranceObjective {
    doc /* LAO-05: Assure terminal approach airspeed envelope cap and reversible waveoff abort containment. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    subject sys subsets Avenger5_Architecture::avenger5System;
  }

  requirement lao06 : RAAML::LifecycleAssuranceObjective {
    doc /* LAO-06: Assure EPS 14 V ESAD power rail margin and RS-485 CRC watchdog timing integrity. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/interfaces"; }
    subject sys subsets Avenger5_Architecture::avenger5System;
  }

  requirement lao07 : RAAML::LifecycleAssuranceObjective {
    doc /* LAO-07: Assure polygon geofence containment, GNSS-denied INS fallback, and pre-launch scrub safeing. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/use-cases"; }
    subject sys subsets Avenger5_Architecture::avenger5System;
  }

  requirement req01 : REQ01_EsadRbfPowerSequenceInterlock {
    doc /* Enforce ESAD RBF #3 retention until Power RBF #2 removal and clean SwarmC2 PBIT completion [A5 Prep#p23]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-01"; rationale = "Closes H-01, UCA-02..UCA-03, SC-01, and STANAG 4187 power-on interlock integrity."; }
    subject sys subsets Avenger5_Architecture::avenger5System;
    satisfy lao01;
  }

  requirement req02 : REQ02_EsadSafeSeparationAndDscGate {
    doc /* Hold ESAD HV < 50 V and inhibit DSC_IN1 / RS-485 Arm Enable until SS1 umbilical open and SS2 safe separation [ESAD ICD#p14-p23]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-02"; rationale = "Closes H-01, UCA-09..UCA-12, SC-02, FaultStates bit 4 & bit 12 invariants."; }
    subject sys subsets Avenger5_Architecture::avenger5System;
    satisfy lao02;
  }

  requirement req03 : REQ03_Pl40PneumaticAndStallMarginGate {
    doc /* Validate PL-40 pressure 13-14 bar, exit velocity <= 25 m/s, rear-folded props, pin cleared, and >= 2 s dual switch hold [PL-40#p24-p26]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-03"; rationale = "Closes H-01, H-02, UCA-05..UCA-08, SC-03 across catapult-airframe mating envelope."; }
    subject sys subsets Avenger5_Architecture::avenger5System;
    satisfy lao03;
  }

  requirement req04 : REQ04_DroneCanSeriesChainSupervision {
    doc /* Supervise Cube orange+ CAN 1 and CAN 2 daisy-chain heartbeats (servos, RM3100, SKYE2) within <= 20 ms FTTI [Block Diagram#p1]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-04"; rationale = "Closes H-03, UCA-17..UCA-20, SC-04 across CAN 2 single-string dependency."; }
    subject sys subsets Avenger5_Architecture::avenger5System;
    satisfy lao04;
  }

  requirement req05 : REQ05_TerminalApproachAirspeedAndAbort {
    doc /* Enforce <= 55 m/s speed cap, 2-5 s track hold, <= 15 deg pitch, and deterministic Abort Approach / 5 s Abort hold [A5 Manual#p84-p90]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-05"; rationale = "Closes H-01, H-02, UCA-13..UCA-16, SC-05 terminal seeker tracking and waveoff bounds."; }
    subject sys subsets Avenger5_Architecture::avenger5System;
    satisfy lao05;
  }

  requirement req06 : REQ06_Eps14VEsadRailAndRs485Watchdog {
    doc /* Sustain EPS J100 rail >= 14.0 V under transient load and run RPI RS-485 polling at 100 Hz with <= 5 ms reply [ESAD ICD#p14-p15]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/interfaces"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-06"; rationale = "Closes H-05, UCA-01, UCA-04, SC-06 across EPS-to-ESAD J100 and RS-485 bus."; }
    subject sys subsets Avenger5_Architecture::avenger5System;
    satisfy lao06;
  }

  requirement req07 : REQ07_GeofenceGnssSpoofAndPreLaunchScrub {
    doc /* Enforce polygon Exclusion/Inclusion geofences, INS GNSS-denied fallback, and OA-08 pre-launch scrub safeing SOP [GAP-05]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/use-cases"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-07"; rationale = "Closes H-04, UCA-21..UCA-24, SC-07, EMG-04..EMG-06, and JARUS SORA containment OSOs."; }
    subject sys subsets Avenger5_Architecture::avenger5System;
    satisfy lao07;
  }

  verification tc01 : TC01_VerifyEsadPowerOnSequenceAndPbit {
    doc /* TEST-01: Verify premature RBF #3 faults ESAD and PBIT confirms HV < 50 V prior to Ready to Fly [A5 Prep#p23]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TEST-01"; reqId = "REQ-01"; method = "HardwareInLoop"; }
    subject sys subsets Avenger5_Architecture::avenger5System;
    verify req01;
  }

  verification tc02 : TC02_VerifyEsadSafeSepAndDscLockout {
    doc /* TEST-02: Inject premature DSC_IN1 before Arm Stage 2 and verify FaultStates bit 4 set and HV < 50 V [ESAD ICD#p23]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TEST-02"; reqId = "REQ-02"; method = "HardwareInLoop"; }
    subject sys subsets Avenger5_Architecture::avenger5System;
    verify req02;
  }

  verification tc03 : TC03_VerifyPl40PressurePinAndTriggerInterlock {
    doc /* TEST-03: Verify PL-40 13-14 bar interlock, < 2 s trigger release, and carriage-pin lockout reset [PL-40#p25-p26]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TEST-03"; reqId = "REQ-03"; method = "HardwareInLoop"; }
    subject sys subsets Avenger5_Architecture::avenger5System;
    verify req03;
  }

  verification tc04 : TC04_VerifyDroneCanSeriesFaultContainment {
    doc /* TEST-04: Inject CAN 2 series open fault and verify Simplex <= 20 ms switchover and yaw/fin control [Block Diagram#p1]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TEST-04"; reqId = "REQ-04"; method = "FormalAnalysis"; }
    subject sys subsets Avenger5_Architecture::avenger5System;
    verify req04;
  }

  verification tc05 : TC05_VerifyTerminalSpeedCapAndWaveoff {
    doc /* TEST-05: Verify <= 55 m/s approach clamp and Abort Approach waveoff transition to GUIDED loiter or RTL [A5 Manual#p88-p90]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TEST-05"; reqId = "REQ-05"; method = "FormalAnalysis"; }
    subject sys subsets Avenger5_Architecture::avenger5System;
    verify req05;
  }

  verification tc06 : TC06_VerifyEps14VMarginAndRs485CrcTiming {
    doc /* TEST-06: Verify J100 >= 14.0 V under peak load and RS-485 115200 bps CRC-16 reply <= 5 ms [ESAD ICD#p14-p16]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TEST-06"; reqId = "REQ-06"; method = "UnitTest"; }
    subject sys subsets Avenger5_Architecture::avenger5System;
    verify req06;
  }

  verification tc07 : TC07_VerifyGeofenceGnssSpoofAndScrubSop {
    doc /* TEST-07: Verify polygon geofence exclusion, GNSS disable timeout, and OA-08 scrub safeing SOP [A5 Manual#p51, p92]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TEST-07"; reqId = "REQ-07"; method = "Inspection"; }
    subject sys subsets Avenger5_Architecture::avenger5System;
    verify req07;
  }
}
