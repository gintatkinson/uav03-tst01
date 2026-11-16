# Avenger 5 Preparation, Safety Rules, SwarmC2 Operations, and Failsafes (Extracted Baseline)

Source Documents:
- `docs/reference/A5_prep and safety_rev7.pdf` (25 pp.)
- `docs/reference/A5-user-manual 2.pdf` (`UDS-A5UM-001`, Model `AVENGER 5 V1`, dated `2026-08-07`, 96 pp.)

---

## 1. End-to-End Preparation Sequence and Hardware Interlocks (`A5_prep and safety_rev7.pdf`)

| Step | Activity | Quantitative / Hardware Constraints & Interlocks | Citation |
| :--- | :--- | :--- | :--- |
| 0 | Training & Manual Gate | Operators must read all related manuals (`A5 User Manual`, `PL-40`, `Warhead`, `ESAD`, `SwarmC2`) and hold authorization before handling | `[A5_prep and safety_rev7.pdf#p2]` |
| 1 | Catapult Preparation | Assemble `PL-40`, verify all fasteners/locks tight, set specified launch pressure (`13-14 bar` per User Manual) | `[A5_prep and safety_rev7.pdf#p5]`, `[A5-user-manual 2.pdf#p54]` |
| 2 | GCS Setup | Erect antenna/rotator, connect/power rugged tablets (`SwarmC2`), calibrate antenna rotator BEFORE touching UAV | `[A5_prep and safety_rev7.pdf#p6]` |
| 3 | ESD Equalization | Touch yellow `EARTH / GROUNDING POINT` inside transport box BEFORE every component handling step | `[A5_prep and safety_rev7.pdf#p7]`, `[A5_prep and safety_rev7.pdf#p9]` |
| 4 | Payload & ESAD Mounting | Connect payload cables to ESAD via `1.5 mm HEX` terminals; align `RED FACE TO TOUCH HOLDER`; CTQ `4980 +/- 20 g`, CG CTQ `30.57 +/- 1.00`, overall `173.00` (unit unprinted); lock hatch | `[A5_prep and safety_rev7.pdf#p9]`-`[p11]` |
| 5 | Battery Installation | Inspect for damage/swelling/leakage (NO-GO if abnormal); confirm full charge; match Battery ID & QR to fuselage ID & QR; pre-connect strap buckle; mate connector & lock ring without sharp cable bends; lock hatch | `[A5_prep and safety_rev7.pdf#p12]`-`[p14]` |
| 6 | Lift & Catapult Seating | Keep RBF pin installed; `2 persons` required to lift airframe without stressing wings/control surfaces; seat in `PL-40` carriage | `[A5_prep and safety_rev7.pdf#p15]`-`[p16]` |
| 7 | Wing & Tail Assembly | Rotate wings (hinged on rear bolt); route RF cable smoothly (no pinching); install 4 front `M6 x 30 mm` bolts and tighten all 8 wing bolts (`10 mm` spanner); slide 4 identical X-tail stabilisers over control horns and finger-tighten captive screws | `[A5_prep and safety_rev7.pdf#p17]`-`[p18]` |
| 8 | Prop & Front RBF #1 | Verify BOTH folding pusher prop blades fold rearward toward tail before power-up (`WARNNING`: collision hazard with trolley); remove pitot cover, sensor cover, and gimbal strap (`RBF #1`) | `[A5_prep and safety_rev7.pdf#p19]`-`[p20]` |
| 9 | Power RBF #2 Removal | Support airframe; pull `UAV POWER R.B.F.` (`XT60E-F` connector housing); close & lock BOTH RBF and umbilical lids; auto power-on & GCS link start | `[A5_prep and safety_rev7.pdf#p21]` |
| 10 | Pre-Flight Diagnostics | Complete all 6 `SwarmC2` checklist groups (`Catapult`, `Mission & parameters`, `Preparation & mounting`, `System checks`, `Video Checks`, `Warhead and Safety`) | `[A5_prep and safety_rev7.pdf#p22]`, `[A5-user-manual 2.pdf#p53]`-`[p57]` |
| 11 | Warhead ESAD RBF #3 Gate | **DO NOT REMOVE BEFORE POWER-ON** (triggers immediate ESAD fault); remove ONLY on `SwarmC2` prompt after ALL 8 preconditions pass; wait for `ESAD: Ready to Fly` | `[A5_prep and safety_rev7.pdf#p23]` |
| 12 | Launch Execution | Clear all personnel to designated safe distance (`PL-40` rear safety area); verify launch corridor clear; perform final arming & dual-switch trigger launch | `[A5_prep and safety_rev7.pdf#p24]`, `[A5-user-manual 2.pdf#p58]` |

---

## 2. SwarmC2 Pre-Flight Checklist Thresholds and Radio/Sensor Checks (`A5-user-manual 2.pdf`)

| Check / Parameter | Nominal Specification / Pass Criterion | Units / Condition | Citation |
| :--- | :--- | :--- | :--- |
| GCS Telemetry Detection | Within `2` min of UAV power-on | min | `[A5-user-manual 2.pdf#p52]` |
| Ground Radio Separation | Keep UAV >= `10` m from ground radio module during ground prep | m | `[A5-user-manual 2.pdf#p52]` |
| Catapult Gauge Pressure | `13-14` bar (manual verification; outlet valve closed until final arming) | bar | `[A5-user-manual 2.pdf#p54]` |
| Ground Radio Power | `2` W (`OMNI` for ground/launch, selectable `OMNI`/`DIR` in flight) | W | `[A5-user-manual 2.pdf#p55]`, `[A5-user-manual 2.pdf#p72]` |
| Pre-Flight Battery Voltage | `49-50` V (`Ok (49.0)` / `50.0 V` for 12S pack) | V | `[A5-user-manual 2.pdf#p53]`, `[A5-user-manual 2.pdf#p56]` |
| Pitot Calm-Air Check | Indicated airspeed < `3` m/s stationary in calm air | m/s | `[A5-user-manual 2.pdf#p56]` |
| Pitot Airflow Check | Gently blowing air indirectly -> indicated airspeed > `10` m/s | m/s | `[A5-user-manual 2.pdf#p56]` |
| Mission Validation Rules | Named <= `24` chars; 1 Takeoff; >= 1 Waypoint; 1 Return; all items lat/lon/alt valid; min altitude >= `50` m; loiter radius >= vehicle default (`300` m) | m, chars | `[A5-user-manual 2.pdf#p46]`-`[p48]` |
| Dynamic Altitude Slider | `50` to `3000` m (`250` m major steps in Fig 8.4) | m | `[A5-user-manual 2.pdf#p63]`, `[A5-user-manual 2.pdf#p65]` |
| Rotator Fine Step | `0.5` deg CCW/CW fine tune step under `Auto Follow`; `4510` MHz example freq | deg, MHz | `[A5-user-manual 2.pdf#p72]`-`[p74]` |

---

## 3. Flight Modes, Safety Failsafes, Engagement & Abort Envelope (`A5-user-manual 2.pdf`)

| Mode / Feature | Functional Rules, Guards, and Limits | Citation |
| :--- | :--- | :--- |
| Flight Modes | Dropdown (`Slide to confirm`): `AUTO`, `CRUISE`, `LOITER` (CW, `300 m` default radius), `RTL`, `MANUAL` (`Advanced` flag only); Map-commanded: `GUIDED` (`Loiter Here`); Terminal: `ATTACK` | `[A5-user-manual 2.pdf#p59]`-`[p64]` |
| `RTL` Actions | `Disable` (caution: high loss risk), `Fly HOME Then Land` (diverts to closer Rally point if in range), `Go Directly to landing sequence`, `OnlyForGoAround` | `[A5-user-manual 2.pdf#p33]`, `[A5-user-manual 2.pdf#p62]` |
| `GCS Failsafe` | Triggers `RTL` when link lost >= `GCS Failsafe Timeout` (s; Fig 5.4 example `105 s`) | `[A5-user-manual 2.pdf#p34]` |
| `Disarm ESAD On GCS Timeout` | Disarms ESAD if no GCS ping for `ESAD GCS Timeout` (s; `0` disables) while armed | `[A5-user-manual 2.pdf#p34]` |
| `GPS Failsafe` + Spoofing | Triggers on lost/poor GPS for `GPS Failsafe Timeout`; `Disable GNSS` enters INS/DR mode (`I'm Here` / `I'm Looking Here` visual fixes); auto re-enables GNSS if radio link lost >= timeout | `[A5-user-manual 2.pdf#p34]`, `[A5-user-manual 2.pdf#p91]`-`[p92]` |
| `Power Off ESAD` | Cuts ESAD power supply -- **IRREVERSIBLE IN FLIGHT** | `[A5-user-manual 2.pdf#p36]` |
| `Reboot Vehicle` / `Gimbal` | `Reboot Vehicle` strictly disabled once armed; `Reboot Gimbal` allowed in flight for fault recovery | `[A5-user-manual 2.pdf#p38]` |
| Polygon Geofences | Independent `Exclusion` (do not enter) and `Inclusion` (do not leave) polygon groups | `[A5-user-manual 2.pdf#p50]`-`[p51]` |
| ESAD States (SwarmC2 UI) | `INACTIVE`, `SAFE`, `ARM STAGE 1`, `ARM STAGE 2` (airborne past safe distance), `ARMED`, `FIRED`; auto-returns to `SAFE` and discharges if landing/non-flying while `NOT ARMED` | `[A5-user-manual 2.pdf#p83]`-`[p85]` |
| ESAD Arm / Self-Destruct / Abort | Arm requires 4 preconditions (powered/no fault, pin removed, takeoff done, in flight); `SELF DESTRUCT` and `ABORT` each require `5` s button hold + `Slide to confirm`; `ABORT` is permanent | `[A5-user-manual 2.pdf#p84]` |
| Engagement Preconditions (6) | (1) Sufficient `GCS Failsafe timeout`; (2) Warhead `ARMED`; (3) Tracked on `EO` daylight camera; (4) Track held `2-5 s`; (5) Target elevation <= `15 deg` at start; (6) Clear LOS | `[A5-user-manual 2.pdf#p88]` |
| Engagement Speed Limit & Abort | MUST NOT exceed `55 m/s` (gimbal saturation -> immediate `Abort Engaging`); `Shallow` (`~15 deg` approach) or `Direct` (locked once in `ATTACK`); `Abort Engaging` climbs toward `Takeoff altitude` -> `GUIDED` loiter (or `RTL` if link lost); no auto re-track on track loss | `[A5-user-manual 2.pdf#p86]`-`[p90]` |
| Operator Auth & C2 | Roles: `Pilot`, `Payload`, `Launch Assistant`; min `8`-char strong password; short initial factory password window; `5W` (`Five Whiskey`) and `CFF` (`Call For Fire`) exported to `ATAK` / `SitaWare` / `DELTA` | `[A5-user-manual 2.pdf#p27]`-`[p29]`, `[A5-user-manual 2.pdf#p67]`-`[p69]`, `[A5-user-manual 2.pdf#p93]` |
