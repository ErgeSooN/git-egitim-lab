# 13 · Geri alma haritası: restore, reset, revert, amend

**Slayt:** 202 · "Geri alma haritası ↩️", "reset'in üç modu" · **Süre:** ~10 dk

```bash
./kur.sh 13
cd calisma/13-geri-alma
```

## Başlangıç durumu
```
1bca88a chore: debug logları   ← hiç olmamalıydı
1449e44 feat: footer
a072389 feat: menü
9f363e9 feat: ana sayfa
 M index.html   ← bir satır yanlışlıkla silindi (unstaged)
A  style.css    ← istenmeyen stil (staged)
```

## Canlı demo (sırayla)
```bash
git status
git restore index.html             # dosyadaki değişikliği çöpe at → silinen satır geri geldi
git restore --staged style.css     # staging'den çıkar (dosya diskte kalır)
rm style.css                       # yeni (takip edilmeyen) dosya: restore değil, sil

git reset --soft HEAD~1            # son commit gitti, değişiklik staged duruyor
git status                         # app.js staged
git reset HEAD~0                   # (--mixed) staging'den de çıkar, dosya duruyor
git status
rm app.js                          # debug dosyasını tamamen at

git commit --amend -m "feat: footer bölümü"   # son commit'in mesajını düzelt
git revert --no-edit HEAD~1        # paylaşılmış "feat: menü"yü geri alan YENİ commit
git log --oneline

git reset --hard HEAD~1            # ⚠️ revert commit'i ve tüm değişiklikler gider
git reflog                         # ama reflog hatırlar → senaryo 14
```

## Anlatırken
| Durum | Komut | Paylaşılan geçmişte? |
|---|---|---|
| Dosyadaki değişikliği at | `git restore <dosya>` | — |
| Staging'den çıkar | `git restore --staged <dosya>` | — |
| Son commit mesajı / unutulan dosya | `git commit --amend` | ❌ |
| Commit'i geri al, değişiklik staged kalsın | `git reset --soft HEAD~1` | ❌ |
| Commit'i geri al, değişiklik dosyada kalsın | `git reset HEAD~1` | ❌ |
| Commit'i ve değişiklikleri tamamen sil | `git reset --hard HEAD~1` | ❌ ⚠️ |
| Push edilmiş commit'in etkisini geri al | `git revert <sha>` | ✅ |

Kural: yerelde reset/amend serbest; **push edildiyse revert**.

## Sıfırla
`./kur.sh 13`
