# Git & GitHub Eğitimi — Uygulama Laboratuvarı 🧪

Sunumdaki her konuyu **canlı göstermek** için hazır senaryolar. Her senaryo, o konuyu anlatmaya hazır bir (ya da birkaç) Git reposunu tek komutla sıfırdan kurar: conflict'e hazır branch'ler, reddedilecek bir push, kaybolmuş commit'ler, hatayı saklayan 60 commit…

```bash
./kur.sh            # senaryoları listele
./kur.sh 6          # 06'yı kur (her seferinde temiz başlangıç)
./kur.sh 6 7 10     # birkaçını birden
./kur.sh hepsi      # hepsini kur
./kontrol.sh        # her senaryoyu geçici klasörde kurup demoları otomatik dener
```

Kurulan repolar `calisma/<senaryo>/` altına gelir. Her senaryonun klasöründeki **README.md** adım adım demo rehberidir: başlangıç durumu, yazılacak komutlar, beklenen çıktılar, anlatırken vurgulanacaklar.

## Senaryolar

| # | Senaryo | Slayt | Süre |
|---|---|---|---|
| **101** | | | |
| 01 | [İlk repo ve ilk commit](senaryolar/01-ilk-commit/README.md) — init, status, add, commit, yaşam döngüsü | İlk ayarlar · Git'in üç alanı · Canlı demo: ilk repo | 6 dk |
| 02 | [Ne değişti? Geçmişe bakmak](senaryolar/02-ne-degisti/README.md) — diff, diff --staged, log --graph, show, blame | Ne değişti? · Geçmişi görselleştir | 6 dk |
| 03 | [İyi commit](senaryolar/03-iyi-commit/README.md) — `add -p` ile atomik commit, Conventional Commits | İyi commit nasıl olur? · Conventional Commits | 7 dk |
| 04 | [.gitignore ve yanlışlıkla commit'lenen .env](senaryolar/04-gitignore/README.md) — `rm --cached`, `check-ignore` | .gitignore | 5 dk |
| 05 | [Branch ve merge](senaryolar/05-branch-merge/README.md) — fast-forward, `--ff-only`, `--no-ff` | Branch komutları · Merge'ün iki hâli | 7 dk |
| 06 | [Merge conflict — ilk karşılaşma](senaryolar/06-merge-conflict/README.md) | Merge conflict 😱 | 6 dk |
| 07 | [Remote: push, fetch, pull ve reddedilen push](senaryolar/07-remote-push-pull/README.md) — iki kişilik takım simülasyonu | Remote · fetch vs pull | 8 dk |
| 08 | [Fork ve upstream ile senkron](senaryolar/08-fork-upstream/README.md) | Fork ile açık kaynağa katkı | 5 dk |
| **202** | | | |
| 09 | [Kaputun altı](senaryolar/09-kaputun-alti/README.md) — blob/tree/commit, refs, detached HEAD | Kaputun altı · HEAD, branch ve refs | 7 dk |
| 10 | [Rebase](senaryolar/10-rebase/README.md) — temiz ve çakışmalı rebase, `--continue`/`--abort` | Rebase · Merge mi, rebase mi? | 8 dk |
| 11 | [Interactive rebase](senaryolar/11-interactive-rebase/README.md) — fixup, reword, `--autosquash` | Interactive rebase | 7 dk |
| 12 | [Conflict — derinlemesine](senaryolar/12-conflict-derin/README.md) — zdiff3, `--ours`/`--theirs`, rebase'de ters dönmesi | Conflict çözümü — derinlemesine | 7 dk |
| 13 | [Geri alma haritası](senaryolar/13-geri-alma/README.md) — restore, reset (soft/mixed/hard), revert, amend | Geri alma haritası · reset'in üç modu | 10 dk |
| 14 | [reflog ile kurtarma](senaryolar/14-reflog-kurtarma/README.md) — `reset --hard` sonrası kayıp 3 commit | reflog: Git'in kara kutusu | 5 dk |
| 15 | [stash](senaryolar/15-stash/README.md) — yarım iş + acil düzeltme | stash | 5 dk |
| 16 | [cherry-pick](senaryolar/16-cherry-pick/README.md) — yarım branch'ten tek düzeltmeyi almak | cherry-pick | 4 dk |
| 17 | [bisect](senaryolar/17-bisect/README.md) — 60 commit içinde hatayı bul (elle + `bisect run`) | bisect | 7 dk |
| 18 | [Tag, Release ve SemVer](senaryolar/18-tag-release/README.md) — annotated tag, describe, push --follow-tags | Tag, Release ve SemVer | 5 dk |
| 19 | [GitHub Actions, PR kontrolleri, Rulesets](senaryolar/19-github-actions/README.md) — kırmızı/yeşil PR (GitHub hesabı gerekir) | Actions · Workflow anatomisi · Rulesets · Merge seçenekleri | 10 dk |
| 20 | [Bonus araç çantası](senaryolar/20-bonus-araclar/README.md) — log -S, blame -w -C, switch -, shortlog, worktree | Bonus araç çantası | 6 dk |

## Gereksinimler

- **Git 2.38+** (`git --version`). macOS, Linux ve Windows'ta **Git Bash** ile çalışır.
- İnternet ya da hesap gerekmez (19 hariç): "GitHub" rolünü yerel bare repolar (`origin.git`, `upstream.git`) oynar.
- Interactive rebase ve merge mesajları için bir editör: `git config --global core.editor "code --wait"`.
- 19 için: GitHub hesabı, isteğe bağlı `gh` CLI.

## Nasıl çalışır?

```
git-egitim-lab/
├── kur.sh            ← giriş noktası: ./kur.sh <no>
├── kontrol.sh        ← tüm senaryoları otomatik dener (calisma/'ya dokunmaz)
├── lib/ortak.sh      ← ortak yardımcılar (repo aç, commit at, sabit zaman…)
├── senaryolar/
│   └── NN-konu/
│       ├── kur.sh    ← o senaryonun repolarını kurar
│       └── README.md ← demo rehberi
└── calisma/          ← kurulan demo repoları (git'e girmez, her kurulumda yeniden oluşur)
```

- **Neden hazır repo değil de betik?** Git iç içe `.git` klasörlerini saklayamaz. Betikler her seferinde aynı başlangıç durumunu kurar; demo bozulursa `./kur.sh <no>` ile saniyeler içinde baştan başlarsın.
- **Hash'ler her kurulumda aynıdır** (sabit yazar ve tarih). Rehberlerdeki `8cd4b32` gibi SHA'lar senin ekranında da aynı çıkar.
- Demo repolarında kimlik (`Ayşe Demo`, `Ali Demo`…) repo içinde ayarlıdır; senin global Git ayarlarına dokunulmaz. İstisna: 01'de ilk commit senin kimliğinle atılır (konu zaten bu).

## Eğitim günü ipuçları

- Başlamadan önce `./kontrol.sh` → hepsi ✅ ise `./kur.sh hepsi`.
- Terminalde büyük font, açık tema; komutları yavaş yaz, her adımda `git status` ve `git log --oneline --graph --all`.
- Katılımcılara: "Bu lab'ı klonlayıp `./kur.sh 6` ile evde aynısını deneyebilirsiniz."
