# fast mbti — Add to Wallet 設計與待辦

> 2026-11-20。前提：把「結果卡」存成 **Apple Wallet pass（PKPass）**，讓使用者日後能從 Wallet 掏出來看，而不是單純存相簿。
>
> **本檔唯一職責：Wallet pass 設計與實作。** 題庫／定位／結果規格以 `spec.md` §0.5 與 `quiz/quiz_tree.md` 為準，分享圖與 IAP 定價不在本檔重述；勾選框見 `todolist.md`。
>
> 一句話結論：**能做，但 Wallet pass 一定要「簽章」，私鑰不能進 App → 必然要有簽章端，這跟本專案「零雲端／零成本／全裝置端」直接衝突。先解這個，再談視覺。**
>
> **現行決策：** ① Wallet 做 **16 張**（結果恆為 16 型，全覆蓋）；② QR **直接指 App Store 產品頁**（已裝的人多一次「Open」點擊）；③ 簽章＝**預簽固定 pass 打包**：build 時用 Pass Designer `.pkpasstemplate` + Pass Builder 簽 16 張，不開 server；④ Pass 版型 `posterGeneric` + `generic` fallback（iOS 27 滿版海報，iOS 26 以下退回）；⑤ 正面欄位 Header 右上 `NO. 0428 · NI-TE`、Primary 四字母與 `BEST MATCH: XXXX`、footer 品牌字樣，`backFields` 免責與聯絡資訊；⑥ **16 張 `4:5` 主圖以 Wallet 為母檔**（16 型各一張），App 分享圖沿用；⑦ 分享只做 `4:5` `1080×1350`（App 端 `ImageRenderer`）。
> 技術依據：WWDC26 session 209「What's new in Wallet」、`Creating a Poster Generic Pass`、Pass Designer／Pass Builder 文件。16 型對應表（BEST MATCH／功能碼／編號）見 §3.5；16 張 4:5 卡片圖待產出。

---

## 0. 結論（先看這五條）

1. **最大決策不是 UI，是「簽章端在哪」。** Pass 必須用 `Pass Type ID` 憑證做 CMS 簽章，私鑰不能進 App → 只能預先簽好固定 pass、隨 App 打包。
2. **Wallet pass 不是分享圖搬家。** iOS 27 起可用 `posterGeneric` 做滿版背景，但欄位仍受限（無 `auxiliaryFields`、只有 1 個 `footerField`），且要並存 `generic` fallback 給 iOS 26 以下；塞不下一張完整分享圖。背景沿用 `4:5` 主圖，但欄位要為 Wallet 重排（見 §3）。
3. **MBTI 結果卡在 Wallet 的「被掏出來用」機率偏低**（不像票券/會員卡）。審查可能落在 **4.2 最小功能 / 4.3 模板**；要給它一個存在理由，最終做法是上面放一個 QR 連到 App Store 產品頁（見 §3）。
4. **靜態 pass 不需要 APNs / pass server 更新。** 結果一出就不變；一旦想做「更新、撤銷、點數」，就多一條雲端 + APNs 依賴，代價陡增。**首版做靜態。**
5. **Wallet 的價值要落在 QR 回訪。** 只是把結果存起來，邊際價值不足以支撐這個功能；QR 連 App Store 產品頁是它存在的理由。

---

## 0.5 決策表（已定案）

| # | 決策 | 決定 |
|---|---|---|
| 1 | 到底做不做 | **做**（簽章端成本可控，用途見 §1） |
| 2 | 簽章端在哪 | **預簽固定 pass 打包**：`.pkpasstemplate` + Pass Builder 在 build 時簽 16 張，不開 server |
| 3 | Pass 類型 | **`posterGeneric` + `generic` fallback**（iOS 27 滿版海報、iOS 26 以下退回純文字卡；`generic` 不支援 strip／background，無須另做橫條圖） |
| 4 | Pass 裡放什麼 | **Header `NO. 0428 · NI-TE`（右上）＋ Primary 四字母與 `BEST MATCH: XXXX`＋ footer 品牌字樣＋ backFields 免責；無梗文案／強度** |
| 5 | 條碼 | **QR 指 App Store 產品頁**；16 張共用同一個 QR URL |
| 6 | 更新／撤銷 | **靜態** |
| 7 | 跟 IAP 的關係 | **免費**（免費用戶看 Rewarded 生成後可存；IAP 無限生成與儲存） |
| 8 | 本地化 | **2 語**（`en` / `zh-Hant`，`l10n/*.lproj`）；`ja`/`ko` 保留、不進 pass |
| 9 | 隱私定位 | **資料不離機** |
| 10 | 審查說明 | **寫**（4.2 / 5.1.1，見 §6） |
| 11 | 分享圖尺寸 | **`4:5` `1080×1350`**（App 端 `ImageRenderer`，沿用 Wallet 16 張主圖） |

---

## 1. 為什麼做

Wallet pass 的價值來自「**反覆被掏出來用**」：登機、付款、會員、票券。結果卡是「看一次就存著」的東西，所以給它一個 Wallet 專屬用途：**QR 連 App Store 產品頁**，別人掃到就能下載。

成本：`Pass Type ID` + 憑證免費（Apple Developer 已有）；簽章在 build 機完成，零 server、零月費。

---

## 2. 簽章端：預簽固定 pass 打包（決策 2、9）

### 為什麼不能全裝置端

1. Pass 是 `pass.json` + 圖片 + `manifest.json`（各檔 SHA-1）+ `signature`（CMS detached signature）。
2. 簽章要用 `Pass Type ID Certificate` 的**私鑰**。私鑰放進 App bundle → 可被抽出、濫用，Apple 明確不允許。
3. 因此：**產 pass 與簽章必須在 App 外完成。**

### 現行做法

- build 機上用憑證先簽好 **16 型**的 `.pkpass`，放進 App bundle；使用者點「Add to Wallet」直接 `PKAddPassesViewController` 載入。
- 優點：零網路、零 server、資料不離機、可離線加。
- 缺點：`serialNumber` 全型共用（不能追蹤單一使用者，但本專案也不需要）、無個人化欄位、16 型 × 2 語的 pass 檔體積要估。

> 先在 Apple Developer → `Identifiers` → `Pass Type IDs` 建一個（例如 `pass.fastmbti.result`），並產生該 type 的 certificate + 私鑰（CSR 流程，跟 `ids.md` §3 類似）。

---

## 3. Pass 內容與版型（決策 3、4、5、8）

### `pass.json` 必要欄位

```
formatVersion      = 1
passTypeIdentifier = pass.fastmbti.result   // 與憑證一致
teamIdentifier     = <Team ID>
serialNumber       = 每型固定值（16 張，見 §11）
organizationName   = fast mbti
description        = 結果卡（兩語）
brandName / labelColor / foregroundColor / backgroundColor
posterGeneric      = { headerFields, primaryFields, footerFields, backFields }  // iOS 27+
generic            = { ... }   // iOS 26 以下 fallback，純文字欄位（無 strip／background），見下方欄位配置
barcode            = { format, message, displayMessage }  // 見下
```

> template 由 Pass Designer 產出 `.pkpasstemplate`，Pass Builder 在 build 時填入 16 型資料並簽章；iOS 27 讀 `posterGeneric`，iOS 26 以下讀 `generic`。不開 server（見 §10）。

### 樣式（決策 3）

- `posterGeneric`：iOS 27+；滿版背景、primary logo、header／primary／footer、QR；**無 `auxiliaryFields`**。
- `generic`：iOS 26 以下 fallback；與 `posterGeneric` 並存同一 pass，欄位要另外映射。
- `posterGeneric` 正面只有 **1 個 `footerField`**；放兩個以上只顯示第一個。

### 欄位配置（決策 4）

| 區塊 | 放什麼 |
|---|---|
| `headerFields`（右上） | `NO. 0428 · NI-TE` — 型別編號＋主導／輔助功能碼；**代替** `MBTI ID`／`ANALYST`／`DIPLOMAT` 等商標感識別詞 |
| `primaryFields` | ① 四字母型別（`INTJ`，省略 label 取得大字標題）② `BEST MATCH: ENFP` |
| `footerFields` | 留空或品牌字樣（只有第一個會顯示） |
| `backFields` | 免責「entertainment only／玩梗用」＋**簽發組織聯絡資訊**（Apple 審查要求，不可移除） |
| `generic` fallback | 四字母進 `primaryFields`；`NO. 0428 · NI-TE` 與 `BEST MATCH: XXXX` 進 `secondaryFields`／`auxiliaryFields`；`backFields` 同上 |

> `posterGeneric` 本身沒有 Secondary／Auxiliary；Back Fields 必須保留以符合 Apple 聯絡資訊要求。

分享圖（4:5）**不要整張塞進去**；Wallet 的 16 張 `4:5` 主圖是母檔，App 分享（含 IG 限動）沿用，Wallet 另出 @1x／@2x／@3x 與 `logo`／`icon`；`generic` fallback 為純文字，不另做 strip。

### 條碼（決策 5 — 2026-11-21 更新）

- `PKBarcodeFormatQR`，`message` = `https://apps.apple.com/app/id<APP_ID>`。
- **16 張 pass 共用同一個 QR URL**（不需要 per-type URL），因為目的地是產品頁、不是結果頁。
- 代價：已裝 App 的人掃完會到 App Store 頁，要再按一次 `Open`；接受。
- `APP_ID` 是 10 位數字，從 `ids.md` §4 抄（目前仍待填）。**上架前 QR 是死連結，TestFlight 階段不測 QR；填入 `APP_ID` 並上架後才生效。**
- 條碼內容別放可識別個人的資料（見 §5）；QR 可從 `.pkpass` 抽出，視為公開資訊。

### 圖片與本地化（決策 8）

2026-11-21 查證（Apple Pass Design / PassKit Package Format + WWDC26 session 209）：

| slot | @1x | @2x | @3x | 比例 |
|---|---|---|---|---|
| `artwork`（`posterGeneric` 滿版） | 358×448 pt | 716×896 | 1074×1344 | 4:5，16 型各一張 |
| `primaryLogo`（`posterGeneric`） | 30–126×30 pt | 252×60 | 378×90 | — |
| `icon` | 29×29 | 58×58 | 87×87 | 1:1 |
| `logo` | 160×50 | 320×100 | 480×150 | 3.2:1 |
| `thumbnail`（選配） | 90×90 | 180×180 | 270×270 | 2:3–3:2 |

> `icon` 另有 38×38／76×76／114×114 的說法（iOS 18+）；Apple 官方文件仍寫 29×29。先真機驗證——尺寸不合 Wallet 只給通用錯誤，不說是哪個檔。

- **一分設計、多種產出**：16 張主圖以 `1080×1350` 製作；Wallet `artwork` 由主圖縮成 @3x `1074×1344`、@2x `716×896`、@1x `358×448`；分享圖（含 IG 限動）直接用 `1080×1350`。另做 480×150 `logo` lockup 與 87×87 `icon`。`generic` fallback 為純文字（Apple 官方 WWDC26 範例），不另做 strip／橫條圖。
- 文字與編號區要保留乾淨對比度；主視覺集中在下半或側邊，避免被 `headerFields`／`primaryFields` 遮住。
- 分享圖：`4:5 = 1080×1350`（IG 限動背景＋系統分享；Meta 建議 9:16、最小 720×1280，4:5 需實機測），由 App 端 `ImageRenderer` 用同一批 16 張主圖本地合成，無後端。無貼文／Threads 專用尺寸。
- 4:5 圖無官方 UI 安全區；文字與 Logo 收在 10% title-safe（約上下 135px、左右 108px）內。IG 限動與 Wallet poster 都是裁左右，QR 與文字務必留中間 70% 安全區。
- 一律 PNG、依 Apple 規範處理 alpha、提供 @2x/@3x。
- 2 語：放 `l10n/en.lproj`、`zh-Hant.lproj` 的 `pass.strings`，`pass.json` 的 `label`/`description` 走本地化 key；`ja`/`ko` 保留在 App 文案檔，暫不進 pass。
- pass 上無浮水印——跟 `spec.md` §0.5 一致（所有人無浮水印 + 高清）。

### 3.5 16 型對應表（Wallet 用，2026-11-21）

> `BEST MATCH` 採常見互補配對（8 組，16 型全覆蓋）；功能碼為主導／輔助認知功能。編號 0428–0443 為暫定流水號，可整批替換。

| 型別 | 功能碼 | 編號 | BEST MATCH |
|---|---|---|---|
| `INTJ` | NI-TE | 0428 | `ENFP` |
| `ISTP` | TI-SE | 0429 | `ESFJ` |
| `INTP` | TI-NE | 0430 | `ENFJ` |
| `INFJ` | NI-FE | 0431 | `ENTP` |
| `INFP` | FI-NE | 0432 | `ENTJ` |
| `ENTP` | NE-TI | 0433 | `INFJ` |
| `ENFP` | NE-FI | 0434 | `INTJ` |
| `ENTJ` | TE-NI | 0435 | `INFP` |
| `ESTP` | SE-TI | 0436 | `ISFJ` |
| `ESFP` | SE-FI | 0437 | `ISTJ` |
| `ISFP` | FI-SE | 0438 | `ESTJ` |
| `ESTJ` | TE-SI | 0439 | `ISFP` |
| `ISTJ` | SI-TE | 0440 | `ESFP` |
| `ENFJ` | FE-NI | 0441 | `INTP` |
| `ESFJ` | FE-SI | 0442 | `ISTP` |
| `ISFJ` | SI-FE | 0443 | `ESTP` |

- Header 文字 = `NO. <編號> · <功能碼>`，例如 `NO. 0428 · NI-TE`；置右上角，代替商標識別詞。
- `BEST MATCH` 標籤**本地化**（2 語 `pass.strings`）：`Best Match`／`最佳拍檔`；值（四字母）維持原文不翻譯。
- 16 張 4:5 卡片圖（`artwork.png` 358×448pt、@2x 716×896、@3x 1074×1344）依此表命名對應型別；`primaryLogo.png` 30–126×30pt。硬體會裁邊，重要圖案留安全區；`logoText` 不要放（iOS 27 會顯示成「…」）。

---

## 4. App 端整合

1. 目標加 `PassKit` framework；能力/entitlement 依 Apple 現行要求勾選（`Pass Type IDs` 需在 App ID 啟用）。
2. 從 bundle 讀取預簽好的 `.pkpass` → `PKPass(data:)`。
3. 用 `PKAddPassesViewController` 呈現系統加入畫面；可用 `PKAddPassButton` 當 CTA。
4. 流程插入點：`ResultView → ShareView` 多一個「Add to Wallet」按鈕（`QuizView → ResultView → GenerateView → ShareView` 不改順序）。
5. 失敗路徑：`PKPass` 初始化失敗、使用者取消 — 都要有文案，不能靜默。
6. 不取 IDFA、不彈 ATT — 維持 `spec.md` §3 的 `5.1.1(iv)` 路線；PassKit 本身不改變這點。

---

## 5. 更新、IAP、隱私（決策 6、7、9）

### 更新／撤銷（決策 6）
- **首版靜態**：結果不變就不更新，不接 APNs、不做 pass server。
- 日後若要「撤銷／改內容」，才需要 pass server + APNs push（`PKPass` update）——那是另一個專案，別混進首版。

### 跟 IAP 的關係（決策 7）
- Wallet 加入做成**免費功能**。
- 理由：`$2.99` 的賣點是「去廣告＋無限生成」；Wallet 維持免費（免費用戶看 Rewarded 生成後可存，IAP 無限存），把 Wallet 塞進付費牆只會增加審查要解釋的東西，邊際收益極小。所有人無浮水印、高清。
- 若強想收費，至少要確認不會讓 4.2「功能過少」更嚴重——付費牆越多，審查越問「那免費版到底有什麼」。

### 隱私（決策 9）
- 簽章在 build 機完成 → 結果型別**不離機**，跟 `todolist.md`「答案只在記憶體、不收集不建檔」一致。
- Pass 本身進 Wallet（不在 App 沙盒），`PrivacyInfo.xcprivacy` / 隱私標籤依 Actual 行為填，不要寫「none」後又傳資料。

---

## 6. 上架審查（決策 10）

| 條號 | 風險 | 對策 |
|---|---|---|
| **4.2 / 4.3** | 結果卡進 Wallet 被視為低價值／模板 | 審查備註寫差異點（QR 回訪、2 語、裝置端生成）；加 QR 提升「用途」 |
| **5.1.1** | 隱私標籤與實際資料流不符 | 資料不離機；照 §5 決策填，不寫 none |
| **5.1.1(iv)** | ATT / IDFA 不一致 | 維持不取 IDFA、不彈 ATT |
| 商標 | pass 內文字、`description` 含 `MBTI` | 跟 `spec.md` §4 紅線一致：不出現商標，只寫「玩梗用」／entertainment only |
| 的智慧財產 | 分享圖／Logo 版權 | 用自家生成素材，不放平台 logo |

- 審查備註（Review Notes）要主動寫：什麼是 Wallet pass、怎麼取得、QR 連到哪、為什麼不是票券卻放 Wallet。
- 文案紅線沿用 `spec.md` §4：不寫「精準／科學／準確率 X%」，加 `entertainment only`。

---

## 7. 與現有鎖定規格的衝突對照

| 現有規格 | 衝突點 | 化解 |
|---|---|---|
| 零伺服器／固定成本 ~$111/年（`spec.md` §2、§1.5） | 簽章需要憑證與工具鏈 | 預簽打包：build 機完成，零 server、零月費 |
| 全裝置端、答案只在記憶體（`todolist.md`） | 簽章在 build 機完成 | 一致，無資料外傳 |
| 分享 `4:5` `ImageRenderer`（決策 11） | Wallet 版型不同 | 沿用 16 張 4:5 主圖，欄位另外映射（見 §3） |
| 2 語同版／無浮水印（§0.5） | pass 也要 2 語 | `l10n` 兩套，無浮水印 |
| IAP `$2.99` 去廣告＋無限生成（§0.5） | 怕 Wallet 被算進付費牆 | 做免費（免費用戶看 Rewarded 生成後可存），見 §5 |
| `13+` / 不取 IDFA（§3） | PassKit 不改變這些 | 維持現狀 |

---

## 8. 驗收與阻擋條件

### 文案紅線（違反就不做）
- pass 任何欄位／圖片／`description` 不出現 `MBTI` / `Myers-Briggs` / `16Personalities` / `Enneagram`。
- 右上角識別標籤用**編號**（`NO. 0428 · NI-TE`），不可用 `MBTI ID`／`ANALYST`／`DIPLOMAT` 等商標感詞。
- 不寫「精準／科學／準確率／很準」；只寫「玩梗用，非心理診斷」＋`entertainment only`。
- 不放其他平台 logo、不標價。

### 阻擋條件（缺一不送審）
1. §0.5 決策 1–11 全填完，尤其決策 2（簽章端）與決策 9（隱私定位）不能互相打架。
2. `Pass Type ID` + certificate + private key 已建立且可成功簽出 `.pkpass`。
3. 2 語 `l10n` 齊、無浮水印、2 語切換無截斷。
4. `PKAddPassesViewController` 實機（含無網路情境）跑通，加入後 Wallet 顯示正確。
5. 審查備註已寫差異點、QR 去向、免責位置。
6. 隱私標籤／`PrivacyInfo.xcprivacy` 與實際資料流一致。

---

## 9. 常見卡點

- 「能不能直接在 App 裡簽 pass？」→ 不能，私鑰不能進 App；只能在 build 機預簽（§2）。
- 「把分享圖直接轉 pass？」→ 不行；背景可沿用，但欄位與尺寸是 Wallet 專屬（§3）。
- 「沒網路就加不了？」→ 不會；預簽打包可離線加（§2）。
- 「Wallet pass 要更新嗎？」→ 首版靜態就好，別碰 APNs（§5）。
- 「從 Wallet 按 Share 能直接發 IG 限動嗎？」→ **不能**。Apple 官方（support.apple.com/en-us/111112）只支援把 pass 傳給其他 iPhone／Apple Watch 使用者（AirDrop／訊息／郵件），不會自動轉成圖片，也不會出現 IG 選項。要發 IG 限動必須由 App 用 Meta `instagram-stories://share?source_application=<FB_APP_ID>` 傳同一張 4:5 圖（見 `ids.md`／`todolist.md`）。
- 「審查會不會嫌功能奇怪？」→ 加 QR 用途 + 寫差異點（§6）。

---

## 10. 預簽打包的性質、能做／不能做、NFC

**已定案：§0.5 決策 2 = 預簽固定 pass 打包。** 以下直接從這個選擇推導。

### 10.1 你會面對的「性質」（不是 bug，是這個做法的本質）

| 性質 | 白話 | 影響 |
|---|---|---|
| 靜態、不可個人化 | build 時就簽死 | 只放固定 Header 編號＋Primary 四字母與 BEST MATCH；無個人化欄位 |
| `serialNumber` 全型共用 | 所有 INTP 同一張、同一號 | 不能追蹤單人、不能撤銷單張；再加一次 Wallet 視為同一張，不會累積 |
| 不能更新／撤銷 | 沒有 APNs、沒有 pass server | 內容要改只能發新版 App 重新簽、重新送審 |
| 憑證有年期 | Pass Type ID certificate 每年 renew | 每年要 renew 並重新 build/sign/送審；已加進 Wallet 的舊 pass 不受影響（以 Apple 現行文件為準） |
| pass 檔可被取出 | 從 App bundle 就能抽出 `.pkpass` | 無法控制轉發；結果卡本來就要給人看，可接受，但 QR 內容別放敏感資料 |
| 離線可加 | 不需要網路 | 優點：飛機上也能加，且資料不離機 |
| 語言由 Wallet 決定 | pass 走 `l10n`，不是 App 內語言 | 系統 `en` 但 App 用 `zh-Hant` → pass 出 `en`；`pass.json` 預設值要寫 `en`（跟 `Base=en` 一致） |
| 除錯點少 | 簽章／manifest hash／憑證任一錯 → `PKPass(data:)` 直接失敗 | build 時加一道「簽完先實機加一次」檢查 |
| 不能 A/B | 內容跟 build 綁死 | 改文案就要發版 |

> 一個 pass 可內含 2 語 `l10n`，所以只要 16 張；前提是 `logo`／`icon` 用**不含文字的圖形**，文字走欄位。

### 10.2 能做 / 不能做

**能做**
- ✅ 16 型結果卡加入 Wallet（離線、免 server、資料不離機）
- ✅ 每張 pass 內含 2 語 `l10n`
- ✅ `posterGeneric` 滿版背景＋`generic` 純文字 fallback；沿用 App 內 16 張 4:5 卡片圖（無 strip／9:16／貼文圖）
- ✅ QR 連 App Store 產品頁（16 張共用同一個 URL）
- ✅ 16 張 4:5 卡片圖（單一風格，16 型各一張），由使用者設計
- ✅ `PKAddPassButton` + `PKAddPassesViewController`，由使用者主動同意才加入

**不能做**
- ❌ 個人化文案／日期／unique serial → 要 server，等於推翻決策（無強度欄位）
- ❌ 更新、撤銷、APNs push、點數 → 要 pass server
- ❌ 在 App 裡重新簽章 → 私鑰不能進 App
- ❌ 讀回使用者有沒有加、改他的 Wallet、跨裝置同步狀態 → 碰不到 Wallet 裡的 pass
- ❌ 靜默加入 → 一定要經系統加入畫面

### 10.3 NFC 能不能用？

**簡答：想要的那種（iPhone 感應當卡片）不行；能申請的那種（讀標籤）對本功能沒用。**

| 你說的 NFC 指什麼 | 結果 | 原因 |
|---|---|---|
| iPhone 掏出來「嗶」一下，像悠遊卡／門禁卡（**卡模擬**） | ❌ 拿不到 | 需要 Apple 特殊核發的 **NFC Pass entitlement / Pass Type ID NFC 授權**，只給支付、交通、門禁等合作夥伴；娛樂測驗不會過，也不是自己在 Xcode 勾就能開 |
| `pass.json` 加 `nfc` key 讓 pass 可感應 | ❌ 同上 | 沒有上面的授權，這個欄位等於沒有；不是寫了就生效 |
| App 去讀 NFC 標籤（**Core NFC reader**） | ⚠️ 技術可開，但別加 | Xcode `NFC Tag Reading` capability 免費可勾、要 `NFCReaderUsageDescription`；但我們沒有標籤要讀，審查會問「為什麼讀」，徒增 5.1.1 問題 |
| QR 條碼替代 | ✅ 最終採用 | `posterGeneric` 與 fallback 的 `barcode` 用 `PKBarcodeFormatQR` 連 App Store 產品頁，不需要任何特殊授權 |

> 以 Apple 現行文件／Developer Support 回覆為準。若未來真要走門禁／會員感應，是另一個需 Apple 審核的獨立專案，不要放進本次。

---

## 11. 待填值（只列未定項，其餘決策見 §0.5）

| 項目 | 值 | 影響 |
|---|---|---|
| `Pass Type ID` | 待填（`pass.fastmbti.result`） | 沒有它簽不出 `.pkpass` |
| `Team ID` | 待填 | `pass.json` 必填 |
| App Store 數字 `APP_ID` | 待填（10 位） | QR 上架前是死連結 |

對帳表由 `ids.md` §7 統一維護，本檔不重複一份。

## 12. 待辦（工程）

1. 16 張 `4:5` 卡片圖與 `primaryLogo` 產出（尺寸見 §3 圖片表）；安全區按 10% title-safe。同一張圖供 Wallet poster 與 IG 限動使用；IG 官方建議 9:16、最小 720×1280，4:5 需實機測（見 `todolist.md` §5）。
2. Pass Designer `.pkpasstemplate` + Pass Builder build 端簽章流程。
3. build 機 macOS 27 + Pass Designer 工具鏈確認（若沒有，改手寫 `pass.json` + 開源簽章）。
4. `PKAddPassesViewController` 實機 + 無網路情境測試。
