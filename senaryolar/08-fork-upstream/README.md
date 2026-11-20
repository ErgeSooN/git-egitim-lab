# 08 · Fork ve upstream ile senkron

**Slayt:** 101 · "Fork ile açık kaynağa katkı 🍴" · **Süre:** ~5 dk

```bash
./kur.sh 8
cd calisma/08-fork-upstream/benim-kopyam
```

## Başlangıç durumu
```
08-fork-upstream/
├── upstream.git    ← orijinal proje (bakımcının reposu)
├── fork.git        ← GitHub'daki fork'un (origin)
└── benim-kopyam/   ← fork'unun bilgisayarındaki klonu
```
Sen fork'ladıktan sonra orijinal projeye 2 yeni commit geldi; fork'un geride kaldı.

## Canlı demo
```bash
git remote -v                          # sadece origin (fork'un)
git log --oneline                      # tek commit — eskide kaldık

git remote add upstream ../upstream.git    # GitHub'da: https://github.com/orijinal/repo.git
git remote -v                          # origin + upstream
git fetch upstream
git log --oneline --all                # upstream/main 2 commit ileride
git switch main
git merge upstream/main                # fast-forward
git push                               # fork'unu da güncelle

git switch -c fix/yazim-hatasi         # katkı için branch → push → GitHub'da PR aç
```

## Anlatırken
- Fork = GitHub tarafında senin kopyan; yazma iznin olmayan projeye katkının yolu.
- `origin` = senin fork'un, `upstream` = orijinal proje. PR'ı her zaman ayrı bir branch'ten aç.
- GitHub arayüzündeki **Sync fork** düğmesi aynı işi yapar.

## Sıfırla
`./kur.sh 8`
