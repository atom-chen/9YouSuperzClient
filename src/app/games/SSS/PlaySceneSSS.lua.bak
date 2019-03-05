
local gt = cc.exports.gt

local YvYin_Node = require("app/views/YvYinNode")
--package.loaded["app/games/SSS/sszCardTools"] = nil
local sszCardTools = require("app/games/SSS/sszCardTools")
local GameLogic = require("app/views/GameLogic")
require("app/effect/shaderEffect")
local cardNum = 13
-- local sszCardTool = sszCardTool:new()

local PlaySceneSSS = class("PlaySceneSSS", function()
	return cc.Scene:create()
end)

PlaySceneSSS.ZOrder = {
	MJTABLE						= 1,
	PLAYER_INFO					= 2,
	MJTILES						= 6,
	DECISION_BTN				= 8,
	PLAYER_INFO_TIPS			= 10,
	REPORT						= 21,
	SETTING						= 18,
	CHAT						= 20,
    DISMISS_ROOM				= 22,

	ROUND_REPORT				= 66 -- 单局结算界面显示在总结算界面之上
}

local PLAYER_STATE = {
	INIT = 0,       -- 初始化
	READY = 1,      -- 准备
	START = 2,	    -- 开始
	PLEDGE = 3,	    -- 押分
	LOOT = 4,	    -- 抢庄
    DEAL = 5,	    -- 发牌
    DEAL2 = 6,      -- 发牌2（抢庄牛牛里的发剩余牌）
	SHOW_CARD = 7,	-- 亮牌
	PAUSE = 9,		-- 暂停
    READY_WAIT = 10, --预准备
	SETTLE = 12,    --小结算
}

local ROOM_STATE = {
	INIT = 0,	        -- 初始化
	READY = 1,	        -- 准备
	START = 2,	        -- 开始
	PLEDGE = 3,	        -- 押分
	LOOT = 4,	        -- 抢庄
	DEAL = 5,	        -- 发牌
    DEAL2 = 6,          -- 发牌2（抢庄牛牛里的发剩余牌）
	SHOW_CARD = 7,	    -- 亮牌
	RESRART = 11,	    -- 重新开始
	SETTLE_ROUND = 12,	-- 小结算
	SETTLE_ROOM = 13	-- 大结算
}

local WAIT_TYPE = {
    READY = 1,	        -- 准备
    LOOT = 2,	        -- 抢庄压倍率
    PLEDGE = 3,	        -- 押分
    SHOW_CARD = 4,	    -- 亮牌
}

local uiChairsNum = 4
local rule_toujintoushun = nil
local rule_daoshui = nil
function PlaySceneSSS:ctor(enterRoomMsgTbl)
	--清理纹理

    if not enterRoomMsgTbl.IsReplay then
		    cc.SpriteFrameCache:getInstance():removeUnusedSpriteFrames()
		    cc.Director:getInstance():getTextureCache():removeUnusedTextures()
	    end

    self.lipaiIsClose = true

	self.game_id=enterRoomMsgTbl.game_id
	self.game_type=enterRoomMsgTbl.game_type
	self.IsReplay=enterRoomMsgTbl.IsReplay
	--限时比赛id
	self.sport_id=enterRoomMsgTbl.sport_id
	-- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))

    -- 几人房
    --enterRoomMsgTbl.max_chairs = 4
    self.roomChairs = enterRoomMsgTbl.max_chairs
    uiChairsNum = self.roomChairs

    local csbName = "games/SSS/csb/PlaySceneFourSSS.csb"
    if uiChairsNum == 8 then
      csbName = "games/SSS/csb/PlaySceneEightSSS.csb"
    end
	self.guildID = enterRoomMsgTbl.guild_id
	self.isMatch = enterRoomMsgTbl.match
    self.game_type = enterRoomMsgTbl.game_type
	self.sportId = enterRoomMsgTbl.sport_id
    --self.lipaiTime = enterRoomMsgTbl.lipai or 60
    self.schelipai_id = nil
    self.scheComCard_id = nil
	-- 加载界面资源
    self.btCancelVisiState = false
    
	local csbNode = cc.CSLoader:createNode(csbName)
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
    ccui.Helper:doLayout(csbNode)
	self:addChild(csbNode)
	self.rootNode = csbNode

    self.sexStr = "man" 
   
    --桌面
    self:changePlayBg()

    --隐藏玩家等待提示
    self.bgWaitingTip = gt.seekNodeByName(self.rootNode, "Img_BgWaitingTip")
    self.bgWaitingTip:setVisible(false)
    self.waitType = nil
    self.lbWatingTip = gt.seekNodeByName(self.rootNode, "Label_WatingTip")
    self.autoWaitTime = 0   --自动托管的等待时间
    self.autoTimePause = false --是否暂停自动托管
    self.cardSignInHandInit = {1, 1, 1, 1, 1} --手牌的明暗标识
    self.isWait = true
    --是否有抢庄动画
    self.bRobDealersAni = false
    --亮牌动画时间
    self.showCardAniTime = 0
    --语音聊天互动CD时间
    self.chatCD = 5
    --默认自己没位置
    self.playerSeatIdx = -1
    --默认庄家没位置
    self.bankerSeatIdx = -1
	-- 房间中的玩家
	self.roomPlayers = {}
	--标志
	self.ChatLog = {}
	self.isRoomCreater = false
	self.roomState = ROOM_STATE.INIT
	self.relogining = false
	-- 亮牌队列
	self.cardShowQueue = {}
	self.cardShowDelay = 0

	--隐藏局数
	self.roundStateNode = gt.seekNodeByName(self.rootNode, "Img_RoundBg")
    if self.roundStateNode then
	     self.roundStateNode:setVisible(false)
    end
    self.selectSpecialSortResult = GameLogic.CT_EX_INVALID
    self.autoLiPaiSpecailSelect = GameLogic.CT_EX_INVALID
    self.freeLiPaiSpecailSelect = GameLogic.CT_EX_INVALID
    
	--更新房间号
	local titleBg = gt.seekNodeByName(self.rootNode, "Img_SetBg")
	local roomIDLabel = gt.seekNodeByName(self.rootNode, "Label_RoomNumber")
	roomIDLabel:setString(enterRoomMsgTbl.room_id)
    self.roomID = enterRoomMsgTbl.room_id

	-- 头像下载管理器
	local playerHeadMgr = require("app/PlayerHeadManager"):create()
	self.rootNode:addChild(playerHeadMgr)
	self.playerHeadMgr = playerHeadMgr

	-- 倒计时
	self.playTimeCDLabel = gt.seekNodeByName(self.rootNode, "Label_PlayTimeCD")
    self.playTimeCDLabel:setVisible(false)

	self.playerNodes = {}
    self.playerWaitSigns = {}
    self.playerRobZhuangFrames = {}
    self.playerAddSocre = {}

    gt.playerData.emojiActTime = 0
  
    local selfCardParNode  = gt.seekNodeByName(self.rootNode, "pCard1" )
    self.selfCardParNodePosX = selfCardParNode:getPositionX()
    self.selfCardParNodePosY = selfCardParNode:getPositionY()

  -- 刚进入房间,隐藏玩家信息节点
    for i = 1, uiChairsNum do
		local playerNode = gt.seekNodeByName(self.rootNode, "Node_playerInfo_" .. i)
		playerNode:setVisible(false)
		local headFrameBtn = gt.seekNodeByName(playerNode, "Panel_HeadFrame")

		local headSpr = gt.seekNodeByName(playerNode, "Spr_Head")
        if headSpr == nil then
            headSpr = cc.Sprite:create("image/common/img_head.png")
        else
            headSpr:removeFromParent(true)
        end
		
		headSpr:setPosition(cc.p(0,0))
		headSpr:setScale(96.0/96.0)
		local stencil = cc.Sprite:create("image/play/avatar_shader.png")
		local clipper = cc.ClippingNode:create()
		clipper:setStencil(stencil)
		clipper:setInverted(true)
		clipper:setAlphaThreshold(0)
		local x,y = headFrameBtn:getPosition()
		local headFrameSize = headFrameBtn:getContentSize()
		clipper:setPosition(cc.p(headFrameSize.width/2,headFrameSize.height/2))
		clipper:addChild(headSpr)
		clipper:setLocalZOrder(-100)
		headFrameBtn:addChild(clipper)

		local offLineSignSpr = gt.seekNodeByName(playerNode, "Label_offline")
        offLineSignSpr:setVisible(false)
		local lbWait = gt.seekNodeByName(playerNode, "Label_Wait")
        lbWait:setVisible(false)
        local robZhuangSpr = gt.seekNodeByName(playerNode, "Img_RobZhuang")
        robZhuangSpr:setVisible(false)
        local lbAddScore = gt.seekNodeByName(playerNode, "Label_AddScore")
        lbAddScore:setVisible(false)
       -- lbAddScore:setOpacity(0)

        self.playerWaitSigns[i] = lbWait
        self.playerRobZhuangFrames[i] = robZhuangSpr
        self.playerAddSocre[i] = lbAddScore
		self.playerNodes[i] = playerNode

		--推注标识
		local tuiflag = cc.CSLoader:createNode("csd/TuiFlag.csb")
		playerNode:addChild(tuiflag)
		self.playerNodes[i].TuiFlag=tuiflag
		self.playerNodes[i].TuiScore=gt.seekNodeByName(tuiflag,"Text_Score")
		tuiflag:setVisible(false)
	end

    --观战标识
    self.imgGuanZhan = gt.seekNodeByName(self.rootNode, "Image_GuanZhan")
    self.imgGuanZhan:setVisible(false)

	-- 准备标示
	self.readySigns = {}
	for i = 1, uiChairsNum do
		local readySignNode = gt.seekNodeByName(self.rootNode, "Node_readySign")
		local readySignSpr = gt.seekNodeByName(readySignNode, "Spr_readySign_" .. i)
		readySignSpr:setVisible(false)
		self.readySigns[i] = readySignSpr
	end

	-- 隐藏玩家牌
    self.orignal_cardsInfo = {}
    self.comparison_cardsInfo = {}
	self.cardViews = {}
	local playNode = gt.seekNodeByName(self.rootNode, "Node_play")
	for i = 1, uiChairsNum do
		self.cardViews[i] = {}
		local cardNode = playNode:getChildByName("pCard"..i)
		cardNode:setVisible(false)
		self.cardViews[i].node = cardNode
		self.cardViews[i].imgCards = {}
        
		for j = 1, 13 do
			self.cardViews[i].imgCards[j] = cardNode:getChildByName("imgCrad"..j)
            self.cardViews[i].imgCards[j].imgCardPos = cc.p(self.cardViews[i].imgCards[j]:getPosition())
            self:setOrignalCardData(self.cardViews[i].imgCards[j],j,i)          
		end

        self:setOrignalCardData(self.cardViews[i].imgCards[1]:getParent(),99,i)
		local effectNode = cc.Node:create()
		cardNode:addChild(effectNode)
		self.cardViews[i].effectNode = effectNode
        self.cardViews[i].imgNiuRate = cardNode:getChildByName("imgNiuRate")
        self.cardViews[i].imgNiuRate:setLocalZOrder(1000)
        self.cardViews[i].imgNiuRate:setVisible(false)
		self.cardViews[i].imgScore = cardNode:getChildByName("Img_Score")
		self.cardViews[i].imgScore:setVisible(false)
		self.cardViews[i].imgScorePos = cc.p(self.cardViews[i].imgScore:getPosition())
		self.cardViews[i].lblScore = self.cardViews[i].imgScore:getChildByName("lblScore")
        self.cardViews[i].imgWinLose = self.cardViews[i].imgScore:getChildByName("Img_Win_Lose")
	end

    -- 房间信息按钮
    local btnInfo = gt.seekNodeByName(self.rootNode, "Btn_Info")
    gt.addBtnPressedListener(btnInfo, handler(self, self.infoBtnClickEvt))
    btnInfo:setVisible(false)
    self.btnInfo = btnInfo

	-- 隐藏准备按钮
	local readyBtn = gt.seekNodeByName(self.rootNode, "Btn_ready")
	readyBtn:setVisible(false)
	gt.addBtnPressedListener(readyBtn, handler(self, self.readyBtnClickEvt))
	self.readyBtn = readyBtn

	-- 隐藏开始按钮
	local startBtn = gt.seekNodeByName(self.rootNode, "Btn_Start")
	startBtn:setVisible(false)
	gt.addBtnPressedListener(startBtn, handler(self, self.startBtnClickEvt))
	self.startBtn = startBtn

	-- 隐藏邀请按钮
	local inviteFriendBtn = gt.seekNodeByName(self.rootNode, "Btn_inviteFriend")
    inviteFriendBtn:setVisible(false)
	gt.addBtnPressedListener(inviteFriendBtn, function()
        local num = gt.getTableSize(self.roomPlayers)
        gt.getRoomShareString(self.tableSetting, num, self.roomID, self.guildID)
	end)
    self.inviteFriendBtn = inviteFriendBtn

    -- 隐藏亮牌按钮
	local showCardBtn = gt.seekNodeByName(self.rootNode, "Btn_ShowCard")
	showCardBtn:setVisible(false)
	gt.addBtnPressedListener(showCardBtn, handler(self, self.showCardBtnClickEvt))
	self.showCardBtn = showCardBtn

	-- 隐藏翻牌按钮
	local openCardBtn = gt.seekNodeByName(self.rootNode, "Btn_OpenCard")
	openCardBtn:setVisible(false)
	gt.addBtnPressedListener(openCardBtn, handler(self, self.openCardBtnClickEvt))
	self.openCardBtn = openCardBtn

	-- 隐藏所有玩家对话框
	local chatBgNode = gt.seekNodeByName(self.rootNode, "Node_chatBg")
	self.rootNode:reorderChild(chatBgNode, PlaySceneSSS.ZOrder.CHAT)
	chatBgNode:setVisible(false)

	--聊天按钮
	self.chatBtn = gt.seekNodeByName(self.rootNode, "Btn_Chat")
	self.chatBtn:setVisible(false)
	gt.addBtnPressedListener(self.chatBtn, function()
		local chatPanel
		if #self.ChatLog > 0 then
			chatPanel = require("app/views/ChatPanel"):create(self.ChatLog, false, self.is_shutup)
		else
		 	chatPanel = require("app/views/ChatPanel"):create(false, false, self.is_shutup)
		end
		chatPanel:setPosition(0,0)
		self:addChild(chatPanel, PlaySceneSSS.ZOrder.CHAT)
	end)

	 --添加设置
	self.settingBtn = gt.seekNodeByName(self.rootNode, "Btn_setting")
	gt.addBtnPressedListener(self.settingBtn, function()

		local playerState_ = -1
		if self.roomPlayers and self.roomPlayers[self.playerSeatIdx] then
			if self.roomPlayers[self.playerSeatIdx].state == PLAYER_STATE.READY_WAIT then
				playerState_ = 1
			end
		end

		local param = {isMatch = self.isMatch,playerState= playerState_, isWait=self.isWait, roomState=self.roomState, curRound=self.curRound, owner=self:isRoomOwner(),sport_id=self.sport_id}
        local settingPanel = require("app/views/Setting"):create(param, 1)
		self:addChild(settingPanel, PlaySceneSSS.ZOrder.SETTING)
	end)

	--语音按钮
	self.yuyinBtn = gt.seekNodeByName(self.rootNode, "Btn_Voice")
    self.yuyinBtn:setVisible(false)

	--发送语音提示
	local yuyinNode = gt.seekNodeByName(self.rootNode, "Node_yuyin")
	yuyinNode:setLocalZOrder(1000)
	if yuyinNode then
		yuyinNode:setVisible(true)

		self.YvYin_Node = YvYin_Node:create()
		self.YvYin_Node:setAnchorPoint(0.5, 0.5)
		self.YvYin_Node:setCallback(function( state )
			self:stopAudio()
		end)
		yuyinNode:addChild(self.YvYin_Node)
	end

	-- 语音聊天喇叭
	self.yuyinChatNode = gt.seekNodeByName(self.rootNode, "Node_Yuyin_Dlg")
	self.yuyinChatNode:setLocalZOrder(PlaySceneSSS.ZOrder.CHAT)
	self.yuyinChatNode:setVisible(false)

	--语音点击回调
	local function touchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
			if 1 == self.is_shutup then
				require("app/views/CommonTips"):create("管理员已禁止语音聊天", 2)
				return
			end
            self.yuyinBtn:stopAllActions()
	        gt.soundEngine:pauseAllSound()
	        self:startAudio()
	        self.YvYin_Node:setState(YvYin_Node.YVYIN)
        elseif eventType == ccui.TouchEventType.moved then
        	if math.abs(sender:getTouchBeganPosition().y - sender:getTouchMovePosition().y) >= 100 then
		        self.YvYin_Node:setState(YvYin_Node.QVXIAO)
		    end
        elseif eventType == ccui.TouchEventType.ended then
	    	gt.soundEngine:resumeAllSound()
	    	if self.YvYin_Node:getState() == YvYin_Node.QVXIAO then
	    		self:stopAudio(true)
	    	elseif self.YvYin_Node:getState() == YvYin_Node.YVYIN then
	    		self:stopAudio(false)
	    	end
	    	self.YvYin_Node:setState(YvYin_Node.YINCANG)
        elseif eventType == ccui.TouchEventType.canceled then
            gt.soundEngine:resumeAllSound()
		    self:stopAudio(true)
		    self.YvYin_Node:setState(YvYin_Node.YINCANG)
        end
    end
	self.yuyinBtn:addTouchEventListener(touchEvent)

	-- 聊天背景
	local chatBgNode = gt.seekNodeByName(self.rootNode, "Node_chatBg")
    self.chat_bg_pos = {}
    for i = 1, uiChairsNum do
		local nodeChatBg = gt.seekNodeByName(chatBgNode, "Node_PlayerChatBg_" .. i)
        local imgChatBg = gt.seekNodeByName(nodeChatBg, "Img_playerChatBg")
		nodeChatBg:setVisible(false)
        local emojiNode = gt.seekNodeByName(chatBgNode, "Node_Emoji_"..i)
        emojiNode:setVisible(false)
        self.chat_bg_pos[i] = cc.p(nodeChatBg:getPosition())
	end

	--查看上局大结算按钮  比赛房用
	self.Btn_ViewFinalReport=gt.seekNodeByName(csbNode,"Btn_ViewFinalReport")
	self.Btn_ViewFinalReport:setVisible(false)

	--托管
	self.Btn_Trusteeship = gt.seekNodeByName(csbNode,"Btn_Trusteeship")
	gt.addBtnPressedListener(self.Btn_Trusteeship,function()
		local trusteeship = require("app/views/Trusteeship"):create(self.tableSetting)
		self.TrusteeshipPanel = trusteeship
		self:addChild(trusteeship)
	end)
	if self:HasTrusteeship() then
		self.IsTrusteeship = true
	else
		self.IsTrusteeship = false
	end
	self.Btn_Trusteeship:setVisible(false)
	--托管中界面
	self.Node_Trusteeship = gt.seekNodeByName(csbNode,"Node_Trusteeship")
	self.Node_Trusteeship:setVisible(false)
	self.Node_Trusteeship:setLocalZOrder(99999999)
	local TrusteeshipBG = self.Node_Trusteeship:getChildByName("Img_BG")

	self.tuoguan_listener = cc.EventListenerTouchOneByOne:create()  --创建一个单点事件监听
	self.tuoguan_listener:setSwallowTouches(true)  --不向下传递
	local function OnTouchBegan(touch,event)
		self.LastTouchCD = 20
		return false
	end
	self.tuoguan_listener:registerScriptHandler(OnTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(self.tuoguan_listener,TrusteeshipBG) --分发监听事件

	self.Btn_CancelTrusteeship = gt.seekNodeByName(self.Node_Trusteeship, "Btn_Cancel")
	gt.addBtnPressedListener(self.Btn_CancelTrusteeship,function()
		local msg = {}
		msg.cmd = gt.TRUSTEESHIP
		msg.ai_type = 0
		dump(msg)
		gt.socketClient:sendMessage(msg)
	end)
	
	self.Btn_ShowResult = gt.seekNodeByName(self.rootNode, "Btn_ShowResult")
	self.Btn_ShowResult:setVisible(false)
	gt.addBtnPressedListener(self.Btn_ShowResult,function()
		local layer = require("app/games/SSS/GameBrief"):create(self.ResultmsgTbl, self.curRound)
        self:addChild(layer, PlaySceneSSS.ZOrder.REPORT)
	end)

	-- 接收消息分发函数
	gt.socketClient:registerMsgListener(gt.ENTER_ROOM, self, self.onRcvEnterRoom) --进入房间
	gt.socketClient:registerMsgListener(gt.ENTER_ROOM_OTHER, self, self.onEnterRoomOther) --接收玩家消息
	gt.socketClient:registerMsgListener(gt.EXIT_ROOM, self, self.onRcvExitRoom) --从房间移除一个玩家
	gt.socketClient:registerMsgListener(gt.RECONNECT_DN, self, self.onRcvSyncRoomState) --断线重连
	gt.socketClient:registerMsgListener(gt.READY, self, self.onRcvReady) --玩家准备回调
	gt.socketClient:registerMsgListener(gt.PAUSE, self, self.onRcvPause) --玩家暂停回调
    gt.socketClient:registerMsgListener(gt.WAIT_DN, self, self.onRcvReadyWait) --玩家预准备回调
    gt.socketClient:registerMsgListener(gt.READY_LATE, self, self.onRcvReadyLate) --准备晚了，座位被占了回调
	gt.socketClient:registerMsgListener(gt.PROMPT_START_DN, self, self.onRcvPromptStart) --提示显示开始游戏按钮
    gt.socketClient:registerMsgListener(gt.START_DN, self, self.onRcvStart) --开始游戏回调
	gt.socketClient:registerMsgListener(gt.DEAL, self, self.onRcvDealCard) --发牌
    gt.socketClient:registerMsgListener(gt.SORT_CARD, self, self.onRcvSortCard) --整牌
    gt.socketClient:registerMsgListener(gt.PROMPT_CARD_DN, self, self.onPromptShowCard) --玩家亮牌提示

	gt.socketClient:registerMsgListener(gt.SAMEIP, self, self.IsSameIp) --相同IP
	gt.socketClient:registerMsgListener(gt.ONLINE_STATUS, self, self.onRcvOffLineState) --玩家在线标识
	gt.socketClient:registerMsgListener(gt.ROUND_STATE, self, self.onRcvRoundState) --当前局数/最大局数
	gt.socketClient:registerMsgListener(gt.SPEAKER, self, self.onRcvChatMsg)
	gt.socketClient:registerMsgListener(gt.SETTLEMENT_FOR_ROUND_DN, self, self.onRcvRoundReport) --单局游戏结束
	gt.socketClient:registerMsgListener(gt.SETTLEMENT_FOR_ROOM_DN, self, self.onRcvFinalReport) --总结算界面
	gt.socketClient:registerMsgListener(gt.DISMISS_ROOM, self, self.onRcvDismissRoom)	--解散房间
	gt.socketClient:registerMsgListener(gt.SPONSOR_VOTE, self, self.onRcvSponorVote)	--发起投票
	gt.socketClient:registerMsgListener(gt.VOTE, self, self.onRcvVote)	--选择投票
	gt.socketClient:registerMsgListener(gt.SYNC_SCORE, self, self.onRcvSyncScore)	--同步积分
	gt.socketClient:registerMsgListener(gt.SCORE_LEAK, self, self.onRcvScoreLeak)	--积分不足

    gt.socketClient:registerMsgListener(gt.PUSH_PLEDGE, self, self.onRcvPush)    -- 可推注xxx
    gt.socketClient:registerMsgListener(gt.PUSH_PLEDGE, self, self.onRcvPush)

	gt.registerEventListener(gt.EventType.BACK_MAIN_SCENE, self, self.backMainSceneEvt)
    gt.registerEventListener(gt.EventType.CHANGE_PLAY_BG, self, self.changePlayBg)
    gt.registerEventListener(gt.EventType.RUB_CARD_OVER, self, self.rubCardOverEvt)
    gt.registerEventListener(gt.EventType.PLAY_SCENE_RESET, self, self.playSceneResetEvt)  --从后台切换到前台的处理事件
	gt.registerEventListener("gunshootFX_hit", self, self.showGunAnimation)
	gt.registerEventListener(gt.EventType.PLAY_SCENE_RESTART, self, self.playSceneRestartEvt)  -- 比赛房间重新开始

	if enterRoomMsgTbl.IsReplay then
		self.tableSetting=enterRoomMsgTbl
		self.curRound=enterRoomMsgTbl.current_round
		self.RecordManager=require("app/RecordManager"):create()
		self.RecordManager:InitScene(self,enterRoomMsgTbl)
		self:addChild(self.RecordManager)
	else
		-- 请求进入房间
		local msgToSend = {}
		msgToSend.cmd = gt.ENTER_ROOM
		msgToSend.room_id = enterRoomMsgTbl.room_id
		msgToSend.player = gt.playerData.uid
		msgToSend.token = gt.token
		local info = {nick=gt.playerData.nickname, icon=gt.playerData.headURL, sex=gt.playerData.sex, game_count = gt.playerData.game_count, reg_time = gt.playerData.reg_time}
		require("json")
		msgToSend.info = json.encode(info)
		gt.socketClient:sendMessage(msgToSend)
	end
end

function PlaySceneSSS:unregisterAllMsgListener()
	gt.socketClient:unregisterMsgListener(gt.ENTER_ROOM)
	gt.socketClient:unregisterMsgListener(gt.ENTER_ROOM_OTHER)
	gt.socketClient:unregisterMsgListener(gt.EXIT_ROOM)
	gt.socketClient:unregisterMsgListener(gt.RECONNECT_DN)
	gt.socketClient:unregisterMsgListener(gt.READY)
	gt.socketClient:unregisterMsgListener(gt.PAUSE)
    gt.socketClient:unregisterMsgListener(gt.WAIT_DN)
    gt.socketClient:unregisterMsgListener(gt.READY_LATE)
	gt.socketClient:unregisterMsgListener(gt.PLEDGE_DN)
	gt.socketClient:unregisterMsgListener(gt.PROMPT_PLEDGE_DN)
    gt.socketClient:unregisterMsgListener(gt.PROMPT_LOOT_DEALER_DN)
    gt.socketClient:unregisterMsgListener(gt.LOOT_DEALER_DN)
    gt.socketClient:unregisterMsgListener(gt.DEAL2_DN)
	gt.socketClient:unregisterMsgListener(gt.PROMPT_START_DN)
    gt.socketClient:unregisterMsgListener(gt.START_DN)
	gt.socketClient:unregisterMsgListener(gt.DEAL)
    gt.socketClient:unregisterMsgListener(gt.PROMPT_CARD_DN)
	gt.socketClient:unregisterMsgListener(gt.SHOW_CARD_DN)
	gt.socketClient:unregisterMsgListener(gt.DEALER_SEAT)
	gt.socketClient:unregisterMsgListener(gt.SAMEIP)
	gt.socketClient:unregisterMsgListener(gt.ONLINE_STATUS)
	gt.socketClient:unregisterMsgListener(gt.ROUND_STATE)
	gt.socketClient:unregisterMsgListener(gt.SPEAKER)
	gt.socketClient:unregisterMsgListener(gt.SETTLEMENT_FOR_ROUND_DN)
	gt.socketClient:unregisterMsgListener(gt.SETTLEMENT_FOR_ROOM_DN)
	gt.socketClient:unregisterMsgListener(gt.SPONSOR_VOTE)
	gt.socketClient:unregisterMsgListener(gt.VOTE)
	gt.socketClient:unregisterMsgListener(gt.SYNC_SCORE)
	gt.socketClient:unregisterMsgListener(gt.SCORE_LEAK)
	gt.socketClient:unregisterMsgListener(gt.DISMISS_ROOM)
end

-- 断线重连,重新进入房间
function PlaySceneSSS:reLogin()
	self.relogining = true
    local msgToSend = {}
	msgToSend.cmd = gt.ENTER_ROOM
	msgToSend.room_id = self.roomID
	msgToSend.player = gt.playerData.uid
	msgToSend.token = gt.token
    local info = {nick=gt.playerData.nickname, icon=gt.playerData.headURL, sex=gt.playerData.sex, game_count = gt.playerData.game_count, reg_time = gt.playerData.reg_time}
    require("json")
	msgToSend.info = json.encode(info)
	gt.socketClient:sendMessage(msgToSend)
end

function PlaySceneSSS:changePlayBg()
    local networkBg = gt.seekNodeByName(self.rootNode, "Img_NetworkBg")
    -- 电量
    local batteryBg = gt.seekNodeByName(networkBg, "Img_BatteryBg")
    local barBattery = gt.seekNodeByName(networkBg, "LoadingBar_Battery")
    -- 网络信号
    local imgNetwork = gt.seekNodeByName(networkBg, "Img_Network")
    local desktop = gt.seekNodeByName(self.rootNode, "Img_Bg")
    local nodeSpine = gt.seekNodeByName(self.rootNode, "Node_Spine")
    local imgSetBg = gt.seekNodeByName(self.rootNode, "Img_SetBg")
    local imgLogo = gt.seekNodeByName(self.rootNode, "Img_Logo")
    imgLogo:setVisible(false)
    local roundStateNode = gt.seekNodeByName(self.rootNode, "Img_RoundBg")
    imgLogo:loadTexture("image/common/big_logo.png")
	nodeSpine:removeAllChildren()
    local deskString = cc.UserDefault:getInstance():getStringForKey("Desktop")
    if deskString == "4" then
       gt.soundEngine:playMusic("special", true)
        desktop:loadTexture("image/play/img_kjbj.jpg")
        if (self.roomChairs == 6) then
            networkBg:loadTexture("image/play/network_bg.png", ccui.TextureResType.plistType)
            imgSetBg:loadTexture("image/play/roominfo_bg2.png")
            roundStateNode:loadTexture("image/play/tips_bg.png")
        end
        self.sk2 = sp.SkeletonAnimation:create("image/play/effect/kjbj.json", "image/play/effect/kjbj.atlas")
		self.sk2:setAnimation(0, "animation", true)
	    nodeSpine:addChild(self.sk2)
    elseif deskString == "1" then
		gt.soundEngine:playMusic("table_bgm1",true)
        imgLogo:loadTexture("image/common/big_logo2.png")
        if (self.roomChairs == 6) then
            networkBg:loadTexture("image/play/network_bg.png", ccui.TextureResType.plistType)
            imgSetBg:loadTexture("image/play/roominfo_bg2.png")
            roundStateNode:loadTexture("image/play/tips_bg.png")
            desktop:loadTexture("games/SSS/play_bg_1.png")
        else
            desktop:loadTexture("games/SSS/play_bg_1.png")
	    end

    elseif deskString == "3" then
        gt.soundEngine:playMusic("special", true)
        if (self.roomChairs == 6) then
            networkBg:loadTexture("image/play/network_bg.png", ccui.TextureResType.plistType)
            imgSetBg:loadTexture("image/play/roominfo_bg2.png")
            roundStateNode:loadTexture("image/play/tips_bg.png")
        end
        self.sk1 = sp.SkeletonAnimation:create("image/play/effect/xkbj.json", "image/play/effect/xkbj.atlas")
		self.sk1:setAnimation(0, "animation", true)
	    nodeSpine:addChild(self.sk1)
		self.sk1:setScale(gt.xkbjScaleX, gt.xkbjScaleY)
    else
       gt.soundEngine:playMusic("classic", true)
       imgLogo:loadTexture("image/common/big_logo2.png")
       if self.roomChairs == gt.GameChairs.SIX then
           networkBg:loadTexture("image/play/network_bg1.png")
           desktop:loadTexture("games/SSS/play_bg_2.png")
           imgSetBg:loadTexture("image/play/roominfo_bg1.png")
           roundStateNode:loadTexture("image/play/time_bg1.png")
       else
           desktop:loadTexture("games/SSS/play_bg_2.png")
       end
    end

    -- 切换牌背
    if deskString == "3" or deskString == "4" then
        self.card_back = "image/card/back.png"
    else
        self.card_back = "image/card/back2.png"
    end
    if self.cardViews ~= nil then
        for k, v in pairs(self.cardViews) do
            for kk, vv in pairs(v.imgCards) do
                local imageRender = vv:getVirtualRenderer()
                local filename  = imageRender:getResourceName()

                if filename == "image/card/back.png" or filename == "image/card/back2.png" then
                    vv:loadTexture(self.card_back, ccui.TextureResType.plistType)
                end
            end
        end
    end
	--如果是赛场则固定这个音乐
	if self.sport_id and self.sport_id>0 then
		gt.soundEngine:playMusic("bgmSport2",true)
	end
end

-- 琼海抢庄显示底分
function PlaySceneSSS:showQHBaseScore()
    if self.roomChairs == 10 or self.roomChairs == 8 then
        local lableScore = gt.seekNodeByName(self.rootNode, "Text_Score")
        lableScore:setVisible(false)
        if self.game_type == gt.GameType.GAME_QH_BANKER then
            lableScore:setVisible(true)
            lableScore:setString( string.format("底分：%d分", self.tableSetting.qh_base_score))
        end
    end
end

function PlaySceneSSS:showEmojiAnimation(emojiAnimation, seatIdxStart, id, user_id)
    local startPlayer = self.roomPlayers[seatIdxStart]
    if not startPlayer then
    	return
    end
    local playerNodeStart = gt.seekNodeByName(self.rootNode, "Node_playerInfo_" .. startPlayer.displaySeatIdx)
    local pos1 = cc.p(playerNodeStart:getPosition())

    local function call_back(sender)
        gt.soundEngine:playEffect("emoji_act/"..emojiAnimation, false)
        local aniNode, action = gt.createCSAnimation("image/play/mj_biaoqingefect/"..emojiAnimation..".csb")
		action:gotoFrameAndPlay(0,false)
        action:setFrameEventCallFunc(function (frameEventName)
            local frameName = frameEventName:getEvent()
            if (frameName == "endAni") then
                aniNode:removeFromParent()
            end
        end)
        sender:addChild(aniNode)
    end


        local seatIdxEnd = nil
        for seatIdx, roomPlayer in pairs(self.roomPlayers) do
            if roomPlayer.uid == id then
                seatIdxEnd = roomPlayer.displaySeatIdx
            end
        end
        local playerNodeEnd = gt.seekNodeByName(self.rootNode, "Node_playerInfo_" .. seatIdxEnd)
        local pos2 = cc.p(playerNodeEnd:getPosition())
		pos1.x = pos1.x + gt.OffsetX
		pos1.y = pos1.y + gt.OffsetY
		pos2.x = pos2.x + gt.OffsetX
		pos2.y = pos2.y + gt.OffsetY
        if emojiAnimation ~= "gunshootFX_hit" then
            display.loadSpriteFrames("image/play/emoji/emoji.plist", "image/play/emoji/emoji.png")
            local imgEmoji = cc.Sprite:createWithSpriteFrameName("image/play/emoji/".. emojiAnimation ..".png")
            imgEmoji:setPosition(pos1)
            self.rootNode:addChild(imgEmoji)
            imgEmoji:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, pos2), cc.DelayTime:create(0.1), cc.RemoveSelf:create()))
        end
        local actionNode = cc.Node:create()
        actionNode:setPosition(pos2)
        actionNode:setLocalZOrder(30000)
        self.rootNode:addChild(actionNode)
        actionNode:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(call_back), cc.DelayTime:create(3), cc.RemoveSelf:create()))

end

function PlaySceneSSS:onNodeEvent(eventName)
	if "enter" == eventName then
		-- 计算更新当前时间倒计时
		local curTimeStr = os.date("%X", os.time())
		local timeSections = string.split(curTimeStr, ":")
		local secondTime = tonumber(timeSections[3])
		self.updateTimeCD = 60 - secondTime
		self:updateCurrentTime()
		 self.updateBatteryAndNetworkCD = 5
		self.LastTouchCD = 20
		 self:updateBatteryAndNetwork()

		-- 逻辑更新定时器
		self.scheduleHandler = gt.scheduler:scheduleScriptFunc(handler(self, self.update), 0.1, false)
     --   self.scheduleWait = gt.scheduler:scheduleScriptFunc(handler(self, self.updateAutoWaitCD), 0.1, false)

       
        

--		gt.soundEngine:playMusic("bgm2", true)
	elseif "exit" == eventName then
		extension.callBackHandler = {}
		gt.removeTargetAllEventListener(self)
		gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
     --   gt.scheduler:unscheduleScriptEntry(self.scheduleWait)
		--gt.soundEngine:playMusic("bgm1", true)
		ccs.ArmatureDataManager:destroyInstance()
        gt.removeCocosEventListener(self,self.tuoguan_listener)
        self.tuoguan_listener = nil

        if self.stopWatchScheId then
            gt.scheduler:unscheduleScriptEntry(self.stopWatchScheId)
            self.stopWatchScheId = nil
        end

	end
end


function PlaySceneSSS:update(delta)
	if self.IsPlay and self.PlaySpeed then
		delta= self.IsPlay*self.PlaySpeed*delta
	end
	self.updateTimeCD = self.updateTimeCD - delta
	if self.IsTrusteeship and not self.isWait and #self.roomPlayers > 1 and self.roomState>=ROOM_STATE.START then
		if self.LastTouchCD > 0 then
			self.LastTouchCD = self.LastTouchCD - delta
		end
		if self.LastTouchCD < 0 then
			local msg = {}
			msg.cmd = gt.TRUSTEESHIP
			msg.ai_type = 1
			dump(msg)
			gt.socketClient:sendMessage(msg)
			self.LastTouchCD = 9999999999
		end
	end
	if self.updateTimeCD <= 0 then
		self.updateTimeCD = 60
		self:updateCurrentTime()
	end
	 self.updateBatteryAndNetworkCD = self.updateBatteryAndNetworkCD - delta
	 if self.updateBatteryAndNetworkCD <= 0 then
	 	self.updateBatteryAndNetworkCD = 5
	 	self:updateBatteryAndNetwork()
	 end
	-- 更新倒计时
	self:playTimeCDUpdate(delta)

	self.cardShowDelay = self.cardShowDelay - delta
	if #(self.cardShowQueue) > 0 then
		if self.cardShowDelay <= 0 then
			local roomPlayer = self.cardShowQueue[1]
			self:showHandCards(false, roomPlayer.displaySeatIdx, roomPlayer.cards_in_hand, roomPlayer.cardsign_in_hand, roomPlayer.sex, roomPlayer.niu_type)
			table.remove(self.cardShowQueue, 1)
			self.cardShowDelay = 0.8
		end
	end
end

--是否庄家
function PlaySceneSSS:isBanker(playerSeatIdx)

    if (playerSeatIdx ~= nil) then
        if self.bankerSeatIdx > 0 and self.bankerSeatIdx == playerSeatIdx then
		    return true
	    end
    else
	    if self.bankerSeatIdx > 0 and self.bankerSeatIdx == self.playerSeatIdx then
		    return true
	    end
    end

	return false
end

-- 是否是房间拥有者(房间创建者，房间庄家都是)
function PlaySceneSSS:isRoomOwner()
    --房间创建者，房间庄家都是
    if self.guildID and self.guildID > 0 then
    	return self.isRoomCreater or self.isAdmin

    elseif (self.isRoomCreater or self:isBanker() or self.isAdmin) then
		return true
	end

	return false
end

--进入房间回调
function PlaySceneSSS:onRcvEnterRoom(msgTbl)
    gt.removeLoadingTips()
    gt.dump(msgTbl, "onRcvEnterRoom-------------")
    
    if msgTbl.code == 1 then
        -- 房间不存在
		local tips = gt.LocationStrings.LTKey_0062
		if self.relogining then
			tips = gt.LocationStrings.LTKey_0063
		end
        require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, tips,
			function()
				gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
			end, function()
			gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
		end, true)
		return
    elseif msgTbl.code == 2 then
        -- 房间人已满
        require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, gt.LocationStrings.LTKey_0018,
			function()
				gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
			end, function()
			gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
		end, true)
		return
	elseif msgTbl.code == 3 then
		-- 房间数据错误
        require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, "房间数据错误",
			function()
				gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
			end, function()
			gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
		end, true)
		return
	end

	self:reInitScene()

	self.relogining = false
	-- 桌子配置
	require("json")
	self.tableSetting = json.decode(msgTbl.kwargs)
    self.wafaSpecialType = {}
    for i = 1,8 do   
             self.wafaSpecialType[i] = string.sub(self.tableSetting.options,i,i) == "1"
    end
    local wafa_table = gt.games_config_list[gt.GameID.SSS]["wanfa"]
    local touJinStrIndex =  wafa_table["Check_11"][2]
    self.wafaTouJin = string.sub(self.tableSetting.options,touJinStrIndex,touJinStrIndex) == "1" 
    self.wafaTouJin = self.wafaTouJin or false
    -- local DaoShuiStrIndex =  wafa_table["Check_12"][2]
    -- self.wafaDaoShuiFaFen = string.sub(self.tableSetting.options,DaoShuiStrIndex,DaoShuiStrIndex) == "1"
    -- self.wafaDaoShuiFaFen = self.wafaDaoShuiFaFen or false
    
	self.isAdmin = msgTbl.is_admin
    self.btnInfo:setVisible(true)
	
	--禁言设置
	self.is_shutup = 0
	if 1 == self.tableSetting.is_shutup then
		self.is_shutup = 1
	end
       
--    self.imgGuanZhan:setVisible(true)

	-- 桌子状态
	self.roomState = msgTbl.room_state
	if msgTbl.owner == gt.playerData.uid then
		self.isRoomCreater = true
	end
	if self.isMatch>0 and self.IsNewGame then
		self.readyBtn:setPositionX(-150)
		self.readyBtn:loadTextureNormal("image/play/btn_continue.png")
		self.readyBtn:setContentSize(192,71)
		self.Btn_ViewFinalReport:setVisible(true)
		self.Btn_ViewFinalReport:setPositionX(150)
	end
	--庄家座位号
	self.bankerSeatIdx = msgTbl.dealer + 1
    --更新局数
    local roundsData = {}
    roundsData.round = msgTbl.round
    roundsData.rounds = msgTbl.rounds
    self:onRcvRoundState(roundsData)
    --显示房间Title
    self:showPlayTitle()

	-- 玩家显示固定座位号
	self.playerFixDispSeat = 1
	-- 逻辑座位和显示座位偏移量(从0编号开始)
	local seatOffset = (self.playerFixDispSeat - 1) - (self.roomChairs-1)
	self.seatOffset = seatOffset
    for i, v in ipairs(msgTbl.player) do
        self:onEnterRoomOther(v)
    end

    local seatNum = #msgTbl.player
    --座位已坐满，桌子还在准备状态，此时进来的观察者
    if (seatNum >= self.roomChairs and self.roomState == ROOM_STATE.READY) then
        local roomPlayerBanker = self.roomPlayers[self.bankerSeatIdx]
        local tip = string.format("等待%s开始游戏...", roomPlayerBanker.nickname)
        self.lbWatingTip:setString(tip)
        self.bgWaitingTip:setVisible(true)
    end

    if (seatNum < self.roomChairs) then
        -- 桌子没坐满显示准备按钮
		self.readyBtn:setVisible(true)
		if not gt.isIOSReview() then
			self.inviteFriendBtn:setVisible(true)
		end
    end
    self:showQHBaseScore()
end


--接收房间添加玩家消息
function PlaySceneSSS:onEnterRoomOther(msgTbl)
	-- 封装消息数据放入到房间玩家表中
    gt.dump(msgTbl, "onEnterRoomOther------------")
	local roomPlayer = {}
	roomPlayer.uid = msgTbl.player
	--玩家自己
    if (msgTbl.player == gt.playerData.uid) then
		if self:HasTrusteeship() then
			if  msgTbl.ai_type ==0 then
				--取消托管
				self.LastTouchCD = 20
				self.Node_Trusteeship:setVisible(false)
			elseif msgTbl.ai_type ==1 or msgTbl.ai_type ==2 then
				--托管中
--				self.LastTouchCD = 9999999999
--				self.Node_Trusteeship:setVisible(true)
--				gt.dispatchEvent("Close_Trusteeship")
			end
		end
        self.isWait = msgTbl.is_wait

        -- 玩家座位编号
	    self.playerSeatIdx = msgTbl.seat + 1
	    -- 玩家显示固定座位号
	    self.playerFixDispSeat = 1
	    -- 逻辑座位和显示座位偏移量(从0编号开始)
	    local seatOffset = (self.playerFixDispSeat - 1) - msgTbl.seat
	    self.seatOffset = seatOffset

        --清除以前位置状态
        for key, var in pairs(self.roomPlayers) do
	        local playerInfoNode = gt.seekNodeByName(self.rootNode, "Node_playerInfo_" .. var.displaySeatIdx)
	        playerInfoNode:setVisible(false)

		    local headSpr = gt.seekNodeByName(playerInfoNode, "Spr_Head")
		    self.playerHeadMgr:resetHeadSpr(headSpr)

            local waitSign = self.playerWaitSigns[var.displaySeatIdx]
            waitSign:setVisible(false)
            local readySignSpr = self.readySigns[var.displaySeatIdx]
	        readySignSpr:setVisible(false)

            self.cardViews[var.displaySeatIdx].node:setVisible(false)
        end
        self.playerHeadMgr:detachAll()

        --把别人的位置重排下
        for key, var in pairs(self.roomPlayers) do
            --重新绘制新位置状态
            var.displaySeatIdx = (var.seatIdx - 1 + self.seatOffset) % self.roomChairs + 1
            self:roomAddPlayer(var)
        end

        local sex = ""
         if roomPlayer.sex == 2 then
             self.sexStr = "woman"
         else
             self.sexStr = "man"
        end

	end
    if (msgTbl.dealer ~= nil and msgTbl.dealer >= 0) then
	    -- 庄家座位号
	    self.bankerSeatIdx = msgTbl.dealer + 1
    end

    local infoTbl = json.decode(msgTbl.info)
	roomPlayer.nickname = infoTbl.nick
	roomPlayer.headURL = infoTbl.icon
	roomPlayer.sex = infoTbl.sex
    roomPlayer.game_count = infoTbl.game_count or 0
    roomPlayer.reg_time = infoTbl.reg_time or 0
	roomPlayer.ip = msgTbl.ip
    roomPlayer.isWait = msgTbl.is_wait
    -- 服务器位置从0开始
	-- 客户端位置从1开始
	roomPlayer.seatIdx = msgTbl.seat + 1
	-- 显示座位编号
	roomPlayer.displaySeatIdx = (msgTbl.seat + self.seatOffset) % self.roomChairs + 1
    roomPlayer.score = msgTbl.score
	roomPlayer.state = msgTbl.state
	roomPlayer.cards_in_hand = msgTbl.cards_in_hand or {}
    roomPlayer.niu_type = msgTbl.niu_type or 0

    

	-- 房间添加玩家
	self:roomAddPlayer(roomPlayer)
end

function PlaySceneSSS:setMaPai(card,cardValue)

    if  sszCardTools.value(cardValue)  == self.tableSetting.mapai and sszCardTools.color(cardValue) == 3 then
--         if card:getChildByName("mapaiSprite") then
--            card:getChildByName("mapaiSprite"):setVisible(true)
--         else
--            local mapaiSprite = cc.Sprite:create("games/SSS/matag.png")
--            mapaiSprite:setPosition(mapaiSprite:getContentSize().width/2+5.0,card:getContentSize().height/2)
--            mapaiSprite:setName("mapaiSprite")
--            mapaiSprite:setScale(0.7)
--            card:addChild(mapaiSprite)
--         end
        card:setColor(cc.c3b(214,173,255))
    else
--        if card:getChildByName("mapaiSprite") then
--            card:removeChildByName("mapaiSprite")
--        end 
        card:setColor(cc.c3b(255,255,255))
    end
end

function PlaySceneSSS:removeMaPai(card)
        card:setColor(cc.c3b(255,255,255))
end

function PlaySceneSSS:getSexStr(sex)
    
    if sex == 2 then
        return "woman"
    else 
        return "man"
    end

end


-- 退出房间
function PlaySceneSSS:onRcvExitRoom(msgTbl)
	if msgTbl.player == gt.playerData.uid then	-- 自己退出
		gt.removeLoadingTips()
		if msgTbl.type and msgTbl.type==1 then
			require("app/views/NoticeTips"):create("提示", "服务器维护中!", function()
				gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
			end, function()
				gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
			end, true)
		else
			gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
		end
		self.playerHeadMgr:detachAll()

	else
        -- 其他人退出 seat=-1是观察者
        if (msgTbl.seat >= 0) then
            local bNoSeatWait = true --是否是没有坐下的旁观者
            for key, var in pairs(self.roomPlayers) do
                if (var.uid == gt.playerData.uid) then
                    bNoSeatWait = false
                    break
                end
            end
            if (bNoSeatWait) then
                self.readyBtn:setVisible(true)
            end

		    local seatIdx = msgTbl.seat + 1
		    local roomPlayer = self.roomPlayers[seatIdx]
		    -- 隐藏玩家信息
		    local playerInfoNode = self.playerNodes[roomPlayer.displaySeatIdx]
		    self.playerNodes[roomPlayer.displaySeatIdx]:setVisible(false)

		    -- 隐藏玩家手势
		    self.readySigns[roomPlayer.displaySeatIdx]:setVisible(false)
		   
  

		    -- 取消头像下载监听
		    local headSpr = gt.seekNodeByName(playerInfoNode, "Spr_Head")
		    self.playerHeadMgr:detach(headSpr)
		    self.playerHeadMgr:resetHeadSpr(headSpr)
		    
		    -- 去除数据
		    self.roomPlayers[seatIdx] = nil
        end
	end
end

-- 断线重连
function PlaySceneSSS:onRcvSyncRoomState(msgTbl,isStart)
	gt.removeLoadingTips()
    self:stopAllActions()
    --关闭搓牌动画界面
 --   gt.dispatchEvent(gt.EventType.SHOW_CARD_OVER)
--    gt.dump(msgTbl, "断线重连-----------")
--    self:resetCardSigns()
	self.readyBtn:setVisible(false)
    self.Btn_ShowResult:setVisible(false)
	if self:getChildByName("GameBrief") then
        self:removeChildByName("GameBrief")
	end
	self.startBtn:setVisible(false)
    self.inviteFriendBtn:setVisible(false)
    self.imgGuanZhan:setVisible(false)
	self.showCardBtn:setVisible(false)
	self.openCardBtn:setVisible(false)
    self.openCardBtn:stopAllActions()
    self.bgWaitingTip:setVisible(false)
    self:hidePlayersRobZhuangFrame()
    self:hideCardViewsActions()
    self:clearNiuEffect()
--	-- 游戏开始后隐藏准备标识
	self:hidePlayersReadySign()

	if self.scheIds then
        for k,v in pairs(self.scheIds) do
            if v then
                gt.scheduler:unscheduleScriptEntry(v)
                v = nil
                self.scheIds[k] = nil
            end
        end
        self.scheIds = {}
    end

--	-- 桌子配置
	require("json")
	self.tableSetting = json.decode(msgTbl.kwargs)
    self.wafaSpecialType = {}
    for i = 1,8 do   
             self.wafaSpecialType[i] = string.sub(self.tableSetting.options,i,i) == "1"
    end
    local wafa_table = gt.games_config_list[gt.GameID.SSS]["wanfa"]
    local touJinStrIndex =  wafa_table["Check_11"][2]
    self.wafaTouJin = string.sub(self.tableSetting.options,touJinStrIndex,touJinStrIndex) == "1" 
    self.wafaTouJin = self.wafaTouJin or false
    -- local DaoShuiStrIndex =  wafa_table["Check_12"][2]
    -- self.wafaDaoShuiFaFen = string.sub(self.tableSetting.options,DaoShuiStrIndex,DaoShuiStrIndex) == "1"
    -- self.wafaDaoShuiFaFen = self.wafaDaoShuiFaFen or false
	
	--禁言设置
	self.is_shutup = 0
	if 1 == self.tableSetting.is_shutup then
		self.is_shutup = 1
	end

	self.isAdmin = msgTbl.is_admin
--    --是否断线重连
    self.bReconnect = true
    self.gameStyle = msgTbl.game_type
    self.curRound = msgTbl.round
    self.btnInfo:setVisible(true)
    local bShowMaxScore = msgTbl.show_max_score
    local showDouble = msgTbl.pledge_double
    --self.autoWaitTime = msgTbl.time
	self.cardShowQueue = {}

    local roundsData = {}
    roundsData.round = msgTbl.round
    roundsData.rounds = msgTbl.rounds
    self:onRcvRoundState(roundsData)
    self:showPlayTitle()
	if self:HasTrusteeship() and msgTbl.round>=1 and msgTbl.room_state>=ROOM_STATE.READY then
		self.Btn_Trusteeship:setVisible(true)
	end

    --已经被占了的座位数量
    local seatNum = #msgTbl.player
	-- 桌子状态
	self.roomState = msgTbl.room_state
	if msgTbl.owner == gt.playerData.uid then
		self.isRoomCreater = true
	end
	-- 庄家座位号
	self.bankerSeatIdx = msgTbl.dealer + 1
    --自己的状态
    local myselfState = msgTbl.player_status
    -- 桌子没坐满时且没有准备过的观战者显示准备，邀请按钮
    if (myselfState == PLAYER_STATE.INIT and seatNum < self.roomChairs) then
        self.readyBtn:setVisible(true)
--        self.imgGuanZhan:setVisible(true)
	    if not gt.isIOSReview() then
		    self.inviteFriendBtn:setVisible(true)
	    end
    end

    for i, v in ipairs(msgTbl.player) do
          if v.player == gt.playerData.uid then
            self.playerSeatIdx = v.seat + 1
            -- 玩家显示固定座位号
            self.playerFixDispSeat = 1
            -- 逻辑座位和显示座位偏移量(从0编号开始)
            local seatOffset = (self.playerFixDispSeat - 1) - v.seat
            self.seatOffset = seatOffset

        end
   end 
    
       
     --按位置seat从小到大排序
       local m_playrs = sszCardTools.copyTable(msgTbl.player)
    table.sort(m_playrs, function (a,b)
        return a.seat < b.seat
    end)
    for i, v in ipairs(m_playrs) do
        if (self.curRound > 1 and not v.is_wait) then
            self.inviteFriendBtn:setVisible(false)
        end
        self:onEnterRoomOther(v)  --这个方法里会显示庄家标识
    end
        
       for i, v in ipairs(msgTbl.player) do
          if v.player == gt.playerData.uid then
--            self.playerSeatIdx = v.seat + 1
--            -- 玩家显示固定座位号
--            self.playerFixDispSeat = 1
--            -- 逻辑座位和显示座位偏移量(从0编号开始)
--            local seatOffset = (self.playerFixDispSeat - 1) - v.seat
--            self.seatOffset = seatOffset
--           --自己是已经坐下的观战者显示邀请按钮

            if v.is_wait then
--                self.imgGuanZhan:setVisible(true)
		        if not gt.isIOSReview() then
			        self.inviteFriendBtn:setVisible(true)
		        end
            end

            if msgTbl.room_state == ROOM_STATE.DEAL  then
                local definedMsgTbl = {}   
                definedMsgTbl.wait_time = msgTbl.sort_card_30 or msgTbl.time or 300
                definedMsgTbl.self_cards = v.cards_in_hand
                definedMsgTbl.other_cards = {0,0,0,0,0,0,0,0,0,0,0,0,0}
                definedMsgTbl.cmd = 267
                definedMsgTbl.res_type=0
                definedMsgTbl.is_sorted = v.is_sorted
                self.bgWaitingTip:setVisible(false)
                if v.cards_in_hand and #v.cards_in_hand > 0 then
                	self:onRcvDealCard(definedMsgTbl,true)
                end
               
            elseif msgTbl.room_state == ROOM_STATE.RESRART  then
                self.readyBtn:loadTextureNormal("image/play/btn_ready.png")
                
                if self.scheIds then
                    for k,v in pairs(self.scheIds) do
                            if v then
                                    gt.scheduler:unscheduleScriptEntry(v)
                                    v = nil
                                    self.scheIds[k] = nil
                                end
                    end
                    self.scheIds = {}
                end
                    local playNode = gt.seekNodeByName(self.rootNode, "Node_play")
                    local cardView = self.cardViews[1]
                    local cardPar = cardView.imgCards[1]:getParent()
                    cardPar:setVisible(false)
                    gt.switchParentNode(cardPar,playNode)

                    cardPar:setPositionY(self.selfCardParNodePosY)
                    cardPar:setPositionX(self.selfCardParNodePosX)

                      gt.removeCocosEventListener(self,self.freeLipaiListener)
                    --  self.tlipaiUi.clockText = nil

                    self.rootNode:removeChildByName("lipai")
                    self.lipaiIsClose = true

                                self.readyBtn:setVisible(true)
            end

        else
        	local displaySeatIdx = self.roomPlayers[v.seat + 1].displaySeatIdx
        	local cardView = self.cardViews[displaySeatIdx]

        	for i=1,cardNum do
        		self:getOrignalCardData(cardView.imgCards[i], i, displaySeatIdx)
        	end
        	
        	if v.is_sorted == true then
    			self:setCardsToComparisonState(displaySeatIdx, true)
        	end
        end
    end

end

function PlaySceneSSS:showHandCardsByQueue(roomPlayer)
	--local data = {displaySeatIdx=displaySeatIdx, cards=cards, sex=sex, niu_type=niu_type}
	table.insert(self.cardShowQueue, roomPlayer)
end

--显示手牌
function PlaySceneSSS:showHandCards(bOrbitAni, displaySeatIdx, cards, cardsigns, sex, niu_type, bShowAll)
    if (bShowAll == nil) then
        bShowAll = false
    end
    local playerMe = self.roomPlayers[self.playerSeatIdx]
	local cardView = self.cardViews[displaySeatIdx]

	cardView.node:setVisible(true)
	for i = 1, 5 do
		local pos = cardView.imgCards[i].imgCardPos
        cardView.imgCards[i]:setPosition(pos)
		cardView.imgCards[i]:setVisible(false)
	end
    if (niu_type ~= nil) then
        --self:setShowCardsPos(niu_type, displaySeatIdx)
        self:setShowCardsShow(displaySeatIdx, cardsigns)
    end

    local orbitTime = 0.1
	for i, v in ipairs(cards) do
		if v > 0 then  -- 显示牌面
			cardView.imgCards[i]:setTag(v)
            if (not self.isWait and playerMe~= nil and playerMe.displaySeatIdx == displaySeatIdx and (self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER) and not bShowAll) then
                if (i > self.tableSetting.cards_count) then
                    if (bOrbitAni) then
                        cardView.imgCards[i]:loadTexture(self.card_back, ccui.TextureResType.plistType)
			            local orbit1 = cc.OrbitCamera:create(orbitTime, 1, 0, 0, 90, 0, 0)
			            local change = cc.CallFunc:create(function(sender)
				            local value = sender:getTag()
				            sender:loadTexture(string.format("image/card/%02x.png", value), ccui.TextureResType.plistType)
			            end)
			            local orbit2 = cc.OrbitCamera:create(orbitTime, 1, 0, 270, 90, 0, 0)
			            cardView.imgCards[i]:runAction(cc.Sequence:create(orbit1, change, orbit2))
                    else
                        cardView.imgCards[i]:loadTexture(string.format("image/card/%02x.png", v), ccui.TextureResType.plistType)
                    end
                else
                    --亮牌时牌的顺序会变
                    cardView.imgCards[i]:loadTexture(string.format("image/card/%02x.png", v), ccui.TextureResType.plistType)
                end
            else
                if (bOrbitAni) then
                    cardView.imgCards[i]:loadTexture(self.card_back, ccui.TextureResType.plistType)
			        local orbit1 = cc.OrbitCamera:create(orbitTime, 1, 0, 0, 90, 0, 0)
			        local change = cc.CallFunc:create(function(sender)
				        local value = sender:getTag()
				        sender:loadTexture(string.format("image/card/%02x.png", value), ccui.TextureResType.plistType)
			        end)
			        local orbit2 = cc.OrbitCamera:create(orbitTime, 1, 0, 270, 90, 0, 0)
			        cardView.imgCards[i]:runAction(cc.Sequence:create(orbit1, change, orbit2))
                else
                    cardView.imgCards[i]:loadTexture(string.format("image/card/%02x.png", v), ccui.TextureResType.plistType)
                end
            end
		else	-- 显示背面
            cardView.imgCards[i]:loadTexture(self.card_back, ccui.TextureResType.plistType)
		end
		cardView.imgCards[i]:setVisible(true)
        if ((self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER) and (self.roomState == ROOM_STATE.DEAL or self.roomState == ROOM_STATE.LOOT) and i > self.tableSetting.cards_count) then
            --如果是抢庄牛牛且是已发首牌的状态，则是只显示首牌的明牌张数
            cardView.imgCards[i]:setVisible(false)
        end
	end

    cardView.imgNiuRate:setVisible(false)
    local bFull = self:isSeatFull()
	if #cards > 0 and niu_type ~= nil then
        local offY = -45.0
        local posX = 65.0
        if niu_type >= gt.NIU_TYPE.STRAIGHT then
            offY = -30.0
        end
        if (not self.isWait and playerMe~= nil and playerMe.displaySeatIdx == displaySeatIdx) then
            offY = -85.0
            posX = 140.0
            if niu_type >= gt.NIU_TYPE.STRAIGHT then
                offY = -50.0
--                if niu_type == gt.NIU_TYPE.GOURD then
--                    offY = -45.0
--                end
            end
        end
        --如果房间已坐满时你是观战者
        if self.isWait and bFull and displaySeatIdx == 1 then
            offY = -85.0
            posX = 140.0
            if niu_type >= gt.NIU_TYPE.STRAIGHT then
                offY = -50.0
            end
        end
		--cardView.imgNiuType:loadTexture(string.format("image/play/niu/%s.png", gt.NIU_NAME[niu_type+1]), ccui.TextureResType.plistType)

        local pathNiuRate = gt.getNiuRateResPath(self.tableSetting.double_type, niu_type)
        if niu_type == gt.NIU_TYPE.NIU_7 or niu_type == gt.NIU_TYPE.NIU_8 or niu_type == gt.NIU_TYPE.NIU_9 then
--            cardView.imgNiuRate:setScale(1.4)
            posX = 165
            if displaySeatIdx ~= 1 then
                posX = 80
            end
        end
        if (niu_type == gt.NIU_TYPE.WU_XIAO or niu_type >= gt.NIU_TYPE.LONG) then
            --五小牛 一条龙 顺子牛 同花牛 葫芦牛
            if (not self.isWait and playerMe~= nil and playerMe.displaySeatIdx == displaySeatIdx) then
                posX = 210.0
            else
                posX = 90.0
            end
            --如果房间已坐满时你是观战者
            if self.isWait and bFull and displaySeatIdx == 1 then
                posX = 210.0
            end
        end
        cardView.imgNiuRate:setPositionX(posX)
        if (pathNiuRate ~= nil) then
            cardView.imgNiuRate:loadTexture(pathNiuRate, ccui.TextureResType.plistType)
        end

        local skName = ""
		if niu_type == gt.NIU_TYPE.NULL then
			skName = "meiniu"
		elseif niu_type == gt.NIU_TYPE.NIU_NIU then
			skName = "niuniu"
		elseif niu_type == gt.NIU_TYPE.YIN_NIU then
			skName = "yiniu"
        elseif niu_type == gt.NIU_TYPE.JIN_NIU then
			skName = "jinniu"
        elseif niu_type == gt.NIU_TYPE.WU_XIAO then
			skName = "5xiaoniu"
		elseif niu_type == gt.NIU_TYPE.BOMB then
			skName = "zhandanniu"
        elseif niu_type == gt.NIU_TYPE.LONG then
            skName = "yitiaolong"
        elseif niu_type == gt.NIU_TYPE.STRAIGHT then
            skName = "shunziniu"
        elseif niu_type == gt.NIU_TYPE.FLUSH then
            skName = "tonghuaniu"
        elseif niu_type == gt.NIU_TYPE.GOURD then
            skName = "huluniu"
        elseif niu_type == gt.NIU_TYPE.STRAIGHT_FLUSH then
            skName = "tonghuashun"
        elseif niu_type == gt.NIU_TYPE.NIU_1 then
            skName = "niu1"
        elseif niu_type == gt.NIU_TYPE.NIU_2 then
            skName = "niu2"
        elseif niu_type == gt.NIU_TYPE.NIU_3 then
            skName = "niu3"
        elseif niu_type == gt.NIU_TYPE.NIU_4 then
            skName = "niu4"
        elseif niu_type == gt.NIU_TYPE.NIU_5 then
            skName = "niu5"
        elseif niu_type == gt.NIU_TYPE.NIU_6 then
            skName = "niu6"
        elseif niu_type == gt.NIU_TYPE.NIU_7 then
            skName = "niu7"
        elseif niu_type == gt.NIU_TYPE.NIU_8 then
            skName = "niu8"
        elseif niu_type == gt.NIU_TYPE.NIU_9 then
            skName = "niu9"
		end
		local function call_back(sender)
            local path = "man/niu"
            if sex == 2 then
                --女声
                path = "woman/niu"
            end
            if niu_type == gt.NIU_TYPE.STRAIGHT_FLUSH then
                gt.soundEngine:playEffect("common/tonghuashun_bg", false)
            end
			gt.soundEngine:playEffect(path .. niu_type, false)

			if skName ~= "" then
				local sk = sp.SkeletonAnimation:create("image/play/effect/"..skName..".json", "image/play/effect/"..skName..".atlas")
				sk:setAnimation(0, "animation", false)
                if niu_type == gt.NIU_TYPE.BOMB then
                    sk:setAnimation(0, "zhadan", false)
                end
                for i = 1, 9 do
                    if skName == "niu"..i then
                        sk:setScale(1.5)
                    end
                end
				if displaySeatIdx ~= 1 then
					sk:setScale(0.42)
                    for i = 1, 9 do
                        if skName == "niu"..i then
                            sk:setScale(0.7)
                        end
                    end
				end
                sk:setPositionY(offY)
--				sk:registerSpineEventHandler(function (event)
--						sk:runAction(cc.RemoveSelf:create())
--					end, sp.EventType.ANIMATION_END)
				cardView.effectNode:removeAllChildren()
				cardView.effectNode:addChild(sk)
			end
		end

        local function call_back2(sender)
--            cardView.imgNiuType:setVisible(true)
            if (pathNiuRate ~= nil) then
                cardView.imgNiuRate:setVisible(true)
            end
        end

        local niuEffectTime = 0
        if (skName ~= "") then
            niuEffectTime = 0.5
        end
	end
	cardView.imgScore:setVisible(false)

end

--玩家准备回调
function PlaySceneSSS:onRcvReady(msgTbl)
	local seatIdx = msgTbl.seat + 1
	self:playerGetReady(seatIdx)

    local seatNum = gt.getTableSize(self.roomPlayers)
    if (self.isWait and seatNum >= self.roomChairs) then

        self.readyBtn:setVisible(false)
        self.Btn_ShowResult:setVisible(false)
        if self:getChildByName("GameBrief") then
			self:removeChildByName("GameBrief")
		end
    end
	if self.roomPlayers[seatIdx].uid == gt.playerData.uid then
		if self.isMatch and self.IsNewGame then
			self.IsNewGame=false
			self.Btn_ViewFinalReport:setVisible(false)
			self.readyBtn:setPositionX(0)
			self.readyBtn:setContentSize(226,82)
			self.readyBtn:loadTextureNormal("image/play/btn_ready.png")
		end
	end

  --  self:onRcvDealCard(msgTbl)

end

--玩家暂停回调
function PlaySceneSSS:onRcvPause(msgTbl)
	local seatIdx = msgTbl.seat + 1
	local roomPlayer = self.roomPlayers[seatIdx]
    roomPlayer.state = PLAYER_STATE.PAUSE
	roomPlayer.isWait = true
	if seatIdx == self.playerSeatIdx then
		self.isWait = true
	end
end

--玩家预准备等待回调 此时是占了座位观战者
function PlaySceneSSS:onRcvReadyWait(msgTbl)
    local seatIdx = msgTbl.seat + 1
    local roomPlayer = self.roomPlayers[seatIdx]
    roomPlayer.state = PLAYER_STATE.READY_WAIT
    local readySignSpr = self.readySigns[roomPlayer.displaySeatIdx]
	readySignSpr:setVisible(true)
	-- 玩家本身
	if seatIdx == self.playerSeatIdx then
        self.chatBtn:setVisible(true)
        self.yuyinBtn:setVisible(true)
--        local lbReady = gt.seekNodeByName(self.readyBtn, "lblReady")
--        lbReady:setString("准  备")
        self.readyBtn:loadTextureNormal("image/play/btn_ready.png")
    end

    local seatNum = gt.getTableSize(self.roomPlayers)
    if (self.isWait and seatNum >= self.roomChairs) then
        self.readyBtn:setVisible(false)
        self.Btn_ShowResult:setVisible(false)
        if self:getChildByName("GameBrief") then
			self:removeChildByName("GameBrief")
		end
    end
end

-- 准备晚了，座位被占了回调
function PlaySceneSSS:onRcvReadyLate()
    require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, gt.LocationStrings.LTKey_0064, nil, nil, true)
end




-- 提示开始
function PlaySceneSSS:onRcvPromptStart(msgTbl)
	self.roomState = ROOM_STATE.READY

	if msgTbl.flag == 0 then
        self.waitType = nil
        self.bgWaitingTip:setVisible(false)
        if (not self.isWait) then
		    self.startBtn:setVisible(true)
        end
	else
		self.startBtn:setVisible(false)
	end
end

-- 开始游戏回调
function PlaySceneSSS:onRcvStart(msgTbl)
    if msgTbl.code == 0 then
		self.IsNewGame=false
		self.Btn_ViewFinalReport:setVisible(false)
		self.readyBtn:setPositionX(0)
		self.readyBtn:setContentSize(226,82)
		self.readyBtn:loadTextureNormal("image/play/btn_ready.png")

        self:hideNiuTypeActions()
        self:hideSigns()
        self:resetCardSigns()
        self.roomState = ROOM_STATE.START
        self.startBtn:setVisible(false)
        if (not self.isWait) then
            self.inviteFriendBtn:setVisible(false)
        end
    elseif msgTbl.code == 1 then
        --还有其他玩家未准备
        self.startBtn:setVisible(true)
        require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, gt.LocationStrings.LTKey_0055, nil, nil, true)
    elseif msgTbl.code == 2 then
        --人数不够，无法开始游戏
        self.startBtn:setVisible(true)
        require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, gt.LocationStrings.LTKey_0056, nil, nil, true)
    elseif msgTbl.code == 3 then
        --AA付费至少6人才可开始游戏
        self.startBtn:setVisible(true)
        require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, gt.LocationStrings.LTKey_0061, nil, nil, true)
    end
end

function PlaySceneSSS:dealCard(msgTbl,isReConnect)
--    isReConnect = isReConnect or false
--      msgTbl = {

--    ["self_cards"]={[1]=0x0a, [2]=0x0b, [3]=0x0c ,[4]=0x0d ,[5]=0x0e ,[6]=0x01 ,[7]=0x02 ,[8]=0x02 ,[9]=0x02 ,[10]=0x02 ,[11]=0x02 ,[12]=0x02 ,[13]=0x02 }, 
--    ["cmd"]=267, ["res_type"]=0 ,["other_cards"]={[1]=0, [2]=0 ,[3]=0, [4]=0, [5]=0 } }

--     math.randomseed(tostring(os.time()):reverse():sub(1, 7))
--  --   local tt = {2,3,4,3,4,5,6,7,7,8,9,10,11}
--    -- local tt = {1,2,3,4,5,6,7,8,9,10,11,12,13}
--     local tt = {0x11,0x2d,0x2c,0x1c,0x2b,0x39,0x08,0x27,0x15,0x05,0x07,0x14,0x33}
--     for i = 1,13 do 
--        msgTbl.self_cards[i] = {}
--      --  msgTbl.self_cards[i] =  math.random(1,13)+ 16*math.random(0,3)
--        msgTbl.self_cards[i] = tt[i]
--        print("--> k="..i.." v="..msgTbl.self_cards[i])

--     end

    if self:getChildByName("GameBrief") then
		self:removeChildByName("GameBrief")
	end
    
    self.lipaiTime = msgTbl.wait_time or 60

    local playNode = gt.seekNodeByName(self.rootNode, "Node_play")
        local cardView = self.cardViews[1]
        local cardPar = cardView.imgCards[1]:getParent()
        cardPar:setVisible(self.playerSeatIdx ~= -1) 
        gt.switchParentNode(cardPar,playNode)

        cardPar:setPositionY(self.selfCardParNodePosY)
        cardPar:setPositionX(self.selfCardParNodePosX)

        gt.removeCocosEventListener(self,self.freeLipaiListener)
         
        
         
        self.rootNode:removeChildByName("lipai")
        self.lipaiIsClose = true

    local tempCards = sszCardTools.copyTable(msgTbl.self_cards)

    for k,v in pairs(self.cardViews) do
    	for i=1,3 do
    		if v.node:getChildByName("kuang_"..i) then
    			v.node:removeChildByName("kuang_" .. i, true)
    		end
    	end
    end

     -- for k,v in pairs(self.roomPlayers) do
       
     --         local cardView = self.cardViews[v.displaySeatIdx]
     --         if cardView then
     --         for i = 1,3 do
     --        print("k="..k.."i="..i)
     --          if  cardView.node:getChildByName("kuang_"..i) then
     --               cardView.node:getChildByName("kuang_"..i):removeFromParent()
     --          end
     --         end
         
     --         end
         
     -- end

     
    if self.playerSeatIdx ~= -1 and msgTbl.self_cards~=0 and #msgTbl.self_cards ~= 0 then
         sszCardTools:setA_14to1(msgTbl.self_cards)
         sszCardTools:keepIndexs(msgTbl.self_cards)

         sszCardTools:CardSortFun(msgTbl.self_cards)
         self.readyBtn:setVisible(false)
         self.Btn_ShowResult:setVisible(false)
        if self:getChildByName("GameBrief") then
			self:removeChildByName("GameBrief")
		end
       -- local tduizi = sszCardTools:getShunZi(msgTbl.self_cards)

            dump(msgTbl.self_cards,"手牌")
           self.specialCards = {}
          --  local ttt  = sszCardTools:getTieZi(msgTbl.self_cards)
       
          self.paixingCards,self.paixingText,self.paixingIndex = sszCardTools:getAllCardType(msgTbl.self_cards,self.wafaTouJin)
          self.specialSortResult ,self.specialCards =   GameLogic:GetSpecialType(msgTbl.self_cards,13)
             self.freeCardTypes = sszCardTools:getTypes(msgTbl.self_cards,1,11,self.wafaTouJin)
          self.selectSpecialType = self.specialSortResult
    
      if self.specialSortResult == 120 then
            for k,v in pairs(self.paixingIndex) do
                if v[1] == 80 and v[2] == 80 and v[3] == 40 then
               --     self.specialCards = self.paixingCards[k]
                    table.remove(self.paixingCards,k)
                    table.remove(self.paixingText,k)
                    table.remove(self.paixingIndex,k)
                    break
                end
            end

           self.specialCards = sszCardTools:getSanTongHuaShun( sszCardTools.copyTable(msgTbl.self_cards)  )
            
      elseif   self.specialSortResult ~=5 and self.specialCards and self.specialCards[1][1] == 0 then

        
            self.specialCards  = self.paixingCards[1]  
      elseif   self.specialSortResult ==5   then 

           local bres,tres  = sszCardTools:getliuduiban(sszCardTools.copyTable(msgTbl.self_cards))     
           if bres then
            self.specialCards = tres
            self.specialSortResult = 20
           end

      end

       local specialtypeKey = {170,160,120,110,90,20,11,10}

        for i =1 ,8 do
             if self.wafaSpecialType[i]  == false and self.specialSortResult == specialtypeKey[i] then
                           self.specialSortResult = GameLogic.CT_EX_INVALID
                           self.specialCards = nil
             end
        end
      
    -- self.scheComCard_id = gt.scheduler:scheduleScriptFunc(handler(self, self.ComparisonCard), 3, false)
  end  
	
    self.waitType = nil
    self.bgWaitingTip:setVisible(false)
	self:hidePlayersReadySign()
	self:clearNiuEffect()
    self:resetCardsPos()
    self.roomState = ROOM_STATE.DEAL

	if self.tableSetting.IsReplay then
		for i = 1,self.roomChairs do
			if self.roomPlayers[i] and not self.roomPlayers[i].isWait then
				self.roomPlayers[i].state = PLAYER_STATE.DEAL
				if self.roomPlayers[i].uid == msgTbl.player then
					self.roomPlayers[i].cards_in_hand = msgTbl.self_cards
					self.roomPlayers[i].niu_type = msgTbl.res_type
				end
			end
		end
		if not msgTbl.GOGOGO then
			return
		end 
	else
		for i = 1,self.roomChairs do
			if self.roomPlayers[i] and not self.roomPlayers[i].isWait then
				self.roomPlayers[i].state = PLAYER_STATE.DEAL
				if self.roomPlayers[i].seatIdx == self.playerSeatIdx then
					self.roomPlayers[i].cards_in_hand = msgTbl.self_cards
					self.roomPlayers[i].niu_type = msgTbl.res_type
					--非录像模式  避免录像下上面写好的数据被覆盖
				elseif not self.tableSetting.IsReplay then
					self.roomPlayers[i].cards_in_hand = msgTbl.other_cards
				end
				--table.insert(roomPlayers, self.roomPlayers[i])
			end
		end
	end

        
      

          for k, v in pairs(self.roomPlayers) do
			if not v.isWait then
				local cardView = self.cardViews[v.displaySeatIdx]
				cardView.node:setVisible(true)
--				if cardView.node:getChildByTag(9999) then
--					cardView.node:removeChildByTag(9999)
--				end
				cardView.imgNiuRate:setVisible(false)
				cardView.imgScore:setVisible(false)

                local special_zi =  cardView.imgCards[1]:getParent():getChildByName("special_zi")
                if special_zi then
                    special_zi:setVisible(false)
                end


               
               
    	       for m = 1, cardNum do
                    self:getOrignalCardData(cardView.imgCards[m],m,v.displaySeatIdx)
                    cardView.imgCards[m]:setVisible(isReConnect)
					if (self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER) or self.tableSetting.IsReplay then
						if not self.isWait and m <= cardNum and v.seatIdx == self.playerSeatIdx then
							local playerMe = self.roomPlayers[self.playerSeatIdx]
							if playerMe~= nil then
                                print(string.format("image/card/%02x.png", playerMe.cards_in_hand[m]))
--								cardView.imgCards[m]:loadTexture(string.format("image/card/%02x.png", playerMe.cards_in_hand[m]), ccui.TextureResType.plistType)
                                cardView.imgCards[m]:loadTexture(self.card_back, ccui.TextureResType.plistType)
                                cardView.imgCards[m]:setTag(playerMe.cards_in_hand[m])
                                self:removeMaPai(cardView.imgCards[m])
							end
						elseif self.tableSetting.IsReplay then
							local player = self.roomPlayers[v.seatIdx]
							if player~= nil then
--								cardView.imgCards[m]:loadTexture(string.format("image/card/%02x.png", player.cards_in_hand[m]), ccui.TextureResType.plistType)
                            cardView.imgCards[m]:loadTexture(self.card_back, ccui.TextureResType.plistType)
                            self:removeMaPai(cardView.imgCards[m])
							end
						else
							cardView.imgCards[m]:loadTexture(self.card_back, ccui.TextureResType.plistType)
                            self:removeMaPai(cardView.imgCards[m])
						end
					else
						cardView.imgCards[m]:loadTexture(self.card_back, ccui.TextureResType.plistType)
                        self:removeMaPai(cardView.imgCards[m])
					end
				end
        else
            local cardView = self.cardViews[v.displaySeatIdx]
				cardView.node:setVisible(false)
        end
    end



	-- 发牌动画
	
	for j = 1, cardNum do
		for k, v in pairs(self.roomPlayers) do
			if not v.isWait then

                if  isReConnect == false then
				    local scale = 0.5
				    if v.displaySeatIdx == 1 then
					    scale = 1
				    end
                    local cardView = self.cardViews[v.displaySeatIdx]

				    local pos = cc.pAdd(cc.p(cardView.node:getPosition()), cc.p(cardView.imgCards[j]:getPosition()))
				    local sp = cc.Sprite:createWithSpriteFrameName(self.card_back)
				    sp:setPosition(0, 0)
				    --sp:setTag(i*5+j)
				    sp:setScale(scale*0.8)
				    playNode:addChild(sp)
				    local moveTime = 0.2
				    local delayTime = (j-1)*(moveTime/2) --((j-1)*playCount+k)*moveTime
				    local callFun = function ()
					    if (v.seatIdx == self.playerSeatIdx) then
						    gt.soundEngine:playEffect("common/fa_pai", false)
					    end
				    end
				    local moveTo = cc.Spawn:create(cc.CallFunc:create(callFun), cc.MoveTo:create(moveTime, pos), cc.ScaleTo:create(moveTime, scale), cc.FadeOut:create(moveTime))
				    sp:runAction(cc.Sequence:create(cc.Hide:create(), cc.DelayTime:create(delayTime), cc.Show:create(), moveTo, cc.RemoveSelf:create()))
				    
                    if v.displaySeatIdx == 1 and j == cardNum  then
                        local m_callfun = function (sender)
                            self:lipai()
end
					    cardView.imgCards[j]:runAction(cc.Sequence:create(cc.DelayTime:create(delayTime+moveTime), cc.Show:create(),cc.CallFunc:create(m_callfun)))
                    else
                     
                         cardView.imgCards[j]:runAction(cc.Sequence:create(cc.DelayTime:create(delayTime+moveTime), cc.Show:create()))    
				    end
                end
			end
		end
	end

    if (not self.isWait) then
        local baseDelayTime = 1.2
        if self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER then

        else
            -- 显示翻牌
            local callfunc = function()
                --self:openCardBtnClickEvt()
                self.openCardBtn:setVisible(true)

                self.waitType = WAIT_TYPE.SHOW_CARD

            end
	        self.openCardBtn:runAction(cc.Sequence:create(cc.DelayTime:create(baseDelayTime), cc.CallFunc:create(callfunc)))
        end
    else
        if self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER then
            --显示选择倍数等待时间
            self.waitType = WAIT_TYPE.LOOT

        else
            self.waitType = WAIT_TYPE.SHOW_CARD

        end
    end

    if isReConnect == true and msgTbl.is_sorted == false then
        self:lipai()
    elseif isReConnect == true and msgTbl.is_sorted == true then
    	local playNode = gt.seekNodeByName(self.rootNode, "Node_play")
	    local cardView = self.cardViews[1]
	    local cardPar = cardView.imgCards[1]:getParent()
	    cardPar:setVisible(true)
	    gt.switchParentNode(cardPar, playNode)
	    self:setCardsToComparisonState(1)

	    sszCardTools:setA_14to1(tempCards)
	    dump(msgTbl)
	    for m = 1, cardNum  do
	        if cardView.imgCards[m] then
	            cardView.imgCards[m]:loadTexture(string.format("image/card/%02x.png", tempCards[cardNum - m + 1]), ccui.TextureResType.plistType)
	            self:setMaPai(cardView.imgCards[m], tempCards[cardNum - m + 1])
	        end      
	    end

		cardPar:setPositionY(self.selfCardParNodePosY)
		cardPar:setPositionX(self.selfCardParNodePosX)

	  	gt.removeCocosEventListener(self,self.freeLipaiListener)
    end
end


--整牌
function PlaySceneSSS:onRcvSortCard(msgTbl)
    print("bigoo bigoo bigoo bigoo",msgTbl.seat+1)
    if self.roomPlayers[msgTbl.seat+1] then
    	local displaySeatIdx = self.roomPlayers[msgTbl.seat+1].displaySeatIdx
    	self:setCardsToComparisonState(displaySeatIdx,true)
    end
end
-- 发牌
function PlaySceneSSS:onRcvDealCard(msgTbl,isReConnect)
    isReConnect = isReConnect or false
    
   if isReConnect == false then
         ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("games/SSS/NewAnimation/NewAnimation1.ExportJson")
	    local ar = ccs.Armature:create("NewAnimation1")
        ar:setPosition(display.cx,display.cy)
        ar:getAnimation():play("kaishi")
        ar:getAnimation():setMovementEventCallFunc(function (armature, movementType, movementID)
             if movementType ==1 then
                if armature then
                    armature:removeFromParentAndCleanup(true)
                end
                self:dealCard(msgTbl,isReConnect)
             end
end)
        self:addChild(ar)
    else
        self:dealCard(msgTbl,isReConnect)
    end

end

function PlaySceneSSS:lipai(dt)
  	if self.rootNode:getChildByName("lipai") then
		self.rootNode:removeChildByName("lipai")
		self.lipaiIsClose = true
	end
	local playerMe = self.roomPlayers[self.playerSeatIdx]
	-- local cardView = self.cardViews[playerMe.displaySeatIdx]
	if playerMe == nil then
		return
	end

  if self.schelipai_id then
    gt.scheduler:unscheduleScriptEntry(self.schelipai_id)
    self.schelipai_id = nil
   end 
   gt.soundEngine:playEffect("SSS/"..self.sexStr.."/start_poker", false)

   self.lipaiIsClose = false
    local csbName = "games/SSS/csb/lipai_SSS.csb"
     

	local csbNode = cc.CSLoader:createNode(csbName)
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(display.cx,display.height*1.5)
    csbNode:setName("lipai")
	self.rootNode:addChild(csbNode)

    csbNode:runAction(cc.EaseSineIn:create(cc.MoveTo:create(0.2,cc.p(display.cx,display.cy))))

    self.tlipaiUi = {}

    for m = 1, cardNum do           
		local playerMe = self.roomPlayers[self.playerSeatIdx]
        local cardView = self.cardViews[playerMe.displaySeatIdx]
		if playerMe~= nil and playerMe.cards_in_hand ~= nil and #playerMe.cards_in_hand > 0 then              
				cardView.imgCards[m]:loadTexture(string.format("image/card/%02x.png", playerMe.cards_in_hand[m]), ccui.TextureResType.plistType)
                self:setMaPai(cardView.imgCards[m],playerMe.cards_in_hand[m])
                                                --cardView.imgCards[m]:setTag(playerMe.cards_in_hand[m])
		end        
    end


    local nodeName = {"cards_node","paixingkuang","paixingkuang_listView","paixingbg_1","paixingbg_2","Button_switch",
    "Button_chupai","clockText","special_bts","bt_spe_1","bt_spe_2","dun_touch1","dun_touch2","dun_touch3","clockbg"
    ,"bt_spe_3","bt_spe_4","bt_spe_5","bt_spe_6","bt_spe_7","bt_spe_8","bt_spe_9","Button_cancel","Button_special","daoshui_text","daoshui_bg"}

	for k,v in pairs(nodeName) do
    	self.tlipaiUi[v]= gt.seekNodeByName(csbNode, v)       
    end
    self.tlipaiUi.clockText:setString(self.lipaiTime)
    self.tlipaiUi.Button_chupai:setPressedActionEnabled(false)
    self.tlipaiUi.Button_switch:setPressedActionEnabled(false)
    self.tlipaiUi.Button_cancel:setPressedActionEnabled(false)
    self.tlipaiUi.Button_special:setPressedActionEnabled(false)
    self.tlipaiUi.daoshui_bg:setOpacity(0)

    if self.stopWatchScheId then
        gt.scheduler:unscheduleScriptEntry(self.stopWatchScheId)
        self.stopWatchScheId = nil
    end

    
    
    self.bgWaitingTip:setVisible(true)
  self.stopWatchScheId  =  gt.stopWatch(self.lipaiTime,function (time)
    print("等待理牌..."..time.."s")

    if time<=5 then
        gt.soundEngine:playEffect("SSS/time_warning", false) 
    end
    
    self.lbWatingTip:setString("等待理牌..."..time.."s")
    self.lbWatingTip:setVisible(true)
    if self.lipaiIsClose == false  then
        if self.tlipaiUi.clockText then
            self.tlipaiUi.clockText:setString(time)
        end
     return true
    else
      return false
    end
end)
       
        
  local  function btSenderCallback (sender) 
        gt.soundEngine:playEffect(gt.clickBtnAudio, false)
        local msgToSend = {}
           msgToSend.cmd = 0x1021
         
          msgToSend.special_type = self.selectSpecialType

          msgToSend.indexs = {}
          local paixingbg = nil

          if self.tlipaiUi.paixingbg_1:isVisible() then
                paixingbg = self.tlipaiUi.paixingbg_1
          else
                paixingbg = self.tlipaiUi.paixingbg_2
          end

          local paiCheck = {}
          for i=1,2 do
              paiCheck[i] = {}
              for j=1,5 do
                    paiCheck[i][j] = gt.seekNodeByName(paixingbg,"card"..i.."_"..j):getTag()
              end
          end
          
          paiCheck[3] = {}
          for j=1,3 do
              paiCheck[3][j] = gt.seekNodeByName(paixingbg,"card3_"..j):getTag()
          end

          -- if self.wafaDaoShuiFaFen == false then
          if true then
                   local daoShuiRes =  sszCardTools:checkDaoShui(paiCheck ,(self.tableSetting.compare_type and self.tableSetting.compare_type == 1), false) 
                    if  daoShuiRes ~= 0 and self.selectSpecialSortResult == GameLogic.CT_EX_INVALID  then
                     --   gt.showLoadingTips("倒水啦！")
                     local str = nil
                     if daoShuiRes == 1 then
                        str =[[摆牌错误，当前摆牌"尾道"小于"中道"]] 
                     elseif   daoShuiRes == 2 then 
                        str =[[摆牌错误，当前摆牌"中道"小于"头道"]]
                     end
                     self.tlipaiUi.daoshui_text:setString(str)
                     self.tlipaiUi.daoshui_bg:setOpacity(255)
                     self.tlipaiUi.daoshui_bg:setPosition(display.width*0.50,display.height*0.59)
                    gt.delayRun(1.0,function (dt)
                     self.tlipaiUi.daoshui_bg:runAction(cc.FadeOut:create(1))
                     self.tlipaiUi.daoshui_bg:runAction(cc.MoveBy:create(1, cc.p(0, 50)))
                    end)
             
                        return 
                    end
            end
           local tempTable = {}
          for j= 1,3 do --插头道
            table.insert(tempTable,gt.seekNodeByName(paixingbg,"card3_"..j)
                    :getTag())
             
          end
          sszCardTools:CardSortFun(tempTable)
          sszCardTools.tableCombin(msgToSend.indexs,tempTable)
          tempTable = {}
          for j = 1,5 do --插中道
            table.insert(tempTable,gt.seekNodeByName(paixingbg,"card2".."_"..j)
                    :getTag())   
          end        
          sszCardTools:CardSortFun(tempTable)
          sszCardTools.tableCombin(msgToSend.indexs,tempTable)
          tempTable = {}
          for j = 1,5 do --插尾道
            table.insert(tempTable,gt.seekNodeByName(paixingbg,"card1".."_"..j)
                    :getTag())   
          end
          sszCardTools:CardSortFun(tempTable)
          sszCardTools.tableCombin(msgToSend.indexs,tempTable)

          sszCardTools:setA_14to1(msgToSend.indexs)
        --  msgToSend.indexs = sszCardTools.reverseTable(sszCardTools:getCIndexs(msgToSend.indexs))
          msgToSend.indexs = sszCardTools:getCIndexs(msgToSend.indexs)
          dump(msgToSend,"出牌")
          gt.socketClient:sendMessage(msgToSend)

          
        local playNode = gt.seekNodeByName(self.rootNode, "Node_play")
        local cardView = self.cardViews[1]
        local cardPar = cardView.imgCards[1]:getParent()
        cardPar:setVisible(true)
        gt.switchParentNode(cardPar,playNode)
        self:setCardsToComparisonState(1)

        

        for m = 1, cardNum  do
            if cardView.imgCards[m] then
                cardView.imgCards[m]:loadTexture(self.card_back, ccui.TextureResType.plistType)
             --   self:getOrignalCardData(cardView.imgCards[m],m,1)          
             --   self:getOrignalCardData(cardView.imgCards[m],m,1)
            end      
        end

        cardPar:setPositionY(self.selfCardParNodePosY)
        cardPar:setPositionX(self.selfCardParNodePosX)

          gt.removeCocosEventListener(self,self.freeLipaiListener)

          

--        gt.switchParentNode(self.tlipaiUi.clockbg,self.rootNode)
--        self.tlipaiUi.clockbg:setPositionX(display.cx)
--        self.tlipaiUi.clockbg:setPositionY(display.cy) 
           csbNode:runAction(
           cc.Sequence:create(
           cc.EaseSineOut:create(cc.MoveTo:create(0.2,cc.p(display.cx,display.height*1.5))),
          cc.CallFunc:create(
            function ()
                    csbNode:removeFromParent()
            end
          )
           )       
           )             
          
          self.tlipaiUi.clockText = nil
--          self.lipaiIsClose = true
          
end

      self.tlipaiUi.Button_chupai:addClickEventListener(btSenderCallback)

      self:autoLiPai(csbNode,true)
      self:freeLiPai(csbNode,true,btSenderCallback)
      self:freeLiPai(csbNode,false,btSenderCallback)

      self.tlipaiUi.Button_switch:setVisible(true)
      self.tlipaiUi.Button_switch:addClickEventListener(
          function (sender)
            gt.soundEngine:playEffect(gt.clickBtnAudio, false)
            if self.tlipaiUi.paixingbg_1:isVisible() then
               self:freeLiPai(csbNode,false,btSenderCallback)
            else
                 self:autoLiPai(csbNode)
            end
          end
      )
    
end

function PlaySceneSSS:autoLiPai(csbNode,isInit)
     
     self.tlipaiUi.Button_chupai:setVisible(true)
     self.tlipaiUi.Button_chupai:setTouchEnabled(true)
     self.tlipaiUi.Button_chupai:setPositionX(1180.23)  
     
     
    self.tlipaiUi.paixingkuang_listView:setVisible(true)
    self.tlipaiUi.paixingbg_2:setVisible(false)
    self.tlipaiUi.paixingbg_1:setVisible(true)
    self.tlipaiUi.special_bts:setVisible(false)
    self.tlipaiUi.Button_cancel:setVisible(false)
    self.tlipaiUi.Button_special:setVisible(false)
    self.tlipaiUi.Button_switch:getChildByName("Text_1"):setString("手动配牌")

    gt.switchParentNode(self.tlipaiUi.clockbg,self.tlipaiUi.paixingbg_1)
    local clock_pos = self.tlipaiUi.paixingbg_1:getChildByName("clock_pos")
    self.tlipaiUi.clockbg:setPositionX(clock_pos:getPositionX())
    self.tlipaiUi.clockbg:setPositionY(clock_pos:getPositionY())
    
    local cardView = self.cardViews[1]
    local cardPar = cardView.imgCards[1]:getParent()
    cardPar:setVisible(false)
    self.selectSpecialSortResult = self.autoLiPaiSpecailSelect
    isInit = isInit or false
    if  isInit == false then
    	if self.specialSortResult ~= GameLogic.CT_EX_INVALID then
    	 	self.selectSpecialType = self.specialSortResult
    	 end 
    	return 
    end

    local playNode = gt.seekNodeByName(self.rootNode, "Node_play")
    gt.switchParentNode(cardPar,playNode)


   cardPar:setPositionY(self.selfCardParNodePosY)
   cardPar:setPositionX(self.selfCardParNodePosX)

    for m = 1, cardNum do
          self:getOrignalCardData(cardView.imgCards[m],m,1)
    end


        local jiaohuanpai_contain = {}   
    local firstPaixingCards   = {}
    dump(self.specialSortResult)
    dump(self.specialCards)
     if self.specialSortResult ~= GameLogic.CT_EX_INVALID then
       if self.specialCards[1][4] == 0 then
            firstPaixingCards = sszCardTools.reverseTable(self.specialCards)
            self.specialCards = firstPaixingCards
            firstPaixingCards[3][4] = nil
            firstPaixingCards[3][5] = nil
       else
            firstPaixingCards = self.specialCards
       end
        
        local flag = true

        for i = 1 , 3  do
          flag =   sszCardTools.cardsCompares(firstPaixingCards[i],self.paixingCards[1][i])
          if flag == false then
            break
          end
        end

        if flag then
            self.paixingCards[1] = nil
            self.paixingText[1] = nil
        end

     else
        firstPaixingCards = self.paixingCards[1]
     end 


    for k1,v1 in pairs(firstPaixingCards) do
         for k2,v2 in pairs(v1) do
            if v2 ~= 0 then
                    local card  = self.tlipaiUi.paixingbg_1:getChildByName("card"..k1.."_"..k2)
                    card:loadTexture(string.format("image/card/%02x.png", v2), ccui.TextureResType.plistType)
                    self:setMaPai(card,v2)
                    card:setTouchEnabled(true)
                    card:setTag(v2)
                    card:addClickEventListener(function (sender)      
                    gt.soundEngine:playEffect(gt.clickBtnAudio, false)
                    table.insert(jiaohuanpai_contain,sender)
                    local temp_tag = nil
                    local temp_name = nil
                    sender:setScale(1.1)
                  if #jiaohuanpai_contain >= 2 then
                    jiaohuanpai_contain[1]:setScale(1.0)
                    jiaohuanpai_contain[2]:setScale(1.0)
                    jiaohuanpai_contain[1]:runAction(cc.MoveTo:create(0.1,cc.p(jiaohuanpai_contain[2]:getPositionX(),jiaohuanpai_contain[2]:getPositionY())))
                    jiaohuanpai_contain[2]:runAction(cc.MoveTo:create(0.1,cc.p(jiaohuanpai_contain[1]:getPositionX(),jiaohuanpai_contain[1]:getPositionY())))  
--                    temp_tag = jiaohuanpai_contain[1]:getTag()
--                    jiaohuanpai_contain[1]:setTag(jiaohuanpai_contain[2]:getTag()) 
--                    jiaohuanpai_contain[2]:setTag(temp_tag)
                    temp_name = jiaohuanpai_contain[1]:getName()
                    jiaohuanpai_contain[1]:setName(jiaohuanpai_contain[2]:getName()) 
                    jiaohuanpai_contain[2]:setName(temp_name)

                    sszCardTools.tableClear(jiaohuanpai_contain) 
                 end

end)
            end
         end
    end


    local lastTouchpaixingkuang = nil
    local selectPaixingIndex = 0
    if self.specialSortResult ~= GameLogic.CT_EX_INVALID then
       local paixingkuangName = self.tlipaiUi.paixingkuang:clone()
        self.tlipaiUi.paixingkuang_listView:pushBackCustomItem(paixingkuangName)
      --  gt.MyShader.setNodeDarken(paixingkuangName)
        paixingkuangName:getChildByName("light"):setVisible(false)

       local paixing_text1  = paixingkuangName:getChildByName("paixin_text1")
        paixing_text1:setString("+"..sszCardTools:getspecailKeyToScore(self.specialSortResult).."分")
       paixing_text1:setColor(cc.c3b(0,200,0)) 
       paixing_text1:setFontName("font/main.ttf")


        local paixing_text2  = paixingkuangName:getChildByName("paixin_text2")
        paixing_text2:setString(sszCardTools:getspecailKeyToString(self.specialSortResult)) 
        paixing_text2:setColor(cc.c3b(255,102,0)) 

       local paixing_text3  =  paixingkuangName:getChildByName("paixin_text3")
        paixing_text3:setString("")  
      

        paixingkuangName:loadTexture("games/SSS/paixingkuang_sp.png")



         paixingkuangName:addClickEventListener(function (sender)     
            gt.soundEngine:playEffect(gt.clickBtnAudio, false)
            if lastTouchpaixingkuang and lastTouchpaixingkuang ~= sender then
            --    gt.MyShader.setNodeDarken(lastTouchpaixingkuang)
                 lastTouchpaixingkuang:getChildByName("light"):setVisible(false)
                 self.autoLiPaiSpecailSelect = self.specialSortResult
                 self.selectSpecialSortResult = self.autoLiPaiSpecailSelect
                 self.selectSpecialType = self.specialSortResult
               -- gt.MyShader.setNodeRestore(sender)
               sender:getChildByName("light"):setVisible(true)
                 for k1,v1 in pairs( self.specialCards) do
                     for k2,v2 in pairs(v1) do
                        local card = self.tlipaiUi.paixingbg_1:getChildByName("card"..k1.."_"..k2)
                        if card then
                            card:loadTexture(string.format("image/card/%02x.png", v2), ccui.TextureResType.plistType)
                            self:setMaPai(card,v2)
                            card:setTag(v2)
                        end
                     end
                end
            end
            

            lastTouchpaixingkuang = sender
            selectPaixingIndex = 0
        end)

        lastTouchpaixingkuang = paixingkuangName
        --gt.MyShader.setNodeRestore(paixingkuangName)
        self.autoLiPaiSpecailSelect = self.specialSortResult
        self.selectSpecialSortResult = self.autoLiPaiSpecailSelect
        self.selectSpecialType = self.specialSortResult
        dump(self.selectSpecialType)
        dump(self.specialSortResult)
        paixingkuangName:getChildByName("light"):setVisible(true)  

    end
    
    

    local paixingkuangName = {}
    for k,v in pairs(self.paixingText) do
           paixingkuangName[k] = self.tlipaiUi.paixingkuang:clone()
         --  gt.MyShader.setNodeDarken(paixingkuangName[k])
         paixingkuangName[k]:getChildByName("light"):setVisible(false)
           self.tlipaiUi.paixingkuang_listView:pushBackCustomItem(paixingkuangName[k])
           v[1] = v[1] or "乌龙"
           paixingkuangName[k]:getChildByName("paixin_text1"):setString(v[1])  
           if self.paixingIndex[k][1] and self.paixingIndex[k][1] >= 60 then
             paixingkuangName[k]:getChildByName("paixin_text1"):setColor(cc.c3b(0,200,0))
           end
           v[2] = v[2] or "乌龙"
           paixingkuangName[k]:getChildByName("paixin_text2"):setString(v[2])  
           if self.paixingIndex[k][2] and self.paixingIndex[k][2] >= 60 then
             paixingkuangName[k]:getChildByName("paixin_text2"):setColor(cc.c3b(0,200,0))
           end
           v[3] = v[3] or "乌龙"
           paixingkuangName[k]:getChildByName("paixin_text3"):setString(v[3])
           if self.paixingIndex[k][3] and self.paixingIndex[k][3] == 30 then
             paixingkuangName[k]:getChildByName("paixin_text3"):setColor(cc.c3b(0,200,0))
           end

           paixingkuangName[k]:addClickEventListener(function (sender)     
            gt.soundEngine:playEffect(gt.clickBtnAudio, false)
            if lastTouchpaixingkuang and lastTouchpaixingkuang ~= sender then
               -- gt.MyShader.setNodeDarken(lastTouchpaixingkuang)
               lastTouchpaixingkuang:getChildByName("light"):setVisible(false)
               -- gt.MyShader.setNodeRestore(sender)
               sender:getChildByName("light"):setVisible(true)
               self.autoLiPaiSpecailSelect = GameLogic.CT_EX_INVALID
               self.selectSpecialSortResult = self.autoLiPaiSpecailSelect
               self.selectSpecialType = GameLogic.CT_EX_INVALID
               print("111111111111111111111111111111111111111111")
                 for k1,v1 in pairs(self.paixingCards[k]) do
                     for k2,v2 in pairs(v1) do
                        self.tlipaiUi.paixingbg_1:getChildByName("card"..k1.."_"..k2)
                        :loadTexture(string.format("image/card/%02x.png", v2), ccui.TextureResType.plistType)
                        self:setMaPai(self.tlipaiUi.paixingbg_1:getChildByName("card"..k1.."_"..k2),v2)

                        self.tlipaiUi.paixingbg_1:getChildByName("card"..k1.."_"..k2):setTag(v2)
                     end
                end
            end
            
            lastTouchpaixingkuang = sender
            selectPaixingIndex = k1
end)
    end

    if self.specialSortResult == GameLogic.CT_EX_INVALID then
        lastTouchpaixingkuang = paixingkuangName[1]
        gt.MyShader.setNodeRestore(paixingkuangName[1])
        paixingkuangName[1]:getChildByName("light"):setVisible(true)
        self.selectSpecialType = GameLogic.CT_EX_INVALID
    end

--    local unitPosX = gt.winSize.width/(#paixingkuangName)
--    for k1,v1 in pairs(paixingkuangName) do
--        v1:setPositionX(unitPosX*k1)
--    end
    self.tlipaiUi.paixingkuang:setVisible(false)

end



function PlaySceneSSS:freeLiPai(csbNode,isInit,btSenderCallback)
	-- dump(self.btCancelVisiState)
	if self.tlipaiUi["dun_touch3"]:getChildByName("card_type"):isVisible() and 
		self.tlipaiUi["dun_touch2"]:getChildByName("card_type"):isVisible() and 
		self.tlipaiUi["dun_touch1"]:getChildByName("card_type"):isVisible() then
		self.btCancelVisiState = true
	else
		self.btCancelVisiState = false
	end
	
    self.tlipaiUi.Button_chupai:setVisible(self.btCancelVisiState)
    self.tlipaiUi.Button_chupai:setTouchEnabled(self.btCancelVisiState)
   
    self.tlipaiUi.paixingkuang_listView:setVisible(false)
    self.tlipaiUi.special_bts:setVisible(true)
    self.tlipaiUi.paixingbg_1:setVisible(false)
    self.tlipaiUi.paixingbg_2:setVisible(true)
    self.tlipaiUi.Button_cancel:setVisible(self.btCancelVisiState)

    if self.specialSortResult ~= GameLogic.CT_EX_INVALID then
        self.tlipaiUi.Button_special:setVisible(true)
    else
        self.tlipaiUi.Button_special:setVisible(false)
    end

    
    self.tlipaiUi.Button_chupai:setPositionX(display.cx+100)
    self.tlipaiUi.Button_cancel:setPositionX(display.cx-100)
    gt.switchParentNode(self.tlipaiUi.clockbg,self.tlipaiUi.paixingbg_2)
    local clock_pos = self.tlipaiUi.paixingbg_2:getChildByName("clock_pos")
    self.tlipaiUi.clockbg:setPositionX(clock_pos:getPositionX())
    self.tlipaiUi.clockbg:setPositionY(clock_pos:getPositionY())
    self.tlipaiUi.Button_switch:getChildByName("Text_1"):setString("自动配牌")

    local cardView = self.cardViews[1]
    for i=1,cardNum do
        cardView.imgCards[i]:setContentSize(126.00,175.00)
    end
   
    local cardPar = cardView.imgCards[1]:getParent()
    cardPar:setVisible(true)   
    self.selectSpecialSortResult = self.freeLiPaiSpecailSelect
    isInit = isInit or false
    if  isInit == false then return end

    gt.switchParentNode(cardPar,self.tlipaiUi.cards_node)
     if cardPar:getPositionY()<0 then
            cardPar:setPositionY( display.cy*0.35)
            cardPar:setPositionX(display.cx)
     end 

    sszCardTools:setCardWithInterval(cardView.imgCards,13,70,0)
       
    local cardsIsUp = {} -- 1是没被点击  2是被点击up了 3 被摆上道 
     for i = 1,13 do
        cardsIsUp[i] = 1  
     end


     local function teshucallBack()
     	dump(self.specialCards)
        for k1,v1 in pairs(self.specialCards) do
                     for k2,v2 in pairs(v1) do
                        local card = gt.seekNodeByName(self.tlipaiUi.paixingbg_2,"card"..k1.."_"..k2)
                        if card then
                            card:loadTexture(string.format("image/card/%02x.png", v2), ccui.TextureResType.plistType)
                            self:setMaPai(card,v2)
                            card:setTag(v2)
                        end
                     end
                end

        self.freeLiPaiSpecailSelect = self.specialSortResult
        self.selectSpecialType = self.specialSortResult
        dump(self.specialSortResult)
        dump(self.selectSpecialType)
        self.selectSpecialSortResult = self.freeLiPaiSpecailSelect
        if btSenderCallback then btSenderCallback() end
    end

    local function teshuCancelCallback()
    	self.selectSpecialType = GameLogic.CT_EX_INVALID
    end

     if self.specialSortResult ~= GameLogic.CT_EX_INVALID then
        require("app/views/NoticeTips"):create("提示","获得特殊牌型:"..sszCardTools:getspecailKeyToString(self.specialSortResult),teshucallBack , teshuCancelCallback, false)
        
     end

     self.tlipaiUi.Button_special:addClickEventListener(
        
        function (sender)
            gt.soundEngine:playEffect(gt.clickBtnAudio, false)
            if self.specialSortResult ~= GameLogic.CT_EX_INVALID then
                require("app/views/NoticeTips"):create("提示", sszCardTools:getspecailKeyToString(self.specialSortResult),teshucallBack , nil, false)
            end
        end
     )


     local touchCards = {}
     local lastTouchCard = nil
     self.freeLipaiListener = gt.getEventListenerTouchOneByOne(cardPar,
     function (touch,event)

        if self.tlipaiUi.paixingbg_2:isVisible() == false then
            return false
         end
         local touch = cardPar:convertToNodeSpace(touch:getLocation())
        for k,v in pairs(cardView.imgCards) do
          if v:isVisible() and  cc.rectContainsPoint(v:getBoundingBox(),touch) then
            gt.MyShader.setNodeDarken(v)
            lastTouchCard = v
            touchCards[k] = lastTouchCard
             break
          end
        end
     return true
     end,

     function (touch,event)
        local touch = cardPar:convertToNodeSpace(touch:getLocation())
        for k,v in pairs(cardView.imgCards) do
          if v:isVisible() and cc.rectContainsPoint(v:getBoundingBox(),touch) then
            if lastTouchCard~=nil and lastTouchCard~=v then
                gt.MyShader.setNodeDarken(v)
                lastTouchCard = v
               touchCards[k] = lastTouchCard
             end
             break
          end
        end
     return true
     end,

     function (touch,event)
        local touch = cardPar:convertToNodeSpace(touch:getLocation())
        for k,v in pairs(cardView.imgCards) do
          if v:isVisible() and cc.rectContainsPoint(v:getBoundingBox(),touch) then
            if lastTouchCard~=nil and lastTouchCard~=v then
                gt.MyShader.setNodeDarken(v)
                lastTouchCard = v
               touchCards[k] = lastTouchCard
             end
             break
          end
        end

        for k,v in pairs(touchCards) do
            gt.MyShader.setNodeRestore(v)
            if cardsIsUp[k] == 2 then
                 cardsIsUp[k] = 1
                 v:runAction(cc.MoveBy:create(0.2,cc.p(0,-20)))
             elseif cardsIsUp[k] == 1 then
                 cardsIsUp[k] = 2
                 v:runAction(cc.MoveBy:create(0.2,cc.p(0,20)))
             end
        
        end
        touchCards = {}
        lastTouchCard = nil
     return true
     end
)
     

     for k,v in pairs(cardView.imgCards) do
          v:setTouchEnabled(false)
          v:addClickEventListener(
          function (sender)
            gt.soundEngine:playEffect(gt.clickBtnAudio, false)
             if cardsIsUp[k] == 2 then
                 cardsIsUp[k] = 1
                 v:runAction(cc.MoveBy:create(0.2,cc.p(0,-20)))
             elseif cardsIsUp[k] == 1 then
                 cardsIsUp[k] = 2
                 v:runAction(cc.MoveBy:create(0.2,cc.p(0,20)))
             end
              
          end
          ) 
     end

    local function compareTouZhong()
    	if self.wafaTouJin then
    		local toudao = {}
    		local zhongdao = {}
    	    for t = 1, 3 do
    	    	local card = gt.seekNodeByName(self.tlipaiUi.paixingbg_2, "card3" .. "_" .. t)
           		if card then
                	if card:isVisible() then
                    	table.insert(toudao, card:getTag())
                	end
           		end
    	    end

    	    for t = 1, 5 do
    	    	local card = gt.seekNodeByName(self.tlipaiUi.paixingbg_2, "card2" .. "_" .. t)
           		if card then
                	if card:isVisible() then
                    	table.insert(zhongdao, card:getTag())
                	end
           		end
    	    end
    	    dump(toudao)
    	    dump(zhongdao)
    	    if #toudao == 3 and #zhongdao == 5 then
    	    	local toudaoKey = sszCardTools:getType(toudao, 1, 11, true)
    	    	local zhongdaoKey = sszCardTools:getType(zhongdao, 1, 11, true)
    	    	dump(toudaoKey)
    	    	dump(zhongdaoKey)
    	    	dump(sszCardTools:comparesCards(toudao, zhongdao, (self.tableSetting.compare_type and self.tableSetting.compare_type == 1), true))
    	    	if (toudaoKey == 5 or toudaoKey == 6) and 
        			sszCardTools:comparesCards(toudao, zhongdao, (self.tableSetting.compare_type and self.tableSetting.compare_type == 1), true) then
        			self.tlipaiUi["dun_touch3"]:getChildByName("card_type"):setString("乌龙")
        		else
        			self.tlipaiUi["dun_touch3"]:getChildByName("card_type"):setVisible(true)
	            	if toudaoKey then
	                	local string = sszCardTools:getPaiXingOrigalKeyToString(toudaoKey, 3)
	                	if string then                   
	                    	self.tlipaiUi["dun_touch3"]:getChildByName("card_type"):setString(string) 
	                	end
	            	else
	                 	self.tlipaiUi["dun_touch3"]:getChildByName("card_type"):setString("乌龙")
	           		end
        		end
        	elseif #toudao == 3 then
        		local toudaoKey = sszCardTools:getType(toudao, 1, 11, true)
        		self.tlipaiUi["dun_touch3"]:getChildByName("card_type"):setVisible(true)
            	if toudaoKey then
                	local string = sszCardTools:getPaiXingOrigalKeyToString(toudaoKey, 3)
                	if string then                   
                    	self.tlipaiUi["dun_touch3"]:getChildByName("card_type"):setString(string) 
                	end
            	else
                 	self.tlipaiUi["dun_touch3"]:getChildByName("card_type"):setString("乌龙")
           		end
    	    end                                 	
        end
    end

     local  function downCardCallBack(card)
            
                    if card then                      
                        card:setVisible(false)
                        for k2,v2 in pairs(cardView.imgCards) do
                            if v2:getTag() == card:getTag() and cardsIsUp[k2] == 3 then
                                 v2:setVisible(true)
                                 cardsIsUp[k2] = 1 
                                 v2:setPositionY(v2:getPositionY() - 20)
                                 card:setTag(0)
                            end
                        end

                        local remindCards = {}
                        local remindCardsValue = {}
                        for k2,v2 in pairs(cardView.imgCards) do
                            if v2:isVisible() then
                                table.insert(remindCards,v2)
                                table.insert(remindCardsValue,v2:getTag())
                                if cardsIsUp[k2] == 2 then
                                    cardsIsUp[k2] = 1 
                                    v2:setPositionY(v2:getPositionY() - 20)
                                end

                            end
                        end

                        sszCardTools:setCardWithInterval(remindCards,#remindCards,70,0) 
                        self.freeCardTypes = sszCardTools:getTypes(remindCardsValue,1,11,self.wafaTouJin)
                        for i=1,11 do
                        if i ~= 8 and i ~= 9 then 
                           local index = i
--                           if i == 8 then index= 5 
--                           elseif i == 9 then index = 6 
                           if i == 10 then index = 8 
                           elseif i == 11 then index = 9 end

                            local bt_spe = self.tlipaiUi["bt_spe_"..index]
                            if bt_spe then
                                 
                                if self.freeCardTypes[i]  then
                                    bt_spe:setColor(cc.c3b(255,255,255))
                                    bt_spe:setTouchEnabled(true)
                                else
                                    bt_spe:setColor(cc.c3b(150,150,150))
                                    bt_spe:setTouchEnabled(false)
                                end
                            end
                         end   
                        end
                    end     
             self.btCancelVisiState = false       
            self.tlipaiUi.Button_cancel:setVisible(self.btCancelVisiState)
            self.tlipaiUi.Button_chupai:setVisible(self.btCancelVisiState)
            self.tlipaiUi.Button_cancel:setTouchEnabled(self.btCancelVisiState)
            self.tlipaiUi.Button_chupai:setTouchEnabled(self.btCancelVisiState)

     end


     local function switchCards(card1,card2)
          local tempVisible = nil
          local tempTag = nil
          tempVisible = card1:isVisible()
          tempTag = card1:getTag()
          
          card1:setVisible(card2:isVisible())
          card1:setTag(card2:getTag())
          if card1:getTag() ~=0 then
              card1:loadTexture(string.format("image/card/%02x.png", card1:getTag()), ccui.TextureResType.plistType)
              self:setMaPai(card1,card1:getTag())
          end

          card2:setVisible(tempVisible)
          card2:setTag(tempTag)
          if card2:getTag() ~=0 then
              card2:loadTexture(string.format("image/card/%02x.png", card2:getTag()), ccui.TextureResType.plistType)
              self:setMaPai(card2,card2:getTag())
          end
     end
      

     for i = 1,3 do
        for j = 1,5 do
            local card = gt.seekNodeByName(self.tlipaiUi.paixingbg_2,"card"..i.."_"..j)          
            if card then
                card:setVisible(false)
                card:setTag(0)
                card:addClickEventListener(function (sender)
                    gt.soundEngine:playEffect(gt.clickBtnAudio, false)
                    downCardCallBack(sender)    
                    local count = j 
                    while true do
                        local card22 = gt.seekNodeByName(self.tlipaiUi.paixingbg_2,"card"..i.."_"..count - 1)
                        if card22 then
                            local card11 = gt.seekNodeByName(self.tlipaiUi.paixingbg_2,"card"..i.."_"..(count))
                            switchCards(card11,card22)
                            compareTouZhong()
                        else
                            break
                        end
                        
                        count = count - 1
                    end
                    local  flag = false
                    for k = 1, 5 do
                        local card  =gt.seekNodeByName(self.tlipaiUi.paixingbg_2,"card"..i.."_"..k)  
                        if card and card:isVisible() then
                            flag =  true
                            break
                        end
                    end
                    self.tlipaiUi["dun_touch"..i]:getChildByName("bt_clear"):setVisible(flag)    
                    self.tlipaiUi["dun_touch"..i]:getChildByName("card_type"):setVisible(false)

                    compareTouZhong()                                   
                end)
            end
        end
     end   
   
    for i = 1, 3 do
        self.tlipaiUi["dun_touch"..i]:getChildByName("bt_clear"):setVisible(false)
        self.tlipaiUi["dun_touch"..i]:getChildByName("bt_clear"):addClickEventListener(
            function (sender)
                gt.soundEngine:playEffect(gt.clickBtnAudio, false)
                for k = 1, 5 do
                   local card  = gt.seekNodeByName(self.tlipaiUi.paixingbg_2,"card"..i.."_"..k)
                   if card then
                        downCardCallBack(card)
                        self.tlipaiUi["dun_touch"..i]:getChildByName("card_type"):setVisible(false)
                    end
                end
                sender:setVisible(false)

                -- 删除中道的时候头道要恢复
        	    compareTouZhong()
            end
        )

        self.tlipaiUi["dun_touch"..i]:addClickEventListener(function (sender)
        	gt.soundEngine:playEffect(gt.clickBtnAudio, false)
        	local remindCards = {}
        	local remindCardsValue = {}
        	local upCards = {}
        	local flag = true
         	for k2,v2 in pairs(cardView.imgCards) do
             	if cardsIsUp[k2] == 2 then                        
                	upCards[k2] = v2
                	flag = false
             	end
        	end

        	if flag then
            	return     
        	end

        -- upCards = sszCardTools.reverseTable(upCards)

        	for k = 5, 1, -1 do
           		local  card  = gt.seekNodeByName(self.tlipaiUi.paixingbg_2,"card"..i.."_"..k)
           		if card and card:isVisible() == false and sszCardTools.hasElement(upCards) then
                	local k2,v2 = sszCardTools:getLastElementAndRemove(upCards)
                	card:setVisible(true)
                	card:loadTexture(string.format("image/card/%02x.png", v2:getTag()), ccui.TextureResType.plistType)     
                	self:setMaPai(card,v2:getTag())          
                	cardsIsUp[k2] = 3
                	v2:setVisible(false)
                	card:setTag(v2:getTag())
           		end
        	end
        
        	local tcheckType = {}
        	local flag = true
        	for k =1,5  do
           		local  card  = gt.seekNodeByName(self.tlipaiUi.paixingbg_2,"card"..i.."_"..k)
           		if card then
                	if card:isVisible()  then
                    	table.insert(tcheckType,card:getTag())
                	else
                    	flag = false
                	end
           		end
        	end

        	
        	

        	if flag then
            	local origalKey = sszCardTools:getType(tcheckType,1,11,self.wafaTouJin)
            	sender:getChildByName("card_type"):setVisible(true)
            	if origalKey then
                	local string = sszCardTools:getPaiXingOrigalKeyToString(origalKey,i)
                	if string then                   
                    	sender:getChildByName("card_type"):setString(string) 
                	end
            	else
                 	sender:getChildByName("card_type"):setString("乌龙")
           		end
            
        	end


        	for k,v in pairs(upCards) do
          --  if cardsIsUp[k] == 2 then
                v:setPositionY(v:getPositionY() - 20)
                cardsIsUp[k] = 1
          --  end
        	end

        	for k2,v2 in pairs(cardView.imgCards) do
             	if cardsIsUp[k2] == 1 then
                	table.insert(remindCards,v2)
                	table.insert(remindCardsValue,v2:getTag())
             	end
        	end

        	sender:getChildByName("bt_clear"):setVisible(true)
        

	        local isdaoshus_false = {}
	        for j = 1,3 do
	            for l = 1,5 do
	                local  card  = gt.seekNodeByName(self.tlipaiUi.paixingbg_2,"card"..j.."_"..l)
	                if card and card:isVisible() == false then       
	                    table.insert(isdaoshus_false,1)
	                    break
	                end          
	            end
	        end

        	if #remindCards <= 5  and #isdaoshus_false == 1 then   
          		for _,v in pairs(remindCards) do  
            		for l = 1,5 do
             			local flag = false
              			for j = 1,3 do
                   			local  card  = gt.seekNodeByName(self.tlipaiUi.paixingbg_2,"card"..j.."_"..l)
                   			if card and card:isVisible() == false then
		                        card:setTag(v:getTag())
		                        card:setVisible(true)
		                        card:loadTexture(string.format("image/card/%02x.png", v:getTag()), ccui.TextureResType.plistType)
		                        self:setMaPai(card,v:getTag()) 
		                        v:setVisible(false)
		                        v:setPositionY(v:getPositionY()+ 20)
		                        flag = true
		                        break
		                   	end
                		end
                 		if flag then 
                 			break 
                 		end
               		end
            	end
	            self.tlipaiUi["dun_touch1"]:getChildByName("bt_clear"):setVisible(true)
	            self.tlipaiUi["dun_touch2"]:getChildByName("bt_clear"):setVisible(true)
	            self.tlipaiUi["dun_touch3"]:getChildByName("bt_clear"):setVisible(true)

            	for i = 1,3 do
                	local cards = {}
                    for j = 1,5 do 
                        local card = self.tlipaiUi["dun_touch"..i]:getChildByName("card"..i.."_"..j)
                        if card then
                            cards[j]=card:getTag()
                        else
                            break
                        end
                    end 
                
	                local origalKey = sszCardTools:getType(cards,1,11,self.wafaTouJin)
	                self.tlipaiUi["dun_touch" .. i]:getChildByName("card_type"):setVisible(true)
	                if origalKey then
	                    local string = sszCardTools:getPaiXingOrigalKeyToString(origalKey,i)
	                    if string then
	                        self.tlipaiUi["dun_touch" .. i]:getChildByName("card_type"):setString(string) 
	                    end
	                else
	                    self.tlipaiUi["dun_touch" .. i]:getChildByName("card_type"):setString("乌龙") 
	                end
	            end

	            for k,v in pairs(cardsIsUp) do
	                cardsIsUp[k] = 3
	            end

                for i=1,9 do
                    local bt_spe = self.tlipaiUi["bt_spe_"..i]
                    if bt_spe then              
                        bt_spe:setColor(cc.c3b(150,150,150))
                        bt_spe:setTouchEnabled(false)                      
                    end
                end 
                self.btCancelVisiState = true
	            self.tlipaiUi.Button_chupai:setVisible(self.btCancelVisiState)
	            self.tlipaiUi.Button_chupai:setTouchEnabled(self.btCancelVisiState) 
	            self.tlipaiUi.Button_cancel:setVisible(self.btCancelVisiState)
	            self.tlipaiUi.Button_cancel:setTouchEnabled(self.btCancelVisiState) 

	            self.freeLiPaiSpecailSelect = GameLogic.CT_EX_INVALID
	            self.selectSpecialSortResult = self.freeLiPaiSpecailSelect

	            

        	elseif #remindCards == 0 then
	            self.btCancelVisiState = true
	            self.tlipaiUi.Button_chupai:setVisible(self.btCancelVisiState) 
	            self.tlipaiUi.Button_chupai:setTouchEnabled(self.btCancelVisiState) 
	            self.tlipaiUi.Button_cancel:setVisible(self.btCancelVisiState)
	            self.tlipaiUi.Button_cancel:setTouchEnabled(self.btCancelVisiState)

	            self.freeLiPaiSpecailSelect = GameLogic.CT_EX_INVALID
	            self.selectSpecialSortResult = self.freeLiPaiSpecailSelect
        	else
                sszCardTools:setCardWithInterval(remindCards,#remindCards,70,0) 
                self.freeCardTypes = sszCardTools:getTypes(remindCardsValue,1,11,self.wafaTouJin)
				for i=1,11 do
					if i ~= 8 and i ~= 9 then 
						local index = i

						if i == 10 then 
							index = 8 
						elseif i == 11 then 
							index = 9 
						end

						local bt_spe = self.tlipaiUi["bt_spe_"..index]
						if bt_spe then
							if self.freeCardTypes[i]  then               
								bt_spe:setColor(cc.c3b(255,255,255))
								bt_spe:setTouchEnabled(true)
							else
								bt_spe:setColor(cc.c3b(150,150,150))
								bt_spe:setTouchEnabled(false)
							end
						end
					end   
				end
        	end

        	-- 有头金头顺的时候，插入中道要判断与头道的关系，如果中道小于头道，那么头道自动变为乌龙
	        	-- 插入头道要判断与中道的关系，如果头道大于中道，那么头道自动变为乌龙
	        compareTouZhong()
        end)
    end
     

     self.tlipaiUi.Button_cancel:addClickEventListener(
        function (sender)
            gt.soundEngine:playEffect(gt.clickBtnAudio, false)
          for i =1 ,3 do
             for k = 1, 5 do
                   local card  = gt.seekNodeByName(self.tlipaiUi.paixingbg_2,"card"..i.."_"..k)
                   if card then
                        downCardCallBack(card)
                    end
                end
            end
            self.tlipaiUi["dun_touch1"]:getChildByName("bt_clear"):setVisible(false)
            self.tlipaiUi["dun_touch2"]:getChildByName("bt_clear"):setVisible(false)
            self.tlipaiUi["dun_touch3"]:getChildByName("bt_clear"):setVisible(false)
            self.tlipaiUi["dun_touch1"]:getChildByName("card_type"):setVisible(false)   
            self.tlipaiUi["dun_touch2"]:getChildByName("card_type"):setVisible(false)
            self.tlipaiUi["dun_touch3"]:getChildByName("card_type"):setVisible(false)          
        end
     )



           for i=1,11 do
            if i ~= 8 and i ~= 9 then 
              local index = i

--              if i == 8 then index= 5 
--              elseif i == 9 then index = 6 
              if i == 10 then index = 8 
              elseif i == 11 then index = 9 end

             local bt_spe = self.tlipaiUi["bt_spe_"..index]
             print("--------->>>>bt_spe_"..index)
             if bt_spe  then
                                 
                if self.freeCardTypes[i]  then 
                    bt_spe:setColor(cc.c3b(255,255,255))
                    bt_spe:setTouchEnabled(true)
                else
                    bt_spe:setColor(cc.c3b(150,150,150))
                    bt_spe:setTouchEnabled(false)
                end
            end
        

        self.tcount = {}
        self.tcount[1] = 1
 
        bt_spe:addTouchEventListener(function (sender,eventType)

        if eventType == ccui.TouchEventType.ended then
            gt.soundEngine:playEffect(gt.clickBtnAudio, false)
            if self.freeCardTypes[i][self.tcount[1]] == nil  then
                self.tcount[1] = 1  
            end
            
            if self.freeCardTypes[i][self.tcount[1]] then
               
               local upCount = 0
              
               for k2,v2 in pairs(cardView.imgCards) do
                     if cardsIsUp[k2] == 2 then
                        cardsIsUp[k2] = 1
                        v2:runAction(cc.MoveBy:create(0.2,cc.p(0,-20)))
                     end
                end
                
                for k1,v1 in pairs(self.freeCardTypes[i][self.tcount[1]]) do
                    for k2,v2 in pairs(cardView.imgCards) do
                       -- print(v2:getTag())
                       if cardsIsUp[k2] == 1 and v1 == v2:getTag() then
                          cardsIsUp[k2] = 2
                          upCount = upCount + 1
                          v2:runAction(cc.MoveBy:create(0.2,cc.p(0,20)))
                          break                                              
                       end
                    end 
                end

                if upCount < 5 then
                    local reminderCardsValue =  {}
                    for k2,v2 in pairs(cardView.imgCards) do
                        if cardsIsUp[k2] == 1 then
                            table.insert(reminderCardsValue,v2:getTag())
                        end
                    end

                    local tDanPai = sszCardTools:getDanPai(reminderCardsValue)

                    local lastV = 5- upCount
                    if #tDanPai < lastV then
                        for k1,v1 in pairs(tDanPai) do
                            for k2,v2 in pairs(cardView.imgCards) do
                                --print(v2:getTag())
                               if cardsIsUp[k2] == 1 and v1 == v2:getTag() then
                                  cardsIsUp[k2] = 2
                                  upCount = upCount + 1
                                  v2:runAction(cc.MoveBy:create(0.2,cc.p(0,20)))
                                  break                                              
                               end
                            end 
                        end

                        for i=1 ,lastV - #tDanPai do
                            for k2,v2 in pairs(cardView.imgCards) do
                                print(v2:getTag())
                               if cardsIsUp[k2] == 1 then
                                  cardsIsUp[k2] = 2
                                  upCount = upCount + 1
                                  v2:runAction(cc.MoveBy:create(0.2,cc.p(0,20)))
                                  break                                              
                               end
                            end 
                        end 
                        
                    else
                        for i=1,lastV do
                            for k2,v2 in pairs(cardView.imgCards) do
                                print(v2:getTag())
                               if cardsIsUp[k2] == 1 and tDanPai[i] == v2:getTag() then
                                  cardsIsUp[k2] = 2
                                  upCount = upCount + 1
                                  v2:runAction(cc.MoveBy:create(0.2,cc.p(0,20)))
                                  break                                              
                               end
                            end 
                        end

                    end

                end
                            
                self.tcount[1] = self.tcount[1] +1
             
            end
        end
      
end)
        end
     end  



end





function PlaySceneSSS:setComparison_CardData(card,k,displaySeatIdx)
    if self.comparison_cardsInfo[displaySeatIdx] == nil  then
        self.comparison_cardsInfo[displaySeatIdx] = {}
    end
     if self.comparison_cardsInfo[displaySeatIdx][k] == nil then
        self.comparison_cardsInfo[displaySeatIdx][k] = {}
     end

     self.comparison_cardsInfo[displaySeatIdx][k].scale = card:getScale()
     self.comparison_cardsInfo[displaySeatIdx][k].rotation = card:getRotation()
     self.comparison_cardsInfo[displaySeatIdx][k].position = {} 
    self.comparison_cardsInfo[displaySeatIdx][k].position.x,
    self.comparison_cardsInfo[displaySeatIdx][k].position.y  = card:getPosition()
    self.comparison_cardsInfo[displaySeatIdx][k].contentSizeWidth = card:getContentSize().width
    self.comparison_cardsInfo[displaySeatIdx][k].contentSizeHeight = card:getContentSize().height
end

function PlaySceneSSS:setOrignalCardData(card,k,displaySeatIdx)
    if self.orignal_cardsInfo[displaySeatIdx] == nil  then
        self.orignal_cardsInfo[displaySeatIdx] = {}
    end
     if self.orignal_cardsInfo[displaySeatIdx][k] == nil then
        self.orignal_cardsInfo[displaySeatIdx][k] = {}
     end

     self.orignal_cardsInfo[displaySeatIdx][k].scale = card:getScale()
     self.orignal_cardsInfo[displaySeatIdx][k].rotation = card:getRotation()
     self.orignal_cardsInfo[displaySeatIdx][k].position = {} 
    self.orignal_cardsInfo[displaySeatIdx][k].position.x,
    self.orignal_cardsInfo[displaySeatIdx][k].position.y  = card:getPosition()
    self.orignal_cardsInfo[displaySeatIdx][k].contentSizeWidth = card:getContentSize().width
    self.orignal_cardsInfo[displaySeatIdx][k].contentSizeHeight = card:getContentSize().height

end

function PlaySceneSSS:getOrignalCardData(card,k,displaySeatIdx,isChange)
    if self.orignal_cardsInfo[displaySeatIdx] == nil  then
        return nil
    end
     if self.orignal_cardsInfo[displaySeatIdx][k] == nil then
        return nil
     end



    card:setPosition(self.orignal_cardsInfo[displaySeatIdx][k].position.x,self.orignal_cardsInfo[displaySeatIdx][k].position.y)   
    card:setRotation(self.orignal_cardsInfo[displaySeatIdx][k].rotation)  
    card:setScale(self.orignal_cardsInfo[displaySeatIdx][k].scale)
    card:setContentSize(self.orignal_cardsInfo[displaySeatIdx][k].contentSizeWidth,
                    self.orignal_cardsInfo[displaySeatIdx][k].contentSizeHeight)

end

function PlaySceneSSS:getComparison_CardData(card,k,displaySeatIdx,isChange)
 if self.comparison_cardsInfo[displaySeatIdx] == nil  then
        return nil
    end
     if self.comparison_cardsInfo[displaySeatIdx][k] == nil then
        return nil
     end

    card:setPosition(self.comparison_cardsInfo[displaySeatIdx][k].position.x,self.comparison_cardsInfo[displaySeatIdx][k].position.y)   
    card:setRotation(self.comparison_cardsInfo[displaySeatIdx][k].rotation)  
    card:setScale(self.comparison_cardsInfo[displaySeatIdx][k].scale)
    card:setContentSize(self.comparison_cardsInfo[displaySeatIdx][k].contentSizeWidth,
                    self.comparison_cardsInfo[displaySeatIdx][k].contentSizeHeight)
end



function PlaySceneSSS:setCardsToComparisonState(displaySeatIdx,isRemoveMaPai)
        isRemoveMaPai = isRemoveMaPai or false
        local cardInfo  =  gt.seekNodeByName(self.rootNode,"ComparCard1")

         	     local cardView = self.cardViews[displaySeatIdx]
				cardView.node:setVisible(true)
				cardView.imgNiuRate:setVisible(false)
				cardView.imgScore:setVisible(false)
                local i = 1
                local j = 1
				for m = 1, cardNum do
					cardView.imgCards[m]:setVisible(true)

                          if j >= 6 then
                             j = 1
                             i = i + 1
                          end
                           local lcard = cardInfo:getChildByName("lcard"..i.."_"..j)
                            cardView.imgCards[m]:setPosition(lcard:getPositionX()  ,lcard:getPositionY())                            
                            cardView.imgCards[m]:setVisible(true)
                            cardView.imgCards[m]:setRotation(lcard:getRotation())
							cardView.imgCards[m]:loadTexture(self.card_back, ccui.TextureResType.plistType)
                            cardView.imgCards[m]:setContentSize(lcard:getContentSize().width,lcard:getContentSize().height)
                            if isRemoveMaPai then  self:removeMaPai(cardView.imgCards[m]) end
                            self:setComparison_CardData(cardView.imgCards[m],m,displaySeatIdx)
                            j = j + 1
				end       
end


function PlaySceneSSS:ComparisonCard(msgTbl)
	self.scheIds = {}

	local playNode = gt.seekNodeByName(self.rootNode, "Node_play")
	local cardView = self.cardViews[1]
	local cardPar = cardView.imgCards[1]:getParent()
	cardPar:setVisible(self.playerSeatIdx ~= -1)
	gt.switchParentNode(cardPar,playNode)

	cardPar:setPositionY(self.selfCardParNodePosY)
	cardPar:setPositionX(self.selfCardParNodePosX)

	gt.removeCocosEventListener(self,self.freeLipaiListener)
	--  self.tlipaiUi.clockText = nil

	self.rootNode:removeChildByName("lipai")
	self.lipaiIsClose = true

	gt.soundEngine:playEffect("SSS/"..self.sexStr.."/start_compare", false)
	dump(msgTbl,"比牌数据",5)
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))
--     --local tt = {2,3,4,3,4,5,6,7,7,8,9,10,11}
--     local tt = {35,52,21,54,57,10,42,58,11,43,59,12,61}
--     for i = 1,13 do 
--        msgTbl.self_cards[i] = {}
--        msgTbl.self_cards[i] =  math.random(1,13)+ 16*math.random(0,3)
--  --      msgTbl.self_cards[i] = tt[i]
--        print("--> k="..i.." v="..msgTbl.self_cards[i])

--     end

    for k, v in pairs(self.roomPlayers) do
    	dump(v)
        local cardView = self.cardViews[v.displaySeatIdx]
        local cardPar = cardView.imgCards[1]:getParent()
        cardPar:setVisible(not v.isWait)

        for kk,vv in pairs(msgTbl.player_data) do
        	if vv.player == v.uid then
        		if not v.isWait then  
			        v.cards_type = {}
			        for i = 1,3 do
			            v.cards_type[i] = msgTbl.player_data[kk].cards_type[i]
			        end

			        v.dao_score = {}
			        for i = 1,3 do
			            v.dao_score[i] =  msgTbl.player_data[kk].scores[i]
			        end

			        v.cards_in_hand = {}
			        sszCardTools:setA_14to1(msgTbl.player_data[kk].cards_in_hand)
			        for i = 1,13 do
			       -- print( string.format("image/card/%02x.png", msgTbl.player_data[k].cards_in_hand[i] ))  
			            v.cards_in_hand[i] =  msgTbl.player_data[kk].cards_in_hand[i]
			        end

			       	v.cards_in_hand =  sszCardTools.reverseTable(v.cards_in_hand) 
			       	dump(v.cards_in_hand)
			        v.total_score = msgTbl.player_data[kk].total_score
			        v.score = msgTbl.player_data[kk].score
			        v.shoot = msgTbl.player_data[kk].shoot
			--        for i=1,3 do
			--            v.shoot[i] = i 
			--        end
			        for k1,v1 in pairs(v.shoot) do
			            v.shoot[k1] = v1 + 1 
			        end

			        v.allShoot = msgTbl.player_data[kk].allShoot
			        v.special_type = msgTbl.player_data[kk].special_type
			--       v.special_type = 10
			--       v.allShoot = true
			    end
			    break
        	end
        end
    end

    --self.roomPlayers[1].allShoot = true

    local isdaqiangBiaoTi = false 
    local daqiangBiaoOnce = true
    for k, v in pairs(self.roomPlayers) do
     	if v.cards_in_hand then
     		if  not v.is_wait  then
	            if sszCardTools.hasElement(v.cards_in_hand) then
	                if v.shoot and sszCardTools.hasElement(v.shoot)  then
	                    isdaqiangBiaoTi = true
	                end
	            end
	        end
     	end
    end

      
    local cardInfo  =  gt.seekNodeByName(self.rootNode,"ComparCard1")
    local specialTime = 0
    local delayTime = 1.0
	for k, v in pairs(self.roomPlayers) do
		if not v.isWait then
            self:setCardsToComparisonState(v.displaySeatIdx)
    	end
    end

    local daoshu = {{11,13},{6,10},{1,5}}
    for i=1 ,3 do
        local roomPlayers = sszCardTools.copyTable(self.roomPlayers)
   --      table.sort(roomPlayers, function (a,b)
   --      	if a and a.cards_in_hand and #a.cards_in_hand > 0 and b and b.cards_in_hand and #b.cards_in_hand > 0 then
   --      		local cards_Value1 = {}
   --              local cards_Value2 = {}
   --              for m =daoshu[i][1],daoshu[i][2] do  
   --                      table.insert(cards_Value1, a.cards_in_hand[m])        
   --                      table.insert(cards_Value2, b.cards_in_hand[m])                         
   --              end

   --     	 		if sszCardTools:comparesCards(cards_Value1, cards_Value2,(self.tableSetting.compare_type and self.tableSetting.compare_type == 1),self.wafaTouJin) then
   --          		return false
   --      		else
   --          		return true
   --      		end
			-- end
   --      end)

        for k, v in pairs(roomPlayers) do
        	dump(v)
        	if v.cards_in_hand and #v.cards_in_hand > 0 then
        		local cardView = self.cardViews[v.displaySeatIdx]  
				local kuang = cardInfo:getChildByName("kuang_"..i)
				kuang = kuang:clone()
				kuang:setName("kuang_"..i)
				if v.displaySeatIdx == 3 and uiChairsNum == 8 then
				    kuang:setPositionX(-kuang:getPositionX())
				end

				cardView.node:addChild(kuang)                      

				kuang:setScale(0)

				if v.special_type == 0 then                                        
					local cardView = self.cardViews[v.displaySeatIdx]

					local scheid = gt.delayRun(delayTime, function (dt)
					    local cards = {}
					    local cards_Value = {}
					    for m =daoshu[i][1],daoshu[i][2] do
					        table.insert(cards,cardView.imgCards[m])   
					        table.insert(cards_Value,v.cards_in_hand[m])                                 
					    end

					    if i == 1 and v.cards_type[i] == 30 then
					        gt.soundEngine:playEffect("SSS/"..self:getSexStr(v.sex).."/type1", false) 
					    elseif  i == 2 and v.cards_type[i] == 60 then
					        gt.soundEngine:playEffect("SSS/"..self:getSexStr(v.sex).."/type2", false) 
					    else
					        gt.soundEngine:playEffect("SSS/"..self:getSexStr(v.sex).."/common"..v.cards_type[i], false)                                                                           
					    end  
					      -- end
					    self:OpenCardAnimation(cards,i,v.cards_type[i],v.dao_score[i],cards_Value,v.score,v.displaySeatIdx,kuang,total_score ,v.total_score)  --亮牌  

					end)
					table.insert(self.scheIds, scheid)
				end
        	end
		end
		delayTime = delayTime + 0.7
	end

        
    for k, v in pairs(self.roomPlayers) do 
       	if isdaqiangBiaoTi then
         	delayTime = delayTime + 0.5
           	if daqiangBiaoOnce and v.special_type == 0 then
            	daqiangBiaoOnce = false
           		local scheId  = gt.delayRun(delayTime, function ()
                    gt.soundEngine:playEffect("SSS/"..self:getSexStr(v.sex).."/daqiang", false)
                    self:KaishiShootAnimation()  --开始打枪动画
                end)
            table.insert(self.scheIds,scheId)
            end
        end
    end


            
	local roomPlayers =  sszCardTools.copyTable(self.roomPlayers)
	table.sort(roomPlayers, function (a,b)
		if a.shoot == nil then
		    return false
		elseif b.shoot == nil then
		    return true
		else
		   return  #(a.shoot) < #(b.shoot)
		end
	end)

	for k, v in pairs(roomPlayers) do          
		if v.shoot then
		--  delayTime = delayTime + 2.0
			for k1,v1 in pairs(v.shoot) do   --打枪      
				if v.special_type == 0 then           
					local scheId = gt.delayRun(delayTime,function ()
						self:ShootAnimation(v.seatIdx,v1)  --打枪
					end)
					table.insert(self.scheIds, scheId)
					delayTime = delayTime + 2.5   
				end
			end
		end
	end

	for k, v in pairs(roomPlayers) do                       
		if v.allShoot and v.special_type == 0 then
			local scheId =  gt.delayRun(delayTime,function ()
				gt.soundEngine:playEffect("SSS/"..self:getSexStr(v.sex).."/quanleida", false) 
				self:AllShootAnimationShowCard(cardView.imgCards,v.displaySeatIdx)  --全垒打
			end)
			table.insert(self.scheIds, scheId)
			delayTime = delayTime + 3.5 
		end    
	end

   --specialTime = 0
    for k, v in pairs(self.roomPlayers) do
        if not v.isWait then
            if v.special_type and v.special_type ~= 0 then
             	local cardView = self.cardViews[v.displaySeatIdx]   
               	local scheId =  gt.delayRun(delayTime,function ()
					gt.soundEngine:playEffect("SSS/"..self:getSexStr(v.sex).."/special"..v.special_type, false)                                                                           
                           --  end
                    local current_headNode =  gt.seekNodeByName(self.rootNode, "Node_playerInfo_" .. v.displaySeatIdx)
                    local totalScoreNode  = current_headNode:getChildByName("total_score")
                    self:specialCardTypeShow(v.special_type,cardView.imgCards,v.displaySeatIdx,v.cards_in_hand,v.score,v.total_score,totalScoreNode)  --特殊牌 亮牌                              
                end)
                table.insert(self.scheIds,scheId)
                delayTime = delayTime + 4
            end
        end
    end

   -- print("--------->>>",specialTime)
  	local scheId = gt.delayRun(delayTime,function ()
		self.readyBtn:loadTextureNormal("image/play/btn_ready.png")
		if self.lastRound == true and self.dajiesuanMsgTble then                                   
		   self:onRcvFinalReport()
		else
			local layer = require("app/games/SSS/GameBrief"):create(msgTbl, self.curRound)
         	self:addChild(layer, PlaySceneSSS.ZOrder.REPORT)
			self.ResultmsgTbl = msgTbl
		    self.Btn_ShowResult:setVisible(true)
		    self.readyBtn:setVisible(true)
		end
	end)
    table.insert(self.scheIds,scheId)
end


local scales = {0.8,0.4,0.4,0.4,0.4,0.4}
function PlaySceneSSS:OpenCardAnimation(cards,daoshu,cards_type,score,cards_Value ,totalscore ,displaySeatIdx,kuang,total_score,tScore)  --v.cards_type[i],v.score[i],cards_Value,v.shoot,v.allShoot
   cards =  sszCardTools.reverseTable(cards)
    local middleCardIndex = nil
    local middleCard = nil
    if #cards == 3 then
        middleCardIndex = 2       
    elseif #cards == 5  then
        middleCardIndex = 3       
    end
     middleCard = cards[middleCardIndex]
    local middleCardPosY   = middleCard:getPositionY()
   

--     local cardInfo  =  gt.seekNodeByName(self.rootNode,"ComparCard1")
--      local kuang = cardInfo:getChildByName("kuang_"..daoshu)
--      kuang = kuang:clone()
--      kuang:setPositionX(kuang:getPositionX()-75)
--      kuang:setVisible(true)
--      kuang:setScale(0.9)
--      kuang:setPositionY(kuang:getPositionY()-33)

      local current_headNode =  gt.seekNodeByName(self.rootNode, "Node_playerInfo_" .. displaySeatIdx)

      

   --   total_score:setString("总分:"..totalscore)
   -- total_score:setVisible(true)

    for i=1 , #cards do

       -- cards[i]:setVisible(false)
     
        cards[i]:loadTexture(string.format("image/card/%02x.png", cards_Value[i]), ccui.TextureResType.plistType)
        self:setMaPai(cards[i],cards_Value[i])
        local orgalScaleY = cards[i]:getScaleY()
        local orgalScaleX = cards[i]:getScaleX()
        local  orgalPosX = cards[i]:getPositionX()
        local  orgalPosY = cards[i]:getPositionY()
        local orgalRotation  = cards[i]:getRotation()
        local orgalZOrder = cards[i]:getLocalZOrder()
        cards[i]:setScaleY(0)
--        local progressTimer  =  cc.ProgressTimer:create(cards[i]:getVirtualRenderer():getSprite())
--        cards[i]:getParent():addChild(progressTimer)
       if daoshu == 1  then
            cards[i]:setPositionY(middleCardPosY - 35)
        elseif daoshu == 2  then
            cards[i]:setPositionY(middleCardPosY - 20)
        else
            cards[i]:setPositionY(middleCardPosY)
        end

        cards[i]:setPositionX(( i  - middleCardIndex  )*35 + middleCard:getPositionX())
        cards[i]:setRotation(0)
--      --  progressTimer:setContentSize(cards[i]:getContentSize().width,cards[i]:getContentSize().heig)
--        progressTimer:setConstantSize(cards[i]:getContentSize().width,cards[i]:getContentSize().height)
--        progressTimer:setScale(cards[i]:getScale())
        cards[i]:setLocalZOrder(99)
--        progressTimer:setBarChangeRate(cc.p(0,1))
--        progressTimer:setMidpoint(cc.p(0,0))
--        progressTimer:setType(kCCProgressTimerTypeBar)
    --    cards[i]:loadTexture(string.format("image/card/%02x.png", cards_Value[i]), ccui.TextureResType.plistType)
        if i == middleCardIndex then
      
           if score > 0 then
                kuang:getChildByName("fuhao_"..daoshu):loadTexture("games/SSS/score/a.png", ccui.TextureResType.localType)           
                kuang:getChildByName("shi_"..daoshu):loadTexture( string.format("games/SSS/score/a%d.png", math.floor(score/10))  , ccui.TextureResType.localType)              
                kuang:getChildByName("ge_"..daoshu):loadTexture( string.format("games/SSS/score/a%d.png",score%10)  , ccui.TextureResType.localType)                
           else
                score = -score
                kuang:getChildByName("fuhao_"..daoshu):loadTexture("games/SSS/score/b.png", ccui.TextureResType.localType)
                 kuang:getChildByName("shi_"..daoshu):loadTexture( string.format("games/SSS/score/b%d.png", math.floor(score/10))  , ccui.TextureResType.localType)
                kuang:getChildByName("ge_"..daoshu):loadTexture( string.format("games/SSS/score/b%d.png",score%10)  , ccui.TextureResType.localType)
           end
           local cardTypeSprite =   cc.Sprite:create("games/SSS/card_type/"..cards_type..".png")
           cardTypeSprite:setName("cardTypeSprite")
           cardTypeSprite:setAnchorPoint(0.5, 0)
           cardTypeSprite:setPosition(middleCard:getContentSize().width/2,middleCard:getContentSize().height)
           middleCard:addChild(cardTypeSprite)
      --     kuang:getChildByName("cardType_"..daoshu):setString(sszCardTools:getPaiXingKeyToString(cards_type))
        --  kuang:setOpacity(0)
          
        end

        cards[i]:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, orgalScaleX, orgalScaleY),
        cc.CallFunc:create(function ()
--                 kuang:runAction(cc.FadeIn:create(0.2))
                 kuang:runAction(cc.Sequence:create(
                 cc.EaseSineIn:create(cc.ScaleTo:create(0.2,1.5,1.5)),
                 cc.EaseSineIn:create(cc.ScaleTo:create(0.05,1.0,1.0))
                 ))
                
               --  kuang:getChildByName("cardType_"..daoshu):setVisible(true)
            end),

        cc.DelayTime:create(0.4), cc.CallFunc:create(
            function ()
            	if middleCard:getChildByName("cardTypeSprite") then
            		middleCard:removeChildByName("cardTypeSprite")
            	end
                
            --    cards[i]:runAction(cc.MoveTo:create(0.2,cc.p(orgalPosX,orgalPosY)))
                cards[i]:setPositionX(orgalPosX)
                cards[i]:setPositionY(orgalPosY)
                --cc.RotateTo:create(0.2, orgalRotation),
                cards[i]:setRotation(orgalRotation)
              --  progressTimer:runAction(cc.ScaleTo:create(0.2,cards[i]:getScale()))
              cards[i]:setLocalZOrder(orgalZOrder - 1)
                         
                         if daoshu == 3 then
                         --    total_score:runAction(cc.FadeIn:create(0.2) ) 
                           local playerNode = self.playerNodes[displaySeatIdx]
		                   local lblScore = gt.seekNodeByName(playerNode, "Label_Score")
		                   dump(tScore)
		                   lblScore:setString( tostring(tScore))

                           self:playAddScoreAni(displaySeatIdx,totalscore)
                        end
--                cards[i]:runAction(cc.Sequence:create(cc.CallFunc:create(
--                    function ()
--                       --  cards[i]:setVisible(true)
--                         --total_score:setVisible(true)

--                         end
--                    end
--                )
--                ))

            end
        )))
    end

end

function PlaySceneSSS:KaishiShootAnimation() 
    
    local ani = sp.SkeletonAnimation:create("games/SSS/shoot/effects1.json", "games/SSS/shoot/effects1.atlas")
    ani:setAnimation(1, "bomb box", false)
	ani:setTimeScale(2)
    ani:setPosition(display.cx,display.cy)
    self.rootNode:addChild(ani)

    ani:registerSpineEventHandler(function (event)
	 ani:runAction(cc.RemoveSelf:create())
    end, sp.EventType.ANIMATION_END)


end


function PlaySceneSSS:specialCardTypeShow(special_type,imgCards,displaySeatIdx,cards_Value,totalscore,tScore,total_score) 
    -- imgCards[1]:getParent():setPosition(display.width*0.5,display.height*0.3)
    
    local m_mask = gt.createMaskLayer()
    self:addChild(m_mask)


     gt.switchParentNode(imgCards[1]:getParent(),m_mask,1)

     imgCards[1]:getParent():setPositionY(display.cy*0.25)
     imgCards[1]:getParent():setPositionX(display.cx)

    for i = 1,13 do
        imgCards[i]:runAction(cc.Sequence:create(cc.FadeOut:create(0.3), cc.CallFunc:create(function ()
        self:getOrignalCardData(imgCards[i],i,displaySeatIdx)
        imgCards[i]:loadTexture(string.format("image/card/%02x.png", cards_Value[i]), ccui.TextureResType.plistType) 
        self:setMaPai(imgCards[i],cards_Value[i])    
        sszCardTools:setCardWithInterval(imgCards,13,60)
        if displaySeatIdx ~= 1 then
--             local width = self.cardViews[1].imgCards[i]:getContentSize().width
--             local height = self.cardViews[1].imgCards[i]:getContentSize().height           
             imgCards[i]:setContentSize(126.00,175.00)
             
        end
     
end)  , cc.FadeIn:create(0.3)))   
    end

    

    local special_typeTble = {
     [170] = "qinglong" , 
     [160] = "yitiaolong",
     [120] = "santonghuashun",
     [110] = "sanfentianxia",
     [90] = "sitaosantiao",
     [20] = "liuduiban",
     [11] = "sanshunzi",
     [10] = "santonghua"
    }

    local ani = sp.SkeletonAnimation:create("games/SSS/special_type/"..special_typeTble[special_type]..".json",
     "games/SSS/special_type/"..special_typeTble[special_type]..".atlas")

    ani:setAnimation(1, special_typeTble[special_type], false)
	ani:setPosition(display.cx,display.cy)	                       
    ani:registerSpineEventHandler(function (event)
             -- ani:runAction(cc.RemoveSelf:create())


              local playNode = gt.seekNodeByName(self.rootNode, "Node_play")
            gt.switchParentNode(imgCards[1]:getParent(),playNode,0)
           self:getOrignalCardData(imgCards[1]:getParent(),99,displaySeatIdx)
         for i = 1,13 do
            self:getComparison_CardData(imgCards[i],i,displaySeatIdx)
         end
        local special_zi =  imgCards[1]:getParent():getChildByName("special_zi")
         if special_zi then
            special_zi:setTexture(string.format("games/SSS/special_type/zi_%d.png",special_type))
         else
              special_zi  = cc.Sprite:create( string.format("games/SSS/special_type/zi_%d.png",special_type) )
              imgCards[1]:getParent():addChild(special_zi,1)
         end
         special_zi:setName("special_zi")
         special_zi:setOpacity(200)
         special_zi:setScale(0.4)
    --     special_zi:setPositionX( self.offPos[displaySeatIdx][1] - 20)
    --     special_zi:setPositionY( self.offPos[displaySeatIdx][2] + 10)

         special_zi:setVisible(true)


          local playerNode = self.playerNodes[displaySeatIdx]
          local lblScore = gt.seekNodeByName(playerNode, "Label_Score")
          dump(tScore)
         lblScore:setString( tostring(tScore))

         gt.delayRun(0,function (dt)
            m_mask:removeFromParent()
end)

         end, sp.EventType.ANIMATION_END)


         m_mask:addChild(ani,0)
         

     

    --gt.delayRun(2.5,function ()
--    ani:removeFromParent()
        

--end)

end


function PlaySceneSSS:AllShootAnimationShowCard(imgCards,displaySeatIdx) 
    local ani = sp.SkeletonAnimation:create("games/SSS/spine/quanleida.json", "games/SSS/spine/quanleida.atlas")

    ani:setAnimation(1, "quanleida", false)
	ani:setPosition(display.cx,display.cy)	                       
    ani:registerSpineEventHandler(function (event)
	     ani:runAction(cc.RemoveSelf:create())
     end, sp.EventType.ANIMATION_END)
     self:addChild(ani)

end

function PlaySceneSSS:ShootAnimation(seatIdx_1,seatIdx_2) 
    local Node_play = gt.seekNodeByName(self.rootNode, "Node_play")
    local posX,posY = gt.seekNodeByName(self.rootNode, "Node_playerInfo_" .. self.roomPlayers[seatIdx_1].displaySeatIdx):getPosition()
    local pos1 = {x = posX + gt.OffsetX ,y =posY + gt.OffsetY}
    local paiNode = self.cardViews[self.roomPlayers[seatIdx_2].displaySeatIdx].node
     local paiPosX = paiNode:getPositionX() 
      local paiPosY = paiNode:getPositionY() 
     local  pos2  = Node_play:convertToWorldSpace(cc.p(paiPosX,paiPosY)) 
      
    local  function qiangFun(shoot,pos1,pos2)
        local ani = sp.SkeletonAnimation:create("games/SSS/shoot/Shoot.json", "games/SSS/shoot/Shoot.atlas")

                                ani:setAnimation(1, shoot, false)
		                       ani:setTimeScale(2)
                                ani:registerSpineEventHandler(function (event)
				                   ani:runAction(cc.RemoveSelf:create())
			                    end, sp.EventType.ANIMATION_END)

                                if pos2 then
                                    
                                    if pos1.x >display.width/2 then
                                        ani:setScaleX(-1)
                                        local jiaodu = -sszCardTools:getAngleByPos(pos1,pos2)+180 + 10
                                        ani:setRotation(jiaodu)
                                        if jiaodu>90 and jiaodu<270 then
                                            ani:setScaleY(-1)
                                            ani:setRotation(jiaodu-20)
                                        end

                                    else
                                        local jiaodu = -sszCardTools:getAngleByPos(pos1,pos2)-10
                                        ani:setRotation(jiaodu)
                                        
                                        if (jiaodu >90 and jiaodu<180) or(jiaodu <-90 and jiaodu>-180) then
                                            ani:setScaleY(-1)
                                            ani:setRotation(jiaodu+20)
                                        end
                                    end
                                else
                                    math.randomseed(tostring(os.time()):reverse():sub(1, 7))
                                    pos1.x = pos1.x -10 + math.random(1,20)
                                    pos1.y = pos1.y -10 + math.random(1,20)
                                end

                                ani:setPosition(pos1.x, pos1.y)
	                            self.rootNode:addChild(ani)
end


                             gt.delayRun(1,function ()
                             qiangFun("Shoot",pos1,pos2)
                            end)

                         
                             gt.delayRun(1.3,function ()
                             gt.soundEngine:playEffect("SSS/daqiang3", false)
                             qiangFun("Shoot2",pos2)
                            end)

                            gt.delayRun(1.55,function ()
                            gt.soundEngine:playEffect("SSS/daqiang3", false)
                             qiangFun("Shoot2",pos2)
                            end)

                             gt.delayRun(1.78,function ()
                             gt.soundEngine:playEffect("SSS/daqiang3", false)
                             qiangFun("Shoot2",pos2)
                            end)

end


--提示亮牌
function PlaySceneSSS:onPromptShowCard(msgTbl)
    self.autoWaitTime = msgTbl.time
end

--玩家在线标识
function PlaySceneSSS:onRcvOffLineState(msgTbl)
	local seatIdx = msgTbl.seat + 1
	local roomPlayer = self.roomPlayers[seatIdx]
	local playerInfoNode = self.playerNodes[roomPlayer.displaySeatIdx]
	-- 离线标示
	local offLineSignSpr = gt.seekNodeByName(playerInfoNode, "Label_offline")
	offLineSignSpr:setLocalZOrder(20000)
	if msgTbl.flag == 0 then
		-- 掉线了
		offLineSignSpr:setVisible(true)
	elseif msgTbl.flag == 1 then
		-- 回来了
		offLineSignSpr:setVisible(false)
	end
end

--当前局数/最大局数量
function PlaySceneSSS:onRcvRoundState(msgTbl)
	-- 牌局状态,剩余牌
    gt.dump(msgTbl, "onRcvRoundState")
	local remainTilesLabel = gt.seekNodeByName(self.rootNode, "Label_Round")
	local stateNum = string.format("%d/%d", (msgTbl.round), msgTbl.rounds)
	remainTilesLabel:setString("第" .. stateNum .. "局")
    self.curRound = msgTbl.round
    if self.roundStateNode then
        self.roundStateNode:setVisible(true)
    end
    if msgTbl.round == msgTbl.rounds then
        self.lastRound = true
    end

end


--语音，表情，文字消息
function PlaySceneSSS:onRcvChatMsg(msgTbl)
	local weizhi = 0
    local seatIdx = msgTbl.seat + 1

    local function CDTime(imgPath, pos, parent)
        local sp = cc.Sprite:create(imgPath)
        local progressTimer = cc.ProgressTimer:create(sp)
        parent:addChild(progressTimer)
        progressTimer:setPosition(pos)
        progressTimer:setBarChangeRate(cc.p(1,0))
        progressTimer:setMidpoint(cc.p(1,0))
        progressTimer:setType(kCCProgressTimerTypeBar)
		local delayTime = cc.DelayTime:create(self.chatCD)
		local callFunc = cc.CallFunc:create(function(sender)
			sender:setEnabled(true)
		end)
		local seq = cc.Sequence:create(delayTime, callFunc)
		parent:runAction(seq)
        progressTimer:runAction(cc.Sequence:create(cc.ProgressFromTo:create(self.chatCD, 100, 0), cc.RemoveSelf:create()))
    end

	if msgTbl.type == gt.ChatType.VOICE_MSG then
		--语音
		gt.soundEngine:pauseAllSound()
		local url = msgTbl.url
		local videoTime = msgTbl.time / 1000.0
		self.yuyinChatNode:setVisible(true)
		self.rootNode:reorderChild(self.yuyinChatNode, 110)
		for i = 1, self.roomChairs do
			local chatBgImg = gt.seekNodeByName(self.yuyinChatNode, "Image_" .. i)
			chatBgImg:setVisible(false)
		end
		local roomPlayer = self.roomPlayers[seatIdx]
		if not roomPlayer then
			return
		end
		local chatBgImg = gt.seekNodeByName(self.yuyinChatNode, "Image_" .. roomPlayer.displaySeatIdx)
		chatBgImg:setVisible(true)
		self.yuyinChatNode:stopAllActions()
		local fadeInAction = cc.FadeIn:create(0.5)
		local delayTime = cc.DelayTime:create(videoTime)
		local fadeOutAction = cc.FadeOut:create(0.5)
		local callFunc = cc.CallFunc:create(function(sender)
			sender:setVisible(false)
			gt.soundEngine:resumeAllSound()
		end)
		self.yuyinChatNode:runAction(cc.Sequence:create(fadeInAction, delayTime, fadeOutAction, callFunc))
		extension.voicePlay(nil, url)
        --语音CD
        local path = "image/play/btn_voice_hui.png"
        local position = cc.p(self.yuyinBtn:getContentSize().width/2, self.yuyinBtn:getContentSize().height/2)
        CDTime(path, position, self.yuyinBtn)
    --扔表情特效
    elseif msgTbl.type == gt.ChatType.ACT_EMOJI then
        if cc.UserDefault:getInstance():getStringForKey("showProp") ~= "false" then
			self:showEmojiAnimation(msgTbl.msg, seatIdx, msgTbl.id, msgTbl.user_id)
		end
	else
		local chatBgNode = gt.seekNodeByName(self.rootNode, "Node_chatBg")
		chatBgNode:setVisible(true)
		local roomPlayer = self.roomPlayers[seatIdx]
		if not roomPlayer then
			return
		end
		local nodeChatBg = gt.seekNodeByName(chatBgNode, "Node_PlayerChatBg_" .. roomPlayer.displaySeatIdx)
        local emojiNode = gt.seekNodeByName(chatBgNode, "Node_Emoji_" .. roomPlayer.displaySeatIdx)
		local textContend = gt.seekNodeByName(nodeChatBg, "Text_Contend")
        local imgChatBg = gt.seekNodeByName(nodeChatBg, "Img_playerChatBg")
		weizhi = roomPlayer.displaySeatIdx
        local talk = {}
        local isTextMsg = false
        local isEmojiMsg = false

        --文字
        if msgTbl.type == gt.ChatType.FIX_MSG or msgTbl.type == gt.ChatType.INPUT_MSG then
            nodeChatBg:setVisible(true)
            emojiNode:setVisible(false)
            textContend:setString(msgTbl.msg)
            isTextMsg = true
            isEmojiMsg = false
            talk.type = msgTbl.type
            talk.nick = roomPlayer.nickname ..":"
            talk.content = string.format("%s", msgTbl.msg)
            if #self.ChatLog > 49 then
				table.remove(self.ChatLog,1)
			end
			table.insert(self.ChatLog, talk)
            if msgTbl.type == gt.ChatType.FIX_MSG then
                local playerFixEffect = "man/f"
                --local playerMe = self.roomPlayers[self.playerSeatIdx]
                if roomPlayer.sex == 2 then
                    playerFixEffect = "woman/f"
                end
                for i = 1 ,6 do
                    if msgTbl.msg == gt.getLocationString("LTKey_0028_" .. i) then
                        gt.soundEngine:playEffect(playerFixEffect..i, false)
                        break
                    end
                end
            end

        --表情
        elseif msgTbl.type == gt.ChatType.EMOJI then
            emojiNode:setVisible(true)
            nodeChatBg:setVisible(false)
            ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("image/Chat/emoji/"..msgTbl.msg..".ExportJson")
	        local ar = ccs.Armature:create(msgTbl.msg)
            ar:getAnimation():play("Animation2")
            ar:setScale(0.7)
            gt.soundEngine:playEffect("chat/"..msgTbl.msg, false)
	        emojiNode:addChild(ar)
            isTextMsg = false
            isEmojiMsg = true
            talk.type = msgTbl.type
            talk.nick = roomPlayer.nickname ..":"
            talk.content = string.format("%s", msgTbl.msg)
            if #self.ChatLog > 49 then
				table.remove(self.ChatLog,1)
			end
			table.insert(self.ChatLog, talk)
        end

		if isTextMsg == true then
            nodeChatBg:stopAllActions()
            nodeChatBg:setPosition(self.chat_bg_pos[roomPlayer.displaySeatIdx].x, self.chat_bg_pos[roomPlayer.displaySeatIdx].y)
            nodeChatBg:runAction(cc.FadeIn:create(0.01))
			local msgLabel_delayTime1 = cc.DelayTime:create(1)
			local msgLabel_moveto = cc.MoveTo:create(1,cc.p(self.chat_bg_pos[roomPlayer.displaySeatIdx].x, self.chat_bg_pos[roomPlayer.displaySeatIdx].y + 25))
            local msgLabel_delayTime2 = cc.DelayTime:create(1)
            local msgLabel_fadeout = cc.FadeOut:create(1)
            local msgLabel_dismiss = cc.Spawn:create(msgLabel_delayTime2, msgLabel_fadeout)
			local msgLabel_callFunc = cc.CallFunc:create(function(sender)
				nodeChatBg:setVisible(false)
			end)
			local msgLabel_Sequence = cc.Sequence:create(msgLabel_delayTime1,
                                                        msgLabel_moveto,
														msgLabel_dismiss,
														msgLabel_callFunc,
                                                        msgLabel_fadein)
			nodeChatBg:runAction(msgLabel_Sequence)
        elseif isEmojiMsg == true then
            local msgLabel_delayTime = cc.DelayTime:create(2)
			local msgLabel_callFunc = cc.CallFunc:create(function(sender)
				sender:setVisible(false)
                sender:removeAllChildren()
			end)
			local msgLabel_Sequence = cc.Sequence:create(msgLabel_delayTime,
														msgLabel_callFunc)
            emojiNode:setVisible(true)
            emojiNode:runAction(msgLabel_Sequence)
		end
	end

	if weizhi == 1 then
		self.chatBtn:setEnabled(false)
        CDTime("image/play/btn_chat_hui.png", cc.p(self.chatBtn:getContentSize().width/2, self.chatBtn:getContentSize().height/2), self.chatBtn)
	end
end

function PlaySceneSSS:showGunAnimation()
	if cc.UserDefault:getInstance():getStringForKey("showProp") ~= "false" then
		gt.soundEngine:playEffect("emoji_act/gunshootFX", false)
		local aniNode, action = gt.createCSAnimation("image/play/mj_biaoqingefect/gunshootFX.csb")
		action:gotoFrameAndPlay(0,false)
		action:setFrameEventCallFunc(function (frameEventName)
			local frameName = frameEventName:getEvent()
			if (frameName == "endAni") then
				aniNode:removeFromParent()
			end
		end)
		self:addChild(aniNode)
		aniNode:setPosition(cc.p(800,300))
	end
end

--单局结算
function PlaySceneSSS:onRcvRoundReport(msgTbl)
	if self:getChildByName("NoticeTips") then
		self:removeChildByName("NoticeTips")
	end
	
	--self.lbWatingTip:setString("等待其他玩家准备...")
    self.bgWaitingTip:setVisible(false)
    self:ComparisonCard(msgTbl)
--	gt.log("游戏结束")
--    gt.dump(msgTbl, "onRcvRoundReport")

--        -- 隐藏玩家等待提示
        self:hidePlayersWaitSign()
--        --把所有桌子上的点了准备玩家状态置为参与者
        for key, var in pairs(self.roomPlayers) do
            if not var.isWait then
                --不是预准备的隐藏准备标识
                local readySignSpr = self.readySigns[var.displaySeatIdx]
	            readySignSpr:setVisible(false)
            end

            if (var.uid == gt.playerData.uid) then
                if var.isWait and var.state == PLAYER_STATE.READY_WAIT then
                    self.isWait = false
                    --隐藏观战牌
                    self.imgGuanZhan:setVisible(false)
                    -- 隐藏牌型
                    --self:hideSigns()
                    self.inviteFriendBtn:setVisible(false)
                else
                    -- 不是预准备的显示准备按钮
--                    local lbReady = gt.seekNodeByName(self.readyBtn, "lblReady")
--                    lbReady:setString("准  备")
--					if not self.lastRound then
--						self.readyBtn:loadTextureNormal("image/play/btn_ready.png")
--						self.readyBtn:setVisible(true)
--					end
                end
            end
			if var.state == PLAYER_STATE.READY_WAIT then
				var.isWait = false
			end
        end
        self.waitType = WAIT_TYPE.READY

end

-- 显示金币飞行动画
function PlaySceneSSS:showCoinFlyTo(count, delay, fromPos, toPos, fromDisplayIdx, toDisplayIdx)
    local addScore = count

    local maxDelayTime = 0
	for i = 1, 10 do
		local sp = cc.Sprite:create("image/play/money_pin.png")
		local pos1 = cc.p(fromPos.x + gt.OffsetX + math.random(-16, 16), fromPos.y + gt.OffsetY + math.random(-16, 16))
		local pos2 = cc.p(toPos.x + gt.OffsetX + math.random(-4, 4), toPos.y + gt.OffsetY + math.random(-4, 4))
		local dis = cc.pGetDistance(fromPos, toPos)
		if dis > 700 then dis = 700 end
		sp:setPosition(pos1)
		local delayTime = (i-1)*0.04
		sp:runAction(cc.Sequence:create(cc.Hide:create(), cc.DelayTime:create(delay+delayTime),
        cc.Show:create(), cc.MoveTo:create(dis/1000, pos2), cc.RemoveSelf:create()))
		self.rootNode:addChild(sp)
        if (maxDelayTime < (dis/1000 + delayTime + delay)) then
            maxDelayTime = dis/1000 + delayTime + delay
        end
	end

	self:runAction(cc.Sequence:create(cc.DelayTime:create(delay), cc.CallFunc:create(function()
			gt.soundEngine:playEffect("common/fly_gold", false)
		end)))

    local callFun2 = function ()
        if (toDisplayIdx == self.roomPlayers[self.bankerSeatIdx].displaySeatIdx) then
            --是自己飞向庄家  飘自己减少的分
            self:playAddScoreAni(fromDisplayIdx, 0-addScore)
        else
            --是庄家飞向自己 飘自己增加的分
            self:playAddScoreAni(toDisplayIdx, addScore)
        end
    end
    self:runAction(cc.Sequence:create(cc.DelayTime:create(maxDelayTime), cc.CallFunc:create(callFun2)))
end

function PlaySceneSSS:playAddScoreAni(playerIdx, addScore)
    local lbAddScore = self.playerAddSocre[playerIdx]
    lbAddScore:setPosition(0,0)
    lbAddScore:setOpacity(255)
    lbAddScore:setTextColor(cc.c3b(255,247,104))  --黄色
    lbAddScore:setString("+"..addScore)
    if addScore < 0 then
        lbAddScore:setTextColor(cc.c3b(1,229,251))  --蓝色
        lbAddScore:setString(""..addScore)
    end
    local lbPos = cc.p(0, 12)
    lbAddScore:runAction(cc.Sequence:create(cc.Show:create(),cc.MoveBy:create(0.8,lbPos), cc.FadeOut:create(0.2)))
end

function PlaySceneSSS:copyTab(st)
    local tab = {}
    for k, v in pairs(st or {}) do
        if type(v) ~= "table" then
            tab[k] = v
        else
            tab[k] = self:copyTab(v)
        end
    end
    return tab
end

--总结算
function PlaySceneSSS:onRcvFinalReport(msgTbl)
	if self:getChildByName("NoticeTips") then
		self:removeChildByName("NoticeTips")
	end
	
    --发送关闭解散房间事件
   if msgTbl and msgTbl.flag ~= 0 and self.dajiesuanMsgTble == nil then
    	--发送关闭解散房间事件
	    if self.lastRound == true  and self.dajiesuanMsgTble == nil then
	        self.dajiesuanMsgTble =  msgTbl
	        return 
	    end
    end

   if msgTbl == nil  then
     msgTbl = self.dajiesuanMsgTble
     self.dajiesuanMsgTble = nil
   end
   
      
    gt.dispatchEvent(gt.EventType.CLOSE_APPLY_DISMISSROOM)
	--比赛不弹大结算界面
	if self.isMatch>0 then
		local resultEffectDelay = self.showCardAniTime + 3
		if msgTbl.flag == 0 then -- 投票结算
			resultEffectDelay = 2
		end

		self:runAction(cc.Sequence:create(cc.DelayTime:create(resultEffectDelay),cc.CallFunc:create(function(sender)
			self.IsNewGame = true
			gt.dispatchEvent(gt.EventType.PLAY_SCENE_RESTART)
		end)))
		self.LastFinalReport={}
		self.LastFinalReport.roomPlayers=self:copyTab(self.roomPlayers)
		self.LastFinalReport.roomID=self.roomID
		self.LastFinalReport.guildID=self.guildID
		self.LastFinalReport.isMatch=self.isMatch
		self.LastFinalReport.msgTbl=msgTbl
		self.LastFinalReport.tableSetting=self.tableSetting
		gt.addBtnPressedListener(self.Btn_ViewFinalReport,function (sender)
			-- 弹出总结算界面
			local finalReport = require("app/views/FinalReport"):create(self.LastFinalReport.roomID, self.LastFinalReport.guildID, self.LastFinalReport.isMatch, self.LastFinalReport.roomPlayers, self.LastFinalReport.msgTbl, self.LastFinalReport.tableSetting)
			self:addChild(finalReport, PlaySceneSSS.ZOrder.REPORT)
		end)
	else
	--	self.lastRound = true
		self.roomState = ROOM_STATE.SETTLE_ROOM
		self.readyBtn:setVisible(false)
        self.Btn_ShowResult:setVisible(false)
		if self:getChildByName("GameBrief") then
			self:removeChildByName("GameBrief")
		end
		gt.log("总结算界面提示")
		local curRoomPlayers = {}
		curRoomPlayers = self:copyTab(self.roomPlayers)

		local callFunc = cc.CallFunc:create(function(sender)
			-- -- 弹出总结算界面
			local finalReport = require("app/views/FinalReport"):create(self.roomID, self.guildID, self.isMatch, curRoomPlayers, msgTbl, self.tableSetting)
			self:addChild(finalReport, PlaySceneSSS.ZOrder.REPORT)
		end)
		local resultEffectDelay = self.showCardAniTime+1
		if msgTbl.flag == 0 then -- 投票结算
			resultEffectDelay = 0
			local seqAction = cc.Sequence:create(cc.DelayTime:create(2.0), callFunc)
			self:runAction(seqAction)
		else -- 正常结算
			local seqAction = cc.Sequence:create(cc.DelayTime:create(self.showCardAniTime+3), callFunc)
			self:runAction(seqAction)
		end

		--观战者不显示胜利失败特效
		if (not self.isWait) then
			local win = false
			for i, v in ipairs(msgTbl.player_data) do
				local seatIdx = v.seat + 1
				if seatIdx == self.playerSeatIdx then
					if v.score >= 0 then
						win = true
					end
					break
				end
			end
			local callFunc2 = function()
				self:showResultEffect(win)
			end
			self:runAction(cc.Sequence:create(cc.DelayTime:create(resultEffectDelay), cc.CallFunc:create(callFunc2)))
		end
	end
end

-- 显示胜负动画
function PlaySceneSSS:showResultEffect(win)
	local sk
	if win then
		sk = sp.SkeletonAnimation:create("image/play/effect/win.json", "image/play/effect/win.atlas")
		sk:setAnimation(0, "win", false)
        gt.soundEngine:playEffect("common/win", false)
	else
		sk = sp.SkeletonAnimation:create("image/play/effect/lose.json", "image/play/effect/lose.atlas")
		sk:setAnimation(0, "lose", false)
        gt.soundEngine:playEffect("common/lose", false)
	end
	sk:registerSpineEventHandler(function (event)
			sk:runAction(cc.RemoveSelf:create())
		end, sp.EventType.ANIMATION_END)
	sk:setPosition(gt.winCenter.x, gt.winCenter.y)
	self:addChild(sk, 1000)
end

-- 房间创建者解散房间
function PlaySceneSSS:onRcvDismissRoom(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 1 then -- 房主直接解散
		require("app/views/NoticeTips"):create("提示", "房主已解散房间", function() gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE) end, function() gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE) end, true)
	elseif msgTbl.code == 2 then  -- 投票解散
		require("app/views/NoticeTips"):create("提示", "房间已解散", function() gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE) end, function() gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE) end, true)
	elseif msgTbl.code == 0 then  -- 大结算后解散
	end
	self.dismissed = true

	gt.socketClient:close()
	if self.sportId and self.sportId > 0 then
		gt.socketClient:connect(gt.LoginServer.ip, gt.LoginServer.port, true)
		local msgToSend = {}
		msgToSend.cmd = gt.LOGIN_USERID
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		gt.socketClient:sendMessage(msgToSend)
	end
end

function PlaySceneSSS:onRcvSponorVote(msgTbl)
    --gt.log("onRcvSponorVote...==========")
    self.autoTimePause = true

	msgTbl.players = {}
	for i, v in pairs(self.roomPlayers) do
		if not v.isWait then
			local player = {uid = v.uid, nickname=v.nickname, headURL=v.headURL,sex=v.sex}
			table.insert(msgTbl.players, player)
		end
	end

	--解散房间
    local applyDimissRoom = self:getChildByTag(1000099)
    if not applyDimissRoom then
	    applyDimissRoom = require("app/views/ApplyDismissRoom"):create(msgTbl, self.isWait)
	    self:addChild(applyDimissRoom, PlaySceneSSS.ZOrder.DISMISS_ROOM, 1000099)
    end
end

function PlaySceneSSS:onRcvVote(msgTbl)
	local player = msgTbl.player
    local flag = msgTbl.flag
    gt.dispatchEvent(gt.EventType.APPLY_DIMISS_ROOM, msgTbl)

    if not msgTbl.flag then
        --有人拒绝解散了,开启自动托管
        self.autoTimePause = false
    end
end

function PlaySceneSSS:onRcvSyncScore(msgTbl)
	local player = msgTbl.player
	for i, v in pairs(self.roomPlayers) do
		if v.uid == player then
			v.score = msgTbl.score
			local displaySeatIdx = v.displaySeatIdx
			local playerNode = self.playerNodes[displaySeatIdx]
			local lblScore = gt.seekNodeByName(playerNode, "Label_Score")
			dump(v.score)
			lblScore:setString(tostring(v.score))
			break
		end
	end
end

function PlaySceneSSS:onRcvScoreLeak(msgTbl)
	require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, "积分不足，无法参与比赛", nil, nil, true)
	self.readyBtn:setVisible(true)
	if self:getChildByName("GameBrief") then
		self:removeChildByName("GameBrief")
	end
end

--更新当前时间
function PlaySceneSSS:updateCurrentTime()
	local timeLabel = gt.seekNodeByName(self.rootNode, "Label_Time")
	local curTimeStr = os.date("%X", os.time())
	local timeSections = string.split(curTimeStr, ":")
	-- 时:分
	timeLabel:setString(string.format("%s:%s", timeSections[1], timeSections[2]))
end

--更新电量和网络状态
function PlaySceneSSS:updateBatteryAndNetwork()
    local bg = gt.seekNodeByName(self.rootNode, "Img_NetworkBg")
	local barBattery = gt.seekNodeByName(self.rootNode, "LoadingBar_Battery")
	local lblNetwork = gt.seekNodeByName(self.rootNode, "Label_Network")
    local imgNetwork = gt.seekNodeByName(self.rootNode, "Img_Network")

	if not barBattery or not lblNetwork then return end

	if gt.isAndroidPlatform() then
		local function setBattery(respJson)
--			lblBattery:setString(string.format("电量:%d", respJson.code))
            barBattery:setPercent(tonumber(respJson.code))
		end
		extension.get_Battery(setBattery)
	else
		local battery = extension.get_Battery()
--		lblBattery:setString(string.format("电量:%d", battery))
        barBattery:setPercent(battery)
	end

    cc.SpriteFrameCache:getInstance():addSpriteFrames("image/play/netandbattery.plist")
	local ping = gt.socketClient:getLastReplayInterval()
	lblNetwork:setString(string.format("%dms", math.floor(ping*1000)))
    local pingValue = math.floor(ping*1000)
	local desktop = cc.UserDefault:getInstance():getStringForKey("Desktop")
    if pingValue <= 100 then
        if self.roomChairs == 6 then
            lblNetwork:setTextColor(cc.c3b(0, 128, 0))
            imgNetwork:loadTexture("image/play/network_23.png", ccui.TextureResType.plistType)
        else
            imgNetwork:loadTexture("image/play/network_33.png", ccui.TextureResType.plistType)
            lblNetwork:setTextColor(cc.c3b(25, 196, 67))
        end
    elseif pingValue > 100 and pingValue <= 500 then
        if self.roomChairs == 6 then
            lblNetwork:setTextColor(cc.c3b(255, 182, 0))
            imgNetwork:loadTexture("image/play/network_22.png", ccui.TextureResType.plistType)
        else
            imgNetwork:loadTexture("image/play/network_32.png", ccui.TextureResType.plistType)
            lblNetwork:setTextColor(cc.c3b(254, 224, 82))
        end
    else
        if self.roomChairs == 6 then
            lblNetwork:setTextColor(cc.c3b(254, 64, 64))
            imgNetwork:loadTexture("image/play/network_21.png", ccui.TextureResType.plistType)
        else
            imgNetwork:loadTexture("image/play/network_31.png", ccui.TextureResType.plistType)
            lblNetwork:setTextColor(cc.c3b(245, 63, 62))
        end
    end
end


--房间添加玩家
function PlaySceneSSS:roomAddPlayer(roomPlayer)
	-- 播放声音
	self.playCDAudioID = gt.soundEngine:playEffect("common/audio_enter_room",false)

	local playerInfoNode = gt.seekNodeByName(self.rootNode, "Node_playerInfo_" .. roomPlayer.displaySeatIdx)
	playerInfoNode:setVisible(true)
    --是等待加入者
    if (roomPlayer.isWait) then
        local lbWait = gt.seekNodeByName(playerInfoNode, "Label_Wait")
        lbWait:setVisible(true)
    end
	-- 头像
    local headSpr = gt.seekNodeByName(playerInfoNode, "Spr_Head")
    if roomPlayer.headURL ~= "" then
	    self.playerHeadMgr:attach(headSpr, roomPlayer.uid, roomPlayer.headURL)
            -- 头像出现动画
	    local orbit = cc.OrbitCamera:create(0.5, 0.3, 0, 0, 360, 0, 0)
	    headSpr:runAction(orbit)
    else
		self.playerHeadMgr:resetHeadSpr(headSpr)
	end
	-- 昵称
	local nicknameLabel = gt.seekNodeByName(playerInfoNode, "Label_Nick")
	-- 名字只取四个字,并且清理掉其中的空格
	local nickname = string.gsub(roomPlayer.nickname," ","")
	nickname = string.gsub(nickname,"　","")
	nicknameLabel:setString(gt.checkName(nickname,4))
	-- 积分
	local scoreLabel = gt.seekNodeByName(playerInfoNode, "Label_Score")
	if roomPlayer.total_score then
		scoreLabel:setString(tostring(roomPlayer.total_score))
	else
		scoreLabel:setString(tostring(roomPlayer.score))
	end
	
	roomPlayer.scoreLabel = scoreLabel
	-- 离线标示
	--local offLineSignSpr = gt.seekNodeByName(playerInfoNode, "Spr_offLineSign")
	--offLineSignSpr:setVisible(false)
	-- 庄家
	local bankerSignSpr = gt.seekNodeByName(playerInfoNode, "Spr_bankerSign")
     if bankerSignSpr then
	    bankerSignSpr:setVisible(false)
    end

    -- 点击头像显示信息
	local headFrameBtn = gt.seekNodeByName(playerInfoNode, "Panel_HeadFrame")
	headFrameBtn:setTag(roomPlayer.seatIdx)
    headFrameBtn:removeObjectAllHandlers()
	headFrameBtn:addClickEventListener(handler(self, self.showPlayerInfo))

    -- 添加入缓冲
	self.roomPlayers[roomPlayer.seatIdx] = roomPlayer

	-- 准备标示
	if self.roomState <= ROOM_STATE.READY and roomPlayer.state == PLAYER_STATE.READY then
		self:playerGetReady(roomPlayer.seatIdx)
	end
end

-- 房间信息按钮回调
function PlaySceneSSS:infoBtnClickEvt()
	local roomInfo = require("app/views/RoomInfo"):create(self.tableSetting,nil,nil,function (csbNode)
        dump(self.tableSetting,5)
        local lbScore = gt.seekNodeByName(csbNode, "lbScore")
        lbScore:setString(self.tableSetting.score)

      local lbRoomRule =   gt.seekNodeByName(csbNode, "lbRoomRule")
        lbRoomRule:setString("")
        if self.tableSetting.pay == 2 then
            lbRoomRule:setString(lbRoomRule:getString().." AA开房")
        else
            lbRoomRule:setString(lbRoomRule:getString().." 房主付费")
        end
        if self.tableSetting.compare_type and self.tableSetting.compare_type == 1 then
            lbRoomRule:setString(lbRoomRule:getString().." 比花色")
        end

        if self.tableSetting.mapai and  (self.tableSetting.mapai ~= 1 or self.tableSetting.mapai ~= 0 )then
            lbRoomRule:setString(lbRoomRule:getString().." 马牌为"..self.tableSetting.mapai)
        end

        if self.tableSetting.gun and  self.tableSetting.gun == 1 then
            lbRoomRule:setString(lbRoomRule:getString().." 计分+1")
       elseif  self.tableSetting.gun and self.tableSetting.gun == 0 then
            lbRoomRule:setString(lbRoomRule:getString().." 计分X2")
        end

        if self.tableSetting.lipai then
            lbRoomRule:setString(lbRoomRule:getString().." 理牌时间"..self.tableSetting.lipai.."s")
        end

        local tt = {"至尊青龙","一条龙","三同花顺","三分天下","四套三条","六对半","三顺子","三同花","头金头顺","倒水罚分"}
      local lbRoomSpecial = gt.seekNodeByName(csbNode, "lbRoomSpecial")
      lbRoomSpecial:setString("")
     for i=1 , #tt do
     if  string.sub(self.tableSetting.options,i,i) == "1" then
        lbRoomSpecial:setString(lbRoomSpecial:getString().." "..tt[i])
     end 
    end

end)    
	self:addChild(roomInfo, PlaySceneSSS.ZOrder.SETTING)
end

--发送玩家准备请求消息
function PlaySceneSSS:readyBtnClickEvt()
    self.readyBtn:setVisible(false)
    self.Btn_ShowResult:setVisible(false)
	if self:getChildByName("GameBrief") then
		self:removeChildByName("GameBrief")
	end
	
	local msgToSend = {}
	msgToSend.cmd = gt.READY
	gt.socketClient:sendMessage(msgToSend)
end

-- 开始游戏
function PlaySceneSSS:startBtnClickEvt()
	self.startBtn:setVisible(false)
	local msgToSend = {}
	msgToSend.cmd = gt.START_DN
	gt.socketClient:sendMessage(msgToSend)
end

-- 点击亮牌
function PlaySceneSSS:showCardBtnClickEvt()
	self.showCardBtn:setVisible(false)

	local msgToSend = {}
	msgToSend.cmd = gt.SHOW_CARD_DN
	gt.socketClient:sendMessage(msgToSend)
end

-- 点击翻牌
function PlaySceneSSS:openCardBtnClickEvt()
	self.openCardBtn:setVisible(false)
	local playerMe = self.roomPlayers[self.playerSeatIdx]
	self:showHandCards(true, playerMe.displaySeatIdx, playerMe.cards_in_hand, playerMe.cardsign_in_hand, nil, nil)
	if not self:isBanker() or self.tableSetting.game_type == gt.GameType.GAME_TOGETHER then
		self.showCardBtn:setVisible(true)
	end
end

--玩家进入准备状态
function PlaySceneSSS:playerGetReady(seatIdx)
	local roomPlayer = self.roomPlayers[seatIdx]
    --玩家状态改成准备状态
    roomPlayer.state = PLAYER_STATE.READY
    roomPlayer.pledge = 0
    roomPlayer.isWait = false
    local lbWait = self.playerWaitSigns[roomPlayer.displaySeatIdx]
    lbWait:setVisible(false)

	-- 显示玩家准备手势
--	local readySignNode = gt.seekNodeByName(self.rootNode, "Node_readySign")
--	readySignNode:setLocalZOrder(1000000)
	local readySignSpr = self.readySigns[roomPlayer.displaySeatIdx]
	readySignSpr:setVisible(true)
	-- 玩家本身
	if seatIdx == self.playerSeatIdx then
        self.imgGuanZhan:setVisible(false)
        self.isWait = false
        self.chatBtn:setVisible(true)
        self.yuyinBtn:setVisible(true)
--        local lbReady = gt.seekNodeByName(self.readyBtn, "lblReady")
--        lbReady:setString("准  备")
        self.readyBtn:loadTextureNormal("image/play/btn_ready.png")
		-- 隐藏准备按钮
        self.readyBtn:stopAllActions()
		self.readyBtn:setVisible(false)
        self.Btn_ShowResult:setVisible(false)
		if self:getChildByName("GameBrief") then
			self:removeChildByName("GameBrief")
		end
        self:hideSigns()

        if (self.curRound <= 1 and self.roomState <= ROOM_STATE.START) then
            if (self:isBanker()) then
                if self.roomState == ROOM_STATE.INIT then
                    --准备后自己是庄家  则提示等待其他玩家准备
                    self.lbWatingTip:setString("等待其他玩家准备...")
                    self.bgWaitingTip:setVisible(true)
                end
            else
                --准备后自己不是庄家则不显示开始按钮，则提示等待房主开始游戏
                local roomPlayerBanker = self.roomPlayers[self.bankerSeatIdx]
                if roomPlayerBanker then
                    local tip = string.format("等待%s开始游戏...", roomPlayerBanker.nickname)
                    self.lbWatingTip:setString(tip)
                    self.bgWaitingTip:setVisible(true)
                end
            end
        end
	end
end

--隐藏所有玩家准备手势标识
function PlaySceneSSS:hidePlayersReadySign()
	for i = 1, self.roomChairs do
		self.readySigns[i]:setVisible(false)
	end
end

--隐藏所有玩家庄家标识
function PlaySceneSSS:hidePlayersBankerSign()
    for i = 1, self.roomChairs do
        local playerInfoNode = gt.seekNodeByName(self.rootNode, "Node_playerInfo_"..i)
        local bankerSignSpr = gt.seekNodeByName(playerInfoNode, "Spr_bankerSign")
        if bankerSignSpr then
            bankerSignSpr:setVisible(false)
        end
        local robZhuangSpr = self.playerRobZhuangFrames[i]
        robZhuangSpr:setVisible(false)
    end
end

--隐藏所有玩家等待标识
function PlaySceneSSS:hidePlayersWaitSign()
    for i = 1, self.roomChairs do
        local lbWait = self.playerWaitSigns[i]
        lbWait:setVisible(false)
    end
end

--隐藏所有玩家抢庄亮框图
function PlaySceneSSS:hidePlayersRobZhuangFrame()
    for i = 1, self.roomChairs do
        local robZhuangSpr = self.playerRobZhuangFrames[i]
        robZhuangSpr:stopAllActions()
        robZhuangSpr:setVisible(false)
    end
end

--隐藏牛类型并停止相应动作
function PlaySceneSSS:hideNiuTypeActions()
    self.cardShowQueue = {}
    for i = 1, self.roomChairs do
        self.cardViews[i].imgScore:stopAllActions()
    end
end

--隐藏牌型并停止相应动作
function PlaySceneSSS:hideCardViewsActions()
    for i = 1, self.roomChairs do
	    self.cardViews[i].node:setVisible(false)
--        for j = 1, #self.cardView.imgCards do
--            self.cardView.imgCards[j]:stopAllActions()
--        end
    end
end

--隐藏牌型
function PlaySceneSSS:hideCardViews()
    for i = 1, self.roomChairs do
        self.cardViews[i].node:setVisible(false)
    end
end

--清除牛牛特效
function PlaySceneSSS:clearNiuEffect()
    for i = 1, self.roomChairs do
        local cardView = self.cardViews[i]
		cardView.effectNode:removeAllChildren()
    end
end

-- 每局准备后隐藏相应标识
function PlaySceneSSS:hideSigns()
    -- 隐藏牌型
    self:hideCardViews()
    --清除牛牛特效
    self:clearNiuEffect()
    -- 如果是抢庄牛牛 每小局结算后隐藏庄家标识
    if (self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER or self.tableSetting.game_type == gt.GameType.GAME_FREE_BANKER) then
        self:hidePlayersBankerSign()
    end
end

--重置牌型位置
function PlaySceneSSS:resetCardsPos()
	for i = 1, self.roomChairs do
		for j = 1, 5 do
			local pos = self.cardViews[i].imgCards[j].imgCardPos
            self.cardViews[i].imgCards[j]:setPosition(pos)
		end
    end
end

--重置手牌明暗标识
function PlaySceneSSS:resetCardSigns()
    for key, var in pairs(self.roomPlayers) do
        var.cardsign_in_hand = self.cardSignInHandInit
    end

	for i = 1, self.roomChairs do
		for j = 1, 5 do
            if self.cardViews[i].imgCards[j] then
                self.cardViews[i].imgCards[j]:setColor(cc.c3b(255,255,255))
            end
		end
    end
end

--房间是否已坐满员
function PlaySceneSSS:isSeatFull()
    local bFull = false
    local playerNum = gt.getTableSize(self.roomPlayers)
    if (self.roomChairs == gt.GameChairs.SIX and playerNum == gt.GameChairs.SIX) or (self.roomChairs == gt.GameChairs.TEN and playerNum == gt.GameChairs.TEN) then
        bFull = true
    end

    return bFull
end

--设置亮牌时牌型明暗显示 0标识暗，1标识亮（牛1到牛牛葫芦牛：3+2，炸弹4+1）
function PlaySceneSSS:setShowCardsShow(displaySeatIdx, cardsigns)
    local cardView = self.cardViews[displaySeatIdx]
    for i = 1, #cardsigns do
        if cardsigns[i] == 1 then
            cardView.imgCards[i]:setColor(cc.c3b(255,255,255))
        else
            cardView.imgCards[i]:setColor(cc.c3b(174,174,174))
        end
    end
end

--设置亮牌时牌型的位置（牛1到牛牛葫芦牛：3+2，炸弹4+1）
function PlaySceneSSS:setShowCardsPos(niuType, displaySeatIdx)
    local cardView = self.cardViews[displaySeatIdx]
    local playerMe = self.roomPlayers[self.playerSeatIdx]
    local bFull = self:isSeatFull()
    --先把自己的牌间距重新设置
    if not self.isWait and playerMe~= nil and playerMe.displaySeatIdx == displaySeatIdx then
        for i = 1, 5 do
            local posX = -100 + (i-1)*50
            cardView.imgCards[i]:setPositionX(posX)
        end
    end
    --如果房间已坐满时你是观战者
    if self.isWait and bFull and displaySeatIdx == 1 then
        for i = 1, 5 do
            local posX = -100 + (i-1)*50
            cardView.imgCards[i]:setPositionX(posX)
        end
    end

    local posX4, posX5, offX
    if ((niuType >= gt.NIU_TYPE.NIU_1 and niuType <= gt.NIU_TYPE.NIU_NIU) or niuType == gt.NIU_TYPE.GOURD) then
        --3+2牌型
        if not self.isWait and playerMe~= nil and playerMe.displaySeatIdx == displaySeatIdx then
            offX = 35
        else
            offX = 25
        end
        --如果房间已坐满时你是观战者
        if self.isWait and bFull and displaySeatIdx == 1 then
            offX = 35
        end
        posX4 = cardView.imgCards[4]:getPositionX() + offX
        posX5 = cardView.imgCards[5]:getPositionX() + offX
        cardView.imgCards[4]:setPositionX(posX4)
        cardView.imgCards[5]:setPositionX(posX5)
    elseif (niuType == gt.NIU_TYPE.BOMB) then
        --4+1牌型
        if not self.isWait and playerMe~= nil and playerMe.displaySeatIdx == displaySeatIdx then
            offX = 40
        else
            offX = 30
        end
        --如果房间已坐满时你是观战者
        if self.isWait and bFull and displaySeatIdx == 1 then
            offX = 40
        end
        posX5 = cardView.imgCards[5]:getPositionX() + offX
        cardView.imgCards[5]:setPositionX(posX5)
    end
end

-- 显示玩家具体信息面板
function PlaySceneSSS:showPlayerInfo(sender)
    gt.soundEngine:playEffect(gt.clickBtnAudio, false)
	local senderTag = sender:getTag()
	local roomPlayer = self.roomPlayers[senderTag]
	if not roomPlayer then
		return
	end
    local shpwType = 2
    if self.isWait then
        shpwType = 1
    end
	local playerInfoTips = require("app/views/PlayerInfoTips"):create(roomPlayer, shpwType)
	self:addChild(playerInfoTips, PlaySceneSSS.ZOrder.PLAYER_INFO_TIPS)
end


--出牌倒计时
function PlaySceneSSS:playTimeCDStart(timeDuration,appear)
	self.playTimeCD = timeDuration
	self.playTimeCDLabel:setVisible(appear)
	self.playTimeCDLabel:setString(tostring(timeDuration))
end

--更新出牌倒计时
function PlaySceneSSS:playTimeCDUpdate(delta)
	if not self.playTimeCD then
		return
	end
	self.playTimeCD = self.playTimeCD - delta
	if self.playTimeCD < 0 then
		self.playTimeCD = 0
	end
	if self.playTimeCD <= 3 and not self.isVibrateAlarm then
		-- 剩余3s开始播放警报声音+震动一下手机
		self.isVibrateAlarm = true
		-- 播放声音
		self.playCDAudioID = gt.soundEngine:playEffect("common/timeup_alarm",false)
		-- 震动提醒
        if cc.UserDefault:getInstance():getStringForKey("Shock") == "true" then
		    cc.Device:vibrate(1)
        end
	end
	local timeCD = math.ceil(self.playTimeCD)
	self.playTimeCDLabel:setString(tostring(timeCD))
end

--将消息转换为花色和牌型
function PlaySceneSSS:changePk(poker)
	local value
	if poker < 44 then
		local x =  math.modf(poker / 4)
		value = math.modf((x + 3) % 14)
	elseif poker <= 47 then
		value = 1
	elseif poker == 51 then
		value = 2
	end
	local color =  math.modf(poker % 4)
	return value , color
end

function PlaySceneSSS:rubCardOverEvt()
    self:openCardBtnClickEvt()
end

function PlaySceneSSS:playSceneResetEvt()
	if not self.IsReplay then
		gt.log("playSceneResetEvt")
		--从后台回来先清除下之前缓存的消息
		gt.socketClient:clearMessage()
		--这里清掉数据不清掉界面
		--比赛场中如果在最后一局断线重连不会不会收到断线重连的消息
		if self.isMatch and self.curRound>=self.tableSetting.rounds then
			self.isWait = true
			self.playerSeatIdx = -1
			self.bankerSeatIdx = -1
			self.roomPlayers = {}
			self.roomState = ROOM_STATE.INIT
			self.relogining = false
			self.cardShowQueue = {}
			self.cardShowDelay = 0
		end
		self:reLogin()
	end
end

function PlaySceneSSS:reInitScene()
     local playNode = gt.seekNodeByName(self.rootNode, "Node_play")
        local cardView = self.cardViews[1]
        local cardPar = cardView.imgCards[1]:getParent()
        cardPar:setVisible(true)
        gt.switchParentNode(cardPar,playNode)

    gt.removeCocosEventListener(self,self.freeLipaiListener)
    self.rootNode:removeChildByName("lipai")
    self.lipaiIsClose = true

	self.startBtn:setVisible(false)
	self.showCardBtn:setVisible(false)
	self.openCardBtn:setVisible(false)
    self.openCardBtn:stopAllActions()
    self.bgWaitingTip:setVisible(false)
	self:resetCardSigns()
    self:hidePlayersRobZhuangFrame()
    self:hideCardViewsActions()
    self:clearNiuEffect()
	self:hidePlayersReadySign()

--	self.readyBtn:loadTextureNormal("image/play/sitdown.png")
	if self.isMatch and self.IsNewGame then
		self.readyBtn:setPositionX(-150)
		self.readyBtn:loadTextureNormal("image/play/btn_continue.png")
		self.readyBtn:setContentSize(192,71)
		self.Btn_ViewFinalReport:setPositionX(150)
		self.Btn_ViewFinalReport:setVisible(true)
	end
    self.readyBtn:setVisible(true)
	for i = 1, self.roomChairs do
		self.playerNodes[i]:setVisible(false)
	end
	self.Node_Trusteeship:setVisible(false)
end

function PlaySceneSSS:playSceneRestartEvt()
	if self.dismissed then
		self:backMainSceneEvt()
		return
	end

	self:reInitScene()
	self.isWait = true
	self.playerSeatIdx = -1
	self.bankerSeatIdx = -1
	self.roomPlayers = {}
	self.roomState = ROOM_STATE.INIT
	self.relogining = false
	self.cardShowQueue = {}
	self.cardShowDelay = 0

	gt.socketClient:clearMessage()
    self:reLogin()
end

function PlaySceneSSS:backMainSceneEvt(eventType)
	extension.callBackHandler = {}
	-- 消息回调
	self:unregisterAllMsgListener()
	-- 连接大厅
	gt.socketClient:close()
	gt.socketClient:connect(gt.LoginServer.ip,gt.LoginServer.port,true)
	local msgToSend = {}
	msgToSend.cmd = gt.LOGIN_USERID
	msgToSend.user_id = gt.playerData.uid
	msgToSend.open_id = gt.playerData.openid
	gt.socketClient:sendMessage(msgToSend)

	local mainScene = require("app/views/MainScene"):create(false)
	cc.Director:getInstance():replaceScene(mainScene)
    
end

function PlaySceneSSS:IsSameIp(msgTbl)
	local SameIpNode = gt.seekNodeByName(self.rootNode, "Node_SameIP")
	SameIpNode:setLocalZOrder(20000000000)
	local text = gt.seekNodeByName(SameIpNode, "Text_4")
	local showStr = "玩家：".. msgTbl.m_nike[1] .. "与\n玩家："..msgTbl.m_nike[2] .. "为同一IP"
	local position = cc.p(SameIpNode:getPosition())
	local callFunc1 = cc.CallFunc:create(function(sender)
		SameIpNode:setPosition(position.x,position.y + 200)
		SameIpNode:setVisible(true)
		text:setString(showStr)
	end)
	local moveTo = cc.MoveTo:create(2, cc.p(position.x, position.y))
	local delayTime = cc.DelayTime:create(3)
	local moveTo1 = cc.MoveTo:create(2, cc.p(position.x, position.y + 600))
	local sequence = cc.Sequence:create(callFunc1,moveTo,delayTime,moveTo1)
	SameIpNode:runAction(sequence)
end

-- 创建房间时是否开启搓牌
function PlaySceneSSS:isOpenRubCard()
    local op = tonumber(gt.charAt(self.tableSetting.options,9))
    if (op == 0) then
        return true
    end

    return false
end

-- 创建房间时是否开启自动托管
function PlaySceneSSS:isAuto()
--    local op = tonumber(gt.charAt(self.tableSetting.options,8))
--    if (op == 1) then
--        return true
--    end

--    return false
    return true
end

--显示房间玩法标题
function PlaySceneSSS:showPlayTitle()
    if (self.roomChairs == gt.GameChairs.SIX) then
        local str = ""
        local strScore = string.format("%d/%d分", self.tableSetting.score, self.tableSetting.score*2)
        local strGameType = gt.GameTypeDesc[self.tableSetting.game_type]
        if (self.tableSetting.game_type == gt.GameType.GAME_CLASSIC) then
            str = strGameType.."  "..strScore
        elseif (self.tableSetting.game_type == gt.GameType.GAME_BULL) then
            str = strGameType.."  "..strScore.."  底分"..self.tableSetting.base_score
        elseif (self.tableSetting.game_type == gt.GameType.GAME_GOLD) then
            local strBetNum = string.format("%次下注可比牌", self.tableSetting.bet_num)
            str = strGameType.."  "..strScore.."  "..strBetNum
        elseif (self.tableSetting.game_type == gt.GameType.GAME_BANKER) then
            str = strGameType.."  "..strScore.."  倍数"..(self.tableSetting.loot_dealer)
        elseif (self.tableSetting.game_type == gt.GameType.GAME_TOGETHER) then
            strScore = string.format("%d分", self.tableSetting.score)
            str = strGameType.."  "..strScore
        elseif (self.tableSetting.game_type == gt.GameType.GAME_FREE_BANKER) then
            str = strGameType.."  "..strScore
        elseif (self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER) then
            strScore = string.format("%d倍", self.tableSetting.score)
            str = strGameType.."  "..strScore.."  抢庄倍数4".."  底分"..self.tableSetting.qh_base_score
        end
        self.textPlayType:setString(str)
        self.textPlayType:setVisible(true)
    end
end

--显示庄家标识
function PlaySceneSSS:showBankerSign()
	self:CloseTuiflag()
    local roomPlayerBanker = self.roomPlayers[self.bankerSeatIdx]
    local playerInfoNode = gt.seekNodeByName(self.rootNode, "Node_playerInfo_" .. roomPlayerBanker.displaySeatIdx)
    local bankerSignSpr = gt.seekNodeByName(playerInfoNode, "Spr_bankerSign")
    bankerSignSpr:setVisible(true)
    local robFrameSpr = self.playerRobZhuangFrames[roomPlayerBanker.displaySeatIdx]
    robFrameSpr:setVisible(true)

    --抢庄时庄家是点的不抢随出来的，抢完庄要显示成1倍
    local rate = roomPlayerBanker.loot_dealer
    if (self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER or self.tableSetting.game_type == gt.GameType.GAME_FREE_BANKER) and rate < 0 then
        local bflRateSign = self.bflRateSigns[roomPlayerBanker.displaySeatIdx]
        bflRateSign:setString("1倍")
    end

    --是暗抢 则抢完庄后选压倍抢的显示具体倍数
    if (self.tableSetting.game_type == gt.GameType.GAME_BANKER and self.tableSetting.steal == 1) then
        for key, var in pairs(self.roomPlayers) do
            local bflRateSign = self.bflRateSigns[var.displaySeatIdx]
            local rate2 = var.loot_dealer
            if (rate2 > 0) then
                bflRateSign:setString(rate2.."倍")
            end
        end
    end
end

-- 开始录音
function PlaySceneSSS:startAudio()
	local ret = extension.voiceStart()
	if not ret then
		gt.log("voice not open");
		return false
	end
	gt.log("start voice")
end

function PlaySceneSSS:getVoiceUrl(respJson)
	gt.log("getVoiceUrl", respJson)
	local status = tonumber(respJson.status)
	if(status == 1) then
		gt.log("get voice url success");
		local code = respJson.code;
		local dataArr = string.split(code, "#")
		local time = dataArr[2]
		if time and tonumber(time) > 0 then
			--获得到地址上传给服务器
			local msgToSend = {}
			msgToSend.cmd = gt.SPEAKER
			msgToSend.type = gt.ChatType.VOICE_MSG -- 语音聊天
			msgToSend.url = tostring(dataArr[1])
			msgToSend.time = tonumber(time)
			gt.socketClient:sendMessage(msgToSend)
		else
		    gt.log("----------get voice url fail: time null url:", tostring(dataArr[1]))
		end
	end
end

function PlaySceneSSS:uploadVoice(path, time)
	gt.log("uploadVoice", path, time)
	extension.voiceupload(handler(self, self.getVoiceUrl), path, time)
end

function PlaySceneSSS:onVoiceFinish(respJson)
	gt.log("onVoiceFinish")
	if self.cancelVoice == true then
		return
	end
	local status = tonumber(respJson.status)
	if (status == 1) then
		gt.log("voice done")
		local code = respJson.code
		local dataArr = string.split(code, "#")

		local path = dataArr[1]
		local time = dataArr[2]

		if ( 500 > tonumber(time)) then
			gt.log("voice time too short");
		else
            local callFunc1 = cc.CallFunc:create(function ()
			    self.yuyinBtn:setEnabled(false)
		    end)
		    local delayTime = cc.DelayTime:create(self.chatCD)
		    local callFunc2 = cc.CallFunc:create(function ()
			    self.yuyinBtn:setEnabled(true)
		    end)
		    local sequence = cc.Sequence:create(callFunc1,delayTime,callFunc2)
		    self.yuyinBtn:runAction(sequence)
				
			self:uploadVoice(path, tostring(time))
		end
	else
		gt.log("voice fail")
	end
end

--停止录音
function PlaySceneSSS:stopAudio(cancel)
	gt.log("stop audio", cancel)
	self.cancelVoice = cancel

	extension.voiceStop(handler(self, self.onVoiceFinish))
end

--是否有托管功能
function PlaySceneSSS:HasTrusteeship()
	if self.IsReplay then
		return false
	end
	return (self.game_id == gt.GameID.NIUNIU and self.game_type == gt.GameType.GAME_BANKER) or
	self.game_id == gt.GameID.QIONGHAI or
	self.game_id == gt.GameID.NIUYE
end

--关闭所有人的可推注xxx标识
function PlaySceneSSS:CloseTuiflag()
	for i,v in ipairs(self.playerNodes) do
		v.TuiFlag:setVisible(false)
	end
end

function PlaySceneSSS:onRcvPush(msgTbl)
	for i,v in ipairs(msgTbl.player) do
		local localSeat=v.seat+1
		self:ShowTuiflag(localSeat,v.push_pledge)
	end
end

function PlaySceneSSS:ShowTuiflag(localSeat,score)
	if score<=0 then
		return
	end
	local playerNode=self.playerNodes[self.roomPlayers[localSeat].displaySeatIdx]
	playerNode.TuiFlag:setVisible(true)
	playerNode.TuiScore:setString(tostring(score))
end

return PlaySceneSSS

