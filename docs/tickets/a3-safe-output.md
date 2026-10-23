---
type: ticket
epic: A
title: "A3: Safe output-template resolution"
labels: ["ticket", "bug"]
priority: P1
---

## Title
Safe output-template resolution

## Summary
`spotdl`'s `{list-name}/{artists} - {title}.{output-ext}` output template resolves `{list-name}` to an empty string for single-track or manual `YouTubeURL|SpotifyURL` downloads, which turns the template into `/{artists} - {title}.{output-ext}` — an absolute path at the filesystem root, producing `Permission denied`. This was hit directly tonight downloading "Whistle" via manual pairing.

## Scope
- Detect whether a given `sdw` invocation is a playlist-context download or a single-track/manual-pairing download.
- Pass `--output "{list-name}/{artists} - {title}.{output-ext}"` only for playlist-context downloads.
- Pass `--output "{artists} - {title}.{output-ext}"` (flat, no leading empty segment) for single-track/manual-pairing downloads.

## Out of Scope
- Changing spotdl's own template engine or `create_file_name` behavior.

## Acceptance Criteria
- [ ] A playlist download still nests output under `<list-name>/`.
- [ ] A single-track or manual `YouTubeURL|SpotifyURL` download never attempts to write to filesystem root.
- [ ] Regression test covers the exact failure mode: empty `{list-name}` + manual pairing.

## Testing / Validation
- [ ] Run `sdw` against a manual `YouTubeURL|SpotifyURL` pairing and confirm the file lands in the expected flat location, not at `/`.
- [ ] Run `sdw --playlist <name>` and confirm nesting still works.

## Implementation Notes
Root cause confirmed in `spotdl/utils/formatter.py::create_file_name` — no special-casing for an empty `{list-name}` substitution; `Path()` just treats the resulting leading `/` as absolute.

## Notes / Links
Parent epic: A (Core CLI wrapper). Reproduced live tonight: `ffmpeg` error `Error opening output /Statik G, Project Pat, Pelvis Presley - Whistle.flac: Permission denied`.
