# 09 · Kaputun altı: nesneler, refs, HEAD

**Slayt:** 202 · "Kaputun altı: Git bir içerik veritabanıdır", "HEAD, branch ve refs", "Git 3.0 yolda" · **Süre:** ~7 dk

```bash
./kur.sh 9
cd calisma/09-kaputun-alti
```

## Başlangıç durumu
3 commit'lik küçük bir repo (`README.md`, `src/app.js`, `src/stil.css`) ve bir commit geride duran `feature/deneme` branch'i.

## Canlı demo
```bash
git cat-file -p HEAD               # commit: tree + parent + author + mesaj
git cat-file -p 'HEAD^{tree}'      # tree: README.md (blob) + src (tree)
git cat-file -p HEAD:src           # alt klasörün tree'si
git cat-file -p HEAD:README.md     # blob: dosyanın içeriği
git cat-file -t HEAD~2             # commit
git hash-object README.md          # içerikten hesaplanan id = HEAD:README.md ile aynı

cat .git/HEAD                      # ref: refs/heads/main
git rev-parse main                 # branch = bir SHA'yı gösteren etiket
git symbolic-ref HEAD              # refs/heads/main
git rev-parse feature/deneme       # bir commit geride

git switch --detach HEAD~1         # detached HEAD: bir branch'te değilsin
echo "deneme" > deneme.txt && git add . && git commit -m "deneme: detached commit"
git switch main                    # uyarı: commit'i branch'siz bırakıyorsun!
git branch kurtarilan <uyarıdaki-sha>   # ya da: git reflog → bul → branch yap
```

Git 3.0 önizlemesi: `git init --object-format=sha256 deneme && git -C deneme rev-parse --show-object-format`

## Anlatırken
- Üç nesne türü: **blob** (içerik), **tree** (klasör), **commit** (fotoğraf + ebeveyn). Hepsi içeriğinin hash'i ile adlandırılır.
- Branch bir dosyada duran bir SHA'dan ibaret; bu yüzden branch açmak bedava.
- `.git` içini elle düzenleme; `rev-parse`/`symbolic-ref` gibi komutları kullan (reftable'da da çalışır).

## Sıfırla
`./kur.sh 9`
