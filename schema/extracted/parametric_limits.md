# Avenger 5 UAS Grounded Parametric Limits & OEM Gap Ledger

Source Baseline: Synthesized exclusively from `01_avenger5_platform_and_architecture.md` through `05_engineering_gaps_and_synthesis_ledger.md` under Step 0.0 (Level 0 OEM Ground Truth Ingestion).

Compliance Rule (Check 26): Every row in Section 1 strictly separates pure numeric `Value` and pure `Units` into distinct columns with zero units inside `Value`, zero numbers inside `Units`, zero Unicode em-dashes (`\u2014`), and zero math delimiters.

---

## 1. Grounded Quantitative Limits, Dimensions, Thresholds, and Derived Regulatory Bounds

| Param ID | Subsystem / Scope | Parameter Name | Value | Units | Constraint / Condition | OEM Source Citation |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `PRM-AF-001` | Airframe | Wingspan (Nominal Spec Sheet) | 1.8 | m | Nominal assembled wingspan | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[A5-user-manual 2.pdf#p9]` |
| `PRM-AF-002` | Airframe | Wingspan (CAD Exact) | 1803.0 | mm | CAD reference wingspan | `[A5-user-manual 2.pdf#p9]` |
| `PRM-AF-003` | Airframe | Overall Length (Nominal Spec Sheet) | 1.6 | m | Nominal assembled fuselage length | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[A5-user-manual 2.pdf#p9]` |
| `PRM-AF-004` | Airframe | Overall Length (CAD Exact) | 1576.0 | mm | CAD reference fuselage length | `[A5-user-manual 2.pdf#p9]` |
| `PRM-AF-005` | Airframe | Assembled Height (Nominal) | 1.1 | m | Nominal assembled airframe height | `[A5-user-manual 2.pdf#p9]` |
| `PRM-AF-006` | Airframe | Assembled Height (CAD Min) | 1095.0 | mm | Minimum CAD assembled height | `[A5-user-manual 2.pdf#p9]` |
| `PRM-AF-007` | Airframe | Assembled Height (CAD Max) | 1112.0 | mm | Maximum CAD assembled height | `[A5-user-manual 2.pdf#p9]` |
| `PRM-AF-008` | Airframe | Maximum Takeoff Weight (MTOW) | 17.0 | kg | Maximum authorized UAV takeoff mass | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[A5-user-manual 2.pdf#p9]` |
| `PRM-AF-009` | Payload | Max Lethal Package / Warhead Mass | 5.0 | kg | Maximum warhead payload mass | `[AVENGER 5 Spec sheet_rev3.pdf#p2]` |
| `PRM-AF-010` | Payload | Warhead Holder Tested Mass (Nominal) | 4.98 | kg | Tested holder unit nominal mass | `[A5_prep and safety_rev7.pdf#p10]` |
| `PRM-AF-011` | Payload | Warhead Holder Tested Mass Tolerance | 0.02 | kg | Symmetric +/- tolerance on tested holder unit | `[A5_prep and safety_rev7.pdf#p10]` |
| `PRM-AF-012` | Payload | Warhead CG CTQ Nominal | 30.57 | unprinted | Payload CG CTQ datum (unit unprinted in OEM prep manual) | `[A5_prep and safety_rev7.pdf#p10]` |
| `PRM-AF-013` | Payload | Warhead CG CTQ Tolerance | 1.00 | unprinted | Symmetric +/- tolerance on CG CTQ datum | `[A5_prep and safety_rev7.pdf#p10]` |
| `PRM-AF-014` | Payload | Warhead Overall CTQ Dimension | 173.00 | unprinted | Payload overall CTQ datum (unit unprinted in OEM prep manual) | `[A5_prep and safety_rev7.pdf#p10]` |
| `PRM-AF-015` | Payload | ESAD Payload Terminal Hex Tool Size | 1.5 | mm | Hex driver size for payload-to-ESAD terminal fastening | `[A5_prep and safety_rev7.pdf#p9]` |
| `PRM-AF-016` | Airframe | Front Wing Bolt Diameter (M6) | 6.0 | mm | Thread diameter for 4 front wing mounting bolts | `[A5_prep and safety_rev7.pdf#p17]` |
| `PRM-AF-017` | Airframe | Front Wing Bolt Length | 30.0 | mm | Length of 4 front M6 wing bolts (8 bolts total; torque unprinted, Sec 2.3) | `[A5_prep and safety_rev7.pdf#p17]` |
| `PRM-AF-018` | Airframe | Wing Bolt Spanner Size | 10.0 | mm | Wrench size for tightening all 8 wing bolts | `[A5_prep and safety_rev7.pdf#p17]` |
| `PRM-AF-019` | Ground Handling | Airframe Lift Crew Minimum | 2 | persons | Minimum personnel required to lift UAV onto PL-40 carriage | `[A5_prep and safety_rev7.pdf#p15]` |
| `PRM-PERF-001` | Performance | Endurance (Minutes) | 90.0 | min | Maximum endurance (ConOps and weather dependent) | `[AVENGER 5 Spec sheet_rev3.pdf#p2]`, `[#p3]` |
| `PRM-PERF-002` | Performance | Endurance (Seconds) | 5400.0 | s | SI equivalent of maximum endurance | `[AVENGER 5 Spec sheet_rev3.pdf#p2]`, `[#p3]` |
| `PRM-PERF-003` | Performance | Derived Statutory Bingo Energy Reserve | 0.20 | ratio | Derived mandatory reserve fraction (Derived -- JARUS SORA / MIL-STD-882E) | `[Derived -- JARUS SORA v2.5 / MIL-STD-882E]` |
| `PRM-PERF-004` | Performance | Stall / Minimum Speed (V2.5 Spec Sheet) | 24.0 | m/s | Minimum flight airspeed per V2.5 Spec Sheet (`GAP-02`) | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-PERF-005` | Performance | Minimum Speed (V1 User Manual) | 26.0 | m/s | Conservative minimum flight speed per V1 User Manual (`GAP-02`) | `[A5-user-manual 2.pdf#p10]` |
| `PRM-PERF-006` | Performance | Cruise Speed (V1 User Manual) | 30.0 | m/s | Nominal cruise airspeed per V1 User Manual (`GAP-02`) | `[A5-user-manual 2.pdf#p10]` |
| `PRM-PERF-007` | Performance | Cruise Speed (V2.5 Spec Sheet) | 31.0 | m/s | Nominal cruise airspeed per V2.5 Spec Sheet (`GAP-02`) | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-PERF-008` | Performance | Max Horizontal Speed (V1 User Manual) | 38.0 | m/s | Conservative max horizontal speed per V1 User Manual (`GAP-02`) | `[A5-user-manual 2.pdf#p10]` |
| `PRM-PERF-009` | Performance | Max Horizontal Speed (V2.5 Spec Sheet) | 42.0 | m/s | Max horizontal airspeed per V2.5 Spec Sheet (`GAP-02`) | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-PERF-010` | Performance | Target Engagement Speed Cap (V1 Dive) | 55.0 | m/s | Hard target engagement cap (exceeding saturates gimbal -> Abort Engaging) | `[A5-user-manual 2.pdf#p10]`, `[#p88]` |
| `PRM-PERF-011` | Performance | Structural Dive Speed VNE (V2.5 Spec Sheet) | 80.0 | m/s | Airframe structural dive limit VNE per V2.5 Spec Sheet (`GAP-02`) | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-PERF-012` | Performance | Max Dive Angle (V1 User Manual) | 22.0 | deg | Maximum dive angle per V1 User Manual | `[A5-user-manual 2.pdf#p10]` |
| `PRM-PERF-013` | Performance | Shallow Attack Approach Angle | 15.0 | deg | Nominal Shallow engagement approach glidepath angle | `[A5-user-manual 2.pdf#p86]`-`[#p90]` |
| `PRM-PERF-014` | Performance | Engagement Max Target Elevation at Start | 15.0 | deg | Maximum target elevation angle at start of terminal engagement | `[A5-user-manual 2.pdf#p88]` |
| `PRM-PERF-015` | Performance | Service Ceiling | 5000.0 | m | Maximum operational altitude ceiling | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-PERF-016` | Performance | Ground Wind Tolerance Max | 12.0 | m/s | Maximum ground / launch wind tolerance | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-PERF-017` | Performance | Cruise Wind Tolerance Max | 28.0 | m/s | Maximum cruise wind tolerance | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-PERF-018` | Performance | Operating Temperature Min | -20.0 | degC | Minimum ambient operating temperature | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-PERF-019` | Performance | Operating Temperature Max | 50.0 | degC | Maximum ambient operating temperature | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-PERF-020` | Performance | Terminal Accuracy CEP Max (Meters) | 0.5 | m | Maximum CEP against stationary targets | `[AVENGER 5 Spec sheet_rev3.pdf#p1]`, `[#p2]` |
| `PRM-PERF-021` | Performance | Terminal Accuracy CEP Max (Centimeters) | 50.0 | cm | Maximum CEP expressed in centimeters | `[AVENGER 5 Spec sheet_rev3.pdf#p1]`, `[#p2]` |
| `PRM-AV-001` | Power Bus | Main Battery Bus Voltage Min | 36.0 | V | Minimum 12S2P Li metal DC bus voltage | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-AV-002` | Power Bus | Main Battery Bus Voltage Max | 50.4 | V | Maximum 12S2P Li metal DC bus voltage | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-AV-003` | Power Bus | Pre-Flight Battery Voltage Min | 49.0 | V | Minimum pre-flight battery check pass voltage (`GAP-05`) | `[A5-user-manual 2.pdf#p53]`, `[#p56]` |
| `PRM-AV-004` | Power Bus | Pre-Flight Battery Voltage Nominal Max | 50.0 | V | Nominal full pre-flight pack check voltage (`GAP-05`) | `[A5-user-manual 2.pdf#p56]` |
| `PRM-AV-005` | Power Bus | Main Automotive Fuse Rating | 200.0 | A | Overcurrent protection fuse between Battery and Power Meter | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-AV-006` | Power Bus | EPS Servo Rail Voltage | 8.0 | V | Regulated EPS supply to 8x HV6160-DroneCAN actuators | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-AV-007` | Power Bus | EPS C2 Radio Rail Voltage | 12.0 | V | Regulated EPS output to DTC Radio | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-AV-008` | Power Bus | DTC Radio Supply Tolerance Min | 8.0 | V | Minimum allowed input voltage at DTC Radio | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-AV-009` | Power Bus | DTC Radio Supply Tolerance Max | 17.0 | V | Maximum allowed input voltage at DTC Radio | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-AV-010` | Power Bus | EPS ESAD Rail Voltage | 14.0 | V | Regulated EPS output to ESAD (zero brownout margin vs ICD min, `GAP-01`) | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-AV-011` | Power Bus | EPS RnD Recovery Igniter Rail Voltage | 50.0 | V | Optional RnD-only burn-wire igniter lines (2x) | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-AV-012` | Harness | Power & CAN 1 Trunk Harness Length | 970.0 | cm | Fuselage trunk wire length between Power Meter / Cube and EPS | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-AV-013` | Harness | Tail Fin Servo CAN 1 Stub Length | 120.0 | cm | Length per each of 4x fin servo CAN 1 stubs | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-AV-014` | Actuation | Tail Ruddervator Servo Quantity | 4 | count | Number of HV6160-DroneCAN tail servos on CAN 1 | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-AV-015` | Actuation | Wing Roll Servo Quantity | 4 | count | Number of HV6160-DroneCAN wing servos on CAN 2 | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-AV-016` | Sensors | Magnetometer + Barometer Module Quantity | 2 | count | Dual redundant mRo RM3100 units on CAN 2 | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-AV-017` | Sensors | Pitot Calm-Air Indicated Airspeed Max | 3.0 | m/s | Stationary calm-air pitot pre-flight check upper bound | `[A5-user-manual 2.pdf#p56]` |
| `PRM-AV-018` | Sensors | Pitot Airflow Check Indicated Airspeed Min | 10.0 | m/s | Indirect blowing pitot pre-flight check lower bound | `[A5-user-manual 2.pdf#p56]` |
| `PRM-AV-019` | EO/IR Gimbal | Day & Thermal Resolution Horizontal | 1280 | px | Horizontal pixel resolution of daylight and thermal channels | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-AV-020` | EO/IR Gimbal | Day & Thermal Resolution Vertical | 720 | px | Vertical pixel resolution of daylight and thermal channels | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-AV-021` | EO/IR Gimbal | Seeker Optical / Combined Zoom Factor | 40.0 | zoom | Nighthawk2UZ X40 zoom capability | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-AV-022` | EO/IR Gimbal | Gimbal Pitch Travel Min | -45.0 | deg | Minimum gimbal pitch travel angle | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-AV-023` | EO/IR Gimbal | Gimbal Pitch Travel Max | 135.0 | deg | Maximum gimbal pitch travel angle | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-AV-024` | EO/IR Gimbal | Gimbal Yaw / Roll Travel Min | -165.0 | deg | Minimum gimbal yaw/roll travel angle | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-AV-025` | EO/IR Gimbal | Gimbal Yaw / Roll Travel Max | 165.0 | deg | Maximum gimbal yaw/roll travel angle | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-RF-001` | Datalink | C2 Radio Operating Frequency Min | 4.4 | GHz | Minimum DTC FHSS operating frequency | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-RF-002` | Datalink | C2 Radio Operating Frequency Max | 5.0 | GHz | Maximum DTC FHSS operating frequency | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-RF-003` | Datalink | C2 Radio Total RF Output Power | 2.0 | W | Total radio TX RF power | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[A5-user-manual 2.pdf#p55]` |
| `PRM-RF-004` | Datalink | C2 Radio Per-Antenna RF Output Power | 1.0 | W | Per-antenna power across dual MPSL4400 chain | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `PRM-RF-005` | Datalink | C2 Radio AES Encryption Key Size | 256 | bits | Link encryption key strength (AES-256) | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-RF-006` | Datalink | RLOS Range Baseline / Nominal | 60.0 | km | Baseline RLOS datalink range | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[A5-user-manual 2.pdf#p10]` |
| `PRM-RF-007` | Datalink | RLOS Range Extended (V2.5 Spec Sheet) | 90.0 | km | Extended RLOS range per V2.5 Spec Sheet (`GAP-02`) | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `PRM-RF-008` | Datalink | RLOS Range Extended (V1 User Manual) | 180.0 | km | Extended RLOS range per V1 User Manual (`GAP-02`) | `[A5-user-manual 2.pdf#p10]` |
| `PRM-RF-009` | Datalink | Ground MARS Directional Antenna Gain | 23.0 | dBi | Directional tracking antenna gain | `[A5-user-manual 2.pdf#p11]` |
| `PRM-RF-010` | Datalink | Rotator Fine Step Increment | 0.5 | deg | Fine manual CCW/CW azimuth step under Auto Follow | `[A5-user-manual 2.pdf#p72]`-`[#p74]` |
| `PRM-RF-011` | Datalink | Ground Rotator Example Channel Frequency | 4510.0 | MHz | Example operating frequency shown in SwarmC2 rotator UI | `[A5-user-manual 2.pdf#p72]`-`[#p74]` |
| `PRM-RF-012` | Datalink | Optional Fiber Optic Ground Spool Length | 200.0 | m | Optional tactical fiber tether between GCS and Ground Radio Box | `[A5-user-manual 2.pdf#p11]` |
| `PRM-GCS-001` | Ground Safety | Minimum Ground Radio / Crew Separation | 10.0 | m | Keep UAV at or beyond separation distance from Ground Radio Box during prep | `[A5-user-manual 2.pdf#p52]` |
| `PRM-GCS-002` | GCS | Telemetry Detection Timeout on Power-On | 2.0 | min | Maximum wait for telemetry acquisition after UAV power-on | `[A5-user-manual 2.pdf#p52]` |
| `PRM-GCS-003` | GCS | Mission Name Max Character Count | 24 | chars | Maximum allowed SwarmC2 mission name length | `[A5-user-manual 2.pdf#p46]`-`[#p48]` |
| `PRM-GCS-004` | GCS | Minimum Mission Waypoint / Slider Altitude | 50.0 | m | Minimum allowed mission waypoint altitude and slider floor | `[A5-user-manual 2.pdf#p46]`-`[#p48]`, `[#p63]` |
| `PRM-GCS-005` | GCS | Dynamic Altitude Slider Max | 3000.0 | m | Upper bound of SwarmC2 dynamic altitude slider | `[A5-user-manual 2.pdf#p63]`, `[#p65]` |
| `PRM-GCS-006` | GCS | Dynamic Altitude Slider Major Step | 250.0 | m | Major graduation interval on dynamic altitude slider | `[A5-user-manual 2.pdf#p63]`, `[#p65]` |
| `PRM-GCS-007` | GCS | Default Loiter Radius Min | 300.0 | m | Default CW loiter radius and mission validation minimum | `[A5-user-manual 2.pdf#p46]`-`[#p48]`, `[#p59]`-`[#p64]` |
| `PRM-GCS-008` | GCS | GCS Failsafe Timeout Example Baseline | 105.0 | s | Example GCS Failsafe RTL trigger timeout in SwarmC2 Fig 5.4 | `[A5-user-manual 2.pdf#p34]` |
| `PRM-GCS-009` | GCS | Operator Password Minimum Length | 8 | chars | Minimum password character count across Pilot/Payload/Launch Assistant | `[A5-user-manual 2.pdf#p27]`-`[#p29]` |
| `PRM-GCS-010` | GCS / ESAD | ESAD Self-Destruct / Abort Hold Min | 5.0 | s | Minimum button hold time before Slide-to-Confirm | `[A5-user-manual 2.pdf#p84]` |
| `PRM-GCS-011` | GCS / ESAD | Engagement Target Track Hold Min | 2.0 | s | Minimum EO daylight track hold time before engagement | `[A5-user-manual 2.pdf#p88]` |
| `PRM-GCS-012` | GCS / ESAD | Engagement Target Track Hold Max | 5.0 | s | Upper bound of EO track stabilization window before engagement | `[A5-user-manual 2.pdf#p88]` |
| `PRM-PL40-001` | Launcher | Max Supported Aircraft MTOW | 30.0 | kg | Structural maximum UAV mass supported by PL-40 | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p3]`, `[#p37]` |
| `PRM-PL40-002` | Launcher | Max Allowed Launch Exit Velocity | 25.0 | m/s | Hard maximum rated carriage launch velocity (`GAP-03`) | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p3]`, `[#p24]`, `[#p37]` |
| `PRM-PL40-003` | Launcher | Avenger 5 Interpolated Exit Velocity (17 kg) | 23.0 | m/s | Approximate exit velocity at 17 kg MTOW and 13-14 bar (`GAP-03`) | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `PRM-PL40-004` | Launcher | Avenger 5 Interpolated Exit Lower Bound | 22.7 | m/s | Lower interpolated exit velocity bound at 17 kg / 13-14 bar | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `PRM-PL40-005` | Launcher | Avenger 5 Interpolated Exit Upper Bound | 23.5 | m/s | Upper interpolated exit velocity bound at 17 kg / 13-14 bar | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `PRM-PL40-006` | Launcher | Rail Elevation Angle | 12.0 | deg | Fixed launch rail inclination angle | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]`, `[#p41]` |
| `PRM-PL40-007` | Launcher | Assembled Rail Length Nominal | 5.0 | m | Nominal 3-section assembled rail length | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `PRM-PL40-008` | Launcher | Ground-Projected CAD Rail Envelope | 4938.0 | mm | Ground-projected assembled CAD envelope | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p41]` |
| `PRM-PL40-009` | Launcher | Disassembled Rail Section Length | 1.28 | m | Transport length of disassembled rail | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `PRM-PL40-010` | Launcher | Deployed Front Leg Lateral Span | 602.0 | mm | Lateral span across deployed front anchors/legs | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p41]` |
| `PRM-PL40-011` | Launcher | Deployed Rail Top Height | 1116.0 | mm | Deployed rail top height above ground | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p41]` |
| `PRM-PL40-012` | Launcher | Total Launcher System Set Mass | 68.0 | kg | Combined mass of launcher case plus compressor unit | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `PRM-PL40-013` | Launcher | Launcher Transport Case Mass | 43.0 | kg | Packed launcher case mass | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `PRM-PL40-014` | Launcher | Compressor Unit Mass | 25.0 | kg | Portable compressor unit mass | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `PRM-PL40-015` | Launcher | Carriage Overall Length | 271.0 | mm | Launch carriage longitudinal length | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p41]` |
| `PRM-PL40-016` | Launcher | Carriage Overall Height | 232.5 | mm | Launch carriage vertical height | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p41]` |
| `PRM-PL40-017` | Launcher | Carriage Lever Lateral Span | 208.5 | mm | Launch carriage lever span | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p41]` |
| `PRM-PL40-018` | Launcher | Carriage Outer Width | 156.0 | mm | Launch carriage outer frame width | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p41]` |
| `PRM-PL40-019` | Launcher | Carriage Inner Width | 140.0 | mm | Launch carriage inner fuselage cradle width | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p41]` |
| `PRM-PL40-020` | Launcher | Carriage Prop-Safe Upper Zone Min | 145.0 | mm | Lower vertical bound of upper prop-safe zone | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p41]` |
| `PRM-PL40-021` | Launcher | Carriage Prop-Safe Upper Zone Max | 155.5 | mm | Upper vertical bound of upper prop-safe zone | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p41]` |
| `PRM-PL40-022` | Launcher | Payload CG Envelope Longitudinal Bound | 200.0 | unprinted | Longitudinal bound between carriage levers (unit unprinted) | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p42]` |
| `PRM-PL40-023` | Launcher | Payload CG Envelope Vertical Bound | 100.0 | unprinted | Vertical bound above lever tips (unit unprinted) | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p42]` |
| `PRM-PL40-024` | Launcher | Hardpoint Option A Split Hook Mass | 0.004 | kg | 6061-T6 split hook unit mass | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p43]`-`[#p45]` |
| `PRM-PL40-025` | Launcher | Hardpoint Option B Single Bar Span | 225.0 | mm | Single bar hardpoint width | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p43]`-`[#p45]` |
| `PRM-PL40-026` | Launcher | Hardpoint Option C M8 Mushroom Pin Span | 320.0 | mm | AISI 304 M8 mushroom pin span | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p43]`-`[#p45]` |
| `PRM-PL40-027` | Launcher | Avenger 5 Operating Pressure Min | 13.0 | bar | SwarmC2 nominal minimum launch gauge pressure (`GAP-03`) | `[A5-user-manual 2.pdf#p54]`, `[A5_prep and safety_rev7.pdf#p5]` |
| `PRM-PL40-028` | Launcher | Onboard Max Working Pressure / Auto-Cutoff | 14.0 | bar | Maximum onboard compressor pressure and Avenger 5 launch upper bound | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p22]`, `[#p24]`, `[#p37]` |
| `PRM-PL40-029` | Launcher | Pressure Regulation Hysteresis | 0.05 | bar | Auto-cutoff pressure regulation hysteresis | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p22]` |
| `PRM-PL40-030` | Launcher | Onboard Compressor Charge Time Max | 8.0 | min | Maximum tank charging duration | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `PRM-PL40-031` | Launcher | External Auxiliary Fill Port Max Pressure | 16.0 | bar | DIN 8 mm PCP external auxiliary fill maximum | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p21]`, `[#p37]` |
| `PRM-PL40-032` | Launcher | Compressor Battery Nominal Voltage | 18.0 | V | Makita BL1860B nominal voltage (2x packs) | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p6]`, `[#p28]` |
| `PRM-PL40-033` | Launcher | Compressor Battery Capacity | 6000.0 | mAh | Makita BL1860B pack charge capacity | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p6]`, `[#p28]` |
| `PRM-PL40-034` | Launcher | Compressor Battery UVLO Protection Cutoff | 14.5 | V | Compressor cuts OFF at or below 14.5 V (PWR LED flashes) | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p23]` |
| `PRM-PL40-035` | Launcher | Compressor Battery UVLO Restart Threshold | 16.0 | V | Minimum battery voltage required to restart after UVLO | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p23]` |
| `PRM-PL40-036` | Launcher | Compressor UVLO Restart Delay | 5.0 | s | Required wait delay before restart check | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p23]` |
| `PRM-PL40-037` | Launcher | Dual-Switch Simultaneous Firing Hold Min | 2.0 | s | Simultaneous hold on both safety-covered switches until plane clears rail | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p25]`, `[#p26]`, `[#p39]` |
| `PRM-PL40-038` | Launcher | Operating Temperature Min | -20.0 | degC | PL-40 minimum ambient operating temperature | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p28]`, `[#p37]` |
| `PRM-PL40-039` | Launcher | Operating Temperature Max | 50.0 | degC | PL-40 maximum ambient operating temperature | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p28]`, `[#p37]` |
| `PRM-PL40-040` | Launcher | Battery Charging Temperature Min | 10.0 | degC | Minimum ambient battery charging temperature | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p28]` |
| `PRM-PL40-041` | Launcher | Battery Charging Temperature Max | 40.0 | degC | Maximum ambient battery charging temperature | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p28]` |
| `PRM-PL40-042` | Launcher | Nominal Field Set-Up Time | 5.0 | min | Nominal mechanical setup time | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `PRM-PL40-043` | Launcher | Pulling Rope & Carriage Bearing Interval | 100 | launches | Preventive replacement interval for pulling rope and carriage wheel bearings | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p29]`-`[#p36]` |
| `PRM-PL40-044` | Launcher | Bearing Threadlocker Heat Removal Temp | 250.0 | degC | Required localized heat for bearing maintenance | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p29]`-`[#p36]` |
| `PRM-PL40-045` | Launcher | Table 2 Exit Velocity (15 kg at 13 bar) | 24.3 | m/s | OEM calibration point below 25.0 m/s limit (`GAP-03`) | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `PRM-PL40-046` | Launcher | Table 2 Exit Velocity (15 kg at 14 bar) | 25.3 | m/s | Exceeds 25.0 m/s launcher rating (`OVER 25 LIMIT`, `GAP-03`) | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `PRM-PL40-047` | Launcher | Table 2 Exit Velocity (20 kg at 13 bar) | 21.1 | m/s | OEM calibration point at 20 kg / 13 bar | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `PRM-PL40-048` | Launcher | Table 2 Exit Velocity (20 kg at 14 bar) | 21.9 | m/s | OEM calibration point at 20 kg / 14 bar | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `PRM-PL40-049` | Launcher | Table 2 Exit Velocity (30 kg at 13 bar) | 17.2 | m/s | OEM calibration point at 30 kg max MTOW / 13 bar | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `PRM-PL40-050` | Launcher | Table 2 Exit Velocity (30 kg at 14 bar) | 17.9 | m/s | OEM calibration point at 30 kg max MTOW / 14 bar | `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `PRM-ESAD-001` | ESAD Power | `VDC_IN` (`GE_POW`) Minimum Input Voltage | 14.0 | V | Minimum ESAD operating input voltage (matches EPS output, `GAP-01`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` |
| `PRM-ESAD-002` | ESAD Power | `VDC_IN` (`GE_POW`) Nominal Input Voltage | 28.0 | V | ICD nominal operating voltage (`GAP-01` vs 14 V Avenger 5 EPS) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` |
| `PRM-ESAD-003` | ESAD Power | `VDC_IN` (`GE_POW`) Maximum Input Voltage | 32.0 | V | Maximum allowed ESAD input voltage | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` |
| `PRM-ESAD-004` | ESAD Interlock | Umbilical Loop (`UMB`) Max Continuity Resistance | 0.5 | Ohm | Maximum continuity resistance across `J100` pins 5-6 (`22-28 AWG`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` |
| `PRM-ESAD-005` | ESAD Interlock | Umbilical Loop (`UMB`) Sense Current | 20.0 | mA | Umbilical continuity sense current | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` |
| `PRM-ESAD-006` | ESAD Discrete | Discrete Arm (`DSC_IN1`) Pulse Frequency | 1000.0 | Hz | Square-wave arm enable frequency (`1 ms` period) on `J100` pin 13 | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` |
| `PRM-ESAD-007` | ESAD Discrete | Discrete Arm (`DSC_IN1`) Pulse Period | 1.0 | ms | Square-wave arm enable period | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` |
| `PRM-ESAD-008` | ESAD Discrete | Discrete Arm (`DSC_IN1`) Duty Cycle | 50.0 | percent | Square-wave duty cycle | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` |
| `PRM-ESAD-009` | ESAD Discrete | Discrete Arm (`DSC_IN1`) Pulse Count | 2 | pulses | Required square-wave arm pulse count | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` |
| `PRM-ESAD-010` | ESAD Discrete | Discrete Arm (`DSC_IN1`) Logic Low Max | 0.7 | V | Logic-low input ceiling (`0..0.7 VDC`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` |
| `PRM-ESAD-011` | ESAD Discrete | Discrete Arm (`DSC_IN1`) Logic High Min | 2.5 | V | Logic-high input floor (`2.5..3.3 VDC`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` |
| `PRM-ESAD-012` | ESAD Discrete | Discrete Arm (`DSC_IN1`) Logic High Max | 3.3 | V | Logic-high input ceiling (`2.5..3.3 VDC`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` |
| `PRM-ESAD-013` | ESAD Sensor | Sensor Board Supply (`J102` `VOUT` `5V0`) | 5.0 | V | Sensor board power output (`28 AWG` harness) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p10]`-`[#p13]` |
| `PRM-ESAD-014` | ESAD Protocol | RS-485 Baud Rate | 115200 | bps | Half-duplex differential RS-485 baud rate (`8N1`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]`-`[#p15]` |
| `PRM-ESAD-015` | ESAD Protocol | RS-485 UART Data Bits | 8 | bits | UART payload bits per character | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]`-`[#p15]` |
| `PRM-ESAD-016` | ESAD Protocol | RS-485 UART Total Frame Bits | 10 | bits | 1 start + 8 data + 1 stop, None parity | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]`-`[#p15]` |
| `PRM-ESAD-017` | ESAD Protocol | RS-485 Polling Frequency | 100.0 | Hz | OC polling frequency (`GAP-04`: `100 Hz` / `0.01 s` vs `100 ms` wording on p15) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p15]` |
| `PRM-ESAD-018` | ESAD Protocol | RS-485 Polling Period (Seconds) | 0.01 | s | Derived `1 / 100 Hz` polling period (`GAP-04` / `05` Sec 2.1) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p15]` |
| `PRM-ESAD-019` | ESAD Protocol | RS-485 Incomplete Packet / Watchdog Timeout | 10.0 | ms | Incomplete packet timeout (`GAP-04` / `04` p15) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p15]` |
| `PRM-ESAD-020` | ESAD Protocol | RS-485 ESAD Reply Max Latency | 5.0 | ms | Max time from command last bit to reply last bit | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p15]` |
| `PRM-ESAD-021` | ESAD Protocol | RS-485 Minimum Packet Length | 5 | bytes | Minimum frame size (`Length + Header + Cmd + 2B CRC-16`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p16]` |
| `PRM-ESAD-022` | ESAD Protocol | RS-485 Max Data Payload Length | 9 | bytes | Maximum `Data` field byte count (`0..9`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p16]` |
| `PRM-ESAD-023` | ESAD Protocol | `EXCHANGE (0x10)` Request Length | 8 | bytes | Request frame length (`0x08`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p17]` |
| `PRM-ESAD-024` | ESAD Protocol | `EXCHANGE (0x10)` Response Length | 14 | bytes | Response frame length (`0x0E`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p17]` |
| `PRM-ESAD-025` | ESAD Protocol | `PBIT (0x11)` Request Length | 5 | bytes | Request frame length (`0x05`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p17]` |
| `PRM-ESAD-026` | ESAD Protocol | `PBIT (0x11)` Response Length | 7 | bytes | Response frame length (`0x07`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p17]` |
| `PRM-ESAD-027` | ESAD Protocol | `HIGHVOLTAGE (0x12)` Request Length | 5 | bytes | Request frame length (`0x05`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p17]` |
| `PRM-ESAD-028` | ESAD Protocol | `HIGHVOLTAGE (0x12)` Response Length | 8 | bytes | Response frame length (`0x08`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p17]` |
| `PRM-ESAD-029` | ESAD HV Safety | PBIT Safe High-Voltage Ceiling | 50.0 | V | PBIT bit 12 safe threshold (`< 50.0 V` safe vs `>= 50.0 V` fault) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p18]`, `[#p26]`-`[#p27]` |
| `PRM-ESAD-030` | ESAD HV Fire | HV Output Minimum (`J401`) | 0.0 | V | Discharged HV output floor | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p18]`, `[#p26]`-`[#p27]` |
| `PRM-ESAD-031` | ESAD HV Fire | HV Output Maximum (`J401`) | 1800.0 | V | Maximum `HIGHVOLTAGE` capacitor charge / firing output | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p18]`, `[#p26]`-`[#p27]` |
| `PRM-ESAD-032` | ESAD Telemetry | High Voltage Telemetry Scale | 1.0 | V/LSB | `UINT16 Value` telemetry scaling | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p26]`-`[#p27]` |
| `PRM-ESAD-033` | ESAD Telemetry | FlightTimer Telemetry Scale | 1.0 | s/LSB | `UINT16 FlightTimer` telemetry scaling | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p20]` |
| `PRM-ESAD-034` | ESAD Telemetry | Acceleration Telemetry Scale | 0.0039 | g/LSB | 13-bit signed two's complement `Acceleration` / `SimAccelerationOffset` scale | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p20]`, `[#p23]` |
| `PRM-ESAD-035` | ESAD Mechanical | ESAD Board Mounting Hole Diameter (M3) | 3.0 | mm | `3x M3` user mounting holes (`75 mm` BCD; torque unprinted, Sec 2.3) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p28]` |
| `PRM-ESAD-036` | ESAD Mechanical | ESAD Board Mounting Circle Diameter | 75.0 | mm | Bolt circle diameter noted from PCB outline (`05` Sec 2.3) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p28]` |
| `PRM-ESAD-037` | ESAD Mechanical | ESAD Sensor Board Mounting Hole Diameter (M2) | 2.0 | mm | `2x M2` sensor board mounting holes | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p28]` |

---

## 2. OEM Engineering Gaps & Missing Quantitative Figures Ledger (`05_engineering_gaps_and_synthesis_ledger.md`)

| Gap ID | Subsystem / Scope | Missing or Conflicting OEM Parameter | Engineering Disposition | OEM Gap Ledger Citation |
| :--- | :--- | :--- | :--- | :--- |
| `GAP-01` | EPS -> ESAD Power | `14 V` EPS output equals `14 V` ESAD `GE_POW` minimum (`28 V` ICD nominal) -- zero cable-drop brownout margin | Model explicit `CrossRingBoundary` & `SignalContract` (`14.0-32.0 V`) + STPA Loss Scenario / FMECA requirement | `[05_engineering_gaps_and_synthesis_ledger.md#s1]`, `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]`, `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` |
| `GAP-02` | Flight Envelope | V1 manual (`26-38 m/s`, `55 m/s` dive, `30 m/s` cruise, `60/180 km` RLOS) vs V2.5 spec (`24-42 m/s`, `80 m/s` dive, `31 m/s` cruise, `60/90 km` RLOS) | Adopt conservative inner control envelope (`55 m/s` EO engagement cap, `80 m/s` VNE structural ceiling) | `[05_engineering_gaps_and_synthesis_ledger.md#s1]`, `[A5-user-manual 2.pdf#p10]`, `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| `GAP-03` | Launch Velocity vs Stall | At `17 kg` MTOW and `13-14 bar`, PL-40 interpolated exit velocity (`~23 m/s`) is below `24-26 m/s` stall without headwind/thrust; `<15 kg` can exceed `25 m/s` launcher limit | Encode launch Go/No-Go gate linking pusher propulsion state, `13-14 bar` check, headwind (`<= 12 m/s`), and `<= 25 m/s` rail limit | `[05_engineering_gaps_and_synthesis_ledger.md#s1]`, `[A5-user-manual 2.pdf#p54]`, `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p37]` |
| `GAP-04` | ESAD Platform Bridge & Polling | ESAD ICD titled `Avenger 3` (`28 V`), Avenger V2.5 uses `14 V` + `RPI CM5004032` bridge; ICD p15 states `100 Hz` (`0.01 s`) / `10 ms` timeout alongside `100 ms` poll wording | Model `RPI <-> ESAD` as `Ring2 -> Ring3` supervised bridge (`100 Hz` `RS-485` `CRC-16 XModem` + `DSC_IN1` + `UMB`) | `[05_engineering_gaps_and_synthesis_ledger.md#s1]`, `[#s2.1]`, `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p1]`, `[#p15]` |
| `GAP-05` | `OBS` Camera & Battery UI | Contradictory `OBS` joystick text (`p79` vs `p81`) and `23.9/25.0 V` legacy screenshots vs `49-50 V` (`12S2P`) normative text | Anchor electrical models strictly to `12S2P` `36-50.4 V` (`49-50 V` launch pre-arm) | `[05_engineering_gaps_and_synthesis_ledger.md#s1]`, `[A5-user-manual 2.pdf#p56]`, `[#p79]`, `[#p81]` |
| `GAP-06` | ESAD RBF #3 Sequencing | Removing `ESAD R.B.F. #3` before UAV+ESAD power-on causes immediate ESAD fault | Formalize ordered lifecycle state machine (`RBF #2` ON before `RBF #3` removal) + STPA UCA | `[05_engineering_gaps_and_synthesis_ledger.md#s1]`, `[A5_prep and safety_rev7.pdf#p21]`, `[#p23]` |
| `GAP-07` | Safe Distance Wording | SwarmC2 (`p84`) writes "within safe distance" vs ESAD ICD (`p21,#p23`) `Safe Distance Exceed` / `SS2 Active` | Physical arming strictly requires exceeding minimum safe separation distance/timer (`Safe Distance Exceed == 1`) | `[05_engineering_gaps_and_synthesis_ledger.md#s1]`, `[A5-user-manual 2.pdf#p84]`, `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p21]` |
| `GAP-WCET` | Control Loop Timing & WCET | Unprinted OEM frequencies/WCET for `Cube orange+` EKF2, `CAN 1/2` bitrates, `HV6160`, `Septentrio`, `Trip6`, `RPI`, `SwarmC2` | Anchor grounded `100 Hz` (`0.01 s`) ESAD polling; mark control-loop RMA/WCET as mission-contract targets awaiting bench measurement | `[05_engineering_gaps_and_synthesis_ledger.md#s2.1]` |
| `GAP-REL` | Failure Rates & MTBF | Unprinted piece-part `lambda` / MTBF for avionics, actuators, battery, radio, gimbal, and ESAD FPGA/CPLD | Parameterize FMECA/FTA using conservative baselines from `docs/catalogs/FMECA_COMPONENT_CLASS_ROSTER_CATALOG.md` | `[05_engineering_gaps_and_synthesis_ledger.md#s2.2]` |
| `GAP-SEPDIST` | Safe-Separation & Fastener Torque | Unprinted numeric safe-separation distance (`m`), launch `g` threshold, arming timer (`s`), `M3` / `M6` torque, and `4980 g` holder datum units | Declare parameterized constraints in `schema/avenger5_uas/` requiring calibration sign-off before field arming | `[05_engineering_gaps_and_synthesis_ledger.md#s2.3]` |
| `GAP-ENV` | Energy, Thermal & Standoff | Unprinted battery energy (`Wh`/`Ah`), SoC RTL floor, ESC/motor current/thermal cutoffs, PL-40 tank volume (`L`), relief cracking pressure (`bar`), IP/rain/icing limits, numeric standoff (`m`) | Track as explicit calibration parameters / operational operating limits in SysML constraints | `[05_engineering_gaps_and_synthesis_ledger.md#s2.4]` |
| `GAP-SCRUB` | Emergency Scrub & Hangfire | Missing OEM scrub/unload procedure once `RBF #3` is removed, Main Valve `(4)` open, or carriage pin pulled, and missing hangfire wait time | Model `SAFE_SCRUB_ABORT` as dedicated Use Case, Safety Constraint, and Emergency Rule | `[05_engineering_gaps_and_synthesis_ledger.md#s2.5]`, `[UAV_launcher_PL-40_user_manual_rev_2.6.pdf#p26]`, `[A5_prep and safety_rev7.pdf#p23]` |
