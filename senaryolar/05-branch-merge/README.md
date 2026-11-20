# 05 · Branch ve merge (fast-forward / merge commit)

**Slayt:** 101 · "Branch nedir?", "Branch komutları" · 202 · "Merge'ün iki hâli" · **Süre:** ~7 dk

```bash
./kur.sh 5
cd calisma/05-branch-merge
```

## Başlangıç durumu
```
* 67d615b (feature/footer) feat: footer ekle
| * bef3de7 (feature/iletisim) style: iletişim formu düzeni
| * 109f8db feat: iletişim sayfası
|/
* de42f13 (HEAD -> main) feat: ana sayfa iskeleti
```
`main` hiç ilerlemedi → `feature/iletisim` **fast-forward** olabilir. Ondan sonra `feature/footer` ayrışmış olur → **merge commit** gerekir.

## Canlı demo
```bash
git branch                             # * main
git log --oneline --graph --all

git merge --ff-only feature/iletisim   # Fast-forward: main sadece ileri kaydı
git log --oneline --graph --all

git merge --ff-only feature/footer     # fatal: Not possible to fast-forward → artık ayrıştılar
git merge --no-ff feature/footer       # editör açılır → kaydet-kapat → merge commit
git log --oneline --graph --all

git branch -d feature/iletisim feature/footer
git switch -c feature/hakkimizda       # yeni iş için yeni branch
```

## Anlatırken
- Branch = bir commit'i gösteren **hafif etiket**; oluşturmak bedava.
- Fast-forward: geçmiş doğrusal, iz yok. `--no-ff`: her zaman merge commit → "bu özellik burada birleşti" izi kalır.
- `main` her zaman çalışır kalsın; her iş kendi branch'inde.

## Sıfırla
`./kur.sh 5`
