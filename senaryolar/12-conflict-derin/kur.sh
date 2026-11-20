#!/usr/bin/env bash
# 12: zdiff3 conflict with a visible common ancestor + a rebase where ours/theirs are reversed.
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 12-conflict-derin
repo_ac .
git config merge.conflictStyle zdiff3   # repo-local; the slide shows the --global version
echo "<h1>Hoşgeldin</h1>" | yaz index.html
kaydet "feat: ana sayfa"

git switch -q -c feature/baslik
echo "<h1>Hoşgeldiniz!</h1>" | yaz index.html
kaydet "feat: başlığı çoğul yap"

git switch -q main
git switch -q -c feature/ters
echo "<h1>Selam!</h1>" | yaz index.html
kaydet "feat: samimi başlık"

git switch -q main
echo "<h1>Hoş geldin!</h1>" | yaz index.html
kaydet "fix: başlık yazımı"
hazir 12-conflict-derin "git merge feature/baslik"
