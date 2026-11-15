# Stage P4 Features Specification

Deterministic capability Features decomposing Stage P4 Epics.

|Feature ID|Parent Epic|IR QName|Title|Ring|Tier|Stories|Requirements|
|:---------|:----------|:-------|:----|:---|:---|:------|:-----------|
|FEAT-01|EPIC-01|Avenger5_ConOps::VehicleAndEsadLifecycle::Deg_GnssDeniedOrLinkLoss|Deg_GnssDeniedOrLinkLoss Capability|Ring-2|TQL-2|US-01, US-02, US-03, US-04, US-05, US-06, US-07, US-08|REQ-01, REQ-02, REQ-03, REQ-04, REQ-05, REQ-06, REQ-07, envOperatingEnvelope|
|FEAT-02|EPIC-01|Avenger5_ConOps::VehicleAndEsadLifecycle::Init_PreFlightPowerOn|Init_PreFlightPowerOn Capability|Ring-2|TQL-2|||
|FEAT-03|EPIC-01|Avenger5_ConOps::VehicleAndEsadLifecycle::Init_SafeAssembly|Init_SafeAssembly Capability|Ring-2|TQL-2|||
|FEAT-04|EPIC-01|Avenger5_ConOps::VehicleAndEsadLifecycle::Nom_AutoCruiseAndSearch|Nom_AutoCruiseAndSearch Capability|Ring-2|TQL-2|||
|FEAT-05|EPIC-01|Avenger5_ConOps::VehicleAndEsadLifecycle::Nom_TerminalApproach|Nom_TerminalApproach Capability|Ring-2|TQL-2|||
|FEAT-06|EPIC-01|Avenger5_ConOps::VehicleAndEsadLifecycle::SafeHold_AbortOrFaultLatch|SafeHold_AbortOrFaultLatch Capability|Ring-2|TQL-2|||
|FEAT-07|EPIC-03|Avenger5_ConOps::lcActuators|lcActuators Capability|Ring-2|TQL-2|||
|FEAT-08|EPIC-04|Avenger5_ConOps::lcDatalink|lcDatalink Capability|Ring-2|TQL-2|||
|FEAT-09|EPIC-06|Avenger5_ConOps::lcEps|lcEps Capability|Ring-2|TQL-2|||
|FEAT-10|EPIC-07|Avenger5_ConOps::lcEsad|lcEsad Capability|Ring-2|TQL-2|||
|FEAT-11|EPIC-08|Avenger5_ConOps::lcFcc|lcFcc Capability|Ring-2|TQL-2|||
|FEAT-12|EPIC-09|Avenger5_ConOps::lcGcs|lcGcs Capability|Ring-2|TQL-2|||
|FEAT-13|EPIC-10|Avenger5_ConOps::lcNavSuite|lcNavSuite Capability|Ring-2|TQL-2|||
|FEAT-14|EPIC-11|Avenger5_ConOps::lcPl40Interlocks|lcPl40Interlocks Capability|Ring-2|TQL-2|||
|FEAT-15|EPIC-12|Avenger5_ConOps::lcPowerMeter|lcPowerMeter Capability|Ring-2|TQL-2|||
|FEAT-16|EPIC-13|Avenger5_ConOps::lcRpi|lcRpi Capability|Ring-2|TQL-2|||
|FEAT-17|EPIC-14|Avenger5_ConOps::lcRtaMonitor|lcRtaMonitor Capability|Ring-2|TQL-2|||
|FEAT-18|EPIC-15|Avenger5_ConOps::lcSeeker|lcSeeker Capability|Ring-2|TQL-2|||
|FEAT-19|EPIC-11|Avenger5_ConOps::oa01|oa01 Capability|Ring-2|TQL-2|||
|FEAT-20|EPIC-12|Avenger5_ConOps::oa02|oa02 Capability|Ring-2|TQL-2|||
|FEAT-21|EPIC-07|Avenger5_ConOps::oa03|oa03 Capability|Ring-2|TQL-2|||
|FEAT-22|EPIC-11|Avenger5_ConOps::oa04|oa04 Capability|Ring-2|TQL-2|||
|FEAT-23|EPIC-08|Avenger5_ConOps::oa05|oa05 Capability|Ring-2|TQL-2|||
|FEAT-24|EPIC-10|Avenger5_ConOps::oa06|oa06 Capability|Ring-2|TQL-2|||
|FEAT-25|EPIC-15|Avenger5_ConOps::oa07|oa07 Capability|Ring-2|TQL-2|||
|FEAT-26|EPIC-07|Avenger5_ConOps::oa08|oa08 Capability|Ring-2|TQL-2|||
|FEAT-27|EPIC-10|Avenger5_ConOps::oa09|oa09 Capability|Ring-2|TQL-2|||
|FEAT-28|EPIC-04|Avenger5_ConOps::oa10|oa10 Capability|Ring-2|TQL-2|||
|FEAT-29|EPIC-13|Avenger5_ConOps::oa11|oa11 Capability|Ring-2|TQL-2|||
|FEAT-30|EPIC-14|Avenger5_ConOps::oa12|oa12 Capability|Ring-2|TQL-2|||
|FEAT-31|EPIC-01|Avenger5_Safety::RtaSafetyCalculators::crcCheck|crcCheck Capability|Ring-2|TQL-2|||
|FEAT-32|EPIC-01|Avenger5_Safety::RtaSafetyCalculators::ctmcBound|ctmcBound Capability|Ring-2|TQL-2|||
|FEAT-33|EPIC-01|Avenger5_Safety::RtaSafetyCalculators::fmedaCheck|fmedaCheck Capability|Ring-2|TQL-2|||
|FEAT-34|EPIC-01|Avenger5_Safety::RtaSafetyCalculators::phaseMargin|phaseMargin Capability|Ring-2|TQL-2|||
|FEAT-35|EPIC-01|Avenger5_Safety::RtaSafetyCalculators::riskTier|riskTier Capability|Ring-2|TQL-2|||
|FEAT-36|EPIC-01|Avenger5_Safety::RtaSafetyCalculators::rmaUtil|rmaUtil Capability|Ring-2|TQL-2|||
|FEAT-37|EPIC-01|Avenger5_Safety::RtaSafetyCalculators::rmaWcrt|rmaWcrt Capability|Ring-2|TQL-2|||
|FEAT-38|EPIC-01|Avenger5_Safety::RtaSafetyCalculators::zcbfBarrier|zcbfBarrier Capability|Ring-2|TQL-2|||
|FEAT-39|EPIC-01|Avenger5_Safety::ca01_EsadInterlockAndPowerGate|ca01_EsadInterlockAndPowerGate Capability|Ring-2|TQL-2|||
|FEAT-40|EPIC-01|Avenger5_Safety::ca02_Pl40PneumaticReleaseCommand|ca02_Pl40PneumaticReleaseCommand Capability|Ring-2|TQL-2|||
|FEAT-41|EPIC-01|Avenger5_Safety::ca03_TerminalApproachAndEnableGate|ca03_TerminalApproachAndEnableGate Capability|Ring-2|TQL-2|||
|FEAT-42|EPIC-01|Avenger5_Safety::ca04_ApproachAbortAndWaveoffCommand|ca04_ApproachAbortAndWaveoffCommand Capability|Ring-2|TQL-2|||
|FEAT-43|EPIC-01|Avenger5_Safety::ca05_DroneCanSurfaceActuation|ca05_DroneCanSurfaceActuation Capability|Ring-2|TQL-2|||
|FEAT-44|EPIC-01|Avenger5_Safety::ca06_GeofenceAndSpoofContingencySwitch|ca06_GeofenceAndSpoofContingencySwitch Capability|Ring-2|TQL-2|||
