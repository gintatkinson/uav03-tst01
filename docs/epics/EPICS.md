# Stage P4 Epics Specification

Deterministic subsystem-level Epics projected from CanonicalIr.

|Epic ID|IR QName|Title|Ring|Tier|Features|Requirements|
|:------|:-------|:----|:---|:---|:-------|:-----------|
|EPIC-01|Avenger5_Architecture::airframe|airframe Subsystem Realization|Ring-2|TQL-2|FEAT-01, FEAT-02, FEAT-03, FEAT-04, FEAT-05, FEAT-06, FEAT-31, FEAT-32, FEAT-33, FEAT-34, FEAT-35, FEAT-36, FEAT-37, FEAT-38, FEAT-39, FEAT-40, FEAT-41, FEAT-42, FEAT-43, FEAT-44|REQ-01, REQ-02, REQ-03, REQ-04, REQ-05, REQ-06, REQ-07, envOperatingEnvelope|
|EPIC-02|Avenger5_Architecture::avenger5System|avenger5System Subsystem Realization|Ring-2|TQL-2|||
|EPIC-03|Avenger5_Architecture::avenger5System::actuators|actuators Subsystem Realization|Ring-2|TQL-2|FEAT-07||
|EPIC-04|Avenger5_Architecture::avenger5System::datalink|datalink Subsystem Realization|Ring-2|TQL-2|FEAT-08, FEAT-28||
|EPIC-05|Avenger5_Architecture::avenger5System::envelopes|envelopes Subsystem Realization|Ring-2|TQL-2|||
|EPIC-06|Avenger5_Architecture::avenger5System::eps|eps Subsystem Realization|Ring-2|TQL-2|FEAT-09||
|EPIC-07|Avenger5_Architecture::avenger5System::esad|esad Subsystem Realization|Ring-2|TQL-2|FEAT-10, FEAT-21, FEAT-26||
|EPIC-08|Avenger5_Architecture::avenger5System::fcc|fcc Subsystem Realization|Ring-2|TQL-2|FEAT-11, FEAT-23||
|EPIC-09|Avenger5_Architecture::avenger5System::gcs|gcs Subsystem Realization|Ring-2|TQL-2|FEAT-12||
|EPIC-10|Avenger5_Architecture::avenger5System::navSuite|navSuite Subsystem Realization|Ring-2|TQL-2|FEAT-13, FEAT-24, FEAT-27||
|EPIC-11|Avenger5_Architecture::avenger5System::pl40Interlocks|pl40Interlocks Subsystem Realization|Ring-2|TQL-2|FEAT-14, FEAT-19, FEAT-22||
|EPIC-12|Avenger5_Architecture::avenger5System::powerMeter|powerMeter Subsystem Realization|Ring-2|TQL-2|FEAT-15, FEAT-20||
|EPIC-13|Avenger5_Architecture::avenger5System::rpi|rpi Subsystem Realization|Ring-2|TQL-2|FEAT-16, FEAT-29||
|EPIC-14|Avenger5_Architecture::avenger5System::rtaMonitor|rtaMonitor Subsystem Realization|Ring-2|TQL-2|FEAT-17, FEAT-30||
|EPIC-15|Avenger5_Architecture::avenger5System::seeker|seeker Subsystem Realization|Ring-2|TQL-2|FEAT-18, FEAT-25||
|EPIC-16|Avenger5_Architecture::bmsNet|bmsNet Subsystem Realization|Ring-2|TQL-2|||
|EPIC-17|Avenger5_Architecture::catapult|catapult Subsystem Realization|Ring-2|TQL-2|||
|EPIC-18|Avenger5_Architecture::launchCrew|launchCrew Subsystem Realization|Ring-2|TQL-2|||
|EPIC-19|Avenger5_Architecture::payloadBay|payloadBay Subsystem Realization|Ring-2|TQL-2|||
|EPIC-20|Avenger5_Architecture::payloadOp|payloadOp Subsystem Realization|Ring-2|TQL-2|||
|EPIC-21|Avenger5_Architecture::pilot|pilot Subsystem Realization|Ring-2|TQL-2|||
|EPIC-22|Avenger5_Safety::csc01_Rbf3PowerLockoutGuard|csc01_Rbf3PowerLockoutGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-23|Avenger5_Safety::csc02_DscArmStage2Guard|csc02_DscArmStage2Guard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-24|Avenger5_Safety::csc03_Pl40TriggerInterlockGuard|csc03_Pl40TriggerInterlockGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-25|Avenger5_Safety::csc04_Can2LossFallbackGuard|csc04_Can2LossFallbackGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-26|Avenger5_Safety::csc05_ApproachAirspeedCapGuard|csc05_ApproachAirspeedCapGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-27|Avenger5_Safety::csc06_EsadUndervoltageInhibitGuard|csc06_EsadUndervoltageInhibitGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-28|Avenger5_Safety::csc07_GeofenceAndSpoofRejectionGuard|csc07_GeofenceAndSpoofRejectionGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-29|Avenger5_Safety::errSrc01_Can2DaisyChain|errSrc01_Can2DaisyChain Subsystem Realization|Ring-2|TQL-2|||
|EPIC-30|Avenger5_Safety::errSrc02_EsadRailDroop|errSrc02_EsadRailDroop Subsystem Realization|Ring-2|TQL-2|||
|EPIC-31|Avenger5_Safety::errSrc03_GnssSpoofDrift|errSrc03_GnssSpoofDrift Subsystem Realization|Ring-2|TQL-2|||
|EPIC-32|Avenger5_Safety::fmeda01_FccLockup|fmeda01_FccLockup Subsystem Realization|Ring-2|TQL-2|||
|EPIC-33|Avenger5_Safety::fmeda02_EsadInterlock|fmeda02_EsadInterlock Subsystem Realization|Ring-2|TQL-2|||
|EPIC-34|Avenger5_Safety::fmeda03_Can2DaisyChain|fmeda03_Can2DaisyChain Subsystem Realization|Ring-2|TQL-2|||
|EPIC-35|Avenger5_Safety::fmeda04_Eps14VRail|fmeda04_Eps14VRail Subsystem Realization|Ring-2|TQL-2|||
|EPIC-36|Avenger5_Safety::ftaGate01_TopInadvEnable|ftaGate01_TopInadvEnable Subsystem Realization|Ring-2|TQL-2|||
|EPIC-37|Avenger5_Safety::ftaGate02_LossOfControl|ftaGate02_LossOfControl Subsystem Realization|Ring-2|TQL-2|||
|EPIC-38|Avenger5_Safety::hazard01_PrematureEsadSwitchState|hazard01_PrematureEsadSwitchState Subsystem Realization|Ring-2|TQL-2|||
|EPIC-39|Avenger5_Safety::hazard02_FlightEnvelopeDeparture|hazard02_FlightEnvelopeDeparture Subsystem Realization|Ring-2|TQL-2|||
|EPIC-40|Avenger5_Safety::hazard03_AutopilotOrCan2ChainLoss|hazard03_AutopilotOrCan2ChainLoss Subsystem Realization|Ring-2|TQL-2|||
|EPIC-41|Avenger5_Safety::hazard04_GeofenceOrSpoofExcursion|hazard04_GeofenceOrSpoofExcursion Subsystem Realization|Ring-2|TQL-2|||
|EPIC-42|Avenger5_Safety::hazard05_EsadBrownoutOrBusLoss|hazard05_EsadBrownoutOrBusLoss Subsystem Realization|Ring-2|TQL-2|||
|EPIC-43|Avenger5_Safety::hyperedge01_Can2SeriesBus|hyperedge01_Can2SeriesBus Subsystem Realization|Ring-2|TQL-2|||
|EPIC-44|Avenger5_Safety::ls01_RbfOrderHumanSlip|ls01_RbfOrderHumanSlip Subsystem Realization|Ring-2|TQL-2|||
|EPIC-45|Avenger5_Safety::ls02_PrematureRpiEnable|ls02_PrematureRpiEnable Subsystem Realization|Ring-2|TQL-2|||
|EPIC-46|Avenger5_Safety::ls03_Pl40InterlockBypass|ls03_Pl40InterlockBypass Subsystem Realization|Ring-2|TQL-2|||
|EPIC-47|Avenger5_Safety::ls04_Can2ConnectorSeparation|ls04_Can2ConnectorSeparation Subsystem Realization|Ring-2|TQL-2|||
|EPIC-48|Avenger5_Safety::ls05_ApproachAirspeedOverrun|ls05_ApproachAirspeedOverrun Subsystem Realization|Ring-2|TQL-2|||
|EPIC-49|Avenger5_Safety::ls06_EpsEsadBrownout|ls06_EpsEsadBrownout Subsystem Realization|Ring-2|TQL-2|||
|EPIC-50|Avenger5_Safety::ls07_GnssSpoofAndLinkTimeout|ls07_GnssSpoofAndLinkTimeout Subsystem Realization|Ring-2|TQL-2|||
|EPIC-51|Avenger5_Safety::prop01_Rs485Corrupt|prop01_Rs485Corrupt Subsystem Realization|Ring-2|TQL-2|||
|EPIC-52|Avenger5_Safety::rtaSafetyCalculators|rtaSafetyCalculators Subsystem Realization|Ring-2|TQL-2|||
|EPIC-53|Avenger5_Safety::sc01_EnforceRbfPowerOrder|sc01_EnforceRbfPowerOrder Subsystem Realization|Ring-2|TQL-2|||
|EPIC-54|Avenger5_Safety::sc02_EnforceSafeSepBeforeDsc|sc02_EnforceSafeSepBeforeDsc Subsystem Realization|Ring-2|TQL-2|||
|EPIC-55|Avenger5_Safety::sc03_EnforcePl40LaunchEnvelope|sc03_EnforcePl40LaunchEnvelope Subsystem Realization|Ring-2|TQL-2|||
|EPIC-56|Avenger5_Safety::sc04_EnforceCan2FallbackControl|sc04_EnforceCan2FallbackControl Subsystem Realization|Ring-2|TQL-2|||
|EPIC-57|Avenger5_Safety::sc05_EnforceApproachSpeedAndAbort|sc05_EnforceApproachSpeedAndAbort Subsystem Realization|Ring-2|TQL-2|||
|EPIC-58|Avenger5_Safety::sc06_EnforceEsadRailAndCrcWatchdog|sc06_EnforceEsadRailAndCrcWatchdog Subsystem Realization|Ring-2|TQL-2|||
|EPIC-59|Avenger5_Safety::sc07_EnforceGeofenceAndInsFallback|sc07_EnforceGeofenceAndInsFallback Subsystem Realization|Ring-2|TQL-2|||
|EPIC-60|Avenger5_Safety::uca01_PrematureRbf3Removal|uca01_PrematureRbf3Removal Subsystem Realization|Ring-2|TQL-2|||
|EPIC-61|Avenger5_Safety::uca02_DscOrRs485BeforeSafeSep|uca02_DscOrRs485BeforeSafeSep Subsystem Realization|Ring-2|TQL-2|||
|EPIC-62|Avenger5_Safety::uca03_Pl40TriggeredOutOfEnvelope|uca03_Pl40TriggeredOutOfEnvelope Subsystem Realization|Ring-2|TQL-2|||
|EPIC-63|Avenger5_Safety::uca04_Can2SeriesChainOmission|uca04_Can2SeriesChainOmission Subsystem Realization|Ring-2|TQL-2|||
|EPIC-64|Avenger5_Safety::uca05_LateApproachAbort|uca05_LateApproachAbort Subsystem Realization|Ring-2|TQL-2|||
|EPIC-65|Avenger5_Safety::uca06_Esad14VRailDroop|uca06_Esad14VRailDroop Subsystem Realization|Ring-2|TQL-2|||
|EPIC-66|Avenger5_Safety::uca07_SpoofedGnssOrGeofenceOmission|uca07_SpoofedGnssOrGeofenceOmission Subsystem Realization|Ring-2|TQL-2|||
