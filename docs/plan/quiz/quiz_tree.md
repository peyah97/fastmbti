# quiz_tree — 決策樹題庫、文案與 key（zh-Hant／en 上架，ja／ko 保留）

> 本檔唯一職責：**題庫**（node 結構、16 型梗文案、String Catalog key）。上架規則見 `spec.md`；進度勾選見 `todolist.md`；句子庫見 `quotes.md`。
> 2026-11-22 合併：原本的「題庫」「多語對照」「key 清單」三檔合一，**結構與文案不再重複**——node 表只有拓樸，文字只在 §5 出現一次。
> 依據：沿用原梗圖的骨架與短句風格，**文案全部重寫**，不整張圖商用（版權）。
> 上線 2 語 `en`/`zh-Hant`；`ja`/`ko` 保留在 catalog、暫不送審。

## 1. 機制

- 一棵決策樹：根 `你奇怪嗎？` → 3–6 題後抵達 16 型之一。
- 每題 2 個選項（少數 3 個）；點完立刻換下一個 node。無計分、無軸分、無強度。
- **分支就是整個機制**：每題直接決定下一題，沒有量表計分。
- 進度條：**不顯示**（2026-11-21 定案）；路徑長短不一（3–6 題），顯示「第 n 題」會跳。

## 2. 資料結構

```json
{
  "id": "root",
  "q": "你奇怪嗎？",
  "options": [
    { "label": "有些", "next": "social" },
    { "label": "不",   "next": "rules"  }
  ]
}
```

- 內部 node 同上；terminal node：`{ "id": "INTJ", "title": "...", "text": "..." }`，`title`/`text` 見 §5。
- `next` 必指向存在的 id；驗收時跑一次遍歷，確認 16 個 terminal 全部可達、無孤兒 node、無迴圈。

## 3. 節點結構表（20 個 node，只有拓樸）

> 題目與選項文字**不在這裡**，一律住 §5（`tree.<id>.q`、`tree.<id>.o1..o3`）；本表只給引擎用的 `next`。

| id | 選項 → next |
|---|---|
| `root` | `o1`→`social` ／ `o2`→`rules` |
| `social` | `o1`→`rational` ／ `o2`→`picky` |
| `rational` | `o1`→`emotional` ／ `o2`→`emotional2` |
| `emotional` | `o1`→`INFJ` ／ `o2`→`cry` |
| `emotional2` | `o1`→`INFJ` ／ `o2`→`sure` |
| `cry` | `o1`→`INFP` |
| `sure` | `o1`→`stone` ／ `o2`→`machine` |
| `stone` | `o1`→`INTJ` |
| `machine` | `o1`→`ISTP` ／ `o2`→`INTP` |
| `picky` | `o1`→`cry` ／ `o2`→`money` |
| `money` | `o1`→`lazy` |
| `lazy` | `o1`→`horoscope` ／ `o2`→`ENTJ` |
| `horoscope` | `o1`→`ENFP` ／ `o2`→`ENTP` |
| `rules` | `o1`→`extreme` ／ `o2`→`impose` ／ `o3`→`easygoing` |
| `extreme` | `o1`→`ESTP` ／ `o2`→`quiet` |
| `quiet` | `o1`→`ESFP` ／ `o2`→`ISFP` |
| `impose` | `o1`→`loud` |
| `loud` | `o1`→`ESTJ` ／ `o2`→`ISTJ` |
| `easygoing` | `o1`→`school` ／ `o2`→`ISFJ` |
| `school` | `o1`→`ENFJ` ／ `o2`→`ESFJ` |

`rational`（理性嗎？）為真分支：是→`emotional`、不→`emotional2`，兩個「感性嗎？」分開，照原梗圖。

## 4. 16 型路徑表（18 條路徑）

| 型 | 題數 | 路徑（由 `root` 起） |
|---|---|---|
| `INTJ` | 6 | root → social → rational → emotional2 → sure → stone → INTJ |
| `ISTP` | 6 | root → social → rational → emotional2 → sure → machine → ISTP |
| `INTP` | 6 | root → social → rational → emotional2 → sure → machine → INTP |
| `INFJ` | 4 / 5 | root → social → rational → emotional → INFJ ／ root → social → rational → emotional2 → INFJ |
| `INFP` | 5 | root → social → rational → emotional → cry → INFP ／ root → social → picky → cry → INFP |
| `ENTP` | 6 | root → social → picky → money → lazy → horoscope → ENTP |
| `ENFP` | 6 | root → social → picky → money → lazy → horoscope → ENFP |
| `ENTJ` | 5 | root → social → picky → money → lazy → ENTJ |
| `ESTP` | 3 | root → rules → extreme → ESTP |
| `ESFP` | 4 | root → rules → extreme → quiet → ESFP |
| `ISFP` | 4 | root → rules → extreme → quiet → ISFP |
| `ESTJ` | 4 | root → rules → impose → loud → ESTJ |
| `ISTJ` | 4 | root → rules → impose → loud → ISTJ |
| `ENFJ` | 4 | root → rules → easygoing（是）→ school → ENFJ |
| `ESFJ` | 4 | root → rules → easygoing（是）→ school → ESFJ |
| `ISFJ` | 3 | root → rules → easygoing（還好）→ ISFJ |

最長 6 題（`INTJ` 等）、最短 3 題（`ESTP`、`ISFJ`）。`INFJ`、`INFP` 各有兩條路徑（兩個「感性嗎？」／`cry` 與 `picky`），其餘 14 型各一條——這棵樹不是嚴格分割，是沿用原梗圖的交叉連線。

## 5. 文案與 String Catalog key（89 個）

> `sourceLanguage = en`。命名：`tree.<id>.q` 題目、`tree.<id>.o1/o2/o3` 選項、`type.<TYPE>.title` 結果標題、`type.<TYPE>.text` 分享卡文案。
> 結果頁用 `title`，分享卡只放「4 字母 + `text`」；`text` ≤ 14 字，`ImageRenderer` 不換行。
> 口語化原則：不要直接翻譯；用各語言自己的諺語、口語、網路語感重寫。**不要機翻鐵石心腸、星座信徒、一個人追劇**。
> 四個單按鈕 node（`cry`／`stone`／`money`／`impose`）的 `o1` 是通用「嗯」按鈕，原梗圖只有箭頭、沒有按鈕文字。

| key | zh-Hant | en | ja | ko | state |
|---|---|---|---|---|---|
| tree.root.q | 你奇怪嗎？ | A bit weird? | 変わってる？ | 너 좀 이상해? | translated |
| tree.root.o1 | 有些 | Kinda | ちょっと | 좀 | translated |
| tree.root.o2 | 不 | Nah | ううん | 아니 | translated |
| tree.social.q | 社恐？ | Shy around people? | 人見知り？ | 낯가림 있어? | translated |
| tree.social.o1 | 有 | Yep | うん | 응 | translated |
| tree.social.o2 | 沒啊 | Nah | いや | 아니 | translated |
| tree.rational.q | 理性嗎？ | Rational? | 理屈っぽい？ | 이성적이야? | translated |
| tree.rational.o1 | 是 | Yes | はい | 응 | translated |
| tree.rational.o2 | 不 | No | いいえ | 아니 | translated |
| tree.emotional.q | 感性嗎？ | Emotional? | 感性が強い？ | 감성적이야? | translated |
| tree.emotional.o1 | 是 | Yes | はい | 응 | translated |
| tree.emotional.o2 | 不 | No | いいえ | 아니 | translated |
| tree.emotional2.q | 感性嗎？ | Emotional? | 感性が強い？ | 감성적이야? | translated |
| tree.emotional2.o1 | 是 | Yes | はい | 응 | translated |
| tree.emotional2.o2 | 不 | No | いいえ | 아니 | translated |
| tree.cry.q | 哭天喊地？ | Big feelings? | 泣き叫ぶ？ | 울고불고? | translated |
| tree.cry.o1 | 嗯。 | Yep. | うん。 | 응. | translated |
| tree.sure.q | 果斷？ | Decisive? | 即断即決？ | 결단력 있어? | translated |
| tree.sure.o1 | 是 | Yep | うん | 응 | translated |
| tree.sure.o2 | 還好 | Not really | まあね | 좀 | translated |
| tree.stone.q | 鐵石心腸 | Cold-hearted | 情がない | 정 없어 | translated |
| tree.stone.o1 | 嗯。 | Yep. | うん。 | 응. | translated |
| tree.machine.q | 重型機械？ | Heavy machinery? | 建機が好き？ | 중장비 좋아해? | translated |
| tree.machine.o1 | 超愛 | Love it | 大好き | 완전 좋아 | translated |
| tree.machine.o2 | 還好啦 | Eh, okay | まあね | 그저 그래 | translated |
| tree.picky.q | 有點難搞？ | High-maintenance? | こだわり強い？ | 좀 까칠해? | translated |
| tree.picky.o1 | 不 | Nah | いや | 아니 | translated |
| tree.picky.o2 | 有點 | A bit | ちょっと | 좀 | translated |
| tree.money.q | 有點 | Kinda | ちょっとね | 좀 그래 | translated |
| tree.money.o1 | 嗯。 | Yep. | うん。 | 응. | translated |
| tree.lazy.q | 懶？ | Lazy? | 怠け者？ | 게을러? | translated |
| tree.lazy.o1 | 對啊 | Yep | うん | 응 | translated |
| tree.lazy.o2 | 沒 | Nope | いや | 아니 | translated |
| tree.horoscope.q | 星座？ | Horoscopes? | 星座？ | 별자리? | translated |
| tree.horoscope.o1 | 相信 | I do | 信じる | 믿어 | translated |
| tree.horoscope.o2 | 誰信啊 | Yeah right | 信じるわけない | 그걸 누가 믿어 | translated |
| tree.rules.q | 規則？ | Rules? | ルール？ | 규칙? | translated |
| tree.rules.o1 | 就是要拿來打破的 | Made to be broken | 破るためにある | 깨라고 있는 거지 | translated |
| tree.rules.o2 | 為了社會是必須的 | Needed for society | 社会に必要 | 사회에 필요해 | translated |
| tree.rules.o3 | 不會讓別人不適就好 | As long as nobody minds | 誰も困らなければOK | 남 안 불편하면 괜찮아 | translated |
| tree.extreme.q | 極限運動？ | Extreme sports? | エクストリームスポーツ？ | 익스트림 스포츠? | translated |
| tree.extreme.o1 | 爽啦 | Hell yes | 最高！ | 완전 좋아 | translated |
| tree.extreme.o2 | 我寧願追劇 | I'd rather binge-watch | ドラマ見てる方がいい | 난 드라마 볼래 | translated |
| tree.quiet.q | 一個人追劇？ | Binge alone? | 一人で見る？ | 혼자 볼래? | translated |
| tree.quiet.o1 | 才不 | Nah | ううん | 아니 | translated |
| tree.quiet.o2 | 嗯嗯 | Yep | うん | 응 | translated |
| tree.impose.q | 強加於他人之上？ | Force it on others? | 他人に押し付ける？ | 남에게 강요해? | translated |
| tree.impose.o1 | 嗯。 | Yep. | うん。 | 응. | translated |
| tree.loud.q | 公共場合大叫？ | Loud in public? | 人前で騒ぐ？ | 사람 많은 데서 시끄럽게 굴어? | translated |
| tree.loud.o1 | 沒錯 | Yep | うん | 응 | translated |
| tree.loud.o2 | 不 | Nah | いや | 아니 | translated |
| tree.easygoing.q | 隨性？ | Easygoing? | 気まま？ | 자유로운 편? | translated |
| tree.easygoing.o1 | 是 | Yep | うん | 응 | translated |
| tree.easygoing.o2 | 還好 | Not really | まあね | 좀 | translated |
| tree.school.q | 讀過很多書嗎？ | Read a lot? | 本よく読む？ | 책 많이 읽어? | translated |
| tree.school.o1 | 人文社科 | Humanities | 文系・人文系 | 인문학 쪽 | translated |
| tree.school.o2 | 沒 | Nah | あんまり | 별로 | translated |
| type.INTJ.title | 鐵石心腸 | Heart of Stone | 鉄の心 | 돌같은 마음 | translated |
| type.INTJ.text | 情緒排在明天。 | Emotions? Tomorrow's problem. | 感情の処理は明日回し。 | 감정은 내일 처리. | translated |
| type.ISTP.title | 重型機械 | Heavy Machinery | 大型機械 | 중장비 | translated |
| type.ISTP.text | 話少，但什麼都拆得開。 | Quiet. Still takes everything apart. | 口数は少ないけど、何でも分解する。 | 말은 적지만 다 뜯어봐. | translated |
| type.INTP.title | 腦內實驗室 | Brain Lab | 頭の中の実験室 | 머릿속 실험실 | translated |
| type.INTP.text | 做到一半，去查量子力學了。 | Halfway through—down a quantum rabbit hole. | 途中で量子力学を調べ始めた。 | 하다가 양자역학 검색하러 감. | translated |
| type.INFJ.title | 先知型 | The Oracle | 予言者 | 예언자 | translated |
| type.INFJ.text | 早知道答案，只是等人問。 | Knew the answer. Just waiting to be asked. | 答えは知ってる。聞かれるのを待ってるだけ。 | 답은 알고 있어. 물어봐 주길 기다릴 뿐. | translated |
| type.INFP.title | 哭天喊地 | Big Feelings | 泣き叫ぶ | 울고불고 | translated |
| type.INFP.text | 哭完一場，還是選擇原諒。 | Cried it out. Still chose to forgive. | 思いきり泣いた。それでも許す。 | 한바탕 울고는 결국 용서해. | translated |
| type.ENTP.title | 反骨 | Contrarian | 天邪鬼 | 반골 | translated |
| type.ENTP.text | 反對的不是星座，是結論。 | Not against astrology. Against the conclusion. | 反対してるのは星座じゃなくて結論。 | 별자리가 아니라 결론에 반대하는 거야. | translated |
| type.ENFP.title | 星座信徒 | True Believer | 信じてる派 | 별자리 덕후 | translated |
| type.ENFP.text | 不是迷信，是劇本。 | Not superstition. It's written in the stars. | 迷信じゃなくて、星のシナリオ。 | 미신이 아니라, 별이 쓴 각본이야. | translated |
| type.ENTJ.title | 沒空 | No Time | 時間がない | 바빠 | translated |
| type.ENTJ.text | 不是沒情緒，是沒空。 | Not heartless. Just busy. | 冷たいんじゃなくて、忙しいだけ。 | 감정이 없는 게 아니라 바쁜 거야. | translated |
| type.ESTP.title | 心跳加速 | Adrenaline | ドキドキ | 심장 박동 | translated |
| type.ESTP.text | 規則拿來打破，心跳拿來用。 | Rules are made to break. Heartbeats are made to race. | ルールは破るもの。心は弾ませるもの。 | 규칙은 깨라고 있고, 심장은 두근거리라고 있어. | translated |
| type.ESFP.title | 氣氛組 | Vibe Captain | ムードメーカー | 분위기 메이커 | translated |
| type.ESFP.text | 安靜不可能，氣氛我來扛。 | Quiet? Never. I bring the energy. | 静かは無理。場は私が盛り上げる。 | 조용한 건 안 돼. 내가 분위기 맡을게. | translated |
| type.ISFP.title | 一個人追劇 | Solo Binge | 一人ドラマ | 혼자 정주행 | translated |
| type.ISFP.text | 世界我先略過。 | World can wait. Episode can't. | 世界は後回し。このエピソードは今。 | 세상은 나중에, 이 편은 지금. | translated |
| type.ESTJ.title | 秩序控 | Order Freak | 秩序好き | 질서광 | translated |
| type.ESTJ.text | 秩序不是束縛，是別亂。 | Not about control. Just less chaos. | 束縛じゃなくて、混乱を避けてるだけ。 | 통제가 아니라, 안 엉망이게 하려는 거야. | translated |
| type.ISTJ.title | 規則要緊 | Rules First | ルール優先 | 규칙이 우선 | translated |
| type.ISTJ.text | 大叫不必，規則要緊。 | No shouting. Rules matter. | 叫ばなくていい。ルールが大事。 | 소리치지 마. 규칙이 중요해. | translated |
| type.ENFJ.title | 人文社科 | Humanities | 人文科学 | 인문사회 | translated |
| type.ENFJ.text | 讀的不是書，是別人的心。 | Didn't read books. Read people. | 本じゃなくて、人の心を読んでた。 | 책이 아니라 사람 마음을 읽었어. | translated |
| type.ESFJ.title | 人情滿分 | Social A+ | 人当たり満点 | 인심 만점 | translated |
| type.ESFJ.text | 書沒讀幾本，人情滿分。 | Few books. Great social life. | 本は少なめ。人間関係は満点。 | 책은 별로, 인심은 만점. | translated |
| type.ISFJ.title | 很規律 | Creature of Habit | 規則正しい | 규칙적 | translated |
| type.ISFJ.text | 很規律，也很會記得你。 | Routine, and I remember you. | 規則正しく、あなたのことも覚えてる。 | 규칙적이고, 너를 기억해. | translated |

## 6. 敏感詞替換表

| 原圖 | 風險 | 上架版 |
|---|---|---|
| 我寧願吸毒 / 安靜吸？ | 藥物使用，廣告與分級 | 我寧願追劇 / 一個人追劇？ |
| 約炮？ | 性暗示 | 隨性？ |
| 性別研究學 | 易被讀成歧視 | 人文社科 |
| *複誦佛經* | 宗教 | 很規律 |
| 狗屁 | 輕微髒話 | 誰信啊 |
| 邊場大聲大叫？ | 錯字/方言 | 公共場合大叫？ |

其餘（社恐、鐵石心腸、重型機械）保留；原圖交叉連線有矛盾（同一框通往兩型），每個框收斂成單一 `next`，不改梗的辨識度。

## 7. 已知限制

- 每題 1 bit，位置偏誤、分支措辭等價性無法完全證明。現在是產品取捨：用「準」換 3–6 題就想分享的傳播力。
- 文案只能寫「玩梗用，不是心理測驗／不能當 MBTI 診斷」，不能寫「很準」「精準測出」（見 `spec.md` §4 文案紅線）。
- 梗圖短句很難翻。上線 `en`/`zh-Hant` 人工寫；`ja`/`ko` 已保留，之後再開。
- 原圖版權：只借結構與題意；所有 node 文案為新寫，分享卡不使用原圖。

## 8. 母語者複核狀態

- 所有 ⚠️ 已清除（2026-11-20）。
- 字面翻譯、平淡、官方語氣已重寫。
- 敏感詞再掃：`en` 無藥物/性暗示，`ja`/`ko` 無歧視語感。
- 尚未完成：`en`/`zh-Hant` 分享卡實機截圖（4 字母 + `text` 不換行、不超框，需 App）；通過後才進 String Catalog（key 見 §5）。兩項進度見 `todolist.md` §12。

## 9. 統計

- 題庫 key 數：**89**
- String Catalog 總 key 數：**90**（89 題庫 + UI key `ui.restart`，供重測鈕 VoiceOver label）
- node 題目 `tree.*.q`：20
- 選項 `tree.*.o*`：37
- 型別 `type.*`：32（16 型 × title/text）

## 10. 驗收條件

1. 遍歷測試：16 型皆可達，無孤兒、無迴圈，深度 3–6，共 18 條路徑。
2. 敏感詞表全數替換，`en`/`zh-Hant` 版面不爆（node 題目 ≤ 12 繁中字）；`ja`/`ko` 保留版另行檢查。
3. 結果頁只有 4 字母 + 一句梗文案 + 分享卡；無強度、無「不穩／亂答」標記。
4. 文案與商店圖說不含「精準／很準／MBTI 診斷」。
5. 16 型 `text` 皆 ≤ 14 字、`title` 2–5 字，分享卡不換行；`en`/`zh-Hant` 依各語言膨脹率重測。
6. `rational` 的 `o1`→`emotional`、`o2`→`emotional2`（真分支）。
7. §5 的 89 列與 §3（20 node／37 選項）、§4（16 型）數量一致，無缺 key、無多餘 key。
