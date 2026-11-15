---
name: spec-conops-engineering
description: "Models pre-STPA ConOps, METL, lifecycle modes, environmental envelopes, and emergency rules in SysML v2 (C1..C7 + C9) and verifies/projects docs/conops/ via ./.deap/bin/assemble-conops."
compatibility: "Requires ./.deap/bin/ingest-sysml and ./.deap/bin/assemble-conops."
metadata:
  title: "Hierarchical ConOps & Mission Intent Engineering (Worker ConOps)"
  category: specification
  risk: low
  source: custom
  version: "3.0"
---

# Concept of Operations & Mission Intent Engineering (Worker ConOps)

Use this skill to model the Level 1B operational envelope in canonical `SysML v2.0 + RAAML v1.0` (`schema/<domain>/`) and deterministically project `docs/conops/CONOPS.md`, `docs/conops/MISSION_INTENT.md`, and `.deap/conops.receipt.json` via `./.deap/bin/assemble-conops`.

## Single Source of Truth & Anti-Drift Invariant (`V-DRIFT`)

NEVER hand-edit compiler-projected `docs/conops/CONOPS.md` or `docs/conops/MISSION_INTENT.md`. If operational parameters, METL thresholds, lifecycle modes, or emergency transitions must change, update the canonical `.sysml` declarations in `schema/<domain>/`, re-seal `.deap/ir.snapshot.bin`, and re-run `assemble-conops project`.

## Pre-STPA Operational Slice (`C1..C7` + `C9`)

Ensure your `schema/<domain>/` operational model explicitly defines:

1. **System Boundary & Stakeholders (`C1`)**: `SystemOfInterest`, `Subsystem` partition, `ControlledProcess`, and `ExternalActor` entities (GCS operator, launch crew, airspace/ATC authority, payload supervisor).
2. **Lifecycle States & Mode Roles (`C2`)**: `state def` specializing `RAAML::LifecycleStateMachine` covering `ModeRole::Init`, `ModeRole::Nom`, `ModeRole::Deg`, and `ModeRole::SafeHold` annotated with `@RAAML::ThreeRing::LifecycleRole { role = ...; terminalSafe = ...; requiresSupReset = ...; }`.
3. **Operational Activities (`C3`)**: Mission phases and operational activities (`OA-01`..`OA-N`) specializing `RAAML::OperationalActivity` and annotated with `@RAAML::ThreeRing::OperationalActivity { oaId = "OA-01"; phase = "..."; summary = "..."; }` plus `@RAAML::ThreeRing::ActionPartition { kind = ActionKind::Ops | Control | Focus | Aux; }`.
4. **Mission Essential Task List (`C4` METL)**: Requirements specializing `RAAML::MissionEssentialTask` annotated with `@RAAML::ThreeRing::MissionTask { metId = "MET-01"; metricName = "..."; thresholdVal = ...; objectiveVal = ...; unitSym = "..."; }` grounded in OEM performance data (`docs/reference/extracted/`) and `docs/catalogs/MISSION_OPERATIONS_CATALOG.md`.
5. **Emergency Decision Rules (`C5`)**: Mandatory emergency rules (`EMG-01`..`EMG-07`+) annotated with `@RAAML::ThreeRing::EmergencyRule { emgId = "EMG-01"; triggerCondition = "..."; targetMode = ModeRole::Deg | ModeRole::SafeHold; maxReactionS = ... [s]; }` with explicit reaction times in coherent seconds (`s`) grounded in OEM fault/recovery procedures and RTA timing bounds.
6. **Airspace, SORA & Energy Margins (`C6`, `C7`, `C9`)**: Quantitative Ground Risk Buffer (`R_GRB`), operational ceiling/speed/wind envelopes, C2 link failover thresholds, and statutory energy reserve (`>= 20%` or OEM fuel/battery bingo reserve) anchored in ISQ attributes and requirements.

## Context Slicing, Check, & Projection Loop

Query bounded ConOps slices when auditing a specific operational node, verify `C1..C7` + `C9` readiness with `assemble-conops check`, and project master documentation and `.deap/conops.receipt.json` with `assemble-conops project`:

```sh
./.deap/bin/ingest-sysml seal --workspace . --schema-dir schema --out-snapshot .deap/ir.snapshot.bin && echo "STAGE1_SEAL: PASS"
./.deap/bin/assemble-conops check --workspace . --snapshot .deap/ir.snapshot.bin && echo "CONOPS_CHECK: PASS"
./.deap/bin/assemble-conops project --workspace . --snapshot .deap/ir.snapshot.bin --out-dir docs/conops --receipt .deap/conops.receipt.json && echo "CONOPS_PROJECT: PASS"
./.deap/bin/assemble-conops slice <QNAME_OR_NODE> --workspace . --snapshot .deap/ir.snapshot.bin
```

## Pure 7-Bit ASCII & KaTeX Integrity

- All authored `.sysml` descriptions and reference tables MUST use pure 7-bit LF ASCII (`0x20..=0x7E` + `0x0A`, zero tabs, zero CR, zero UTF-8 symbols).
- Never use inline `$ ... $` delimiters inside Markdown table cells; write units in plain ASCII (`m`, `m/s`, `m/s^2`, `deg`, `s`, `W`, `J`, `K`).
- Inspect `.deap/conops.receipt.json` and sample generated `docs/conops/{CONOPS,MISSION_INTENT}.md` after `assemble-conops project` to verify all OEM parameters, METL rows, and emergency rules projected accurately.
