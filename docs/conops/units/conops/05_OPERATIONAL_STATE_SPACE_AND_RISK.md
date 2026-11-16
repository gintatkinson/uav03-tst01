## 5. Operational State Space, Boundary Containment & Risk Assessment

- **Baseline Date:** `2026-11-16`
- **System Baseline:** `Avenger5V25UasSystem` (`Avenger 5 V2.5 UAS` / `ASTK A5 V2.5` + `ELI Military Simulations PL-40 Rev 2.6` + `Artron ESAD AB00-0054-01AA-0005` + `SwarmC2`)
- **Normative Governance:** `JARUS SORA v2.5` (Annex B and Annex C, `MET-02`), `MIL-STD-882E` (Tasks 202, 205, and 206, `SAF-02` and `MET-04`), `MIL-STD-1629A` (Methods 101 and 102, `SAF-03`), `SAE ARP4754A / ARP4761` (`SAF-02`), `ASTM F3269-17` (§5.2, `CTL-01`), `RTCA DO-362A` (§2.2 and §3.2, `CTL-02`), `NATO STANAG 4187 Ed. 5` (`SAF-01`), and `ISO/IEC/IEEE 29148:2018` (`OBL-01`).
- **Architectural Truth Invariants:** Software-hosted `ASTM F3269-17` Simplex Run-Time Assurance (`RTA`) inside `FlightControllerCubeOrangePlus` (`standaloneRtaBoxCount == 0`); strictly mechanical zero-wire launch rail interface across `Pl40PneumaticLauncher` and `ElectricPropulsionUnit` (`IF-MECH-001`, `CONN_23`, `electricalWireToUavCount == 0`); `0` production recovery parachutes (`rndRecoveryOptionInstalled == false`, with non-production `2x 50.0 V` EPS igniter rails disabled per `REQ_SC_03`); and `12S2P` `36.0-50.4 V` primary DC bus (`49.0-50.0 V` pre-flight check per `REQ_SAF_05`).

### 5.1 4D Operational State Space & Flight Envelope Formulation

The `Avenger5V25UasSystem` operational domain spans a bounded four-dimensional (4D) spatiotemporal volume $\Omega_{4\mathrm{D}}$ in cylindrical mission coordinates $(r, \psi, h, t)$ centered on `GroundRfStationAndAntennaTracker`, coupled with an inner-loop kinematic and energy state envelope governed by `FlightControllerCubeOrangePlus` (`RtaEnvelopeMonitorState`, `UavFlightLifecycleState`), `SwarmC2OperatorConsole`, and `MainBatteryAndFuseUnit` (`.pipeline/schema.sysml`, `schema/extracted/parametric_limits.md`).

Per `GAP-02` (`REQ_SAF_02`), conflicting V1 User Manual (`26.0-38.0 m/s` airspeed, `55.0 m/s` dive, `30.0 m/s` cruise, `60.0/180.0 km` RLOS) and V2.5 Spec Sheet (`24.0-42.0 m/s` airspeed, `80.0 m/s` structural `V_NE`, `31.0 m/s` cruise, `60.0/90.0 km` RLOS) parameters are harmonized into a conservative inner control envelope: `24.0-42.0 m/s` horizontal airspeed (`26.0 m/s` conservative climb transition floor), `55.0 m/s` target engagement speed cap (`Abort Engaging` trigger preventing `Nighthawk2UZ` gimbal saturation), `80.0 m/s` structural dive limit `V_NE`, and `60.0/90.0 km` Radio Line-of-Sight (`RLOS`) range (`PRM-PERF-004` through `PRM-PERF-011`, `PRM-RF-006`, `PRM-RF-007`). Mission waypoints are constrained via `SwarmC2AuthAndMissionBoundsConstraint` to `50.0-3000.0 m` altitude (`250.0 m` slider graduation) inside the `5000.0 m` service ceiling (`PRM-PERF-015`, `PRM-GCS-004` through `PRM-GCS-006`), with minimum CW loiter radius `300.0 m` (`PRM-GCS-007`) and statutory `0.20` Bingo energy reserve (`1080.0 s` floor of `5400.0 s` maximum endurance, `PRM-PERF-001` through `PRM-PERF-003`).

$$
\begin{aligned}
\Omega_{4\mathrm{D}} &= \left\{ (r, \psi, h, t) \in \mathbb{R}^{4} \mid r_{\mathrm{loiter,min}} \le r \le R_{\mathrm{RLOS}}, \; \psi \in [0, 2\pi), \; h_{\mathrm{mission,min}} \le h \le h_{\mathrm{mission,max}} \le h_{\mathrm{ceiling}}, \; t \in [t_{0}, t_{0} + T_{\mathrm{usable}}] \right\} \\
V_{4\mathrm{D}} &= \int_{t_{0}}^{t_{0} + T_{\mathrm{usable}}} \int_{h_{\mathrm{mission,min}}}^{h_{\mathrm{mission,max}}} \int_{0}^{2\pi} \int_{r_{\mathrm{loiter,min}}}^{R_{\mathrm{RLOS}}} r \, \mathrm{d}r \, \mathrm{d}\psi \, \mathrm{d}h \, \mathrm{d}t \\
&= \pi \left(R_{\mathrm{RLOS}}^{2} - r_{\mathrm{loiter,min}}^{2}\right) \left(h_{\mathrm{mission,max}} - h_{\mathrm{mission,min}}\right) T_{\mathrm{usable}} \\
T_{\mathrm{bingo}} &= \rho_{\mathrm{bingo}} \, T_{\mathrm{endurance}}, \qquad T_{\mathrm{usable}} = \left(1 - \rho_{\mathrm{bingo}}\right) T_{\mathrm{endurance}} \\
V_{\mathrm{stall,V25}} &\le V_{\mathrm{min,V1}} \le V_{\mathrm{cruise,V25}} \le V_{\mathrm{horiz,max}} < V_{\mathrm{engage,cap}} < V_{\mathrm{NE}} \\
V_{\mathrm{air}}(t) &\in \left[V_{\mathrm{stall,V25}}, \, V_{\mathrm{engage,cap}}\right], \qquad \theta_{\mathrm{dive}}(t) \le \theta_{\mathrm{dive,max}}, \qquad v_{\mathrm{wind,gnd}} \le v_{\mathrm{wind,gnd,max}}, \qquad v_{\mathrm{wind,crs}} \le v_{\mathrm{wind,crs,max}}
\end{aligned}
$$

#### Parameter Definitions & Engineering Units: 4D Operational State Space

| Parameter | Symbol | Value | Units | Constraint / Rule | Grounded SSOT Citation |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Mission Waypoint Altitude Floor | h_mission_min | 50.0 | m | h >= 50.0 (SwarmC2 slider min) | `PRM-GCS-004`, `SwarmC2AuthAndMissionBoundsConstraint` |
| Mission Waypoint Altitude Ceiling | h_mission_max | 3000.0 | m | h <= 3000.0 (SwarmC2 slider max) | `PRM-GCS-005`, `SwarmC2AuthAndMissionBoundsConstraint` |
| SwarmC2 Altitude Slider Step | delta_h_slider | 250.0 | m | Discrete mission altitude step | `PRM-GCS-006`, `SwarmC2OperatorConsole` |
| Airframe Service Ceiling | h_ceiling | 5000.0 | m | h_mission_max <= 5000.0 | `PRM-PERF-015`, `ElectricPropulsionUnit` |
| Vertical Simplex RTA Buffer | delta_h_buffer | 2000.0 | m | h_ceiling - h_mission_max | Derived from `PRM-PERF-015` and `PRM-GCS-005` |
| Minimum CW Loiter Radius | r_loiter_min | 300.0 | m | r_loiter >= 300.0 | `PRM-GCS-007`, `SwarmC2AuthAndMissionBoundsConstraint` |
| Ground Radio / Crew Separation | d_sep_radio | 10.0 | m | d_sep >= 10.0 during prep | `PRM-GCS-001`, `GroundCrewSeparationAndEsdConstraint` |
| RLOS Range Baseline (V2.5) | R_RLOS_base | 60.0 | km | R_containment <= 60.0 (nominal) | `PRM-RF-006`, `REQ_SAF_02` (`GAP-02`) |
| RLOS Range Extended (V2.5) | R_RLOS_ext | 90.0 | km | R_containment <= 90.0 (extended) | `PRM-RF-007`, `REQ_SAF_02` (`GAP-02`) |
| Maximum Endurance | T_endurance | 5400.0 | s | 90.0 min total endurance ceiling | `PRM-PERF-001`, `PRM-PERF-002`, `MainBatteryAndFuseUnit` |
| Statutory Bingo Reserve Ratio | rho_bingo | 0.20 | ratio | reserveRatio >= 0.20 | `PRM-PERF-003`, `BingoEnergyReserveConstraint` |
| Statutory Bingo Reserve Floor | T_bingo | 1080.0 | s | rho_bingo * T_endurance = 1080.0 | `MainBatteryAndFuseUnit`, `REQ_UCA_02` |
| Usable On-Station Mission Time | T_usable | 4320.0 | s | T_endurance - T_bingo = 4320.0 | Derived from `PRM-PERF-002` and `PRM-PERF-003` |
| Stall / Minimum Airspeed (V2.5) | V_stall_V25 | 24.0 | m/s | V_air >= 24.0 (V2.5 spec) | `PRM-PERF-004`, `FlightEnvelopeSpeedConstraint` |
| Conservative Min Climb Speed (V1) | V_min_V1 | 26.0 | m/s | Climb transition above 26.0 | `PRM-PERF-005`, `UavFlightLifecycleState` |
| Nominal Cruise Airspeed (V2.5) | V_cruise_V25 | 31.0 | m/s | Nominal V2.5 cruise speed | `PRM-PERF-007` (V1 nominal `30.0 m/s` `PRM-PERF-006`) |
| Max Horizontal Speed (V2.5) | V_horiz_max | 42.0 | m/s | Max horizontal flight (V1 `38.0`) | `PRM-PERF-009` (`PRM-PERF-008`, `GAP-02`) |
| Target Engagement Speed Cap | V_engage_cap | 55.0 | m/s | V_air <= 55.0 in dive (RTA abort) | `PRM-PERF-010`, `EngagementSpeedAndTrackHoldConstraint` |
| Structural Dive Limit (V_NE) | V_NE | 80.0 | m/s | V_air <= 80.0 hard airframe limit | `PRM-PERF-011`, `FlightEnvelopeSpeedConstraint` |
| PL-40 Interpolated Launch Exit | V_exit_nom | 23.0 | m/s | 22.7-23.5 m/s at 17.0 kg (`GAP-03`) | `PRM-PL40-003`, `PRM-PL40-004`, `PRM-PL40-005` |
| PL-40 Max Rated Exit Velocity | V_exit_max | 25.0 | m/s | Exit velocity <= 25.0 | `PRM-PL40-002`, `Pl40MassAndExitVelocityConstraint` |
| Max Dive Angle | theta_dive_max | 22.0 | deg | Dive pitch angle <= 22.0 | `PRM-PERF-012`, `ElectricPropulsionUnit` |
| Shallow Engagement Approach Angle | theta_shallow | 15.0 | deg | Nominal shallow dive / target elev | `PRM-PERF-013`, `PRM-PERF-014` |
| Max Ground / Launch Wind | v_wind_gnd_max | 12.0 | m/s | Launch gate wind <= 12.0 | `PRM-PERF-016`, `Pl40MassAndExitVelocityConstraint` |
| Max Cruise Wind Tolerance | v_wind_crs_max | 28.0 | m/s | Cruise wind <= 28.0 | `PRM-PERF-017`, `ElectricPropulsionUnit` |
| Operating Ambient Temp Min | Temp_min | 253.15 | Dimensionless | Ambient temperature >= 253.15 (Normalized Kelvin scalar T / 1.0 K; OEM: -20.0 degC) | `PRM-PERF-018`, `PRM-PL40-038` |
| Operating Ambient Temp Max | Temp_max | 323.15 | Dimensionless | Ambient temperature <= 323.15 (Normalized Kelvin scalar T / 1.0 K; OEM: 50.0 degC) | `PRM-PERF-019`, `PRM-PL40-039` |
| Maximum Takeoff Weight (MTOW) | m_MTOW | 17.0 | kg | Airframe MTOW (PL-40 cap 30.0) | `PRM-AF-008`, `PRM-PL40-001` |
| Maximum Warhead Payload Mass | m_warhead_max | 5.0 | kg | 4.98 +/- 0.02 kg tested holder | `PRM-AF-009`, `PRM-AF-010`, `WarheadMassAndPbitHvSafetyConstraint` |
| Production Recovery Parachutes | N_parachute | 0 | count | Production parachute excluded | `ProductionNoParachuteConstraint`, `REQ_SC_03` |

- **4D Spatiotemporal Manifold Interpretation:** The symbol $\Omega_{4\mathrm{D}}$ denotes the admissible cylindrical airspace and time manifold with active radial span `r` (`300.0 m` minimum loiter orbit to `60.0/90.0 km` RLOS), azimuth `psi` across `0` to `2*pi` radians, mission waypoint altitude `h` (`50.0` to `3000.0 m`, vertical span `2950.0 m` inside the `5000.0 m` ceiling), and usable mission duration `T_usable = 4320.0 s` (`72.0 min`) preserving the `1080.0 s` (`18.0 min`) statutory Bingo reserve (`rho_bingo = 0.20`). The resulting 4D operational hypervolume `V_4D` (in `m^3 * s` before scaling) provides a strict geometric upper bound that is further partitioned into operational Flight Geography and Contingency Volumes under `JARUS SORA v2.5` Annex C.
- **Launch-to-Cruise Kinematic Gap (`GAP-03`):** Because `PL-40` interpolated carriage exit velocity (`23.0 m/s`, range `22.7-23.5 m/s` at `17.0 kg` MTOW and `13.0-14.0 bar`) lies below the `24.0-26.0 m/s` stall floor without headwind or immediate pusher climb thrust, `REQ_SAF_03` mandates an explicit pre-launch `Go/No-Go` gate verifying `AXI 5345/16` / `IBEX160` propulsion readiness, `13.0-14.0 bar` tank pressure, `<= 12.0 m/s` ground headwind margin, and `<= 25.0 m/s` rail exit limit before dual-switch launch release.

### 5.2 JARUS SORA v2.5 Annex B/C Boundary Containment & Ground Risk Buffer

Under `JARUS SORA v2.5` Annex B (Ground Risk Buffer and unpowered trajectory containment) and Annex C (Operational Volume partitioning and Air Risk containment, `MET-02`), the operational airspace is decomposed into three concentric containment shells around any active mission corridor: (1) the **Flight Geography** (`R_FG`), containing nominal `30.0-31.0 m/s` cruise and `>= 300.0 m` loiter operations; (2) the **Contingency Volume** (`Delta R_CV`), accommodating `RtaEnvelopeMonitorState` recovery pull-ups (`AirspeedDiveCapClamped` above `55.0 m/s`), `PACE` C2 link degradation (`PaceC2LinkState`), and `GPS Failsafe` / `Disable GNSS` inertial dead-reckoning drift; and (3) the **Ground Risk Buffer** (`R_GRB`, Annex B), bounding unpowered ground-impact excursion under `0` recovery parachutes (`N_parachute = 0`).

Because production `Avenger V2.5` carries `m_MTOW = 17.0 kg` (including up to `5.0 kg` warhead holder mass) with zero recovery parachutes (`ProductionNoParachuteConstraint`) and attains terminal kinetic energy between `4896.0 J` (at `24.0 m/s` stall) and `54400.0 J` (at `80.0 m/s` `V_NE`), physical containment relies exclusively on closed-loop trajectory bounding and deterministic `Artron ESAD` safing rather than parachute deceleration. To prevent boundary excursion (`REQ_L_02`, `REQ_L_04`), the declared operational containment boundary `R_containment` MUST satisfy the Annex B/C containment margin inequality `R_containment >= R_min`, while remaining strictly inside the active `4.4-5.0 GHz` `AES-256` FHSS `RLOS` datalink envelope (`R_RLOS = 60.0 km` baseline or `90.0 km` extended).

$$
\begin{aligned}
R_{\mathrm{OV}} &= R_{\mathrm{FG}} + \Delta R_{\mathrm{CV}} \\
t_{\mathrm{fall}} &= \sqrt{\frac{2 \, h_{\mathrm{mission,max}}}{g_{\mathrm{accel}}}} \\
d_{\mathrm{ballistic}} &= \frac{h_{\mathrm{mission,max}}}{\tan(\theta_{\mathrm{dive,max}})} \\
d_{\mathrm{wind}} &= v_{\mathrm{wind,crs,max}} \, t_{\mathrm{fall}} \\
d_{\mathrm{glide,max}} &= \max\!\left(d_{\mathrm{ballistic}}, \, \gamma_{\mathrm{glide}} \, h_{\mathrm{mission,max}}\right) + d_{\mathrm{wind}} \\
R_{\mathrm{GRB}} &\ge d_{\mathrm{glide,max}} + V_{\mathrm{horiz,max}} \, \tau_{\mathrm{react}} + \Delta r_{\mathrm{nav}} \\
R_{\mathrm{min}} &= R_{\mathrm{OV}} + R_{\mathrm{GRB}} \\
R_{\mathrm{containment}} &\ge R_{\mathrm{min}}, \qquad R_{\mathrm{containment}} \le R_{\mathrm{RLOS}} \\
E_{\mathrm{impact}} &= \frac{1}{2} \, m_{\mathrm{MTOW}} \, v_{\mathrm{terminal}}^{2}, \qquad N_{\mathrm{parachute}} = 0
\end{aligned}
$$

#### Parameter Definitions & Engineering Units: Boundary Containment & Ground Risk Buffer

| Parameter | Symbol | Value | Units | Constraint / Rule | Grounded SSOT Citation |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Max Mission Containment Altitude | h_mission_max | 3000.0 | m | Upper mission bound (ceiling 5000.0) | `PRM-GCS-005`, `PRM-PERF-015` |
| Standard Gravitational Acceleration | g_accel | 9.80665 | m/s^2 | SI standard gravity (9.80665 N/kg equivalent) | `conops_specification_schema.json` (`airspace_sora`) |
| Worst-Case Dive Impact Angle | theta_dive_max | 22.0 | deg | Max aerodynamic dive angle | `PRM-PERF-012` (shallow `15.0` `PRM-PERF-013`) |
| Max Cruise Wind Drift Speed | v_wind_crs_max | 28.0 | m/s | Worst-case wind drift speed | `PRM-PERF-017` (ground `12.0` `PRM-PERF-016`) |
| Max Horizontal Containment Speed | V_horiz_max | 42.0 | m/s | V2.5 max horizontal reaction speed | `PRM-PERF-009`, `GAP-02` |
| Maximum Terminal Engagement Cap | V_engage_cap | 55.0 | m/s | Simplex RTA dive clamp limit | `PRM-PERF-010`, `REQ_SC_05` |
| Structural Dive Limit (V_NE) | V_NE | 80.0 | m/s | Structural airframe velocity limit | `PRM-PERF-011`, `REQ_SC_05` |
| ESAD RS-485 Watchdog Timeout | tau_esad_wd | 0.01 | s | 10.0 ms max incomplete packet timeout | `PRM-ESAD-019` (`100.0 Hz`, `PRM-ESAD-017`) |
| ESAD Self-Destruct / Abort Hold | tau_sd_hold | 5.0 | s | Minimum HITL abort hold + Slide-to-Confirm | `PRM-GCS-010`, `REQ_SC_16` |
| GCS Lost-Link Failsafe Baseline | tau_gcs_fs | 105.0 | s | Autonomous RTL + ESAD disarm timeout | `PRM-GCS-008`, `PaceC2LinkState` |
| Baseline RLOS Containment Ceiling | R_RLOS_base_m | 60000.0 | m | 60.0 km nominal C2 link ceiling | `PRM-RF-006`, `REQ_SAF_02` |
| Extended RLOS Containment Ceiling | R_RLOS_ext_m | 90000.0 | m | 90.0 km extended V2.5 C2 ceiling | `PRM-RF-007`, `REQ_SAF_02` |
| Minimum Loiter Geography Radius | r_loiter_min | 300.0 | m | R_FG >= 300.0 in loiter orbit | `PRM-GCS-007`, `SwarmC2AuthAndMissionBoundsConstraint` |
| Maximum Takeoff Mass | m_MTOW | 17.0 | kg | Airframe MTOW for kinetic energy | `PRM-AF-008`, `ElectricPropulsionUnit` |
| Production Parachute Count | N_parachute | 0 | count | Unpowered descent without parachute | `ProductionNoParachuteConstraint`, `REQ_SC_03` |
| Kinetic Energy at Stall (24 m/s) | E_impact_stall | 4896.0 | J | 0.5 * 17.0 * 24.0 * 24.0 | Derived from `PRM-AF-008`, `PRM-PERF-004` |
| Kinetic Energy at Cruise (31 m/s) | E_impact_cruise | 8168.5 | J | 0.5 * 17.0 * 31.0 * 31.0 | Derived from `PRM-AF-008`, `PRM-PERF-007` |
| Kinetic Energy at Dive Cap (55 m/s) | E_impact_cap | 25712.5 | J | 0.5 * 17.0 * 55.0 * 55.0 | Derived from `PRM-AF-008`, `PRM-PERF-010` |
| Kinetic Energy at V_NE (80 m/s) | E_impact_VNE | 54400.0 | J | 0.5 * 17.0 * 80.0 * 80.0 | Derived from `PRM-AF-008`, `PRM-PERF-011` |
| Terminal Guidance CEP Ceiling | cep_max | 0.5 | m | Stationary target accuracy (50.0 cm) | `PRM-PERF-020`, `PRM-PERF-021` |

- **Runtime Containment & Unprinted Calibration Bindings (`GAP-ENV`, `GAP-SEPDIST`, `GAP-WCET`):**
  - `R_FG` (Flight Geography radius, `m`, bounded below by `r_loiter_min = 300.0 m`) and `Delta R_CV` (Contingency Volume lateral buffer, `m`) sum to the Operational Volume `R_OV = R_FG + Delta R_CV`, configured per sortie inside `SwarmC2` geofence limits.
  - `t_fall` (`s`), `d_ballistic` (`m`), `d_wind` (`m`), `d_glide_max` (`m`), and `R_GRB` (`m`) compute the `JARUS SORA v2.5` Annex B Ground Risk Buffer. Because OEM documentation does not publish an empirical unpowered glide ratio `gamma_glide` (`L/D`), GNSS-denied dead-reckoning drift rate `Delta r_nav` (`m` over `mRo RM3100` + `CUAV SKYE2` pitot fallback), or standoff distance limits (`GAP-ENV`, `GAP-SEPDIST`), `REQ_SAF_10` and `REQ_SAF_11` mandate explicit bench and flight-test calibration sign-off of `gamma_glide`, `Delta r_nav`, and `R_GRB` prior to operational `R_containment` declaration (`CONOPS_CONFIGURED`).
  - `tau_react` (`s`) aggregates multi-hop supervisory reaction latency across `Cube orange+` (`FlightControllerCubeOrangePlus` software Simplex RTA), `RPI CM5004032` (`100.0 Hz` / `10.0 ms` RS-485 ESAD cycle, `GAP-04`), and `CAN 1` / `CAN 2` actuator response; `GAP-WCET` (`REQ_SAF_08`) tracks EKF2, `CAN 1/2`, and `Trip6` WCET profiling around the grounded `0.01 s` ESAD heartbeat.
  - **Software Simplex RTA Boundary Enforcement:** Whenever `V_air(t) > 55.0 m/s` in `TargetTrackAndDive`, `FlightControllerCubeOrangePlus` transitions `RtaEnvelopeMonitorState` to `AirspeedDiveCapClamped`, overrides `Trip6` terminal cues, commands `Abort Engaging` climb to `Takeoff altitude`, and prevents exceedance of `V_NE = 80.0 m/s` (`REQ_SC_05`, `TC_03`). Simultaneously, `GAP-01` (`14.0 V` EPS output with `0.0 V` brownout margin above `14.0 V` ESAD `VDC_IN` minimum), `Bingo <= 0.20` (`1080.0 s`), or `>= 105.0 s` C2 link loss triggers `EmergencyAbortOrRtb` (`RTL`) and `Disarm ESAD On GCS Timeout` / irreversible `Power Off ESAD` (`REQ_SC_02`, `REQ_SC_12`, `REQ_SAF_01`), bounding both airframe kinetic risk and live ordnance exposure inside `R_containment`.

### 5.3 Integrated STPA & FMECA Risk Assessment Summary

Risk across the `Avenger5V25UasSystem` 4D operational envelope is governed jointly by top-down System-Theoretic Process Analysis (`STPA`, `MIL-STD-882E` Tasks 202/205/206, `SAE ARP4754A / ARP4761`, `SAF-02`) documented in `docs/safety/STPA_MATRIX.md` and bottom-up Component FMECA (`MIL-STD-1629A` Methods 101/102, `SAF-03`) documented in `docs/research/FAILURE_MODE_REGISTRY.md`.

#### 5.3.1 System-Level Losses (`REQ_L_01`, `REQ_L_02`, `REQ_L_03`, `REQ_L_04`) & Root Composition Loss (`L-1`)

Root composition loss `L-1` ("Loss of safe function of `Avenger5V25IntegratedSystem`") decomposes into four normative STPA system losses (`STPA_MATRIX.md` §1):

| Requirement ID | Loss Description | Severity | Triggered By Hazards | `RESEARCH_INVENTORY.md` Anchor |
| :--- | :--- | :--- | :--- | :--- |
| `REQ_L_01` | Loss L1: Human fatality or severe crew injury from unintended warhead detonation or unrestrained PL-40 launch discharge. | Catastrophic | `REQ_H_01`, `REQ_H_04`, `REQ_H_06` | `SAF-01`, `SAF-02`, `MET-04`, `EXT-01`, `EXT-02` |
| `REQ_L_02` | Loss L2: Uncontrolled airframe crash or hull destruction outside authorized engagement corridor. | Catastrophic | `REQ_H_01`, `REQ_H_02`, `REQ_H_03`, `REQ_H_06` | `SAF-02`, `SAF-03`, `MET-01`, `MET-02`, `CTL-01`, `CTL-04` |
| `REQ_L_03` | Loss L3: Unrecoverable loss of navigation or C2 mission control resulting in flyaway or inability to verify safe abort. | Hazardous | `REQ_H_02`, `REQ_H_03`, `REQ_H_05` | `OBL-04`, `SAF-02`, `CTL-02`, `CTL-03` |
| `REQ_L_04` | Loss L4: Unintended warhead detonation during ground handling/launch or collateral impact outside authorized target. | Catastrophic | `REQ_H_04`, `REQ_H_05` | `SAF-01`, `SAF-02`, `MET-03`, `CTL-03` |

#### 5.3.2 System-Level Hazards (`REQ_H_01` through `REQ_H_06`) & Boundary Containment Controls

Six normative system-level hazards (`REQ_H_01`, `REQ_H_02`, `REQ_H_03`, `REQ_H_04`, `REQ_H_05`, `REQ_H_06`), expanded across all `19` AST action-bound hazards (`H-1` through `H-19` in `STPA_MATRIX.md` §2.2), define the hazard envelope bounded by `REQ_SC_01` through `REQ_SC_16`, `REQ_SAF_01` through `REQ_SAF_12`, and the `5` Stateflow safety monitors (`UavFlightLifecycleState`, `RtaEnvelopeMonitorState`, `EsadSafeArmState`, `PaceC2LinkState`, `Pl40LauncherState`):

| Hazard ID | Hazard Description | Severity | Linked Losses | Governing Gaps & SysML Constraints | Primary Safety Constraints & Statechart Containment |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `REQ_H_01` | Hazard H1: Premature propulsion energization, reversed RBF sequencing, or insufficient launch airspeed (`< 24.0-26.0 m/s`) during handling or launch. | Catastrophic | `REQ_L_01`, `REQ_L_02` | `GAP-03`, `GAP-05`, `GAP-06`, `MainBatteryPreFlightVoltageConstraint`, `ProductionNoParachuteConstraint` | `REQ_SC_01`, `REQ_SC_03`, `REQ_SAF_03`, `REQ_SAF_05`; `UavFlightLifecycleState::PreFlightCheck` (`49.0-50.0 V`, `RBF #1 -> #2 -> #3`) |
| `REQ_H_02` | Hazard H2: In-flight propulsion loss, main bus sag below `36.0 V`, EPS `14.0 V` ESAD brownout (`GAP-01`), or Bingo reserve exhaustion (`< 0.20`). | Hazardous | `REQ_L_02`, `REQ_L_03` | `GAP-01`, `GAP-05`, `GAP-ENV`, `BingoEnergyReserveConstraint`, `EpsEsadZeroBrownoutMarginConstraint` | `REQ_SC_02`, `REQ_SC_04`, `REQ_SAF_01`, `REQ_SAF_11`; `RtaEnvelopeMonitorState::CriticalBatteryOrGeofenceRtb` + `Power Off ESAD` |
| `REQ_H_03` | Hazard H3: Loss of flight control authority due to RTA envelope exceedance (`> 55.0/80.0 m/s`), `CAN 1`/`CAN 2` bus saturation, or unflagged pitot/mag corruption. | Catastrophic | `REQ_L_02`, `REQ_L_03` | `GAP-02`, `GAP-04`, `GAP-WCET`, `SimplexRtaSoftwareHostingConstraint`, `CanTopologyIsolationConstraint` | `REQ_SC_05` through `REQ_SC_08`, `REQ_SAF_02`, `REQ_SAF_08`; `RtaEnvelopeMonitorState::AirspeedDiveCapClamped` & `EsadBusWatchdogFaultFallback` |
| `REQ_H_04` | Hazard H4: Artron ESAD premature arming, HV `>= 50.0 V` during PBIT, premature `DSC_IN1` fault, or out-of-order `RBF #3` removal. | Catastrophic | `REQ_L_01`, `REQ_L_04` | `GAP-04`, `GAP-06`, `GAP-07`, `EsadRbf3PowerBeforePullConstraint`, `EsadSafeDistanceExceedConstraint` | `REQ_SC_09` through `REQ_SC_11`, `REQ_SAF_04`, `REQ_SAF_06`, `REQ_SAF_07`; `EsadSafeArmState` (`SS1`, `SS2`, `DSC_IN1`, `FaultLockout`) |
| `REQ_H_05` | Hazard H5: EO/IR gimbal saturation above `55.0 m/s` dive speed or prolonged C2 link loss while warhead is armed. | Catastrophic | `REQ_L_03`, `REQ_L_04` | `GAP-02`, `GAP-WCET`, `EngagementSpeedAndTrackHoldConstraint`, `FlightEnvelopeSpeedConstraint` | `REQ_SC_12`, `REQ_SAF_02`; `PaceC2LinkState::EmergencyLostLinkRtlHolding` (`105.0 s` RTL + `Disarm ESAD On GCS Timeout`) |
| `REQ_H_06` | Hazard H6: Uncontrolled PL-40 rail discharge, `> 25.0 m/s` over-velocity (`< 15 kg` at `14 bar`), sub-stall exit (`< 24.0-26.0 m/s`), or unbleed hangfire crew approach. | Catastrophic | `REQ_L_01`, `REQ_L_02` | `GAP-03`, `GAP-SEPDIST`, `GAP-SCRUB`, `Pl40MassAndExitVelocityConstraint`, `Pl40UvloAndDualSwitchConstraint` | `REQ_SC_13` through `REQ_SC_16`, `REQ_SAF_03`, `REQ_SAF_10`, `REQ_SAF_12`; `Pl40LauncherState::ScrubbedSafeDepressurized` (`SAFE_SCRUB_ABORT`) |

#### 5.3.3 Component FMECA Criticality Profile & Peak RPN 192 Analysis (`FAILURE_MODE_REGISTRY.md`)

`FAILURE_MODE_REGISTRY.md` achieves `100%` AST structural coverage across all `15 / 15` SysML v2 `part def` assemblies (`42` BOM items and `CONN_01` through `CONN_24`), cataloging `61` distinct failure modes (`39` `SSOT`, `22` `Derived`) across all four universal dimensions (`Interface`, `State`, `Action`, `Resource`). Severity (`S`), Occurrence (`O`), and Detection (`D`) are integer ratings in `[1, 10]` yielding `RPN = S * O * D` per `MIL-STD-1629A` Methods 101/102 (`SAF-03`).

The portfolio exhibits a **Peak RPN of `192`** shared by four failure modes (`FM-04-01`, `FM-04-04`, `FM-14-03`, `FM-15-04`), with `19` modes scoring `RPN >= 135`. All `19` top-RPN failure modes and their governing STPA linkages are consolidated below:

| Rank | FM ID | AST Part (`part def`) | Dimension | S | O | D | RPN | Basis | Primary Risk & Containment Driver | Linked `REQ_*` IDs | Verification Gate |
| :---: | :--- | :--- | :--- | :---: | :---: | :---: | :---: | :--- | :--- | :--- | :--- |
| 1 | `FM-04-01` | `ElectronicPowerSystemEps` | Interface | 8 | 6 | 4 | 192 | `SSOT` | `GAP-01`: `14.0 V` `esad14VOut` zero brownout margin above `ESAD` `14.0 V` min | `REQ_H_02`, `REQ_UCA_02`, `REQ_SC_02`, `REQ_SAF_01` | `TC_02` |
| 2 | `FM-04-04` | `ElectronicPowerSystemEps` | Resource | 8 | 4 | 6 | 192 | `Derived` | `GAP-01`, `GAP-ENV`, `GAP-WCET`: `970.0 cm` trunk sag and unprinted EPS thermal limits | `REQ_H_02`, `REQ_SC_02`, `REQ_SAF_01`, `REQ_SAF_11` | `TC_02` |
| 3 | `FM-14-03` | `GroundRfStationAndAntennaTracker` | Action | 8 | 4 | 6 | 192 | `SSOT` | Omitted Transport Box ESD touch or `< 10.0 m` `2.0 W` RF proximity (`GAP-ENV`) | `REQ_L_01`, `REQ_SC_15`, `REQ_SAF_11` | `TC_08` |
| 4 | `FM-15-04` | `Avenger5V25IntegratedSystem` | Resource | 8 | 6 | 4 | 192 | `Derived` | Integrated `5400.0 s` / `0.20` Bingo energy + `GAP-01` `14.0 V` ESAD bus droop | `REQ_L_02`, `REQ_L_03`, `REQ_H_02`, `REQ_UCA_02`, `REQ_SC_02`, `REQ_SAF_01`, `REQ_SAF_05`, `REQ_SAF_09`, `REQ_SAF_11` | `TC_02` |
| 5 | `FM-07-03` | `NavigationAndAirDataSuite` | Action | 9 | 4 | 5 | 180 | `SSOT` | `CUAV SKYE2` pitot obstruction/icing/bias violating `55.0 m/s` RTA or `24.0-26.0 m/s` stall | `REQ_H_03`, `REQ_UCA_03`, `REQ_SC_07`, `REQ_SAF_02`, `REQ_SAF_11` | `TC_03`, `TC_04` |
| 6 | `FM-08-03` | `DroneCanSurfaceActuation` | Action | 9 | 4 | 5 | 180 | `SSOT` | `CAN 1/2` saturation (`GAP-WCET`) or `HV6160` blowdown `> 55.0/80.0 m/s` (`GAP-02`) | `REQ_L_02`, `REQ_H_03`, `REQ_SC_05`, `REQ_SC_06`, `REQ_SAF_02`, `REQ_SAF_08` | `TC_03` |
| 7 | `FM-07-02` | `NavigationAndAirDataSuite` | State | 8 | 5 | 4 | 160 | `SSOT` | GNSS spoofing/jamming DR transition delay or re-enable in lost-link RTL | `REQ_L_03`, `REQ_UCA_03`, `REQ_SC_07`, `REQ_SAF_08` | `TC_04` |
| 8 | `FM-11-01` | `ArtronEsadAndSensorUnit` | Resource | 8 | 5 | 4 | 160 | `SSOT` | `GE_POW` (`J100`) brownout `< 14.0 V` (`GAP-01` `0.0 V` margin) causing ESAD fault | `REQ_H_02`, `REQ_SC_02`, `REQ_SAF_01` | `TC_02`, `TC_06` |
| 9 | `FM-04-03` | `ElectronicPowerSystemEps` | Action | 10 | 3 | 5 | 150 | `Derived` | Common-cause `8.0 V` servo / `12.0 V` radio drop or failed `esadPowerOffCmd` (`GAP-SCRUB`) | `REQ_L_02`, `REQ_SC_16`, `REQ_SAF_08`, `REQ_SAF_09`, `REQ_SAF_12` | `TC_02`, `TC_08` |
| 10 | `FM-08-04` | `DroneCanSurfaceActuation` | Resource | 10 | 3 | 5 | 150 | `Derived` | Single `HV6160` stall/short collapsing shared `8.0 V` EPS rail across all 8 surfaces | `REQ_L_02`, `REQ_H_03`, `REQ_SC_06`, `REQ_SAF_09` | `TC_03` |
| 11 | `FM-12-02` | `Pl40PneumaticLauncher` | State | 10 | 3 | 5 | 150 | `SSOT` | Unbleed hangfire / armed-rail approach without `SAFE_SCRUB_ABORT` (`GAP-SCRUB`) | `REQ_H_06`, `REQ_UCA_08`, `REQ_SC_13`, `REQ_SC_16`, `REQ_SAF_12` | `TC_08` |
| 12 | `FM-15-03` | `Avenger5V25IntegratedSystem` | Action | 10 | 3 | 5 | 150 | `Derived` | End-to-end dual-path Simplex RTA + ESAD `Power Off` multi-hop latency (`GAP-02`, `GAP-04`, `GAP-WCET`) | `REQ_L_02`, `REQ_L_03`, `REQ_L_04`, `REQ_H_03`, `REQ_H_05`, `REQ_UCA_03`, `REQ_UCA_04`, `REQ_UCA_07`, `REQ_SC_05`, `REQ_SC_08`, `REQ_SC_12`, `REQ_SAF_01`, `REQ_SAF_02`, `REQ_SAF_04`, `REQ_SAF_08` | `TC_03` through `TC_06` |
| 13 | `FM-12-01` | `Pl40PneumaticLauncher` | Interface | 9 | 4 | 4 | 144 | `SSOT` | `IF-MECH-001` sub-stall `23.0 m/s` exit at `17.0 kg` (`GAP-03`) or `> 25.0 m/s` overspeed | `REQ_H_06`, `REQ_SAF_03` | `TC_07` |
| 14 | `FM-13-02` | `SwarmC2OperatorConsole` | State | 9 | 4 | 4 | 144 | `SSOT` | `SwarmC2` voltage UI (`GAP-05`), `RBF #3` ordering (`GAP-06`), `SS2` wording (`GAP-07`) desync | `REQ_H_04`, `REQ_UCA_06`, `REQ_SC_09`, `REQ_SAF_05`, `REQ_SAF_06`, `REQ_SAF_07` | `TC_01`, `TC_06` |
| 15 | `FM-15-01` | `Avenger5V25IntegratedSystem` | Interface | 9 | 4 | 4 | 144 | `SSOT` | Cross-segment `PL-40` `IF-MECH-001` (`CONN_23`) and `SS1` (`CONN_24`) mismatch (`GAP-03`, `GAP-SEPDIST`) | `REQ_L_01`, `REQ_L_02`, `REQ_H_01`, `REQ_H_06`, `REQ_SAF_03`, `REQ_SAF_10` | `TC_01`, `TC_07` |
| 16 | `FM-01-01` | `MainBatteryAndFuseUnit` | Interface | 9 | 3 | 5 | 135 | `SSOT` | Open/high-resistance `protectedDcOut` (`IF-PWR-001`, `IF-PWR-002`, `CONN_01`) or pack QR/ID mismatch | `REQ_L_02`, `REQ_H_02`, `REQ_SC_02`, `REQ_SC_04` | `TC_01`, `TC_02` |
| 17 | `FM-02-04` | `PowerMeterAndRbfSwitch` | Resource | 9 | 3 | 5 | 135 | `Derived` | `XT60E-F` `RBF #2` / `970.0 cm` trunk ohmic sag (`GAP-01`) starving `IBEX160` and `EPS` | `REQ_L_02`, `REQ_H_02`, `REQ_SC_02`, `REQ_SAF_01`, `REQ_SAF_09`, `REQ_SAF_11` | `TC_02` |
| 18 | `FM-03-02` | `ElectricPropulsionUnit` | State | 9 | 3 | 5 | 135 | `SSOT` | Rear prop unfolded outside `145.0-155.5 mm` or `RBF #1` covers retained pre-`RBF #2` | `REQ_L_01`, `REQ_H_01`, `REQ_UCA_01`, `REQ_SC_01`, `REQ_SC_07`, `REQ_SAF_06` | `TC_01` |
| 19 | `FM-11-05` | `ArtronEsadAndSensorUnit` | Interface | 9 | 3 | 5 | 135 | `Derived` | Warhead holder mass (`<= 5.0 kg`), CTQ units, or `M3`/`M2`/`1.5 mm HEX`/`J401` loosening (`GAP-SEPDIST`) | `REQ_L_02`, `REQ_SAF_10` | `TC_06` |

- **High-Severity Interlock-Gated Modes (`S = 10`, `D <= 3`):** In addition to the top-19 RPN modes above, five Catastrophic `S = 10` failure modes (`FM-02-02` RPN `90`, `FM-05-03` RPN `60`, `FM-06-02` RPN `60`, `FM-11-03` RPN `60`, and `FM-11-04` RPN `60`) achieve reduced RPN strictly through deterministic hardware and software interlocks (`RBF #1 -> #2 -> #3` sequencing, `Cube orange+` Simplex RTA dive speed clamping `<= 55.0 m/s`, `STANAG 4187` `SS1`/`SS2` `Safe Distance Exceed == 1`, and `DSC_IN1` `1 kHz` 2-pulse gating). Any regression in those interlocks immediately elevates residual operational risk; consequently, `TC_01` through `TC_08` enforce mandatory closed-loop verification of every `S = 10` barrier alongside the `RPN = 192` peak drivers (`GAP-01`, `GAP-ENV`, `GAP-WCET`, `GAP-REL`, `GAP-SCRUB`).

/// OperationalAllocation: [MET-01]
/// OperationalAllocation: [MET-02]
/// OperationalAllocation: [MET-03]
/// OperationalAllocation: [MET-04]
