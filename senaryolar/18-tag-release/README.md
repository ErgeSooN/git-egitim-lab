# 18 · Tag, Release ve SemVer

**Slayt:** 202 · "Tag, Release ve SemVer 🏷️" · **Süre:** ~5 dk

```bash
./kur.sh 18
cd calisma/18-tag-release/proje
```

## Başlangıç durumu
`origin.git` "GitHub"ı temsil eder. `v1.0.0` ve `v1.1.0` push edilmiş; sonrasında bir **fix** ve bir **feat** geldi.
```
6bc90e6 (HEAD -> main) feat: karanlık mod
eb5bb83 fix: menü bağlantısı
9fc5ba3 (tag: v1.1.0, origin/main) feat: menü
5f3e066 (tag: v1.0.0) feat: ana sayfa
```

## Canlı demo
```bash
git tag                            # v1.0.0 v1.1.0
git describe --tags                # v1.1.0-2-g6bc90e6 → son tag'den 2 commit sonra
git log --oneline v1.1.0..HEAD     # fix + feat → SemVer: MINOR artar → v1.2.0
git tag -a v1.2.0 -m "Karanlık mod"
git show v1.2.0                    # annotated tag: yazar, tarih, mesaj
git tag deneme                     # lightweight tag: sadece bir etiket (karşılaştır)
git tag -l "v1.*"
git push origin v1.2.0             # ya da: git push --follow-tags
git ls-remote --tags origin
git tag -d deneme
```

## Anlatırken
- **MAJOR.MINOR.PATCH:** geriye uyumsuz → MAJOR · yeni özellik → MINOR · hata düzeltmesi → PATCH.
- Release'lerde annotated tag kullan (`-a`); `--follow-tags` sadece annotated tag'leri gönderir.
- GitHub'da tag'den Release oluştur → **Generate release notes** (Conventional Commits ile çok daha okunaklı).

## Sıfırla
`./kur.sh 18`
