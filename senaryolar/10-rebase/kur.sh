#!/usr/bin/env bash
# 10: main moved on after two branches started. feature/ozellik rebases cleanly, feature/cakisan conflicts.
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 10-rebase
repo_ac .
yaz index.html <<'HTML'
<h1>GDG Düzce</h1>
<footer>© 2025 GDG on Campus Düzce</footer>
HTML
kaydet "feat: ana sayfa"

git switch -q -c feature/ozellik
echo "<input type=\"search\" placeholder=\"Ara\">" | yaz arama.html
kaydet "feat: arama kutusu"
echo "input[type=search] { width: 240px; }" | yaz arama.css
kaydet "style: arama kutusu"

git switch -q main
git switch -q -c feature/cakisan
yaz index.html <<'HTML'
<h1>GDG Düzce</h1>
<footer>© GDG on Campus Düzce — tüm hakları saklıdır</footer>
HTML
kaydet "feat: footer metni"

git switch -q main
yaz index.html <<'HTML'
<h1>GDG Düzce</h1>
<footer>© 2026 GDG on Campus Düzce</footer>
HTML
kaydet "fix: footer yılı"
echo "<nav><a href=\"index.html\">Ana sayfa</a></nav>" | yaz menu.html
kaydet "feat: menü"
hazir 10-rebase "git log --oneline --graph --all"
