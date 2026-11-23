# widget 每日一句：寫作規格與句子庫（v6，2026-11-22）

> 本檔唯一職責：**句子怎麼寫、寫了什麼**。場景卡（跨語言、寫句子只看它）見 `quotes.scenes.md`；widget 實作與合規見 `widget.md`；上架規則見 `spec.md`；進度勾選見 `todolist.md`。
> 用途：句子庫的寫作規格。之後補第二個月、擴語版、或加新型別，**照這份做，不要重新發明規則**。
> 產出：16 型 × 30 = **480 條 × 3 語**（`en` / `zh-Hant` / `zh-Hans`），一列一 key、三語並排，見 §7。
> 舊稿 v1（作廢）已刪除；結構與本版不同，不需要語氣對照。

## 1 語版狀態

| 語版 | 狀態 | 字數上限 | 說明 |
|---|---|---|---|
| `en` | **來源語**，未鎖定 | ≤ 60 字元 | `sourceLanguage`；句子外層引號不寫進 catalog |
| `zh-Hant` | **上架**，未鎖定 | 5–24 字 | 台灣腔 · 嗆 · 2026-11-22 重寫（480 條中 232 條改寫、248 條原句已合格保留） |
| `zh-Hans` | 保留不送審 | 6–22 字 | 480 條已寫滿（簡體、大陸口語），留作備援 |
| `ja`／`ko` | 未開始 | — | 只留 catalog key 位置，不產 `lproj` |

三語共用同一組 key（`quote.<type>.<label>.<idx>`），同一列的句子必須是同一個意思，不是各自造句。

## 2 定位

每一句都是**那個型的人對自己說的內心 OS**：講給自己聽，不是旁人對他的評語，也不是格言。

- 對：`"Smiled. Nodded. Screamed internally. Standard Tuesday."`
- 錯：`"You are a thoughtful person who feels deeply."`（旁白）
- 錯：`"Time is a gift we give ourselves."`（格言）

## 3 五個硬條件

1. **零資料成立**：不依賴任何真實事件、人名、地點、行程。系統不知道他今天發生什麼。
2. **只講時間，不講事件**：`today`／`tonight`／`before noon`／`at 3 p.m.` 可以；「你的三個會議」不行。
3. **今天做得到**：10 分鐘內、不需別人配合、不需花錢。
4. **自己驗得完**：做到自己知道，不用問人、不用等回覆。
5. **做不到不罪惡**：這是娛樂，不是待辦清單；會讓人產生欠債感的句子直接砍。

## 4 四個標籤

| 標籤 | 必須滿足 | 好 | 壞 |
|---|---|---|---|
| `TODAY'S GOAL` | 10 分鐘內可完成、不需他人配合、失敗也無害 | `"One honest sentence today. No slides."` | `"Be your best self."` |
| `TODAY'S BAN` | 禁一個他今天一定會想做的習慣動作 | `"No explaining it twice today."` | `"No sugar."`（變健康建議） |
| `TODAY'S PERMISSION` | 允許他少做一次／拒絕一次，具體到行為 | `"Leave early. No exit speech."` | `"Allow yourself joy."` |
| `TODAY'S WARNING` | 說中今天的自我欺騙，不是詛咒 | `"You'll call it a quick fix. It won't be."` | `"You'll have a bad day."` |

標籤由 widget 獨立顯示，**句子本身不重複標籤文字**（不寫 `Today's goal:`），只可用 `today` 這個字。

## 4.5 嗆度與邊界（2026-11-22 使用者定案）

`zh-Hant` 採「嗆」的語域，三條方向：

1. **嗆制度、場合、不長眼的人**，不是嗆使用者。
2. **對自己的軟弱下手**——「你又答應了」比「你很軟弱」有效。
3. **不安慰、不昇華**：句子結束後不得補安慰句，停在最不舒服的地方。

邊界（不跨）：

1. 沒有 slur，不針對族群、性別、外貌、職業。
2. 不罵特定的人，只寫行為與場合。
3. 不鼓吹自傷、報復、違法。

`PERMISSION` 以「拒絕優先於安慰」為準：給行動，不給擁抱。例：`今天不用當好人。真的不用。`

## 4.6 達標定義：兩個反應（所有語言共用）

每一句都必須讓該型讀者產生兩個反應，缺一不可：

1. **先笑**：有一個具體的荒謬點、反轉或自嘲。
2. **再想「我真的是這樣」**：笑完之後被說中。

只有笑 = 只是笑話；只有被說中 = 只是準；兩個都沒有 = 重寫。

適用範圍：`en`、`zh-Hant`、`zh-Hans`、之後的 `ja`／`ko` 全部照這條判，不因語言放寬。

三個常見不及格：

1. **中性指令**：「關機一小時。」——沒有任何反應。
2. **名詞聽不懂**：抽象詞或要猜的詞（`分頁`、`洞見`、`九十分`、`對齊`）。**廢話式幽默不算此類**——「它不會咬你」這種沒意義但看得懂的話可以留。
3. **解釋型幽默**：把笑點解釋完，或幽默靠語助詞撐（`喔`、`啦` 不是笑點）。

判準：**可以看不懂笑點，不能看不懂字**。每個名詞都要是讀者一定懂的日常詞。

判斷方式：找一個該型的人讀，直接問兩句——「你笑了嗎」「這是你嗎」。兩題都答不出來就退。

## 5 配額（每型 30 條）

- `GOAL` 9
- `BAN` 7
- `PERMISSION` 7
- `WARNING` 7

`GOAL` 最多，因為它最像「今天有事發生」；`BAN` 與 `PERMISSION` 各 7 才不會每天都在禁止；`WARNING` 7 條剛好一個月被說中幾次，多了變碎念。

## 6 六條驗收（每句都跑）

1. 今天做得到嗎。
2. 自己驗得完嗎。
3. 做不到會不會有罪惡感（會 → 砍）。
4. 是不是只有一個動作或一個判斷（兩個 → 拆）。
5. 讀完 3 秒內有沒有「對」的反應（沒有 → 重寫）。
6. 是否在該語版的字數上限內（超過 → 砍字，不要縮字級；上限見 §1）。

## 7. 句子庫（480 條 × 3 語）

> key = `quote.<type>.<label>.<idx>`，例 INTJ 的 `G01` → `quote.intj.goal.1`。

> 上架語版：`en`、`zh-Hant`；`zh-Hans` 保留不送審（480 條已寫滿，留作備援）。

> 每列一句，三語同一 key；`en` 為來源語。`G` = TODAY'S GOAL、`B` = TODAY'S BAN、`P` = TODAY'S PERMISSION、`W` = TODAY'S WARNING。

> 每型 30 條 = `G` 9／`B` 7／`P` 7／`W` 7（共 480）。


### INTJ


**GOAL**（9）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| G01 | One honest sentence today. No slides. | 講重點就好。不用附上三份資料。 | 说一句真话。不用 PPT。 |
| G02 | Answer one message in under a minute. | 一分鐘回完。不要再改第七遍。 | 一分钟内把消息回完。 |
| G03 | Say the plan out loud once. Just once. | 計畫講出來。別自己做完才說。 | 把计划讲出来一次。就一次。 |
| G04 | Ask one question you already know the answer to. | 問吧。你只是想確認自己沒聽錯。 | 问一个你早就知道答案的问题。 |
| G05 | Close nine tabs. Keep the important one. | 關掉那些網頁。留一個就夠了。 | 关掉九个标签页，留最重要的。 |
| G06 | Tell someone the deadline. Then keep it. | 把期限說出去。這樣你才會動。 | 把截止时间告诉一个人，然后守住。 |
| G07 | Pick the boring option today. It's cheaper. | 今天選便宜那個。複雜的留給明天。 | 今天选无聊的那个，便宜。 |
| G08 | Write the three-line version. Send that. | 三行就好。附件不用三十頁。 | 写三行版本，发出去。 |
| G09 | Leave one meeting seven minutes early. | 提早走。反正你已經知道他們會講錯。 | 提前七分钟离开一场会。 |

**BAN**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| B01 | No explaining it twice today. | 今天不補第二次說明。 | 今天不解释第二遍。 |
| B02 | No re-planning what's already working. | 能跑的就不要動。你的手很癢。 | 不再重排已经能跑的东西。 |
| B03 | No quick fixes. Not today. | 今天不接「順手看一下」。 | 今天不接「顺手改一下」。 |
| B04 | No fixing strangers who never asked. | 不要幫別人規劃人生。 | 不修没开口求助的人。 |
| B05 | No small talk before noon. | 中午前不要講話。不是針對誰。 | 中午前不社交。 |
| B06 | No new systems. Use the one you built. | 不要換新工具。舊的還沒用完。 | 不搭新系统，用你建好的。 |
| B07 | No arguing with people who haven't read it. | 不要跟沒看的人辯。你會講到沒氣。 | 不跟没读过的人辩。 |

**PERMISSION**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| P01 | Skip the meeting. You know the outcome. | 會可以不去。答案你早就有了。 | 会可以不去。结果你早知道。 |
| P02 | Say no without the paragraph after it. | 拒絕就一句。後面那張報告收起來。 | 拒绝就拒绝，别补一段。 |
| P03 | Skip the debrief. You already wrote it in your head. | 先離開。沒有人會拿筆記本記你。 | 提前走，不用开场白。 |
| P04 | Be the quiet one tonight. It still counts. | 今晚安靜沒關係。你到場了。 | 今晚当安静的那个，人到就行。 |
| P05 | Do it worse today, faster tomorrow. | 做差一點。世界不會因為這樣歪掉。 | 今天做差一点，明天快一点。 |
| P06 | Not answering the one you dread until tomorrow. | 不想回的那則，明天再說。 | 那条消息明天再回。 |
| P07 | Take the long way home for no reason. | 走別條路。你的導航太固執了。 | 绕远路回家，没理由。 |

**WARNING**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| W01 | You'll call it a quick fix. It won't be. | 你會說「順手就好」。然後做到半夜。 | 你会说「顺手就好」。不会顺手。 |
| W02 | You'll say later at 10 a.m. and mean it. | 十點你說「等一下弄」。那是一個時區。 | 十点你会说「等会儿弄」，还挺真诚。 |
| W03 | Someone will talk for six minutes. You'll count. | 他講到第三分鐘，你已經在心裡結帳。 | 有人会讲六分钟，你会数。 |
| W04 | You'll rewrite the plan at 11 p.m. Don't. | 十一點你會重寫計畫。白天那個你太天真。 | 十一点你会重写计划。别。 |
| W05 | You'll be right and say it badly. | 你會是對的。然後房間只剩你一個。 | 你会是对的，然后说得很伤人。 |
| W06 | You'll agree to one more thing. You have room for zero. | 你會再答應一件。你的清單已經滿了。 | 你会再答应一件。你的额度是零。 |
| W07 | You'll find a flaw and fix it for free. | 你會看到瑕疵，然後免費修掉。 | 你会看到一个瑕疵，然后免费修掉。 |

### INTP


**GOAL**（9）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| G01 | Pick one tab. Any tab. Stay there. | 今天只看一個網頁。其他八個假裝不存在。 | 挑一个标签页，随便一个，待着。 |
| G02 | Answer the email. The short version. | 回那句話，不用先想三個版本。 | 回那封邮件。短的版本。 |
| G03 | Write the idea down so your brain can drop it. | 把想法寫成三行。腦裡那篇論文先放著。 | 把想法写下来，脑子才能放下。 |
| G04 | Test it for ten minutes before explaining it. | 先試十分鐘。原理等回來再講。 | 先试十分钟，再解释。 |
| G05 | Say the simple version once. No footnotes. | 講最白的那版。不要一開口就上課。 | 讲简单版一次，别加注释。 |
| G06 | Start at 11. Finish at 11:40. | 打開那個檔案，看第一段就好。 | 十一点开始，十一点四十结束。 |
| G07 | Ask one person what they actually meant. | 直接問他：剛剛那句是什麼意思。 | 问一个人他到底什么意思。 |
| G08 | Delete three drafts. Keep the honest one. | 刪掉三份草稿。它們不是證據。 | 删三份草稿，留诚实那份。 |
| G09 | Make one version. You will see what is missing. | 先做一版。做完就知道缺什麼。 | 先做，再查。 |

**BAN**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| B01 | No new research today. You have enough. | 今天不要再查了。你查的比做的多。 | 今天不查新资料，够了。 |
| B02 | No debugging other people's lives. | 不要幫朋友 debug 他的人生。 | 不修别人的人生。 |
| B03 | No I'll start after this video. | 不要說「看完這支就開始」。你不會看。 | 不接「看完这个就开始」。 |
| B04 | No explaining the flaw in the system. Again. | 制度壞在哪裡，今天不用再講一次。 | 不再解释制度哪里坏了。又一次。 |
| B05 | No buying a tool to fix a habit. | 不要再買新的清單 App。你四個都沒開。 | 不买工具来改习惯。 |
| B06 | No reading about it a fourth time. | 同一段不要讀第四次。你已經背起來了。 | 不读第四遍。 |
| B07 | No arguing with a stranger at 1 a.m. | 半夜不要跟陌生人吵。贏了也睡不著。 | 凌晨一点不跟陌生人吵。 |

**PERMISSION**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| P01 | Leave it half-built tonight. | 今晚就讓它沒做完。它不會跑掉。 | 今晚就让它半成品。 |
| P02 | Reply ok and move on. | 回一個「好」就好。不用附理由。 | 回个「好」，结束。 |
| P03 | Not understanding it today. | 今天可以聽不懂。不用馬上查。 | 今天可以不懂。 |
| P04 | Cancel the thing. No explanation needed. | 取消就取消。不用寫請假單。 | 取消，不用理由。 |
| P05 | Be the slowest one in the room. | 當最慢的那個。你腦子已經先到了。 | 当全场最慢的那个。 |
| P06 | Do it the ugly way if it works. | 能跑就好。醜不影響它會動。 | 丑点但能用就行。 |
| P07 | Skip the party. Send one real message instead. | 聚會不去，傳一句真的就好。 | 聚会不去，发一条真话。 |

**WARNING**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| W01 | You'll open a tab and forget the task. | 你會開一個網頁，然後忘了本來要幹嘛。 | 你会开个标签页，然后忘了要干嘛。 |
| W02 | You'll explain it perfectly and do none of it. | 你會解釋得很清楚，然後一件都沒做。 | 你会解释得很完美，然后一件没做。 |
| W03 | 3 a.m. is not a good time to start this. | 凌晨三點不是開始的時間。你每次都這樣想。 | 凌晨三点不是开始的好时间。 |
| W04 | You'll call it research for two hours. | 「查一下」會變成兩小時。你知道的。 | 你会把「查一下」说成两小时。 |
| W05 | You'll rewrite the plan and call it progress. | 你會重寫計畫，然後說這是進度。 | 你会重写计划，然后说这是进度。 |
| W06 | That question is a rabbit hole. It always is. | 那個問題沒有底。你還是會跳下去。 | 那个问题是无底洞，每次都是。 |
| W07 | You'll miss the deadline and blame the deadline. | 期限到了，你會說期限太趕。 | 你会错过截止时间，然后怪截止时间。 |

### ENTP


**GOAL**（9）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| G01 | Pick one idea and give it a deadline. | 挑一個想法，給它一個日子。不是感覺。 | 挑一个想法，给它一个截止时间。 |
| G02 | Argue the other side once today. | 今天站對面辯一次。你會發現自己也沒那麼對。 | 今天站反方辩一次。 |
| G03 | Ship the boring version. Not the clever one. | 先送出去。你的完美版換過三次了。 | 不完美也先发。 |
| G04 | Write the worst version first. | 先寫最爛的。反正第一版你會當定稿。 | 先写最烂的那版。 |
| G05 | Ask for the meeting you've been avoiding. | 去約那場會。躲著比開會還累。 | 去约那场你一直躲的会。 |
| G06 | Finish the sentence you keep starting. | 把那句講完。你開頭很強，結尾在空中。 | 把说到一半的那句说完。 |
| G07 | Say the real reason, not the clever one. | 講真的原因。聰明那版你自己聽過就散。 | 说真正的原因，不是聪明的版本。 |
| G08 | Do the boring twenty minutes first. | 先做無聊的二十分鐘。你可以研究它三天。 | 先做无聊的二十分钟。 |
| G09 | Text back the person you forgot. | 回他。你記得他的論點，忘了回訊息。 | 回那个你忘了的人。 |

**BAN**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| B01 | No new project today. Look at the shelf. | 今天不開新專案。抽屜裡還有三個。 | 今天不开新项目，看看架上。 |
| B02 | No debating people who aren't playing. | 不要跟沒在玩的人辯。你可以辯到天黑。 | 不跟没在玩的人辩。 |
| B03 | No what-if-we before noon. | 早上不要講「如果我們」。 | 中午前不说「要是我们……」。 |
| B04 | No starting a podcast. | 不要開節目。名字你已經取三個了。 | 不开播客。 |
| B05 | No buying a domain. | 不要買網域。你買六個了，一個都沒開。 | 不买域名。 |
| B06 | No winning arguments with strangers. | 不要贏路人。贏完你還是要上班。 | 不赢跟陌生人的争论。 |
| B07 | No rewriting the plan you already shipped. | 不要重寫上線的東西。上線才是改的開始。 | 不重写已经上线的计划。 |

**PERMISSION**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| P01 | Leave the argument undecided. | 讓它沒有結論。不是每場都要收尾。 | 让这场辩论没有结论。 |
| P02 | Be wrong out loud. | 認錯一次。不用順便教他一課。 | 当众认错一次。 |
| P03 | Say no to the fun thing you can't afford. | 拒絕那個好玩的。你付不起那個代價。 | 拒绝那个你付不起的开心。 |
| P04 | Skip the group chat today. | 今天退出群組。裡面只有你在加熱。 | 今天退出群聊。 |
| P05 | Send the messy draft. | 送亂的那版。亂的不代表沒做完。 | 把乱的那版发出去。 |
| P06 | Not having an opinion on this one. | 有些事可以不講話。沉默也是回答。 | 这事可以不表态。 |
| P07 | Go home before it gets weird. | 場面怪掉之前回家。你每次都多留半小時。 | 场面变怪之前回家。 |

**WARNING**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| W01 | Your great idea expires by Friday. | 你的好點子活不過星期五。你比我清楚。 | 你的好点子活不过周五。 |
| W02 | You'll start three things before lunch. | 午餐前你會開三件事。用開始代替完成。 | 你午饭前会开三件事。 |
| W03 | You'll win the argument and lose the room. | 你會贏了道理，然後整桌安靜。 | 你会赢了道理，输了整桌。 |
| W04 | You'll call it exploring options for a month. | 「看看選項」你會講一個月。選項愈多你愈不動。 | 你会把「看看选项」说一个月。 |
| W05 | You'll be late and charming about it. | 你會遲到，還講得好像是一種風格。 | 你会迟到，还挺得意。 |
| W06 | You'll reopen the decision at 9 p.m. | 九點你會重新打開那個決定。半夜的你最有主見。 | 九点你会重新打开这个决定。 |
| W07 | That tangent has a tangent. | 那條岔路後面還有岔路。你走不完。 | 那个岔路后面还有岔路。 |

### ENFP


**GOAL**（9）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| G01 | Finish one thing. The sandwich counts. | 做完一件就好。三明治也算一件。 | 做完一件。三明治也算。 |
| G02 | Send the message you've rewritten five times. | 那則訊息發出去。你改五遍也沒更好。 | 把改了五遍的那条发出去。 |
| G03 | Say yes to one small thing today. | 今天答應一件小的。大的你已經答應三個。 | 今天答应一件小事。 |
| G04 | Put the good idea in a note, not a new folder. | 好點子記在手機。不要又開一個資料夾。 | 好点子记在笔记里，别开新文件夹。 |
| G05 | Call the person you keep almost calling. | 打那通電話。你已經在腦裡打過三次。 | 打给那个你差一点就打了的人。 |
| G06 | Do the first five minutes. Only five. | 做五分鐘就好。不用一次做到完。 | 只做前五分钟，就五分钟。 |
| G07 | Pick one plan and tell someone. | 挑一個計畫講。你現在活在五個裡面。 | 挑一个计划，说给一个人听。 |
| G08 | Wear the thing you keep saving. | 穿那件。特別的日子不會自己來。 | 穿那件你一直留着的。 |
| G09 | Take the photo. Don't post it. | 拍一張，自己留著。不用發給誰看。 | 拍一张，别发。 |

**BAN**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| B01 | No new hobbies today. Look at the shelf. | 今天不要開新興趣。你已經有五個在跑。 | 今天不开新兴趣，看看架上。 |
| B02 | No buying supplies for Tuesday's hobby. | 不要再買材料。那箱還沒拆。 | 不买周二那个兴趣的材料。 |
| B03 | No we-should-hang-out without a date. | 不要說「改天約」。你講完就忘了。 | 不说「改天约」又不给日子。 |
| B04 | No starting a group chat. | 不要開新群。你開的有一半在睡覺。 | 不开新群。 |
| B05 | No reorganizing your life at 11 p.m. | 晚上十一點不要重整人生。你明天會後悔。 | 晚上十一点不重整人生。 |
| B06 | No new notebook. You have nine. | 不要買筆記本。你有九本，只寫前三頁。 | 不买新本子，你有九本。 |
| B07 | No explaining the five-year plan to strangers. | 不要跟問路的人講五年計畫。 | 不跟陌生人讲你的五年计划。 |

**PERMISSION**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| P01 | Be late and not narrate it. | 遲到就遲到。不用編一個故事。 | 迟到，也不解释。 |
| P02 | Leave before you start managing the room. | 想走就走。你不是怕錯過，是怕留下。 | 第一个离开派对。 |
| P03 | Change your mind mid-sentence. | 改主意就改。你的結論本來就會轉彎。 | 说到一半改主意。 |
| P04 | Not being the fun one tonight. | 今晚不用好笑。安靜不會讓你被忘記。 | 今晚不当搞笑的那个。 |
| P05 | Be sad in public. It's allowed. | 難過就難過。不用先逗大家笑。 | 难过可以让人看见。 |
| P06 | Drop the plan that stopped being fun. | 不好玩就停。你已經撐過很多場。 | 不好玩了就停。 |
| P07 | Not every message needs an answer today. | 已讀不回也可以。不是每則都要接。 | 明天再回。 |

**WARNING**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| W01 | The new hobby will be four days old. | 新興趣會活四天。你自己也數過。 | 新兴趣会活四天。 |
| W02 | You'll promise three things before noon. | 中午前你會答應三件事。你答應比想快。 | 你中午前会答应三件事。 |
| W03 | You'll say let's do it and check the calendar after. | 你會說「衝」，然後才看行事曆。 | 你会说「冲」，然后才看日历。 |
| W04 | The 2 a.m. idea will look different at nine. | 凌晨的點子，九點看起來很荒謬。 | 凌晨两点的点子，九点长得不一样。 |
| W05 | You'll start a project to avoid finishing one. | 你會開新專案，來逃避收尾那個。 | 你会开新项目来逃避收尾。 |
| W06 | You'll be late because you were being nice. | 你會因為不好意思先走，而遲到下一場。 | 你会因为人太好而迟到。 |
| W07 | You'll forget what you were excited about yesterday. | 你會忘記昨天在興奮什麼。今天也是。 | 你会忘记昨天在兴奋什么。 |

### ISTJ


**GOAL**（9）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| G01 | Leave one thing unfinished. On purpose. | 留一件不做完。它會在你腦裡待到明天。 | 故意留一件没做完。 |
| G02 | Do the small thing you keep deferring. | 把那件小事做掉。它已經放一個月了。 | 做那件你一直往后放的小事。 |
| G03 | Say one sentence without hedging. | 講肯定句。不要又加「可能」。 | 说一句不带「可能」的话。 |
| G04 | Take the lunch break. The whole thirty. | 午休三十分鐘。吃飯不用配進度表。 | 午休休满三十分钟。 |
| G05 | Send the update before they ask. | 先更新。省得他們來問你。 | 在他们问之前先更新。 |
| G06 | Fix the thing that's annoyed you for a week. | 把煩你一週的事修掉。一週太久了。 | 修掉那件烦了你一周的事。 |
| G07 | Write it down so you can stop remembering it. | 寫下來。你的腦不是待辦清單。 | 写下来，然后放过自己。 |
| G08 | Ask for help once. | 開口拜託一次。沒人會覺得你不行。 | 开口求助一次。 |
| G09 | Go home at the time you said. | 說六點走就六點走。燈不用你關。 | 说几点走就几点走。 |

**BAN**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| B01 | No fixing what nobody asked about. | 今天不改別人的錯字。 | 不修没人问的事。 |
| B02 | No redoing someone else's work quietly. | 不要偷偷重做。做完還假裝沒動。 | 不偷偷重做别人的活。 |
| B03 | No I'll just do it myself. | 不要說「我自己來比較快」。你會做到半夜。 | 不说「我自己来更快」。 |
| B04 | No staying late to prove a point. | 不要留下來證明什麼。沒有人在看。 | 不留下来证明什么。 |
| B05 | No email at dinner. | 晚餐時間不要看信。筷子都停在半空。 | 晚饭时间不看邮件。 |
| B06 | No new spreadsheet. The old one works. | 不要開新表格。你舊的還會用。 | 不开新表格，旧的还能用。 |
| B07 | No apologizing for being on time. | 不要為準時道歉。遲到的人才要。 | 不为准时道歉。 |

**PERMISSION**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| P01 | Say not my job today. | 今天講一次：這不干我的事。 | 今天说一次「这不归我管」。 |
| P02 | Stop at eighty. Nobody measures the rest. | 做到八成就停。剩兩成沒人看得出來。 | 让它九十分就好。 |
| P03 | Leave the dishes. | 碗留著。它們不會自己長大。 | 碗留着。 |
| P04 | Not explaining why you're tired. | 今天只說一句：我有點累。 | 不用解释你为什么累。 |
| P05 | Turn the phone off for an hour. | 關機一小時。信箱不會跑掉。 | 关机一小时。 |
| P06 | Skip the thing you always attend. | 那個每次都去的局，今天不去。他們不會發現。 | 那个你每次都去的，今天不去。 |
| P07 | Be the one who says no first. | 當第一個說不的人。他們都在等。 | 当第一个说不的人。 |

**WARNING**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| W01 | You'll be the only one on time. Again. | 你又會是唯一準時的那個。站著等。 | 准时到的，又只有你。 |
| W02 | You'll redo it tonight anyway. | 你今晚還是會重做。你對「差不多」有陰影。 | 你今晚还是会重做。 |
| W03 | You'll say fine and mean no. | 你說「沒事」的語氣，大家都聽得出來。 | 你会说「没事」，意思是「有事」。 |
| W04 | You'll see the typo and not sleep. | 你會在床上想起那個錯字。 | 你会看到那个错字，然后睡不着。 |
| W05 | You'll plan for a version of you with energy. | 你替有體力的自己排了太多事。 | 你会为有体力的自己排日程。 |
| W06 | You'll take the blame for a team decision. | 你會替團隊背那個不是你的責任。 | 你会替团队的决定背锅。 |
| W07 | The quick check is the whole evening. | 「順便看一下」會吃掉你整個晚上。 | 「顺便看一眼」就是整个晚上。 |

### ESTJ


**GOAL**（9）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| G01 | Say the decision out loud today. | 把決定說出來。你心裡已經宣布過了。 | 今天把决定说出来。 |
| G02 | Send the one email that unblocks three people. | 寄那封信。三個人卡在同一個地方。 | 发那封能解开三个人的邮件。 |
| G03 | Give one clear instruction. No preamble. | 講清楚要做什麼。不要先講三句場面話。 | 给一条清楚的指令，别铺垫。 |
| G04 | Delete one meeting from the calendar. | 刪掉一場會。你的行事曆快滿出來。 | 从日历删掉一场会。 |
| G05 | Praise one person specifically. | 誇他一句具體的。不要順便打分數。 | 具体夸一个人。 |
| G06 | Ask for the deadline in writing. | 期限請他回在文字裡。口頭不算。 | 截止时间要对方用文字回。 |
| G07 | Leave the office at six. | 六點走。不用回頭看第三次。 | 六点离开办公室。 |
| G08 | Fix the process, not the person. | 改流程，不要改人。人是改不動的。 | 改流程，别改人。 |
| G09 | Say I was wrong once. | 說一次「我錯了」。不用附檢討報告。 | 说一次「我错了」。 |

**BAN**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| B01 | No doing it for them today. | 今天不要接手。讓他們自己做一次。 | 今天不替他们做。 |
| B02 | No meeting that could be a message. | 不要開會。三句話可以講完。 | 不开能变成一条消息的会。 |
| B03 | No we'll see. | 不要說「再看看」。你自己知道那是不要。 | 不说「再看看」。 |
| B04 | No re-explaining the standard. | 標準今天不用再講第三次。 | 不再重讲标准。 |
| B05 | No working through lunch. | 不要邊吃邊回信。午餐十分鐘不算午餐。 | 不边吃边干活。 |
| B06 | No taking on what nobody assigned. | 不要接沒人派的事。最後都會變成你的。 | 不接没人派的事。 |
| B07 | No sighing at the group chat. | 不要在群組嘆氣。他們會以為要加班。 | 不对群叹气。 |

**PERMISSION**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| P01 | Delegate the thing you'd do in five minutes. | 派出去。你五分鐘能做完，不代表你要做。 | 派出去那个你五分钟能做完的。 |
| P02 | Leave the typo. | 錯字放過。它不會影響世界。 | 错字放过。 |
| P03 | Say good enough and ship. | 說「行了」就上線。不用等到百分之百。 | 说「行了」然后上线。 |
| P04 | Close the tab. The email can wait until morning. | 在最後一封信之前回家。信永遠還有。 | 在最后一封邮件之前回家。 |
| P05 | Not having an opinion about lunch. | 午餐吃什麼不用表態。今天可以隨便。 | 午饭吃什么可以不表态。 |
| P06 | Let someone else run it. | 讓別人主持。你在台下不會死。 | 让别人主持。 |
| P07 | Close your eyes. The inbox can wait. | 六點關機。誰找都一樣。 | 去睡一觉。 |

**WARNING**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| W01 | You'll take over the meeting in minute four. | 你會在第十分鐘把會接走。你忍不住。 | 你会第十分钟把会接走。 |
| W02 | You'll say quickly and it won't be. | 你會說「很快」。然後講四十分鐘。 | 你会说「很快」，然后不很快。 |
| W03 | You'll do their job and resent it by five. | 你會做完他的工作，五點才開始生氣。 | 你会做完他的活，五点开始怨。 |
| W04 | You'll be right in a way that costs you the room. | 你會辯到讓人閉嘴，然後覺得贏了。 | 你会对得让人不想再说话。 |
| W05 | You'll say yes to one more thing. You have no room. | 你已經滿了，還是會再答應一件。 | 你会再答应一件。你没位置。 |
| W06 | You'll skip lunch and call it discipline. | 你不吃午餐，然後管這個叫自律。 | 你不吃午饭，然后管这叫自律。 |
| W07 | You'll check messages at 10 p.m. | 你晚上十點還在看訊息。那是第二個老闆。 | 你晚上十点会看消息。 |

### ESFJ


**GOAL**（9）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| G01 | Ask one person how they actually are. | 問他好不好。聽完就好，先不要動手修。 | 问一个人他到底好不好。 |
| G02 | Say one true thing about yourself. | 講一件你自己的事。不用先問別人。 | 说一件关于自己的真话。 |
| G03 | Let someone help you. | 讓他幫你一次。你坐著也不會怎樣。 | 让别人帮你一次。 |
| G04 | Send the message that isn't a favor. | 傳一則跟幫忙無關的訊息。就一句笑話。 | 发一条不是求帮忙的消息。 |
| G05 | Eat lunch sitting down. | 坐下來吃。你吃飯的時間比泡麵還短。 | 坐下来把午饭吃完。 |
| G06 | Compliment one person on something real. | 誇他一句就好。不要順便給建議。 | 夸一件具体的事。 |
| G07 | Leave the group chat for an hour. | 退出群組一小時。地球還是會轉。 | 退出群聊一小时。 |
| G08 | Ask for the thing you need. | 今天開口要，不要先墊一個人情。 | 说出你需要的东西。 |
| G09 | Do one thing nobody thanks you for. | 做一件沒人會謝你的事，然後不要提。 | 做一件没人会谢你的事。 |

**BAN**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| B01 | No hosting today. For real. | 今天不要當主人。進門先坐下。 | 今天不当东道主。真的。 |
| B02 | No organizing other people's plans. | 不要排別人的週末。他們有自己的計畫。 | 不安排别人的日程。 |
| B03 | No apologizing for the mood of the room. | 氣氛冷掉不用道歉。那不是你的工作。 | 不为全场的气氛道歉。 |
| B04 | No checking the group chat twice. | 大家好不好，問一次就夠。 | 不确认大家好不好。一次够了。 |
| B05 | No saying yes before you think. | 今天不要馬上說好。 | 没想清楚之前不答应。 |
| B06 | No making the cake nobody asked for. | 不要烤蛋糕。沒有人點。 | 不做没人点的蛋糕。 |
| B07 | No mediating a fight you're not in. | 別人的架不要調解。你不在場。 | 不去劝你不在场的架。 |

**PERMISSION**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| P01 | Accept the offer without returning the favor. | 今天可以被照顧。不用搶著付錢。 | 今天可以被照顾。 |
| P02 | Leave the dishes for tomorrow. | 家事留到明天。灰塵不會抗議。 | 碗留到明天。 |
| P03 | Say I don't know to the plan. | 對計畫說「我不知道」。不用硬給答案。 | 对计划说「我不知道」。 |
| P04 | Not being the group's memory today. | 行程讓別人記。他們也該記一次。 | 今天不当大家的备忘录。 |
| P05 | Say no and don't soften it. | 拒絕就拒絕。不用繞三圈。 | 拒绝，也别修饰。 |
| P06 | Be quiet at dinner. | 晚餐可以安靜。不是冷場。 | 晚饭安静点。 |
| P07 | Send a text instead of calling. | 傳訊息就好。電話你會講四十分鐘。 | 发消息代替打电话。 |

**WARNING**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| W01 | You'll be the unpaid manager by ten. | 十點你就自己坐上主持人的位子。沒有人投票。 | 你十点就变成没工资的管理员。 |
| W02 | You'll say yes and check your calendar later. | 你會先說好，然後才打開行事曆。 | 你会先答应，再看日历。 |
| W03 | You'll feel invisible and not mention it. | 你收完、洗完、關燈，然後沒有人發現。 | 你会觉得没人看见，然后不说。 |
| W04 | You'll hold the mood of six people. | 你一個人扛六個人的情緒。他們在笑。 | 你一个人扛六个人的情绪。 |
| W05 | You'll say it's fine three times. | 你會說三次「沒事」。那是開場白。 | 你会说三次「没事」。 |
| W06 | You'll be exhausted by something you volunteered for. | 你會為自己報名的事累垮。那都是別人的事。 | 你会为自己报名的事累垮。 |
| W07 | You'll notice who didn't say thank you. | 你會記得誰沒說謝謝。記得很清楚。 | 你会注意到谁没道谢。 |

### ENFJ


**GOAL**（9）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| G01 | Say the thing you're holding back, kindly. | 把那句話講出來。他不會碎掉。 | 把那句憋着的话好好说出来。 |
| G02 | Ask for help without explaining why. | 開口要一次。不用先道歉。 | 今天开口要一个帮忙。 |
| G03 | Let one person solve their own problem. | 讓他處理。他沒有你也活得下去。 | 让一个人自己解决。 |
| G04 | Take ten minutes that aren't for anyone. | 留十分鐘給自己。廁所不算休息。 | 留十分钟不给任何人。 |
| G05 | Tell someone what you actually need. | 講你要什麼。你常常自己也不知道。 | 说出你真正需要的。 |
| G06 | Say no and stay warm. | 拒絕，然後不用補一段溫暖的話。 | 拒绝，而且保持温度。 |
| G07 | Name the awkward thing out loud. | 把尷尬的事講開。你最會處理別人的。 | 把尴尬的那件事挑明。 |
| G08 | Ask for feedback and sit with it. | 問完就聽。不要中途開始解釋。 | 问反馈，然后听完。 |
| G09 | Praise without fixing. | 誇就好。不要順便加一句「不過」。 | 夸，别顺便改。 |

**BAN**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| B01 | No coaching people who never opted in. | 今天不要開發別人。他沒報名。 | 不修没开口的人。 |
| B02 | No absorbing the room's mood today. | 不要吸全場的情緒。你不是吸塵器。 | 今天不吸全场情绪。 |
| B03 | No three-paragraph no. | 拒絕不用寫三段。一句就夠。 | 不为你的「不」写说明书。 |
| B04 | No mentoring people who didn't sign up. | 不要指導沒問你的人。路人也是人。 | 不指导没报名的人。 |
| B05 | No saying yes for the sake of the group. | 不要為大家好而答應。他們會自己好。 | 不为大家好而答应。 |
| B06 | No comparing yourself to the person you helped. | 幫完不要偷偷跟他比。 | 不跟被你帮的人比。 |
| B07 | No we when you mean I. | 不要講「我們」。那是你自己的事。 | 不说「我们」，如果你指「我」。 |

**PERMISSION**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| P01 | Step out before someone asks you to stay. | 提早走。不用留下來致詞。 | 提前走，不用致辞。 |
| P02 | Be the one who's struggling. | 今天可以撐不住。你不用當那個。 | 当那个撑不住的人。 |
| P03 | Not being inspiring today. | 今天不用勵志。你也不用安慰誰。 | 今天不用很励志。 |
| P04 | Say no to the cause you love. | 拒絕你愛的那個理想。它會等你。 | 拒绝你爱的那个理想。 |
| P05 | Be honest and let them be upset. | 說實話。他難過也是他的事。 | 说实话，让他不高兴。 |
| P06 | Do not greet everyone first today. | 今天不當大家的早晨。他們有鬧鐘。 | 今天不当大家的早晨。 |
| P07 | Let it be fine instead of great. | 讓它「還行」。不用逼到「很好」。 | 让它「还行」，不用「很好」。 |

**WARNING**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| W01 | You'll carry a mood that isn't yours. | 你回家還帶著別人的情緒。 | 你会扛一个不是你的情绪。 |
| W02 | You'll say we when you mean me. | 你會說「我們」。其實是「我」。 | 你会说「我们」，其实是「我」。 |
| W03 | You'll be the adult in the room again. | 你又會是房間裡那個大人。你很累。 | 你又会是屋里那个大人。 |
| W04 | You'll be tired by the third person. | 第三個人你就累了。你還是會撐到第五個。 | 第三个人你就累了。 |
| W05 | You'll call it support and it's control. | 你會把控制講成「我在幫你」。 | 你会把控制说成支持。 |
| W06 | You'll agree and regret it by four. | 你會先答應，四點開始後悔。 | 你会先答应，四点开始后悔。 |
| W07 | You'll notice the person at the edge and forget yourself. | 你會看到角落那個人，然後忘了自己。 | 你会看到角落里那个人，然后忘了自己。 |

### INFJ


**GOAL**（9）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| G01 | Say one honest thing before noon. | 中午前講一句真的。不要先包裝。 | 中午前说一句真话。 |
| G02 | Take the ten minutes nobody knows about. | 留十分鐘沒人知道。你需要消失一下。 | 留十分钟没人知道。 |
| G03 | Ask for what you actually want. Once. | 講你要的。講出來不代表你自私。 | 说出你真正想要的。一次。 |
| G04 | Write one page. Do not show it to anyone. | 今天寫一頁，不給任何人看。 | 写那封信，别寄。 |
| G05 | Let one silence stay silent. | 沉默就讓它沉默。不用急著填。 | 让一段沉默就只是沉默。 |
| G06 | Say I need a day and mean it. | 說「我需要一天」。然後真的休。 | 说「我需要一天」，然后真休。 |
| G07 | Leave the party while you still like it. | 還喜歡的時候就走。不要等到膩。 | 在还喜欢的时候离开派对。 |
| G08 | Tell one person the true version. | 對一個人講真的那版。不要三個版本。 | 对一个人说真的版本。 |
| G09 | Do the small kind thing for yourself. | 為自己做一件事。你為別人做的夠多了。 | 为自己做那件小事。 |

**BAN**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| B01 | No absorbing the room today. | 今天不要一進門就讀空氣。 | 今天不吸屋里的情绪。 |
| B02 | No fixing people who didn't ask. | 不要替沒開口的人先痛一次。 | 不修没开口的人。 |
| B03 | No saying it's fine when it isn't. | 群組那句話不是判決。不要再看。 | 不说「没事」，如果是有事。 |
| B04 | No reading the group chat as a verdict. | 你的「不」不用附說明。 | 不把群聊当判决书。 |
| B05 | No over-explaining your no. | 不要提示。讓他們自己找答案。 | 不为你的「不」解释。 |
| B06 | No giving the answer they should find. | 不要當大家的充電站。你也會沒電。 | 不给那些他们该自己找到的答案。 |
| B07 | No being everyone's quiet place. | 不要先幫別人想台詞。他們會自己講。 | 不当所有人的安静角落。 |

**PERMISSION**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| P01 | Leave without the goodbye tour. | 走就走。不用每個都告別。 | 走，不用一个个告别。 |
| P02 | Be the one who's not okay. | 今天可以不太好。沒有人會因此離開。 | 当那个不太好的人。 |
| P03 | Say no without the reason. | 拒絕不用理由。你就是不想。 | 拒绝，不用理由。 |
| P04 | Be ordinary tonight. | 今晚普通就好。不是每件事都要有意義。 | 今晚普通就好。 |
| P05 | Not having the insight today. | 今天可以什麼都沒看透。 | 今天可以没有洞见。 |
| P06 | Cancel and stay home. | 取消一個約。愧疚放在門外。 | 取消，待在家。 |
| P07 | Let them misunderstand you once. | 讓他們誤會一次。不用馬上澄清。 | 让他们误会你一次。 |

**WARNING**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| W01 | You'll feel a mood that started somewhere else. | 你會感覺到一個不是你的情緒。 | 你会感觉到一个不属于你的情绪。 |
| W02 | You'll say it's fine and sleep badly. | 躺下之後，你的會議才開始。 | 你会说「没事」，然后睡不好。 |
| W03 | You'll be right and say nothing. | 你看對了，然後一個字都不說。 | 你会是对的，然后一个字都不说。 |
| W04 | You'll give away the hour you needed. | 你會把需要的那一小時送出去。 | 你会把需要的那小时送出去。 |
| W05 | You'll leave quietly and hope they notice. | 你會安靜離開，然後希望有人追出來。 | 你会安静离开，然后希望被看见。 |
| W06 | You'll be tired from a conversation that didn't happen. | 你會為一場沒發生的對話累一整天。 | 你会为一场没发生的对话累。 |
| W07 | You'll forgive and remember. | 你會原諒得很快，然後記得很久。 | 你会原谅，然后记住。 |

### INFP


**GOAL**（9）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| G01 | Send it before you rewrite it six times. | 送出。第七次也不會比較好。 | 别改第六遍了，直接发。 |
| G02 | Say one true sentence out loud. | 講出來。你在心裡講得很順。 | 说一句真话，出声。 |
| G03 | Answer the message with one honest line. | 回一句就好。不用寫完再刪掉。 | 用一句诚实的话回消息。 |
| G04 | Take the walk without the podcast. | 散步就散步。不用配 Podcast。 | 散步，别听播客。 |
| G05 | Write the feeling down. Then close the notes. | 寫下來，然後關掉。不用重讀十次。 | 把感觉写下来，然后关掉。 |
| G06 | Say what you want once. No apology after. | 說一次你要什麼。不用先道歉。 | 说一次你要什么，后面别道歉。 |
| G07 | Wear the thing. Go outside. | 穿那件出門。場合不會自己出現。 | 穿那件，出门。 |
| G08 | Do the small thing you keep romanticizing. | 做那件小事。它不是一場革命。 | 做那件你一直美化的小事。 |
| G09 | Tell one person the answer you actually mean. | 講你真正想的。安全答案他聽過了。 | 对一个人说真正的答案。 |

**BAN**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| B01 | No apologizing for existing. | 今天不要再道歉。你沒有做錯。 | 今天先别道歉。你没有做错什么。 |
| B02 | No rewriting the message more than twice. | 改兩次就好。你的兩次是十次。 | 不超过改两遍。 |
| B03 | No imagining their reply all day. | 不要幫他寫回覆。他會自己回。 | 不整天想象他的回复。 |
| B04 | No sorry for the long text. | 不要寫「抱歉打得有點長」。 | 不写「抱歉写得有点长」。 |
| B05 | No making yourself smaller to fit the room. | 不要縮小。這個房間裝得下你。 | 不为了挤进这个屋而缩小自己。 |
| B06 | No researching the feeling at 2 a.m. | 凌晨不要研究自己的情緒。你會寫到天亮。 | 凌晨两点不研究自己的情绪。 |
| B07 | No sending the letter. | 那封信不要寄。它只是寫給你自己。 | 不寄那封信。 |

**PERMISSION**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| P01 | Leave early. No exit speech. | 提早離場。不用一個一個道別。 | 提前走，不用挨个告别。 |
| P02 | Be the one who doesn't explain. | 今天不用解釋。沒有人問你。 | 当那个不解释的人。 |
| P03 | Disappoint one person today. | 讓一個人失望。他不會因此消失。 | 今天让一个人失望。 |
| P04 | Not being the nice one. | 今天不當好人。好人也會累。 | 不当好人。 |
| P05 | Cry, then eat something. | 哭一哭，然後吃點東西。 | 哭，然后吃点东西。 |
| P06 | Say no to the plan you'd hate. | 拒絕那個計畫。你會後悔一整週。 | 拒绝你会难受的那个计划。 |
| P07 | Be a stranger in the group chat. | 在群組安靜沒關係。你每則都看了。 | 在群里当个陌生人。 |

**WARNING**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| W01 | 3 p.m. feelings are not facts. | 下午三點的情緒，不是事實。 | 下午三点的情绪，不算数。 |
| W02 | You'll draft it, delete it, send ok. | 你會寫完、刪掉、送出一個「好」。 | 你会写完、删掉、发个「好」。 |
| W03 | You'll rehearse a conversation that won't happen. | 你會預演一場不會發生的對話。 | 你会预演一场不会发生的对话。 |
| W04 | You'll be homesick for a place you invented. | 你會想念一個根本不存在的地方。 | 你会想念一个你自己编出来的地方。 |
| W05 | You'll say fine and mean devastated. | 你會說「沒事」。那其實是求救。 | 你会说「没事」，意思是「要塌了」。 |
| W06 | You'll defend someone who wouldn't. | 你會替不會替你講話的人講話。 | 你会替不会替你说话的人说话。 |
| W07 | You'll rewrite the past by dinner. | 你晚餐前會把過去改寫一次。 | 你晚饭前会改写过去。 |

### ISFJ


**GOAL**（9）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| G01 | Ask for one thing today. | 今天要一樣東西。不用先送禮。 | 今天开口要一样东西。 |
| G02 | Sit down while everyone else moves. | 大家站著的時候，你坐下。 | 大家站着的时候，你坐下。 |
| G03 | Say one sentence that starts with I need. | 講一句「我需要」。你的句子都以別人開頭。 | 说一句以「我需要」开头的话。 |
| G04 | Let someone else make the plan. | 讓他安排這次。不要偷偷再確認。 | 让别人安排这次。 |
| G05 | Eat something before the thing. | 出門前先吃。你會忙到忘記。 | 出门前先吃点东西。 |
| G06 | Leave one task for tomorrow. | 留一件給明天。它不會壞。 | 留一件事给明天。 |
| G07 | Tell someone what you actually did. | 講你做了什麼。沒有人知道。 | 说出你实际做了什么。 |
| G08 | Say no before you say let me see. | 先說不。你的「我看看」就是好。 | 在「我看看」之前先说「不」。 |
| G09 | Take the nap. | 去睡。睡不是浪費。 | 去睡一会儿。 |

**BAN**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| B01 | No being the group's memory today. | 不要替別人排他的下一步。 | 今天不当大家的备忘录。 |
| B02 | No fixing what nobody noticed. | 不要補那個沒人注意的地方。 | 不补没人注意到的地方。 |
| B03 | No saying yes to keep the peace. | 不要為了和諧而答應。和諧不值這個價。 | 不为和平而答应。 |
| B04 | No preparing food nobody will eat. | 不要準備沒人會吃的東西。 | 不做那个蛋糕。 |
| B05 | No apologizing for the mood. | 氣氛怪掉不用道歉。你不是主持人。 | 不为气氛道歉。 |
| B06 | No checking if they're upset. Once is enough. | 問一次就好。你問三次他們才真的生氣。 | 不确认他们有没有生气。一次够了。 |
| B07 | No doing it again because it's faster. | 不要因為比較快又重做一次。 | 不因为更快又重做一遍。 |

**PERMISSION**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| P01 | Be taken care of today. | 今天被照顧，不用先問對方累不累。 | 今天被照顾。 |
| P02 | Skip the phone call. | 那通電話不用打。他不會介意。 | 那个电话不打。 |
| P03 | Let the tradition pause. | 那個傳統今年可以停一次。 | 那个传统今年可以停一次。 |
| P04 | Say I'm tired without the explanation. | 說「我累」就好。累不用有理由。 | 说「我累」，不用理由。 |
| P05 | Leave the kitchen. | 離開廚房。他們會自己收。 | 离开厨房。 |
| P06 | Not being the reliable one for one day. | 今天不當可靠的那個。一天而已。 | 一天不当可靠的那个。 |
| P07 | Ask for the same effort back. | 要求一樣的力氣回來。在心裡也算。 | 要求同样的力气回来。 |

**WARNING**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| W01 | You'll be the unpaid organizer by nine. | 九點你就開始張羅，像有人指派你一樣。 | 你九点就变成没工资的主办。 |
| W02 | You'll say yes and regret it at midnight. | 你會點頭，然後半夜開始後悔。 | 你会答应，然后半夜后悔。 |
| W03 | You'll feel unseen and call it fine. | 你做完，然後沒有人記得。 | 你会觉得没人看见，然后说没事。 |
| W04 | You'll remember everyone's thing but your own. | 你會記得大家的生日，除了自己的。 | 你会记得大家的事，除了自己的。 |
| W05 | You'll redo it because they did it wrong. | 你會一邊念，一邊重做一次。 | 你会因为他们做错又重做。 |
| W06 | You'll say no worries while worrying. | 你會說「沒事啦」，一邊擔心到不行。 | 你会说「没事儿」，一边在担心。 |
| W07 | You'll carry the day for six people quietly. | 你會安靜扛完六個人的一天。 | 你会安静地扛完六个人的一天。 |

### ISFP


**GOAL**（9）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| G01 | Make the small thing today. | 做那個小的。小的你比較自在。 | 今天做那个小东西。 |
| G02 | Wear the color you saved. | 穿那個顏色。場合不會自己來。 | 穿你留着的那个颜色。 |
| G03 | Take one photo and keep it. | 拍一張就好。自己留著。 | 拍一张，自己留着。 |
| G04 | Say the honest no once. | 老實說一次「不」。不用繞三圈。 | 老实说一次「不」。 |
| G05 | Sit somewhere that isn't your room. | 去坐別的位子。你的位子沒有寫名字。 | 坐在不是你房间的地方。 |
| G06 | Do the thing badly first. | 把喜歡的歌放很大聲。今天不用小聲。 | 先做烂，再变好。 |
| G07 | Tell one person the real answer. | 把你真正想的講出來。小聲也行。 | 对一个人说真的答案。 |
| G08 | Move your body for ten minutes. | 動十分鐘。躺著想運動不算運動。 | 动十分钟身体。 |
| G09 | Leave the party on a good song. | 歌好聽的時候就走。不要等它播完。 | 在好听的那首歌离开派对。 |

**BAN**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| B01 | No performing for the room. | 不要演給房間裡的人看。 | 不为屋里的人表演。 |
| B02 | No saying yes out of politeness. | 不要因為禮貌而答應。禮貌不會留下。 | 不因为礼貌而答应。 |
| B03 | No explaining your taste. | 不要解釋你的品味。喜歡就喜歡。 | 不解释你的品味。 |
| B04 | No making it perfect before you start. | 不要等完美才開始。你會在原地。 | 不先做到完美才开始。 |
| B05 | No letting the mood decide for you. | 不要讓心情替你決定。它今天很吵。 | 不让心情替你做决定。 |
| B06 | No waiting for permission to go. | 散場之後不用留下來幫忙收。 | 歌没了就别再留。 |
| B07 | No apologizing for going quiet. | 安靜不用道歉。 | 不为变安静道歉。 |

**PERMISSION**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| P01 | Leave first. | 先走。不用等誰一起。 | 第一个走。 |
| P02 | Be unknown in this room. | 在這個房間當不認識的人。 | 在这个屋当不认识的人。 |
| P03 | Not having a plan. | 今天沒有計畫。照樣過得完。 | 没有计划也可以。 |
| P04 | Change your mind and don't justify it. | 換主意不用交代。你不是在報告。 | 改主意，不用说明。 |
| P05 | Say no to the plan you only said yes to. | 你可以晚一點再決定。 | 让计划失望。 |
| P06 | Be alone and not lonely. | 一個人也可以不寂寞。 | 一个人，但不寂寞。 |
| P07 | Say I'd rather not. | 講「我比較不想」。不用修飾。 | 说「我不太想」。 |

**WARNING**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| W01 | You'll agree and hate the whole night. | 你會答應，然後整晚都在恨。 | 你会答应，然后整晚都在恨。 |
| W02 | You will say yes and go quiet for the rest of the night. | 你會一句話都不說就走。 | 你会一句话都不说就走。 |
| W03 | You'll get talked into the thing you dread. | 你會被人推一下，就去做那件你怕的事。 | 你会被人劝进那件你怕的事。 |
| W04 | You'll feel the room change before anyone speaks. | 房間一變，你就先感覺到。 | 屋里的变化你先感觉到。 |
| W05 | You'll say it's fine and mean never again. | 你會笑著，然後整晚不講話。 | 你会说「没事」，意思是「别再」。 |
| W06 | You'll buy the thing to fix a mood. | 你會買東西來修心情。它修不好。 | 你会买东西来治心情。 |
| W07 | You'll be quiet and they'll call it cold. | 你安靜，他們就說你冷。 | 你会安静，然后他们说你冷。 |

### ENTJ


**GOAL**（9）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| G01 | Make the call you've been postponing. | 打那通你最不想打的電話。 | 打那通你一直拖的电话。 |
| G02 | Give the answer, not the options. | 給答案。三個選項只是你在拖。 | 给答案，别给选项。 |
| G03 | Say the number out loud in the meeting. | 把數字講出來。你心裡已經算完了。 | 在会上把数字说出来。 |
| G04 | Delete one thing from the plan. | 從計畫刪掉一件。它只會變長。 | 从计划里删掉一件。 |
| G05 | Ask the question that ends the meeting early. | 問那句能讓會早點結束的話。 | 问那个能让会早点结束的问题。 |
| G06 | Do the twenty-minute thing first. | 先做那二十分鐘。小事也是事。 | 先做那二十分钟的事。 |
| G07 | Tell one person what you actually think of their work. | 講你真正的看法。憋著更難受。 | 对一个人的工作说出真实看法。 |
| G08 | Leave on time. That's the test. | 準時走。今天不加班是測驗。 | 准时走。这是考试。 |
| G09 | Write the one-page version. | 寫一頁就好。不是十頁。 | 写一页版本。 |

**BAN**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| B01 | No taking over at minute four. | 第十分鐘不要接手。手放桌上。 | 第十分钟别接手。 |
| B02 | No quick call that runs an hour. | 不要開「快速通話」。你的快速一小時。 | 不开那种一小时的「快速通话」。 |
| B03 | No doing their job silently. | 不要默默做掉他的工作。那是他的。 | 不默默做掉他的活。 |
| B04 | No working through dinner. | 不要跳過晚餐。餓不是效率。 | 不跳过晚饭。 |
| B05 | No new strategy before the last one ships. | 上一個還沒上線，不要開新的。 | 上一个没上线，不开新策略。 |
| B06 | No arguing with people who aren't deciding. | 不要跟不做決定的人辯。他不會簽。 | 不跟不做决定的人辩。 |
| B07 | No let's circle back. | 不要說「之後再聊」。你的之後等於沒有。 | 不说「回头再聊」。 |

**PERMISSION**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| P01 | Be wrong in public. | 認錯就好。不用順便檢討流程。 | 当众认错。 |
| P02 | Delegate badly and let them learn. | 派得不好也沒關係。他們要學。 | 派得不好，让他们学。 |
| P03 | Leave the meeting without the last word. | 不用搶最後一句。會議會自己結束。 | 不抢最后一句就离开会。 |
| P04 | Take the weekend. | 週末真的休。你有兩場會可以刪。 | 周末真休。 |
| P05 | Say I don't know yet. | 說「我還不知道」。這句不會扣分。 | 说「我还不知道」。 |
| P06 | Let the second-best option win. | 讓第二好的方案贏一次。 | 让第二好的方案赢。 |
| P07 | Skip the thing that moves nothing. | 跳過那件不會動的事。 | 跳过那件不会动的事。 |

**WARNING**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| W01 | You'll take the wheel in minute three. | 你會第三分鐘就把方向盤搶過來。 | 你会第三分钟就把方向盘抢过来。 |
| W02 | You'll call it a five-minute sync. | 你會說「五分鐘會議」。然後講四十分鐘。 | 你会管这叫「五分钟对齐」。 |
| W03 | You'll be right and alone with it. | 你會對，而且會說出來。兩件事都不用。 | 你会是对的，然后一个人对。 |
| W04 | You'll say fine and rewrite it tonight. | 你會說「可以」。然後今晚重寫。 | 你会说「行」，然后今晚重写。 |
| W05 | You'll skip lunch and call it focus. | 你把餓當成效率。那不是效率。 | 你不吃午饭，管这叫专注。 |
| W06 | You'll add one more thing to the list. | 你會再往清單加一件。它已經滿了。 | 你会再往清单上加一件。 |
| W07 | You'll check messages at midnight. | 十二點你還會點開它。睡前最後一眼。 | 你半夜十二点会看消息。 |

### ISTP


**GOAL**（9）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| G01 | Fix the one annoying thing. Ten minutes. | 修掉那件煩人的事。十分鐘而已。 | 修掉那件烦人的事。十分钟。 |
| G02 | Say one sentence instead of mm. | 回一句完整的。不要只「嗯」。 | 说一句话，别只「嗯」。 |
| G03 | Test the thing before explaining it. | 先試。解釋等試完再說。 | 先试，再解释。 |
| G04 | Take the long way on the bike. | 騎車繞遠路。繞完就沒事了。 | 骑车绕远路。 |
| G05 | Answer the text with three words. | 三個字也可以。你已經很努力了。 | 用三个字回那条消息。 |
| G06 | Put the tool back where it goes. | 工具放回去。下次你找不到。 | 工具放回它该在的地方。 |
| G07 | Do the task in one go, then stop. | 做完就停。不要再順手修一遍。 | 一次做完，然后停。 |
| G08 | Ask one direct question. | 直接問。你在心裡問三遍了。 | 问一个直接的问题。 |
| G09 | Leave the phone in the other room for an hour. | 手機丟另一個房間。它不會跑。 | 手机丢另一个房间一小时。 |

**BAN**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| B01 | No explaining the fix twice. | 修法不要解釋第二次。他們也不會記。 | 不把修法解释第二遍。 |
| B02 | No meeting you're not paid for. | 不要開沒錢的會。你坐著在算成本。 | 不开没钱的会。 |
| B03 | No small talk before coffee. | 咖啡前不要社交。你只有單字。 | 咖啡前不社交。 |
| B04 | No fixing what isn't broken. | 不要修沒壞的東西。它不是壞了。 | 不修没坏的东西。 |
| B05 | No quick favors. | 不要接「順手幫一下」。那是兩小時。 | 不接「顺手帮一下」。 |
| B06 | No reading the manual twice. | 說明書不要讀第二遍。你早就會了。 | 说明书不读第二遍。 |
| B07 | No sitting through the whole thing politely. | 不要有禮貌地坐完整場。你坐不住。 | 不有礼貌地坐完全场。 |

**PERMISSION**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| P01 | Leave when it's fixed. | 修好就走。不用留下來聊。 | 修好就走。 |
| P02 | Say yeah, no. | 說「沒有，不用」。不用補抱歉。 | 说「没有，不用」。 |
| P03 | Not explaining your weekend. | 週末做了什麼不用報告。 | 不汇报你的周末。 |
| P04 | Do it the fast way. | 用快的方法。漂亮不是重點。 | 用快的方法。 |
| P05 | Skip the group dinner. | 團體晚餐不去。去了也只是坐著。 | 团体晚餐不去。 |
| P06 | Take the silence as an answer. | 沉默就是答案。你不用再問。 | 把沉默当答案。 |
| P07 | Be bored out loud. | 無聊就說無聊。冷場也是一種結局。 | 无聊就说无聊。 |

**WARNING**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| W01 | You'll say mm and they'll keep talking. | 你只回一個字，他當成邀請。 | 你会「嗯」，然后他继续讲。 |
| W02 | You'll fix it and explain it for forty minutes. | 你修四分鐘，講了四十分鐘。 | 你会修好，然后解释四十分钟。 |
| W03 | You'll get pulled into a meeting about a meeting. | 你會被抓進一場「關於會議的會議」。 | 你会被抓进一场「关于会的会」。 |
| W04 | You'll agree to one favor. It's three. | 你會答應一個忙。最後是三個。 | 你会答应一个忙。总共三个。 |
| W05 | You'll be late because the road was good. | 你會因為路太好騎而遲到。 | 你会因为路太好骑而迟到。 |
| W06 | You'll start it at ten and finish at two. | 你十點開始，兩點才結束。 | 你十点开始，两点结束。 |
| W07 | You'll disappear for the whole afternoon. | 你整個下午會消失。沒有人找得到你。 | 你整个下午会消失。 |

### ESTP


**GOAL**（9）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| G01 | Say it, then do it, in that order. | 先講，再做。講完你就知道要做什麼。 | 先说，再做，按这个顺序。 |
| G02 | Ask for the thing directly. | 直接開口要。繞一圈更花時間。 | 直接开口要。 |
| G03 | Do the boring ten minutes first. | 先做那無聊的十分鐘。開頭最難。 | 先做无聊的那十分钟。 |
| G04 | Make the call instead of the text. | 打過去。訊息你傳三天沒人回。 | 打电话，别发消息。 |
| G05 | Sprint the small thing. | 小事就直接做。想三秒就變大事。 | 小事就冲。 |
| G06 | Go to the thing and leave when it's done. | 去了，做完就走。不要多留半小時。 | 去了，做完就走。 |
| G07 | Fix one broken thing before noon. | 中午前修好一件。只修那件。 | 中午前修好一件坏的。 |
| G08 | Say the number in the room. | 把那個數字講出來。不是感覺。 | 在屋里把数字说出来。 |
| G09 | Take the walk instead of the scroll. | 出去走。你滑手機滑掉一個下午。 | 出去走走，别刷手机。 |

**BAN**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| B01 | No five more minutes today. | 今天不要說「再五分鐘」。 | 今天不说「再五分钟」。 |
| B02 | No last-minute plan you'll regret. | 不要臨時約。你約完會問自己在哪。 | 不临时约你会后悔的局。 |
| B03 | No arguing with people who won't move. | 不要跟不會動的人吵。他只想被吵。 | 不跟不会动的人辩。 |
| B04 | No saying yes before coffee. | 咖啡前不要答應大事。你還沒醒。 | 咖啡前不答应大事。 |
| B05 | No scrolling through what you already did. | 不要重看自己做完的事。 | 不刷你早就做完的事。 |
| B06 | No driving to the meeting you could skip. | 不要開車去那場可以跳過的會。 | 不开车去那场能跳过的会。 |
| B07 | No one more round. | 不要再來一輪。你的三輪已經開始。 | 不再来一轮。 |

**PERMISSION**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| P01 | Go before the second round starts. | 第一個走。不用解釋去哪裡。 | 第一个走。 |
| P02 | Skip the part that isn't fun or paid. | 不好玩又沒錢的就跳過。 | 不好玩又没钱的部分跳过。 |
| P03 | Say not doing it. | 直接說「我不要」。不用搞笑帶過。 | 说「我不做」。 |
| P04 | Do the thing without a plan. | 沒有計畫也可以。你本來就沒在照。 | 没计划也能做。 |
| P05 | Be wrong and laugh. | 錯了就笑。不用假裝沒事。 | 错了就笑。 |
| P06 | Take the nap you'd call lazy. | 去睡。你累到還在說不累。 | 去睡那个你会嫌懒的觉。 |
| P07 | Go home early with the story. | 早點回家。故事明天再講。 | 早点回家，把故事带走。 |

**WARNING**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| W01 | You'll say yes before checking the calendar. | 你會沒看行事曆就先答應。 | 你会没看日历就先答应。 |
| W02 | You'll start at eleven and need a nap at eleven-twenty. | 十一點開始，十一點二十就想睡。 | 你十一点开始，十一点二十就想睡。 |
| W03 | You'll take the bet. It's not a bet. | 你會賭。那明明不是賭。 | 你会赌。那不是赌。 |
| W04 | You'll be honest in the worst room. | 你會在最不該誠實的房間誠實。 | 你会在这屋里最不该说实话的时候说实话。 |
| W05 | You'll do it the fast way and explain it at midnight. | 你會用快的方法，然後半夜解釋。 | 你会用快的方法，然后半夜解释。 |
| W06 | You'll be late and call it traffic. | 你會十一點才到，然後說「剛剛好」。 | 你会迟到，然后说堵车。 |
| W07 | You'll get in the car with no destination. | 你會坐上車，然後才想目的地。 | 你会坐上车，没有目的地。 |

### ESFP


**GOAL**（9）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| G01 | Say the thing you've been rehearsing. | 講那句話。你排練的是他們的反應。 | 说那句你一直在排练的话。 |
| G02 | Dance for one song. Then stop. | 跳一首歌就好。跳到第三首你就累了。 | 跳一首歌。然后停。 |
| G03 | Take the photo. Don't check it. | 拍一張就收。不用拍二十張選一張。 | 拍一张，别检查。 |
| G04 | Call instead of texting. | 電話拿起來。訊息排到明天了。 | 打电话，别发消息。 |
| G05 | Go to the thing you keep canceling. | 去那個局。你已經取消兩次了。 | 去那个你一直取消的局。 |
| G06 | Wear the outfit. | 穿那一套。你買了還沒穿出去過。 | 穿那一套。 |
| G07 | Do one thing just because. | 做一件沒有理由的事。 | 做一件没有理由的事。 |
| G08 | Say I want out loud. | 講「我想要」。小聲講也算。 | 把「我想要」说出来。 |
| G09 | Leave the party while it's still good. | 好玩的時候就走。你每次都留到散場。 | 在还玩得开心的时候离开派对。 |

**BAN**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| B01 | No checking the mirror before the photo. | 拍照前不要照鏡子。你已經在廁所看過了。 | 拍照前别照镜子。 |
| B02 | No comparing yourself to the group chat. | 不要跟群組比。你比完會難過。 | 不跟群里比。 |
| B03 | No buying the thing to feel better. | 不要買東西治心情。你會更差。 | 不买东西来治心情。 |
| B04 | No saying yes to the plan you'll dread. | 不要先說好。那件事你會怕。 | 不答应你会怕的那个计划。 |
| B05 | No scrolling at 1 a.m. | 凌晨不要滑手機。你會滑到天亮。 | 凌晨一点不刷手机。 |
| B06 | No playing small to keep them comfortable. | 不要為了他們舒服而變小聲。 | 不为了让他们舒服而变小声。 |
| B07 | No I'm fine when you're not. | 不好就說不好。不要說還不錯。 | 不好就别硬说「我很好」。 |

**PERMISSION**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| P01 | Be the loud one. | 當大聲的那個。大聲是你的保護色。 | 当大声的那个。 |
| P02 | Stay thirty minutes, then go. No explanation. | 可以只待一小時。沒有人會數。 | 当早走的那个。 |
| P03 | Be sad in public. | 難過可以給人看。不用邊笑邊難過。 | 难过可以让人看见。 |
| P04 | Not being entertaining tonight. | 今晚不用很好笑。你也是來玩的。 | 今晚不用很好笑。 |
| P05 | Skip the group photo. | 合照不拍。站邊邊也可以。 | 合影不拍。 |
| P06 | Say the thing that makes it awkward. | 講那句會讓場面尷尬的話。 | 说那句会让场面尴尬的话。 |
| P07 | Take up space. | 位子佔著。不用讓給誰。 | 占位置。 |

**WARNING**（7）

| idx | en | zh-Hant | zh-Hans |
|---|---|---|---|
| W01 | You'll promise to be there by eight. | 你會答應八點到。然後十點才出門。 | 你会答应八点到。 |
| W02 | You'll be tired at ten and leave at twelve. | 你十點就累，十二點才走。 | 你十点就累，十二点才走。 |
| W03 | You'll buy it and forget it. | 你會買，然後忘記放在哪。 | 你会买，然后忘。 |
| W04 | You'll feel it all at 2 a.m. | 凌晨兩點，你會全部感覺到。 | 你凌晨两点会全部感觉到。 |
| W05 | You'll call a bad night so fun. | 你會把爛的一晚講成「超好玩」。 | 你会把烂的一晚说成「超好玩」。 |
| W06 | You'll check your phone during the good part. | 最好玩的時候，你在看手機。 | 最好玩的时候你在看手机。 |
| W07 | You'll be honest and it'll be a whole thing. | 你會說實話，然後變成一件事。 | 你会说实话，然后变成一件事。 |

## 8 產出流程（五步）

1. 選型，先寫 5 條 `WARNING`（最難，先確認聲音對不對）。
2. 補 `GOAL` 9 條，每條自問「他今天真的做得到嗎」。
3. 補 `BAN` 7 條與 `PERMISSION` 7 條，兩者要成對（禁什麼就允許什麼）。
4. 逐句跑 §6 六條驗收，標 `spicy` / `clean`。
5. 以 `型別 × 天序` 定址，同一天同一句，寫進句子庫（§7 對應欄位）。

## 9 資料格式

- key：`quote.<type>.<label>.<idx>`（例 `quote.intj.warning.3`）；表內 `W03` = `warning.3`。
- 每條一個 `spicy` / `clean` 標記；clean 池給「鎖屏不想被看到粗口」的人用（標記尚未填，見 `todolist.md`）。
- 索引：`day index` + 型別 → 固定句子，跨裝置、重裝一致，禁隨機。
- 一個月 30 條，第 31 天回到 01；句子庫只增不減。

## 10 四個必踩的反例

1. `"Be your best self."` — 無法驗收、空話。
2. `"You'll have a bad day."` — 是詛咒，不是被說中。
3. `"No sugar."` — 滑向健康建議，會碰 `1.4.1`。
4. `"Text him back."` — 感情建議，且需要真實資料。

## 11 別做的事

1. 不捏造行程、不假裝知道他發生什麼。
2. 不做心理診斷或健康／財務／感情建議。
3. 不寫 slur、不針對任何族群或個人。
4. 不寫絕對日期（`on November 3`），三個月後就過期。
5. 不在商店截圖與文案出現粗口（`2.3.8` 要求 metadata 適度 4+）。

## 12 驗收條件

1. 三語 480 列、key 完全對齊，無缺列、無重複。
2. 每型 `G9／B7／P7／W7`，共 480。
3. 每句通過 §6 六條，且不超過該語版字數上限。
4. 句子不含標籤文字、不含絕對日期、不含人名地點。
5. 商店截圖只用 `clean` 句（`todolist.md` 追蹤）。

## 12.1 兩反應抽讀（待執行；未通過不得進 `xcstrings`）

> 狀態：**暫緩**。建 App 前必須完成，這是進 `xcstrings` 的硬 gate。

1. 抽樣：分層隨機，每型最多 1 條，標籤比例 `G3／B2／P2／W3`；`en` 與 `zh-Hant` 各 10 條。
2. 遮資訊：只給句子，不給型別、標籤、key。
3. 三題：① 笑了嗎 0/1 ② 這是你嗎 0/1 ③ 哪個詞看不懂（寫詞，無則 `-`）。
4. 判定：兩題都 1 = 過；一題 = 待改；都 0 = 重寫。
5. 門檻：達標率 < 70% → 整批改；≥ 70% 才准鎖定句子並進 `xcstrings`。
6. 限制：受測者須是該型本人；一次最多 10 條，避免疲勞；下一輪換 seed。
