## 3. Proposed Capabilities & Operational Justification (Trade-Offs)

| Document Attribute | Specification |
| :--- | :--- |
| **Unit Title** | Proposed Capabilities & Operational Justification (Trade-Offs) |
| **Effective Date** | `2026-11-16` |
| **Document Version** | `1.0.0` |
| **System Baseline** | `Avenger5V25UasSystem` (`Avenger 5 V2.5 UAS` / `ASTK A5 V2.5` + `ELI PL-40 Rev 2.6` + `Artron ESAD AB00-0054-01AA-0005` + `SwarmC2`) |
| **JSON Schema Mapping** | `proposed_capabilities` (`mission_drivers`, `value_proposition`, `trade_off_analysis`) |
| **Normative Governance** | `ISO/IEC/IEEE 29148:2018` §6.4, §8.4, Annex A (§A.2); `IEEE Std 1362-1998` §4, §4.3; `ISO/IEC/IEEE 15288:2023` §6.4.2-§6.4.4; `INCOSE SE Handbook v5.0` §2.3.5.4; `OMG UAF v2.0` |
| **SSOT Model Binding** | `.pipeline/schema.sysml` (`CAP-01` through `CAP-08`), `.pipeline/schema-digest.json`, `docs/research/RESEARCH_INVENTORY.md`, `schema/extracted/01_avenger5_platform_and_architecture.md`, `schema/extracted/parametric_limits.md` |

---

### 3.1 Mission Drivers & Capability Derivation Baseline

In accordance with `ISO/IEC/IEEE 29148:2018` Annex A (§A.2), `IEEE Std 1362-1998` §4, and `INCOSE SE Handbook v5.0` §2.3.5.4, the proposed capabilities of `Avenger5V25IntegratedSystem` are derived deterministically from the eight SysML v2 `capability def` AST nodes declared in `.pipeline/schema.sysml` (`CAP-01` through `CAP-08`, counted as `capability_defs: 8` in `.pipeline/schema-digest.json`). Every proposed capability closes an empirical technical, safety, or operational deficiency grounded in the OEM hardware/parametric baseline (`EXT-01`, `EXT-02`) and the `12` OEM engineering gap dispositions (`GAP-01` through `GAP-07`, `GAP-WCET`, `GAP-REL`, `GAP-SEPDIST`, `GAP-ENV`, `GAP-SCRUB`), while satisfying the `16` declared normative obligations (`OBL-01` through `OBL-04`, `SAF-01` through `SAF-04`, `MET-01` through `MET-04`, `CTL-01` through `CTL-04`) in `docs/research/RESEARCH_INVENTORY.md`.

Production `Avenger 5 V2.5` (`Avenger5V25UasSystem`) is a tactical loitering munition uncrewed aircraft system (`17.0 kg` MTOW X-wing pusher airframe carrying a `<= 5.0 kg` lethal package) requiring rapid field deployment from a zero-wire pneumatic rail catapult (`ELI PL-40 Rev 2.6`), resilient flight stability and GNSS-denied dead-reckoning across contested RF environments, positive human-in-the-loop (HITL) control over terminal EO/IR engagement (`<= 0.5 m` CEP), and strictly gated electronic ordnance initiation (`Artron ESAD AB00-0054-01AA-0005`). The production baseline specifies no recovery system (Recovery System: No; `ProductionNoParachuteConstraint`: `productionRecoverySystemInstalled == false`, `rndRecoveryOptionInstalled == false`), runs `ASTM F3269-17` Simplex Run-Time Assurance (RTA) exclusively in software inside `FlightControllerCubeOrangePlus` (`standaloneRtaBoxCount == 0`), and isolates the launcher from airframe avionics across a purely mechanical catapult rail (`electricalWireToUavCount == 0`, `IF-MECH-001`).

#### Table 3.1: Mission Drivers & Normative Capability Allocation Matrix

| Driver ID | Mission Driver & Operational Need | Derived Capability ID | Declared SysML `capability def` | Normative Obligations & Standards | Bound Scenarios & Operational Activities |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `DRV-01` | Provide a compact `17.0 kg` tactical airframe envelope with high-voltage `12S2P` energy capacity (`5400.0 s` endurance), pre-flight pack verification (`49.0-50.0 V`), and statutory `0.20` Bingo energy reserve (`GAP-05`, `GAP-ENV`) | `CAP-01` | `AirframeStructuralAndEnergySupply` | `OBL-01`, `MET-02` (`JARUS SORA v2.5` Annex B/C), `SAF-04` (`MIL-STD-810H` Methods 501.7, 502.7, 514.8, 516.8), `CTL-04`, `EXT-01` | `SCN-01`, `SCN-02`; `OA-01`, `OA-04` |
| `DRV-02` | Enforce `RBF #2` main bus energization before `RBF #3` pull (`GAP-06`), drive electric pusher propulsion (`24.0-80.0 m/s` envelope up to `5000.0 m`), and distribute isolated regulated rails (`8.0 V`, `12.0 V`, `14.0 V` per `GAP-01`) | `CAP-02` | `SwitchedPropulsionAndRegulatedDistribution` | `SAF-02` (`MIL-STD-882E` Task 202, Task 205), `SAF-03` (`MIL-STD-1629A` Method 101/102), `CTL-04` (`SAE ARP4754A` §5.1; `SAE ARP4761` §3.2), `EXT-01` | `SCN-01`, `SCN-02`, `SCN-08`; `OA-01`, `OA-02`, `OA-03`, `OA-04` |
| `DRV-03` | Prevent flight envelope excursions (`55.0 m/s` engagement cap / `80.0 m/s` VNE per `GAP-02`) and single-bus actuation blackouts without external RTA hardware overhead (`GAP-WCET`) | `CAP-03` | `AutonomousFlightControlAndSimplexRta` | `CTL-01` (`ASTM F3269-17` §5.2), `CTL-04` (`SAE ARP4754A` §5.1; `SAE ARP4761` §3.2), `SAF-03` (`RTCA DO-178C` §6.3, §11.0; `RTCA DO-254` §10.0), `EXT-01` | `SCN-02`, `SCN-03`, `SCN-04`; `OA-05`, `OA-09` |
| `DRV-04` | Sustain navigation continuity under satellite jamming/denial (`Disable GNSS`) with dual `mRo RM3100` and `CUAV SKYE2` dead-reckoning and supervise real-time `100 Hz` RS-485 ESAD health (`GAP-04`) | `CAP-04` | `CompanionSupervisionAndGnssDeniedNav` | `CTL-02` (`RTCA DO-362A` §2.2, §3.2), `CTL-03` (`RTCA DO-178C` §6.3; `NATO STANAG 4187 Ed. 5` Chapter 2), `SAF-03`, `EXT-01` | `SCN-01`, `SCN-03`, `SCN-05`; `OA-06`, `OA-07`, `OA-08` |
| `DRV-05` | Maintain encrypted `4.4-5.0 GHz` (`AES-256` FHSS) BVLOS/RLOS command, video, and positive HITL EO/IR target lock (`<= 0.5 m` CEP) with gimbal freeze recovery (`OA-14`) | `CAP-05` | `EncryptedDatalinkAndEoIrTerminalGuidance` | `OBL-04` (`NIST SP 800-82r3` Chapter 6, Appendix F AC/IA/SC), `CTL-02` (`RTCA DO-362A`), `MET-01`, `MET-03` (`DoD Directive 3000.09` §4.1.a), `EXT-01` | `SCN-03`, `SCN-04`, `SCN-07`; `OA-13`, `OA-14` |
| `DRV-06` | Guarantee zero premature high-voltage ordnance arming (`< 50.0 V` PBIT) via independent `STANAG 4187` dual physical barriers (`SS1` + `SS2` per `GAP-07`), `RBF #3` power-before-pull (`GAP-06`), and deterministic abort (`GAP-SCRUB`) | `CAP-06` | `Stanag4187SafeArmAndOrdnanceInterlock` | `SAF-01` (`NATO STANAG 4187 Ed. 5` Chapter 2/3/Annex A; `MIL-STD-331D` Group A Tests A3, A4.1, A5), `SAF-04` (`MIL-STD-461G` CS114/116/118/RE102/RS103), `MET-03`, `CTL-03`, `EXT-01` | `SCN-01`, `SCN-03`, `SCN-05`, `SCN-08`; `OA-08`, `OA-10`, `OA-11`, `OA-12`, `OA-17` |
| `DRV-07` | Deploy and launch `17.0 kg` aircraft safely in austere terrain (`~23.0 m/s` exit, `<= 25.0 m/s` limit per `GAP-03`) with zero airframe-to-rail electrical wires and clean hangfire scrub (`GAP-SCRUB`) | `CAP-07` | `PneumaticRailCatapultLaunch` | `EXT-02` (`ELI PL-40 Rev 2.6`), `MET-01`, `MET-04` (`MIL-STD-882E` Task 206), `OBL-02` | `SCN-06`, `SCN-08`; `OA-15`, `OA-16`, `OA-17` |
| `DRV-08` | Enforce `>= 8` char role access control (`UCL-01`, `UCL-02`, `UCL-03`), ESD and `>= 10.0 m` ground crew safety, calibrated `23.0 dBi` RF tracking, mission bounds, and `5W / CFF` tactical export | `CAP-08` | `SwarmC2MissionCommandAndGroundRfTracking` | `OBL-04` (`NIST SP 800-82r3`), `MET-01`, `MET-02` (`JARUS SORA v2.5`), `MET-03` (`DoD Directive 3000.09` §4.1.a), `CTL-02`, `EXT-01` | `SCN-07`, `SCN-08`; `OA-18`, `OA-19` |

---

### 3.2 Proposed Capabilities Taxonomy (AST `capability def` Baseline: `CAP-01` through `CAP-08`)

#### 3.2.1 `CAP-01`: `AirframeStructuralAndEnergySupply`

- **AST Symbol & Source Binding:** `capability def AirframeStructuralAndEnergySupply` (`.pipeline/schema.sysml` line 338).
- **Capability Scope:** Provides the modular X-wing pusher airframe structural envelope (`1.8 m` nominal / `1803.0 mm` CAD wingspan, `1.6 m` nominal / `1576.0 mm` CAD fuselage length, `1.1 m` nominal / `1095.0-1112.0 mm` CAD height, `17.0 kg` MTOW, `M6 x 30.0 mm` wing bolts tightened with a `10.0 mm` spanner, `-20.0 to +50.0 degC` ambient qualification) integrated with a removable `12S2P Li metal BEI maximus20` primary battery (`36.0-50.4 V` DC bus, `49.0-50.0 V` pre-flight pass band per `GAP-05`, `200.0 A` inline automotive fuse) sized for up to `90.0 min` (`5400.0 s`) endurance with a mandatory `0.20` statutory Bingo energy reserve (`1080.0 s`).
- **Realizing `part def` Assemblies & Interfaces:** `Avenger5V25IntegratedSystem`, `MainBatteryAndFuseUnit`, and `ElectricPropulsionUnit` (structural envelope and `RBF #1` covers/prop-fold strap), connected across `OpTx-01` (`CONN_01`: `batteryAndFuse.protectedDcOut` -> `powerMeter.mainDcIn`).
- **Allocated Activities, Constraints & Verification:** Executes `OA-01` (`ValidateBatteryAndPowerOnRbf2`) and `OA-04` (`MonitorBingoEnergyReserve`) under `MainBatteryPreFlightVoltageConstraint`, `BingoEnergyReserveConstraint`, and `ProductionNoParachuteConstraint` across `SCN-01` and `SCN-02`, verified by `TC_01_PreflightPowerAndRbfSequence` and `TC_02_BingoReserveAndEpsBrownoutMonitor`.

#### 3.2.2 `CAP-02`: `SwitchedPropulsionAndRegulatedDistribution`

- **AST Symbol & Source Binding:** `capability def SwitchedPropulsionAndRegulatedDistribution` (`.pipeline/schema.sysml` line 340).
- **Capability Scope:** Gates primary DC bus power through the `PowerMeterAndRbfSwitch` (`UAV Power R.B.F. Key #2 (XT60E-F)`), enforcing strict power-before-pull sequencing (`pullRbf2BeforeRbf3 == true`, `GAP-06`). Commands the rear folding pusher propeller via `PWM` throttle from `Power Meter` to `IBEX160` ESC and `AXI 5345/16 HD GOLD LINE V3` BLDC motor across `24.0-80.0 m/s` flight envelopes up to `5000.0 m` service ceiling (`12.0 m/s` ground wind, `28.0 m/s` cruise wind tolerance), while bridging `ESC UART` telemetry (RPM, ESC/motor temperature, bus voltage, current) onto `CAN 1`. Simultaneously drives a `970.0 cm` DC trunk to `ElectronicPowerSystemEps` to regulate `8.0 V` (`8x` servos), `12.0 V` (`DTC` radio, `8.0-17.0 V` allowed input), `14.0 V` (`Artron ESAD` per `GAP-01`), pitot/mag/gimbal sensor rails, and irreversible `Power Off ESAD` rail isolation (with optional `2x 50.0 V` RnD recovery igniter outputs permanently inhibited on production).
- **Realizing `part def` Assemblies & Interfaces:** `PowerMeterAndRbfSwitch`, `ElectricPropulsionUnit`, and `ElectronicPowerSystemEps` interconnected across `OpTx-01` through `OpTx-10` (`CONN_01` through `CONN_10`).
- **Allocated Activities, Constraints & Verification:** Executes `OA-01`, `OA-02` (`CommandPusherThrottleAndReadEscTelem`), `OA-03` (`DistributeRegulatedPowerRails`), and `OA-04` under `EpsEsadZeroBrownoutMarginConstraint` and `FlightEnvelopeSpeedConstraint` across `SCN-01`, `SCN-02`, and `SCN-08`, verified by `TC_01_PreflightPowerAndRbfSequence` and `TC_02_BingoReserveAndEpsBrownoutMonitor`.

#### 3.2.3 `CAP-03`: `AutonomousFlightControlAndSimplexRta`

- **AST Symbol & Source Binding:** `capability def AutonomousFlightControlAndSimplexRta` (`.pipeline/schema.sysml` line 602).
- **Capability Scope:** Executes EKF2 inertial/sensor state estimation, inner-loop aerodynamic stabilization, and physically segregated DroneCAN surface actuation inside `FlightControllerCubeOrangePlus` (`ASTK A5 V2.5` stack) without an external RTA hardware box (`simplexRtaSoftwareHosted == true`, `standaloneRtaBoxCount == 0`). `CAN 1` (`970.0 cm` trunk + `4x 120.0 cm` stubs) drives `4x HV6160-DroneCAN` tail ruddervator servos (`#1` through `#4`, mixed pitch/yaw skid-turn without banking) alongside `Power Meter` and `EPS` taps, while `CAN 2` routes through a `CAN/power splitter PCB` in a strictly series daisy-chain across `4x HV6160-DroneCAN` wing roll servos (`#5` through `#8`) for active roll stabilization. Hosts software `ASTM F3269-17` Simplex RTA monitors (`RtaEnvelopeMonitorState`) enforcing the `55.0 m/s` engagement speed cap (`Abort Engaging`), `80.0 m/s` structural `VNE` limit (`GAP-02`), geofence containment, Bingo/sag RTL, GCS loss RTL, and ESAD bus-fault disarmament requests.
- **Realizing `part def` Assemblies & Interfaces:** `FlightControllerCubeOrangePlus` and `DroneCanSurfaceActuation` across `OpTx-04` (`CONN_04`), `OpTx-09` through `OpTx-12` (`CONN_09` through `CONN_12`), and `OpTx-14` through `OpTx-17` (`CONN_14` through `CONN_17`).
- **Allocated Activities, Constraints & Verification:** Executes `OA-05` (`ExecuteSimplexRtaEnvelopeCheck`) and `OA-09` (`ActuateTailAndWingSurfaces`) under `SimplexRtaSoftwareHostingConstraint`, `CanTopologyIsolationConstraint`, and `FlightEnvelopeSpeedConstraint` across `SCN-02`, `SCN-03`, and `SCN-04`, verified by `TC_03_SimplexRtaEnvelopeAndActuation`.

#### 3.2.4 `CAP-04`: `CompanionSupervisionAndGnssDeniedNav`

- **AST Symbol & Source Binding:** `capability def CompanionSupervisionAndGnssDeniedNav` (`.pipeline/schema.sysml` line 604).
- **Capability Scope:** Runs the `RPI CM5004032` companion mission computer (`CompanionComputeRpiCm5`, `OC Master`) to bridge `SwarmC2` IP over onboard Ethernet (`CONN_18`), exchange telemetry/commands with `Cube orange+` over `Serial` (`CONN_14`), and execute `100 Hz` (`0.01 s` period) `115200 bps` `8N1` half-duplex RS-485 `CRC-16 XModem` supervisory polling of the `Artron ESAD` (`<= 5.0 ms` reply latency, `<= 10.0 ms` incomplete/watchdog timeout per `GAP-04`) paired with Stage 2 `DSC_IN1` (`1000.0 Hz`, `1.0 ms` period, `50.0 percent` duty, `2` pulses) discrete hardware arming (`CONN_20`). In parallel, `NavigationAndAirDataSuite` fuses `Septentrio Asterx-m3 pro` RTK GNSS + `Talysman TW3972EXF` antenna (`Serial`, `CONN_15`) with dual redundant `mRo RM3100` magnetometers/barometers and heated `CUAV SKYE2` pitot airspeed (`CAN 2` daisy-chain end-nodes, `CONN_13`) to sustain INS/dead-reckoning (`DR`) flight when GNSS fails or operator `Disable GNSS` is commanded, gated pre-flight by `<= 3.0 m/s` calm-air and `>= 10.0 m/s` airflow checks.
- **Realizing `part def` Assemblies & Interfaces:** `CompanionComputeRpiCm5` and `NavigationAndAirDataSuite` across `OpTx-07` (`CONN_07`), `OpTx-13` through `OpTx-15` (`CONN_13` through `CONN_15`), `OpTx-18` (`CONN_18`), and `OpTx-20` (`CONN_20`).
- **Allocated Activities, Constraints & Verification:** Executes `OA-06` (`RunPitotAndMagPreflightCheck`), `OA-07` (`SwitchToGnssDeniedDeadReckoning`), and `OA-08` (`SuperviseEsadOcMasterCycle`) under `PitotPreflightCalibrationConstraint` and `EsadRs485ProtocolTimingConstraint` across `SCN-01`, `SCN-03`, and `SCN-05`, verified by `TC_04_GnssDeniedDrAndPaceLinkFailsafe` and `TC_06_EsadProtocolInterlockAndHvFireGate`.

#### 3.2.5 `CAP-05`: `EncryptedDatalinkAndEoIrTerminalGuidance`

- **AST Symbol & Source Binding:** `capability def EncryptedDatalinkAndEoIrTerminalGuidance` (`.pipeline/schema.sysml` line 900).
- **Capability Scope:** Establishes `4.4-5.0 GHz` `AES-256` FHSS air-ground RF command and HD video transport at `2.0 W` total TX power (`2x 1.0 W` dual `MPSL4400` antennas) across `60.0 km` baseline and `90.0 km` V2.5 extended (`180.0 km` V1 manual) RLOS (`GAP-02`), backed by an internal switched Ethernet fabric and lockable external `USB/ETH` service interface (`OnboardEthernetAndC2RadioUnit`). Integrates the `Nighthawk2UZ` 2-axis stabilized EO/IR gimbal (`1280 x 720 px` daylight and thermal sensors, `40.0x` zoom, `-45.0 to +135.0 deg` pitch, `-165.0 to +165.0 deg` yaw/roll) with `Trip6` camera compute (`Power + HDMI`, `ETH`, `Serial` to `Cube orange+`), supporting `2.0-5.0 s` operator-supervised target lock hold, shallow `15.0 deg` approach (`22.0 deg` max dive, `<= 15.0 deg` initial target elevation), automatic `Abort Engaging` above `55.0 m/s`, in-flight `Reboot Gimbal` Ethernet recovery, and `<= 0.5 m` (`<= 50.0 cm`) terminal CEP against stationary targets.
- **Realizing `part def` Assemblies & Interfaces:** `OnboardEthernetAndC2RadioUnit` and `EoIrSeekerAndTrackerUnit` across `OpTx-05` (`CONN_05`), `OpTx-08` (`CONN_08`), `OpTx-16` through `OpTx-19` (`CONN_16` through `CONN_19`), and `OpTx-21` (`CONN_21`).
- **Allocated Activities, Constraints & Verification:** Executes `OA-13` (`AcquireAndTrackTerminalTarget`) and `OA-14` (`RebootGimbalAndBridgeEthernet`) under `EngagementSpeedAndTrackHoldConstraint` and `PaceC2LinkState` across `SCN-03`, `SCN-04`, and `SCN-07`, verified by `TC_05_EoIrTargetTrackAndSpeedCapAbort`.

#### 3.2.6 `CAP-06`: `Stanag4187SafeArmAndOrdnanceInterlock`

- **AST Symbol & Source Binding:** `capability def Stanag4187SafeArmAndOrdnanceInterlock` (`.pipeline/schema.sysml` line 902).
- **Capability Scope:** Enforces `NATO STANAG 4187 Ed. 5` all-electronic safe, arm, and initiation control across `ArtronEsadAndSensorUnit` (`AB00-0054-01AA-0005`, `MIL-STD-461G`, `MIL-STD-331D` Group A drop qualified, `3x M3` `75.0 mm` BCD mount) and Sensor Board (`2x M2` mount, `5.0 V` regulated interface, ORed `IRQ_L` proximity/impact trigger) coupled to a `<= 5.0 kg` warhead (`4.98 +/- 0.02 kg` tested holder mass, `1.5 mm` hex terminal fasteners). Combines `RBF #3` `UMB` continuity (`< 0.5 Ohm` at `20.0 mA`) enforcing `RBF #2` power-before-pull ordering (`GAP-06`), pre-flight PBIT confirming `< 50.0 V` internal HV (`WarheadMassAndPbitHvSafetyConstraint`), dual independent physical barriers `SS1` (inertial launch acceleration via `CONN_24`) and `SS2` (`Safe Distance Exceed == 1` per `GAP-07` and `GAP-SEPDIST`), Stage 2 `DSC_IN1` `1000.0 Hz` `2`-pulse discrete gate strictly after `SS1` + `SS2` (premature pulsing latches fault lockout), `100 Hz` RS-485 `CRC-16 XModem` supervision across `14.0-32.0 V` `VDC_IN` (`GAP-01`), `0-1800 V` `J401` fire output, `>= 5.0 s` self-destruct hold + Slide-to-Confirm, `Disarm ESAD On GCS Timeout`, and irreversible `Power Off ESAD`.
- **Realizing `part def` Assemblies & Interfaces:** `ArtronEsadAndSensorUnit`, supervised by `CompanionComputeRpiCm5` (`OpTx-20` / `CONN_20`), powered by `ElectronicPowerSystemEps` (`OpTx-06` / `CONN_06`), and triggered mechanically by launch inertia (`OpTx-24` / `CONN_24`).
- **Allocated Activities, Constraints & Verification:** Executes `OA-08`, `OA-10` (`ExecuteEsadBootAndPbit`), `OA-11` (`TransitionEsadArmingSequence`), `OA-12` (`CommandEsadAbortAndSelfDestruct`), and `OA-17` under `EsadInputVoltageAndBrownoutConstraint`, `EsadRbf3PowerBeforePullConstraint`, `EsadSafeDistanceExceedConstraint`, `EsadRs485ProtocolTimingConstraint`, and `EsadSafeArmState` across `SCN-01`, `SCN-03`, `SCN-05`, and `SCN-08`, verified by `TC_06_EsadProtocolInterlockAndHvFireGate` and `TC_08_EmergencyScrubHangfireAndC2Auth`.

#### 3.2.7 `CAP-07`: `PneumaticRailCatapultLaunch`

- **AST Symbol & Source Binding:** `capability def PneumaticRailCatapultLaunch` (`.pipeline/schema.sysml` line 1151).
- **Capability Scope:** Provides expeditionary mechanical rail launch (`ELI Military Simulations PL-40 Rev 2.6`: `5.0 m` nominal / `4938.0 mm` CAD length, `1.28 m` disassembled sections, `12.0 deg` elevation, `1116.0 mm` rail top height, `602.0 mm` front leg span, `5.0 min` field setup, `68.0 kg` system total = `43.0 kg` case + `25.0 kg` compressor, `30.0 kg` max supported MTOW, `100` launch rope/bearing maintenance interval). Pressurizes the pneumatic tank to `13.0-14.0 bar` (`<= 8.0 min` fill, `0.05 bar` cutoff hysteresis) from `2x Makita BL1860B` (`18.0 V`, `6000.0 mAh`, `<= 14.5 V` UVLO cutoff, `>= 16.0 V` after `5.0 s` restart) or a `16.0 bar` DIN `8.0 mm` external PCP source, enforces `>= 2` lift crew, prop-safe carriage zone clearance (`145.0-155.5 mm`), `<= 12.0 m/s` ground headwind, carriage red safety pin pull, Main Valve `4` open, and simultaneous `>= 2.0 s` dual safety-covered switch firing hold, imparting `~23.0 m/s` (`22.7-23.5 m/s` at `17.0 kg`, capped `<= 25.0 m/s` per `GAP-03`) with **zero electrical or CAN conductors to the UAV (`electricalWireToUavCount == 0`, `IF-MECH-001`)**, plus `SAFE_SCRUB_ABORT` depressurization (`GAP-SCRUB`).
- **Realizing `part def` Assemblies & Interfaces:** `Pl40PneumaticLauncher` driving `ElectricPropulsionUnit` across pure mechanical impulse interface `OpTx-23` (`CONN_23`: `pl40Launcher.mechLaunchOut` -> `propulsionAndAirframe.mechLaunchRailIn`).
- **Allocated Activities, Constraints & Verification:** Executes `OA-15` (`ChargePl40CompressorWithUvloCheck`), `OA-16` (`ExecuteLaunchGoNoGoAndDualTrigger`), and `OA-17` (`DepressurizeAndScrubPl40Launcher`) under `Pl40MassAndExitVelocityConstraint`, `Pl40UvloAndDualSwitchConstraint`, and `Pl40LauncherState` across `SCN-06` and `SCN-08`, verified by `TC_07_Pl40RailChargeLaunchAndZeroWire` and `TC_08_EmergencyScrubHangfireAndC2Auth`.

#### 3.2.8 `CAP-08`: `SwarmC2MissionCommandAndGroundRfTracking`

- **AST Symbol & Source Binding:** `capability def SwarmC2MissionCommandAndGroundRfTracking` (`.pipeline/schema.sysml` line 1153).
- **Capability Scope:** Governs ground mission command, RF tracking, and operator safety via `SwarmC2OperatorConsole` (`Windows 11` rugged tablet) and `GroundRfStationAndAntennaTracker`. Enforces `>= 8` char role-based authentication across `UCL-01` (`Pilot`), `UCL-02` (`Payload Operator`), and `UCL-03` (`Launch Assistant`), Transport Box ESD grounding touch, `>= 10.0 m` UAV-to-Ground Radio Box separation, `Directional Antenna Rotator` calibration (`Auto Follow` + `0.5 deg` CW/CCW azimuth fine step) strictly BEFORE touching the UAV, `MARS 23.0 dBi` directional + OMNI antennas (`4.4-5.0 GHz`, `2.0 W`) with optional `200.0 m` fiber tether, `24` char mission naming, `50.0-3000.0 m` waypoint/altitude slider (`250.0 m` major step), `>= 300.0 m` loiter radius, `2.0 min` telemetry detect window, `105.0 s` GCS failsafe timeout, `>= 5.0 s` ESAD self-destruct hold + Slide-to-Confirm, and `5W / CFF` target report export to `ATAK`, `SitaWare HQ`, and `DELTA`.
- **Realizing `part def` Assemblies & Interfaces:** `SwarmC2OperatorConsole` and `GroundRfStationAndAntennaTracker` connected across `OpTx-22` (`CONN_22`) and `OpTx-21` (`CONN_21`).
- **Allocated Activities, Constraints & Verification:** Executes `OA-18` (`AuthenticateOperatorAndCalibrateRotator`) and `OA-19` (`ExportTargetReport5wCff`) under `SwarmC2AuthAndMissionBoundsConstraint` and `GroundCrewSeparationAndEsdConstraint` across `SCN-07` and `SCN-08`, verified by `TC_08_EmergencyScrubHangfireAndC2Auth`.

#### Table 3.2: Quantitative Capability Envelopes & Grounded Parametric Bounds (`CAP-01` through `CAP-08`)

*(All rows obey Check 26 strict separation: pure numeric scalars in `Value`, pure unit tokens with zero numbers in `Units`, and zero inline math expressions inside cells.)*

| Capability ID | Param ID | Parameter Description | Bound / Qualifier | Value | Units | Normative / OEM Source |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `CAP-01` | `PRM-AF-001` | Nominal assembled wingspan (`1803.0 mm` CAD) | Nominal | 1.8 | m | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-01` | `PRM-AF-003` | Nominal assembled overall length (`1576.0 mm` CAD) | Nominal | 1.6 | m | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-01` | `PRM-AF-008` | Maximum authorized takeoff weight (MTOW) | Max | 17.0 | kg | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-01` | `PRM-PERF-002` | Maximum mission endurance (`90.0 min` equivalent) | Max | 5400.0 | s | `AVENGER 5 Spec sheet_rev3.pdf#p2` |
| `CAP-01` | `PRM-PERF-003` | Derived statutory Bingo energy reserve fraction | Min | 0.20 | ratio | `JARUS SORA v2.5` / `MIL-STD-882E` |
| `CAP-01` | `PRM-AV-001` | `12S2P` main battery DC bus floor (`36.0-50.4 V`) | Min | 36.0 | V | `Avenger5_V2.5_block_diagram_rev5.pdf#p1` |
| `CAP-01` | `PRM-AV-002` | `12S2P` main battery DC bus ceiling (`36.0-50.4 V`) | Max | 50.4 | V | `Avenger5_V2.5_block_diagram_rev5.pdf#p1` |
| `CAP-01` | `PRM-AV-003` | Pre-flight battery check voltage floor (`GAP-05`) | Min | 49.0 | V | `A5-user-manual 2.pdf#p53`, `#p56` |
| `CAP-01` | `PRM-AV-004` | Pre-flight battery check nominal ceiling (`GAP-05`) | Max | 50.0 | V | `A5-user-manual 2.pdf#p56` |
| `CAP-01` | `PRM-AV-005` | Main battery inline automotive fuse rating | Exact | 200.0 | A | `Avenger5_V2.5_block_diagram_rev5.pdf#p1` |
| `CAP-02` | `PRM-AV-006` | Regulated EPS servo power rail (`8x HV6160-DroneCAN`) | Nominal | 8.0 | V | `Avenger5_V2.5_block_diagram_rev5.pdf#p1` |
| `CAP-02` | `PRM-AV-007` | Regulated EPS C2 radio rail (`8.0-17.0 V` input window) | Nominal | 12.0 | V | `Avenger5_V2.5_block_diagram_rev5.pdf#p1` |
| `CAP-02` | `PRM-AV-010` | Regulated EPS ESAD rail (`GAP-01` zero brownout margin) | Nominal | 14.0 | V | `Avenger5_V2.5_block_diagram_rev5.pdf#p1` |
| `CAP-02` | `PRM-AV-012` | Fuselage power and `CAN 1` trunk harness length | Nominal | 970.0 | cm | `Avenger5_V2.5_block_diagram_rev5.pdf#p1` |
| `CAP-02` | `PRM-PERF-015` | Airframe maximum operational service ceiling | Max | 5000.0 | m | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-02` | `PRM-PERF-018` | Airframe minimum ambient operating temperature (Normalized Kelvin scalar T / 1.0 K; OEM: -20.0 degC) | Min | 253.15 | Dimensionless | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-02` | `PRM-PERF-019` | Airframe maximum ambient operating temperature (Normalized Kelvin scalar T / 1.0 K; OEM: 50.0 degC) | Max | 323.15 | Dimensionless | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-03` | `PRM-PERF-004` | Stall airspeed per V2.5 Spec Sheet (`26.0 m/s` V1 min) | Min | 24.0 | m/s | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-03` | `PRM-PERF-007` | Nominal cruise airspeed per V2.5 Spec (`30.0 m/s` V1) | Nominal | 31.0 | m/s | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-03` | `PRM-PERF-009` | Max horizontal airspeed per V2.5 Spec (`38.0 m/s` V1) | Max | 42.0 | m/s | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-03` | `PRM-PERF-010` | Target engagement speed cap (Simplex RTA dive limit) | Max | 55.0 | m/s | `A5-user-manual 2.pdf#p10`, `#p88` |
| `CAP-03` | `PRM-PERF-011` | Structural dive speed limit VNE per V2.5 Spec (`GAP-02`) | Max | 80.0 | m/s | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-03` | `PRM-AV-013` | `CAN 1` tail fin servo stub length (`4x` stubs) | Nominal | 120.0 | cm | `Avenger5_V2.5_block_diagram_rev5.pdf#p1` |
| `CAP-03` | `PRM-AV-014` | Tail ruddervator servos on `CAN 1` (`HV6160-DroneCAN`) | Exact | 4 | count | `Avenger5_V2.5_block_diagram_rev5.pdf#p1` |
| `CAP-03` | `PRM-AV-015` | Wing roll servos on `CAN 2` (`HV6160-DroneCAN`) | Exact | 4 | count | `Avenger5_V2.5_block_diagram_rev5.pdf#p1` |
| `CAP-04` | `PRM-AV-016` | Dual redundant `mRo RM3100` mag/baro modules (`CAN 2`) | Exact | 2 | count | `Avenger5_V2.5_block_diagram_rev5.pdf#p1` |
| `CAP-04` | `PRM-AV-017` | Pre-flight calm-air pitot upper speed threshold | Max | 3.0 | m/s | `A5-user-manual 2.pdf#p56` |
| `CAP-04` | `PRM-AV-018` | Pre-flight airflow pitot lower speed threshold | Min | 10.0 | m/s | `A5-user-manual 2.pdf#p56` |
| `CAP-04` | `PRM-ESAD-014` | `RPI CM5` to ESAD half-duplex RS-485 baud rate (`8N1`) | Exact | 115200 | bps | `ESAD ICD AB00-0054-01AA-0005#p14-15` |
| `CAP-04` | `PRM-ESAD-017` | `RPI CM5` to ESAD supervisory polling rate (`GAP-04`) | Exact | 100.0 | Hz | `ESAD ICD AB00-0054-01AA-0005#p15` |
| `CAP-04` | `PRM-ESAD-019` | RS-485 incomplete frame / watchdog timeout | Max | 10.0 | ms | `ESAD ICD AB00-0054-01AA-0005#p15` |
| `CAP-04` | `PRM-ESAD-020` | ESAD maximum reply latency from command end | Max | 5.0 | ms | `ESAD ICD AB00-0054-01AA-0005#p15` |
| `CAP-05` | `PRM-RF-001` | `DTC` FHSS C2 radio operating frequency floor | Min | 4.4 | GHz | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-05` | `PRM-RF-002` | `DTC` FHSS C2 radio operating frequency ceiling | Max | 5.0 | GHz | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-05` | `PRM-RF-003` | `DTC` C2 radio total RF TX power (`2x 1.0 W` antennas) | Max | 2.0 | W | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-05` | `PRM-RF-005` | `DTC` C2 datalink cryptographic key bit length (`AES-256`, 256 bits) | Exact | 256 | count | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-05` | `PRM-RF-006` | Baseline RF radio line-of-sight (RLOS) range | Nominal | 60.0 | km | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-05` | `PRM-RF-007` | Extended RLOS range per V2.5 Spec (`180.0 km` V1 manual) | Max | 90.0 | km | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-05` | `PRM-AV-019` | `Nighthawk2UZ` day/thermal horizontal resolution (1280 pixels) | Exact | 1280 | count | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-05` | `PRM-AV-021` | `Nighthawk2UZ` combined optical/digital zoom magnification ratio (OEM: 40.0x zoom) | Max | 40.0 | ratio | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-05` | `PRM-GCS-011` | Minimum EO daylight track hold prior to engagement | Min | 2.0 | s | `A5-user-manual 2.pdf#p88` |
| `CAP-05` | `PRM-PERF-020` | Terminal circular error probable (CEP) vs stationary target | Max | 0.5 | m | `AVENGER 5 Spec sheet_rev3.pdf#p1`, `#p2` |
| `CAP-06` | `PRM-AF-009` | Maximum authorized lethal package / warhead mass | Max | 5.0 | kg | `AVENGER 5 Spec sheet_rev3.pdf#p2` |
| `CAP-06` | `PRM-ESAD-001` | ESAD `VDC_IN` minimum operating input (`GAP-01`) | Min | 14.0 | V | `ESAD ICD AB00-0054-01AA-0005#p14` |
| `CAP-06` | `PRM-ESAD-003` | ESAD `VDC_IN` maximum operating input (`28.0 V` nom) | Max | 32.0 | V | `ESAD ICD AB00-0054-01AA-0005#p14` |
| `CAP-06` | `PRM-ESAD-004` | `RBF #3` umbilical continuity loop (`UMB`) max voltage drop at `20.0 mA` sense current (OEM: `0.5 Ohm` max resistance) | Max | 0.01 | V | `ESAD ICD AB00-0054-01AA-0005#p14` |
| `CAP-06` | `PRM-ESAD-005` | `RBF #3` umbilical loop (`UMB`) continuity sense current | Nominal | 20.0 | mA | `ESAD ICD AB00-0054-01AA-0005#p14` |
| `CAP-06` | `PRM-ESAD-006` | Stage 2 `DSC_IN1` discrete arm square-wave frequency | Exact | 1000.0 | Hz | `ESAD ICD AB00-0054-01AA-0005#p14` |
| `CAP-06` | `PRM-ESAD-009` | Stage 2 `DSC_IN1` required discrete arm pulse count (`2` pulses) | Exact | 2 | count | `ESAD ICD AB00-0054-01AA-0005#p14` |
| `CAP-06` | `PRM-ESAD-029` | Pre-flight PBIT safe internal high-voltage ceiling | Max | 50.0 | V | `ESAD ICD AB00-0054-01AA-0005#p18`, `#p26-27` |
| `CAP-06` | `PRM-ESAD-031` | Armed `J401` high-voltage initiation charge ceiling | Max | 1800.0 | V | `ESAD ICD AB00-0054-01AA-0005#p18`, `#p26-27` |
| `CAP-06` | `PRM-GCS-010` | Minimum operator hold before Slide-to-Confirm ESAD abort | Min | 5.0 | s | `A5-user-manual 2.pdf#p84` |
| `CAP-07` | `PRM-PL40-001` | `PL-40` maximum supported aircraft takeoff mass | Max | 30.0 | kg | `UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p3` |
| `CAP-07` | `PRM-PL40-002` | `PL-40` hard maximum rated carriage exit velocity (`GAP-03`) | Max | 25.0 | m/s | `UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p3`, `#p24` |
| `CAP-07` | `PRM-PL40-003` | Avenger 5 interpolated rail exit velocity (`17.0 kg`) | Nominal | 23.0 | m/s | `UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37` |
| `CAP-07` | `PRM-PL40-006` | Fixed `PL-40` pneumatic launch rail elevation angle | Exact | 12.0 | deg | `UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37`, `#p41` |
| `CAP-07` | `PRM-PL40-007` | Assembled 3-section launch rail nominal length | Nominal | 5.0 | m | `UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37` |
| `CAP-07` | `PRM-PL40-027` | Avenger 5 operating pneumatic launch pressure floor (Normalized pressure ratio P / 100 kPa; OEM: `13.0 bar`) | Min | 13.0 | ratio | `A5-user-manual 2.pdf#p54` |
| `CAP-07` | `PRM-PL40-028` | `PL-40` onboard compressor max pressure / launch ceiling (Normalized pressure ratio P / 100 kPa; OEM: `14.0 bar`) | Max | 14.0 | ratio | `UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p22`, `#p37` |
| `CAP-07` | `PRM-PL40-034` | `Makita BL1860B` (`18.0 V`) compressor UVLO cutoff floor | Min | 14.5 | V | `UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p23` |
| `CAP-07` | `PRM-PL40-037` | Dual safety-covered launch switch simultaneous hold | Min | 2.0 | s | `UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p25-26` |
| `CAP-07` | `PRM-PERF-016` | Maximum authorized ground headwind during launch | Max | 12.0 | m/s | `AVENGER 5 Spec sheet_rev3.pdf#p3` |
| `CAP-08` | `PRM-RF-009` | Directional `MARS` ground tracking antenna gain | Nominal | 23.0 | dBi | `A5-user-manual 2.pdf#p11` |
| `CAP-08` | `PRM-RF-010` | `Antenna Rotator` fine manual azimuth step (`Auto Follow`) | Exact | 0.5 | deg | `A5-user-manual 2.pdf#p72-74` |
| `CAP-08` | `PRM-RF-012` | Optional tactical fiber spool between GCS and Radio Box | Max | 200.0 | m | `A5-user-manual 2.pdf#p11` |
| `CAP-08` | `PRM-GCS-001` | Minimum UAV-to-Ground Radio Box separation during prep | Min | 10.0 | m | `A5-user-manual 2.pdf#p52` |
| `CAP-08` | `PRM-GCS-004` | Minimum mission waypoint altitude and slider floor | Min | 50.0 | m | `A5-user-manual 2.pdf#p46-48`, `#p63` |
| `CAP-08` | `PRM-GCS-005` | Dynamic mission altitude slider upper limit | Max | 3000.0 | m | `A5-user-manual 2.pdf#p63`, `#p65` |
| `CAP-08` | `PRM-GCS-007` | Minimum CW loiter radius enforced by `SwarmC2` | Min | 300.0 | m | `A5-user-manual 2.pdf#p46-48`, `#p59-64` |
| `CAP-08` | `PRM-GCS-008` | GCS failsafe lost-link RTL timeout example baseline | Nominal | 105.0 | s | `A5-user-manual 2.pdf#p34` |
| `CAP-08` | `PRM-GCS-009` | Operator role login minimum password character count (OEM: `8 chars`) | Min | 8 | count | `A5-user-manual 2.pdf#p27-29` |

---

### 3.3 Operational Value Proposition & Effectiveness Quantification

The integrated `CAP-01` through `CAP-08` architecture delivers measurable mission effectiveness (`INCOSE SE Handbook v5.0` §2.3.5.4, `JARUS SORA v2.5` Annex B/C, `DoD Directive 3000.09` §4.1.a) without incurring external hardware complexity:

1. **Expeditionary Launch Agility & Zero-Wire Clean Separation:** The `ELI PL-40 Rev 2.6` catapult deploys in `5.0 min` (`43.0 kg` rail case + `25.0 kg` compressor), pressurizes within `<= 8.0 min`, and launches a `17.0 kg` airframe at `~23.0 m/s` with zero airframe-to-launcher electrical wires (`IF-MECH-001`), eliminating runway dependency and dynamic umbilical tear hazards.
2. **Long-Endurance, Protected Energy Envelope:** Combining the `12S2P` `36.0-50.4 V` architecture (`49.0-50.0 V` pre-flight verification) with a `0.20` statutory Bingo reserve (`1080.0 s`) guarantees `4320.0 s` (`72.0 min`) of productive tactical loiter while preserving deterministic RTL energy margin and minimizing resistive (`I^2 * R`) trunk drop across the `970.0 cm` bus feeding the `14.0 V` ESAD converter (`GAP-01`).
3. **Resilience in Contested RF & GNSS-Denied Environments:** Dual `mRo RM3100` magnetometers/barometers and heated `CUAV SKYE2` pitot on physically isolated `CAN 2` enable deterministic `Disable GNSS` dead-reckoning continuity, complemented by `4.4-5.0 GHz` `AES-256` FHSS links (`60.0-90.0 km` RLOS, `23.0 dBi` `MARS` directional tracking, optional `200.0 m` fiber spool standoff) and `105.0 s` autonomous lost-link failsafe + ESAD disarm.
4. **Precision Lethal Effectiveness Under Positive Human Judgment:** Stabilized `1280 x 720 px` Day/Thermal (`40.0x` zoom) EO/IR tracking (`2.0-5.0 s` hold) achieves `<= 0.5 m` terminal CEP while enforcing a software `ASTM F3269-17` Simplex dive clamp (`<= 55.0 m/s` engagement abort vs `80.0 m/s` VNE), `NATO STANAG 4187 Ed. 5` dual barriers (`SS1` + `SS2`), `>= 5.0 s` self-destruct hold + Slide-to-Confirm, and `5W / CFF` digital interoperability (`ATAK`, `SitaWare HQ`, `DELTA`).

#### Quantitative Endurance Reserve & ESAD Voltage Margin Formulation

$$
\begin{aligned}
t_{\mathrm{bingo}} &= \rho_{\mathrm{bingo}} \cdot t_{\mathrm{endurance,max}} \\
t_{\mathrm{usable}} &= (1 - \rho_{\mathrm{bingo}}) \cdot t_{\mathrm{endurance,max}} \\
\Delta V_{\mathrm{esad,margin}} &= V_{\mathrm{EPS,esad}} - V_{\mathrm{ESAD,min}} - \Delta V_{\mathrm{harness}}
\end{aligned}
$$

#### Parameter Definitions & Engineering Units

| Parameter | Symbol | Units | Constraint / Rule | Description |
| :--- | :--- | :--- | :--- | :--- |
| Maximum Endurance | t_endurance_max | s | t_endurance_max = 5400.0 | Maximum airframe endurance (`90.0 min`) under nominal conditions (`PRM-PERF-002`) |
| Statutory Bingo Reserve Ratio | rho_bingo | ratio | rho_bingo >= 0.20 | Mandatory reserve fraction enforcing RTL before depletion (`PRM-PERF-003`) |
| Statutory Bingo Reserve Time | t_bingo | s | t_bingo >= 1080.0 | Protected energy flight duration (`0.20 * 5400.0`) reserved for RTL (`OA-04`) |
| Usable Tactical Mission Time | t_usable | s | t_usable <= 4320.0 | Maximum productive sortie time before Bingo RTL trigger (`72.0 min`) |
| EPS ESAD Rail Output | V_EPS_esad | V | V_EPS_esad = 14.0 | Regulated DC rail output from `ElectronicPowerSystemEps` to ESAD (`PRM-AV-010`) |
| ESAD Minimum Input Floor | V_ESAD_min | V | V_ESAD_min = 14.0 | Minimum specified `VDC_IN` (`GE_POW`) floor at `Artron ESAD` (`PRM-ESAD-001`) |
| Harness Voltage Drop | Delta V_harness | V | Delta V_harness >= 0.0 | Resistive drop along EPS-to-ESAD interconnect causing `GAP-01` brownout risk |
| ESAD Input Voltage Margin | Delta V_esad_margin | V | Delta V_esad_margin <= 0.0 | Net margin at `V_EPS_esad = 14.0` (`0.0 V` before drop, requiring `GAP-01` guard) |

#### Table 3.3: Operational Value Proposition Summary Across Capability Tiers

| Capability ID | Predecessor / Unmitigated Operational Limitation | Quantified Value Delivered by Proposed Capability | Traceable Verification Basis |
| :--- | :--- | :--- | :--- |
| `CAP-01` | Unverified pack state-of-charge (`GAP-05` `24 V` UI confusion) and unquantified endurance exhaustion risk | Enforces `49.0-50.0 V` pre-flight check, `200.0 A` overcurrent fuse, and `1080.0 s` (`0.20`) protected Bingo RTL reserve across `5400.0 s` max endurance | `TC_01_PreflightPowerAndRbfSequence`, `TC_02_BingoReserveAndEpsBrownoutMonitor` |
| `CAP-02` | Out-of-order `RBF #3` removal causing immediate ESAD fault (`GAP-06`) and undetected ESAD supply brownout (`GAP-01`) | Deterministic `RBF #2` before `RBF #3` bus gating, continuous ESC telemetry onto `CAN 1`, and active `14.0 V` brownout supervision + irreversible `Power Off ESAD` | `TC_01_PreflightPowerAndRbfSequence`, `TC_02_BingoReserveAndEpsBrownoutMonitor` |
| `CAP-03` | Single-bus actuator failures and unguarded dive overspeed (`> 55.0 m/s` gimbal saturation) | Dual-bus `CAN 1` / `CAN 2` fault isolation (`4x` tail + `4x` wing) plus software Simplex RTA (`0` external boxes) clamping `<= 55.0 m/s` engagement and `<= 80.0 m/s` VNE | `TC_03_SimplexRtaEnvelopeAndActuation` |
| `CAP-04` | Loss of navigation under GNSS denial and unmonitored ESAD bus timing drifts (`GAP-04`) | Seamless `RM3100`/`SKYE2` INS/DR fallback (`3.0/10.0 m/s` pitot gate) plus deterministic `100 Hz` (`10.0 ms` timeout) `RPI CM5` RS-485 ESAD supervision | `TC_04_GnssDeniedDrAndPaceLinkFailsafe`, `TC_06_EsadProtocolInterlockAndHvFireGate` |
| `CAP-05` | Unencrypted links, frozen gimbal video requiring hard landing, and high terminal dispersion | `4.4-5.0 GHz` `AES-256` FHSS (`60.0-90.0 km` RLOS), `40.0x` HD Day/Thermal EO/IR (`<= 0.5 m` CEP), and in-flight `Reboot Gimbal` over Ethernet | `TC_05_EoIrTargetTrackAndSpeedCapAbort` |
| `CAP-06` | Single-point electronic arming risk and unsafe hangfire approach (`GAP-07`, `GAP-SCRUB`) | `STANAG 4187` dual physical barriers (`SS1` + `SS2`), `< 50.0 V` PBIT, `DSC_IN1` `1 kHz` `2`-pulse hardware gate, `>= 5.0 s` self-destruct hold, and safe scrub safing | `TC_06_EsadProtocolInterlockAndHvFireGate`, `TC_08_EmergencyScrubHangfireAndC2Auth` |
| `CAP-07` | Prepared-runway dependency, umbilical snag hazards, and `< 15 kg` overspeed / `17 kg` underspeed margin (`GAP-03`) | `5.0 min` setup pneumatic rail (`13.0-14.0 bar`, `14.5 V` Makita UVLO, `0` wires to UAV) delivering `~23.0 m/s` exit (`<= 25.0 m/s` cap) and `Main Valve 4` bleed scrub | `TC_07_Pl40RailChargeLaunchAndZeroWire`, `TC_08_EmergencyScrubHangfireAndC2Auth` |
| `CAP-08` | Unauthenticated GCS control, premature UAV contact before rotator calibration, and manual target relay | Role auth (`>= 8` chars across `UCL-01`, `UCL-02`, `UCL-03`), ESD + `>= 10.0 m` separation, `0.5 deg` rotator calibration, `105.0 s` failsafe, and `5W / CFF` export | `TC_08_EmergencyScrubHangfireAndC2Auth` |

---

### 3.4 Engineering Trade-Off Analysis (`TRD-01` through `TRD-05`)

Five foundational architectural trade studies govern the `Avenger5V25IntegratedSystem` design baseline. Each study contrasts the selected SysML v2 architecture against the rejected alternative, tracing SWaP, safety (`MIL-STD-882E`, `SAE ARP4761`, `NATO STANAG 4187 Ed. 5`), fault containment, and open OEM gap mitigations directly to `.pipeline/schema.sysml` constraints and verification test cases.

#### 3.4.1 `TRD-01`: Mechanical Zero-Wire `PL-40` Launch Rail (`IF-MECH-001`) vs. Electrical Umbilical Interface

- **Decision Scope:** Launch interface topology between `Pl40PneumaticLauncher` (`CAP-07`) and the `17.0 kg` airframe (`ElectricPropulsionUnit`, `PowerMeterAndRbfSwitch`, `ArtronEsadAndSensorUnit`).
- **Selected Architecture (Option A -- Pure Mechanical Impulse Interface):** Zero electrical, power, or CAN conductors cross the `PL-40 <-> UAV` rail boundary (`electricalWireToUavCount == 0`, `CONN_23` / `OpTx-23`, `IF-MECH-001`). Energy transfer is strictly pneumatic-to-mechanical along the `5.0 m` (`4938.0 mm` CAD) `12.0 deg` rail (`13.0-14.0 bar`, `~23.0 m/s` exit velocity at `17.0 kg`), while UAV bus energization (`RBF #2`), pre-flight BIT, and `4.4-5.0 GHz` C2 supervision operate autonomously on internal `12S2P` battery and RF telemetry at `>= 10.0 m` ground radio separation. `SS1` launch acceleration is sensed purely inertially onboard (`CONN_24` / `OpTx-24`).
- **Rejected Alternative (Option B -- Hardwired Electrical / CAN Launch Umbilical):** Ground umbilical cable supplying external rail power, ground BIT telemetry, or discrete launch-arm signals to the airframe carriage interface.
- **Justification & Accepted Mitigations:** Eliminating the umbilical prevents dynamic cable snagging, shear-connector fouling, pin-arcing, and `MIL-STD-461G` ESD/EMI transient injection (`CS114`, `CS118`) along the `~23.0 m/s` catapult stroke, and enables safe `SAFE_SCRUB_ABORT` (`OA-17`, `GAP-SCRUB`) tank bleeding and red pin reinstallation without unplugging live power next to an energized airframe. Because `~23.0 m/s` exit at `17.0 kg` lies slightly below the `24.0-26.0 m/s` aerodynamic stall window (`GAP-03`) and no rail wire inhibits pusher spin-up, `OA-16` enforces pre-launch verification of `RBF #1` prop-fold/cover removal, `145.0-155.5 mm` carriage prop-safe upper zone clearance, `13.0-14.0 bar` gauge pressure, `<= 12.0 m/s` headwind, and live RF BIT before pulling the red safety pin and holding the dual firing switches for `>= 2.0 s` (`TC_07_Pl40RailChargeLaunchAndZeroWire`).

#### 3.4.2 `TRD-02`: Software-Hosted `ASTM F3269-17` Simplex RTA on `Cube orange+` vs. Standalone External RTA Hardware Box

- **Decision Scope:** Run-Time Assurance (`RtaEnvelopeMonitorState`) hosting and flight envelope protection (`CAP-03`) on `FlightControllerCubeOrangePlus`.
- **Selected Architecture (Option A -- Software-Hosted Simplex RTA Inside `Cube orange+`):** `ASTM F3269-17` §5.2 Simplex monitoring and recovery logic execute directly in software partitions on `Cube orange+` (`simplexRtaSoftwareHosted == true`, `standaloneRtaBoxCount == 0`), enforcing the `<= 55.0 m/s` engagement speed abort, `<= 80.0 m/s` structural `VNE` limit (`GAP-02`), `105.0 s` GCS loss RTL, `0.20` Bingo / `36.0 V` sag RTL, and ESAD bus-fault disarming (`OA-05`).
- **Rejected Alternative (Option B -- Standalone External RTA Hardware Box):** Independent physical monitor box inserted in series between `Cube orange+` and the `CAN 1` / `CAN 2` servo harnesses and `Power Meter`.
- **Justification & Accepted Mitigations:** Within a `17.0 kg` MTOW airframe carrying a `<= 5.0 kg` warhead (`4.98 +/- 0.02 kg` tested), `12S2P` battery, `970.0 cm` trunk, `RPI CM5004032`, `Trip6`/`Nighthawk2UZ`, `DTC` radio, and `Artron ESAD`, an external RTA box adds unbudgeted mass, volume, connector failure modes (`MIL-STD-1629A`), and additional regulated DC load onto an EPS already operating at `0.0 V` brownout margin on its `14.0 V` ESAD rail (`GAP-01`). Co-locating Simplex RTA on `Cube orange+` requires strict `RTCA DO-178C` §6.3 partitioning and closure of unprinted OEM control-loop WCET/RMA measurements (`GAP-WCET`) via `TC_03_SimplexRtaEnvelopeAndActuation` before operational release.

#### 3.4.3 `TRD-03`: Physical Bus Isolation of `CAN 1` (Star/Tap Power & Tail Fins) vs. `CAN 2` (Series Daisy-Chain Wings & Air-Data Sensors)

- **Decision Scope:** Onboard DroneCAN bus architecture (`canBusCount == 2`) connecting `FlightControllerCubeOrangePlus`, `PowerMeterAndRbfSwitch`, `ElectronicPowerSystemEps`, `DroneCanSurfaceActuation`, and `NavigationAndAirDataSuite` (`CAP-02`, `CAP-03`, `CAP-04`).
- **Selected Architecture (Option A -- Dual Physically Isolated Asymmetric DroneCAN Buses):** `CAN 1` operates as a multi-drop star/tap bus (`970.0 cm` trunk + `4x 120.0 cm` stubs) linking `Cube orange+` (`can1Master`) to `EPS`, `Power Meter` (carrying `IBEX160` ESC UART telemetry), and `4x HV6160-DroneCAN` tail ruddervator servos (`#1` through `#4`, mixed pitch/yaw skid-turn). `CAN 2` operates as a strictly series daisy-chain from `Cube orange+` (`can2Master`) through the `CAN/power splitter PCB` across `4x HV6160-DroneCAN` wing roll servos (`#5 -> #6 -> #7 -> #8`) to `2x mRo RM3100` magnetometers/barometers and `CUAV SKYE2` heated pitot (`CONN_12`, `CONN_13`).
- **Rejected Alternative (Option B -- Single Unified DroneCAN Bus):** All `8x` servos, power/EPS nodes, and air-data sensors multiplexed onto one shared CAN segment.
- **Justification & Accepted Mitigations:** Physical separation (`CanTopologyIsolationConstraint`, `CTL-04`, `SAE ARP4754A` §5.1) prevents any single bus short, open stub, or babbling servo from causing total loss of flight control and telemetry: a `CAN 2` wing/sensor fault leaves `CAN 1` pitch/yaw ruddervators (`#1` through `#4`), `EPS`, and `Power Meter` Bingo/ESC telemetry fully operational for RTL recovery, while a `CAN 1` fault preserves `CAN 2` active wing roll (`#5` through `#8`), dual `RM3100`, and `SKYE2` pitot. Because `CAN 2` uses a series daisy-chain where an upstream break disconnects downstream `RM3100`/`SKYE2` sensors, `Septentrio` RTK GNSS remains on an independent `Serial` link (`CONN_15`), `2x RM3100` provide dual sensor redundancy, and `OA-06` verifies full `CAN 2` sensor enumeration pre-flight (`TC_03`, `TC_04`).

#### 3.4.4 `TRD-04`: Dual-Barrier `STANAG 4187` ESAD Supervision on `RPI CM5004032` (`Ring 2 -> Ring 3`) vs. Direct Autopilot Coupling or Single-Barrier Arming

- **Decision Scope:** Ordnance safety architecture and protocol mediation across `FlightControllerCubeOrangePlus`, `CompanionComputeRpiCm5`, `ElectronicPowerSystemEps`, and `ArtronEsadAndSensorUnit` (`CAP-04`, `CAP-06`).
- **Selected Architecture (Option A -- Mediated `RPI CM5004032` OC Master Supervision + Dual `STANAG 4187` Barriers):** `RPI CM5004032` (`Ring 2`) isolates `Cube orange+` flight navigation and `SwarmC2` IP from `Artron ESAD` (`Ring 3`), enforcing `100 Hz` (`0.01 s`) half-duplex `115200 bps` `8N1` RS-485 `CRC-16 XModem` polling (`<= 5.0 ms` reply, `<= 10.0 ms` timeout per `GAP-04`) alongside out-of-band hardware `DSC_IN1` (`1000.0 Hz`, `2` pulses). High-voltage charging (`0-1800 V` on `J401`) requires sequential satisfaction of `RBF #2` power-before-pull `RBF #3` (`UMB < 0.5 Ohm @ 20.0 mA`, `GAP-06`), pre-flight PBIT `< 50.0 V`, physical barrier `SS1` (inertial launch acceleration, `CONN_24`), physical barrier `SS2` (`Safe Distance Exceed == 1`, `GAP-07`), HITL authorization (`DoD Directive 3000.09` §4.1.a), Stage 2 `DSC_IN1`, and `J102` Sensor Board ORed `IRQ_L` trigger (`OA-10`, `OA-11`).
- **Rejected Alternatives (Option B / C):** (B) Direct `Cube orange+` serial connection to ESAD without an isolated OC Master and hardware `DSC_IN1` pulse gate; (C) Software-only single-barrier arming omitting `SS1`/`SS2` or `RBF #3` ordering.
- **Justification & Accepted Mitigations:** Eliminates single-point failures across software, RS-485 bus corruption, and mechanical handling (`SAF-01`, `NATO STANAG 4187 Ed. 5` Chapter 2/3, `MIL-STD-331D` Group A drop tests), and isolates `100 Hz` ESAD watchdog polling from `Cube orange+` real-time flight control loops while preserving HITL abort (`>= 5.0 s` self-destruct hold + Slide-to-Confirm, `Disarm ESAD On GCS Timeout`, and irreversible `Power Off ESAD` via `EPS`). Accepted engineering gaps (`GAP-01` zero voltage margin between `14.0 V` EPS output and `14.0 V` ESAD `VDC_IN` minimum; `GAP-SEPDIST` unprinted numeric safe-separation meters/seconds/`g` thresholds) are explicitly mitigated via `EpsEsadZeroBrownoutMarginConstraint` monitoring (`TC_02`), fault-lockout testing (`TC_06`), and mandatory calibration sign-off before field arming.

#### 3.4.5 `TRD-05`: `12S2P` Li-Metal `BEI maximus20` Energy Architecture (`36.0-50.4 V`) & `0.20` Statutory Bingo Reserve (`1080.0 s`)

- **Decision Scope:** Primary energy storage voltage class, harness power loss across the `970.0 cm` trunk, pre-flight voltage gating, and statutory Bingo reserve policy (`CAP-01`, `CAP-02`).
- **Selected Architecture (Option A -- `12S2P` `36.0-50.4 V` Bus with `49.0-50.0 V` Pre-Flight Gate & `0.20` Bingo Reserve):** Standardizes on the `12S2P Li metal BEI maximus20` pack (`36.0-50.4 V` bus, `49.0-50.0 V` pre-flight check, `200.0 A` fuse) feeding `IBEX160` ESC and `EPS` over the `970.0 cm` fuselage trunk, combined with an active `0.20` (`1080.0 s`) Bingo reserve floor (`4320.0 s` usable mission endurance out of `5400.0 s`) and `36.0 V` sag RTL trigger (`OA-04`).
- **Rejected Alternative (Option B -- Legacy `24 V` Nominal Pack Model or Zero-Reserve Mission Sizing):** Retaining conflicting legacy `24 V` UI voltage expectations (`legacy24VUiRejected == true`, `GAP-05`) or permitting `100.0 percent` endurance depletion without an autonomous Bingo RTL floor.
- **Justification & Accepted Mitigations:** Operating at `36.0-50.4 V` instead of `24 V` nominal halves DC trunk current for identical propulsion and payload power, reducing resistive (`I^2 * R`) voltage drop across the `970.0 cm` harness and `200.0 A` fuse so `EPS` maintains stable regulation for the zero-margin `14.0 V` ESAD rail (`GAP-01`). Simultaneously, rejecting legacy `24 V` UI artifacts (`MainBatteryPreFlightVoltageConstraint`: `49.0-50.0 V`) prevents launching with depleted cells, and the `0.20` (`1080.0 s`) reserve enforces `JARUS SORA v2.5` operational volume containment (`MET-02`). Because OEM sheets omit `Wh`/`Ah` capacity and ESC thermal cutoffs (`GAP-ENV`), continuous `Power Meter` V/I monitoring (`OA-02`) dual-triggers RTL on either `0.20` remaining endurance or `<= 36.0 V` bus sag (`TC_01`, `TC_02`).

#### Table 3.4: Engineering Trade-Off Evaluation Matrix (`TRD-01` through `TRD-05`)

| Trade-Off ID | Selected Option (`Option A`) | Rejected Alternative (`Option B`) | Primary Engineering Justification | Accepted Risk & Residual Mitigation | Bound SysML AST Nodes |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `TRD-01` | Zero-wire mechanical `PL-40` rail (`IF-MECH-001`, `0` wires) | Hardwired UAV-to-rail electrical/CAN umbilical | Eliminates umbilical snag/shear, ESD/EMI coupling (`MIL-STD-461G`), and enables safe hangfire bleed (`OA-17`) at `>= 10.0 m` standoff | No wire prop-inhibit and `~23.0 m/s` exit near `24.0-26.0 m/s` stall (`GAP-03`); mitigated by `OA-16` Go/No-Go, `RBF #1` check, `13.0-14.0 bar`, `<= 12.0 m/s` headwind, and `TC_07` | `CAP-07`, `Pl40PneumaticLauncher`, `Pl40MassAndExitVelocityConstraint`, `TC_07_Pl40RailChargeLaunchAndZeroWire` |
| `TRD-02` | Software Simplex RTA on `Cube orange+` (`0` external boxes) | Standalone external RTA hardware box | Saves MTOW inside `17.0 kg` limit, avoids added EPS power drain (`GAP-01`), and removes inline actuator FMECA single points | Shared processor requires `DO-178C` §6.3 partitioning and unprinted WCET measurement (`GAP-WCET`); mitigated by `TC_03` dive/overspeed verification | `CAP-03`, `FlightControllerCubeOrangePlus`, `SimplexRtaSoftwareHostingConstraint`, `TC_03_SimplexRtaEnvelopeAndActuation` |
| `TRD-03` | Physical `CAN 1` (star/tap tail + power) vs `CAN 2` (series wing + air-data) | Single unified DroneCAN bus | Prevents single bus fault from killing both pitch/yaw and roll (`SAE ARP4754A` §5.1); isolates ESC EMI from `RM3100` | Upstream `CAN 2` daisy-chain break drops wing roll + `RM3100`/`SKYE2`; mitigated by `CAN 1` pitch/yaw RTL, `Serial` GNSS (`CONN_15`), and `OA-06` BIT | `CAP-03`, `CAP-04`, `DroneCanSurfaceActuation`, `CanTopologyIsolationConstraint`, `TC_03_SimplexRtaEnvelopeAndActuation` |
| `TRD-04` | `RPI CM5` `100 Hz` RS-485 + `DSC_IN1` + `STANAG 4187` `SS1`/`SS2` | Direct `Cube` coupling or software-only single barrier | Zero pre-launch SPF (`SAF-01`), isolates `100 Hz` RS-485 watchdog (`GAP-04`) from `Cube`, enforces `DoD Directive 3000.09` HITL | `0.0 V` margin on `14.0 V` ESAD rail (`GAP-01`) and unprinted `GAP-SEPDIST` constants; mitigated by `TC_02` brownout monitor, `TC_06` lockout, and field calibration | `CAP-04`, `CAP-06`, `CompanionComputeRpiCm5`, `ArtronEsadAndSensorUnit`, `EsadSafeDistanceExceedConstraint`, `TC_06_EsadProtocolInterlockAndHvFireGate` |
| `TRD-05` | `12S2P` `36.0-50.4 V` (`49.0-50.0 V` check) + `0.20` Bingo (`1080.0 s`) | Legacy `24 V` nominal assumption or zero-reserve sizing | Halves `970.0 cm` trunk current to protect `14.0 V` EPS rail (`GAP-01`); rejects depleted packs (`GAP-05`); guarantees `SORA` RTL | Unprinted `Wh`/`Ah` capacity and ESC cutoffs (`GAP-ENV`); mitigated by `CAN 1` `Power Meter` telemetry (`OA-02`), dual Bingo/sag triggers, and `TC_01`/`TC_02` | `CAP-01`, `CAP-02`, `MainBatteryAndFuseUnit`, `MainBatteryPreFlightVoltageConstraint`, `BingoEnergyReserveConstraint`, `TC_01_PreflightPowerAndRbfSequence` |

#### Table 3.5: Quantitative Trade-Off Thresholds & Verification Targets

| Trade-Off ID | Metric Description | Qualifier | Value | Units | Source / Verification Gate |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `TRD-01` | Electrical / CAN conductors across `PL-40` to UAV rail (`IF-MECH-001`) | Exact | 0 | count | `.pipeline/schema.sysml` (`electricalWireToUavCount`) |
| `TRD-01` | Avenger 5 interpolated rail exit velocity (`17.0 kg` vs `25.0 m/s` max) | Nominal | 23.0 | m/s | `PRM-PL40-003` (`GAP-03`), `TC_07` |
| `TRD-02` | Standalone external RTA hardware box count (`Cube orange+` software-hosted) | Exact | 0 | count | `.pipeline/schema.sysml` (`standaloneRtaBoxCount`) |
| `TRD-02` | Simplex RTA terminal engagement speed clamp (`Abort Engaging`) | Max | 55.0 | m/s | `PRM-PERF-010` (`GAP-02`), `TC_03` |
| `TRD-03` | Physically isolated DroneCAN controller buses (`CAN 1` vs `CAN 2`) | Exact | 2 | count | `.pipeline/schema.sysml` (`canBusCount`), `CTL-04` |
| `TRD-03` | `CAN 1` fuselage power and actuation trunk length | Nominal | 970.0 | cm | `PRM-AV-012`, `Avenger5_V2.5_block_diagram_rev5.pdf#p1` |
| `TRD-04` | `RPI CM5` to `Artron ESAD` RS-485 supervisory poll frequency | Exact | 100.0 | Hz | `PRM-ESAD-017` (`GAP-04`), `TC_06` |
| `TRD-04` | Net EPS-to-ESAD voltage margin (`14.0 V` rail vs `14.0 V` `VDC_IN` min) | Max | 0.0 | V | `PRM-AV-010`, `PRM-ESAD-001` (`GAP-01`), `TC_02` |
| `TRD-05` | Pre-flight `12S2P` battery voltage acceptance floor (`GAP-05`) | Min | 49.0 | V | `PRM-AV-003`, `TC_01` |
| `TRD-05` | Protected Bingo reserve flight duration (`0.20 * 5400.0 s`) | Min | 1080.0 | s | `PRM-PERF-002`, `PRM-PERF-003`, `TC_02` |

---

### 3.5 Traceability Closure & Open OEM Gap Governance

All eight declared AST capabilities (`CAP-01` through `CAP-08`) map cleanly onto the `15` declared `part def` operational nodes, `19` operational activities (`OA-01` through `OA-19`), `24` operational exchanges (`OpTx-01` through `OpTx-24` / `CONN_01` through `CONN_24`), `8` operational scenarios (`SCN-01` through `SCN-08`), `18` AST `constraint def` checks, `5` AST `state def` machines, and `8` verification test cases (`TC_01` through `TC_08`) without speculative hardware additions. Open engineering gaps requiring empirical bench characterization (`GAP-WCET` control-loop timing, `GAP-REL` component failure rates, `GAP-SEPDIST` safe-separation distance/timer/`g` thresholds and fastener torques, `GAP-ENV` `Wh`/`Ah` capacity and tank volume/IP limits, and `GAP-SCRUB` hangfire hold intervals) remain explicitly isolated as calibration-gated parameters tracked across downstream verification and Level 2 SyRS requirements rather than masked by assumed constants.

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
/// OperationalAllocation: [MET-01]
/// OperationalAllocation: [MET-02]
/// OperationalAllocation: [MET-03]
/// OperationalAllocation: [MET-04]
