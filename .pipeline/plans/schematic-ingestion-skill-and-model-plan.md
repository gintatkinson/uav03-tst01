# Plan & Fresh-Session Dispatch Specification: Standalone Pure-M2 Source-Graph Ingestion Skill & Bijective SysML v2 Model Synthesis

## 1. Objective & Single Atomic Scope

Prove a deterministic, 100% domain-neutral **M2 Source-Graph-to-SysML v2 Ingestion, Sharded Blind Verification & Transcript-Proven Execution Architecture** inside `./` (`gintatkinson/uav03-tst01`) that extracts a 100% source-faithful architectural model (`schema/source_graph_ledger.json` -> `schema/model.sysml` -> `.pipeline/schema.sysml`) directly from raw normative documents (`docs/reference/*`) with **zero** prior-run contamination, **zero** M1 domain/medium/protocol hints, **zero** multimodal PDF context-compaction crashes, and **immutable log proof of subagent delegation**.

### Strict Scope Boundaries
- **In Scope (3 Artifacts Only, Proven by `transcript_full.jsonl` Audit)**:
  1. `skills/spec-source-ingestion/` (`SKILL.md`, `resources/source_graph_ledger_schema.json`, `references/blind_source_graph_audit_protocol.md`, `references/sysml_v2_compiler_grammar.md`) -- standalone, portable, 100% M2 metamodel-pure skill package (`0` edits to `skills/spec-orchestrator/SKILL.md`), written exclusively via delegated `TypeName="self"` subagents.
  2. `schema/source_graph_ledger.json` -- extracted cold in a **single pass per source document** (`1` document per `TypeName="self"` subagent, capturing complete M2 structural containment, classifiers, instances, connections, interface/item contracts, state machines, and quantitative constraints), merged in a text-only `TypeName="self"` subagent, and verified to `0` discrepancies by **sharded Blind `TypeName="research"` Audit #1** (`1` `research` subagent per source document + `1` text-only global ledger `research` subagent).
  3. `schema/model.sysml` (overwritten wholesale via `write_file` `Overwrite: true` in a `TypeName="self"` synthesis subagent without reading the prior file) + freshly compiled `.pipeline/schema.sysml` and `.pipeline/schema-digest.json` -- lowered bijectively from `schema/source_graph_ledger.json` into `PartDefinition`, `Part`, `PortDefinition`, `ConnectionDefinition`, `ItemDefinition`, `StateDefinition`, `ConstraintDefinition`, `RequirementDefinition`, `ActionDefinition`, and `UseCaseDefinition` AST nodes under Structural Laws `L1..L8`, compiled **first** via `./target/release/ingest-sysml --schema schema/model.sysml --allowed-parts ... --negative-invariants ...` and `./target/release/compile-sysml --compile schema/model.sysml` (`exit 0`, re-run after every edit), verified to `0` discrepancies by **100% text-only Blind `TypeName="research"` Audit #2** (`0` PDF loads), and verified for clean-room subagent execution by **Blind `TypeName="research"` Audit #3 (`Transcript Provenance & Quarantine Proof Gate`)** prior to commit.
- **Explicitly Out of Scope (Hard Stop at Compiled SysML Model)**:
  - **ZERO** downstream specification regeneration or quarantined reads: do NOT read, modify, or re-project `docs/{conops,interfaces,epics,features,user-stories,use-cases,safety,research,management,architecture}/**`, do NOT read `README.md` or `.pipeline/defects/**`, do NOT run `git log`, `git show`, or `git diff` against prior commits, leave `schema/extracted/*` untouched and unread, do NOT read pre-existing `.pipeline/schema*` prior to overwriting them with your new compile, do NOT run `--forward-sync`, `--stpa-transpile`, `assemble-conops`, or `reconcile-backlog`, do NOT run full-repo `verify-baseline` checks against untouched legacy `docs/*`, and do NOT touch GitHub issues.
  - **ZERO** external repository access: NEVER read, list, grep, stat, or touch `../deap04`, `../deap03`, `~/.deap/keys/*`, or `../DEAP01-spec-core/crates/*`.
  - **ZERO** `DEAP01-spec-core` Rust feature rewrites: consume existing `./target/release/*` binaries as black-box tools.

---

## 2. M2 Graph Extraction Failure Modes Eliminated by This Design

| Failure ID | Graph-Extraction Failure Mode in Unstructured LLM Modeling | Pure-M2 Countermeasure in `spec-source-ingestion` |
| :--- | :--- | :--- |
| `FM-01` | **Containment Hierarchy Collapse**: Modeling from prose summaries drops nested visual/logical grouping boundaries in source diagrams, yielding a flat peer list. | Mandatory top-down `enclosures[]` containment tree (`T_E`) extracted before leaf nodes or connections; Law `L1` enforces `1:1` composite `PartDefinition` and `Part` nesting. |
| `FM-02` | **Synthetic Aggregate Classifiers & Duplicate Types**: Distinct source blocks on separate interfaces get merged into synthetic aggregate classes, or `k` identical instances get duplicated into `k` separate definitions. | Explicit separation of `component_types[]` (`V_T -> PartDefinition`) and `component_instances[]` (`V_I -> Part`) via typing map `tau: V_I -> V_T` (`Law L2`). |
| `FM-03` | **Omitted Internal & Resource-Supply Paths**: Internal links inside composite containers or routed through intermediate distribution nodes are skipped, leaving resource-consuming instances unreachable from any producer. | Generic M2 `requires_resource_supply` + `supply_satisfaction_mode` + `carries_resource_supply` edge semantics enforced by Law `L6` Producer-to-Consumer Supply-Graph Reachability. |
| `FM-04` | **Topology, Port Typing & Unconnected-Port Loss**: Ordered hop chains flatten into stars; shared multidrop links merge with point-to-point stubs; distinct media share hybrid ports; documented spare ports are dropped; declared types sit unused. | Mandatory `topology` (`ordered_chain_hop` + contiguous `chain_hop_index`), single-medium directional `declared_ports[]`, `unconnected_ports[]`, boundary port delegation (`Law L4`), and `0` orphan AST definitions (`Law L3`). |
| `FM-05` | **Annotation, Contract & Cross-Document Drift**: Marginal diagram rules, item/interface contracts, state transition guards, variant exclusions, and cross-document parameter conflicts are missed or trigger second PDF reads. | Single-pass capture of `secondary_capabilities[]`, `item_and_interface_contracts[]`, `state_machines[]`, `functional_invariants[]`, `variant_disposition`, and `cross_document_reconciliations[]` lowered into formal AST nodes (`Law L7`, `Law L8`). |
| `FM-06` | **Multimodal PDF Compaction & Unverified Coordinator Self-Execution**: `read_file` on binary PDFs renders every page per call, while coordinators silently bypass subagents or read quarantined files unless harness logs are audited. | **Zero-PDF Orchestrator**, **1-PDF-per-subagent single whole-read** (`> 2 MB` solo), `.pipeline/diagnostics/shards/<doc_id>.json` sharding, `<= 250`-word delta replies, and **Blind Audit #3** on `transcript_full.jsonl`. |

---

## 3. Exact Specification of `skills/spec-source-ingestion/`

### 3.1 `resources/source_graph_ledger_schema.json` (Pure-M2 JSON Schema Draft 2020-12)
Every object schema MUST set `"additionalProperties": false` and contain **`0` M1 physical-medium, hardware-class, domain, vendor, or protocol tokens**, adhering strictly to `ALLOWED_M2_METAMODEL_TYPES` in `rules/sysml-ssot-completeness.md` (Check 19). Define `"$defs": { "document_shard": ... }` reusing the exact item schemas below with **`minItems: 0` on all `document_shard` arrays** so partial single-document shards validate cleanly before merge. Root ledger properties:
1. `schema_version`: integer `const: 1`.
2. `source_documents[]` (`minItems: 1` at root):
   - `doc_id`, `relative_path`, `file_size_bytes` (`integer >= 1`), `page_count` (`integer >= 1`), `inspected_pages[]` (`integer[]` listing every inspected page in `1..page_count`).
3. `enclosures[]` (`minItems: 1` at root, `minItems: 0` in `document_shard`; parent-before-child containment tree `T_E` -> composite `PartDefinition`):
   - `enclosure_id`, `canonical_part_def` (`UpperCamelCase`), `canonical_instance_name` (`lowerCamelCase | null`, `null` only at root `SystemUnderStudy`), `source_exact_label`, `parent_enclosure_id` (`string | null`), `boundary_placement` (`"interior" | "boundary_straddling" | "external_peer"`), `cardinality` (`"1" | "0..1" | "0..*" | "1..*"`), `variant_disposition` (`"active_baseline" | "excluded_variant"`), `source_ref` (`{ doc_id, page, locator }`), `corroborating_source_refs[]`.
4. `component_types[]` (`minItems: 1` at root, `minItems: 0` in `document_shard`; distinct leaf classifiers `V_T` -> `PartDefinition`):
   - `type_id`, `canonical_part_def` (`UpperCamelCase`), `source_exact_label`,
   - `m2_role` (closed Check-19 M2 enum ONLY): `"Component" | "SystemController" | "SafetyInterlock" | "PhysicalActuator" | "Sensor" | "SystemUnderStudy" | "ExternalSystem" | "OperatorConsole" | "HumanOperator"`,
   - `secondary_capabilities[]` (`string[]`),
   - `requires_resource_supply` (`boolean`),
   - `supply_satisfaction_mode` (`"intrinsic_source" | "dedicated_supply_port" | "co_carried_on_connection" | "unmodeled_external_boundary" | "not_applicable"`),
   - `declared_ports[]` (`{ port_name, port_def_name, direction: "in" | "out" | "inout", conveyed_item_def, source_medium_or_protocol: string, is_resource_supply_producer: boolean, is_resource_supply_consumer: boolean }`),
   - `parametric_attributes[]` (`{ attribute_name, sysml_type: "Real" | "Integer" | "Boolean" | "String", value, unit_symbol, source_raw_value_and_unit, source_ref }`),
   - `source_ref`, `corroborating_source_refs[]`.
5. `component_instances[]` (`minItems: 1` at root, `minItems: 0` in `document_shard`; concrete diagram/specification occurrences `V_I` -> `Part` usage):
   - `instance_id`, `canonical_instance_name` (`lowerCamelCase`), `type_id` (FK -> `component_types`), `source_instance_label`, `parent_enclosure_id` (FK -> `enclosures`), `variant_disposition` (`"active_baseline" | "excluded_variant"`), `instance_attributes[]`, `source_ref`, `corroborating_source_refs[]`.
6. `connections[]` (`minItems: 1` at root, `minItems: 0` in `document_shard`; complete interaction edge list `E_C` -> `ConnectionDefinition`):
   - `connection_id`, `source_connection_label`, `conveyed_item_def` (`UpperCamelCase` -> `ItemDefinition`), `source_medium_or_protocol` (`string`, extracted dynamically from source documents at runtime -- `0` hardcoded M1 medium enums in the schema),
   - `topology` (`"point_to_point" | "shared_multidrop" | "branched_stub" | "ordered_chain_hop"`),
   - `direction` (`"unidirectional" | "bidirectional"`),
   - `from_endpoint` (`{ instance_id, port_name, endpoint_locator }`),
   - `to_endpoint` (`{ instance_id, port_name, endpoint_locator }`),
   - `chain_id` (`string | null`), `chain_hop_index` (`integer | null`),
   - `carries_resource_supply` (`boolean`),
   - `variant_disposition` (`"active_baseline" | "excluded_variant"`),
   - `link_attributes[]` (`{ attribute_name, sysml_type: "Real" | "Integer" | "Boolean" | "String", value, unit_symbol, source_raw_value_and_unit }`),
   - `source_ref`, `corroborating_source_refs[]`.
7. `unconnected_ports[]` (`minItems: 0`):
   - `instance_id`, `interface_group_id`, `port_or_element_designator`, `source_signal_or_port_label`, `disposition` (`const: "documented_unconnected"`), `source_ref`.
8. `item_and_interface_contracts[]` (`minItems: 0`; single-pass capture of payload fields, transfer bounds/rates, integrity/validation mechanisms, and command/status/threshold definitions):
   - `contract_id`, `connection_or_port_ref`, `operating_or_framing_spec`, `integrity_or_validation_spec`, `elements_and_thresholds[]`, `source_ref`, `corroborating_source_refs[]`.
9. `state_machines[]` (`minItems: 1` at root, `minItems: 0` in `document_shard` -> `StateDefinition` / `ActionDefinition`):
   - `fsm_id`, `owner_enclosure_or_type_id`, `states[]`, `transitions[]` (`{ from_state, trigger_event, guard_condition, effect_action, to_state }`), `source_ref`.
10. `functional_invariants[]` (`minItems: 0`):
    - `invariant_id`, `subject_id`, `category` (`"transfer_relation" | "cross_element_coupling" | "temporal_or_interlock_order" | "quantitative_bound" | "fault_or_recovery_rule" | "variant_exclusion"`), `formal_statement`, `sysml_realization_kind` (`"ConstraintDefinition" | "RequirementDefinition" | "StateDefinition" | "ActionDefinition"`), `source_ref`.
11. `cross_document_reconciliations[]` (`minItems: 0`):
    - `gap_id`, `summary`, `source_a`, `source_b`, `authoritative_disposition`.

### 3.2 Multimodal PDF Anti-Compaction & Single-Pass Sharding Protocol (Mandatory in `SKILL.md`)
1. **Binary PDF `read_file` Physics**: `read_file` on a `.pdf` ignores `StartLine`/`EndLine` and attaches rendered page images + OCR for **all** pages of the PDF on every call.
2. **Zero-PDF Orchestrator & Bounded Subagent Replies**: The coordinator MUST NEVER call `read_file` on any `.pdf` file; it inspects only `ls -la docs/reference` byte sizes, schedules documents in **ascending byte-size order** without assuming file contents, and requires every subagent (`self` or `research`) to keep its completion message `<= 250` words (delta/violation summary only).
3. **1-Document-Per-Subagent & Single-Pass Whole-Read (`> 2 MB` Solo Rule)**: Every subagent reading a `.pdf` receives **at most 1 `.pdf` path**, calls `read_file` **at most once** on that `.pdf` with **zero `StartLine`/`EndLine` arguments**, and NEVER issues parallel `read_file` calls on PDFs. Any `.pdf` **`> 2 MB`** runs **solo (`1` active subagent, `0` concurrent peers)** and is reclaimed immediately. In that single pass, the `TypeName="self"` extractor captures **both** structural graph elements (`enclosures`, `component_types`, `component_instances`, `connections`, `unconnected_ports`) **and** complete parametric/behavioral facts (`parametric_attributes`, `item_and_interface_contracts`, `state_machines`, `functional_invariants`) so zero second PDF reads are ever needed.
4. **Gitignored Workspace Shard Persistence (`0` `rm` Needed) & Text-Only Merge**:
   - Write per-document shards directly to gitignored `.pipeline/diagnostics/shards/<doc_id>.json` (already excluded by `.gitignore` line 41, so `0` `rm` or cleanup shell mutations are ever needed).
   - Dispatch 1 **text-only (`0`-PDF)** `TypeName="self"` merge subagent to reconcile canonical IDs, attach `corroborating_source_refs[]`, record `cross_document_reconciliations[]`, and emit `schema/source_graph_ledger.json`.

### 3.3 Structural Lowering Laws (`L1..L8` in `SKILL.md`)
- **Law `L1` (Containment Tree & Variant Disposition Fidelity)**: Every `"active_baseline"` entry in `enclosures[]` lowers `1:1` to a composite `PartDefinition` and `Part` usage at its exact `parent_enclosure_id` nesting level (`0` flattened containers; boundary-straddling elements follow `boundary_placement` with explicit boundary ports). Every `"excluded_variant"` entry across `enclosures[]`, `component_instances[]`, or `connections[]` lowers to an explicit `ConstraintDefinition` (`category == "variant_exclusion"`) AND is passed via `--negative-invariants` to `./target/release/ingest-sysml` rather than instantiated as an active baseline `Part`/`ConnectionDefinition`.
- **Law `L2` (Classifier vs. Instance Bijection -- Zero Aggregates, Zero Duplicate Types)**: For `"active_baseline"` elements, `|active component_types| == |leaf PartDefinitions|` and `|active component_instances| == |leaf Part usages|`. Two distinct source block types never share a `PartDefinition`; `k` identical instances (`k > 1`) share **one** `PartDefinition` and instantiate **`k`** distinct `Part` usages.
- **Law `L3` (Single-Medium Directional Ports & Zero Orphan Definitions)**: Every `declared_ports[]` entry carries a single `source_medium_or_protocol`, `conveyed_item_def`, and `in`/`out`/`inout` directionality (`0` hybrid ports multiplexing distinct media or protocols). Every declared `PortDefinition`, `ItemDefinition`, and `PartDefinition` in `schema/model.sysml` has `>= 1` active usage and connection (`0` orphan AST nodes).
- **Law `L4` (Intra-Enclosure & Boundary Port Connection Conservation)**: Intra-enclosure active `connections[]` bind peer `Part` ports directly inside their owning composite `PartDefinition`; cross-enclosure active `connections[]` delegate explicitly through typed boundary ports on each crossed composite `PartDefinition` (`Container.Subcontainer.port`), preserving `1:1` edge conservation.
- **Law `L5` (Ordered Chain, Multidrop & Distribution Node Fidelity)**: Active `connections[]` with `topology == "ordered_chain_hop"` connect strictly hop-by-hop in ascending `chain_hop_index` order (`0 -> 1 -> 2 -> ...`) across distinct `chainIn` / `chainOut` ports -- never collapsed into a star. Intermediate distribution/routing nodes are modeled as explicit `Part` usages fanning out connections as drawn.
- **Law `L6` (Producer-to-Consumer Resource Supply-Graph Reachability)**: Every `"active_baseline"` `component_instance` whose type declares `requires_resource_supply == true` and `supply_satisfaction_mode != "unmodeled_external_boundary"` must have a directed or bidirectional path in active `connections[]` (via `dedicated_supply_port` with `is_resource_supply_consumer == true` or `co_carried_on_connection` with `carries_resource_supply == true`) tracing back to an `"active_baseline"` instance whose type sets `supply_satisfaction_mode == "intrinsic_source"` (`is_resource_supply_producer == true`), including instances inside nested composite enclosures.
- **Law `L7` (Formal AST Realization of Capabilities, Contracts, State Machines & Invariants)**: Every entry in `secondary_capabilities[]`, `item_and_interface_contracts[]`, `state_machines[]`, `functional_invariants[]`, and `cross_document_reconciliations[]` lowers to formal typed `Attribute`, `ItemDefinition`, `ConstraintDefinition`, `RequirementDefinition` (bound via `@TriggersHazard`, `@SafetyRealises`, and `test case def` `verify requirement`), `ActionDefinition`, or `StateDefinition` AST nodes -- never stranded solely in `doc /* ... */` comments.
- **Law `L8` (Root Lifecycle `StateDefinition` & Explicit-Path Compile Gate)**: Overwrite `schema/model.sysml` wholesale via `write_file` (`Overwrite: true`) without reading the quarantined prior file; declare a root lifecycle `state def` (`>= 2` states with `Initial` and `Terminal` transitions) in the root `package`; and run `./target/release/ingest-sysml --schema schema/model.sysml --allowed-parts ... --negative-invariants ...` + `./target/release/compile-sysml --compile schema/model.sysml` (`exit 0`, re-run after every edit) **before** Blind Audit #2 inspects `.pipeline/schema-digest.json`.

### 3.4 `references/blind_source_graph_audit_protocol.md` (Audits #1, #2 & #3 -- Strictly `TypeName="research"`)
- **Blind Audit #1 (`Sharded Per-Document Visual/Text Diff + Global Ledger Audit; TypeName="research"; 0 Shell Access`)**:
  1. **Per-Document Shards (`1` `TypeName="research"` subagent per file in `docs/reference/*`; solo if `> 2 MB`; `<= 250`-word delta reply)**: Receives ONLY its single assigned `docs/reference/<file>` (`<= 1` `read_file` call with `0` line-range args), `source_graph_ledger_schema.json`, `blind_source_graph_audit_protocol.md`, and `schema/source_graph_ledger.json` (`0` access to `schema/model.sysml`, `schema/extracted/*`, `docs/*`, `README.md`, `.pipeline/defects/**`, or `.pipeline/schema*`). Independently counts and diffs every grouping boundary, boundary-straddling node, leaf block, internal/cross-boundary connection, ordered hop sequence, unconnected port, item/interface contract, state transition/guard, annotation rule, variant disposition, and quantitative parameter in that document against `schema/source_graph_ledger.json`.
  2. **Global Text-Only Ledger Audit (`1` `TypeName="research"` subagent; `0` PDF reads; `<= 250`-word delta reply)**: Validates JSON Schema conformance, foreign-key integrity (`parent_enclosure_id`, `type_id`, `instance_id`, `port_name`), Check-19 `m2_role` closure, contiguous `0..m` `chain_hop_index` sequences, global `Law L6` supply-graph reachability, and `cross_document_reconciliations[]` completeness.
  - **Exit Criterion**: `0` discrepancies across all shards and global ledger audit before SysML synthesis begins.
- **Blind Audit #2 (`100% Text-Only Ledger <-> SysML Bijection Audit; TypeName="research"; 0 Shell Access; 0 PDF Reads`)**:
  - Executed strictly **after** `ingest-sysml --schema schema/model.sysml ...` and `compile-sysml --compile schema/model.sysml` overwrite `.pipeline/schema.sysml` and `.pipeline/schema-digest.json` (and re-run after any edit + recompile). Verifies Laws `L1..L8` line-by-line across `schema/source_graph_ledger.json`, `skills/spec-source-ingestion/SKILL.md`, `schema/model.sysml`, and `.pipeline/schema-digest.json` (`0` discrepancies required before Blind Audit #3).
- **Blind Audit #3 (`Transcript Provenance, Subagent Delegation & Quarantine Proof Gate; TypeName="research"; 0 Shell Access; 0 PDF Reads`)**:
  - Executed strictly **after** Blind Audit #2 passes and **before** `git commit`. Inspects `<appDataDir>/brain/<conversation-id>/.system_generated/logs/transcript_full.jsonl` (plus only same-session child `transcript_full.jsonl` files referenced by its `invoke_subagent` records; `0` cross-session access) to verify and report by `step_index` and `conversation://<subagent-id>`:
    1. `0` coordinator `write_file`/`edit_file` calls targeting repository paths (sole coordinator writes are `<appDataDir>/brain/<conversation-id>/implementation_plan.md` and post-push `walkthrough.md`) and `0` Python/Perl/Ruby/Node or shell file-mutation operators (`cp`, `mv`, `rm`, `tee`, `sed -i`, `>`, `>>`).
    2. `1:1` `TypeName="self"` writer dispatches (carrying verbatim `DOWNSTREAM_CUSTOMER_PROJECT` classification and `PROCEED`) cleanly separated from `TypeName="research"` read-only auditors; `0` coordinator `.pdf` reads; `<= 1` whole-PDF `read_file` per shard subagent; solo execution for all PDFs `> 2 MB`.
    3. `0` reads of quarantined `schema/model.sysml` (prior to wholesale overwrite), `schema/extracted/*`, legacy `docs/**` (outside `docs/plans/` and `docs/reference/`), `README.md`, `.pipeline/defects/**`, pre-compile `.pipeline/schema*`, `git log`/`git show`/`git diff` history, or external repos (`../deap04`, `../deap03`, `~/.deap/keys/*`, `../DEAP01-spec-core/crates/*`).
  - **Exit Criterion**: `0` violations; the verified `step_index` + `[<Role>](conversation://<subagent-id>)` provenance table MUST appear in `walkthrough.md` and the final report.

### 3.5 `references/sysml_v2_compiler_grammar.md` (Self-Contained Check-19 `Meta*` / M2 Surface Syntax)
Store and follow this self-contained, compile-verified Check-19 `Meta*` / M2 surface grammar accepted by `./target/release/compile-sysml --compile` (`0` M1 domain/medium/unit nouns, `0` undefined types, `@TriggersHazard` / `@SafetyRealises` / `verify requirement` only):

```sysml
doc /* Root M2 metamodel surface grammar template. */
package MetaPackage {
    state def MetaLifecycleState {
        state MetaInitialReady;
        state MetaOperational;
        transition T_MetaInit first Initial then MetaInitialReady;
        transition T_MetaRun first MetaInitialReady accept metaGuardAccepted then MetaOperational;
        transition T_MetaDone first MetaOperational then Terminal;
    }
    part def MetaSystemUnderStudy {
        connection def CONN_META_TOP_01 {
            connect metaPrimaryComposite.metaBoundaryOut to metaPeerComposite.metaBoundaryIn;
        }
        part metaPrimaryComposite : MetaCompositePart {}
        part metaPeerComposite : MetaPeerCompositePart {}
    }
    package MetaSubPackage {
        port def MetaOutPort {
            attribute direction = "out";
            attribute itemType = "MetaItem";
            attribute protocol = "META_IF_01";
        }
        port def MetaInPort {
            attribute direction = "in";
            attribute itemType = "MetaItem";
            attribute protocol = "META_IF_01";
        }
        port def MetaInoutPort {
            attribute direction = "inout";
            attribute itemType = "MetaItem";
            attribute protocol = "META_IF_01";
        }
        item def MetaItem {
            attribute metaValue : Real = 0.0;
        }
        action def MetaAction(in metaInput : Real, out metaStatus : Boolean);
        constraint def MetaConstraint {
            in metaValue : Real && attribute invariantExpr : String = "metaValue >= 0.0 and metaValue <= 1.0";
        }
        requirement def REQ_L_01 {
            doc /* Abstract system loss definition. */
            attribute severity : String = "Catastrophic";
        }
        requirement def REQ_H_01 {
            doc /* Abstract system hazard definition. */
            attribute severity : String = "Catastrophic";
        }
        requirement def REQ_UCA_01 {
            doc /* Abstract unsafe control action definition. */
            attribute ucaType : String = "Not Provided";
            @TriggersHazard("REQ_H_01");
        }
        requirement def REQ_SC_01 {
            text = "Abstract safety constraint statement.";
            @SafetyRealises("REQ_UCA_01");
        }
        use case def UC_01_ExecuteMetaCapability {
            subject MetaSystemController;
            actor HumanOperator;
            objective "Abstract operational objective statement.";
        }
        test case def TC_01_VerifyMetaConstraint {
            subject MetaSystemController;
            verify requirement REQ_SC_01;
            objective "Abstract verification objective statement.";
            step evaluateMetaInvariant;
        }
        capability def MetaCapability;
        interaction def INT_01_MetaInteraction {}
        part def MetaComponent {
            attribute metaParameter : Real = 0.0;
            port out metaOut : MetaOutPort;
            port inout metaPeer : MetaInoutPort;
        }
        part def MetaSystemController {
            attribute metaCycleCount : Integer = 1;
            port in metaIn : MetaInPort;
        }
        part def MetaCompositePart {
            port out metaBoundaryOut : MetaOutPort;
            connection def CONN_META_INT_01 {
                connect metaSource.metaOut to metaController.metaIn;
            }
            connection def CONN_META_BOUNDARY_01 {
                connect metaSource.metaOut to metaBoundaryOut;
            }
            part metaSource : MetaComponent {}
            part metaController : MetaSystemController {}
        }
        part def MetaPeerCompositePart {
            port in metaBoundaryIn : MetaInPort;
            port inout metaPeerPort : MetaInoutPort;
            connection def CONN_META_PEER_01 {
                connect metaBoundaryIn to metaTarget.metaIn;
            }
            part metaTarget : MetaSystemController {}
        }
    }
}
```

---

## 4. Copyable Turn-1 Dispatch Prompt (For Fresh Agent in New Session)

```markdown
You are starting a clean-room M2 source-graph ingestion session in `./` (`DOWNSTREAM_CUSTOMER_PROJECT`, remote `origin`: `gintatkinson/uav03-tst01`).

All pre-existing `schema/*`, `.pipeline/schema*`, legacy `docs/{conops,interfaces,epics,features,user-stories,use-cases,safety,research,management,architecture}/**`, `README.md`, `.pipeline/defects/**`, and prior git commit history are quarantined legacy artifacts and MUST NOT be read, grepped, diffed, or reused.

Read `docs/plans/SCHEMATIC_INGESTION_SKILL_AND_MODEL_PLAN.md` on Turn 1 and execute its exact single-scope specification:
1. Build the standalone, 100% M2 metamodel-pure skill package `skills/spec-source-ingestion/` (`SKILL.md`, `resources/source_graph_ledger_schema.json`, `references/blind_source_graph_audit_protocol.md`, `references/sysml_v2_compiler_grammar.md`) exclusively via bounded `TypeName="self"` subagents.
2. Apply that skill cold to `docs/reference/*` (with ZERO reliance on quarantined files) to produce `schema/source_graph_ledger.json` (passing sharded Blind `TypeName="research"` Audit #1 with `0` discrepancies) and `schema/model.sysml` + freshly compiled `.pipeline/schema.sysml` / `.pipeline/schema-digest.json` (passing `./target/release/ingest-sysml --schema schema/model.sysml --allowed-parts ... --negative-invariants ...`, `./target/release/compile-sysml --compile schema/model.sysml` with `exit 0`, Laws `L1..L8`, text-only Blind `TypeName="research"` Audit #2 with `0` discrepancies, and Blind `TypeName="research"` Audit #3 `transcript_full.jsonl` Provenance & Quarantine Proof Gate with `0` violations).

Hard Constraints (Non-Negotiable):
1. **Strict Scope Ceiling (STOP at Compiled SysML Model)**: Do NOT read, regenerate, or modify `docs/{conops,interfaces,epics,features,user-stories,use-cases,safety,research,management,architecture}/**`, do NOT run `--forward-sync`, `--stpa-transpile`, `assemble-conops`, or `reconcile-backlog`, do NOT run full-repo `verify-baseline` checks against untouched legacy `docs/*`, do NOT edit `skills/spec-orchestrator/SKILL.md`, and do NOT touch GitHub issues.
2. **External Repository Firewall**: NEVER read, list, grep, stat, or touch `../deap04`, `../deap03`, `~/.deap/keys/*`, or `../DEAP01-spec-core/crates/*`.
3. **Complete Legacy & History Quarantine**: NEVER read, grep, or inspect pre-existing `schema/model.sysml`, `schema/extracted/*`, legacy `docs/**` (outside `docs/plans/` and `docs/reference/`), `README.md`, `.pipeline/defects/**`, pre-existing `.pipeline/schema*`, or `git log` / `git show` / `git diff` against prior commits (leave `schema/extracted/*` untouched; overwrite `schema/model.sysml` wholesale via `write_file` `Overwrite: true` in a synthesis subagent without reading the prior file; read `.pipeline/schema*` ONLY after your new `ingest-sysml` and `compile-sysml --compile` runs overwrite them; use Section 3.5's `Meta*` grammar card for `compile-sysml` syntax). Use `ask_question` ONLY if an undocumented source ambiguity cannot be resolved deterministically from `docs/reference/*` alone.
4. **Multimodal PDF Context Hygiene & Gitignored Sharding (`> 2 MB` Solo Lock)**:
   - `read_file` on a binary `.pdf` ignores `StartLine`/`EndLine` and renders every page screenshot + OCR per call.
   - **Zero-PDF Orchestrator**: The coordinator MUST NEVER call `read_file` on any `.pdf` file; schedule `docs/reference/*` strictly in **ascending byte-size order** (`ls -la docs/reference`).
   - **1-PDF-Per-Subagent & `> 2 MB` Solo Rule**: Every subagent (`TypeName="self"` extractor or `TypeName="research"` Audit #1) inspecting a `.pdf` receives **at most 1 `.pdf` path**, calls `read_file` **at most once** with **zero `StartLine`/`EndLine` arguments**, and NEVER issues parallel `.pdf` reads. Any `.pdf` **`> 2 MB`** MUST run in a solo subagent (`0` concurrent peers) and be reclaimed immediately.
   - **Single-Pass Shards in `.pipeline/diagnostics/shards/`**: Write each per-document shard (conforming to `$defs.document_shard` with `minItems: 0` on shard arrays, capturing all topological and quantitative/contract/FSM/invariant facts in one pass) directly to gitignored `.pipeline/diagnostics/shards/<doc_id>.json` (`0` `rm` needed), merge into `schema/source_graph_ledger.json` via 1 text-only `TypeName="self"` subagent, run sharded `TypeName="research"` Audit #1, compile `schema/model.sysml` via explicit-path `ingest-sysml --schema schema/model.sysml ...` + `compile-sysml --compile schema/model.sysml` (re-running both after any edit), and run text-only `TypeName="research"` Audit #2 (`0` PDF reads).
5. **Literal Check-19 `ALLOWED_M2_METAMODEL_TYPES` Purity**: `skills/spec-source-ingestion/**` must contain **ZERO M1 physical-medium, hardware-class, domain, customer, vendor, or protocol tokens** -- enforce `rules/sysml-ssot-completeness.md` `ALLOWED_M2_METAMODEL_TYPES` literally across all schema enums, lowering laws, audit docs, and `Meta*` grammar examples. Before committing, verify `skills/spec-source-ingestion/**` via read-only search for Check-19 purity, and verify both `skills/spec-source-ingestion/**` and `schema/{source_graph_ledger.json,model.sysml}` for zero `.DS_Store` (`Check 11`), zero hardcoded workstation paths, and zero Unicode dashes.
6. **Governance, Writer/Auditor Separation & `transcript_full.jsonl` Proof Gate (`Blind Audit #3`)**:
   - On Turn 1, read-only inspect ONLY `AGENTS.md`, `.gitignore`, `rules/sysml-ssot-completeness.md`, `rules/subagent-dispatch-standards.md`, `docs/plans/SCHEMATIC_INGESTION_SKILL_AND_MODEL_PLAN.md`, `ls -la docs/reference`, `git status --short --branch`, and `./target/release/{ingest-sysml,compile-sysml} --help`; write your session plan ONLY to `<appDataDir>/brain/<conversation-id>/implementation_plan.md`; and **STOP** for explicit `PROCEED` approval before mutating any repository file.
   - After `PROCEED`, persist a copy of the approved session plan to `docs/plans/source-ingestion-session-plan.md` via a `TypeName="self"` subagent, delegate 100% of repository writes to bounded single-item `TypeName="self"` subagents (`<= 200`-word prompts carrying verbatim `DOWNSTREAM_CUSTOMER_PROJECT` classification and trailing `PROCEED`; `<= 2` concurrent, `1` solo for PDFs `> 2 MB`; `<= 250`-word delta replies; immediate `manage_subagents` reclamation), keep all audit gates strictly on read-only `TypeName="research"` subagents (`0` shell/write access), and never invoke Python/Perl/Ruby/Node or shell file-mutation operators (`cp`, `mv`, `rm`, `tee`, `sed -i`, `>`, `>>`).
   - **Before `git commit`**, run **Blind Audit #3 (`TypeName="research"`, `0` shell access, `0` PDF reads)** on `<appDataDir>/brain/<conversation-id>/.system_generated/logs/transcript_full.jsonl` (plus same-session child `transcript_full.jsonl` files referenced in its `invoke_subagent` records; `0` cross-session reads) to prove `0` coordinator repo writes, `0` coordinator `.pdf` reads, `1:1` subagent delegation, and `0` quarantined reads. Commit is **LOCKED** unless Blind Audit #3 returns `0` violations and you record the `step_index` + `[<Role>](conversation://<subagent-id>)` provenance table in `walkthrough.md` and your final report, then stage/commit tracked deliverables via explicit paths (`git add -- ...`, `git commit --only -- ...`), push to `origin/main`, and verify `git status --porcelain` and `git diff origin/main` are empty.
```
