# Claude Code Project Guidelines

## Upstream Toolchain & Downstream Perimeter Context
- **Upstream Provenance**: `gintatkinson/deap03@e75d23d412fa88f5ecc9683c0615c3303d43bf00` (`stage-10-complete`, Ferrocene `stable-26.08.0` via `criticalup.toml`).
- **Perimeter Role**: `downstream-consumer` (`N_up_src == 0`, zero symlinks, pure 7-bit LF ASCII on governed files).
- **Signed Release Manifest & Key**: `.deap/update-manifest.json` (SHA-256 `1243abcb151f276806ea96b01e77b671e3eed03b4c8e1653fa5bd5baee8b3619`) verified against Tier-2 `Ed25519` public key `606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b`.
- **Native Skills & Reference Corpus**: 12 modernized engineering skills reside in real non-symlink directories at `.agents/skills/<skill-name>/SKILL.md` (entry point: `.agents/skills/spec-orchestrator/SKILL.md`). Customer reference PDFs/datasheets live under `docs/reference/` (tracked with `docs/reference/.gitkeep`) and extracted ground-truth Markdown tables live under `docs/reference/extracted/`.

## Workflow & Quality Gates
- Follow project governance in `AGENTS.md`, `.agents/skills/project-constitution/SKILL.md`, `downstream-profiles/README.md`, `downstream-profiles/DOWNSTREAM_INSTALLATION_AND_CI_GUIDE.md`, and the target sub-bundles in `downstream-profiles/{profile-dart-flutter-hmi,profile-target-app-runtime,profile-non-rust-targets}/`.
- Strict Planning Gate: Do not execute unauthorized modifications without an approved implementation plan.
- Keep shell code blocks free of `#` comment lines for interactive `zsh` compatibility.
- Verify signed `0x60` `UpdateManifest` and `B_5` binaries: `./.deap/bin/verify-baseline verify-manifest --workspace . --manifest .deap/update-manifest.json --bundle-dir .deap/bin --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b`.
- Execute downstream perimeter, ASCII, and `schema/` gate (`--schema-scope lib-only` for template baseline, or `--schema-scope all` once `schema/<domain>/` is populated): `./.deap/bin/verify-baseline perimeter --workspace . --perimeter-role downstream-consumer --schema-scope lib-only --manifest .deap/update-manifest.json --bundle-dir .deap/bin --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b`.
- Seal SysML v2 / RAAML v1 canonical IR snapshot: `./.deap/bin/ingest-sysml seal --workspace . --schema-dir schema --out-snapshot .deap/ir.snapshot.bin`.
- Assemble ConOps & Mission Intent projections: `./.deap/bin/assemble-conops project --workspace . --snapshot .deap/ir.snapshot.bin --out-dir docs/conops --receipt .deap/conops.receipt.json`.
- Compile SysML v2 safety artifacts and `#![no_std]` contracts (always overriding default `crates/deap-contracts/` to prevent `DEAP_E0104`): `./.deap/bin/compile-sysml build --workspace . --snapshot .deap/ir.snapshot.bin --conops-receipt .deap/conops.receipt.json --out-docs docs --out-contracts crates/mission-contracts/src/generated --out-kani verification/mission-kani/src/generated --receipt .deap/compile.receipt.json`.
- Reconcile Agile/WBS backlog specifications and 3-way Merkle state: `./.deap/bin/reconcile-backlog project --workspace . --snapshot .deap/ir.snapshot.bin --docs-dir docs --schema-dir schema --provider offline` and `./.deap/bin/reconcile-backlog sync --workspace . --snapshot .deap/ir.snapshot.bin --docs-dir docs --schema-dir schema --provider offline`.
