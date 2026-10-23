---
type: epic
key: A
title: Core CLI wrapper
labels: ["epic"]
---

## Title
Core CLI wrapper

## Summary
`spotdl-wrapper` needs a thin, repo-local Python CLI (`sdw`) that shells out to `spotdl` with safe defaults, mirroring the shape of `gallery-dl-wrapper`'s `gdw` command. Raw `spotdl` usage tonight required hand-constructing `--output` overrides and pasting full URLs on every invocation; a named playlist registry and a safe default output resolver remove both of those friction points.

## Scope
- Poetry-managed CLI entrypoint that wraps `spotdl` subprocess calls.
- Repo-local `playlists.json` registry mapping short names to Spotify playlist URLs + target folder names.
- Output-template resolution that never produces spotdl's `{list-name}` empty-string root-path bug.

## Out of Scope
- Any spotdl matching/search logic changes (spotdl itself is not forked or modified).
- Non-Spotify sources.

## Acceptance Criteria
- [ ] `sdw --playlist <name>` runs a full playlist download without the caller specifying `--output` manually.
- [ ] `sdw <spotify-track-url>` (single track) never triggers spotdl's root-path write bug.
- [ ] `playlists.json.example` documents the registry format.

## Milestones / Phases
- [ ] Phase 1: CLI skeleton + playlist registry (A1, A2)
- [ ] Phase 2: Safe output resolution (A3)

## Testing / Validation
- [ ] Manual run against a real Spotify playlist URL.
- [ ] Manual run against a single track / manual `YouTubeURL|SpotifyURL` pairing, confirming no root-path error.

## Child Tickets
- [ ] A1: CLI entrypoint + spotdl subprocess wrapper
- [ ] A2: Playlist registry config
- [ ] A3: Safe output-template resolution

## Notes / Links
Reference implementation shape: `D:\Dropbox\Projects\Software\Active\GalleryDlWrapper\src\gallery-dl-wrapper`.
