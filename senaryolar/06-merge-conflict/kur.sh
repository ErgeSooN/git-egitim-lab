#!/usr/bin/env bash
# 06: main and feature/baslik changed the same line -> conflict on merge (slide: "Merge conflict — ilk karşılaşma").
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 06-merge-conflict
repo_ac .
yaz index.html <<'HTML'
<!doctype html>
<html lang="tr">
<body>
<h1>Hoş geldin</h1>
<p>Git & GitHub eğitimi</p>
</body>
</html>
HTML
kaydet "feat: ana sayfa"

git switch -q -c feature/baslik
yaz index.html <<'HTML'
<!doctype html>
<html lang="tr">
<body>
<h1>Topluluğumuza hoş geldiniz</h1>
<p>Git & GitHub eğitimi</p>
</body>
</html>
HTML
echo "h1 { font-size: 48px; }" | yaz style.css
kaydet "feat: başlığı topluluğa göre güncelle"

git switch -q main
yaz index.html <<'HTML'
<!doctype html>
<html lang="tr">
<body>
<h1>GDG Düzce'ye hoş geldin!</h1>
<p>Git & GitHub eğitimi</p>
</body>
</html>
HTML
kaydet "feat: başlığa GDG Düzce ekle"
hazir 06-merge-conflict "git merge feature/baslik"
