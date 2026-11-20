#!/usr/bin/env bash
# 05: two feature branches: one can fast-forward, the other needs a merge commit.
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 05-branch-merge
repo_ac .
yaz index.html <<'HTML'
<h1>GDG Düzce</h1>
<nav><a href="index.html">Ana sayfa</a></nav>
HTML
kaydet "feat: ana sayfa iskeleti"

git switch -q -c feature/iletisim
echo "<h1>İletişim</h1>" | yaz iletisim.html
kaydet "feat: iletişim sayfası"
echo "form { display: grid; gap: 8px; }" | yaz iletisim.css
kaydet "style: iletişim formu düzeni"

git switch -q main
git switch -q -c feature/footer
echo "<footer>GDG on Campus Düzce · 2026</footer>" | yaz footer.html
kaydet "feat: footer ekle"

git switch -q main
hazir 05-branch-merge "git branch"
