---
type: ticket
epic: B
title: "B3: Manual match override file"
labels: ["ticket"]
priority: P1
---

## Title
Manual match override file

## Summary
Tracks with no ISRC (confirmed tonight: "Zeds Dead - Pourin Rain", "Dreamers Delight - My Soul", "The Kids, 86LOVE - heathens.") consistently return zero usable search candidates from spotdl's fuzzy matching. Once the correct YouTube video is found by hand, it should never need to be re-found. `overrides.json` persists Spotify track ID -> known-good YouTube URL, and `sdw` automatically builds the `YouTubeURL|SpotifyURL` manual-pairing syntax from it.

## Scope
- `overrides.json` (repo-local, gitignored): `{ "<spotify_track_id>": "<youtube_url>" }`.
- `overrides.json.example` template.
- Before invoking `spotdl`, check each track against the override map; if present, invoke with the `YouTubeURL|SpotifyURL` pairing instead of the bare Spotify URL.
- `sdw override add <spotify_track_url> <youtube_url>` helper command to add entries without hand-editing JSON.

## Out of Scope
- Automatically discovering correct videos — overrides are always hand-supplied.

## Acceptance Criteria
- [ ] A track with an override entry downloads correctly via the paired syntax with zero manual command construction.
- [ ] `sdw override add` writes a valid entry that `sdw` immediately picks up on the next run.
- [ ] Tracks without an override entry fall through to normal spotdl search, unchanged.

## Testing / Validation
- [ ] Add override entries for the two confirmed tonight ("Whistle" -> `4PoxD6CO2j0`, "heathens." -> `m5ex0xhIyrA`) and confirm both download correctly via `sdw`.

## Notes / Links
Parent epic: B (Reliability and retry handling).
