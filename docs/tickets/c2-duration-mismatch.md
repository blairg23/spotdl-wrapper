---
type: ticket
epic: C
title: "C2: Duration-mismatch flagger"
labels: ["ticket"]
priority: P2
---

## Title
Duration-mismatch flagger

## Summary
The "heathens." mismatch tonight (wrong video downloaded under a plausible-looking title) went undetected until manually inspected. Spotify's track metadata includes an authoritative duration; comparing it against the actual downloaded audio file's duration is a cheap, automatable sanity check for wrong-match downloads.

## Scope
- Read Spotify's known duration from `spotdl save` metadata (or embedded file tags, if present).
- Read the actual duration of each downloaded audio file (via `ffprobe` or a Python audio-metadata library).
- Flag files where the delta exceeds a configurable threshold (default: 5 seconds).

## Out of Scope
- Automatically re-downloading or fixing flagged mismatches (surfaced for manual review + B3 override, not auto-corrected).

## Acceptance Criteria
- [ ] Running the check against a folder with one known wrong-match file flags it.
- [ ] Correct downloads (matching duration within threshold) are not flagged.
- [ ] Threshold is configurable.

## Testing / Validation
- [ ] Run against `gummy trapz` folder (contains the confirmed correct "Whistle" download) and confirm no false positive.

## Notes / Links
Parent epic: C (Gap analysis and auditing). Would have caught the "heathens." mismatch immediately instead of requiring a manual screenshot + debug trace.
