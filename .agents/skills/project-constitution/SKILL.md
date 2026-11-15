---
name: project-constitution
description: "Defines the sovereign deap03 two-tier downstream governance constitution: schema/ SSOT primacy (V-DRIFT), zero symlinks, N_up_src == 0, pure 7-bit LF ASCII, signed .deap/bin governance, and lazy on-demand downstream-profiles/ loading."
compatibility: "Applies to all agents and workflows operating inside downstream deap03 repositories."
metadata:
  title: "Downstream Project Constitution (deap03 Sovereign Governance)"
  category: governance
  risk: low
  source: custom
  version: "3.0"
---

# Downstream Project Constitution (`deap03`)

This constitution establishes the non-negotiable two-tier governance rules for downstream customer repositories powered by the signed `deap03` `B_5` toolchain in `./.deap/bin/`.

## Architecture: Two-Tier Sovereign Separation

1. **Tier 1 -- Functional Specification Layer (SSOT & Platform-Independent)**:
   - Authoritative model inputs: `docs/reference/` (OEM PDFs, datasheets, ICDs, pure-ASCII extraction tables in `docs/reference/extracted/`) and `docs/catalogs/` / `docs/research/`.
   - Canonical compiler SSOT: `schema/lib/{ISQ,RAAML}.sysml` (immutable foundation libraries) and customer domain packages under `schema/<domain>/*.sysml`.
   - Compiler projections (read-only outputs, never hand-edited): `docs/conops/{CONOPS,MISSION_INTENT}.md`, `docs/interfaces/`, `docs/safety/`, `docs/epics/`, `docs/features/`, `docs/user-stories/`, `docs/use-cases/`, `docs/agile/`, `docs/annex/`, `crates/mission-contracts/src/generated/`, and `verification/mission-kani/src/generated/`.
2. **Tier 2 -- Platform Implementation Profiles (`downstream-profiles/`, Lazy On-Demand)**:
   - `downstream-profiles/README.md` & `DOWNSTREAM_INSTALLATION_AND_CI_GUIDE.md` (build, FFI, CI).
   - `downstream-profiles/profile-dart-flutter-hmi/` (`app_flutter/` Ring-3 HMI & `include/deap_ffi.h`).
   - `downstream-profiles/profile-target-app-runtime/` (dynamic metadata & zero-mocking SQLite persistence).
   - `downstream-profiles/profile-non-rust-targets/` (MATLAB/Simulink/Stateflow/Embedded Coder, SCADE, SPARK Ada, MISRA C/C++, AADL, FMI).

## Non-Negotiable Constitutional Mandates

1. **SSOT Primacy & `V-DRIFT` Zero-Drift Mandate**: All requirement, safety, ICD, ConOps, and contract updates originate in `schema/<domain>/*.sysml` (grounded by `docs/reference/extracted/*.md`). Hand-editing generated `docs/` projections or generated Rust contracts is strictly forbidden.
2. **Signed `B_5` Trust Anchor (`VK_REL`)**: Only execute `.deap/bin/{ingest-sysml,assemble-conops,compile-sysml,reconcile-backlog,verify-baseline}` attested by `.deap/update-manifest.json` against `VK_REL = 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b`.
3. **Downstream `compile-sysml` Path Lock (`DEAP_E0104`)**: Every `compile-sysml` command MUST pass `--out-contracts crates/mission-contracts/src/generated --out-kani verification/mission-kani/src/generated`. Never target `crates/deap-*`.
4. **Zero Upstream Leakage & Retired Paths (`N_up_src == 0`)**: Strictly forbid `blueprints/`, `crates/deap-*`, `bins/...`, `tools/dylint-deap/`, `.pipeline/`, root `rules/`, root `skills/`, `scripts/*.py`, `parity_auditor/`, and `target/release/`.
5. **Real Native Skill Directories & Zero Symlinks (`DEAP_E0102`)**: Native Antigravity skills live as regular files inside real directories under `.agents/skills/<skill-name>/SKILL.md`. Symbolic links anywhere outside `.git/` fail `verify-baseline perimeter` fail-closed.
6. **Pure 7-Bit LF ASCII (`DEAP_E0103` / `DEAP_E0530`)**: All `.md`, `.yml`, `.yaml`, and `.sysml` governed artifacts MUST use bytes `0x20..=0x7E` + `0x0A` only (zero tabs, zero CR, zero UTF-8 smart quotes, em/en dashes, arrows, or Greek glyphs). Defect dossiers under `.deap/defects/*.md` MUST also stay `<= 100` columns/line and use the exact 7 ordered headings (`DEAP_E0525`).
7. **Interactive `zsh` Command Safety**: Never embed bare `#` comment lines inside copy-pasteable shell snippets; explain commands in prose before the code block.
8. **Human Plan Approval & Subagent Context Isolation**: Obtain explicit human approval on `implementation_plan.md` before workspace mutations, dispatch fresh context-isolated workers for multi-item extraction/implementation, verify TDD + clean builds + live persistence, never use `fix #` / `close #` auto-closing keywords in commits, and keep `origin` synchronized.

## Constitutional Verification Gate Commands

Verify cryptographic manifest parity, baseline audit closure, downstream perimeter compliance, and deterministic POSIX Git hooks prior to committing:

```sh
./.deap/bin/verify-baseline verify-manifest --workspace . --manifest .deap/update-manifest.json --bundle-dir .deap/bin --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b && echo "MANIFEST: PASS"
./.deap/bin/verify-baseline audit --workspace . && echo "AUDIT: PASS"
./.deap/bin/verify-baseline perimeter --workspace . --perimeter-role downstream-consumer --schema-scope all --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b && echo "PERIMETER_ALL: PASS"
./.deap/bin/verify-baseline setup-hooks --workspace . --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b && echo "FULL_SSOT_HOOKS: PASS"
```
