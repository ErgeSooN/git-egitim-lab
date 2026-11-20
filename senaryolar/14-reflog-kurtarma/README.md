# 14 · reflog ile kayıp commit'leri kurtarmak

**Slayt:** 202 · "reflog: Git'in kara kutusu ✈️" · **Süre:** ~5 dk

```bash
./kur.sh 14
cd calisma/14-reflog-kurtarma
```

## Başlangıç durumu
Senaryo: biri `git reset --hard HEAD~3` yaptı, 3 commit'lik emek "gitti".
```
$ git log --oneline
a445ae8 fix: başlıktaki yazım hatası
5f3e066 feat: ana sayfa
```

## Canlı demo
```bash
git log --oneline                  # iletişim, form, karanlık mod yok!
ls                                 # tema.css, iletisim.html yok
git reflog
# a445ae8 HEAD@{0}: reset: moving to HEAD~3
# e2d03b4 HEAD@{1}: commit: feat: karanlık mod
# 31fe03f HEAD@{2}: commit: feat: form
# 4ebd915 HEAD@{3}: commit: feat: iletişim sayfası

git branch kurtarma e2d03b4        # güvenli yol: önce bir branch'e bağla
git log --oneline kurtarma
git reset --hard HEAD@{1}          # ya da main'i doğrudan eski hâline döndür
git log --oneline && ls
```

## Anlatırken
- HEAD'in gittiği **her yer** kaydedilir: commit, reset, rebase, switch.
- Saklama: erişilebilir kayıtlar ~90 gün, erişilemeyenler ~30 gün. Sadece **senin bilgisayarında** (push edilmez).
- Commit'lediğin bir şeyi Git'te kaybetmek çok zor; commit'lemediğini kaybetmek kolay → sık commit at.

## Sıfırla
`./kur.sh 14`
