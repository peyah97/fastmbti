# widget.md — widget 每日一句：範圍與實作

> 2026-11-22 建立（自 `todolist.md` 抽出）。
> **本檔唯一職責：widget 功能範圍與工程實作**（target、App Group、timeline、通知、合規、送審）。
> 句子內容與寫作規格見 `quotes.md`；上架規則見 `spec.md`；進度勾選見 `todolist.md` §widget。

## 1. 範圍鎖定

- 主畫面 `small` + 鎖屏 `rectangular` + 每天 09:00 本地通知，三處同一天同一句。
- **不做**：streak／收藏／widget 內按鈕／多風格／medium-large／伺服器／APNs。
- widget 顯示名稱 = `today's meme`（2026-11-22 定案）：**不含 `MBTI`／`Myers-Briggs`**，縮小商標暴露面；App 名 `fast mbti` 不動。之後若要 A/B，`InfoPlist.xcstrings` 留 key。
- widget 不在主畫面換型別（型別只由測驗決定，省一層 intent）。

## 2. 前置（卡住就整案停）

1. `git init` + 首次 commit（加 target 會改 `project.pbxproj`，沒版本控制改壞回不去）。
2. `Developer Portal` 建 `App Group` = `group.app.fastmbti.ios`（免費帳號不可用）。
3. widget `bundle id` = `app.fastmbti.ios.widget`、最小 deployment = `iOS 18.0`。

## 3. 骨架

1. `Xcode` 新增 `Widget Extension` target，不勾 `Configuration Intent`。
2. 主 App 與 extension **都**開 `App Group` capability。
3. extension `CFBundleShortVersionString` + `CFBundleVersion` 與主 App 完全一致（不一致 = `Invalid Bundle` 退件）。
4. extension `deployment target` 不低於主 App；指定同一 `Team`，重簽 provisioning。
5. 先放一句寫死的句子，確認主畫面與鎖屏都加得到，再往下做。

## 4. 資料

1. `FastMBTICore` link 進 widget target；句子庫放 SPM resources（`Bundle.module` 可讀）。
2. 測驗完成／重測時把型別寫進 `App Group`，並觸發 timeline 重排。
3. 未測驗 fallback：通用句 + 導向 60 秒測驗（缺這條新安裝看到空白）。
4. 句子索引 = `day number` + 型別 → 固定索引，禁隨機（同一天跨裝置必須同句）。
5. 換型後重排整個 timeline，不只換當前那句。

## 5. 畫面

1. `small`：一句話主體 + 型別小標 + 日期角標（凍結狀態看得出來）。
2. 鎖屏 `rectangular`：同一句，字級降一級。
3. 深色 + `iOS 26` `Clear`／`Tinted` 各出一版單色設計（`containerBackground` 必備）。
4. `widgetAccentable()` / `widgetAccentedRenderingMode` 調過，clear 模式不變一坨白。
5. 最長句子（60 字元）在 `small` 不截斷、不縮成螞蟻字。

## 6. 換句

1. 一次交 90 天 entries，`policy` = 第 90 天。
2. App 啟動比對上次交件日，超過 60 天就重交（防凍結）。
3. 偽時間測試：裝置日期推到 90 天後仍正常續句。
4. 跨時區／跨日測試：不重複、不跳號。
5. 低耗電模式測一次，確認不是靠背景更新換句。

## 7. 通知

1. 權限請求放在「看到第一句之後」，不在一開 App 就彈。
2. 09:00 本地排程，內容 = 當天那句，一天一則。
3. App 內關閉開關；換型後重排。
4. 通知被拒不得影響 widget（兩者獨立）。
5. 文案直接放句子，不寫「快回來看看」。

## 8. 合規（2026-11-22 依 Apple 文件查證，非法律意見）

1. `PrivacyInfo.xcprivacy` 的 `NSPrivacyAccessedAPICategoryUserDefaults` 改用 **`1C8F.1`**（App Group 跨 App/extension；`CA92.1` 只涵蓋 App 本身，寫 App Group suite 屬不符）。
2. widget extension **自己的** `PrivacyInfo.xcprivacy`（主 App manifest 不覆蓋 extension；缺會收 `ITMS-91053`）。
3. widget 與通知內零廣告、零推銷（`2.5.18` 明列 extensions／widgets／notifications）；確認 widget target 不 link `AdsManager`。
4. widget 顯示名稱不用 `MBTI`／`Myers-Briggs`（商標指南禁入產品名／metatag）。
5. `App Store` keywords 不塞 `Myers-Briggs`、`16personalities`、`MBTI test`（`2.3.7`）。
6. 送審 Notes 具體描述 widget 功能（`2.3.1`）；句子不得宣稱準確——`1.1.6` 明說「entertainment only」不能免責。
7. 句子禁醫療／心理診斷／治療建議（`1.4.1`），全句 `13+` 可過。
8. 粗口不影響分級：`頻繁的粗口／粗俗幽默` = `13+`（`16+` 只由無限制網頁瀏覽、頻繁醫療資訊、頻繁成熟主題觸發），**維持 `13+`**。
9. 商店文案與截圖**不得出現粗口**（`2.3.8` 要求 metadata 適齡 `4+`），截圖用 `clean` 版句子。
10. 句中不得含 slur 或針對族群／宗教／性別的攻擊（`1.1.1`），開罵只對「規則／制度／場合」，不對人。

## 9. 送審

1. 測試矩陣：全新安裝、未測驗、已測驗、換型、深色、Clear／Tinted、鎖屏、飛航。
2. 截圖含主畫面 widget 實照；描述提 widget；build 號往上跳，不沿用已送審 build。
3. `TestFlight` 外部測試一輪（驗簽章與版本號）。

## 10. 驗收條件

1. 三處（`small`、`rectangular`、通知）同一天同一句，跨裝置一致。
2. 90 天不凍結；App 超過 60 天未開仍能續句。
3. 未測驗狀態有 fallback 句 + 導引，不是空白。
4. widget target 不含任何廣告程式碼；extension manifest 齊全。
5. `small` 最長句不截斷；Clear／Tinted 可讀。
