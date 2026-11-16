# System Losses, Hazards & Control Structure Topology

## System Losses

### Normative System Losses (`REQ_L_01..04`)

| Requirement ID | Loss Description | Severity | Triggered By Hazards | Primary `RESEARCH_INVENTORY.md` Anchor |
| :--- | :--- | :--- | :--- | :--- |
| `REQ_L_01` | Loss L1: Human fatality or severe crew injury from unintended warhead detonation or unrestrained PL-40 launch discharge. | Catastrophic | `REQ_H_01`, `REQ_H_04`, `REQ_H_06` | `SAF-01`, `SAF-02`, `MET-04`, `EXT-01`, `EXT-02` |
| `REQ_L_02` | Loss L2: Uncontrolled airframe crash or hull destruction outside authorized engagement corridor. | Catastrophic | `REQ_H_01`, `REQ_H_02`, `REQ_H_03`, `REQ_H_06` | `SAF-02`, `SAF-03`, `MET-01`, `MET-02`, `CTL-01`, `CTL-04` |
| `REQ_L_03` | Loss L3: Unrecoverable loss of navigation or C2 mission control resulting in flyaway or inability to verify safe abort. | Hazardous | `REQ_H_02`, `REQ_H_03`, `REQ_H_05` | `OBL-04`, `SAF-02`, `CTL-02`, `CTL-03` |
| `REQ_L_04` | Loss L4: Unintended warhead detonation during ground handling/launch or collateral impact outside authorized target. | Catastrophic | `REQ_H_04`, `REQ_H_05` | `SAF-01`, `SAF-02`, `MET-03`, `CTL-03` |

### Root Composition Loss (`L-1`)

| Loss ID | Description |
| :--- | :--- |
| L-1 | Loss of safe function of Avenger5V25IntegratedSystem |

## System Hazards

### Normative System Hazards (`REQ_H_01..06`)

| Requirement ID | Hazard Description | Severity | Linked System Losses | Governing Engineering Gaps & Constraints |
| :--- | :--- | :--- | :--- | :--- |
| `REQ_H_01` | Hazard H1: Premature propulsion energization, reversed RBF sequencing, or insufficient launch airspeed (`< 24.0-26.0 m/s`) during handling or launch. | Catastrophic | `REQ_L_01`, `REQ_L_02` | `GAP-03`, `GAP-05`, `GAP-06`, `MainBatteryPreFlightVoltageConstraint`, `ProductionNoParachuteConstraint` |
| `REQ_H_02` | Hazard H2: In-flight propulsion loss, main bus sag below `36.0 V`, EPS `14.0 V` ESAD brownout (`GAP-01`), or Bingo reserve exhaustion (`< 0.20`). | Hazardous | `REQ_L_02`, `REQ_L_03` | `GAP-01`, `GAP-05`, `GAP-ENV`, `BingoEnergyReserveConstraint`, `EpsEsadZeroBrownoutMarginConstraint` |
| `REQ_H_03` | Hazard H3: Loss of flight control authority due to RTA envelope exceedance (`> 55.0/80.0 m/s`), `CAN 1`/`CAN 2` bus saturation, or unflagged pitot/mag corruption. | Catastrophic | `REQ_L_02`, `REQ_L_03` | `GAP-02`, `GAP-04`, `GAP-WCET`, `SimplexRtaSoftwareHostingConstraint`, `CanTopologyIsolationConstraint` |
| `REQ_H_04` | Hazard H4: Artron ESAD premature arming, HV `>= 50.0 V` during PBIT, premature `DSC_IN1` fault, or out-of-order `RBF #3` removal. | Catastrophic | `REQ_L_01`, `REQ_L_04` | `GAP-04`, `GAP-06`, `GAP-07`, `EsadRbf3PowerBeforePullConstraint`, `EsadSafeDistanceExceedConstraint` |
| `REQ_H_05` | Hazard H5: EO/IR gimbal saturation above `55.0 m/s` dive speed or prolonged C2 link loss while warhead is armed. | Catastrophic | `REQ_L_03`, `REQ_L_04` | `GAP-02`, `GAP-WCET`, `EngagementSpeedAndTrackHoldConstraint`, `FlightEnvelopeSpeedConstraint` |
| `REQ_H_06` | Hazard H6: Uncontrolled PL-40 rail discharge, `> 25.0 m/s` over-velocity (`< 15 kg` at `14 bar`), sub-stall exit (`< 24.0-26.0 m/s`), or unbleed hangfire crew approach. | Catastrophic | `REQ_L_01`, `REQ_L_02` | `GAP-03`, `GAP-SEPDIST`, `GAP-SCRUB`, `Pl40MassAndExitVelocityConstraint`, `Pl40UvloAndDualSwitchConstraint` |

### AST Action-Bound System Hazards (`H-1..19`)

| Hazard ID | Associated Control Action | Controller |
| :--- | :--- | :--- |
| H-1 | ValidateBatteryAndPowerOnRbf2 | Avenger5V25IntegratedSystem |
| H-2 | CommandPusherThrottleAndReadEscTelem | Avenger5V25IntegratedSystem |
| H-3 | DistributeRegulatedPowerRails | Avenger5V25IntegratedSystem |
| H-4 | MonitorBingoEnergyReserve | Avenger5V25IntegratedSystem |
| H-5 | ExecuteSimplexRtaEnvelopeCheck | Avenger5V25IntegratedSystem |
| H-6 | RunPitotAndMagPreflightCheck | Avenger5V25IntegratedSystem |
| H-7 | SwitchToGnssDeniedDeadReckoning | Avenger5V25IntegratedSystem |
| H-8 | SuperviseEsadOcMasterCycle | Avenger5V25IntegratedSystem |
| H-9 | ActuateTailAndWingSurfaces | Avenger5V25IntegratedSystem |
| H-10 | ExecuteEsadBootAndPbit | Avenger5V25IntegratedSystem |
| H-11 | TransitionEsadArmingSequence | Avenger5V25IntegratedSystem |
| H-12 | CommandEsadAbortAndSelfDestruct | Avenger5V25IntegratedSystem |
| H-13 | AcquireAndTrackTerminalTarget | Avenger5V25IntegratedSystem |
| H-14 | RebootGimbalAndBridgeEthernet | Avenger5V25IntegratedSystem |
| H-15 | ChargePl40CompressorWithUvloCheck | Avenger5V25IntegratedSystem |
| H-16 | ExecuteLaunchGoNoGoAndDualTrigger | Avenger5V25IntegratedSystem |
| H-17 | DepressurizeAndScrubPl40Launcher | Avenger5V25IntegratedSystem |
| H-18 | AuthenticateOperatorAndCalibrateRotator | Avenger5V25IntegratedSystem |
| H-19 | ExportTargetReport5wCff | Avenger5V25IntegratedSystem |

## Hierarchical Control Structure Topology

The Avenger 5 V2.5 hierarchical safety control structure enforces strict architectural separation: ASTM F3269-17 Simplex Run-Time Assurance executes strictly in software on `FlightControllerCubeOrangePlus` (`standaloneRtaBoxCount == 0`, `rtaHostedOnCubeOrangePlus == true`), `CompanionComputeRpiCm5` acts as sole `100 Hz` RS-485 `OC Master` for `ArtronEsadAndSensorUnit`, `Pl40PneumaticLauncher` couples purely mechanically across `IF-MECH-001` (`CONN_23`) with zero electrical or CAN wires to the UAV, and production `ElectronicPowerSystemEps` inhibits optional RnD `2x 50.0 V` recovery igniters (`rndRecoveryOptionInstalled == false`).

```mermaid
flowchart TD
    subgraph T1 ["Tier 1 HITL Crew and Ground C2"]
        direction TB
        HitlCrew["HITL Flight Crew<br/>Pilot Payload Launch Asst"]
        SwarmC2["SwarmC2OperatorConsole<br/>Windows 11 C2 Tablet"]
        GroundRf["GroundRfStationAndAntennaTracker<br/>DTC 4.4-5.0 GHz MARS OMNI"]
    end

    subgraph T2 ["Tier 2 Airborne Control and RTA"]
        direction TB
        CommsUnit["OnboardEthernetAndC2RadioUnit<br/>DTC Radio ETH Switch USB Lid"]
        FlightCtrl["FlightControllerCubeOrangePlus<br/>Autopilot and Software RTA"]
        RpiMaster["CompanionComputeRpiCm5<br/>ESAD OC Master 100 Hz RS485"]
    end

    subgraph T3 ["Tier 3 Power Bus and EPS"]
        direction TB
        BattUnit["MainBatteryAndFuseUnit<br/>12S2P 36-50.4V 200A Fuse"]
        PowerRbf["PowerMeterAndRbfSwitch<br/>RBF Key 2 and ESC Telemetry"]
        EpsUnit["ElectronicPowerSystemEps<br/>8V 12V 14V Rails No RnD 50V"]
    end

    subgraph T4 ["Tier 4 Actuation Prop and Rail"]
        direction TB
        Actuators["DroneCanSurfaceActuation<br/>CAN1 Tail CAN2 Wings HV6160"]
        PropAirframe["ElectricPropulsionUnit<br/>IBEX160 AXI 5345 Airframe"]
        Pl40Rail["Pl40PneumaticLauncher<br/>13-14 bar Zero UAV Wires"]
    end

    subgraph T5 ["Tier 5 Ordnance Seeker and Nav"]
        direction TB
        EsadUnit["ArtronEsadAndSensorUnit<br/>STANAG 4187 SS1 SS2 RBF3"]
        EoIrUnit["EoIrSeekerAndTrackerUnit<br/>Nighthawk2UZ and Trip6"]
        NavSuite["NavigationAndAirDataSuite<br/>Septentrio RM3100 SKYE2"]
    end

    HitlCrew -->|"Auth Mission Abort"| SwarmC2
    SwarmC2 -->|"CONN_22 Fiber IP Rotator"| GroundRf
    HitlCrew -->|"Pin Valve4 Dual Switch"| Pl40Rail
    HitlCrew -->|"ESD RBF1 RBF2 RBF3"| PowerRbf

    GroundRf -->|"CONN_21 4.4-5.0 GHz C2"| CommsUnit
    CommsUnit -->|"CONN_17 Radio Serial USB"| FlightCtrl
    CommsUnit -->|"CONN_18 ETH RPi Bridge"| RpiMaster
    CommsUnit -->|"CONN_19 ETH Trip6 Cues"| EoIrUnit

    FlightCtrl -->|"CONN_14 FC to RPi UART"| RpiMaster
    FlightCtrl -->|"CONN_09 CAN1 Power Tap"| PowerRbf
    FlightCtrl -->|"CONN_10 CAN1 EPS PowerOff"| EpsUnit
    FlightCtrl -->|"CONN_11 CAN1 Tail Fins"| Actuators
    FlightCtrl -->|"CONN_12 CAN2 Wing Servos"| Actuators
    FlightCtrl -->|"CONN_16 Trip6 Guidance"| EoIrUnit
    RpiMaster -->|"CONN_20 RS485 DSC_IN1"| EsadUnit

    BattUnit -->|"CONN_01 36-50.4V DC"| PowerRbf
    PowerRbf -->|"CONN_02 PWM ESC Drive"| PropAirframe
    PowerRbf -->|"CONN_03 970cm Trunk"| EpsUnit
    EpsUnit -->|"CONN_04 8V Servo Rail"| Actuators
    EpsUnit -->|"CONN_05 12V Radio Rail"| CommsUnit
    EpsUnit -->|"CONN_06 14V ESAD GAP-01"| EsadUnit
    EpsUnit -->|"CONN_07 Sensor Power"| NavSuite
    EpsUnit -->|"CONN_08 Gimbal Power"| EoIrUnit

    Pl40Rail -->|"CONN_23 Mech 0 Wire"| PropAirframe
    PropAirframe -->|"CONN_24 Inertial SS1"| EsadUnit
    Actuators -->|"CONN_13 CAN2 Daisy Nav"| NavSuite

    NavSuite -.->|"CONN_15 GNSS and AirData"| FlightCtrl
    PowerRbf -.->|"CAN1 ESC and Bingo Telem"| FlightCtrl
    CommsUnit -.->|"RF Telemetry and Video"| GroundRf

    GroundRf ~~~ FlightCtrl
    FlightCtrl ~~~ PowerRbf
    PowerRbf ~~~ Actuators
    Actuators ~~~ EsadUnit
```
