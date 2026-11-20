# 02 · Ne değişti? Geçmişe bakmak

**Slayt:** 101 · "Ne değişti? Nereye bakarım?", "Geçmişi görselleştir" · **Süre:** ~6 dk

```bash
./kur.sh 2
cd calisma/02-ne-degisti
```

## Başlangıç durumu
- Merge edilmiş bir branch'li küçük bir geçmiş.
- `style.css`'te **staged** (sahnede) bir değişiklik, `index.html`'de **unstaged** bir değişiklik.

```
*   b4685ef (HEAD -> main) Merge branch 'feature/iletisim'
|\
| * 5917ca0 (feature/iletisim) fix: form hizalaması
| * 9049ee8 feat: iletişim formu ekle
* | 9a8a2e5 fix: başlıktaki yazım hatası
|/
* 0051029 docs: README ekle
```

## Canlı demo
```bash
git status                     # M index.html (unstaged) · M style.css (staged)
git diff                       # sadece index.html → henüz sahnede olmayan
git diff --staged              # sadece style.css → commit'e girecek olan
git log --oneline
git log --oneline --graph --all --decorate
git show 9a8a2e5               # tek bir commit'in detayı
git log -p --follow index.html # bir dosyanın tüm geçmişi + diff'leri
git blame index.html           # her satırı en son kim, hangi commit'te değiştirdi

git config --global alias.lg "log --oneline --graph --all --decorate"
git lg
```

## Anlatırken
- `diff` ile `diff --staged` farkı en çok karıştırılan şey: "commit'e ne girecek?" sorusunun cevabı `--staged`.
- `git show` + `git blame` ile "bu satır neden böyle?" sorusu hash'ten commit mesajına, oradan PR'a kadar izlenebilir.

## Sıfırla
`./kur.sh 2`
