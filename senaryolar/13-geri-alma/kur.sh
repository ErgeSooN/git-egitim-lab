#!/usr/bin/env bash
# 13: four commits (the last one is junk) + one unstaged and one staged change: restore / reset / revert / amend.
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 13-geri-alma
repo_ac .
yaz index.html <<'HTML'
<h1>GDG Düzce</h1>
<p>Etkinlik: Git & GitHub</p>
<p>Tarih: 2 Aralık</p>
HTML
kaydet "feat: ana sayfa"
echo "<nav><a href=\"index.html\">Ana sayfa</a></nav>" | yaz menu.html
kaydet "feat: menü"
echo "<footer>GDG on Campus Düzce</footer>" | yaz footer.html
kaydet "feat: footer"
echo "console.log('DEBUG: buraya geldi');" | yaz app.js
kaydet "chore: debug logları"

# unstaged: a line deleted by accident
yaz index.html <<'HTML'
<h1>GDG Düzce</h1>
<p>Tarih: 2 Aralık</p>
HTML
# staged: an unwanted style change
echo "h1 { color: red; font-size: 80px; }" | yaz style.css
git add style.css
hazir 13-geri-alma "git status"
