## 7. Operational Information Exchange (Op-Tx) Matrix

| Document Attribute | Specification |
| :--- | :--- |
| **Unit Title** | Operational Information Exchange (Op-Tx) Matrix |
| **Effective Date** | `2026-11-16` |
| **Document Version** | `1.0.0` |
| **System Baseline** | `Avenger5V25UasSystem` (`Avenger 5 V2.5 UAS` / `ASTK A5 V2.5` + `ELI Military Simulations PL-40 Rev 2.6` + `Artron ESAD AB00-0054-01AA-0005` + `SwarmC2`) |
| **JSON Schema Mapping** | `optx_exchanges` (`id`, `source_node`, `destination_node`, `information_element`, `throughput`, `max_latency`, `criticality`) |
| **Normative Governance** | `ISO/IEC/IEEE 29148:2018` §6.4.2-§6.4.3; `ISO/IEC/IEEE 15288:2023` §6.4.2-§6.4.4; `IEEE Std 1362-1998` §5.3; `OMG UAF v2.0` (Op-Tx / Rs-Tx); `RTCA DO-362A` §2.2, §3.2; `NATO STANAG 4187 Ed. 5`; `DoD Directive 3000.09` §4.1.a; `ASTM F3269-17` §5.2 |
| **SSOT Model Binding** | `.pipeline/schema.sysml` (`CONN_01` through `CONN_24`), `.pipeline/schema-digest.json` (`OpTx-01` through `OpTx-24`), `docs/architecture/views/sv1_platform_subsystems.mmd`, `schema/extracted/interface_table.md`, `schema/extracted/parametric_limits.md` |

---

### 7.1 Level 1B Operational Information Exchange Scope & Boundary Governance

In accordance with `OMG UAF v2.0` (`Operational Viewpoint Op-Tx` and `Resources Viewpoint Rs-Tx`), `ISO/IEC/IEEE 29148:2018` §6.4.2-§6.4.3, and `ISO/IEC/IEEE 15288:2023` §6.4.2-§6.4.4, Section 7 defines all `24` operational information, energy, and mechanical-coupling exchanges (`OpTx-01` through `OpTx-24`) executing across the `14` physical and ground subsystem assemblies of `Avenger5V25IntegratedSystem`. Every declared exchange maps in strict 1:1 bijection to a SysML v2 `connection def` node (`CONN_01` through `CONN_24`) in [`.pipeline/schema.sysml`](../../.pipeline/schema.sysml), [`.pipeline/schema-digest.json`](../../.pipeline/schema-digest.json), and [`docs/architecture/views/sv1_platform_subsystems.mmd`](../../docs/architecture/views/sv1_platform_subsystems.mmd).

**Strict Level 1B Operational Abstraction & Architectural Invariants:**
- **Level 1B vs. Level 1C ICD Firewall:** Section 7 specifies operational exchange payloads, functional supervision semantics, throughput/latency budgets, and safety criticalities at Level 1B ConOps scope (`OA-01` through `OA-19` and `SCN-01` through `SCN-08`). Component-internal serial hex opcodes, connector shell/pinout assignments, wire gauges, register bitmasks, and cyclic redundancy polynomial equations are strictly excluded from ConOps and reside exclusively in Level 1C Interface Control Documents (`ICD_01_SYSTEM_INTERFACE_MATRIX.md` and `ICD_02_MASTER_SIGNAL_DICTIONARY.md`).
- **Software-Hosted Simplex RTA & Bus Isolation (`standaloneRtaBoxCount == 0`):** Flight envelope clamping (`ASTM F3269-17` §5.2) executes in software inside `FlightControllerCubeOrangePlus` (`Cube orange+`), while ordnance protocol supervision executes inside `CompanionComputeRpiCm5` (`RPI CM5004032`). Onboard actuation and sensing remain physically partitioned across `CAN 1` (`OpTx-09`, `OpTx-10`, `OpTx-11`) and `CAN 2` (`OpTx-12`, `OpTx-13`).
- **Purely Mechanical Launcher Boundary (`IF-MECH-001`):** `OpTx-23` (`CONN_23`) transfers strictly mechanical rail-launch acceleration between `Pl40PneumaticLauncher` and `ElectricPropulsionUnit` (`electricalWireToUavCount == 0`), imparting rigid-body launch acceleration (`OpTx-24` / `CONN_24`) to the `ArtronEsadAndSensorUnit` inertial `SS1` barrier with zero electrical or CAN conductors crossing the rail.
- **Grounded Timing vs. `GAP-WCET` Bench Disposition (`REQ_SAF_08`):** Only the `RPI CM5004032` to `Artron ESAD` supervisory cycle (`OpTx-20`) carries OEM-printed timing limits (`100.0 Hz` / `0.01 s` polling, `<= 5.0 ms` reply ceiling, `<= 10.0 ms` incomplete-frame watchdog timeout per `GAP-04`) alongside grounded C2/operator timers (`105.0 s` `GCS Failsafe` RTL timeout, `2.0 min` telemetry detection window, `>= 2.0 s` dual-switch firing hold, `2.0-5.0 s` EO track hold, and `>= 5.0 s` ESAD self-destruct hold). Unprinted OEM DroneCAN bitrates, EKF2 rates, UART baud/WCET budgets, Trip6 tracker latency, and RF round-trip jitter are explicitly designated `Unprinted (GAP-WCET)` for bench verification rather than fabricated.
- **Zero Production Parachute & Power Grounding (`GAP-01`, `GAP-05`, `GAP-06`):** Production `Avenger 5 V2.5` excludes recovery parachutes (`rndRecoveryOptionInstalled == false`; `2x 50.0 V` EPS lines inhibited). Primary DC exchanges anchor strictly to `12S2P` `36.0-50.4 V` (`49.0-50.0 V` pre-flight check rejecting legacy `24-25 V` UI values), enforce `RBF #2` power-before-pull `RBF #3`, and supervise `OpTx-06` (`14.0 V` ESAD rail with `0.0 V` brownout margin) on `OpTx-10` and `OpTx-14`.

---

### 7.2 Complete Operational Information Exchange Matrix (`OpTx-01` through `OpTx-24`)

Table 7.1 enumerates 100% of the `24` operational exchanges declared in `.pipeline/schema-digest.json` (`OpTx-01` through `OpTx-24`) aligned 1:1 with `CONN_01` through `CONN_24` in `.pipeline/schema.sysml`. Table 7.2 isolates all grounded quantitative rate, timing, voltage, and physical threshold values into strictly separated numeric `Value` and unit-only `Units` columns.

#### Table 7.1: Operational Information Exchange (Op-Tx) Matrix (`24` of `24` AST Connection Parity)

| Op-Tx ID | Bound Connection & IF | Source Node (`Port`) | Destination Node (`Port`) | Information Element & Bound Operational Activities | Throughput / Exchange Regime | Max Latency / Timeout Budget | Criticality |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `OpTx-01` | `CONN_01` (`IF-PWR-001`, `IF-PWR-002`, `IF-PWR-003`) | `MainBatteryAndFuseUnit` (`protectedDcOut`) | `PowerMeterAndRbfSwitch` (`mainDcIn`) | Fuse-protected `12S2P` main DC bus energy (`36.0-50.4 V` operating, `49.0-50.0 V` pre-flight, `200.0 A` fuse) gated by `RBF #2` switch closure (`OA-01`, `OA-04`) | Continuous unregulated DC power transfer; `RBF #2` discrete state transition on pull | Immediate electrical energization upon `RBF #2` removal (`GAP-05`, `GAP-06`) | Catastrophic (DAL-A Equivalent; `REQ_L_01`, `REQ_L_02`, `REQ_H_01`) |
| `OpTx-02` | `CONN_02` (`IF-PWR-004`, `IF-PWR-005`, `IF-PWM-001`, `IF-SER-005`) | `PowerMeterAndRbfSwitch` (`escDriveOut`) | `ElectricPropulsionUnit` (`escDriveIn`) | Bidirectional propulsion bus: switched `36.0-50.4 V` DC and unidirectional throttle PWM command to `IBEX160` ESC; unidirectional ESC UART telemetry return (RPM, ESC/motor temp, voltage, current) (`OA-02`) | Continuous DC propulsion feed; PWM throttle and ESC UART telemetry rate `Unprinted (GAP-WCET)` | Thermal/RPM control latency `Unprinted (GAP-WCET)` (`REQ_SAF_08`) | Hazardous (DAL-B Equivalent; `REQ_L_02`, `REQ_H_02`) |
| `OpTx-03` | `CONN_03` (`IF-PWR-006`) | `PowerMeterAndRbfSwitch` (`trunkDcOut970cm`) | `ElectronicPowerSystemEps` (`trunkDcIn`) | Main unregulated `12S2P` DC trunk energy (`36.0-50.4 V` over `970.0 cm` trunk harness) feeding EPS converters and load switches (`OA-01`, `OA-03`, `OA-04`) | Continuous unregulated DC trunk power transfer | Continuous supply; trunk `I * R` sag monitored for `GAP-01` brownout | Catastrophic (DAL-A Equivalent; `REQ_L_02`, `REQ_H_02`) |
| `OpTx-04` | `CONN_04` (`IF-PWR-007`) | `ElectronicPowerSystemEps` (`servo8VOut`) | `DroneCanSurfaceActuation` (`servo8VIn`) | Regulated `8.0 V` DC servo actuation rail powering `4x` tail ruddervators (`#1` through `#4`) and `4x` wing roll servos (`#5` through `#8`) (`OA-03`, `OA-09`) | Continuous regulated DC actuator rail (`8.0 V` nominal) | Continuous regulation across full aerodynamic surface load transients | Catastrophic (DAL-A Equivalent; `REQ_L_02`, `REQ_H_03`) |
| `OpTx-05` | `CONN_05` (`IF-PWR-008`) | `ElectronicPowerSystemEps` (`radio12VOut`) | `OnboardEthernetAndC2RadioUnit` (`radio12VIn`) | Regulated `12.0 V` DC datalink rail (`8.0-17.0 V` radio tolerance) powering airborne `DTC` `4.4-5.0 GHz` transceiver and onboard `ETH` switch (`OA-03`, `OA-14`) | Continuous regulated DC comms rail (`12.0 V` nominal) | Continuous regulation sustaining `2.0 W` RF transmission | Hazardous (DAL-B Equivalent; `REQ_L_03`, `REQ_H_05`) |
| `OpTx-06` | `CONN_06` (`IF-PWR-009`) | `ElectronicPowerSystemEps` (`esad14VOut`) | `ArtronEsadAndSensorUnit` (`esad14VIn`) | Switchable regulated `14.0 V` ordnance supply (`14.0-32.0 V` ICD band, `0.0 V` brownout margin per `GAP-01`) and irreversible `Power Off ESAD` rail cutoff (`OA-03`, `OA-10`, `OA-12`, `OA-17`) | Continuous `14.0 V` DC rail during authorized sortie; event-driven load-switch cutoff on abort | Zero undetected brownout below `14.0 V`; immediate load-switch cutoff on `Power Off ESAD` | Catastrophic (DAL-A Equivalent; `REQ_L_01`, `REQ_L_04`, `REQ_H_02`, `REQ_H_04`) |
| `OpTx-07` | `CONN_07` (`IF-PWR-011`) | `ElectronicPowerSystemEps` (`sensorPowerOut`) | `NavigationAndAirDataSuite` (`sensorPowerIn`) | Regulated sensor DC rails powering dual `mRo RM3100` magnetometers/barometers and heated `CUAV SKYE2` pitot tube (`OA-03`, `OA-06`, `OA-07`) | Continuous regulated DC sensor rail | Continuous regulation sustaining GNSS-denied DR instrumentation | Hazardous (DAL-B Equivalent; `REQ_L_03`, `REQ_H_03`) |
| `OpTx-08` | `CONN_08` (`IF-PWR-011`) | `ElectronicPowerSystemEps` (`gimbalPowerOut`) | `EoIrSeekerAndTrackerUnit` (`gimbalPowerIn`) | Regulated payload gimbal DC power feeding `Trip6` camera compute and `Nighthawk2UZ` 2-axis stabilized EO/IR gimbal (`OA-03`, `OA-13`, `OA-14`) | Continuous regulated DC gimbal rail; switched cycle on `Reboot Gimbal` | Continuous regulation; deterministic power reset on `Reboot Gimbal` | Major (DAL-C Equivalent; `REQ_L_03`, `REQ_H_05`) |
| `OpTx-09` | `CONN_09` (`IF-CAN1-001`) | `FlightControllerCubeOrangePlus` (`can1Master`) | `PowerMeterAndRbfSwitch` (`can1Tap`) | Bidirectional DroneCAN Bus 1 multi-drop tap: main `12S2P` voltage/current, `0.20` Bingo reserve status (`1080.0 s` floor), `36.0 V` sag alert, and bridged `IBEX160` ESC telemetry (`OA-01`, `OA-02`, `OA-04`) | DroneCAN Bus 1 bitrate and frame rate `Unprinted (GAP-WCET)` | `CAN 1` telemetry latency `Unprinted (GAP-WCET)` (`REQ_SAF_08`) | Hazardous (DAL-B Equivalent; `REQ_L_02`, `REQ_H_02`) |
| `OpTx-10` | `CONN_10` (`IF-CAN1-001`) | `FlightControllerCubeOrangePlus` (`can1Master`) | `ElectronicPowerSystemEps` (`can1Tap`) | Bidirectional DroneCAN Bus 1 multi-drop tap: `EPS` rail health telemetry, `14.0 V` ESAD brownout alert (`GAP-01`), and `Power Off ESAD` load-switch isolation command (`OA-03`, `OA-12`, `OA-17`) | DroneCAN Bus 1 bitrate and supervision cycle `Unprinted (GAP-WCET)` | Rail-fault isolation latency `Unprinted (GAP-WCET)` (`REQ_SAF_01`, `REQ_SAF_08`) | Catastrophic (DAL-A Equivalent; `REQ_L_01`, `REQ_L_04`, `REQ_H_02`) |
| `OpTx-11` | `CONN_11` (`IF-CAN1-001`) | `FlightControllerCubeOrangePlus` (`can1Master`) | `DroneCanSurfaceActuation` (`can1TailFins`) | Bidirectional DroneCAN Bus 1 (`4x 120.0 cm` stubs): mixed pitch/yaw skid-turn servo commands and actuator position/health feedback for tail ruddervators `#1` through `#4` (`OA-05`, `OA-09`) | DroneCAN Bus 1 actuator loop rate `Unprinted (GAP-WCET)` | Closed-loop tail actuation latency `Unprinted (GAP-WCET)` (`REQ_SAF_08`) | Catastrophic (DAL-A Equivalent; `REQ_L_02`, `REQ_H_03`) |
| `OpTx-12` | `CONN_12` (`IF-CAN2-001`) | `FlightControllerCubeOrangePlus` (`can2Master`) | `DroneCanSurfaceActuation` (`can2SplitterIn`) | Bidirectional isolated DroneCAN Bus 2 (`CAN/power splitter PCB`): active roll stabilization commands and actuator feedback for wing panels `#5` through `#8` plus upstream sensor relay (`OA-05`, `OA-09`) | DroneCAN Bus 2 actuator loop rate `Unprinted (GAP-WCET)` | Closed-loop wing actuation latency `Unprinted (GAP-WCET)` (`REQ_SAF_08`) | Catastrophic (DAL-A Equivalent; `REQ_L_02`, `REQ_H_03`) |
| `OpTx-13` | `CONN_13` (`IF-CAN2-001`) | `DroneCanSurfaceActuation` (`can2DaisyOutToSensors`) | `NavigationAndAirDataSuite` (`can2DaisyIn`) | Bidirectional DroneCAN Bus 2 series daisy-chain: dual `mRo RM3100` magnetometer/barometer states and `CUAV SKYE2` airspeed (`<= 3.0 m/s` calm / `>= 10.0 m/s` airflow check) (`OA-06`, `OA-07`) | DroneCAN Bus 2 sensor daisy-chain rate `Unprinted (GAP-WCET)` | Air-data / heading transport latency `Unprinted (GAP-WCET)` (`REQ_SAF_08`) | Catastrophic (DAL-A Equivalent; `REQ_L_02`, `REQ_L_03`, `REQ_H_03`) |
| `OpTx-14` | `CONN_14` (`IF-SER-001`) | `FlightControllerCubeOrangePlus` (`serialRpi`) | `CompanionComputeRpiCm5` (`serialFc`) | Bidirectional point-to-point internal UART serial: autopilot flight state, Simplex RTA abort/RTL directives, and companion-relayed ESAD bus fault and arm-status telemetry (`OA-05`, `OA-08`, `OA-12`) | Point-to-point UART baud/rate `Unprinted (GAP-WCET)` | Autopilot-to-companion coordination WCET `Unprinted (GAP-WCET)` (`REQ_SAF_08`) | Catastrophic (DAL-A Equivalent; `REQ_L_03`, `REQ_L_04`, `REQ_H_03`, `REQ_H_04`) |
| `OpTx-15` | `CONN_15` (`IF-SER-002`) | `FlightControllerCubeOrangePlus` (`serialGnss`) | `NavigationAndAirDataSuite` (`serialGnss`) | Bidirectional point-to-point UART serial: `Septentrio Asterx-m3 pro` RTK GNSS PVT navigation stream and `Disable GNSS` INS/DR mode switching control (`OA-06`, `OA-07`) | GNSS serial solution rate `Unprinted (GAP-WCET)` | PVT fix / failover latency `Unprinted (GAP-WCET)` (`REQ_SAF_08`) | Hazardous (DAL-B Equivalent; `REQ_L_03`, `REQ_H_03`) |
| `OpTx-16` | `CONN_16` (`IF-SER-003`) | `FlightControllerCubeOrangePlus` (`serialTrip6`) | `EoIrSeekerAndTrackerUnit` (`serialFc`) | Bidirectional point-to-point UART serial: `Trip6` terminal target lock (`2.0-5.0 s` hold), dive steering vectors (`<= 55.0 m/s` cap, `<= 0.5 m` CEP), INS attitude aid, and `Abort Engaging` (`OA-05`, `OA-13`) | Tracker serial steering rate `Unprinted (GAP-WCET)` | Seeker-to-autopilot guidance latency `Unprinted (GAP-WCET)` (`REQ_SAF_08`) | Catastrophic (DAL-A Equivalent; `REQ_L_04`, `REQ_H_05`) |
| `OpTx-17` | `CONN_17` (`IF-SER-004`, `IF-USB-001`) | `FlightControllerCubeOrangePlus` (`serialRadioAndUsbExt`) | `OnboardEthernetAndC2RadioUnit` (`fcSerialAndUsbExt`) | Bidirectional autopilot serial C2 stream to `DTC` radio plus ground USB firmware/log service behind lockable umbilical lid (`OA-05`, `OA-14`, `OA-18`) | Autopilot-to-radio serial rate `Unprinted (GAP-WCET)`; USB ground service only | Serial C2 forwarding latency `Unprinted (GAP-WCET)` (`REQ_SAF_08`) | Hazardous (DAL-B Equivalent; `REQ_L_03`, `REQ_H_05`) |
| `OpTx-18` | `CONN_18` (`IF-ETH-001`) | `CompanionComputeRpiCm5` (`ethSwitch`) | `OnboardEthernetAndC2RadioUnit` (`ethRpiPort`) | Bidirectional switched onboard Ethernet IP: `SwarmC2` mission directives, `RBF #3` / ESAD status, positive HITL arm/abort/self-destruct authorizations, and ground service ETH (`OA-08`, `OA-11`, `OA-12`, `OA-14`) | Switched onboard Ethernet IP; bandwidth/jitter `Unprinted (GAP-WCET)` | Companion Ethernet bridge latency `Unprinted (GAP-WCET)` (`REQ_SAF_08`) | Catastrophic (DAL-A Equivalent; `REQ_L_03`, `REQ_L_04`, `REQ_H_04`) |
| `OpTx-19` | `CONN_19` (`IF-ETH-001`) | `EoIrSeekerAndTrackerUnit` (`ethSwitch`) | `OnboardEthernetAndC2RadioUnit` (`ethTrip6Port`) | Bidirectional switched onboard Ethernet IP: `1280x720` Day and Thermal EO/IR video streams (`X40` zoom), gimbal cues, and in-flight `Reboot Gimbal` recovery command (`OA-13`, `OA-14`) | Switched Ethernet HD Day/Thermal video; exact bitrate `Unprinted (GAP-WCET)` | Video encoding and Ethernet transport latency `Unprinted (GAP-WCET)` | Hazardous (DAL-B Equivalent; `REQ_L_03`, `REQ_H_05`) |
| `OpTx-20` | `CONN_20` (`IF-ORD-001`, `IF-ORD-002`) | `CompanionComputeRpiCm5` (`esadOcControl`) | `ArtronEsadAndSensorUnit` (`ocControlIn`) | Level 1B supervised ESAD command/status cycle (`100.0 Hz` / `0.01 s`), PBIT safe-HV confirmation (`< 50.0 V`), high-voltage charge authorization (`0.0-1800.0 V` gated by `SS1`/`SS2`), abort/self-destruct supervision, and Stage 2 hardware arm discrete (`1000.0 Hz`, `2` pulses) (`OA-08`, `OA-10`, `OA-11`, `OA-12`) | `100.0 Hz` (`0.01 s` cycle) RS-485 cyclic supervision + `1000.0 Hz` (`2` pulses) Stage 2 discrete arm enable (`GAP-04`) | `<= 5.0 ms` ESAD reply latency; `<= 10.0 ms` incomplete-packet / watchdog lockout timeout (`GAP-04`) | Catastrophic (DAL-A Equivalent; `REQ_L_01`, `REQ_L_04`, `REQ_H_04`) |
| `OpTx-21` | `CONN_21` (`IF-RF-001`) | `OnboardEthernetAndC2RadioUnit` (`rfDatalinkOut`) | `GroundRfStationAndAntennaTracker` (`rfAirPort`) | Over-the-air `4.4-5.0 GHz` `AES-256` FHSS (`2.0 W` / `2x 1.0 W`, `60.0/90.0 km` RLOS) bidirectional C2 uplink, flight/ESAD telemetry downlink, and `1280x720` EO/IR video (`OA-07`, `OA-12`, `OA-13`, `OA-18`) | `4.4-5.0 GHz` encrypted RF link; exact net throughput `Unprinted (GAP-WCET)` | `2.0 min` (`120.0 s`) telemetry detect timeout; `105.0 s` `GCS Failsafe` RTL + `Disarm ESAD On GCS Timeout` | Catastrophic (DAL-A Equivalent; `REQ_L_03`, `REQ_L_04`, `REQ_H_05`) |
| `OpTx-22` | `CONN_22` (`IF-GND-001`) | `SwarmC2OperatorConsole` (`gcsStationPort`) | `GroundRfStationAndAntennaTracker` (`gcsStationPort`) | Bidirectional wired IP or optional `200.0 m` tactical fiber spool carrying role-authenticated C2 directives (`>= 8` chars), telemetry/video display, and `Antenna Rotator` (`Auto Follow` + `0.5 deg` step) control (`OA-18`, `OA-19`) | Wired IP / `200.0 m` fiber spool link; tablet round-trip jitter `Unprinted (GAP-WCET)` | Ground link latency `Unprinted (GAP-WCET)`; `>= 5.0 s` ESAD abort hold enforced at HMI | Catastrophic (DAL-A Equivalent; `REQ_L_01`, `REQ_L_03`, `REQ_L_04`, `REQ_H_05`) |
| `OpTx-23` | `CONN_23` (`IF-MECH-001`) | `Pl40PneumaticLauncher` (`mechLaunchOut`) | `ElectricPropulsionUnit` (`mechLaunchRailIn`) | Purely mechanical catapult impulse across `5.0 m` (`12.0 deg` elevation) rail at `13.0-14.0 bar`, delivering `~23.0 m/s` (`22.7-23.5 m/s` at `17.0 kg`, `<= 25.0 m/s` cap) with `0` electrical/CAN conductors (`OA-15`, `OA-16`, `OA-17`) | Event-driven pneumatic launch stroke (`>= 2.0 s` dual-switch hold; `<= 8.0 min` tank charge) | Instantaneous mechanical carriage impulse across `5.0 m` stroke (`GAP-03`, `GAP-SCRUB`) | Catastrophic (DAL-A Equivalent; `REQ_L_01`, `REQ_L_02`, `REQ_H_01`, `REQ_H_06`) |
| `OpTx-24` | `CONN_24` (Rigid-Body Mechanical) | `ElectricPropulsionUnit` (`inertialSs1Out`) | `ArtronEsadAndSensorUnit` (`inertialSs1In`) | Rigid-body longitudinal launch acceleration pulse (`SS1`) transmitted mechanically through airframe structure to trigger the ESAD inertial first safety barrier (`0` wires) (`OA-11`, `OA-16`) | Event-driven physical inertial acceleration impulse (`0.0039 g/LSB` sense scale) | Real-time physical rigid-body coupling; numeric launch `g` threshold tracked under `GAP-SEPDIST` | Catastrophic (DAL-A Equivalent; `REQ_L_01`, `REQ_L_04`, `REQ_H_04`) |

#### Table 7.2: Grounded Op-Tx Quantitative Exchange Thresholds & Timing Envelopes

| Param ID | Bound Op-Tx | Quantitative Parameter | Value | Units | Constraint / Gap Disposition |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `PRM-AV-001` | `OpTx-01`, `OpTx-03` | Main `12S2P` Bus Operating Voltage Range | 36.0-50.4 | V | Continuous operating bus (`PRM-AV-002` upper limit) |
| `PRM-AV-003` | `OpTx-01` | Pre-Flight Battery Check Acceptance Window | 49.0-50.0 | V | Rejects legacy `24-25 V` UI values (`GAP-05`) |
| `PRM-AV-005` | `OpTx-01` | Main Inline Automotive Fuse Current Rating | 200.0 | A | Overcurrent protection upstream of `Power Meter` |
| `PRM-PERF-003` | `OpTx-09` | Statutory Bingo Energy Reserve Floor Ratio | 0.20 | ratio | Triggers RTL at `1080.0` s remaining of `5400.0` s (`MET-02`) |
| `PRM-AV-006` | `OpTx-04` | Regulated EPS Servo Actuation Rail Voltage | 8.0 | V | Feeds `8x HV6160-DroneCAN` tail and wing actuators |
| `PRM-AV-007` | `OpTx-05` | Regulated EPS C2 Radio Rail Voltage | 12.0 | V | Within `8.0-17.0` V `DTC` radio supply tolerance |
| `PRM-AV-010` | `OpTx-06` | Regulated EPS ESAD Supply Voltage (`GAP-01`) | 14.0 | V | Zero brownout margin above `14.0` V ESAD `VDC_IN` minimum |
| `PRM-AV-012` | `OpTx-03`, `OpTx-09` | Fuselage Main DC and `CAN 1` Trunk Length | 970.0 | cm | Parallel power and `CAN 1` fuselage trunk routing |
| `PRM-AV-013` | `OpTx-11` | Tail Fin Servo `CAN 1` Stub Length (`4x`) | 120.0 | cm | `4x` multi-drop stubs feeding ruddervators `#1` through `#4` |
| `PRM-AV-017` | `OpTx-13` | Pitot Pre-Flight Calm-Air Indicated Speed Max | 3.0 | m/s | `OA-06` pre-flight `CUAV SKYE2` sanity check ceiling |
| `PRM-AV-018` | `OpTx-13` | Pitot Pre-Flight Airflow Check Speed Min | 10.0 | m/s | `OA-06` indirect airflow verification threshold |
| `PRM-PERF-010` | `OpTx-11`, `OpTx-16` | Software Simplex RTA Engagement Speed Cap | 55.0 | m/s | Exceeding forces `Abort Engaging` (`80.0` m/s structural `VNE`) |
| `PRM-AV-019` | `OpTx-19`, `OpTx-21` | EO/IR Day and Thermal Video Horizontal Pixels | 1280 | px | Paired with `720` px vertical and `40.0`x optical/digital zoom |
| `PRM-ESAD-017` | `OpTx-20` | ESAD Supervisory Cyclic Polling Frequency | 100.0 | Hz | Equivalent `0.01` s period (`GAP-04` anchored baseline) |
| `PRM-ESAD-020` | `OpTx-20` | ESAD Supervisory Reply Maximum Latency | 5.0 | ms | End-of-command to end-of-reply ceiling (`GAP-04`) |
| `PRM-ESAD-019` | `OpTx-20` | ESAD Incomplete-Packet / Watchdog Timeout | 10.0 | ms | Triggers deterministic fault lockout / safe abort (`GAP-04`) |
| `PRM-ESAD-006` | `OpTx-20` | Arm Stage 2 Discrete (`DSC_IN1`) Pulse Rate | 1000.0 | Hz | `2` pulses (`1.0` ms period, `50.0` percent duty) gated to Stage 2 |
| `PRM-ESAD-029` | `OpTx-20` | PBIT Safe Internal High-Voltage Ceiling | 50.0 | V | Pre-flight PBIT strictly below `50.0` V (`0.0-1800.0` V HV firing output max) |
| `PRM-RF-001` | `OpTx-21` | Airborne and Ground `DTC` RF Operating Band | 4.4-5.0 | GHz | `AES-256` FHSS at `2.0` W total (`60.0` / `90.0` km RLOS) |
| `PRM-GCS-008` | `OpTx-21`, `OpTx-22` | `GCS Failsafe` Lost-Link RTL Timeout Baseline | 105.0 | s | Triggers autonomous RTL plus `Disarm ESAD On GCS Timeout` |
| `PRM-GCS-002` | `OpTx-21`, `OpTx-22` | Power-On Telemetry Acquisition Timeout | 2.0 | min | Maximum wait (`120.0` s) after `RBF #2` energization |
| `PRM-RF-012` | `OpTx-22` | Optional Ground Tactical Fiber Optic Spool | 200.0 | m | Remotes `Ground Radio Box` from `SwarmC2` tablet (`0.5` deg step) |
| `PRM-PL40-003` | `OpTx-23` | Interpolated PL-40 Exit Velocity (`17.0 kg` MTOW) | 23.0 | m/s | `22.7-23.5` m/s band (`<= 25.0` m/s cap at `13.0-14.0` bar, `GAP-03`) |
| `PRM-PL40-037` | `OpTx-23` | Dual-Switch Simultaneous Launch Firing Hold Min | 2.0 | s | Held simultaneously after `Main Valve 4` open and pin pull |
| `PRM-AF-008` | `OpTx-23`, `OpTx-24` | Electrical / CAN Conductors Across `PL-40` Rail | 0 | count | Strictly mechanical `IF-MECH-001` (`CONN_23`, `CONN_24`) |

---

### 7.3 Operational Information Exchange Interaction Sequences (`Diagram 10.1` through `Diagram 10.4`)

In compliance with the **100% Op-Tx Interaction Sequence Parity Invariant**, all `24` declared exchanges (`OpTx-01` through `OpTx-24`) are partitioned deterministically across four `OMG UAF v2.0` / `ISO/IEC/IEEE 29148:2018` §6.4.2 Mermaid `sequenceDiagram` specifications (`Diagram 10.1` through `Diagram 10.4`) with zero uncovered exchanges and strict Human-in-the-Loop (HITL) temporal safety precedence (`DoD Directive 3000.09` §4.1.a).

#### 7.3.1 Diagram 10.1: Power, Launch & Propulsion Exchange Sequence (`OpTx-01` through `OpTx-08`, `OpTx-23`, `OpTx-24`)

This interaction thread traces primary `12S2P` DC power distribution (`OpTx-01`, `OpTx-03` through `OpTx-08`), HITL propulsion authorization and ESC telemetry return (`OpTx-02`), zero-wire pneumatic catapult release (`OpTx-23`), rigid-body inertial `SS1` launch sensing (`OpTx-24`), and HITL-authorized ESAD rail isolation (`OpTx-06`).

```mermaid
sequenceDiagram
    autonumber
    actor LaunchAsst as "UCL-03 Launch Assistant"
    actor PilotOp as "UCL-01 Pilot Operator"
    participant SwarmC2 as "SwarmC2OperatorConsole"
    participant MainBatt as "MainBatteryAndFuseUnit"
    participant PowerRbf as "PowerMeterAndRbfSwitch"
    participant EpsUnit as "ElectronicPowerSystemEps"
    participant PropUnit as "ElectricPropulsionUnit"
    participant Pl40Rail as "Pl40PneumaticLauncher"
    participant CanActuators as "DroneCanSurfaceActuation"
    participant CommsRadio as "OnboardEthernetAndC2RadioUnit"
    participant NavSuite as "NavigationAndAirDataSuite"
    participant EoIrSeeker as "EoIrSeekerAndTrackerUnit"
    participant EsadUnit as "ArtronEsadAndSensorUnit"

    Note over LaunchAsst,EsadUnit: Phase 1 HITL ESD Grounding and RBF Power Before Pull Sequence
    LaunchAsst ->> PowerRbf: Touch_ESD_Remove_RBF1_Fold_Prop_Pull_RBF2
    MainBatt ->> PowerRbf: OpTx-01 Protected_12S2P_DC_Bus_49_to_50V_Preflight
    PowerRbf ->> EpsUnit: OpTx-03 Main_970cm_DC_Trunk_36_to_50p4V
    EpsUnit ->> CanActuators: OpTx-04 Regulated_8V_Servo_Power_Rail
    EpsUnit ->> CommsRadio: OpTx-05 Regulated_12V_DTC_Radio_Power_Rail
    EpsUnit ->> EsadUnit: OpTx-06 Regulated_14V_ESAD_Rail_RBF3_Installed
    EpsUnit ->> NavSuite: OpTx-07 Regulated_Sensor_Power_RM3100_and_Pitot
    EpsUnit ->> EoIrSeeker: OpTx-08 Regulated_Gimbal_and_Seeker_Power

    Note over LaunchAsst,EsadUnit: Phase 2 HITL GoNoGo Authorization and Pusher Propulsion Drive
    PilotOp ->> SwarmC2: Authorize_Preflight_BIT_and_Propulsion_Check
    SwarmC2 -->> LaunchAsst: Eight_Preconditions_Passed_Cleared_for_RBF3_and_Rail
    PilotOp ->> PowerRbf: Authorize_Armed_Pusher_Throttle_Consent_Token
    PowerRbf ->> PropUnit: OpTx-02 Switched_DC_and_Throttle_PWM_Drive
    PropUnit -->> PowerRbf: OpTx-02 ESC_UART_RPM_Temp_Voltage_Current_Return

    Note over LaunchAsst,EsadUnit: Phase 3 HITL Dual Switch Launch and Mechanical Inertial SS1
    LaunchAsst ->> Pl40Rail: Verify_13_to_14bar_Pull_Pin_Open_Valve4_Hold_Dual_2s
    Pl40Rail ->> PropUnit: OpTx-23 Mechanical_Launch_Impulse_Zero_Wires_23mps
    PropUnit ->> EsadUnit: OpTx-24 Rigid_Body_Inertial_SS1_Launch_Accel_Pulse

    Note over LaunchAsst,EsadUnit: Phase 4 HITL Irreversible ESAD Rail Isolation on Abort or Scrub
    PilotOp ->> SwarmC2: Command_Power_Off_ESAD_or_Safe_Scrub_Isolation
    SwarmC2 ->> EpsUnit: Authorize_Irreversible_ESAD_Load_Switch_Cutoff
    EpsUnit ->> EsadUnit: OpTx-06 Isolate_14V_ESAD_Rail_Deenergize_Safe
```

#### 7.3.2 Diagram 10.2: Flight Control, Segregated DroneCAN & Navigation Sequence (`OpTx-09` through `OpTx-16`)

This interaction thread traces physically segregated `CAN 1` (`OpTx-09`, `OpTx-10`, `OpTx-11`) and `CAN 2` (`OpTx-12`, `OpTx-13`) buses, software-hosted `ASTM F3269-17` Simplex RTA supervision inside `FlightControllerCubeOrangePlus`, point-to-point UART exchanges (`OpTx-14`, `OpTx-15`, `OpTx-16`), and HITL-authorized GNSS-denied dead-reckoning and terminal engagement steering.

```mermaid
sequenceDiagram
    autonumber
    actor PilotOp as "UCL-01 Pilot Operator"
    actor PayloadOp as "UCL-02 Payload Operator"
    participant SwarmC2 as "SwarmC2OperatorConsole"
    participant CubeFc as "FlightControllerCubeOrangePlus"
    participant PowerRbf as "PowerMeterAndRbfSwitch"
    participant EpsUnit as "ElectronicPowerSystemEps"
    participant CanActuators as "DroneCanSurfaceActuation"
    participant NavSuite as "NavigationAndAirDataSuite"
    participant RpiMaster as "CompanionComputeRpiCm5"
    participant EoIrSeeker as "EoIrSeekerAndTrackerUnit"

    Note over PilotOp,EoIrSeeker: Phase 1 HITL Mission Upload and Dual Bus Preflight Verification
    PilotOp ->> SwarmC2: Authenticate_and_Authorize_Mission_Plan_Upload
    SwarmC2 ->> CubeFc: Upload_Corridor_50_to_3000m_Loiter_300m_Geofence
    PowerRbf ->> CubeFc: OpTx-09 CAN1_Bus_V_I_ESC_and_Bingo_Reserve_Telem
    EpsUnit ->> CubeFc: OpTx-10 CAN1_EPS_Rail_Health_and_14V_Brownout_Status
    NavSuite ->> CubeFc: OpTx-15 UART_RTK_GNSS_PVT_Navigation_Stream
    NavSuite -->> CanActuators: OpTx-13 CAN2_Daisy_Dual_RM3100_and_SKYE2_Pitot_BIT
    CanActuators -->> CubeFc: OpTx-12 CAN2_Splitter_Wing_Servos_and_AirData_Return

    Note over PilotOp,EoIrSeeker: Phase 2 HITL Sortie Authorization and Segregated CAN Control
    PilotOp ->> SwarmC2: Authorize_Sortie_Flight_Mode_Execution
    SwarmC2 ->> CubeFc: Action_Authorized_Flight_Control_Consent_Token
    CubeFc ->> CubeFc: Execute_Software_Simplex_RTA_24_to_80mps_Monitor
    CubeFc ->> CanActuators: OpTx-11 CAN1_Tail_Fins_1_to_4_Pitch_Yaw_Commands
    CanActuators -->> CubeFc: OpTx-11 CAN1_Tail_Fin_Position_and_Health_Feedback
    CubeFc ->> CanActuators: OpTx-12 CAN2_Wing_Panels_5_to_8_Roll_Commands
    CubeFc ->> RpiMaster: OpTx-14 UART_Autopilot_State_and_Mission_Status
    RpiMaster -->> CubeFc: OpTx-14 UART_Companion_Health_and_ESAD_Status_Relay

    Note over PilotOp,EoIrSeeker: Phase 3 HITL GNSS Denied Fallback and Terminal Dive Steering
    PilotOp ->> SwarmC2: Authorize_Disable_GNSS_INS_DR_Fallback
    SwarmC2 ->> CubeFc: Command_GNSS_Denied_Dead_Reckoning_Consent
    CubeFc ->> NavSuite: OpTx-15 UART_Disable_GNSS_Switch_to_DR_Mode
    NavSuite ->> CanActuators: OpTx-13 CAN2_RM3100_Mag_Baro_and_SKYE2_Airspeed_Feed
    PayloadOp ->> SwarmC2: Authorize_Terminal_Track_and_Shallow_Dive_Engagement
    SwarmC2 ->> CubeFc: Action_Authorized_Terminal_Guidance_Consent_Token
    EoIrSeeker ->> CubeFc: OpTx-16 UART_Trip6_Target_Track_and_Dive_Vectors
    CubeFc -->> EoIrSeeker: OpTx-16 UART_INS_Attitude_and_55mps_Cap_Abort_Cue
    CubeFc ->> EpsUnit: OpTx-10 CAN1_Command_ESAD_Rail_Off_On_Fault_or_Abort
```

#### 7.3.3 Diagram 10.3: C2 RF Link, Onboard Ethernet & EO/IR Video Sequence (`OpTx-17`, `OpTx-18`, `OpTx-19`, `OpTx-21`, `OpTx-22`)

This interaction thread traces ground console to RF station and rotator control (`OpTx-22`), encrypted `4.4-5.0 GHz` `AES-256` FHSS air-ground RF transport (`OpTx-21`), autopilot serial C2 and locked USB service access (`OpTx-17`), switched onboard Ethernet IP bridging (`OpTx-18`), EO/IR Day/Thermal video streaming and HITL `Reboot Gimbal` recovery (`OpTx-19`), PACE link failover, and `5W` / `CFF` tactical export.

```mermaid
sequenceDiagram
    autonumber
    actor PilotOp as "UCL-01 Pilot Operator"
    actor PayloadOp as "UCL-02 Payload Operator"
    actor ExtC2 as "UCL-04 External Tactical C2"
    participant SwarmC2 as "SwarmC2OperatorConsole"
    participant GroundRf as "GroundRfStationAndAntennaTracker"
    participant CommsRadio as "OnboardEthernetAndC2RadioUnit"
    participant CubeFc as "FlightControllerCubeOrangePlus"
    participant RpiMaster as "CompanionComputeRpiCm5"
    participant EoIrSeeker as "EoIrSeekerAndTrackerUnit"

    Note over PilotOp,EoIrSeeker: Phase 1 HITL Role Auth Rotator Calibration and Umbilical Lock
    PilotOp ->> SwarmC2: Login_Role_Auth_Min_8_Chars_Authorize_Rotator_Cal
    SwarmC2 ->> GroundRf: OpTx-22 Wired_IP_or_200m_Fiber_Calibrate_Rotator_0p5deg
    GroundRf -->> SwarmC2: OpTx-22 Ground_RF_Ready_and_10m_Standoff_Verified
    CubeFc ->> CommsRadio: OpTx-17 Ground_USB_Service_Complete_Lock_Umbilical_Lid
    CommsRadio ->> GroundRf: OpTx-21 AES256_FHSS_4p4_to_5p0GHz_OMNI_Preflight_Link

    Note over PilotOp,EoIrSeeker: Phase 2 HITL DIR Tracking Flight Telemetry and HD Video Relay
    PilotOp ->> SwarmC2: Authorize_PostLaunch_MARS_23dBi_DIR_Auto_Follow
    SwarmC2 ->> GroundRf: OpTx-22 Enable_Rotator_Auto_Follow_Tracking
    CubeFc ->> CommsRadio: OpTx-17 UART_Flight_Telemetry_and_RTA_Health
    RpiMaster ->> CommsRadio: OpTx-18 ETH_Switch_Companion_IP_Telemetry_Bridge
    EoIrSeeker ->> CommsRadio: OpTx-19 ETH_Switch_1280x720_Day_Thermal_Video_Stream
    CommsRadio ->> GroundRf: OpTx-21 RF_Downlink_Telemetry_ESAD_State_and_HD_Video
    GroundRf ->> SwarmC2: OpTx-22 Ground_Console_Telemetry_and_EOIR_Display

    Note over PilotOp,EoIrSeeker: Phase 3 HITL Gimbal Recovery PACE Failover and 5W CFF Export
    PayloadOp ->> SwarmC2: Authorize_InFlight_Reboot_Gimbal_Recovery
    SwarmC2 ->> GroundRf: OpTx-22 Forward_Gimbal_Reboot_Authorization
    GroundRf ->> CommsRadio: OpTx-21 AES256_Uplink_Reboot_Gimbal_Command
    CommsRadio ->> EoIrSeeker: OpTx-19 ETH_Switch_Execute_Reboot_Gimbal_Recovery
    PilotOp ->> SwarmC2: Authorize_PACE_DIR_to_OMNI_or_105s_Failsafe_Action
    SwarmC2 ->> GroundRf: OpTx-22 Ground_PACE_Switch_or_Timeout_Trigger
    GroundRf ->> CommsRadio: OpTx-21 Uplink_RTL_and_Disarm_ESAD_On_GCS_Timeout
    CommsRadio ->> RpiMaster: OpTx-18 ETH_Switch_Deliver_C2_Ordnance_Safe_Directive
    PayloadOp ->> SwarmC2: Authorize_5W_CFF_Target_Intelligence_Export
    SwarmC2 ->> ExtC2: Export_5W_CFF_Report_to_ATAK_SitaWare_DELTA
```

#### 7.3.4 Diagram 10.4: Ordnance Safe-Arm Supervision & Interlock Sequence (`OpTx-06`, `OpTx-10`, `OpTx-14`, `OpTx-20`, `OpTx-24`)

This safety-critical interaction thread enforces `NATO STANAG 4187 Ed. 5` and `DoD Directive 3000.09` §4.1.a across Level 1B ordnance supervision (`OpTx-06`, `OpTx-10`, `OpTx-14`, `OpTx-20`, `OpTx-24`), strictly isolating power-before-pull `RBF #3` ordering (`GAP-06`), pre-flight safe high-voltage PBIT verification (`< 50.0 V`), independent physical barriers `SS1` and `SS2 Safe Distance Exceed` (`GAP-07`), positive HITL arm/abort consent, and deterministic rail cutoff without exposing component-internal serial opcodes, pinouts, bitmasks, or checksum polynomial equations.

```mermaid
sequenceDiagram
    autonumber
    actor LaunchAsst as "UCL-03 Launch Assistant"
    actor PayloadOp as "UCL-02 Payload Operator"
    participant SwarmC2 as "SwarmC2OperatorConsole"
    participant CubeFc as "FlightControllerCubeOrangePlus"
    participant EpsUnit as "ElectronicPowerSystemEps"
    participant RpiMaster as "CompanionComputeRpiCm5"
    participant PropUnit as "ElectricPropulsionUnit"
    participant EsadUnit as "ArtronEsadAndSensorUnit"

    Note over LaunchAsst,EsadUnit: Phase 1 Power Before Pull RBF3 and Safe PBIT Verification
    LaunchAsst ->> EpsUnit: Confirm_RBF2_Power_ON_While_ESAD_RBF3_Installed
    EpsUnit ->> EsadUnit: OpTx-06 Supply_14V_ESAD_Rail_Zero_Brownout_Margin
    EpsUnit -->> CubeFc: OpTx-10 CAN1_Confirm_14V_Rail_Nominal_No_Brownout
    CubeFc ->> RpiMaster: OpTx-14 UART_Confirm_Preflight_State_and_Rail_Health
    RpiMaster ->> EsadUnit: OpTx-20 Cyclic_100Hz_Supervisory_Boot_and_PBIT_Check
    EsadUnit -->> RpiMaster: OpTx-20 Boot_Complete_PBIT_Internal_HV_Below_50V
    PayloadOp ->> SwarmC2: Verify_Eight_Preconditions_Authorize_RBF3_Pull
    SwarmC2 -->> LaunchAsst: Prompt_Remove_ESAD_RBF3_Continuity_Plug
    LaunchAsst ->> EsadUnit: Pull_ESAD_RBF3_After_Power_and_PBIT_Pass

    Note over LaunchAsst,EsadUnit: Phase 2 Post Launch Dual Physical Barriers SS1 and SS2
    PropUnit ->> EsadUnit: OpTx-24 Rigid_Body_Inertial_SS1_Launch_Accel_Pulse
    EsadUnit ->> EsadUnit: Latch_SS1_Count_FlightTimer_Until_SS2_Safe_Dist_Exceed
    RpiMaster ->> EsadUnit: OpTx-20 Poll_100Hz_ArmState_SS1_and_SS2_Status
    EsadUnit -->> RpiMaster: OpTx-20 Confirm_SS1_and_SS2_Safe_Distance_Exceeded
    RpiMaster -->> CubeFc: OpTx-14 UART_Report_ESAD_Arm_Stage2_Ready

    Note over LaunchAsst,EsadUnit: Phase 3 Positive HITL Arm Consent and Supervised HV Charge
    PayloadOp ->> SwarmC2: Authorize_Positive_HITL_Arm_and_Engagement_Consent
    SwarmC2 ->> RpiMaster: Action_Authorized_ESAD_Arm_Consent_Token
    RpiMaster ->> EsadUnit: OpTx-20 Assert_Stage2_Arm_Discrete_and_HV_Enable
    EsadUnit -->> RpiMaster: OpTx-20 HV_Capacitor_Charged_0_to_1800V_Ready
    Note over RpiMaster,EsadUnit: Initiation gated behind Sensor Board trigger or authorized OC command

    Note over LaunchAsst,EsadUnit: Phase 4 HITL Self Destruct Abort Watchdog Fault and Rail Cutoff
    PayloadOp ->> SwarmC2: Hold_5s_SelfDestruct_Slide_or_Command_Power_Off_ESAD
    SwarmC2 ->> RpiMaster: Action_Authorized_Abort_or_Timeout_Disarm_Token
    RpiMaster ->> EsadUnit: OpTx-20 Command_Abort_Discharge_or_10ms_Watchdog_Safe
    RpiMaster ->> CubeFc: OpTx-14 UART_Report_ESAD_Disarm_or_Bus_Fault_Lockout
    CubeFc ->> EpsUnit: OpTx-10 CAN1_Command_Irreversible_Power_Off_ESAD
    EpsUnit ->> EsadUnit: OpTx-06 Cut_14V_ESAD_Rail_Confirm_Safe_Deenergized
```

---

### 7.4 Op-Tx Coverage Parity & Traceability Summary

Table 7.3 confirms 100% deterministic closure of all `24` operational exchanges (`OpTx-01` through `OpTx-24`) across SysML `connection def` nodes (`CONN_01` through `CONN_24`), interaction sequence diagrams (`Diagram 10.1` through `Diagram 10.4`), UAF Operational Activities (`OA-01` through `OA-19`), Operational Scenarios (`SCN-01` through `SCN-08`), Safety Constraints (`REQ_SC_01` through `REQ_SC_16`, `REQ_SAF_01` through `REQ_SAF_12`), and Verification Test Cases (`TC_01` through `TC_08`).

#### Table 7.3: Op-Tx to Diagram, Operational Activity, Scenario & Verification Parity Matrix

| Op-Tx ID | SysML `connection def` | Sequence Diagram Allocation | Bound Operational Activities (`OA`) | Bound Scenarios (`SCN`) | Governing Constraints & Test Cases |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `OpTx-01` | `CONN_01` | `Diagram 10.1` | `OA-01`, `OA-04` | `SCN-01`, `SCN-02`, `SCN-08` | `REQ_SC_01`, `REQ_SC_02`, `REQ_SAF_05`, `REQ_SAF_06`; `TC_01` |
| `OpTx-02` | `CONN_02` | `Diagram 10.1` | `OA-02`, `OA-16` | `SCN-01`, `SCN-02`, `SCN-06` | `REQ_SC_04`, `REQ_SAF_03`; `TC_01`, `TC_02`, `TC_07` |
| `OpTx-03` | `CONN_03` | `Diagram 10.1` | `OA-01`, `OA-03`, `OA-04` | `SCN-01`, `SCN-02` | `REQ_SC_02`, `REQ_SAF_01`, `REQ_SAF_05`; `TC_01`, `TC_02` |
| `OpTx-04` | `CONN_04` | `Diagram 10.1` | `OA-03`, `OA-09` | `SCN-01`, `SCN-02`, `SCN-04` | `REQ_SC_06`; `TC_02`, `TC_03` |
| `OpTx-05` | `CONN_05` | `Diagram 10.1` | `OA-03`, `OA-14` | `SCN-01`, `SCN-03`, `SCN-07` | `REQ_SC_02`, `REQ_SC_15`; `TC_02`, `TC_04` |
| `OpTx-06` | `CONN_06` | `Diagram 10.1`, `Diagram 10.4` | `OA-03`, `OA-10`, `OA-12`, `OA-17` | `SCN-01`, `SCN-05`, `SCN-08` | `REQ_SC_09`, `REQ_SC_16`, `REQ_SAF_01`, `REQ_SAF_06`; `TC_02`, `TC_06`, `TC_08` |
| `OpTx-07` | `CONN_07` | `Diagram 10.1` | `OA-03`, `OA-06`, `OA-07` | `SCN-01`, `SCN-03` | `REQ_SC_07`; `TC_02`, `TC_04` |
| `OpTx-08` | `CONN_08` | `Diagram 10.1` | `OA-03`, `OA-13`, `OA-14` | `SCN-01`, `SCN-04`, `SCN-07` | `REQ_SC_12`; `TC_02`, `TC_05` |
| `OpTx-09` | `CONN_09` | `Diagram 10.2` | `OA-01`, `OA-02`, `OA-04` | `SCN-01`, `SCN-02` | `REQ_SC_02`, `REQ_SC_04`, `REQ_SC_06`, `REQ_SAF_05`; `TC_01`, `TC_02` |
| `OpTx-10` | `CONN_10` | `Diagram 10.2`, `Diagram 10.4` | `OA-03`, `OA-12`, `OA-17` | `SCN-01`, `SCN-05`, `SCN-08` | `REQ_SC_02`, `REQ_SC_16`, `REQ_SAF_01`; `TC_02`, `TC_06`, `TC_08` |
| `OpTx-11` | `CONN_11` | `Diagram 10.2` | `OA-05`, `OA-09` | `SCN-02`, `SCN-03`, `SCN-04` | `REQ_SC_05`, `REQ_SC_06`, `REQ_SAF_02`; `TC_03` |
| `OpTx-12` | `CONN_12` | `Diagram 10.2` | `OA-05`, `OA-09` | `SCN-02`, `SCN-03`, `SCN-04` | `REQ_SC_05`, `REQ_SC_06`, `REQ_SAF_02`; `TC_03` |
| `OpTx-13` | `CONN_13` | `Diagram 10.2` | `OA-06`, `OA-07` | `SCN-01`, `SCN-03` | `REQ_SC_06`, `REQ_SC_07`; `TC_03`, `TC_04` |
| `OpTx-14` | `CONN_14` | `Diagram 10.2`, `Diagram 10.4` | `OA-05`, `OA-08`, `OA-12` | `SCN-02`, `SCN-03`, `SCN-05`, `SCN-08` | `REQ_SC_05`, `REQ_SC_08`, `REQ_SAF_04`; `TC_03`, `TC_04`, `TC_06` |
| `OpTx-15` | `CONN_15` | `Diagram 10.2` | `OA-06`, `OA-07` | `SCN-01`, `SCN-02`, `SCN-03` | `REQ_SC_07`; `TC_04` |
| `OpTx-16` | `CONN_16` | `Diagram 10.2` | `OA-05`, `OA-13` | `SCN-02`, `SCN-04` | `REQ_SC_05`, `REQ_SC_12`, `REQ_SAF_02`; `TC_03`, `TC_05` |
| `OpTx-17` | `CONN_17` | `Diagram 10.3` | `OA-05`, `OA-14`, `OA-18` | `SCN-01`, `SCN-03`, `SCN-07` | `REQ_SC_15`; `TC_04`, `TC_08` |
| `OpTx-18` | `CONN_18` | `Diagram 10.3` | `OA-08`, `OA-11`, `OA-12`, `OA-14` | `SCN-03`, `SCN-05`, `SCN-07`, `SCN-08` | `REQ_SC_08`, `REQ_SC_16`, `REQ_SAF_04`; `TC_04`, `TC_06`, `TC_08` |
| `OpTx-19` | `CONN_19` | `Diagram 10.3` | `OA-13`, `OA-14` | `SCN-04`, `SCN-07` | `REQ_SC_12`; `TC_05` |
| `OpTx-20` | `CONN_20` | `Diagram 10.4` | `OA-08`, `OA-10`, `OA-11`, `OA-12` | `SCN-01`, `SCN-05`, `SCN-08` | `REQ_SC_08`, `REQ_SC_09`, `REQ_SC_10`, `REQ_SC_11`, `REQ_SAF_04`, `REQ_SAF_06`, `REQ_SAF_07`; `TC_04`, `TC_06`, `TC_08` |
| `OpTx-21` | `CONN_21` | `Diagram 10.3` | `OA-07`, `OA-12`, `OA-13`, `OA-18` | `SCN-01`, `SCN-03`, `SCN-04`, `SCN-05`, `SCN-07`, `SCN-08` | `REQ_SC_12`, `REQ_SC_15`, `REQ_SAF_02`; `TC_04`, `TC_05`, `TC_08` |
| `OpTx-22` | `CONN_22` | `Diagram 10.3` | `OA-18`, `OA-19` | `SCN-01`, `SCN-03`, `SCN-07`, `SCN-08` | `REQ_SC_15`, `REQ_SC_16`, `REQ_SAF_12`; `TC_08` |
| `OpTx-23` | `CONN_23` | `Diagram 10.1` | `OA-15`, `OA-16`, `OA-17` | `SCN-06`, `SCN-08` | `REQ_SC_13`, `REQ_SC_14`, `REQ_SC_16`, `REQ_SAF_03`, `REQ_SAF_12`; `TC_07`, `TC_08` |
| `OpTx-24` | `CONN_24` | `Diagram 10.1`, `Diagram 10.4` | `OA-11`, `OA-16` | `SCN-05`, `SCN-06` | `REQ_SC_11`, `REQ_SAF_07`, `REQ_SAF_10`; `TC_06`, `TC_07` |

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
/// OperationalAllocation: [MET-02]
