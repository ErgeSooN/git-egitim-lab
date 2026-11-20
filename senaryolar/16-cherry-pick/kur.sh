#!/usr/bin/env bash
# 16: a big unfinished branch contains one bug fix that main needs right now.
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 16-cherry-pick
repo_ac .
yaz tarih.js <<'JS'
function tarihYaz(d) {
  return d.getMonth() + "/" + d.getDate() + "/" + d.getFullYear();
}
JS
echo "<h1>Mağaza</h1>" | yaz index.html
kaydet "feat: mağaza ana sayfası"

git switch -q -c feature/buyuk-is
echo "// TODO: yeni ödeme akışı" | yaz odeme.js
kaydet "feat: yeni ödeme akışı (yarım)"
yaz tarih.js <<'JS'
function tarihYaz(d) {
  const gun = String(d.getDate()).padStart(2, "0");
  const ay = String(d.getMonth() + 1).padStart(2, "0");
  return gun + "." + ay + "." + d.getFullYear();
}
JS
kaydet "fix: tarih formatındaki hata"
echo "<h1>Ödeme</h1><!-- taslak -->" | yaz odeme.html
kaydet "feat: ödeme ekranı taslağı"
git switch -q main
hazir 16-cherry-pick "git log --oneline main..feature/buyuk-is"
