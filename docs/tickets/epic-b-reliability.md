---
type: epic
key: B
title: Reliability and retry handling
labels: ["epic"]
---

## Title
Reliability and retry handling

## Summary
Every `AudioProviderError` hit during tonight's debugging session was transient (YouTube throttling) and cleared on a bare retry, but nothing retries automatically today. Separately, `LookupError: No results found` (tracks with no ISRC) requires a manual `YouTubeURL|SpotifyURL` pairing that currently has to be re-discovered from scratch every time. This epic makes both failure modes self-healing or at least self-remembering.

## Scope
- Automatic retry loop for transient download errors, relying on spotdl's own `overwrite: skip` to make reruns idempotent and cheap.
- Structured, categorized failure log (transient vs. no-match) built from `--save-errors`.
- Persistent manual-match override file so a hand-found correct video is never re-diagnosed twice.

## Out of Scope
- Changing spotdl's internal matching/scoring algorithm.
- Automatically guessing replacement videos for `LookupError` tracks (still requires a human to find the correct video once).

## Acceptance Criteria
- [ ] A single `sdw` invocation retries transient failures without the user re-running commands by hand.
- [ ] Failure output clearly distinguishes "will retry automatically" from "needs a manual override."
- [ ] Once a track has an entry in `overrides.json`, it downloads correctly on every future run with zero extra input.

## Milestones / Phases
- [ ] Phase 1: Auto-retry runner (B1)
- [ ] Phase 2: Structured failure log (B2)
- [ ] Phase 3: Manual override file (B3)

## Testing / Validation
- [ ] Simulate a transient failure and confirm the retry loop recovers without manual intervention.
- [ ] Add an override entry for a known `LookupError` track and confirm it downloads on the next run.

## Child Tickets
- [ ] B1: Auto-retry runner for transient AudioProviderError
- [ ] B2: Structured failure log (--save-errors based)
- [ ] B3: Manual match override file

## Notes / Links
Real examples from tonight: `Statik G, Project Pat, Pelvis Presley - Whistle` and `The Kids, 86LOVE - heathens.` both required manual `YouTubeURL|SpotifyURL` pairing after repeated `LookupError`s.
