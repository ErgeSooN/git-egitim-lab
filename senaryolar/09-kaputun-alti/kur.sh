#!/usr/bin/env bash
# 09: small repo with a subfolder to explore commit/tree/blob objects, refs and detached HEAD.
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 09-kaputun-alti
repo_ac .
echo "# Kaputun altı" | yaz README.md
echo "console.log('merhaba');" | yaz src/app.js
kaydet "feat: ilk sürüm"
echo "body { margin: 0; }" | yaz src/stil.css
kaydet "feat: stil dosyası"
echo "console.log('merhaba git');" | yaz src/app.js
kaydet "fix: karşılama mesajı"
git branch feature/deneme HEAD~1
hazir 09-kaputun-alti "git cat-file -p HEAD"
