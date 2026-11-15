# Stage P4 Use Cases Specification

Operational Use Cases covering Nominal, Degraded, and SafeHold Emergency flows.

|Use Case ID|IR QName|Title|Nominal Flow|Degraded Flow|Emergency Flow|Requirements|
|:----------|:-------|:----|:-----------|:------------|:-------------|:-----------|
|UC-01|Avenger5_ConOps::scn01NominalMission|Operational Scenario: scn01NominalMission|Execute Avenger5_ConOps::scn01NominalMission within nominal ISQ envelope|Shed non-essential load on Avenger5_ConOps::scn01NominalMission while preserving safety invariants|Latch safety violation on Avenger5_ConOps::scn01NominalMission and transition deterministically to SafeHold|REQ-01, REQ-02, REQ-03, REQ-04, REQ-05, REQ-06|
|UC-02|Avenger5_ConOps::scn02DegradedGnssAndLinkLoss|Operational Scenario: scn02DegradedGnssAndLinkLoss|Execute Avenger5_ConOps::scn02DegradedGnssAndLinkLoss within nominal ISQ envelope|Shed non-essential load on Avenger5_ConOps::scn02DegradedGnssAndLinkLoss while preserving safety invariants|Latch safety violation on Avenger5_ConOps::scn02DegradedGnssAndLinkLoss and transition deterministically to SafeHold|REQ-07|
|UC-03|Avenger5_ConOps::scn03EmergencyAbortAndScrub|Operational Scenario: scn03EmergencyAbortAndScrub|Execute Avenger5_ConOps::scn03EmergencyAbortAndScrub within nominal ISQ envelope|Shed non-essential load on Avenger5_ConOps::scn03EmergencyAbortAndScrub while preserving safety invariants|Latch safety violation on Avenger5_ConOps::scn03EmergencyAbortAndScrub and transition deterministically to SafeHold|REQ-05, REQ-07|
