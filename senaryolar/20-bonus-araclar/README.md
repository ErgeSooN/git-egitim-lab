# 20 · Bonus araç çantası: log -S, blame -C, switch -, shortlog, worktree

**Slayt:** 202 · "Bonus araç çantası 🧰" · **Süre:** ~6 dk

```bash
./kur.sh 20
cd calisma/20-bonus-araclar/proje
```

## Başlangıç durumu
Üç yazarlı (Ayşe, Mehmet, Zeynep) bir geçmiş:
- Bir zamanlar koda gizli `apiKey` yazılmış, sonra kaldırılmış.
- Mehmet'in yazdığı `formatTarih`, Zeynep tarafından girintisi değiştirilerek `tarih.js`'e taşınmış.

## Canlı demo
```bash
git log -S "apiKey" --oneline
# 25c5c6b fix: gizli apiKey'i koddan kaldır
# d6573ca feat: ayarlar dosyası          ← sızıntı burada başladı

git blame tarih.js                 # her satır Zeynep'in gibi görünüyor (taşıma + girinti)
git blame -w -C tarih.js           # -w boşlukları, -C taşımayı görmezden gelir → asıl yazar Mehmet

git switch feature/deneme
git switch -                       # bir önceki branch'e dön (cd - gibi)

git shortlog -sn HEAD              # 4 Ayşe · 2 Mehmet · 1 Zeynep

git worktree add -b hotfix/acil ../hotfix main   # ikinci çalışma klasörü, aynı repo
ls ../hotfix && git worktree list
git worktree remove ../hotfix
```

## Anlatırken
- `log -S` "bu metin ne zaman girdi/çıktı?" — sızan anahtarın ilk commit'ini bulmak için ideal.
- `blame -w -C`: refactor sonrası "bunu kim yazdı?" sorusunun dürüst cevabı.
- `worktree`: stash'e alternatif — acil iş için yarım işini bozmadan ayrı klasörde çalış.

## Sıfırla
`./kur.sh 20`
