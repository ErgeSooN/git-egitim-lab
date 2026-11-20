# 17 · bisect: hatayı getiren commit'i bul

**Slayt:** 202 · "bisect: hatayı getiren commit'i bul 🔍" · **Süre:** ~7 dk

```bash
./kur.sh 17
cd calisma/17-bisect
```

## Başlangıç durumu
60 commit'lik bir geçmiş. `v1.0` etiketinde sepet toplamı (KDV dahil) doğruydu, şimdi yanlış. `test.sh` doğru/yanlışı söylüyor.
```
$ bash test.sh
❌ toplam yanlış: 66000 (beklenen 72000)
```

## Canlı demo — elle
```bash
bash test.sh                       # ❌
git log --oneline | wc -l          # 60 commit — tek tek bakmak yok
git bisect start
git bisect bad                     # şu an bozuk
git bisect good v1.0               # burada sağlamdı
bash test.sh                       # Git ortadaki commit'e geçti → sonuca göre:
git bisect good                    # ya da: git bisect bad
# … ~6 adımda:
# e2bb1b8… is the first bad commit — refactor: KDV hesabını sadeleştir
git bisect reset
```

## Canlı demo — otomatik
```bash
git bisect start HEAD v1.0
git bisect run bash test.sh        # Git testi kendisi koşturur
git bisect reset
git show e2bb1b8                   # suçlu değişiklik
```

## Anlatırken
- İkili arama: 60 commit → en fazla ~6 adım; 1000 commit → ~10 adım.
- `bisect run` için testin "0 = sağlam, 1 = bozuk" dönmesi yeter (`npm test`, `pytest`, bir betik…).
- bisect'in gücü küçük, atomik commit'lerden gelir: "bir sürü şey değişti" commit'i bulsan da işine yaramaz.

## Sıfırla
`./kur.sh 17`
