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
|EPIC-22|Avenger5_Safety::csc01_EsadUndervoltageInhibitGuard|csc01_EsadUndervoltageInhibitGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-23|Avenger5_Safety::csc02_EsadFaultLatchInhibitGuard|csc02_EsadFaultLatchInhibitGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-24|Avenger5_Safety::csc03_Rbf3PowerLockoutGuard|csc03_Rbf3PowerLockoutGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-25|Avenger5_Safety::csc04_Rs485ExchangeWatchdogGuard|csc04_Rs485ExchangeWatchdogGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-26|Avenger5_Safety::csc05_Pl40ThrustValveInterlockGuard|csc05_Pl40ThrustValveInterlockGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-27|Avenger5_Safety::csc06_Pl40TriggerInterlockGuard|csc06_Pl40TriggerInterlockGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-28|Avenger5_Safety::csc07_Pl40CrewStandoffGuard|csc07_Pl40CrewStandoffGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-29|Avenger5_Safety::csc08_Pl40DualSwitchHoldGuard|csc08_Pl40DualSwitchHoldGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-30|Avenger5_Safety::csc09_EsadSafeHoldOnTrackLossGuard|csc09_EsadSafeHoldOnTrackLossGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-31|Avenger5_Safety::csc10_DscArmStage2Guard|csc10_DscArmStage2Guard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-32|Avenger5_Safety::csc11_EoLockBeforeEnableGuard|csc11_EoLockBeforeEnableGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-33|Avenger5_Safety::csc12_DscPulseTimingGuard|csc12_DscPulseTimingGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-34|Avenger5_Safety::csc13_ApproachAbortTriggerGuard|csc13_ApproachAbortTriggerGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-35|Avenger5_Safety::csc14_WaveoffLoadLimiterGuard|csc14_WaveoffLoadLimiterGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-36|Avenger5_Safety::csc15_ApproachAirspeedCapGuard|csc15_ApproachAirspeedCapGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-37|Avenger5_Safety::csc16_AbortFiveSecondLatchGuard|csc16_AbortFiveSecondLatchGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-38|Avenger5_Safety::csc17_Can2LossFallbackGuard|csc17_Can2LossFallbackGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-39|Avenger5_Safety::csc18_SurfaceDeflectionEnvelopeGuard|csc18_SurfaceDeflectionEnvelopeGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-40|Avenger5_Safety::csc19_DroneCanPhaseMarginGuard|csc19_DroneCanPhaseMarginGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-41|Avenger5_Safety::csc20_ServoBabbleIsolationGuard|csc20_ServoBabbleIsolationGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-42|Avenger5_Safety::csc21_GeofenceAndSpoofRejectionGuard|csc21_GeofenceAndSpoofRejectionGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-43|Avenger5_Safety::csc22_ExclusionPolygonVectorGuard|csc22_ExclusionPolygonVectorGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-44|Avenger5_Safety::csc23_SpoofSwitchLatencyGuard|csc23_SpoofSwitchLatencyGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-45|Avenger5_Safety::csc24_GnssDeniedInsDriftGuard|csc24_GnssDeniedInsDriftGuard Subsystem Realization|Ring-2|TQL-2|||
|EPIC-46|Avenger5_Safety::errSrc01_Can2DaisyChain|errSrc01_Can2DaisyChain Subsystem Realization|Ring-2|TQL-2|||
|EPIC-47|Avenger5_Safety::errSrc02_EsadRailDroop|errSrc02_EsadRailDroop Subsystem Realization|Ring-2|TQL-2|||
|EPIC-48|Avenger5_Safety::errSrc03_GnssSpoofDrift|errSrc03_GnssSpoofDrift Subsystem Realization|Ring-2|TQL-2|||
|EPIC-49|Avenger5_Safety::fmeda01_FccLockup|fmeda01_FccLockup Subsystem Realization|Ring-2|TQL-2|||
|EPIC-50|Avenger5_Safety::fmeda02_EsadInterlock|fmeda02_EsadInterlock Subsystem Realization|Ring-2|TQL-2|||
|EPIC-51|Avenger5_Safety::fmeda03_Can2DaisyChain|fmeda03_Can2DaisyChain Subsystem Realization|Ring-2|TQL-2|||
|EPIC-52|Avenger5_Safety::fmeda04_Eps14VRail|fmeda04_Eps14VRail Subsystem Realization|Ring-2|TQL-2|||
|EPIC-53|Avenger5_Safety::fmeda05_EsadSafeSepChannel|fmeda05_EsadSafeSepChannel Subsystem Realization|Ring-2|TQL-2|||
|EPIC-54|Avenger5_Safety::fmeda06_FccCan1Control|fmeda06_FccCan1Control Subsystem Realization|Ring-2|TQL-2|||
|EPIC-55|Avenger5_Safety::fmeda07_NavGnssInsFault|fmeda07_NavGnssInsFault Subsystem Realization|Ring-2|TQL-2|||
|EPIC-56|Avenger5_Safety::fmeda08_Rs485BusFault|fmeda08_Rs485BusFault Subsystem Realization|Ring-2|TQL-2|||
|EPIC-57|Avenger5_Safety::ftaGate01_H01InadvSwitch|ftaGate01_H01InadvSwitch Subsystem Realization|Ring-2|TQL-2|||
|EPIC-58|Avenger5_Safety::ftaGate02_H02EnvelopeDep|ftaGate02_H02EnvelopeDep Subsystem Realization|Ring-2|TQL-2|||
|EPIC-59|Avenger5_Safety::ftaGate03_H03Can2Loss|ftaGate03_H03Can2Loss Subsystem Realization|Ring-2|TQL-2|||
|EPIC-60|Avenger5_Safety::ftaGate04_H04GeofenceExc|ftaGate04_H04GeofenceExc Subsystem Realization|Ring-2|TQL-2|||
|EPIC-61|Avenger5_Safety::ftaGate05_H05EsadBusLoss|ftaGate05_H05EsadBusLoss Subsystem Realization|Ring-2|TQL-2|||
|EPIC-62|Avenger5_Safety::hazard01_PrematureEsadSwitchState|hazard01_PrematureEsadSwitchState Subsystem Realization|Ring-2|TQL-2|||
|EPIC-63|Avenger5_Safety::hazard02_FlightEnvelopeDeparture|hazard02_FlightEnvelopeDeparture Subsystem Realization|Ring-2|TQL-2|||
|EPIC-64|Avenger5_Safety::hazard03_AutopilotOrCan2ChainLoss|hazard03_AutopilotOrCan2ChainLoss Subsystem Realization|Ring-2|TQL-2|||
|EPIC-65|Avenger5_Safety::hazard04_GeofenceOrSpoofExcursion|hazard04_GeofenceOrSpoofExcursion Subsystem Realization|Ring-2|TQL-2|||
|EPIC-66|Avenger5_Safety::hazard05_EsadBrownoutOrBusLoss|hazard05_EsadBrownoutOrBusLoss Subsystem Realization|Ring-2|TQL-2|||
|EPIC-67|Avenger5_Safety::hyperedge01_Can2SeriesBus|hyperedge01_Can2SeriesBus Subsystem Realization|Ring-2|TQL-2|||
|EPIC-68|Avenger5_Safety::ls01_EpsEsad14VBrownout|ls01_EpsEsad14VBrownout Subsystem Realization|Ring-2|TQL-2|||
|EPIC-69|Avenger5_Safety::ls02_FaultyEsadPowerEnable|ls02_FaultyEsadPowerEnable Subsystem Realization|Ring-2|TQL-2|||
|EPIC-70|Avenger5_Safety::ls03_RbfOrderHumanSlip|ls03_RbfOrderHumanSlip Subsystem Realization|Ring-2|TQL-2|||
|EPIC-71|Avenger5_Safety::ls04_Rs485PollTimeout|ls04_Rs485PollTimeout Subsystem Realization|Ring-2|TQL-2|||
|EPIC-72|Avenger5_Safety::ls05_Pl40ValveStuckClosed|ls05_Pl40ValveStuckClosed Subsystem Realization|Ring-2|TQL-2|||
|EPIC-73|Avenger5_Safety::ls06_Pl40InterlockBypass|ls06_Pl40InterlockBypass Subsystem Realization|Ring-2|TQL-2|||
|EPIC-74|Avenger5_Safety::ls07_Pl40CrewStandoffViolation|ls07_Pl40CrewStandoffViolation Subsystem Realization|Ring-2|TQL-2|||
|EPIC-75|Avenger5_Safety::ls08_Pl40ShortTriggerPulse|ls08_Pl40ShortTriggerPulse Subsystem Realization|Ring-2|TQL-2|||
|EPIC-76|Avenger5_Safety::ls09_EsadInhibitOmittedOnLoss|ls09_EsadInhibitOmittedOnLoss Subsystem Realization|Ring-2|TQL-2|||
|EPIC-77|Avenger5_Safety::ls10_PrematureRpiEnable|ls10_PrematureRpiEnable Subsystem Realization|Ring-2|TQL-2|||
|EPIC-78|Avenger5_Safety::ls11_PreEoLockEnable|ls11_PreEoLockEnable Subsystem Realization|Ring-2|TQL-2|||
|EPIC-79|Avenger5_Safety::ls12_DscPulseTimingDrift|ls12_DscPulseTimingDrift Subsystem Realization|Ring-2|TQL-2|||
|EPIC-80|Avenger5_Safety::ls13_ApproachAbortOmitted|ls13_ApproachAbortOmitted Subsystem Realization|Ring-2|TQL-2|||
|EPIC-81|Avenger5_Safety::ls14_WaveoffOverstressPullup|ls14_WaveoffOverstressPullup Subsystem Realization|Ring-2|TQL-2|||
|EPIC-82|Avenger5_Safety::ls15_ApproachAirspeedOverrun|ls15_ApproachAirspeedOverrun Subsystem Realization|Ring-2|TQL-2|||
|EPIC-83|Avenger5_Safety::ls16_TruncatedAbortSafeHold|ls16_TruncatedAbortSafeHold Subsystem Realization|Ring-2|TQL-2|||
|EPIC-84|Avenger5_Safety::ls17_Can2ConnectorSeparation|ls17_Can2ConnectorSeparation Subsystem Realization|Ring-2|TQL-2|||
|EPIC-85|Avenger5_Safety::ls18_SaturatedControlSurfaceCmd|ls18_SaturatedControlSurfaceCmd Subsystem Realization|Ring-2|TQL-2|||
|EPIC-86|Avenger5_Safety::ls19_DroneCanBusJitterLag|ls19_DroneCanBusJitterLag Subsystem Realization|Ring-2|TQL-2|||
|EPIC-87|Avenger5_Safety::ls20_CanServoBabbleFault|ls20_CanServoBabbleFault Subsystem Realization|Ring-2|TQL-2|||
|EPIC-88|Avenger5_Safety::ls21_GnssSpoofAndLinkTimeout|ls21_GnssSpoofAndLinkTimeout Subsystem Realization|Ring-2|TQL-2|||
|EPIC-89|Avenger5_Safety::ls22_DrWaypointExclusionViolation|ls22_DrWaypointExclusionViolation Subsystem Realization|Ring-2|TQL-2|||
|EPIC-90|Avenger5_Safety::ls23_DelayedSpoofIsolation|ls23_DelayedSpoofIsolation Subsystem Realization|Ring-2|TQL-2|||
|EPIC-91|Avenger5_Safety::ls24_UnboundedInsDriftTimeout|ls24_UnboundedInsDriftTimeout Subsystem Realization|Ring-2|TQL-2|||
|EPIC-92|Avenger5_Safety::prop01_Rs485Corrupt|prop01_Rs485Corrupt Subsystem Realization|Ring-2|TQL-2|||
|EPIC-93|Avenger5_Safety::rtaSafetyCalculators|rtaSafetyCalculators Subsystem Realization|Ring-2|TQL-2|||
|EPIC-94|Avenger5_Safety::sc01_EnforceRbfPowerOrder|sc01_EnforceRbfPowerOrder Subsystem Realization|Ring-2|TQL-2|||
|EPIC-95|Avenger5_Safety::sc02_EnforceSafeSepBeforeDsc|sc02_EnforceSafeSepBeforeDsc Subsystem Realization|Ring-2|TQL-2|||
|EPIC-96|Avenger5_Safety::sc03_EnforcePl40LaunchEnvelope|sc03_EnforcePl40LaunchEnvelope Subsystem Realization|Ring-2|TQL-2|||
|EPIC-97|Avenger5_Safety::sc04_EnforceCan2FallbackControl|sc04_EnforceCan2FallbackControl Subsystem Realization|Ring-2|TQL-2|||
|EPIC-98|Avenger5_Safety::sc05_EnforceApproachSpeedAndAbort|sc05_EnforceApproachSpeedAndAbort Subsystem Realization|Ring-2|TQL-2|||
|EPIC-99|Avenger5_Safety::sc06_EnforceEsadRailAndCrcWatchdog|sc06_EnforceEsadRailAndCrcWatchdog Subsystem Realization|Ring-2|TQL-2|||
|EPIC-100|Avenger5_Safety::sc07_EnforceGeofenceAndInsFallback|sc07_EnforceGeofenceAndInsFallback Subsystem Realization|Ring-2|TQL-2|||
|EPIC-101|Avenger5_Safety::uca01_EsadPbitRailNotProvided|uca01_EsadPbitRailNotProvided Subsystem Realization|Ring-2|TQL-2|||
|EPIC-102|Avenger5_Safety::uca02_EsadEnableWithLatchedFault|uca02_EsadEnableWithLatchedFault Subsystem Realization|Ring-2|TQL-2|||
|EPIC-103|Avenger5_Safety::uca03_PrematureRbf3Removal|uca03_PrematureRbf3Removal Subsystem Realization|Ring-2|TQL-2|||
|EPIC-104|Avenger5_Safety::uca04_EsadPbitPollWindowExceeded|uca04_EsadPbitPollWindowExceeded Subsystem Realization|Ring-2|TQL-2|||
|EPIC-105|Avenger5_Safety::uca05_Pl40ReleaseNotProvided|uca05_Pl40ReleaseNotProvided Subsystem Realization|Ring-2|TQL-2|||
|EPIC-106|Avenger5_Safety::uca06_Pl40TriggeredOutOfEnvelope|uca06_Pl40TriggeredOutOfEnvelope Subsystem Realization|Ring-2|TQL-2|||
|EPIC-107|Avenger5_Safety::uca07_Pl40TriggeredBeforeCrewClear|uca07_Pl40TriggeredBeforeCrewClear Subsystem Realization|Ring-2|TQL-2|||
|EPIC-108|Avenger5_Safety::uca08_Pl40DualSwitchReleasedEarly|uca08_Pl40DualSwitchReleasedEarly Subsystem Realization|Ring-2|TQL-2|||
|EPIC-109|Avenger5_Safety::uca09_EsadSafeInhibitNotMaintained|uca09_EsadSafeInhibitNotMaintained Subsystem Realization|Ring-2|TQL-2|||
|EPIC-110|Avenger5_Safety::uca10_DscOrRs485BeforeSafeSep|uca10_DscOrRs485BeforeSafeSep Subsystem Realization|Ring-2|TQL-2|||
|EPIC-111|Avenger5_Safety::uca11_EnableBeforeEoTrackGate|uca11_EnableBeforeEoTrackGate Subsystem Realization|Ring-2|TQL-2|||
|EPIC-112|Avenger5_Safety::uca12_DscOrConfirmHoldOutOfWindow|uca12_DscOrConfirmHoldOutOfWindow Subsystem Realization|Ring-2|TQL-2|||
|EPIC-113|Avenger5_Safety::uca13_ApproachAbortNotProvided|uca13_ApproachAbortNotProvided Subsystem Realization|Ring-2|TQL-2|||
|EPIC-114|Avenger5_Safety::uca14_WaveoffCommandsExcessLoad|uca14_WaveoffCommandsExcessLoad Subsystem Realization|Ring-2|TQL-2|||
|EPIC-115|Avenger5_Safety::uca15_LateApproachAbort|uca15_LateApproachAbort Subsystem Realization|Ring-2|TQL-2|||
|EPIC-116|Avenger5_Safety::uca16_AbortHoldReleasedEarly|uca16_AbortHoldReleasedEarly Subsystem Realization|Ring-2|TQL-2|||
|EPIC-117|Avenger5_Safety::uca17_Can2SeriesChainOmission|uca17_Can2SeriesChainOmission Subsystem Realization|Ring-2|TQL-2|||
|EPIC-118|Avenger5_Safety::uca18_SaturatedFinOrWingCommand|uca18_SaturatedFinOrWingCommand Subsystem Realization|Ring-2|TQL-2|||
|EPIC-119|Avenger5_Safety::uca19_DroneCanActuationLate|uca19_DroneCanActuationLate Subsystem Realization|Ring-2|TQL-2|||
|EPIC-120|Avenger5_Safety::uca20_ServoBabblingPastFtti|uca20_ServoBabblingPastFtti Subsystem Realization|Ring-2|TQL-2|||
|EPIC-121|Avenger5_Safety::uca21_SpoofedGnssOrGeofenceOmission|uca21_SpoofedGnssOrGeofenceOmission Subsystem Realization|Ring-2|TQL-2|||
|EPIC-122|Avenger5_Safety::uca22_DrVectorEntersExclusionZone|uca22_DrVectorEntersExclusionZone Subsystem Realization|Ring-2|TQL-2|||
|EPIC-123|Avenger5_Safety::uca23_LateSpoofIsolationSwitch|uca23_LateSpoofIsolationSwitch Subsystem Realization|Ring-2|TQL-2|||
|EPIC-124|Avenger5_Safety::uca24_GnssDeniedDrDriftExceeded|uca24_GnssDeniedDrDriftExceeded Subsystem Realization|Ring-2|TQL-2|||
