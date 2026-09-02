---
type: ticket
epic: A
title: "A2: Playlist registry config"
labels: ["ticket"]
priority: P2
---

## Title
Playlist registry config (playlists.json)

## Summary
Let the user run `sdw --playlist gummy-trapz` instead of pasting the full Spotify playlist URL every time, mirroring `sites.json` in `gallery-dl-wrapper`.

## Scope
- `playlists.json` (repo-local, gitignored) mapping short names to `{ "url": "...", "folder": "..." }`.
- `playlists.json.example` template.
- `--playlist <name>` CLI flag that resolves to the registered URL and target folder.

## Out of Scope
- Auto-discovering the user's Spotify playlists via the API (manual registration only, for now).

## Acceptance Criteria
- [ ] `sdw --playlist gummy-trapz` resolves to the correct URL and output folder without the user specifying either.
- [ ] Unknown playlist names produce a clear error listing the registered names.
- [ ] `playlists.json` is gitignored; `playlists.json.example` is committed.

## Testing / Validation
- [ ] Register a real playlist name and confirm `sdw --playlist <name>` downloads to the correct folder.
- [ ] Confirm an unregistered name fails with a helpful error instead of a raw exception.

## Notes / Links
Parent epic: A (Core CLI wrapper). Format mirrors `gallery-dl-wrapper`'s `sites.json`.
