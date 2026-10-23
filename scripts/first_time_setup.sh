#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
ENV_EXAMPLE="$REPO_ROOT/.env.example"
ENV_FILE="$REPO_ROOT/.env"
CLAUDE_DIR="$REPO_ROOT/.claude"
CLAUDE_SETTINGS_FILE="$CLAUDE_DIR/settings.local.json"
PAT_PLACEHOLDER="<classic-PAT>"

pick_shell_rc() {
  local shell_name
  shell_name="$(basename "${SHELL:-bash}")"
  case "$shell_name" in
    zsh) printf '%s
' "$HOME/.zshrc" ;;
    *) printf '%s
' "$HOME/.bashrc" ;;
  esac
}

upsert_env_line() {
  local file="$1"
  local pattern="$2"
  local replacement="$3"
  local tmp

  tmp="$(mktemp)"
  if [ -f "$file" ]; then
    grep -v -E "$pattern" "$file" > "$tmp" || true
  fi
  printf '%s
' "$replacement" >> "$tmp"
  mv "$tmp" "$file"
}

echo "Repo-scaffold first-time GitHub Projects setup"
echo
echo "This script will:"
echo "  1) ensure .env exists"
echo "  2) set export GH_PROJECT_TOKEN=..."
echo "  3) set GH_TOKEN=... for repo-scaffold compatibility"
echo "  4) write .claude/settings.local.json"
echo "  5) optionally append a ghp alias to your shell rc"
echo

if [ ! -f "$ENV_FILE" ]; then
  if [ -f "$ENV_EXAMPLE" ]; then
    cp "$ENV_EXAMPLE" "$ENV_FILE"
    echo "Created $ENV_FILE from .env.example"
  else
    : > "$ENV_FILE"
    echo "Created empty $ENV_FILE"
  fi
fi

read -r -p "Classic PAT for GitHub Projects v2 (leave blank to keep placeholder): " PROJECT_TOKEN
if [ -z "$PROJECT_TOKEN" ]; then
  PROJECT_TOKEN="$PAT_PLACEHOLDER"
fi

read -r -p "Repo-scaffold GH_TOKEN (leave blank to reuse the project token): " REPO_TOKEN
if [ -z "$REPO_TOKEN" ]; then
  REPO_TOKEN="$PROJECT_TOKEN"
fi

upsert_env_line "$ENV_FILE" '^(export[[:space:]]+)?GH_PROJECT_TOKEN=' "export GH_PROJECT_TOKEN=$PROJECT_TOKEN"
upsert_env_line "$ENV_FILE" '^GH_TOKEN=' "GH_TOKEN=$REPO_TOKEN"
echo "Updated $ENV_FILE"

mkdir -p "$CLAUDE_DIR"
cat > "$CLAUDE_SETTINGS_FILE" <<EOF
{
  "env": {
    "GH_PROJECT_TOKEN": "$PROJECT_TOKEN"
  }
}
EOF
echo "Wrote $CLAUDE_SETTINGS_FILE"

RC_FILE="$(pick_shell_rc)"
ALIAS_LINE="alias ghp='GH_TOKEN=$PROJECT_TOKEN gh'"
read -r -p "Append ghp alias to $RC_FILE? [y/N] " APPEND_ALIAS
case "$APPEND_ALIAS" in
  [yY]|[yY][eE][sS])
    touch "$RC_FILE"
    if ! grep -Fqx "$ALIAS_LINE" "$RC_FILE"; then
      printf '
%s
' "$ALIAS_LINE" >> "$RC_FILE"
      echo "Appended ghp alias to $RC_FILE"
    else
      echo "ghp alias already present in $RC_FILE"
    fi
    ;;
  *)
    echo "Skipped shell alias update."
    ;;
esac

echo
echo "Next steps:"
echo "  source $RC_FILE"
echo "  ghp project list --owner YOUR_OWNER"
echo "  GH_TOKEN=$PROJECT_TOKEN gh project item-list <PROJECT_NUMBER> --owner YOUR_OWNER"
echo
echo "For project board commands in WSL / Claude Code, use ghp or direct GH_TOKEN=... gh ... commands."
echo "Do not rely on GH_TOKEN=\$GH_PROJECT_TOKEN gh ... in this environment."
