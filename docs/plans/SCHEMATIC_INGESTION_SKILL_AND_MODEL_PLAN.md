# Plan & Fresh-Session Dispatch Specification: Standalone Schematic Ingestion Skill & Bijective SysML v2 Model Synthesis

## 1. Objective & Single Atomic Scope

Prove a deterministic, domain-neutral **OEM Schematic-to-SysML v2 Ingestion & Blind Verification Architecture** inside `./` (`gintatkinson/uav03-tst01`) that produces a 100% hardware-faithful architectural model (`schema/schematic_ledger.json` -> `schema/model.sysml` -> `.pipeline/schema.sysml`) directly from raw customer PDFs (`docs/reference/*.pdf`) with **zero** prior-run contamination and **zero** domain hints.

### Strict Scope Boundaries
- **In Scope (3 Artifacts Only)**:
  1. `skills/spec-schematic-ingestion/` (`SKILL.md`, `resources/schematic_ledger_schema.json`, `references/blind_schematic_audit_protocol.md`) -- standalone, portable, 100% domain-neutral skill package (`0` edits to `skills/spec-orchestrator/SKILL.md`).
  2. `schema/schematic_ledger.json` (plus reconciled `schema/extracted/*.md` tables derived strictly from `schematic_ledger.json`) -- extracted cold from `docs/reference/*.pdf` and verified to `0` discrepancies by an independent blind `TypeName="research"` visual auditor.
  3. `schema/model.sysml` + compiled `.pipeline/schema.sysml` and `.pipeline/schema-digest.json` -- synthesized bijectively from `schema/schematic_ledger.json` under Structural Laws `L1..L8`, verified to `0` discrepancies by a second blind `TypeName="research"` auditor against `docs/reference/*.pdf`, and passing `./target/release/ingest-sysml` (`--allowed-parts` / `--negative-invariants`) and `./target/release/compile-sysml --compile` (`exit 0`).
- **Explicitly Out of Scope (Hard Stop at Compiled SysML Model)**:
  - **ZERO** downstream specification regeneration: do NOT modify or re-project `docs/{conops,interfaces,epics,features,user-stories,use-cases,safety,research,management}` and do NOT run `--forward-sync`, `--stpa-transpile`, `assemble-conops`, or `reconcile-backlog`, and do NOT modify GitHub issues.
  - **ZERO** external repository access: NEVER read, list, grep, stat, or touch `../deap04`, `../deap03`, `~/.deap/keys/*`, or `../DEAP01-spec-core/crates/*`.
  - **ZERO** `DEAP01-spec-core` Rust feature rewrites: consume existing `./target/release/*` binaries as black-box tools.

---

## 2. Root-Cause Failure Modes Eliminated by This Design

| Failure ID | Failure Mode Observed in Unstructured LLM Modeling | Structural Countermeasure in `spec-schematic-ingestion` |
| :--- | :--- | :--- |
| `FM-01` | **Spatial Enclosure Loss**: Modeling from text tables drops dashed/grouped physical sub-assembly boxes on block diagrams, yielding a flat peer list. | Mandatory top-down `enclosures[]` containment tree $T_E$ extracted visually from drawings before any component or wire is listed; Law `L1` enforces `1:1` composite `part def` nesting. |
| `FM-02` | **Chimera Bucket Classes & Duplicate Classifiers**: Separate hardware boxes on different buses get merged into synthetic "suite/unit" classes, or `k` identical actuators get duplicated into `k` separate `part def`s. | Explicit split between `component_types[]` ($V_T \to$ leaf `part def`) and `component_instances[]` ($V_I \to$ leaf `part` usage) with typing map $\tau: V_I \to V_T$ (`Law L2`). |
| `FM-03` | **Dropped Internal & Supply Rails**: Power/data lines drawn *inside* a stacked sub-assembly or routed through a distribution/splitter PCB are skipped, leaving controllers/switches unpowered. | Mandatory per-type `requires_electrical_power` + `power_feed_mode` declaration and Law `L6` Supply-Graph Reachability check tracing every powered instance back to an energy source. |
| `FM-04` | **Topology & Port-Domain Corruption**: Series daisy-chains flatten into stars; multi-drop trunks merge with star stubs; unrelated buses (`Serial` + `USB`, `Bus` + `GPIO`) share hybrid ports; declared `port def`s sit unconnected. | Mandatory `topology` (`series_daisy_hop` + contiguous `series_hop_index`), single-domain directional `declared_ports[]`, bulkhead delegation (`Law L4`), and `0` orphan AST node check (`Law L3`). |
| `FM-05` | **Diagram Legend & Cross-PDF Drift**: Schematic sidebar rules (kinematic control laws, co-packaged secondary sensors, inverted interlock polarity, optional R&D branches) and cross-PDF conflicts get lost in prose comments. | Mandatory `co_packaged_functions[]`, `functional_invariants[]`, and `cross_document_reconciliations[]` arrays lowered directly into formal `constraint def` / `requirement def` / `state def` AST nodes (`Law L7`, `Law L8`). |

---

## 3. Exact Specification of `skills/spec-schematic-ingestion/`

### 3.1 `resources/schematic_ledger_schema.json` (JSON Schema Draft 2020-12)
Every object schema MUST enforce `"additionalProperties": false` and `0` concrete customer/domain tokens (`rules/sysml-ssot-completeness.md` Check 19). Required root properties:
1. `schema_version`: integer `const: 1`.
2. `source_documents[]` (`minItems: 1`):
   - `doc_id`, `relative_path`, `page_count` (`integer >= 1`), `inspected_pages[]` (`integer[]` listing every visually inspected diagram, pinout, CAD, and specification page).
3. `enclosures[]` (`minItems: 1`, ordered parent-before-child tree $T_E$):
   - `enclosure_id`, `canonical_part_def` (`UpperCamelCase`), `canonical_instance_name` (`lowerCamelCase | null`, `null` only at root), `oem_exact_label`, `parent_enclosure_id` (`string | null`), `boundary_placement` (`"interior" | "boundary_straddling" | "external_segment"`), `cardinality` (`"1" | "0..1"`), `populated_in_production` (`boolean`), `source_ref` (`{ doc_id, page, locator }`).
4. `component_types[]` (`minItems: 1`, distinct hardware/software classifiers $V_T$):
   - `type_id`, `canonical_part_def` (`UpperCamelCase`), `oem_model_or_label`, `functional_category` (closed domain-neutral enum: `"energy_storage"`, `"circuit_protection"`, `"power_switch_meter"`, `"power_distribution_regulator"`, `"primary_controller"`, `"companion_computer"`, `"network_switch"`, `"splitter_distribution_pcb"`, `"rf_transceiver"`, `"passive_antenna"`, `"gnss_receiver"`, `"navigation_sensor"`, `"airdata_sensor"`, `"electro_optical_gimbal"`, `"payload_compute_module"`, `"electromechanical_actuator"`, `"safe_arm_controller"`, `"proximity_impact_sensor"`, `"energetic_payload"`, `"pyrotechnic_actuator"`, `"safety_interlock_key"`, `"external_service_interface"`, `"mechanical_launch_structure"`, `"pneumatic_compressor_unit"`, `"operator_trigger_unit"`, `"operator_console"`, `"antenna_positioner"`, `"esd_grounding_fixture"`), `co_packaged_functions[]` (`string[]`), `requires_electrical_power` (`boolean`), `power_feed_mode` (`"self_energy_source" | "dedicated_power_port" | "in_band_signal_or_composite_cable" | "none_passive_or_mechanical"`), `declared_ports[]` (`{ port_name, port_def_name, direction: "in" | "out" | "inout", domain, protocol_or_electrical_spec, is_power_input: boolean, is_power_output: boolean }`), `parametric_attributes[]` (`{ attribute_name, sysml_type: "Real" | "Integer" | "Boolean" | "String", value, si_unit, oem_raw_value_and_unit, source_ref }`), `source_ref`.
5. `component_instances[]` (`minItems: 1`, physical diagram symbol / field unit occurrences $V_I$):
   - `instance_id`, `canonical_instance_name` (`lowerCamelCase`), `type_id` (FK -> `component_types`), `oem_instance_label`, `parent_enclosure_id` (FK -> `enclosures`), `populated_in_production` (`boolean`), `instance_attributes[]`, `source_ref`.
6. `wires[]` (`minItems: 1`, complete physical/logical edge list $E_W$):
   - `wire_id`, `oem_wire_label`, `domain` (`"dc_power" | "ac_multiphase" | "can_bus" | "uart_serial" | "rs485_differential" | "usb_bus" | "ethernet_ip" | "pwm_control" | "discrete_gpio" | "umbilical_continuity_loop" | "composite_power_video" | "composite_sensor_harness" | "high_voltage_fire" | "rf_coax" | "rf_over_the_air" | "optical_fiber" | "pneumatic_pressure" | "mechanical_structural_load" | "inertial_acceleration"`), `topology` (`"point_to_point" | "multi_drop_trunk" | "star_stub" | "series_daisy_hop"`), `direction` (`"unidirectional" | "bidirectional"`), `from_endpoint` (`{ instance_id, port_name, connector_or_pin_ref }`), `to_endpoint` (`{ instance_id, port_name, connector_or_pin_ref }`), `series_chain_id` (`string | null`), `series_hop_index` (`integer | null`), `nominal_voltage_v` (`number | null`), `voltage_range_v` (`[number, number] | null`), `harness_length_m` (`number | null`), `conductor_count` (`integer | null`), `active_in_production` (`boolean`), `source_ref`.
7. `unconnected_or_spare_pins[]`:
   - `instance_id`, `connector_id`, `pin_designator`, `signal_name`, `disposition` (`const: "documented_spare_unconnected"`), `source_ref`.
8. `functional_invariants[]`:
   - `invariant_id`, `subject_id`, `category` (`"kinematic_control_law" | "sensor_fusion_coupling" | "interlock_sequence" | "power_margin" | "failsafe_behavior" | "configuration_exclusion"`), `formal_statement`, `sysml_realization_kind` (`"constraint_def" | "requirement_def" | "state_def" | "action_def"`), `source_ref`.
9. `cross_document_reconciliations[]`:
   - `gap_id`, `summary`, `source_a`, `source_b`, `authoritative_disposition`.

### 3.2 `SKILL.md` & Structural Lowering Laws (`L1..L8`)
`skills/spec-schematic-ingestion/SKILL.md` codifies the 4-stage execution pipeline (Visual Extraction -> Blind Audit #1 -> Bijective SysML Lowering -> Blind Audit #2 + Compiler Gate) and the 8 mandatory lowering laws:
- **Law `L1` (Enclosure Tree Isomorphism)**: Every entry in `enclosures[]` lowers `1:1` to a composite `part def` instantiated at its exact `parent_enclosure_id` nesting level (`0` omitted or flattened dashed boxes). Optional `0..1` assemblies (`populated_in_production == false`) are modeled structurally alongside explicit production-inhibit constraints rather than reduced to booleans.
- **Law `L2` (Classifier vs. Instance Separation -- Zero Chimeras, Zero Duplicate Types)**: `|component_types| == |leaf part defs|` and `|component_instances| == |leaf part usages|`. Two physically distinct OEM boxes may never share a `part def`; `k` identical physical units (`k > 1`) share **one** `part def` and instantiate **`k`** distinct `part` usages.
- **Law `L3` (Single-Domain Directional Ports & Zero Orphan Definitions)**: Every port carries exactly one `domain` with faithful `in`/`out`/`inout` directionality (`0` hybrid ports multiplexing separate cables such as `UART + USB` or `RS-485 + GPIO`). Every declared `port def`, `item def`, and `part def` in `schema/model.sysml` has `>= 1` usage and connection (`0` dead declarations).
- **Law `L4` (Intra-Enclosure & Bulkhead Port Connection Conservation)**: Intra-enclosure wires connect peer `part`s directly inside their owning composite `part def`; cross-enclosure wires delegate explicitly through typed bulkhead ports on the boundary of each crossed composite `part def` (`Subsystem.Path.port`), preserving `1:1` wire count and hierarchy.
- **Law `L5` (Series Daisy-Chain, Trunk & Splitter Fidelity)**: Wires with `topology == "series_daisy_hop"` connect strictly hop-by-hop in ascending `series_hop_index` order (`0 -> 1 -> 2 -> ...`) across distinct `busIn` / `busThruOut` ports -- never collapsed into a star. Distribution/splitter PCBs are modeled as explicit intermediate nodes fanning out power/data as drawn.
- **Law `L6` (Electrical Supply-Graph Reachability)**: Every `component_instance` whose type sets `requires_electrical_power == true` has an explicit connected inbound power path (`dc_power`, `composite_power_video`, `composite_sensor_harness`, or documented `in_band_signal_or_composite_cable`) tracing back to an `energy_storage` source (`0` unpowered boards, switches, radios, or sensors, including boards inside nested stacks).
- **Law `L7` (Formal AST Realization of Legends, Co-Packaged Functions & Conflicts)**: Every entry in `co_packaged_functions[]`, `functional_invariants[]`, and `cross_document_reconciliations[]` lowers to a formal `attribute`, `constraint def`, `requirement def` (`satisfy` / `verify` bound), `action def`, or `state def` -- never stranded in `doc /* ... */` comments alone.
- **Law `L8` (Root Lifecycle `state def` & Compiler Gate)**: The root `package` declares a top-level system lifecycle `state def` (`>= 2` states with `Initial` and `Terminal` transitions). `./target/release/ingest-sysml` (`--allowed-parts` and `--negative-invariants` derived mechanically from `schematic_ledger.json`) and `./target/release/compile-sysml --compile` must both exit `0`.

### 3.3 `references/blind_schematic_audit_protocol.md` (Two Independent `TypeName="research"` Gates)
- **Blind Audit #1 (`PDFs` vs. `schema/schematic_ledger.json`)**: Fresh `TypeName="research"` subagent (`0` shell access) receives ONLY `docs/reference/*.pdf`, `schematic_ledger_schema.json`, `blind_schematic_audit_protocol.md`, and `schema/schematic_ledger.json` (`0` access to `schema/extracted/*` or `*.sysml`). Independently counts and diffs all dashed boundaries, boundary-straddling items, solid boxes, internal/external power wires, signal/RF/coax/mechanical lines, series hop orders, spare pins, sidebar functional paragraphs, and cross-PDF parameter conflicts. Must return `0` discrepancies before SysML authoring begins.
- **Blind Audit #2 (`PDFs` + `schematic_ledger.json` vs. `schema/model.sysml`)**: Second fresh `TypeName="research"` subagent verifies Laws `L1..L8` across `schema/model.sysml` and `.pipeline/schema-digest.json` (exact `enclosures[]`, `component_types[]`, `component_instances[]`, and `wires[]` counts; `100%` power-reachability table; `0` chimeras; `0` hybrid ports; `0` unconnected `port def`/`part def`/`item def` nodes; `100%` `functional_invariants[]` AST realization). Must return `0` discrepancies before commit.

---

## 4. Copyable Turn-1 Dispatch Prompt (For Fresh Agent in New Session)

```markdown
You are starting a clean-sheet modeling session in `/Users/perkunas/uav03-tst01` (`DOWNSTREAM_CUSTOMER_PROJECT`, remote `origin`: `gintatkinson/uav03-tst01`).

Current `HEAD` contains a flawed first-pass SysML model (`schema/model.sysml` and `schema/extracted/*`) that flattened nested physical enclosures, merged distinct hardware boxes into synthetic "chimera" `part def`s, omitted internal power and signal connections, flattened series daisy-chains, multiplexed unrelated buses onto hybrid ports, and modeled from lossy prose summaries instead of the OEM drawings.

Read `docs/plans/SCHEMATIC_INGESTION_SKILL_AND_MODEL_PLAN.md` on Turn 1 and execute its exact single-scope specification:
1. Build the standalone, 100% domain-neutral skill package `skills/spec-schematic-ingestion/` (`SKILL.md`, `resources/schematic_ledger_schema.json`, `references/blind_schematic_audit_protocol.md`).
2. Apply that skill cold to `docs/reference/*.pdf` (with ZERO reliance on the prior flawed `schema/model.sysml` or `schema/extracted/*`) to produce `schema/schematic_ledger.json` (passing Blind `research` Audit #1 with `0` discrepancies) and `schema/model.sysml` + compiled `.pipeline/schema.sysml` / `.pipeline/schema-digest.json` (passing Laws `L1..L8`, Blind `research` Audit #2 with `0` discrepancies, `./target/release/ingest-sysml --allowed-parts ... --negative-invariants ...`, and `./target/release/compile-sysml --compile` with `exit 0`).

Hard Constraints (Non-Negotiable):
1. **Strict Scope Ceiling (STOP at Compiled SysML Model)**: Do NOT regenerate or modify `docs/{conops,interfaces,epics,features,user-stories,use-cases,safety,research,management}`, do NOT run `--forward-sync`, `--stpa-transpile`, `assemble-conops`, or `reconcile-backlog`, do NOT edit `skills/spec-orchestrator/SKILL.md`, and do NOT touch GitHub issues.
2. **External Repository Firewall**: NEVER read, list, grep, stat, or touch `/Users/perkunas/deap04`, `/Users/perkunas/deap03`, `/Users/perkunas/.deap/keys/*`, or `../DEAP01-spec-core/crates/*`.
3. **Prior-Run Quarantine**: Do NOT read or reuse existing `schema/model.sysml` or `schema/extracted/*` during schematic extraction or SysML synthesis -- inspect every page of every PDF in `docs/reference/*.pdf` directly via `read_file` so zero prior modeling bias leaks into `schema/schematic_ledger.json` or `schema/model.sysml`. Use `ask_question` ONLY if a genuine OEM configuration option (e.g., optional R&D kit population) cannot be resolved deterministically from the PDFs alone.
4. **Pure Domain-Neutrality in the Skill (`Check 19`)**: `skills/spec-schematic-ingestion/**` must contain ZERO concrete customer, vehicle, weapon, sensor-model, or vendor tokens -- use strictly abstract metamodel terms so the skill is portable across any engineering domain.
5. **Governance & Execution Discipline (`AGENTS.md`)**:
   - On Turn 1, inspect `docs/plans/SCHEMATIC_INGESTION_SKILL_AND_MODEL_PLAN.md`, `ls docs/reference`, `git status --short --branch`, and `./target/release/{ingest-sysml,compile-sysml} --help` read-only, write your session execution plan to `<appDataDir>/brain/<conversation-id>/implementation_plan.md` (and `.pipeline/plans/schematic-ingestion-session-plan.md`), and **STOP** for explicit `PROCEED` approval before mutating any other repository file.
   - After `PROCEED`, delegate all repository file writes to bounded subagents (`<= 200`-word prompts referencing disk paths; `<= 2` concurrent subagents; reclaim all subagents on completion); run both blind `TypeName="research"` audits (`0` shell access) to `0` discrepancies; never invoke Python/Perl/Ruby/Node or shell file-mutation operators; leave `0` `.DS_Store` files; use ASCII `--` only (`0` Unicode em dashes); commit via explicit paths and verify `git diff origin/main` is empty.
```
