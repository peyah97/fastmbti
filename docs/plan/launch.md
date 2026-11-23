# launch.md — fast mbti 上線時間軸與門檻

> 2026-11-21 建立，2026-11-22 瘦身。
> **本檔唯一職責：時間軸（哪一週做什麼、卡在哪）+ 上線門檻勾選。**
> 規格與理由見 `spec.md`；每一步的逐步操作與進度勾選見 `todolist.md`；題庫見 `quiz/quiz_tree.md`；Wallet 見 `add-to-wallet.md`；widget 見 `widget.md`。
> 週次是相對時間（W0 = 現在），不是絕對日期；卡住的項目並行處理，不要等前一週全做完才開始。

## 1. 時間線總覽

| 週 | 主題 | 產出 | 卡關風險 |
|---|---|---|---|
| W0 | 帳號法務起跑（最久）+ ID 取得 | Developer / AdMob / IAP / Facebook App 帳號、網域落地頁 | D-U-N-S、稅表、PIN 郵寄 4–6 週 |
| W1 | Xcode 專案 + 2 語 catalog + 決策樹引擎 | 可跑的 Quiz→Result、90 key 進 catalog（89 題庫 + 1 UI） | 2 語版面膨脹 |
| W2 | 分享卡 + 生成圖 + 廣告 + IAP + Wallet + 句子庫 | `4:5` 分享（IG 限動）、Banner 兩處 + Rewarded 生成卡、Restore 可測、預簽 16 張 pass、句子庫驗收 | AdMob 測試 ID 回調、Pass 簽章 |
| W3 | 商店素材 + 2 語 ASO + 審查備註 + widget | Icon、截圖、描述、keywords、widget target 與 2 語截圖 | 4.2/4.3 被判模板 |
| W4 | QA + 阻擋條件 + 送審 | TestFlight、B1–B9 全過（含 Wallet 加入、IG 限動、widget 三處同句） | 商標、`app-ads.txt`、Restore |
| W5 | 審查等待 + 行銷前置 | 素材排程、落地頁就緒 | 審查 1–7 天（4.3 可能 2–4 週） |
| W6 | 上線 + 7 天指標監控 | App Store 上架、M1–M6 | 崩潰率、填充率 |
| W7+ | 成長迴圈 + 變現優化 | 分享迴圈、ASO 迭代、Phase 2 中介 | eCPM 低預期 |

## 2. 依賴關係（哪些不能並行）

1. W0 的 ID → W1 的 `Info.plist` / StoreKit / AdMob SDK。
2. W1 的 catalog → W2 的結果圖出字。
3. W2 的廣告與 IAP → W4 的阻擋條件。
4. W3 的素材 → W4 的 Review Notes + 送審。
5. W4 送審 → W5 等待 → W6 上線 → W7 成長。

## 3. 送審阻擋（B1–B9，缺一不送審）

> 本節是**唯一**的阻擋勾選處；定義與理由見 `spec.md` §5（B1–B9）。實際操作步驟見 `todolist.md`；Wallet 見 `add-to-wallet.md`，widget 見 `widget.md`。

- [ ] **B1** 商標風險告知與接受留痕（`MBTI` 商標、風險自負）
- [ ] **B2** `app-ads.txt` 抓取成功，`Developer Website` 與網域一致
- [ ] **B3** `Restore Purchases` 實測通過，IAP 隨版本一起送審
- [ ] **B4** 隱私標籤與 AdMob 行為相符（`Device ID` + `Advertising Data`，不寫 none）
- [ ] **B5** 分級 `13+`（新制 4+/9+/13+/16+/18+，`12+` 已廢）
- [ ] **B6** 2 語切換無截斷（`ViewThatFits`，`en` 標題 +40%／按鈕 +30%）
- [ ] **B7** 16 張 `.pkpass` 已預簽、實機加入 Wallet 成功；`generic` 純文字 fallback 顯示正確
- [ ] **B8** widget 三處（`small`／`rectangular`／通知）同一天同一句；extension 有自己的 `PrivacyInfo.xcprivacy`
- [ ] **B9** 句子庫 `en`／`zh-Hant` 逐句六條驗收＋兩反應測試通過；IG 限動 4:5 實機測通過

## 4. 上線 7 天指標（M1–M6）

> 本節是**唯一**的指標門檻數字出處；量測來源與報表切法見 `todolist.md` §上線後。

- [ ] **M1** 崩潰率 < 0.5%
- [ ] **M2** D1 留存 > 20%
- [ ] **M3** rewarded 填充率 > 80%
- [ ] **M4** 決策樹完成率 > 70%
- [ ] **M5** 結果頁到達率 > 90%
- [ ] **M6** `en`／`zh-Hant` 各自報表已建（D1、填充、IAP 轉換分開看）

> 首月**不改廣告頻次**，先建立 baseline；M1–M6 未達標先查地區組成與崩潰 log，不要先動廣告。

## 5. 每週卡點與對策

| 週 | 可能卡住 | 對策 | 詳細 |
|---|---|---|---|
| W0 | D-U-N-S 1–2 週、PIN 郵寄 4–6 週 | 個人帳號先開；PIN 第一天就寄 | `spec.md` §7 |
| W1 | 2 語版面爆、catalog 缺 key | 先跑 89 key 再補 UI key；`ViewThatFits` | `todolist.md` §i18n |
| W2 | AdMob 測試 ID 不回調、StoreKit 沙盒卡 | 測試 ID 固定三組先跑通再換正式 | `todolist.md` §廣告與 IAP |
| W3 | 4.2/4.3 被判模板 | 備註寫差異點 + demo；不補功能 | `spec.md` §3 |
| W4 | 任一 B 項沒過 | 缺哪項補哪項，不要帶傷送審 | 本檔 §3 |
| W5 | 4.3 審查 2–4 週 | 同時備素材與 ASO，不空等 | `spec.md` §6 |
| W6 | 崩潰、填充不足 | 先修崩潰，廣告問題看地區組成 | 本檔 §4 |
