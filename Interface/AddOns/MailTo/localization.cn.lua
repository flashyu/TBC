-- Traditional Chinese text strings by whocare@TW-HLX
-- Simplified Chinese text strings by condywl@CDWG

if(GetLocale()=="zhCN") then
-- Binding Configuration
BINDING_HEADER_MAILTO   = "MailTo"
BINDING_NAME_MAILTOLOG  = "显示MailTo纪录"
BINDING_NAME_MAILTOEX   = "显示收件夹存放时限"
BINDING_NAME_MAILTOMAIL = "切换MailTo收件窗口"

-- MailTo option list with text
MAILTO_OPTION = { alert=  {flag='noalert', name="寄达通知"},
                  auction={flag='noauction', name="点击拍卖"},
                  chat=   {flag='nochat',  name="点击交谈"},
                  coin=   {flag='nocoin',  name="现金邮件"},
                  ding=   {flag='noding',  name="叮当声音"},
                  click=  {flag='noclick', name="物品栏"},
                  login=  {flag='nologin', name="登入通知"},
                  right=  {flag='noshift', name="右键点击"},
                  trade=  {flag='notrade', name="点击追踪"},
                }
MAILTO_DAYS = {icon=28, long=3, new=7, short=1, soon=3, warn=2}

-- Message text
MAILTO_ON =         "%s 已经开启"
MAILTO_OFF =        "%s 已经关闭"
MAILTO_TIME =       " '%s' 过期时限设定为 %s"
MAILTO_TOOLTIP =    "点击选择收件人"
MAILTO_CLEARED =    "邮寄清单已经清除!"
MAILTO_LISTEMPTY =  "清除清单"
MAILTO_LISTFULL =   "警告: 清单已满!"
MAILTO_ADDED =      "加入邮寄清单"
MAILTO_REMOVED =    "移出邮寄清单"
MAILTO_F_ADD =      "(新增 %s)"
MAILTO_F_REMOVE =   "(移除 %s)"
MAILTO_YOU =        "你"
MAILTO_DELIVERED =  "寄达"
MAILTO_DUE =        "预计 %d 分钟后寄达"
MAILTO_SENT =       "%s 寄给 %s 由 %s %s"
MAILTO_RETURNLIST = "可返回物品:"
MAILTO_RETURN =     "|cffffffff%s|r 寄给 %s"
MAILTO_NORETURN =   "为发现可返回物品"
MAILTO_NEW =        "%s%s 来自 %s 寄给 %s"
MAILTO_NONEW =      "未发现新收物品"
MAILTO_NEWMAIL =    "(可能新邮件)"
MAILTO_LOGEMPTY =   "邮寄记录是空的"
MAILTO_NODATA =     "无收件资料"
MAILTO_NOITEMS =    "收件夹是空的"
MAILTO_NOTFOUND =   "未发现物品"
MAILTO_INBOX =      "#%d, %s, 来自 %s"
MAILTO_EXPIRES =    "将要过期"
MAILTO_EXPIRED =    "已经过期!"
MAILTO_UNDEFINED =  "未定义指令, "
MAILTO_RECEIVED =   "收到 %s 来自 %s, %s"
MAILTO_SALE =       "%s 购买 %s 数量 %s (净额=%s)."
MAILTO_WON =        "你购买 %s 来自 %s 数量 %s."
MAILTO_NONAME =     "姓名不详"
MAILTO_NODESC =     "叙述不详"
MAILTO_MAILOPEN =   "邮箱开启"
MAILTO_MAILCHECK =  "尚未检查邮件"
MAILTO_TITLE =      "MailTo  收件夹"
MAILTO_STACK =	    "(堆栈 %d)"
MAILTO_DATE =       "收件日期: "
MAILTO_SELECT =     "选择:"
MAILTO_SERVER =     "服务器"
MAILTO_SERVERTIP =  "检查其它服务器的角色"
MAILTO_FROM =       "来自: "
MAILTO_EXPIRES2 =   "将要过期 "
MAILTO_RETURNED =   "原信返回 "
MAILTO_DELETED =    "将要删除 "
MAILTO_EXPIRED2 =   "已经过期!"
MAILTO_RETURNED2 =  "已经返回!"
MAILTO_DELETED2 =   "已经删除!"
MAILTO_LOCATE =     "物品位置匹配 '%s':"
MAILTO_REMOVE2 =    "移除 %s 的 %s."
MAILTO_BACKPACK =   "无可用格位"
MAILTO_EMPTYNEW =   "你有新邮件..."
MAILTO_MAIL =       "邮件"
MAILTO_INV =        "物品栏"
MAILTO_BANK =       "银行"
MAILTO_SOLD =       "拍卖成功"
MAILTO_OUTBID =     "出价被超过"
MAILTO_CANCEL =     "拍卖取消"
MAILTO_CASH =       "收到现金: 总计=%s, 售出=%s, 退款=%s, 其它=%s"
MAILTO_MAILABLE = 	"可邮寄物品"
MAILTO_TRADABLE = 	"可交易物品"
MAILTO_AUCTIONABLE = 	"可拍卖物品"
MAILTO_MAILABLE_L = 	"左键 - 增为附件"
MAILTO_TRADABLE_L = 	"左键 - 交易物品"
MAILTO_AUCTIONABLE_L = 	"左键 - 查询"
MAILTO_MAILABLE_R = 	"右键 - 邮寄物品"
MAILTO_TRADABLE_R = 	"右键 - 接受"
MAILTO_AUCTIONABLE_R = 	"右键 - 拍卖物品"
MAILTO_SHIFT_CHAT_L = 	"左键 - 张贴物品连结"
MAILTO_SHIFT_L = 	"左键 - 分散物品"
MAILTO_SHIFT_R = 	"右键 - 拾取物品"

-- Help text
MT_Help = { ['?'] = 'MailTo';
	inbox = { ['?'] = "管理收件窗口",
		  [''] = "切换收件窗口",
		  ['return'] = "可返回物品列表",
		  ['<name>'] = "查阅 <name> 收件窗口", };
	maf = { ['?'] = "新增邮寄记录",
		  ['<name> <item>'] = "将收到物品加入邮寄记录中", };
	mat = { ['?'] = "主要命令项",
		  [''] = "将目前角色邮寄记录列表",
		  alert = "切换是否立即寄送",
		  auction = "切换可拍卖物品窗口",
		  chat = "切换是否忽略右键点击的聊天连结",
		  clear = "清除寄件清单",
		  click = "切换可邮寄物品窗口",
		  coin = "切换现金邮件是否显示金额",
		  ding = "开启或关闭邮件抵达音效",
		  list = "发件清单列表",
		  login = "切换登入时是否显示即将过期或已经过期列表",
		  pos = "移动发件清单位置",
		  scale = "改变可邮寄物品窗口大小",
		  right = "切换 可邮寄/可交易/可拍卖 窗口的特殊功能",
		  trade = "切换可拍卖物品窗口", 
		  filter = "筛检物品种类", 
		  grid = "设定团队数目 (4-10)", };
	mtex = { ['?'] = "处理现存讯息",
		  [''] = "将目前角色之[可能过期邮件]列表",
		  active = "将所有未清空收件夹之[可能过期邮件]列表",
		  all = "将所有未清空收件夹之[可能过期邮件]列表",
		  active = "将所有角色收件夹之[可能过期邮件]列表",
		  icon = "设定[过期邮件]之天数 (预设=28)",
		  long = "设定[可能过期物品=黄色图示]的天数 (预设=7)",
		  new = "设定[潜在过期邮件]清单天数 (预设=3)",
		  short = "设定[即将过期邮件=红色图示]的天数 (预设=1)",
		  server = "将此服务器所有角色之即将过期邮件列表",
		  soon = "将三天内将要过期邮件列表",
		  warn = "设定登入时将会发出[过期邮件警告]的天数 (预设=2)", };
	mtl = { ['?'] = "收件夹物品定位",
		  ['<name>'] = "依照 <name> 进行收件夹物品定位", };
	mtn = { ['?'] = "显示新抵达邮件",
		  [''] = "显示此服务器新抵达邮件",
		  all = "显示所有服务器新抵达邮件", };
	}

end