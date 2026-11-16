% SLDV Formal Proof Script
% Schema constraint bindings
sldv.assert( (in packVoltageV Real && in busVoltageV Real && attribute invariantExpr String == 'packVoltageV >= 49.0 and packVoltageV <= 50.0 and busVoltageV >= 36.0 and busVoltageV <= 50.4'), 'Bind_MAINBATTERYPREFLIGHTVOLTAGECONSTRAINT_ASSERTION' );
sldv.assert( (in reserveRatio Real && attribute invariantExpr String == 'reserveRatio >= 0.20'), 'Bind_BINGOENERGYRESERVECONSTRAINT_ASSERTION' );
sldv.assert( (in airspeedMs Real && in engagementActive Boolean && attribute invariantExpr String == 'airspeedMs >= 24.0 and airspeedMs <= 80.0 and (not engagementActive or airspeedMs <= 55.0)'), 'Bind_FLIGHTENVELOPESPEEDCONSTRAINT_ASSERTION' );
sldv.assert( (in epsEsadOutV Real && attribute invariantExpr String == 'epsEsadOutV >= 14.0 and epsEsadOutV <= 32.0'), 'Bind_EPSESADZEROBROWNOUTMARGINCONSTRAINT_ASSERTION' );
sldv.assert( (in rndRecoveryOptionInstalled Boolean && attribute invariantExpr String == 'rndRecoveryOptionInstalled == false'), 'Bind_PRODUCTIONNOPARACHUTECONSTRAINT_ASSERTION' );
sldv.assert( (in calmAirMs Real && in blownAirMs Real && attribute invariantExpr String == 'calmAirMs <= 3.0 and blownAirMs >= 10.0'), 'Bind_PITOTPREFLIGHTCALIBRATIONCONSTRAINT_ASSERTION' );
sldv.assert( (in finCount Integer && in wingCount Integer && in magCount Integer && in stubLenCm Real && attribute invariantExpr String == 'finCount == 4 and wingCount == 4 and magCount == 2 and stubLenCm == 120.0'), 'Bind_CANTOPOLOGYISOLATIONCONSTRAINT_ASSERTION' );
sldv.assert( (in standaloneRtaBoxCount Integer && in rtaHostedOnCubeOrangePlus Boolean && attribute invariantExpr String == 'standaloneRtaBoxCount == 0 and rtaHostedOnCubeOrangePlus == true'), 'Bind_SIMPLEXRTASOFTWAREHOSTINGCONSTRAINT_ASSERTION' );
sldv.assert( (in vdcInV Real && attribute invariantExpr String == 'vdcInV >= 14.0 and vdcInV <= 32.0'), 'Bind_ESADINPUTVOLTAGEANDBROWNOUTCONSTRAINT_ASSERTION' );
sldv.assert( (in baudBps Integer && in pollHz Real && in replyMs Real && in timeoutMs Real && attribute invariantExpr String == 'baudBps == 115200 and pollHz == 100.0 and replyMs <= 5.0 and timeoutMs <= 10.0'), 'Bind_ESADRS485PROTOCOLTIMINGCONSTRAINT_ASSERTION' );
sldv.assert( (in uavPoweredBeforeRbf3Pull Boolean && in umbResistanceOhm Real && attribute invariantExpr String == 'uavPoweredBeforeRbf3Pull == true and umbResistanceOhm < 0.5'), 'Bind_ESADRBF3POWERBEFOREPULLCONSTRAINT_ASSERTION' );
sldv.assert( (in safeDistanceExceeded Boolean && in ss1Sensed Boolean && attribute invariantExpr String == 'safeDistanceExceeded == true and ss1Sensed == true'), 'Bind_ESADSAFEDISTANCEEXCEEDCONSTRAINT_ASSERTION' );
sldv.assert( (in warheadMassKg Real && in pbitHvV Real && in fireHvV Real && attribute invariantExpr String == 'warheadMassKg <= 5.0 and pbitHvV < 50.0 and fireHvV >= 0.0 and fireHvV <= 1800.0'), 'Bind_WARHEADMASSANDPBITHVSAFETYCONSTRAINT_ASSERTION' );
sldv.assert( (in airspeedMs Real && in trackHoldSec Real && in cepM Real && attribute invariantExpr String == 'airspeedMs <= 55.0 and trackHoldSec >= 2.0 and trackHoldSec <= 5.0 and cepM <= 0.5'), 'Bind_ENGAGEMENTSPEEDANDTRACKHOLDCONSTRAINT_ASSERTION' );
sldv.assert( (in uavMassKg Real && in pressureBar Real && in exitVelMs Real && in windMs Real && attribute invariantExpr String == 'uavMassKg <= 30.0 and pressureBar >= 13.0 and pressureBar <= 14.0 and exitVelMs <= 25.0 and windMs <= 12.0'), 'Bind_PL40MASSANDEXITVELOCITYCONSTRAINT_ASSERTION' );
sldv.assert( (in packVoltageV Real && in dualHoldSec Real && attribute invariantExpr String == 'packVoltageV > 14.5 and dualHoldSec >= 2.0'), 'Bind_PL40UVLOANDDUALSWITCHCONSTRAINT_ASSERTION' );
sldv.assert( (in passwordLen Integer && in missionNameLen Integer && in waypointAltM Real && in loiterRadiusM Real && attribute invariantExpr String == 'passwordLen >= 8 and missionNameLen <= 24 and waypointAltM >= 50.0 and waypointAltM <= 3000.0 and loiterRadiusM >= 300.0'), 'Bind_SWARMC2AUTHANDMISSIONBOUNDSCONSTRAINT_ASSERTION' );
sldv.assert( (in esdGrounded Boolean && in separationM Real && attribute invariantExpr String == 'esdGrounded == true and separationM >= 10.0'), 'Bind_GROUNDCREWSEPARATIONANDESDCONSTRAINT_ASSERTION' );

% Theorem proof bindings
