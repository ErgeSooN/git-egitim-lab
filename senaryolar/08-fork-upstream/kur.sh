#!/usr/bin/env bash
# 08: upstream.git = original project, fork.git = your fork (made earlier), benim-kopyam/ = your clone of the fork.
#     upstream moved on after you forked -> sync with `remote add upstream`, fetch, merge.
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 08-fork-upstream
uzak_ac upstream.git

repo_ac bakimci "Proje Bakımcısı" "bakimci@ornek.dev"
cd bakimci
echo "# Açık kaynak proje" | yaz README.md
echo "function topla(a, b) { return a + b; }" | yaz kutuphane.js
kaydet "feat: topla fonksiyonu"
git remote add origin ../upstream.git
git push -q origin main
cd ..

git clone -q --bare upstream.git fork.git
git clone -q fork.git benim-kopyam
git -C benim-kopyam config user.name "Ayşe Demo"; git -C benim-kopyam config user.email "ayse@ornek.dev"
git -C benim-kopyam config core.autocrlf false

cd bakimci
echo "function carp(a, b) { return a * b; }" >> kutuphane.js
kaydet "feat: carp fonksiyonu"
printf '\n## Kurulum\nnpm install acik-kaynak-proje\n' >> README.md
kaydet "docs: kurulum bölümü"
git push -q origin main
cd ..
rm -rf bakimci
hazir 08-fork-upstream/benim-kopyam "git remote -v"
