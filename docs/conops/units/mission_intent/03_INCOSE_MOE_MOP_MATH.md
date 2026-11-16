## 3. INCOSE Measures of Effectiveness (MoE) & Measures of Performance (MoP) Math

- **Baseline Date:** `2026-11-16`
- **System Baseline:** `Avenger5V25UasSystem` (`Avenger5V25IntegratedSystem`: `Avenger 5 V2.5 UAS` / `ASTK A5 V2.5` + `ELI Military Simulations PL-40 Rev 2.6` + `Artron ESAD AB00-0054-01AA-0005` + `SwarmC2`)
- **JSON Schema Mapping:** `incose_moe_mop` (`.pipeline/schemas/mission_intent_specification_schema.json`)
- **Normative Governance:** `INCOSE SE Handbook v5.0` (§2.3.5.4, §2.3.5.9, §3.4.4), `ISO/IEC/IEEE 15288:2023` (§6.4.2, §6.4.3, §6.4.4, §6.4.9), `ISO/IEC/IEEE 29148:2018` (§6.4, §8.4, Annex A §A.2), `IEEE Std 1362-1998` (§4, §4.3), `NATO STANAG 4187 Ed. 5` (Chapter 2, Chapter 3, Annex A), `MIL-STD-882E` (Tasks 202, 205, 206), `MIL-STD-1629A` (Methods 101, 102), `MIL-STD-461G`, `MIL-STD-810H`, `RTCA DO-178C / DO-254`, `RTCA DO-362A` (§2.2, §3.2), `SAE ARP4754A / ARP4761`, `JARUS SORA v2.5` (Annex B, Annex C), `ASTM F3269-17` (§5.2), `NIST SP 800-82r3` (Chapter 6, Appendix F), and `DoD Directive 3000.09` (§4.1.a).
- **Architectural Truth Invariants:** Software-hosted `ASTM F3269-17` Simplex Run-Time Assurance (`RTA`) inside `FlightControllerCubeOrangePlus` (`standaloneRtaBoxCount == 0`, `rtaHostedOnCubeOrangePlus == true`); strictly mechanical zero-wire `Pl40PneumaticLauncher` launch interface (`IF-MECH-001`, `CONN_23`, `electricalWireToUavCount == 0`); zero production recovery parachutes (`rndRecoveryOptionInstalled == false`, with `2x 50.0 V` Optional RnD igniter rails permanently inhibited per `REQ_SC_03`); `12S2P` `36.0-50.4 V` primary DC bus (`49.0-50.0 V` pre-flight check rejecting lower-voltage legacy UI values per `GAP-05`); and Level 1B stakeholder disambiguation (`UCL-01` through `UCL-05`, zero Level 2 use-case IDs, zero Level 1C serial hex opcodes or connector pin numbers).

In accordance with `INCOSE SE Handbook v5.0` (§2.3.5.4, §2.3.5.9, §3.4.4) and `ISO/IEC/IEEE 29148:2018` (§6.4), operational effectiveness across `Avenger5V25UasSystem` is quantified by five mission-level **Measures of Effectiveness (`MoE-01` through `MoE-05`)** and eight system/subsystem **Measures of Performance (`MoP-01` through `MoP-08`)**. Every mathematical expression derives exclusively from declared `constraint def` invariants and grounded attributes in `.pipeline/schema.sysml`, `schema/extracted/parametric_limits.md`, and `docs/research/RESEARCH_INVENTORY.md`.

---

### 3.1 Master INCOSE MoE & MoP Summary Matrix

`Table 3.1` consolidates all `MoE-01` through `MoE-05` and `MoP-01` through `MoP-08` metrics (plus linked sub-dimensions `MoE-02a`, `MoP-01a`, `MoP-04a`, `MoP-05a`, `MoP-08a`, and `MoP-08b`) with strictly isolated `Threshold`, `Objective`, and `Units` columns.

#### Table 3.1: Master INCOSE MoE & MoP Verification Summary (`incose_moe_mop`)

| Metric ID | Class | Measure Name | Governing Symbolic Expression | Threshold | Objective | Units | SSOT Constraint & Verification Basis |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `MoE-01` | `MoE` | Terminal Precision Engagement Accuracy (`CEP_50`) | `CEP_50 = median(||p_imp - p_tgt||_2) <= CEP_max` | `<= 0.5` | `< 0.5` | m | `PRM-PERF-020`, `EngagementSpeedAndTrackHoldConstraint`, `MET-01`, `TC_05` |
| `MoE-02` | `MoE` | Sortie Endurance Envelope (with `0.20` Bingo Floor) | `T_usable = (1 - rho_bingo_min) * T_endurance_max` | `4320.0` | `5400.0` | s | `PRM-PERF-001`, `PRM-PERF-002`, `MainBatteryAndFuseUnit`, `TC_02` |
| `MoE-02a` | `MoE` | Statutory Bingo Energy Reserve Ratio (`1080.0 s` floor) | `rho_rem = E_reserve / E_cap >= rho_bingo_min` | `>= 0.20` | `>= 0.20` | ratio | `PRM-PERF-003`, `BingoEnergyReserveConstraint`, `MET-02`, `REQ_SC_02`, `TC_02` |
| `MoE-03` | `MoE` | `JARUS SORA v2.5` Operational Containment Margin (`M_contain`) | `M_contain = R_containment / (R_OV + R_GRB)` | `>= 1.0` | `>= 1.0` | ratio | `JARUS SORA v2.5` Annex B/C, `MET-02`, `CONOPS.md §5.2`, `TC_02`, `TC_08` |
| `MoE-04` | `MoE` | Encrypted `4.4-5.0 GHz` C2 RLOS Reach (`R_RLOS`) | `R_ops(t) <= R_RLOS` (with DR continuity) | `60.0` | `90.0` | km | `PRM-RF-006`, `PRM-RF-007`, `GAP-02`, `CTL-02`, `REQ_SAF_02`, `TC_04` |
| `MoE-05` | `MoE` | Positive HITL Lethal Governance & Scrub Compliance (`P_HITL`) | `P_HITL = 100 * N_compliant / N_total` (`N_unauth = 0`) | `100.0` | `100.0` | percent | `DoD Directive 3000.09 §4.1.a`, `NATO STANAG 4187 Ed. 5`, `MET-03`, `TC_06`, `TC_08` |
| `MoP-01` | `MoP` | `PL-40` Pneumatic Rail Exit Velocity (`V_exit` at `17.0 kg`) | `V_exit_low <= V_exit(m_UAV, P_tank) <= V_exit_max` | `22.7` | `23.5` | m/s | `PRM-PL40-002` through `PRM-PL40-005`, `Pl40MassAndExitVelocityConstraint`, `GAP-03`, `TC_07` |
| `MoP-01a` | `MoP` | Post-Launch Climb Airspeed vs Stall Floor (`V_air_launch`) | `V_air_launch = V_exit + v_headwind + Delta V_pusher` | `>= 24.0` | `>= 26.0` | m/s | `PRM-PERF-004`, `PRM-PERF-005`, `REQ_SAF_03`, `GAP-03`, `TC_03`, `TC_07` |
| `MoP-02` | `MoP` | `12S2P` Main DC Bus Operating & Pre-Flight Window (`V_bus`) | `V_bus in [V_bus_min, V_bus_max]`; `V_pack in [V_pre_min, V_pre_max]` | `36.0-50.4` | `49.0-50.0` | V | `PRM-AV-001` through `PRM-AV-004`, `MainBatteryPreFlightVoltageConstraint`, `GAP-05`, `TC_01` |
| `MoP-03` | `MoP` | `EPS` to `Artron ESAD` Regulated Rail Input (`V_ESAD_in`) | `Delta V_brownout = V_EPS_esad - Delta V_wire - V_ESAD_min >= 0` | `>= 14.0` | `28.0` | V | `PRM-AV-010`, `PRM-ESAD-001` through `PRM-ESAD-003`, `EpsEsadZeroBrownoutMarginConstraint`, `GAP-01`, `TC_02` |
| `MoP-04` | `MoP` | `RPI CM5` to `ESAD` RS-485 Watchdog & Reply Latency (`tau_wd`) | `tau_reply <= tau_reply_max < tau_wd_max <= T_poll` | `<= 10.0` | `<= 5.0` | ms | `PRM-ESAD-019`, `PRM-ESAD-020`, `EsadRs485ProtocolTimingConstraint`, `GAP-04`, `TC_04`, `TC_06` |
| `MoP-04a` | `MoP` | `RPI CM5` `OC Master` Cyclic RS-485 Polling Rate (`f_poll`) | `f_poll = 1 / T_poll` (`115200 bps` `8N1`, `CRC-16 XModem`) | `100.0` | `100.0` | Hz | `PRM-ESAD-017`, `CompanionComputeRpiCm5`, `REQ_SC_08`, `CTL-03`, `TC_06` |
| `MoP-05` | `MoP` | `Artron ESAD` PBIT Safe Internal HV Ceiling (`V_PBIT`) | `V_PBIT < V_PBIT_safe`; `V_J401 = 0` pre-`SS1`/`SS2`/`DSC1` | `< 50.0` | `0.0` | V | `PRM-ESAD-029`, `PRM-ESAD-030`, `WarheadMassAndPbitHvSafetyConstraint`, `SAF-01`, `TC_06` |
| `MoP-05a` | `MoP` | `ESAD RBF #3` Umbilical Loop Continuity Resistance (`R_UMB`) | `R_UMB = V_UMB / I_sense < R_UMB_max` | `< 0.5` | `< 0.5` | Ohm | `PRM-ESAD-004`, `PRM-ESAD-005`, `EsadRbf3PowerBeforePullConstraint`, `GAP-06`, `TC_01` |
| `MoP-06` | `MoP` | `EO/IR` Seeker Daylight Target Track Hold Window (`tau_track`) | `tau_hold_min <= tau_track <= tau_hold_max` | `2.0` | `2.0-5.0` | s | `PRM-GCS-011`, `PRM-GCS-012`, `EngagementSpeedAndTrackHoldConstraint`, `MET-03`, `TC_05` |
| `MoP-07` | `MoP` | Software Simplex RTA Airspeed Envelope & Dive Cap (`V_air`) | `V_stall <= V_air <= V_NE`; `q_engage -> V_air <= V_engage_cap` | `24.0-80.0` | `26.0-55.0` | m/s | `PRM-PERF-004` through `PRM-PERF-011`, `FlightEnvelopeSpeedConstraint`, `SimplexRtaSoftwareHostingConstraint`, `TC_03`, `TC_05` |
| `MoP-08` | `MoP` | `GCS Failsafe` Lost-Link RTL & ESAD Disarm Timeout (`tau_gcs_fs`) | `Delta t_C2_loss >= tau_gcs_fs -> RTL and DisarmESAD` | `<= 120.0` | `<= 105.0` | s | `PRM-GCS-002`, `PRM-GCS-008`, `PaceC2LinkState`, `CTL-02`, `REQ_SC_15`, `TC_04` |
| `MoP-08a` | `MoP` | HITL `ESAD` Self-Destruct & Permanent Abort Hold (`tau_sd_min`) | `tau_hold_abort >= tau_sd_min and q_slide = 1` | `>= 5.0` | `>= 5.0` | s | `PRM-GCS-010`, `CommandEsadAbortAndSelfDestruct`, `DoD Directive 3000.09`, `TC_08` |
| `MoP-08b` | `MoP` | Derived `SAFE_SCRUB_ABORT` Hangfire Crew Dwell (`tau_scrub_dwell`) | `tau_holdback_crew >= tau_scrub_dwell` (`P_tank = 0`, `RBF #3 -> #2`) | `>= 10.0` | `>= 10.0` | min | `GAP-SCRUB`, `REQ_SC_16`, `REQ_SAF_12`, `MET-04`, `EMG-04`, `TC_08` |

---

### 3.2 Measures of Effectiveness (`MoE-01` through `MoE-05`)

#### 3.2.1 `MoE-01`: Terminal Precision Engagement Accuracy (`CEP_50`)

Terminal engagement effectiveness measures the 50th-percentile horizontal radial miss distance (`CEP_50`) between the physical impact datum and the human-authorized stationary target coordinates under `Nighthawk2UZ` (`1280x720` Day/Thermal, `X40` zoom) + `Trip6` visual lock (`2.0-5.0 s` continuous hold, initial target elevation `<= 15.0 deg`, `15.0 deg` shallow / `<= 22.0 deg` dive) and `FlightControllerCubeOrangePlus` airspeed capping (`<= 55.0 m/s`, `EngagementSpeedAndTrackHoldConstraint`, `REQ_SC_12`, `MET-01`).

$$
\begin{aligned}
e_i &= \sqrt{\left(x_{\mathrm{imp},i} - x_{\mathrm{tgt},i}\right)^{2} + \left(y_{\mathrm{imp},i} - y_{\mathrm{tgt},i}\right)^{2}} \\
\mathrm{CEP}_{50} &= \mathrm{median}_{i \in \{1, \dots, N\}} \left(e_i\right) = \inf \left\{ r \ge 0 \mid \frac{1}{N} \sum_{i=1}^{N} \mathbf{1}\!\left(e_i \le r\right) \ge 0.50 \right\} \\
\mathrm{CEP}_{50} &\le \mathrm{CEP}_{\max}, \qquad V_{\mathrm{air}}(t) \le V_{\mathrm{engage,cap}}, \qquad \tau_{\mathrm{hold,min}} \le \tau_{\mathrm{track}} \le \tau_{\mathrm{hold,max}}, \qquad \theta_{\mathrm{elev}} \le \theta_{\mathrm{elev,max}}
\end{aligned}
$$

#### Parameter Definitions & Engineering Units: `MoE-01` Terminal Engagement Accuracy

| Parameter | Symbol | Units | Governing Bound / Constraint | SSOT Basis |
| :--- | :--- | :--- | :--- | :--- |
| Radial Impact Miss Distance | e_i | m | e_i >= 0.0 per qualified terminal trial | `EngagementSpeedAndTrackHoldConstraint`, `TC_05` |
| Impact Ground Coordinates | x_imp,i, y_imp,i | m | Measured horizontal impact datum | `EoIrSeekerAndTrackerUnit`, `PRM-PERF-020` |
| Stationary Target Coordinates | x_tgt,i, y_tgt,i | m | Authorized stationary target datum | `PRM-PERF-020`, `REQ_SC_12` |
| Sample Engagement Trial Count | N | count | N >= 1 statistically valid trials | `INCOSE SE Handbook v5.0 §2.3.5.9` |
| Circular Error Probable (50%) | CEP_50 | m | <= 0.5 Threshold (Objective < 0.5) | `PRM-PERF-020`, `PRM-PERF-021` (`50.0 cm`) |
| Maximum Allowable CEP Ceiling | CEP_max | m | 0.5 | `PRM-PERF-020`, `EngagementSpeedAndTrackHoldConstraint` |
| Active Dive Engagement Airspeed | V_air | m/s | <= 55.0 (Abort Engaging above cap) | `PRM-PERF-010`, `FlightEnvelopeSpeedConstraint` |
| EO Daylight Track Hold Duration | tau_track | s | 2.0 to 5.0 continuous lock prior to ATTACK | `PRM-GCS-011`, `PRM-GCS-012` |
| Initial Target Elevation Angle | theta_elev | deg | <= 15.0 at terminal engagement start | `PRM-PERF-014`, `PRM-PERF-013` (`15.0` shallow / `<= 22.0` dive) |

#### 3.2.2 `MoE-02`: Mission Endurance & Statutory Bingo Energy Preservation (`T_usable`, `rho_bingo`)

Mission persistence balances total `12S2P Li metal BEI maximus20` flight endurance (`5400.0 s` / `90.0 min` maximum nominal endurance, `PRM-PERF-001`, `PRM-PERF-002`) against the derived `0.20` (`20%`) statutory Bingo energy reserve floor (`1080.0 s` / `18.0 min`, `PRM-PERF-003`, `BingoEnergyReserveConstraint`, `MET-02`), yielding `4320.0 s` (`72.0 min`) of usable on-station sortie time before autonomous Return-to-Launch (`RTL`) override (`REQ_SC_02`). Unprinted pack `Wh`/`Ah` ratings and `SoC` cutoffs remain tracked under `GAP-ENV` (`REQ_SAF_11`).

$$
\begin{aligned}
\rho_{\mathrm{rem}}(t) &= \frac{E_{\mathrm{rem}}(t)}{E_{\mathrm{cap}}} \approx \frac{T_{\mathrm{rem}}(t)}{T_{\mathrm{endurance,max}}} \\
T_{\mathrm{bingo}} &= \rho_{\mathrm{bingo,min}} \, T_{\mathrm{endurance,max}}, \qquad E_{\mathrm{reserve}} \ge \rho_{\mathrm{bingo,min}} \, E_{\mathrm{cap}} \\
T_{\mathrm{usable}} &= \left(1 - \rho_{\mathrm{bingo,min}}\right) T_{\mathrm{endurance,max}} = T_{\mathrm{endurance,max}} - T_{\mathrm{bingo}} \\
u_{\mathrm{RTL}}(t) &= \mathbf{1}\!\left(\left(\rho_{\mathrm{rem}}(t) \le \rho_{\mathrm{bingo,min}}\right) \lor \left(T_{\mathrm{rem}}(t) \le T_{\mathrm{bingo}}\right) \lor \left(V_{\mathrm{bus}}(t) < V_{\mathrm{bus,min}}\right)\right)
\end{aligned}
$$

#### Parameter Definitions & Engineering Units: `MoE-02` Mission Endurance & Bingo Reserve

| Parameter | Symbol | Units | Governing Bound / Constraint | SSOT Basis |
| :--- | :--- | :--- | :--- | :--- |
| Remaining Usable Battery Energy | E_rem | J | E_rem > E_reserve on station (`GAP-ENV` Wh/Ah unprinted) | `MainBatteryAndFuseUnit`, `REQ_SAF_11` |
| Rated 12S2P Energy Capacity | E_cap | J | E_cap > 0.0 nominal (`GAP-ENV` Wh/Ah unprinted) | `MainBatteryAndFuseUnit`, `GAP-ENV` |
| Statutory Bingo Reserve Energy | E_reserve | J | >= 0.20 * E_cap preserved for RTL | `BingoEnergyReserveConstraint`, `MET-02` |
| Remaining Endurance Ratio | rho_rem | ratio | > 0.20 during CruiseAndLoiter | `MonitorBingoEnergyReserve`, `REQ_SC_02` |
| Statutory Bingo Reserve Ratio | rho_bingo_min | ratio | >= 0.20 | `PRM-PERF-003`, `BingoEnergyReserveConstraint` |
| Maximum Rated Sortie Endurance | T_endurance_max | s | 5400.0 (90.0 min ConOps/weather dependent) | `PRM-PERF-001`, `PRM-PERF-002` |
| Statutory Bingo Reserve Time | T_bingo | s | 1080.0 (0.20 * 5400.0 = 18.0 min) | `MainBatteryAndFuseUnit`, `REQ_UCA_02` |
| Usable On-Station Mission Time | T_usable | s | 4320.0 (0.80 * 5400.0 = 72.0 min) | Derived from `PRM-PERF-002` and `PRM-PERF-003` |
| Primary 12S2P Bus Voltage | V_bus | V | >= 36.0 (36.0 to 50.4 operating range) | `PRM-AV-001`, `PRM-AV-002` |
| Autonomous Bingo/Sag RTL Trigger | u_RTL | Boolean | 1 triggers EmergencyAbortOrRtb RTL | `RtaEnvelopeMonitorState`, `TC_02` |

#### 3.2.3 `MoE-03`: `JARUS SORA v2.5` Operational Boundary Containment Margin (`M_contain`)

Because production `Avenger 5 V2.5` excludes recovery parachutes (`rndRecoveryOptionInstalled == false`, `2x 50.0 V` Optional RnD igniters disabled per `ProductionNoParachuteConstraint`, `REQ_SC_03`) at `17.0 kg` MTOW, `JARUS SORA v2.5` Annex B and Annex C (`MET-02`) require the declared operational containment radius `R_containment` to enclose the sum of the Flight Geography (`R_FG >= 300.0 m`), Contingency Volume (`Delta R_CV`), and unpowered Ground Risk Buffer (`R_GRB`), while remaining inside the active `RLOS` datalink envelope (`60.0 km` baseline / `90.0 km` extended) and `50.0-3000.0 m` waypoint altitude corridor (`<= 5000.0 m` service ceiling).

$$
\begin{aligned}
R_{\mathrm{OV}} &= R_{\mathrm{FG}} + \Delta R_{\mathrm{CV}}, \qquad R_{\mathrm{FG}} \ge r_{\mathrm{loiter,min}}, \qquad h_{\mathrm{mission,min}} \le h(t) \le h_{\mathrm{mission,max}} \le h_{\mathrm{ceiling}} \\
t_{\mathrm{fall}} &= \sqrt{\frac{2 \, h_{\mathrm{mission,max}}}{g_{\mathrm{accel}}}}, \qquad d_{\mathrm{ballistic}} = \frac{h_{\mathrm{mission,max}}}{\tan\!\left(\theta_{\mathrm{dive,max}}\right)} \\
d_{\mathrm{wind}} &= v_{\mathrm{wind,crs,max}} \, t_{\mathrm{fall}}, \qquad d_{\mathrm{glide,max}} = \max\!\left(d_{\mathrm{ballistic}}, \, \gamma_{\mathrm{glide}} \, h_{\mathrm{mission,max}}\right) + d_{\mathrm{wind}} \\
R_{\mathrm{GRB}} &\ge d_{\mathrm{glide,max}} + V_{\mathrm{horiz,max}} \, \tau_{\mathrm{react}} + \Delta r_{\mathrm{nav}}, \qquad R_{\mathrm{min}} = R_{\mathrm{OV}} + R_{\mathrm{GRB}} \\
M_{\mathrm{contain}} &= \frac{R_{\mathrm{containment}}}{R_{\mathrm{min}}} \ge 1.0, \qquad R_{\mathrm{min}} \le R_{\mathrm{containment}} \le R_{\mathrm{RLOS}}, \qquad N_{\mathrm{parachute}} = 0
\end{aligned}
$$

#### Parameter Definitions & Engineering Units: `MoE-03` JARUS SORA v2.5 Operational Containment

| Parameter | Symbol | Units | Governing Bound / Constraint | SSOT Basis |
| :--- | :--- | :--- | :--- | :--- |
| Flight Geography Radius | R_FG | m | >= 300.0 (r_loiter_min) | `PRM-GCS-007`, `SwarmC2AuthAndMissionBoundsConstraint` |
| Contingency Volume Lateral Buffer | Delta R_CV | m | > 0.0 sortie-configured buffer | `JARUS SORA v2.5 Annex C`, `CONOPS.md §5.2` |
| Operational Volume Radius | R_OV | m | R_FG + Delta R_CV | `JARUS SORA v2.5 Annex C`, `MET-02` |
| Mission Altitude Envelope | h_mission_min, h_mission_max | m | 50.0 to 3000.0 (within 5000.0 ceiling) | `PRM-GCS-004`, `PRM-GCS-005`, `PRM-PERF-015` |
| Standard Gravitational Acceleration | g_accel | N/kg | 9.80665 | `CONOPS.md §5.2` |
| Maximum Aerodynamic Dive Angle | theta_dive_max | deg | <= 22.0 | `PRM-PERF-012`, `ElectricPropulsionUnit` |
| Maximum Cruise Wind Drift Speed | v_wind_crs_max | m/s | <= 28.0 | `PRM-PERF-017`, `ElectricPropulsionUnit` |
| Unpowered Glide Ratio (L/D) | gamma_glide | ratio | UNPRINTED (`GAP-ENV`; calibrated pre-ops) | `REQ_SAF_11`, `CONOPS.md §5.2` |
| Max Horizontal Containment Speed | V_horiz_max | m/s | 42.0 V2.5 (38.0 V1 conservative) | `PRM-PERF-008`, `PRM-PERF-009`, `GAP-02` |
| End-to-End RTA Reaction Latency | tau_react | s | Bench-verified around 0.01 ESAD cycle (`GAP-WCET`) | `REQ_SAF_08`, `CONOPS.md §5.2` |
| GNSS-Denied DR Drift Allowance | Delta r_nav | m | UNPRINTED (`GAP-SEPDIST`; calibrated pre-ops) | `REQ_SAF_10`, `CONOPS.md §5.2` |
| Ground Risk Buffer Radius | R_GRB | m | >= d_glide_max + V_horiz_max * tau_react + Delta r_nav | `JARUS SORA v2.5 Annex B`, `MET-02` |
| Minimum Required Containment Radius | R_min | m | R_OV + R_GRB | `JARUS SORA v2.5`, `CONOPS.md §5.2` |
| Declared Operational Containment | R_containment | m | >= R_min and <= R_RLOS | `MET-02`, `TC_02`, `TC_08` |
| Boundary Containment Margin Ratio | M_contain | ratio | >= 1.0 | `JARUS SORA v2.5 Annex B/C`, `MET-02` |
| Production Recovery Parachutes | N_parachute | count | 0 (Optional RnD 2x 50.0 V inhibited) | `ProductionNoParachuteConstraint`, `REQ_SC_03` |

#### 3.2.4 `MoE-04`: `4.4-5.0 GHz` C2 RLOS Reach & Contested GNSS-Denied Continuity (`R_RLOS`)

Command-and-control effectiveness quantifies operational slant range across the encrypted `DTC 4.4-5.0 GHz` `AES-256` FHSS air-ground datalink (`2.0 W` total / `2x 1.0 W` dual `MPSL4400` airborne antennas, `MARS 23.0 dBi` `DIR` rotator with `0.5 deg` trim and `OMNI` close-in antenna, optional `200.0 m` ground fiber spool, `>= 10.0 m` crew/radio separation) alongside uninterrupted `INS/DR` flight continuity upon `GPS Failsafe` or operator `Disable GNSS` (`2x mRo RM3100` + `CUAV SKYE2` pitot on `CAN 2`, `PaceC2LinkState`, `OA-07`, `REQ_SC_07`, `CTL-02`).

$$
\begin{aligned}
R_{\mathrm{ops}}(t) &= \sqrt{\left(x_{\mathrm{UAV}}(t) - x_{\mathrm{GCS}}\right)^{2} + \left(y_{\mathrm{UAV}}(t) - y_{\mathrm{GCS}}\right)^{2} + \left(h_{\mathrm{UAV}}(t) - h_{\mathrm{GCS}}\right)^{2}} \le R_{\mathrm{RLOS}} \\
f_{\mathrm{C2}} &\in \left[f_{\mathrm{RF,min}}, \, f_{\mathrm{RF,max}}\right], \qquad P_{\mathrm{TX,tot}} = 2 \, P_{\mathrm{TX,ant}}, \qquad K_{\mathrm{AES}} = 256, \qquad d_{\mathrm{sep,gnd}} \ge d_{\mathrm{sep,min}} \\
\mathrm{Mode}_{\mathrm{C2}}(t) &= \begin{cases}
\mathrm{DIR} & \text{if } \Delta t_{\mathrm{loss}} < \tau_{\mathrm{gcs,fs}} \land q_{\mathrm{DIR}} = 1 \\
\mathrm{OMNI} & \text{if } \Delta t_{\mathrm{loss}} < \tau_{\mathrm{gcs,fs}} \land q_{\mathrm{DIR}} = 0 \\
\mathrm{EmergencyRTL} & \text{if } \Delta t_{\mathrm{loss}} \ge \tau_{\mathrm{gcs,fs}}
\end{cases} \\
\mathrm{Nav}_{\mathrm{source}}(t) &= \begin{cases}
\mathrm{GnssRtk} & \text{if } q_{\mathrm{GNSS}} = 1 \land u_{\mathrm{disGNSS}} = 0 \\
\mathrm{InsDeadReckoning} & \text{if } q_{\mathrm{GNSS}} = 0 \lor u_{\mathrm{disGNSS}} = 1
\end{cases}
\end{aligned}
$$

#### Parameter Definitions & Engineering Units: `MoE-04` C2 RLOS Reach & Contested Continuity

| Parameter | Symbol | Units | Governing Bound / Constraint | SSOT Basis |
| :--- | :--- | :--- | :--- | :--- |
| Active Air-to-Ground Slant Range | R_ops | km | <= R_RLOS throughout mission | `AirGroundRfDatalinkInterface`, `CONN_21` |
| Rated Radio Line-of-Sight Range | R_RLOS | km | 60.0 baseline / 90.0 V2.5 extended (`GAP-02`) | `PRM-RF-006`, `PRM-RF-007` (V1 `180.0`) |
| DTC FHSS C2 Frequency Band | f_RF_min, f_RF_max | GHz | 4.4 to 5.0 | `PRM-RF-001`, `PRM-RF-002`, `OBL-04` |
| Total / Per-Antenna RF TX Power | P_TX_tot, P_TX_ant | W | 2.0 total (2x 1.0 per MPSL4400) | `PRM-RF-003`, `PRM-RF-004` |
| FHSS Link Encryption Strength | K_AES | bits | 256 (AES-256) | `PRM-RF-005`, `NIST SP 800-82r3` |
| Ground MARS Directional Gain | G_MARS | dBi | 23.0 (0.5 deg fine step rotator) | `PRM-RF-009`, `PRM-RF-010` |
| Optional Ground Fiber Spool Length | L_fiber | m | <= 200.0 | `PRM-RF-012`, `IF-GND-001` |
| Ground Radio-to-UAV Separation | d_sep_gnd | m | >= 10.0 during prep | `PRM-GCS-001`, `GroundCrewSeparationAndEsdConstraint` |
| GCS Lost-Link RTL Timeout | tau_gcs_fs | s | 105.0 baseline (`Disarm ESAD` + RTL) | `PRM-GCS-008`, `PaceC2LinkState`, `CTL-02` |
| DIR / GNSS / DisableGNSS Indicators | q_DIR, q_GNSS, u_disGNSS | Boolean | 0 or 1 discrete operational states | `PaceC2LinkState`, `SwitchToGnssDeniedDeadReckoning`, `TC_04` |

#### 3.2.5 `MoE-05`: Positive HITL Weapon Governance & Zero-Harm Scrub Assurance (`P_HITL`)

Per `DoD Directive 3000.09` (§4.1.a, `MET-03`), `NATO STANAG 4187 Ed. 5` (`SAF-01`), and `MIL-STD-882E` Task 206 (`MET-04`), no high-voltage ordnance charging (`0.0-1800.0 V`), terminal `ATTACK` dive, or detonation occurs without verified Human-in-the-Loop (`UCL-01` through `UCL-03`) authorization and intact physical/inertial barriers (`RBF #2` before `RBF #3` per `GAP-06`, `SS1` launch pulse, `SS2` `Safe Distance Exceed == 1` per `GAP-07`, `DSC_IN1`), while any pre-launch scrub enforces `SAFE_SCRUB_ABORT` (`>= 10.0 min` holdback dwell, `0.0 bar` bleed, red pin restore, and `RBF #3` prior to `RBF #2` safing, `GAP-SCRUB`).

$$
\begin{aligned}
G_{\mathrm{arm}} &= I_{\mathrm{seqRBF}} \cdot I_{\mathrm{SS1}} \cdot I_{\mathrm{SS2}} \cdot I_{\mathrm{DSC1}} \cdot I_{\mathrm{HITL,arm}} \\
G_{\mathrm{fire}} &= G_{\mathrm{arm}} \cdot I_{\mathrm{pre6}} \cdot I_{\mathrm{track}} \cdot I_{\mathrm{HITL,atk}} \cdot I_{\mathrm{IRQ}} \\
G_{\mathrm{scrub}} &= I_{\mathrm{sd}} \cdot I_{\mathrm{pwroff}} \cdot I_{\mathrm{dwell}} \cdot I_{\mathrm{bleed}} \cdot I_{\mathrm{pin}} \cdot I_{\mathrm{revRBF}} \\
P_{\mathrm{HITL}} &= 100 \cdot \frac{N_{\mathrm{compliant}}}{N_{\mathrm{total}}}, \qquad N_{\mathrm{unauth}} = N_{\mathrm{total}} - N_{\mathrm{compliant}} = 0
\end{aligned}
$$

#### Parameter Definitions & Engineering Units: `MoE-05` Positive HITL Governance & Safe Scrub Compliance

| Parameter | Symbol | Units | Governing Bound / Constraint | SSOT Basis |
| :--- | :--- | :--- | :--- | :--- |
| Power-Before-Pull RBF Sequence Gate | I_seqRBF | Boolean | 1 (RBF #2 ON and PBIT < 50.0 V before RBF #3 pull) | `EsadRbf3PowerBeforePullConstraint`, `GAP-06`, `REQ_SC_09` |
| Inertial & Safe-Separation Barriers | I_SS1, I_SS2 | Boolean | 1 (SS1 launch pulse and SS2 Safe Distance Exceed == 1) | `EsadSafeDistanceExceedConstraint`, `GAP-07`, `REQ_SC_11` |
| Hardware Discrete Arm Gate | I_DSC1 | Boolean | 1 (DSC_IN1 1000.0 Hz, 2 pulses at Arm Stage 2) | `PRM-ESAD-006` through `PRM-ESAD-009`, `REQ_SC_10` |
| Engagement Preconditions & EO Track | I_pre6, I_track | Boolean | 1 (6 preconditions pass and 2.0-5.0 s EO hold) | `EngagementSpeedAndTrackHoldConstraint`, `MET-03` |
| HITL Operator Consent Tokens | I_HITL_arm, I_HITL_atk | Boolean | 1 (`UCL-02` Payload Operator `Slide to confirm`) | `DoD Directive 3000.09 §4.1.a`, `SwarmC2OperatorConsole` |
| Sensor Board Initiation Input | I_IRQ | Boolean | 1 (ORed proximity/impact IRQ_L or OC Trigger) | `EsadSafeArmState`, `IF-ORD-004` |
| Emergency Scrub & Safing Gates | I_sd, I_pwroff, I_dwell, I_bleed, I_pin, I_revRBF | Boolean | 1 (>= 5.0 s SD, Power Off, >= 10.0 min dwell, 0.0 bar, pin, RBF #3 -> #2) | `REQ_SC_16`, `REQ_SAF_12`, `GAP-SCRUB`, `EMG-04` |
| Authorized / Total Transition Counts | N_compliant, N_total, N_unauth | count | N_unauth = 0 across all test/sortie trials | `TC_06`, `TC_08` |
| HITL Governance Compliance Rate | P_HITL | percent | 100.0 | `DoD Directive 3000.09 §4.1.a`, `MET-03`, `MET-04` |

---

### 3.3 Measures of Performance (`MoP-01` through `MoP-08`)

#### 3.3.1 `MoP-01`: `PL-40` Pneumatic Launch Exit Velocity & Kinematic Stall Margin (`V_exit`, `GAP-03`)

The `ELI Military Simulations PL-40 Rev 2.6` pneumatic rail catapult (`5.0 m` / `4938.0 mm` rail at `12.0 deg` elevation, `0` electrical/CAN wires to the UAV across `IF-MECH-001` / `CONN_23`) imparts an interpolated carriage exit velocity of `22.7-23.5 m/s` (`23.0 m/s` nominal) at `17.0 kg` MTOW and `13.0-14.0 bar` (`PRM-PL40-003` through `PRM-PL40-005`), bounded below the `25.0 m/s` structural rail ceiling (`PRM-PL40-002`; lighter loads at `15.0 kg` / `14.0 bar` reach `25.3 m/s` and violate the rail cap). Per `GAP-03` (`REQ_SAF_03`), because `22.7-23.5 m/s` sits below the `24.0 m/s` (`V2.5`) / `26.0 m/s` (`V1`) stall speed without wind or pusher thrust, pre-launch Go/No-Go gating (`OA-16`, `TC_07`) enforces `13.0-14.0 bar` pressure, `<= 12.0 m/s` ground headwind, active `AXI 5345/16` / `IBEX160` climb thrust, `> 14.5 V` Makita `BL1860B` UVLO health, and `>= 2.0 s` simultaneous dual-switch firing hold.

$$
\begin{aligned}
V_{\mathrm{exit,low}} &\le V_{\mathrm{exit}}\!\left(m_{\mathrm{UAV}}, P_{\mathrm{tank}}\right) \le V_{\mathrm{exit,high}} < V_{\mathrm{exit,max}} \\
m_{\mathrm{UAV}} &\le m_{\mathrm{rail,max}}, \qquad P_{\mathrm{tank}} \in \left[P_{\mathrm{min}}, \, P_{\mathrm{max}}\right], \qquad v_{\mathrm{wind,gnd}} \le v_{\mathrm{wind,gnd,max}} \\
V_{\mathrm{air,launch}} &= V_{\mathrm{exit}} + v_{\mathrm{headwind}} + \Delta V_{\mathrm{pusher}} \ge V_{\mathrm{stall,V25}}, \qquad V_{\mathrm{climb}} \ge V_{\mathrm{min,V1}} \\
V_{\mathrm{makita}} &> V_{\mathrm{UVLO,cut}}, \qquad \tau_{\mathrm{dual,sw}} \ge \tau_{\mathrm{dual,min}}, \qquad N_{\mathrm{wires,rail}} = 0
\end{aligned}
$$

#### Parameter Definitions & Engineering Units: `MoP-01` PL-40 Launch Velocity & Stall Margin

| Parameter | Symbol | Units | Governing Bound / Constraint | SSOT Basis |
| :--- | :--- | :--- | :--- | :--- |
| Interpolated 17.0 kg Exit Bounds | V_exit_low, V_exit_nom, V_exit_high | m/s | 22.7 low / 23.0 nom / 23.5 high at 13.0-14.0 bar | `PRM-PL40-003` through `PRM-PL40-005`, `GAP-03` |
| PL-40 Maximum Rated Exit Cap | V_exit_max | m/s | <= 25.0 (15.0 kg at 14.0 bar = 25.3 violates cap) | `PRM-PL40-002`, `PRM-PL40-046`, `Pl40MassAndExitVelocityConstraint` |
| Airframe MTOW / Rail Max MTOW | m_UAV, m_rail_max | kg | 17.0 <= 30.0 | `PRM-AF-008`, `PRM-PL40-001` |
| Launch Tank Pressure Envelope | P_min, P_max | bar | 13.0 to 14.0 (0.05 hysteresis; 16.0 aux max) | `PRM-PL40-027` through `PRM-PL40-031` |
| Ground Headwind Tolerance Max | v_wind_gnd_max | m/s | <= 12.0 | `PRM-PERF-016`, `Pl40MassAndExitVelocityConstraint` |
| Stall / Conservative Climb Floor | V_stall_V25, V_min_V1 | m/s | >= 24.0 V2.5 stall / >= 26.0 V1 climb transition | `PRM-PERF-004`, `PRM-PERF-005`, `UavFlightLifecycleState` |
| Pusher + Headwind Airspeed Gain | v_headwind, Delta V_pusher | m/s | Bridges 22.7-23.5 exit across >= 24.0/26.0 floor | `REQ_SAF_03`, `GAP-03`, `CommandPusherThrottleAndReadEscTelem` |
| Makita Compressor UVLO Cutoff | V_UVLO_cut | V | > 14.5 (>= 16.0 after 5.0 s wait to restart) | `PRM-PL40-034` through `PRM-PL40-036`, `Pl40UvloAndDualSwitchConstraint` |
| Dual-Switch Firing Hold Minimum | tau_dual_min | s | >= 2.0 simultaneous hold on both switches | `PRM-PL40-037`, `Pl40UvloAndDualSwitchConstraint` |
| PL-40 to UAV Electrical Wires | N_wires_rail | count | 0 (strictly mechanical IF-MECH-001) | `Pl40PneumaticLauncher`, `CONN_23`, `REQ_SC_13` |

#### 3.3.2 `MoP-02`: `12S2P` Main Power Bus & Pre-Flight Voltage Envelope (`V_bus`, `GAP-05`)

Primary electrical propulsion and avionics power derives from the removable `12S2P Li metal BEI maximus20` pack (`MainBatteryAndFuseUnit`, `GAP-05`), protected by a `200.0 A` automotive inline fuse (`IF-PWR-001`, `IF-PWR-002`) and switched by `UAV Power R.B.F. Key #2` (`XT60E-F`, `PowerMeterAndRbfSwitch`) onto the `IBEX160` ESC and `970.0 cm` trunk to `ElectronicPowerSystemEps`. Pre-flight BIT strictly requires `49.0-50.0 V` (`legacy24VUiRejected == true`) before launch, while in-flight bus voltage must stay within `36.0-50.4 V` (`MainBatteryPreFlightVoltageConstraint`, `TC_01`, `TC_02`).

$$
\begin{aligned}
V_{\mathrm{pre,min}} &\le V_{\mathrm{pack}}(t_0) \le V_{\mathrm{pre,max}} \\
V_{\mathrm{bus,min}} &\le V_{\mathrm{bus}}(t) \le V_{\mathrm{bus,max}}, \qquad \forall t \in \left[t_0, \, t_{\mathrm{end}}\right] \\
I_{\mathrm{bus}}(t) &\le I_{\mathrm{fuse,max}}, \qquad \Delta V_{\mathrm{trunk}}(t) = I_{\mathrm{EPS}}(t) \, R_{\mathrm{trunk}}\!\left(L_{\mathrm{trunk}}\right)
\end{aligned}
$$

#### Parameter Definitions & Engineering Units: `MoP-02` 12S2P Primary DC Power Bus

| Parameter | Symbol | Units | Governing Bound / Constraint | SSOT Basis |
| :--- | :--- | :--- | :--- | :--- |
| Pre-Flight Battery Pass Window | V_pre_min, V_pre_max | V | 49.0 to 50.0 (rejects legacy lower-V UI per GAP-05) | `PRM-AV-003`, `PRM-AV-004`, `MainBatteryPreFlightVoltageConstraint` |
| In-Flight 12S2P Bus Envelope | V_bus_min, V_bus_max | V | 36.0 to 50.4 (sag < 36.0 triggers RTL) | `PRM-AV-001`, `PRM-AV-002`, `MainBatteryAndFuseUnit` |
| Main Inline Automotive Fuse Rating | I_fuse_max | A | <= 200.0 overcurrent protection limit | `PRM-AV-005`, `REQ_SC_04` |
| Power & CAN 1 Trunk Harness Length | L_trunk | cm | 970.0 between Power Meter and EPS | `PRM-AV-012`, `PowerMeterAndRbfSwitch` |
| Regulated Servo / Radio EPS Rails | V_servo, V_radio | V | 8.0 servo / 12.0 radio (8.0-17.0 radio tolerance) | `PRM-AV-006` through `PRM-AV-009`, `ElectronicPowerSystemEps` |

#### 3.3.3 `MoP-03`: `EPS` to `Artron ESAD` `14.0 V` Rail Brownout Margin (`Delta V_brownout`, `GAP-01`)

Because `ElectronicPowerSystemEps` outputs `14.0 V` (`esad14VOut`, `PRM-AV-010`) whereas `ArtronEsadAndSensorUnit` specifies `14.0-32.0 V` (`28.0 V` ICD nominal, `14.0 V` minimum `VDC_IN`, `PRM-ESAD-001` through `PRM-ESAD-003`), the nominal voltage margin at the ESAD input interface is `0.0 V` (`GAP-01`, `EpsEsadZeroBrownoutMarginConstraint`, `FM-04-01` RPN `192`). Any harness drop (`I_ESAD * R_wire > 0.0 V`) or `970.0 cm` trunk transient sagging `V_ESAD,in < 14.0 V` triggers an immediate `CAN 1` brownout alert (`REQ_SAF_01`) and irreversible `Power Off ESAD` / `FaultLockout` (`TC_02`, `EMG-05`).

$$
\begin{aligned}
V_{\mathrm{ESAD,in}}(t) &= V_{\mathrm{EPS,esad}}(t) - I_{\mathrm{ESAD}}(t) \, R_{\mathrm{wire}} \\
\Delta V_{\mathrm{brownout}}(t) &= V_{\mathrm{ESAD,in}}(t) - V_{\mathrm{ESAD,min}} \ge 0 \\
\Delta V_{\mathrm{nom,GAP01}} &= V_{\mathrm{EPS,nom}} - V_{\mathrm{ESAD,min}}, \qquad V_{\mathrm{ESAD,min}} \le V_{\mathrm{ESAD,in}}(t) \le V_{\mathrm{ESAD,max}}
\end{aligned}
$$

#### Parameter Definitions & Engineering Units: `MoP-03` EPS-to-ESAD 14.0 V Brownout Margin

| Parameter | Symbol | Units | Governing Bound / Constraint | SSOT Basis |
| :--- | :--- | :--- | :--- | :--- |
| EPS Regulated ESAD Rail Output | V_EPS_nom | V | 14.0 nominal (`0.0` margin above ESAD min) | `PRM-AV-010`, `EpsEsadZeroBrownoutMarginConstraint` |
| ESAD Input Voltage Envelope | V_ESAD_min, V_ESAD_max | V | 14.0 min to 32.0 max (28.0 ICD nominal Objective) | `PRM-ESAD-001` through `PRM-ESAD-003`, `EsadInputVoltageAndBrownoutConstraint` |
| Instantaneous Brownout Margin | Delta V_brownout | V | >= 0.0 (nominal 0.0; < 0 triggers brownout fault) | `GAP-01`, `REQ_SAF_01`, `FM-04-01`, `TC_02` |
| Harness Ohmic Drop Term | I_ESAD * R_wire | V | Must not pull V_ESAD_in below 14.0 | `IF-PWR-009`, `CONN_06`, `ElectronicPowerSystemEps` |

#### 3.3.4 `MoP-04`: `RPI CM5` to `Artron ESAD` Cyclic `RS-485` Supervision Latency (`f_poll`, `tau_wd`, `GAP-04`)

`CompanionComputeRpiCm5` (`RPI CM5004032`) executes sole `OC Master` supervision over half-duplex differential `RS-485` (`115200 bps`, `8N1` `10 bits/byte`, `CRC-16 XModem` frame integrity, frame sizes `5` to `14` bytes) at `100.0 Hz` (`T_poll = 0.01 s = 10.0 ms`, resolving `GAP-04` vs `100 ms` ambiguous ICD text), enforcing `<= 5.0 ms` ESAD reply latency (`PRM-ESAD-020`) and `<= 10.0 ms` incomplete-packet / watchdog timeout (`PRM-ESAD-019`, `EsadRs485ProtocolTimingConstraint`, `REQ_SC_08`, `TC_04`, `TC_06`). Unprinted `EKF2`, `CAN 1/2`, and `Trip6` loop execution times remain anchored around this `0.01 s` horizon under `GAP-WCET` (`REQ_SAF_08`).

$$
\begin{aligned}
T_{\mathrm{poll}} &= \frac{1}{f_{\mathrm{poll}}}, \qquad \tau_{\mathrm{tx}}\!\left(L_{\mathrm{pkt}}\right) = \frac{B_{\mathrm{uart}} \, L_{\mathrm{pkt}}}{R_{\mathrm{baud}}} \\
\tau_{\mathrm{reply}} &\le \tau_{\mathrm{reply,max}} < \tau_{\mathrm{wd,max}} \le T_{\mathrm{poll}} \\
\left(\tau_{\mathrm{incomplete}}(t) > \tau_{\mathrm{wd,max}}\right) &\lor \left(\mathrm{CRC}_{\mathrm{err}} = 1\right) \implies \mathrm{Fault}_{\mathrm{ESAD}} = 1
\end{aligned}
$$

#### Parameter Definitions & Engineering Units: `MoP-04` ESAD RS-485 Cyclic Supervision Timing

| Parameter | Symbol | Units | Governing Bound / Constraint | SSOT Basis |
| :--- | :--- | :--- | :--- | :--- |
| OC Master RS-485 Poll Frequency | f_poll | Hz | 100.0 exact (`GAP-04` resolution) | `PRM-ESAD-017`, `EsadRs485ProtocolTimingConstraint` |
| Cyclic Supervision Period | T_poll | s | 0.01 (10.0 ms equivalent cycle) | `PRM-ESAD-018`, `CompanionComputeRpiCm5` |
| RS-485 Line Baud Rate | R_baud | bps | 115200 (`8N1` 10 bits/byte framing) | `PRM-ESAD-014` through `PRM-ESAD-016` |
| Frame Length Bounds | L_pkt | bytes | 5 min to 14 max (0 to 9 data payload bytes) | `PRM-ESAD-021` through `PRM-ESAD-028` |
| ESAD Command-to-Reply Latency | tau_reply_max | ms | <= 5.0 max reply turnaround | `PRM-ESAD-020`, `REQ_SC_08` |
| Incomplete-Packet / Watchdog Ceiling | tau_wd_max | ms | <= 10.0 timeout triggers fault / safe disarm | `PRM-ESAD-019`, `EMG-05`, `TC_04`, `TC_06` |

#### 3.3.5 `MoP-05`: `Artron ESAD` PBIT Safe HV Ceiling & `STANAG 4187` Barrier Gating (`V_PBIT`, `R_UMB`, `V_J401`)

`ArtronEsadAndSensorUnit` (`AB00-0054-01AA-0005`, `NATO STANAG 4187 Ed. 5`, `MIL-STD-331D`, `MIL-STD-461G`) requires pre-flight PBIT internal high voltage strictly `< 50.0 V` (`PRM-ESAD-029`, `WarheadMassAndPbitHvSafetyConstraint`), `RBF #3` (`J100` `UMB`) loop resistance `< 0.5 Ohm` at `20.0 mA` sense current (`PRM-ESAD-004`, `PRM-ESAD-005`) retained until `RBF #2` ON (`GAP-06`), dual physical barriers `SS1` (inertial launch acceleration) and `SS2` (`Safe Distance Exceed == 1`, `GAP-07`), and `Arm Stage 2` `DSC_IN1` hardware pulse gating (`1000.0 Hz`, `1.0 ms` period, `50.0%` duty, `2` pulses, `0.0-0.7 V` low / `2.5-3.3 V` high) before charging `J401` across `0.0-1800.0 V` (`1.0 V/LSB`) into the `<= 5.0 kg` warhead (`4.98 +/- 0.02 kg` tested holder, `REQ_SC_09` through `REQ_SC_11`, `TC_06`).

$$
\begin{aligned}
V_{\mathrm{PBIT}} &< V_{\mathrm{PBIT,safe}}, \qquad R_{\mathrm{UMB}} = \frac{V_{\mathrm{UMB}}}{I_{\mathrm{sense}}} < R_{\mathrm{UMB,max}} \\
f_{\mathrm{DSC1}} &= \frac{1}{T_{\mathrm{DSC1}}}, \qquad N_{\mathrm{DSC1}} = 2, \qquad V_{\mathrm{DSC1,low}} \le V_{\mathrm{low,max}}, \qquad V_{\mathrm{DSC1,high}} \in \left[V_{\mathrm{high,min}}, \, V_{\mathrm{high,max}}\right] \\
V_{\mathrm{J401}}(t) &= \begin{cases}
0 & \text{if } \neg\!\left(I_{\mathrm{SS1}} \land I_{\mathrm{SS2}} \land I_{\mathrm{DSC1}} \land I_{\mathrm{OC,arm}}\right) \\
V_{\mathrm{cap}}(t) \in \left[V_{\mathrm{HV,min}}, \, V_{\mathrm{HV,max}}\right] & \text{if } I_{\mathrm{SS1}} \land I_{\mathrm{SS2}} \land I_{\mathrm{DSC1}} \land I_{\mathrm{OC,arm}}
\end{cases} \\
m_{\mathrm{warhead}} &\le m_{\mathrm{warhead,max}}, \qquad m_{\mathrm{holder}} = m_{\mathrm{nom}} \pm \delta m_{\mathrm{tol}}
\end{aligned}
$$

#### Parameter Definitions & Engineering Units: `MoP-05` Artron ESAD PBIT HV & STANAG 4187 Barriers

| Parameter | Symbol | Units | Governing Bound / Constraint | SSOT Basis |
| :--- | :--- | :--- | :--- | :--- |
| PBIT Safe Internal HV Ceiling | V_PBIT_safe | V | < 50.0 (>= 50.0 latches FaultLockout) | `PRM-ESAD-029`, `WarheadMassAndPbitHvSafetyConstraint` |
| RBF #3 UMB Loop Resistance | R_UMB_max | Ohm | < 0.5 at 20.0 mA (`GAP-06` power-before-pull) | `PRM-ESAD-004`, `PRM-ESAD-005`, `EsadRbf3PowerBeforePullConstraint` |
| DSC_IN1 Hardware Arm Pulse Rate | f_DSC1, T_DSC1, N_DSC1 | Hz | 1000.0 (1.0 ms period, 50.0% duty, 2 pulses) | `PRM-ESAD-006` through `PRM-ESAD-009`, `REQ_SC_10` |
| DSC_IN1 Logic Voltage Levels | V_low_max, V_high_min, V_high_max | V | 0.0-0.7 low / 2.5-3.3 high | `PRM-ESAD-010` through `PRM-ESAD-012` |
| J401 High-Voltage Fire Envelope | V_HV_min, V_HV_max | V | 0.0 to 1800.0 (`1.0 V/LSB`; 0.0 pre-arm) | `PRM-ESAD-030` through `PRM-ESAD-032`, `REQ_SC_11` |
| Warhead & Tested Holder Mass | m_warhead_max, m_nom, delta m_tol | kg | <= 5.0 max (4.98 +/- 0.02 tested holder) | `PRM-AF-009` through `PRM-AF-011`, `WarheadMassAndPbitHvSafetyConstraint` |
| Dual Barrier & Arm Enable Flags | I_SS1, I_SS2, I_DSC1, I_OC_arm | Boolean | All 4 = 1 required before J401 charge (`GAP-07`) | `EsadSafeDistanceExceedConstraint`, `TC_06` |

#### 3.3.6 `MoP-06`: `EO/IR` Seeker Daylight Target Track Hold Window (`tau_track`)

Terminal seeker lock (`EoIrSeekerAndTrackerUnit`: `Nighthawk2UZ` 2-axis gimbal at `1280x720` Day/Thermal resolution with `40.0` zoom and `Trip6` tracker compute) requires `2.0-5.0 s` continuous daylight target tracking hold prior to engagement (`PRM-GCS-011`, `PRM-GCS-012`, `EngagementSpeedAndTrackHoldConstraint`) with target elevation `<= 15.0 deg` at engagement initiation (`PRM-PERF-014`) inside gimbal travel limits (`-45.0` to `+135.0 deg` pitch, `-165.0` to `+165.0 deg` yaw/roll, `PRM-AV-022` through `PRM-AV-025`). Loss of track or video freeze (`IF-VID-001`, `IF-ETH-001`) aborts diving without autonomous re-track and permits in-flight `Reboot Gimbal` (`OA-14`, `EMG-08`, `TC_05`).

$$
\begin{aligned}
\tau_{\mathrm{hold,min}} &\le \tau_{\mathrm{track}}(t) \le \tau_{\mathrm{hold,max}}, \qquad \theta_{\mathrm{elev}} \le \theta_{\mathrm{elev,max}} \\
\theta_{\mathrm{pitch}} &\in \left[\theta_{\mathrm{pitch,min}}, \, \theta_{\mathrm{pitch,max}}\right], \qquad \psi_{\mathrm{yaw}} \in \left[\psi_{\mathrm{min}}, \, \psi_{\mathrm{max}}\right] \\
N_{\mathrm{px}} &= W_{\mathrm{px}} \, H_{\mathrm{px}}, \qquad Z_{\mathrm{opt}} \le Z_{\mathrm{max}}
\end{aligned}
$$

#### Parameter Definitions & Engineering Units: `MoP-06` EO/IR Seeker Target Track Stabilization

| Parameter | Symbol | Units | Governing Bound / Constraint | SSOT Basis |
| :--- | :--- | :--- | :--- | :--- |
| Daylight Target Track Hold Window | tau_hold_min, tau_hold_max | s | 2.0 minimum Threshold; 2.0 to 5.0 stabilized window | `PRM-GCS-011`, `PRM-GCS-012`, `EngagementSpeedAndTrackHoldConstraint` |
| Max Initial Target Elevation | theta_elev_max | deg | <= 15.0 at terminal engagement start | `PRM-PERF-014`, `EoIrSeekerAndTrackerUnit` |
| Gimbal Pitch Travel Envelope | theta_pitch_min, theta_pitch_max | deg | -45.0 to +135.0 | `PRM-AV-022`, `PRM-AV-023` |
| Gimbal Yaw / Roll Travel Envelope | psi_min, psi_max | deg | -165.0 to +165.0 | `PRM-AV-024`, `PRM-AV-025` |
| Day & Thermal Sensor Dimensions | W_px, H_px | px | 1280 horizontal by 720 vertical | `PRM-AV-019`, `PRM-AV-020` |
| Seeker Combined Zoom Capability | Z_max | zoom | 40.0 (`Nighthawk2UZ` X40) | `PRM-AV-021`, `EoIrSeekerAndTrackerUnit` |

#### 3.3.7 `MoP-07`: Software Simplex RTA Airspeed Envelope & Terminal Dive Cap (`V_air`, `GAP-02`)

Reconciling `V1` User Manual and `V2.5` Spec Sheet airspeed bounds (`GAP-02`, `REQ_SAF_02`), the software-hosted `ASTM F3269-17` Simplex RTA supervisor inside `FlightControllerCubeOrangePlus` (`standaloneRtaBoxCount == 0`, `rtaHostedOnCubeOrangePlus == true`, `SimplexRtaSoftwareHostingConstraint`) enforces the monotonic speed hierarchy from `24.0 m/s` (`V2.5` stall) / `26.0 m/s` (`V1` climb minimum) through `30.0-31.0 m/s` cruise and `38.0-42.0 m/s` max horizontal speed up to the `<= 55.0 m/s` terminal engagement speed cap (`Abort Engaging` override preventing `Nighthawk2UZ` gimbal saturation) and `<= 80.0 m/s` structural `VNE` (`FlightEnvelopeSpeedConstraint`, `TC_03`, `TC_05`).

$$
\begin{aligned}
V_{\mathrm{stall,V25}} &\le V_{\mathrm{min,V1}} < V_{\mathrm{cruise,V1}} < V_{\mathrm{cruise,V25}} < V_{\mathrm{horiz,V1}} < V_{\mathrm{horiz,V25}} < V_{\mathrm{engage,cap}} < V_{\mathrm{NE}} \\
V_{\mathrm{air}}(t) &\in \left[V_{\mathrm{stall,V25}}, \, V_{\mathrm{NE}}\right], \qquad q_{\mathrm{engage}}(t) = 1 \implies V_{\mathrm{air}}(t) \le V_{\mathrm{engage,cap}} \\
\left(V_{\mathrm{air}}(t) > V_{\mathrm{engage,cap}}\right) &\land \left(q_{\mathrm{engage}}(t) = 1\right) \implies u_{\mathrm{RTA}}(t) = \mathrm{AbortEngaging} \\
N_{\mathrm{RTA,box}} &= 0, \qquad q_{\mathrm{RTA,Cube}} = 1
\end{aligned}
$$

#### Parameter Definitions & Engineering Units: `MoP-07` Software Simplex RTA Airspeed Envelope

| Parameter | Symbol | Units | Governing Bound / Constraint | SSOT Basis |
| :--- | :--- | :--- | :--- | :--- |
| Stall / Conservative Min Airspeed | V_stall_V25, V_min_V1 | m/s | 24.0 V2.5 stall / 26.0 V1 conservative floor | `PRM-PERF-004`, `PRM-PERF-005`, `GAP-02` |
| Nominal Cruise Airspeed | V_cruise_V1, V_cruise_V25 | m/s | 30.0 V1 / 31.0 V2.5 | `PRM-PERF-006`, `PRM-PERF-007` |
| Max Horizontal Airspeed | V_horiz_V1, V_horiz_V25 | m/s | 38.0 V1 / 42.0 V2.5 | `PRM-PERF-008`, `PRM-PERF-009` |
| Terminal Engagement Speed Cap | V_engage_cap | m/s | <= 55.0 (triggers Abort Engaging climb-out) | `PRM-PERF-010`, `EngagementSpeedAndTrackHoldConstraint` |
| Structural Never-Exceed Speed (VNE) | V_NE | m/s | <= 80.0 hard airframe limit | `PRM-PERF-011`, `FlightEnvelopeSpeedConstraint` |
| Standalone RTA Hardware Box Count | N_RTA_box | count | 0 (zero external RTA hardware enclosures) | `SimplexRtaSoftwareHostingConstraint`, `CTL-01` |
| Software RTA Host Verification | q_RTA_Cube | Boolean | 1 (hosted strictly inside Cube orange+) | `SimplexRtaSoftwareHostingConstraint`, `REQ_SC_05` |

#### 3.3.8 `MoP-08`: `GCS Failsafe` Lost-Link, HITL Abort Hold & `SAFE_SCRUB_ABORT` Dwell (`tau_gcs_fs`, `tau_sd_min`, `tau_scrub_dwell`)

System termination and contingency timeliness combines three deterministic timers: (1) `105.0 s` `GCS Failsafe` lost-link autonomous `RTL` and `Disarm ESAD On GCS Timeout` (`PRM-GCS-008`, bounded against the `2.0 min` / `120.0 s` pre-flight telemetry detect ceiling `PRM-GCS-002`, `PaceC2LinkState`, `EMG-01`); (2) `>= 5.0 s` continuous HITL `SELF DESTRUCT` / permanent `ABORT` button hold prior to `Slide to confirm` (`PRM-GCS-010`, `CommandEsadAbortAndSelfDestruct`, `EMG-07`); and (3) `>= 10.0 min` derived `SAFE_SCRUB_ABORT` hangfire crew holdback dwell in the rear `SAFETY AREA` (`GAP-SCRUB`, `REQ_SC_16`, `REQ_SAF_12`, `EMG-04`) prior to `Main Valve 4` close, `0.0 bar` bleed, red pin restore, and `RBF #3` before `RBF #2` safing (`TC_04`, `TC_08`).

$$
\begin{aligned}
\Delta t_{\mathrm{C2,loss}}(t) &= t - t_{\mathrm{last,rx}} \ge \tau_{\mathrm{gcs,fs}} \implies \mathrm{EnterRTL}(t) \land \mathrm{DisarmESAD}(t) \\
\Delta t_{\mathrm{boot,rx}} &\le \tau_{\mathrm{telem,init}}, \qquad r_{\mathrm{loiter}} \ge r_{\mathrm{loiter,min}}, \qquad h_{\mathrm{wp}} \in \left[h_{\mathrm{mission,min}}, \, h_{\mathrm{mission,max}}\right] \\
\tau_{\mathrm{hold,abort}}(t) &\ge \tau_{\mathrm{sd,min}} \land q_{\mathrm{slide}} = 1 \implies \mathrm{ExecuteAbortOrSD}(t) \\
\tau_{\mathrm{holdback,crew}} &\ge \tau_{\mathrm{scrub,dwell}} \land P_{\mathrm{tank}} = 0 \land q_{\mathrm{pin}} = 1 \land q_{\mathrm{RBF3}} = 1 \implies \mathrm{CrewApproachAllowed}
\end{aligned}
$$

#### Parameter Definitions & Engineering Units: `MoP-08` GCS Failsafe, HITL Abort & Scrub Timers

| Parameter | Symbol | Units | Governing Bound / Constraint | SSOT Basis |
| :--- | :--- | :--- | :--- | :--- |
| GCS Failsafe Lost-Link Timeout | tau_gcs_fs | s | 105.0 baseline (`RTL` + `Disarm ESAD`) | `PRM-GCS-008`, `SwarmC2OperatorConsole`, `EMG-01` |
| Pre-Flight Telemetry Detect Timeout | tau_telem_init | min | <= 2.0 (120.0 s maximum wait on RBF #2 pull) | `PRM-GCS-002`, `SwarmC2OperatorConsole` |
| Minimum CW Loiter Orbit Radius | r_loiter_min | m | >= 300.0 (after Abort Engaging climb-out) | `PRM-GCS-007`, `SwarmC2AuthAndMissionBoundsConstraint` |
| Waypoint Altitude Slider Band | h_mission_min, h_mission_max | m | 50.0 to 3000.0 (250.0 slider graduation) | `PRM-GCS-004` through `PRM-GCS-006` |
| HITL ESAD Self-Destruct / Abort Hold | tau_sd_min | s | >= 5.0 continuous hold + `Slide to confirm` | `PRM-GCS-010`, `CommandEsadAbortAndSelfDestruct`, `MET-03` |
| Derived Hangfire Scrub Holdback Dwell | tau_scrub_dwell | min | >= 10.0 (`GAP-SCRUB`; OEM hangfire timer unprinted) | `REQ_SAF_12`, `REQ_SC_16`, `MET-04`, `EMG-04` |
| Post-Bleed PL-40 Tank Pressure | P_tank | bar | 0.0 verified before forward crew entry | `Pl40LauncherState`, `REQ_SC_16`, `TC_08` |
| Red Pin & Reverse RBF #3 Restoration | q_pin, q_RBF3 | Boolean | 1 (red pin restored and RBF #3 before RBF #2) | `REQ_SC_16`, `MET-04`, `TC_08` |

---

### 3.4 Verification Mapping & Engineering Gap Reconciliation

All `13` primary INCOSE metrics (`MoE-01` through `MoE-05` and `MoP-01` through `MoP-08`) trace directly to the `8` native SysML v2 verification test cases (`TC_01` through `TC_08`), the `19` operational activities (`OA-01` through `OA-19`), and the `12` OEM engineering gap dispositions (`GAP-01` through `GAP-07`, `GAP-WCET`, `GAP-REL`, `GAP-SEPDIST`, `GAP-ENV`, `GAP-SCRUB`) cataloged in `schema/extracted/parametric_limits.md` and `docs/research/RESEARCH_INVENTORY.md`.

#### Table 3.2: Cross-Metric Verification Gate & Gap Closure Matrix

| Metric IDs | Primary Operational Activities (`OA-*`) | Linked `REQ_*` Safety & Gap IDs | Authoritative Verification Gates | Governing Engineering Gap Dispositions |
| :--- | :--- | :--- | :--- | :--- |
| `MoE-01`, `MoP-06`, `MoP-07` | `OA-05`, `OA-09`, `OA-13`, `OA-14` | `REQ_SC_05`, `REQ_SC_06`, `REQ_SC_12`, `REQ_SAF_02`, `REQ_SAF_08` | `TC_03_SimplexRtaEnvelopeAndActuation`, `TC_05_EoIrTargetTrackAndSpeedCapAbort` | `GAP-02` (`55.0 m/s` cap vs `80.0 m/s` `VNE`); `GAP-WCET` (`Cube orange+` / `CAN 1` / `CAN 2` / `Trip6`) |
| `MoE-02`, `MoP-02`, `MoP-03` | `OA-01`, `OA-02`, `OA-03`, `OA-04` | `REQ_SC_01`, `REQ_SC_02`, `REQ_SC_03`, `REQ_SC_04`, `REQ_SAF_01`, `REQ_SAF_05`, `REQ_SAF_11` | `TC_01_PreflightPowerAndRbfSequence`, `TC_02_BingoReserveAndEpsBrownoutMonitor` | `GAP-01` (`14.0 V` ESAD `0.0 V` margin); `GAP-05` (`12S2P` `49.0-50.0 V` check); `GAP-ENV` (`Wh`/`Ah`, `SoC` floor) |
| `MoE-03`, `MoE-04`, `MoP-08` | `OA-05`, `OA-07`, `OA-12`, `OA-17`, `OA-18`, `OA-19` | `REQ_SC_07`, `REQ_SC_15`, `REQ_SC_16`, `REQ_SAF_10`, `REQ_SAF_11`, `REQ_SAF_12` | `TC_04_GnssDeniedDrAndPaceLinkFailsafe`, `TC_08_EmergencyScrubHangfireAndC2Auth` | `GAP-02` (`60.0/90.0 km` RLOS); `GAP-SEPDIST` / `GAP-ENV` (`gamma_glide`, `Delta r_nav`); `GAP-SCRUB` (`10.0 min` dwell) |
| `MoE-05`, `MoP-04`, `MoP-05` | `OA-08`, `OA-10`, `OA-11`, `OA-12` | `REQ_SC_08`, `REQ_SC_09`, `REQ_SC_10`, `REQ_SC_11`, `REQ_SAF_04`, `REQ_SAF_06`, `REQ_SAF_07`, `REQ_SAF_09` | `TC_01_PreflightPowerAndRbfSequence`, `TC_06_EsadProtocolInterlockAndHvFireGate` | `GAP-04` (`100.0 Hz` / `10.0 ms` ESAD cycle); `GAP-06` (`RBF #2` before `RBF #3`); `GAP-07` (`Safe Distance Exceed == 1`); `GAP-REL` |
| `MoP-01` | `OA-15`, `OA-16`, `OA-17` | `REQ_SC_13`, `REQ_SC_14`, `REQ_SAF_03` | `TC_07_Pl40RailChargeLaunchAndZeroWire` | `GAP-03` (`22.7-23.5 m/s` exit vs `24.0/26.0 m/s` stall & `25.0 m/s` rail cap; `0` UAV wires) |

---

/// OperationalAllocation: [OA-01]
/// OperationalAllocation: [OA-02]
/// OperationalAllocation: [OA-03]
/// OperationalAllocation: [OA-04]
/// OperationalAllocation: [OA-05]
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
