# spotdl-wrapper

[![codecov](https://codecov.io/gh/blairg23/spotdl-wrapper/graph/badge.svg)](https://codecov.io/gh/blairg23/spotdl-wrapper)

Created by [repo-scaffold](https://github.com/your-org/repo-scaffold).

## Enabled languages

- python

## Setup

### Python

```bash
python -m venv .venv
source .venv/bin/activate
pip install -e .[dev]
```

## Git hooks

```bash
python -m pip install pre-commit
pre-commit install
pre-commit run --all-files
```

For parity with CI quality gates, pre-commit also runs `tox -e precommit`.
If formatters or fixers change tracked files, the hook exits non-zero so you can re-stage and rerun the commit intentionally.
The fast pre-commit gate also enforces the Python coverage threshold when Python is enabled.

## Day-to-day commands

### Python

```bash
tox -e format
ruff check .
black --check .
mypy src
pytest
tox -e lint,type,coverage
tox -e coverage
tox -e precommit
tox -e codecov-upload
export CODECOV_TOKEN=your_codecov_token
tox -e codecov-upload
```

CI runs the same Python quality matrix via tox (`lint`, `type`, `coverage`).
Run `tox -e coverage` to generate `coverage.xml` and `htmlcov/` locally.
The current minimum coverage gate is 70%.
If `CODECOV_TOKEN` is already present in `.env`, you can run `tox -e codecov-upload` directly.
If you prefer an explicit shell export, set `CODECOV_TOKEN` and then run `tox -e codecov-upload`.

## Convenience targets

Optional wrappers are provided in `Makefile`: `make format`, `make lint`, `make typecheck`, `make test`, `make build`.

## Repo-scaffold GitHub workflow

- Keep repo planning markdown in a directory of your choice; point repo-scaffold at it with `--source` or `GITHUB_TICKETS_DIR` in `.env`.
- The canonical repo project metadata file is `.repo-scaffold/project.json` once a project has been created or synced.
- `AGENTS.md` tells local agents to treat `GH_REPO` and `.repo-scaffold/project.json` as the repo-local GitHub context.
- Prefer `gh auth login` or an OS-backed credential manager for local GitHub auth; use `.env` only when you intentionally want token-based local scripting.
- Run `./scripts/first_time_setup.sh` once to wire the local GitHub Projects v2 token, Claude Code settings, and the `ghp` shell alias for WSL workflows.

### GitHub Projects v2 auth for WSL / Claude Code

```bash
./scripts/first_time_setup.sh
source ~/.bashrc  # or ~/.zshrc
ghp project list --owner YOUR_OWNER
GH_TOKEN=<classic-PAT> gh project item-list <PROJECT_NUMBER> --owner YOUR_OWNER
```

- `.env.example` includes `export GH_PROJECT_TOKEN=<classic-PAT>` because child processes need the export prefix.
- `.claude/settings.local.json` is local-only and gives Claude Code the same project token context.
- For direct `gh project ...` calls in WSL/Claude, prefer `ghp ...` or `GH_TOKEN=<classic-PAT> gh ...`.
- Do not rely on `GH_TOKEN=$GH_PROJECT_TOKEN gh ...` for project board commands in this environment.

## GitHub templates included

- `.github/ISSUE_TEMPLATE/epic.md`
- `.github/ISSUE_TEMPLATE/ticket.md`
- `.github/pull_request_template.md`
