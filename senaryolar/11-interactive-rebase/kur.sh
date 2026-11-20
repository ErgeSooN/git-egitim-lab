#!/usr/bin/env bash
# 11: a feature branch with messy commits (slide: profil kartı / wip / typo düzelt / karanlık mod).
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 11-interactive-rebase
repo_ac .
echo "<h1>GDG Düzce</h1>" | yaz index.html
kaydet "feat: ana sayfa"

git switch -q -c feature/profil
yaz profil.html <<'HTML'
<div class="kart">
  <h2>Ayşe Demo</h2>
</div>
HTML
kaydet "feat: profil kartı"
yaz profil.html <<'HTML'
<div class="kart">
  <h2>Ayşe Demo</h2>
  <p>Fronted geliştirici</p>
</div>
HTML
kaydet "wip"
yaz profil.html <<'HTML'
<div class="kart">
  <h2>Ayşe Demo</h2>
  <p>Frontend geliştirici</p>
</div>
HTML
kaydet "typo düzelt"
echo "@media (prefers-color-scheme: dark) { body { background: #202124; color: #e8eaed; } }" | yaz tema.css
kaydet "feat: karanlık mod"
hazir 11-interactive-rebase "git log --oneline main..feature/profil"
