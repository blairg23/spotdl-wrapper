---
type: ticket
epic: C
title: "C3: Near-duplicate detector"
labels: ["ticket"]
priority: P3
---

## Title
Near-duplicate detector

## Summary
The "chillz dubz" folder tonight had 423 files against 343 live playlist tracks. Investigation showed this was mostly legitimate: the same recording released as two separate Spotify catalog entries with different remix credits (e.g. "Alison Wonderland - Bad Things (ShockOne Remix)" vs "Alison Wonderland, ShockOne - Bad Things - ShockOne Remix"). A detector should surface likely duplicates for review while distinguishing this legitimate case from actual accidental re-downloads.

## Scope
- Normalize artist+title (strip remix/feat formatting variance, case, punctuation) across all files in a folder.
- Group files with high normalized-title similarity and compare durations.
- Report groups as "likely duplicate" (near-identical duration) vs "same song, different release" (both present in the live playlist as distinct track IDs, per C1's snapshot).

## Out of Scope
- Automatically deleting anything.

## Acceptance Criteria
- [ ] Confirmed real duplicate pairs from tonight are correctly classified as "different release, not a bug": "Bad Things", "Thirst", "Destiny", "Loner".
- [ ] An artificially introduced true accidental duplicate (same track ID downloaded twice) is flagged as "likely duplicate."

## Testing / Validation
- [ ] Run against `chillz dubz` and confirm output matches the manual classification from tonight's investigation.

## Notes / Links
Parent epic: C (Gap analysis and auditing). Depends on C1's playlist snapshot to distinguish legitimate catalog duplicates from accidental re-downloads.
