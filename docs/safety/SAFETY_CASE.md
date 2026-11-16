# DEAP-03 Quantitative Safety Case

Deterministic safety case compiled from verified SysML v2 / RAAML strata (Tier-1, SPFM=1.000000, LFM=0.945547, lambda_cat=1.3000e-14 s^-1 \< 2.7778e-13 s^-1).

## 1\. Safety Assurance Chain Topology

````mermaid
flowchart TD
    subgraph SG_SAF["Five-Substep Verified Safety Chain (S1 to S5)"]
    direction TB
    S1["S1 STPA D1..D6 (3 Losses, 5 Hazards, 24 UCAs)"] --> S2["S2 EMV2 lfp (4 iters)"]
    S2 --> S3["S3 FMEDA (8 Modes, SPFM=1.0000, LFM=0.9455)"]
    S3 --> S4["S4 Minato ZBDD (5 Top Gates, 15 Nodes)"]
    S4 --> S5["S5 6-State CTMC (lambda_cat=1.300e-14 s^-1)"]
    end
````

## 2\. STPA Grounding Closure (D1..D6)

* Verified Losses (D1): 3
* Verified System Hazards (D2): 5
* Verified Control Actions (D3): 6
* Verified Unsafe Control Actions (D4): 24
* Verified Causal Loss Scenarios (D5): 24
* Controller / Safety Constraints (D6): 24 CSC + 7 SC (min FTTI = 0.050 s)

## 3\. Quantitative FMEDA Summary (Coherent SI s^-1)

|FM ID|Focus Fn|Sev|HFT|lam_raw (s^-1)|lam_dd (s^-1)|lam_du (s^-1)|AP|
|:----|:-------|:--|:--|:-------------|:------------|:------------|:-|
|FM-01-FCC-LOCKUP|oa05|S5|HFT=1|1.500e-12|5.970e-13|3.000e-15|LOW|
|FM-02-ESAD-INTERLOCK|oa05|S5|HFT=1|5.000e-13|1.743e-13|7.000e-16|LOW|
|FM-03-CAN2-DAISYCHAIN|oa05|S4|HFT=1|1.500e-12|7.455e-13|4.500e-15|LOW|
|FM-04-EPS-14V-RAIL|oa05|S4|HFT=1|9.000e-13|4.026e-13|2.430e-15|LOW|
|FM-05-ESAD-SAFESEP|oa05|S5|HFT=1|5.000e-13|1.743e-13|7.000e-16|LOW|
|FM-06-FCC-CAN1|oa05|S4|HFT=1|1.500e-12|5.970e-13|3.000e-15|LOW|
|FM-07-NAV-GNSS-INS|oa05|S4|HFT=1|1.000e-12|4.473e-13|2.700e-15|LOW|
|FM-08-RS485-BUS|oa05|S4|HFT=1|6.000e-13|2.684e-13|1.620e-15|LOW|

## 4\. Fault Tree Minimal Cut Sets (Minato ZBDD)

|Gate ID|Hazard|Severity|Min Cut Order|Implied HFT|MCS Count|
|:------|:-----|:-------|:------------|:----------|:--------|
|FTG-01-H01|H-01|S5|2|1|1|
|FTG-02-H02|H-02|S5|2|1|1|
|FTG-03-H03|H-03|S5|2|1|1|
|FTG-04-H04|H-04|S5|2|1|1|
|FTG-05-H05|H-05|S5|2|1|1|

## 5\. 6-State Kolmogorov CTMC Distribution

|Markov State|Terminal Probability P(T)|
|:-----------|:------------------------|
|S0|9.999999929800e-1|
|S1|9.899999930502e-15|
|S2|8.018999950419e-12|
|S3|2.571029981951e-14|
|S4|6.941745365335e-9|
|S5|7.019999977509e-11|
