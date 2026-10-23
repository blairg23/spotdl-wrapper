---
type: ticket
epic: C
title: "C1: Playlist gap report"
labels: ["ticket"]
priority: P2
---

## Title
Playlist gap report

## Summary
Tonight's "48/49" and "423 vs 343" investigations were done with ad hoc `find`/`ls` commands across WSL and Windows paths. Automate the comparison: snapshot the live Spotify playlist via `spotdl save`, compare track list against on-disk files in the target folder, and report exactly what's missing.

## Scope
- `sdw gap-report --playlist <name>` (or `--url <spotify-playlist-url>`).
- Snapshot playlist metadata with `spotdl save --save-file`.
- Match each track to an on-disk file by normalized artist+title; report unmatched tracks as "missing."
- Summary output: `N/M tracks present`, followed by a list of missing track names.

## Out of Scope
- Automatically downloading missing tracks (that's just `sdw --playlist <name>` again, already covered by Epic A/B).

## Acceptance Criteria
- [ ] Running the report against a playlist with one known-missing track lists exactly that track as missing.
- [ ] Report handles playlists with legitimate duplicate catalog entries without misreporting them as missing/extra.

## Testing / Validation
- [ ] Run against a playlist snapshot from tonight's session with a known gap and confirm the report matches manual findings.

## Notes / Links
Parent epic: C (Gap analysis and auditing).
