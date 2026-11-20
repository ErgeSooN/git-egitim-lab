# 03 · İyi commit: küçük, tek amaçlı, iyi mesajlı

**Slayt:** 101 · "İyi commit nasıl olur?" · 202 · "Conventional Commits" · **Süre:** ~7 dk

```bash
./kur.sh 3
cd calisma/03-iyi-commit
```

## Başlangıç durumu
Kötü mesajlarla dolu bir geçmiş:
```
a23dd1a bir sürü şey değişti
f3dfb1e son hali
4c43bdc asdasd
fb407c9 fix
```
Commit'lenmemiş **üç ayrı iş** bekliyor:
1. `index.html` başındaki yazım hatası (`Eğtimi` → `Eğitimi`)
2. `index.html` sonuna eklenen **İletişim** bölümü
3. `README.md`'deki kurulum adımları

## Canlı demo
```bash
git log --oneline              # "6 ay sonra kimse ne olduğunu bilmez — sen dahil"
git status
git diff                       # üç iş tek yığın hâlinde

git add -p index.html          # 1. parça (başlık): y   ·   2. parça (iletişim): n
git commit -m "fix: başlıktaki yazım hatası"

git add index.html
git commit -m "feat: iletişim bölümü ekle"

git add README.md
git commit -m "docs: kurulum adımlarını ekle"

git log --oneline              # önce/sonra karşılaştır
```

## Anlatırken
- **Atomik commit:** bir commit = bir mantıksal değişiklik. Geri almak (`revert`) ve incelemek kolaylaşır.
- `git add -p`: dosyanın sadece bir kısmını sahneye al (`y` evet, `n` hayır, `s` parçayı böl, `q` çık).
- Conventional Commits: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`… → otomatik changelog ve sürüm numarası.

## Sıfırla
`./kur.sh 3`
