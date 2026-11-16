# ICD-01 System Interface Matrix

Deterministic Pre-STPA Logical Interface Matrix (\`DomainTag::PreStpaIcdGraph = 0x21\`, digest \`2dba831fe1087a8b2aeb754149676b6044d2bd1af31e9a59934b3db0bdfd346c\`). Zero dangling ports verified.

* Boundary Port Usages: 120
* Conjugated Interface and Loop Links: 79
* Signal Contracts: 13 (Omega = 1.0)
* Dangling Boundary Ports: 0

## 1\. Closed-Loop Interface Topology

````mermaid
flowchart TD
    subgraph SG_ICD["Verified Conjugated Interface Topology"]
    direction TB
    PA_0["gcs.operatorTlmOut"] -->|"fl01_gcs_to_pilot"| PB_0["pilot.c2TlmIn"]
    PA_1["gcs.operatorIn"] -->|"fl01_pilot_to_gcs"| PB_1["pilot.c2CmdOut"]
    PA_2["gcs.operatorTlmOut"] -->|"fl02_gcs_to_payop"| PB_2["payloadOp.videoFeedIn"]
    PA_3["gcs.operatorIn"] -->|"fl02_payop_to_gcs"| PB_3["payloadOp.payloadCmdOut"]
    PA_4["bmsNet.bmsTaskOut"] -->|"fl03_bms_to_gcs"| PB_4["gcs.bmsIn"]
    PA_5["bmsNet.takFeedIn"] -->|"fl03_gcs_to_bms"| PB_5["gcs.takSyncOut"]
    PA_6["datalink.rfToGcsOut"] -->|"fl04_dl_to_gcs"| PB_6["gcs.rfTlmIn"]
    PA_7["datalink.rfToGcs"] -->|"fl04_gcs_to_dl"| PB_7["gcs.rfDatalinkOut"]
    PA_8["datalink.onboardEthOut"] -->|"fl05_dl_to_rpi"| PB_8["rpi.ethFabric"]
    PA_9["datalink.onboardEthIn"] -->|"fl05_rpi_to_dl"| PB_9["rpi.ethTlmOut"]
    PA_10["datalink.onboardSerialOut"] -->|"fl06_dl_to_fcc"| PB_10["fcc.radioSerialPort"]
    PA_11["datalink.onboardSerialIn"] -->|"fl06_fcc_to_dl"| PB_11["fcc.radioSerialOut"]
    PA_12["rpi.seekerEthOut"] -->|"fl07_rpi_to_seeker"| PB_12["seeker.ethCmdIn"]
    PA_13["rpi.ethFabric"] -->|"fl07_seeker_to_rpi"| PB_13["seeker.ethLinkOut"]
    PA_14["fcc.trip6SerialOut"] -->|"fl08_fcc_to_seeker"| PB_14["seeker.serialCmdIn"]
    PA_15["fcc.trip6SerialPort"] -->|"fl08_seeker_to_fcc"| PB_15["seeker.serialLinkOut"]
    end
````

## 2\. N x N Component Coupling Matrix

|Driver / Receiver|actuators|airframe|catapult|eps|esad|fcc|navSuite|pl40Interlocks|powerMeter|rpi|seeker|
|:----------------|:--------|:-------|:-------|:--|:---|:--|:-------|:-------------|:---------|:--|:-----|
|actuators|0|1|0|0|0|1|0|0|0|0|0|
|airframe|1|0|0|0|0|0|1|0|0|0|1|
|catapult|0|0|0|0|0|0|0|0|0|0|0|
|eps|0|0|0|0|1|0|0|0|0|0|0|
|esad|0|0|0|0|0|0|0|0|0|1|0|
|fcc|2|0|0|0|0|0|0|0|0|0|0|
|navSuite|0|0|0|0|0|0|0|0|0|0|0|
|pl40Interlocks|0|0|1|0|0|0|0|0|0|0|0|
|powerMeter|0|0|0|1|0|0|0|0|0|0|0|
|rpi|0|0|0|0|2|0|0|0|0|0|0|
|seeker|0|0|0|0|0|0|0|0|0|0|0|

## 3\. Boundary Port Roster

|Port QName|Owner Part|Port Definition|Conjugated (\~)|
|:---------|:---------|:--------------|:-------------|
|Avenger5_Architecture::airframe::aeroLoadFbkOut|Avenger5_Architecture::airframe|DroneCanBusPort|true|
|Avenger5_Architecture::airframe::aeroSurfaceIn|Avenger5_Architecture::airframe|DroneCanBusPort|false|
|Avenger5_Architecture::airframe::airDataOut|Avenger5_Architecture::airframe|DroneCanBusPort|true|
|Avenger5_Architecture::airframe::launchClearFbkOut|Avenger5_Architecture::airframe|PneumaticLaunchPort|true|
|Avenger5_Architecture::airframe::launchImpulseIn|Avenger5_Architecture::airframe|PneumaticLaunchPort|false|
|Avenger5_Architecture::airframe::opticalSceneOut|Avenger5_Architecture::airframe|EthernetIpPort|true|
|Avenger5_Architecture::avenger5System::actuators::aeroSurfaceOut|Avenger5_Architecture::avenger5System::actuators|DroneCanBusPort|true|
|Avenger5_Architecture::avenger5System::actuators::afLoadIn|Avenger5_Architecture::avenger5System::actuators|DroneCanBusPort|false|
|Avenger5_Architecture::avenger5System::actuators::can1FbkOut|Avenger5_Architecture::avenger5System::actuators|DroneCanBusPort|true|
|Avenger5_Architecture::avenger5System::actuators::can1FinIn|Avenger5_Architecture::avenger5System::actuators|DroneCanBusPort|false|
|Avenger5_Architecture::avenger5System::actuators::can2WingIn|Avenger5_Architecture::avenger5System::actuators|DroneCanBusPort|false|
|Avenger5_Architecture::avenger5System::actuators::servoLoadOut|Avenger5_Architecture::avenger5System::actuators|PowerRailPort|true|
|Avenger5_Architecture::avenger5System::actuators::servoPwrIn|Avenger5_Architecture::avenger5System::actuators|PowerRailPort|false|
|Avenger5_Architecture::avenger5System::datalink::onboardEthIn|Avenger5_Architecture::avenger5System::datalink|EthernetIpPort|false|
|Avenger5_Architecture::avenger5System::datalink::onboardEthOut|Avenger5_Architecture::avenger5System::datalink|EthernetIpPort|true|
|Avenger5_Architecture::avenger5System::datalink::onboardSerialIn|Avenger5_Architecture::avenger5System::datalink|SerialTelemetryPort|false|
|Avenger5_Architecture::avenger5System::datalink::onboardSerialOut|Avenger5_Architecture::avenger5System::datalink|SerialTelemetryPort|true|
|Avenger5_Architecture::avenger5System::datalink::radioPwrIn|Avenger5_Architecture::avenger5System::datalink|PowerRailPort|false|
|Avenger5_Architecture::avenger5System::datalink::rfToGcs|Avenger5_Architecture::avenger5System::datalink|EthernetIpPort|false|
|Avenger5_Architecture::avenger5System::datalink::rfToGcsOut|Avenger5_Architecture::avenger5System::datalink|EthernetIpPort|true|
|Avenger5_Architecture::avenger5System::eps::actLoadFbkIn|Avenger5_Architecture::avenger5System::eps|PowerRailPort|false|
|Avenger5_Architecture::avenger5System::eps::busIn|Avenger5_Architecture::avenger5System::eps|PowerRailPort|false|
|Avenger5_Architecture::avenger5System::eps::can1Ctrl|Avenger5_Architecture::avenger5System::eps|DroneCanBusPort|false|
|Avenger5_Architecture::avenger5System::eps::can1TlmOut|Avenger5_Architecture::avenger5System::eps|DroneCanBusPort|true|
|Avenger5_Architecture::avenger5System::eps::epsStatOut|Avenger5_Architecture::avenger5System::eps|PowerRailPort|true|
|Avenger5_Architecture::avenger5System::eps::esadOut|Avenger5_Architecture::avenger5System::eps|PowerRailPort|true|
|Avenger5_Architecture::avenger5System::eps::radioOut|Avenger5_Architecture::avenger5System::eps|PowerRailPort|true|
|Avenger5_Architecture::avenger5System::eps::servoPwrOut|Avenger5_Architecture::avenger5System::eps|PowerRailPort|true|
|Avenger5_Architecture::avenger5System::esad::dscArmIn|Avenger5_Architecture::avenger5System::esad|DiscreteInterlockPort|false|
|Avenger5_Architecture::avenger5System::esad::esadPwrIn|Avenger5_Architecture::avenger5System::esad|PowerRailPort|false|
|Avenger5_Architecture::avenger5System::esad::hvOut|Avenger5_Architecture::avenger5System::esad|DiscreteInterlockPort|true|
|Avenger5_Architecture::avenger5System::esad::interlockStatOut|Avenger5_Architecture::avenger5System::esad|DiscreteInterlockPort|true|
|Avenger5_Architecture::avenger5System::esad::launchUmbIn|Avenger5_Architecture::avenger5System::esad|DiscreteInterlockPort|false|
|Avenger5_Architecture::avenger5System::esad::rbf3KeyIn|Avenger5_Architecture::avenger5System::esad|DiscreteInterlockPort|false|
|Avenger5_Architecture::avenger5System::esad::rs485Bus|Avenger5_Architecture::avenger5System::esad|Rs485EsadPort|false|
|Avenger5_Architecture::avenger5System::esad::rs485ReplyOut|Avenger5_Architecture::avenger5System::esad|Rs485EsadPort|true|
|Avenger5_Architecture::avenger5System::esad::rtaInhibitIn|Avenger5_Architecture::avenger5System::esad|DiscreteInterlockPort|false|
|Avenger5_Architecture::avenger5System::esad::umbilicalFbIn|Avenger5_Architecture::avenger5System::esad|DiscreteInterlockPort|false|
|Avenger5_Architecture::avenger5System::extBmsIn|Avenger5_Architecture::avenger5System|EthernetIpPort|false|
|Avenger5_Architecture::avenger5System::extCmdIn|Avenger5_Architecture::avenger5System|EthernetIpPort|false|
|Avenger5_Architecture::avenger5System::extInterlockIn|Avenger5_Architecture::avenger5System|DiscreteInterlockPort|false|
|Avenger5_Architecture::avenger5System::extInterlockStatOut|Avenger5_Architecture::avenger5System|DiscreteInterlockPort|true|
|Avenger5_Architecture::avenger5System::extLauncherCmdIn|Avenger5_Architecture::avenger5System|PneumaticLaunchPort|false|
|Avenger5_Architecture::avenger5System::extLauncherStatOut|Avenger5_Architecture::avenger5System|PneumaticLaunchPort|true|
|Avenger5_Architecture::avenger5System::extTakOut|Avenger5_Architecture::avenger5System|EthernetIpPort|true|
|Avenger5_Architecture::avenger5System::extTlmOut|Avenger5_Architecture::avenger5System|EthernetIpPort|true|
|Avenger5_Architecture::avenger5System::fcc::can1BusOut|Avenger5_Architecture::avenger5System::fcc|DroneCanBusPort|true|
|Avenger5_Architecture::avenger5System::fcc::can1FbkIn|Avenger5_Architecture::avenger5System::fcc|DroneCanBusPort|false|
|Avenger5_Architecture::avenger5System::fcc::can2SensorIn|Avenger5_Architecture::avenger5System::fcc|DroneCanBusPort|false|
|Avenger5_Architecture::avenger5System::fcc::can2WingOut|Avenger5_Architecture::avenger5System::fcc|DroneCanBusPort|true|
|Avenger5_Architecture::avenger5System::fcc::gnssSerialPort|Avenger5_Architecture::avenger5System::fcc|SerialTelemetryPort|false|
|Avenger5_Architecture::avenger5System::fcc::radioSerialOut|Avenger5_Architecture::avenger5System::fcc|SerialTelemetryPort|true|
|Avenger5_Architecture::avenger5System::fcc::radioSerialPort|Avenger5_Architecture::avenger5System::fcc|SerialTelemetryPort|false|
|Avenger5_Architecture::avenger5System::fcc::rpiSerialOut|Avenger5_Architecture::avenger5System::fcc|SerialTelemetryPort|true|
|Avenger5_Architecture::avenger5System::fcc::rpiSerialPort|Avenger5_Architecture::avenger5System::fcc|SerialTelemetryPort|false|
|Avenger5_Architecture::avenger5System::fcc::rtaInhibitIn|Avenger5_Architecture::avenger5System::fcc|DroneCanBusPort|false|
|Avenger5_Architecture::avenger5System::fcc::trip6SerialOut|Avenger5_Architecture::avenger5System::fcc|SerialTelemetryPort|true|
|Avenger5_Architecture::avenger5System::fcc::trip6SerialPort|Avenger5_Architecture::avenger5System::fcc|SerialTelemetryPort|false|
|Avenger5_Architecture::avenger5System::fromAirframeOpticalIn|Avenger5_Architecture::avenger5System|EthernetIpPort|false|
|Avenger5_Architecture::avenger5System::fromAirframeSensIn|Avenger5_Architecture::avenger5System|DroneCanBusPort|false|
|Avenger5_Architecture::avenger5System::fromCatapultStatIn|Avenger5_Architecture::avenger5System|PneumaticLaunchPort|false|
|Avenger5_Architecture::avenger5System::fromPayloadStatIn|Avenger5_Architecture::avenger5System|DiscreteInterlockPort|false|
|Avenger5_Architecture::avenger5System::gcs::bmsIn|Avenger5_Architecture::avenger5System::gcs|EthernetIpPort|false|
|Avenger5_Architecture::avenger5System::gcs::operatorIn|Avenger5_Architecture::avenger5System::gcs|EthernetIpPort|false|
|Avenger5_Architecture::avenger5System::gcs::operatorTlmOut|Avenger5_Architecture::avenger5System::gcs|EthernetIpPort|true|
|Avenger5_Architecture::avenger5System::gcs::rfDatalinkOut|Avenger5_Architecture::avenger5System::gcs|EthernetIpPort|true|
|Avenger5_Architecture::avenger5System::gcs::rfTlmIn|Avenger5_Architecture::avenger5System::gcs|EthernetIpPort|false|
|Avenger5_Architecture::avenger5System::gcs::takSyncOut|Avenger5_Architecture::avenger5System::gcs|EthernetIpPort|true|
|Avenger5_Architecture::avenger5System::navSuite::airDataIn|Avenger5_Architecture::avenger5System::navSuite|DroneCanBusPort|false|
|Avenger5_Architecture::avenger5System::navSuite::can2SensorOut|Avenger5_Architecture::avenger5System::navSuite|DroneCanBusPort|true|
|Avenger5_Architecture::avenger5System::navSuite::gnssSerialOut|Avenger5_Architecture::avenger5System::navSuite|SerialTelemetryPort|true|
|Avenger5_Architecture::avenger5System::pl40Interlocks::afClearIn|Avenger5_Architecture::avenger5System::pl40Interlocks|PneumaticLaunchPort|false|
|Avenger5_Architecture::avenger5System::pl40Interlocks::catapultFbIn|Avenger5_Architecture::avenger5System::pl40Interlocks|PneumaticLaunchPort|false|
|Avenger5_Architecture::avenger5System::pl40Interlocks::crewIn|Avenger5_Architecture::avenger5System::pl40Interlocks|DiscreteInterlockPort|false|
|Avenger5_Architecture::avenger5System::pl40Interlocks::esadClearOut|Avenger5_Architecture::avenger5System::pl40Interlocks|DiscreteInterlockPort|true|
|Avenger5_Architecture::avenger5System::pl40Interlocks::fccLaunchPermIn|Avenger5_Architecture::avenger5System::pl40Interlocks|DroneCanBusPort|false|
|Avenger5_Architecture::avenger5System::pl40Interlocks::fccLaunchStatOut|Avenger5_Architecture::avenger5System::pl40Interlocks|DroneCanBusPort|true|
|Avenger5_Architecture::avenger5System::pl40Interlocks::pneumaticOut|Avenger5_Architecture::avenger5System::pl40Interlocks|PneumaticLaunchPort|true|
|Avenger5_Architecture::avenger5System::pl40Interlocks::railLaunchCmdOut|Avenger5_Architecture::avenger5System::pl40Interlocks|PneumaticLaunchPort|true|
|Avenger5_Architecture::avenger5System::powerMeter::can1Port|Avenger5_Architecture::avenger5System::powerMeter|DroneCanBusPort|false|
|Avenger5_Architecture::avenger5System::powerMeter::can1TlmOut|Avenger5_Architecture::avenger5System::powerMeter|DroneCanBusPort|true|
|Avenger5_Architecture::avenger5System::powerMeter::epsFeedOut|Avenger5_Architecture::avenger5System::powerMeter|PowerRailPort|true|
|Avenger5_Architecture::avenger5System::powerMeter::epsStatIn|Avenger5_Architecture::avenger5System::powerMeter|PowerRailPort|false|
|Avenger5_Architecture::avenger5System::powerMeter::rbf2KeyIn|Avenger5_Architecture::avenger5System::powerMeter|DiscreteInterlockPort|false|
|Avenger5_Architecture::avenger5System::rpi::esadDscOut|Avenger5_Architecture::avenger5System::rpi|DiscreteInterlockPort|true|
|Avenger5_Architecture::avenger5System::rpi::esadRs485In|Avenger5_Architecture::avenger5System::rpi|Rs485EsadPort|false|
|Avenger5_Architecture::avenger5System::rpi::esadRs485Out|Avenger5_Architecture::avenger5System::rpi|Rs485EsadPort|true|
|Avenger5_Architecture::avenger5System::rpi::ethFabric|Avenger5_Architecture::avenger5System::rpi|EthernetIpPort|false|
|Avenger5_Architecture::avenger5System::rpi::ethTlmOut|Avenger5_Architecture::avenger5System::rpi|EthernetIpPort|true|
|Avenger5_Architecture::avenger5System::rpi::fccSerialOut|Avenger5_Architecture::avenger5System::rpi|SerialTelemetryPort|true|
|Avenger5_Architecture::avenger5System::rpi::fccTelemetryIn|Avenger5_Architecture::avenger5System::rpi|SerialTelemetryPort|false|
|Avenger5_Architecture::avenger5System::rpi::seekerEthOut|Avenger5_Architecture::avenger5System::rpi|EthernetIpPort|true|
|Avenger5_Architecture::avenger5System::rtaMonitor::can1Monitor|Avenger5_Architecture::avenger5System::rtaMonitor|DroneCanBusPort|false|
|Avenger5_Architecture::avenger5System::rtaMonitor::esadInhibitOut|Avenger5_Architecture::avenger5System::rtaMonitor|DiscreteInterlockPort|true|
|Avenger5_Architecture::avenger5System::rtaMonitor::esadWatch|Avenger5_Architecture::avenger5System::rtaMonitor|Rs485EsadPort|false|
|Avenger5_Architecture::avenger5System::rtaMonitor::safetyOverrideOut|Avenger5_Architecture::avenger5System::rtaMonitor|DroneCanBusPort|true|
|Avenger5_Architecture::avenger5System::seeker::ethCmdIn|Avenger5_Architecture::avenger5System::seeker|EthernetIpPort|false|
|Avenger5_Architecture::avenger5System::seeker::ethLinkOut|Avenger5_Architecture::avenger5System::seeker|EthernetIpPort|true|
|Avenger5_Architecture::avenger5System::seeker::opticalIn|Avenger5_Architecture::avenger5System::seeker|EthernetIpPort|false|
|Avenger5_Architecture::avenger5System::seeker::serialCmdIn|Avenger5_Architecture::avenger5System::seeker|SerialTelemetryPort|false|
|Avenger5_Architecture::avenger5System::seeker::serialLinkOut|Avenger5_Architecture::avenger5System::seeker|SerialTelemetryPort|true|
|Avenger5_Architecture::avenger5System::toAirframeCmdOut|Avenger5_Architecture::avenger5System|DroneCanBusPort|true|
|Avenger5_Architecture::avenger5System::toCatapultCmdOut|Avenger5_Architecture::avenger5System|PneumaticLaunchPort|true|
|Avenger5_Architecture::avenger5System::toPayloadHvOut|Avenger5_Architecture::avenger5System|DiscreteInterlockPort|true|
|Avenger5_Architecture::bmsNet::bmsTaskOut|Avenger5_Architecture::bmsNet|EthernetIpPort|true|
|Avenger5_Architecture::bmsNet::takFeedIn|Avenger5_Architecture::bmsNet|EthernetIpPort|false|
|Avenger5_Architecture::catapult::airSupplyIn|Avenger5_Architecture::catapult|PneumaticLaunchPort|false|
|Avenger5_Architecture::catapult::aircraftImpulseOut|Avenger5_Architecture::catapult|PneumaticLaunchPort|true|
|Avenger5_Architecture::catapult::crewManualIn|Avenger5_Architecture::catapult|PneumaticLaunchPort|false|
|Avenger5_Architecture::catapult::launcherStateOut|Avenger5_Architecture::catapult|PneumaticLaunchPort|true|
|Avenger5_Architecture::launchCrew::interlockStatIn|Avenger5_Architecture::launchCrew|DiscreteInterlockPort|false|
|Avenger5_Architecture::launchCrew::launcherOperateOut|Avenger5_Architecture::launchCrew|PneumaticLaunchPort|true|
|Avenger5_Architecture::launchCrew::launcherStatIn|Avenger5_Architecture::launchCrew|PneumaticLaunchPort|false|
|Avenger5_Architecture::launchCrew::manualInterlockOut|Avenger5_Architecture::launchCrew|DiscreteInterlockPort|true|
|Avenger5_Architecture::payloadBay::payloadEnableIn|Avenger5_Architecture::payloadBay|DiscreteInterlockPort|false|
|Avenger5_Architecture::payloadBay::umbilicalStateOut|Avenger5_Architecture::payloadBay|DiscreteInterlockPort|true|
|Avenger5_Architecture::payloadOp::payloadCmdOut|Avenger5_Architecture::payloadOp|EthernetIpPort|true|
|Avenger5_Architecture::payloadOp::videoFeedIn|Avenger5_Architecture::payloadOp|EthernetIpPort|false|
|Avenger5_Architecture::pilot::c2CmdOut|Avenger5_Architecture::pilot|EthernetIpPort|true|
|Avenger5_Architecture::pilot::c2TlmIn|Avenger5_Architecture::pilot|EthernetIpPort|false|

## 4\. Conjugated Interface and Cross-Ring Links

|Link ID|Endpoint A|Endpoint B|Ring Boundary|Integrity|Watchdog (s)|
|:------|:---------|:---------|:------------|:--------|:-----------|
|fl01_gcs_to_pilot|Avenger5_Architecture::avenger5System::gcs::operatorTlmOut|Avenger5_Architecture::pilot::c2TlmIn|IntraRing|Internal|0.000|
|fl01_pilot_to_gcs|Avenger5_Architecture::avenger5System::gcs::operatorIn|Avenger5_Architecture::pilot::c2CmdOut|IntraRing|Internal|0.000|
|fl02_gcs_to_payop|Avenger5_Architecture::avenger5System::gcs::operatorTlmOut|Avenger5_Architecture::payloadOp::videoFeedIn|IntraRing|Internal|0.000|
|fl02_payop_to_gcs|Avenger5_Architecture::avenger5System::gcs::operatorIn|Avenger5_Architecture::payloadOp::payloadCmdOut|IntraRing|Internal|0.000|
|fl03_bms_to_gcs|Avenger5_Architecture::bmsNet::bmsTaskOut|Avenger5_Architecture::avenger5System::gcs::bmsIn|IntraRing|Internal|0.000|
|fl03_gcs_to_bms|Avenger5_Architecture::bmsNet::takFeedIn|Avenger5_Architecture::avenger5System::gcs::takSyncOut|IntraRing|Internal|0.000|
|fl04_dl_to_gcs|Avenger5_Architecture::avenger5System::datalink::rfToGcsOut|Avenger5_Architecture::avenger5System::gcs::rfTlmIn|IntraRing|Internal|0.000|
|fl04_gcs_to_dl|Avenger5_Architecture::avenger5System::datalink::rfToGcs|Avenger5_Architecture::avenger5System::gcs::rfDatalinkOut|IntraRing|Internal|0.000|
|fl05_dl_to_rpi|Avenger5_Architecture::avenger5System::datalink::onboardEthOut|Avenger5_Architecture::avenger5System::rpi::ethFabric|IntraRing|Internal|0.000|
|fl05_rpi_to_dl|Avenger5_Architecture::avenger5System::datalink::onboardEthIn|Avenger5_Architecture::avenger5System::rpi::ethTlmOut|IntraRing|Internal|0.000|
|fl06_dl_to_fcc|Avenger5_Architecture::avenger5System::datalink::onboardSerialOut|Avenger5_Architecture::avenger5System::fcc::radioSerialPort|IntraRing|Internal|0.000|
|fl06_fcc_to_dl|Avenger5_Architecture::avenger5System::datalink::onboardSerialIn|Avenger5_Architecture::avenger5System::fcc::radioSerialOut|IntraRing|Internal|0.000|
|fl07_rpi_to_seeker|Avenger5_Architecture::avenger5System::rpi::seekerEthOut|Avenger5_Architecture::avenger5System::seeker::ethCmdIn|IntraRing|Internal|0.000|
|fl07_seeker_to_rpi|Avenger5_Architecture::avenger5System::rpi::ethFabric|Avenger5_Architecture::avenger5System::seeker::ethLinkOut|IntraRing|Internal|0.000|
|fl08_fcc_to_seeker|Avenger5_Architecture::avenger5System::fcc::trip6SerialOut|Avenger5_Architecture::avenger5System::seeker::serialCmdIn|IntraRing|Internal|0.000|
|fl08_seeker_to_fcc|Avenger5_Architecture::avenger5System::fcc::trip6SerialPort|Avenger5_Architecture::avenger5System::seeker::serialLinkOut|IntraRing|Internal|0.000|
|fl09_fcc_to_rpi|Avenger5_Architecture::avenger5System::fcc::rpiSerialOut|Avenger5_Architecture::avenger5System::rpi::fccTelemetryIn|IntraRing|Internal|0.000|
|fl09_rpi_to_fcc|Avenger5_Architecture::avenger5System::fcc::rpiSerialPort|Avenger5_Architecture::avenger5System::rpi::fccSerialOut|Ring3->Ring2|CRC-32C|0.050|
|fl10_nav_to_fcc|Avenger5_Architecture::avenger5System::fcc::gnssSerialPort|Avenger5_Architecture::avenger5System::navSuite::gnssSerialOut|IntraRing|Internal|0.000|
|fl11_nav_to_fcc|Avenger5_Architecture::avenger5System::fcc::can2SensorIn|Avenger5_Architecture::avenger5System::navSuite::can2SensorOut|IntraRing|Internal|0.000|
|fl12_fcc_to_pm|Avenger5_Architecture::avenger5System::fcc::can1BusOut|Avenger5_Architecture::avenger5System::powerMeter::can1Port|IntraRing|Internal|0.000|
|fl12_pm_to_fcc|Avenger5_Architecture::avenger5System::fcc::can1FbkIn|Avenger5_Architecture::avenger5System::powerMeter::can1TlmOut|IntraRing|Internal|0.000|
|fl13_eps_to_fcc|Avenger5_Architecture::avenger5System::eps::can1TlmOut|Avenger5_Architecture::avenger5System::fcc::can1FbkIn|IntraRing|Internal|0.000|
|fl13_fcc_to_eps|Avenger5_Architecture::avenger5System::eps::can1Ctrl|Avenger5_Architecture::avenger5System::fcc::can1BusOut|IntraRing|Internal|0.000|
|fl14_act_to_fcc|Avenger5_Architecture::avenger5System::actuators::can1FbkOut|Avenger5_Architecture::avenger5System::fcc::can1FbkIn|IntraRing|Internal|0.000|
|fl14_fcc_to_act|Avenger5_Architecture::avenger5System::actuators::can1FinIn|Avenger5_Architecture::avenger5System::fcc::can1BusOut|IntraRing|Internal|0.000|
|fl15_fcc_to_act|Avenger5_Architecture::avenger5System::actuators::can2WingIn|Avenger5_Architecture::avenger5System::fcc::can2WingOut|IntraRing|Internal|0.000|
|fl15_fcc_to_pl40|Avenger5_Architecture::avenger5System::fcc::can1BusOut|Avenger5_Architecture::avenger5System::pl40Interlocks::fccLaunchPermIn|IntraRing|Internal|0.000|
|fl15_pl40_to_fcc|Avenger5_Architecture::avenger5System::fcc::can1FbkIn|Avenger5_Architecture::avenger5System::pl40Interlocks::fccLaunchStatOut|IntraRing|Internal|0.000|
|fl16_fcc_to_rta|Avenger5_Architecture::avenger5System::fcc::can1BusOut|Avenger5_Architecture::avenger5System::rtaMonitor::can1Monitor|Ring2->Ring1|CRC-32C|0.020|
|fl16_rta_to_esad|Avenger5_Architecture::avenger5System::esad::rtaInhibitIn|Avenger5_Architecture::avenger5System::rtaMonitor::esadInhibitOut|IntraRing|Internal|0.000|
|fl16_rta_to_fcc|Avenger5_Architecture::avenger5System::fcc::rtaInhibitIn|Avenger5_Architecture::avenger5System::rtaMonitor::safetyOverrideOut|IntraRing|Internal|0.000|
|fl17_esad_to_pl40|Avenger5_Architecture::avenger5System::esad::interlockStatOut|Avenger5_Architecture::avenger5System::pl40Interlocks::crewIn|IntraRing|Internal|0.000|
|fl17_esad_to_rpi|Avenger5_Architecture::avenger5System::esad::rs485ReplyOut|Avenger5_Architecture::avenger5System::rpi::esadRs485In|IntraRing|Internal|0.000|
|fl17_pl40_to_esad|Avenger5_Architecture::avenger5System::esad::launchUmbIn|Avenger5_Architecture::avenger5System::pl40Interlocks::esadClearOut|IntraRing|Internal|0.000|
|fl17_rpi_to_esad|Avenger5_Architecture::avenger5System::esad::rs485Bus|Avenger5_Architecture::avenger5System::rpi::esadRs485Out|Ring3->Ring1|CRC-32C|0.030|
|fl18_rpi_to_rta|Avenger5_Architecture::avenger5System::rpi::esadRs485Out|Avenger5_Architecture::avenger5System::rtaMonitor::esadWatch|IntraRing|Internal|0.000|
|fl19_rpi_to_esad_dsc|Avenger5_Architecture::avenger5System::esad::dscArmIn|Avenger5_Architecture::avenger5System::rpi::esadDscOut|Ring3->Ring1|CRC-32C|0.010|
|fl20_eps_to_pm|Avenger5_Architecture::avenger5System::eps::epsStatOut|Avenger5_Architecture::avenger5System::powerMeter::epsStatIn|IntraRing|Internal|0.000|
|fl20_pm_to_eps|Avenger5_Architecture::avenger5System::eps::busIn|Avenger5_Architecture::avenger5System::powerMeter::epsFeedOut|IntraRing|Internal|0.000|
|fl21_eps_to_esad|Avenger5_Architecture::avenger5System::eps::esadOut|Avenger5_Architecture::avenger5System::esad::esadPwrIn|IntraRing|Internal|0.000|
|fl22_act_to_eps|Avenger5_Architecture::avenger5System::actuators::servoLoadOut|Avenger5_Architecture::avenger5System::eps::actLoadFbkIn|IntraRing|Internal|0.000|
|fl22_eps_to_act|Avenger5_Architecture::avenger5System::actuators::servoPwrIn|Avenger5_Architecture::avenger5System::eps::servoPwrOut|IntraRing|Internal|0.000|
|fl22_eps_to_dl|Avenger5_Architecture::avenger5System::datalink::radioPwrIn|Avenger5_Architecture::avenger5System::eps::radioOut|IntraRing|Internal|0.000|
|fl23_crew_to_esad|Avenger5_Architecture::avenger5System::esad::rbf3KeyIn|Avenger5_Architecture::launchCrew::manualInterlockOut|IntraRing|Internal|0.000|
|fl23_crew_to_pl40|Avenger5_Architecture::launchCrew::manualInterlockOut|Avenger5_Architecture::avenger5System::pl40Interlocks::crewIn|IntraRing|Internal|0.000|
|fl23_crew_to_pm|Avenger5_Architecture::launchCrew::manualInterlockOut|Avenger5_Architecture::avenger5System::powerMeter::rbf2KeyIn|IntraRing|Internal|0.000|
|fl23_esad_to_crew|Avenger5_Architecture::avenger5System::esad::interlockStatOut|Avenger5_Architecture::launchCrew::interlockStatIn|IntraRing|Internal|0.000|
|fl26_crew_to_cat|Avenger5_Architecture::launchCrew::launcherOperateOut|Avenger5_Architecture::avenger5System::pl40Interlocks::catapultFbIn|IntraRing|Internal|0.000|
|fl26_pl40_to_crew|Avenger5_Architecture::launchCrew::launcherStatIn|Avenger5_Architecture::avenger5System::pl40Interlocks::pneumaticOut|IntraRing|Internal|0.000|
|fl27_cat_to_pl40|Avenger5_Architecture::catapult::launcherStateOut|Avenger5_Architecture::avenger5System::pl40Interlocks::catapultFbIn|IntraRing|Internal|0.000|
|fl27_pl40_to_cat|Avenger5_Architecture::catapult::airSupplyIn|Avenger5_Architecture::avenger5System::pl40Interlocks::pneumaticOut|IntraRing|Internal|0.000|
|fl27_pl40_to_cat_man|Avenger5_Architecture::catapult::crewManualIn|Avenger5_Architecture::avenger5System::pl40Interlocks::pneumaticOut|IntraRing|Internal|0.000|
|fl28_act_to_af|Avenger5_Architecture::avenger5System::actuators::aeroSurfaceOut|Avenger5_Architecture::airframe::aeroSurfaceIn|IntraRing|Internal|0.000|
|fl28_af_to_act|Avenger5_Architecture::avenger5System::actuators::afLoadIn|Avenger5_Architecture::airframe::aeroLoadFbkOut|IntraRing|Internal|0.000|
|fl28_af_to_nav|Avenger5_Architecture::airframe::airDataOut|Avenger5_Architecture::avenger5System::navSuite::airDataIn|IntraRing|Internal|0.000|
|fl28_af_to_seeker|Avenger5_Architecture::airframe::opticalSceneOut|Avenger5_Architecture::avenger5System::seeker::opticalIn|IntraRing|Internal|0.000|
|fl29_af_to_pl40|Avenger5_Architecture::airframe::launchClearFbkOut|Avenger5_Architecture::avenger5System::pl40Interlocks::afClearIn|IntraRing|Internal|0.000|
|fl29_pl40_to_af|Avenger5_Architecture::airframe::launchImpulseIn|Avenger5_Architecture::avenger5System::pl40Interlocks::railLaunchCmdOut|IntraRing|Internal|0.000|
|fl30_esad_to_pay|Avenger5_Architecture::avenger5System::esad::hvOut|Avenger5_Architecture::payloadBay::payloadEnableIn|IntraRing|Internal|0.000|
|fl30_pay_to_esad|Avenger5_Architecture::avenger5System::esad::umbilicalFbIn|Avenger5_Architecture::payloadBay::umbilicalStateOut|IntraRing|Internal|0.000|
|fc01_pilot_in|Avenger5_Architecture::avenger5System::extCmdIn|Avenger5_Architecture::pilot::c2CmdOut|IntraRing|Internal|0.000|
|fc01_pilot_out|Avenger5_Architecture::avenger5System::extTlmOut|Avenger5_Architecture::pilot::c2TlmIn|IntraRing|Internal|0.000|
|fc02_payop_in|Avenger5_Architecture::avenger5System::extCmdIn|Avenger5_Architecture::payloadOp::payloadCmdOut|IntraRing|Internal|0.000|
|fc02_payop_out|Avenger5_Architecture::avenger5System::extTlmOut|Avenger5_Architecture::payloadOp::videoFeedIn|IntraRing|Internal|0.000|
|fc03_bms_in|Avenger5_Architecture::avenger5System::extBmsIn|Avenger5_Architecture::bmsNet::bmsTaskOut|IntraRing|Internal|0.000|
|fc03_bms_out|Avenger5_Architecture::avenger5System::extTakOut|Avenger5_Architecture::bmsNet::takFeedIn|IntraRing|Internal|0.000|
|fc23_crew_in|Avenger5_Architecture::avenger5System::extInterlockIn|Avenger5_Architecture::launchCrew::manualInterlockOut|IntraRing|Internal|0.000|
|fc23_crew_out|Avenger5_Architecture::avenger5System::extInterlockStatOut|Avenger5_Architecture::launchCrew::interlockStatIn|IntraRing|Internal|0.000|
|fc26_crew_launch_in|Avenger5_Architecture::avenger5System::extLauncherCmdIn|Avenger5_Architecture::launchCrew::launcherOperateOut|IntraRing|Internal|0.000|
|fc26_crew_launch_out|Avenger5_Architecture::avenger5System::extLauncherStatOut|Avenger5_Architecture::launchCrew::launcherStatIn|IntraRing|Internal|0.000|
|fc29_cat_af|Avenger5_Architecture::airframe::launchImpulseIn|Avenger5_Architecture::catapult::aircraftImpulseOut|IntraRing|Internal|0.000|
|fc_af_in|Avenger5_Architecture::airframe::airDataOut|Avenger5_Architecture::avenger5System::fromAirframeSensIn|IntraRing|Internal|0.000|
|fc_af_opt|Avenger5_Architecture::airframe::opticalSceneOut|Avenger5_Architecture::avenger5System::fromAirframeOpticalIn|IntraRing|Internal|0.000|
|fc_af_out|Avenger5_Architecture::airframe::aeroSurfaceIn|Avenger5_Architecture::avenger5System::toAirframeCmdOut|IntraRing|Internal|0.000|
|fc_cat_in|Avenger5_Architecture::avenger5System::fromCatapultStatIn|Avenger5_Architecture::catapult::launcherStateOut|IntraRing|Internal|0.000|
|fc_cat_out|Avenger5_Architecture::avenger5System::toCatapultCmdOut|Avenger5_Architecture::catapult::airSupplyIn|IntraRing|Internal|0.000|
|fc_pay_in|Avenger5_Architecture::avenger5System::fromPayloadStatIn|Avenger5_Architecture::payloadBay::umbilicalStateOut|IntraRing|Internal|0.000|
|fc_pay_out|Avenger5_Architecture::avenger5System::toPayloadHvOut|Avenger5_Architecture::payloadBay::payloadEnableIn|IntraRing|Internal|0.000|
