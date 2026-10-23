---
type: ticket
epic: D
title: "D1: README and example config files"
labels: ["ticket"]
priority: P3
---

## Title
README and example config files

## Summary
Document install, config, and run examples so the repo is usable without re-deriving context, matching `gallery-dl-wrapper`'s README shape.

## Scope
- README sections: Requirements, Install, Config (`config.json`, `playlists.json`, `overrides.json`), Repo layout, Run examples.
- `config.json.example`, `playlists.json.example`, `overrides.json.example`.

## Out of Scope
- Any new functionality.

## Acceptance Criteria
- [ ] README covers first-time setup end to end (clone -> install -> configure -> first run).
- [ ] Every config file referenced in the README has a corresponding `.example` file.

## Testing / Validation
- [ ] Follow the README from a clean checkout and confirm every step works as written.

## Notes / Links
Parent epic: D (Docs and repo hygiene). Reference: `gallery-dl-wrapper`'s README.
