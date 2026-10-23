---
type: ticket
epic: D
title: "D2: Tune init-generated CI/tox gates"
labels: ["ticket"]
priority: P3
---

## Title
Tune init-generated CI/tox gates

## Summary
`repo-scaffold init` generates baseline `tox.ini`/CI workflows (lint, type, coverage). Confirm they fit this project's actual test needs once the core CLI (Epic A) and reliability logic (Epic B) exist to test against.

## Scope
- Review generated `tox.ini` lint/type/coverage environments against actual project structure.
- Adjust the coverage threshold if the default doesn't fit early-stage test coverage.
- Confirm `poetry run tox -e precommit` passes on a clean checkout.

## Out of Scope
- Adding new CI providers or deployment pipelines.

## Acceptance Criteria
- [ ] `poetry run tox` passes cleanly.
- [ ] `poetry run pre-commit run --all-files` passes cleanly.

## Testing / Validation
- [ ] Fresh clone, `poetry install`, `poetry run tox`.

## Notes / Links
Parent epic: D (Docs and repo hygiene). Should land after Epic A/B have enough surface area to actually test.
