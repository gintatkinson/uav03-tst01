# SysML v2 Compiler Surface Grammar & CLI Contracts

This reference specifies the domain-neutral SysML v2 surface grammar accepted by `./target/release/compile-sysml --compile` and `./target/release/ingest-sysml`, along with the exact CLI contracts and compiler invariants required for Law `L8` closed-loop synthesis.

All constructs below are 100% domain-neutral (Check 19 compliant) and empirically verified against the compiled Tier-0 binaries.

---

## 1. Verified Domain-Neutral SysML v2 Surface Grammar

### 1.1 Complete Compilable Reference Model

The example below compiles with `exit 0` under `./target/release/compile-sysml --compile`. Notice that every `part <usage> : <PartDef>` inside `IntegratedSystemRoot` resolves to an explicitly declared `part def` (`PrimarySegmentEnclosure`, `SecondarySegmentEnclosure`), and every `connect` statement resolves to declared ports:

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
            satisfy requirement REQ_SC_01;
        }
        part def LeafControllerUnit {
            attribute controllerClockHz : Real = 100.0;
            port in dcRailIn : RegulatedDcInPort;
        }
        part def PrimarySegmentEnclosure {
            port out bulkheadPowerOut : RegulatedDcOutPort;
            connection def CONN_INT_01 {
                connect regulator.dcRailOut to controller.dcRailIn;
            }
            connection def CONN_BULKHEAD_01 {
                connect regulator.dcRailOut to bulkheadPowerOut;
            }
            part regulator : PowerRegulatorUnit {}
            part controller : LeafControllerUnit {}
        }
        part def SecondarySegmentEnclosure {
            port in bulkheadPowerIn : RegulatedDcInPort;
            connection def CONN_BULKHEAD_02 {
                connect bulkheadPowerIn to secondaryController.dcRailIn;
            }
            part secondaryController : LeafControllerUnit {}
        }
    }
}
```

---

### 1.2 Construct-by-Construct Grammar & Empirically Verified Compiler Rules

1. **Packages & File Header**:
   - File header: `doc /* <summary> */`
   - Root container: `package <UpperCamelCase> { ... }`
   - Nested domain packages: `package <UpperCamelCase> { ... }`
2. **State Machines (`state def`)**:
   - Declare states: `state <Identifier>;`
   - Declare transitions:
     - Initial transition: `transition <Name> first Initial then <State>;`
     - Triggered/guarded transition: `transition <Name> first <FromState> accept <TriggerId> [if <GuardId>] then <ToState>;`
     - Terminal transition: `transition <Name> first <State> then Terminal;`
   - Law `L8` requires a top-level `state def` directly inside the root `package` containing `>= 2` states plus explicit `Initial` and `Terminal` transitions.
3. **Parts, Containment & Optional `0..1` Cardinality (`part def`, `part`)**:
   - Classifier definition: `part def <UpperCamelCase> { ... }`
   - Child usage inside composite `part def`: `part <lowerCamelCase> : <PartDef> { ... }`
   - Every `part <usage> : <PartDef>` MUST reference an existing `part def <PartDef>` in the model; otherwise `compile-sysml --compile` fails (`exit 1`) with `Part '<usage>' references undefined type '<PartDef>'`.
   - **Verified Multiplicity Rule**: Trailing multiplicity brackets on `part` usages (e.g., `part slot : Unit [0..1] {}`) break port/type resolution in `compile-sysml --compile` (`undefined target port`). Instead, model `0..1` cardinality and unpopulated production options using typed attributes on the `part` usage plus an explicit `constraint def`:
     ```sysml
     part optionalSlot : OptionalAssembly {
         attribute multiplicity : String = "0..1";
         attribute populatedInProduction : Boolean = false;
     }
     ```
4. **Typed Single-Domain Ports (`port def`, `port`)**:
   - Port definition:
     ```sysml
     port def <UpperCamelCase> {
         attribute direction = "in" | "out" | "inout";
         attribute itemType = "<ItemDefName>";
         attribute protocol = "<IF_ID>";
     }
     ```
   - Port usage inside `part def`: `port <in|out|inout> <lowerCamelCase> : <PortDef>;`
   - Per Law `L3`, every port carries a single domain and directionality with zero hybrid multi-bus ports.
5. **Connections & Bulkhead Delegation (`connection def`, `connect`)**:
   - Peer-to-peer inside an enclosing `part def`:
     `connection def <CONN_ID> { connect <partA>.<portOut> to <partB>.<portIn>; }`
   - Bulkhead pass-through between an inner child part and the enclosing `part def`'s own boundary port:
     `connection def <CONN_ID> { connect <childPart>.<port> to <ownBulkheadPort>; }`
     or
     `connection def <CONN_ID> { connect <ownBulkheadPort> to <childPart>.<port>; }`
   - **Verified Path-Depth Rule**: `compile-sysml --compile` resolves only 1-level `<childPart>.<port>` and enclosing `<ownBulkheadPort>` references. Multi-segment dotted paths (e.g., `inner.leaf.port`) fail (`exit 1`) with `undefined source port` / `undefined target port`. Cross-enclosure routing MUST delegate step-by-step through declared boundary ports on each traversed enclosure `part def` (Law `L4`).
6. **Payload & Signal Definitions (`item def`)**:
   - `item def <UpperCamelCase> { attribute <name> : <Real|Integer|Boolean|String> = <literal>; }`
7. **Typed Attributes (`attribute`)**:
   - Supported primitive types: `Real` (`12.0`), `Integer` (`2`), `Boolean` (`true` / `false`), `String` (`"..."`).
   - May appear inside `part def`, `part` usages, `item def`, `port def`, `requirement def`, and `constraint def`.
8. **Behavioral Actions & Interactions (`action def`, `interaction def`, `capability def`)**:
   - `action def <UpperCamelCase>(in <param> : <Type>, out <param> : <Type>);`
   - `interaction def <Name> {}`
   - `capability def <Name>;`
9. **Constraints & Negative Exclusions (`constraint def`, `assert constraint`)**:
   - Formal parametric invariant:
     ```sysml
     constraint def <UpperCamelCase> {
         in <param> : <Type> && attribute invariantExpr : String = "<boolean_expr>";
     }
     ```
   - Negative exclusion assertion:
     ```sysml
     assert constraint assert_exclusion_<slug> {
         !exists(<ForbiddenEntity>);
     }
     ```
10. **Requirements, Safety Links, Use Cases & Test Cases**:
    - `requirement def <REQ_ID> { doc /* ... */ text = "..."; attribute ...; @TriggersHazard("..."); @SafetyRealises("..."); }`
    - `satisfy requirement <REQ_ID>;` inside the realizing `part def` (note: package-level `satisfy requirement X by Y;` is normalized to `satisfy requirement X;` during canonical serialization, so nesting `satisfy requirement <REQ_ID>;` inside `part def` keeps the implementing part binding explicit).
    - `use case def <UC_ID> { subject <PartDef>; actor <ActorName>; objective "..."; }`
    - `test case def <TC_ID> { subject <PartDef>; verify requirement <REQ_ID>; objective "..."; step <stepIdentifier>; }`

---

## 2. `./target/release/ingest-sysml` CLI Contract

Version verified: `ingest-sysml 0.1.0`

### 2.1 Usage & Options

```text
Usage: ingest-sysml [OPTIONS]

Options:
      --source <source>
  -s, --schema <schema>
      --package <package>
  -f, --format <format>                            [default: auto]
      --language <language>                        [default: auto]
  -o, --out <out>                                  [default: .pipeline/schema.sysml]
  -d, --digest <digest>                            [default: .pipeline/schema-digest.json]
      --allowed-parts <allowed_parts>
      --negative-invariants <negative_invariants>
      --cache-ast
  -h, --help                                       Print help
  -V, --version                                    Print version
```

### 2.2 Gate Semantics & Critical Filtering Behavior

- **`--allowed-parts <comma_separated_PartDefs>`**:
  - Verifies architectural scope: exits `2` (`ERROR: Architectural scope verification failed: none of the --allowed-parts {...} matched any extracted PartDef in package '...'`) if none match.
  - **Important AST Side-Effect**: When `--allowed-parts` is supplied, `ingest-sysml` filters its emitted `--out` `.sysml` file down to only listed `part def`s and **strips `part` usages and `item def`s** from the written `--out` file. If any composite enclosure `part def` is omitted from `--allowed-parts`, it is pruned from the ingested AST.
- **`--negative-invariants <comma_separated_ForbiddenNames>`**:
  - Verifies exclusion invariants: exits `2` (`ERROR: Architectural negative-invariant violation: forbidden entity '<Name>' exists in package '...'`) if any forbidden entity appears in the parsed model.
  - When satisfied, injects `assert constraint assert_exclusion_<name> { !exists(<Name>); }` into the root package of `--out`.
- **Mandatory Two-Step Invocation Order (Law `L8`)**:
  1. Run `./target/release/ingest-sysml --schema schema/model.sysml --allowed-parts "<all_enclosure_and_leaf_part_defs>" --negative-invariants "<excluded_names>"` first as the architectural scope and negative-invariant gate (`exit 0`).
  2. Run `./target/release/compile-sysml --compile schema/model.sysml` immediately afterward so `.pipeline/schema.sysml` and `.pipeline/schema-digest.json` are regenerated cleanly with all `part` usages, `item def`s, and `connection def`s intact.

---

## 3. `./target/release/compile-sysml --compile` CLI Contract

### 3.1 Usage & Options

```text
Usage: compile-sysml [OPTIONS] [FILE]

Arguments:
  [FILE]  Path to input .sysml file

Options:
      --schema <SCHEMA_FILE>                       Path to schema file or directory (default searches schema/*.sysml)
      --compile                                    Run the Pipeline 0 compilation gate: parse, validate semantics, serialize, and emit digest
      --docs <docs>                                Path to documentation directory [default: docs/]
      --out <out>                                  Path to output schema model file [default: .pipeline/schema.sysml]
      --digest <digest>                            Path to output schema digest JSON [default: .pipeline/schema-digest.json]
      --force                                      Force overwrite of existing files / bypass landing zone guard
      --dry-run                                    Simulate synchronization without writing changes to disk
  -h, --help                                       Print help
```

Note: `compile-sysml` also provides downstream projection/sync flags (`--stpa-transpile`, `--stpa`, `--reverse-sync`, `--forward-sync`, `--inject-safety-docstrings`, `--extract-source`, `--export-mbd`, `--slice-package`, `--emit-flutter-contracts`, `--emit-modular-rust`, `--out-dir`, `--scoring-config`). Those flags are out of scope for Pipeline 0 schematic ingestion (`--compile` only).

### 3.2 Compilation Gate Contract & Digest Output

- **Command**:
  ```bash
  ./target/release/compile-sysml --compile schema/model.sysml
  ```
- **Success (`exit 0`)**:
  - Prints: `Successfully compiled SysML schema '<stem>' to '<out>' (SHA-256: <64-char-hex>, <N> elements)`
  - Emits canonicalized SysML v2 AST to `--out` (default `.pipeline/schema.sysml`).
  - Emits AST digest JSON to `--digest` (default `.pipeline/schema-digest.json`) containing:
    - `sha256`, `total_lines`
    - `node_counts` (`action_defs`, `attribute_defs`, `calc_defs`, `capability_defs`, `connection_defs`, `constraint_defs`, `containers`, `groupings`, `hazard_defs`, `identities`, `interaction_defs`, `item_defs`, `leaves`, `lists`, `operation_defs`, `packages`, `part_defs`, `port_defs`, `requirement_defs`, `risk_defs`, `state_defs`, `test_case_defs`, `typedefs`, `use_case_defs`)
    - `schema_nodes[]` (sorted AST identifier list)
    - `operational_activities[]`, `operational_exchanges[]` (`source_port`, `target_port`, `source_part`, `target_part`), `operational_scenarios[]`, `operational_nodes[]`, `file_manifest[]`
- **Failure (`exit 1`)**:
  - Prints `Error: Semantic validation error: ...` whenever a `part` usage references an undeclared `part def` or a `connection def` references an undeclared source/target port.
  - Note: In `node_counts`, `part_defs` counts both `part def` definitions and `part` usages, and `port_defs` counts both `port def` definitions and `port` usages.
- **Re-Compile Rule**: Always re-run both `ingest-sysml` and `compile-sysml --compile schema/model.sysml` after any edit to `schema/model.sysml` prior to Blind Audit #2.
