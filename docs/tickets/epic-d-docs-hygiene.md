---
type: epic
key: D
title: Docs and repo hygiene
labels: ["epic"]
---

## Title
Docs and repo hygiene

## Summary
Baseline documentation and CI tuning so the repo is usable by future-me without re-deriving context, matching the documentation shape already established in `gallery-dl-wrapper`.

## Scope
- README covering install, config, and run examples.
- Example config files (`config.json.example`, `playlists.json.example`, `overrides.json.example`).
- Confirm the `repo-scaffold init`-generated tox/CI gates fit this project's actual test needs.

## Out of Scope
- Any new functionality; this epic is documentation and CI tuning only.

## Acceptance Criteria
- [ ] README has install, config, and run-example sections matching `gallery-dl-wrapper`'s shape.
- [ ] All example config files exist and are referenced from the README.
- [ ] `poetry run tox` passes cleanly on a fresh clone.

## Milestones / Phases
- [ ] Phase 1: README + example configs (D1)
- [ ] Phase 2: CI/tox tuning (D2)

## Testing / Validation
- [ ] Fresh clone + `poetry install` + `poetry run tox` succeeds end to end.

## Child Tickets
- [ ] D1: README and example config files
- [ ] D2: Tune init-generated CI/tox gates

## Notes / Links
Reference: `D:\Dropbox\Projects\Software\Active\GalleryDlWrapper\src\gallery-dl-wrapper\README.md`.
