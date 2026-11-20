#!/usr/bin/env bash
# 07: origin.git plays GitHub; ali/ and ayse/ are two clones. Ayşe already pushed, Ali has an unpushed commit
#     -> Ali's push is rejected until he fetches/pulls.
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 07-remote-push-pull
uzak_ac origin.git

repo_ac tohum "Ayşe Demo" "ayse@ornek.dev"
cd tohum
echo "# Takım sitesi" | yaz README.md
yaz index.html <<'HTML'
<nav><a href="index.html">Ana sayfa</a> <a href="blog.html">Blog</a></nav>
<h1>Takım sitesi</h1>
HTML
kaydet "feat: ilk sürüm"
git remote add origin ../origin.git
git push -q origin main
cd ..
rm -rf tohum

git clone -q origin.git ali
git -C ali config user.name "Ali Demo"; git -C ali config user.email "ali@ornek.dev"
git -C ali config pull.rebase false; git -C ali config core.autocrlf false
git clone -q origin.git ayse
git -C ayse config user.name "Ayşe Demo"; git -C ayse config user.email "ayse@ornek.dev"
git -C ayse config pull.rebase false; git -C ayse config core.autocrlf false

cd ayse
echo "<h1>Hakkımızda</h1>" | yaz hakkimizda.html
kaydet "feat: hakkımızda sayfası"
git push -q origin main
cd ../ali
yaz index.html <<'HTML'
<nav><a href="index.html">Ana sayfa</a> <a href="blog/">Blog</a></nav>
<h1>Takım sitesi</h1>
HTML
kaydet "fix: blog bağlantısı"
cd ..
hazir 07-remote-push-pull/ali "git push"
