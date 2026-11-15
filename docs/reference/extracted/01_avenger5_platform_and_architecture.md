# Avenger 5 Platform Specifications and Hardware Architecture (Extracted Baseline)

Source Documents:
- `docs/reference/AVENGER 5 Spec sheet_rev3.pdf` (4 pp.)
- `docs/reference/Avenger5_V2.5_block_diagram_rev5.pdf` (1 p., titled `AIR VEHICLE Avenger V2.5` / autopilot stack `ASTK A5 V2.5`)

Cross-Document Version Note:
- `AVENGER 5 Spec sheet_rev3.pdf` and `Avenger5_V2.5_block_diagram_rev5.pdf` (`Avenger V2.5`) state slightly higher speed envelopes (`31 m/s` cruise, `42 m/s` max horizontal, `24 m/s` stall, `80 m/s` max dive, `60/90 km` RLOS) than `A5-user-manual 2.pdf` (`AVENGER 5 V1`, `UDS-A5UM-001`, dated `2026-08-07`: `30 m/s` cruise, `38 m/s` max horizontal, `26 m/s` min speed, `55 m/s` max dive, `60/180 km` RLOS). Both sets are preserved verbatim with exact citations.

---

## 1. System Identification and Airframe Performance Envelope

| Subsystem | Parameter | Value | Unit | Limit / Qualifier | Citation |
| :--- | :--- | :--- | :--- | :--- | :--- |
| System | Product Designation (Spec Sheet) | AVENGER 5 (Precision Mid-range Strike UAV) | - | - | `[AVENGER 5 Spec sheet_rev3.pdf#p1]` |
| System | System Designation (Block Diagram) | AIR VEHICLE Avenger V2.5 (stack ASTK A5 V2.5) | - | - | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| System | OEM | UAB Unmanned Defense Systems (Company code 306079694, Vilnius, LT) | - | - | `[AVENGER 5 Spec sheet_rev3.pdf#p4]` |
| Airframe | Wingspan | 1.8 | m | Nominal (`1803` CAD) | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[A5-user-manual 2.pdf#p9]` |
| Airframe | Overall Length | 1.6 | m | Nominal (`1576` CAD) | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[A5-user-manual 2.pdf#p9]` |
| Airframe | Assembled Height | 1.1 | m | Nominal (`1095-1112` CAD) | `[A5-user-manual 2.pdf#p9]` |
| Airframe | MTOW | 17 | kg | Max takeoff weight | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[A5-user-manual 2.pdf#p9]` |
| Airframe | Max Lethal Package / Warhead Mass | 5 | kg | Max (`4980 +/- 20 g` tested holder unit) | `[AVENGER 5 Spec sheet_rev3.pdf#p2]`, `[A5_prep and safety_rev7.pdf#p10]` |
| Airframe | Aerodynamic Configuration | X-wing (4 wing panels, 4 tail ruddervators), rear foldable pusher prop | - | Yaw skid turns without banking | `[A5-user-manual 2.pdf#p8]`, `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| Performance | Endurance | 90 | min | Up to 90 min (ConOps/weather dependent) | `[AVENGER 5 Spec sheet_rev3.pdf#p2]`, `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| Performance | Cruise Speed (Spec Sheet / V1 Manual) | 31 / 30 | m/s | Nominal | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[A5-user-manual 2.pdf#p10]` |
| Performance | Max Horizontal Speed (Spec / V1) | 42 / 38 | m/s | Max | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[A5-user-manual 2.pdf#p10]` |
| Performance | Stall / Min Speed (Spec / V1) | 24 / 26 | m/s | Min | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[A5-user-manual 2.pdf#p10]` |
| Performance | Max Dive Speed (Spec / V1) | 80 / 55 | m/s | Max (`55 m/s` hard engagement cap in V1) | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[A5-user-manual 2.pdf#p88]` |
| Performance | Max Dive Angle (V1 Manual) | 22 | deg | Max | `[A5-user-manual 2.pdf#p10]` |
| Performance | Ground Wind Tolerance | 12 | m/s | Max | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| Performance | Cruise Wind Tolerance | 28 | m/s | Max | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| Performance | Service Ceiling | 5000 | m | Max | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| Performance | Operating Temperature Range | -20 to +50 | degC | Min / Max | `[AVENGER 5 Spec sheet_rev3.pdf#p3]` |
| Performance | Terminal Accuracy (CEP) | < 0.5 (< 50) | m (cm) | Stationary targets | `[AVENGER 5 Spec sheet_rev3.pdf#p1]`, `[AVENGER 5 Spec sheet_rev3.pdf#p2]` |
| Deployment | Launch Method | Pneumatic rail catapult (`PL-40`, `12 deg` rail) | - | Mechanically launched | `[AVENGER 5 Spec sheet_rev3.pdf#p1]`, `[A5-user-manual 2.pdf#p9]` |

---

## 2. Avionics, Power, Propulsion, Sensors, and Payloads (`Avenger5_V2.5_block_diagram_rev5.pdf#p1`)

| Subsystem | Component / Model | Key Parameter / Role | Electrical / Data Interface | Citation |
| :--- | :--- | :--- | :--- | :--- |
| Main Battery | `12S2P Li metal BEI` (cells: `maximus20`, removable) | `36-50.4 V` DC bus (`49-50 V` pre-flight check in V1) | Main DC bus via `200 A` automotive fuse | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]`, `[A5-user-manual 2.pdf#p56]` |
| Bus Protection | `200 A` Automotive Fuse | Main battery overcurrent protection | In-line Battery -> Power Meter | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| Power Meter | Integrated Voltage/Current Sensor + Main Switch | Controlled by `UAV R.B.F. Key` removal; switches UAV ON/OFF; feeds ESC & EPS | `CAN 1` <-> `Cube orange+`; `PWM ESC control` -> `ESC`; `UART` <- `ESC` | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| Motor & ESC | `IBEX160` ESC + `AXI 5345/16 HD GOLD LINE V3` BLDC Motor | Fully electric pusher propulsion | 3-phase power; `PWM ESC control` + `Telemetry UART` (RPM, ESC/mot temp, V, I) | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| Electronic Power System (`EPS`) | DC/DC Converters + Load Switches + MCU | Distributes regulated rails | `CAN 1`; `8 V` (x8 servos), `12 V` (`Radio`), `14 V` (`ESAD`), `50 V` (x2 RnD igniters), Pitot/Mag/Gimbal rails | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| Flight Controller | `Cube orange+` (inside `ASTK A5 V2.5` stack) | Primary flight stabilization, INS/EKF, autonomous navigation | `CAN 1`, `CAN 2`, `Serial` (`RPI`, `GNSS`, `Trip6`, `Radio`), `USB` (Ext) | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| Companion Compute | `RPI CM5004032` | SwarmC2 bridge, payload/ESAD supervisor | `ETH` <-> `ETH switch`; `Serial` <-> `Cube orange+`; `RS-485` + `Analog trigger (GPIO)` -> `ESAD` | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| Internal Network | `ETH switch` + `External Interface board (USB/ETH)` | Onboard IP switching and ground debug/config port | `ETH` <-> `RPI`, `Trip6`, `DTC Radio`, `Ext Board` | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| GNSS | `Septentrio Asterx-m3 pro` + `Talysman TW3972EXF` Antenna | GPS / GLONASS / GALILEO RTK-capable positioning | `Serial` <-> `Cube orange+`; coax RF <-> Antenna | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| Magnetometers + Baro | 2x `mRo RM3100` (each integrates barometric sensor) | Dual redundant heading and barometric altitude | `CAN 2` daisy-chain + `Mag Power` | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| Heated Pitot | `CUAV SKYE2` Airspeed Sensor | Built-in heating and water drainage | `CAN 2` end-node + `Pito power` | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| Actuation (Tail & Wing) | 4x `HV6160-DroneCAN` Fins (#1-#4); 4x `HV6160-DroneCAN` Wings (#5-#8) | Fins mixed pitch/yaw (skid-turn); wings active roll stabilization | Fins on `CAN 1` (`120 cm` stubs); Wings on `CAN 2` series daisy-chain via splitter PCB; `8 V` power | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| C2 Datalink Radio | `DTC 4.4-5 GHz` + 2x `MPSL4400` Antennas | `4.4-5.0 GHz`, `AES-256`, FHSS, `2 W` / `2x1 W`, `60/90 km` RLOS | `Radio power 12 V` (`8-17 V` input); `ETH` + `Serial` | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| EO/IR Seeker | `Nighthawk2UZ` Gimbal + `Trip6` Camera Compute | Day `1280x720` + Thermal `1280x720`, `X40` zoom, 2-axis (`P -45..+135 deg`, `Y/R +/-165 deg`), auto-track | `Power + HDMI` (`Trip6`<->`Gimbal`), `ETH` + `Serial` (`Trip6`<->`ASTK`) | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| Lethal Package (Optional/Mission) | `ESAD` + `Proximity sensor` + `Warhead` + `ESAD R.B.F Key` | All-electronic HV in-line safety/initiation train | `14 V` from `EPS`; `RS-485` + `GPIO trigger` from `RPI`; proximity trigger -> `ESAD` | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| Recovery (Optional RnD) | 2x Pyrotechnic Igniters | Burn-wire release of payload-bay parachute cover (RnD only) | `2x 50 V` lines from `EPS` (`Recovery System: No` on production Avenger 5) | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]`, `[A5-user-manual 2.pdf#p10]` |

---

## 3. Bus Topologies and Wire Harness Matrix (`Avenger5_V2.5_block_diagram_rev5.pdf#p1`)

| Bus / Harness | Endpoints & Topology | Physical / Protocol Characteristics | Citation |
| :--- | :--- | :--- | :--- |
| `Batt Power` (Red) | `Battery` -> `200 A Fuse` -> `Power meter` -> `ESC` & `EPS` | `36-50.4 V`; `970 cm` wire feed from `Power meter` to `EPS` | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `CAN 1` (DroneCAN) | `Cube orange+` <-> `EPS` tap <-> `Power meter` tap <-> 4-way split -> `Fin Servos #1-#4` | Multi-drop star/tap bus; `970 cm` trunk + `4x 120 cm` fin stubs | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `CAN 2` (DroneCAN) | `Cube orange+` -> `CAN/power splitter PCB` -> `Wings #5->#6->#7->#8` -> `Mag #2` -> `Mag #1` -> `CUAV SKYE2 Pitot` | Strictly series daisy-chain across wings and environmental sensors | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `ETH` Network | `ETH switch` <-> `{RPI CM5004032, Trip6, DTC Radio, External Interface USB/ETH}` | Switched IP telemetry/video/command fabric inside `ASTK A5 V2.5` | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `Serial` Links | `Cube orange+` <-> `RPI CM5004032`; `Cube` <-> `{Septentrio GNSS, Trip6, DTC Radio}` | Point-to-point UART/Serial links (no external baud rates stated) | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| `RS-485` + `Analog trigger` | `RPI CM5004032` -> `ESAD` | Differential bus (`115200 bps` per ESAD ICD) + GPIO arm/trigger line | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]`, `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p15]` |
| `ESC Telemetry UART` + `PWM` | `Power meter` -> `ESC (PWM)` ; `ESC` -> `Power meter (UART)` | Unidirectional PWM drive + UART RPM/ESC temp/motor temp/V/I feedback | `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| Ground Tactical / Fiber | `SwarmC2` tablet (`Windows 11`) + `Radio/Ground BOX` + `Rotator` + `MARS 23 dBi` antenna | Integrates with `SitaWare HQ`, `ATAK`, `DELTA`; `200 m` fiber spool option | `[AVENGER 5 Spec sheet_rev3.pdf#p3]`, `[A5-user-manual 2.pdf#p11]` |
