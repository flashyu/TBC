-- Traditional Chinese text strings by whocare@TW-HLX

if(GetLocale()=="zhTW") then
-- Binding Configuration
BINDING_HEADER_MAILTO   = "MailTo"
BINDING_NAME_MAILTOLOG  = "顯示MailTo紀錄"
BINDING_NAME_MAILTOEX   = "顯示收件夾存放時限"
BINDING_NAME_MAILTOMAIL = "切換MailTo收件視窗"

-- MailTo option list with text
MAILTO_OPTION = { alert=  {flag='noalert', name="寄達通知"},
                  auction={flag='noauction', name="點擊拍賣"},
                  chat=   {flag='nochat',  name="點擊交談"},
                  coin=   {flag='nocoin',  name="現金郵件"},
                  ding=   {flag='noding',  name="叮噹聲音"},
                  click=  {flag='noclick', name="物品欄"},
                  login=  {flag='nologin', name="登入通知"},
                  right=  {flag='noshift', name="右鍵點擊"},
                  trade=  {flag='notrade', name="點擊追蹤"},
                }
MAILTO_DAYS = {icon=28, long=3, new=7, short=1, soon=3, warn=2}

-- Message text
MAILTO_ON =         "%s 已經開啟"
MAILTO_OFF =        "%s 已經關閉"
MAILTO_TIME =       " '%s' 過期時限設定為 %s"
MAILTO_TOOLTIP =    "點擊選擇收件人"
MAILTO_CLEARED =    "郵寄清單已經清除!"
MAILTO_LISTEMPTY =  "清除清單"
MAILTO_LISTFULL =   "警告: 清單已滿!"
MAILTO_ADDED =      "加入郵寄清單"
MAILTO_REMOVED =    "移出郵寄清單"
MAILTO_F_ADD =      "(新增 %s)"
MAILTO_F_REMOVE =   "(移除 %s)"
MAILTO_YOU =        "你"
MAILTO_DELIVERED =  "寄達"
MAILTO_DUE =        "預計 %d 分鐘後寄達"
MAILTO_SENT =       "%s 寄給 %s 由 %s %s"
MAILTO_RETURNLIST = "可返回物品:"
MAILTO_RETURN =     "|cffffffff%s|r 寄給 %s"
MAILTO_NORETURN =   "為發現可返回物品"
MAILTO_NEW =        "%s%s 來自 %s 寄給 %s"
MAILTO_NONEW =      "未發現新收物品"
MAILTO_NEWMAIL =    "(可能新郵件)"
MAILTO_LOGEMPTY =   "郵寄記錄是空的"
MAILTO_NODATA =     "無收件資料"
MAILTO_NOITEMS =    "收件夾是空的"
MAILTO_NOTFOUND =   "未發現物品"
MAILTO_INBOX =      "#%d, %s, 來自 %s"
MAILTO_EXPIRES =    "將要過期"
MAILTO_EXPIRED =    "已經過期!"
MAILTO_UNDEFINED =  "未定義指令, "
MAILTO_RECEIVED =   "收到 %s 來自 %s, %s"
MAILTO_SALE =       "%s 購買 %s 數量 %s (淨額=%s)."
MAILTO_WON =        "你購買 %s 來自 %s 數量 %s."
MAILTO_NONAME =     "姓名不詳"
MAILTO_NODESC =     "敘述不詳"
MAILTO_MAILOPEN =   "郵箱開啟"
MAILTO_MAILCHECK =  "尚未檢查郵件"
MAILTO_TITLE =      "MailTo  收件匣"
MAILTO_STACK =	    "(堆疊 %d)"
MAILTO_DATE =       "收件日期: "
MAILTO_SELECT =     "選擇:"
MAILTO_SERVER =     "伺服器"
MAILTO_SERVERTIP =  "檢查其他伺服器的角色"
MAILTO_FROM =       "來自: "
MAILTO_EXPIRES2 =   "將要過期 "
MAILTO_RETURNED =   "原信返回 "
MAILTO_DELETED =    "將要刪除 "
MAILTO_EXPIRED2 =   "已經過期!"
MAILTO_RETURNED2 =  "已經返回!"
MAILTO_DELETED2 =   "已經刪除!"
MAILTO_LOCATE =     "物品位置匹配 '%s':"
MAILTO_REMOVE2 =    "移除 %s 的 %s."
MAILTO_BACKPACK =   "無可用格位"
MAILTO_EMPTYNEW =   "你有新郵件..."
MAILTO_MAIL =       "郵件"
MAILTO_INV =        "物品欄"
MAILTO_BANK =       "銀行"
MAILTO_SOLD =       "拍賣成功"
MAILTO_OUTBID =     "出價被超過"
MAILTO_CANCEL =     "拍賣取消"
MAILTO_CASH =       "收到現金: 總計=%s, 售出=%s, 退款=%s, 其他=%s"
MAILTO_MAILABLE = 	"可郵寄物品"
MAILTO_TRADABLE = 	"可交易物品"
MAILTO_AUCTIONABLE = 	"可拍賣物品"
MAILTO_MAILABLE_L = 	"左鍵 - 增為附件"
MAILTO_TRADABLE_L = 	"左鍵 - 交易物品"
MAILTO_AUCTIONABLE_L = 	"左鍵 - 查詢"
MAILTO_MAILABLE_R = 	"右鍵 - 郵寄物品"
MAILTO_TRADABLE_R = 	"右鍵 - 接受"
MAILTO_AUCTIONABLE_R = 	"右鍵 - 拍賣物品"
MAILTO_SHIFT_CHAT_L = 	"左鍵 - 張貼物品連結"
MAILTO_SHIFT_L = 	"左鍵 - 分散物品"
MAILTO_SHIFT_R = 	"右鍵 - 拾取物品"

-- Help text
MT_Help = { ['?'] = 'MailTo';
	inbox = { ['?'] = "管理收件視窗",
		  [''] = "切換收件視窗",
		  ['return'] = "可返回物品列表",
		  ['<name>'] = "查閱 <name> 收件視窗", };
	mf = { ['?'] = "新增郵寄記錄",
		  ['<name> <item>'] = "將收到物品加入郵寄記錄中", };
	mt = { ['?'] = "The main chat command",
		  [''] = "將目前角色郵寄記錄列表",
		  alert = "切換是否立即寄送",
		  auction = "切換可拍賣物品視窗",
		  chat = "切換是否忽略右鍵點擊的聊天連結",
		  clear = "清除寄件清單",
		  click = "切換可郵寄物品視窗",
		  coin = "切換現金郵件是否顯示金額",
		  ding = "開啟或關閉郵件抵達音效",
		  list = "發件清單列表",
		  login = "切換登入時是否顯示即將過期或已經過期列表",
		  pos = "移動發件清單位置",
		  scale = "改變可郵寄物品視窗大小",
		  right = "切換 可郵寄/可交易/可拍賣 視窗的特殊功能",
		  trade = "切換可拍賣物品視窗", 
		  filter = "篩檢物品種類", 
		  grid = "設定團隊數目 (4-10)", };
	mtex = { ['?'] = "處理現存訊息",
		  [''] = "將目前角色之[可能過期郵件]列表",
		  active = "將所有未清空收件匣之[可能過期郵件]列表",
		  all = "將所有未清空收件匣之[可能過期郵件]列表",
		  active = "將所有角色收件匣之[可能過期郵件]列表",
		  icon = "設定[過期郵件]之天數 (預設=28)",
		  long = "設定[可能過期物品=黃色圖示]的天數 (預設=7)",
		  new = "設定[潛在過期郵件]清單天數 (預設=3)",
		  short = "設定[即將過期郵件=紅色圖示]的天數 (預設=1)",
		  server = "將此伺服器所有角色之即將過期郵件列表",
		  soon = "將三天內將要過期郵件列表",
		  warn = "設定登入時將會發出[過期郵件警告]的天數 (預設=2)", };
	mtl = { ['?'] = "收件匣物品定位",
		  ['<name>'] = "依照 <name> 進行收件匣物品定位", };
	mtn = { ['?'] = "顯示新抵達郵件",
		  [''] = "顯示此伺服器新抵達郵件",
		  all = "顯示所有伺服器新抵達郵件", };
	}

end