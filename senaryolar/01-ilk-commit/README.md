# 01 · İlk repo ve ilk commit

**Slayt:** 101 · "İlk ayarlar", "Git'in üç alanı", "Bir dosyanın yaşam döngüsü", "Canlı demo: ilk repo" · **Süre:** ~6 dk

```bash
./kur.sh 1
cd calisma/01-ilk-commit/merhaba-git
```

## Başlangıç durumu
Boş bir `merhaba-git` klasörü. Henüz repo değil (`.git` yok).

## Canlı demo
```bash
git config --global user.name        # kimlik ayarlı mı? (yoksa 101 "İlk ayarlar")
git status                           # fatal: not a git repository → henüz repo değil
git init                             # .git oluştu → artık bir repo
ls -a                                # .git klasörünü göster

echo "# Merhaba Git" > README.md
git status                           # README.md: untracked  (working directory)
git add README.md
git status                           # Changes to be committed  (staging)
git commit -m "docs: README ekle"    # repo'ya kaydedildi
git log --oneline

echo "Bugün Git öğreniyoruz." >> README.md
git status                           # modified  → yaşam döngüsü: committed → modified
git diff                             # ne değişti?
git add README.md && git commit -m "docs: README'ye açıklama ekle"
git log --oneline
```

## Anlatırken
- Üç alan: **working directory → staging → repo**. `add` = sahneye çıkar, `commit` = fotoğrafı çek.
- `git status` en iyi arkadaşın; her adımda çalıştır ve ekrandaki ipuçlarını oku.
- Commit mesajı "ne yaptım" sorusunun cevabı: `docs:`, `feat:`, `fix:` (bkz. senaryo 03).

## Sıfırla
`./kur.sh 1` — klasörü silip yeniden boş hâliyle kurar.
