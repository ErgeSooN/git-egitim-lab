#!/usr/bin/env bash
# 01: empty folder for the very first git init / add / commit.
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 01-ilk-commit
mkdir merhaba-git
hazir 01-ilk-commit/merhaba-git "git init"
