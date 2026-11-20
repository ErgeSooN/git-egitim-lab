# 19 · GitHub Actions, PR kontrolleri ve Rulesets

**Slayt:** 202 · "GitHub Actions'a giriş", "Bir workflow'un anatomisi", "main'i koru: Rulesets", "GitHub'da 3 merge seçeneği", "İyi bir Pull Request" · **Süre:** ~10 dk

```bash
./kur.sh 19
cd calisma/19-github-actions
```

## Başlangıç durumu
Küçük bir Node projesi: slayttaki `ci.yml` workflow'u, `CODEOWNERS`, PR şablonu.
- `main`: test geçer ✅
- `feature/kirmizi-test`: `topla` bozuldu, test kırılır ❌

Bu senaryo **GitHub'da** çalışır: bir hesap ve (public repo için ücretsiz) Actions gerekir.
> ⚠️ ErgeSooN hesabında Actions şu an billing kilidi yüzünden çalışmıyor; demoyu başka bir hesapla yap ya da önce Settings → Billing'deki sorunu çöz.

## Canlı demo
```bash
# 1) GitHub'a gönder (gh CLI ile; ya da github.com/new + git remote add origin + git push)
gh repo create ci-demo --public --source . --push
# → GitHub → Actions: "CI" koşusu ✅

# 2) Kırmızı PR
git push -u origin feature/kirmizi-test
gh pr create --fill --head feature/kirmizi-test
# → PR'da "CI / test" ❌ — Details → hangi adım neden düştü
gh run watch

# 3) Düzelt → yeşil
git switch feature/kirmizi-test
sed -i.bak 's/a - b/a + b/' src/topla.js && rm src/topla.js.bak
git commit -am "fix: topla doğru toplasın"
git push                            # PR kendiliğinden güncellenir → ✅
```

GitHub arayüzünde:
4. **Settings → Rules → Rulesets → New branch ruleset** → Target: default branch → *Require a pull request* + *Require status checks* (`test`) + *Block force pushes*. Sonra `main`'e doğrudan push etmeyi dene → reddedilir.
5. `CODEOWNERS`'taki `@kullanici-adin`'ı kendi kullanıcı adınla değiştir → PR'larda otomatik reviewer.
6. PR'ı **Squash and merge** ile birleştir; Settings → General → Pull Requests'te izin verilen merge türlerini göster.

## Anlatırken
- Workflow = `on` (ne zaman) + `jobs` (nerede) + `steps` (ne). `permissions: contents: read` en az yetki.
- Kırmızı CI ceza değil, geri bildirim. Ruleset ile "kırmızıyken merge yok" kuralı konur.
- Fork'tan gelen PR'lar secret'lara erişemez.

## Temizlik
`gh repo delete ci-demo --yes` ya da GitHub → Settings → Delete this repository.

## Sıfırla
`./kur.sh 19`
