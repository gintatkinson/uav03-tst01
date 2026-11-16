# DEAP-03 Synthesized Design Contracts

Layer 4 Hybrid Pass 3 contract projection binding 120 boundary ports, 13 signal envelopes, 1 RTA Simplex monitors, and 3 RMA tasks into \`#!\[no_std\]\` Rust traits.

## 1\. Pass 3 Contract Synthesis Architecture

````mermaid
flowchart TD
    subgraph SG_P3["Hybrid Pass 3 Deterministic AST Synthesis"]
    direction TB
    IR["Verified CanonicalIr + Pass1/Pass2"] --> SYN["syn + quote AST"]
    SYN --> GEN_C["crates/deap-contracts/src/generated/mod.rs"]
    SYN --> GEN_K["verification/kani-proofs/src/generated/mod.rs"]
    SYN --> DOC_D["docs/designs/DESIGN_CONTRACTS.md"]
    end
````

## 2\. RTA Simplex ZCBF Barrier Contracts

|Monitor ID|gamma (s^-1)|t_switch (s)|t_rollback (s)|h_floor|
|:---------|:-----------|:-----------|:-------------|:------|
|RTA-A5-SIMPLEX|2.000|0.0100|0.0200|0.0500|

## 3\. Rate-Monotonic Analysis (Joseph-Pandya WCRT)

|Task ID|Priority|WCET (s)|Blocking (s)|WCRT (s)|Deadline (s)|Period (s)|
|:------|:-------|:-------|:-----------|:-------|:-----------|:---------|
|RMA-FCC-ATTITUDE|1|0.0008|0.0002|0.0010|0.0040|0.0040|
|RMA-FCC-NAV-EKF2|2|0.0012|0.0002|0.0022|0.0100|0.0100|
|RMA-RPI-ESAD-POLL|3|0.0015|0.0005|0.0040|0.0100|0.0100|
