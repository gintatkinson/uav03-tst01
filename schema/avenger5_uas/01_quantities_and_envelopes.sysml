package Avenger5_Quantities {
  doc /* Coherent SI quantity definitions and grounded OEM physical constants for Avenger 5 V2.5, PL-40, and ESAD. */

  private import ISQ::*;
  private import RAAML::*;

  package SI_Domain {
    doc /* Derived affine-free coherent SI types extending ISQ::Real64. */

    attribute def Length_m :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "m"; dimL = 1; }
    }

    attribute def Mass_kg :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "kg"; dimM = 1; }
    }

    attribute def Speed_m_per_s :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "m/s"; dimL = 1; dimT = -1; }
    }

    attribute def Acceleration_m_per_s2 :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "m/s^2"; dimL = 1; dimT = -2; }
    }

    attribute def Pressure_Pa :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "Pa"; dimL = -1; dimM = 1; dimT = -2; }
    }

    attribute def Voltage_V :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "V"; dimL = 2; dimM = 1; dimT = -3; dimI = -1; }
    }

    attribute def Current_A :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "A"; dimI = 1; }
    }

    attribute def Power_W :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "W"; dimL = 2; dimM = 1; dimT = -3; }
    }

    attribute def Resistance_Ohm :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "Ohm"; dimL = 2; dimM = 1; dimT = -3; dimI = -2; }
    }

    attribute def Energy_J :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "J"; dimL = 2; dimM = 1; dimT = -2; }
    }
  }

  part def GroundedPlatformEnvelope {
    doc /* Normative physical, pneumatic, and electrical limits extracted from docs/reference/extracted/01..05*.md. */
    private import SI_Domain::*;

    attribute wingspanM : Length_m = 1.80 [m];
    attribute airframeLengthM : Length_m = 1.60 [m];
    attribute airframeHeightM : Length_m = 1.10 [m];
    attribute mtowKg : Mass_kg = 17.0 [kg];
    attribute payloadMeasuredMassKg : Mass_kg = 4.98 [kg];
    attribute launcherMaxPlaneMassKg : Mass_kg = 30.0 [kg];

    attribute stallSpeedV25Mps : Speed_m_per_s = 24.0 [m/s];
    attribute minSpeedV1Mps : Speed_m_per_s = 26.0 [m/s];
    attribute cruiseSpeedV1Mps : Speed_m_per_s = 30.0 [m/s];
    attribute cruiseSpeedV25Mps : Speed_m_per_s = 31.0 [m/s];
    attribute maxHorizSpeedV1Mps : Speed_m_per_s = 38.0 [m/s];
    attribute maxHorizSpeedV25Mps : Speed_m_per_s = 42.0 [m/s];
    attribute engagementMaxSpeedMps : Speed_m_per_s = 55.0 [m/s];
    attribute structuralMaxDiveMps : Speed_m_per_s = 80.0 [m/s];
    attribute pl40MaxLaunchVelMps : Speed_m_per_s = 25.0 [m/s];

    attribute groundWindMaxMps : Speed_m_per_s = 12.0 [m/s];
    attribute cruiseWindMaxMps : Speed_m_per_s = 28.0 [m/s];
    attribute serviceCeilingM : Length_m = 5000.0 [m];
    attribute minWaypointAltM : Length_m = 50.0 [m];
    attribute defaultLoiterRadiusM : Length_m = 300.0 [m];
    attribute terminalCepMaxM : Length_m = 0.50 [m];
    attribute rlosBaseM : Length_m = 60000.0 [m];

    attribute tempMinK : Temperature_K = 253.15 [K];
    attribute tempMaxK : Temperature_K = 323.15 [K];
    attribute maxEnduranceS : Duration_s = 5400.0 [s];

    attribute pl40TargetPressureMinPa : Pressure_Pa = 1300000.0 [Pa];
    attribute pl40TargetPressureMaxPa : Pressure_Pa = 1400000.0 [Pa];
    attribute pl40AuxMaxPressurePa : Pressure_Pa = 1600000.0 [Pa];
    attribute pl40RailAngleRad : PhaseAngle_rad = 0.20944 [rad];
    attribute pl40DualTriggerHoldMinS : Duration_s = 2.0 [s];

    attribute mainBattMinV : Voltage_V = 36.0 [V];
    attribute mainBattLaunchMinV : Voltage_V = 49.0 [V];
    attribute mainBattMaxV : Voltage_V = 50.4 [V];
    attribute mainFuseMaxA : Current_A = 200.0 [A];
    attribute epsServoRailV : Voltage_V = 8.0 [V];
    attribute epsRadioRailV : Voltage_V = 12.0 [V];
    attribute epsEsadRailV : Voltage_V = 14.0 [V];
    attribute epsIgniterRailV : Voltage_V = 50.0 [V];
    attribute dtcRadioPowerW : Power_W = 2.0 [W];

    attribute esadInputMinV : Voltage_V = 14.0 [V];
    attribute esadInputNomV : Voltage_V = 28.0 [V];
    attribute esadInputMaxV : Voltage_V = 32.0 [V];
    attribute esadUmbilicalMaxOhm : Resistance_Ohm = 0.5 [Ohm];
    attribute esadUmbilicalCurrentA : Current_A = 0.020 [A];
    attribute esadRs485RateHz : Frequency_Hz = 100.0 [Hz];
    attribute esadRs485ReplyMaxS : Duration_s = 0.005 [s];
    attribute esadRs485TimeoutS : Duration_s = 0.010 [s];
    attribute esadHoldCommandS : Duration_s = 5.0 [s];
    attribute groundRadioMinSepM : Length_m = 10.0 [m];
  }
}
