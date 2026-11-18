# Plan & Fresh-Session Dispatch Specification: Standalone Schematic Ingestion Skill & Bijective SysML v2 Model Synthesis

## 1. Objective & Single Atomic Scope

Prove a deterministic, domain-neutral **OEM Schematic-to-SysML v2 Ingestion & Sharded Blind Verification Architecture** inside `./` (`gintatkinson/uav03-tst01`) that produces a 100% hardware-faithful architectural model (`schema/schematic_ledger.json` -> `schema/model.sysml` -> `.pipeline/schema.sysml`) directly from raw customer PDFs (`docs/reference/*.pdf`) with **zero** prior-run contamination, **zero** domain hints, and **zero** multimodal PDF context-compaction crashes.

### Strict Scope Boundaries
- **In Scope (3 Artifacts Only)**:
  1. `skills/spec-schematic-ingestion/` (`SKILL.md`, `resources/schematic_ledger_schema.json`, `references/blind_schematic_audit_protocol.md`, `references/sysml_v2_compiler_grammar.md`) -- standalone, portable, 100% domain-neutral skill package (`0` edits to `skills/spec-orchestrator/SKILL.md`).
  2. `schema/schematic_ledger.json` -- extracted cold in a **single pass per PDF** (`1` PDF per subagent, capturing both topology and all quantitative parameters, protocol bitfields, and state guards), merged in a text-only subagent, and verified to `0` discrepancies by **sharded Blind `TypeName="research"` Audit #1** (`1` `research` subagent per PDF + `1` text-only global ledger `research` subagent).
  3. `schema/model.sysml` (overwritten wholesale via `write_file` `Overwrite: true` without reading the prior file) + freshly compiled `.pipeline/schema.sysml` and `.pipeline/schema-digest.json` -- synthesized bijectively from `schema/schematic_ledger.json` under Structural Laws `L1..L8`, compiled **first** via `./target/release/ingest-sysml` (`--allowed-parts` / `--negative-invariants`) and `./target/release/compile-sysml --compile` (`exit 0`, re-run after every edit), and **then** verified to `0` discrepancies by **100% text-only Blind `TypeName="research"` Audit #2** (`0` PDF loads).
- **Explicitly Out of Scope (Hard Stop at Compiled SysML Model)**:
  - **ZERO** downstream specification regeneration or reads: do NOT read, modify, or re-project `docs/{conops,interfaces,epics,features,user-stories,use-cases,safety,research,management,architecture}/**`, leave `schema/extracted/*` untouched and unread, do NOT read pre-existing `.pipeline/schema*` prior to overwriting them with your new compile, do NOT run `--forward-sync`, `--stpa-transpile`, `assemble-conops`, or `reconcile-backlog`, do NOT run full-repo `verify-baseline` checks against untouched legacy `docs/*`, and do NOT touch GitHub issues.
  - **ZERO** external repository access: NEVER read, list, grep, stat, or touch `/Users/perkunas/deap04`, `/Users/perkunas/deap03`, `/Users/perkunas/.deap/keys/*`, or `../DEAP01-spec-core/crates/*`.
  - **ZERO** `DEAP01-spec-core` Rust feature rewrites: consume existing `./target/release/*` binaries as black-box tools.

---

## 2. Root-Cause Failure Modes Eliminated by This Design

| Failure ID | Failure Mode Observed in Unstructured LLM Modeling | Structural Countermeasure in `spec-schematic-ingestion` |
| :--- | :--- | :--- |
| `FM-01` | **Spatial Enclosure Loss**: Modeling from text tables drops dashed/grouped physical sub-assembly boxes on block diagrams, yielding a flat peer list. | Mandatory top-down `enclosures[]` containment tree $T_E$ extracted visually from drawings before any component or wire is listed; Law `L1` enforces `1:1` composite `part def` nesting. |
| `FM-02` | **Chimera Bucket Classes & Duplicate Classifiers**: Separate hardware boxes on different buses get merged into synthetic "suite/unit" classes, or `k` identical actuators get duplicated into `k` separate `part def`s. | Explicit split between `component_types[]` ($V_T \to$ leaf `part def`) and `component_instances[]` ($V_I \to$ leaf `part` usage) with typing map $\tau: V_I \to V_T$ (`Law L2`). |
| `FM-03` | **Dropped Internal & Supply Rails**: Power/data lines drawn *inside* a stacked sub-assembly or routed through a distribution/splitter PCB are skipped, leaving controllers/switches unpowered. | Mandatory per-type `requires_electrical_power` + `power_feed_mode` declaration and Law `L6` Supply-Graph Reachability check tracing every powered instance back to an energy source. |
| `FM-04` | **Topology & Port-Domain Corruption**: Series daisy-chains flatten into stars; multi-drop trunks merge with star stubs; unrelated buses (`Serial` + `USB`, `Bus` + `GPIO`) share hybrid ports; declared `port def`s sit unconnected. | Mandatory `topology` (`series_daisy_hop` + contiguous `series_hop_index`), single-domain directional `declared_ports[]`, bulkhead delegation (`Law L4`), and `0` orphan AST node check (`Law L3`). |
| `FM-05` | **Diagram Legend, Protocol & Cross-PDF Drift**: Schematic sidebar rules, protocol opcodes/bitfields, state guards, and cross-PDF conflicts get missed or require costly second PDF reads. | Single-pass capture of `co_packaged_functions[]`, `protocol_and_register_contracts[]`, `state_machines_and_procedures[]`, `functional_invariants[]`, and `cross_document_reconciliations[]` lowered into formal AST nodes (`Law L7`, `Law L8`). |
| `FM-06` | **Multimodal PDF & Reply Context Compaction**: `read_file` on binary PDFs ignores `StartLine`/`EndLine` and renders every page screenshot + OCR per call (~204 pages across 6 PDFs), while verbose subagent replies bloat coordinator context. | **Zero-PDF Orchestrator**, **1-PDF-per-subagent single whole-read** (`0` `StartLine`/`EndLine` args, solo for `> 10 MB`), scratch JSON sharding, `<= 250`-word delta-only subagent replies, sharded Audit #1, and 100% text-only Audit #2. |

---

## 3. Exact Specification of `skills/spec-schematic-ingestion/`

### 3.1 `resources/schematic_ledger_schema.json` (JSON Schema Draft 2020-12)
Every object schema MUST enforce `"additionalProperties": false` and `0` concrete customer/domain tokens (`rules/sysml-ssot-completeness.md` Check 19). Include `"$defs": { "document_shard": ... }` so per-PDF extraction shards validate against the same strict field contracts before merge. Required root properties:
1. `schema_version`: integer `const: 1`.
2. `source_documents[]` (`minItems: 1`):
   - `doc_id`, `relative_path`, `file_size_bytes` (`integer >= 1`), `page_count` (`integer >= 1`), `inspected_pages[]` (`integer[]` listing every visually inspected diagram, pinout, CAD, protocol, and specification page).
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
8. `protocol_and_register_contracts[]` (single-pass capture of bus framing, baud/poll/timeout timing, CRC polynomials, opcodes, telemetry/fault bitfields, and discrete waveform specs):
   - `contract_id`, `wire_or_interface_ref`, `framing_and_timing`, `checksum_or_integrity`, `commands_and_bitfields[]`, `source_ref`.
9. `state_machines_and_procedures[]` (single-pass capture of hardware/software mode machines, pre-operational interlocks, emergency abort/scrub sequences, and failsafe triggers):
   - `fsm_id`, `owner_enclosure_or_type_id`, `states[]`, `transitions[]` (`{ from_state, trigger_and_guard, to_state }`), `source_ref`.
10. `functional_invariants[]`:
   - `invariant_id`, `subject_id`, `category` (`"kinematic_control_law" | "sensor_fusion_coupling" | "interlock_sequence" | "power_margin" | "failsafe_behavior" | "configuration_exclusion"`), `formal_statement`, `sysml_realization_kind` (`"constraint_def" | "requirement_def" | "state_def" | "action_def"`), `source_ref`.
11. `cross_document_reconciliations[]`:
   - `gap_id`, `summary`, `source_a`, `source_b`, `authoritative_disposition`.

### 3.2 Multimodal PDF Anti-Compaction & Single-Pass Sharding Protocol (Mandatory in `SKILL.md`)
1. **Binary PDF `read_file` Physics**: `read_file` on a `.pdf` ignores `StartLine`/`EndLine` and attaches rendered page images + OCR for **all** pages of the PDF on every call.
2. **Zero-PDF Orchestrator & Bounded Subagent Replies**: The coordinator agent MUST NEVER call `read_file` on any `.pdf` file; it inspects only `ls -la docs/reference` byte sizes to schedule subagents, and requires every subagent (`self` or `research`) to keep its completion message `<= 250` words (delta/violation summary only, writing full payloads to disk).
3. **1-PDF-Per-Subagent & Exhaustive Single-Pass Whole-Read**: Every subagent reading a `.pdf` receives **at most 1 `.pdf` path**, calls `read_file` **at most once** on that `.pdf` with **zero `StartLine`/`EndLine` arguments**, and NEVER issues parallel `read_file` calls on PDFs. Any `.pdf` `> 10 MB` runs **solo (`1` active subagent, `0` concurrent peers)** and is reclaimed immediately. In that single pass, the extractor captures **both** structural topology (`enclosures`, `component_types`, `component_instances`, `wires`, `unconnected_or_spare_pins`) **and** complete parametric/behavioral facts (`parametric_attributes`, `protocol_and_register_contracts`, `state_machines_and_procedures`, `functional_invariants`) so zero second PDF reads are ever needed.
4. **Resolved Scratch-Sharded Extraction & Text-Only Merge**:
   - Pass the resolved literal absolute path `/Users/.../brain/<conversation-id>/scratch/shards/<doc_id>.json` (never a literal `<appDataDir>` placeholder; or gitignored `.pipeline/diagnostics/shards/<doc_id>.json` if subagent sandboxing restricts external paths, deleting fallback shards prior to commit). Extract the primary system block-diagram PDF first so canonical IDs anchor subsequent manual/ICD shards.
   - Dispatch 1 **text-only (`0`-PDF)** merge subagent to synthesize unified `schema/schematic_ledger.json`.

### 3.3 Structural Lowering Laws (`L1..L8` in `SKILL.md`)
- **Law `L1` (Enclosure Tree Isomorphism)**: Every entry in `enclosures[]` lowers `1:1` to a composite `part def` instantiated at its exact `parent_enclosure_id` nesting level (`0` omitted or flattened dashed boxes). Optional `0..1` assemblies (`populated_in_production == false`) are modeled structurally alongside explicit production-inhibit constraints rather than reduced to booleans.
- **Law `L2` (Classifier vs. Instance Separation -- Zero Chimeras, Zero Duplicate Types)**: `|component_types| == |leaf part defs|` and `|component_instances| == |leaf part usages|`. Two physically distinct OEM boxes may never share a `part def`; `k` identical physical units (`k > 1`) share **one** `part def` and instantiate **`k`** distinct `part` usages.
- **Law `L3` (Single-Domain Directional Ports & Zero Orphan Definitions)**: Every port carries exactly one `domain` with faithful `in`/`out`/`inout` directionality (`0` hybrid ports multiplexing separate cables such as `UART + USB` or `RS-485 + GPIO`). Every declared `port def`, `item def`, and `part def` in `schema/model.sysml` has `>= 1` usage and connection (`0` dead declarations).
- **Law `L4` (Intra-Enclosure & Bulkhead Port Connection Conservation)**: Intra-enclosure wires connect peer `part`s directly inside their owning composite `part def`; cross-enclosure wires delegate explicitly through typed bulkhead ports on the boundary of each crossed composite `part def` (`Subsystem.Path.port`), preserving `1:1` wire count and hierarchy.
- **Law `L5` (Series Daisy-Chain, Trunk & Splitter Fidelity)**: Wires with `topology == "series_daisy_hop"` connect strictly hop-by-hop in ascending `series_hop_index` order (`0 -> 1 -> 2 -> ...`) across distinct `busIn` / `busThruOut` ports -- never collapsed into a star. Distribution/splitter PCBs are modeled as explicit intermediate nodes fanning out power/data as drawn.
- **Law `L6` (Electrical Supply-Graph Reachability)**: Every `component_instance` whose type sets `requires_electrical_power == true` has an explicit connected inbound power path (`dc_power`, `composite_power_video`, `composite_sensor_harness`, or documented `in_band_signal_or_composite_cable`) tracing back to an `energy_storage` source (`0` unpowered boards, switches, radios, or sensors, including boards inside nested stacks).
- **Law `L7` (Formal AST Realization of Legends, Protocols, FSMs & Conflicts)**: Every entry in `co_packaged_functions[]`, `protocol_and_register_contracts[]`, `state_machines_and_procedures[]`, `functional_invariants[]`, and `cross_document_reconciliations[]` lowers to formal typed `attribute`, `item def`, `constraint def`, `requirement def` (`satisfy` / `verify` bound), `action def`, or `state def` AST nodes -- never stranded in `doc /* ... */` comments alone.
- **Law `L8` (Root Lifecycle `state def` & Compile-Before-Audit-#2 Gate)**: Overwrite `schema/model.sysml` wholesale via `write_file` (`Overwrite: true`) without reading the quarantined prior file; declare a top-level system lifecycle `state def` (`>= 2` states with `Initial` and `Terminal` transitions) in the root `package`; and run `./target/release/ingest-sysml --schema schema/model.sysml --allowed-parts ... --negative-invariants ...` + `./target/release/compile-sysml --compile schema/model.sysml` (`exit 0`, re-run after every edit) **before** Blind Audit #2 inspects `.pipeline/schema-digest.json`.

### 3.4 `references/blind_schematic_audit_protocol.md` (Sharded Audit #1 + Text-Only Audit #2)
- **Blind Audit #1 (`Sharded Per-PDF Visual Diff + Text-Only Global Ledger Audit`)**:
  1. **Per-PDF Visual Shards (`1` `TypeName="research"` subagent per PDF; solo if `> 10 MB`; `<= 250`-word delta-only reply)**: Receives ONLY its single assigned `docs/reference/<file>.pdf` (calling `read_file` once with `0` line-range args), `schematic_ledger_schema.json`, `blind_schematic_audit_protocol.md`, and `schema/schematic_ledger.json` (`0` access to `schema/model.sysml`, `schema/extracted/*`, `docs/*`, or `.pipeline/schema*`). Independently counts and diffs every dashed boundary, boundary-straddling item, solid box, internal/external power wire, signal/RF/coax/mechanical line, series hop order, spare pin, protocol/bitfield table, state/interlock rule, sidebar functional paragraph, and parameter limit in that PDF against `schema/schematic_ledger.json`.
  2. **Global Text-Only Ledger Audit (`1` `TypeName="research"` subagent; `0` PDF reads; `<= 250`-word delta-only reply)**: Validates JSON Schema conformance, referential integrity across all foreign keys (`parent_enclosure_id`, `type_id`, `instance_id`, `port_name`), contiguous `0..m` `series_hop_index` chains, global supply-graph reachability for every `requires_electrical_power == true` instance, and completeness of `cross_document_reconciliations[]`.
  - **Exit Criterion**: `0` discrepancies across all per-PDF shards and global ledger audit before SysML synthesis begins.
- **Blind Audit #2 (`100% Text-Only Ledger <-> SysML Bijection Audit; 0 PDF Reads; Runs AFTER Fresh Compile`)**:
  - Executed strictly **after** `ingest-sysml` and `compile-sysml --compile` overwrite `.pipeline/schema.sysml` and `.pipeline/schema-digest.json` (and re-executed after any subsequent edit + recompile). Fresh `TypeName="research"` subagent (`0` shell access, **`0` PDF reads**, `<= 250`-word delta-only reply) receives `schema/schematic_ledger.json`, `skills/spec-schematic-ingestion/SKILL.md`, `schema/model.sysml`, and the freshly generated `.pipeline/schema-digest.json`, verifying Laws `L1..L8` line-by-line (`0` discrepancies required before commit).

### 3.5 `references/sysml_v2_compiler_grammar.md` (Domain-Neutral `compile-sysml` Surface Syntax)
Because `schema/model.sysml` is quarantined, store and follow this verified, 100% domain-neutral surface grammar accepted by `./target/release/compile-sysml --compile`:

```sysml
doc /* Root system model header comment. */
package SystemRootPackage {
    state def SystemLifecycleState {
        state PreOperational;
        state OperationalActive;
        transition T_Init first Initial then PreOperational;
        transition T_Run first PreOperational accept readinessConfirmed then OperationalActive;
        transition T_Done first OperationalActive then Terminal;
    }
    part def IntegratedSystemRoot {
        connection def CONN_EXT_01 {
            connect segmentA.bulkheadPowerOut to segmentB.bulkheadPowerIn;
        }
        part segmentA : PrimarySegmentEnclosure {}
        part segmentB : SecondarySegmentEnclosure {}
    }
    package SubsystemDomainPackage {
        port def RegulatedDcOutPort {
            attribute direction = "out";
            attribute itemType = "DcRailPowerItem";
            attribute protocol = "IF-PWR-001";
        }
        port def RegulatedDcInPort {
            attribute direction = "in";
            attribute itemType = "DcRailPowerItem";
            attribute protocol = "IF-PWR-001";
        }
        item def DcRailPowerItem {
            attribute nominalVoltageV : Real = 12.0;
        }
        action def RegulateSubsystemPower(in inputBusV : Real, out railHealthy : Boolean);
        constraint def VoltageBoundsConstraint {
            in railV : Real && attribute invariantExpr : String = "railV >= 12.0 and railV <= 32.0";
        }
        requirement def REQ_L_01 {
            doc /* Loss description. */
            attribute severity : String = "Catastrophic";
        }
        requirement def REQ_H_01 {
            doc /* Hazard description. */
            attribute severity : String = "Catastrophic";
        }
        requirement def REQ_UCA_01 {
            doc /* Unsafe control action description. */
            attribute ucaType : String = "Not Provided";
            @TriggersHazard("REQ_H_01");
        }
        requirement def REQ_SC_01 {
            text = "Safety constraint statement.";
            @SafetyRealises("REQ_UCA_01");
        }
        use case def UC_01_OperateSubsystem {
            subject LeafControllerUnit;
            actor SystemOperator;
            objective "Operational objective statement.";
        }
        test case def TC_01_VerifySubsystemRail {
            subject LeafControllerUnit;
            verify requirement REQ_SC_01;
            objective "Verification objective statement.";
            step measureNominalRailVoltage;
        }
        capability def SubsystemPowerRegulationCapability;
        interaction def INT_01_PowerStartupSequence {}
        part def PowerRegulatorUnit {
            attribute outputNominalV : Real = 12.0;
            port out dcRailOut : RegulatedDcOutPort;
        }
        part def LeafControllerUnit {
            attribute controllerClockHz : Real = 100.0;
            port in dcRailIn : RegulatedDcInPort;
        }
        part def NestedStackAssembly {
            port out statusRailOut : RegulatedDcOutPort;
            connection def CONN_INT_01 {
                connect regulator.dcRailOut to controller.dcRailIn;
            }
            connection def CONN_BULKHEAD_01 {
                connect regulator.dcRailOut to statusRailOut;
            }
            part regulator : PowerRegulatorUnit {}
            part controller : LeafControllerUnit {}
        }
    }
}
```

---

## 4. Copyable Turn-1 Dispatch Prompt (For Fresh Agent in New Session)

```markdown
You are starting a clean-sheet modeling session in `/Users/perkunas/uav03-tst01` (`DOWNSTREAM_CUSTOMER_PROJECT`, remote `origin`: `gintatkinson/uav03-tst01`).

Current `HEAD` contains a flawed first-pass SysML model (`schema/model.sysml` and `schema/extracted/*`) that flattened nested physical enclosures, merged distinct hardware boxes into synthetic "chimera" `part def`s, omitted internal power and signal connections, flattened series daisy-chains, multiplexed unrelated buses onto hybrid ports, and modeled from lossy prose summaries instead of the OEM drawings.

Read `docs/plans/SCHEMATIC_INGESTION_SKILL_AND_MODEL_PLAN.md` on Turn 1 and execute its exact single-scope specification:
1. Build the standalone, 100% domain-neutral skill package `skills/spec-schematic-ingestion/` (`SKILL.md`, `resources/schematic_ledger_schema.json`, `references/blind_schematic_audit_protocol.md`, `references/sysml_v2_compiler_grammar.md`).
2. Apply that skill cold to `docs/reference/*.pdf` (with ZERO reliance on the prior flawed `schema/model.sysml`, `schema/extracted/*`, legacy `docs/*`, or stale `.pipeline/schema*`) to produce `schema/schematic_ledger.json` (passing sharded Blind `research` Audit #1 with `0` discrepancies) and `schema/model.sysml` + freshly compiled `.pipeline/schema.sysml` / `.pipeline/schema-digest.json` (passing `./target/release/ingest-sysml --allowed-parts ... --negative-invariants ...`, `./target/release/compile-sysml --compile` with `exit 0`, Laws `L1..L8`, and text-only Blind `research` Audit #2 with `0` discrepancies).

Hard Constraints (Non-Negotiable):
1. **Strict Scope Ceiling (STOP at Compiled SysML Model)**: Do NOT regenerate or modify `docs/{conops,interfaces,epics,features,user-stories,use-cases,safety,research,management,architecture}`, do NOT run `--forward-sync`, `--stpa-transpile`, `assemble-conops`, or `reconcile-backlog`, do NOT run full-repo baseline checks that compare new `schema/model.sysml` names against untouched legacy `docs/*`, do NOT edit `skills/spec-orchestrator/SKILL.md`, and do NOT touch GitHub issues.
2. **External Repository Firewall**: NEVER read, list, grep, stat, or touch `/Users/perkunas/deap04`, `/Users/perkunas/deap03`, `/Users/perkunas/.deap/keys/*`, or `../DEAP01-spec-core/crates/*`.
3. **Prior-Run Quarantine**: NEVER read, grep, or reuse existing `schema/model.sysml`, `schema/extracted/*`, legacy `docs/{conops,interfaces,epics,features,user-stories,use-cases,safety,research,management,architecture}/**`, or pre-existing `.pipeline/schema*` during extraction, auditing, or synthesis (leave `schema/extracted/*` untouched; overwrite `schema/model.sysml` wholesale via `write_file` with `Overwrite: true` without reading the prior file; read `.pipeline/schema*` ONLY after your new `ingest-sysml` / `compile-sysml` run overwrites them; use the domain-neutral grammar in `docs/plans/SCHEMATIC_INGESTION_SKILL_AND_MODEL_PLAN.md` Section 3.5 for `compile-sysml` syntax) so zero prior modeling bias leaks in. Use `ask_question` ONLY if a genuine OEM configuration option (e.g., optional R&D kit population) cannot be resolved deterministically from the PDFs alone.
4. **Multimodal PDF Context Hygiene Lock (Anti-Compaction -- Mandatory in Session & Skill)**:
   - `read_file` on a binary `.pdf` ignores `StartLine`/`EndLine` parameters and attaches full-page screenshots + OCR for EVERY page of the PDF on every invocation.
   - **Zero-PDF Orchestrator**: The main orchestrator MUST NEVER call `read_file` on any `.pdf` file.
   - **1-PDF-Per-Subagent & Single Whole-Read Rule**: Any subagent (extraction or Blind `research` Audit #1) inspecting a `.pdf` MUST receive **at most 1 `.pdf` path**, MUST call `read_file` **at most once** on that `.pdf` with **zero `StartLine`/`EndLine` arguments**, and MUST NEVER issue parallel `read_file` calls on a `.pdf`. Any `.pdf` larger than `10 MB` MUST run in a solo subagent (`0` concurrent subagents) and be reclaimed immediately.
   - **Sharded Extraction & Sharded Audits**: Extract per-PDF JSON shards (capturing all topological enclosures/types/instances/wires AND all quantitative limits, protocol bitfields, state transitions, and operational/safety rules needed for `Laws L1..L8` in that single pass so no PDF requires a second read) to your resolved literal absolute scratch path `<appDataDir>/brain/<conversation-id>/scratch/shards/<doc_id>.json` (or gitignored `.pipeline/diagnostics/shards/<doc_id>.json` if subagent workspace sandboxing restricts external paths, removing any fallback shards before commit; start with the smallest block-diagram PDF to anchor canonical IDs). Merge shards into `schema/schematic_ledger.json` in a text-only (`0`-PDF) subagent, run Blind `research` Audit #1 as **1 `research` subagent per PDF** (`doc_id`-scoped) + **1 text-only global ledger `research` subagent**, compile `schema/model.sysml` via `ingest-sysml` + `compile-sysml --compile` (re-running both after any edit), and run Blind `research` Audit #2 (`schematic_ledger.json` <-> `schema/model.sysml` + fresh `.pipeline/schema-digest.json` + Laws `L1..L8`) strictly **text-only (`0` PDF reads)**. Encode this domain-neutral sharding rule inside `skills/spec-schematic-ingestion/` as well.
5. **Pure Domain-Neutrality in the Skill (`Check 19`)**: `skills/spec-schematic-ingestion/**` must contain ZERO concrete customer, vehicle, weapon, sensor-model, or vendor tokens -- use strictly abstract metamodel terms so the skill is portable across any engineering domain. Before committing, verify `skills/spec-schematic-ingestion/**` via read-only search for zero domain leaks (`Check 19`), and verify both `skills/spec-schematic-ingestion/**` and `schema/{schematic_ledger.json,model.sysml}` for zero `.DS_Store` (`Check 11`) and zero Unicode dashes.
6. **Governance & Execution Discipline (`AGENTS.md`)**:
   - On Turn 1, read-only inspect `AGENTS.md`, `.gitignore`, `rules/sysml-ssot-completeness.md`, `docs/plans/SCHEMATIC_INGESTION_SKILL_AND_MODEL_PLAN.md`, `ls -la docs/reference` (note file sizes for solo-PDF scheduling), `git status --short --branch`, and `./target/release/{ingest-sysml,compile-sysml} --help`; write your session execution plan using native file-write tools to `<appDataDir>/brain/<conversation-id>/implementation_plan.md` (and `.pipeline/plans/schematic-ingestion-session-plan.md`); and **STOP** for explicit `PROCEED` approval before mutating any other repository file.
   - After `PROCEED`, delegate all repository file writes to bounded subagents (`<= 200`-word prompts referencing disk paths; `<= 2` concurrent subagents, `1` solo for PDFs `> 10 MB`; require `<= 250`-word delta-only return summaries so subagent replies do not bloat orchestrator context; reclaim all subagents on completion); run both blind `TypeName="research"` audits (`0` shell access) to `0` discrepancies; never invoke Python/Perl/Ruby/Node or shell file-mutation operators; leave `0` `.DS_Store` files; use ASCII `--` only (`0` Unicode em/en dashes); stage and commit tracked deliverables via explicit paths (`git add -- ...`, `git commit --only -- ...`), push to `origin/main` (per `AGENTS.md` rules), and verify both `git status --porcelain` and `git diff origin/main` are empty.
```