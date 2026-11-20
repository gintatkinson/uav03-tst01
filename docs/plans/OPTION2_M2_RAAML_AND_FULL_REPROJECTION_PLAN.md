# Option-2 Master Execution Plan & Turn-1 Fresh-Session Dispatch Specification

## 1. Objective, Single Work-Package Scope & Preserved Working Tree

- **Target Repository**: `./` (`gintatkinson/uav03-tst01`, `DOWNSTREAM_CUSTOMER_PROJECT`, baseline commit `245bbc0` synced with `origin/main`, precompiled Tier-0 release binaries matching `DEAP01-spec-core` `dd62601` / `#867`).
- **Single Atomic Option-2 Work Package (`AGENTS.md` Continuous Execution After Turn-1 `PROCEED`)**:
  Execute one end-to-end specification-model composition and full downstream SSOT re-projection across 5 sequential stages:
  1. **Stage 1**: Replace M1-contaminated `skills/spec-schematic-ingestion/` with the pure Check-19 M2 skill package `skills/spec-source-ingestion/` and surgically update `README.md`.
  2. **Stage 2**: Vendor `https://github.com/gintatkinson/esad-sysmlv2/tree/Antigravity/schema/esad` (pinned commit `3c902b9bc1af37cc5751d54a90f0bbc8f4224a8b`, `7` `.sysml` files + `ANOMALY_AND_TBD_LOG.md`, replacing deleted `docs/reference/ESAD flow charts.pdf`) immutably under `docs/reference/esad-sysmlv2/`, migrate `schema/schematic_ledger.json` -> `schema/source_graph_ledger.json` (adding `DOC-07`), fix the `4` residual structural defects in `schema/model.sysml`, lower 100% of `ESADModel` semantics into `schema/model.sysml` (DEAP SysML subset syntax), synchronize `schema/extracted/*` for Check 23, and compile `.pipeline/schema.sysml` + `.pipeline/schema-digest.json`.
  3. **Stage 3**: Re-project `docs/research/` (per-component FMECA swarm across every AST `part def`), 10-pillar `docs/safety/` STPA/FMECA/SLDV suite, `docs/conops/` + `docs/architecture/views/*.mmd` (`assemble-conops --verify`), and `docs/interfaces/` Level 1C ICDs.
  4. **Stage 4**: Purge stale `Nov 16` backlog files, re-project `docs/{epics,features,user-stories,use-cases}/`, synthesize Level 4 WBS `docs/management/` (`Check 20`), and reconcile live GitHub issues `#1..#51`+ on `gintatkinson/uav03-tst01`.
  5. **Stage 5**: Pass all coordinator verification gates + `Blind Audit #3`, commit explicit paths, push to `origin/main`, apply `status:fixed-resolved` evidence on referenced issues, and write `walkthrough.md`.
- **Precedence & Supersession Over `SCHEMATIC_INGESTION_SKILL_AND_MODEL_PLAN.md` (`7b368e6`)**:
  - **Adopt ONLY**: Sections 2 and 3 of `docs/plans/SCHEMATIC_INGESTION_SKILL_AND_MODEL_PLAN.md` (`FM-01..FM-06` and the pure-M2 skill design, generalized in `C7` below so non-paged structured model sets validate under `"additionalProperties": false`).
  - **Explicitly Superseded (Do NOT Enforce)**: `SCHEMATIC`'s strict stop-at-SysML ceiling (`L12-15`), `SCHEMATIC`'s legacy quarantine over `README.md`, `schema/extracted/*`, prior `schema/model.sysml`, and `docs/**` (`L218`, `L227`), `SCHEMATIC` Section 4 Turn-1 prompt (`L213-238`), and `SCHEMATIC`'s pre-`245bbc0` empty `git status --porcelain` precondition on Turn 1 (`L237`).
- **Explicit Preserved Working-Tree Mandate**:
  - At baseline `245bbc0`, `26` tracked files are modified (`M`) on disk from the `#867` ConOps fix and MUST be preserved intact on Turn 1 (`0` `git checkout`, `0` `git restore`, `0` `git reset`, `0` `git stash`):
    - `docs/architecture/views/{icd_system_interface_matrix,sv1_platform_subsystems,sv1_super_system}.mmd` (`3` files)
    - `docs/conops/MISSION_INTENT.md` (`1` file)
    - `docs/conops/units/conops/01..12_*.md` (`12` files)
    - `docs/conops/units/mission_intent/01..10_*.md` (`10` files)
  - These `26` files are refined in Stage 3 and committed/pushed in Stage 5, after which `git status --porcelain` MUST be empty.

---

## 2. Empirically Proven Compiler, Verifier, Schema & Governance Guardrails (`C1..C7`)

- **`C1` (Verified DEAP SysML Subset Grammar, OMG/RAAML Placement & Check 31)**:
  - `./target/release/compile-sysml --compile` and `./target/release/ingest-sysml` accept ONLY the DEAP SysML subset grammar (`doc`, `package`, `part def`, `part`, `port def` with `attribute direction = ...`, `port`, `item def`, `connection def` with `connect a to b;`, `state def` with `state`/`transition`, `action def`, `constraint def`, `requirement def` with `@TriggersHazard`/`@SafetyRealises`/`satisfy requirement`, `use case def`, `test case def` with `verify requirement`, `capability def`, `interaction def`). They reject OMG SysML v2.0 + RAAML v1.0 constructs (`private import`, `public import`, `#houseEvent`, `#basicEvent`, `#andGate`, `ref x ::> y :> inputs`, `:>>`, `[s]`) with `Parse error: Unexpected token 'Ident("private")'`.
  - `./target/release/verify-baseline` Check 31 (`Dual-Schema SSOT Parity Gate`) enforces identical AST definitions across `schema/*.sysml`, `schema/model.sysml`, and `.pipeline/schema.sysml` and rejects sibling `.sysml` files inside `schema/`.
  - **Mandatory Placement**: Vendor the verbatim `esad-sysmlv2@3c902b9` files under `docs/reference/esad-sysmlv2/` (NEVER under `schema/`) via:
    `gh api -H "Accept: application/vnd.github.raw+json" "repos/gintatkinson/esad-sysmlv2/contents/<path>?ref=3c902b9bc1af37cc5751d54a90f0bbc8f4224a8b" | cat`
    (never pass `--jq` with `Accept: application/vnd.github.raw+json`). Keep `schema/model.sysml` as the sole `.sysml` file under `schema/`.
- **`C2` (Canonical Exact CLI Invocations Verified Against `--help`)**:
  - **Explicit `--schema` File Path Only**: Never pass a directory containing `.md` files to `./target/release/compile-sysml --schema` (causes hangs). Standardize on these exact tested invocations across the entire session:
    - Ingestion gate: `./target/release/ingest-sysml --schema schema/model.sysml --out .pipeline/schema.sysml --digest .pipeline/schema-digest.json --allowed-parts "<ACTIVE_PART_DEFS_CSV>" --negative-invariants "<EXCLUDED_VARIANTS_CSV>"` (pass active `PartDef`s / forbidden entity identifiers from `schema/source_graph_ledger.json`).
    - Compile gate: `./target/release/compile-sysml --compile --schema schema/model.sysml --out .pipeline/schema.sysml --digest .pipeline/schema-digest.json`
    - STPA transpile: `./target/release/compile-sysml --stpa-transpile --schema .pipeline/schema.sysml --out-dir docs/safety/ --force`
    - Forward sync: `./target/release/compile-sysml --forward-sync --schema .pipeline/schema.sysml --docs docs/ --force`
    - Reverse sync (when spec edits update behavior/trace links): `./target/release/compile-sysml --reverse-sync --schema .pipeline/schema.sysml --docs docs/ --out .pipeline/schema.sysml --digest .pipeline/schema-digest.json`
    - ConOps verify & assemble: `./target/release/assemble-conops --input-dir docs/conops/units/ --output-dir docs/conops/ --verify .`
    - Baseline verify (coordinator ONLY): `./target/release/verify-baseline . --spec-only --only "<spec_file>"`, `./target/release/verify-baseline . --spec-only`, `./target/release/verify-baseline . --no-domain`
    - Commit-message non-closure check: `./target/release/verify-baseline check-commit-msg --check-text "<commit_msg>"` (before commit) and `./target/release/verify-baseline check-commit-msg --head` (after commit)
    - Tracker issue per-item create/update: `./target/release/reconcile-backlog create-issue --body-file "<local-md-file>" --label "<type>" --title "<title>"`
    - Tracker global sync sweep: `./target/release/reconcile-backlog --provider github --sync-bodies`
- **`C3` (Auto-Generated `.pipeline/defects/defect_*` Cleanup Awareness)**:
  - Failing `./target/release/verify-baseline` runs write `.pipeline/defects/defect_<timestamp>.{json,md}` on disk. Resolve root causes until all verification gates exit `0`, and delete any transient auto-generated `defect_<timestamp>.*` scratch files via a bounded `TypeName="self"` subagent before Stage 5 git commit.
- **`C4` (Strict Coordinator Locks, Coordinator-Only Verification, Symlink & Subagent Cleanup)**:
  - Turn 1 writes `<appDataDir>/brain/<conversation-id>/implementation_plan.md` covering Stages 1-5 and STOPS for explicit user `PROCEED`.
  - Coordinator performs `0` repository file writes/edits, `0` shell file mutations (`cp`, `mv`, `rm`, `tee`, `sed -i`, `>`, `>>`), `0` Python/Perl/Ruby/Node (`Check 33`), and `0` `*.sh` scripts (`Check 32`).
  - All repository writes run inside context-isolated `TypeName="self"` subagents tagged with `DOWNSTREAM_CUSTOMER_PROJECT`, `---GOVERNANCE-END---`, and `PROCEED` (at most `1` specification item per subagent in Stage 3-4 workflows; first step `read_file` on the governing `SKILL.md` for skill workflows).
  - Per `AGENTS.md` lines 33 and 84, **single-item writer subagents MUST NEVER run `./target/release/verify-baseline`, `cargo`, `git commit`, or `git push`**; the **coordinator** runs `./target/release/verify-baseline . --spec-only --only "<spec_file>"` after each subagent/batch completes and dispatches targeted repair subagents if any check fails.
  - Reclaim/kill every subagent immediately via `manage_subagents(Action: "kill")`. Note `.agents/skills` is a symlink (`-> ../skills`).
- **`C5` (Zero-PDF Coordinator & Multimodal Single-Pass Rule)**:
  - Coordinator NEVER calls `read_file` on any `.pdf`. Any subagent inspecting a `.pdf` reads at most `1` `.pdf` once (`0` `StartLine`/`EndLine` args), runs strictly solo (`0` concurrent peers) when file size `> 2,000,000` bytes, and returns a `<= 250`-word delta reply.
- **`C6` (External Repository Firewall & Content Hygiene)**:
  - Never read, list, grep, stat, or touch `../deap04`, `../deap03`, `~/.deap/keys/*`, or `../DEAP01-spec-core/crates/*`.
  - Enforce zero Unicode em/en dashes (`\u2014` / `\u2013`), zero auto-closing commit keywords (`fix #`, `fixes #`, `close #`, `resolve #` -- use `(refs #<id>)`), zero `[TBD]`/`TODO` placeholders in Markdown prose (Check 23), and workspace-relative `./...` paths everywhere.
- **`C7` (Pure-M2 Multi-Modal Schema Generalization -- Check 19 Safe & `DOC-07` Valid)**:
  - Generalize `SCHEMATIC` Sec. 3.1 inside `skills/spec-source-ingestion/resources/source_graph_ledger_schema.json` using strictly pure-M2 fields (ZERO `ESAD`, `RAAML`, `Avenger`, hardware, protocol, or vendor tokens inside `skills/spec-source-ingestion/**`) while preserving `"additionalProperties": false` on every object:
    - `source_documents[]`: replace rigid integer-only `page_count` / `inspected_pages[]` with:
      - `doc_id`, `relative_path`, `source_kind` (`"paged_document" | "structured_model_set" | "text_specification"`), `file_size_bytes` (`integer >= 1`), `unit_count` (`integer >= 1`), `inspected_units` (`array`, `minItems: 1`, `items: { "type": ["integer", "string"] }`).
    - `source_ref`: `{ "doc_id": string, "unit": { "type": ["integer", "string"] }, "locator": string }`.
  - Inside `skills/spec-source-ingestion/references/blind_source_graph_audit_protocol.md`: define reusable pure-M2 verification across any `source_kind` (`Audit #1` per assigned source doc + global ledger audit; `Audit #2` ledger <-> `schema/model.sysml` + digest bijection; `Audit #3` `transcript_full.jsonl` delegation, `0`-PDF coordinator, `0` external repo access, and conditional clean-room quarantine verification only when invoked in cold-quarantine mode).

---

## 3. 5-Stage End-to-End Execution Architecture

### Stage 1: Replace `skills/spec-schematic-ingestion/` with Pure-M2 `skills/spec-source-ingestion/` & Update `README.md`
1. **Skill Authoring & Cleanup (`TypeName="self"` subagents, `PROCEED`)**:
   - Create `skills/spec-source-ingestion/` implementing `SCHEMATIC` Sec. 3 as updated by `C7`:
     - `skills/spec-source-ingestion/SKILL.md` (zero M1/domain/medium/protocol/vendor tokens; covers both `paged_document` visual sources and `structured_model_set` / `text_specification` sources cleanly; enforces Laws `L1..L8` with `REQ_L_*`, `REQ_H_*`, `REQ_UCA_*` `@TriggersHazard`, `REQ_SC_*` `@SafetyRealises`, `TC_*` `verify requirement`).
     - `skills/spec-source-ingestion/resources/source_graph_ledger_schema.json` (Draft 2020-12 JSON Schema with `"$defs": { "document_shard": ... }`, `"additionalProperties": false`, `Check 19` closed `m2_role`, `unit_count`/`inspected_units[]`/`source_ref.unit`).
     - `skills/spec-source-ingestion/references/blind_source_graph_audit_protocol.md` (`C7` audit protocol).
     - `skills/spec-source-ingestion/references/sysml_v2_compiler_grammar.md` (pure `Meta*` / M2 DEAP SysML subset template matching `C1`).
   - Delete `skills/spec-schematic-ingestion/` cleanly via a bounded `TypeName="self"` subagent.
   - Surgically update `README.md` (`edit_file`, `0` wholesale replacement) to replace `spec-schematic-ingestion` / `schematic_ledger.json` references with `spec-source-ingestion` / `source_graph_ledger.json` and note `docs/reference/esad-sysmlv2/`. Reclaim subagents immediately.
2. **Stage 1 Verification Gates (Coordinator + `TypeName="research"`)**:
   - Extract the fenced SysML snippet from `skills/spec-source-ingestion/references/sysml_v2_compiler_grammar.md` into `<appDataDir>/brain/<conversation-id>/scratch/grammar_check.sysml` and verify:
     `./target/release/compile-sysml --compile --schema <scratch>/grammar_check.sysml --out <scratch>/grammar_out.sysml --digest <scratch>/grammar_digest.json` exits `0`.
   - Dispatch `1` `TypeName="research"` Check-19 M2 Purity Auditor inspecting all `4` files under `skills/spec-source-ingestion/` verifying `0` M1 domain, customer, product (`ESAD`, `Avenger`), framework (`RAAML`), medium, protocol, or unit leaks (`4/4` clean). Reclaim immediately.

### Stage 2: Vendor `esad-sysmlv2@3c902b9`, Migrate Source Ledger, Fix `schema/model.sysml`, Sync `schema/extracted/*` & Compile SSOT
1. **Immutable Source Vendoring (`TypeName="self"` subagent, `PROCEED`)**:
   - Download verbatim from `gintatkinson/esad-sysmlv2` commit `3c902b9bc1af37cc5751d54a90f0bbc8f4224a8b` (`Antigravity` branch, `schema/esad/`) into `docs/reference/esad-sysmlv2/`:
     `ESAD_Package.sysml`, `ESAD_TypesAndPorts.sysml`, `ESAD_Unit.sysml`, `ESAD_OperationalFlow.sysml`, `ESAD_SoftwareFunctionalFlow.sysml`, `ESAD_ModeStatesAndFaultMonitors.sysml`, `ESAD_RAAMLSafety.sysml`, `ANOMALY_AND_TBD_LOG.md`.
   - Write `docs/reference/esad-sysmlv2/MANIFEST.json` recording source repo, branch, commit SHA, exact URLs, byte counts, and SHA-256 digests; verify `test ! -e "docs/reference/ESAD flow charts.pdf"`. Reclaim immediately.
2. **Shard Extraction (`DOC-07`) & Ledger Migration (`TypeName="self"` subagents, `PROCEED`)**:
   - Extract `.pipeline/diagnostics/shards/DOC-07.json` from `docs/reference/esad-sysmlv2/*` conforming to `$defs.document_shard` in `skills/spec-source-ingestion/resources/source_graph_ledger_schema.json`.
   - Migrate `schema/schematic_ledger.json` -> `schema/source_graph_ledger.json` (upgrade `DOC-01..06` entries to `source_kind: "paged_document"` with `unit_count` / `inspected_units` / `source_ref.unit`, incorporate `DOC-07`, apply the `4` structural fixes across `enclosures`/`component_types`/`component_instances`/`connections`/`cross_document_reconciliations`, and delete `schema/schematic_ledger.json`). Reclaim immediately.
   - Dispatch **Blind Audit #1 (`TypeName="research"`)**:
     - Shard `DOC-07`: audit `docs/reference/esad-sysmlv2/*` against `DOC-07` in `schema/source_graph_ledger.json`.
     - Shard `DOC-01`: single whole-PDF read of `Avenger5_V2.5_block_diagram_rev5.pdf` (`329,050` B `< 2 MB`) verifying `ASTK A5 V2.5` containment (`ethSwitch`, `rpi`), airframe placement, and `Septentrio` `Serial` link (`0` `EPS -> GNSS` wire).
     - Shard `DOC-03` (**strictly solo**, `2,041,999` B `> 2 MB`): single whole-PDF read of `ESAD ICD_for Excalibur_AB00-0054-01AA-0005 2 1.pdf` verifying `IRQ_L` hardware-OR on `ProximitySensorBoard`, connector/pinouts, and `100 Hz` polling note.
     - Global Ledger Audit (`0` PDFs): validate JSON Schema conformance (`DOC-01..07`), foreign-key integrity, Law `L6` reachability, and `cross_document_reconciliations[]`. Reclaim all auditors immediately upon `0` discrepancies.
3. **Fix `4` Residual Defects & Lower 100% of `ESADModel` in `schema/model.sysml` (`TypeName="self"` subagent, `PROCEED`)**:
   - Resolve all `4` residual defects:
     1. Move `ethSwitch : EthSwitch` and `rpi : RpiCm5004032` from `AirVehicleAvengerV25` into `AutopilotStackModuleAstkA5V25` with explicit typed boundary port delegations (`Law L1`, `Law L4`).
     2. Move airframe attributes (`wingspanM`, `lengthM`, `heightM`, `maximumTakeoffWeightKg`, `wingMountBoltSpec`, `airframeFinishColor`) off `AutopilotCubeOrangePlus` onto `AirVehicleAvengerV25`.
     3. Delete fabricated `WIRE-DOC01-03` (`CONN_WIRE_DOC01_03_*`), `REQ_GAP_DOC01_04`, `TC_REQ_GAP_DOC01_04`, and `gnssPowerOut` on `EpsElectronicPowerSystemModule`; set `supply_satisfaction_mode = "co_carried_on_connection"` and `carries_resource_supply = true` on `Cube orange+ <-> Septentrio` `Serial` (`WIRE-042`).
     4. Eliminate duplicate-driver short on `esad.analogTriggerIn` (`WIRE-056` + `WIRE-DOC03-08`) by modeling hardware-ORed `IRQ_L -> IR_ESAD_L` from `ProximitySensorBoard` (`J102 <-> J1`), and split single-port multi-wire shorts (`finServoPower8vOut`, `can1Bus`, `can2Bus`) onto distinct typed pin/tap ports (`Law L3`, `Law L5`).
   - Lower 100% of `ESADModel` (`docs/reference/esad-sysmlv2/*`) into `LethalPackage` / `EsadSafeAndArmDevice` in DEAP SysML subset syntax (`C1`):
     - Verified numeric parameters: `pbitDurationS = 0.5`, `exchangePeriodS = 0.1` (`exchangeFrequencyHz = 10.0`, reconciled with ICD Table 6 `100 Hz` polling rate via `cross_document_reconciliations[]` and formal requirement traceability), `simulationCommandWindowS = 1.0`.
     - Unvalued source parameters (`TBD-1..3`: `longitudinalAccelerationThreshold`, `safeSeparationDistanceLimit`, `safeSeparationTimeLimit`): declare formal AST attributes with explicit source-gap strings (`"UNSPECIFIED_IN_SOURCE_TBD_1"`, etc.) and traceability requirements -- `0` invented numerical values and `0` raw `[TBD]` tokens.
     - Behavior & Safety AST: `ESAD_ModeStateMachine` (`Mod_Safe`, `Mod_Fault`, `Mod_Stage1`, `Mod_Stage2`, `Mod_Armed`, `Mod_Fired` + `21` transitions), `PerformESADMissionOperation` & `ExecuteESADSoftwareControlCycle` `action def`s, `FaultMonitor1..6`, `11`-input `gate_anyESADModFault`, `2oo2` dual-channel arm interlock, proper DEAP requirement chain (`REQ_L_*`, `REQ_H_*`, `REQ_UCA_*` with `@TriggersHazard`, `REQ_SC_*` `sc_*` with `@SafetyRealises`, `TC_*` with `verify requirement REQ_SC_*`), and all `10` documented diagram anomalies (`ANOM-1..ANOM-10` from `ANOMALY_AND_TBD_LOG.md`). Reclaim subagent immediately.
4. **Update `schema/extracted/*` Parity Files (`TypeName="self"` subagent, `PROCEED`)**:
   - Create `schema/extracted/06_esad_raaml_behavioral_and_safety_model.md` and synchronize `schema/extracted/{04_esad_excalibur_icd,05_engineering_gaps_and_synthesis_ledger,oem_bom,interface_table,parametric_limits}.md` (`0` stale `EPS -> GNSS` wire, `ASTK A5 V2.5` hosting `ethSwitch`/`rpi`, hardware-OR `IRQ_L`, `ESADModel` parameters/states/anomalies, `0` raw `[TBD]` placeholder tokens). Reclaim immediately.
5. **Compile & Run Blind Audit #2 (`0` PDFs, `0` shell)**:
   - Coordinator executes in order:
     1. `./target/release/ingest-sysml --schema schema/model.sysml --out .pipeline/schema.sysml --digest .pipeline/schema-digest.json --allowed-parts "<ACTIVE_PART_DEFS_CSV>" --negative-invariants "<EXCLUDED_VARIANTS_CSV>"` (`exit 0`)
     2. `./target/release/compile-sysml --compile --schema schema/model.sysml --out .pipeline/schema.sysml --digest .pipeline/schema-digest.json` (`exit 0`)
     3. Verify canonical formatting/AST synchronization between `schema/model.sysml` and `.pipeline/schema.sysml` (Check 31 readiness: if `--compile` reformatted `.pipeline/schema.sysml` cosmetically relative to `schema/model.sysml`, copy canonical serialization via a `TypeName="self"` subagent or run `--compile --schema .pipeline/schema.sysml --out schema/model.sysml --digest .pipeline/schema-digest.json` so `schema/model.sysml` and `.pipeline/schema.sysml` match AST + canonical text).
   - Dispatch **Blind Audit #2 (`TypeName="research"`)** verifying Laws `L1..L8`, all `4` defect closures, and `ESADModel` bijection across `schema/source_graph_ledger.json`, `docs/reference/esad-sysmlv2/*`, `schema/model.sysml`, and `.pipeline/schema-digest.json` (`0` discrepancies). Reclaim immediately.

### Stage 3: Normative Research, Sharded Per-Component FMECA Swarm, Safety Suite, ConOps/Views & Level 1C ICDs
1. **Research & Per-Component Failure Mode Swarm (`TypeName="self"` subagents, `PROCEED`)**:
   - Update `docs/research/RESEARCH_INVENTORY.md` indexing `docs/reference/esad-sysmlv2/*`, `100 Hz` vs. `10 Hz` reconciliation, `TBD-1..3` source gaps, and `ANOM-1..10`.
   - Enumerate all AST `part def` components in `.pipeline/schema.sysml`; dispatch `1` context-isolated `Component Failure Mode Researcher` subagent per `part def` (`AGENTS.md` Swarm Mandate #9) writing gitignored `.pipeline/diagnostics/fmeca/<PartDef>.md` across all `4` Universal Failure Dimensions (`0` `verify-baseline` calls inside subagents; reclaim immediately in batches), then `1` synthesis subagent merging `.pipeline/diagnostics/fmeca/*.md` into `docs/research/FAILURE_MODE_REGISTRY.md` (`0` retired `ArtronEsadAndSensorUnit` tokens).
2. **STPA / FMECA / RTA Safety Suite (`docs/safety/`)**:
   - Run `./target/release/compile-sysml --stpa-transpile --schema .pipeline/schema.sysml --out-dir docs/safety/ --force`.
   - Dispatch single-artifact `TypeName="self"` subagents to align `docs/safety/{01_LOSSES_HAZARDS_TOPOLOGY.md,02_UCA_COMBINATORIAL_MATRIX.md,03_LOSS_SCENARIOS.md,04_SAFETY_CONSTRAINTS.md,05_FMECA_MATRIX.md,06_REGULATORY_OBJECTIVES_ASSESSMENT.md,07_RTA_ARCHITECTURE.md,HAZARD_LOG.md,STPA_MATRIX.md,SLDV_FORMAL_PROOFS.m}` with `ESAD_RAAMLSafety` (`FaultMonitor1..6`, `11`-cause `gate_anyESADModFault`, `2oo2` interlock, `REQ_UCA_*` / `REQ_SC_*`, `ANOM-1..10`) and the fixed avionics/power/trigger topology. Coordinator verifies each via `./target/release/verify-baseline . --spec-only --only "<file>"` (`exit 0`). Reclaim immediately.
3. **ConOps, Mission Intent & Architecture Views (`docs/conops/`, `docs/architecture/views/`)**:
   - Refine the preserved `26` modified files (`docs/conops/units/conops/01..12_*.md`, `docs/conops/units/mission_intent/01..10_*.md`, `docs/architecture/views/{icd_system_interface_matrix,sv1_platform_subsystems,sv1_super_system}.mmd`) via single-unit `TypeName="self"` subagents (`read_file` `skills/spec-conops-engineering/SKILL.md` first) for any sections affected by `ESADModel` modes/timings/fault monitors/anomalies, `ASTK A5 V2.5` containment, `GNSS` serial power co-carriage, `ProximitySensorBoard` hardware-OR `IRQ_L`, or SVG/Mermaid parity (`0` `assemble-conops`/`verify-baseline` inside writer subagents). Reclaim immediately.
   - Coordinator runs `./target/release/assemble-conops --input-dir docs/conops/units/ --output-dir docs/conops/ --verify .` (`exit 0`) and syncs GitHub issues `#1` and `#2`.
4. **Level 1C ICDs (`docs/interfaces/`)**:
   - Dispatch single-artifact `TypeName="self"` subagents (`read_file` `skills/spec-icd-engineering/SKILL.md` first) to update `docs/interfaces/ICD_01_SYSTEM_INTERFACE_MATRIX.md` and `docs/interfaces/ICD_02_MASTER_SIGNAL_DICTIONARY.md`. Coordinator runs `./target/release/verify-baseline . --spec-only --only docs/interfaces/<file>.md` (`exit 0`) and syncs GitHub issues `#3` and `#4`.

### Stage 4: Agile Backlog Re-Projection, Level 4 WBS (`Check 20`) & GitHub Tracker Reconciliation
1. **Clean Agile Backlog Regeneration**:
   - Delete stale `Nov 16` files in `docs/{epics,features,user-stories,use-cases}/*.md` (preserving `.gitkeep` in all `4` directories) via `1` bounded `TypeName="self"` subagent.
   - Coordinator runs `./target/release/compile-sysml --forward-sync --schema .pipeline/schema.sysml --docs docs/ --force`.
   - Dispatch `1` context-isolated `TypeName="self"` subagent per Feature -> Epic -> User Story -> Use Case (first step `read_file` on `skills/schema-specification-engineering/SKILL.md`, `skills/spec-user-story-engineering/SKILL.md`, or `skills/spec-usecase-engineering/SKILL.md`), writing ONLY its target file with:
     - YAML frontmatter `generation_mode: "subagent"` (`Check 35`) and unique normalized titles per spec type (`rules/tracker-source-of-truth.md`).
     - Complete 3-layer DoD (`(1) Domain State & Data Model`, `(2) Logic & State Management`, `(3) Presentation & Actuator Interface Binding` -- `0` `N/A` entries).
     - `4`-dimension failure mode mitigations from `docs/research/FAILURE_MODE_REGISTRY.md`.
     - Explicit HITL operator authorization preceding every safety-critical irreversible actuation/energization signal in any Mermaid `sequenceDiagram` (`Check 23` temporal safety).
     - Machine-resolvable citations (`0` raw `[TBD]`/`TODO`/placeholder strings) and `0` `verify-baseline`/`git` invocations inside the subagent.
   - Coordinator immediately verifies each file with `./target/release/verify-baseline . --spec-only --only "<spec_file>"` (`exit 0`) and reclaims the subagent. If behavioral refinements updated specs relative to `.pipeline/schema.sysml`, coordinator runs `./target/release/compile-sysml --reverse-sync --schema .pipeline/schema.sysml --docs docs/ --out .pipeline/schema.sysml --digest .pipeline/schema-digest.json`, syncs `schema/model.sysml`, and re-verifies Check 31 parity.
2. **Level 4 WBS & Enterprise Deliverables Suite (`Check 20`)**:
   - Dispatch `1` `TypeName="self"` subagent (`read_file` `skills/spec-wbs-engineering/SKILL.md` first) generating `docs/management/WBS_DELIVERABLES_SUITE.md` (`| Attribute | Specification Detail |` 2-column metadata table + 7-column Traceability Matrix), `docs/management/wbs_export_jira_monday_ms_project.csv`, and `docs/management/wbs_export.json` (`"wbs_tree": { ... }`). Coordinator verifies `./target/release/verify-baseline . --spec-only --only docs/management/WBS_DELIVERABLES_SUITE.md` (`exit 0`) and reclaims immediately.
3. **GitHub Tracker Reconciliation (`gintatkinson/uav03-tst01`)**:
   - Create label `status:superseded` if absent (`gh label create "status:superseded" --color "cfd3d7" --description "Superseded by updated SysML v2 SSOT projection" || true`).
   - Register/update issues strictly in dependency order (**Features -> Epics (100% live Feature checklists) -> User Stories -> Use Cases -> ConOps/ICDs/WBS** via `./target/release/reconcile-backlog create-issue --body-file "<file>" --label "<type>" --title "<title>"` + `gh issue view <ID> --json body`).
   - NEVER call `gh issue close`. Update `1:1` continuous issues in place, and label any retired `Nov 16` issues among `#5..#51` (such as `#43` `ArtronEsadAndSensorUnit`) with `status:superseded` + cross-reference comment pointing to replacement issue(s).
   - Run `./target/release/reconcile-backlog --provider github --sync-bodies` (`exit 0`).

### Stage 5: Final Verification Gates, Blind Audit #3, Explicit-Path Commit, Push & Walkthrough
1. Clean any transient auto-generated `.pipeline/defects/defect_*` / `.DS_Store` files via a bounded `TypeName="self"` subagent (`reclaim` immediately), then execute coordinator final verification gates in order:
   - `./target/release/assemble-conops --input-dir docs/conops/units/ --output-dir docs/conops/ --verify .` (`exit 0`)
   - `./target/release/verify-baseline . --spec-only` (`0` findings, `passed: true`)
   - `./target/release/verify-baseline . --no-domain` (`exit 0`)
2. Run **Blind Audit #3 (`TypeName="research"`, `0` PDFs, `0` shell)** inspecting the fresh session's `<appDataDir>/brain/<conversation-id>/.system_generated/logs/transcript_full.jsonl` + same-session child `transcript_full.jsonl` records (`0` cross-session reads) verifying: `0` coordinator repo writes, `0` coordinator PDF reads, `1:1` subagent write delegation, `0` Python/shell scripts, `0` `verify-baseline`/`git` inside single-item writer subagents, and `0` forbidden external repo accesses (`../deap04`, `../deap03`, `~/.deap/keys/*`, `../DEAP01-spec-core/crates/*`). Reclaim immediately.
3. Check commit message non-closure before committing (`./target/release/verify-baseline check-commit-msg --check-text "<msg>"` using `(refs #<id>)`), stage and commit explicit paths via `git add -- ...` and `git commit --only -- ...` (`0` unscoped `git add .`/`-A`), verify `./target/release/verify-baseline check-commit-msg --head` (`exit 0`), push to `origin main`, verify `git status --porcelain` == empty AND `git diff origin/main` == empty, apply `status:fixed-resolved` + verification evidence comments on active referenced issues, verify `0` active subagents/tasks, and write `<appDataDir>/brain/<conversation-id>/walkthrough.md`.

---

## 4. Self-Contained Copyable Turn-1 Dispatch Prompt (For Fresh Agent in New Session)

```markdown
You are starting a fresh Option-2 end-to-end execution session in `./` (`DOWNSTREAM_CUSTOMER_PROJECT`, remote `origin`: `gintatkinson/uav03-tst01`).

1. Baseline & Preserved Working Tree:
   - `HEAD` already contains the `dd62601` Tier-0 release binaries in `./target/release/`.
   - The obsolete `docs/reference/ESAD flow charts.pdf` has been removed and replaced by the authoritative OMG SysML v2.0 + RAAML v1.0 model at `https://github.com/gintatkinson/esad-sysmlv2/tree/Antigravity/schema/esad` (pinned commit `3c902b9bc1af37cc5751d54a90f0bbc8f4224a8b`, `7` `.sysml` files + `ANOMALY_AND_TBD_LOG.md`).
   - CRITICAL WORKING-TREE PRESERVATION: Run `git status --short --branch` on Turn 1. Preserve all `26` existing modified (`M`) files in `docs/conops/**` and `docs/architecture/views/*.mmd` intact on disk (`0` `git checkout`, `0` `git restore`, `0` `git reset`, `0` `git stash`); refine them in Stage 3 and commit them in Stage 5.

2. Read-Only Turn-1 Survey:
   - Read `docs/plans/OPTION2_M2_RAAML_AND_FULL_REPROJECTION_PLAN.md` (governing master plan), Sections 2-3 ONLY of `docs/plans/SCHEMATIC_INGESTION_SKILL_AND_MODEL_PLAN.md` (note `OPTION2` Section 1 explicitly supersedes `SCHEMATIC` quarantine, stop ceiling, empty-porcelain precondition, and Section 4), `.pipeline/constitution.md`, and `.pipeline/ACTIVE_RULES_BUNDLE.md`.

3. Mandatory Guardrails:
   - **Dialect & Check 31 Placement (`C1`, `C2`)**: `compile-sysml` and `ingest-sysml` reject raw OMG `private import`/`#houseEvent` syntax (`Unexpected token 'Ident("private")'`), and `verify-baseline` Check 31 forbids sibling `.sysml` files under `schema/`. Vendor verbatim `esad-sysmlv2@3c902b9` files under `docs/reference/esad-sysmlv2/` (never under `schema/`) and lower 100% of `ESADModel` into `schema/source_graph_ledger.json` + `schema/model.sysml`. Always pass explicit `--schema schema/model.sysml --out .pipeline/schema.sysml --digest .pipeline/schema-digest.json` (never pass a directory containing `.md` files to `compile-sysml --schema`).
   - **Pure-M2 Multi-Modal Skill (`C7`, Check 19)**: `skills/spec-source-ingestion/` must preserve `"additionalProperties": false` using pure-M2 `source_kind` (`"paged_document" | "structured_model_set" | "text_specification"`), `unit_count`, `inspected_units[]`, and `source_ref.unit`, with `0` domain/medium/protocol/vendor/framework leaks (`0` `ESAD`, `0` `RAAML`, `0` `Avenger`). Verify its self-contained grammar template compiles (`exit 0`) and pass a `TypeName="research"` Check-19 purity audit before Stage 2.
   - **4 Residual `model.sysml` Fixes + `ESADModel` + `schema/extracted/*` Parity**: Move `ethSwitch` + `rpi` into `AutopilotStackModuleAstkA5V25`; move airframe attributes (`wingspanM`, `lengthM`, `heightM`, `maximumTakeoffWeightKg`, `wingMountBoltSpec`, `airframeFinishColor`) onto `AirVehicleAvengerV25`; remove fabricated `EPS -> GNSS` `WIRE-DOC01-03`/`REQ_GAP_DOC01_04` and model `co_carried_on_connection` on `Cube orange+ <-> Septentrio` `Serial`; eliminate duplicate-driver `esad.analogTriggerIn` short (`IRQ_L` hardware-OR on `ProximitySensorBoard`) and split `finServoPower8vOut`/`can1Bus`/`can2Bus` onto distinct typed ports. Lower `pbitDurationS = 0.5`, `exchangePeriodS = 0.1` / `10.0 Hz` (reconciled with ICD `100 Hz`), `simulationCommandWindowS = 1.0`, unvalued `TBD-1..3` (`0` invented values, `0` raw `[TBD]` strings), `ESAD_ModeStateMachine` (`6` `Mod_*`, `21` transitions), `FaultMonitor1..6`, `11`-cause `gate_anyESADModFault`, `2oo2` interlock, DEAP requirement chain (`REQ_L_*`, `REQ_H_*`, `REQ_UCA_*` `@TriggersHazard`, `REQ_SC_*` `@SafetyRealises`, `TC_*` `verify requirement REQ_SC_*`), and `ANOM-1..10`, plus updated `schema/extracted/*` parity files for Check 23.
   - **Governance & Execution Discipline (`C4..C6`)**: On Turn 1, write `<appDataDir>/brain/<conversation-id>/implementation_plan.md` treating Stages 1-5 as one cohesive Option-2 work package and STOP for explicit `PROCEED`. After `PROCEED`, delegate 100% of repository writes to `TypeName="self"` subagents (never run `verify-baseline` or `git` inside writer subagents -- run `--spec-only --only` and final gates at coordinator level; reclaim every subagent immediately; coordinator performs `0` repo writes, `0` PDF reads, `0` Python/shell scripts, `0` external repo reads to `../deap04|../deap03|~/.deap/keys|../DEAP01-spec-core/crates`, and `0` `gh issue close`), until `assemble-conops --input-dir docs/conops/units/ --output-dir docs/conops/ --verify .`, `verify-baseline . --spec-only`, `verify-baseline . --no-domain`, `Blind Audit #3`, explicit-path commit (`verify-baseline check-commit-msg --head`), and `git push origin main` all succeed cleanly.
```
