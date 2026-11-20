#!/usr/bin/env bash
# Shared helpers for the scenario setup scripts (bash 3.2 compatible: macOS, Linux, Git Bash).
set -euo pipefail

LAB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CALISMA="${LAB_CALISMA:-$LAB_DIR/calisma}"
_T=0  # fake clock (minutes) so every run produces the same commit hashes

# Fresh workspace for a scenario: calisma/<name>; cds into it.
alan_hazirla() {
  ALAN_ADI="$1"
  ALAN="$CALISMA/$1"
  rm -rf "$ALAN"
  mkdir -p "$ALAN"
  cd "$ALAN"
}

# git init with a neutral demo identity and predictable, repo-local settings.
# usage: repo_ac <dir> [name] [email]
repo_ac() {
  git init -q -b main "$1"
  git -C "$1" config user.name "${2:-Ayşe Demo}"
  git -C "$1" config user.email "${3:-ayse@ornek.dev}"
  git -C "$1" config core.autocrlf false
  git -C "$1" config commit.gpgsign false
  git -C "$1" config tag.gpgsign false
  git -C "$1" config pull.rebase false
}

# Bare repo that plays the role of GitHub.
uzak_ac() {
  git init -q --bare -b main "$1"
}

_zaman() {
  _T=$((_T + 5))
  echo "$((1794200000 + _T * 60)) +0300"
}

# Write stdin to a file (creates parent dirs).
yaz() {
  mkdir -p "$(dirname "$1")"
  cat > "$1"
}

# Stage everything and commit with a fixed timestamp. usage: kaydet "<message>"
kaydet() {
  local d
  d="$(_zaman)"
  git add -A
  GIT_AUTHOR_DATE="$d" GIT_COMMITTER_DATE="$d" git commit -q -m "$1"
}

# Same as kaydet but with another author. usage: kaydet_yazar "<name>" "<email>" "<message>"
kaydet_yazar() {
  local d
  d="$(_zaman)"
  git add -A
  GIT_AUTHOR_NAME="$1" GIT_AUTHOR_EMAIL="$2" GIT_AUTHOR_DATE="$d" \
    GIT_COMMITTER_NAME="$1" GIT_COMMITTER_EMAIL="$2" GIT_COMMITTER_DATE="$d" \
    git commit -q -m "$3"
}

# Merge with a fixed timestamp and a merge commit. usage: birlestir <branch> ["message"]
birlestir() {
  local d
  d="$(_zaman)"
  GIT_AUTHOR_DATE="$d" GIT_COMMITTER_DATE="$d" git merge -q --no-ff -m "${2:-Merge branch '$1'}" "$1"
}

# Final message printed after a scenario is ready.
# usage: hazir "<path under calisma>" "<first command>"
hazir() {
  local senaryo
  senaryo="$(basename "$(dirname "$0")")"
  echo "✅ ${senaryo} hazır"
  echo "   cd \"$CALISMA/$1\""
  if [ -n "${2:-}" ]; then echo "   ilk komut: $2"; fi
  echo "   rehber:    senaryolar/${senaryo}/README.md"
}
