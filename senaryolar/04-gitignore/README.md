# 04 · .gitignore ve yanlışlıkla commit'lenen .env

**Slayt:** 101 · ".gitignore — Git'e 'buna bakma' de" · **Süre:** ~5 dk

```bash
./kur.sh 4
cd calisma/04-gitignore
```

## Başlangıç durumu
- `.env` (gizli anahtarlar) ilk commit'te **yanlışlıkla** repoya girmiş ve şimdi değişmiş.
- Çalışma klasörü çöple dolu: `node_modules/`, `dist/`, `app.log`, `.DS_Store`.

```
 M .env
?? .DS_Store
?? app.log
?? dist/app.min.js
?? node_modules/lodash/index.js
?? node_modules/lodash/package.json
```

## Canlı demo
```bash
git status --untracked-files=all       # gürültü
cat > .gitignore <<'X'
# Bağımlılıklar
node_modules/
# Gizli bilgiler — ASLA commit'leme
.env
# Derleme çıktıları ve loglar
dist/
*.log
# İşletim sistemi çöpü
.DS_Store
X
git status                             # gürültü gitti… ama .env hâlâ "modified"!
git check-ignore -v app.log            # hangi kural yakaladı?

git rm --cached .env                   # dosyayı diskte bırak, takipten çıkar
git status                             # D .env (takipten çıkıyor) + .gitignore
git add .gitignore
git commit -m "chore: .gitignore ekle, .env takipten çıkar"
git log --oneline --stat -1
```

## Anlatırken
- `.gitignore` sadece **henüz takip edilmeyen** dosyaları gizler; takip edilen dosya için `git rm --cached` gerekir.
- `.env` bir kez push edildiyse **sızmış say**: önce anahtarı değiştir (rotate), sonra temizle (geçmiş temizliği tek başına yetmez).
- Hazır şablonlar: github.com/github/gitignore

## Sıfırla
`./kur.sh 4`
