#!/usr/bin/env bash
# 20: multi-author history for log -S, blame -w -C, switch -, shortlog -sn and worktree.
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 20-bonus-araclar
repo_ac proje
cd proje
AYSE="Ayşe Demo"; AYSE_M="ayse@ornek.dev"
MEHMET="Mehmet Demo"; MEHMET_M="mehmet@ornek.dev"
ZEYNEP="Zeynep Demo"; ZEYNEP_M="zeynep@ornek.dev"

echo "# Bonus araçlar" | yaz README.md
kaydet_yazar "$AYSE" "$AYSE_M" "docs: README"
yaz ayarlar.js <<'JS'
const apiKey = "demo-1234-gizli";
module.exports = { apiKey };
JS
kaydet_yazar "$AYSE" "$AYSE_M" "feat: ayarlar dosyası"
yaz yardimci.js <<'JS'
function selamla(ad) {
  return "Merhaba " + ad;
}

function formatTarih(d) {
  const gun = String(d.getDate()).padStart(2, "0");
  const ay = String(d.getMonth() + 1).padStart(2, "0");
  return gun + "." + ay + "." + d.getFullYear();
}

module.exports = { selamla, formatTarih };
JS
kaydet_yazar "$MEHMET" "$MEHMET_M" "feat: yardımcı fonksiyonlar"
yaz ayarlar.js <<'JS'
const anahtar = process.env.API_KEY;
module.exports = { anahtar };
JS
kaydet_yazar "$AYSE" "$AYSE_M" "fix: gizli apiKey'i koddan kaldır"
# move formatTarih to its own file (re-indented) -> plain blame credits Zeynep, blame -w -C finds Mehmet
yaz yardimci.js <<'JS'
function selamla(ad) {
  return "Merhaba " + ad;
}

module.exports = { selamla };
JS
yaz tarih.js <<'JS'
module.exports = {
    formatTarih(d) {
      const gun = String(d.getDate()).padStart(2, "0");
      const ay = String(d.getMonth() + 1).padStart(2, "0");
      return gun + "." + ay + "." + d.getFullYear();
    },
};
JS
kaydet_yazar "$ZEYNEP" "$ZEYNEP_M" "refactor: formatTarih'i tarih.js'e taşı"
echo "<h1>GDG Düzce</h1>" | yaz index.html
kaydet_yazar "$MEHMET" "$MEHMET_M" "feat: ana sayfa"
echo "<footer>GDG on Campus Düzce</footer>" >> index.html
kaydet_yazar "$AYSE" "$AYSE_M" "feat: footer"
git branch feature/deneme
cd ..
hazir 20-bonus-araclar/proje "git log -S \"apiKey\" --oneline"
