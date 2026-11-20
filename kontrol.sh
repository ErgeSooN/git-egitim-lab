#!/usr/bin/env bash
# Rebuilds every scenario in a temp folder and runs the key demo steps non-interactively.
# Your calisma/ folder is not touched. Run before the event: ./kontrol.sh
set -uo pipefail
LAB_DIR="$(cd "$(dirname "$0")" && pwd)"
export LAB_CALISMA="$(mktemp -d)"
export GIT_EDITOR=true GIT_MERGE_AUTOEDIT=no
W="$LAB_CALISMA"
ok=0; bad=0
gec()  { echo "  ✅ $1"; ok=$((ok + 1)); }
kal()  { echo "  ❌ $1"; bad=$((bad + 1)); }
# pipefail off inside checks: `cmd | grep -q` would otherwise fail on SIGPIPE
dogrula() { if (set +o pipefail; eval "$2") >/dev/null 2>&1; then gec "$1"; else kal "$1"; fi; }

kur() { bash "$LAB_DIR/kur.sh" "$1" >/dev/null 2>&1 || kal "kurulum $1"; }

echo "01 ilk commit"; kur 1
dogrula "klasör boş ve repo değil" "[ -d '$W/01-ilk-commit/merhaba-git' ] && [ ! -d '$W/01-ilk-commit/merhaba-git/.git' ]"

echo "02 ne değişti"; kur 2; cd "$W/02-ne-degisti"
dogrula "staged değişiklik var" "[ -n \"\$(git diff --staged)\" ]"
dogrula "unstaged değişiklik var" "[ -n \"\$(git diff)\" ]"
dogrula "merge commit'li geçmiş" "[ \$(git rev-list --merges --count HEAD) -eq 1 ]"

echo "03 iyi commit"; kur 3; cd "$W/03-iyi-commit"
dogrula "kötü mesajlar geçmişte" "git log --format=%s | grep -qx asdasd"
dogrula "index.html iki ayrı parça (hunk)" "[ \$(git diff -U3 index.html | grep -c '^@@') -eq 2 ]"

echo "04 gitignore"; kur 4; cd "$W/04-gitignore"
dogrula ".env yanlışlıkla takipte" "git ls-files --error-unmatch .env"
dogrula "node_modules görünüyor" "git status --porcelain | grep -q node_modules"
printf 'node_modules/\ndist/\n*.log\n.DS_Store\n.env\n' > .gitignore
git rm -q --cached .env
dogrula ".gitignore + rm --cached sonrası sadece .gitignore kalır" "[ \"\$(git status --porcelain | sort | tr '\n' ' ')\" = '?? .gitignore D  .env ' ]"

echo "05 branch & merge"; kur 5; cd "$W/05-branch-merge"
dogrula "feature/iletisim fast-forward olur" "git merge --ff-only feature/iletisim"
dogrula "feature/footer fast-forward olmaz" "! git merge --ff-only feature/footer"
dogrula "feature/footer merge commit ile birleşir" "git merge --no-edit feature/footer"

echo "06 merge conflict"; kur 6; cd "$W/06-merge-conflict"
dogrula "merge conflict çıkar" "! git merge feature/baslik"
dogrula "çakışma işaretleri index.html'de" "grep -q '^<<<<<<< HEAD' index.html && grep -q \"GDG Düzce'ye hoş geldin!\" index.html && grep -q 'Topluluğumuza hoş geldiniz' index.html"
dogrula "style.css çakışmasız geldi" "git diff --name-only --cached | grep -qx style.css"

echo "07 remote"; kur 7; cd "$W/07-remote-push-pull/ali"
dogrula "Ali'nin push'u reddedilir" "! git push -q origin main"
dogrula "git pull birleştirir" "git pull -q --no-edit"
dogrula "sonra push geçer" "git push -q origin main"

echo "08 fork"; kur 8; cd "$W/08-fork-upstream/benim-kopyam"
git remote add upstream ../upstream.git
dogrula "fetch upstream" "git fetch -q upstream"
dogrula "upstream/main fast-forward ile gelir" "git merge -q --ff-only upstream/main"
dogrula "fork'a push" "git push -q origin main"

echo "09 kaputun altı"; kur 9; cd "$W/09-kaputun-alti"
dogrula "HEAD bir commit nesnesi" "[ \"\$(git cat-file -t HEAD)\" = commit ]"
dogrula "HEAD:src bir tree" "[ \"\$(git cat-file -t HEAD:src)\" = tree ]"
dogrula "hash-object = blob id" "[ \"\$(git hash-object README.md)\" = \"\$(git rev-parse HEAD:README.md)\" ]"

echo "10 rebase"; kur 10; cd "$W/10-rebase"
git switch -q feature/ozellik
dogrula "feature/ozellik temiz rebase olur" "git rebase -q main"
dogrula "geçmiş artık doğrusal" "[ \$(git rev-list --merges --count HEAD) -eq 0 ] && git merge-base --is-ancestor main HEAD"
git switch -q feature/cakisan
dogrula "feature/cakisan rebase'de conflict verir" "! git rebase -q main"
git rebase --abort

echo "11 interactive rebase"; kur 11; cd "$W/11-interactive-rebase"
git switch -q feature/profil
dogrula "rebase -i (fixup, fixup) 4 → 2 commit" "GIT_SEQUENCE_EDITOR=\"sed -i.bak -e '2s/^pick/fixup/' -e '3s/^pick/fixup/'\" git rebase -q -i main && [ \$(git rev-list --count main..HEAD) -eq 2 ]"

echo "12 conflict derin"; kur 12; cd "$W/12-conflict-derin"
dogrula "zdiff3 ortak atayı gösterir" "! git merge feature/baslik; grep -q '^|||||||' index.html && grep -q 'Hoşgeldin' index.html"
dogrula "restore --theirs + add çözer" "git restore --theirs index.html && git add index.html && grep -qx '<h1>Hoşgeldiniz!</h1>' index.html"
git merge --abort 2>/dev/null; git reset -q --hard
git switch -q feature/ters
dogrula "rebase'de --ours = main tarafı" "! git rebase -q main; git restore --ours index.html && grep -qx '<h1>Hoş geldin!</h1>' index.html"
git rebase --abort 2>/dev/null

echo "13 geri alma"; kur 13; cd "$W/13-geri-alma"
dogrula "restore silinen satırı geri getirir" "git restore index.html && grep -q Etkinlik index.html"
dogrula "restore --staged staging'den çıkarır" "git restore --staged style.css && [ -z \"\$(git diff --staged)\" ]"
dogrula "reset --soft HEAD~1 commit'i geri alır, değişiklik staged kalır" "git reset -q --soft HEAD~1 && git diff --staged --name-only | grep -qx app.js"
dogrula "revert yeni commit üretir" "git restore --staged app.js && git revert --no-edit HEAD~1 && [ ! -f menu.html ] && git log -1 --format=%s | grep -q Revert"

echo "14 reflog"; kur 14; cd "$W/14-reflog-kurtarma"
dogrula "karanlık mod log'da yok" "! git log --format=%s | grep -q 'karanlık mod'"
dogrula "reflog'da var" "git reflog | grep -q 'feat: karanlık mod'"
dogrula "reset --hard HEAD@{1} kurtarır" "git reset -q --hard 'HEAD@{1}' && [ -f tema.css ]"

echo "15 stash"; kur 15; cd "$W/15-stash"
dogrula "stash push -u" "git stash push -q -u -m 'yarım: profil formu' && [ -z \"\$(git status --porcelain)\" ]"
dogrula "main'e geçip düzelt" "git switch -q main && sed -i.bak 's/gledin/geldin/' index.html && rm index.html.bak && git commit -qam 'fix: başlıktaki yazım hatası'"
dogrula "stash pop yarım işi geri getirir" "git switch -q feature/profil && git stash pop -q && [ -f profil.css ]"

echo "16 cherry-pick"; kur 16; cd "$W/16-cherry-pick"
FIX="\$(git log --format=%h --grep='tarih formatı' feature/buyuk-is)"
dogrula "cherry-pick -x düzeltmeyi main'e alır" "git cherry-pick -x $FIX && grep -q padStart tarih.js && [ ! -f odeme.js ]"

echo "17 bisect"; kur 17; cd "$W/17-bisect"
dogrula "test şu an kırık" "! bash test.sh"
dogrula "bisect run suçluyu bulur" "git bisect start HEAD v1.0 && git bisect run bash test.sh | grep -q 'refactor: KDV hesabını sadeleştir'"
git bisect reset >/dev/null 2>&1

echo "18 tag"; kur 18; cd "$W/18-tag-release/proje"
dogrula "describe v1.1.0-2-..." "git describe --tags | grep -q '^v1.1.0-2-'"
dogrula "annotated tag + push --follow-tags" "git tag -a v1.2.0 -m 'Karanlık mod' && git push -q origin main --follow-tags && git ls-remote --tags origin | grep -q v1.2.0"

echo "19 github actions"; kur 19; cd "$W/19-github-actions"
dogrula "workflow ve CODEOWNERS var" "[ -f .github/workflows/ci.yml ] && [ -f .github/CODEOWNERS ]"
if command -v node >/dev/null 2>&1; then
  dogrula "main'de test geçer" "npm test --silent"
  dogrula "feature/kirmizi-test'te test kırılır" "git switch -q feature/kirmizi-test && ! npm test --silent"
else
  echo "  ➖ node yok: testler atlandı (GitHub Actions'ta çalışır)"
fi

echo "20 bonus"; kur 20; cd "$W/20-bonus-araclar/proje"
dogrula "log -S apiKey 2 commit bulur" "[ \$(git log -S apiKey --oneline | wc -l) -eq 2 ]"
dogrula "blame -w -C taşınan kodun yazarını bulur" "git blame -w -C tarih.js | grep -q 'Mehmet Demo'"
dogrula "shortlog 3 yazar" "[ \$(git shortlog -sn HEAD | wc -l) -eq 3 ]"
dogrula "worktree eklenir" "git worktree add -q -b hotfix/acil ../hotfix main && [ -f ../hotfix/index.html ]"

rm -rf "$LAB_CALISMA"
echo
echo "Sonuç: $ok başarılı, $bad başarısız"
[ "$bad" -eq 0 ]
