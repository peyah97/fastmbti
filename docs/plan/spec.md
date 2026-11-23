# fast mbti — 產品規格、變現與上架限制

> 2026-11 版。eCPM 為公開 benchmark 區間（估算，非報價）；實際以 AdMob 後台為準。
>
> **本檔唯一職責：產品與變現決策、上架法規、風險。** 它是**唯一規格來源**，其他檔只准引用、不准重述。
> 分工：時間軸與門檻勾選在 `launch.md`，進度與步驟在 `todolist.md`，題庫在 `quiz/quiz_tree.md`，Wallet 在 `add-to-wallet.md`，widget 在 `widget.md`，句子庫在 `quotes.md`，憑證與 ID 在 `ids.md`。
> 衝突時**以本檔為準**，並直接修訂本檔。

## 0. 結論

1. 首發只接 **AdMob 一家、只做 rewarded 一種格式**。不要一開始上 AppLovin MAX / LevelPlay 中介。
2. 這個 app 的終身價值約 **US$0.020–0.093 / 安裝（基準 $0.048）**。一個 US$2.99 付費用戶 ≈ 262 個免費用戶的廣告收入 → 調價與轉換率比換廣告網更值錢。
3. **不能買量**。US CPI 約 $1–3，LTV $0.05，虧 20 倍以上。成長只能靠分享迴圈 + ASO。
4. 上架最大兩個坑不是廣告，是 **商標**（MBTI / Myers-Briggs 不可入名、不可入 keyword）與 **4.2 / 4.3**（quiz app 被當模板 / 最小功能不足）。

## 0.5 已鎖定規格（之後改動要改這張表）

| 項目 | 決定 |
|---|---|
| 主名 | `fast mbti`（已知含 `MBTI` 商標、風險自負；`Myers-Briggs`、`16Personalities` 不入名、不入 keyword） |
| Bundle ID | `app.fastmbti.ios`（上架前定案） |
| 最低版本 | **iOS 18.0**（不用 17；`iOS 26` 與 `iOS 27 posterGeneric` 專屬 API 只留 `@available` hook；pass 檔靠 `posterGeneric` + `generic` 雙樣式相容，不再拉高最低版本） |
| 語言 | 上架 **`en` / `zh-Hant`** 兩語同版送審（不分批），`String Catalog .xcstrings`，`Base = en`；`zh-Hans`（480 條已寫）、`ja`/`ko` 保留、暫不送審 |
| 測驗 | 決策樹 3–6 題直出 16 型，根 `你奇怪嗎？`，分支即機制，無軸分/強度（題庫、文案與 key 見 `quiz/quiz_tree.md`） |
| 定位 | **純娛樂玩梗**：16 型梗文案＋分享卡；禁寫「精準／很準／MBTI 診斷」 |
| 結果 | 4 字母＋一句梗文案；**無強度、無不穩/亂答標記**；分享卡固定 4 字母 |
| 變現 | AdMob Banner（測驗中 + 結果頁共用 1 unit）+ Rewarded 1 點（`fastmbti_Card_Generate`，結果頁生成卡片）+ StoreKit 2 `$2.99`（去廣告 + 無限生成；單一卡片風格；所有人無浮水印 + 高清；首發直接測，調價條件見 §2） |
| 圖片 | 16 張 `4:5` `1080×1350` 主圖（16 型各一張，由使用者設計；Wallet 與分享共用）；`seed` 只換框／排序；**不另做 9:16／strip／貼文專用尺寸** |
| 分享 | `4:5` `1080×1350`（IG 限動背景＋系統分享；Meta 建議 9:16、最小 720×1280，4:5 需實機測），`ImageRenderer` 依 `Locale` 出字；所有人移除浮水印、高清；無貼文／Threads 專用尺寸 |
| 平台 | iPhone + iPad；`Designed for iPad` 可上 Mac，**不做** Catalyst / 原生 macOS |
| 地區 | 首發**不開中國區**，不買量 |

## 1. 廣告來源（iOS、US、rewarded video）

eCPM = 每千次「完成觀看」你實拿的金額，**已內含聯播網抽成**，不要再扣一次。

| 聯播網 | eCPM 區間 (US iOS) | 填充率 | 上手 | 缺點 | 建議 |
|---|---|---|---|---|---|
| **Google AdMob** | $15–19 | 90–95% | 0.5 天，1 個 SDK | eCPM 不是最高 | **首發唯一** |
| AppLovin MAX | $19–21 | 90% | 2–3 天，要接中介 | SDK 大、隱私揭露多、審查問題多 | DAU > 5k 再加 |
| Unity LevelPlay (ironSource) | $16–17 | 85–90% | 2 天 | 後台複雜、報表難對 | 第二順位中介 |
| Meta Audience Network | $14–15 | 80–90% | 2 天 | 要 FB app、IDFA 依賴重、無 IDFA 掉最多 | 不建議 |
| Vungle / Liftoff | $15–16 | 80% | 2 天 | 以遊戲為主，quiz 填充不穩 | 可選 |
| InMobi / Chartboost | $12–14 | 75–85% | 1–2 天 | 需求弱、eCPM 低 | 跳過 |

### 你實際會拿到的（打折後）

上表是 Tier-1 遊戲受眾。你是 **非遊戲 + 無 IDFA + 全球混合**，實務落點：

| 受眾 | rewarded eCPM |
|---|---|
| 美/英/加/澳 為主 | $9–14 |
| 全球混合（含東南亞） | $4–8 |
| 台灣為主的繁中版 | $3–6 |

### 推薦路線

- **Phase 1（上架～DAU 3k）**：AdMob 單一 SDK；Banner 兩處共用 1 unit（測驗中 + 結果頁底部），Rewarded 1 點 `fastmbti_Card_Generate`（結果頁看一次生成一張卡；單一卡片風格）。目標是「先有收入曲線」，不是最大化 eCPM。
- **Phase 2（DAU > 5k）**：AdMob 當底 + 開 MAX 或 LevelPlay 中介。預期 +15–25% eCPM，即 $300/月 → $345–375/月。設定成本 2–3 天 + 每家一張隱私揭露。
- **Phase 3**：自售 / 直客（品牌聯名心理測驗）才有量級跳躍，但需要業務，不是工程問題。

## 1.5 平台支援與「收不到錢」風險

### Apple 平台支援矩陣（2026-11）

| SDK | iOS / iPadOS | macOS 原生 / Catalyst | tvOS | visionOS |
|---|---|---|---|---|
| **Google AdMob** | ✅ 官方 | ❌ 連結即失敗 | ❌ | 未正式支援 |
| AppLovin MAX | ✅ | ❌ | ❌ | ❌ |
| Unity LevelPlay | ✅ | ❌ | ❌ | ❌ |
| Meta Audience Network | ✅（弱） | ❌ | ❌ | ❌ |
| Vungle / Liftoff / InMobi | ✅ | ❌ | ❌ | ❌ |

**沒有**任何 rewarded SDK 支援原生 macOS。Apple 自己也不對第三方 App 賣廣告版位（Search Ads 是買量，不是變現）。

### macOS 的三條路

| 做法 | 廣告收入 | 成本 | 建議 |
|---|---|---|---|
| 不開 Mac 版 | — | 0 | **首發就這樣** |
| 「Designed for iPad」上 Mac（同一份 iOS binary） | AdMob 照常 | 幾乎 0，勾選即可 | 想覆蓋 Mac 就選這條 |
| Mac Catalyst / 原生 macOS | 只能條件編譯掉 SDK → 零廣告，只剩 IAP | 高 | 不要 |

Catalyst 版若要過編譯，必須 `#if !targetEnvironment(macCatalyst)` 包掉 AdMob；等於 Mac 版只賣 $2.99，而 Mac 使用者付費意願與流量都不足以補這個工。

### 「收不到錢」的四種來源

| 類型 | 實際樣貌 | 誰會中 | 對策 |
|---|---|---|---|
| 政策凍結 | 判定無效流量（IVT）→ 停權、扣留未付餘額 | 所有網，AdMob 最嚴 | 不自刷、不誘導點擊、不疊廣告、帳號資料與 App Store 一致 |
| 技術性卡住 | 稅表過期、地址 PIN 未驗、銀行名不符、匯款退回 | 新手最常中 | 上線前跑完 §7 |
| 需求消失 | 填充率崩、eCPM 掉 → 有位置沒廣告 | 小網、單一地區 | 選需求最深的網 + 之後接 mediation |
| 網商退出 | 整併、停止 publisher 業務 | 小型網 | 只用 Tier-1 |

### 風險排序（付款可靠度 × 停權寬鬆度 × 填充）

| 聯播網 | 付款 | 停權風險 | 填充 | 綜合 |
|---|---|---|---|---|
| **Google AdMob** | 最穩（月結、$100） | 高（連坐整帳號） | 最高 | **首發首選** |
| AppLovin MAX | 穩 | 中 | 高 | 備援首選 |
| Unity LevelPlay | 穩 | 中 | 中 | 第二備援 |
| Meta Audience Network | 穩 | 低 | 低 | 不建議 |
| 小網（Chartboost / InMobi / Pangle） | 不穩 | 中 | 低 | 跳過 |

結論：**「付款最穩」和「停權最鬆」不在同一家**。要同時拿到，只能做兩層：AdMob 打底 + 一家備援走 mediation（同一份流量、不重複曝光）。

### 技術面 2026 兩個坑

- **CocoaPods 2026-12-02 起唯讀**，AdMob 不再發新版到 CocoaPods → 一律用 SPM。
- Xcode 27 要求 deployment target ≥ iOS 15；AdMob SDK 仍支援 iOS 13 → 用 CocoaPods 會 build 失敗。SPM 沒這問題。

## 2. 利潤模型

### 每 1,000 次安裝的終身收入

假設：iOS only、**`en` + `zh-Hant` 混合**、organic + IG 分享；每人 rewarded **1.0–1.2 次**（只有「結果頁生成卡片」一個點，基準 1.1）；IAP $2.99（首發直接測）、SBP 15% → 淨 $2.54。

語言組成（假設值，上線後用 App Store Connect 的地區報表校正）與加權 eCPM：

| 語言 | 安裝占比 | rewarded eCPM | 加權 |
|---|---|---|---|
| `en` | 80% | $10 | $8.0 |
| `zh-Hant` | 20% | $4 | $0.8 |
| **混合** | 100% | **≈ $8.8** | |

| 情境 | rewarded 次數/人 | eCPM | 廣告 | IAP 轉換 | IAP | 合計 | 每安裝 |
|---|---|---|---|---|---|---|---|
| 悲觀 | 1.0 | $4.5 | $4.5 | 0.6% | $15.2 | $19.7 | $0.020 |
| **基準** | **1.1** | $8.8 | $9.7 | 1.5% | $38.1 | **$47.8** | **$0.048** |
| 樂觀 | 1.2 | $14 | $16.8 | 3.0% | $76.2 | $93.0 | $0.093 |

→ 10 萬安裝：**$2.0k / $4.8k / $9.3k**（終身，非每月）
→ 穩定 1 萬新安裝/月：約 **$480–930/月**（含留存尾巴）

### 固定成本與損益兩平

| 項目 | 年費 |
|---|---|
| Apple Developer | $99 |
| 網域 + 靜態頁 | ~$12 |
| 伺服器 | $0（全裝置端） |
| **合計** | **~$111** |

- 損益兩平：**約 2,300 次安裝**（悲觀 5,550、樂觀 1,200）。
- 也就是說：**賣 44 份 IAP 就打平一年成本**（44 × $2.54 = $112 > $111），之後全是淨賺。風險不在虧錢，在「量不夠」。

### 兩個關鍵比率（定價決策的唯一出處）

- **一個 $2.99 用戶 = 約 289 次 rewarded 觀看 = 約 262 個免費用戶**（混合 eCPM $8.8、每人 1.1 次）。
- 所以：每 1 萬安裝把轉換率從 1.5% 拉到 2.5%，等於多約 2.9 萬次 rewarded 觀看。**定價與付費牆設計的槓桿 > 換廣告網**。
- **首發直接測 $2.99**，淨 $2.54，同樣 1.5% 轉換 → 每千安裝 IAP $38（+50%）。**降價門檻：實測 <1.3% 才降回 $1.99；>2.5% 可測 $3.49。**

### 為什麼不能買量

| | 數值 |
|---|---|
| US ASA / Meta CPI（quiz、utility） | $1–3 |
| 你的 LTV | $0.02–0.12 |
| 結論 | 每買一個虧 $0.9–3 |

唯一可買的情形：**品牌字防守**（$0.2–0.5 CPI）或已驗證 K-factor > 0.6 後的小額測試。

### 廣告收入 vs IAP 的稅務差異

- 廣告：Apple 不抽，eCPM 全額是你的（Google 抽成已內含）。但**美國來源所得可能被預扣 30%**（台灣與美無租稅協定，以稅表為準）。
- IAP：Apple 抽 15%（SBP，年收入 < $1M）或 30%。
- 實務：**廣告的邊際淨額比 IAP 高**，但單價低太多，兩者都要，不是二選一。

## 3. 蘋果上架限制（會被打回的 11 條）

| 條號 | 你會踩什麼 | 對策 |
|---|---|---|
| **5.2.1** | `Myers-Briggs`、`16Personalities`、`Enneagram` 入名或 keyword → 商標侵權直接拒 | 名稱已定 `fast mbti`（風險自負）；subtitle / keywords / 描述只用描述性詞：`personality types`、`16 types`、`type quiz`，並加「not affiliated with …」 |
| **4.3** | 心理測驗屬高度飽和類別，被判定 spam / template | 審查備註寫差異點：小光點路線動畫、3–6 題決策樹、裝置端生成圖片、seed 唯一、無雲端；附 30 秒 demo |
| **4.2** | 「3–6 題決策樹 + 分享 + 一組圖」可能被認定功能過少 | **不補功能，維持小 app**（使用者：「小遊戲就是要小小的」）；被退再補 16 型圖鑑／結果解釋頁 |
| **3.1.1** | 去廣告 / 無限生成用非 IAP 途徑（外部連結、解鎖碼） | 一律 StoreKit 2；必須有 **Restore Purchases** 按鈕；IAP 要跟版本一起送審 |
| **5.1.1 / 5.1.2** | 隱私標籤寫「不收集」但裝了 AdMob → 與 SDK 行為不符 | 必填：`Identifiers → Device ID`、`Usage Data → Advertising Data`、`Diagnostics`，用途 Third-Party Advertising |
| **2.3.3 / 2.3.14** | 截圖是合成圖、不是 app 畫面；素材寫「#1」「最準」或標價 | 截圖必須真機畫面；新規 2.3.14（2026-10）禁止價格、不可驗證宣稱、其他平台 logo |
| **2.3.6 / 年齡分級** | 還寫 12+。新制只有 4+/9+/13+/16+/18+ | 誠實回答新問卷（含 Advertising 能力）；要 13+ 就手動調高 |
| **2.5.19** | 送審版本藏功能、過審後遠端開啟（2026-10 新條文） | 送審內容 = 上線內容；A/B 只能調文案與顏色，不能開關功能 |
| **1.1.6 / 2.3.1** | 宣稱「科學心理測驗」「準確率 90%」 | 全站寫 entertainment only、not a psychological assessment |
| **4.7 / 1.2** | 若日後加「社群畫廊」→ 觸發 UGC 三件套（過濾 / 檢舉 / 封鎖） | 首發不要做畫廊；只做系統分享 |
| **5.1.1(iv)** | ATT 與 IDFA 不一致（宣告不用卻取） | 明確走「非個人化廣告」：不取 IDFA、不彈 ATT、`NSPrivacyTracking=false` |

### 其他硬限制

- **Xcode 26.x / iOS 26 SDK**：2026-04-28 起強制；**本專案 deployment target 是 `iOS 18.0`**（SDK ≠ 最低版本，不要為此把最低版本拉到 26）。
- **Privacy Manifest**：`PrivacyInfo.xcprivacy` 要含 `UserDefaults` 的 required-reason（App 本體 `CA92.1`；widget 走 App Group 時另見 `widget.md`）；AdMob 自帶 manifest 會合併。
- **匯出合規**：只用 HTTPS → `ITSAppUsesNonExemptEncryption = NO`，省一輪問答。
- **EU DSA**：App Store Connect 要宣告 trader / non-trader，否則歐盟下架。
- **中國區**：要工信部 App 備案 + 網域 ICP，首發**不開中國區**。
- **美國州法（2027）**：加州 / 猶他 / 路易斯安那的 App Store Accountability Act 生效後，13+ 且觸及未成年需接 Declared Age Range API。現在不用做，先別把年齡分級設成 18+。
- **截圖尺寸**：6.9"（1320×2868）與 6.5"（1242×2688）各一組即可，不必做 6.7"。
- **App Preview**：15–30 秒、必須是 app 實錄（2.3.4）。

## 4. 文案紅線（違反任一項就不上架）

- 不出現 `MBTI`、`Myers-Briggs`、`16Personalities`、`Enneagram`（名稱、subtitle、keywords、描述、截圖、App 內都算）。
- 不寫「精準」「科學」「準確率 X%」「很準」；只寫「玩梗用，非心理測驗」＋ `entertainment only`。
- 圖片不得合成、不得標價、不得放其他平台 logo。
- 商店截圖與 metadata 不出現粗口（`2.3.8`）。

> 現名 `fast mbti` **含 `MBTI` 註冊商標**（權利人 The Myers-Briggs Company）；已向使用者告知風險，使用者決定採用、不找律師、風險自負。`https://fastmbti.nobaggage2rome.com/app-ads.txt` 待人工確認是否已佈署。

## 5. 送審阻擋條件（定義 B1–B9）

> 勾選框與門檻數字住 `launch.md`；本節只寫**定義與理由**。

| 編號 | 條件 | 為什麼 |
|---|---|---|
| **B1** | 商標風險已告知並接受，文件留痕 | 名稱含 `MBTI`；出事時要能證明是知情決定 |
| **B2** | `app-ads.txt` 抓取成功，`Developer Website` 與網域一致 | AdMob 驗證失敗 = 沒收入；`5.2.1` 也看網域一致性 |
| **B3** | `Restore Purchases` 實測通過，IAP 隨版本一起送審 | `3.1.1` 硬性要求；單獨補 IAP 會被退 |
| **B4** | 隱私標籤與 AdMob 實際行為相符（`Device ID` + `Advertising Data`） | `5.1.1` 不符直接退件，不是警告 |
| **B5** | 分級為 `13+`（不是已廢的 `12+`） | 新制只有 4+/9+/13+/16+/18+；含廣告能力要誠實回答 |
| **B6** | 2 語切換後任一畫面無截斷（`ViewThatFits` 過） | `en` 膨脹 40% 是實際會爆的地方 |
| **B7** | 16 張 `.pkpass` 預簽成功、實機加入 Wallet；`generic` 純文字 fallback 正常 | Pass 簽章或 manifest 任一錯就加不進去；iOS 26 以下只認 `generic` |
| **B8** | widget 三處同一天同一句；extension 有自己的 `PrivacyInfo.xcprivacy` | `2.5.18` 零廣告、manifest 缺會收 `ITMS-91053` |
| **B9** | 句子庫 2 語逐句六條驗收＋兩反應測試通過；IG 限動 4:5 實機測通過 | 句子是 widget 的內容來源；Meta 建議 9:16，4:5 要確認不被裁到 QR |

> 前五項需要 App 與 App Store Connect 權限才能實測；`app-ads.txt` 目前仍待確認佈署。

## 6. 風險與對策

| 風險 | 機率 | 影響 | 對策 |
|---|---|---|---|
| 4.3 被判 spam | 中 | 延 2–4 週 | 差異點備註 + demo 影片 + 圖鑑功能 |
| 商標被申訴 | 低–中 | 下架 | 名稱已避開；關鍵字與描述也避開 |
| 隱私標籤不符 | 中 | 退件 | 照 SDK 行為填，不寫「none」 |
| eCPM 遠低預期（$3–5） | 高 | 收入腰斬 | 先看地區組成，再加 mediator |
| 下載量不足（< 2k） | 高 | 打不平成本 | 分享迴圈 + TikTok/Reels 素材，不買量 |
| IAP 轉換 < 1%（$2.99 實測） | 中 | 少一半收入 | 付費牆時機（結果頁「生成卡片 / 去廣告」並列）；調價條件見 §2 |
| **決策樹僅 3–6 題，4.2 最小功能風險上升** | 中 | 被判模板/spam，延 2–4 週 | **不補功能，維持小 app（2026-11-21 定案）**；被退再補圖鑑／解釋頁；備註寫明決策樹 + 裝置端生成 |
| **16 型映射是玩梗，非心理計量** | 高 | 「不準」負評 | 全站 entertainment only；禁寫「精準／很準／MBTI 診斷」；結果頁與分享卡只給 4 字母＋梗文案 |
| **`en`/`zh-Hant` 文案品質差** | 中 | 一星、退貨 | `zh-Hant` 人工寫；`en` 母語者校對；梗改寫不直翻 |

## 7. 帳號、AdMob 與收款要求（單一出處）

### 7.1 AdMob 設定（漏了會直接沒收入）

1. `app-ads.txt` 放在**開發者網站網域根目錄**，且 App Store 列表的 Developer Website 必須是同一個網域。
2. `Info.plist` 加 `GADApplicationIdentifier` + Google 的 `SKAdNetworkItems`（否則 iOS 歸因失效、出價下降）。
3. 廣告單元先全用**測試 ID** 驗證，正式上線才切換。
4. 設 `MaxAdContentRating = G`，封鎖敏感類別。
5. EEA/UK 用 Google UMP 取同意；美國州別提供 opt-out。
6. 不要標「child-directed」（不進 Kids 類別），否則個人化廣告關閉、eCPM 腰斬。
7. 付款門檻 $100、填稅表（W-8BEN）、地址 PIN 驗證，第一次撥款會慢 1–2 個月。

### 7.2 收款前必做 6 項（漏一項就收不到）

1. 稅表 W-8BEN（3 年效期，過期會 hold）。
2. 地址 PIN 驗證（郵寄 4–6 週，**先寄**）。
3. 收款人英文名 = 銀行帳戶名（不符會被退回）。
4. 銀行 SWIFT / 中轉行資料向銀行確認（錯一次扣 $15–40）。
5. 幣別與匯損：多為美元電匯，評估用美元帳戶收款。
6. **先讓一個小 app 跑完第一次出帳**，確認整條鏈路通了，再接主力 app。

> 第一次出帳通常在上線後 2–3 個月。把「驗證收款」當成獨立里程碑，不要等到有量才發現卡住。

### 7.3 帳號與法務

1. Apple Developer Program：個人 $99/年（立即）或公司要 D-U-N-S（多 1–2 週）；權限要 `Admin`（`Member` 建不了 Identifier）。
2. SBP（Small Business Program）上線前送出，手續費 15% 而非 30%。
3. 網域 + 靜態落地頁（只放說明與隱私/支援，不加分析，否則推翻「不收集」）+ `app-ads.txt`。
4. 隱私政策頁 + 服務條款頁（2 語；含廣告、娛樂免責、AI 生成說明）。
5. `EU DSA` 宣告 trader / non-trader。
