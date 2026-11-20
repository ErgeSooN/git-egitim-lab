#!/usr/bin/env bash
# 18: v1.0.0 and v1.1.0 exist; a fix and a feature were added since -> next version is v1.2.0 ("Karanlık mod").
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 18-tag-release
uzak_ac origin.git
repo_ac proje
cd proje
git remote add origin ../origin.git
echo "<h1>GDG Düzce</h1>" | yaz index.html
kaydet "feat: ana sayfa"
GIT_COMMITTER_DATE="$(_zaman)" git tag -a v1.0.0 -m "İlk sürüm"
echo "<nav>Menü</nav>" | yaz menu.html
kaydet "feat: menü"
GIT_COMMITTER_DATE="$(_zaman)" git tag -a v1.1.0 -m "Menü"
git push -q origin main --follow-tags
echo "<nav><a href=\"index.html\">Menü</a></nav>" | yaz menu.html
kaydet "fix: menü bağlantısı"
echo "@media (prefers-color-scheme: dark) { body { background: #202124; } }" | yaz tema.css
kaydet "feat: karanlık mod"
cd ..
hazir 18-tag-release/proje "git describe --tags"
