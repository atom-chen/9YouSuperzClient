--[[
-- 扎金花的场景文件
--]]

local gt = cc.exports.gt
local YvYin_Node = require("app/views/YvYinNode")
local GrayShader = require("app/ShaderGrayEff")

local PlaySceneZJH = class("PlaySceneZJH", function()
	return cc.Scene:create()
end)

local NEED_NOTICE_SCORE = 200

PlaySceneZJH.ZOrder = {
	PLAYER_INFO					= 5,
	DECISION_BTN				= 8,
	PLAYER_INFO_TIPS			= 10,
	CHAT						= 20,
    DISMISS_ROOM				= 21,
    REPORT						= 26,
}

local PLAYER_STATE = {
	INIT = 0,       -- 初始化
	READY = 1,      -- 准备
	START = 2,	    -- 开始
    DEAL = 3,	    -- 发牌
    ACTIVITY = 4,   -- 玩牌状态
    BET = 5,        -- 押注
	SHOW_CARD = 6,	-- 亮牌
    FOLD = 8,       --弃牌
    READY_WAIT = 9, --预准备
	SETTLE_ROOM = 11,    --小结算
}

local ROOM_STATE = {
	INIT = 0,	        -- 初始化
	READY = 1,	        -- 准备
	START = 2,	        -- 开始
	DEAL = 3,	        -- 发牌
	SHOW_CARD = 4,	    -- 亮牌
    STEP = 5,           -- 下一步
    WAIT = 6,           -- 等待
    END = 7,            -- 结束
	RESRART = 8,	    -- 重新开始
	SETTLE_ROUND = 9,	-- 小结算
	SETTLE_ROOM = 10,	-- 大结算
}

--手牌状态
local HAND_CARD_STATE = {
    NONE = 0, --没牌
    DARK = 1, --暗牌
    VIEWED = 2, --明牌(已看牌)
    FOLD = 3,  --弃牌
    CMP_FAILD = 4, --比牌失败
    SHOW = 5,  --亮牌
}

local CARD_NUM = 3

function PlaySceneZJH:ctor(enterRoomMsgTbl)
	--清理纹理
	if not enterRoomMsgTbl.IsReplay then
		cc.SpriteFrameCache:getInstance():removeUnusedSpriteFrames()
		cc.Director:getInstance():getTextureCache():removeUnusedTextures()
	end

	-- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))
    
    -- 初始化变量
    self.roomChairs = enterRoomMsgTbl.max_chairs
	self.guildID = enterRoomMsgTbl.guild_id
	self.isMatch = enterRoomMsgTbl.match
    self.game_type = enterRoomMsgTbl.game_type
    self.roomID = enterRoomMsgTbl.room_id
	--限时比赛id
	self.sport_id=enterRoomMsgTbl.sport_id

    --等待类型
    self.isWait = true

    --默认自己没位置
    self.playerSeatIdx = -1
    --默认庄家没位置
    self.bankerSeatIdx = -1
	-- 房间中的玩家
	self.roomPlayers = {}

    --玩家相关节点序列
    self.playerNodes = {}
    self.playerWaitSigns = {}
    self.playerAddSocre = {}
	
	self.isRoomCreater = false
	self.roomState = ROOM_STATE.INIT
	self.relogining = false
    --当前轮数
    self.curTurns = 0
    --是否已看牌
    self.isViewedCard = false
    --可以亮牌了
    self.showCardEnabled = false 
    --是否正在比牌
    self.isCmpingCard = false
    --手牌状态
    self.handCardState = HAND_CARD_STATE.NONE

    -- 加载csb
    self:loadCSBFile()
    --初始化UI
    self:initUI()
    --初始化玩家信息
    self:initPlayersInfo()
    -- 处理操作按钮
    self:handleOperateBtns()

    --为了比牌，把rootNode上所有节点提高
    self:upLocalZOrderToOne()

    --注册所有的消息监听
    self:registerAllMsgListener()

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

function PlaySceneZJH:refreshCurTurns(num_)
	if num_ > self.tableSetting.now_rounds then
		num_ = self.tableSetting.now_rounds
	end
	if num_ == 1 then
		self.isShowTips = false
	end
	if num_ == self.tableSetting.now_rounds - 2 and not self.isShowTips then
	-- 	self.lblCmpTips:setVisible(false)
	-- else
	-- 	self.lblCmpTips:setVisible(true)
		require("app/views/CommonTips"):create("两轮后系统将从庄家下一位开始逆时针比牌")
		self.isShowTips = true
	end
	local roundStr = string.format("第 %d/%d 轮",num_,self.tableSetting.now_rounds)
	self.curTurnsLabel:setString(roundStr)
end

function PlaySceneZJH:registerAllMsgListener()
    -- 接收消息分发函数
	gt.socketClient:registerMsgListener(gt.ROOM_CARD, self, self.onRcvRoomCard) --接收房卡信息
	gt.socketClient:registerMsgListener(gt.ENTER_ROOM, self, self.onRcvEnterRoom) --进入房间
	gt.socketClient:registerMsgListener(gt.ENTER_ROOM_OTHER, self, self.onEnterRoomOther) --接收玩家消息
	gt.socketClient:registerMsgListener(gt.EXIT_ROOM, self, self.onRcvExitRoom) --从房间移除一个玩家
	gt.socketClient:registerMsgListener(gt.RECONNECT_DN, self, self.onRcvSyncRoomState) --断线重连
	gt.socketClient:registerMsgListener(gt.READY, self, self.onRcvReady) --玩家准备回调
    gt.socketClient:registerMsgListener(gt.WAIT_DN, self, self.onRcvReadyWait) --玩家预准备回调
    gt.socketClient:registerMsgListener(gt.READY_LATE, self, self.onRcvReadyLate) --准备晚了，座位被占了回调
	gt.socketClient:registerMsgListener(gt.PLEDGE_DN, self, self.onRcvPledge) --玩家押分
    gt.socketClient:registerMsgListener(gt.ACTIVITY_SEAT, self, self.onRcvPromptOperate) --通知玩家操作
	gt.socketClient:registerMsgListener(gt.PROMPT_START_DN, self, self.onRcvPromptStart) --提示显示开始游戏按钮
    gt.socketClient:registerMsgListener(gt.START_DN, self, self.onRcvStart) --开始游戏回调
	gt.socketClient:registerMsgListener(gt.DEAL, self, self.onRcvDealCard) --发牌
    --gt.socketClient:registerMsgListener(gt.PROMPT_CARD_DN, self, self.onPromptShowCard) --玩家亮牌提示
	gt.socketClient:registerMsgListener(gt.SHOW_CARD_DN, self, self.onRcvShowCard) --玩家亮牌
    gt.socketClient:registerMsgListener(gt.LOOK_CARDS, self, self.onRcvViewCard) --玩家看牌
    gt.socketClient:registerMsgListener(gt.COMPARE_DN, self, self.onRcvCmpCard) --玩家比牌
    gt.socketClient:registerMsgListener(gt.WAIVE, self, self.onRcvFoldCard) --弃牌
	gt.socketClient:registerMsgListener(gt.SAMEIP, self, self.IsSameIp) --相同IP
	gt.socketClient:registerMsgListener(gt.ONLINE_STATUS, self, self.onRcvOffLineState) --玩家在线标识
	gt.socketClient:registerMsgListener(gt.ROUND_STATE, self, self.onRcvRoundState) --当前局数/最大局数
	gt.socketClient:registerMsgListener(gt.SETTLEMENT_FOR_ROUND_DN, self, self.onRcvRoundReport) --单局游戏结束
	gt.socketClient:registerMsgListener(gt.SETTLEMENT_FOR_ROOM_DN, self, self.onRcvFinalReport) --总结算界面
	gt.socketClient:registerMsgListener(gt.DISMISS_ROOM, self, self.onRcvDismissRoom)	--解散房间
	gt.socketClient:registerMsgListener(gt.SPONSOR_VOTE, self, self.onRcvSponorVote)	--发起投票
	gt.socketClient:registerMsgListener(gt.VOTE, self, self.onRcvVote)	--选择投票
	gt.socketClient:registerMsgListener(gt.SYNC_SCORE, self, self.onRcvSyncScore)	--同步积分
	gt.socketClient:registerMsgListener(gt.SCORE_LEAK, self, self.onRcvScoreLeak)	--积分不足

	gt.registerEventListener(gt.EventType.BACK_MAIN_SCENE, self, self.backMainSceneEvt)
    gt.registerEventListener(gt.EventType.CHANGE_PLAY_BG, self, self.changePlayBg)
    gt.registerEventListener(gt.EventType.PLAY_SCENE_RESET, self, self.playSceneResetEvt)  --从后台切换到前台的处理事件
	gt.registerEventListener("gunshootFX_hit", self, self.showGunAnimation)
	gt.registerEventListener(gt.EventType.PLAY_SCENE_RESTART, self, self.playSceneRestartEvt)  -- 比赛房间重新开始
end

function PlaySceneZJH:unregisterAllMsgListener()
	gt.socketClient:unregisterMsgListener(gt.ROOM_CARD)
	gt.socketClient:unregisterMsgListener(gt.ENTER_ROOM)
	gt.socketClient:unregisterMsgListener(gt.ENTER_ROOM_OTHER)
	gt.socketClient:unregisterMsgListener(gt.EXIT_ROOM)
	gt.socketClient:unregisterMsgListener(gt.RECONNECT_DN)
	gt.socketClient:unregisterMsgListener(gt.READY)
    gt.socketClient:unregisterMsgListener(gt.WAIT_DN)
    gt.socketClient:unregisterMsgListener(gt.READY_LATE)
	gt.socketClient:unregisterMsgListener(gt.PLEDGE_DN)
    gt.socketClient:unregisterMsgListener(gt.ACTIVITY_SEAT)
    gt.socketClient:unregisterMsgListener(gt.LOOK_CARDS)
	gt.socketClient:unregisterMsgListener(gt.PROMPT_START_DN)
    gt.socketClient:unregisterMsgListener(gt.START_DN)
	gt.socketClient:unregisterMsgListener(gt.DEAL)
    gt.socketClient:unregisterMsgListener(gt.WAIVE)
	gt.socketClient:unregisterMsgListener(gt.SHOW_CARD_DN)
	gt.socketClient:unregisterMsgListener(gt.SAMEIP)
	gt.socketClient:unregisterMsgListener(gt.ONLINE_STATUS)
	gt.socketClient:unregisterMsgListener(gt.ROUND_STATE)
	gt.socketClient:unregisterMsgListener(gt.SETTLEMENT_FOR_ROUND_DN)
	gt.socketClient:unregisterMsgListener(gt.SETTLEMENT_FOR_ROOM_DN)
	gt.socketClient:unregisterMsgListener(gt.SPONSOR_VOTE)
	gt.socketClient:unregisterMsgListener(gt.VOTE)
	gt.socketClient:unregisterMsgListener(gt.SYNC_SCORE)
	gt.socketClient:unregisterMsgListener(gt.SCORE_LEAK)
	gt.socketClient:unregisterMsgListener(gt.DISMISS_ROOM)
end

-- 断线重连,重新进入房间
function PlaySceneZJH:reLogin()
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

function PlaySceneZJH:loadCSBFile()
    -- 加载界面资源
    local csbName = "csd/PlaySceneZJH.csb"
    if self.roomChairs == gt.GameChairs.TEN then
        csbName = "csd/PlaySceneZJHTen.csb"
    elseif self.roomChairs == gt.GameChairs.EIGHT then
        csbName = "csd/PlaySceneZJHEight.csb"
    end
	local csbNode = cc.CSLoader:createNode(csbName)
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
    ccui.Helper:doLayout(csbNode)
	self:addChild(csbNode)
	self.rootNode = csbNode

    self.actionTimeLine = cc.CSLoader:createTimeline(csbName)
    self.rootNode:runAction(self.actionTimeLine)
end

function PlaySceneZJH:initUI()
    --菜单项，把设置相关转移到menu处理
    self.m_menu = require("app/views/PlaySceneZJHMenu"):create(self,self.rootNode)
    --桌面
    self:changePlayBg()
	--隐藏房间玩法标题
    --[[if self.roomChairs == gt.GameChairs.SIX then
	    self.textPlayType = gt.seekNodeByName(self.rootNode, "Label_GameType")
	    self.textPlayType:setVisible(false) 
    end--]]

    --隐藏玩家等待提示
    self.bgWaitingTip = gt.seekNodeByName(self.rootNode, "Img_BgWaitingTip")
    self.bgWaitingTip:setVisible(false)
    self.lbWatingTip = gt.seekNodeByName(self.rootNode, "Label_WatingTip")

	--隐藏局数
	self.roundStateNode = gt.seekNodeByName(self.rootNode, "Img_RoundBg")
	self.roundStateNode:setVisible(false)

	--更新房间号
	local titleBg = gt.seekNodeByName(self.rootNode, "Img_SetBg")
	local roomIDLabel = gt.seekNodeByName(titleBg, "Label_RoomNumber")
	roomIDLabel:setString(self.roomID)

    --观战标识
    self.imgGuanZhan = gt.seekNodeByName(self.rootNode, "Image_GuanZhan")
    self.imgGuanZhan:setVisible(false)
    --隐藏玩家准备标志
    self:hidePlayersReadySign()

	-- 押分标示
	self.pledgeSigns = {}
	for i = 1, self.roomChairs do
		local pledgeSignNode = gt.seekNodeByName(self.rootNode, "Node_pledgeSign")
		local pladgeSignImg = pledgeSignNode:getChildByName("Img_pledgeSign_" .. i)
		pladgeSignImg:setVisible(false)
		self.pledgeSigns[i] = pladgeSignImg
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
		for j = 1, 3 do
			self.cardViews[i].imgCards[j] = cardNode:getChildByName("imgCrad"..j)
            self.cardViews[i].imgCards[j].imgCardPos = cc.p(self.cardViews[i].imgCards[j]:getPosition())
		end
	
		self.cardViews[i].imgTips = cardNode:getChildByName("Img_Tips")
		self.cardViews[i].imgTips:setVisible(false)
		self.cardViews[i].imgTipsPos = cc.p(self.cardViews[i].imgTips:getPosition())
		self.cardViews[i].lblTips = self.cardViews[i].imgTips:getChildByName("Lbl_Tips")
        self.cardViews[i].imgCardType = cardNode:getChildByName("Img_CardType")
	end
    --隐藏牌型
    self:hideAllCardType()

	-- 隐藏准备按钮
	local readyBtn = gt.seekNodeByName(self.rootNode, "Btn_ready")
	readyBtn:setVisible(false)
	gt.addBtnPressedListener(readyBtn, handler(self, self.readyBtnClickEvt))
    --[[local lbReady = gt.seekNodeByName(readyBtn, "lblReady")
    lbReady:setString("坐  下")--]]
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

    self.lblCmpTips = gt.seekNodeByName(self.rootNode,"lblCmpTips")
    self.lblCmpTips:setVisible(false)

    --隐藏奖池
    self.goldsPool = gt.seekNodeByName(self.rootNode,"Img_Golds_Pool")
    self.goldsPool:setVisible(false)
    --奖池数
    self.goldsPoolLabel = gt.seekNodeByName(self.goldsPool, "Text_Golds_Num") 
    --当前轮数
    self.curTurnsLabel = gt.seekNodeByName(self.goldsPool, "Text_Tuns_Num")

    --查看上局大结算按钮  比赛房用
	self.Btn_ViewFinalReport=gt.seekNodeByName(self.rootNode,"Btn_ViewFinalReport")
	self.Btn_ViewFinalReport:setVisible(false)
end

function PlaySceneZJH:initPlayersInfo()
    -- 头像下载管理器
	local playerHeadMgr = require("app/PlayerHeadManager"):create()
	self.rootNode:addChild(playerHeadMgr)
	self.playerHeadMgr = playerHeadMgr

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
       
        local lbAddScore = gt.seekNodeByName(playerNode, "Label_AddScore")
        lbAddScore:setVisible(false)

        self.playerWaitSigns[i] = lbWait
        self.playerAddSocre[i] = lbAddScore
		self.playerNodes[i] = playerNode
	end
end

--为了比牌，把rootNode上所有节点提高
function PlaySceneZJH:upLocalZOrderToOne()
    for _,subNode in ipairs(self.rootNode:getChildren()) do
        subNode:setLocalZOrder(2)
    end

    --背景设置成0
    gt.seekNodeByName(self.rootNode, "Img_Bg"):setLocalZOrder(0)
    gt.seekNodeByName(self.rootNode, "Node_Spine"):setLocalZOrder(0)

    --把玩家信息节点都提到rootNode
    local nodePlayerInfo = gt.seekNodeByName(self.rootNode, "Node_PlayerInfo")
    for i=1,self.roomChairs do
        local playerInfo = self.playerNodes[i]
--        playerInfo:removeFromParent()
        playerInfo:setLocalZOrder(1)
--        self.rootNode:addChild(playerInfo)

        local cardNode = self.cardViews[i].node
        local wldPos = cardNode:getParent():convertToWorldSpace(cc.p(cardNode:getPosition()))
        cardNode:removeFromParent()
        cardNode:setLocalZOrder(1)
        cardNode:setPosition(self.rootNode:convertToNodeSpace(wldPos))
        self.rootNode:addChild(cardNode)

        --比牌触碰区域按钮
        local cmpBtn = gt.seekNodeByName(self.rootNode, "Btn_Cmp_Rect_" .. i)
        if cmpBtn then
        	cmpBtn:stopAllActions()
            cmpBtn:removeAllChildren()
            -- cmpBtn:removeFromParent()
            cmpBtn:setLocalZOrder(5)
            cmpBtn:setVisible(false)
            gt.addBtnPressedListener(cmpBtn,function ()
                local seatIdx = (i - self.seatOffset - 1)%self.roomChairs + 1 --这里可能会导致找不到玩家数据或者数据错误
                --gt.log("座位信息：", i , seatIdx, self.seatOffset)
                self:sendCmpCardMsg(self:GetPlayerBySeatIdx(seatIdx))
            end)
--            self.rootNode:addChild(cmpBtn)
        end
    end

    --放到奖池之上
    self.readyBtn:setLocalZOrder(3)

    --增加个touch层，接收比牌动作,ZOrder设置为3
    --需要比牌时，把玩家头像Zorder提升到4
    self.cmpCardsGrayPanel = self.rootNode:getChildByName("Panel_CmpCards")
    self.cmpCardsGrayPanel:setLocalZOrder(3)
    self.cmpCardsGrayPanel:setVisible(false)
    self.cmpCardsGrayPanel:addTouchEventListener(handler(self, self.onTouchEventOfCmpPanel))

    --比牌特效层放到最上面
    self.rootNode:getChildByName("Panel_Cmp_Eff"):setLocalZOrder(4)
end

--比牌灰色遮盖层的touch处理
function PlaySceneZJH:onTouchEventOfCmpPanel(sender, touchType)
    if touchType == TOUCH_EVENT_ENDED then
        self:restoreCmpCardsNode()
        self.isCmpingCard = false
        -- 显示玩家操作
        self:showOprateNode(true)
    end
end

function PlaySceneZJH:restoreCmpCardsNode()
    -- 没有点到头像，取消比牌
    self.cmpCardsGrayPanel:setVisible(false)
    -- 层都恢复到1
    for i = 1, self.roomChairs do
        self.playerNodes[i]:setLocalZOrder(1)
        self.cardViews[i].node:setLocalZOrder(1)
        
        local cmpBtn = gt.seekNodeByName(self.rootNode, "Btn_Cmp_Rect_" .. i)
        if cmpBtn then
        	cmpBtn:stopAllActions()
            cmpBtn:removeAllChildren()
            cmpBtn:setVisible(false) --隐藏比牌触碰区域按钮
        end
    end
end

function PlaySceneZJH:sendWaiveMsg()
	local msgToSend = {cmd = gt.WAIVE}
    gt.socketClient:sendMessage(msgToSend)

    self:showOprateNode(false)
end

function PlaySceneZJH:handleOperateBtns()
    -- 隐藏亮牌按钮
	local showCardBtn = gt.seekNodeByName(self.rootNode, "Btn_Show_Card")
	showCardBtn:setVisible(false)
	gt.addBtnPressedListener(showCardBtn, handler(self, self.showCardBtnClickEvt))
	self.showCardBtn = showCardBtn
    
	-- 隐藏看牌按钮
	local openCardBtn = gt.seekNodeByName(self.rootNode, "Btn_View_Card")
	openCardBtn:setVisible(false)
	gt.addBtnPressedListener(openCardBtn, handler(self, self.openCardBtnClickEvt))
	self.openCardBtn = openCardBtn

    local nodeOper = gt.seekNodeByName(self.rootNode,"Node_Operates")
    nodeOper:setVisible(false)
    self.operateNode = nodeOper

    --弃牌
    local btnGiveup = gt.seekNodeByName(nodeOper,"Btn_GiveUp")
    gt.addBtnPressedListener(btnGiveup,function ()

		local function confirm()
      		self:sendWaiveMsg()
      		self.noticeTips = nil
		end
		local function onCancel()
      		self.noticeTips = nil
		end
		local tips = "是否放弃手牌，弃牌后视为认输，输掉已下注分。"
		self.noticeTips = require("app/views/NoticeTips"):create("提示", tips, confirm, onCancel, false)

    end)
    self.giveupBtn = btnGiveup

    local function onCmp()
    	
        --把比牌玩家提升ZOrder为4
        local curPlayers = {}
        for i,roomPlayer in pairs(self.roomPlayers) do
            if #roomPlayer.cards_in_hand > 0 and  --有手牌
            roomPlayer.waive_type ~= 1 and  --不是弃牌
            roomPlayer.is_win ~= false and  --不是比牌失败
            roomPlayer.seatIdx ~= self:GetPlayerMeSeat() then --不是自己
                --提高头像层次
                self.playerNodes[roomPlayer.displaySeatIdx]:setLocalZOrder(4)
                --提高牌的层次
                self.cardViews[roomPlayer.displaySeatIdx].node:setLocalZOrder(4)
                local cmpBtn = gt.seekNodeByName(self.rootNode, "Btn_Cmp_Rect_" .. roomPlayer.displaySeatIdx)
                if cmpBtn then
                    cmpBtn:setVisible(true) --隐藏比牌触碰区域按钮
                    gt.scaleNode(cmpBtn)
					self:tipArrow(cmpBtn, roomPlayer.displaySeatIdx > (self.roomChairs / 2 + 1))
                    -- curPlayerNum = curPlayerNum + 1
                    table.insert(curPlayers, roomPlayer)
                end
            end
        end
    	self.isCmpingCard = true
        self:showOprateNode(false)
        if #curPlayers <= 0 then --容错处理 避免比牌卡死
	        self.isCmpingCard = false
	        -- 显示玩家操作
	        self:showOprateNode(true)
        	self:restoreCmpCardsNode()
	    elseif #curPlayers == 1 then
	    	self:sendCmpCardMsg(curPlayers[1])
	    else
        	self.cmpCardsGrayPanel:setVisible(true)
        end
	end
    --比牌
    local btnCompare = gt.seekNodeByName(nodeOper,"Btn_Compare")
    gt.addBtnPressedListener(btnCompare,function ()
    	if self.tableSetting.zjh_bipai and self.curTurns < self.tableSetting.zjh_bipai then
		 	require("app/views/CommonTips"):create(string.format("操作失败，需要第%d回合才可以进行该操作",self.tableSetting.zjh_bipai + 1))
    	else
	         local titleLabel = btnCompare:getChildByName("Text_BM_Title")
	        local curScore = tonumber(titleLabel:getString())

	    	if self:getMyLastScore() < curScore and self.isMatch > 0 then
	    		local function onConfirm()
			   		onCmp()
		      		self.noticeTips = nil
		   		end
		   		local function onCancel()
		      		self.noticeTips = nil
				end
	    		self.noticeTips = require("app/views/NoticeTips"):create("提示", "当前积分不足点击确定后会弃牌，如果需要继续加分请点击取消并在倒计时结束先加好分数。", onConfirm, onCancel, false)
	    	else
		    	onCmp()
		    end
	    end
    end)
    self.compareBtn = btnCompare

    --跟注
    local btnBet = gt.seekNodeByName(nodeOper,"Btn_Bet")
    gt.addBtnPressedListener(btnBet,function ()
	
        local titleLabel = btnBet:getChildByName("Text_BM_Title")
        local curScore = tonumber(titleLabel:getString())

    	if self:getMyLastScore() < curScore and self.isMatch > 0 then
    		local function onConfirm()
		   		self:sendPledgeMsg(0)
	      		self.noticeTips = nil
	   		end
	   		local function onCancel()
	      		self.noticeTips = nil
			end
    		self.noticeTips = require("app/views/NoticeTips"):create("提示", "当前积分不足点击确定后会弃牌，如果需要继续加分请点击取消并在倒计时结束先加好分数。", onConfirm, onCancel, false)
    	else
	    	self:sendPledgeMsg(0) --0跟注
	    end
    end)
    self.betBtn = btnBet

    --加注选项
    local list_options = gt.seekNodeByName(nodeOper,"ListView_Btn_Raise")
    list_options:setScrollBarEnabled(false)
    local optionsArray = {}
    for i,btn in pairs(list_options:getItems()) do 
        gt.addBtnPressedListener(btn,function ()
           -- self:sendPledgeMsg(#optionsArray - i + 1) --0跟注 1、2、3

           local titleLabel = btnBet:getChildByName("Text_BM_Title")
	        local curScore = tonumber(titleLabel:getString())
	        
	    	if self:getMyLastScore() < curScore and self.isMatch > 0 then
	    		local function onConfirm()
			   		self:sendPledgeMsg(#optionsArray - i + 1)
		      		self.noticeTips = nil
		   		end
		   		local function onCancel()
		      		self.noticeTips = nil
				end
	    		self.noticeTips = require("app/views/NoticeTips"):create("提示", "当前积分不足点击确定后会弃牌，如果需要继续加分请点击取消并在倒计时结束先加好分数。", onConfirm, onCancel, false)
	    	else
		    	self:sendPledgeMsg(#optionsArray - i + 1) --0跟注
		    end

        end)
        table.insert(optionsArray,1,btn) 
    end
    list_options:setVisible(false)
    self.raiseListView = list_options
    self.raiseBtnArr = optionsArray

    --加注
    local btnRaiseBet = gt.seekNodeByName(nodeOper,"Btn_RaiseBet")
    gt.addBtnPressedListener(btnRaiseBet,function ()
        list_options:setVisible(not list_options:isVisible())
    end)
    self.raiseBtn = btnRaiseBet
end

function PlaySceneZJH:tipArrow(node, bIsRight)
	local directionX = -1
	if bIsRight then
		directionX = 1
	end
	for i=1, 3 do
		local arrowSprite = cc.Sprite:create("image/play_zjh/ui/jt.png")
		arrowSprite:setPosition(cc.p(120 + (120 + 18 * i) * directionX, 60))
		arrowSprite:setOpacity(255 * 0.2)
		if bIsRight then
			arrowSprite:setRotation(180)
		end
		node:addChild(arrowSprite)
		
		local delayTime = cc.DelayTime:create(i/6)
		local callFunc = cc.CallFunc:create(function()
			local spawn1 = cc.Spawn:create(cc.FadeIn:create(1/6), cc.MoveBy:create(1/6,cc.p(-3 * directionX, 0)))
			local spawn2 = cc.Spawn:create(cc.FadeOut:create(1/6), cc.MoveBy:create(1/6,cc.p(3 * directionX, 0)))
			local callFunc1 = cc.CallFunc:create(function()
				arrowSprite:setOpacity(255 * 0.2)
			end)
			local delayTime1 = cc.DelayTime:create(3/6)
			local action1 = cc.Sequence:create(spawn1, spawn2, callFunc1, delayTime1)
			arrowSprite:runAction(cc.RepeatForever:create(action1))
		end)
		arrowSprite:runAction(cc.Sequence:create(delayTime, callFunc))
	end
end

function PlaySceneZJH:sendPledgeMsg(type_)
	local msgToSend = {cmd = gt.PLEDGE_DN}
    msgToSend.pledge_type = type_
    gt.socketClient:sendMessage(msgToSend)

    self:showOprateNode(false)
end

function PlaySceneZJH:changePlayBg()
    local networkBg = gt.seekNodeByName(self.rootNode, "Img_NetworkBg")
    -- 电量
    local batteryBg = gt.seekNodeByName(networkBg, "Img_BatteryBg")
    local barBattery = gt.seekNodeByName(networkBg, "LoadingBar_Battery")
    -- 网络信号
    local imgNetwork = gt.seekNodeByName(networkBg, "Img_Network")
    local desktop = gt.seekNodeByName(self.rootNode, "Img_Bg")
    --local imgSetBg = gt.seekNodeByName(desktop, "Img_SetBg")
    --local roundStateNode = gt.seekNodeByName(desktop, "Img_RoundBg")
	
	local nodeSpine = gt.seekNodeByName(self.rootNode, "Node_Spine")
	nodeSpine:removeAllChildren()

    local deskString = cc.UserDefault:getInstance():getStringForKey("Desktop")


    if deskString == "1" then
		gt.soundEngine:playMusic("table_bgm1",true)
--[[        if (self.roomChairs == gt.GameChairs.SIX) then
            networkBg:loadTexture("image/play/network_bg.png", ccui.TextureResType.plistType)
	    end--]]
        desktop:loadTexture("image/play/play_bg_1.png")

    elseif deskString == "3" then
        gt.soundEngine:playMusic("special", true)
--[[		if (self.roomChairs == gt.GameChairs.SIX) then
            networkBg:loadTexture("image/play/network_bg.png", ccui.TextureResType.plistType)
        end--]]
        self.sk1 = sp.SkeletonAnimation:create("image/play/effect/xkbj.json", "image/play/effect/xkbj.atlas")
		self.sk1:setAnimation(0, "animation", true)
		nodeSpine:addChild(self.sk1)
		self.sk1:setScale(gt.xkbjScaleX, gt.xkbjScaleY)

	elseif deskString == "4" then
       gt.soundEngine:playMusic("special", true)
        desktop:loadTexture("image/play/img_kjbj.jpg")
--[[        if (self.roomChairs == gt.GameChairs.SIX) then
            networkBg:loadTexture("image/play/network_bg.png", ccui.TextureResType.plistType)
        end--]]
        self.sk2 = sp.SkeletonAnimation:create("image/play/effect/kjbj.json", "image/play/effect/kjbj.atlas")
		self.sk2:setAnimation(0, "animation", true)
		nodeSpine:addChild(self.sk2)

    else
       gt.soundEngine:playMusic("classic", true)
       desktop:loadTexture("image/play/play_bg_2.png")

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

function PlaySceneZJH:onNodeEvent(eventName)
	if "enter" == eventName then
		-- 计算更新当前时间倒计时
		local curTimeStr = os.date("%X", os.time())
		local timeSections = string.split(curTimeStr, ":")
		local secondTime = tonumber(timeSections[3])
		self.updateTimeCD = 60 - secondTime
		
		-- 逻辑更新定时器
		self.scheduleHandler = gt.scheduler:scheduleScriptFunc(handler(self, self.update), 0.1, false)
		-- gt.soundEngine:playMusic("bgm2", true)
	elseif "exit" == eventName then
		extension.callBackHandler = {}
		gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
		-- gt.soundEngine:playMusic("bgm1", true)
		ccs.ArmatureDataManager:destroyInstance()
	end
end

function PlaySceneZJH:update(delta)
	self.updateTimeCD = self.updateTimeCD - delta
	if self.updateTimeCD <= 0 then
		self.updateTimeCD = 60
	end
	 
	-- 更新倒计时
	self:playTimeCDUpdate(delta)
end


function PlaySceneZJH:GetPlayerBySeatIdx(seatIdx_)
	for i,v in pairs(self.roomPlayers) do
		if v.seatIdx==seatIdx_ then
			return v
		end
	end
	return nil
end

function PlaySceneZJH:GetPlayerMeSeat()
	if self:GetPlayerMe() then
		return self:GetPlayerMe().seatIdx
	else
		return -1
	end
end

function PlaySceneZJH:GetPlayerMe()
	local playerMe = nil
	for i,v in pairs(self.roomPlayers) do
		if v.uid== gt.playerData.uid then
			playerMe = v
			break
		end
	end 
	return playerMe
end

-- 断线重连
function PlaySceneZJH:onRcvSyncRoomState(msgTbl, isStart)
    gt.dump(msgTbl, "断线重连-----------")

    gt.removeLoadingTips()
    self:stopAllActions()

    self.readyBtn:setVisible(false)
    self.startBtn:setVisible(false)
    self.inviteFriendBtn:setVisible(false)
    self.imgGuanZhan:setVisible(false)
    self.showCardBtn:setVisible(false)
    self.openCardBtn:setVisible(false)
    self.openCardBtn:stopAllActions()
    self.bgWaitingTip:setVisible(false)
    if self.goldsPool then
    	self.goldsPool:setVisible(false)
    	self.goldsPool:stopAllActions()
    end
    if self.noticeTips then
		self.noticeTips:removeFromParent()
		self.noticeTips = nil
	end

    -- 游戏开始后隐藏准备标识
    self:hidePlayersReadySign()
    self:hidePlayersPledgeSign()
    self:resetCardSigns()
    self:resetCardsPos()
    self:hideAllCardType()
    self:resetGoldsPool()
    self:showOprateNode(false)

    -- 桌子配置
    require("json")
    self.tableSetting = json.decode(msgTbl.kwargs)
	
	--禁言设置
	self.is_shutup = 0
	if 1 == self.tableSetting.is_shutup then
		self.is_shutup = 1
	end

    self.curRound = msgTbl.round
    local bShowMaxScore = msgTbl.show_max_score
    local showDouble = msgTbl.pledge_double

    local roundsData = { }
    roundsData.round = msgTbl.round
    roundsData.rounds = msgTbl.rounds
    self:onRcvRoundState(roundsData)
    --self:showPlayTitle()

    -- 已经被占了的座位数量
    local seatNum = #msgTbl.player
    -- 桌子状态
    self.roomState = msgTbl.room_state
    if msgTbl.owner == gt.playerData.uid then
        self.isRoomCreater = true
    end
    if self.isMatch > 0 and self.IsNewGame then
        self.readyBtn:setPositionX(-150)
        --self.readyBtn:getChildByName("lblReady"):setString("继续游戏")
        self.readyBtn:loadTextureNormal("image/play/btn_continue.png")
        self.Btn_ViewFinalReport:setVisible(true)
        self.Btn_ViewFinalReport:setPositionX(150)
    end
    -- 庄家座位号
    self.bankerSeatIdx = msgTbl.dealer + 1
    -- 自己的状态
    local myselfState = msgTbl.player_status
    -- 桌子没坐满时且没有准备过的观战者显示准备，邀请按钮
    if (myselfState == PLAYER_STATE.INIT and seatNum < self.roomChairs) then
        self.readyBtn:setVisible(true)
        self.imgGuanZhan:setVisible(true)
        if not gt.isIOSReview() then
            self.inviteFriendBtn:setVisible(true)
        end
    end

    -- 当前压分
    self.cur_need_pledge = msgTbl.base_pledge
    -- 刷新底池数
    -- if msgTbl.base_score and tonumber(msgTbl.base_score) > 0 then
    --     self.goldsPool:setVisible(true)
    --     self:betGolds(nil, msgTbl.base_score)
    -- end
    self.goldsPool:setVisible(true)
    self:resetGoldsPool()
    if msgTbl.pledge_records and tonumber(#msgTbl.pledge_records) > 0 then
        self:betGoldRecords(nil, msgTbl.pledge_records)
    end
    -- 刷新轮数
    self.curTurns = msgTbl.now_rounds
    -- self.curTurnsLabel:setString(msgTbl.now_rounds + 1)
    self:refreshCurTurns(msgTbl.now_rounds + 1)

    if msgTbl.room_state == ROOM_STATE.INIT
       or msgTbl.room_state == ROOM_STATE.READY
       or msgTbl.room_state == ROOM_STATE.RESRART
       or msgTbl.room_state == ROOM_STATE.SETTLE_ROUND then --清除桌子
          self.goldsPool:setVisible(false)
    end

    -- 玩家自己
    for i, v in ipairs(msgTbl.player) do
        if v.player == gt.playerData.uid then
            -- 玩家座位编号
            self.playerSeatIdx = v.seat + 1
            -- 玩家显示固定座位号
            self.playerFixDispSeat = 1
            -- 逻辑座位和显示座位偏移量(从0编号开始)
            local seatOffset =(self.playerFixDispSeat - 1) - v.seat
            self.seatOffset = seatOffset

            -- 自己是已经坐下的观战者显示邀请按钮
            if v.is_wait then
                self.imgGuanZhan:setVisible(true)
                if not gt.isIOSReview() then
                    self.inviteFriendBtn:setVisible(true)
                end
            end

            if (msgTbl.room_state == ROOM_STATE.INIT
                or msgTbl.room_state == ROOM_STATE.READY
                or msgTbl.room_state == ROOM_STATE.RESRART
                or msgTbl.room_state == ROOM_STATE.SETTLE_ROUND) then
                -- 初始状态
                if not v.is_wait and v.state ~= PLAYER_STATE.READY then
                    --gt.seekNodeByName(self.readyBtn, "lblReady"):setString("准  备")
                    self.readyBtn:loadTextureNormal("image/play/btn_ready.png")
                    --self.readyBtn:setVisible(true)
                end
            end

            if (msgTbl.room_state == ROOM_STATE.INIT
                or msgTbl.room_state == ROOM_STATE.READY
                or msgTbl.room_state == ROOM_STATE.RESRART)
                and v.state == PLAYER_STATE.READY and not v.is_wait then
                -- 已准备状态
                if self:isBanker() and msgTbl.room_state ~= ROOM_STATE.INIT then
                    self.startBtn:setVisible(true)
                end
                if not gt.isIOSReview() then
                    self.inviteFriendBtn:setVisible(true)
                end
            end

            if self.roomState == ROOM_STATE.STEP then
                -- 玩家已看过牌，但是没有亮过牌，则显示亮牌
                self.isViewedCard = v.look_cards
                if #v.cards_in_hand > 0 then
                    if not self.isViewedCard then
                    	if not self:isWatchByOrder() and v.is_win then
			                self.openCardBtn:setVisible(true)
			            end
                    end 
                end
            end
        end
    end

    -- 按位置seat从小到大排序
    table.sort(msgTbl.player, function(a, b)
        return a.seat < b.seat
    end )
    for i, v in ipairs(msgTbl.player) do
        if (self.curRound > 1 and not v.is_wait) then
            self.inviteFriendBtn:setVisible(false)
        end
        -- 这个方法里会显示庄家标识
        self:onEnterRoomOther(v)
    end

    self.active_seat = msgTbl.active_seat + 1

    -- 刷新操作
    if self.roomState == ROOM_STATE.STEP and self.active_seat == self:GetPlayerMeSeat() then
        self:showOprateNode(true)
        self.isCmpingCard = false
        self:refreshOperateBtnsScore()
    end

    -- 刷新倒计时
    self:hideCountdown()
    if self.roomState == ROOM_STATE.STEP and self.active_seat >= 1 then
        self:showCountdown(self:GetPlayerBySeatIdx(self.active_seat).displaySeatIdx,msgTbl.time)
    end

    -- 其他玩家牌
    for seatIdx, roomPlayer in pairs(self.roomPlayers) do
        if seatIdx == self:GetPlayerMeSeat() then
            if (self.curRound <= 1 and self.roomState <= ROOM_STATE.START) then
                if (self:isBanker()) then
                    if self.roomState == ROOM_STATE.INIT then
                        -- 准备后自己是庄家  则提示等待其他玩家准备
                        self.lbWatingTip:setString("等待其他玩家准备...")
                        self.bgWaitingTip:setVisible(true)
                    end
                else
                    -- 准备后自己不是庄家则不显示开始按钮，则提示等待房主开始游戏
                    local roomPlayerBanker = self:GetPlayerBySeatIdx(self.bankerSeatIdx)
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

        if self.roomState == ROOM_STATE.STEP then
            -- 压分标识
            if roomPlayer.cur_total_pledge > 0 then
                local pledgeSignImg = self.pledgeSigns[roomPlayer.displaySeatIdx]
                local bflScore = pledgeSignImg:getChildByName("Text_Bet_Score")
                bflScore:setString(roomPlayer.cur_total_pledge)
                pledgeSignImg:setVisible(true)
            end

            self.cardViews[roomPlayer.displaySeatIdx].imgTips:setVisible(false)

            -- 看牌标识
            local markStr = nil
            if roomPlayer.look_cards then markStr = "已看牌" end
            -- 弃牌标识
            if roomPlayer.waive_type == 1 then markStr = "弃牌" end
            -- 比牌失败标识
            if not roomPlayer.is_win then markStr = "失败" end
            if markStr then
                if roomPlayer.seatIdx ~= self:GetPlayerMeSeat() then
                    self.cardViews[roomPlayer.displaySeatIdx].imgTips:setVisible(true)
                    self.cardViews[roomPlayer.displaySeatIdx].lblTips:setString(markStr)
                end
                if not roomPlayer.look_cards then
                    self:setCardsGray(roomPlayer.displaySeatIdx, true)
                end
            end
        end
    end
end

--接收房卡信息
function PlaySceneZJH:onRcvRoomCard(msgTbl)
	gt.playerData.roomCardsCount = {msgTbl.card, msgTbl.card, msgTbl.card}
end

--进入房间回调
function PlaySceneZJH:onRcvEnterRoom(msgTbl)
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
			end, nil, true)
		return
    elseif msgTbl.code == 2 then
        -- 房间人已满
        require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, gt.LocationStrings.LTKey_0018,
			function()
				gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
			end, nil, true)
		return
	elseif msgTbl.code == 3 then
		-- 房间数据错误
        require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, gt.LocationStrings.LTKey_0070,
			function()
				gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
			end, nil, true)
		return
	end

	self:reInitScene()

    if msgTbl.round == 1 and #msgTbl.player<= 0 and msgTbl.room_state == ROOM_STATE.INIT then
  --   	self.isWait = true
		-- self.playerSeatIdx = -1
		-- self.bankerSeatIdx = -1
		-- self.roomPlayers = {}
		self:showOprateNode(false)
		if self:GetPlayerMe() then
			local resultEffectDelay = 2.0
			self:stopAllActions()
			self:runAction(cc.Sequence:create(cc.DelayTime:create(resultEffectDelay),cc.CallFunc:create(function(sender)
				gt.dispatchEvent(gt.EventType.PLAY_SCENE_RESTART)
			end)))
		end
    end


	self.relogining = false
	-- 桌子配置
	require("json")
	self.tableSetting = json.decode(msgTbl.kwargs)
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
	--庄家座位号
	self.bankerSeatIdx = msgTbl.dealer + 1
    --更新局数
    local roundsData = {}
    roundsData.round = msgTbl.round
    roundsData.rounds = msgTbl.rounds
    self:onRcvRoundState(roundsData)
    --显示房间Title
    --self:showPlayTitle()

	-- 玩家显示固定座位号
	self.playerFixDispSeat = 1
	-- 逻辑座位和显示座位偏移量(从0编号开始)
	local seatOffset = (self.playerFixDispSeat - 1) - (self.roomChairs-1)
	self.seatOffset = seatOffset
    for i, v in ipairs(msgTbl.player) do
        self:onEnterRoomOther(v)
    end

     --当前压分
    self.cur_need_pledge = msgTbl.base_pledge
    --刷新底池数
    -- if msgTbl.base_score and tonumber(msgTbl.base_score) > 0 then
    --     self.goldsPool:setVisible(true)
    --     self:betGoldRecords(nil,msgTbl.base_score)
    -- end
    self.goldsPool:setVisible(true)
    if msgTbl.pledge_records and tonumber(#msgTbl.pledge_records) > 0 then
        self:betGoldRecords(nil,msgTbl.pledge_records)
    end
    --刷新轮数
    -- self.curTurnsLabel:setString(msgTbl.now_rounds + 1)
    self:refreshCurTurns(msgTbl.now_rounds + 1)

    self.active_seat = msgTbl.active_seat + 1
    --刷新操作
    if (self.active_seat) == self:GetPlayerMeSeat() and msgTbl.room_state ~= ROOM_STATE.INIT then
        self:showOprateNode(true)
        self:refreshOperateBtnsScore()
    end

    --刷新倒计时
    self:hideCountdown()
    if self.roomState > ROOM_STATE.READY and self.active_seat >= 1 and self:GetPlayerBySeatIdx(self.active_seat) then
        self:showCountdown(self:GetPlayerBySeatIdx(self.active_seat).displaySeatIdx)
    end

    local seatNum = #msgTbl.player
    --座位已坐满，桌子还在准备状态，此时进来的观察者
    if (seatNum >= self.roomChairs and self.roomState == ROOM_STATE.READY) then
        local roomPlayerBanker = self:GetPlayerBySeatIdx(self.bankerSeatIdx)
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
end

--接收房间添加玩家消息
function PlaySceneZJH:onEnterRoomOther(msgTbl)
	-- 封装消息数据放入到房间玩家表中
    gt.dump(msgTbl, "onEnterRoomOther------------")
	local roomPlayer = {}
	roomPlayer.uid = msgTbl.player
    if (msgTbl.player == gt.playerData.uid) then
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
           
            local pledgeSign = self.pledgeSigns[var.displaySeatIdx]
            pledgeSign:setVisible(false)
            self.cardViews[var.displaySeatIdx].node:setVisible(false)
        end
        self.playerHeadMgr:detachAll()

        self:hidePlayersReadySign()

        --把别人的位置重排下
        for key, var in pairs(self.roomPlayers) do
            --重新绘制新位置状态
            var.displaySeatIdx = (var.seatIdx - 1 + self.seatOffset) % self.roomChairs + 1
            self:roomAddPlayer(var)
        end  
        self.myPledgeTotal = msgTbl.pledge_max
	end
    if (msgTbl.dealer ~= nil and msgTbl.dealer >= 0) then
	    -- 庄家座位号
	    self.bankerSeatIdx = msgTbl.dealer + 1
    end

    local infoTbl = json.decode(msgTbl.info)
	roomPlayer.nickname = infoTbl.nick
	roomPlayer.headURL = infoTbl.icon
	roomPlayer.sex = infoTbl.sex
    roomPlayer.game_count = infoTbl.game_count
    roomPlayer.reg_time = infoTbl.reg_time
    roomPlayer.uid = msgTbl.player
	roomPlayer.ip = msgTbl.ip
    roomPlayer.isWait = msgTbl.is_wait
    -- 服务器位置从0开始,客户端位置从1开始
	roomPlayer.seatIdx = msgTbl.seat + 1
	-- 显示座位编号
	roomPlayer.displaySeatIdx = (msgTbl.seat + self.seatOffset) % self.roomChairs + 1
	roomPlayer.state = msgTbl.state
	roomPlayer.score = msgTbl.score
	roomPlayer.pledge = msgTbl.pledge   --压分分数
	roomPlayer.niu_type = msgTbl.niu_type
	roomPlayer.cards_in_hand = msgTbl.cards_in_hand or {}
    --手牌排序
    self:sortCards(roomPlayer.cards_in_hand)

    roomPlayer.cur_total_pledge = msgTbl.pledge_max --当前压分数
    roomPlayer.look_cards = msgTbl.look_cards
    roomPlayer.waive_type = msgTbl.waive_type  --0在游戏中 1弃牌
    roomPlayer.is_show_card = msgTbl.is_show_card
    roomPlayer.is_win = msgTbl.is_win

	-- 房间添加玩家
	self:roomAddPlayer(roomPlayer)
end

-- 退出房间
function PlaySceneZJH:onRcvExitRoom(msgTbl)
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
		    local roomPlayer =self:GetPlayerBySeatIdx(seatIdx) 
		    if not roomPlayer then return end 
		    -- 隐藏玩家信息
		    local playerInfoNode = self.playerNodes[roomPlayer.displaySeatIdx]
		    self.playerNodes[roomPlayer.displaySeatIdx]:setVisible(false)

		    -- 隐藏玩家手势
            self:hidePlayersReadySign(roomPlayer.displaySeatIdx)
		    self.pledgeSigns[roomPlayer.displaySeatIdx]:setVisible(false)

		    -- 取消头像下载监听
		    local headSpr = gt.seekNodeByName(playerInfoNode, "Spr_Head")
		    self.playerHeadMgr:detach(headSpr)
		    self.playerHeadMgr:resetHeadSpr(headSpr)
		    
		    -- 去除数据
		    self.roomPlayers[seatIdx] = nil
        end
	end
end

--玩家准备回调
function PlaySceneZJH:onRcvReady(msgTbl)
	local seatIdx = msgTbl.seat + 1
	self:playerGetReady(seatIdx)

    local seatNum = gt.getTableSize(self.roomPlayers)
    if (self.isWait and seatNum >= self.roomChairs) then
        self.readyBtn:setVisible(false)
    end
	if self:GetPlayerBySeatIdx(seatIdx).uid == gt.playerData.uid then
		if self.isMatch and self.IsNewGame then
			self.IsNewGame=false
			self.Btn_ViewFinalReport:setVisible(false)
			self.readyBtn:setPositionX(0)
			--self.readyBtn:getChildByName("lblReady"):setString("准  备")
            self.readyBtn:loadTextureNormal("image/play/btn_ready.png")
		end
	end
end

--玩家预准备等待回调 此时是占了座位观战者
function PlaySceneZJH:onRcvReadyWait(msgTbl)
    local seatIdx = msgTbl.seat + 1
    local roomPlayer =self:GetPlayerBySeatIdx(seatIdx)
    roomPlayer.state = PLAYER_STATE.READY_WAIT
    
    gt.seekNodeByName(self.playerNodes[roomPlayer.displaySeatIdx], "Label_Wait"):setVisible(false)
    self.readySigns[roomPlayer.displaySeatIdx]:setVisible(true)
	
    -- 玩家本身
	if seatIdx == self:GetPlayerMeSeat() then
        self.m_menu:showChatBtns()
        --修改坐下按钮为准备按钮
        self.readyBtn:setVisible(false)
        --gt.seekNodeByName(self.readyBtn, "lblReady"):setString("准  备")
        self.readyBtn:loadTextureNormal("image/play/btn_ready.png")
    end

    local seatNum = gt.getTableSize(self.roomPlayers)
    if (self.isWait and seatNum >= self.roomChairs) then
        self.readyBtn:setVisible(false)
    end
end

-- 准备晚了，座位被占了回调
function PlaySceneZJH:onRcvReadyLate()
    require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, gt.LocationStrings.LTKey_0064, nil, nil, true)
end

-- 提示开始
function PlaySceneZJH:onRcvPromptStart(msgTbl)
	self.roomState = ROOM_STATE.READY

	if msgTbl.flag == 0 then
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
function PlaySceneZJH:onRcvStart(msgTbl)
    if msgTbl.code == 0 then
		self.IsNewGame=false
		self.Btn_ViewFinalReport:setVisible(false)
		self.readyBtn:setPositionX(0)
		--self.readyBtn:getChildByName("lblReady"):setString("准  备")
        self.readyBtn:loadTextureNormal("image/play/btn_ready.png")

        self:hideSigns()
        self:resetCardSigns()
        self:resetGoldsPool()
        self.roomState = ROOM_STATE.START
        self.startBtn:setVisible(false)
        self.goldsPool:setVisible(true)

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

-- 发牌
function PlaySceneZJH:onRcvDealCard(msgTbl)
    self.bgWaitingTip:setVisible(false)
	self:hidePlayersReadySign()
    self:resetCardsPos()
    self:hideAllCardType()

    self.roomState = ROOM_STATE.DEAL
    gt.dump(msgTbl, "fapai onRcvDealCard-----")

    -- self.goldsPool:setLocalZOrder(0)

    local function dealCards()
        --把预先准备的玩家修改成非旁观者
        for _,roomPlayer in pairs(self.roomPlayers) do 
            if roomPlayer.state == PLAYER_STATE.ACTIVITY then --压过底分，则给发牌
                roomPlayer.isWait = false
                if roomPlayer.seatIdx == self:GetPlayerMeSeat() then
                    self.isWait = false
                    --隐藏观战标
                    self.imgGuanZhan:setVisible(false)
                end
            end
        end

	    local roomPlayers = {}
	    for i = 1, self.roomChairs do
	    	local roomP = self:GetPlayerBySeatIdx(i)
		    if roomP and not roomP.isWait then
                roomP.state = PLAYER_STATE.DEAL
			    if i == self:GetPlayerMeSeat() then
				    roomP.cards_in_hand = msgTbl.self_cards
                    self.handCardState = HAND_CARD_STATE.DARK --暗牌
			    else
				    roomP.cards_in_hand = msgTbl.other_cards
			    end
			    table.insert(roomPlayers, roomP)
		    end
	    end

	    -- 发牌动画
	    local playNode = gt.seekNodeByName(self.rootNode, "Node_play")
	    for j = 1, CARD_NUM do
		    for k, v in ipairs(roomPlayers) do
			    local cardView = self.cardViews[v.displaySeatIdx]
			    cardView.node:setVisible(true)
                cardView.imgTips:setVisible(false)
			    for m = 1, 3 do
				    cardView.imgCards[m]:setVisible(false)
                    if self.tableSetting.game_type == gt.GameType.GAME_BANKER then
                        if not self.isWait and m <= CARD_NUM and v.seatIdx == self:GetPlayerMeSeat() then
                	        local playerMe = self:GetPlayerMe()
                            if playerMe~= nil then
                                local card = playerMe.cards_in_hand[m]
                                if math.fmod(card,16) == 14 then card = card - 13 end
                                cardView.imgCards[m]:loadTexture(string.format("image/card/%02x.png", card), ccui.TextureResType.plistType)
                            end
                        else
                            cardView.imgCards[m]:loadTexture("image/card/back.png", ccui.TextureResType.plistType)
                        end
                    else
                        cardView.imgCards[m]:loadTexture("image/card/back.png", ccui.TextureResType.plistType)
                    end
			    end
			    local scale = 0.5
			    if v.displaySeatIdx == 1 then
                    scale = 1 
                end

			    local pos = cc.pAdd(cc.p(cardView.node:getPosition()), cc.p(cardView.imgCards[j]:getPosition()))
			    local sp = cc.Sprite:createWithSpriteFrameName("image/card/back.png")
			    sp:setPosition(0, 0)
			    sp:setScale(scale*0.8)
			    playNode:addChild(sp)
                local moveTime = 0.2
			    local delayTime = (j-1)*(moveTime/2)
                local callFun = function ()
                    if (v.seatIdx == self:GetPlayerMeSeat()) then
                        gt.soundEngine:playEffect("common/fa_pai", false)
                    end
                end
			    local moveTo = cc.Spawn:create(cc.CallFunc:create(callFun), cc.MoveTo:create(moveTime, pos), cc.ScaleTo:create(moveTime, scale), cc.FadeOut:create(moveTime))
			    sp:runAction(cc.Sequence:create(cc.Hide:create(), cc.DelayTime:create(delayTime), cc.Show:create(), moveTo, cc.RemoveSelf:create()))
			    cardView.imgCards[j]:runAction(cc.Sequence:create(cc.DelayTime:create(delayTime+moveTime), cc.Show:create()))
		    end
	    end

        if (not self.isWait) then --显示看牌按钮
	        self.openCardBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
	        	if not self:isWatchByOrder() then
	                self.openCardBtn:setVisible(true)
	            end
                -- self.goldsPool:setLocalZOrder(3)
            end)))
        end
    end

    self:runAction(cc.Sequence:create(cc.DelayTime:create(1.0),cc.CallFunc:create(dealCards)))
end

function PlaySceneZJH:onRcvPromptOperate(msgTbl)
    self.curTurns = msgTbl.now_rounds or 1
    -- self.curTurnsLabel:setString(self.curTurns + 1)
    self:refreshCurTurns(self.curTurns + 1)
     
    local seatIdx = msgTbl.seat + 1
    --记录当前操作玩家
    self.curOperateSeatIdx = seatIdx

    local delay = 0.1
    if self.roomState == ROOM_STATE.DEAL then --发牌状态
        delay = 1.5
    end
    local function startOperate()
        if seatIdx == self:GetPlayerMeSeat() then  --玩家自己
            --显示操作按钮
            self:showOprateNode(true)
            --刷新操作按钮
            self:refreshOperateBtnsScore()
        end
        --倒计时
        local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)
        if not roomPlayer then return end 
        self:showCountdown(roomPlayer.displaySeatIdx)
        --轮牌阶段
        self.roomState = ROOM_STATE.STEP
    end
    self:runAction(cc.Sequence:create(cc.DelayTime:create(delay),cc.CallFunc:create(startOperate)))
end

function PlaySceneZJH:getMyLastScore()
	if self:GetPlayerMe() then
		return self:GetPlayerMe().score - (self.myPledgeTotal or 0)
	end
end

-- 玩家押分回调
function PlaySceneZJH:onRcvPledge(msgTbl)
	local seatIdx = msgTbl.seat + 1
	local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)
	roomPlayer.pledge = msgTbl.pledge
    roomPlayer.cur_total_pledge = msgTbl.cur_pledge_total
    roomPlayer.state = PLAYER_STATE.ACTIVITY

    self.cur_need_pledge = msgTbl.cur_need_pledge

    if seatIdx == self:GetPlayerMeSeat() then
	    self.myPledgeTotal =  msgTbl.cur_pledge_total
	end

    if seatIdx == self:GetPlayerMeSeat() and self:getMyLastScore() < NEED_NOTICE_SCORE 
    			and msgTbl.pledge_type ~= -1  --底注除外
    			and self.isMatch > 0
    			then 
    	local function onConfirm()
      		self.noticeTips = nil
		end
    	self.noticeTips = require("app/views/NoticeTips"):create("提示", "当前积分不足会影响游戏体验，请及时加分。", onConfirm, nil, true)
    end

	-- 显示玩家压分分数
	local pledgeSignImg = self.pledgeSigns[roomPlayer.displaySeatIdx]
    local bflScore = pledgeSignImg:getChildByName("Text_Bet_Score")
	bflScore:setString(msgTbl.cur_pledge_total)
	pledgeSignImg:setVisible(true)
	
    --押金币
    -- self:betGolds(roomPlayer.displaySeatIdx,msgTbl.pledge)
    self:betGoldRecords(roomPlayer.displaySeatIdx,msgTbl.pledge_record)
    if msgTbl.pledge_type == 0 then
        self:playMusicEffect(seatIdx,"call")
    elseif msgTbl.pledge_type > 0 then -- -1底注 0跟注 1,2,3加注
        self:playMusicEffect(seatIdx,"raise")
    end

    --隐藏操作界面
    self:showOprateNode(false)
    --隐藏倒计时
    self:hideCountdown(roomPlayer.displaySeatIdx)
end

--显示倒计时
function PlaySceneZJH:showCountdown(displaySeat, time_)
    local playerNode = self.playerNodes[displaySeat]
    local progress = playerNode:getChildByTag(8888)
    if not progress then
        local head_bg = playerNode:getChildByName("head_bg")

        progress = cc.ProgressTimer:create(cc.Sprite:create("image/play_zjh/countdown.png"))
        progress:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
        progress:setReverseDirection(false)
        progress:setColor(cc.c3b(0,255,84))
        progress:setOpacity(150)
        progress:setPosition(cc.p(head_bg:getPosition()))
        progress:setTag(8888)
        playerNode:addChild(progress)
    end
    progress:stopAllActions()
    progress:setPercentage(0)
    progress:setVisible(true)

    local total_seconds = self.tableSetting.zjh_qipai
    local seconds = 0.0
    if time_ then
    	seconds = total_seconds - time_
    end
    local isTimeUpEnable = true
    progress:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.05),cc.CallFunc:create(function ()
        seconds = seconds + 0.05
        if total_seconds - seconds < 0 then 
            progress:stopAllActions()

            if self:GetPlayerMe() and displaySeat == self:GetPlayerMe().displaySeatIdx then
            	-- self:sendWaiveMsg()
            	if self.noticeTips then
            		self.noticeTips:removeFromParent()
            		self.noticeTips = nil
            	end
            end
            return
        end
        progress:setPercentage((( seconds)/total_seconds)*100)

        -- 剩余3s开始播放警报声音+震动一下手机
        if math.ceil(total_seconds - seconds) == 3 and isTimeUpEnable then 
            isTimeUpEnable = false

		    -- 播放声音
		    gt.soundEngine:playEffect("common/timeup_alarm",false)
		    -- 震动提醒
            if cc.UserDefault:getInstance():getStringForKey("Shock") == "true" then
		        cc.Device:vibrate(1)
            end
        end
    end))))
end

--隐藏倒计时
function PlaySceneZJH:hideCountdown(displaySeat)
    if displaySeat then 
        local playerNode = self.playerNodes[displaySeat]
        local progress = playerNode:getChildByTag(8888)
        if progress then 
            progress:setVisible(false)
            progress:stopAllActions()
        end
    else
        for _,playerNode in ipairs(self.playerNodes) do
            local progress = playerNode:getChildByTag(8888)
            if progress then 
                progress:setVisible(false)
                progress:stopAllActions()
            end
        end
    end
end

--比牌结果
function PlaySceneZJH:onRcvCmpCard(msgTbl)
    local seatIdx = msgTbl.seat + 1
    local cmp_seat = msgTbl.cmp_seat + 1
    local win_seat = msgTbl.win_seat + 1

    local fail_seat = win_seat == seatIdx and cmp_seat or seatIdx
    self:GetPlayerBySeatIdx(fail_seat).is_win = false --T= 在游 F = 比牌失败

    --隐藏倒计时
    self:hideCountdown( self:GetPlayerBySeatIdx(seatIdx).displaySeatIdx)
    
    local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)
	roomPlayer.pledge = msgTbl.pledge
    roomPlayer.cur_total_pledge = msgTbl.cur_pledge_total
    self.cur_need_pledge = msgTbl.cur_need_pledge
    
	-- 显示玩家压分分数
	local pledgeSignImg = self.pledgeSigns[roomPlayer.displaySeatIdx]
    local bflScore = pledgeSignImg:getChildByName("Text_Bet_Score")
	bflScore:setString(msgTbl.cur_pledge_total)
	pledgeSignImg:setVisible(true)
	
    --押金币
    -- self:betGolds(roomPlayer.displaySeatIdx,msgTbl.pledge)
    self:betGoldRecords(roomPlayer.displaySeatIdx,msgTbl.pledge_record)

    self:playMusicEffect(seatIdx,"cmp")

    local function showTips() --比牌赢了的人如果分数过低进行提示
    	if win_seat == self:GetPlayerMeSeat() and seatIdx == self:GetPlayerMeSeat() 
    		and self:GetPlayerMe().score - msgTbl.cur_pledge_total < NEED_NOTICE_SCORE 
    		and self.isMatch > 0
        then
            local function onConfirm()
                self.noticeTips = nil
            end
            self.noticeTips = require("app/views/NoticeTips"):create("提示", "当前积分不足会影响游戏体验，请及时加分。", onConfirm, nil, true)
        end
    end

    local function changeToFailedState()
        self:cmpHandCardsFailed(self:GetPlayerBySeatIdx(fail_seat).displaySeatIdx)
    end
    
    self:runAction(cc.Sequence:create(cc.CallFunc:create(function ()
            self:playCmpEffAnimation(self:GetPlayerBySeatIdx(seatIdx),self:GetPlayerBySeatIdx(cmp_seat),win_seat)
        end),cc.DelayTime:create(1.5),cc.CallFunc:create(changeToFailedState),cc.DelayTime:create(0.5),cc.CallFunc:create(showTips)))
end

--发起玩家sCmpPlayer
function PlaySceneZJH:playCmpEffAnimation(sCmpPlayer,rCmpPlayer,winSeat)
    local cmpEffPanel = gt.seekNodeByName(self.rootNode, "Panel_Cmp_Eff")
    cmpEffPanel:setVisible(true)

    local players = {{node = gt.seekNodeByName(cmpEffPanel, "Node_Player_Left"),info = sCmpPlayer},
                     {node = gt.seekNodeByName(cmpEffPanel, "Node_Player_Right"),info = rCmpPlayer}}
    for _,playerInfo in ipairs(players) do 
        local sprHead = gt.seekNodeByName(playerInfo.node, "Spr_Head")
        if cc.FileUtils:getInstance():isFileExist("image/play/default_avatar.png") then
        	sprHead:setTexture("image/play/default_avatar.png")
        end
        local head_image_file = string.format("%shead_%d.png", cc.FileUtils:getInstance():getWritablePath(),playerInfo.info.uid)
        if cc.FileUtils:getInstance():isFileExist(head_image_file) then
            local texture = cc.TextureCache:getInstance():addImage(head_image_file)
            if texture then
                sprHead:setTexture(texture)
            end
        end

        --名字
        gt.seekNodeByName(playerInfo.node, "Label_Nick"):setString(gt.checkName(playerInfo.info.nickname,4))
    end

    local winNode = cmpEffPanel:getChildByName("Text_Win")
    if winNode == nil then
    	winNode = cmpEffPanel:getChildByName("imgWin")
    end
    winNode:setVisible(false)
    winNode:setLocalZOrder(1)

    local winLabel = cmpEffPanel:getChildByTag(12320)
    if not winLabel then 
        winLabel = winNode:clone()
        winLabel:setScale(0.4)
        winLabel:setVisible(false)
        winLabel:setTag(12320)
        cmpEffPanel:addChild(winLabel)
    end

    local isLeftWin = true
    if winSeat == rCmpPlayer.seatIdx then
        isLeftWin = false
    end

    local skeletonNode = cmpEffPanel:getChildByTag(12321)
    if not skeletonNode then
        skeletonNode = sp.SkeletonAnimation:create("image/play_zjh/yszpkpengzhuang.json", "image/play_zjh/yszpkpengzhuang.atlas")
	    skeletonNode:setAnimation(0, "animation", false)
        skeletonNode:setPosition(cc.p(cmpEffPanel:getChildByName("Node_VS_Pos"):getPosition()))
        skeletonNode:setTag(12321)
        skeletonNode:setVisible(false)
	    cmpEffPanel:addChild(skeletonNode)
    end

    local function setCardsGray(isGray)
        local playerNode = gt.seekNodeByName(cmpEffPanel, "Node_Player_Left")
        if isLeftWin then
            playerNode = gt.seekNodeByName(cmpEffPanel, "Node_Player_Right")
        end
        for i=1,3 do 
             --gt.seekNodeByName(playerNode, "imgCrad" .. i):setColor(isGray and cc.c3b(80,80,80) or cc.c3b(255,255,255)) 
             if isGray then
                GrayShader:addGrayNode(gt.seekNodeByName(playerNode, "imgCrad" .. i))
            else 
                GrayShader:removeGrayNode(gt.seekNodeByName(playerNode, "imgCrad" .. i))
            end
        end
   end

    local function runSpineAnimation()
        skeletonNode:setVisible(true)
        skeletonNode:setAnimation(0, "animation", false)
    end

    local function runWinAnimation()
        setCardsGray(true)

        local animationName = "animation_win_left"
        if not isLeftWin then
            animationName = "animation_win_right"
        end
        winNode:setVisible(true)
        self.actionTimeLine:play(animationName,false)
    end

    local function runFailAnimation()
        winNode:setVisible(false)
        winLabel:setVisible(true)
        winLabel:setPosition(cc.p(isLeftWin and 200 or 1084,398))

        local animationName = "animation_fail_left"
        if isLeftWin then
            animationName = "animation_fail_right"
        end
        self.actionTimeLine:play(animationName,false)
    end

    local function runPKAnimation()

        gt.seekNodeByName(self.rootNode,"FileNode_Animate"):setVisible(true)

		local actionTimeLine_ = cc.CSLoader:createTimeline("csd/texiao/zjhBattle.csb")
	    self.rootNode:runAction(actionTimeLine_)
	    actionTimeLine_:play("animation_zjhBattle",false)
    end

    local function restoreCmpPanel()
        winNode:setVisible(false)
        winLabel:setVisible(false)
        setCardsGray(false)
        skeletonNode:setVisible(false)

        gt.seekNodeByName(self.rootNode,"FileNode_Animate"):setVisible(false)

        --恢复到0帧
        self.actionTimeLine:gotoFrameAndPause(0)
    end

    cmpEffPanel:runAction(cc.Sequence:create(
    										cc.DelayTime:create(0.2),
    										cc.CallFunc:create(runPKAnimation),
    										cc.DelayTime:create(0.4),
    										cc.CallFunc:create(runSpineAnimation),
                                            cc.DelayTime:create(1.0),
                                            cc.CallFunc:create(runWinAnimation),
                                            cc.DelayTime:create(1.2),
                                            cc.CallFunc:create(runFailAnimation),
                                            cc.DelayTime:create(1.2),
                                            cc.Hide:create(),
                                            cc.CallFunc:create(restoreCmpPanel)))
end

--弃牌结果
function PlaySceneZJH:onRcvFoldCard(msgTbl)
    local seatIdx = msgTbl.seat + 1
    local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)
    roomPlayer.waive_type = 1 --弃牌标志： 0在游  1弃牌
    roomPlayer.state = PLAYER_STATE.FOLD

    if seatIdx == self:GetPlayerMeSeat() then
        self.handCardState = HAND_CARD_STATE.FOLD
		if self:isWatchByOrder() then --按序看牌弃牌后方可看牌
            self.openCardBtn:setVisible(true)
        end

        if self.isCmpingCard then
            self:restoreCmpCardsNode()
            self.isCmpingCard = false
        end
    end
    self:hideCountdown(self:GetPlayerBySeatIdx(seatIdx).displaySeatIdx)
    self:foldHandCards(roomPlayer.displaySeatIdx)
    self:playMusicEffect(seatIdx,"fold")

    self:showOprateNode(false)
end

--点击亮牌回调
function PlaySceneZJH:onRcvShowCard(msgTbl)
    gt.dump(msgTbl,"亮牌")

	local seatIdx = msgTbl.seat + 1
	local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)
	if roomPlayer then
	    roomPlayer.is_show_card = true --亮牌了
	    
	    --如果是自己则隐藏亮牌按钮
	    if seatIdx == self:GetPlayerMeSeat() then
	        self.showCardBtn:setVisible(false)
	        self.handCardState = HAND_CARD_STATE.SHOW
	    end

	    if type(msgTbl.cards) == 'table' and #msgTbl.cards > 0 then 
	        roomPlayer.cards_in_hand = msgTbl.cards 
	        self:sortCards(roomPlayer.cards_in_hand)

	         --亮牌
	        self:flopPoker(roomPlayer.displaySeatIdx,msgTbl.cards ,true)
	        --显示牌类型
	        self:showCardType(seatIdx,msgTbl.niu_type)
	        --根据牌类型调用声音
	        self:playCardTypeEff(seatIdx,msgTbl.niu_type)
	    end
	end

end

--玩家看牌
function PlaySceneZJH:onRcvViewCard(msgTbl)
	local seatIdx = msgTbl.seat + 1
    local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)
    roomPlayer.look_cards = true

    local displaySeatIdx = roomPlayer.displaySeatIdx

    if seatIdx == self:GetPlayerMeSeat() then  --玩家自己，翻牌
        self.isViewedCard = true
        roomPlayer.cards_in_hand = msgTbl.cards_in_hand
        self:sortCards(roomPlayer.cards_in_hand)
        self:flopPoker(displaySeatIdx,roomPlayer.cards_in_hand,true)
        if self.curOperateSeatIdx == seatIdx then 
            --刷新操作显示
            self:refreshOperateBtnsScore()
        end
        self.handCardState = HAND_CARD_STATE.VIEWED --看牌
        if self.showCardEnabled then --可以显示亮牌
            self.showCardBtn:setVisible(true)
        end
        --显示牌类型
        self:showCardType(seatIdx,msgTbl.niu_type)
        --根据牌类型调用声音
        self:playCardTypeEff(seatIdx,msgTbl.niu_type)

    else --别的玩家显示已看牌
        self.cardViews[displaySeatIdx].imgTips:setVisible(true)
        self.cardViews[displaySeatIdx].lblTips:setString("已看牌")
    end
    if self.curOperateSeatIdx == seatIdx and self:GetPlayerBySeatIdx(seatIdx).state == PLAYER_STATE.ACTIVITY then 
        --重新倒计时
        self:showCountdown(displaySeatIdx)
    end

    self:playMusicEffect(seatIdx,"view")
end

function PlaySceneZJH:flopPoker(displaySeatIdx, cards, beAnimal)
    local cardView = self.cardViews[displaySeatIdx]

    local orbitTime = 0.1
    for i, v in ipairs(cards) do
        if v > 0 then
            -- 显示牌面
            if (bOrbitAni) then
                cardView.imgCards[i]:loadTexture("image/card/back.png", ccui.TextureResType.plistType)
                local orbit1 = cc.OrbitCamera:create(orbitTime, 1, 0, 0, 90, 0, 0)
                local change = cc.CallFunc:create( function(sender)
                    local value = sender:getTag()
                    if math.fmod(value,16) == 14 then value = value - 13 end
                    sender:loadTexture(string.format("image/card/%02x.png", value), ccui.TextureResType.plistType)
                end )
                local orbit2 = cc.OrbitCamera:create(orbitTime, 1, 0, 270, 90, 0, 0)
                cardView.imgCards[i]:runAction(cc.Sequence:create(orbit1, change, orbit2))
            else
                if math.fmod(v,16) == 14 then v = v - 13 end
                cardView.imgCards[i]:loadTexture(string.format("image/card/%02x.png", v), ccui.TextureResType.plistType)
            end
        else
            -- 显示背面
            cardView.imgCards[i]:loadTexture("image/card/back.png", ccui.TextureResType.plistType)
        end
        cardView.imgCards[i]:setVisible(true)
    end
    cardView.imgTips:setVisible(false)
end

--弃手牌
function PlaySceneZJH:foldHandCards(displaySeatIdx)
    self:setCardsGray(displaySeatIdx,true)
    self.cardViews[displaySeatIdx].imgTips:setVisible(true)
    self.cardViews[displaySeatIdx].lblTips:setString("弃牌")
end

--比牌失败
function PlaySceneZJH:cmpHandCardsFailed(displaySeatIdx)
    self:setCardsGray(displaySeatIdx,true)
    self.cardViews[displaySeatIdx].imgTips:setVisible(true)
    self.cardViews[displaySeatIdx].lblTips:setString("失败")
    if self:GetPlayerMe() and self:GetPlayerMe().displaySeatIdx == displaySeatIdx then
    	self.openCardBtn:setVisible(false)
    end
end

function PlaySceneZJH:getGoldType(type_)
	local goldStr = "image/play_zjh/ui/iconGoldDi.png"
	if type_ == 1 then
		goldStr = "image/play_zjh/ui/iconGold1.png"
	elseif type_ == 2 then
		goldStr = "image/play_zjh/ui/iconGold2.png"
	elseif type_ == 3 then
		goldStr = "image/play_zjh/ui/iconGold3.png"
	end
	return goldStr
end

function PlaySceneZJH:getGoldTypeColor(type_)
	local color = cc.c3b(32,142,39)
	if type_ == 1 then
		color = cc.c3b(172,120,29)
	elseif type_ == 2 then
		color = cc.c3b(131,78,226)
	elseif type_ == 3 then
		color = cc.c3b(217,60,48)
	end
	return color
end

-- 押注记录
function PlaySceneZJH:betGoldRecords(fromDisplaySeat,goldRecords)
	local playerPos = fromDisplaySeat and cc.p(self.playerNodes[fromDisplaySeat]:getPosition())
    local fromPos = fromDisplaySeat and self.goldsPool:convertToNodeSpace(self.playerNodes[fromDisplaySeat]:getParent():convertToWorldSpace(playerPos))

    for i=1,#goldRecords do
    	local record = goldRecords[i]
    	if record then
    		local score_ = record.score
    		local pledge_type_ = record.pledge_type

	        local toPos = cc.p( math.random(self.goldsPool:getContentSize().width*0.25,self.goldsPool:getContentSize().width*0.75), 
	                            math.random(self.goldsPool:getContentSize().height*0.15,self.goldsPool:getContentSize().height*0.8))
	       
	       local goldCoinSpr = cc.Sprite:create(self:getGoldType(pledge_type_))
	       if goldCoinSpr then
		       	local m_label = cc.LabelBMFont:create(score_, "font/YSZ_Bet.fnt")
	      	 	m_label:setScale(0.8)
		       	m_label:setAnchorPoint(0.5,0.5)
		       	m_label:setPosition(39,43.2)
		       	m_label:setColor(self:getGoldTypeColor(pledge_type_))
		       	goldCoinSpr:addChild(m_label)

         	 	goldCoinSpr:setTag(999)
		       	goldCoinSpr:setPosition(fromDisplaySeat and fromPos or toPos)
		       	goldCoinSpr:setScale(fromDisplaySeat and 0.8 or 0.7)
		       	self.goldsPool:addChild(goldCoinSpr)


		       	if fromDisplaySeat then 
		            goldCoinSpr:runAction(cc.Sequence:create(cc.DelayTime:create(0.1),cc.Spawn:create(cc.ScaleTo:create(0.5,0.7),cc.MoveTo:create(0.5,toPos))))
		       	end
		   end
	       
		   --刷新底池数
		   self.goldsPoolLabel:setString(tonumber(self.goldsPoolLabel:getString()) + score_)
    	end
    end
    --播放声音
    self.goldsPoolLabel:runAction(cc.CallFunc:create(function () gt.soundEngine:playEffect("common/fly_gold", false) end))
end

-- 押注金币
function PlaySceneZJH:betGolds(fromDisplaySeat,goldsNum)
    local playerPos = fromDisplaySeat and cc.p(self.playerNodes[fromDisplaySeat]:getPosition())
    local fromPos = fromDisplaySeat and self.goldsPool:convertToNodeSpace(self.playerNodes[fromDisplaySeat]:getParent():convertToWorldSpace(playerPos))

    for i=1,goldsNum do
        local toPos = cc.p( math.random(self.goldsPool:getContentSize().width*0.25,self.goldsPool:getContentSize().width*0.75), 
                            math.random(self.goldsPool:getContentSize().height*0.15,self.goldsPool:getContentSize().height*0.8))
       
       local goldCoinSpr = cc.Sprite:create("image/play/gold_coin.png")
       goldCoinSpr:setTag(999)
       goldCoinSpr:setPosition(fromDisplaySeat and fromPos or toPos)
       goldCoinSpr:setScale(fromDisplaySeat and 1.5 or 1.0)
       self.goldsPool:addChild(goldCoinSpr)

       if fromDisplaySeat then 
            goldCoinSpr:runAction(cc.Sequence:create(cc.DelayTime:create(0.1),cc.Spawn:create(cc.ScaleTo:create(0.5,1.0),cc.MoveTo:create(0.5,toPos))))
       end
    end
    --播放声音
    self.goldsPoolLabel:runAction(cc.CallFunc:create(function () gt.soundEngine:playEffect("common/fly_gold", false) end))
    --刷新底池数
    self.goldsPoolLabel:setString(tonumber(self.goldsPoolLabel:getString()) + goldsNum)
end

-- 赢金币
function PlaySceneZJH:winGolds(toDisplaySeat)
    local playerPos = cc.p(self.playerNodes[toDisplaySeat]:getPosition())
    local toPos = self.goldsPool:convertToNodeSpace(self.playerNodes[toDisplaySeat]:getParent():convertToWorldSpace(playerPos))
    local children = self.goldsPool:getChildren()
    local delay = 0.1/math.ceil(#children/10)

    local idx = 0
    for _,child in pairs(children) do
        if child:getTag() == 999 then
            idx = idx + 1
            child:runAction(cc.Sequence:create(cc.DelayTime:create(idx*delay),cc.Spawn:create(cc.MoveTo:create(0.5,toPos),cc.ScaleTo:create(0.5,0.8)),cc.RemoveSelf:create()))
        end
    end

    --播放声音
    self.goldsPoolLabel:runAction(cc.CallFunc:create(function () gt.soundEngine:playEffect("common/fly_gold", false) end))
    --刷新底池数
   self.goldsPoolLabel:setString(0)
end

function PlaySceneZJH:resetGoldsPool()
    local children = self.goldsPool:getChildren()
    for _,child in pairs(children) do
        if child:getTag() == 999 then
            child:removeFromParent()
        end
    end
    --刷新底池数
   self.goldsPoolLabel:setString(0)
end

-- 收喜钱
function PlaySceneZJH:collectHappyMoney(toDisplaySeat, cardType)
    local bottom_score = self.tableSetting.zjh_base_score
    local addGolds = bottom_score
    if cardType == 60 then  --豹子
        addGolds = bottom_score*10
    elseif cardType == 51 or cardType == 50 then --顺金（50是123同花顺）
        addGolds = bottom_score*5
    end
    for _,roomPlayer in pairs(self.roomPlayers) do
        if roomPlayer.displaySeatIdx ~= toDisplaySeat then 
            self:flyGoldCoinToPlayer(roomPlayer.displaySeatIdx, toDisplaySeat, addGolds)
        end
    end
end

-- 飞金币到玩家
function PlaySceneZJH:flyGoldCoinToPlayer(fromDisplaySeat,toDisplaySeat, goldsNum)
    local fromPlayerPos = cc.p(self.playerNodes[fromDisplaySeat]:getPosition())
    local fromPos = self.goldsPool:convertToNodeSpace(self.playerNodes[fromDisplaySeat]:getParent():convertToWorldSpace(fromPlayerPos))
    local toPlayerPos = cc.p(self.playerNodes[toDisplaySeat]:getPosition())
    local toPos = self.goldsPool:convertToNodeSpace(self.playerNodes[toDisplaySeat]:getParent():convertToWorldSpace(toPlayerPos))
  
    local delay = 0.1/math.ceil(goldsNum/10.0)

    for i=1,goldsNum do
       local goldCoinSpr = cc.Sprite:create("image/play/gold_coin.png")
       goldCoinSpr:setTag(999)
       goldCoinSpr:setPosition(fromPos)
       goldCoinSpr:setScale(1.5)
       self.goldsPool:addChild(goldCoinSpr)

       goldCoinSpr:runAction(cc.Sequence:create(cc.DelayTime:create(delay*i),cc.Spawn:create(cc.ScaleTo:create(0.5,1.0),cc.MoveTo:create(0.5,toPos)),cc.RemoveSelf:create()))
   end
   --播放声音
   self.goldsPoolLabel:runAction(cc.CallFunc:create(function () gt.soundEngine:playEffect("common/fly_gold", false) end))
end

--玩家在线标识
function PlaySceneZJH:onRcvOffLineState(msgTbl)
	local seatIdx = msgTbl.seat + 1
	local playerInfoNode = self.playerNodes[self:GetPlayerBySeatIdx(seatIdx).displaySeatIdx]

	-- 离线标示
	local offLineSignSpr = gt.seekNodeByName(playerInfoNode, "Label_offline")
	offLineSignSpr:setZOrder(20000)
	offLineSignSpr:setVisible(msgTbl.flag == 0)
end

--当前局数/最大局数量
function PlaySceneZJH:onRcvRoundState(msgTbl)
	-- 牌局状态,剩余牌
    gt.dump(msgTbl, "onRcvRoundState")
	local remainTilesLabel = gt.seekNodeByName(self.roundStateNode, "Label_Round")
	local stateNum = string.format("%d/%d", (msgTbl.round), msgTbl.rounds)
	remainTilesLabel:setString("第" .. stateNum .. "局")
    self.curRound = msgTbl.round

    self.roundStateNode:setVisible(true)
end

function PlaySceneZJH:showGunAnimation()
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

function PlaySceneZJH:onRcvRoundReport(msgTbl)
	gt.log("游戏结束")
    gt.dump(msgTbl, "onRcvRoundReport")
    self.roomState = ROOM_STATE.SETTLE_ROUND
    self.isLastRound = false
    
    self.bgWaitingTip:setVisible(false)

    for _,playerData in ipairs(msgTbl.player_data) do
		local seatIdx = playerData.seat + 1
	    local roomPlayer = self.roomPlayers[seatIdx]
		if roomPlayer then
			roomPlayer.score = playerData.total_score
			roomPlayer.state = PLAYER_STATE.SETTLE_ROOM
		end
    end
   
    --隐藏邀请按钮
    if (not self.isWait or ( self:GetPlayerMe() and self:GetPlayerMe().state == PLAYER_STATE.READY_WAIT)) then
        self.inviteFriendBtn:setVisible(false)
    end

    -- 连续亮牌
    if not self.isWait then
        self.showCardEnabled = true
    end
    local show_card_list = {}
    for i, data in ipairs(msgTbl.player_data) do
        if data.is_show_card > 0 then --亮牌标志：0 不亮  1亮牌 2花红亮牌 3赢家亮牌 4花红加赢家
            table.insert(show_card_list,data)
            --处理玩家自己
            if (data.seat + 1) == self:GetPlayerMeSeat() then
                self.openCardBtn:setVisible(false)
                self.showCardBtn:setVisible(false)
                self.showCardEnabled = false
            end
        end
    end
    local showCardsInteval = 1.0*(#show_card_list)
    local function showCards()
        for i,v in ipairs(show_card_list) do
            self.goldsPool:runAction(cc.Sequence:create(cc.DelayTime:create((i - 1)*0.5),cc.CallFunc:create(function ()
                 self:onRcvShowCard({seat=v.seat,cards=v.cards_in_hand,niu_type=v.niu_type})
                 if (v.is_show_card == 2 or v.is_show_card == 4) and self.roomPlayers and self:GetPlayerBySeatIdx(v.seat + 1) then --收喜钱
                     self:collectHappyMoney(self:GetPlayerBySeatIdx(v.seat + 1).displaySeatIdx,v.niu_type)
                 end
            end)))
        end
    end
	
	-- 玩家头像胜利光效
	local function winLightEffect()
        local seatIdx = msgTbl.max_seat + 1
        if self.roomPlayers and self:GetPlayerBySeatIdx(seatIdx) then
	        local displaySeat = self:GetPlayerBySeatIdx(seatIdx).displaySeatIdx
			local playerNode = self.playerNodes[displaySeat]
			local firstSprite = cc.Sprite:create("image/winLightEffect/txktx2001.png")
			firstSprite:setPosition(cc.p(0,0))
			playerNode:addChild(firstSprite)

			local animation = cc.Animation:create()
			local nameStr
			for i = 1, 16 do
				nameStr = string.format("image/winLightEffect/txktx200%d.png",i)
				animation:addSpriteFrameWithFile(nameStr)
			end
			animation:setDelayPerUnit(0.1)
			local action =cc.Animate:create(animation)                                                       
			firstSprite:runAction(action)
	    end
    end

    --飞金币到赢家,1.0秒
    local function flyGoldCoin()
        local seatIdx = msgTbl.max_seat + 1
        if self.roomPlayers and self:GetPlayerBySeatIdx(seatIdx) then
	        self:winGolds(self:GetPlayerBySeatIdx(seatIdx).displaySeatIdx)
	    end
    end

    --刷新金币池显示
    local function refreshGoldCoinPool(args)
        --刷新底池数
        self.goldsPoolLabel:setString(0)
        --刷新轮数
        -- self.curTurnsLabel:setString(0)
        self:refreshCurTurns(0)
    end

    --玩家加分减分动作,1.0秒
    local function showChangeScoreAni()
        for i, data in ipairs(msgTbl.player_data) do
		    -- 显示分数
		    local seatIdx = data.seat + 1
		    if self.roomPlayers and self:GetPlayerBySeatIdx(seatIdx) then
			    local displaySeatIdx = self:GetPlayerBySeatIdx(seatIdx).displaySeatIdx
	            --[[local addScore = tonumber(self.pledgeSigns[displaySeatIdx]:getChildByName("Text_Bet_Score"):getString())
	            if msgTbl.max_seat ~= data.seat then --输家
	                if addScore > 0 then addScore = 0 - addScore end
	            else
	                --新的分数减去玩家原有分数
	                addScore = tonumber(data.score)
	            end --]]
	            self:playAddScoreAni(displaySeatIdx, tonumber(data.score))
	        end
        end 
    end

    --刷新玩家积分显示
    local function refreshPlayersScore()
        for i, data in ipairs(msgTbl.player_data) do
		    -- 显示分数
		    local seatIdx = data.seat + 1
		    if self:GetPlayerBySeatIdx(seatIdx)  then
				local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)
			    local displaySeatIdx = roomPlayer.displaySeatIdx
	            local scoreLabel = self.playerNodes[displaySeatIdx]:getChildByName("Label_Score")
				scoreLabel:setString(roomPlayer.score)
	            self.pledgeSigns[displaySeatIdx]:getChildByName("Text_Bet_Score"):setString(0)
	            self.pledgeSigns[displaySeatIdx]:setVisible(false)
	        end
        end
    end

    --玩家进入去准备状态,显示准备按钮等等
    local function gotoReadyState(args)
        --隐藏奖池
        -- self.goldsPool:setVisible(false)
        if self.noticeTips ~= nil then
    		self.noticeTips:removeFromParent()
    		self.noticeTips = nil
    	end

        if not self.isWait then 
            if not self.isLastRound then
                gt.seekNodeByName(self.readyBtn, "lblReady"):setString("准  备")
                -- self.readyBtn:setVisible(true)
            end
            --显示亮牌按钮
            if self.isViewedCard and self.showCardEnabled then
                self.showCardBtn:setVisible(true)
            end
        end
    end

    self.goldsPool:runAction(cc.Sequence:create(cc.DelayTime:create(1.5),
                                                cc.CallFunc:create(showCards),
                                                cc.DelayTime:create(showCardsInteval),
                                                cc.CallFunc:create(winLightEffect),
												cc.CallFunc:create(flyGoldCoin),
                                                cc.DelayTime:create(1.0),
                                                cc.CallFunc:create(refreshGoldCoinPool),
                                                cc.CallFunc:create(showChangeScoreAni),
                                                cc.DelayTime:create(1.0),
                                                cc.CallFunc:create(refreshPlayersScore),
                                                cc.CallFunc:create(gotoReadyState)))
end

function PlaySceneZJH:playAddScoreAni(displaySeatIdx, addScore)
    local lbAddScore = self.playerAddSocre[displaySeatIdx]
    lbAddScore:setPosition(0,0)
    lbAddScore:setOpacity(255)
    lbAddScore:setTextColor(cc.c3b(249,207,65))  --黄色
    lbAddScore:setString("+"..addScore)
    if addScore < 0 then
        lbAddScore:setTextColor(cc.c3b(0,146,255))  --蓝色
        lbAddScore:setString(""..addScore)
    end
    local lbPos = cc.p(0, 76)
    lbAddScore:runAction(cc.Sequence:create(cc.Show:create(),cc.MoveTo:create(0.8,lbPos), cc.FadeOut:create(0.2)))
end

--总结算
function PlaySceneZJH:onRcvFinalReport(msgTbl)
	gt.removeLoadingTips()
    --发送关闭解散房间事件
    gt.dispatchEvent(gt.EventType.CLOSE_APPLY_DISMISSROOM)

    local resultEffectDelay = 4.0

	--比赛不弹大结算界面
	if self.isMatch>0 then
        resultEffectDelay = 4.0
        if msgTbl.flag == 0 then -- 投票结算
            resultEffectDelay = 0.5
        end
        self:stopAllActions()
		self:runAction(cc.Sequence:create(cc.DelayTime:create(resultEffectDelay),cc.CallFunc:create(function(sender)
			self.IsNewGame = true
			gt.dispatchEvent(gt.EventType.PLAY_SCENE_RESTART)
		end)))
		self.LastFinalReport={}
		self.LastFinalReport.roomPlayers=clone(self.roomPlayers)
		self.LastFinalReport.roomID=self.roomID
		self.LastFinalReport.guildID=self.guildID
		self.LastFinalReport.isMatch=self.isMatch
		self.LastFinalReport.msgTbl=msgTbl
		self.LastFinalReport.tableSetting=self.tableSetting
		gt.addBtnPressedListener(self.Btn_ViewFinalReport,function (sender)
			-- 弹出总结算界面
			local finalReport = require("app/views/FinalReport"):create(self.LastFinalReport.roomID, self.LastFinalReport.guildID, self.LastFinalReport.isMatch, self.LastFinalReport.roomPlayers, self.LastFinalReport.msgTbl, self.LastFinalReport.tableSetting)
			self:addChild(finalReport, PlaySceneZJH.ZOrder.REPORT)
		end)
	else
		self.isLastRound = true
		self.roomState = ROOM_STATE.SETTLE_ROOM
		self.readyBtn:setVisible(false)
		gt.log("总结算界面提示")
		local curRoomPlayers = {}
		curRoomPlayers = clone(self.roomPlayers)

		local callFunc = cc.CallFunc:create(function(sender)
			-- -- 弹出总结算界面
			local finalReport = require("app/views/FinalReport"):create(self.roomID, self.guildID, self.isMatch, curRoomPlayers, msgTbl, self.tableSetting)
			self:addChild(finalReport, PlaySceneZJH.ZOrder.REPORT)
		end)
		if msgTbl.flag == 0 then -- 投票结算
            resultEffectDelay = 2.0
        else
            resultEffectDelay = resultEffectDelay + 2.0
        end
		local seqAction = cc.Sequence:create(cc.DelayTime:create(resultEffectDelay), callFunc)
		self:runAction(seqAction)
	end
end

-- 房间创建者解散房间
function PlaySceneZJH:onRcvDismissRoom(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 1 then -- 房主直接解散
		require("app/views/NoticeTips"):create("提示", "房主已解散房间", function() gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE) end, nil, true)
	elseif msgTbl.code == 2 then  -- 投票解散
		require("app/views/NoticeTips"):create("提示", "房间已解散", function() gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE) end, nil, true)
	elseif msgTbl.code == 0 then  -- 大结算后解散
	end
	self.dismissed = true
	gt.socketClient:close()
end

function PlaySceneZJH:onRcvSponorVote(msgTbl)
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
	    self:addChild(applyDimissRoom, PlaySceneZJH.ZOrder.DISMISS_ROOM, 1000099)    
    end
    if self.active_seat == self:GetPlayerMeSeat() and self.roomState == ROOM_STATE.STEP then
	    self:restoreCmpCardsNode()
	    self.isCmpingCard = false
	    self:showOprateNode(true)
	end
end

function PlaySceneZJH:onRcvVote(msgTbl)
	local player = msgTbl.player
    local flag = msgTbl.flag
    gt.dispatchEvent(gt.EventType.APPLY_DIMISS_ROOM, msgTbl)

end

function PlaySceneZJH:onRcvSyncScore(msgTbl)
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

function PlaySceneZJH:onRcvScoreLeak(msgTbl)
	require("app/views/NoticeTips"):create(gt.LocationStrings.LTKey_0007, "积分不足，无法参与比赛", nil, nil, true)
	self.readyBtn:setVisible(true)
end

--房间添加玩家
function PlaySceneZJH:roomAddPlayer(roomPlayer)
	-- 播放声音
	self.playCDAudioID = gt.soundEngine:playEffect("common/audio_enter_room",false)
    
	local playerInfoNode = gt.seekNodeByName(self.rootNode, "Node_playerInfo_" .. roomPlayer.displaySeatIdx)
	playerInfoNode:setVisible(true)
    --是等待加入者
    if (roomPlayer.isWait) then
        gt.seekNodeByName(playerInfoNode, "Label_Wait"):setVisible(true)
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
	nicknameLabel:setString(gt.checkName(nickname,6))
	-- 积分
	local scoreLabel = gt.seekNodeByName(playerInfoNode, "Label_Score")
	scoreLabel:setString(tostring(roomPlayer.score))
	roomPlayer.scoreLabel = scoreLabel
	
	-- 庄家
	local bankerSignSpr = gt.seekNodeByName(playerInfoNode, "Spr_bankerSign")
	bankerSignSpr:setVisible(false)
	if self.bankerSeatIdx == roomPlayer.seatIdx then            
        bankerSignSpr:setVisible(true)
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

    --发玩家手牌
    if (self.roomState == ROOM_STATE.DEAL or self.roomState == ROOM_STATE.STEP) and #roomPlayer.cards_in_hand > 0 then
      --押分
        local pledgeSign = self.pledgeSigns[roomPlayer.displaySeatIdx]
        if roomPlayer.pledge and roomPlayer.pledge > 0 then
            local bflScore = pledgeSign:getChildByName("Text_Bet_Score")
		    bflScore:setString(roomPlayer.pledge)
            pledgeSign:setVisible(true)
        end
      
       local cardView = self.cardViews[roomPlayer.displaySeatIdx]
       cardView.node:setVisible(true)

        for i,value in ipairs(roomPlayer.cards_in_hand) do
            local cardImg = cardView.imgCards[i]
            cardImg:setVisible(true)
            if value > 0 then
                if math.fmod(value,16) == 14 then value = value - 13 end
                cardImg:loadTexture(string.format("image/card/%02x.png", value), ccui.TextureResType.plistType)
            else 
                cardImg:loadTexture("image/card/back.png", ccui.TextureResType.plistType)
            end
       end

       if not self.isWait and roomPlayer.niu_type and tonumber(roomPlayer.niu_type) > 0 then
            self:showCardType(roomPlayer.seatIdx,roomPlayer.niu_type)
       end
   end
end

--发送玩家准备请求消息
function PlaySceneZJH:readyBtnClickEvt()
	self.readyBtn:setVisible(false)
	if self.isMatch > 0 and self.Btn_ViewFinalReport then
    	self.Btn_ViewFinalReport:setVisible(false)
    end
	for i = 1, self.roomChairs do
		self.pledgeSigns[i]:setVisible(false)
	end
	local msgToSend = {}
	msgToSend.cmd = gt.READY
	gt.socketClient:sendMessage(msgToSend)
end

-- 开始游戏
function PlaySceneZJH:startBtnClickEvt()
	self.startBtn:setVisible(false)

	local msgToSend = {}
	msgToSend.cmd = gt.START_DN
	gt.socketClient:sendMessage(msgToSend)
end

-- 点击亮牌
function PlaySceneZJH:showCardBtnClickEvt()
	
	self.showCardBtn:setVisible(false)
    
	local msgToSend = {}
	msgToSend.cmd = gt.SHOW_CARD_DN
	gt.socketClient:sendMessage(msgToSend)
	
end

-- 点击看牌牌
function PlaySceneZJH:openCardBtnClickEvt()
	gt.log("------:"..self.curTurns .."  roomstate:"..self.roomState)
	if self.curTurns < self.tableSetting.zjh_menpai and self.roomState  == ROOM_STATE.STEP then
	 	require("app/views/CommonTips"):create(string.format("操作失败，需要第%d回合才可以进行该操作",self.tableSetting.zjh_menpai + 1))
	else
		self.openCardBtn:setVisible(false)
	    
	    local msgToSend = {}
		msgToSend.cmd = gt.LOOK_CARDS
		gt.socketClient:sendMessage(msgToSend)
	end
end

--玩家进入准备状态
function PlaySceneZJH:playerGetReady(seatIdx)
	local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)
    --玩家状态改成准备状态
    roomPlayer.state = PLAYER_STATE.READY
    roomPlayer.pledge = 0
    roomPlayer.isWait = false
    roomPlayer.cur_total_pledge = 0
    roomPlayer.look_cards = false --看牌
    roomPlayer.waive_type = 0 --0 在游戏中  1弃牌
    roomPlayer.is_show_card = false --没显示牌
    roomPlayer.is_win = true --true游戏中 false比牌输
    roomPlayer.niu_type = nil

    local lbWait = self.playerWaitSigns[roomPlayer.displaySeatIdx]
    lbWait:setVisible(false)

	-- 显示玩家准备手势
    self.readySigns[roomPlayer.displaySeatIdx]:setVisible(true)

     --隐藏牌
    self.cardViews[roomPlayer.displaySeatIdx].node:setVisible(false)
    --隐藏压分
    self.pledgeSigns[roomPlayer.displaySeatIdx]:setVisible(false)
    --隐藏牌类型
    self.cardViews[roomPlayer.displaySeatIdx].imgCardType:setVisible(false)
 
	-- 玩家本身
	if seatIdx == self:GetPlayerMeSeat() then
        self.imgGuanZhan:setVisible(false)
        self.isWait = false
        self.m_menu:showChatBtns()

        --gt.seekNodeByName(self.readyBtn, "lblReady"):setString("准  备")
        self.readyBtn:loadTextureNormal("image/play/btn_ready.png")

		-- 隐藏准备按钮
        self.readyBtn:stopAllActions()
		self.readyBtn:setVisible(false)
        self:hideSigns()

        self.showCardBtn:setVisible(false)
        self.openCardBtn:setVisible(false)
        --看牌标为False
        self.isViewedCard = false
        self.showCardEnabled = false

        if (self.curRound <= 1 and self.roomState <= ROOM_STATE.START) then
            if (self:isBanker()) then
                if self.roomState == ROOM_STATE.INIT then
                    --准备后自己是庄家  则提示等待其他玩家准备
                    self.lbWatingTip:setString("等待其他玩家准备...")
                    self.bgWaitingTip:setVisible(true)
                end
            else
                --准备后自己不是庄家则不显示开始按钮，则提示等待房主开始游戏
                local roomPlayerBanker = self:GetPlayerBySeatIdx(self.bankerSeatIdx)
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
function PlaySceneZJH:hidePlayersReadySign(displaySeat)
    if not self.readySigns then
	    self.readySigns = {}
	    for i = 1, self.roomChairs do
		    local readySignNode = gt.seekNodeByName(self.rootNode, "Node_readySign")
		    local readySignSpr = gt.seekNodeByName(readySignNode, "Spr_readySign_" .. i)
		    self.readySigns[i] = readySignSpr
	    end
    end

    if not displaySeat then
	    for i = 1, self.roomChairs do
		    self.readySigns[i]:setVisible(false)
	    end
    else
        self.readySigns[displaySeat]:setVisible(false)
    end
end

--隐藏所有玩家压分标识
function PlaySceneZJH:hidePlayersPledgeSign()
	for i = 1, self.roomChairs do
		self.pledgeSigns[i]:setVisible(false)
	end
end

--隐藏所有玩家庄家标识
function PlaySceneZJH:hidePlayersBankerSign()
    for i = 1, self.roomChairs do
        local playerInfoNode = gt.seekNodeByName(self.rootNode, "Node_playerInfo_"..i)
        local bankerSignSpr = gt.seekNodeByName(playerInfoNode, "Spr_bankerSign")
        bankerSignSpr:setVisible(false)
    end
end

--隐藏所有玩家等待标识
function PlaySceneZJH:hidePlayersWaitSign()
    for i = 1, self.roomChairs do
        local lbWait = self.playerWaitSigns[i]
        lbWait:setVisible(false)
    end
end

-- 每局准备后隐藏相应标识
function PlaySceneZJH:hideSigns()
    -- 隐藏压分标识
    self:hidePlayersPledgeSign()
    -- 如果是抢庄牛牛 每小局结算后隐藏庄家标识
    if (self.tableSetting.game_type == gt.GameType.GAME_BANKER or self.tableSetting.game_type == gt.GameType.GAME_FREE_BANKER) then
        self:hidePlayersBankerSign()
    end
end

--重置牌型位置
function PlaySceneZJH:resetCardsPos()
	for i = 1, self.roomChairs do
		for j = 1, 3 do
			local pos = self.cardViews[i].imgCards[j].imgCardPos
            self.cardViews[i].imgCards[j]:setPosition(pos)
		end
    end
end

--房间是否已坐满员
function PlaySceneZJH:isSeatFull()
    local bFull = false
    local playerNum = gt.getTableSize(self.roomPlayers)
    if (self.roomChairs == gt.GameChairs.SIX and playerNum == gt.GameChairs.SIX) or 
        (self.roomChairs == gt.GameChairs.TEN and playerNum == gt.GameChairs.TEN) then
        bFull = true
    end
    return bFull
end

--重置手牌明暗标识
function PlaySceneZJH:resetCardSigns()
	for i = 1, self.roomChairs do
		self:setCardsGray(i,false)
    end   
end

--设置亮牌时牌型明暗显示
function PlaySceneZJH:setCardsGray(displaySeatIdx,isGray)
    local cardView = self.cardViews[displaySeatIdx]
    for i = 1, #cardView.imgCards do
        if isGray then
            GrayShader:addGrayNode(cardView.imgCards[i])
        else 
            GrayShader:removeGrayNode(cardView.imgCards[i])
        end
    end
end

-- 显示玩家具体信息面板
function PlaySceneZJH:showPlayerInfo(sender)
    gt.soundEngine:playEffect(gt.clickBtnAudio, false)
	local senderTag = sender:getTag()
	local roomPlayer = self:GetPlayerBySeatIdx(senderTag)
	if not roomPlayer then
		return
	end

    --if not self.isCmpingCard then
        local shpwType = 2
        if self.isWait then
            shpwType = 1
        end
	    local playerInfoTips = require("app/views/PlayerInfoTips"):create(roomPlayer, shpwType)
	    self:addChild(playerInfoTips, PlaySceneZJH.ZOrder.PLAYER_INFO_TIPS)

    --[[else  --比牌
        self:sendCmpCardMsg(roomPlayer)
    end--]]
end

--更新出牌倒计时
function PlaySceneZJH:playTimeCDUpdate(delta)
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
end

function PlaySceneZJH:playSceneResetEvt()
	if not self.IsReplay then
		gt.log("playSceneResetEvt")
		--从后台回来先清除下之前缓存的消息
		gt.socketClient:clearMessage()
		self:reLogin()
	end
end

function PlaySceneZJH:reInitScene(isNotClearPlayer)
	self.waitType = nil
	gt.dispatchEvent(gt.EventType.CLOSE_APPLY_DISMISSROOM)
	
    self:stopAllActions()

    self.lblCmpTips:setVisible(false)
    self.readyBtn:setVisible(false)
    self.startBtn:setVisible(false)
    self.inviteFriendBtn:setVisible(false)
    self.imgGuanZhan:setVisible(false)
    self.showCardBtn:setVisible(false)
    self.openCardBtn:setVisible(false)
    self.openCardBtn:stopAllActions()
    self.bgWaitingTip:setVisible(false)

    self:hidePlayersReadySign()
    self:hidePlayersPledgeSign()
    self:resetCardSigns()
    self:resetCardsPos()
    self:hideAllCardType()
    self:hideAllCards()
    self:resetGoldsPool()
    self:hideCountdown()

	if self.isMatch and self.IsNewGame then
		self.readyBtn:setPositionX(-150)
		--self.readyBtn:getChildByName("lblReady"):setString("继续游戏")
        self.readyBtn:loadTextureNormal("image/play/btn_continue.png")
		self.Btn_ViewFinalReport:setPositionX(150)
		self.Btn_ViewFinalReport:setContentSize(226,82)
		self.Btn_ViewFinalReport:setVisible(true)
	end
    self.readyBtn:setVisible(true)

    
	self:showOprateNode(false)
	

    if not isNotClearPlayer then
	    for i = 1, self.roomChairs do
		    self.playerNodes[i]:setVisible(false)
	    end
    end
end

function PlaySceneZJH:playSceneRestartEvt()
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

	gt.socketClient:clearMessage()
    self:reLogin()
end

function PlaySceneZJH:backMainSceneEvt(eventType)
	extension.callBackHandler = {}
	-- 事件回调
	gt.removeTargetAllEventListener(self)
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

function PlaySceneZJH:sendCmpCardMsg(roomPlayer)
    local msgToSend = {cmd = gt.COMPARE_DN}
	msgToSend.cmp_seat = roomPlayer.seatIdx - 1
	gt.socketClient:sendMessage(msgToSend)

    --恢复玩家层次节点
    self:restoreCmpCardsNode()
    --隐藏操作牌
    self:showOprateNode(false)
end

function PlaySceneZJH:showOprateNode(isShow)
	if self.operateNode then
		self.operateNode:setVisible(isShow)
	end
	if self:isWatchByOrder() then
		local playerMe = self:GetPlayerMe()
		if playerMe and isShow then
			if (playerMe.waive_type and playerMe.waive_type > 0) or playerMe.look_cards then
				return
			end
		end
		self.openCardBtn:setVisible(isShow)
	end
end

function PlaySceneZJH:isWatchByOrder()
	if self.tableSetting and self.tableSetting.zjh_watch then
		return self.tableSetting.zjh_watch > 0
	else
		return false
	end
end

function PlaySceneZJH:isStraightBiggerThanFlush()
	if self.tableSetting and self.tableSetting.zjh_straight_big then
		return self.tableSetting.zjh_straight_big > 0
	else
		return false
	end
end

function PlaySceneZJH:refreshOperateBtnsScore()
    local config ={
        [10] = {2,5,10},
        [20] = {10,15,20},
        [30] = {10,20,30},
    }

    local maxBetScore = self.tableSetting.score
    --弃牌按钮 #一直显示
    
    --比牌按钮
    local isDouble = gt.charAt(self.tableSetting.options,2) == "1"

    self.compareBtn:getChildByName("Text_BM_Title"):setString(self.cur_need_pledge*(self.isViewedCard and (isDouble and 4 or 2) or (isDouble and 2 or 1)))

    self.compareBtn:setEnabled(self.curTurns >= self.tableSetting.zjh_bipai) --3轮开始比牌


    --跟注
    self.betBtn:getChildByName("Text_BM_Title"):setString(self.cur_need_pledge*(self.isViewedCard and 2 or 1))

    --隐藏加注按钮
    self.raiseListView:setVisible(false)

    --加注按钮
    self.raiseBtn:setEnabled(self.cur_need_pledge < maxBetScore)
    --加注小按钮
    local raiseCfg = config[maxBetScore]
    local cur_need_pledge = self.cur_need_pledge*(self.isViewedCard and 2 or 1)
    for i,btnBet in ipairs(self.raiseBtnArr) do 
        local textLabel = btnBet:getChildByName("Text_BM_Title")
        textLabel:setString(raiseCfg[i]*(self.isViewedCard and 2 or 1))
        if tonumber(textLabel:getString()) <= cur_need_pledge then
            btnBet:setEnabled(false)
        else 
            btnBet:setEnabled(true)
        end
    end
end

function PlaySceneZJH:IsSameIp(msgTbl)
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

--显示庄家标识
function PlaySceneZJH:showBankerSign()
    local roomPlayerBanker = self:GetPlayerBySeatIdx(self.bankerSeatIdx)
    local playerInfoNode = gt.seekNodeByName(self.rootNode, "Node_playerInfo_" .. roomPlayerBanker.displaySeatIdx)
    local bankerSignSpr = gt.seekNodeByName(playerInfoNode, "Spr_bankerSign")
    bankerSignSpr:setVisible(true)
end

--是否庄家
function PlaySceneZJH:isBanker(playerSeatIdx)

    playerSeatIdx = playerSeatIdx or self.playerSeatIdx
    if self.bankerSeatIdx > 0 and self.bankerSeatIdx == playerSeatIdx then
		return true
	end
	return false
end

-- 是否是房间拥有者(房间创建者，房间庄家都是)
function PlaySceneZJH:isRoomOwner()
    if self.guildID and self.guildID > 0 then
    	return self.isRoomCreater or self.isAdmin

    elseif (self.isRoomCreater or self:isBanker() or self.isAdmin) then
		return true
	end

	return false
end

function PlaySceneZJH:showCardType(seatIdx,cardType)
    local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)

    local cardTypeFile = "image/play_zjh/"
    if cardType == 60 then  --豹子
        cardTypeFile = cardTypeFile .. "poker_type_6.png"
    elseif cardType == 51 or cardType == 50 then --顺金（50是123同花顺）
        cardTypeFile = cardTypeFile .. "poker_type_5.png"
    elseif cardType == 41 or cardType == 40 then --金花
    	if self:isStraightBiggerThanFlush() then
	        cardTypeFile = cardTypeFile .. "poker_type_3.png"
    	else
	        cardTypeFile = cardTypeFile .. "poker_type_4.png"
	    end
    elseif cardType == 31 or cardType == 30 then --顺子（30是123顺子）
    	if self:isStraightBiggerThanFlush() then
        	cardTypeFile = cardTypeFile .. "poker_type_4.png"
        else
        	cardTypeFile = cardTypeFile .. "poker_type_3.png"
        end
    elseif cardType and cardType >= 10 and cardType < 30 then --对子
        cardTypeFile = cardTypeFile .. "poker_type_2.png"
    else  --高牌
        cardTypeFile = cardTypeFile .. "poker_type_1.png"
    end
    self.cardViews[roomPlayer.displaySeatIdx].imgCardType:loadTexture(cardTypeFile, ccui.TextureResType.plistType)
    self.cardViews[roomPlayer.displaySeatIdx].imgCardType:setVisible(true)
end

function PlaySceneZJH:hideAllCardType()
    for _,cardNode in ipairs(self.cardViews) do
        cardNode.imgCardType:setVisible(false)
    end
end

function PlaySceneZJH:hideAllCards()
    for _,cardNode in ipairs(self.cardViews) do
        cardNode.node:setVisible(false)
    end
end

function PlaySceneZJH:playMusicEffect(seatIdx,effFileName)
    local roomPlayer = self:GetPlayerBySeatIdx(seatIdx)
    local path = "man/zjh/"
    if roomPlayer.sex == 2 then
        path = "woman/zjh/" 
    end
     gt.soundEngine:playEffect(path .. effFileName, false)
end

function PlaySceneZJH:playCardTypeEff(seatIdx,cardType)
    if cardType == 60 then  --豹子
        self:playMusicEffect(seatIdx,"three")
    elseif cardType == 51 or cardType == 50 then --顺金（50是123同花顺）
        self:playMusicEffect(seatIdx,"flush_straight")
    elseif cardType == 41 or cardType == 40 then --金花
    	if self:isStraightBiggerThanFlush() then
	        self:playMusicEffect(seatIdx,"straight")
    	else
	        self:playMusicEffect(seatIdx,"flush")
	    end
    elseif cardType == 31 or cardType == 30 then --顺子（30是123顺子）
    	if self:isStraightBiggerThanFlush() then
	        self:playMusicEffect(seatIdx,"flush")
    	else
	        self:playMusicEffect(seatIdx,"straight")
	    end
    elseif cardType and cardType >= 10 and cardType < 30 then --对子
        self:playMusicEffect(seatIdx,"pair")
    else 
        gt.log('该牌型没有对应声音资源')
    end
end

function PlaySceneZJH:sortCards(cards)
   cards = cards or {}
   local function sortFunc(a,b)
        local aHuase = math.floor(a/16)
        local aValue = math.fmod(a,16)
        local bHuase = math.floor(b/16)
        local bValue = math.fmod(b,16)
        if aValue == bValue then 
            return aHuase > bHuase           
        end
        return aValue < bValue
   end
   table.sort(cards,sortFunc)
end

return PlaySceneZJH

