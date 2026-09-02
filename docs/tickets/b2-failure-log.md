---
type: ticket
epic: B
title: "B2: Structured failure log (--save-errors based)"
labels: ["ticket"]
priority: P2
---

## Title
Structured failure log (--save-errors based)

## Summary
Raw `spotdl` failure output mixes transient `AudioProviderError` and permanent `LookupError` lines together, forcing manual triage every time (exactly what happened tonight with the "gap analysis nightmare" comment). Parse `--save-errors` output into a categorized, structured log so B1's retry loop and B3's override workflow can consume it programmatically.

## Scope
- Invoke `spotdl` with `--save-errors <path>` on every run.
- Parse the resulting file into `{ song, reason: "transient" | "no-match", raw_line }` records.
- Persist a running JSON log (`state/failures.json`) so failures are visible across runs, not just the last one.

## Out of Scope
- Any retry/override logic itself (B1, B3 consume this log; this ticket only produces it).

## Acceptance Criteria
- [ ] After a run with failures, `state/failures.json` contains one categorized entry per failed song.
- [ ] `AudioProviderError` lines are categorized `transient`; `LookupError` lines are categorized `no-match`.
- [ ] Successive runs update (not duplicate) existing entries for the same song.

## Testing / Validation
- [ ] Force both failure types in a test run and confirm correct categorization.

## Notes / Links
Parent epic: B (Reliability and retry handling). Real examples tonight: `AudioProviderError: YT-DLP download error - https://www.youtube.com/watch?v=7TPRkgLYqvA` (transient) vs `LookupError: No results found for song: Zeds Dead - Pourin Rain` (no-match).
