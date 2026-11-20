# 11 · Interactive rebase: geçmişi PR'dan önce temizle

**Slayt:** 202 · "Interactive rebase: geçmişi PR'dan önce temizle" · **Süre:** ~7 dk

```bash
./kur.sh 11
cd calisma/11-interactive-rebase
git switch feature/profil
```

## Başlangıç durumu
```
21c4094 feat: karanlık mod
784f281 typo düzelt
1e0c671 wip
e069bfb feat: profil kartı
```

## Canlı demo
Editörün ayarlı olsun: `git config --global core.editor "code --wait"`
```bash
git log --oneline main..
git rebase -i main                 # ya da: git rebase -i HEAD~4
```
Açılan listede:
```
pick   e069bfb feat: profil kartı
fixup  1e0c671 wip
fixup  784f281 typo düzelt
reword 21c4094 feat: karanlık mod
```
Kaydet-kapat → `reword` için mesaj editörü açılır → ör. `feat: karanlık mod desteği` → kaydet-kapat.
```bash
git log --oneline main..           # 4 commit → 2 anlamlı commit
```

Profesyonel kısayol (`--fixup` + `--autosquash`):
```bash
echo "  <p>Düzce</p>" >> profil.html
git commit -a --fixup ':/feat: profil kartı'   # "fixup! feat: profil kartı" commit'i (:/ = mesajla bul)
git rebase -i --autosquash main            # liste hazır gelir → kaydet-kapat
git log --oneline main..
```
Editörsüz deneme: `GIT_SEQUENCE_EDITOR="sed -i.bak -e '2s/^pick/fixup/' -e '3s/^pick/fixup/'" git rebase -i main`

## Anlatırken
- `reword` mesajı değiştir · `squash` birleştir, mesajları da birleştir · `fixup` birleştir, mesajı at · `drop` sil.
- Sadece push etmediğin (ya da PR'ı sadece senin olan) commit'lerde yap.
- Bir şeyler ters giderse: `git rebase --abort` ya da `git reflog` (senaryo 14).

## Sıfırla
`./kur.sh 11`
