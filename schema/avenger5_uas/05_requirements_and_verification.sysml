package Avenger5_Verification {
  doc /* Requirement traceability (V-TRACE), Certification Objectives, and VerificationTestCases closing all hazards and safety constraints. */

  private import ISQ::*;
  private import RAAML::*;
  private import Avenger5_Architecture::*;
  private import Avenger5_Safety::*;

  requirement def REQ01_EsadRbfPowerSequenceInterlock :> RAAML::LifecycleAssuranceObjective {
    doc /* ESAD RBF #3 MUST remain installed until Power RBF #2 is pulled, UAV + ESAD boot cleanly, and SwarmC2 completes PBIT [A5 Prep#p23]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-A5-001"; rationale = "Closes H-01, UCA-01, SC-01, and STANAG 4187 power-on interlock integrity."; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  requirement def REQ02_EsadSafeSeparationAndDscGate :> RAAML::LifecycleAssuranceObjective {
    doc /* ESAD MUST keep HV < 50 V and reject DSC_IN1 (1 kHz 2-pulse) / RS-485 Arm Enable until Umbilical open (SS1) and Safe Distance Exceeded (SS2) [ESAD ICD#p14-p23]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-A5-002"; rationale = "Closes H-01, UCA-02, SC-02, FaultStates bit 4 & bit 12 invariants."; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  requirement def REQ03_Pl40PneumaticAndStallMarginGate :> RAAML::LifecycleAssuranceObjective {
    doc /* PL-40 launch MUST verify 13-14 bar pressure, exit velocity <= 25 m/s, rear-folded props, carriage pin state, and dual switches >= 2 s [PL-40#p24-p26; GAP-03]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-A5-003"; rationale = "Closes H-02, UCA-03, SC-03 across catapult-airframe mating envelope."; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  requirement def REQ04_DroneCanSeriesChainSupervision :> RAAML::LifecycleAssuranceObjective {
    doc /* Cube orange+ MUST supervise CAN 1 and CAN 2 series daisy-chain heartbeats (wing servos #5-#8, dual RM3100, SKYE2) with <= 20 ms FTTI [Block Diagram#p1]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-A5-004"; rationale = "Closes H-03, UCA-04, SC-04 across CAN 2 single-string dependency."; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  requirement def REQ05_TerminalEngagementAirspeedAndAbort :> RAAML::LifecycleAssuranceObjective {
    doc /* ATTACK mode MUST enforce <= 55 m/s speed limit, 2-5 s EO track hold, <= 15 deg elevation, and deterministic Abort Engaging / 5 s Abort hold [A5 Manual#p84-p90]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/safety"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-A5-005"; rationale = "Closes H-02, UCA-05, SC-05 terminal seeker tracking and waveoff bounds."; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  requirement def REQ06_Eps14VEsadRailAndRs485Watchdog :> RAAML::LifecycleAssuranceObjective {
    doc /* EPS 14 V ESAD rail MUST maintain >= 14.0 V under transient load (GAP-01) and RPI RS-485 master MUST maintain 100 Hz polling with <= 5 ms reply [ESAD ICD#p14-p15]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/interfaces"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-A5-006"; rationale = "Closes H-05, UCA-06, SC-06 across EPS-to-ESAD J100 and RS-485 bus."; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  requirement def REQ07_GeofenceGnssSpoofAndPreLaunchScrub :> RAAML::LifecycleAssuranceObjective {
    doc /* System MUST enforce polygon Inclusion/Exclusion geofences, INS GNSS-denied fallback, and pre-launch scrub/hangfire safeing SOP (OA-08) [GAP-05]. */
    @RAAML::ThreeRing::DocTier { tier = DocTierKind::Tier4Spec; docPath = "docs/use-cases"; }
    @RAAML::ThreeRing::TraceReq { reqId = "REQ-A5-007"; rationale = "Closes H-04, EMG-04..EMG-06, and JARUS SORA containment OSOs."; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  verification def TC01_VerifyEsadPowerOnSequenceAndPbit :> RAAML::VerificationTestCase {
    doc /* Verify premature RBF #3 triggers Fault state and post-power-on PBIT confirms HV < 50 V and Ready to Fly [A5 Prep#p23; ESAD ICD#p18]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TC-A5-001"; reqId = "REQ-A5-001"; method = "HardwareInLoop"; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  verification def TC02_VerifyEsadSafeSepAndDscLockout :> RAAML::VerificationTestCase {
    doc /* Inject early DSC_IN1 (1 kHz 2-pulse) prior to Arm Stage 2 and verify FaultStates bit 4 set and HV blocked < 50 V [ESAD ICD#p23]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TC-A5-002"; reqId = "REQ-A5-002"; method = "HardwareInLoop"; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  verification def TC03_VerifyPl40PressurePinAndTriggerInterlock :> RAAML::VerificationTestCase {
    doc /* Test PL-40 at 13-14 bar, verify < 2 s trigger release closes valve and trigger with carriage pin in forces full reset [PL-40#p25-p26]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TC-A5-003"; reqId = "REQ-A5-003"; method = "Test"; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  verification def TC04_VerifyDroneCanSeriesFaultContainment :> RAAML::VerificationTestCase {
    doc /* Simulate open circuit on CAN 2 series splitter and verify Simplex FTTI <= 20 ms switchover and yaw/fin stabilization [Block Diagram#p1]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TC-A5-004"; reqId = "REQ-A5-004"; method = "FormalAnalysis"; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  verification def TC05_VerifyTerminalSpeedCapAndWaveoff :> RAAML::VerificationTestCase {
    doc /* Verify ATTACK mode clamps <= 55 m/s and Abort Engaging triggers safe climb and GUIDED loiter or RTL on link loss [A5 Manual#p88-p90]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TC-A5-005"; reqId = "REQ-A5-005"; method = "FormalAnalysis"; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  verification def TC06_VerifyEps14VMarginAndRs485CrcTiming :> RAAML::VerificationTestCase {
    doc /* Measure J100 VDC_IN >= 14.0 V during peak load and verify RS-485 115200 bps CRC-16 XModem (0xB987 test vector) <= 5 ms reply [ESAD ICD#p14-p16]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TC-A5-006"; reqId = "REQ-A5-006"; method = "UnitTest"; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }

  verification def TC07_VerifyGeofenceGnssSpoofAndScrubSop :> RAAML::VerificationTestCase {
    doc /* Verify Exclusion/Inclusion polygon enforcement, GNSS disable/auto-reenable timeout, and OA-08 scrub/hangfire safeing checklist [A5 Manual#p51, p92]. */
    @RAAML::ThreeRing::VerificationTest { testId = "TC-A5-007"; reqId = "REQ-A5-007"; method = "Inspection"; }
    subject sys : Avenger5_Architecture::Avenger5UasSystem;
  }
}
