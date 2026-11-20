# 16 · cherry-pick: tek bir commit'i al

**Slayt:** 202 · "cherry-pick: tek bir commit'i al" · **Süre:** ~4 dk

```bash
./kur.sh 16
cd calisma/16-cherry-pick
```

## Başlangıç durumu
`feature/buyuk-is` henüz bitmedi ama içinde `main`'e hemen lazım olan bir düzeltme var:
```
4d8ea40 feat: ödeme ekranı taslağı
8cd4b32 fix: tarih formatındaki hata    ← sadece bu lazım
df3768a feat: yeni ödeme akışı (yarım)
```

## Canlı demo
```bash
git log --oneline main..feature/buyuk-is
git switch main
cat tarih.js                       # ay/gün/yıl — hatalı
git cherry-pick -x 8cd4b32
cat tarih.js                       # gg.aa.yyyy — düzeldi
ls                                 # odeme.js / odeme.html YOK → sadece o commit geldi
git log -1                         # "(cherry picked from commit 8cd4b32…)"
```

## Anlatırken
- Commit'in **kopyası** oluşur (yeni SHA). `-x` mesaja kaynağını yazar → izlenebilirlik.
- Tipik kullanım: hotfix'i release branch'ine taşımak.
- Conflict olursa: çöz → `git add` → `git cherry-pick --continue` (ya da `--abort`).

## Sıfırla
`./kur.sh 16`
