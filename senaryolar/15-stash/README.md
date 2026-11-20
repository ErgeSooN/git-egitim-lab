# 15 · stash: yarım işi rafa kaldır

**Slayt:** 202 · "stash: yarım işi rafa kaldır" · **Süre:** ~5 dk

```bash
./kur.sh 15
cd calisma/15-stash
```

## Başlangıç durumu
`feature/profil` branch'indesin, iş yarım:
```
 M profil.html   ← yarım form
?? profil.css    ← yeni, henüz takip edilmiyor
```
Bu sırada `main`'deki başlıkta acil bir yazım hatası var (`hoş gledin`).

## Canlı demo
```bash
git status
git switch main                            # ❌ error: Your local changes … would be overwritten → önce rafa kaldır
git stash push -u -m "yarım: profil formu" # -u: takip edilmeyen profil.css de girsin
git status                                 # tertemiz
git stash list

git switch main
# index.html'de "gledin" → "geldin" düzelt
git commit -am "fix: başlıktaki yazım hatası"

git switch feature/profil
git stash pop                              # yarım iş geri geldi
git status
```

## Anlatırken
- `stash` = geçici raf; uzun süre bekletme, unutulur. Uzun sürecekse `wip` commit'i at.
- `-u` olmadan yeni (untracked) dosyalar stash'e girmez.
- `git stash show -p` içine bak · `git stash apply` uygula ama silme · `git stash drop` sil.
- Alternatif: iki iş paralel yürüyorsa `git worktree` (senaryo 20).

## Sıfırla
`./kur.sh 15`
