#!/usr/bin/env bash
# 04: noisy working tree (node_modules, dist, logs, .DS_Store) and a .env that was committed by mistake.
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 04-gitignore
repo_ac .
yaz index.html <<'HTML'
<h1>Uygulama</h1>
<script src="dist/app.min.js"></script>
HTML
yaz .env <<'ENV'
API_KEY=demo-1234-gizli
DB_PASSWORD=sifre123
ENV
kaydet "feat: ilk sürüm"

# the mess that should never be committed
echo "module.exports = {};" | yaz node_modules/lodash/index.js
echo '{"name":"lodash","version":"4.17.21"}' | yaz node_modules/lodash/package.json
echo "console.log('derlenmiş');" | yaz dist/app.min.js
printf '2026-11-21 10:00 INFO başladı\n2026-11-21 10:01 ERROR bağlantı yok\n' | yaz app.log
printf 'Bud1' | yaz .DS_Store
yaz .env <<'ENV'
API_KEY=demo-5678-yeni-gizli
DB_PASSWORD=sifre123
ENV
hazir 04-gitignore "git status"
