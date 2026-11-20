# 12 · Conflict çözümü — derinlemesine (zdiff3, ours/theirs)

**Slayt:** 202 · "Conflict çözümü — derinlemesine" · **Süre:** ~7 dk

```bash
./kur.sh 12
cd calisma/12-conflict-derin
```

## Başlangıç durumu
- Bu repoda `merge.conflictStyle = zdiff3` (sadece bu repo için, `git config merge.conflictStyle`).
- Ortak ata: `<h1>Hoşgeldin</h1>` · `main`: `<h1>Hoş geldin!</h1>` · `feature/baslik`: `<h1>Hoşgeldiniz!</h1>` · `feature/ters`: `<h1>Selam!</h1>`

## Canlı demo — merge
```bash
git merge feature/baslik
cat index.html
# <<<<<<< HEAD
# <h1>Hoş geldin!</h1>
# ||||||| 30c993c        ← ortak ata: iki taraf da neyi değiştirdi, görünüyor
# <h1>Hoşgeldin</h1>
# =======
# <h1>Hoşgeldiniz!</h1>
# >>>>>>> feature/baslik

git restore --ours index.html      # main'in hâli
git restore --theirs index.html    # feature/baslik'in hâli
git add index.html && git commit   # birini seçip bitir
# ya da: git merge --abort
```

## Canlı demo — rebase'de ours/theirs ters döner
```bash
# önce temiz başlangıç: lab köküne dön → ./kur.sh 12 → cd calisma/12-conflict-derin
git switch feature/ters
git rebase main                    # CONFLICT
git restore --ours index.html && cat index.html   # <h1>Hoş geldin!</h1>  ← main'in hâli!
git restore --theirs index.html && cat index.html # <h1>Selam!</h1>       ← senin commit'in
git rebase --abort
```

## Anlatırken
- Global ayar: `git config --global merge.conflictStyle zdiff3` — ortak atayı görmek kararı kolaylaştırır.
- `--ours` / `--theirs` sonrası da `git add` şart.
- Rebase'de `--ours` = üzerine taşındığın taban (main), `--theirs` = senin commit'in.

## Sıfırla
`./kur.sh 12`
