#!/usr/bin/env bash
# Builds the demo repos under calisma/.
#   ./kur.sh            list scenarios
#   ./kur.sh 6          (re)build scenario 06 from scratch
#   ./kur.sh 6 7 10     several at once
#   ./kur.sh hepsi      all of them
set -euo pipefail
LAB_DIR="$(cd "$(dirname "$0")" && pwd)"

liste() {
  echo "Senaryolar (./kur.sh <no>):"
  for d in "$LAB_DIR"/senaryolar/*/; do
    n="$(basename "$d")"
    baslik="$(head -1 "$d/README.md" | sed 's/^# //')"
    printf '  %s\n' "$baslik"
  done
}

kur_bir() {
  local no d
  no="$(printf '%02d' "$((10#$1))")"
  d="$(ls -d "$LAB_DIR"/senaryolar/"$no"-* 2>/dev/null | head -1 || true)"
  if [ -z "$d" ]; then echo "Senaryo bulunamadı: $1" >&2; exit 1; fi
  bash "$d/kur.sh"
}

case "${1:-liste}" in
  liste|-h|--help) liste ;;
  hepsi)
    for d in "$LAB_DIR"/senaryolar/*/; do bash "$d/kur.sh"; echo; done ;;
  *)
    for n in "$@"; do kur_bir "$n"; echo; done ;;
esac
