# Avenger 5 + PL-40 + ESAD Cross-Document Reconciliations and Engineering Gaps Ledger

This ledger synthesizes discrepancies, tight interface margins, and unstated OEM quantitative assurance figures identified across all 6 customer PDFs in `docs/reference/` so downstream `schema/avenger5_uas/*.sysml` specifications represent grounded hardware limits faithfully while bounding unstated figures explicitly.

---

## 1. Cross-Document Interface Tight Margins and Discrepancies

| Gap / Conflict ID | Finding Across OEM Documents | Citations | Engineering Disposition for `schema/avenger5_uas/` |
| :--- | :--- | :--- | :--- |
| `GAP-01` (Voltage Rail Margin) | `Avenger5_V2.5_block_diagram_rev5.pdf` specifies `EPS -> ESAD power 14 V`, whereas `ESAD ICD` Table 4 defines `GE_POW` Min = `14 V`, Nominal = `28 V`, Max = `32 V`. Zero brownout margin exists under cable drop (`I * R`) | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]`, `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` | Model explicit `CrossRingBoundary` & `SignalContract` for `ESAD power` (`min 14.0 V`, `nom 14.0-28.0 V`, `max 32.0 V`) and flag zero brownout margin on `14 V` EPS output as STPA Loss Scenario + FMECA requirement |
| `GAP-02` (V1 vs V2.5 Flight Envelope) | `A5-user-manual 2.pdf` (V1) cites `26-38 m/s` horizontal, `55 m/s` max dive, `30 m/s` cruise, `60/180 km` RLOS; `AVENGER 5 Spec sheet_rev3.pdf` / `V2.5` cites `24 m/s` stall, `31 m/s` cruise, `42 m/s` max horizontal, `80 m/s` dive, `60/90 km` RLOS | `[A5-user-manual 2.pdf#p10]`, `[AVENGER 5 Spec sheet_rev3.pdf#p3]` | Adopt conservative inner structural/control envelope (`stall 24-26 m/s`, `cruise 30-31 m/s`, `max horz 38-42 m/s`, `dive cap 55 m/s` per EO seeker tracking limit `[#p88]`, airframe structural max `80 m/s`) |
| `GAP-03` (PL-40 vs Stall Margin at 17 kg) | Avenger 5 `MTOW = 17 kg`; `SwarmC2` catapult checklist specifies `13-14 bar`. On `PL-40` Table 2, `13-14 bar` yields `24.3-25.3 m/s` at `15 kg` and `21.1-21.9 m/s` at `20 kg` (~`23 m/s` at `17 kg`), which is below `24-26 m/s` stall speed without headwind + electric thruster contribution and exceeds `25 m/s` launcher rating below `15 kg` | `[A5-user-manual 2.pdf#p54]`, `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]`, `[AVENGER 5 Spec sheet_rev3.pdf#p3]` | Encode strict launch Go/No-Go gate linking pusher propulsion state, `13-14 bar` pressure check, headwind component (`<= 12 m/s` ground wind), and `<= 25 m/s` carriage speed limit |
| `GAP-04` (ESAD Platform Naming & Bus Bridge) | `ESAD ICD` is titled `Avenger 3` (`28 V` nom, `RS-485` `115200 bps`, `CRC-16 XModem`), while `Avenger V2.5` diagram shows `14 V` supply, `RPI CM5004032` -> `ESAD` `RS-485` + `GPIO`, and `ESAD R.B.F. Key` directly on `ESAD` | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p1]`, `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` | Model `RPI CM5004032 <-> ESAD` as `Ring2 -> Ring3` supervised interface bridging IP/MAVLink/SwarmC2 to `100 Hz` `RS-485` `CRC-16 XModem`, plus hardware discrete `DSC_IN1` (`1 kHz 2-pulse PWM`) & `UMB` interlock |
| `GAP-05` (`OBS` Camera Mode & 23.9V/25V vs 49V Screenshots) | `A5-user-manual 2.pdf` contradicts itself on `OBS` joystick control (`p79` vs `p81`), and shows `23.9 V` / `25.0 V` UI screenshots alongside normative `49-50 V` (`12S2P`) battery voltage text (`p56`) | `[A5-user-manual 2.pdf#p56]`, `[#p79]`, `[#p81]` | Anchor electrical models strictly to normative `12S2P` `36-50.4 V` (`49-50 V` launch pre-arm) and treat `24-25 V` screenshots as legacy/6S UI artifacts |
| `GAP-06` (ESAD Power-On Sequence Interlock) | `A5_prep and safety_rev7.pdf#p23` warns removing `ESAD R.B.F. #3` BEFORE `UAV + ESAD` power-up triggers an **immediate ESAD fault**, requiring power-up via `Power R.B.F. #2` first | `[A5_prep and safety_rev7.pdf#p21]`, `[#p23]` | Formalize strict ordered lifecycle state machine + STPA Unsafe Control Action for out-of-order RBF removal |
| `GAP-07` (`ESAD` vs `SwarmC2` Safe Distance Logic) | `A5-user-manual 2.pdf#p84` states `ARM STAGE 2` occurs when airborne "within safe distance from launch point", whereas `ESAD ICD#p21,#p23` uses `Safe Distance Exceed` / `SS2 Active` | `[A5-user-manual 2.pdf#p84]`, `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p21]` | Clarify wording: physical arming requires **exceeding** minimum safe separation distance/flight-timer from launch point (`Safe Distance Exceed == 1`) |

---

## 2. Explicit Missing OEM Quantitative Assurance & Timing Figures

The following engineering parameters required for `DO-178C` / `JARUS SORA` / `MIL-STD-882E` / `deap03` verification are NOT published in the 6 customer OEM PDFs and are explicitly tracked as OEM Baseline Gaps:

1. **Real-Time Control Loop Frequencies & WCET Budgets**:
   - Missing OEM values: `Cube orange+` EKF2/attitude/control-surface update rate, `DroneCAN` (`CAN 1` / `CAN 2`) bitrates (`Mbps`), `HV6160-DroneCAN` servo command/feedback rate, `Septentrio Asterx-m3 pro` GNSS solution rate, `Trip6` tracking latency, `RPI CM5004032` Linux jitter/WCET, and `SwarmC2` tablet link round-trip latency. Only `ESAD RS-485` specifies `100 Hz` polling / `5 ms` reply / `10 ms` frame timeout `[ESAD ICD#p15]`.
   - Engineering Disposition: Annotate grounded `100 Hz` ESAD polling rate (`0.01 s`) and mark flight-control RMA/WCET parameters explicitly as mission-contract targets awaiting OEM bench measurement.
2. **Component Failure Rates (`lambda`), MTBF & Hardware Reliability**:
   - Missing OEM values: Piece-part failure rates for `Cube orange+`, `IBEX160`, `AXI 5345/16`, `HV6160-DroneCAN`, `mRo RM3100`, `CUAV SKYE2`, `maximus20 12S2P`, `DTC 4.4-5 GHz`, `Trip6`, `Nighthawk2UZ`, and `ESAD` FPGA/CPLD.
   - Engineering Disposition: Parameterize FMECA/FTA gates using conservative catalog baselines from `docs/catalogs/FMECA_COMPONENT_CLASS_ROSTER_CATALOG.md` and cite OEM datasheet gap.
3. **ESAD Safe-Separation Numerical Thresholds & Connector Pinout CAD**:
   - Missing OEM values: Numeric safe-separation distance (`m`), launch-acceleration threshold (`g`), arming timer (`s`), and `3x M3` (`75 mm` BCD from PCB outline) / torque values (and `A5` `M6 x 30 mm` wing bolt torque / `4980 g` holder datum unit confirmation).
   - Engineering Disposition: Declare parameterized constraints in `schema/avenger5_uas/` requiring calibration sign-off before field arming.
4. **Power, Thermal & Environmental Missing Envelope Limits**:
   - Missing OEM values: Battery pack energy (`Wh` / `Ah`), minimum battery voltage / SoC RTL threshold, `ESC` / `Motor` continuous current & thermal shutoff limits, `PL-40` tank internal volume (`L`), safety relief cracking pressure (`bar`), IP water-ingress rating, rain/icing limits, and numeric catapult/warhead safe standoff distance (`m`).
5. **Emergency Scrub, Hangfire & Post-Flight De-Arm Procedures**:
   - Missing OEM values: Neither `A5_prep and safety_rev7.pdf`, `A5-user-manual 2.pdf`, nor `UAV_launcher_PL-40_user_manual_rev_2.6.pdf` specifies an abort/unload sequence once `ESAD R.B.F. #3` is removed, `PL-40` main outlet valve `(4)` is open, or carriage pin is pulled, nor a hangfire waiting time `[PL-40#p26]`, `[A5_prep#p23]`.
   - Engineering Disposition: Explicitly model `SAFE_SCRUB_ABORT` as a dedicated Use Case, Safety Constraint, and Emergency Rule in `schema/avenger5_uas/`!
