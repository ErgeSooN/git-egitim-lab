#!/usr/bin/env bash
# 17: 60 commits; somewhere a "refactor" broke the VAT calculation. test.sh tells good from bad.
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 17-bisect
repo_ac .
yaz hesap.sh <<'SH'
#!/usr/bin/env bash
# Prints the basket total including 20% VAT (prices in kuruş).
toplam=0
while read -r urun fiyat; do toplam=$((toplam + fiyat)); done < fiyatlar.txt
echo $((toplam * 120 / 100))
SH
yaz test.sh <<'SH'
#!/usr/bin/env bash
# Exit 0 = good, 1 = bad (used by `git bisect run`).
beklenen=72000
sonuc="$(bash hesap.sh)"
if [ "$sonuc" = "$beklenen" ]; then echo "✅ toplam doğru: $sonuc"; exit 0; fi
echo "❌ toplam yanlış: $sonuc (beklenen $beklenen)"; exit 1
SH
printf 'kalem 10000\ndefter 20000\nçanta 30000\n' | yaz fiyatlar.txt
chmod +x hesap.sh test.sh
echo "# Sepet hesaplayıcı" | yaz README.md
kaydet "feat: sepet toplamı (KDV dahil)"
git tag -a v1.0 -m "İlk sürüm"

i=2
while [ $i -le 60 ]; do
  if [ $i -eq 41 ]; then
    yaz hesap.sh <<'SH'
#!/usr/bin/env bash
# Prints the basket total including 20% VAT (prices in kuruş).
toplam=0
while read -r urun fiyat; do toplam=$((toplam + fiyat)); done < fiyatlar.txt
echo $((toplam + toplam / 10 * 2 / 2))
SH
    kaydet "refactor: KDV hesabını sadeleştir"
  else
    echo "- değişiklik $i" >> NOTLAR.md
    kaydet "docs: not $i"
  fi
  i=$((i + 1))
done
hazir 17-bisect "bash test.sh"
