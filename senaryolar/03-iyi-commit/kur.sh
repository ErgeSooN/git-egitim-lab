#!/usr/bin/env bash
# 03: a history with bad commit messages + mixed changes to split with `git add -p`.
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 03-iyi-commit
repo_ac .
yaz README.md <<'MD'
# Etkinlik sayfası

Kurulum: dosyayı tarayıcıda aç.
MD
yaz index.html <<'HTML'
<!doctype html>
<html lang="tr">
<head>
  <meta charset="utf-8">
  <title>Etkinlik</title>
</head>
<body>
  <h1>Git & GitHub Eğtimi</h1>
  <p>Tarih: 2 Aralık</p>
  <p>Yer: Online</p>

  <section id="program">
    <h2>Program</h2>
    <ul>
      <li>101 — temeller</li>
      <li>202 — ileri seviye</li>
    </ul>
  </section>

  <section id="konusmaci">
    <h2>Konuşmacı</h2>
    <p>Ali Eren Yaman</p>
  </section>

  <footer>GDG on Campus Düzce</footer>
</body>
</html>
HTML
kaydet "fix"
echo "body { font-family: sans-serif; }" | yaz style.css
kaydet "asdasd"
echo "h1 { color: #1a73e8; }" >> style.css
kaydet "son hali"
echo "footer { margin-top: 40px; color: #5f6368; }" >> style.css
echo "Katılım ücretsiz." >> README.md
kaydet "bir sürü şey değişti"

# Uncommitted work that really is three separate changes:
#  1) typo fix at the top of index.html   2) new section at the bottom   3) README docs
yaz index.html <<'HTML'
<!doctype html>
<html lang="tr">
<head>
  <meta charset="utf-8">
  <title>Etkinlik</title>
</head>
<body>
  <h1>Git & GitHub Eğitimi</h1>
  <p>Tarih: 2 Aralık</p>
  <p>Yer: Online</p>

  <section id="program">
    <h2>Program</h2>
    <ul>
      <li>101 — temeller</li>
      <li>202 — ileri seviye</li>
    </ul>
  </section>

  <section id="konusmaci">
    <h2>Konuşmacı</h2>
    <p>Ali Eren Yaman</p>
  </section>

  <section id="iletisim">
    <h2>İletişim</h2>
    <p>Sorular için: duzce@gdg.ornek</p>
  </section>

  <footer>GDG on Campus Düzce</footer>
</body>
</html>
HTML
yaz README.md <<'MD'
# Etkinlik sayfası

## Kurulum
1. Repoyu klonla
2. `index.html` dosyasını tarayıcıda aç

Katılım ücretsiz.
MD
hazir 03-iyi-commit "git log --oneline"
