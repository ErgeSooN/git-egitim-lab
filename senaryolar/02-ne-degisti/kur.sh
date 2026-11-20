#!/usr/bin/env bash
# 02: small history with a merged branch + one staged and one unstaged change (diff / log / show / blame).
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 02-ne-degisti
repo_ac .
echo "# Merhaba Git" | yaz README.md
yaz index.html <<'HTML'
<!doctype html>
<html lang="tr">
<head>
  <meta charset="utf-8">
  <title>GDG Düzce</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <h1>GDG Düzce'ye hoş gledin</h1>
  <p>Git &amp; GitHub eğitimine hoş geldin.</p>
</body>
</html>
HTML
yaz style.css <<'CSS'
body { font-family: sans-serif; margin: 40px; }
h1 { color: #1a73e8; }
CSS
kaydet "docs: README ekle"

git switch -q -c feature/iletisim
yaz iletisim.html <<'HTML'
<form>
  <input name="eposta" placeholder="E-posta">
  <button>Gönder</button>
</form>
HTML
kaydet "feat: iletişim formu ekle"
yaz iletisim.html <<'HTML'
<form class="iletisim">
  <input name="eposta" placeholder="E-posta">
  <button>Gönder</button>
</form>
HTML
echo ".iletisim { display: flex; gap: 8px; }" >> style.css
kaydet "fix: form hizalaması"

git switch -q main
yaz index.html <<'HTML'
<!doctype html>
<html lang="tr">
<head>
  <meta charset="utf-8">
  <title>GDG Düzce</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <h1>GDG Düzce'ye hoş geldin</h1>
  <p>Git &amp; GitHub eğitimine hoş geldin.</p>
</body>
</html>
HTML
kaydet "fix: başlıktaki yazım hatası"
birlestir feature/iletisim

# staged change
echo "p { line-height: 1.6; }" >> style.css
git add style.css
# unstaged change
yaz index.html <<'HTML'
<!doctype html>
<html lang="tr">
<head>
  <meta charset="utf-8">
  <title>GDG Düzce</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <h1>GDG Düzce'ye hoş geldin</h1>
  <p>Git &amp; GitHub eğitimine hoş geldin.</p>
  <a href="iletisim.html">İletişim</a>
</body>
</html>
HTML
hazir 02-ne-degisti "git status"
