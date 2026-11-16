# ICD-02 Master Signal Dictionary

Coherent SI Master Signal Dictionary bound to \`0x21\` ICD graph \`2dba831fe1087a8b2aeb754149676b6044d2bd1af31e9a59934b3db0bdfd346c\`. Every signal enforces finite closed bounds \`\[min, max\]\`, fail-safe default \`safe\`, and positive cadence.

## 1\. Master Signal Contracts

|Signal ID|Kind|Payload|Driver Port|Receiver Port|SI Unit|Range|Safe Val|Rate (Hz)|Max Latency (s)|
|:--------|:---|:------|:----------|:------------|:------|:----|:-------|:--------|:--------------|
|SIG-ACT-AF-SURFACE-CMD|Command|DroneCanFrameItem|actuators.aeroSurfaceOut|airframe.aeroSurfaceIn|Hz|\[0, 250\]|0|250|0.004|
|SIG-ACT-FCC-CAN1-FBK|Feedback|DroneCanFrameItem|actuators.can1FbkOut|fcc.can1FbkIn|Hz|\[0, 250\]|0|100|0.010|
|SIG-AF-ACT-LOAD-FBK|Feedback|DroneCanFrameItem|airframe.aeroLoadFbkOut|actuators.afLoadIn|Hz|\[0, 250\]|0|250|0.004|
|SIG-AF-NAV-AIRDATA-FBK|Feedback|DroneCanFrameItem|airframe.airDataOut|navSuite.airDataIn|m/s|\[0, 80\]|24|50|0.020|
|SIG-AF-SEEKER-OPTICAL-FBK|Feedback|IpTelemetryCommandItem|airframe.opticalSceneOut|seeker.opticalIn|Hz|\[0, 60\]|0|30|0.033|
|SIG-BAT-MAIN-BUS-V|Command|DCBusPowerItem|powerMeter.epsFeedOut|eps.busIn|V|\[0, 50.4\]|0|50|0.020|
|SIG-EPS-ESAD-PWR|Command|DCBusPowerItem|eps.esadOut|esad.esadPwrIn|V|\[0, 32\]|0|100|0.010|
|SIG-ESAD-RPI-RS485-FBK|Feedback|Rs485ControlFrame|esad.rs485ReplyOut|rpi.esadRs485In|Hz|\[0, 100\]|0|100|0.005|
|SIG-FCC-CAN1-FIN|Command|DroneCanFrameItem|fcc.can1BusOut|actuators.can1FinIn|Hz|\[0, 250\]|0|250|0.004|
|SIG-FCC-CAN2-WING|Command|DroneCanFrameItem|fcc.can2WingOut|actuators.can2WingIn|Hz|\[0, 250\]|0|250|0.004|
|SIG-PL40-TANK-P|Command|PneumaticImpulseItem|pl40Interlocks.pneumaticOut|catapult.airSupplyIn|Pa|\[0, 1400000\]|0|10|0.100|
|SIG-RPI-ESAD-DSC-IN1|Command|DiscreteSafetySignalItem|rpi.esadDscOut|esad.dscArmIn|V|\[0, 3.3\]|0|1000|0.002|
|SIG-RPI-ESAD-RS485|Command|Rs485ControlFrame|rpi.esadRs485Out|esad.rs485Bus|Hz|\[0, 100\]|0|100|0.005|
