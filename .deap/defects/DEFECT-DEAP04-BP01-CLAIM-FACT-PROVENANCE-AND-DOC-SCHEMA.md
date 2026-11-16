# Defect Dossier: DEFECT-DEAP04-BP01 Missing Claim-Fact Provenance & Layer 4 Doc Schemas

## 1. Metadata
- **Defect ID**: `DEFECT-DEAP04-BP01-CLAIM-FACT-PROVENANCE-AND-DOC-SCHEMA`
- **Severity**: Critical
- **Pillar**: Test & Traceability Integrity
- **Target Component**: `gintatkinson/deap04@1db490b`:
  - `blueprints/DOCUMENT_AND_SPECIFICATION_STANDARD.md` (Sec 3.2.5 L288-297, Sec 3.4 L306-323)
  - `blueprints/VERIFY_BASELINE_BLUEPRINT.md` (Sec 3 L96-158)
  - `blueprints/SYSML_V2_SPECIFICATION.md` (Sec 2.2 L85-111, Sec 5.2 L254-268)
- **Labels**: `type::defect`, `status::open`, `safety::hazardous`, `assurance::ring1`,
  `verification::unit-test`

## 2. Normative Anchor
- **SysML QName**: `Avenger5_Verification::REQ01`..`REQ07`, `Avenger5_Safety::loss01`..`sc07`
- **Safety / Requirement Ref**: `DEAP01` Derivation-Annotation Contract & Check 23 (`aaf3d5f`)
- **Standard Clause**: ISO/IEC/IEEE 29148:2018, MIL-STD-882E, DO-178C, DO-330 `TQL-1`/`TQL-5`

## 3. Minimal Deterministic Reproducer
1. Provenance baseline and regression observed across three repository commits:
   - Historical `DEAP01` baseline (`DEAP-uas-infrastructure-safety@aaf3d5f` distributing
     `DEAP01-spec-core@3a2c687`) enforced:
     - 4-column `Derivation-Annotation Contract` (`.pipeline/constitution.md` L210,
       `skills/spec-blueprint-engineering/SKILL.md` L30-86): (1) `SSOT Input Anchor`,
       (2) `Methodology Citation`, (3) `Derivation Grade` (`Directly Evidenced`,
       `Analytically Derived`, `Declared Assumption`), (4) `Caveat` on silent sources.
     - `Check 23` Factual Grounding & Numeric Provenance Gate (`skills/spec-orchestrator/SKILL.md`).
   - Downstream Avenger 5 reproducer (`gintatkinson/uav03-tst01@fcd873a`): 6 OEM PDFs extracted
     into `docs/reference/extracted/01..05_*.md` with `<file>#p<page>` anchors and
     `GAP-01..07` caveats, and `[A5 Prep#p23]` / `[ESAD ICD#p14]` cited in
     `schema/avenger5_uas/*.sysml` `doc /* ... */` blocks.
   - Upstream compiler baseline (`gintatkinson/deap04@1db490b`):
     `blueprints/DOCUMENT_AND_SPECIFICATION_STANDARD.md` Sec 3.2.5 enforces Layer 2
     Implementation-Blindness without defining Customer Layer 4 Markdown schemas or claim-fact
     provenance contracts in Layer 1/2/3.
2. Read-only inspection commands against `gintatkinson/uav03-tst01@fcd873a` & `deap04@1db490b`:

```sh
wc -l docs/conops/TRACEABILITY_ANNEX.md
gh api "repos/gintatkinson/deap04/git/trees/HEAD?recursive=1" --jq \
  '.tree[] | select(.path | startswith("docs/")) | "\(.size)\t\(.path)"'
```

## 4. Expected vs Actual
- **Expected**: Layer 1/2 blueprints define normative Customer Layer 4 Markdown schemas and
  preserve `DEAP01`'s 4-field Derivation-Annotation Contract and Check 23 closed-world gate from
  `schema/lib/` metadata through every projected spec in `docs/`.
- **Actual**:
  - `uav03-tst01/docs/conops/TRACEABILITY_ANNEX.md` is 34 lines containing only 7 bare ID rows
    (`LAO-01 -> REQ-01 -> TEST-01`), zero OEM input anchors, zero methodology citations, zero
    derivation grades, and zero silent-source caveats.
  - All projected `uav03-tst01/docs/{conops,interfaces,safety,epics,features,use-cases}/` files
    strip `doc /* [file#pXX] */` citations except verbatim `TraceReq` lines in `USER_STORIES.md`.
  - `gintatkinson/deap04@1db490b` `docs/` outputs are stubs (`SAFETY_CASE_AND_RAAML.md` 572 B,
    `INTERFACE_CONTROL_DOCUMENT.md` 813 B, `CONOPS_BASELINE.md` 1112 B).

## 5. Root Cause & Boundary Analysis
1. **5-Whys Root Cause**:
   - **Why 1**: Projected `docs/*` in both `deap03` (`uav03-tst01`) and `deap04` lack claim-to-fact
     provenance tables and render tiny summary stubs.
   - **Why 2**: Compiler crates faithfully implemented what `blueprints/*.md` specified.
   - **Why 3**: `DOCUMENT_AND_SPECIFICATION_STANDARD.md` Sec 3.2.5 stripped templates from Layer 2
     to enforce implementation blindness, while Sec 3.4 (`docs/*`) and
     `VERIFY_BASELINE_BLUEPRINT.md` Sec 3 never restored normative Layer 4 schemas or Check 23.
   - **Why 4**: `SYSML_V2_SPECIFICATION.md` / `schema/lib/RAAML.sysml` has no structured metadata
     slots (`inputAnchor`, `methodology`, `derivationGrade`, `caveat`), leaving only free-text
     `TraceReq.rationale : Str`.
   - **Why 5 (Root Cause)**: Deletion of `DEAP01`'s Derivation-Annotation Contract and Check 23
     specification without replacement in `deap03`/`deap04` Layer 1/2 blueprints.
2. **Boundary & Invariant Violated**:
   - Layer 1->2->3->4 unidirectional refinement completeness and closed-world verification
     (`Check 23`).

## 6. Downstream Impact
- Avionics/UAS customer programs cannot audit which OEM datasheet page or engineering assumption
  backs each projected hazard, safety constraint, signal limit, or requirement in `docs/`.
- Hand-patching projected `docs/*.md` to add provenance tables is blocked by `V-DRIFT`.

## 7. Proposed Upstream Fix & Verification Test
1. **Minimal Surgical Upstream Fix (`deap04` Blueprints -> `schema/lib/` -> `crates/`)**:
   - Define normative Customer Layer 4 Markdown output schemas in a Tier-1 specification artifact
     (or dedicated `DOCUMENT_AND_SPECIFICATION_STANDARD.md` Sec 3.4 table contract) without
     violating Layer 2 implementation blindness.
   - Add first-class `@Provenance` / `@DerivationAnnotation` metadata in
     `SYSML_V2_SPECIFICATION.md` and `schema/lib/` (`inputAnchor`, `methodology`,
     `derivationGrade` enum, `caveat`).
   - Specify closed-world `Check 23` enforcement in `VERIFY_BASELINE_BLUEPRINT.md` Sec 3 and
     emit the 4 provenance columns in `TRACEABILITY_ANNEX.md` and safety/ConOps/ICD tables.
2. **TDD Regression Test & Verification Assertions**:
   - Assert projected ConOps/Safety/ICD/Traceability docs retain all `inputAnchor`, `methodology`,
     `derivationGrade`, and `caveat` fields from IR.
   - Assert `verify-baseline audit` rejects (`exit != 0`) a fixture containing a numeric envelope
     without `inputAnchor` or a `DeclaredAssumption` without a non-empty `caveat`.
