# ESAD Electrical, Protocol, Safety State, and Connector ICD (Extracted Baseline)

Source Document: `docs/reference/ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf` (`Doc. No: ICD_AB00-0054-01AA-0005`, Revision `1`, Rev. No `01`, First Release Date `14.04.2026`, 33 pp.; titled for UDS Avenger 3 / Excalibur International board-level integration).

Scope Note: This extraction documents strictly defensive electrical safety interlocks, connector pinouts, serial bus framing, BIT telemetry bitfields, fault states, and mechanical mounting interfaces required for `RS-485` integration and unintended-activation prevention.

---

## 1. Governing Standards and System Interfaces

| Attribute | Value / Specification | Citation |
| :--- | :--- | :--- |
| Document Number & Date | `ICD_AB00-0054-01AA-0005`, Rev `1` (`01`), `14.04.2026` | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p2]` |
| Platform Reference Note | Title page states `UDS Avenger 3 UAV` / `Artron` ESAD -> integrates with `Avenger 5 V2.5` block diagram via `14 V` rail + `RS-485` + `GPIO trigger` | `[#p1]`, `[#p5]`, `[Avenger5_V2.5_block_diagram_rev5.pdf#p1]` |
| Cited Safety & EMC Standards | `STANAG 4187` (Fuze Safety Design Requirements); `MIL-STD-461` (EMI/EMC) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p5]` |
| Safety Architecture Features | Static switch 1 (`SS1`), Static switch 2 (`SS2`), Dynamic switch (`DS`), internal HV monitor, safe-separation timer/distance, umbilical continuity loop, power-on BIT (`PBIT`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p5]`, `[#p6]`, `[#p18]`, `[#p23]`, `[#p26]` |
| Mechanical Mounting | ESAD Board: `3x M3` user mounting holes (3 larger holes reserved for vendor); Sensor Board: `2x M2` mounting holes; mounted inside sealed drone bay | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p28]` |

---

## 2. Connectors, Electrical Power, and Discrete Signal Limits

| Interface | Connector / Part No | Key Signals & Electrical Specifications | Citation |
| :--- | :--- | :--- | :--- |
| System Connector `J100` | Harwin `G125-2241696F1` (16-pin, crimps `G125-0020005`) | Pins 1-2 `VDC_IN`; 3-4 `GND`; 5-6 `UMB` / `UMB_RTN`; 9-10 `RS485_AB_P/N`; 11-12 `EXT_RS485_P/N` (spare); 13 `DSC_IN1` (Arm Enable); 14 `DSC_IN2`; 15-16 `DSC_OUT1/2` | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p10]` |
| Sensor Interface `J102` -> `J1` | Harwin `G125-2241096F1` (10-pin, epoxy-potted back) -> Molex `501330-0800` (8-pin) | `28 AWG` harness: `5V0` (`VOUT`, 2 pins), `GND` (2 pins), `DIST_COMM1/2` (UART TX/RX), `IRQ_L` <-> `IR_ESAD_L` (trigger, ORed proximity+impact on sensor board), `DIST_SPARE` | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p10]`-`[#p13]`, `[#p18]` |
| Output Interface `J401` | Custom 8-pin (pins 4, 8 removed) | Pins 1,2,3 `HV_OUT`; Pins 5,6,7 `HV_GND` | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p12]` |
| ESAD Power Input `GE_POW` | `J100` Pins 1-2 (`VDC_IN`) | Min `14 V` / Nominal `28 V` / Max `32 V` DC | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` |
| Umbilical Loop `UMB` | `J100` Pins 5-6 (`UMB` / `UMB_RTN`) | Continuity resistance `< 0.5 Ohm` (`22-28 AWG`), `20 mA` sense current | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` |
| Discrete Arm `DSC_IN1` | `J100` Pin 13 (OC -> ESAD) | `1 ms` period (`1 kHz`), `50%` duty cycle, `2` square-wave pulses; Low `0..0.7 VDC`, High `2.5..3.3 VDC` | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]` |

---

## 3. RS-485 Datalink Protocol, Commands, Safety State Machine, and Fault Register

| Protocol Layer / Item | Specification | Citation |
| :--- | :--- | :--- |
| Physical Layer (`Table 6`) | Differential `RS-485` half-duplex; `115200 bps`, `8` data bits, `1` start bit, `1` stop bit, `None` parity (`10` bits/frame), `100 Hz` polling interval | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p14]`-`[#p15]` |
| Master / Slave & Timing | `OC` (`RPI CM5004032`) is master; `ESAD` is strict slave; `100 ms` poll period; reply last bit within `5 ms` of command last bit; incomplete packet timeout `10 ms` | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p15]` |
| Packet Structure (`Table 8`) | `[Length (1 B, min 5)] [Header (1 B: 0x01 OC->ESAD, 0x02 ESAD->OC)] [Command (1 B)] [Data (0..9 B)] [CRC-16 XModem (2 B)]` | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p16]` |
| Integrity Checksum | `CRC-16 XModem`: init `0x0000`, poly `0x1021` (test vector `[0x10..0x19]` -> `0xB987`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p16]` |
| Supported Commands | `EXCHANGE (0x10)` req `0x08 B` / resp `0x0E B`; `PBIT (0x11)` req `0x05 B` / resp `0x07 B`; `HIGHVOLTAGE (0x12)` req `0x05 B` / resp `0x08 B`; `VERSION (0x13)` (FPGA+CPLD hex); `WELCOME (0xB0)` boot ASCII `"WELCOME"` | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p17]`-`[#p27]` |
| `EXCHANGE` `ArmState` (bits 0-2) | `0: Safe State`, `1: Arm Stage1 State`, `2: Arm Stage2 State`, `3: Armed State`, `4: Fired State`, `5: Fault State` | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p22]` |
| `EXCHANGE` `OC_Status` (bits 0-5) | Bit 0 `Fault Mode`, Bit 1 `Simulation Mode`, Bit 2 `Arm Enable`, Bit 3 `Mission Abort Enable`, Bit 4 `Arm Abort Enable`, Bit 5 `OC Trigger Enable` | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p19]` |
| `EXCHANGE` `FaultStates` (`UINT16`) | Bit 0 `ESAD Fault`; Bit 1 `PBIT Unsuccessful`; Bit 2 `Safe Distance Unsuccessful`; Bit 3 `OC Fault`; Bit 4 `Discrete Arm Received Before Arm Stage 2`; Bit 5 `SS1 Error`; Bit 6 `SS2 Error`; Bit 7 `Dynamic Switch Error`; Bit 8 `HV Error` | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p23]` |
| `HIGHVOLTAGE` Telemetry | `UINT8` flags (`SS1/SS2/DS Enabled & Sensed`, `Charger Enabled`, `HV Charged`) + `UINT16 Value` `[0, 1800] V` (`1 V/LSB`; `PBIT` bit 12 checks `< 50 V` safe vs `>= 50 V`) | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p18]`, `[#p26]`-`[#p27]` |
| Telemetry Scaling | `FlightTimer`: `UINT16` (`1 s/LSB`); `Acceleration` / `SimAccelerationOffset`: `INT16` 13-bit signed two's complement at `0.0039 g/LSB` | `[ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf#p20]`, `[#p23]` |
