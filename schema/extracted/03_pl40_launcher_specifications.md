# ELI Military Simulations PL-40 Pneumatic Launcher Specifications (Extracted Baseline)

Source Document: `docs/reference/UAV_launcher_PL-40_user_manual_rev_2.6.pdf` (Rev 2.6, Tallinn 2026, 45 pp.).

---

## 1. Mechanical, Dimensional, Mass, and Carriage Interface Parameters

| Parameter | Value / Specification | Units | Citation |
| :--- | :--- | :--- | :--- |
| Architecture | 3-section modular pneumatic rail launcher + carriage + ground anchors + battery compressor | - | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p4]` |
| Max Aircraft Mass (MTOW) | 30 | kg | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p3]`, `[#p37]` |
| Max Allowed Launch Velocity | 25 | m/s | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p3]`, `[#p24]`, `[#p37]` |
| Rail Elevation Angle | 12 | deg | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]`, `[#p41]` |
| Assembled Rail Length | 5 (`4938` mm ground-projected CAD envelope) | m | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]`, `[#p41]` |
| Disassembled Rail Length | 1.28 | m | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| Deployed Front Leg Span / Rail Top Height | `602` lateral span / `1116` height | mm | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p41]` |
| Total Set Weight | 68 (`43 kg` launcher case `1480x440x170 mm` + `25 kg` compressor `360x360x680 mm`) | kg | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| Carriage Geometry | `271 mm` long, `232.5 mm` high, `208.5 mm` lever span, `156 mm` outer / `140 mm` inner width, `145-155.5 mm` upper prop-safe zone | mm | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p41]` |
| Payload CG Envelope | Bounded longitudinally `200` between levers, vertically `100` above tips (units unprinted) | unprinted | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p42]` |
| Hardpoint Options | A: `6061-T6` split hooks (`0.004 kg`, `178/186/206 mm`); B: `225 mm` single bar; C: `AISI 304` `M8` mushroom pins (`320 mm` span) | mm, kg | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p43]`-`[#p45]` |

---

## 2. Pneumatic, Electrical, Interlock, and Environmental Parameters

| Parameter | Value / Specification | Units | Citation |
| :--- | :--- | :--- | :--- |
| Onboard Max Working Pressure | `14` bar auto-cutoff (`0.05` bar regulation hysteresis; `<= 8` min charge time) | bar, min | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p22]`, `[#p24]`, `[#p37]` |
| External Aux Fill Port (`DIN 8 mm PCP`) | Up to `16` bar auxiliary pressure source | bar | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p21]`, `[#p37]` |
| Compressor Battery | 2x Makita `BL1860B` `18 V` Li-Ion `6000 mAh` (`UN 3481`; swap after 1st launch & every 2 launches) | V, mAh | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p6]`, `[#p26]`, `[#p28]` |
| Battery Protection Cutoff | Turns OFF at <= `14.5 V` (PWR LED flashes); restarts after `5 s` only if > `16 V` | V, s | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p23]` |
| Dual-Switch Firing Interlock | Flip 2 safety covers up -> press BOTH switches simultaneously for >= `2` s until plane clears rail | s | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p25]`, `[#p26]`, `[#p39]` |
| Mechanical Pin & Main Valve Interlocks | Red carriage safety pin locks carriage prior to opening Main Valve (4); Valve (4) closed between launches; pressing trigger with pin installed forces full reset | - | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p3]`, `[#p24]`-`[#p26]` |
| Piston Over-Acceleration Protection | Loose carriage lever lock-pads cause piston over-accel -> internal valve shuts inlet air -> launch abort | - | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p18]` |
| Temperature Limits | Operating `-20 to +50` degC; Charging `+10 to +40` degC; Set-up time `5` min | degC, min | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p28]`, `[#p37]` |
| Replacement Intervals | Pulling rope & carriage wheel bearings (`250 degC` threadlocker heat removal) every `100` launches | launches | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p29]`-`[#p36]` |
| Launch Zone Exclusion | `SAFETY AREA` strictly behind rear anchor/foot; `DANGER ZONE` all forward & lateral sectors (no numeric meters stated) | - | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p40]` |

---

## 3. OEM Pressure-Mass-Velocity Table (`UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37`)

Note: Values above `25 m/s` exceed the launcher's `25 m/s` rated limit `[#p24]`, `[#p37]`. Avenger 5 `MTOW = 17 kg` lies between the `15 kg` and `20 kg` columns (interpolated ~`22.7-23.5 m/s` at `13-14 bar`, close to `24 m/s` stall speed without headwind/thrust margin).

| Pressure (bar) | 10 kg (m/s) | 15 kg (m/s) | 20 kg (m/s) | 30 kg (m/s) | Note |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 5 | 18.4 | 15.1 | 13.1 | 10.7 | Nominal |
| 8 | 23.3 | 19.1 | 16.5 | 13.5 | Nominal |
| 9 | 24.8 | 20.3 | 17.6 | 14.3 | Nominal |
| 10 | 26.1 (OVER 25 LIMIT) | 21.3 | 18.5 | 15.1 | Exceeds 25 m/s at 10 kg |
| 12 | - | 23.4 | 20.3 | 16.5 | Nominal |
| 13 | - | 24.3 | 21.1 | 17.2 | Avenger 5 SwarmC2 nominal lower bound |
| 14 | - | 25.3 (OVER 25 LIMIT) | 21.9 | 17.9 | Max onboard compressor pressure (`13-14 bar` Avenger 5 range) |
| 15 (Aux) | - | 26.1 (OVER 25 LIMIT) | 22.7 | 18.5 | Requires aux fill |
| 16 (Aux) | - | - | 23.4 | 19.1 | Max aux fill |
