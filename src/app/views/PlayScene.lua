
local gt = cc.exports.gt

local YvYin_Node = require("app/views/YvYinNode")

local PlayScene = class("PlayScene", function()
	return cc.Scene:create()
end)

PlayScene.ZOrder = {
	MJTABLE						= 1,
	PLAYER_INFO					= 2,
	MJTILES						= 6,
	DECISION_BTN				= 8,
	PLAYER_INFO_TIPS			= 10,
	REPORT						= 26,
	SETTING						= 18,
	CHAT						= 20,
    DISMISS_ROOM				= 21,

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
	BUY_PLEDGE = 13, --闲家买码
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
	SETTLE_ROOM = 13,    -- 大结算
	BUY_PLEDGE = 14, --闲家买码
}

local WAIT_TYPE = {
    READY = 1,	        -- 准备
    LOOT = 2,	        -- 抢庄压倍率
    PLEDGE = 3,	        -- 押分
    SHOW_CARD = 4,	    -- 亮牌
	BUY_PLEDGE = 5, -- 闲家买码
}


function PlayScene:ctor(enterRoomMsgTbl)
	--清理纹理
	

    if not enterRoomMsgTbl.IsReplay then
		    cc.SpriteFrameCache:getInstance():removeUnusedSpriteFrames()
		    cc.Director:getInstance():getTextureCache():removeUnusedTextures()
	    end

	self.game_id=enterRoomMsgTbl.game_id
	self.game_type=enterRoomMsgTbl.game_type
	self.IsReplay=enterRoomMsgTbl.IsReplay
	--限时比赛id
	self.sport_id=enterRoomMsgTbl.sport_id
	-- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))

    -- 几人房
    self.roomChairs = enterRoomMsgTbl.max_chairs
	self.guildID = enterRoomMsgTbl.guild_id
	self.isMatch = enterRoomMsgTbl.match
    self.game_type = enterRoomMsgTbl.game_type
	self.sportId = enterRoomMsgTbl.sport_id
	-- 加载界面资源
    local csbName = "csd/PlayScene.csb"
    if self.roomChairs == gt.GameChairs.TEN then
        csbName = "csd/PlaySceneTen.csb"
    elseif self.roomChairs == gt.GameChairs.EIGHT then
        csbName = "csd/PlaySceneEight.csb"
    elseif self:isTwelve() then
        csbName = "csd/PlaySceneTwelve.csb"
    end
	local csbNode = cc.CSLoader:createNode(csbName)
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
    ccui.Helper:doLayout(csbNode)
	self:addChild(csbNode)
	self.rootNode = csbNode

    --桌面
    self:changePlayBg()

	--隐藏房间玩法标题
    if self.roomChairs == gt.GameChairs.SIX then
	    self.textPlayType = gt.seekNodeByName(self.rootNode, "Label_GameType")
	    self.textPlayType:setVisible(false)
    end

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
    --抢庄动画时间
    self.robDealerAniTime = 3
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
	self.roundStateNode:setVisible(false)

	--更新房间号
	local titleBg = gt.seekNodeByName(self.rootNode, "Img_SetBg")
	local roomIDLabel = gt.seekNodeByName(titleBg, "Label_RoomNumber")
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

	-- 刚进入房间,隐藏玩家信息节点
	for i = 1, self.roomChairs do
		local playerNode = gt.seekNodeByName(self.rootNode, "Node_playerInfo_" .. i)
		playerNode:setVisible(false)
		local headFrameBtn = gt.seekNodeByName(playerNode, "Panel_HeadFrame")

		local headSpr = gt.seekNodeByName(playerNode, "Spr_Head")
		headSpr:removeFromParent(true)
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
	for i = 1, self.roomChairs do
		local readySignNode = gt.seekNodeByName(self.rootNode, "Node_readySign")
		local readySignSpr = gt.seekNodeByName(readySignNode, "Spr_readySign_" .. i)
		readySignSpr:setVisible(false)
		self.readySigns[i] = readySignSpr
	end

	-- 押分标示
	self.pledgeSigns = {}
	for i = 1, self.roomChairs do
		local pledgeSignNode = gt.seekNodeByName(self.rootNode, "Node_pledgeSign")
		local pladgeSignImg = pledgeSignNode:getChildByName("Img_pledgeSign_" .. i)
		pladgeSignImg:setVisible(false)
		self.pledgeSigns[i] = pladgeSignImg
	end

	self:initBuyPledge()
	
	--闲家买码提示
	if not self:isTwelve() then
		self.buyPledgeSigns = {}
		for i = 1,self.roomChairs do
			local buyPledgeSign = self.buyPledgeSignNode:getChildByName("Img_buyPledgeSign_" .. i)
			buyPledgeSign:setVisible(false)

		self.buyPledgeSigns[i] = buyPledgeSign
		end
	end

    -- 抢庄倍数标示
    self.bflRateSigns = {}
    for i = 1, self.roomChairs do
        local rateSignNode = gt.seekNodeByName(self.rootNode, "Node_RateSign")
        local bflRateSign = rateSignNode:getChildByName("bflRateSign"..i)
        bflRateSign:setVisible(false)
        self.bflRateSigns[i] = bflRateSign
    end

	-- 隐藏玩家牌
	self.cardViews = {}
	local playNode = gt.seekNodeByName(self.rootNode, "Node_play")
	for i = 1, self.roomChairs do
		self.cardViews[i] = {}
		local cardNode = playNode:getChildByName("pCard"..i)
		cardNode:setVisible(false)
		self.cardViews[i].node = cardNode
		self.cardViews[i].imgCards = {}
		for j = 1, 5 do
			self.cardViews[i].imgCards[j] = cardNode:getChildByName("imgCrad"..j)
            self.cardViews[i].imgCards[j].imgCardPos = cc.p(self.cardViews[i].imgCards[j]:getPosition())
		end
		local effectNode = cc.Node:create()
		cardNode:addChild(effectNode)
		self.cardViews[i].effectNode = effectNode
		self.cardViews[i].imgNiuType = cardNode:getChildByName("imgNiuType")
        self.cardViews[i].imgNiuType:setVisible(false)
        self.cardViews[i].imgNiuRate = cardNode:getChildByName("imgNiuRate")
        self.cardViews[i].imgNiuRate:setLocalZOrder(1000)
        self.cardViews[i].imgNiuRate:setVisible(false)
		self.cardViews[i].imgScore = cardNode:getChildByName("Img_Score")
		self.cardViews[i].imgScore:setVisible(false)
		self.cardViews[i].imgScorePos = cc.p(self.cardViews[i].imgScore:getPosition())
		self.cardViews[i].lblScore = self.cardViews[i].imgScore:getChildByName("lblScore")
        self.cardViews[i].imgWinLose = self.cardViews[i].imgScore:getChildByName("Img_Win_Lose")
	end

	-- 隐藏玩家押分按钮
	gt.seekNodeByName(self.rootNode,"Node_decisionBtn"):getChildByName("Node_ScoreSpecial"):setVisible(false)
	gt.seekNodeByName(self.rootNode,"Node_decisionBtn"):getChildByName("Node_Score"):setVisible(false)
	gt.seekNodeByName(self.rootNode,"Node_decisionBtn"):getChildByName("Node_QHScore"):setVisible(false)

	self.decisionBtnNode = gt.seekNodeByName(self.rootNode, "Node_decisionBtn")
	-- self.rootNode:reorderChild(self.decisionBtnNode, PlayScene.ZOrder.DECISION_BTN)
	-- self.decisionBtnNode:setVisible(false)

 --    --推注按钮
 --    self.scoreTui = 0
 --    local function onTuiZhu(sender)
 --        local soundScore = "man/tui_zhu"
 --        if gt.playerData.sex == 2 then
 --            --女声
 --            soundScore = "woman/tui_zhu"
 --        end
 --        gt.soundEngine:playEffect(soundScore, false)

	-- 	local msgToSend = {}
	-- 	msgToSend.cmd = gt.PLEDGE_DN
	-- 	msgToSend.pledge = self.scoreTui
 --        msgToSend.pledge_type = 1  --0不推注，1推注
 --        msgToSend.pledge_double = 0 --0不翻倍，1翻倍
	-- 	gt.socketClient:sendMessage(msgToSend)
	-- end

 --    local nodeScore = gt.seekNodeByName(self.decisionBtnNode, "Node_Score")
 --    self.btnScoreTui = gt.seekNodeByName(nodeScore, "btnScoreTui")
 --    self.lbScoreTui = self.btnScoreTui:getChildByName("bfLabel")
 --    self.btnScoreTui:setVisible(false)
 --    self.btnScoreTui:addClickEventListener(onTuiZhu)

 --    --翻倍按钮
 --    self.bDoublePledge = false
 --    local function onDoubleBtn()
 --        self.bDoublePledge = true
 --        self.btnDoubleScore:setVisible(false)
 --        self:setShowPledgeScoreBtn()
 --    end
 --    self.btnDoubleScore = gt.seekNodeByName(nodeScore, "btnDoubleScore")
 --    gt.addBtnPressedListener(self.btnDoubleScore, onDoubleBtn, "double", gt.playerData.sex)
 --    self.btnDoubleScore:setVisible(false)

    --隐藏玩家抢庄倍数按钮
    self.rateBtnNode = gt.seekNodeByName(self.rootNode, "Node_RateBtn")
    self.rateBtnNode:setVisible(false)

    -- 房间信息按钮
    local btnInfo = gt.seekNodeByName(self.rootNode, "Btn_Info")
    gt.addBtnPressedListener(btnInfo, handler(self, self.infoBtnClickEvt))
    btnInfo:setVisible(false)
    self.btnInfo = btnInfo

	-- 隐藏准备按钮
	local readyBtn = gt.seekNodeByName(self.rootNode, "Btn_ready")
	readyBtn:setVisible(false)
	gt.addBtnPressedListener(readyBtn, handler(self, self.readyBtnClickEvt))
--    local lbReady = gt.seekNodeByName(readyBtn, "lblReady")
--    lbReady:setString("坐  下")
    readyBtn:loadTextureNormal("image/play/sitdown.png")
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
        gt.getRoomShareString(self.tableSetting, num, self.roomID, self.guildID, self.isMatch)
	end)
    self.inviteFriendBtn = inviteFriendBtn

    -- 隐藏亮牌按钮
	local showCardBtn = gt.seekNodeByName(self.rootNode, "Btn_ShowCard")
	showCardBtn:setVisible(false)
	gt.addBtnPressedListener(showCardBtn, handler(self, self.showCardBtnClickEvt))
	self.showCardBtn = showCardBtn

    -- 隐藏搓牌按钮
    self.rubCardBtn = gt.seekNodeByName(self.rootNode, "Btn_RubCard")
    self.rubCardBtn:setVisible(false)
    gt.addBtnPressedListener(self.rubCardBtn, handler(self, self.rubCardBtnClickEvt))

	-- 隐藏翻牌按钮
	local openCardBtn = gt.seekNodeByName(self.rootNode, "Btn_OpenCard")
	openCardBtn:setVisible(false)
	gt.addBtnPressedListener(openCardBtn, handler(self, self.openCardBtnClickEvt))
	self.openCardBtn = openCardBtn

	-- 隐藏所有玩家对话框
	local chatBgNode = gt.seekNodeByName(self.rootNode, "Node_chatBg")
	self.rootNode:reorderChild(chatBgNode, PlayScene.ZOrder.CHAT)
	chatBgNode:setVisible(false)

	--聊天按钮
	self.chatBtn = gt.seekNodeByName(self.rootNode, "Btn_Chat")
	self.chatBtn:setVisible(false)
	gt.addBtnPressedListener(self.chatBtn, function()
		local chatPanel
		if #self.ChatLog > 0 then
			chatPanel = require("app/views/ChatPanel"):create(self.ChatLog,self:isTwelve(), self.is_shutup)
		else
		 	chatPanel = require("app/views/ChatPanel"):create(false,self:isTwelve(), self.is_shutup)
		end
		chatPanel:setPosition(0,0)
		self:addChild(chatPanel, PlayScene.ZOrder.CHAT)
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
        local settingPanel = require("app/views/Setting"):create(param, 1 , self:isTwelve())

		self:addChild(settingPanel, PlayScene.ZOrder.SETTING)
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
	self.yuyinChatNode:setLocalZOrder(PlayScene.ZOrder.CHAT)
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
    for i = 1, self.roomChairs do
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
		local trusteeship = require("app/views/Trusteeship"):create(self.tableSetting ,self:isTwelve())
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
	self.Node_Trusteeship:setZOrder(99999999)
	local TrusteeshipBG = self.Node_Trusteeship:getChildByName("Img_BG")

	local listener = cc.EventListenerTouchOneByOne:create()  --创建一个单点事件监听
	listener:setSwallowTouches(true)  --不向下传递
	local function OnTouchBegan(touch,event)
		self.LastTouchCD = 20
		return false
	end
	listener:registerScriptHandler(OnTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener,TrusteeshipBG) --分发监听事件

	self.Btn_CancelTrusteeship = gt.seekNodeByName(self.Node_Trusteeship, "Btn_Cancel")
	gt.addBtnPressedListener(self.Btn_CancelTrusteeship,function()
		local msg = {}
		msg.cmd = gt.TRUSTEESHIP
		msg.ai_type = 0
		dump(msg)
		gt.socketClient:sendMessage(msg)
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
	gt.socketClient:registerMsgListener(gt.PLEDGE_DN, self, self.onRcvPledge) --玩家押分
	gt.socketClient:registerMsgListener(gt.PROMPT_PLEDGE_DN, self, self.onPromptPledge) --玩家押分提示
    gt.socketClient:registerMsgListener(gt.PROMPT_LOOT_DEALER_DN, self, self.onPromptRate) --提示玩家可以压倍率
    gt.socketClient:registerMsgListener(gt.LOOT_DEALER_DN, self, self.onRcvRate) --玩家压倍率
    gt.socketClient:registerMsgListener(gt.DEAL2_DN, self, self.onRcvDealLeftCard) --发剩余的牌（抢庄后）
	gt.socketClient:registerMsgListener(gt.PROMPT_START_DN, self, self.onRcvPromptStart) --提示显示开始游戏按钮
    gt.socketClient:registerMsgListener(gt.START_DN, self, self.onRcvStart) --开始游戏回调
	gt.socketClient:registerMsgListener(gt.DEAL, self, self.onRcvDealCard) --发牌
    gt.socketClient:registerMsgListener(gt.PROMPT_CARD_DN, self, self.onPromptShowCard) --玩家亮牌提示
	gt.socketClient:registerMsgListener(gt.SHOW_CARD_DN, self, self.onRcvShowCard) --玩家亮牌
	gt.socketClient:registerMsgListener(gt.DEALER_SEAT, self, self.onRecvDealerSeat)	--换庄
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
	gt.socketClient:registerMsgListener(gt.TRUSTEESHIP,self,self.onRcvTrust)    --托管
	gt.socketClient:registerMsgListener(gt.PUSH_PLEDGE,self,self.onRcvPush)    --可推注xxx

	gt.socketClient:registerMsgListener(gt.PROMPT_BUY_PLEDGE,self,self.onPromptBuyPledge)    --提示闲家可以买码
	gt.socketClient:registerMsgListener(gt.BUY_PLEDGE,self,self.onRcvBuyPledge)    --闲家买码
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

function PlayScene:isScoreSpecial()
	return self.game_id == gt.GameID.NIUNIU and self.game_type == gt.GameType.GAME_BANKER
end

function PlayScene:isScoreSpecial11()
	local _bisScoreSpecial = false
	if self.tableSetting and self.tableSetting.score >=11 and self.tableSetting.score <= 16 then
		_bisScoreSpecial = true
	end

	return _bisScoreSpecial
end


function PlayScene:showBuyPledge()

	if self:isTwelve() then
		return
	end

	self.buyPledgeBtnNode:setVisible(true)
	self.buyPledgeSignNode:setVisible(true)
	self.node_buyPledge:setVisible(false)


	for i = 2, self.roomChairs do
		local btnBuyPledge = gt.seekNodeByName(self.buyPledgeBtnNode,"btnBuyPledge"..i)
		if btnBuyPledge then
			btnBuyPledge:setVisible(false)
		end
	end
	for i,roomPlayer in pairs(self.roomPlayers) do
		if roomPlayer.uid ~= gt.playerData.uid and not self:isBanker(roomPlayer.seatIdx) then
			local btnBuyPledge = gt.seekNodeByName(self.buyPledgeBtnNode,"btnBuyPledge"..roomPlayer.displaySeatIdx)
			if btnBuyPledge  and not roomPlayer.isWait then
				btnBuyPledge:setVisible(true)
			end
		end
		self.buyPledgeSigns[i]:setVisible(false)
	end



end

function PlayScene:hideBuyPledge()
	if self:isTwelve() then
		return
	end
	self.buyPledgeBtnNode:setVisible(false)
	self.node_buyPledge:setVisible(false)

end

function PlayScene:hidePopFrame()
	self.node_buyPledge:setVisible(false)
	self.bClickPop = false
end

function PlayScene:initBuyPledge()
	if self:isTwelve() then
		return
	end
	self.buyPledgeBtnNode =  gt.seekNodeByName(self.rootNode,"Node_BuyPledgeBtn")
	self.buyPledgeSignNode =  gt.seekNodeByName(self.rootNode,"Node_BuyPledgeSign")

	self.node_buyPledge =  gt.seekNodeByName(self.buyPledgeBtnNode,"node_buyPledge")

	self.buyPledgeSignNode:setVisible(false)
	self.buyPledgeBtnNode:setVisible(false)
	self.node_buyPledge:setVisible(false)

	local function onNotBuy(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		local msgToSend = {}
		msgToSend.cmd = gt.BUY_PLEDGE
		msgToSend.buy_pledge_score = 0
		msgToSend.buy_seat = 0
		gt.socketClient:sendMessage(msgToSend)

		self:hideBuyPledge()

	end
	gt.seekNodeByName(self.buyPledgeBtnNode,"btnNotBuy"):addClickEventListener(onNotBuy)


	--buy pledge node
	local function onBuyPledge(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		self.node_buyPledge:setVisible(true)
		local tag = sender:getTag()
		self._buypledgeIndex = self:GetPlayerIndexByDisplayseat(tag)
		self._buyPledgeBtnNode:setPosition(sender:getPosition())

	end
	for i = 2, self.roomChairs do
		local btnBuyPledge = gt.seekNodeByName(self.buyPledgeBtnNode,"btnBuyPledge"..i)
		if btnBuyPledge then
			btnBuyPledge:setTag(i)
			btnBuyPledge:addClickEventListener(onBuyPledge)
		end
	end

	-- hide pop frame
	self.panelBuyPledge =  gt.seekNodeByName(self.rootNode,"panelBuyPledge")
	self.panelBuyPledge:addTouchEventListener(function (sender, touchType)
        if touchType == TOUCH_EVENT_ENDED then
            self:hidePopFrame()
            
        end
    end)

end

function PlayScene:initBuyPledgeBySetting()
	if self:isTwelve() then
		return
	end
	self.isInitBuyPledge = false 
	if not self.isInitBuyPledge then

		local nodeBuyPledgeScoreSpecial =  self.node_buyPledge:getChildByName("Node_ScoreSpecial")
		local nodeBuyPledgeScore =  self.node_buyPledge:getChildByName("Node_Score")
		nodeBuyPledgeScore:setVisible(false)
		nodeBuyPledgeScoreSpecial:setVisible(false)

		if self:isScoreSpecial11() then
			self._buyPledgeBtnNode = nodeBuyPledgeScoreSpecial
		else
			self._buyPledgeBtnNode = nodeBuyPledgeScore
		end
		self._buyPledgeBtnNode:setVisible(true)


		local _max = 2
		if self:isScoreSpecial11() then
			_max = 4
		end
		for i = 1,_max do
			local scoreBtn = gt.seekNodeByName(self._buyPledgeBtnNode,"btnScore" .. i)
			local lbScore = scoreBtn:getChildByName("bfLabel")
			
			local buyPledge = self.tableSetting.score * i
			if self:isScoreSpecial() then
				buyPledge = gt.getScoreSpecialDetail(self.tableSetting.score, i)
			end
			
			lbScore:setString(buyPledge)
			gt.addBtnPressedListener(scoreBtn,function(sender)
				local msgToSend = {}
				msgToSend.cmd = gt.BUY_PLEDGE
				msgToSend.buy_pledge_score = buyPledge
				msgToSend.buy_seat = self._buypledgeIndex - 1 
				gt.socketClient:sendMessage(msgToSend)
				self:hideBuyPledge()
			end,"common/ys/btnclick")
		end

		self.isInitBuyPledge = true
	end

end

function PlayScene:initDecision()
	self.isInitDecision = false
	if not self.isInitDecision then

		-- self.decisionBtnNode = gt.seekNodeByName(self.rootNode, "Node_decisionBtn")
		self.rootNode:reorderChild(self.decisionBtnNode, PlayScene.ZOrder.DECISION_BTN)
		self.decisionBtnNode:setVisible(false)

	    --推注按钮
	    self.scoreTui = 0
	    local function onTuiZhu(sender)
	        local soundScore = "man/tui_zhu"
	        if gt.playerData.sex == 2 then
	            --女声
	            soundScore = "woman/tui_zhu"
	        end
	        gt.soundEngine:playEffect(soundScore, false)

			local msgToSend = {}
			msgToSend.cmd = gt.PLEDGE_DN
			msgToSend.pledge = self.scoreTui
	        msgToSend.pledge_type = 1  --0不推注，1推注
	        msgToSend.pledge_double = 0 --0不翻倍，1翻倍
			gt.socketClient:sendMessage(msgToSend)
		end

	    local nodeScore = gt.seekNodeByName(self.decisionBtnNode, "Node_Score")
	    if self:isScoreSpecial11() then
	    	nodeScore = gt.seekNodeByName(self.decisionBtnNode, "Node_ScoreSpecial")
	    end

	    self.btnScoreTui = gt.seekNodeByName(nodeScore, "btnScoreTui")

	    self.lbScoreTui = self.btnScoreTui:getChildByName("bfLabel")
	    self.btnScoreTui:setVisible(false)
	    self.btnScoreTui:addClickEventListener(onTuiZhu)

	    --翻倍按钮
	    self.bDoublePledge = false
	    local function onDoubleBtn()
	        self.bDoublePledge = true
	        self.btnDoubleScore:setVisible(false)
	        self:setShowPledgeScoreBtn()
	    end
	    self.btnDoubleScore = gt.seekNodeByName(nodeScore, "btnDoubleScore")
	    gt.addBtnPressedListener(self.btnDoubleScore, onDoubleBtn, "double", gt.playerData.sex)
	    self.btnDoubleScore:setVisible(false)

		self.isInitDecision = true
	end
end
function PlayScene:unregisterAllMsgListener()
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
	gt.socketClient:unregisterMsgListener(gt.PROMPT_BUY_PLEDGE)
	gt.socketClient:unregisterMsgListener(gt.BUY_PLEDGE)
end

-- 断线重连,重新进入房间
function PlayScene:reLogin()
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

function PlayScene:changePlayBg()
    local networkBg = gt.seekNodeByName(self.rootNode, "Img_NetworkBg")
    -- 电量
    local batteryBg = gt.seekNodeByName(networkBg, "Img_BatteryBg")
    local barBattery = gt.seekNodeByName(networkBg, "LoadingBar_Battery")
    -- 网络信号
    local imgNetwork = gt.seekNodeByName(networkBg, "Img_Network")
    local desktop = gt.seekNodeByName(self.rootNode, "Img_Bg")
    desktop:setRotation(0)
    desktop:setScale(1)
    local nodeSpine = gt.seekNodeByName(self.rootNode, "Node_Spine")
    local imgSetBg = gt.seekNodeByName(self.rootNode, "Img_SetBg")
    local imgLogo = gt.seekNodeByName(self.rootNode, "Img_Logo")
    local roundStateNode = gt.seekNodeByName(self.rootNode, "Img_RoundBg")

    imgLogo:loadTexture("image/common/big_logo.png")

	nodeSpine:removeAllChildren()
    local deskString = cc.UserDefault:getInstance():getStringForKey("Desktop")
    
    if deskString == "1" then
		gt.soundEngine:playMusic("table_bgm1",true)
        imgLogo:loadTexture("image/common/big_logo2.png")
        if (self.roomChairs == 6) then
            networkBg:loadTexture("image/play/network_bg.png", ccui.TextureResType.plistType)
            imgSetBg:loadTexture("image/play/roominfo_bg2.png")
            roundStateNode:loadTexture("image/play/tips_bg.png")
            desktop:loadTexture("image/play/play_bg_1.png")
		elseif self:isTwelve() then
			desktop:loadTexture("image/play/player12/play12bg2.jpg")
        else
            desktop:loadTexture("image/play/play_bg_1.png")
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
	    if self:isTwelve() then
			self.sk1:setRotation(-90)
			self.sk1:setScale(gt.xkbjScaleY*1.78, gt.xkbjScaleX*1.78)
		end
	elseif deskString == "4" then
       gt.soundEngine:playMusic("special", true)
        desktop:loadTexture("image/play/img_kjbj.jpg")
        if (self.roomChairs == 6) then
            networkBg:loadTexture("image/play/network_bg.png", ccui.TextureResType.plistType)
            imgSetBg:loadTexture("image/play/roominfo_bg2.png")
            roundStateNode:loadTexture("image/play/tips_bg.png")
        end
        self.sk2 = sp.SkeletonAnimation:create("image/play/effect/kjbj.json", "image/play/effect/kjbj.atlas")
		self.sk2:setAnimation(0, "animation", true)
		if self:isTwelve() then
			self.sk2:setRotation(-90)
			desktop:setRotation(-90)
			desktop:setScale(1.78)
			self.sk2:setScale(1.78)
		end
	    nodeSpine:addChild(self.sk2)

    else
       	gt.soundEngine:playMusic("classic", true)
       	imgLogo:loadTexture("image/common/big_logo2.png")
       	if self.roomChairs == gt.GameChairs.SIX then
           networkBg:loadTexture("image/play/network_bg1.png")
           desktop:loadTexture("image/play/play_bg_2.png")
           imgSetBg:loadTexture("image/play/roominfo_bg1.png")
           roundStateNode:loadTexture("image/play/time_bg1.png")
       	elseif self:isTwelve() then
			desktop:loadTexture("image/play/player12/play12bg1.jpg")
       	else
           	desktop:loadTexture("image/play/play_bg_2.png")
       	end
    end

    -- 底分显示
    if self.roomChairs == 10 or self.roomChairs == 8 then
        local lableScore = gt.seekNodeByName(self.rootNode, "Text_Score")
        lableScore:setVisible(false)
        if self.game_type == gt.GameType.GAME_QH_BANKER then
            lableScore:setVisible(true)
            if deskString == "1" then
                lableScore:setTextColor(cc.c3b(5, 89, 99))
                lableScore:enableShadow(cc.c4b(40, 203, 224, 255), cc.size(0, -1))
            elseif deskString == "3" or deskString == "4" then
                lableScore:setTextColor(cc.c3b(155, 218, 255))
                lableScore:disableEffect()
            else
                lableScore:setTextColor(cc.c3b(4, 86, 56))
                lableScore:enableShadow(cc.c4b(47, 251, 185, 255), cc.size(0, -1))
            end
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
function PlayScene:showQHBaseScore()
    if self.roomChairs == 10 or self.roomChairs == 8 then
        local lableScore = gt.seekNodeByName(self.rootNode, "Text_Score")
        lableScore:setVisible(false)
        if self.game_type == gt.GameType.GAME_QH_BANKER then
            lableScore:setVisible(true)
            lableScore:setString( string.format("底分：%d分", self.tableSetting.qh_base_score))
        end
    end
end

function PlayScene:showEmojiAnimation(emojiAnimation, seatIdxStart, id, user_id)
	if self.roomPlayers == nil or #self.roomPlayers <= 0 then
		return
	end
    local startPlayer = self.roomPlayers[seatIdxStart]
    if not startPlayer then return end
    
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
        if self:isTwelve() then
        	aniNode:setRotation(-90)
        end
        sender:addChild(aniNode)
    end

--    if id == user_id then
--        for i, roomPlayer in pairs(self.roomPlayers) do
--            if roomPlayer.uid ~= user_id then
--                local seatIdxEnd = roomPlayer.displaySeatIdx
--                local playerNodeEnd = gt.seekNodeByName(self.rootNode, "Node_playerInfo_" .. seatIdxEnd)
--                local pos2 = cc.p(playerNodeEnd:getPosition())
--                local imgEmoji = cc.Sprite:create("image/play/".. emojiAnimation ..".png")
--                imgEmoji:setPosition(pos1)
--                self:addChild(imgEmoji)
--                imgEmoji:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, pos2), cc.DelayTime:create(0.1), cc.RemoveSelf:create()))

--                local actionNode = cc.Node:create()
--                actionNode:setPosition(pos2)
--                self:addChild(actionNode)
--                actionNode:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(call_back), cc.DelayTime:create(1), cc.RemoveSelf:create()))
--            end
--        end
--    else
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
            if self:isTwelve() then
	        	imgEmoji:setRotation(-90)
	        end
            imgEmoji:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, pos2), cc.DelayTime:create(0.1), cc.RemoveSelf:create()))
        end
        local actionNode = cc.Node:create()
        actionNode:setPosition(pos2)
        actionNode:setZOrder(30000)
        self.rootNode:addChild(actionNode)
        actionNode:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(call_back), cc.DelayTime:create(3), cc.RemoveSelf:create()))
--    end
end

function PlayScene:onNodeEvent(eventName)
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
        self.scheduleWait = gt.scheduler:scheduleScriptFunc(handler(self, self.updateAutoWaitCD), 0.1, false)

       
        

--		gt.soundEngine:playMusic("bgm2", true)
	elseif "exit" == eventName then
		extension.callBackHandler = {}
		gt.removeTargetAllEventListener(self)
		gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
        gt.scheduler:unscheduleScriptEntry(self.scheduleWait)
		--gt.soundEngine:playMusic("bgm1", true)
		ccs.ArmatureDataManager:destroyInstance()
	end
end


function PlayScene:update(delta)
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
			if not roomPlayer then return end
			self:showHandCards(false, roomPlayer.displaySeatIdx, roomPlayer.cards_in_hand, roomPlayer.cardsign_in_hand, roomPlayer.sex, roomPlayer.niu_type)
			table.remove(self.cardShowQueue, 1)
			self.cardShowDelay = 0.8
			if tonumber(gt.charAt(self.tableSetting.options,15)) > 0 then
				self.cardShowDelay = 0.2
			end
		end
	end
end

--更新自动托管等待时间
function PlayScene:updateAutoWaitCD(delta)
	delta = delta or 0
	if self.IsPlay and self.PlaySpeed then
		delta = self.IsPlay*self.PlaySpeed*delta
	end
    --自动托管关闭的情况
    if (self.waitType ~= nil and not self:isAuto()) then
        local strTip= ""
        if (self.waitType == WAIT_TYPE.READY) then
            strTip = "等待玩家准备..."
        elseif (self.waitType == WAIT_TYPE.LOOT) then
            strTip = "等待选择倍数..."
        elseif (self.waitType == WAIT_TYPE.PLEDGE) then
            strTip = "等待选择押分..."
            if self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER then
                strTip = "等待选择押倍..."
            end
        elseif (self.waitType == WAIT_TYPE.SHOW_CARD) then
            strTip = "等待玩家亮牌..."
		elseif (self.waitType == WAIT_TYPE.BUY_PLEDGE) then
			strTip = "等待玩家买码..."
        end
        self.lbWatingTip:setString(strTip)
        self.bgWaitingTip:setVisible(true)
        return
    end

    if self.autoTimePause then
        return
    end
	self.autoWaitTime = self.autoWaitTime - delta
	if self.autoWaitTime < 0 then
		self.autoWaitTime = 0
    end

    if (self.autoWaitTime >= 0 and self.waitType ~= nil) then
        local strTip= ""
        if (self.waitType == WAIT_TYPE.READY) then
            strTip = string.format("等待玩家准备...%ds", self.autoWaitTime)
        elseif (self.waitType == WAIT_TYPE.LOOT) then
            strTip = string.format("等待选择倍数...%ds", self.autoWaitTime)
        elseif (self.waitType == WAIT_TYPE.PLEDGE) then
            strTip = string.format("等待选择押分...%ds", self.autoWaitTime)
            if self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER then
                strTip = string.format("等待选择押倍...%ds", self.autoWaitTime)
            end
        elseif (self.waitType == WAIT_TYPE.SHOW_CARD) then
            strTip = string.format("等待玩家亮牌...%ds", self.autoWaitTime)
		elseif (self.waitType == WAIT_TYPE.BUY_PLEDGE) then
			strTip = string.format("等待玩家买码...%ds",self.autoWaitTime)
        end
        self.lbWatingTip:setString(strTip)
        self.bgWaitingTip:setVisible(true)
	end
end

--是否庄家
function PlayScene:isBanker(playerSeatIdx)

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
function PlayScene:isRoomOwner()
    --房间创建者，房间庄家都是
    if self.guildID and self.guildID > 0 then
    	return self.isRoomCreater or self.isAdmin

    elseif (self.isRoomCreater or self:isBanker() or self.isAdmin) then
		return true
	end

	return false
end

--进入房间回调
function PlayScene:onRcvEnterRoom(msgTbl)
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
		end, true, self:isTwelve())
		return
    elseif msgTbl.code == 2 then
        -- 房间人已满
        require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, gt.LocationStrings.LTKey_0018,
			function()
				gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
			end, function()
			gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
		end, true, self:isTwelve())
		return
	elseif msgTbl.code == 3 then
		-- 房间数据错误
        require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, gt.LocationStrings.LTKey_0070,
			function()
				gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
			end, function()
			gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
		end, true, self:isTwelve())
		return
	end

	self:reInitScene()

	self.relogining = false
	-- 桌子配置
	require("json")
	self.tableSetting = json.decode(msgTbl.kwargs)
	self:initDecision()
	self.isAdmin = msgTbl.is_admin
	self:initBuyPledgeBySetting()
    self:setShowPledgeScoreBtn()
    self:setShowRateBtn()
    self.btnInfo:setVisible(true)
    self.imgGuanZhan:setVisible(true)
	
	--禁言设置
	self.is_shutup = 0
	if 1 == self.tableSetting.is_shutup then
		self.is_shutup = 1
	end
	
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
        if not roomPlayerBanker then return end
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
function PlayScene:onEnterRoomOther(msgTbl)
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
				self.LastTouchCD = 9999999999
				self.Node_Trusteeship:setVisible(true)
				gt.dispatchEvent("Close_Trusteeship")
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
            local pledgeSign = self.pledgeSigns[var.displaySeatIdx]
            pledgeSign:setVisible(false)
            local rateSign = self.bflRateSigns[var.displaySeatIdx]
            rateSign:setVisible(false)
			if not self:isTwelve() then
				local buyPledgeSign = self.buyPledgeSigns[var.displaySeatIdx]
				buyPledgeSign:setVisible(false)
			end
            self.cardViews[var.displaySeatIdx].node:setVisible(false)
        end
        self.playerHeadMgr:detachAll()

        --把别人的位置重排下
        for key, var in pairs(self.roomPlayers) do
            --重新绘制新位置状态
            var.displaySeatIdx = (var.seatIdx - 1 + self.seatOffset) % self.roomChairs + 1
            self:roomAddPlayer(var)
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
	roomPlayer.state = msgTbl.state
	roomPlayer.score = msgTbl.score
	roomPlayer.pledge = msgTbl.pledge   --压分分数
    roomPlayer.loot_dealer = msgTbl.loot_dealer   --抢庄倍数
	roomPlayer.cards_in_hand = msgTbl.cards_in_hand or {}
    roomPlayer.cardsign_in_hand = msgTbl.cardsign_in_hand or self.cardSignInHandInit --明暗标识
	roomPlayer.niu_type = msgTbl.niu_type or 0
	-- 房间添加玩家
	self:roomAddPlayer(roomPlayer)
end


-- 退出房间
function PlayScene:onRcvExitRoom(msgTbl)
	if msgTbl.player == gt.playerData.uid then	-- 自己退出
		gt.removeLoadingTips()
		if msgTbl.type and msgTbl.type==1 then
			require("app/views/NoticeTips"):create("提示", "服务器维护中!", function()
				gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
			end, function()
				gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
			end, true, self:isTwelve())
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
		    if not roomPlayer then return end
		    -- 隐藏玩家信息
		    local playerInfoNode = self.playerNodes[roomPlayer.displaySeatIdx]
		    self.playerNodes[roomPlayer.displaySeatIdx]:setVisible(false)

		    -- 隐藏玩家手势
		    self.readySigns[roomPlayer.displaySeatIdx]:setVisible(false)
		    self.pledgeSigns[roomPlayer.displaySeatIdx]:setVisible(false)
            self.bflRateSigns[roomPlayer.displaySeatIdx]:setVisible(false)

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
function PlayScene:onRcvSyncRoomState(msgTbl,isStart)
	gt.removeLoadingTips()
    self:stopAllActions()
    --关闭搓牌动画界面
    gt.dispatchEvent(gt.EventType.SHOW_CARD_OVER)
    gt.dump(msgTbl, "断线重连-----------")
    self:resetCardSigns()
	self.readyBtn:setVisible(false)
	self.startBtn:setVisible(false)
    self.inviteFriendBtn:setVisible(false)
    self.imgGuanZhan:setVisible(false)
	if self.decisionBtnNode then
		self.decisionBtnNode:setVisible(false)
	end
    self.rateBtnNode:setVisible(false)
    self.rateBtnNode:stopAllActions()
	self.showCardBtn:setVisible(false)
    self.rubCardBtn:setVisible(false)
	self.openCardBtn:setVisible(false)
    self.openCardBtn:stopAllActions()
    self.bgWaitingTip:setVisible(false)
    self:hidePlayersRobZhuangFrame()
    self:hideCardViewsActions()
    self:clearNiuEffect()
    	self:hideBuyPledge()
	-- 游戏开始后隐藏准备标识
	self:hidePlayersReadySign()
	self:hidePlayersBuyPledgeSign()
	self:hidePlayersPledgeSign()
	self:hidePlayersRateSign()
    if (self.tongSha ~= nil) then
        self.tongSha:removeFromParent()
        self.tongSha = nil
    end

	-- 桌子配置
	require("json")
	self.tableSetting = json.decode(msgTbl.kwargs)
	self:initDecision()
	
	--禁言设置
	self.is_shutup = 0
	if 1 == self.tableSetting.is_shutup then
		self.is_shutup = 1
	end
	
	self.isAdmin = msgTbl.is_admin
    --是否断线重连

    self.bReconnect = true
    self.gameStyle = msgTbl.game_type
    self.curRound = msgTbl.round
	self:initBuyPledgeBySetting()
    self:setShowPledgeScoreBtn()
    self:setShowRateBtn()
    self.btnInfo:setVisible(true)
    self.scoreTui = msgTbl.push_pledge
    local bShowMaxScore = msgTbl.show_max_score
    local showDouble = msgTbl.pledge_double
    self.autoWaitTime = msgTbl.time
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
        self.imgGuanZhan:setVisible(true)
	    if not gt.isIOSReview() then
		    self.inviteFriendBtn:setVisible(true)
	    end
    end

    -- 玩家自己
    for i, v in ipairs(msgTbl.player) do
        if v.player == gt.playerData.uid then
            -- 玩家座位编号
            self.playerSeatIdx = v.seat + 1
            -- 玩家显示固定座位号
            self.playerFixDispSeat = 1
            -- 逻辑座位和显示座位偏移量(从0编号开始)
            local seatOffset = (self.playerFixDispSeat - 1) - v.seat
            self.seatOffset = seatOffset

            --自己是已经坐下的观战者显示邀请按钮
            if v.is_wait then
                self.imgGuanZhan:setVisible(true)
		        if not gt.isIOSReview() then
			        self.inviteFriendBtn:setVisible(true)
		        end
            end

			if (msgTbl.room_state == ROOM_STATE.INIT
             or msgTbl.room_state == ROOM_STATE.READY
			 or msgTbl.room_state == ROOM_STATE.RESRART
			 or msgTbl.room_state == ROOM_STATE.SETTLE_ROUND) then  -- 初始状态
                if not v.is_wait and v.state ~= PLAYER_STATE.READY then
--                    local lbReady = gt.seekNodeByName(self.readyBtn, "lblReady")
--                    lbReady:setString("准  备")
                    self.readyBtn:loadTextureNormal("image/play/btn_ready.png")
                    self.readyBtn:setVisible(true)
				    if not gt.isIOSReview() then
					    self.inviteFriendBtn:setVisible(true)
				    end
                end

                if (self.autoWaitTime > 0) then
                    self.waitType = WAIT_TYPE.READY
                    self:updateAutoWaitCD()
                end
			end

			if (msgTbl.room_state == ROOM_STATE.INIT
             or msgTbl.room_state == ROOM_STATE.READY
			 or msgTbl.room_state == ROOM_STATE.RESRART)
             and v.state == PLAYER_STATE.READY and not v.is_wait then  -- 已准备状态
                if self:isBanker() and msgTbl.room_state ~= ROOM_STATE.INIT then
				    self.startBtn:setVisible(true)
				    self.Btn_ViewFinalReport:setVisible(false)
                end
				if not gt.isIOSReview() then
					self.inviteFriendBtn:setVisible(true)
				end
			end

            --不是庄家 没亮过牌 不是参观者
            if not v.is_wait and (not self:isBanker() or self.tableSetting.game_type == gt.GameType.GAME_TOGETHER) and v.state < PLAYER_STATE.SHOW_CARD then
                if (self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER) then
                    if (msgTbl.room_state == ROOM_STATE.DEAL2 and v.state == PLAYER_STATE.DEAL2) then --已发牌2状态
                        self.showCardBtn:setVisible(true)
                    end
                else
                    if (msgTbl.room_state == ROOM_STATE.DEAL and v.state == PLAYER_STATE.DEAL)then --已发首牌状态
                        self.showCardBtn:setVisible(true)
                    end
                end
	        end

            if (self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER) then
                --抢庄牛牛  发首牌--》抢庄--》压分--》发剩余牌
                if msgTbl.room_state == ROOM_STATE.DEAL and (v.state == PLAYER_STATE.DEAL or v.state == PLAYER_STATE.LOOT)then  --开始抢庄压倍率
                    if not v.is_wait and v.state ~= PLAYER_STATE.LOOT then
                        self.rateBtnNode:setVisible(true)
                        self.readyBtn:setVisible(false)
                    end

                    self.waitType = WAIT_TYPE.LOOT
                    self:updateAutoWaitCD()
                end
                --开始押分 所有人显示押分等待时间
                if msgTbl.room_state == ROOM_STATE.LOOT and (v.state == PLAYER_STATE.LOOT or v.state == PLAYER_STATE.PLEDGE) then
                    self.waitType = WAIT_TYPE.PLEDGE
                    self:updateAutoWaitCD()

                    if (not v.is_wait and not self:isBanker() and v.state ~= PLAYER_STATE.PLEDGE) then
                        self:showScoreBtn(showDouble)
                    end
                end
                --已发牌2状态
                if msgTbl.room_state == ROOM_STATE.DEAL2 then
				    --self.openCardBtn:setVisible(true)

                    self.waitType = WAIT_TYPE.SHOW_CARD
                    self:updateAutoWaitCD()
			    end
            elseif self.tableSetting.game_type == gt.GameType.GAME_FREE_BANKER then
                --自由抢庄  抢庄--》压分--》发首牌
                if msgTbl.room_state == ROOM_STATE.START and (v.state == PLAYER_STATE.READY or v.state == PLAYER_STATE.START or v.state == PLAYER_STATE.LOOT) then  --开始抢庄压倍率
                    if not v.is_wait and v.state ~= PLAYER_STATE.LOOT then
                        self.rateBtnNode:setVisible(true)
                    end

                    self.waitType = WAIT_TYPE.LOOT
                    self:updateAutoWaitCD()
                end
                --开始押分 所有人显示押分等待时间
                if msgTbl.room_state == ROOM_STATE.LOOT and (v.state == PLAYER_STATE.LOOT or v.state == PLAYER_STATE.PLEDGE) then
                    self.waitType = WAIT_TYPE.PLEDGE
                    self:updateAutoWaitCD()

                    if (not v.is_wait and not self:isBanker() and v.state ~= PLAYER_STATE.PLEDGE) then
                        self:showScoreBtn(showDouble)
                    end
                end
                --已发首牌状态
                if msgTbl.room_state == ROOM_STATE.DEAL then
                    self.waitType = WAIT_TYPE.SHOW_CARD
                    self:updateAutoWaitCD()
			    end
            else
                --其他  压分--》发首牌
                if (msgTbl.room_state == ROOM_STATE.START and (v.state == PLAYER_STATE.READY or v.state == PLAYER_STATE.PLEDGE)) then --所有人显示押分等待时间
                    self.waitType = WAIT_TYPE.PLEDGE
                    self:updateAutoWaitCD()

                    if (not v.is_wait and not self:isBanker() and v.state ~= PLAYER_STATE.PLEDGE and self.tableSetting.game_type ~= gt.GameType.GAME_TOGETHER) then
                        self:showScoreBtn(showDouble)
                    end
                end

                --已发首牌状态
                if msgTbl.room_state == ROOM_STATE.DEAL then
				    --self.openCardBtn:setVisible(true)

                    self.waitType = WAIT_TYPE.SHOW_CARD
                    self:updateAutoWaitCD()
			    end
            end
        end
    end

    --按位置seat从小到大排序
    table.sort(msgTbl.player, function (a,b)
        return a.seat < b.seat
    end)
    for i, v in ipairs(msgTbl.player) do
        if (self.curRound > 1 and not v.is_wait) then
            self.inviteFriendBtn:setVisible(false)
        end

        self:onEnterRoomOther(v)  --这个方法里会显示庄家标识
    end
	for i,v in ipairs(msgTbl.player) do
		--可推注标识
		if v.push_pledge then
			if v.push_pledge > 0 and (msgTbl.room_state == ROOM_STATE.DEAL)then
				self:ShowTuiflag(v.seat+1,v.push_pledge)
			end
		end
	end

	-- 其他玩家牌
	for seatIdx, roomPlayer in pairs(self.roomPlayers) do
        if seatIdx == self.playerSeatIdx then
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

		-- 准备标志
		if roomPlayer.state == PLAYER_STATE.READY or roomPlayer.state == PLAYER_STATE.READY_WAIT then
			self.readySigns[roomPlayer.displaySeatIdx]:setVisible(true)
		end

		-- 压分标识
		if roomPlayer.pledge > 0 then
			local pledgeSignImg = self.pledgeSigns[roomPlayer.displaySeatIdx]
            local bflScore = pledgeSignImg:getChildByName("bfLabel")
			bflScore:setString(roomPlayer.pledge.."分")
            if self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER then
                bflScore:setString("x"..roomPlayer.pledge)
            end
			pledgeSignImg:setVisible(true)
		end
		
		
			-- 闲家买码标识
		if roomPlayer.buyPledge and roomPlayer.buyPledge > 0 then
			local buyPledgeSignImg = self.buyPledgeSigns[roomPlayer.displaySeatIdx]
			local bflScore = buyPledgeSignImg:getChildByName("bfLabel")
			bflScore:setString(roomPlayer.buyPledge)
			--bflScore:setVisible(true)
			buyPledgeSignImg:setVisible(true)
		end

        -- 抢庄倍率标识
        if (self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_FREE_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER) and roomPlayer.state == PLAYER_STATE.LOOT then
            local rate = roomPlayer.loot_dealer
            if (roomPlayer.pledge > 0) then
                --如果已压过分了，则庄家显示抢庄时已压的倍率，其他人显示已压的压分标识
                if self:isBanker(roomPlayer.seatIdx) then
                    local bflRateSign = self.bflRateSigns[roomPlayer.displaySeatIdx]
                    if (rate > 0) then
                        bflRateSign:setString(rate.."倍")
                    else
                        --bflRateSign:setString("不抢")
                        --抢庄时庄家是点的不抢随出来的，抢完庄要显示成1倍
                        bflRateSign:setString("1倍")
                    end
                    bflRateSign:setVisible(true)
                end
            else
                local bflRateSign = self.bflRateSigns[roomPlayer.displaySeatIdx]
                if (rate > 0) then
                    bflRateSign:setString(rate.."倍")
                else
                    bflRateSign:setString("不抢")
                    if self:isBanker(roomPlayer.seatIdx) then
                        --抢庄时庄家是点的不抢随出来的，抢完庄要显示成1倍
                        bflRateSign:setString("1倍")
                    end
                end
                bflRateSign:setVisible(true)
            end
        end

		if #(roomPlayer.cards_in_hand) > 0 then
            if (roomPlayer.state < PLAYER_STATE.SHOW_CARD) then
                --没过亮牌
                self:showHandCards(false, roomPlayer.displaySeatIdx, roomPlayer.cards_in_hand, roomPlayer.cardsign_in_hand, nil, nil, true)
            else
                --已亮牌
                self:showHandCards(false, roomPlayer.displaySeatIdx, roomPlayer.cards_in_hand, roomPlayer.cardsign_in_hand, roomPlayer.sex, roomPlayer.niu_type, true)
            end
		end
	end

    -- 琼海抢庄显示底分
    self:showQHBaseScore()

    self.bReconnect = false

end

function PlayScene:showHandCardsByQueue(roomPlayer)
	--local data = {displaySeatIdx=displaySeatIdx, cards=cards, sex=sex, niu_type=niu_type}
	table.insert(self.cardShowQueue, roomPlayer)
end

--显示手牌
function PlayScene:showHandCards(bOrbitAni, displaySeatIdx, cards, cardsigns, sex, niu_type, bShowAll)
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

	cardView.imgNiuType:setVisible(false)
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
        if bShowAll then
            cardView.imgNiuType:runAction(cc.Sequence:create(cc.CallFunc:create(call_back2)))
        else
            cardView.imgNiuType:runAction(cc.Sequence:create(cc.CallFunc:create(call_back), cc.DelayTime:create(niuEffectTime), cc.CallFunc:create(call_back2)))
        end
	end
	cardView.imgScore:setVisible(false)

end

--玩家准备回调
function PlayScene:onRcvReady(msgTbl)
	local seatIdx = msgTbl.seat + 1
	self:playerGetReady(seatIdx)

    local seatNum = gt.getTableSize(self.roomPlayers)
    if (self.isWait and seatNum >= self.roomChairs) then

        self.readyBtn:setVisible(false)
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
end

--玩家暂停回调
function PlayScene:onRcvPause(msgTbl)
	local seatIdx = msgTbl.seat + 1
	local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)
	if not roomPlayer then return end
    roomPlayer.state = PLAYER_STATE.PAUSE
	roomPlayer.isWait = true
	if seatIdx == self.playerSeatIdx then
		self.isWait = true
	end
end

--玩家预准备等待回调 此时是占了座位观战者
function PlayScene:onRcvReadyWait(msgTbl)
    local seatIdx = msgTbl.seat + 1
    local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)
    if not roomPlayer then return end
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
    end
end

-- 准备晚了，座位被占了回调
function PlayScene:onRcvReadyLate()
    require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, gt.LocationStrings.LTKey_0064, nil, nil, true, self:isTwelve())
end

-- 玩家押分回调
function PlayScene:onRcvPledge(msgTbl)
	local seatIdx = msgTbl.seat + 1
	local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)
	if not roomPlayer then return end
	roomPlayer.pledge = msgTbl.pledge
    roomPlayer.state = PLAYER_STATE.PLEDGE
    -- 隐藏抢庄压倍倍率
	local bflRateSign = self.bflRateSigns[roomPlayer.displaySeatIdx]
    bflRateSign:setVisible(false)
	-- 显示玩家压分分数
	local pledgeSignImg = self.pledgeSigns[roomPlayer.displaySeatIdx]
    local bflScore = pledgeSignImg:getChildByName("bfLabel")
	bflScore:setString(msgTbl.pledge.."分")
    if self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER then
        bflScore:setString("x"..msgTbl.pledge)
    end
	pledgeSignImg:setVisible(true)
	-- 玩家本身
	if seatIdx == self.playerSeatIdx then
		-- 隐藏压分按钮
		self.decisionBtnNode:setVisible(false)
	end
	self:CloseTuiflag()
	
	local readySignSpr = self.readySigns[roomPlayer.displaySeatIdx]
	readySignSpr:setVisible(false)
end

-- 提示押分
function PlayScene:onPromptPledge(msgTbl)
    self.waitType = nil
    self.bgWaitingTip:setVisible(false)
    self:hideBuyPledge()
    self.autoWaitTime = msgTbl.time
    if (self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER or self.tableSetting.game_type == gt.GameType.GAME_FREE_BANKER) then
        --自由抢庄 明牌抢庄
        self.roomState = ROOM_STATE.LOOT
        if (not self.isWait and self.bRobDealersAni) then
            local callFuncTmp = cc.CallFunc:create(function()
                self.waitType = WAIT_TYPE.PLEDGE
                self:updateAutoWaitCD()
                self.bRobDealersAni = false
            end)
            self:runAction(cc.Sequence:create(cc.DelayTime:create(self.robDealerAniTime), callFuncTmp))
        else
            self.waitType = WAIT_TYPE.PLEDGE
            self:updateAutoWaitCD()
        end
    else
        self.waitType = WAIT_TYPE.PLEDGE
        self:updateAutoWaitCD()
        self.roomState = ROOM_STATE.START
        --隐藏准备标识 明牌抢庄会在发牌时隐藏，自由抢庄会在提示压倍率时隐藏
        if not self.isWait then
            self:hidePlayersReadySign()
        end
    end


    if (not self.isWait and msgTbl.flag == 0) then
        self.scoreTui = msgTbl.push_pledge
        local bShowMaxScore = msgTbl.show_max_score
        local showDouble = msgTbl.pledge_double
        if (self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER or self.tableSetting.game_type == gt.GameType.GAME_FREE_BANKER) and self.bRobDealersAni then
            self.bRobDealersAni = false
            local callFunc = cc.CallFunc:create(function()
	            if not self:isBanker() then
                    self:showScoreBtn(showDouble)
                    --播放开始下注押分音效
                    gt.soundEngine:playEffect("common/start_bet", false)
	            end
		    end)
            self:runAction(cc.Sequence:create(cc.DelayTime:create(self.robDealerAniTime), callFunc))
        else
	        if not self:isBanker() then
                self:showScoreBtn(showDouble)
                --播放开始下注押分音效
                gt.soundEngine:playEffect("common/start_bet", false)
	        end
        end
    end
end

function PlayScene:onPromptBuyPledge(msgTbl)
	gt.log("-------------onPromptBuyPledge")

	self.autoWaitTime = msgTbl.time
	if (not self.isWait and self.bRobDealersAni) then
	 	local callFuncTmp = cc.CallFunc:create(function()
	            self.waitType = WAIT_TYPE.BUY_PLEDGE
	            self:updateAutoWaitCD()

	            local roomPlayer = self:GetPlayerMe()
	            if not roomPlayer then return end
				if not self:isBanker() and roomPlayer and roomPlayer.state ~= PLAYER_STATE.PAUSE then
					roomPlayer.state = PLAYER_STATE.BUY_PLEDGE
					self:showBuyPledge()
				end
		
		
	            self.bRobDealersAni = false                
	        end)
	        self:runAction(cc.Sequence:create(cc.DelayTime:create(self.robDealerAniTime), callFuncTmp))
	else
		self.waitType = WAIT_TYPE.BUY_PLEDGE
		self:updateAutoWaitCD()

		local roomPlayer =self:GetPlayerMe()
		if not roomPlayer then return end
		if not self:isBanker() and roomPlayer and roomPlayer.state ~= PLAYER_STATE.PAUSE and roomPlayer.state ~= PLAYER_STATE.READY_WAIT then
			roomPlayer.state = PLAYER_STATE.BUY_PLEDGE
			self:showBuyPledge()
		end
		
	end
end

function PlayScene:GetPlayerMe()
	local playerMe 
	for i,v in pairs(self.roomPlayers) do
		if v.uid== gt.playerData.uid then
			playerMe = v
			break
		end
	end 
	return playerMe
end

function PlayScene:GetPlayerBySeatIdx(seatIdx_)
	for i,v in pairs(self.roomPlayers) do
		if v.seatIdx==seatIdx_ then
			return v
		end
	end
	return nil
end

function PlayScene:onRcvBuyPledge(msgTbl)
	gt.log("-------------onRcvBuyPledge")
	self.buyPledgeSignNode:setVisible(true)

	local seatIdx = msgTbl.be_buy_seat + 1
	local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)
	if not roomPlayer then return end
	roomPlayer.buyPledge =  msgTbl.buy_pledge_score -- + (roomPlayer.buyPledge or 0) 
	
	--buy pledge sign
	local buyPledgeSignImg = self.buyPledgeSigns[roomPlayer.displaySeatIdx]
	local bflScore = buyPledgeSignImg:getChildByName("bfLabel")
	if roomPlayer.buyPledge > 0 then
		gt.soundEngine:playEffect("common/ys/bet",false)
		buyPledgeSignImg:setVisible(true)
		bflScore:setString(roomPlayer.buyPledge)
	end

end

--提示可以抢庄压倍率
function PlayScene:onPromptRate(msgTbl)
    --self.rateBtnNode:setVisible(true)
    self.autoWaitTime = msgTbl.time
    self:hideBuyPledge()
    --自由抢庄
    if (self.tableSetting.game_type == gt.GameType.GAME_FREE_BANKER) then
        if not self.isWait then
            --播放请抢庄音效
            gt.soundEngine:playEffect("common/rob_zhuang", false)
            --显示选择倍率按钮
            self.rateBtnNode:setVisible(true)
            self:hidePlayersReadySign()
            self.readyBtn:setVisible(false)
        end

        --显示选择倍数等待时间
        self.waitType = WAIT_TYPE.LOOT
        self:updateAutoWaitCD()
    end
end

--玩家抢庄压倍率回调
function PlayScene:onRcvRate(msgTbl)
	if msgTbl.code == 1 then
		require("app/views/CommonTips"):create(gt.getLocationString("LTKey_0066"))
		return
	end
	local seatIdx = msgTbl.seat + 1
	local roomPlayer = self.roomPlayers[seatIdx]
	if not roomPlayer then return end
	roomPlayer.loot_dealer = msgTbl.loot_dealer
    roomPlayer.state = PLAYER_STATE.LOOT
    --隐藏准备图标
    local readySignSpr = self.readySigns[roomPlayer.displaySeatIdx]
	readySignSpr:setVisible(false)
	-- 显示玩家倍率
	local bflRateSign = self.bflRateSigns[roomPlayer.displaySeatIdx]
    local rate = roomPlayer.loot_dealer
    if (rate > 0) then
        bflRateSign:setString(rate.."倍")
    else
        bflRateSign:setString("不抢")
    end
    --如果开启了暗抢
    if (self.tableSetting.game_type == gt.GameType.GAME_BANKER and self.tableSetting.steal == 1) then
        if (rate > 0) then
            bflRateSign:setString("抢")
        end
    end
	bflRateSign:setVisible(true)
    -- 玩家本身
	if seatIdx == self.playerSeatIdx then
		-- 隐藏压倍率按钮
		self.rateBtnNode:setVisible(false)
	end
end

-- 提示开始
function PlayScene:onRcvPromptStart(msgTbl)
	self.roomState = ROOM_STATE.READY

	if msgTbl.flag == 0 then
        self.waitType = nil
        self.bgWaitingTip:setVisible(false)
        if (not self.isWait) then
		    self.startBtn:setVisible(true)
		    self.Btn_ViewFinalReport:setVisible(false)
        end
	else
		self.startBtn:setVisible(false)
	end
end

-- 开始游戏回调
function PlayScene:onRcvStart(msgTbl)
	self.Btn_ViewFinalReport:setVisible(false)
    if msgTbl.code == 0 then
		self.IsNewGame=false
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
        require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, gt.LocationStrings.LTKey_0055, nil, nil, true, self:isTwelve())
    elseif msgTbl.code == 2 then
        --人数不够，无法开始游戏
        self.startBtn:setVisible(true)
        require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, gt.LocationStrings.LTKey_0056, nil, nil, true, self:isTwelve())
    elseif msgTbl.code == 3 then
        --AA付费至少6人才可开始游戏
        self.startBtn:setVisible(true)
        require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, gt.LocationStrings.LTKey_0061, nil, nil, true, self:isTwelve())                 
    end
end

-- 发牌
function PlayScene:onRcvDealCard(msgTbl)
	if self:HasTrusteeship() then
		self.Btn_Trusteeship:setVisible(true)
	else
		self.Btn_Trusteeship:setVisible(false)
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


    local cardNum = 5
    if self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER then
        --抢庄牛牛或琼海抢庄
        cardNum = self.tableSetting.cards_count
    end

	--先屏蔽不会发的牌
	for i = cardNum,5 do
		for j,v in pairs(self.roomPlayers) do
			local cardView = self.cardViews[v.displaySeatIdx]
			cardView.imgCards[i]:setVisible(false)
		end
	end
	-- 发牌动画
	local playNode = gt.seekNodeByName(self.rootNode, "Node_play")
	for j = 1, cardNum do
		for k, v in pairs(self.roomPlayers) do
			if not v.isWait then
				local cardView = self.cardViews[v.displaySeatIdx]
				cardView.node:setVisible(true)
				if cardView.node:getChildByTag(9999) then
					cardView.node:removeChildByTag(9999)
				end
				cardView.imgNiuType:setVisible(false)
				cardView.imgNiuRate:setVisible(false)
				cardView.imgScore:setVisible(false)

				for m = 1, cardNum do
					cardView.imgCards[m]:setVisible(false)
					if (self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER) or self.tableSetting.IsReplay then
						if not self.isWait and m <= cardNum and v.seatIdx == self.playerSeatIdx then
							local playerMe = self:GetPlayerMe()
							if playerMe~= nil then
								cardView.imgCards[m]:loadTexture(string.format("image/card/%02x.png", playerMe.cards_in_hand[m]), ccui.TextureResType.plistType)
							end
						elseif self.tableSetting.IsReplay then
							local player = self:GetPlayerBySeatIdx(v.seatIdx)
							if player~= nil then
								cardView.imgCards[m]:loadTexture(string.format("image/card/%02x.png", player.cards_in_hand[m]), ccui.TextureResType.plistType)
							end
						else
							cardView.imgCards[m]:loadTexture(self.card_back, ccui.TextureResType.plistType)
						end
					else
						cardView.imgCards[m]:loadTexture(self.card_back, ccui.TextureResType.plistType)
					end
				end

				local scale = 0.5
				if v.displaySeatIdx == 1 then
					scale = 1
				end

				local pos = cc.pAdd(cc.p(cardView.node:getPosition()), cc.p(cardView.imgCards[j]:getPosition()))
				local sp = cc.Sprite:createWithSpriteFrameName(self.card_back)
				sp:setPosition(0, 0)
				--sp:setTag(i*5+j)
				if self:isTwelve() then
					sp:setRotation(-90)
				end
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
				cardView.imgCards[j]:runAction(cc.Sequence:create(cc.DelayTime:create(delayTime+moveTime), cc.Show:create()))
			end
		end
	end

    if (not self.isWait) then
        local baseDelayTime = 1.2
        if self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER then
            --如果是抢庄牛牛 显示压倍率抢庄
            local delayTime2 = baseDelayTime * (cardNum / 5)
            self.rateBtnNode:runAction(cc.Sequence:create(cc.DelayTime:create(delayTime2), cc.Show:create(),
            cc.CallFunc:create(function ()
                --播放请抢庄音效
                gt.soundEngine:playEffect("common/rob_zhuang", false)
                --显示选择倍数等待时间
                self.waitType = WAIT_TYPE.LOOT
                self:updateAutoWaitCD()
            end)))
        else
            -- 显示翻牌
            local callfunc = function()
                --self:openCardBtnClickEvt()
                if (self:isOpenRubCard()) then
                    self.rubCardBtn:setVisible(true)
                end
                self.openCardBtn:setVisible(true)

                self.waitType = WAIT_TYPE.SHOW_CARD
                self:updateAutoWaitCD()
            end
	        self.openCardBtn:runAction(cc.Sequence:create(cc.DelayTime:create(baseDelayTime), cc.CallFunc:create(callfunc)))
        end
    else
        if self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER then
            --显示选择倍数等待时间
            self.waitType = WAIT_TYPE.LOOT
            self:updateAutoWaitCD()
        else
            self.waitType = WAIT_TYPE.SHOW_CARD
            self:updateAutoWaitCD()
        end
    end
end

--发剩余的牌（抢庄后）
function PlayScene:onRcvDealLeftCard(msgTbl)

    self.waitType = nil
    self.bgWaitingTip:setVisible(false)
	self:clearNiuEffect()
    self.roomState = ROOM_STATE.DEAL2

	if self.tableSetting.IsReplay then
		for i = 1,self.roomChairs do
			if self.roomPlayers[i] and not self.roomPlayers[i].isWait then
				self.roomPlayers[i].state = PLAYER_STATE.DEAL2
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
		for i = 1, self.roomChairs do
			if self.roomPlayers[i] and not self.roomPlayers[i].isWait then
				self.roomPlayers[i].state = PLAYER_STATE.DEAL2
				if i == self.playerSeatIdx then
					self.roomPlayers[i].cards_in_hand = msgTbl.self_cards
					self.roomPlayers[i].niu_type = msgTbl.res_type
				else
					self.roomPlayers[i].cards_in_hand = msgTbl.other_cards
				end
			end
		end
	end

	-- 发牌动画
    local cardNum = self.tableSetting.cards_count
	local playNode = gt.seekNodeByName(self.rootNode, "Node_play")
	for j = cardNum+1, 5 do
		for k, v in pairs(self.roomPlayers) do
			if not v.isWait then
				local cardView = self.cardViews[v.displaySeatIdx]
				cardView.node:setVisible(true)
				if cardView.node:getChildByTag(9999) then
					cardView.node:removeChildByTag(9999)
				end
				cardView.imgNiuType:setVisible(false)
				cardView.imgNiuRate:setVisible(false)
				for m = cardNum+1, 5 do
					cardView.imgCards[m]:setVisible(false)
					cardView.imgCards[m]:loadTexture(self.card_back, ccui.TextureResType.plistType)
				end
				local scale = 0.5
				if v.displaySeatIdx == 1 then
					scale = 1
				end

				local pos = cc.pAdd(cc.p(cardView.node:getPosition()), cc.p(cardView.imgCards[j]:getPosition()))
				local sp = cc.Sprite:createWithSpriteFrameName(self.card_back)
				sp:setPosition(0, 0)
				sp:setScale(scale*0.8)
				playNode:addChild(sp)
				local moveTime = 0.2
				local delayTime = (j-cardNum-1)*(moveTime/2) --((j-cardNum)*5+k-5)*moveTime
				local callFun = function ()
					if (v.seatIdx == self.playerSeatIdx) then
						gt.soundEngine:playEffect("common/fa_pai", false)
					end
				end
				local moveTo = cc.Spawn:create(cc.CallFunc:create(callFun), cc.MoveTo:create(moveTime, pos), cc.ScaleTo:create(moveTime, scale), cc.FadeOut:create(moveTime))
				sp:runAction(cc.Sequence:create(cc.Hide:create(), cc.DelayTime:create(delayTime), cc.Show:create(), moveTo, cc.RemoveSelf:create()))
				cardView.imgCards[j]:runAction(cc.Sequence:create(cc.DelayTime:create(delayTime+moveTime), cc.Show:create()))
			end
		end
	end

    if (not self.isWait) then
        -- 显示翻牌
        local baseDelayTime = 1.2
        local delayTime2 = baseDelayTime * ((5 - cardNum)/5)
        local callfunc = function()
            --self:openCardBtnClickEvt()
            if (self:isOpenRubCard()) then
                self.rubCardBtn:setVisible(true)
            end
            self.openCardBtn:setVisible(true)

            self.waitType = WAIT_TYPE.SHOW_CARD
            self:updateAutoWaitCD()
        end
	    self.openCardBtn:runAction(cc.Sequence:create(cc.DelayTime:create(delayTime2), cc.CallFunc:create(callfunc)))
    else
        self.waitType = WAIT_TYPE.SHOW_CARD
        self:updateAutoWaitCD()
    end
end

--提示亮牌
function PlayScene:onPromptShowCard(msgTbl)
    self.autoWaitTime = msgTbl.time
	if self.decisionBtnNode then
		self.decisionBtnNode:setVisible(false)
	end
	self.rateBtnNode:setVisible(false)
end

--点击亮牌回调
function PlayScene:onRcvShowCard(msgTbl)
	--gt.dump(msgTbl, "liangpai onRcvShowCard============")
	local seatIdx = msgTbl.seat + 1
	local roomPlayer = self.roomPlayers[seatIdx]
	if not roomPlayer then return end
	roomPlayer.cards_in_hand = msgTbl.cards
	roomPlayer.cardsign_in_hand = msgTbl.cardsign_in_hand
	roomPlayer.niu_type = msgTbl.niu_type
    roomPlayer.state = PLAYER_STATE.SHOW_CARD
    --gt.log("点击亮牌回调点击亮牌回调点击亮牌回调")
    self:showHandCardsByQueue(roomPlayer)

    --如果是自己或者是参观者则隐藏亮牌按钮
    if (seatIdx == self.playerSeatIdx or self.isWait) then
        self.showCardBtn:setVisible(false)
    end
end

--换庄回调
function PlayScene:onRecvDealerSeat(msgTbl)
    --庄家座位号
	self.bankerSeatIdx = msgTbl.seat + 1
    --桌子状态
    self.roomState = msgTbl.room_state

    --更换庄家标识
    self:hidePlayersBankerSign()
    if (self.tableSetting.game_type ~= gt.GameType.GAME_BANKER and self.tableSetting.game_type ~= gt.GameType.GAME_QH_BANKER and self.tableSetting.game_type ~= gt.GameType.GAME_FREE_BANKER) then
        self:showBankerSign()
    end

    if self.curRound == 1 and self.roomState == ROOM_STATE.READY then
        local roomPlayerBanker =  self:GetPlayerBySeatIdx(self.bankerSeatIdx)
        if not roomPlayerBanker then return end
        local tip = string.format("等待%s开始游戏...", roomPlayerBanker.nickname)
        self.lbWatingTip:setString(tip)
        self.bgWaitingTip:setVisible(true)
    end

    --如果是抢庄牛牛且是真正的抢庄换庄 显示抢庄结果特效
    if self.roomState > ROOM_STATE.READY and (self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER or self.tableSetting.game_type == gt.GameType.GAME_FREE_BANKER) then
        local robDealers = {}
        local noRobDealers = {}
        local maxRate = 1
        for key, var in pairs(self.roomPlayers) do
            maxRate = var.loot_dealer
            for k, v in pairs(self.roomPlayers) do
                if (maxRate < v.loot_dealer) then
                    maxRate = v.loot_dealer
                end
            end
            if (var.loot_dealer == -1 and not var.isWait) then
                table.insert(noRobDealers, var)
            end
        end
        if (maxRate >= 1) then
            for key, var in pairs(self.roomPlayers) do
                if (var.loot_dealer == maxRate and not var.isWait) then
                    table.insert(robDealers, var)
                end
            end
        end

        local playerNum = gt.getTableSize(self.roomPlayers)
        if (#noRobDealers == playerNum) then
            robDealers = noRobDealers
        end

        local num = #robDealers
        if (num > 1) then
            --抢庄中音效
            gt.soundEngine:playEffect("common/rob_zhuang_ani", false)
            --抢庄动画
            self.bRobDealersAni = true
            for key, var in ipairs(robDealers) do
                local robFrameSpr = self.playerRobZhuangFrames[var.displaySeatIdx]
		        robFrameSpr:runAction(cc.Sequence:create(cc.Show:create(), cc.Blink:create(2, 10), cc.Hide:create()))
            end

            local func = function ()
                --曝光音效
                gt.soundEngine:playEffect("common/exposure", false)
                --曝光特效
                local sk = sp.SkeletonAnimation:create("image/play/effect/qiangzhuang_2.json", "image/play/effect/qiangzhuang_2.atlas")
		        sk:setAnimation(0, "animation", false)
		        sk:registerSpineEventHandler(function (event)
				        sk:runAction(cc.RemoveSelf:create())
			        end, sp.EventType.ANIMATION_END)

		        local roomPlayerBanker = self.roomPlayers[self.bankerSeatIdx]
		        if not roomPlayerBanker then return end
                local playerInfoNode = gt.seekNodeByName(self.rootNode, "Node_playerInfo_" .. roomPlayerBanker.displaySeatIdx)
		        playerInfoNode:addChild(sk, 1000)
            end
            self:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(func)))

            --播放完抢庄动画后显示庄家标识
            local func2 = function()
                self:showBankerSign()
            end
            self:runAction(cc.Sequence:create(cc.DelayTime:create(self.robDealerAniTime), cc.CallFunc:create(func2)))
        else
            self:showBankerSign()
        end
    end

    --如果是斗公牛 把庄家底分加上
    if self.tableSetting.game_type == gt.GameType.GAME_BULL then
        local roomPlayerBanker = self.roomPlayers[self.bankerSeatIdx]
        if not roomPlayerBanker then return end
        roomPlayerBanker.scoreLabel:setString(tostring(msgTbl.score))
    end
end

--玩家在线标识
function PlayScene:onRcvOffLineState(msgTbl)
	local seatIdx = msgTbl.seat + 1
	local roomPlayer = self.roomPlayers[seatIdx]
	if not roomPlayer then return end
	local playerInfoNode = self.playerNodes[roomPlayer.displaySeatIdx]
	-- 离线标示
	local offLineSignSpr = gt.seekNodeByName(playerInfoNode, "Label_offline")
	offLineSignSpr:setZOrder(20000)
	if msgTbl.flag == 0 then
		-- 掉线了
		offLineSignSpr:setVisible(true)
	elseif msgTbl.flag == 1 then
		-- 回来了
		offLineSignSpr:setVisible(false)
	end
end

--当前局数/最大局数量
function PlayScene:onRcvRoundState(msgTbl)
	-- 牌局状态,剩余牌
    gt.dump(msgTbl, "onRcvRoundState")
	local remainTilesLabel = gt.seekNodeByName(self.roundStateNode, "Label_Round")
	local stateNum = string.format("%d/%d", (msgTbl.round), msgTbl.rounds)
	remainTilesLabel:setString("第" .. stateNum .. "局")
    self.curRound = msgTbl.round

    self.roundStateNode:setVisible(true)
end


--语音，表情，文字消息
function PlayScene:onRcvChatMsg(msgTbl)
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
		local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)
		if not roomPlayer then return end
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
		local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)
		if roomPlayer then
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
	end

	if weizhi == 1 then
		self.chatBtn:setEnabled(false)
        CDTime("image/play/btn_chat_hui.png", cc.p(self.chatBtn:getContentSize().width/2, self.chatBtn:getContentSize().height/2), self.chatBtn)
	end
end

function PlayScene:showGunAnimation()
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
function PlayScene:onRcvRoundReport(msgTbl)
	gt.log("游戏结束")
    gt.dump(msgTbl, "onRcvRoundReport")
    self.roomState = ROOM_STATE.SETTLE_ROUND
    self.lastRound = false
    --发送亮牌结束时间，关闭搓牌流程
    gt.dispatchEvent(gt.EventType.SHOW_CARD_OVER)
    self.autoWaitTime = msgTbl.time
    self.waitType = nil
    self.bgWaitingTip:setVisible(false)
    --隐藏翻牌按钮
    self.openCardBtn:setVisible(false)
    --隐藏亮牌按钮
    self.showCardBtn:setVisible(false)
    self.rubCardBtn:setVisible(false)
    --隐藏邀请按钮
    if (not self.isWait) then
        self.inviteFriendBtn:setVisible(false)
    end
	-- 隐藏押分按钮
	self.decisionBtnNode:setVisible(false)

    local showCardNum = #self.cardShowQueue
    self.showCardAniTime = showCardNum * 1
	--local delayTime = cc.DelayTime:create(self.showCardAniTime+4)
    local delayTime = cc.DelayTime:create(self.showCardAniTime)
    local seatNum = gt.getTableSize(self.roomPlayers)
	local callFunc = cc.CallFunc:create(function(sender)
        -- 隐藏玩家等待提示
        self:hidePlayersWaitSign()
        --把所有桌子上的点了准备玩家状态置为参与者
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
					if not self.lastRound then
						self.readyBtn:loadTextureNormal("image/play/btn_ready.png")
						self.readyBtn:setVisible(true)
					end
                end
            end
			if var.state == PLAYER_STATE.READY_WAIT then
				var.isWait = false
			end
        end
        self.waitType = WAIT_TYPE.READY
        self:updateAutoWaitCD()
	    -- 停止倒计时音效
	    self.playTimeCD = nil
	    -- 隐藏倒计时
	    self.playTimeCDLabel:setVisible(false)
        if (self.isWait) then
            -- 隐藏牌型
            --self:hideSigns()
        end
	end)
    --最后一局不显示准备(服务器会小结算协议后立即在改变局数协议就把局数改变)
    if (self.curRound < self.tableSetting.rounds) then
	    local seqAction = cc.Sequence:create(delayTime, callFunc)
	    self.readyBtn:runAction(seqAction)
    end

    --如果是通比牛牛，则分数为正的设为庄家（仅供飘分飘金币用，实际上通比牛牛没庄家，只有一家赢家）
    if (self.tableSetting.game_type == gt.GameType.GAME_TOGETHER) then
        for i, data in ipairs(msgTbl.player_data) do
            if data.score > 0 then
                self.bankerSeatIdx = data.seat + 1
                break
            end
        end
    end

    local callFunScore = function()
	    local roomPlayerBanker = self:GetPlayerBySeatIdx(self.bankerSeatIdx)
	    if not roomPlayerBanker then return end
	    local posBanker = cc.p(self.playerNodes[roomPlayerBanker.displaySeatIdx]:getPosition())
        local bankerAddScore = 0
        local bankerMinusScore = 0
        local bankerScore = 0
        local hasBankerAdd = false
        local hasBankerMinus = false
	    for i, data in ipairs(msgTbl.player_data) do
		    -- 显示分数
		    local seatIdx = data.seat + 1
		    local score = data.score
		    local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)
		    if not roomPlayer then return end
		    local displaySeatIdx = roomPlayer.displaySeatIdx
		    self.cardViews[displaySeatIdx].lblScore:setString(tostring(score))
		    --self.cardViews[displaySeatIdx].imgScore:setVisible(true)
		    local textColor = cc.c3b(255,235,0)
		    if score < 0 then
			    textColor = cc.c3b(0, 146, 255)
		    end
		    self.cardViews[displaySeatIdx].lblScore:setTextColor(textColor)

		    -- 玩家增加分数
		    roomPlayer.score = roomPlayer.score + score
		    if self.isMatch then
		    	roomPlayer.score = data.total_score
		    end
		    
		    local playerNode = self.playerNodes[displaySeatIdx]
		    local lblScore = gt.seekNodeByName(playerNode, "Label_Score")
		    lblScore:setString(tostring(roomPlayer.score))

		    local pos = cc.p(self.playerNodes[displaySeatIdx]:getPosition())
            local posSeatIdx = displaySeatIdx
            local bankerSeatIdx = roomPlayerBanker.displaySeatIdx
		    if seatIdx ~= self.bankerSeatIdx then
			    if score > 0 then
                    hasBankerMinus = true
                    bankerMinusScore = bankerMinusScore - score
				    self:showCoinFlyTo(score, 1, posBanker, pos, bankerSeatIdx, posSeatIdx)
			    elseif score < 0 then
                    hasBankerAdd = true
                    bankerAddScore = bankerAddScore + (0-score)
				    self:showCoinFlyTo(0-score, 0, pos, posBanker, posSeatIdx, bankerSeatIdx)
			    end
            else
                bankerScore = score
		    end
	    end

        --庄家飘分
        local callFun = function ()
            local banker = self:GetPlayerBySeatIdx(self.bankerSeatIdx)
            if not banker then return end
            if (bankerAddScore > 0) then
                --闲家飞向庄家 飘庄家增加的总分（如果有增有减则只飘最后的总分）
                if not (hasBankerAdd and hasBankerMinus) then
                    self:playAddScoreAni(banker.displaySeatIdx, bankerAddScore)
                end
            end
            if (bankerMinusScore < 0) then
                --庄家飞向闲家 飘庄家减少的总分
                if (bankerAddScore > 0) then
                    --先播庄家增加的分再播减少的分
--                    local callFun2 = function ()
--                        self:playAddScoreAni(banker.displaySeatIdx, bankerMinusScore)
--                    end
--                    self:runAction(cc.Sequence:create(cc.DelayTime:create(1.2), cc.CallFunc:create(callFun2)))
                    self:playAddScoreAni(banker.displaySeatIdx, bankerScore)
                else
                    self:playAddScoreAni(banker.displaySeatIdx, bankerMinusScore)
                end
            end
        end
        self:runAction(cc.Sequence:create(cc.DelayTime:create(1.1), cc.CallFunc:create(callFun)))

	    -- 庄家通杀
        local maxSeatIdx = msgTbl.max_seat + 1
	    if self.tableSetting.rounds ~= self.curRound and self.tableSetting.game_type ~= gt.GameType.GAME_TOGETHER and maxSeatIdx == self.bankerSeatIdx then
            self.tongSha = sp.SkeletonAnimation:create("image/play/effect/quanchangtongsha.json", "image/play/effect/quanchangtongsha.atlas")
		    self.tongSha:setAnimation(0, "tongsha", false)
		    self.tongSha:registerSpineEventHandler(function (event)
				    self.tongSha:runAction(cc.Sequence:create(cc.CallFunc:create(function() self.tongSha=nil end), cc.RemoveSelf:create()))
			    end, sp.EventType.ANIMATION_END)
		    self.tongSha:setPosition(gt.winCenter.x, gt.winCenter.y)

		    if self:isTwelve() then
		    	self.tongSha:setRotation(-90)
		    end

		    self:addChild(self.tongSha, 1000)
            self.tongSha:setScale(0.8)
            self.tongSha:setPosition(self.tongSha:getPositionX() - 50, self.tongSha:getPositionX()-200)
	    end
    end
    self:runAction(cc.Sequence:create(cc.DelayTime:create(self.showCardAniTime), cc.CallFunc:create(callFunScore)))

    for i, data in ipairs(msgTbl.player_data) do
		-- 显示分数
		local seatIdx = data.seat + 1
		local roomPlayer = self.roomPlayers[seatIdx]
		if not roomPlayer then return end
		local displaySeatIdx = roomPlayer.displaySeatIdx
		self.cardViews[displaySeatIdx].imgScore:runAction(cc.Sequence:create(cc.DelayTime:create(self.showCardAniTime+0.1), cc.Show:create()))
    end
end

function PlayScene:isTwelve()
	return self.roomChairs == gt.GameChairs.TWELVE
end

-- 显示金币飞行动画
function PlayScene:showCoinFlyTo(count, delay, fromPos, toPos, fromDisplayIdx, toDisplayIdx)
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
   		local bankerPlayer = self:GetPlayerBySeatIdx(self.bankerSeatIdx)
   		if not bankerPlayer then return end
        if (toDisplayIdx ==  bankerPlayer.displaySeatIdx) then
            --是自己飞向庄家  飘自己减少的分
            self:playAddScoreAni(fromDisplayIdx, 0-addScore)
        else
            --是庄家飞向自己 飘自己增加的分
            self:playAddScoreAni(toDisplayIdx, addScore)
        end
    end
    self:runAction(cc.Sequence:create(cc.DelayTime:create(maxDelayTime), cc.CallFunc:create(callFun2)))
end

function PlayScene:playAddScoreAni(playerIdx, addScore)
    local lbAddScore = self.playerAddSocre[playerIdx]
    lbAddScore:setPosition(0,0)
    lbAddScore:setOpacity(255)
    lbAddScore:setTextColor(cc.c3b(255,247,104))  --黄色
    lbAddScore:setString("+"..addScore)
    if addScore < 0 then
        lbAddScore:setTextColor(cc.c3b(1,229,251))  --蓝色
        lbAddScore:setString(""..addScore)
    end
    local lbPos = cc.p(0, 76)
    lbAddScore:runAction(cc.Sequence:create(cc.Show:create(),cc.MoveTo:create(0.8,lbPos), cc.FadeOut:create(0.2)))
end

function PlayScene:copyTab(st)
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
function PlayScene:onRcvFinalReport(msgTbl)
	gt.removeLoadingTips()
    --发送关闭解散房间事件
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
			self:addChild(finalReport, PlayScene.ZOrder.REPORT)
		end)
	else
		self.lastRound = true
		self.roomState = ROOM_STATE.SETTLE_ROOM
		self.readyBtn:setVisible(false)
		gt.log("总结算界面提示")
		local curRoomPlayers = {}
		curRoomPlayers = self:copyTab(self.roomPlayers)

		local callFunc = cc.CallFunc:create(function(sender)
			-- -- 弹出总结算界面
			local finalReport = require("app/views/FinalReport"):create(self.roomID, self.guildID, self.isMatch, curRoomPlayers, msgTbl, self.tableSetting)
			self:addChild(finalReport, PlayScene.ZOrder.REPORT)
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
function PlayScene:showResultEffect(win)
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
function PlayScene:onRcvDismissRoom(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 1 then -- 房主直接解散
		require("app/views/NoticeTips"):create("提示", "房主已解散房间", function() gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE) end, function() gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE) end, true, self:isTwelve())
	elseif msgTbl.code == 2 then  -- 投票解散
		require("app/views/NoticeTips"):create("提示", "房间已解散", function() gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE) end, function() gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE) end, true, self:isTwelve())
	elseif msgTbl.code == 0 then  -- 大结算后解散
	end
	self.dismissed = true
	gt.socketClient:close()
	if self.sportId and self.sportId > 0 then
		gt.socketClient:connect(gt.LoginServer.ip, gt.LoginServer.port, true)
		local msgToSend = {}
		msgToSend.cmd = gt.LOGIN_USERID
		msgToSend.ver = gt.resVersion
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		gt.socketClient:sendMessage(msgToSend)
	end
end

function PlayScene:onRcvSponorVote(msgTbl)
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
	    applyDimissRoom = require("app/views/ApplyDismissRoom"):create(msgTbl, self.isWait ,self:isTwelve())
	    self:addChild(applyDimissRoom, PlayScene.ZOrder.DISMISS_ROOM, 1000099)    
    end
end

function PlayScene:onRcvVote(msgTbl)
	local player = msgTbl.player
    local flag = msgTbl.flag
    gt.dispatchEvent(gt.EventType.APPLY_DIMISS_ROOM, msgTbl)

    if not msgTbl.flag then
        --有人拒绝解散了,开启自动托管
        self.autoTimePause = false
    end
end

function PlayScene:onRcvSyncScore(msgTbl)
	local player = msgTbl.player
	for i, v in pairs(self.roomPlayers) do
		if v.uid == player then
			v.score = msgTbl.score
			local displaySeatIdx = v.displaySeatIdx
			local playerNode = self.playerNodes[displaySeatIdx]
			local lblScore = gt.seekNodeByName(playerNode, "Label_Score")
			lblScore:setString(tostring(v.score))
			break
		end
	end
end

function PlayScene:onRcvScoreLeak(msgTbl)
	require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, "积分不足，无法参与比赛", nil, nil, true, self:isTwelve())
	self.readyBtn:setVisible(true)
end
function PlayScene:onRcvTrust(msg)
	local seat = msg.seat + 1
	if seat == self.playerSeatIdx then
		if msg.ai_type == 0 then
			--取消托管
			self.LastTouchCD = 20
			self.Node_Trusteeship:setVisible(false)
		else
			self.LastTouchCD = 9999999999
			self.Node_Trusteeship:setVisible(true)
			gt.dispatchEvent("Close_Trusteeship")
		end
	end
end
--更新当前时间
function PlayScene:updateCurrentTime()
	local timeLabel = gt.seekNodeByName(self.rootNode, "Label_Time")
	local curTimeStr = os.date("%X", os.time())
	local timeSections = string.split(curTimeStr, ":")
	-- 时:分
	timeLabel:setString(string.format("%s:%s", timeSections[1], timeSections[2]))
end

--更新电量和网络状态
function PlayScene:updateBatteryAndNetwork()
    local bg = gt.seekNodeByName(self.rootNode, "Img_NetworkBg")
	local barBattery = gt.seekNodeByName(bg, "LoadingBar_Battery")
	local lblNetwork = gt.seekNodeByName(bg, "Label_Network")
    local imgNetwork = gt.seekNodeByName(bg, "Img_Network")

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
function PlayScene:roomAddPlayer(roomPlayer)
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
	scoreLabel:setString(tostring(roomPlayer.score))
	roomPlayer.scoreLabel = scoreLabel
	-- 离线标示
	--local offLineSignSpr = gt.seekNodeByName(playerInfoNode, "Spr_offLineSign")
	--offLineSignSpr:setVisible(false)
	-- 庄家
	local bankerSignSpr = gt.seekNodeByName(playerInfoNode, "Spr_bankerSign")
	bankerSignSpr:setVisible(false)
    local robFrameSpr = gt.seekNodeByName(playerInfoNode, "Img_RobZhuang")
    robFrameSpr:setVisible(false)
	if self.tableSetting.game_type ~= gt.GameType.GAME_TOGETHER and self.bankerSeatIdx == roomPlayer.seatIdx then
        if self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER then
            --明牌抢庄琼海抢庄  准备--开始--发首牌--抢庄
            if (self.roomState == ROOM_STATE.INIT or self.roomState == ROOM_STATE.RESRART or self.roomState == ROOM_STATE.READY or self.roomState == ROOM_STATE.START or self.roomState == ROOM_STATE.DEAL) then
                bankerSignSpr:setVisible(false)
            else
                bankerSignSpr:setVisible(true)
                robFrameSpr:setVisible(true)
            end
        elseif self.tableSetting.game_type == gt.GameType.GAME_FREE_BANKER then
            --自由抢庄  准备--开始--抢庄
            if (self.roomState == ROOM_STATE.INIT or self.roomState == ROOM_STATE.RESRART or self.roomState == ROOM_STATE.READY or self.roomState == ROOM_STATE.START) then
                bankerSignSpr:setVisible(false)
            else
                bankerSignSpr:setVisible(true)
                robFrameSpr:setVisible(true)
            end
        else
            bankerSignSpr:setVisible(true)
            robFrameSpr:setVisible(true)
        end
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

    --牌型
    local cardNum = #roomPlayer.cards_in_hand
    if not self.bReconnect and cardNum > 0 then
        if cardNum == 4 or roomPlayer.state ~= PLAYER_STATE.SHOW_CARD then
            --没亮过牌
            self:showHandCards(false, roomPlayer.displaySeatIdx, roomPlayer.cards_in_hand, roomPlayer.cardsign_in_hand, nil, nil, true)
        else
            --已亮过牌
            self:showHandCards(false, roomPlayer.displaySeatIdx, roomPlayer.cards_in_hand, roomPlayer.cardsign_in_hand, roomPlayer.sex, roomPlayer.niu_type, true)
        end
    end

    --压倍率
    local bflRateSign = self.bflRateSigns[roomPlayer.displaySeatIdx]
    if (roomPlayer.loot_dealer and roomPlayer.loot_dealer > 0 and roomPlayer.state ~= PLAYER_STATE.READY_WAIT and roomPlayer.state >= PLAYER_STATE.PLEDGE) then
        bflRateSign:setString(roomPlayer.loot_dealer.."倍")
        if (self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER) and roomPlayer.state ~= PLAYER_STATE.DEAL then
            --明牌抢庄  准备--开始--发首牌--抢庄
            bflRateSign:setVisible(true)
        elseif self.tableSetting.game_type == gt.GameType.GAME_FREE_BANKER then
            --自由抢庄  准备--开始--抢庄
            bflRateSign:setVisible(true)
        end
    end

    --押分
    local pledgeSign = self.pledgeSigns[roomPlayer.displaySeatIdx]
    if (roomPlayer.pledge and roomPlayer.pledge > 0 and not self:isBanker(roomPlayer.seatIdx)) then
        local bflScore = pledgeSign:getChildByName("bfLabel")
		bflScore:setString(roomPlayer.pledge.."分")
        if self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER then
            bflScore:setString("x"..roomPlayer.pledge)
        end
        bflRateSign:setVisible(false)
        pledgeSign:setVisible(true)
    end
	if not self:isTwelve() then
		--闲家买码
		local buyPledgeSign = self.buyPledgeSigns[roomPlayer.displaySeatIdx]
		if (roomPlayer.buyPledge and roomPlayer.buyPledge > 0 and not self:isBanker(roomPlayer.seatIdx)) then
			local bflScore = pledgeSign:getChildByName("bfLabel")
			bflScore:setString(roomPlayer.buyPledge)

			buyPledgeSign:setVisible(true)
		end
	end

end

-- 房间信息按钮回调
function PlayScene:infoBtnClickEvt()
    local roomInfo = require("app/views/RoomInfo"):create(self.tableSetting,nil,self:isTwelve())
	self:addChild(roomInfo, PlayScene.ZOrder.SETTING)
end

--发送玩家准备请求消息
function PlayScene:readyBtnClickEvt()
	
	self.readyBtn:setVisible(false)
	if self.isMatch > 0 and self.Btn_ViewFinalReport then
    	self.Btn_ViewFinalReport:setVisible(false)
    end
	for i = 1, self.roomChairs do
		--self.cardViews[i].node:setVisible(false)
		self.pledgeSigns[i]:setVisible(false)
        self.bflRateSigns[i]:setVisible(false)
	end
	local msgToSend = {}
	msgToSend.cmd = gt.READY
	gt.socketClient:sendMessage(msgToSend)
end

-- 开始游戏
function PlayScene:startBtnClickEvt()
	self.startBtn:setVisible(false)
	local msgToSend = {}
	msgToSend.cmd = gt.START_DN
	gt.socketClient:sendMessage(msgToSend)
end

-- 点击亮牌
function PlayScene:showCardBtnClickEvt()
	self.showCardBtn:setVisible(false)

	local msgToSend = {}
	msgToSend.cmd = gt.SHOW_CARD_DN
	gt.socketClient:sendMessage(msgToSend)
end

-- 点击搓牌
function PlayScene:rubCardBtnClickEvt()
	local playerMe = self:GetPlayerMe()
	if not playerMe then return end 
    local cards = {}
    if self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER then
        --抢庄牛牛
        if (self.tableSetting.cards_count == 3) then
            table.insert(cards, playerMe.cards_in_hand[4])
            table.insert(cards, playerMe.cards_in_hand[5])
        else
            table.insert(cards, playerMe.cards_in_hand[5])
        end
    else
        cards = playerMe.cards_in_hand
    end
    local rubCardsAni = require("app/views/RubCardsAni"):create(cards, playerMe.cards_in_hand, self.tableSetting.game_id , self:isTwelve())
	self:addChild(rubCardsAni, PlayScene.ZOrder.SETTING)    
end

-- 点击翻牌
function PlayScene:openCardBtnClickEvt()
	self.openCardBtn:setVisible(false)
    self.rubCardBtn:setVisible(false)
	local playerMe = self.roomPlayers[self.playerSeatIdx]
	self:showHandCards(true, playerMe.displaySeatIdx, playerMe.cards_in_hand, playerMe.cardsign_in_hand, nil, nil)
	if not self:isBanker() or self.tableSetting.game_type == gt.GameType.GAME_TOGETHER then
		self.showCardBtn:setVisible(true)
	end
end

--玩家进入准备状态
function PlayScene:playerGetReady(seatIdx)
	local roomPlayer = self.roomPlayers[seatIdx]
	if roomPlayer then
	    --玩家状态改成准备状态
	    roomPlayer.state = PLAYER_STATE.READY
	    roomPlayer.pledge = 0
	    roomPlayer.isWait = false
	    local lbWait = self.playerWaitSigns[roomPlayer.displaySeatIdx]
	    lbWait:setVisible(false)

		-- 显示玩家准备手势
	--	local readySignNode = gt.seekNodeByName(self.rootNode, "Node_readySign")
	--	readySignNode:setZOrder(1000000)
		local readySignSpr = self.readySigns[roomPlayer.displaySeatIdx]
		readySignSpr:setVisible(true)
	end
	
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
function PlayScene:hidePlayersReadySign()
	for i = 1, self.roomChairs do
		self.readySigns[i]:setVisible(false)
	end
end

--隐藏所有玩家闲家买码标识
function PlayScene:hidePlayersBuyPledgeSign()
	if self:isTwelve() then
		return
	end
	for i = 1,self.roomChairs do
		self.buyPledgeSigns[i]:setVisible(false)
	end
	for key,roomPlayer in pairs(self.roomPlayers) do
		roomPlayer.buyPledge = 0
	end

end

--隐藏所有玩家压分标识
function PlayScene:hidePlayersPledgeSign()
	for i = 1, self.roomChairs do
		self.pledgeSigns[i]:setVisible(false)
	end
end

--隐藏所有玩家抢庄倍数标识
function PlayScene:hidePlayersRateSign()
    for i = 1, self.roomChairs do
        self.bflRateSigns[i]:setVisible(false)
    end
end

--隐藏所有玩家庄家标识
function PlayScene:hidePlayersBankerSign()
    for i = 1, self.roomChairs do
        local playerInfoNode = gt.seekNodeByName(self.rootNode, "Node_playerInfo_"..i)
        local bankerSignSpr = gt.seekNodeByName(playerInfoNode, "Spr_bankerSign")
        bankerSignSpr:setVisible(false)

        local robZhuangSpr = self.playerRobZhuangFrames[i]
        robZhuangSpr:setVisible(false)
    end
end

--隐藏所有玩家等待标识
function PlayScene:hidePlayersWaitSign()
    for i = 1, self.roomChairs do
        local lbWait = self.playerWaitSigns[i]
        lbWait:setVisible(false)
    end
end

--隐藏所有玩家抢庄亮框图
function PlayScene:hidePlayersRobZhuangFrame()
    for i = 1, self.roomChairs do
        local robZhuangSpr = self.playerRobZhuangFrames[i]
        robZhuangSpr:stopAllActions()
        robZhuangSpr:setVisible(false)
    end
end

--隐藏牛类型并停止相应动作
function PlayScene:hideNiuTypeActions()
    self.cardShowQueue = {}
    for i = 1, self.roomChairs do
	    self.cardViews[i].imgNiuType:setVisible(false)
        self.cardViews[i].imgNiuType:stopAllActions()
        self.cardViews[i].imgScore:stopAllActions()
    end
end

--隐藏牌型并停止相应动作
function PlayScene:hideCardViewsActions()
    for i = 1, self.roomChairs do
	    self.cardViews[i].node:setVisible(false)
        self.cardViews[i].imgNiuType:stopAllActions()
--        for j = 1, #self.cardView.imgCards do
--            self.cardView.imgCards[j]:stopAllActions()
--        end
    end
end

--隐藏牌型
function PlayScene:hideCardViews()
    for i = 1, self.roomChairs do
        self.cardViews[i].node:setVisible(false)
    end
end

--清除牛牛特效
function PlayScene:clearNiuEffect()
    for i = 1, self.roomChairs do
        local cardView = self.cardViews[i]
		cardView.effectNode:removeAllChildren()
    end
end

-- 每局准备后隐藏相应标识
function PlayScene:hideSigns()
    -- 隐藏压分标识
    self:hidePlayersPledgeSign()
    -- 隐藏压倍率标识
    self:hidePlayersRateSign()
	-- 隐藏闲家买码标识
	self:hidePlayersBuyPledgeSign()
    -- 隐藏牌型
    self:hideCardViews()
    --清除牛牛特效
    self:clearNiuEffect()
    -- 如果是抢庄牛牛 每小局结算后隐藏庄家标识
    if (self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER or self.tableSetting.game_type == gt.GameType.GAME_FREE_BANKER) then
        self:hidePlayersBankerSign()
        self:setShowPledgeScoreBtn()
    end
end

--重置牌型位置
function PlayScene:resetCardsPos()
	for i = 1, self.roomChairs do
		for j = 1, 5 do
			local pos = self.cardViews[i].imgCards[j].imgCardPos
            self.cardViews[i].imgCards[j]:setPosition(pos)
		end
    end
end

--重置手牌明暗标识
function PlayScene:resetCardSigns()
    for key, var in pairs(self.roomPlayers) do
        var.cardsign_in_hand = self.cardSignInHandInit
    end

	for i = 1, self.roomChairs do
		for j = 1, 5 do
            self.cardViews[i].imgCards[j]:setColor(cc.c3b(255,255,255))
		end
    end
end

--房间是否已坐满员
function PlayScene:isSeatFull()
    local bFull = false
    local playerNum = gt.getTableSize(self.roomPlayers)
    if (self.roomChairs == gt.GameChairs.SIX and playerNum == gt.GameChairs.SIX) or (self.roomChairs == gt.GameChairs.TEN and playerNum == gt.GameChairs.TEN) then
        bFull = true
    end

    return bFull
end

--设置亮牌时牌型明暗显示 0标识暗，1标识亮（牛1到牛牛葫芦牛：3+2，炸弹4+1）
function PlayScene:setShowCardsShow(displaySeatIdx, cardsigns)
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
function PlayScene:setShowCardsPos(niuType, displaySeatIdx)
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
function PlayScene:showPlayerInfo(sender)
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
	local playerInfoTips = require("app/views/PlayerInfoTips"):create(roomPlayer, shpwType , self:isTwelve())
	self:addChild(playerInfoTips, PlayScene.ZOrder.PLAYER_INFO_TIPS)
end


--出牌倒计时
function PlayScene:playTimeCDStart(timeDuration,appear)
	self.playTimeCD = timeDuration
	self.playTimeCDLabel:setVisible(appear)
	self.playTimeCDLabel:setString(tostring(timeDuration))
end

--更新出牌倒计时
function PlayScene:playTimeCDUpdate(delta)
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
function PlayScene:changePk(poker)
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

function PlayScene:rubCardOverEvt()
    self:openCardBtnClickEvt()
end

function PlayScene:playSceneResetEvt()
	if not self.IsReplay then
		gt.log("playSceneResetEvt")
		--从后台回来先清除下之前缓存的消息
		gt.socketClient:clearMessage()
		--这里清掉数据不清掉界面
		--比赛场中如果在最后一局断线重连不会不会收到断线重连的消息
		if self.isMatch and self.tableSetting and self.curRound>=self.tableSetting.rounds then
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

function PlayScene:reInitScene()
	self.waitType = nil
	gt.dispatchEvent(gt.EventType.CLOSE_APPLY_DISMISSROOM)

	self.startBtn:setVisible(false)
	if self.decisionBtnNode then
		self.decisionBtnNode:setVisible(false)
	end
	self:hideBuyPledge()
    self.rateBtnNode:setVisible(false)
    self.rateBtnNode:stopAllActions()
	self.showCardBtn:setVisible(false)
    self.rubCardBtn:setVisible(false)
	self.openCardBtn:setVisible(false)
    self.openCardBtn:stopAllActions()
    self.bgWaitingTip:setVisible(false)
	self:resetCardSigns()
    self:hidePlayersRobZhuangFrame()
    self:hideCardViewsActions()
	self:hidePlayersBuyPledgeSign()
	self:hidePlayersReadySign()
	self:hidePlayersPledgeSign()
	self:hidePlayersRateSign()
	self.readyBtn:loadTextureNormal("image/play/sitdown.png")
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

function PlayScene:playSceneRestartEvt()
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

function PlayScene:backMainSceneEvt(eventType)
	extension.callBackHandler = {}
	-- 消息回调
	self:unregisterAllMsgListener()
	-- 连接大厅
	gt.socketClient:close()
	gt.socketClient:connect(gt.LoginServer.ip, gt.LoginServer.port, true)
	local msgToSend = {}
	msgToSend.cmd = gt.LOGIN_USERID
	msgToSend.ver = gt.resVersion
	msgToSend.user_id = gt.playerData.uid
	msgToSend.open_id = gt.playerData.openid 
	gt.socketClient:sendMessage(msgToSend)

	local mainScene = require("app/views/MainScene"):create(false)
	cc.Director:getInstance():replaceScene(mainScene)
end

function PlayScene:IsSameIp(msgTbl)
	local SameIpNode = gt.seekNodeByName(self.rootNode, "Node_SameIP")
	SameIpNode:setZOrder(20000000000)
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
function PlayScene:isOpenRubCard()
    local op = tonumber(gt.charAt(self.tableSetting.options,9))
    if (op == 0) then
        return true
    end

    return false
end

-- 创建房间时是否开启自动托管
function PlayScene:isAuto()
--    local op = tonumber(gt.charAt(self.tableSetting.options,8))
--    if (op == 1) then
--        return true
--    end

--    return false
    return true
end

--显示房间玩法标题
function PlayScene:showPlayTitle()
    if (self.roomChairs == gt.GameChairs.SIX) then
        local str = ""
        local strScore = string.format("%d/%d分", self.tableSetting.score, self.tableSetting.score*2)
        if (self.tableSetting.score == 2) then
			strScore = string.format("%d/%d分",2,4)
		elseif (self.tableSetting.score == 3) then
			strScore = string.format("%d/%d分",3,6)
		elseif (self.tableSetting.score == 4) then
			strScore = string.format("%d/%d分",4,8)
		elseif (self.tableSetting.score == 5) then
			strScore = string.format("%d/%d分",5,10)
		elseif (self.tableSetting.score == 11) then
			strScore = string.format("%d/%d/%d/%d分",2,3,4,5)
		elseif (self.tableSetting.score == 12) then
			strScore = string.format("%d/%d/%d/%d分",2,4,8,10)
		elseif (self.tableSetting.score == 13) then
			strScore = string.format("%d/%d/%d/%d分",3,6,12,15)
		elseif (self.tableSetting.score == 14) then
			strScore = string.format("%d/%d/%d/%d分",4,8,16,20)
		elseif (self.tableSetting.score == 15) then
			strScore = string.format("%d/%d/%d/%d分",5,10,20,25)
		elseif (self.tableSetting.score == 16) then
			strScore = string.format("%d/%d/%d/%d分",1,2,4,5)
		end

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
function PlayScene:showBankerSign()
	self:CloseTuiflag()
    local roomPlayerBanker = self:GetPlayerBySeatIdx(self.bankerSeatIdx)
	if roomPlayerBanker then
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

--显示押分按钮
function PlayScene:showScoreBtn(showDouble)
    local nodeScore = gt.seekNodeByName(self.decisionBtnNode, "Node_Score")
    nodeScore:setVisible(false)
    local nodeQHScore = gt.seekNodeByName(self.decisionBtnNode, "Node_QHScore")
    nodeQHScore:setVisible(false)
    local nodeScoreSpecial = gt.seekNodeByName(self.decisionBtnNode, "Node_ScoreSpecial")
    nodeScoreSpecial:setVisible(false)

    if (self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER) then
        nodeQHScore:setVisible(true)
    else
    	local _max = 2
    	local step_ = 72
		if self:isTwelve() then step_ = 58 end

    	if self:isScoreSpecial11() then
        	nodeScoreSpecial:setVisible(true)
        	gt.seekNodeByName(nodeScoreSpecial,"btnScore1"):setPositionX(-3 * step_)
			gt.seekNodeByName(nodeScoreSpecial,"btnScore2"):setPositionX(-step_)
			gt.seekNodeByName(nodeScoreSpecial,"btnScore3"):setPositionX(step_)
			gt.seekNodeByName(nodeScoreSpecial,"btnScore4"):setPositionX(3 * step_)
			self.btnScoreTui:setPositionX(5 * step_)
			self.btnDoubleScore:setPositionX(5 * step_)

    		for i = 1, 4 do
				local scoreBtn = gt.seekNodeByName(nodeScoreSpecial,"btnScore"..i)
				scoreBtn:setVisible(true)
			end
    	else
        	nodeScore:setVisible(true)
        	gt.seekNodeByName(nodeScore,"btnScore1"):setPositionX(-90.00)
			gt.seekNodeByName(nodeScore,"btnScore2"):setPositionX(90.00)
			self.btnScoreTui:setPositionX(270.00)
			self.btnDoubleScore:setPositionX(270.00)


        	for i = 1, 2 do
				local scoreBtn = gt.seekNodeByName(nodeScore,"btnScore"..i)
				scoreBtn:setVisible(true)
			end
    	end
    	
        if showDouble == 1 then
            --有翻倍按钮
            self.btnDoubleScore:setVisible(true)
        else
            self.btnDoubleScore:setVisible(false)
        end

        if (self.scoreTui > 0) then
            --有推注按钮
            if showDouble == 1 then
				if self:isScoreSpecial11() then
					-- self.btnDoubleScore:setPositionX(480.00)
					gt.seekNodeByName(nodeScoreSpecial,"btnScore1"):setPositionX(-5 * step_)
					gt.seekNodeByName(nodeScoreSpecial,"btnScore2"):setPositionX(-3 * step_)
					gt.seekNodeByName(nodeScoreSpecial,"btnScore3"):setPositionX(- step_)
					gt.seekNodeByName(nodeScoreSpecial,"btnScore4"):setPositionX(step_)
					self.btnScoreTui:setPositionX(3* step_)
				else
					-- self.btnDoubleScore:setPositionX(360.00)
					gt.seekNodeByName(nodeScore,"btnScore1"):setPositionX(-270.00)
					gt.seekNodeByName(nodeScore,"btnScore2"):setPositionX(-90.00)
					self.btnScoreTui:setPositionX(90.00)
				end
			end
		
            self.lbScoreTui:setString(self.scoreTui)
            self.btnScoreTui:setVisible(true)
        else
            self.btnScoreTui:setVisible(false)
        end
    end
	self.decisionBtnNode:setVisible(true)
	self.readyBtn:setVisible(false)
    self.rateBtnNode:setVisible(false)
end

--根据房间设置显示压分按钮
function PlayScene:setShowPledgeScoreBtn()
    if (self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER) then
        --琼海抢庄
        local nodeQHScore = gt.seekNodeByName(self.decisionBtnNode, "Node_QHScore")
        for i = 1, 4 do
            local scoreBtn = gt.seekNodeByName(nodeQHScore, "btnScore"..i)
            local lbScore = scoreBtn:getChildByName("bfLabel")
            local pledge = 1
            if self.tableSetting.score == 5 then
                if i == 2 then
                    pledge = 2
                elseif i == 3 then
                    pledge = 4
                elseif i == 4 then
                    pledge = 5
                end
            elseif self.tableSetting.score == 8 then
                if i == 2 then
                    pledge = 3
                elseif i == 3 then
                    pledge = 5
                elseif i == 4 then
                    pledge = 8
                end
            end

            local soundScore = "rate"..pledge
            lbScore:setString(string.format("%d倍", pledge))
		    gt.addBtnPressedListener(scoreBtn, function(sender)
			    local msgToSend = {}
			    msgToSend.cmd = gt.PLEDGE_DN
			    msgToSend.pledge = pledge
                msgToSend.pledge_type = 0
                msgToSend.pledge_double = 0
			    gt.socketClient:sendMessage(msgToSend)
		    end, soundScore, gt.playerData.sex)
        end
    else
    	local _max = 2
		if self:isScoreSpecial11() then
			_max = 4
		end
        for i = 1, _max do
            local nodeScore = gt.seekNodeByName(self.decisionBtnNode, "Node_Score")
            if self:isScoreSpecial11() then
				nodeScore = gt.seekNodeByName(self.decisionBtnNode, "Node_ScoreSpecial")
			end
		    local scoreBtn = gt.seekNodeByName(nodeScore, "btnScore"..i)
            local lbScore = scoreBtn:getChildByName("bfLabel")
            local pledge_double = 0
            local pledge = self.tableSetting.score * i
            if self:isScoreSpecial() then
				pledge = gt.getScoreSpecialDetail(self.tableSetting.score, i)
			end
            if self.bDoublePledge then
                pledge = pledge * 2
                pledge_double = 1
            end
            local soundScore = "fen"..pledge
            lbScore:setString(pledge)
		    gt.addBtnPressedListener(scoreBtn, function(sender)
			    local msgToSend = {}
			    msgToSend.cmd = gt.PLEDGE_DN
			    msgToSend.pledge = pledge
                msgToSend.pledge_type = 0
                msgToSend.pledge_double = pledge_double
			    gt.socketClient:sendMessage(msgToSend)
		    end, soundScore, gt.playerData.sex)
	    end
        self.bDoublePledge = false
    end
end

--根据房间设置显示抢庄倍数按钮
function PlayScene:setShowRateBtn()
    local nodeRateList = {}
    for i = 1, 5 do
        nodeRateList[i] = self.rateBtnNode:getChildByName("Node_Rate"..i)
        nodeRateList[i]:setVisible(false)
    end

    local rate = 1
    local tableSetRate = self.tableSetting.loot_dealer
    if (self.tableSetting.game_type == gt.GameType.GAME_FREE_BANKER) then
        --自由抢庄
        nodeRateList[5]:setVisible(true)
        for i = 1, 2 do
            local rateBtn = nodeRateList[5]:getChildByName("btnRate"..i)
            if (i == 2) then
                rate = 0
            else
			    rate = i
            end
            rateBtn:setTag(rate)

            gt.addBtnPressedListener(rateBtn, function(sender)
			    local msgToSend = {}
			    msgToSend.cmd = gt.LOOT_DEALER_DN
                local lootDealer = sender:getTag()
                if (lootDealer == 0) then
                    lootDealer = -1
                end
                msgToSend.loot_dealer = lootDealer
			    gt.socketClient:sendMessage(msgToSend)
		    end, "rate"..rate, gt.playerData.sex)
        end
    elseif (self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_QH_BANKER) then
        --明牌抢庄
        if (tableSetRate == 1) then
            nodeRateList[1]:setVisible(true)
            for i = 1, 2 do
                local rateBtn = nodeRateList[1]:getChildByName("btnRate"..i)
                if (i == 2) then
                    rate = 0
                else
			        rate = i
                end
                rateBtn:setTag(rate)

                gt.addBtnPressedListener(rateBtn, function(sender)
			        local msgToSend = {}
			        msgToSend.cmd = gt.LOOT_DEALER_DN
                    local lootDealer = sender:getTag()
                    if (lootDealer == 0) then
                        lootDealer = -1
                    end
                    msgToSend.loot_dealer = lootDealer
			        gt.socketClient:sendMessage(msgToSend)
		        end, "rate"..rate, gt.playerData.sex)
            end
        elseif (tableSetRate == 2) then
            nodeRateList[2]:setVisible(true)
            for i = 1, 3 do
                local rateBtn = nodeRateList[2]:getChildByName("btnRate"..i)
                if (i == 3) then
                    rate = 0
                else
			        rate = i
                end
                rateBtn:setTag(rate)

                gt.addBtnPressedListener(rateBtn, function(sender)
			        local msgToSend = {}
			        msgToSend.cmd = gt.LOOT_DEALER_DN
                    local lootDealer = sender:getTag()
                    if (lootDealer == 0) then
                        lootDealer = -1
                    end
                    msgToSend.loot_dealer = lootDealer
			        gt.socketClient:sendMessage(msgToSend)
		        end, "rate"..rate, gt.playerData.sex)
            end
        elseif (tableSetRate == 3) then
            nodeRateList[3]:setVisible(true)
            for i = 1, 4 do
                local rateBtn = nodeRateList[3]:getChildByName("btnRate"..i)
                if (i == 4) then
                    rate = 0
                else
			        rate = i
                end
                rateBtn:setTag(rate)

                gt.addBtnPressedListener(rateBtn, function(sender)
			        local msgToSend = {}
			        msgToSend.cmd = gt.LOOT_DEALER_DN
                    local lootDealer = sender:getTag()
                    if (lootDealer == 0) then
                        lootDealer = -1
                    end
                    msgToSend.loot_dealer = lootDealer
			        gt.socketClient:sendMessage(msgToSend)
		        end, "rate"..rate, gt.playerData.sex)
            end
        elseif (tableSetRate == 4) then
            nodeRateList[4]:setVisible(true)
            for i = 1, 5 do
                local rateBtn = nodeRateList[4]:getChildByName("btnRate"..i)
                if (i == 5) then
                    rate = 0
                else
			        rate = i
                end
                rateBtn:setTag(rate)

                gt.addBtnPressedListener(rateBtn, function(sender)
			        local msgToSend = {}
			        msgToSend.cmd = gt.LOOT_DEALER_DN
                    local lootDealer = sender:getTag()
                    if (lootDealer == 0) then
                        lootDealer = -1
                    end
                    msgToSend.loot_dealer = lootDealer
			        gt.socketClient:sendMessage(msgToSend)
		        end, "rate"..rate, gt.playerData.sex)
            end
        end
    end
end

-- 开始录音
function PlayScene:startAudio()
	local ret = extension.voiceStart()
	if not ret then
		gt.log("voice not open");
		return false
	end
	gt.log("start voice")
end

function PlayScene:getVoiceUrl(respJson)
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

function PlayScene:uploadVoice(path, time)
	gt.log("uploadVoice", path, time)
	extension.voiceupload(handler(self, self.getVoiceUrl), path, time)
end

function PlayScene:onVoiceFinish(respJson)
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
function PlayScene:stopAudio(cancel)
	gt.log("stop audio", cancel)
	self.cancelVoice = cancel

	extension.voiceStop(handler(self, self.onVoiceFinish))
end

--是否有托管功能
function PlayScene:HasTrusteeship()
	if self.IsReplay then
		return false
	end
	return (self.game_id == gt.GameID.NIUNIU and self.game_type == gt.GameType.GAME_BANKER) or
	self.game_id == gt.GameID.QIONGHAI or
	self.game_id == gt.GameID.NIUYE
end

--关闭所有人的可推注xxx标识
function PlayScene:CloseTuiflag()
	for i,v in ipairs(self.playerNodes) do
		v.TuiFlag:setVisible(false)
	end
end


function PlayScene:GetPlayerIndexByDisplayseat(displayseat_)
	local seatIndex_ = 0
	for i,v in pairs(self.roomPlayers) do
		if v.displaySeatIdx == displayseat_ then
			seatIndex_ = v.seatIdx
		end
	end
	return seatIndex_
end

function PlayScene:onRcvPush(msgTbl)
	for i,v in ipairs(msgTbl.player) do
		local localSeat=v.seat+1
		self:ShowTuiflag(localSeat,v.push_pledge)
	end
end

function PlayScene:ShowTuiflag(localSeat,score)
	if score<=0 then
		return
	end
	local playerNode=self.playerNodes[self.roomPlayers[localSeat].displaySeatIdx]
	playerNode.TuiFlag:setVisible(true)
	playerNode.TuiScore:setString(tostring(score))
end

return PlayScene

