# Hazard Log

| ID | Kind | Source | Status | Notes |
| :--- | :--- | :--- | :--- | :--- |
| L-1 | Loss | Avenger5V25IntegratedSystem | Open | Loss of safe functional integrity of Avenger5V25IntegratedSystem (AST Derived) |
| H-1 | Hazard | Avenger5V25IntegratedSystem / ValidateBatteryAndPowerOnRbf2 | Open | Enforced by SC-001 (Catastrophic (Derived)); guard MainBatteryPreFlightVoltageConstraint |
| H-2 | Hazard | Avenger5V25IntegratedSystem / CommandPusherThrottleAndReadEscTelem | Open | Enforced by SC-005 (Catastrophic (Derived)); guard ProductionNoParachuteConstraint |
| H-3 | Hazard | Avenger5V25IntegratedSystem / DistributeRegulatedPowerRails | Open | Enforced by SC-009 (Catastrophic (Derived)); guard EsadInputVoltageAndBrownoutConstraint |
| H-4 | Hazard | Avenger5V25IntegratedSystem / MonitorBingoEnergyReserve | Open | Enforced by SC-013 (Catastrophic (Derived)); guard WarheadMassAndPbitHvSafetyConstraint |
| H-5 | Hazard | Avenger5V25IntegratedSystem / ExecuteSimplexRtaEnvelopeCheck | Open | Enforced by SC-017 (Catastrophic (Derived)); guard SwarmC2AuthAndMissionBoundsConstraint |
| H-6 | Hazard | Avenger5V25IntegratedSystem / RunPitotAndMagPreflightCheck | Open | Enforced by SC-021 (Catastrophic (Derived)); guard FlightEnvelopeSpeedConstraint |
| H-7 | Hazard | Avenger5V25IntegratedSystem / SwitchToGnssDeniedDeadReckoning | Open | Enforced by SC-025 (Catastrophic (Derived)); guard CanTopologyIsolationConstraint |
| H-8 | Hazard | Avenger5V25IntegratedSystem / SuperviseEsadOcMasterCycle | Open | Enforced by SC-029 (Catastrophic (Derived)); guard EsadRbf3PowerBeforePullConstraint |
| H-9 | Hazard | Avenger5V25IntegratedSystem / ActuateTailAndWingSurfaces | Open | Enforced by SC-033 (Catastrophic (Derived)); guard Pl40MassAndExitVelocityConstraint |
| H-10 | Hazard | Avenger5V25IntegratedSystem / ExecuteEsadBootAndPbit | Open | Enforced by SC-037 (Catastrophic (Derived)); guard MainBatteryPreFlightVoltageConstraint |
| H-11 | Hazard | Avenger5V25IntegratedSystem / TransitionEsadArmingSequence | Open | Enforced by SC-041 (Catastrophic (Derived)); guard ProductionNoParachuteConstraint |
| H-12 | Hazard | Avenger5V25IntegratedSystem / CommandEsadAbortAndSelfDestruct | Open | Enforced by SC-045 (Catastrophic (Derived)); guard EsadInputVoltageAndBrownoutConstraint |
| H-13 | Hazard | Avenger5V25IntegratedSystem / AcquireAndTrackTerminalTarget | Open | Enforced by SC-049 (Catastrophic (Derived)); guard WarheadMassAndPbitHvSafetyConstraint |
| H-14 | Hazard | Avenger5V25IntegratedSystem / RebootGimbalAndBridgeEthernet | Open | Enforced by SC-053 (Catastrophic (Derived)); guard SwarmC2AuthAndMissionBoundsConstraint |
| H-15 | Hazard | Avenger5V25IntegratedSystem / ChargePl40CompressorWithUvloCheck | Open | Enforced by SC-057 (Catastrophic (Derived)); guard FlightEnvelopeSpeedConstraint |
| H-16 | Hazard | Avenger5V25IntegratedSystem / ExecuteLaunchGoNoGoAndDualTrigger | Open | Enforced by SC-061 (Catastrophic (Derived)); guard CanTopologyIsolationConstraint |
| H-17 | Hazard | Avenger5V25IntegratedSystem / DepressurizeAndScrubPl40Launcher | Open | Enforced by SC-065 (Catastrophic (Derived)); guard EsadRbf3PowerBeforePullConstraint |
| H-18 | Hazard | Avenger5V25IntegratedSystem / AuthenticateOperatorAndCalibrateRotator | Open | Enforced by SC-069 (Catastrophic (Derived)); guard Pl40MassAndExitVelocityConstraint |
| H-19 | Hazard | Avenger5V25IntegratedSystem / ExportTargetReport5wCff | Open | Enforced by SC-073 (Catastrophic (Derived)); guard MainBatteryPreFlightVoltageConstraint |

| Resolution Authority | Avenger5V25UasSystem Safety Governance Authority (Derived) |

