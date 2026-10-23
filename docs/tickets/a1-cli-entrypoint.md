---
type: ticket
epic: A
title: "A1: CLI entrypoint and spotdl subprocess wrapper"
labels: ["ticket"]
priority: P1
---

## Title
CLI entrypoint and spotdl subprocess wrapper

## Summary
Add the `sdw` Poetry entrypoint that wraps `spotdl` subprocess invocations, mirroring `gdw` in `gallery-dl-wrapper`. This is the foundation every other ticket in this repo builds on.

## Scope
- `pyproject.toml` script entrypoint (`sdw`).
- Subprocess wrapper module that shells out to `spotdl download|save|url` with consistent argument handling.
- `--dry-run` mode that prints the resolved `spotdl` command without executing it.

## Out of Scope
- Playlist registry (A2), safe output resolution (A3), retry logic (Epic B) — this ticket only wires the base subprocess call.

## Acceptance Criteria
- [ ] `poetry run sdw --dry-run <spotify-url>` prints the exact `spotdl` command it would run.
- [ ] `poetry run sdw <spotify-url>` actually invokes `spotdl` and streams its output.
- [ ] Non-zero `spotdl` exit codes propagate as non-zero `sdw` exit codes.

## Testing / Validation
- [ ] Run `sdw --dry-run` against a known playlist URL and confirm the printed command matches what would be run manually.
- [ ] Run `sdw` against a single track and confirm it downloads.

## Implementation Notes
Model directly on `gallery-dl-wrapper`'s `src/gallery_dl_wrapper/` CLI structure.

## Notes / Links
Parent epic: A (Core CLI wrapper).
