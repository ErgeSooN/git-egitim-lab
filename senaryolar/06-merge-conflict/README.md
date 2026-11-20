# 06 · Merge conflict — ilk karşılaşma

**Slayt:** 101 · "Merge conflict — ilk karşılaşma 😱" · **Süre:** ~6 dk

```bash
./kur.sh 6
cd calisma/06-merge-conflict
```

## Başlangıç durumu
`main` ve `feature/baslik` aynı satırı (`<h1>`) farklı değiştirdi. `feature/baslik` ayrıca çakışmasız bir `style.css` ekledi.

## Canlı demo
```bash
git log --oneline --graph --all
git merge feature/baslik
# Auto-merging index.html
# CONFLICT (content): Merge conflict in index.html
# Automatic merge failed; fix conflicts and then commit the result.

git status                     # both modified: index.html · new file: style.css (sorunsuz geldi)
cat index.html
# <<<<<<< HEAD
# <h1>GDG Düzce'ye hoş geldin!</h1>
# =======
# <h1>Topluluğumuza hoş geldiniz</h1>
# >>>>>>> feature/baslik
```
1. Dosyayı aç (VS Code "Accept Current / Incoming / Both" düğmeleri), işaretleri sil, doğru hâli bırak — ör. `<h1>GDG Düzce topluluğuna hoş geldiniz!</h1>`
2. `git add index.html` → "çözdüm" demek
3. `git commit` → merge tamamlandı (mesaj hazır gelir)
4. Vazgeçmek istersen çözmeden önce: `git merge --abort`

```bash
git log --oneline --graph --all
```

## Anlatırken
- Conflict bir hata değil, bir **soru**: Git iki doğru arasında karar veremedi.
- Sadece çakışan satırlar işaretlenir; `style.css` gibi çakışmayan değişiklikler otomatik gelir.
- Daha az conflict için: küçük PR, sık `pull`, kısa ömürlü branch. Derinlemesine hâli: senaryo 12.

## Sıfırla
`./kur.sh 6`
