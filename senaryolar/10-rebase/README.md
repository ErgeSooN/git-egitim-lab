# 10 · Rebase (temiz ve çakışmalı)

**Slayt:** 202 · "Rebase: commit'leri yeni bir tabana taşı", "Merge mi, rebase mi?" · **Süre:** ~8 dk

```bash
./kur.sh 10
cd calisma/10-rebase
```

## Başlangıç durumu
```
* ff2d006 (feature/cakisan) feat: footer metni
| * e8a79ca (feature/ozellik) style: arama kutusu
| * cf7212c feat: arama kutusu
|/
| * 954d56a (HEAD -> main) feat: menü
| * 31bd196 fix: footer yılı
|/
* ff7b93e feat: ana sayfa
```
- `feature/ozellik` farklı dosyalara dokunuyor → temiz rebase.
- `feature/cakisan` ile `main` footer satırını farklı değiştirdi → rebase'de conflict.

## Canlı demo
```bash
git log --oneline --graph --all
git switch feature/ozellik
git rebase main                    # commit'ler main'in ucuna taşındı
git log --oneline --graph --all    # doğrusal geçmiş; SHA'lar değişti (cf7212c → yeni SHA)

git switch feature/cakisan
git rebase main                    # CONFLICT in index.html
git status                         # "rebase in progress"
# index.html'i çöz → ör. <footer>© 2026 GDG on Campus Düzce — tüm hakları saklıdır</footer>
git add index.html
git rebase --continue              # editör açılırsa kaydet-kapat
# vazgeçmek için: git rebase --abort
git log --oneline --graph --all
```

## Anlatırken
- Rebase commit'leri **yeniden yazar** (yeni SHA) → sadece kendi, paylaşılmamış branch'inde yap.
- Paylaşılmış branch'i rebase ettiysen push için `git push --force-with-lease` (asla düz `--force`).
- Kural: kendi feature branch'ini güncel tutmak için rebase, `main`'e almak için PR (merge/squash).

## Sıfırla
`./kur.sh 10`
