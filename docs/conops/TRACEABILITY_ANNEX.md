# Stage M3.5 Post-Safety Bijective Traceability Annex

Isolated traceability annex preserving pre-STPA CONOPS.md and MISSION_INTENT.md digests.

````mermaid
flowchart TD
  subgraph TRIADS["Bijective Assurance Triads"]
    direction TB
    L1["LAO-01"] --> R1["REQ-01"]
    R1 --> T1["TEST-01"]
    L2["LAO-02"] --> R2["REQ-02"]
    R2 --> T2["TEST-02"]
    L3["LAO-03"] --> R3["REQ-03"]
    R3 --> T3["TEST-03"]
    L4["LAO-04"] --> R4["REQ-04"]
    R4 --> T4["TEST-04"]
    L5["LAO-05"] --> R5["REQ-05"]
    R5 --> T5["TEST-05"]
    L6["LAO-06"] --> R6["REQ-06"]
    R6 --> T6["TEST-06"]
    L7["LAO-07"] --> R7["REQ-07"]
    R7 --> T7["TEST-07"]
  end
````

|LAO ID|REQ ID|TEST ID|Target Crate|Method|Model Anchors|
|:-----|:-----|:------|:-----------|:-----|:------------|
|LAO-01|REQ-01|TEST-01|workspace|HardwareInLoop|lao01|
|LAO-02|REQ-02|TEST-02|workspace|HardwareInLoop|lao02|
|LAO-03|REQ-03|TEST-03|workspace|HardwareInLoop|lao03|
|LAO-04|REQ-04|TEST-04|workspace|FormalAnalysis|lao04|
|LAO-05|REQ-05|TEST-05|workspace|FormalAnalysis|lao05|
|LAO-06|REQ-06|TEST-06|workspace|UnitTest|lao06|
|LAO-07|REQ-07|TEST-07|workspace|Inspection|lao07|
