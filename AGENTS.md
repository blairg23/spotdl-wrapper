# AGENTS.md -- spotdl-wrapper

Agent workflow guide. Read this before touching anything.

---

## Branch naming

Format: `type/NNN-short-description`

- `type`: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`
- `NNN`: the GitHub issue number -- create the issue first if one does not exist
- `short-description`: kebab-case, 3-4 words max

Examples: `feat/42-user-auth`, `fix/88-crash-on-load`, `docs/17-api-reference`

`main` is the only long-lived branch. Never reuse a branch after its PR has merged.

---

## PR titles

Format: `type(scope): description (#NNN)`

Example: `feat(auth): add OAuth login flow (#42)`

The issue number at the end is required so the PR is immediately traceable to its ticket.

---

## Workflow rules

- Create a GitHub issue before starting work so you have the `NNN` for the branch name.
- Always use the PR template (`.github/pull_request_template.md`) -- no freeform bodies.
- Always use the issue templates (`.github/ISSUE_TEMPLATE/ticket.md` or `epic.md`).
- After creating an issue, add it to the `spotdl-wrapper Roadmap` project board.
- Never merge or close PRs -- push the branch, open the PR, stop there.
- Never push new commits to a branch whose PR is already merged -- cut a fresh branch from main.

---

## Git identity

Before your first commit, confirm `git config user.name` and `git config user.email` are
set to real values (not `Your Name` / `you@example.com`). If they are placeholders, stop
and ask the user to configure them before continuing.

---

## Commit messages

Format: subject line (imperative mood) + blank line + body.

- Subject: 50 chars max, no trailing period
- Body: explain WHY the change is needed, not what it does (the diff shows what)
- No one-liner commits for non-trivial changes

---

## Project context

- If `.repo-scaffold/project.json` exists, it is the canonical GitHub Project metadata for this repo.
- Planning markdown lives wherever you keep it; point repo-scaffold at it with `--source` or `GITHUB_TICKETS_DIR` in `.env`.
- Imported backlog JSON lives in `local/<owner>/<repo>/backlog.json` (gitignored).
- `GH_REPO` (set in `.env`) is the canonical repo identity for this workspace (e.g. `owner/repo`).

---

## GitHub Projects v2 auth

For GitHub Projects v2 commands, use the `ghp` shell alias or the explicit form:

```bash
GH_TOKEN=$GH_PROJECT_TOKEN gh ...
```

`GH_PROJECT_TOKEN` is a classic PAT with `project` scope. Set it in `.env`.
