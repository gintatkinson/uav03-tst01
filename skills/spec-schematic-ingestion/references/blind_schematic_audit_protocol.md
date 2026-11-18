<!-- Copyright Gint Atkinson, gint.atkinson@gmail.com -->

# Blind Schematic & SysML Bijection Audit Protocol

This reference protocol governs **Blind Audit #1** (sharded per-PDF visual verification + global text-only ledger audit) and **Blind Audit #2** (text-only post-compile ledger-to-SysML bijection audit) for `skills/spec-schematic-ingestion/`.

---

## 1. Universal Blindness, Quarantine & Dispatch Invariants

1. **Research-Only Role Isolation**: Every audit subagent MUST run as a fresh, context-isolated `TypeName="research"` agent with **zero shell execution** and **zero file write/edit permissions** against repository artifacts (`schema/*`, `skills/*`, `.pipeline/*`).
2. **Prior-Run Quarantine & External Firewall**:
   - Auditors MUST NEVER read `schema/extracted/*`, legacy `docs/{conops,interfaces,epics,features,user-stories,use-cases,safety,research,management,architecture}/**`, or external repositories/compiler source crates.
   - Audit #1 subagents MUST NEVER read `schema/model.sysml` or `.pipeline/schema*`.
   - Audit #2 subagents MUST NEVER read any `.pdf` file (`0` PDF reads).
3. **Multimodal PDF Hygiene (Audit #1 Visual Shards Only)**:
   - Each visual shard receives **at most 1 `.pdf` path** and calls `read_file` **at most once** on that PDF with **zero `StartLine` and zero `EndLine` arguments**.
   - Any `.pdf` larger than `10 MB` MUST run in a **solo subagent** (`1` active subagent, `0` concurrent peers) and be reclaimed immediately upon completion.
4. **Bounded Reply & Scratch Overflow Contract**:
   - Every audit subagent MUST return a **`<= 250`-word delta-only summary** stating verdict (`PASS` or `FAIL`), observed vs. recorded counts, and exact discrepancy IDs (`A1-<doc_id>-NNN`, `A1-GLOB-NNN`, or `A2-NNN`).
   - If detailed discrepancy rows exceed 250 words, write the complete discrepancy table to a resolved scratch file (`<appDataDir>/brain/<conversation-id>/scratch/audits/<audit_id>.md`, expanding placeholders to literal resolved paths -- or gitignored `.pipeline/diagnostics/audits/<audit_id>.md` if sandboxed, deleted before commit) and cite that path inside the `<= 250`-word reply.
   - Reclaim every audit subagent immediately after its report arrives.
5. **Zero-Discrepancy Exit Gate**: Both Audit #1 and Audit #2 require strictly `0` discrepancies before advancing to the next workflow phase or committing artifacts.

---

## 2. Blind Audit #1 -- Sharded Per-PDF Visual Diff + Global Ledger Audit

Blind Audit #1 verifies that `schema/schematic_ledger.json` captures 100% of physical, electrical, protocol, behavioral, and parametric facts present in `docs/reference/*.pdf` without omission, phantom invention, or structural distortion. It executes in two sub-phases.

### Sub-Phase 1A: Per-PDF Visual Diff Shards (`1` `TypeName="research"` Subagent per PDF)

#### Inputs Allowed (Strict Allowlist)
1. Single assigned PDF (`docs/reference/<file>.pdf`) -- read once with `0` `StartLine`/`EndLine` args.
2. `skills/spec-schematic-ingestion/resources/schematic_ledger_schema.json`
3. `skills/spec-schematic-ingestion/references/blind_schematic_audit_protocol.md`
4. `schema/schematic_ledger.json`

#### Inputs Forbidden
- All other `.pdf` files, `schema/model.sysml`, `schema/extracted/*`, legacy `docs/*`, `.pipeline/schema*`.

#### Independent Counting & Visual Diff Procedure
Inspect the assigned PDF completely first and tally independent counts from its pages BEFORE comparing against entries in `schema/schematic_ledger.json` referencing `doc_id`:

1. **Page Inventory (`source_documents[]`)**: Verify `page_count` matches the PDF and confirm every block schematic, wiring diagram, pinout table, CAD/mechanical layout, protocol specification, and parameter table page is listed in `inspected_pages[]`.
2. **Dashed/Grouped Boundaries & Enclosures (`enclosures[]`)**: Count and diff every dashed/grouped physical sub-assembly box, parent-child nesting relationship, `boundary_placement` (`"interior"`, `"boundary_straddling"`, `"external_segment"`), `cardinality` (`"1"`, `"0..1"`), and `populated_in_production` flag (`FM-01`).
3. **Solid Boxes, Classifiers & Instances (`component_types[]`, `component_instances[]`)**: Count every drawn hardware/software symbol and verify physically distinct OEM boxes are not collapsed into chimera classes, identical units map `k` instances to `1` shared `type_id`, and every diagram legend or sidebar functional callout is recorded in `co_packaged_functions[]` (`FM-02`).
4. **Internal & External Power Rails (`wires[]`, `requires_electrical_power`, `power_feed_mode`)**: Independently trace every power feed -- including rails drawn inside stacked/nested sub-assemblies and routed through splitter/distribution PCBs -- checking `nominal_voltage_v`, `voltage_range_v`, and port power flags (`is_power_input`, `is_power_output`) (`FM-03`).
   - When a block graphic omits an individual supply line for an active powered component whose power supply or cable kit is evidenced by the same document's sidebar specification or BOM cable inventory, modeling that `dc_power` edge with an explicit `source_ref.locator` to the sidebar/BOM clause plus a `cross_document_reconciliations[]` entry is mandatory for Law `L6` closure and MUST NOT be flagged as `PHANTOM`.
5. **Signal, Bus, Optical, RF, Pneumatic & Mechanical Lines (`wires[]`)**: Count and diff every communication bus, discrete I/O line, continuity loop, composite harness, coaxial/over-the-air link, optical fiber, pneumatic line, and structural/inertial edge. Verify exact `domain`, `direction`, `from_endpoint` / `to_endpoint` (`instance_id`, `port_name`, `connector_or_pin_ref`), `harness_length_m`, `conductor_count`, and `active_in_production` (`FM-04`).
6. **Series Daisy-Chain Order (`topology`, `series_chain_id`, `series_hop_index`)**: Verify every `series_daisy_hop` chain preserves exact hop-by-hop physical order (`0 -> 1 -> 2 -> ...`) across distinct directional ports and is never collapsed into a star (`FM-04`).
7. **Unconnected & Spare Pins (`unconnected_or_spare_pins[]`)**: Diff every pinout table row marked spare, NC, or unconnected against `unconnected_or_spare_pins[]` (`disposition: "documented_spare_unconnected"`).
8. **Protocol, Register & Waveform Contracts (`protocol_and_register_contracts[]`)**: Diff every bus framing format, baud/poll/timeout value, CRC/checksum rule, opcode table, telemetry/fault bitfield, and discrete waveform timing specification (`FM-05`).
9. **State Machines, Procedures & Interlocks (`state_machines_and_procedures[]`)**: Diff every operational state, pre-operational interlock, emergency abort/scrub sequence, and failsafe transition `{ from_state, trigger_and_guard, to_state }` (`FM-05`).
10. **Functional Invariants & Parametric Limits (`functional_invariants[]`, `parametric_attributes[]`)**: Diff every sidebar constraint, operating limit, physical/environmental bound, SI conversion, and `oem_raw_value_and_unit` (`Check 23`).
11. **Two-Way Diff Classification**:
    - `MISSING`: Present in assigned PDF, absent in `schema/schematic_ledger.json`.
    - `PHANTOM`: Recorded in `schema/schematic_ledger.json` citing `doc_id`, absent in assigned PDF.
      - Sidebar/BOM Power-Rail Rule: When a block graphic omits an individual supply line for an active powered component whose power supply or cable kit is evidenced by the same document's sidebar specification or BOM cable inventory, modeling that `dc_power` edge with an explicit `source_ref.locator` to the sidebar/BOM clause plus a `cross_document_reconciliations[]` entry is mandatory for Law `L6` closure and MUST NOT be flagged as `PHANTOM`.
    - `MISMATCH`: Attribute, count, topology, domain, endpoint, or limit differs from assigned PDF.

---

### Sub-Phase 1B: Global Text-Only Ledger Audit (`1` `TypeName="research"` Subagent; `0` PDF Reads)

#### Inputs Allowed (Strict Allowlist)
1. `skills/spec-schematic-ingestion/resources/schematic_ledger_schema.json`
2. `skills/spec-schematic-ingestion/references/blind_schematic_audit_protocol.md`
3. `schema/schematic_ledger.json`

#### Inputs Forbidden
- ALL `.pdf` files (`docs/reference/*.pdf`), `schema/model.sysml`, `schema/extracted/*`, legacy `docs/*`, `.pipeline/schema*`.

#### Global Structural & Graph Checks
1. **Strict Draft 2020-12 Conformance**: Verify presence of all 11 required root keys (`schema_version == 1` through `cross_document_reconciliations`), closed enums, required properties, correct scalar/array types, and zero unpermitted keys (`additionalProperties: false`).
2. **Enclosure Tree & Foreign Key Integrity**:
   - `enclosures[]` forms an acyclic parent-before-child tree `T_E` (`parent_enclosure_id: null` only at root).
   - Every `component_instances[].type_id` resolves in `component_types[]`.
   - Every `component_instances[].parent_enclosure_id` resolves in `enclosures[]`.
   - Every `wires[].from_endpoint` and `to_endpoint` resolves to a valid `instance_id` and a declared `port_name` on its `type_id` in `component_types[]`.
   - Every foreign key in `unconnected_or_spare_pins[]`, `protocol_and_register_contracts[]`, `state_machines_and_procedures[]`, and `functional_invariants[]` resolves to a valid ledger entity.
3. **Contiguous Series Daisy-Chain Continuity**: For each `series_chain_id`, verify all wires share `topology == "series_daisy_hop"`, `series_hop_index` forms an unbroken `0, 1, ..., m` sequence with zero gaps or duplicates, and consecutive hops chain endpoint-to-endpoint (`wire[i].to_endpoint.instance_id == wire[i+1].from_endpoint.instance_id`) via distinct input vs. pass-through ports.
4. **Global Electrical Supply-Graph Reachability (`Law L6` Pre-Check)**: Construct the directed power supply graph from `energy_storage` / `self_energy_source` components across active electrical and composite power-carrying wires (`dc_power`, `ac_multiphase`, `in_band_signal_or_composite_cable`, and composite power-carrying harness domains) through intermediate regulators, switches, and splitter PCBs (`is_power_input` -> `is_power_output`). Confirm 100% of `component_instances` whose type has `requires_electrical_power == true` and `populated_in_production == true` are reachable (`0` isolated active modules).
5. **Cross-Document Reconciliation & Uniqueness**: Confirm zero duplicate `enclosure_id`, `type_id`, `instance_id`, `wire_id`, `canonical_part_def`, or `canonical_instance_name` collisions, and verify every inter-document conflict carries a `cross_document_reconciliations[]` entry with an explicit `authoritative_disposition`.

#### Audit #1 Exit & Remediation Loop
If `>= 1` discrepancy (`A1-<doc_id>-NNN` or `A1-GLOB-NNN`) is reported:
1. Remediate the ledger gap (re-reading a single PDF ONLY if missing visual facts cannot be resolved from existing shard artifacts, obeying the 1-PDF-per-subagent single-read rule).
2. Re-run only the affected per-PDF shard audit(s) plus the global text-only audit until ALL shards and the global audit return `PASS` with `0` discrepancies.

---

## 3. Blind Audit #2 -- Text-Only Post-Compile Ledger <-> SysML Bijection Audit

Blind Audit #2 verifies 100% mathematical bijection and Laws `L1..L8` between the verified ledger and the freshly compiled SysML v2 AST without touching any PDFs.

### Strict Precondition
Blind Audit #2 MUST NOT run until `schema/model.sysml` has been written wholesale and BOTH `./target/release/ingest-sysml` and `./target/release/compile-sysml --compile schema/model.sysml` have exited `0`, freshly overwriting `.pipeline/schema.sysml` and `.pipeline/schema-digest.json`.

### Agent & Input Allowlist (`1` `TypeName="research"` Subagent; `0` PDF Reads)

#### Inputs Allowed
1. `schema/schematic_ledger.json`
2. `skills/spec-schematic-ingestion/SKILL.md`
3. `skills/spec-schematic-ingestion/references/blind_schematic_audit_protocol.md`
4. `skills/spec-schematic-ingestion/references/sysml_v2_compiler_grammar.md`
5. `schema/model.sysml`
6. Fresh `.pipeline/schema-digest.json` (and `.pipeline/schema.sysml` overwritten by the latest compile)

#### Inputs Forbidden
- ALL `.pdf` files (`docs/reference/*.pdf`), `schema/extracted/*`, legacy `docs/*`.

### Line-by-Line Bijection & Law `L1..L8` Audit Matrix

Verify every Law explicitly and log any violation as `A2-NNN`:

1. **Law `L1` (Enclosure Tree Isomorphism)**:
   - Compare `enclosures[]` against composite `part def` and `part` usages across `schema/model.sysml` and `.pipeline/schema-digest.json`.
   - Confirm `1:1` composite `part def` parity, exact `parent_enclosure_id` nesting depth, preserved `cardinality` / `boundary_placement`, and structural modeling + production-inhibit constraints for every `0..1` `populated_in_production == false` assembly.
2. **Law `L2` (Classifier vs. Instance Bijection)**:
   - Verify exact counts: `|component_types[]| == |leaf part defs|` and `|component_instances[]| == |leaf part usages|`.
   - Confirm zero chimera bucket `part def`s merging distinct hardware boxes, zero duplicate `part def`s for `k` identical units, and exact typing `part <canonical_instance_name> : <canonical_part_def>`.
3. **Law `L3` (Single-Domain Ports & Zero Orphan Definitions)**:
   - Verify every `port def` and `port` carries one single `domain` and exact `in`/`out`/`inout` direction matching `declared_ports[]` (`0` hybrid ports).
   - Cross-check `.pipeline/schema-digest.json` against `schema/model.sysml` to confirm every declared `part def`, `port def`, `item def`, `action def`, `state def`, `constraint def`, `requirement def`, `use case def`, `test case def`, `capability def`, and `interaction def` has `>= 1` active usage, connection, or `satisfy`/`verify`/`subject` binding (`0` dead declarations).
4. **Law `L4` (Connection Conservation & Bulkhead Delegation)**:
   - Verify `1:1` edge conservation from `wires[]` to compiled `connection def` links.
   - Confirm intra-enclosure wires connect directly inside the owning composite `part def`, while cross-enclosure wires delegate cleanly through typed bulkhead ports on every crossed composite `part def` (`Subsystem.Path.port`), with zero omitted hops or illegal cross-boundary shortcuts.
5. **Law `L5` (Series Daisy-Chain & Splitter Fidelity)**:
   - Verify every `series_daisy_hop` chain connects sequentially in `0 -> 1 -> ... -> m` order across distinct input and pass-through ports (`0` star flattening), and every `splitter_distribution_pcb` / distribution hub fans out explicitly as a modeled intermediate `part`.
6. **Law `L6` (Electrical Supply-Graph Reachability in AST)**:
   - Trace compiled `connection def` edges in `schema/model.sysml` from `energy_storage` / `self_energy_source` parts to confirm every `requires_electrical_power == true` instance has an unbroken inbound power path, including modules nested inside multi-level assemblies.
7. **Law `L7` (Formal AST Realization of Legends, Protocols, FSMs & Conflicts)**:
   - Confirm every `co_packaged_functions[]`, `protocol_and_register_contracts[]`, `state_machines_and_procedures[]`, `functional_invariants[]`, `cross_document_reconciliations[]`, and `parametric_attributes[]` entry maps to formal typed `attribute`, `item def`, `constraint def`, `requirement def` (`satisfy` / `verify` bound), `action def`, or `state def` AST nodes -- never stranded solely inside `doc /* ... */` prose comments.
   - Confirm `unconnected_or_spare_pins[]` entries are captured as formal attribute/constraint declarations without creating unconnected orphan `port` declarations.
8. **Law `L8` (Root Lifecycle `state def` & Fresh Digest Parity)**:
   - Verify the root `package` declares a top-level lifecycle `state def` with `>= 2` `state` declarations and formal `Initial` plus `Terminal` transitions.
   - Verify `.pipeline/schema-digest.json` reflects the latest `schema/model.sysml` without stale digest drift.

### Audit #2 Exit & Recompile-Before-Reaudit Loop
If `>= 1` `A2-NNN` discrepancy is found:
1. Repair `schema/model.sysml` (or fix `schema/schematic_ledger.json` if an upstream inconsistency was surfaced).
2. Re-run BOTH `./target/release/ingest-sysml ...` and `./target/release/compile-sysml --compile schema/model.sysml` (`exit 0`).
3. Dispatch a fresh text-only `TypeName="research"` Audit #2 subagent until Audit #2 reports `PASS` with `0` discrepancies.
