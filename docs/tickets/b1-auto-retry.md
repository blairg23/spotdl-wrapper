---
type: ticket
epic: B
title: "B1: Auto-retry runner for transient AudioProviderError"
labels: ["ticket"]
priority: P1
---

## Title
Auto-retry runner for transient AudioProviderError

## Summary
Every `AudioProviderError: YT-DLP download error` observed tonight cleared on a bare retry (confirmed repeatedly, including `4PoxD6CO2j0`, `EZl4ZliNAzY`, `G2XDjOhYGA0`). Because spotdl's `overwrite: skip` makes reruns idempotent and cheap, this is safe to automate.

## Scope
- Wrap `spotdl download` in a retry loop (configurable max attempts, default 3).
- Only re-invoke `spotdl` on the same target (playlist or track) — never re-attempt songs that already succeeded, relying on `overwrite: skip`.
- Log each retry attempt with the failure reason.

## Out of Scope
- Retrying `LookupError` (no-match) failures — those need a manual override (B3), not a retry.

## Acceptance Criteria
- [ ] A playlist download that hits a transient `AudioProviderError` on song N succeeds without manual re-invocation.
- [ ] Retries stop after the configured max attempts and the remaining failure is surfaced clearly.
- [ ] `LookupError` failures are never retried blindly (see B2 for classification).

## Testing / Validation
- [ ] Run a playlist download large enough to statistically hit at least one transient failure and confirm it self-recovers.
- [ ] Confirm retry count is configurable and respected.

## Notes / Links
Parent epic: B (Reliability and retry handling).
