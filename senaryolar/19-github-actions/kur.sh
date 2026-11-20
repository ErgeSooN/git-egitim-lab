#!/usr/bin/env bash
# 19: a tiny Node project with the CI workflow from the slides, CODEOWNERS and a PR template.
#     Push it to a GitHub repo to demo Actions, red/green PR checks and rulesets.
source "$(dirname "$0")/../../lib/ortak.sh"
alan_hazirla 19-github-actions
repo_ac .
yaz package.json <<'JSON'
{
  "name": "ci-demo",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "test": "node --test"
  }
}
JSON
yaz package-lock.json <<'JSON'
{
  "name": "ci-demo",
  "version": "1.0.0",
  "lockfileVersion": 3,
  "requires": true,
  "packages": {
    "": {
      "name": "ci-demo",
      "version": "1.0.0"
    }
  }
}
JSON
yaz src/topla.js <<'JS'
function topla(a, b) {
  return a + b;
}
module.exports = { topla };
JS
yaz test/topla.test.js <<'JS'
const test = require("node:test");
const assert = require("node:assert");
const { topla } = require("../src/topla");

test("2 + 2 = 4", () => {
  assert.strictEqual(topla(2, 2), 4);
});
JS
yaz .github/workflows/ci.yml <<'YML'
name: CI
on:
  pull_request:
  push:
    branches: [main]

permissions:
  contents: read

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v7
      - uses: actions/setup-node@v7
        with:
          node-version: 24
      - run: npm ci
      - run: npm test
YML
yaz .github/CODEOWNERS <<'TXT'
# Bu yollar değişirse otomatik reviewer (kendi kullanıcı adınla değiştir)
*.js          @kullanici-adin
/.github/     @kullanici-adin
TXT
yaz .github/pull_request_template.md <<'MD'
## Ne değişti?

## Neden?

## Nasıl test ettim?

Closes #
MD
echo "# CI demo" | yaz README.md
echo "node_modules/" | yaz .gitignore
kaydet "feat: topla fonksiyonu ve CI"

# A branch whose test fails -> red check on the PR
git switch -q -c feature/kirmizi-test
yaz src/topla.js <<'JS'
function topla(a, b) {
  return a - b; // hata: yanlış işlem
}
module.exports = { topla };
JS
kaydet "refactor: topla fonksiyonunu sadeleştir"
git switch -q main
hazir 19-github-actions "gh repo create ci-demo --public --source . --push"
