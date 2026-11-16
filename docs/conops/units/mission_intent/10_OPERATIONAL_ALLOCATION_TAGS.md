## 10. Operational Allocation & Normative Obligation Traceability Tags

- **System Baseline:** `Avenger5V25UasSystem` (`Avenger 5 V2.5 UAS` / `ASTK A5 V2.5` + `ELI Military Simulations PL-40 Rev 2.6` + `Artron ESAD AB00-0054-01AA-0005` + `SwarmC2`)
- **Normative Baseline Date:** `2026-11-16`
- **JSON Schema Mapping:** `allocation_tags` (`.pipeline/schemas/mission_intent_specification_schema.json`)
- **Governing Standards & SSOT Anchors:** `ISO/IEC/IEEE 29148:2018` (`§5.2.4`, `§6.4`, `§8.4`, `Annex A §A.2`), `ISO/IEC/IEEE 15288:2023` (`§6.4.2`, `§6.4.3`, `§6.4.4`, `§6.4.9`), `IEEE Std 1362-1998` (`§4`, `§4.3`), `INCOSE SE Handbook v5.0` (`§2.3.5.4`, `§2.3.5.9`), `OMG UAF v2.0` (`Operational Viewpoint Op-Cn / Op-Sr`, `Resources Viewpoint Rs-Tx / Rs-Tr`), `NATO STANAG 4187 Ed. 5` (`Chapter 2`, `Chapter 3`, `Annex A`), `MIL-STD-331D` (`Group A Test A3, Test A4.1, Test A5`), `MIL-STD-461G` (`CS114`, `CS116`, `CS118`, `RE102`, `RS103`), `MIL-STD-810H` (`Method 501.7, 502.7, 506.6, 510.7, 514.8, 516.8`), `MIL-STD-882E` (`Task 202`, `Task 205`, `Task 206`), `MIL-STD-1629A` (`Method 101`, `Method 102`), `RTCA DO-178C` (`§6.3`, `§11.0`), `RTCA DO-254` (`§10.0`), `SAE ARP4754A` (`§5.1`) / `ARP4761` (`§3.1-3.3`), `ASTM F3269-17` (`§5.2`), `RTCA DO-362A` (`§2.2`, `§3.2`), `JARUS SORA v2.5` (`Annex B`, `Annex C`), `NIST SP 800-82r3` (`Chapter 6`, `Appendix F: AC, IA, SC`), and `DoD Directive 3000.09` (`§4.1.a`), grounded strictly in `docs/research/RESEARCH_INVENTORY.md`, `docs/safety/STPA_MATRIX.md`, `.pipeline/schema.sysml`, `.pipeline/schema-digest.json`, and `docs/conops/units/mission_intent/02_MISSION_ESSENTIAL_TASK_LIST.md`.

---

### 10.1 Gate 24 Mission Essential Task Allocation Directives (`MET-01` through `MET-08`)

In accordance with `ISO/IEC/IEEE 29148:2018` (`§6.4`, `Annex A §A.2`), `OMG UAF v2.0`, and `02_MISSION_ESSENTIAL_TASK_LIST.md`, the eight Mission Essential Tasks (`MET-01` through `MET-08`) emit deterministic 1:1 Gate 24 traceability tags binding operational tasks to Level 1B Operational Activities (`OA-01` through `OA-19`), Operational Scenarios (`SCN-01` through `SCN-08`), SysML v2 Interaction Definitions (`INT_01_PreflightPowerAndBit` through `INT_08_EmergencyScrubAndSafing`), Operational Go/No-Go Phase Gates (`GNG-01` through `GNG-08`), Level 1B User Classes (`UCL-01` through `UCL-05`), and Verification Test Cases (`TC_01_PreflightPowerAndRbfSequence` through `TC_08_EmergencyScrubHangfireAndC2Auth`).

All allocations preserve the four hardware-faithful Level 1B architectural invariants of `Avenger5V25UasSystem`:
1. Software-hosted Simplex Run-Time Assurance inside `FlightControllerCubeOrangePlus` (`standaloneRtaBoxCount == 0`, `rtaHostedOnCubeOrangePlus == true`).
2. Strictly mechanical zero-wire `PL-40` catapult rail interface (`IF-MECH-001` / `CONN_23`, `electricalWireToUavCount == 0`).
3. Permanent inhibition of `Optional RnD` recovery parachute igniters on production airframes (`rndRecoveryOptionInstalled == false`).
4. Strict Level 1B operational isolation: stakeholder roles use `UCL-01` through `UCL-05` exclusively, while component-internal ESAD wire framing and serial opcode details reside strictly in Level 1C ICD artifacts.

#### Gate 24 `OperationalAllocation` Directive Roster

/// OperationalAllocation: [MET-01]

/// OperationalAllocation: [MET-02]

/// OperationalAllocation: [MET-03]

/// OperationalAllocation: [MET-04]

/// OperationalAllocation: [MET-05]

/// OperationalAllocation: [MET-06]

/// OperationalAllocation: [MET-07]

/// OperationalAllocation: [MET-08]

#### Table 10.1: Gate 24 Mission Essential Task Allocation Traceability Matrix (`MET-01` through `MET-08`)

| MET ID | Mission Essential Task & Lifecycle Scope | Operational Activities (`OA`) | Scenarios (`SCN`) | Interaction Defs (`INT`) | Go/No-Go Gate (`GNG`) | User Classes (`UCL-01` through `UCL-05`) | Verification Test Cases (`TC`) |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `MET-01` | Ground Staging, ESD Touch, Rotator Calibration & `12S2P` `RBF #1/#2/#3` Energization (`UavFlightLifecycleState::PreFlightCheck`; `EsadSafeArmState::SafePowerOff` through `SafeRbfRemoved`) | `OA-01`, `OA-03`, `OA-06`, `OA-10`, `OA-18` | `SCN-01`, `SCN-07` | `INT_01_PreflightPowerAndBit` | `GNG-01` (`SwarmC2AuthAndMissionBoundsConstraint`, `GroundCrewSeparationAndEsdConstraint`, `MainBatteryPreFlightVoltageConstraint`, `PitotPreflightCalibrationConstraint`, `EsadRbf3PowerBeforePullConstraint`) | `UCL-03` (Primary Staging), `UCL-01` (Auth / BIT), `UCL-02` (Seeker / ESAD BIT), `UCL-05` (Safety / Packing Lead) | `TC_01_PreflightPowerAndRbfSequence` |
| `MET-02` | `PL-40` Pneumatic Pressurization, UVLO Guard & Zero-Wire Launch (`Pl40LauncherState::AnchoredAndLeveled` through `RailLaunchReleased`; `IF-MECH-001` / `CONN_23`) | `OA-02`, `OA-15`, `OA-16` | `SCN-06` | `INT_03_Pl40RailChargeAndLaunchSequence` | `GNG-02` (`Pl40MassAndExitVelocityConstraint`, `Pl40UvloAndDualSwitchConstraint`, `GAP-03` Go/No-Go Gate) | `UCL-03` (Primary Catapult Operator), `UCL-01` (Go/No-Go & Climb Mode), `UCL-05` (Safety & Corridor Clearance) | `TC_07_Pl40RailChargeLaunchAndZeroWire` |
| `MET-03` | Cruise Flight & Software Simplex RTA Envelope Guard (`UavFlightLifecycleState::CruiseAndLoiter`; `RtaEnvelopeMonitorState::NominalPrimaryEnvelope`) | `OA-02`, `OA-03`, `OA-04`, `OA-05`, `OA-09` | `SCN-02` | `INT_02_PropulsionThrustAndBingoMonitor`, `INT_04_AutopilotRtaAndSurfaceActuation` | `GNG-03` (`SimplexRtaSoftwareHostingConstraint`, `CanTopologyIsolationConstraint`, `FlightEnvelopeSpeedConstraint`, `EpsEsadZeroBrownoutMarginConstraint`, `ProductionNoParachuteConstraint`) | `UCL-01` (Primary Flight Supervisor), `UCL-04` (Airspace Bounds Coordination), `UCL-05` (Avionics & Maintenance Integrity) | `TC_02_BingoReserveAndEpsBrownoutMonitor`, `TC_03_SimplexRtaEnvelopeAndActuation` |
| `MET-04` | Contested C2 PACE & GNSS-Denied INS/DR Navigation (`PaceC2LinkState::AlternateDtcOmniLocal` through `EmergencyLostLinkRtlHolding`) | `OA-06`, `OA-07`, `OA-14`, `OA-18` | `SCN-03`, `SCN-07` | `INT_05_GnssDeniedDeadReckoningAndPaceLink` | `GNG-04` (`CanTopologyIsolationConstraint`, `SwarmC2AuthAndMissionBoundsConstraint`, `Disable GNSS` & `GCS Failsafe` Gate) | `UCL-01` (Primary C2 / Rotator / `Disable GNSS` Operator), `UCL-02` (Visual Landmark Cueing), `UCL-04` (Tactical C2 Conduit Boundary) | `TC_04_GnssDeniedDrAndPaceLinkFailsafe` |
| `MET-05` | `EO/IR` (`Nighthawk2UZ` / `Trip6`) Terminal Track & `5W`/`CFF` Target Reporting (`UavFlightLifecycleState::TargetTrackAndDive`) | `OA-13`, `OA-14`, `OA-19` | `SCN-04`, `SCN-07` | `INT_06_EoIrSeekerTrackAndTerminalDive` | `GNG-05` (`EngagementSpeedAndTrackHoldConstraint`, six `SwarmC2` engagement preconditions, HITL `Slide to confirm`) | `UCL-02` (Primary Seeker / HITL `ATTACK` / `5W` Export), `UCL-01` (Envelope / Abort Support), `UCL-04` (`5W` / `CFF` Consumer) | `TC_05_EoIrTargetTrackAndSpeedCapAbort` |
| `MET-06` | Positive HITL `Artron ESAD` Safe-Arm & `SS1`/`SS2` Detonation Gate (`EsadSafeArmState::BootAndPbit` through `DetonatedOrAborted`) | `OA-08`, `OA-10`, `OA-11` | `SCN-05` | `INT_07_EsadDualBarrierArmAndDetonation` | `GNG-06` (`EsadRs485ProtocolTimingConstraint`, `EsadInputVoltageAndBrownoutConstraint`, `WarheadMassAndPbitHvSafetyConstraint`, `EsadSafeDistanceExceedConstraint`) | `UCL-02` (Exclusive HITL Arm/Fire Consent), `UCL-03` (Ordered `RBF #3` Pull), `UCL-05` (Ordnance Safety Lead), `UCL-01` (Failsafe Coordination) | `TC_06_EsadProtocolInterlockAndHvFireGate` |
| `MET-07` | In-Flight Abort, Lost-Link RTL & Statutory Bingo Reserve Protection (`UavFlightLifecycleState::EmergencyAbortOrRtb`) | `OA-03`, `OA-04`, `OA-05`, `OA-07`, `OA-08`, `OA-12`, `OA-13` | `SCN-02`, `SCN-03`, `SCN-04`, `SCN-05` | `INT_02_PropulsionThrustAndBingoMonitor`, `INT_05_GnssDeniedDeadReckoningAndPaceLink` | `GNG-07` (`BingoEnergyReserveConstraint`, `FlightEnvelopeSpeedConstraint`, `EpsEsadZeroBrownoutMarginConstraint`, `ProductionNoParachuteConstraint`) | `UCL-01` (Flight Abort / `RTL` Recovery), `UCL-02` (Exclusive HITL Self-Destruct / `Power Off ESAD`), `UCL-05` (Containment Policy Oversight) | `TC_02_BingoReserveAndEpsBrownoutMonitor`, `TC_04_GnssDeniedDrAndPaceLinkFailsafe` |
| `MET-08` | Pre-Launch `SAFE_SCRUB_ABORT` Hangfire Recovery (`Pl40LauncherState::ScrubbedSafeDepressurized`; `UavFlightLifecycleState::SafePostFlightShutdown`) | `OA-12`, `OA-15`, `OA-17` | `SCN-08` | `INT_08_EmergencyScrubAndSafing` | `GNG-08` (`GAP-SCRUB` Rear Holdback, `REQ_SC_16` Zero-Bar Bleed, `EsadRbf3PowerBeforePullConstraint` Reverse `RBF #3` -> `#2` -> `#1`) | `UCL-03` (Physical Bleed, Red Pin & Reverse `RBF` Crew), `UCL-02` (Remote ESAD Abort / `Power Off ESAD`), `UCL-01` (Launch Scrub Control), `UCL-05` (Arming Safety Lead & Quarantine) | `TC_08_EmergencyScrubHangfireAndC2Auth` |

---

### 10.2 Normative Obligation Witness Roster (`OBL-01` through `EXT-02`)

Every normative obligation, safety constraint, METL task, control pattern, and OEM domain baseline extension declared in `docs/research/RESEARCH_INVENTORY.md` (`OBL-01` through `OBL-04`, `SAF-01` through `SAF-04`, `MET-01` through `MET-04`, `CTL-01` through `CTL-04`, `EXT-01`, `EXT-02`) is explicitly witnessed below in exact alignment with `docs/safety/STPA_MATRIX.md` Section 10, `.pipeline/schema.sysml`, and the Level 1B ConOps and Mission Intent specification tree.

/// ObligationWitness: [OBL-01] ISO/IEC/IEEE 29148:2018 §6.4, §8.4, Annex A (§A.2); IEEE Std 1362-1998 §4, §4.3 -- Operational Concept and Mission Intent closure across CONOPS.md, MISSION_INTENT.md (MET-01 through MET-08, UCL-01 through UCL-05), and 15/15 AST part def baselines (Avenger5V25IntegratedSystem plus 14 subsystem and ground parts) synced with STPA Pillars 1 through 8, 01_LOSSES_HAZARDS_TOPOLOGY.md, and FMECA-001 through FMECA-061.

/// ObligationWitness: [OBL-02] ISO/IEC/IEEE 15288:2023 §6.4.2, §6.4.3, §6.4.4, §6.4.9; INCOSE SE Handbook v5.0 §2.3.5.4, §2.3.5.9 -- Bijective mapping of 24 operational interfaces (CONN_01 through CONN_24), 46 requirement defs (REQ_L_01 through REQ_L_04, REQ_H_01 through REQ_H_06, REQ_UCA_01 through REQ_UCA_08, REQ_SC_01 through REQ_SC_16, REQ_SAF_01 through REQ_SAF_12), and 8 verification test cases (TC_01_PreflightPowerAndRbfSequence through TC_08_EmergencyScrubHangfireAndC2Auth).

/// ObligationWitness: [OBL-03] OMG UAF v2.0 Operational Viewpoint (Op-Cn / Op-Sr), Resources Viewpoint (Rs-Tx / Rs-Tr) -- Complete allocation across 19 operational activities (OA-01 through OA-19), 24 operational exchanges (OpTx-01 through OpTx-24), 8 operational scenarios (SCN-01 through SCN-08), 8 interaction defs (INT_01_PreflightPowerAndBit through INT_08_EmergencyScrubAndSafing), Hierarchical Control Structure Topology (Pillar 3), and 5 AST safety statecharts (UavFlightLifecycleState, RtaEnvelopeMonitorState, EsadSafeArmState, PaceC2LinkState, Pl40LauncherState).

/// ObligationWitness: [OBL-04] NIST SP 800-82r3 Chapter 6, Appendix F (AC, IA, SC) -- Role-based SwarmC2 auth >= 8 chars across Pilot (UCL-01), Payload (UCL-02), and Launch Assistant (UCL-03), AES-256 4.4-5.0 GHz FHSS datalink, locked USB/ETH umbilical lid, and consumer-only external C2 boundary (UCL-04) verified under REQ_SC_15, SwarmC2AuthAndMissionBoundsConstraint (T-17), FM-09-02, and TC_08_EmergencyScrubHangfireAndC2Auth.

/// ObligationWitness: [SAF-01] NATO STANAG 4187 Ed. 5 Chapter 2, Chapter 3, Annex A; MIL-STD-331D Group A Test A3, Test A4.1, Test A5 -- Dual independent barriers SS1 (inertial launch accel) + SS2 (Safe Distance Exceed == 1, GAP-07), RBF #3 power-before-pull (GAP-06, UMB < 0.5 Ohm @ 20.0 mA), PBIT internal HV < 50.0 V, and J401 0.0-1800.0 V fire gate verified via EsadSafeArmState, REQ_SC_09 through REQ_SC_11, and TC_06_EsadProtocolInterlockAndHvFireGate.

/// ObligationWitness: [SAF-02] MIL-STD-882E Task 202, Task 205, Task 206; SAE ARP4754A §5.1; SAE ARP4761 §3.1-3.3 -- Full FHA/OHA/STPA closure across REQ_L_01 through REQ_L_04, REQ_H_01 through REQ_H_06, REQ_UCA_01 through REQ_UCA_08, REQ_SC_01 through REQ_SC_16, H-1 through H-19, UCA-001 through UCA-076, LS-001 through LS-152, and SC-001 through SC-076.

/// ObligationWitness: [SAF-03] MIL-STD-1629A Method 101, Method 102; RTCA DO-178C §6.3, §11.0; RTCA DO-254 §10.0 -- 100% AST part FMECA closure (FMECA-001 through FMECA-061 synced 1:1 with FAILURE_MODE_REGISTRY.md, Peak RPN 192), Cube orange+ / RPI CM5 software assurance (GAP-WCET, REQ_SAF_08), and ESAD hardware reliability tracking (GAP-REL, REQ_SAF_09).

/// ObligationWitness: [SAF-04] MIL-STD-461G CS114, CS116, CS118, RE102, RS103; MIL-STD-810H Method 501.7, 502.7, 506.6, 510.7, 514.8, 516.8 -- Artron ESAD EMI/ESD immunity, -20.0 to +50.0 degC thermal bounds, 12.0 m/s ground / 28.0 m/s cruise wind, rain/dust/shock/vibration envelopes, and FM-14-03 / FMECA-060 ESD grounding (REQ_SAF_11).

/// ObligationWitness: [MET-01] ISO/IEC/IEEE 29148:2018 Annex A (§A.2); IEEE Std 1362-1998 §4.3 -- End-to-end thread safety coverage across MET-01 through MET-08, OA-01 through OA-19, SCN-01 through SCN-08, UavFlightLifecycleState, and verification cases TC_01_PreflightPowerAndRbfSequence through TC_08_EmergencyScrubHangfireAndC2Auth.

/// ObligationWitness: [MET-02] JARUS SORA v2.5 Annex B, Annex C -- 17.0 kg MTOW, 50.0-3000.0 m waypoint altitude, >= 300.0 m loiter radius, 5000.0 m ceiling, 0.20 statutory Bingo reserve (1080.0 s of 5400.0 s endurance, T-02), >= 10.0 m ground radio separation (T-18), and Inclusion/Exclusion operational containment (TC_02_BingoReserveAndEpsBrownoutMonitor, TC_08_EmergencyScrubHangfireAndC2Auth).

/// ObligationWitness: [MET-03] DoD Directive 3000.09 §4.1.a -- Positive HITL engagement governance assigned exclusively to Payload Operator (UCL-02): 2.0-5.0 s EO track hold, Slide-to-Confirm ATTACK, >= 5.0 s ESAD self-destruct hold + Slide-to-Confirm, irreversible Power Off ESAD, and <= 55.0 m/s Abort Engaging (T-14, TC_05_EoIrTargetTrackAndSpeedCapAbort, TC_06_EsadProtocolInterlockAndHvFireGate).

/// ObligationWitness: [MET-04] MIL-STD-882E Task 206 -- Formal SAFE_SCRUB_ABORT and hangfire recovery (MET-08, GAP-SCRUB, REQ_SC_16, REQ_SAF_12, Pl40LauncherState::ScrubbedSafeDepressurized): >= 10.0 min rear SAFETY AREA holdback, ESAD abort + Power Off ESAD, Main Valve 4 close and 0.0 bar bleed, red pin restore, and RBF #3 prior to RBF #2 disconnect (TC_08_EmergencyScrubHangfireAndC2Auth).

/// ObligationWitness: [CTL-01] ASTM F3269-17 §5.2 -- Software-hosted Simplex RTA inside FlightControllerCubeOrangePlus (standaloneRtaBoxCount == 0, rtaHostedOnCubeOrangePlus == true, T-08, RtaEnvelopeMonitorState) clamping <= 55.0 m/s engagement and <= 80.0 m/s VNE (T-03, TC_03_SimplexRtaEnvelopeAndActuation).

/// ObligationWitness: [CTL-02] RTCA DO-362A §2.2, §3.2 -- 4.4-5.0 GHz 2.0 W (2x 1.0 W) PACE C2 link degradation (PaceC2LinkState, 60.0/90.0 km RLOS, 2.0 min telemetry timeout, 105.0 s GCS Failsafe RTL + Disarm ESAD On GCS Timeout, TC_04_GnssDeniedDrAndPaceLinkFailsafe).

/// ObligationWitness: [CTL-03] RTCA DO-178C §6.3; NATO STANAG 4187 Ed. 5 Chapter 2 -- RPI CM5004032 OC Master 100.0 Hz (0.01 s) 115200 bps 8N1 RS-485 CRC-16 XModem (<= 5.0 ms reply / <= 10.0 ms timeout, T-10, GAP-04) + Stage 2 DSC_IN1 1.0 kHz 2-pulse gate (REQ_SC_08, REQ_SC_10, TC_04_GnssDeniedDrAndPaceLinkFailsafe, TC_06_EsadProtocolInterlockAndHvFireGate).

/// ObligationWitness: [CTL-04] SAE ARP4754A §5.1; SAE ARP4761 §3.2 -- Physical CAN 1 (Power Meter, EPS, 4x tail fins 120.0 cm stubs) vs CAN 2 (splitter, 4x wings, 2x RM3100, SKYE2 pitot) separation (T-07), 12S2P 36.0-50.4 V bus (T-01, GAP-05), and 14.0 V ESAD brownout guard (T-04, T-09, GAP-01, TC_01_PreflightPowerAndRbfSequence through TC_03_SimplexRtaEnvelopeAndActuation).

/// ObligationWitness: [EXT-01] OEM Avenger 5 V2.5 & Artron ESAD Baseline (AB00-0054-01AA-0005) -- 37 BOM assemblies, 126 grounded parameters, and 12 OEM gap dispositions (GAP-01 through GAP-07, GAP-WCET, GAP-REL, GAP-SEPDIST, GAP-ENV, GAP-SCRUB) bound via REQ_SAF_01 through REQ_SAF_12 and FMECA-001 through FMECA-049 and FMECA-054 through FMECA-061.

/// ObligationWitness: [EXT-02] OEM ELI PL-40 Rev 2.6 Launcher Baseline (UAV_launcher_PL-40_user_manual_rev_2.6.pdf #p3-#p45) -- 5 launcher BOM assemblies, 50 grounded parameters, 13.0-14.0 bar launch pressure, 14.5 V Makita UVLO (T-16), ~23.0 m/s exit (<= 25.0 m/s ceiling, T-15, GAP-03), zero electrical or CAN wires to UAV (IF-MECH-001 / CONN_23), bound via Pl40PneumaticLauncher failure modes FM-12-01 through FM-12-04, TC_07_Pl40RailChargeLaunchAndZeroWire, and TC_08_EmergencyScrubHangfireAndC2Auth.

#### Table 10.2: Normative Obligation Witness & Cross-Artifact Traceability Table (`OBL-01` through `EXT-02`)

| Witness ID | Category | Standard / Baseline ID | Authoritative Public Clause Citation | Realized Mission Intent & ConOps Anchors | Realized STPA Matrix & Schema Proof Hooks |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `OBL-01` | Normative Obligation | `ISO/IEC/IEEE 29148:2018`; `IEEE Std 1362-1998` | `ISO/IEC/IEEE 29148:2018 §6.4, §8.4, Annex A (§A.2)`; `IEEE Std 1362-1998 §4, §4.3` | `CONOPS.md`, `MISSION_INTENT.md` (`MET-01` through `MET-08`, `UCL-01` through `UCL-05`, `15` `part def` baselines) | `STPA_MATRIX.md` Sections 1 through 8 (`15` `part def`s across FMECA & Topology, `FMECA-001` through `FMECA-061`) |
| `OBL-02` | Normative Obligation | `ISO/IEC/IEEE 15288:2023`; `INCOSE SE Handbook v5.0` | `ISO/IEC/IEEE 15288:2023 §6.4.2, §6.4.3, §6.4.4, §6.4.9`; `INCOSE SE Handbook v5.0 §2.3.5.4, §2.3.5.9` | `CONOPS.md` SV-1 (`CONN_01` through `CONN_24`), `MISSION_INTENT.md` (`MET-01` through `MET-08`) | `STPA_MATRIX.md` Sections 3, 6.2, 6.3, 6.4 (`CONN_01` through `CONN_24`, `46` requirement defs, `TC_01_PreflightPowerAndRbfSequence` through `TC_08_EmergencyScrubHangfireAndC2Auth`) |
| `OBL-03` | Normative Obligation | `OMG UAF v2.0` | `OMG UAF v2.0 Operational Viewpoint (Op-Cn / Op-Sr), Resources Viewpoint (Rs-Tx / Rs-Tr)` | `OA-01` through `OA-19`, `OpTx-01` through `OpTx-24`, `SCN-01` through `SCN-08`, `INT_01_PreflightPowerAndBit` through `INT_08_EmergencyScrubAndSafing` | `STPA_MATRIX.md` Sections 3, 6.1 (`19` `action def`s, `5` AST `state def`s) |
| `OBL-04` | Normative Obligation | `NIST SP 800-82r3` | `NIST SP 800-82r3 Chapter 6, Appendix F (AC, IA, SC)` | `UCL-01` through `UCL-04` auth & conduit isolation (`MET-01`, `MET-04`, `MET-05`, `PRM-GCS-009`, `PRM-RF-005`) | `STPA_MATRIX.md` Sections 6.2, 6.3, 7, 9 (`REQ_SC_15`, `T-17`, `FM-09-02`, `FMECA-038`, `TC_08_EmergencyScrubHangfireAndC2Auth`) |
| `SAF-01` | Safety Constraint | `NATO STANAG 4187 Ed. 5`; `MIL-STD-331D` | `NATO STANAG 4187 Ed. 5 Chapter 2, Chapter 3, Annex A`; `MIL-STD-331D Group A Test A3, Test A4.1, Test A5` | `MET-01`, `MET-06`, `MET-08` (`GAP-06`, `GAP-07`, `PRM-ESAD-004`, `PRM-ESAD-029`, `PRM-ESAD-031`, `PRM-ESAD-034`) | `STPA_MATRIX.md` Sections 6.1 (`EsadSafeArmState`), 6.2 (`REQ_SC_09` through `REQ_SC_11`), 9 (`T-11` through `T-13`, `TC_06_EsadProtocolInterlockAndHvFireGate`) |
| `SAF-02` | Safety Constraint | `MIL-STD-882E`; `SAE ARP4754A / ARP4761` | `MIL-STD-882E Task 202, Task 205, Task 206`; `SAE ARP4754A §5.1`; `SAE ARP4761 §3.1-3.3` | FHA/OHA threat & interlock derivation across `MET-01` through `MET-08` and `UCL-05` oversight | `STPA_MATRIX.md` Sections 1 through 6 (`REQ_L_01` through `REQ_L_04`, `REQ_H_01` through `REQ_H_06`, `REQ_UCA_01` through `REQ_UCA_08`, `REQ_SC_01` through `REQ_SC_16`, `H-1` through `H-19`, `UCA-001` through `UCA-076`, `LS-001` through `LS-152`, `SC-001` through `SC-076`) |
| `SAF-03` | Safety Constraint | `MIL-STD-1629A`; `RTCA DO-178C / DO-254` | `MIL-STD-1629A Method 101, Method 102`; `RTCA DO-178C §6.3, §11.0`; `RTCA DO-254 §10.0` | `MET-03`, `MET-06` (`FlightControllerCubeOrangePlus`, `CompanionComputeRpiCm5`, `ArtronEsadAndSensorUnit`, `GAP-WCET`, `GAP-REL`) | `STPA_MATRIX.md` Sections 6.2 (`REQ_SAF_08`, `REQ_SAF_09`), 7 (`FMECA-001` through `FMECA-061`, Peak RPN `192`), 8 (`OBJ-01` through `OBJ-64`) |
| `SAF-04` | Safety Constraint | `MIL-STD-461G`; `MIL-STD-810H` | `MIL-STD-461G CS114, CS116, CS118, RE102, RS103`; `MIL-STD-810H Method 501.7, 502.7, 506.6, 510.7, 514.8, 516.8` | `MET-01` through `MET-04`, `MET-06` (`PRM-PERF-016` through `PRM-PERF-019`, ESD touch, `GAP-ENV`) | `STPA_MATRIX.md` Sections 6.2 (`REQ_SAF_11`), 7 (`FMECA-016`, `FMECA-031`, `FMECA-044`, `FMECA-045`, `FMECA-060`), 8 |
| `MET-01` | METL Task | `ISO/IEC/IEEE 29148:2018`; `IEEE Std 1362-1998` | `ISO/IEC/IEEE 29148:2018 Annex A (§A.2)`; `IEEE Std 1362-1998 §4.3` | `MET-01` through `MET-08`, `OA-01` through `OA-19`, `SCN-01` through `SCN-08` | `STPA_MATRIX.md` Sections 6.1 (`UavFlightLifecycleState`), 6.3 (`TC_01_PreflightPowerAndRbfSequence` through `TC_08_EmergencyScrubHangfireAndC2Auth`) |
| `MET-02` | METL Task | `JARUS SORA v2.5` | `JARUS SORA v2.5 Annex B, Annex C` | `MET-01`, `MET-02`, `MET-03`, `MET-07` (`PRM-AF-008`, `PRM-GCS-001`, `PRM-GCS-004` through `PRM-GCS-007`, `PRM-PERF-003`, `PRM-PERF-015`) | `STPA_MATRIX.md` Sections 6.2 (`REQ_SC_02`, `REQ_SC_15`), 9 (`T-02`, `T-17`, `T-18`, `TC_02_BingoReserveAndEpsBrownoutMonitor`, `TC_08_EmergencyScrubHangfireAndC2Auth`) |
| `MET-03` | METL Task | `DoD Directive 3000.09` | `DoD Directive 3000.09 §4.1.a` | `MET-05`, `MET-06`, `MET-07`, `MET-08` (`UCL-02` exclusive HITL engagement, arming, self-destruct, and `Power Off ESAD`) | `STPA_MATRIX.md` Sections 6.2 (`REQ_SC_12`, `REQ_SC_16`), 6.3, 9 (`T-14`, `TC_05_EoIrTargetTrackAndSpeedCapAbort`, `TC_06_EsadProtocolInterlockAndHvFireGate`, `TC_08_EmergencyScrubHangfireAndC2Auth`) |
| `MET-04` | METL Task | `MIL-STD-882E` | `MIL-STD-882E Task 206` | `MET-08` (`GAP-SCRUB`, `OA-12`, `OA-15`, `OA-17`, `SCN-08`, reverse `RBF #3` -> `#2` -> `#1`) | `STPA_MATRIX.md` Sections 6.1 (`Pl40LauncherState`), 6.2 (`REQ_SC_16`, `REQ_SAF_12`), 7 (`FMECA-051`), `TC_08_EmergencyScrubHangfireAndC2Auth` |
| `CTL-01` | Control Pattern | `ASTM F3269-17` | `ASTM F3269-17 §5.2` | `MET-03`, `MET-05`, `MET-07` (`SimplexRtaSoftwareHostingConstraint`, `FlightEnvelopeSpeedConstraint`) | `STPA_MATRIX.md` Sections 3, 6.1 (`RtaEnvelopeMonitorState`), 9.1, 9.2 (`T-03`, `T-08`, `TC_03_SimplexRtaEnvelopeAndActuation`) |
| `CTL-02` | Control Pattern | `RTCA DO-362A` | `RTCA DO-362A §2.2, §3.2` | `MET-04`, `MET-07` (`PRM-RF-001` through `PRM-RF-007`, `PRM-GCS-002`, `PRM-GCS-008`) | `STPA_MATRIX.md` Sections 6.1 (`PaceC2LinkState`), 6.2 (`REQ_SC_12`, `REQ_SC_15`), 7 (`FMECA-037` through `FMECA-040`), `TC_04_GnssDeniedDrAndPaceLinkFailsafe` |
| `CTL-03` | Control Pattern | `RTCA DO-178C / DO-254`; `NATO STANAG 4187 Ed. 5` | `RTCA DO-178C §6.3`; `NATO STANAG 4187 Ed. 5 Chapter 2` | `MET-06`, `MET-07` (`EsadRs485ProtocolTimingConstraint`, `DscIn1ArmPulseTrain`, `GAP-04`) | `STPA_MATRIX.md` Sections 6.2 (`REQ_SC_08`, `REQ_SAF_04`), 7 (`FMECA-025` through `FMECA-028`, `FMECA-045`), 9 (`T-10`, `TC_04_GnssDeniedDrAndPaceLinkFailsafe`, `TC_06_EsadProtocolInterlockAndHvFireGate`) |
| `CTL-04` | Control Pattern | `SAE ARP4754A / ARP4761` | `SAE ARP4754A §5.1`; `SAE ARP4761 §3.2` | `MET-01`, `MET-03`, `MET-04`, `MET-07` (`CanTopologyIsolationConstraint`, `MainBatteryPreFlightVoltageConstraint`, `EpsEsadZeroBrownoutMarginConstraint`, `GAP-01`, `GAP-05`) | `STPA_MATRIX.md` Sections 3, 6.2 (`REQ_SC_02`, `REQ_SC_06`, `REQ_SAF_01`), 9 (`T-01`, `T-04`, `T-07`, `T-09`, `TC_01_PreflightPowerAndRbfSequence` through `TC_03_SimplexRtaEnvelopeAndActuation`) |
| `EXT-01` | Domain Extension | `OEM Avenger 5 V2.5 & Artron ESAD Baseline` (`AB00-0054-01AA-0005`) | `AVENGER 5 Spec sheet_rev3.pdf (#p1-#p3)`; `Avenger5_V2.5_block_diagram_rev5.pdf (#p1)`; `A5-user-manual 2.pdf (#p8-#p90)`; `A5_prep and safety_rev7.pdf (#p5-#p23)`; `ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf (#p1-#p28)` | `MET-01` through `MET-08` (`37` OEM BOM assemblies, `126` grounded parameters, `12` OEM gaps `GAP-01` through `GAP-SCRUB`) | `STPA_MATRIX.md` Sections 6.2 (`REQ_SAF_01` through `REQ_SAF_12`), 7 (`FMECA-001` through `FMECA-049`, `FMECA-054` through `FMECA-061`) |
| `EXT-02` | External Addition | `OEM ELI PL-40 Rev 2.6 Launcher Baseline` | `UAV_launcher_PL-40_user_manual_rev_2.6.pdf (#p3-#p4, #p6, #p18, #p21-#p28, #p29-#p45)` | `MET-02`, `MET-08` (`5` launcher BOM assemblies, `50` grounded parameters `PRM-PL40-001` through `PRM-PL40-050`, `IF-MECH-001` zero-wire interface) | `STPA_MATRIX.md` Sections 3, 6.1 (`Pl40LauncherState`), 6.2 (`REQ_SC_13`, `REQ_SC_14`, `REQ_SAF_03`), 7 (`FMECA-050` through `FMECA-053`), 9 (`T-15`, `T-16`, `TC_07_Pl40RailChargeLaunchAndZeroWire`, `TC_08_EmergencyScrubHangfireAndC2Auth`) |

---

### 10.3 Cross-Model Bijective Closure Summary

| Traceability Population | Declared Count | Target Coverage | Closure Status |
| :--- | :--- | :--- | :--- |
| Mission Essential Tasks (`MET-01` through `MET-08`) | 8 | 8 | Conforming |
| Gate 24 `OperationalAllocation` Directives (`MET-01` through `MET-08`) | 8 | 8 | Conforming |
| OMG UAF Operational Activities (`OA-01` through `OA-19`) | 19 | 19 | Conforming |
| Multi-Threaded Operational Scenarios (`SCN-01` through `SCN-08`) | 8 | 8 | Conforming |
| SysML v2 Interaction Definitions (`INT_01_PreflightPowerAndBit` through `INT_08_EmergencyScrubAndSafing`) | 8 | 8 | Conforming |
| Operational Go/No-Go Phase Gates (`GNG-01` through `GNG-08`) | 8 | 8 | Conforming |
| Level 1B Operational User Classes (`UCL-01` through `UCL-05`) | 5 | 5 | Conforming |
| SysML v2 Verification Test Cases (`TC_01_PreflightPowerAndRbfSequence` through `TC_08_EmergencyScrubHangfireAndC2Auth`) | 8 | 8 | Conforming |
| Gate 28 / Gate 29 `ObligationWitness` Directives (`OBL-01` through `EXT-02`) | 18 | 18 | Conforming |
| Level 1B Boundary Violations (Level 2 use-case leakage, ESAD hex opcodes, ungrounded ranges) | 0 | 0 | Conforming |

---

/// OperationalAllocation: [OA-01]
/// OperationalAllocation: [OA-02]
/// OperationalAllocation: [OA-03]
/// OperationalAllocation: [OA-04]
/// OperationalAllocation: [OA-05]
/// OperationalAllocation: [OA-06]
/// OperationalAllocation: [OA-07]
/// OperationalAllocation: [OA-08]
/// OperationalAllocation: [OA-09]
/// OperationalAllocation: [OA-10]
/// OperationalAllocation: [OA-11]
/// OperationalAllocation: [OA-12]
/// OperationalAllocation: [OA-13]
/// OperationalAllocation: [OA-14]
/// OperationalAllocation: [OA-15]
/// OperationalAllocation: [OA-16]
/// OperationalAllocation: [OA-17]
/// OperationalAllocation: [OA-18]
/// OperationalAllocation: [OA-19]
