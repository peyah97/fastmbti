# launch.md — fast mbti 上線時間軸與門檻

> 2026-11-21 建立，2026-11-22 瘦身。
> **本檔唯一職責：時間軸（哪一週做什麼、卡在哪）+ 上線門檻勾選。**
> 規格與理由見 `spec.md`；每一步的逐步操作與進度勾選見 `todolist.md`；題庫見 `quiz/quiz_tree.md`；Wallet 見 `add-to-wallet.md`；widget 見 `widget.md`。
> **先看 §0：啟動前要申請哪些帳號、每個帳號怎麼申請（最久 4–6 週，第一天就啟動）**，再回 §1 看時間軸；ID／憑證怎麼拿見 `ids.md`。
> 週次是相對時間（W0 = 現在），不是絕對日期；卡住的項目並行處理，不要等前一週全做完才開始。

## 0. 啟動前先申請的帳號（W0 第一天就開始，最久的先跑）

> 本節是**唯一**的「申請什麼帳號、怎麼申請」逐步清單。帳號開好後要拿的 `ID`／憑證見 `ids.md`；進度勾選見 `todolist.md` §1–2；為什麼要這些見 `spec.md` §7。
> **順序鐵律**：先啟動 A（Apple Developer）與 C（AdMob 收款 PIN，最久 4–6 週），其餘並行；不要等前一項辦完才開始下一項。

### 0.1 要申請的帳號一覽

| # | 帳號／服務 | 在哪申請 | 最久 | 拿到什麼 | 卡點 | 詳細 |
|---|---|---|---|---|---|---|
| A | Apple Developer Program | `developer.apple.com/programs/enroll` | 個人立即／公司 +1–2 週 | 開發者帳號、`Team ID`、權限 `Admin` | D-U-N-S（公司）、$99/年 | §0.3.A |
| B | App Store Connect | `appstoreconnect.apple.com`（同 A 登入） | 10 分鐘～1 天 | `Apple ID`（10 位）、`SKU`、SBP、Sandbox、DSA | `Bundle ID` 同步等 10 分鐘 | §0.3.B |
| C | AdMob（Google） | `apps.admob.com` | **PIN 郵寄 4–6 週** | `AdMob App ID`、2 個 Ad Unit ID | W-8BEN、銀行、PIN | §0.3.C |
| D | Facebook App（Meta） | `developers.facebook.com/apps` | 10 分鐘 | `Facebook App ID` | Business 基本設定即可 | §0.3.D |
| E | 網域 + 靜態落地頁 | 域名商 + 靜態託管 | 幾小時～1 天 | `https://fastmbti.nobaggage2rome.com`、`app-ads.txt` | DNS 生效、`app-ads.txt` 根目錄 | §0.3.E |

### 0.2 第一天順序：A/C → D/E

1. 先辦 **A**（個人 $99，跳過 D-U-N-S）→ 當天再辦 **B**（同帳號登入）。
2. 同時辦 **C**：註冊 AdMob → 立刻填稅表 + 銀行 → **把 PIN 寄出**（這條最久，先寄先等）。
3. **D / E 並行**，不依附上面任何一項。

### 0.3 各帳號逐步申請

#### A. Apple Developer Program

1. 準備一個專用 Apple ID（可新建；若用既有帳號，確認持有者是你）。
2. 開 `https://developer.apple.com/programs/enroll` → `Start enrollment`。
3. 選 `Individual / Sole Proprietor`（**推薦：立即生效，避開 D-U-N-S**）；要公司名義才選 `Organization`，並先辦 D-U-N-S（見 step 8 備註）。
4. 用 Apple ID 登入 → 填法定姓名、地址、電話（與付款資料一致）。
5. 同意 `Apple Developer Program License Agreement`、`App Store Review Guidelines` 等合約。
6. 付 $99/年（信用卡）→ 收 activation email → 點連結啟用（個人幾分鐘～幾小時；公司要等 D-U-N-S 核對 + 電話驗證，1–2 週）。
7. 啟用後開 `https://developer.apple.com/account` → 確認 `Team` 出現、Membership = `Active`、你的角色 = `Admin`（`Member` 建不了 Identifier，見 `ids.md` §0）。
8. 抄 `Team ID`（`Membership → Team ID`）回填 `ids.md` §7。
   - 公司 D-U-N-S：到 `https://www.dnb.com/duns-number/get-a-duns.html` 免費申請（1–2 週），拿到 9 位數字再回 step 3 選 `Organization`；`Organization` 另需公開網站 + 專用企業信箱。
   - Wallet 的 `Pass Type ID pass.fastmbti.result` 同在此站建，逐步見 `add-to-wallet.md`。

#### B. App Store Connect（與 A 同一組登入）

1. 開 `https://appstoreconnect.apple.com` → 用 A 的 Apple ID 登入 → 接受第一次跳出來的開發者附屬合約。
2. `Users and Access` → 確認自己 `Access = Admin` 或 `Account Holder`。
3. `Agreements, Tax, and Banking` → 接受 `Paid Applications` 合約（IAP 要收錢必須）；收款人英文名 = 銀行帳戶名（同 §0.3.C step 4 規則）。
4. 申請 **SBP（Small Business Program）**：`App Store → Small Business Program → Apply`；年收入 < $1M 適用，手續費 15% 而非 30%，上線前送出（見 `spec.md` §7.3）。
5. 建 **Sandbox tester**：`Users and Access → Sandbox → Testers → +`；用一個沒被用過的 Apple ID（不能是開發者帳號本身），地區選非中國區；用來測 IAP `Restore Purchases`（見 `ids.md` §6）。
6. **EU DSA 宣告**：`App Information → Trader Status` 填 `non-trader`，否則歐盟下架（見 `spec.md` §3）。
7. 等 A 的 `App ID` 建好（`ids.md` §2）再回來建 App 記錄：`Apps → + → New App`，`Name = fast mbti`、`Primary Language = English (U.S.)`、`Bundle ID = app.fastmbti.ios`、`SKU = fastmbti-001`；下拉選不到 `Bundle ID` → 等 10 分鐘再進（見 `ids.md` §8）。
   - 本步只到「拿到 10 位 `Apple ID`」；分級 / 隱私標籤 / 價格送審前再補，逐步見 `todolist.md` §2。

#### C. AdMob（含收款，最久）

1. 開 `https://apps.admob.com` → 用 Google 帳號註冊為 publisher；**持有人身份要與 Developer Website 網域持有人一致**（見 `ids.md` §5）。
2. 進 `Agreements` 完成註冊（地址 / 電話 / 稅務）。
3. **稅表 W-8BEN**（個人，3 年效期，過期會 hold）：`Payments → Tax settings` → 選非美國個人 / 獨資 → 填台灣資料 + 簽名送出（見 `spec.md` §7.2）。
4. **收款銀行**：`Payments → Payment settings` → 收款人英文名須與銀行帳戶名完全相同（不符退回）；SWIFT / 中轉行先向銀行確認（錯一次扣 $15–40）；建議美元帳戶。
5. **地址 PIN（先寄）**：`Payments → Verify your address` → 確認地址無誤 → 送出，郵寄 **4–6 週**；收到後依期限上線輸入，沒驗會 hold 付款（見 `spec.md` §7.2）。
6. 再回 `Apps → Add App` 建 App、拿 `AdMob App ID` 與兩個 Ad Unit ID —— ID 逐步見 `ids.md` §5（本節只管「帳號 + 收款可達」）。
7. 付款門檻 $100、第一次出帳通常上線後 2–3 個月；把「小 app 跑通第一次出帳」當獨立里程碑（見 `spec.md` §7.2）。

#### D. Facebook App（IG 限動分享強制）

1. 開 `https://developers.facebook.com/apps` → `Create App`。
2. 用途選 `Other` / `Business` 皆可 → 填 `App Display Name = fast mbti`、`App Contact Email` → `Create App`。
3. 進 `Settings → Basic` → 填 `Display Name`、`Contact Email`、`Category`（生活方式 / 娛樂），`App Domains` 留空或填落地頁網域 → `Save Changes`。
4. 抄頂端 `App ID` 回填 `ids.md` §7；分享用 `instagram-stories://share?source_application=<FB_APP_ID>`（見 `todolist.md` §5）。
5. **不用**跑完整 App Review，`Basic settings` 填完即可（見 `ids.md` §0 第 6 項）；2023 起 Meta 強制，缺它 IG 限動會顯示「此 App 不支援」。

#### E. 網域 + 靜態落地頁 + app-ads.txt

1. 在既有 `nobaggage2rome.com` 加子域 `fastmbti`，或向域名商註冊 → DNS 指向靜態託管（GitHub Pages / Cloudflare Pages 等）。
2. 部署四個檔案：
   - `index.html`：說明頁（娛樂免責、non-affiliated 聲明）
   - `privacy.html`：隱私政策（含廣告、AI 生成說明）
   - `support.html`：支援頁
   - `app-ads.txt`：放**網域根目錄**，內容 `google.com, pub-XXXXXXXXXXXXXXXX, DIRECT, f08c47fec0942fa0`
3. 此網域 = App Store Connect 的 `Developer Website`（`app-ads.txt` 驗證與 `5.2.1` 一致性都看它，見 `spec.md` §7.1）。
4. 落地頁**不加任何分析 / tracker**，否則推翻「不收集」的隱私標籤（B4，見 `spec.md` §3）。
5. 驗收：`https://fastmbti.nobaggage2rome.com/app-ads.txt` 瀏覽器可抓到；回填 `ids.md` §7。

### 0.4 申請完成驗收（全部回填 `ids.md` §7）

- [ ] A 啟用、`Team ID` 已知、角色 `Admin`
- [ ] B 有 10 位 `Apple ID`、SBP 已送、Sandbox tester 可登入、DSA 已填
- [ ] C 稅表已送、銀行已填、**PIN 已寄出**、AdMob App ID + 2 Unit ID 已知
- [ ] D `Facebook App ID` 已知
- [ ] E 網域可達、`app-ads.txt` 可抓、與 `Developer Website` 一致

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
