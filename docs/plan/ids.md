# fast mbti 取 ID 與 Cert 全流程

> **本檔唯一職責：ID／憑證怎麼拿、拿到什麼。** 對帳表在 §7（其他檔不重複一份）；為什麼要這些 ID 見 `spec.md` §7；時間順序見 `launch.md`；進度勾選見 `todolist.md`。
>
> 前提：已有 `Apple Developer` (`dev acc`)。目標：拿到 `BundleID` / `App ID` / `Certificate` / `Provisioning Profile` / `Apple ID` / `AdMob App ID` + 1 個 `Rewarded Ad Unit ID`（`fastmbti_Card_Generate`）+ 1 個 `Banner Ad Unit ID`（`fastmbti_Banner`）/ `IAP Product ID` / `Pass Type ID`。全程 `Xcode 26.x` + `iOS 18.0` target。

## 0. 執行前必確定（缺一就卡住）

| # | 確認項 | 為什麼卡 | 定案值填這 |
|---|---|---|---|
| 1 | 最終 `BundleID` | `App ID` / `Connect` / `AdMob` / `IAP` 全綁它，建錯要重建 | 已鎖：`app.fastmbti.ios`（免網域，`reverse-DNS` 只求唯一，不驗所有權） |
| 2 | `Team ID` + 權限 | 建 `Certificate` / `Identifier` / `Connect App` 要 `Admin` 或 `Account Holder`，`Member` 建不了 | 已確認：`Admin`，`Team ID` = 待填 |
| 3 | 簽名方式 | 自動簽名不用手動管 `Profile`；手動才要 `CSR` + `Profile` 下載 | 已鎖：`Automatic`（`Xcode 26` 自動簽） |
| 4 | `App` 主體資料 | `App Store Connect` 建 App 要 `SKU` + 分級 `13+` + 類別，否則建到一半停 | `SKU` = `fastmbti-001`，`Name` = `fast mbti` 不翻譯 |
| 5 | 網域 + `Privacy URL` | 不擋發證，但擋 `AdMob` 驗證 + `app-ads.txt` + 送審 | 已鎖：`https://fastmbti.nobaggage2rome.com`（子域可用）；`Privacy` = `/privacy`，`Support` = `/support`，`app-ads.txt` 放子域根 |
| 6 | `Facebook App ID` | 2023 起 Meta 強制；沒有它 IG 限動分享會顯示「此 App 不支援」 | 待填（建立一個免費 FB App，Basic settings 填完即可） |

## 1. 定 BundleID（已定案）

- 已鎖：`app.fastmbti.ios`，全小寫、全球唯一即可，不需自有網域。
- 全文件統一使用此 BundleID，不再改。

## 2. 建 App ID — developer.apple.com

1. 開 `https://developer.apple.com/account` → 選對 `Team`。
2. 左側 `Certificates, Identifiers & Profiles` → `Identifiers` → `+`。
3. 選 `App IDs` → `App` → `Continue`。
4. `Description` = `fast mbti`，`Bundle ID` 選 `Explicit` 貼上一步 `BundleID`。
5. `Capabilities` 只勾 **App Groups**（`group.app.fastmbti.ios`，widget 與主 App 共用，見 `widget.md` §2）與 **Pass Type IDs**（`pass.fastmbti.result`，Wallet 用，見 `add-to-wallet.md` §4）；其餘 `Push` / `iCloud` / `Sign in with Apple` / `Associated Domains` 不勾。免費帳號無法用 App Groups，需已繳費的 Developer Program。
6. `Continue` → `Register`。
7. 抄下：`App ID Prefix (Team ID)` + `BundleID`。

驗收：`Identifiers` 列表出現該 `BundleID`，狀態 `Enabled`。

## 3. 拿 Certificate（推自動簽名）

### 3A. 自動簽名（推薦，Xcode 26）

1. `Xcode` 開專案 → `Target` → `Signing & Capabilities` → 勾 `Automatically manage signing`。
2. `Team` 選你的 `Team`。
3. `Bundle Identifier` 貼最終 `BundleID`。
4. 接上任一真機或 `Any iOS Device` 做一次 `Build`，`Xcode` 自動產生 `Apple Development` + `Apple Distribution` 憑證與 `Profile`。
5. 到網站 `Certificates` 確認出現 `Apple Distribution` + 到期日。

### 3B. 手動（只有 CI / 多人共用憑證才用）

1. 本機 `Keychain Access` → `Certificate Assistant` → `Request a Certificate From a Certificate Authority` → 存 `CSR`。
2. 網站 `Certificates` → `+` → `Apple Distribution` → 上傳 `CSR` → `Continue` → 下載 `.cer` 雙擊安裝。
3. `Profiles` → `+` → `App Store` → 選 §2 的 `App ID` → 選上一步 `Certificate` → 命名 `fastmbti_AppStore` → 下載。
4. `Xcode` 切 `Manual signing`，`Provisioning Profile` 選下載檔。

驗收：`security find-identity -v -p codesigning` 看得到 `Apple Distribution: ...`，`Xcode` `Build` 不報 `No signing certificate`。

## 4. 建 App Store Connect 記錄 — 拿 Apple ID

1. 開 `https://appstoreconnect.apple.com` → `Apps` → `+` → `New App`。
2. `Platform` 勾 `iOS`，`Name` = `fast mbti`，`Primary Language` = `English (U.S.)`。
3. `Bundle ID` 下拉選 §2 建好的那個（選不到 = Team 選錯或還沒同步，等 10 分鐘）。
4. `SKU` = `fastmbti-001`（不可重複，之後不改），`User Access` 選 `Full Access`。
5. `Create` → 進 `App Information` 抄數字 `Apple ID (id1234567890)`。
6. `Pricing and Availability` 先留免費 + 首發**不開中國區**；`App Privacy` 之後填（裝了 `AdMob` 必勾 `Device ID` + `Advertising Data`）。

驗收：有 10 位數 `Apple ID`。

## 5. 拿 AdMob ID + 1 Rewarded + 1 Banner Unit

> 2026-11-23 實作結果：AdMob 綁 Google 帳號 `nobaggage2rome@gmail.com`，**付款國家 `Malaysia`（不可改）**，payee `NOBAGGAGE ENTERPRISE`，publisher `pub-9603007011739375`。`peyng97@gmail.com` 曾誤建一個空帳號，已關閉。

1. 開 `https://apps.admob.com` → 用 `nobaggage2rome@gmail.com` 註冊（含稅表 `W-8BEN` + 收款銀行，`$100` 門檻；PIN 改為收入達門檻才觸發）。
2. `Apps` → `Add App` → `iOS` → **`No, the app is not listed on a supported app store`**（上架前）→ `App name` = `fast mbti`；上架後回來 `Link to app store`。
3. 建好進 `App settings` 抄 `App ID`：`ca-app-pub-9603007011739375~7813231080`。
4. `Ad units` → `+` 建兩個 Ad Unit：
   - `Rewarded`：`fastmbti_Card_Generate`（結果頁看一次生成一張卡）
   - `Banner`：`fastmbti_Banner`（測驗中 + 結果頁底部共用）
5. 各抄 `Ad Unit ID`：`ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY`。
6. 初期全用 Google 測試 ID 跑通再切換：
   - `App ID` 測試：`ca-app-pub-3940256099942544~1458002511`
   - `Rewarded` 測試：`ca-app-pub-3940256099942544/1712485313`
   - `Banner` 測試：`ca-app-pub-3940256099942544/2934735716`
7. `Info.plist` 加 `GADApplicationIdentifier` = 上述 `App ID`，加 Google 的 `SKAdNetworkItems`。

驗收：測試廣告能播完拿獎勵回調，正式 ID 已存好未上線。

## 6. 拿 IAP Product ID — StoreKit 2

1. `App Store Connect` → 該 `App` → `Monetization` → `In-App Purchases` → `+` → `Non-Consumable`。
2. `Product ID` = `com.fastmbti.remove_ads`（與 `BundleID` 前綴一致，鎖死不改）。
3. `Reference Name` = `Pro Bundle - Remove Ads & Unlimited Cards`，Display Name = `去廣告＋無限生成` / `No Ads & Unlimited Cards`，Description = `永久移除所有廣告，享無限次生成與儲存結果卡片，並可加入 Apple Wallet。`；價格與調價條件見 `spec.md` §2，審核圖截付費牆。
4. 本地先建 `StoreKit Configuration (.storekit)` 同 `Product ID` 跑通購買 + `Restore Purchases` 按鈕，再隨版本一起送審（`3.1.1` 要求）。
5. `UserDefaults` 存 3 key：`quiz_version`、`ads_removed`（`Bool`）、`quiz_progress`（`currentID` + `path`，重新開始／進結果頁／買 IAP 後清除）；不存答案內容或結果型別。

驗收：沙盒帳號買過 + 刪 App 重裝按 `Restore` 能回來。

## 7. 收尾對帳（一行過）

- `BundleID` = `app.fastmbti.ios`
- `widget BundleID` = `app.fastmbti.ios.widget`（已註冊，App Groups ✓；IAP 為 Apple 強制鎖定、widget 不呼叫 StoreKit）
- `App Group` = `group.app.fastmbti.ios`（已註冊並指派給 App ID 與 widget App ID）
- 主 App ID capabilities：App Groups ✓、In-App Purchase ✓、Wallet ✓（2026-11-23 於 Developer Portal 補勾）
- `Pass Type ID` = `pass.fastmbti.result`；Pass certificate `fast mbti Pass`（到期 2027-12-23）已匯入 login Keychain；私鑰／`.p12` 在 `~/.keys/fastmbti-pass/`（不進 repo），`.p12` 密碼存 Keychain item `fastmbti-pass-p12`
- `Team ID` / `App ID Prefix` = `AMX7659GJJ`（個人帳號 `Account Holder`）
- 簽名：Release 用 `fastmbti_AppStore` provisioning profile + `Apple Distribution` 手動簽（Xcode 已另產 `Apple Development`）；Archive 成功於 `FastMBTI/build/FastMBTI.xcarchive`
- `Apple ID (數字)` = `6838271103`
- AdMob 帳號 = `nobaggage2rome@gmail.com`；publisher = `pub-9603007011739375`；payee = `NOBAGGAGE ENTERPRISE`；付款國家 = `Malaysia`（不可改）
- `AdMob App ID (ca-app-pub-~)` = `ca-app-pub-9603007011739375~7813231080`（App 名 `fastmbti`，iOS，未綁商店，狀態 `Requires review`）
- `Rewarded Unit (Card_Generate)` = `ca-app-pub-9603007011739375/4323423117`（reward `1 Card`）
- `Banner Unit (shared)` = `ca-app-pub-9603007011739375/9237993394`
- `app-ads.txt` 內容 = `google.com, pub-9603007011739375, DIRECT, f08c47fec0942fa0`
- AdMob 稅表 = `W-8BEN`（個人／sole proprietor，2026-11-24 已提交）；收款銀行待加，帳戶名須為 `NOBAGGAGE ENTERPRISE`
- `IAP` = `com.fastmbti.remove_ads`（價格見 `spec.md` §2）
- `Facebook App ID` = 待填（IG 限動分享強制；見 §0 第 6 項）
- 網域 = `https://fastmbti.nobaggage2rome.com`；`Privacy` = `/privacy`，`Support` = `/support`，`app-ads.txt` 放子域根（`Developer Website` 填同子域）

## 8. 常見卡點

- `Bundle ID` 下拉選不到 → `Team` 錯或 `Identifier` 剛建未同步，等 10 分鐘切 `Team` 重進。
- `No signing certificate` → `Xcode` 先切 `Automatic` 跑一次 `Build`，不要手工去 `Profiles` 翻。
- `AdMob` 搜不到 App → 先 `No` 建 `App ID`，上架後回來綁 `App Store` 連結再過 `app-ads.txt` 驗證。
- `IAP` 送審被退 `3.1.1` → 一定有 `Restore Purchases` 按鈕 + 跟版本一起送，不要後加。
