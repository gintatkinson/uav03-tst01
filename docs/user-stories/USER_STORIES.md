# Stage P4 User Stories Specification

Testable Given/When/Then User Stories with coherent ISQ SI second \[s\] bounds.

|Story ID|Parent Feature|IR QName|Ring|Tier|Bound \[s\]|Requirements|Verification Tests|
|:-------|:-------------|:-------|:---|:---|:--------|:-----------|:-----------------|
|US-01|FEAT-01|Avenger5_ConOps::envOperatingEnvelope|Ring-2|TQL-2|1.000000|envOperatingEnvelope||
|US-02|FEAT-01|Avenger5_Verification::req01|Ring-2|TQL-2|1.000000|REQ-01|TEST-01|
|US-03|FEAT-01|Avenger5_Verification::req02|Ring-2|TQL-2|1.000000|REQ-02|TEST-02|
|US-04|FEAT-01|Avenger5_Verification::req03|Ring-2|TQL-2|1.000000|REQ-03|TEST-03|
|US-05|FEAT-01|Avenger5_Verification::req04|Ring-2|TQL-2|1.000000|REQ-04|TEST-04|
|US-06|FEAT-01|Avenger5_Verification::req05|Ring-2|TQL-2|1.000000|REQ-05|TEST-05|
|US-07|FEAT-01|Avenger5_Verification::req06|Ring-2|TQL-2|1.000000|REQ-06|TEST-06|
|US-08|FEAT-01|Avenger5_Verification::req07|Ring-2|TQL-2|1.000000|REQ-07|TEST-07|

## US-01: Realize envOperatingEnvelope (Pre-STPA operational environmental envelope (C7): 253.15 K to 323.15 K, \<= 12 m/s ground wind, \<= 28 m/s cruise wind, \<= 5000 m ceiling \[Spec Sheet\#p3\].)

* Given: operational guard for Avenger5_ConOps::VehicleAndEsadLifecycle::Deg_GnssDeniedOrLinkLoss is active
* When: stimulus exercises envOperatingEnvelope
* Then: Pre-STPA operational environmental envelope (C7): 253.15 K to 323.15 K, \<= 12 m/s ground wind, \<= 28 m/s cruise wind, \<= 5000 m ceiling \[Spec Sheet#p3\]. holds within 1.000 s or transitions to SafeHold

## US-02: Realize REQ-01 (Enforce ESAD RBF \#3 retention until Power RBF \#2 removal and clean SwarmC2 PBIT completion \[A5 Prep\#p23\].)

* Given: operational guard for Avenger5_ConOps::VehicleAndEsadLifecycle::Deg_GnssDeniedOrLinkLoss is active
* When: stimulus exercises REQ-01
* Then: Enforce ESAD RBF #3 retention until Power RBF #2 removal and clean SwarmC2 PBIT completion \[A5 Prep#p23\]. holds within 1.000 s or transitions to SafeHold

## US-03: Realize REQ-02 (Hold ESAD HV \< 50 V and inhibit DSC_IN1 / RS-485 Arm Enable until SS1 umbilical open and SS2 safe separation \[ESAD ICD\#p14-p23\].)

* Given: operational guard for Avenger5_ConOps::VehicleAndEsadLifecycle::Deg_GnssDeniedOrLinkLoss is active
* When: stimulus exercises REQ-02
* Then: Hold ESAD HV \< 50 V and inhibit DSC_IN1 / RS-485 Arm Enable until SS1 umbilical open and SS2 safe separation \[ESAD ICD#p14-p23\]. holds within 1.000 s or transitions to SafeHold

## US-04: Realize REQ-03 (Validate PL-40 pressure 13-14 bar, exit velocity \<= 25 m/s, rear-folded props, pin cleared, and >= 2 s dual switch hold \[PL-40\#p24-p26\].)

* Given: operational guard for Avenger5_ConOps::VehicleAndEsadLifecycle::Deg_GnssDeniedOrLinkLoss is active
* When: stimulus exercises REQ-03
* Then: Validate PL-40 pressure 13-14 bar, exit velocity \<= 25 m/s, rear-folded props, pin cleared, and >= 2 s dual switch hold \[PL-40#p24-p26\]. holds within 1.000 s or transitions to SafeHold

## US-05: Realize REQ-04 (Supervise Cube orange+ CAN 1 and CAN 2 daisy-chain heartbeats (servos, RM3100, SKYE2) within \<= 20 ms FTTI \[Block Diagram\#p1\].)

* Given: operational guard for Avenger5_ConOps::VehicleAndEsadLifecycle::Deg_GnssDeniedOrLinkLoss is active
* When: stimulus exercises REQ-04
* Then: Supervise Cube orange+ CAN 1 and CAN 2 daisy-chain heartbeats (servos, RM3100, SKYE2) within \<= 20 ms FTTI \[Block Diagram#p1\]. holds within 1.000 s or transitions to SafeHold

## US-06: Realize REQ-05 (Enforce \<= 55 m/s speed cap, 2-5 s track hold, \<= 15 deg pitch, and deterministic Abort Approach / 5 s Abort hold \[A5 Manual\#p84-p90\].)

* Given: operational guard for Avenger5_ConOps::VehicleAndEsadLifecycle::Deg_GnssDeniedOrLinkLoss is active
* When: stimulus exercises REQ-05
* Then: Enforce \<= 55 m/s speed cap, 2-5 s track hold, \<= 15 deg pitch, and deterministic Abort Approach / 5 s Abort hold \[A5 Manual#p84-p90\]. holds within 1.000 s or transitions to SafeHold

## US-07: Realize REQ-06 (Sustain EPS J100 rail >= 14.0 V under transient load and run RPI RS-485 polling at 100 Hz with \<= 5 ms reply \[ESAD ICD\#p14-p15\].)

* Given: operational guard for Avenger5_ConOps::VehicleAndEsadLifecycle::Deg_GnssDeniedOrLinkLoss is active
* When: stimulus exercises REQ-06
* Then: Sustain EPS J100 rail >= 14.0 V under transient load and run RPI RS-485 polling at 100 Hz with \<= 5 ms reply \[ESAD ICD#p14-p15\]. holds within 1.000 s or transitions to SafeHold

## US-08: Realize REQ-07 (Enforce polygon Exclusion/Inclusion geofences, INS GNSS-denied fallback, and OA-08 pre-launch scrub safeing SOP \[GAP-05\].)

* Given: operational guard for Avenger5_ConOps::VehicleAndEsadLifecycle::Deg_GnssDeniedOrLinkLoss is active
* When: stimulus exercises REQ-07
* Then: Enforce polygon Exclusion/Inclusion geofences, INS GNSS-denied fallback, and OA-08 pre-launch scrub safeing SOP \[GAP-05\]. holds within 1.000 s or transitions to SafeHold
