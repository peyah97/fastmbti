# fast mbti — 進度勾選

> **本檔唯一職責：進度。** 只有勾選框與一行動作，不寫規則、不寫數字、不寫理由。
> 規則與決策 → `spec.md`；時間軸與 B1–B9／M1–M6 的數字 → `launch.md`；題庫 → `quiz/quiz_tree.md`；widget → `widget.md`；句子庫 → `quotes.md`；Wallet → `add-to-wallet.md`；ID 對帳 → `ids.md`。
> 勾選代表「做完」，改規則要去改對應的規格檔，不是改這裡。

## 1 帳號與法務（W0）

- [x] 商標風險已告知：採用 `fast mbti`（含 `MBTI`），不找律師、風險自負
- [x] Apple Developer Program（個人 $99／公司要 D-U-N-S；已啟用）
- [x] 權限確認為 `Admin`（個人為 `Account Holder`）
- [x] W-8BEN + 銀行帳戶（Agreements, Tax, and Banking；皆 `Active`）
- [ ] 申請 SBP（Small Business Program）
- [x] AdMob 帳號 + 付款 profile（`nobaggage2rome@gmail.com`、`pub-9603007011739375`、`AdSense (Malaysia)`）
- [ ] AdMob 稅表 `W-8BEN` + 收款銀行
- [x] 地址 PIN：改為收入達驗證門檻才觸發，現階段不需寄
- [ ] 網域 `fastmbti.nobaggage2rome.com` + 靜態落地頁
- [ ] `app-ads.txt` 放網域根目錄，瀏覽器實測可抓
- [ ] 隱私政策頁 + 服務條款頁（2 語，含廣告與娛樂免責、AI 生成）
- [ ] `EU DSA` 宣告 trader / non-trader

## 2 ID 與憑證（W0）

- [x] App ID `app.fastmbti.ios`，只勾 App Groups（`group.app.fastmbti.ios`）與 Pass Type IDs（`pass.fastmbti.result`）
- [x] 簽名 + 產出 `Apple Distribution`（Release 用 `fastmbti_AppStore` profile 手動簽；Xcode 已自動產出 `Apple Development`；Archive 成功）
- [ ] Connect 建 App：`fast mbti`、English (U.S.)、SKU `fastmbti-001`、Lifestyle/Entertainment、`13+`、不開中國區（App 記錄已建，分類／分級待補）
- [x] 抄 10 位 `Apple ID`（`6838271103`）
- [x] AdMob：App ID `ca-app-pub-9603007011739375~7813231080` + Rewarded `fastmbti_Card_Generate`（`/4323423117`）+ Banner `fastmbti_Banner`（`/9237993394`）
- [ ] IAP `com.fastmbti.remove_ads`（Non-Consumable、$2.99）
- [ ] `Facebook App ID`（IG 限動分享強制；Meta 2023 起要求）
- [x] `Pass Type ID` `pass.fastmbti.result` + certificate + 私鑰（憑證已入 login Keychain；私鑰／`.p12` 在 `~/.keys/fastmbti-pass/`，密碼在 Keychain item `fastmbti-pass-p12`）
- [ ] 全部回填 `ids.md` §7 對帳表

## 3 i18n 與 catalog（W1）

- [x] 89 題庫 key 定稿（`quiz/quiz_tree.md` §5）
- [ ] 建 `Localizable.xcstrings`（`sourceLanguage = en`、90 key 起底）
- [ ] 貼 `en`/`zh-Hant` 值，state 全 `translated`
- [ ] `extractionState: manual`
- [ ] 4 個單按鈕 node 的 `o1` 用通用「嗯」按鈕
- [ ] `xcrun xcstringstool print` 驗證 JSON
- [ ] 全字串走 `String(localized:)` / `Text("key")`，禁硬編
- [ ] 數字/日期/時長用 `FormatStyle`
- [ ] 台灣用語（設定／訊息／影片），不用大陸詞（设置／消息／视频）
- [ ] `zh-Hant` 人工寫、`en` 母語者校對
- [ ] `zh-Hans`／`ja`／`ko` 只保留在 catalog，不產 `lproj`
- [ ] `CFBundleLocalizations` 只列 `en`、`zh-Hant`
- [ ] 每頁 `#Preview` 加 `zh-Hant` locale
- [ ] 膨脹測試：標題 +40%、按鈕 +30%，`ViewThatFits`，不寫死 `lineLimit`
- [ ] `ImageRenderer` + `.environment(\.locale, …)`，不預存英文 PNG
- [ ] 翻譯流程走 `xcstrings` → `XLIFF` → `TranslationSession` → 人工複核
- [ ] 商品頁 2 語（subtitle／描述／keywords 各自寫，不直翻）

## 4 決策樹與畫面（W1）

- [ ] Xcode 26.x 建 SwiftUI App，`iOS 18.0` deployment target
- [ ] `QuizEngine`：20 node 轉 Swift 資料（enum id + struct Node）
- [ ] 遍歷 unit test：16 型可達、無孤兒、無迴圈、深度 3–6
- [ ] 進度條不顯示（已定案）
- [ ] `QuizView`（小光點路線）→ `ResultView` → `GenerateView` → `ShareView`
- [ ] 檔案：`QuizEngine`／`QuizProgressStore`／`QuizView`／`ResultView`／`GenerateView`／`ShareView`／`CardUnlockManager`／`OnDeviceGenerator`／`AdBannerView`／`AdsManager`／`StoreManager`／`ShareSheet`
- [ ] node 題目 ≤ 12 繁中字

## 5 分享卡與生成圖（W2）

- [ ] 只做 `4:5` `1080×1350`，4 字母 + 梗文案；不另做 9:16／貼文圖／Wallet strip
- [ ] 16 張主圖（16 型各一張，單一風格）就位；同一張供 Wallet 與 IG 限動使用
- [ ] `seed = hash + time` 選框／排序
- [ ] `UIActivityViewController` + `instagram-stories://share?source_application=<FB_APP_ID>`
- [ ] `Info.plist` 的 `LSApplicationQueriesSchemes` 加 `instagram-stories`
- [ ] IG 限動文案寫「用相機掃 QR」，不寫「點圖下載」（Meta 無 `contentURL` 參數）
- [ ] 4:5 圖進 IG 限動實機測（Meta 建議 9:16、最小 720×1280）
- [ ] 圖只寫 `tmp/`，答案只在記憶體

## 6 廣告（W2）

- [ ] 三組 Google 測試 ID 先跑通（App／Rewarded／Banner）
- [ ] Banner：測驗中 + 結果頁共用 1 unit
- [ ] Rewarded：`fastmbti_Card_Generate`，看一次生成一張
- [ ] `Info.plist`：`GADApplicationIdentifier` + `SKAdNetworkItems`
- [ ] UMP 同意（EEA/UK）+ 美國州別 opt-out
- [ ] `MaxAdContentRating = G`；不取 IDFA、不彈 ATT
- [ ] 獎勵回調成功後才切正式 ID（上線前切）

## 7 IAP（W2）

- [ ] 本機 `.storekit` 跑通購買
- [ ] `Restore Purchases` 按鈕
- [ ] 沙盒買過 → 刪 App → 重裝 → Restore 回來
- [ ] `UserDefaults` 存：`quiz_version`／`ads_removed`／`quiz_progress`（App Group 另存 `result_type` 給 widget、`app_language` 給 App 內語言切換）
- [ ] `quiz_progress` 只存 `currentID` + `path`，重新開始／進結果頁／買 IAP 後清除
- [ ] 不存答題過程、不上傳；只存最終型別（如 `INTJ`）在本機給 widget 用

## 8 隱私（W2）

- [ ] `PrivacyInfo.xcprivacy`：`UserDefaults` required-reason `CA92.1`
- [ ] App Privacy 標籤：`Device ID` + `Advertising Data` + `Diagnostics`
- [ ] `NSPrivacyTracking = false`
- [ ] `ITSAppUsesNonExemptEncryption = NO`
- [ ] `NSPhotoLibraryAddUsageDescription`（僅存圖時彈）

## 9 商店素材與 ASO（W3）

- [ ] Icon 1024×1024（無 alpha、無圓角）
- [ ] 截圖 6.9" + 6.5"，各 4–6 張，真機畫面，`en`／`zh-Hant` 各一組
- [ ] App Preview（選配，必須 app 實錄）
- [ ] 名稱不翻譯；subtitle／描述各自寫（功能 → 分享 → 免責 → 廣告說明）
- [ ] keywords 各 ≤100 字、不含商標
- [ ] 分級問卷（含 Advertising 能力）→ `13+`
- [ ] Review Notes：測試步驟、Banner／Rewarded／IAP 位置、差異點、免責位置

## 10 QA 與送審（W4）

- [ ] 18 條路徑實機各走一遍
- [ ] 舊機測試：iPhone SE 3、iPhone 12（發熱、記憶體）
- [ ] 崩潰率、2 語切換、AdMob 填充、Restore 全測
- [ ] 送審前逐項核對 `launch.md` §3 的 B1–B9
- [ ] Archive → TestFlight 內部 → Review Notes → 送審
- [ ] 正式 AdMob ID 已切換（測試 ID 不能上線）
- [ ] 確認不靠遠端開關功能（送審內容 = 上線內容）

## 11 上線後（W6+）

- [ ] 7 天指標看板建好（門檻數字見 `launch.md` §4）
- [ ] AdMob app 驗證通過、`app-ads.txt` 已抓
- [ ] `en`／`zh-Hant` 報表分開建（D1、填充、IAP 轉換）
- [ ] 首月不改廣告頻次，先建立 baseline
- [ ] 收款驗證當獨立里程碑（第一次出帳 2–3 個月）
- [ ] 分享迴圈與 ASO 迭代開始跑
- [ ] `ja`／`ko` 評估是否開（文案已保留）

## 12 題庫（對照 `quiz/quiz_tree.md`）

- [x] 20 node、18 路徑、16 型全可達
- [x] 89 key 四語表完成、敏感詞全替換
- [ ] 分享卡實機截圖：4 字母 + `text` 不換行、不超框
- [ ] 文案紅線全掃（無 MBTI／精準／很準）
- [ ] 89 + 1 key 進 catalog

## 13 widget（逐步驟見 `widget.md`）

- [x] 前置：`git init`（`c5482ce`）、App Group `group.app.fastmbti.ios`、widget bundle id `app.fastmbti.ios.widget`（Developer Portal 已註冊）
- [x] 骨架：extension target（2026-11-23，`FastMBTIWidget`，含 Embed Foundation Extensions）、App Group capability（主 App 與 widget 都有 entitlements）、版本號一致（1.0 / 1）；`xcodebuild` Debug 模擬器 build 通過
- [x] 實機（2026-11-23／24）：Ahpey（iPhone 15 Pro, iOS 27.2.1）註冊到 Developer、開 Developer Mode、`devicectl` 裝機；主畫面與鎖屏都加得到 widget，顯示 `today's meme`／寫死句子／INTJ／日期，無裁切（§3 step 5）
- [ ] 實機後續：換型後 widget 是否即時更新、飛航模式、低耗電（widget.md §9 測試矩陣）
- [ ] 資料：`FastMBTICore`、句子庫 resources、type 寫入 App Group、固定索引
- [ ] 畫面：`small`、`rectangular`、深色、Clear／Tinted
- [ ] 換句：90 天 entries、60 天重交、偽時間與跨時區測試
- [ ] 通知：權限時機、09:00 排程、關閉開關
- [ ] 合規：`1C8F.1`、extension 自己的 manifest、`2.5.18`（零廣告）
- [ ] 送審：測試矩陣、截圖、TestFlight

## 14 句子庫（對照 `quotes.md`）

- [ ] `en` 480 條逐句跑六條驗收（2026-11-23 已跑衝突／標籤／重複三種檢查並修 25 條）
- [x] `zh-Hant` 480 條照場景卡重寫（2026-11-23，台灣腔 · 嗆 · 最長 22 字、零重複、零簡體詞）
- [ ] `zh-Hant` 480 條逐句驗收（重寫後仍待逐句過六條驗收＋兩反應測試）
- [ ] **硬 gate**：兩反應抽讀（`quotes.md` §12.1，`en`／`zh-Hant` 各 10 條，達標率 ≥ 70%）。**未通過不得進 `xcstrings`**
- [ ] 語氣門檻：`en`／`zh-Hant` 各抽 5 條給使用者確認
- [x] 場景卡 480 張（`quotes.scenes.md`，16 型各 30 張，嘲點角度覆蓋已驗證）
- [ ] 每條標 `spicy`／`clean`
- [ ] 進 `xcstrings`（`quote.<type>.<label>.<idx>`）；**前置：上一條 gate 必須已完成**
- [x] `zh-Hans` 480 條已寫滿（保留不上架）
- [ ] 最長／最短句各 3 條做 `small` 與鎖屏截斷測試
