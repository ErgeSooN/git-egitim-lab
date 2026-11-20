# 07 · Remote: push, fetch, pull ve reddedilen push

**Slayt:** 101 · "Remote: bilgisayarın ↔ GitHub", "fetch vs pull" · 202 · "Merge mi, rebase mi?" · **Süre:** ~8 dk

```bash
./kur.sh 7
cd calisma/07-remote-push-pull/ali
```

## Başlangıç durumu
İnternet ya da hesap gerekmez; GitHub'ı yerel bir **bare repo** temsil eder:
```
07-remote-push-pull/
├── origin.git   ← "GitHub"
├── ali/         ← senin bilgisayarın (push edilmemiş 1 commit: fix: blog bağlantısı)
└── ayse/        ← takım arkadaşın (çoktan push etti: feat: hakkımızda sayfası)
```

## Canlı demo
```bash
git remote -v                  # origin → ../origin.git (GitHub'da https://github.com/... olurdu)
git status -sb                 # ## main...origin/main [ahead 1] — Ayşe'nin push'undan habersiz!
git push
# ! [rejected]  main -> main (fetch first)
# hint: Updates were rejected because the remote contains work that you do not have locally.

git fetch                      # indir ama dokunma
git status -sb                 # [ahead 1, behind 1] → ayrıştık
git log --oneline --graph --all
git pull                       # fetch + merge → merge commit (editör açılırsa kaydet-kapat)
git push                       # artık geçer
git log --oneline --graph --all
```

Rebase'li alternatif (önce `./kur.sh 7` ile sıfırla):
```bash
git pull --rebase              # kendi commit'ini Ayşe'ninkinin üstüne taşır, merge commit yok
git push
```

Klon demosu: `cd .. && git clone origin.git yeni-klon`

## Anlatırken
- `fetch` = güvenli, sadece bakar. `pull` = `fetch` + `merge` (ya da `pull.rebase true` ile rebase).
- "rejected (fetch first)" bir hata değil: "senden önce biri push etti, önce onu al" demek.
- `git status`'taki "up to date" bilgisi **son fetch** anına göredir.

## Sıfırla
`./kur.sh 7`
