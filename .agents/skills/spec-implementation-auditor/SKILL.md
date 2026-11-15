---
name: spec-implementation-auditor
description: "Runs disjoint DO-330 TQL-5 baseline, V-QUANT, V-TRACE, V-DRIFT, and downstream perimeter audits using ./.deap/bin/verify-baseline and verifies specification-to-code coverage against crates/mission-contracts/src/generated."
compatibility: "Requires ./.deap/bin/verify-baseline, ./.deap/bin/ingest-sysml, and cargo."
metadata:
  title: "Specification & TQL-5 Independent Baseline Auditor"
  category: auditing
  risk: low
  source: custom
  version: "3.0"
---

# Specification & `DO-330 TQL-5` Independent Baseline Auditor

Use this skill to perform independent, read-only `DO-330 TQL-5` verification across `schema/`, projected `docs/`, `crates/mission-contracts/src/generated/`, `verification/mission-kani/src/generated/`, and downstream application code (Rust crates, ROS2/PX4 nodes, Dual-Track MBD models, or `app_flutter/`).

## When to Use This Skill vs `debug-protocol` / `adversarial-code-auditor`

- Use **this skill** to execute independent baseline/perimeter gates (`verify-baseline audit`, `hygiene`, `perimeter`) and audit whether generated `#![no_std]` contracts and downstream code match the sealed IR snapshot without drift (`V-DRIFT`, `V-QUANT`, `V-TRACE`).
- Use `debug-protocol` to isolate and fix specific deterministic `DEAP_E0xxx` diagnostics or runtime failures.
- Use `adversarial-code-auditor` when performing red-team safety/boundary/memory audits or issuing 7-section `DEAP_E0525` Defect Dossiers under `.deap/defects/`.

## Step 1: Mandatory Cryptographic & `TQL-5` Gate Verification

Verify the signed `0x60` release manifest, run the independent baseline audit, run hygiene checks, and verify downstream zero-source perimeter compliance (`--schema-scope lib-only` before domain schemas exist; `--schema-scope all` once `schema/<domain>/` is populated):

```sh
./.deap/bin/verify-baseline verify-manifest --workspace . --manifest .deap/update-manifest.json --bundle-dir .deap/bin --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b && echo "MANIFEST: PASS"
./.deap/bin/verify-baseline audit --workspace . --schema-dir schema --docs-dir docs --snapshot .deap/ir.snapshot.bin && echo "AUDIT: PASS"
./.deap/bin/verify-baseline perimeter --workspace . --perimeter-role downstream-consumer --schema-scope all --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b && echo "PERIMETER_ALL: PASS"
```

When a Cargo workspace exists in the downstream project, also verify workspace hygiene and build parity:

```sh
./.deap/bin/verify-baseline hygiene --workspace . --perimeter-role downstream-consumer --schema-scope all && echo "HYGIENE: PASS"
```

## Step 2: `V-DRIFT`, `V-QUANT` & `V-TRACE` Codebase Audit Checklist

Dispatch context-isolated read-only `research` subagents as needed to audit:

1. **Spec-to-IR Parity (`V-DRIFT`)**: Confirm zero manual edits inside `docs/conops/{CONOPS,MISSION_INTENT}.md`, `docs/interfaces/`, `docs/safety/`, `docs/epics/`, `docs/features/`, `docs/user-stories/`, `docs/use-cases/`, `crates/mission-contracts/src/generated/`, and `verification/mission-kani/src/generated/`.
2. **Quantitative Margin Provenance (`V-QUANT`)**: Cross-check numeric limits in `schema/<domain>/*.sysml` against `docs/reference/extracted/*.md` (`<pdf>#p<page>` citations) and curated `docs/catalogs/*.md`, flagging any ungrounded number or negative margin (`dt`, `wcetS`, `maxLatencyS`, `E_reserve`, `pCatBound`, `PhaseMarginEff`).
3. **Triad Traceability (`V-TRACE`)**: Confirm 100% closure across `Hazard` -> `SafetyConstraint` -> `Requirement` (`@TraceReq`) -> `VerificationTestCase` (`@VerificationTest`) -> Rust implementation symbols (annotated via `compile-sysml inject-docstrings`) and tests/Kani proofs.
4. **Live Persistence & Non-Mocking**: For runtime targets under `app_flutter/` or mission Rust crates, verify live SQLite/register/telemetry binding per `downstream-profiles/profile-target-app-runtime/PERSISTENCE_ARCHITECTURE_BLUEPRINT.md` with zero production mocks.
5. **Perimeter & ASCII Integrity**: Verify zero symbolic links (`find . -not -path './.git*' -type l` empty), zero forbidden paths (`blueprints/`, `crates/deap-*`, `.pipeline/`, `rules/`, root `skills/`, `scripts/*.py`, `target/release/`), and pure 7-bit LF ASCII (`0x20..=0x7E` + `0x0A`) on all governed artifacts.

## Step 3: Reporting & Remediation Routing

- Report exact observed CLI outputs, hashes, coverage counts, and missing traceability links with clickable workspace-relative file/line references.
- Route any codebase gap or spec mismatch to `feature-driven-implementation` (new feature work), `debug-protocol` (defects), or `adversarial-code-auditor` (confirmed toolchain/boundary defects requiring a `.deap/defects/*.md` dossier).
