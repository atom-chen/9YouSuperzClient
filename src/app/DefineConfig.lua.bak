
local gt = cc.exports.gt

gt.GameServer		= {}



gt.GT_MJ = 1  --麻将
gt.GT_PK = 2  --扑克
gt.GT_ZP = 3  --字牌

-- 版本号
-- 正式服:游客登录的IP   --马陈192.168.1.119  冰寒192.168.1.189 黄达137 胡文良157
--gt.LoginServer		= {ip = "192.168.1.137", port = "8056"}
--gt.LoginServer		= {ip = "192.168.1.124", port = "8056"}
--gt.LoginServer		= {ip = "192.168.1.124", port = "8056"}
--gt.LoginServer		= {ip = "192.168.1.101", port = "8056"}
--gt.LoginServer		= {ip = "47.94.15.56", port = "8096"}
-- gt.LoginServer       = {ip = "192.168.1.156", port = "8056"}
-- gt.LoginServer       = {ip = "192.168.1.155", port = "8056"}
-- gt.LoginServer       = {ip = "192.168.1.181", port = "8056"}
-- gt.LoginServer       = {ip = "192.168.1.186", port = "8056"}
-- gt.LoginServer		= {ip = "192.168.1.191", port = "8056"}
-- gt.LoginServer		= {ip = "192.168.1.193", port = "8056"}
--gt.LoginServer     = {ip = "192.168.1.94", port = "8056"}			--马陈吉尔
--gt.LoginServer     = {ip = "47.97.186.121", port = "8096"}  --测试服务器
gt.LoginServer      = {ip = "login1.szn.xmsgl2017.com", port = "8096"}

--审核
gt.AppStoreServer = {ip = "login1.szn.xmsgl2017.com", port = "8096"}
-- 心跳发送时间间隔
gt.heartTime = 5
-- 心跳回复超时时间
gt.heartReplayTimeout = 5
-- 分享地址
-- gt.shareWeb = "http://apps.9you.net/szn/index.html"
gt.shareWeb = "http://pdkzks.xmsgl2017.com/?app=szn&start_type=0"
-- gt.shareRoomWeb = "http://apps.9you.net/szn/gamestart.html"
gt.shareRoomWeb = "http://pdkzks.xmsgl2017.com/?app=szn&start_type=1"
-- 登录地址
gt.loginIpUrl = "http://192.168.1.119/getIP.html"
 
-- 通用按钮按键声效
gt.clickBtnAudio = "common/btn_click"
--点击屏幕声效
gt.clickScreenAudio = "click"
-- 是否开启赛场
gt.openSport = true

gt.IAPItem={
	"com.u9game.supezn.card001",
	"com.u9game.supezn.card002",
	"com.u9game.supezn.card003",
	"com.u9game.supezn.card004",
	"com.u9game.supezn.card005",
	"com.u9game.supezn.card006",
	"com.u9game.supezn.ticket001",
	"com.u9game.supezn.ticket002",

}

-- 通用弹出面板
gt.CommonZOrder = {
	LOADING_TIPS				= 106,
	NOTICE_TIPS					= 107,
	TOUCH_MASK					= 108
}

gt.EventType = {
	NETWORK_ERROR				= 1,
	BACK_MAIN_SCENE				= 2,
	APPLY_DIMISS_ROOM			= 3,
	GM_CHECK_HISTORY			= 4,
    CHANGE_PLAY_BG              = 5,
    CLOSE_APPLY_DISMISSROOM     = 6,
    RUB_CARD_OVER               = 7,
    SHOW_CARD_OVER              = 8,
	CREATE_PAY_ORDER            = 9,
    CLOSE_INVITE                = 10,
    PLAY_SCENE_RESET            = 11,
    EXIT_HALL                   = 12,
    CLOSE_ROUNDRECORD           = 13,
    CLOSE_CUT_CARD              = 14,
	PLAY_SCENE_RESTART          = 15,
    CLOSE_ANNOUNCEMENTLAYER     = 16,
    SHOW_UPDATA_ANNOUNCE        = 17,
	IOS_IAP						= 18,
    GUILD_PARTNER_INVITE        = 19,
    GUILD_MEMBER_MSG            = 20,
    GUILD_REFRESH_SCORE         = 21,
    GUILD_REQUEST_INFO          = 22,
    GUILD_REQUEST_MATCHRANK     = 23,
    GUILD_SCORE_GIVE            = 24,
    GUILD_SHARE_SET            	= 25,
    UPDATE_ROOMCARD            	= 26,
}

gt.ChatType = {
	FIX_MSG						= 1,
	INPUT_MSG					= 2,
	EMOJI						= 3,
	VOICE_MSG					= 4,
    ACT_EMOJI                   = 5,
}

gt.GameType = {
	GAME_CLASSIC				= 1,   --经典牛牛(霸王庄)
	GAME_BULL					= 2,   --斗公牛
	GAME_GOLD	                = 3,   --扎金牛
	GAME_BANKER				    = 4,   --明牌抢庄
	GAME_TOGETHER               = 5,   --快乐通比
    GAME_FREE_BANKER            = 6,   --自由抢庄
    GAME_QH_BANKER              = 7,   --琼海抢庄

    GAME_SG_BIGSMALL              = 7,   --大吃小

	GAME_CLASSIC_ZJH            = 1,   --经典扎金花

    GAME_TTZ_MJ                 = 1,    --麻将推筒子
    GAME_TTZ_PK                 = 2,    --扑克推筒子
}

gt.GameTypeDesc = {
	"快乐拼十",
	"快乐地桩",
	"诈金牛",
	"明牌抢庄",
	"快乐通比",
    "自由抢庄",
    "琼海抢庄"
}

gt.GameSGTypeDesc = {
	"霸王庄",
	"快乐地桩",
	"诈金牛",
	"明牌抢庄",
	"无庄通比",
    "自由抢庄",
    "大吃小"
}

gt.GameTTZTypeDesc={
    "麻将二八杠",
    "扑克二八杠"
}

gt.GameZJHTypeDesc = {
    "经典拼三张",
}

gt.GameSSSTypeDesc = {
  [7] =   "十三水",
}

--[[
    old
    NULL = 0,               -- 无牛
    NIU_1 = 1,              -- 牛1
    NIU_2 = 2,              -- 牛2
    NIU_3 = 3,              -- 牛3
    NIU_4 = 4,              -- 牛4
    NIU_5 = 5,              -- 牛5
    NIU_6 = 6,              -- 牛6
    NIU_7 = 7,              -- 牛7
    NIU_8 = 8,              -- 牛8
    NIU_9 = 9,              -- 牛9
    NIU_NIU = 10,           -- 牛牛
    YIN_NIU = 11,           -- 银牛
    JIN_NIU = 12,           -- 金牛
    WU_XIAO = 13,           -- 五小牛
    BOMB = 14,              -- 炸弹
    LONG = 15,              -- 一条龙
    STRAIGHT = 16,          -- 顺子牛
    FLUSH = 17,             -- 同花牛
    GOURD = 18,             -- 葫芦牛
    STRAIGHT_FLUSH = 19,    -- 同花顺
]]

--new
gt.NIU_TYPE = {
	NULL = 0,		        -- 无牛
	NIU_1 = 1,		        -- 牛1
	NIU_2 = 2,		        -- 牛2
	NIU_3 = 3,		        -- 牛3
	NIU_4 = 4,		        -- 牛4
	NIU_5 = 5,		        -- 牛5
	NIU_6 = 6,		        -- 牛6
	NIU_7 = 7,		        -- 牛7
	NIU_8 = 8,		        -- 牛8
	NIU_9 = 9,		        -- 牛9
	NIU_NIU = 10,	        -- 牛牛
    STRAIGHT = 11,          -- 顺子牛
	YIN_NIU = 12,	        -- 银牛
    FLUSH = 13,             -- 同花牛
	JIN_NIU = 14,	        -- 金牛
    GOURD = 15,             -- 葫芦牛
	WU_XIAO = 16,	        -- 五小牛
	BOMB = 17,		        -- 炸弹
	LONG = 18,		        -- 一条龙
    STRAIGHT_FLUSH = 19,    -- 同花顺
}

--三公类型
gt.SG_TYPE = {
    Zero = 0,               --零点
    Point1 = 10,            --1点
    Point2 = 20,            --2点
    Point3 = 30,            --3点
    Point4 = 40,            --4点
    Point5 = 50,            --5点
    Point6 = 60,            --6点
    Point7 = 70,            --7点
    Point8 = 80,            --8点
    Point9 = 90,            --9点
    Point9Signle = 91,      --单公9点
    Point9Double = 92,      --双公9点
    SanGong = 100,          --三公
    BaoJiu = 110,           --豹九
}

gt.GameAppID = {
    COMMON = 100,           --普通房卡版
    CUSTOM_ANIUGE = 101,    --阿牛哥定制版
}

gt.GameChairs = {
    SIX = 6,    --六人房
	EIGHT=8,	--8人房
    TEN = 10,    --十人房
    TWELVE = 12,    --十二人房
}

gt.GameID = {
    NIUNIU = 1,     --牛牛
    SANGONG = 2,    --三公
	NIUYE = 3,      --牛爷
	QIONGHAI = 4,   --琼海
	TTZ=5,          --推筒子
	ZJH = 6,        --扎金花
}
--[[
--new
gt.NIU_TYPE = {
    NULL = 0,               -- 无牛
    NIU_1 = 1,              -- 牛1
    NIU_2 = 2,              -- 牛2
    NIU_3 = 3,              -- 牛3
    NIU_4 = 4,              -- 牛4
    NIU_5 = 5,              -- 牛5
    NIU_6 = 6,              -- 牛6
    NIU_7 = 7,              -- 牛7
    NIU_8 = 8,              -- 牛8
    NIU_9 = 9,              -- 牛9
    NIU_NIU = 10,           -- 牛牛
    STRAIGHT = 11,          -- 顺子牛
    YIN_NIU = 12,           -- 银牛
    FLUSH = 13,             -- 同花牛
    JIN_NIU = 14,           -- 金牛
    GOURD = 15,             -- 葫芦牛
    WU_XIAO = 16,           -- 五小牛
    BOMB = 17,              -- 炸弹
    LONG = 18,              -- 一条龙
    STRAIGHT_FLUSH = 19,    -- 同花顺
}

]]
gt.NIU_NAME = {
    "meiniu",
    "niu1", 
    "niu2", 
    "niu3", 
    "niu4", 
    "niu5", 
    "niu6", 
    "niu7", 
    "niu8", 
    "niu9", 
    "niuniu", --10
    "straight",
    "yinniu", 
    "flush",
    "jinniu", 
    "gourd",
    "wuxiaoniu", 
    "bomb", 
    "yitiaolong",
    "straightflush"
}

-- 消耗房卡
gt.RoomCardConsume = {
    g1_p1_r10_c6 = 3,             -- 牛牛/房主付费/10局/6人
    g1_p1_r10_c8 = 6,             -- 牛牛/房主付费/10局/8人
    g1_p1_r10_c10 = 6,            -- 牛牛/房主付费/10局/10人
    g1_p1_r10_c12 = 8,            -- 牛牛/房主付费/10局/12人
    g1_p1_r20_c6 = 6,             -- 牛牛/房主付费/20局/6人
    g1_p1_r20_c8 = 8,            -- 牛牛/房主付费/20局/8人
    g1_p1_r20_c10 = 8,            -- 牛牛/房主付费/20局/10人
    g1_p1_r20_c12 = 10,            -- 牛牛/房主付费/20局/12人
    g1_p1_r30_c6 = 10,             -- 牛牛/房主付费/30局/6人
    g1_p1_r30_c8 = 12,            -- 牛牛/房主付费/30局/8人
    g1_p1_r30_c10 = 12,            -- 牛牛/房主付费/30局/10人
    g1_p1_r30_c12 = 14,            -- 牛牛/房主付费/30局/12人
    g1_p2_r10_c6 = 1,             -- 牛牛/AA付 费/10局/6人
    g1_p2_r10_c8 = 1,            -- 牛牛/AA付费/10局/8人
    g1_p2_r10_c10 = 1,            -- 牛牛/AA付费/10局/10人
    g1_p2_r10_c12 = 1,            -- 牛牛/AA付费/10局/12人
    g1_p2_r20_c6 = 2,             -- 牛牛/AA付费/20局/6人
    g1_p2_r20_c8 = 2,            -- 牛牛/AA付费/20局/8人
    g1_p2_r20_c10 = 2,            -- 牛牛/AA付费/20局/10人
    g1_p2_r20_c12 = 2,            -- 牛牛/AA付费/20局/12人
    g1_p2_r30_c6 = 3,             -- 牛牛/AA付费/30局/6人
    g1_p2_r30_c8 = 3,            -- 牛牛/AA付费/30局/8人
    g1_p2_r30_c10 = 3,            -- 牛牛/AA付费/30局/10人
    g1_p2_r30_c12 = 3,            -- 牛牛/AA付费/30局/12人



    g2_p1_r10_c6 = 3,             -- 三公/房主付费/10局/6人
    g2_p1_r10_c8 = 6,            -- 三公/房主付费/10局/8人
    g2_p1_r10_c10 = 6,            -- 三公/房主付费/10局/10人
    g2_p1_r20_c6 = 6,             -- 三公/房主付费/20局/6人
    g2_p1_r20_c8 = 8,            -- 三公/房主付费/20局/8人
    g2_p1_r20_c10 = 8,            -- 三公/房主付费/20局/10人
    g2_p1_r30_c6 = 10,             -- 三公/房主付费/30局/6人
    g2_p1_r30_c8 = 12,            -- 三公/房主付费/30局/8人
    g2_p1_r30_c10 = 12,            -- 三公/房主付费/30局/10人
    g2_p2_r10_c6 = 1,             -- 三公/AA付费/10局/6人
    g2_p2_r10_c8 = 1,            -- 三公/AA付费/10局/8人
    g2_p2_r10_c10 = 1,            -- 三公/AA付费/10局/10人
    g2_p2_r20_c6 = 2,             -- 三公/AA付费/20局/6人
    g2_p2_r20_c8 = 2,            -- 三公/AA付费/20局/8人
	g2_p2_r20_c10 = 2,            -- 三公/AA付费/20局/10人
    g2_p2_r30_c6 = 3,             -- 三公/AA付费/30局/6人
    g2_p2_r30_c8 = 3,            -- 三公/AA付费/30局/8人
    g2_p2_r30_c10 = 3,            -- 三公/AA付费/30局/10人

    g3_p1_r10_c6 = 3,             -- 牛爷/房主付费/10局/6人
    g3_p1_r10_c8 = 6,             -- 牛爷/房主付费/10局/8人
    g3_p1_r10_c10 = 6,            -- 牛爷/房主付费/10局/10人
    g3_p1_r10_c12 = 8,            -- 牛爷/房主付费/10局/12人
    g3_p1_r20_c6 = 6,             -- 牛爷/房主付费/20局/6人
    g3_p1_r20_c8 = 8,            -- 牛爷/房主付费/20局/8人
    g3_p1_r20_c10 = 8,            -- 牛爷/房主付费/20局/10人
    g3_p1_r20_c12 = 10,            -- 牛爷/房主付费/20局/12人
    g3_p1_r30_c6 = 10,             -- 牛爷/房主付费/30局/6人
    g3_p1_r30_c8 = 12,            -- 牛爷/房主付费/30局/8人
    g3_p1_r30_c10 = 12,            -- 牛爷/房主付费/30局/10人
    g3_p1_r30_c12 = 14,            -- 牛爷/房主付费/30局/12人
    g3_p2_r10_c6 = 1,             -- 牛爷/AA付费/10局/6人
    g3_p2_r10_c8 = 1,            -- 牛爷/AA付费/10局/8人
    g3_p2_r10_c10 = 1,            -- 牛爷/AA付费/10局/10人
    g3_p2_r10_c12 = 1,            -- 牛爷/AA付费/10局/12人
    g3_p2_r20_c6 = 2,             -- 牛爷/AA付费/20局/6人
    g3_p2_r20_c8 = 2,            -- 牛爷/AA付费/20局/8人
    g3_p2_r20_c10 = 2,            -- 牛爷/AA付费/20局/10人
    g3_p2_r20_c12 = 2,            -- 牛爷/AA付费/20局/12人
    g3_p2_r30_c6 = 3,             -- 牛爷/AA付费/30局/6人
    g3_p2_r30_c8 = 3,            -- 牛爷/AA付费/30局/8人
    g3_p2_r30_c10 = 3,            -- 牛爷/AA付费/30局/10人
    g3_p2_r30_c12 = 3,            -- 牛爷/AA付费/30局/12人

    g4_p1_r10_c6 = 3,             -- 琼海/房主付费/10局/6人
    g4_p1_r10_c8 = 6,            -- 琼海/房主付费/10局/8人
    g4_p1_r10_c10 = 6,            -- 琼海/房主付费/10局/10人
    g4_p1_r10_c12 = 8,            -- 琼海/房主付费/10局/12人
    g4_p1_r20_c6 = 6,             -- 琼海/房主付费/20局/6人
    g4_p1_r20_c8 = 8,            -- 琼海/房主付费/20局/8人
    g4_p1_r20_c10 = 8,            -- 琼海/房主付费/20局/10人
    g4_p1_r20_c12 = 10,            -- 琼海/房主付费/20局/12人
    g4_p1_r30_c6 = 10,             -- 琼海/房主付费/30局/6人
    g4_p1_r30_c8 = 12,            -- 琼海/房主付费/30局/8人
    g4_p1_r30_c10 = 12,            -- 琼海/房主付费/30局/10人
    g4_p1_r30_c12 = 14,            -- 琼海/房主付费/30局/12人
    g4_p2_r10_c6 = 1,             -- 琼海/AA付费/10局/6人
    g4_p2_r10_c8 = 1,            -- 琼海/AA付费/10局/8人
    g4_p2_r10_c10 = 1,            -- 琼海/AA付费/10局/10人
    g4_p2_r10_c12 = 1,            -- 琼海/AA付费/10局/12人
    g4_p2_r20_c6 = 2,             -- 琼海/AA付费/20局/6人
    g4_p2_r20_c8 = 2,            -- 琼海/AA付费/20局/8人
    g4_p2_r20_c10 = 2,            -- 琼海/AA付费/20局/10人
    g4_p2_r20_c12 = 2,            -- 琼海/AA付费/20局/12人
    g4_p2_r30_c6 = 3,             -- 琼海/AA付费/30局/6人
    g4_p2_r30_c8 = 3,            -- 琼海/AA付费/30局/8人
    g4_p2_r30_c10 = 3,            -- 琼海/AA付费/30局/10人
    g4_p2_r30_c12 = 3,            -- 琼海/AA付费/30局/12人

    g5_p1_r10_c6 = 3,               -- 推筒子/房主付费/10局/6人
    g5_p1_r10_c8 = 6,               -- 推筒子/房主付费/10局/8人
    g5_p1_r10_c10 = 6,              -- 推筒子/房主付费/10局/10人
    g5_p1_r20_c6 = 6,               -- 推筒子/房主付费/20局/6人
    g5_p1_r20_c8 = 8,               -- 推筒子/房主付费/20局/8人
    g5_p1_r20_c10 = 8,              -- 推筒子/房主付费/20局/10人
    g5_p1_r30_c6 = 10,              -- 推筒子/房主付费/30局/6人
    g5_p1_r30_c8 = 12,              -- 推筒子/房主付费/30局/8人
    g5_p1_r30_c10 = 12,             -- 推筒子/房主付费/30局/10人
    g5_p2_r10_c6 = 1,               -- 推筒子/AA付费/10局/6人
    g5_p2_r10_c8 = 1,               -- 推筒子/AA付费/10局/8人
    g5_p2_r10_c10 = 1,              -- 推筒子/AA付费/10局/10人
    g5_p2_r20_c6 = 2,               -- 推筒子/AA付费/20局/6人
    g5_p2_r20_c8 = 2,               -- 推筒子/AA付费/20局/8人
    g5_p2_r20_c10 = 2,              -- 推筒子/AA付费/20局/10人
    g5_p2_r30_c6 = 3,               -- 推筒子/AA付费/30局/6人
    g5_p2_r30_c8 = 3,               -- 推筒子/AA付费/30局/8人
    g5_p2_r30_c10 = 3,              -- 推筒子/AA付费/30局/10人


	g6_p1_r3_c6 = 2,             -- 扎金花/房主付费/3局/6人
    g6_p1_r3_c8 = 2,            -- 扎金花/房主付费/3局/8人
    g6_p1_r3_c10 = 2,            -- 扎金花/房主付费/3局/10人
    g6_p1_r6_c6 = 4,             -- 扎金花/房主付费/6局/6人
    g6_p1_r6_c8 = 4,            -- 扎金花/房主付费/6局/8人
    g6_p1_r6_c10 = 4,            -- 扎金花/房主付费/6局/10人
    g6_p1_r9_c6 = 6,             -- 扎金花/房主付费/9局/6人
    g6_p1_r9_c8 = 6,            -- 扎金花/房主付费/9局/8人
    g6_p1_r9_c10 = 6,            -- 扎金花/房主付费/9局/10人
    g6_p2_r3_c6 = 1,             -- 扎金花/AA付费/3局/6人
    g6_p2_r3_c8 = 1,            -- 扎金花/AA付费/3局/8人
    g6_p2_r3_c10 = 1,            -- 扎金花/AA付费/3局/10人
    g6_p2_r6_c6 = 2,             -- 扎金花/AA付费/6局/6人
    g6_p2_r6_c8 = 2,            -- 扎金花/AA付费/6局/8人
    g6_p2_r6_c10 = 2,            -- 扎金花/AA付费/6局/10人
    g6_p2_r9_c6 = 3,             -- 扎金花/AA付费/9局/6人
    g6_p2_r9_c8 = 3,            -- 扎金花/AA付费/9局/8人
    g6_p2_r9_c10 = 3,            -- 扎金花/AA付费/9局/10人

    g6_p1_r10_c6 = 6,             -- 扎金花/房主付费/10局/6人
    g6_p1_r10_c8 = 6,            -- 扎金花/房主付费/10局/8人
    g6_p1_r10_c10 = 6,            -- 扎金花/房主付费/10局/10人
    g6_p1_r20_c6 = 8,             -- 扎金花/房主付费/20局/6人
    g6_p1_r20_c8 = 8,            -- 扎金花/房主付费/20局/8人
    g6_p1_r20_c10 = 8,            -- 扎金花/房主付费/20局/10人
    g6_p1_r30_c6 = 10,            -- 扎金花/房主付费/30局/6人
    g6_p1_r30_c8 = 10,            -- 扎金花/房主付费/30局/8人
    g6_p1_r30_c10 = 10,            -- 扎金花/房主付费/30局/10人
    g6_p2_r10_c6 = 1,             -- 扎金花/AA付费/10局/6人
    g6_p2_r10_c8 = 1,            -- 扎金花/AA付费/10局/8人
    g6_p2_r10_c10 = 1,            -- 扎金花/AA付费/10局/10人
    g6_p2_r20_c6 = 2,             -- 扎金花/AA付费/20局/6人
    g6_p2_r20_c8 = 2,            -- 扎金花/AA付费/20局/8人
    g6_p2_r20_c10 = 2,            -- 扎金花/AA付费/20局/10人
    g6_p2_r30_c6 = 3,             -- 扎金花/AA付费/30局/6人
    g6_p2_r30_c8 = 3,            -- 扎金花/AA付费/30局/8人
    g6_p2_r30_c10 = 3,            -- 扎金花/AA付费/30局/10人

    
    g6_p1_r6_c6 = 4,             -- 扎金花/房主付费/6局/6人
    g6_p1_r6_c8 = 6,            -- 扎金花/房主付费/6局/8人
    g6_p1_r6_c10 = 6,            -- 扎金花/房主付费/6局/10人
    g6_p1_r9_c6 = 5,             -- 扎金花/房主付费/9局/6人
    g6_p1_r9_c8 = 7,            -- 扎金花/房主付费/9局/8人
    g6_p1_r9_c10 = 7,            -- 扎金花/房主付费/9局/10人
    g6_p1_r12_c6 = 6,            -- 扎金花/房主付费/12局/6人
    g6_p1_r12_c8 = 8,            -- 扎金花/房主付费/12局/8人
    g6_p1_r12_c10 = 8,            -- 扎金花/房主付费/12局/10人
    g6_p2_r6_c6 = 1,             -- 扎金花/AA付费/6局/6人
    g6_p2_r6_c8 = 1,            -- 扎金花/AA付费/6局/8人
    g6_p2_r6_c10 = 1,            -- 扎金花/AA付费/6局/10人
    g6_p2_r9_c6 = 2,             -- 扎金花/AA付费/9局/6人
    g6_p2_r9_c8 = 2,            -- 扎金花/AA付费/9局/8人
    g6_p2_r9_c10 = 2,            -- 扎金花/AA付费/9局/10人
    g6_p2_r12_c6 = 2,             -- 扎金花/AA付费/12局/6人
    g6_p2_r12_c8 = 2,            -- 扎金花/AA付费/12局/8人
    g6_p2_r12_c10 = 2,            -- 扎金花/AA付费/12局/10人
    
    g7_p1_r10_c4 = 3,
    g7_p1_r10_c8 = 6,
    g7_p1_r20_c4 = 6,
    g7_p1_r20_c8 = 12,
    g7_p1_r30_c4 = 10,
    g7_p1_r30_c8 = 18,
    g7_p2_r10_c4 = 1,
    g7_p2_r10_c8 = 1,
    g7_p2_r20_c4 = 2,
    g7_p2_r20_c8 = 2,
    g7_p2_r30_c4 = 3,
    g7_p2_r30_c8 = 3,
}

-- 获取消耗房卡
local function getRoomCardConsume(game_id, pay, rounds, chairs)
    local key = "g"..game_id.."_p"..pay.."_r"..rounds.."_c"..chairs
    if gt.RoomCardConsume[key] then
        return gt.RoomCardConsume[key]
    end
    return 1
end
gt.getRoomCardConsume = getRoomCardConsume


-- 获取字符串某个位置的字符 str字符串 index下标从1开始
local function charAt(str,index)
    return string.sub(str,index,index)
end
gt.charAt = charAt

-- 判断某个值是否在表里 
local function inTable(t,val)
	for k, v in pairs(t) do
		if val == v then
			return true
		end
	end
	return false
end
gt.inTable = inTable

-- 得到表的大小（无论表是否连续）
local function getTableSize(tb)
    local size = 0
    for key, var in pairs(tb) do
        size = size + 1
    end
    
    return size
end
gt.getTableSize = getTableSize

-- 获取牛类型倍数图片资源路径
local function getNiuRateResPath(doubleType, niuType, bSmall, prefix)
	if(bSmall == nil) then
		bSmall = false
	end
	local pathNiuRate = nil
	local strPrefix = prefix and prefix or "image/play/niu/"
    if bSmall then
        strPrefix = "image/record/"
    end

    if (niuType == gt.NIU_TYPE.NIU_7) then
		--牛7
        if (doubleType == 2 or doubleType == 4)  then
            pathNiuRate = strPrefix.."b2.png"
        elseif doubleType == 5 then
            pathNiuRate = strPrefix.."b7.png"
        end

    elseif (niuType == gt.NIU_TYPE.NIU_1) then
        if doubleType == 5 then
            pathNiuRate = strPrefix.."b1.png"
        end

    elseif (niuType == gt.NIU_TYPE.NIU_2) then
        if doubleType == 5 then
            pathNiuRate = strPrefix.."b2.png"
        end

    elseif (niuType == gt.NIU_TYPE.NIU_3) then
        if doubleType == 5 then
            pathNiuRate = strPrefix.."b3.png"
        end

    elseif (niuType == gt.NIU_TYPE.NIU_4) then
        if doubleType == 5 then
            pathNiuRate = strPrefix.."b4.png"
        end

    elseif (niuType == gt.NIU_TYPE.NIU_5) then
        if doubleType == 5 then
            pathNiuRate = strPrefix.."b5.png"
        end

    elseif (niuType == gt.NIU_TYPE.NIU_6) then
        if doubleType == 5 then
            pathNiuRate = strPrefix.."b6.png"
        end

    elseif (niuType == gt.NIU_TYPE.NIU_8) then
        --牛8
        if doubleType == 5 then
            pathNiuRate = strPrefix.."b8.png"
        else
            pathNiuRate = strPrefix.."b2.png"
        end
    elseif (niuType == gt.NIU_TYPE.NIU_9) then
        --牛9
        if (doubleType == 2) then
            pathNiuRate = strPrefix.."b3.png"
        elseif doubleType == 5 then
            pathNiuRate = strPrefix.."b9.png"
        else
            pathNiuRate = strPrefix.."b2.png"
        end
    elseif (niuType == gt.NIU_TYPE.NIU_NIU) then
        --牛牛
        if (doubleType == 2) then
            pathNiuRate = strPrefix.."b4.png"
        elseif doubleType == 5 then
            pathNiuRate = strPrefix.."b10.png"
        else
            pathNiuRate = strPrefix.."b3.png"
        end
    elseif (niuType == gt.NIU_TYPE.YIN_NIU) then
        --银牛
        if doubleType == 5 then
            pathNiuRate = strPrefix.."b15.png"
        else
            pathNiuRate = strPrefix.."b5.png"
        end

    elseif (niuType == gt.NIU_TYPE.JIN_NIU) then
        --金牛
        if doubleType == 5 then
            pathNiuRate = strPrefix.."b20.png"
        else
            pathNiuRate = strPrefix.."b6.png"
        end
    elseif (niuType == gt.NIU_TYPE.WU_XIAO) then
        --五小牛
        if doubleType == 5 then
            pathNiuRate = strPrefix.."b25.png"
        else
            pathNiuRate = strPrefix.."b7.png"
        end

    elseif (niuType == gt.NIU_TYPE.BOMB) then
        --炸弹
        if doubleType == 5 then
            pathNiuRate = strPrefix.."b30.png"
        else
            pathNiuRate = strPrefix.."b8.png"
        end
    elseif (niuType == gt.NIU_TYPE.LONG) then
        --一条龙
        if doubleType == 5 then
            pathNiuRate = strPrefix.."b35.png"
        else
            pathNiuRate = strPrefix.."b9.png"
        end
    elseif (niuType == gt.NIU_TYPE.STRAIGHT) then
        --顺子牛
        if doubleType == 5 then
            pathNiuRate = strPrefix.."b15.png"
        else
            pathNiuRate = strPrefix.."b5.png"
        end
    elseif (niuType == gt.NIU_TYPE.FLUSH) then
        --同花牛
        if doubleType == 5 then
            pathNiuRate = strPrefix.."b20.png"
        else
            pathNiuRate = strPrefix.."b6.png"
        end
    elseif (niuType == gt.NIU_TYPE.GOURD) then
        --葫芦牛
        if doubleType == 5 then
            pathNiuRate = strPrefix.."b25.png"
        else
            pathNiuRate = strPrefix.."b7.png"
        end
    elseif (niuType == gt.NIU_TYPE.STRAIGHT_FLUSH) then
        --同花顺
        if doubleType == 5 then
            pathNiuRate = strPrefix.."b40.png"
        else
            pathNiuRate = strPrefix.."b10.png"
        end
    end
    if pathNiuRate=="image/record/" or pathNiuRate=="image/play/niu/" or pathNiuRate=="image/playys/niu/"  then
        return nil
    else
        return pathNiuRate
    end
end
gt.getNiuRateResPath = getNiuRateResPath

-- 获取三公倍数图片资源路径（策划需求暂时去掉三公牌型倍数）
local function getSGRateResPath(sgType, bSmall)
    if (bSmall == nil) then
        bSmall = false
    end
    local pathRate = nil
--    local strPrefix = "image/play/niu/"
--    if bSmall then
--        strPrefix = "image/record/"
--    end

--    if (sgType == gt.SG_TYPE.Point8) then
--        --8点
--        pathRate = strPrefix.."b2.png"
--    elseif (sgType == gt.SG_TYPE.Point9) then
--        --9点
--        pathRate = strPrefix.."b3.png"
--    elseif (sgType == gt.SG_TYPE.SanGong) then
--        --三公
--        pathRate = strPrefix.."b4.png"
--    elseif (sgType == gt.SG_TYPE.BaoJiu) then
--        --豹九
--        pathRate = strPrefix.."b5.png"
--    end
    
    return pathRate
end
gt.getSGRateResPath = getSGRateResPath



local function getRoomDoubleTypeDesc(par)
    local double_type = ""

    if not par.game_id or not par.game_type or not par.double_type then
        return double_type
    end

    if par.double_type == 1 then
        double_type = "牛八—牛九2倍，牛牛3倍"
    elseif par.double_type == 2 then
        double_type = "牛七—牛八2倍，牛九3倍，牛牛4倍"
    elseif par.double_type == 5 then
        double_type = "牛一 ~ 牛牛 分别对应1~10倍"
    elseif par.double_type == 4 then
        double_type = "牛七—牛九2倍，牛牛3倍"
    end

    if par.game_id == gt.GameID.TTZ then
        if par.game_type ==gt.GameType.GAME_TTZ_PK then
            double_type="八点-八点半2倍 九点-九点半3倍 豹子4倍"
        elseif par.game_type ==gt.GameType.GAME_TTZ_MJ then
            double_type="八点-八点半2倍 九点-九点半3倍 豹子4倍 白板豹子5倍"
        end
    end
    
    return double_type
end
gt.getRoomDoubleTypeDesc = getRoomDoubleTypeDesc

local function getRoomBankerDesc(par)
    local banker = ""

    if not par.game_id or not par.banker then
        return banker
    end

    if par.banker == 1 then
        banker = "房主坐庄"
        if par.game_id == gt.GameID.SANGONG then
            banker = "霸王庄"
        end
    elseif par.banke == 2 then
        banker = "轮流坐庄"
    elseif par.banke == 3 then
        banker = "牛牛上庄"
        if par.game_id == gt.GameID.SANGONG then
            banker = "牌大坐庄"
        end
    end

    return banker
end
gt.getRoomBankerDesc = getRoomBankerDesc

local function getRoomFractionDesc(par)
    local fraction = ""

    if not par.game_id then
        return fraction
    end

    if par.game_id==gt.GameID.NIUYE or par.game_id == gt.GameID.NIUNIU 
             or  par.game_id == gt.GameID.TTZ then
        fraction = "1/2"
        if par.score == 2 then
            fraction = "2/4"
        elseif par.score == 4 then
            fraction = "4/8"
        elseif par.score ==3 then
            fraction= "3/6"
        elseif par.score ==5 then
            fraction= "5/10"
        elseif par.score == 11 then
            fraction = "2/3/4/5"
        elseif par.score == 12 then
            fraction = "2/4/8/10"
        elseif par.score == 13 then
            fraction = "3/6/12/15"
        elseif par.score == 14 then
            fraction = "4/8/16/20"
        elseif par.score == 15 then
            fraction = "5/10/20/25"
        elseif par.score == 16 then
            fraction = "1/2/4/5"
        end
    elseif par.game_id == gt.GameID.ZJH then
        fraction = tostring(par.zjh_base_score)
    elseif par.game_id == gt.GameID.SSS then
        fraction = tostring(par.score) 
    elseif par.game_id == gt.GameID.QIONGHAI then
        fraction = tostring(par.qh_base_score)
    elseif par.game_id == gt.GameID.SANGONG then
        fraction = "5/10/15/20"

        if par.game_type == gt.GameType.GAME_SG_BIGSMALL then
            if par.score == 5 then
                fraction = "5/10/20/50"
            elseif par.score == 10 then
                fraction = "10/30/50/100"
            elseif par.score == 20 then
                fraction = "20/50/100/250"
            end
        else
            if par.score == 10 then
                fraction = "10/20/30/40"
            elseif par.score == 20 then
                fraction = "20/40/60/80"
            end
        end
    end

    return fraction
end
gt.getRoomFractionDesc = getRoomFractionDesc

local function getRoomShareString(roomInfo, playerCount, id, guildId ,matchId)
    local pay, push, limit, double_type, banker, fraction
    if roomInfo.pay == 1 then
        pay = "房主付费"
    else 
        pay = "AA付费"
    end
    if roomInfo.push_pledge == 0 then
        push = ""
    else
        push = "闲家推注"
    end
    if roomInfo.pledge_res == 0 then
        limit = ""
    else
        limit = "下注限制"    
    end

    double_type = gt.getRoomDoubleTypeDesc(roomInfo)
    banker = gt.getRoomBankerDesc(roomInfo)
    fraction = gt.getRoomFractionDesc(roomInfo)
	
    local roomChairs = roomInfo.max_chairs
	local guildDesc = ""
    if guildId and guildId > 0 then
        guildDesc = "俱乐部"
    end
    if matchId and matchId > 0 then
        if string.len(guildId) == 5 then
            guildDesc = "大联盟"
        else
            guildDesc = "比赛"
        end
	end

    local strPreTitle = "战斗牛"
    if roomInfo.game_id == gt.GameID.NIUYE then
        strPreTitle = "战斗牛经典"
    elseif roomInfo.game_id == gt.GameID.QIONGHAI then
        strPreTitle = "战斗牛琼海"
    elseif roomInfo.game_id == gt.GameID.TTZ then
        strPreTitle = "战斗牛推筒子"
    elseif roomInfo.game_id == gt.GameID.SSS then
        strPreTitle = "战斗牛十三水"
    end
    local title = string.format("%s【%d】%s房【%s】%d缺%d", strPreTitle, id, guildDesc, gt.GameTypeDesc[roomInfo.game_type], playerCount, (roomChairs - playerCount))
    if roomInfo.game_id == gt.GameID.SANGONG then
        title = string.format("战斗牛三公【%d】%s房【%s】%d缺%d", id, guildDesc, gt.GameSGTypeDesc[roomInfo.game_type], playerCount, (roomChairs - playerCount))
    elseif roomInfo.game_id == gt.GameID.ZJH then
        title = string.format("战斗牛拼三张【%d】%s房【%s】%d缺%d", id, guildDesc, gt.GameZJHTypeDesc[roomInfo.game_type], playerCount, (roomChairs - playerCount))
    elseif roomInfo.game_id == gt.GameID.TTZ then
        title = string.format("%s【%d】%s房【%s】%d缺%d", strPreTitle, id, guildDesc, gt.GameTTZTypeDesc[roomInfo.game_type], playerCount, (roomChairs - playerCount))
    elseif roomInfo.game_id == gt.GameID.SSS then
        title = string.format("%s【%d】%s房【%s】%d缺%d", strPreTitle, id, guildDesc, gt.GameSSSTypeDesc[roomInfo.game_type], playerCount, (roomChairs - playerCount))
    end

    local description
    if roomInfo.game_id == gt.GameID.TTZ then
        title = string.format("%s【%d】%s房【%s】%d缺%d", strPreTitle, id, guildDesc, gt.GameTTZTypeDesc[roomInfo.game_type], playerCount, (roomChairs - playerCount))
        description = string.format("%d局，%d人房，%s，%s分，%s，%s", roomInfo.rounds, roomChairs, pay, fraction, double_type, push)
    elseif roomInfo.game_id == gt.GameID.ZJH then
        title = string.format("战斗牛拼三张【%d】%s房【%s】%d缺%d", id, guildDesc, gt.GameZJHTypeDesc[roomInfo.game_type], playerCount, (roomChairs - playerCount))
        description = string.format("%d局，%d人房，%s ，底注%s分，%d回合封顶", roomInfo.rounds, roomChairs, pay, fraction, roomInfo.now_rounds)
    elseif roomInfo.game_id == gt.GameID.SANGONG then
        title = string.format("战斗牛三公【%d】%s房【%s】%d缺%d", id, guildDesc, gt.GameSGTypeDesc[roomInfo.game_type], playerCount, (roomChairs - playerCount))
        description = string.format("%d局，%d人房，%s，%s分，%s，%s，%s", roomInfo.rounds, roomChairs, pay, fraction, double_type, banker, push)

    elseif roomInfo.game_id == gt.GameID.NIUNIU or roomInfo.game_id == gt.GameID.NIUYE or roomInfo.game_id == gt.GameID.QIONGHAI then
        if roomInfo.game_type == 1 then
        --经典牛牛
            description = string.format("%d局，%d人房，%s，%s分，%s，%s，%s", roomInfo.rounds, roomChairs, pay, fraction, double_type, banker, push)
        elseif roomInfo.game_type == 2 then
            --斗公牛
            description = string.format("%d局，%d人房，%s，庄家底分%d分，%s分，%s，%s", roomInfo.rounds, roomChairs, pay, roomInfo.base_score, fraction, double_type, push)
        elseif roomInfo.game_type == 3 then
            --炸金牛
        elseif roomInfo.game_type == 4 then
            --明牌抢庄
            description = string.format("%d局，%d人房，%s，%d倍，%s分，%s，%s，%s", roomInfo.rounds, roomChairs, pay, roomInfo.loot_dealer, fraction, double_type, push, limit)
            if roomInfo.game_id == gt.GameID.SANGONG then
                description = string.format("%d局，%d人房，%s，%s分，%s，%s", roomInfo.rounds, roomChairs, pay, fraction, push, limit)
            end
        elseif roomInfo.game_type == 5 then
            --通比牛牛
            if roomInfo.game_id == gt.GameID.SANGONG then
                description = string.format("%d局，%d人房，%s，%d分", roomInfo.rounds, roomChairs, pay, fraction)
            else
                description = string.format("%d局，%d人房，%s，%d分，%s", roomInfo.rounds, roomChairs, pay, roomInfo.score, double_type)
            end
        elseif roomInfo.game_type == 6 then
            --自由抢庄
            description = string.format("%d局，%d人房，%s，%s分，%s，%s，%s", roomInfo.rounds, roomChairs, pay, fraction, double_type, push, limit)
        elseif roomInfo.game_type == 7 then
            --琼海抢庄
            description = string.format("%d局，%d人房，%s，底分%d分，%d倍，%s", roomInfo.rounds, roomChairs, pay, roomInfo.qh_base_score, roomInfo.score, double_type)                    
        end
    end

    
    if roomInfo.game_id == gt.GameID.SSS and roomInfo.game_type == 7 then
        title = string.format("%s【%d】%s房【%s】%d缺%d", strPreTitle, id, guildDesc, gt.GameSSSTypeDesc[roomInfo.game_type], playerCount, (roomChairs - playerCount))
        description = string.format("%d局，%d人房，%s，底分%d分", roomInfo.rounds, roomChairs,pay ,fraction)
          
            if roomInfo.compare_type and roomInfo.compare_type == 1 then
                description = description.." ,比花色"
            end

            if roomInfo.mapai and  (roomInfo.mapai ~= 1 or roomInfo.mapai ~= 0 )then
                description = description.." ,马牌为"..roomInfo.mapai
            end

            if roomInfo.gun and  roomInfo.gun == 1 then
                description = description.." ,计分+1"
           elseif  roomInfo.gun and roomInfo.gun == 0 then
                description = description.." ,计分X2"
            end

            if roomInfo.lipai then
                description = description.." ,理牌时间"..roomInfo.lipai.."s" 
            end

    end
    gt.log("----------------------------des:"..description)
    local url = gt.shareRoomWeb .. "&app_id=" .. gt.app_id .. "&roomid=" .. id
	-- gt.log("----------------------------url:"..url)

	extension.shareToURL(extension.SHARE_TYPE_SESSION, title, description, url)
end
gt.getRoomShareString = getRoomShareString

local function getRoomInfo(roomInfo, isAllShowSpecial)
    --付费方式
    local strRule = ""
    if not gt.isIOSReview() then
        strRule = "AA付费 "
        if (roomInfo.pay == 1) then
            strRule = "房主付费 "
        end
    end

    --翻倍规则
    local strRate = "牛八2倍 牛九2倍 牛牛3倍 "
    if (roomInfo.double_type == 2) then
        strRate = "牛七2倍 牛八2倍 牛九3倍 牛牛4倍 "
    elseif (roomInfo.double_type == 5) then
        strRate = "牛一 ~ 牛牛 分别对应1~10倍 "
    elseif (roomInfo.double_type == 4) then
        strRate = "牛七2倍 牛八2倍 牛九2倍 牛牛3倍 "
    end
    if roomInfo.game_id == gt.GameID.SANGONG then
        strRate = ""
    elseif roomInfo.game_id==gt.GameID.TTZ then
        if roomInfo.game_type ==gt.GameType.GAME_TTZ_PK then
            strRate="八点-八点半2倍 九点-九点半3倍 豹子4倍"
        elseif roomInfo.game_type ==gt.GameType.GAME_TTZ_MJ then
            strRate="八点-八点半2倍 九点-九点半3倍 豹子4倍 白板豹子5倍"
        end
    end
	
    --底分
    local strScore = "1/2分"
    if roomInfo.game_id == gt.GameID.NIUYE or roomInfo.game_id == gt.GameID.NIUNIU or roomInfo.game_id == gt.GameID.TTZ then
    	strScore = "1/2分"
   	    if roomInfo.score == 2 then
        	strScore = "2/4分"
	    elseif roomInfo.score == 3 then
		    strScore = "3/6分"
        elseif roomInfo.score == 4 then
            strScore = "4/8分"
	    elseif roomInfo.score == 5 then
		    strScore = "5/10分"
        elseif roomInfo.score == 6 then
            strScore = "25/50分"
        elseif (roomInfo.score == 11) then
            strScore = string.format("%d/%d/%d/%d分",2,3,4,5)
        elseif (roomInfo.score == 12) then
            strScore = string.format("%d/%d/%d/%d分",2,4,8,10)
        elseif (roomInfo.score == 13) then
            strScore = string.format("%d/%d/%d/%d分",3,6,12,15)
        elseif (roomInfo.score == 14) then
            strScore = string.format("%d/%d/%d/%d分",4,8,16,20)
        elseif (roomInfo.score == 15) then
            strScore = string.format("%d/%d/%d/%d分",5,10,20,25)
        elseif (roomInfo.score == 16) then
            strScore = string.format("%d/%d/%d/%d分",1,2,4,5)
	    end
    elseif roomInfo.game_id == gt.GameID.SANGONG then
        strScore = "5/10/15/20分 "
        if roomInfo.score == 10 then
            strScore = "10/20/30/40分 "
        elseif roomInfo.score == 20 then
            strScore = "20/40/60/80分 "
        end
    elseif roomInfo.game_id == gt.GameID.ZJH then
        strScore = roomInfo.zjh_base_score .. "分"
    end


    if (roomInfo.game_type == gt.GameType.GAME_TOGETHER) then
        --通比
        strScore = string.format("%d分 ", roomInfo.score)
    elseif (roomInfo.game_type == gt.GameType.GAME_QH_BANKER) then
        --琼海抢庄
        strScore = string.format("闲家倍数%d倍 ", roomInfo.score)
    end

    if roomInfo.game_id == gt.GameID.SSS and roomInfo.game_type == 7 then
            if roomInfo.score == 2 then
        	    strScore = "2分 "
	        elseif roomInfo.score == 5 then
		        strScore = "5分 "
             elseif roomInfo.score == 10 then
		        strScore = "10分 "
			else
				strScore = ""
	        end 
    end

    local baseScore = ""
    --琼海抢庄底分
    if (roomInfo.game_id == gt.GameID.QIONGHAI and roomInfo.game_type == gt.GameType.GAME_QH_BANKER) then
        baseScore = "底分"..roomInfo.qh_base_score.."分 "
    end
    --斗公牛庄家底分
    if (roomInfo.game_type == gt.GameType.GAME_BULL) and roomInfo.game_id ~= gt.GameID.TTZ then
        baseScore = "庄家底分"..roomInfo.base_score.."分 "
    end


    --抢庄倍数
    local rate = ""
    if roomInfo.game_type == 4 then
        rate = string.format("%d倍 ", roomInfo.loot_dealer)
        if roomInfo.game_id == gt.GameID.SANGONG then
            rate = ""
        end
    end

    --推注
    local tuizhu = ""
    -- 下注限制只有明牌抢庄和自由抢庄有
    if ((roomInfo.game_type == 4 or roomInfo.game_type == 6) and roomInfo.pledge_res == 1) then
        tuizhu = tuizhu.."下注限制 "
    end
    -- 下注加倍只有牛爷和牛牛的明牌抢庄和自由抢庄有
    if ((roomInfo.game_id == gt.GameID.NIUYE or roomInfo.game_id == gt.GameID.NIUNIU) and (roomInfo.game_type == 4 or roomInfo.game_type == 6) and roomInfo.pledge_double == 1) then
        tuizhu = tuizhu.."下注加倍 "
    end	
    -- 通比牛牛琼海抢庄没有推注
    if (roomInfo.game_type ~= gt.GameType.GAME_TOGETHER and roomInfo.game_type ~= gt.GameType.GAME_QH_BANKER and roomInfo.push_pledge ~= 0) then
        tuizhu = tuizhu.."推注 "
    end
    -- 只有明牌抢庄有暗抢
    if (roomInfo.game_type == gt.GameType.GAME_BANKER and roomInfo.steal == 1) then
        tuizhu = tuizhu.."暗抢 "
    end

    if roomInfo.game_id == gt.GameID.ZJH then
        tuizhu = string.format("%d回合封顶 %d注封顶 ", roomInfo.now_rounds,roomInfo.score)
    end

    --特殊玩法
    local strSpecial = ""
    --先展示特殊牌型
    if isAllShowSpecial then
        for i = 1, 13 do
            local op = tonumber(gt.charAt(roomInfo.options,i))
            if (op == 1) then
                if roomInfo.game_id == gt.GameID.NIUNIU or roomInfo.game_id == gt.GameID.NIUYE or roomInfo.game_id == gt.GameID.QIONGHAI then
                    if (i == 1) then
                        strSpecial = "一条龙  "
                    elseif (i == 2) then
                        strSpecial = strSpecial.."五小牛  "
                    elseif (i == 3) then
                        strSpecial = strSpecial.."炸弹牛  "
                    elseif (i == 4) then
                        strSpecial = strSpecial.."金牛  "
                    elseif (i == 5) then
                        strSpecial = strSpecial.."银牛  "
                    elseif (i == 10) then
                        strSpecial = strSpecial.."顺子牛  "
                    elseif (i == 11) then
                        strSpecial = strSpecial.."同花牛  "
                    elseif (i == 12) then
                        strSpecial = strSpecial.."葫芦牛  "
                    elseif (i == 13) then
                        strSpecial = strSpecial.."同花顺  "
                    end
                end
            end
        end
    end
    --别的特殊规则
    for i = 6, 9 do
        local op = tonumber(gt.charAt(roomInfo.options,i))
        if op == 1 then
            if (roomInfo.game_id == gt.GameID.NIUNIU or roomInfo.game_id == gt.GameID.NIUYE) and i == 6 then
                strSpecial = strSpecial.."无花牌  "
            elseif (i == 7) then
                strSpecial = strSpecial.."开局后禁止加入  "
            elseif (i == 8) then
                strSpecial = strSpecial.."快速游戏  "
            elseif (i == 9) then
                strSpecial = strSpecial.."禁止搓牌  "
            end
        end
    end
	
	
    --九点庄大(三公霸王庄玩法的霸王庄)
    if roomInfo.game_id == gt.GameID.SANGONG and roomInfo.game_type == gt.GameType.GAME_CLASSIC
    and roomInfo.banker == 1 and roomInfo.banker9 == 1 then
        strSpecial = strSpecial.."九点庄大"
    end

	--推筒子特殊玩法
	if roomInfo.game_id==gt.GameID.TTZ then
		strSpecial=""
		if gt.charAt(roomInfo.options,1)=="1" then
			strSpecial="二八杠"
		end
	end   

	if roomInfo.game_id == gt.GameID.ZJH then
        strSpecial = ""
        strSpecial = strSpecial..(roomInfo.compare_type == 0 and "牌相同时(先比为输) " or "牌相同时(按花色比) ")
        for i = 1, 3 do
            local op = tonumber(gt.charAt(roomInfo.options,i))
            if op == 1 then
                if (i == 1) then
                    strSpecial = strSpecial.."A23>JQK  "
                elseif (i == 2) then
                    strSpecial = strSpecial.."比牌双倍分  "
                elseif (i == 3) then
                    strSpecial = strSpecial.."235吃豹子  "
                end
            end
        end

        if (roomInfo.zjh_watch and roomInfo.zjh_watch > 0) then
            strSpecial = strSpecial.."按序看牌  "
        end
        if (roomInfo.zjh_straight_big and roomInfo.zjh_straight_big > 0) then
            strSpecial = strSpecial.."顺子大金花  "
        end
    end

	if roomInfo.game_id == gt.GameID.NIUNIU or roomInfo.game_id == gt.GameID.NIUYE or roomInfo.game_id == gt.GameID.QIONGHAI then
		if 1 == roomInfo.laizi then
			strSpecial = strSpecial.."经典王癞  "
		elseif 2 == roomInfo.laizi then
			strSpecial = strSpecial.."疯狂王癞  "
		end
	end
	
	if roomInfo.game_id == gt.GameID.SSS then
		strRate = ""
		strSpecial = ""
	end
	
    local SSS_str = ""
   if roomInfo.game_id == gt.GameID.SSS and roomInfo.game_type == 7 then
            if roomInfo.compare_type and roomInfo.compare_type == 1 then
                SSS_str = SSS_str.." 比花色"
            end

            if roomInfo.mapai and  (roomInfo.mapai ~= 1 or roomInfo.mapai ~= 0 )then
                SSS_str = SSS_str.." 马牌为"..roomInfo.mapai
            end

            if roomInfo.gun and  roomInfo.gun == 1 then
                SSS_str = SSS_str.." 计分+1"
           elseif  roomInfo.gun and roomInfo.gun == 0 then
                SSS_str = SSS_str.." 计分X2"
            end

            if roomInfo.lipai then
                SSS_str = SSS_str.." 理牌时间"..roomInfo.lipai.."s"
            end

        local tt = {"至尊青龙","一条龙","三同花顺","三分天下","四套三条","六对半","三顺子","三同花"}
         for i=1 , 8 do
         if  string.sub(roomInfo.options,i,i) == "1" then
            SSS_str = SSS_str.." "..tt[i]
         end 
        end
    end

    return strRule, strRate, strScore, baseScore, rate, tuizhu, strSpecial , SSS_str
end
gt.getRoomInfo = getRoomInfo



gt.scoreSpecial1 = {2,3,4,5}
gt.scoreSpecial2 = {2,4,8,10}
gt.scoreSpecial3 = {3,6,12,15}
gt.scoreSpecial4 = {4,8,16,20}
gt.scoreSpecial5 = {5,10,20,25}
gt.scoreSpecial6 = {1,2,4,5}

local function getScoreSpecialDetail(score_, no_)
    local result = 1
    if score_>= 1 and score_ <= 5 then
        result = score_ * no_
    elseif score_ == 11 then
        result = gt.scoreSpecial1[no_]
    elseif score_ == 12 then
        result = gt.scoreSpecial2[no_]
    elseif score_ == 13 then
        result = gt.scoreSpecial3[no_]
    elseif score_ == 14 then
        result = gt.scoreSpecial4[no_]
    elseif score_ == 15 then
        result = gt.scoreSpecial5[no_]
    elseif score_ == 16 then
        result = gt.scoreSpecial6[no_]
    end
    return result
end
gt.getScoreSpecialDetail = getScoreSpecialDetail

local function getGameIdDesc(par)
    local strGameId = ""
    if par.game_id == gt.GameID.NIUNIU then
        strGameId = "牛牛"
    elseif par.game_id == gt.GameID.SANGONG then
        strGameId = "三公"
    elseif par.game_id == gt.GameID.NIUYE then
        strGameId = "经典"
    elseif par.game_id == gt.GameID.QIONGHAI then
        strGameId = "琼海"
    elseif par.game_id == gt.GameID.TTZ then
        strGameId = "推筒子"
    elseif par.game_id == gt.GameID.ZJH then
        strGameId = "经典拼三张"
    elseif par.game_id == gt.GameID.SSS then
        strGameId = "十三水"
    end
    return strGameId 
end
gt.getGameIdDesc = getGameIdDesc


local function getGameTypeDesc(gameid, gametype)
	if gameid == gt.GameID.NIUNIU or gameid == gt.GameID.NIUYE or gameid == gt.GameID.QIONGHAI then
		return gt.GameTypeDesc[gametype]
	elseif gameid == gt.GameID.SANGONG then
		return gt.GameSGTypeDesc[gametype]
    elseif gameid==gt.GameID.ZJH then
        return gt.GameZJHTypeDesc[gametype]
    elseif gameid==gt.GameID.TTZ then
        return gt.GameTTZTypeDesc[gametype]
    elseif gameid==gt.GameID.SSS then
        return gt.GameSSSTypeDesc[gametype]
	end
	return ""
end

gt.getGameTypeDesc = getGameTypeDesc

local function shortNumber(num)
	num = tonumber(num)
	if not num then
		return ""
	end
	if num < 100000 then
		return tostring(num)
	elseif num < 100000000 then
		return math.floor(num * 0.0001) .. "万"
	else
		return math.floor(num * 0.00000001) .. "亿"
	end
end
gt.shortNumber = shortNumber



gt.games_config_list = {}
require "app.games.SSS.main_SSS"