#!/usr/bin/env bash
# 14: three commits were "lost" with `git reset --hard HEAD~3` (slide: reflog = Git's black box).
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 14-reflog-kurtarma
repo_ac .
echo "<h1>GDG Düzce</h1>" | yaz index.html
kaydet "feat: ana sayfa"
echo "<h1>GDG Düzce'ye hoş geldin</h1>" | yaz index.html
kaydet "fix: başlıktaki yazım hatası"
echo "<h1>İletişim</h1>" | yaz iletisim.html
kaydet "feat: iletişim sayfası"
echo "<form><input name=\"eposta\"><button>Gönder</button></form>" >> iletisim.html
kaydet "feat: form"
echo "@media (prefers-color-scheme: dark) { body { background: #202124; } }" | yaz tema.css
kaydet "feat: karanlık mod"
git reset -q --hard HEAD~3
hazir 14-reflog-kurtarma "git log --oneline"
