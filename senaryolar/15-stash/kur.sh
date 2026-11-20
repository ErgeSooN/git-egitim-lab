#!/usr/bin/env bash
# 15: half-done work on feature/profil (modified + untracked file) while main needs an urgent fix.
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 15-stash
repo_ac .
echo "<h1>GDG Düzce'ye hoş gledin</h1>" | yaz index.html
kaydet "feat: ana sayfa"

git switch -q -c feature/profil
yaz profil.html <<'HTML'
<div class="profil">
  <h2>Profil</h2>
</div>
HTML
kaydet "feat: profil sayfası iskeleti"

# half-done work, not committed
yaz profil.html <<'HTML'
<div class="profil">
  <h2>Profil</h2>
  <form>
    <input name="ad" placeholder="Adın">
HTML
echo ".profil form { display: grid; }" | yaz profil.css
hazir 15-stash "git status"
