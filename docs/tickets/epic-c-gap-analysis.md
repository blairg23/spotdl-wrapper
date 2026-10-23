---
type: epic
key: C
title: Gap analysis and auditing
labels: ["epic"]
---

## Title
Gap analysis and auditing

## Summary
Tonight's session ended with manual "why do I have 423 files when the playlist has 343 tracks" and "why is one song missing" investigations, done by hand with ad hoc shell commands. This epic automates that auditing: comparing the live Spotify playlist against on-disk files, and flagging likely wrong-match downloads (like the "heathens." mismatch) before the user has to notice by ear.

## Scope
- Gap report comparing `spotdl save` playlist metadata against on-disk files per playlist folder.
- Duration-mismatch check between Spotify's known track duration and the downloaded file's actual duration.
- Near-duplicate detector that flags likely accidental re-downloads, while not flagging legitimate duplicate catalog entries (e.g. two official releases of the same remix with different credited artists).

## Out of Scope
- Automatically deleting anything. All checks in this epic are read-only/report-only.
- Fixing the underlying spotdl matching issues (that's Epic B).

## Acceptance Criteria
- [ ] Running the gap report against a playlist folder lists exactly which tracks are missing on disk.
- [ ] The duration-mismatch check flags a known-bad example (e.g. a wrong-match download) without flagging correct downloads.
- [ ] The duplicate detector distinguishes real duplicate catalog entries (confirmed example: "Alison Wonderland - Bad Things (ShockOne Remix)" vs "Alison Wonderland, ShockOne - Bad Things - ShockOne Remix") from accidental re-downloads.

## Milestones / Phases
- [ ] Phase 1: Gap report (C1)
- [ ] Phase 2: Duration-mismatch flagger (C2)
- [ ] Phase 3: Near-duplicate detector (C3)

## Testing / Validation
- [ ] Run the gap report against a playlist with a known missing track and confirm it's reported.
- [ ] Run the duplicate detector against the `chillz dubz` folder and confirm it doesn't flag the confirmed-legitimate remix-credit pairs.

## Child Tickets
- [ ] C1: Playlist gap report
- [ ] C2: Duration-mismatch flagger
- [ ] C3: Near-duplicate detector

## Notes / Links
Confirmed real example of a legitimate (non-bug) duplicate pair found tonight: two separate Spotify catalog releases of the same recording with different remix-credit formatting.
