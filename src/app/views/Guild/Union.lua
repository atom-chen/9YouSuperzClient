-- 大联盟界面

local gt = cc.exports.gt

local Union = class("Union", function()
	return gt.createMaskLayer()
end)

function Union:ctor(isShowAnim)
	self:registerScriptHandler(handler(self, self.onNodeEvent))

	local csbNode = cc.CSLoader:createNode("csd/Guild/Union.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
    --ccui.Helper:doLayout(csbNode)
	self:addChild(csbNode)
	self.csbNode = csbNode
	gt.log("-----openUI:union")
	
	self.isShowAnim = isShowAnim or 1

	self:initUI()
	-- 初始化视图
	self:initGuildListView()
	self:initRoomsView()
	self:initSettingView()
	self:initDataView()
	self:initScoreView()
	-- self:initMatchView()
	self:initTopView()
	self:initJoinUi()

	gt.socketClient:registerMsgListener(gt.UNION_CHECK_ACTIVE_CODE, self, self.onRcvCheckActiveCode)
	gt.socketClient:registerMsgListener(gt.MATCH_ROOM, self, self.onRcvMatchRoom)
	gt.socketClient:registerMsgListener(gt.GUILD_INFO, self, self.onRcvGuildInfo)
	gt.socketClient:registerMsgListener(gt.GUILD_MEMBER, self, self.onRcvGuildMember)

	gt.socketClient:registerMsgListener(gt.CREATE_GUILD, self, self.onRcvCreateGuild)
	gt.socketClient:registerMsgListener(gt.APPLY_GUILD, self, self.onRcvApplyGuild)
	gt.socketClient:registerMsgListener(gt.GUILD_LIST, self, self.onRcvGuildList)
	gt.socketClient:registerMsgListener(gt.DISMISS_GUILD, self, self.onRcvDismissGuild)
	gt.socketClient:registerMsgListener(gt.EXIT_GUILD, self, self.onRcvExitGuild)
	-- gt.socketClient:registerMsgListener(gt.DEL_MEMBER, self, self.onRcvDelMember)
	gt.socketClient:registerMsgListener(gt.RENAME_GUILD, self, self.onRcvRenameGuild)
	gt.socketClient:registerMsgListener(gt.GUILD_ROOM_PARAM, self, self.onRcvGuildRoomParam)
	gt.socketClient:registerMsgListener(gt.RECV_GUILD_APPLY, self, self.onRcvRecvGuildApply)
	gt.socketClient:registerMsgListener(gt.RECV_GUILD_REPLY, self, self.onRcvRecvGuildReply)
	gt.socketClient:registerMsgListener(gt.GUILD_NULL, self, self.onRcvGuildNull)
	gt.socketClient:registerMsgListener(gt.GUILD_INVITE, self, self.onRcvGuildInvite)
	gt.socketClient:registerMsgListener(gt.CREATE_ROOM, self, self.onRcvCreateRoom)
	gt.socketClient:registerMsgListener(gt.JOIN_ROOM, self, self.onRcvJoinRoom)

	gt.socketClient:registerMsgListener(gt.GUILD_INVITE_MEMBER, self, self.onRcvGuildInviteMember)
	gt.socketClient:registerMsgListener(gt.GUILD_INVITE_LIST, self, self.onRcvGuildInviteList)

	gt.registerEventListener(gt.EventType.GUILD_PARTNER_INVITE, self, self.regisMsgInvite)
	gt.registerEventListener(gt.EventType.GUILD_REFRESH_SCORE, self, self.refreshScore)

	gt.registerEventListener(gt.EventType.GUILD_MEMBER_MSG, self, self.regisMsgMember)
end

function Union:initUI()
	--左边联盟列表 高度全屏适配
	self.Panel_Left = gt.seekNodeByName(self.csbNode, "Panel_Left")
	self.Panel_Left:setContentSize(cc.size(self.Panel_Left:getContentSize().width, gt.winSize.height))

	--俱乐部房间列表 宽度全屏适配
	self.lstRooms = gt.seekNodeByName(self.csbNode, "List_Rooms")
	self.roomListSize = self.lstRooms:getContentSize()
	self.roomListSize.width = self.roomListSize.width + (gt.winSize.width - 1280)
	self.lstRooms:setContentSize(self.roomListSize)
	
	ccui.Helper:doLayout(self.csbNode)

	self.currentGuild = nil
	self.refreshTime = 0
	gt.UnionManager = require("app/views/Guild/GuildManager"):create()
	
	-- 头像下载管理器
	local playerHeadMgr = require("app/PlayerHeadManager"):create("Union")
	self.csbNode:addChild(playerHeadMgr)
	self.playerHeadMgr = playerHeadMgr

	local btnClose1 = gt.seekNodeByName(self.csbNode, "btnClose")
	gt.addBtnPressedListener(btnClose1, function()
		self:removeFromParent()
		gt.soundEngine:playMusic("bgm1", true)
	end)

    self.itemParticle = gt.seekNodeByName(self.csbNode,"itemParticle")
    self.itemParticle:retain()
    self.itemParticle:removeFromParent()

    self.panelBtn = gt.seekNodeByName(self.csbNode, "Panel_Btn")
    self.panelBtn:setVisible(false)
	
	local btnCreate = gt.seekNodeByName(self.csbNode,"Btn_Create")
	gt.addBtnPressedListener(btnCreate, function()
		self:createGuild()
	end)

	local btnJoin = gt.seekNodeByName(self.csbNode,"Btn_Join")
	gt.addBtnPressedListener(btnJoin, function()
		self:joinGuild()
	end)
	
	self.Button_Flex = gt.seekNodeByName(self.csbNode,"Button_Flex")
	gt.addBtnPressedListener(self.Button_Flex, function()
		self:guildListFlex()
	end)
	self.bIsShowGuildList = true
end

function Union:joinGuild()
    local guilds = gt.UnionManager:getGuildList()
    if #guilds >= 5 then
		require("app/views/NoticeTips"):create("提示", "您创建和加入的大联盟数量超过限制", nil, nil, false)
		return
	end
	local view = require("app/views/Guild/GuildNumberPad"):create("guild_apply",1)
    self:addChild(view)
end

function Union:createGuild()
    local guilds = gt.UnionManager:getGuildList()
    if #guilds >= 5 then
		require("app/views/NoticeTips"):create("提示", "您创建和加入的大联盟部数量超过限制", nil, nil, false)
		return
	end
	-- local view = require("app/views/Guild/GuildInput"):create("guild_create")
	local view = require("app/views/Guild/UnionActive"):create()
    self:addChild(view)
end
	
function Union:guildListFlex()	
	--必须先doLayout 再MoveTo
	
	self.Button_Flex:setEnabled(false)
	
	local enabledBtnFun = cc.CallFunc:create(function(sender)
		self.Button_Flex:setEnabled(true)
    end)	
	if self.bIsShowGuildList then
		self.roomListSize.width = self.roomListSize.width + 285	
		self.lstRooms:setContentSize(self.roomListSize)
		ccui.Helper:doLayout(self.csbNode)
			
		self.Button_Flex:loadTextureNormal("image/guild/NewBigUnion/btnFlexRight.png")
		
		local EaseSineMoveTo = cc.EaseSineIn:create(cc.MoveTo:create(0.5, cc.p(-285, 0)))
	    self.Panel_Left:runAction(cc.Sequence:create(EaseSineMoveTo, enabledBtnFun))
		self.bIsShowGuildList = false
	else
		self.Button_Flex:loadTextureNormal("image/guild/NewBigUnion/btnFlexLeft.png")
		
		self.Panel_Left:setPosition(-285, 0)
		local EaseSineMoveTo = cc.EaseSineIn:create(cc.MoveTo:create(0.5, cc.p(0, 0)))
		local delayFun = cc.CallFunc:create(function(sender)
				self.roomListSize.width = self.roomListSize.width - 285
				self.lstRooms:setContentSize(self.roomListSize)
				ccui.Helper:doLayout(self.csbNode)
	     	end)
		self.Panel_Left:runAction(cc.Sequence:create(EaseSineMoveTo, delayFun, enabledBtnFun))
		self.bIsShowGuildList = true
	end
	
end
	
function Union:initJoinUi()
	self.UnionJoinBg = gt.seekNodeByName(self.csbNode, "UnionJoinBg")
	self.UnionJoinBg:setLocalZOrder(100)
	if 0 < self.isShowAnim then
		self.UnionJoinBg:setVisible(true)
		gt.soundEngine:stopMusic()
	else
		self.UnionJoinBg:setVisible(false)
		gt.soundEngine:playMusic("union", true)
	end
	
	self.Panel_JoinUnion = gt.seekNodeByName(self.csbNode, "Panel_JoinUnion")
	self.Panel_JoinUnion:setLocalZOrder(101)
	self.Panel_JoinUnion:setVisible(false)
	
	self.FileNode_StayAni = gt.seekNodeByName(self.Panel_JoinUnion, "FileNode_StayAni")
	
	self.Button_Close = self.FileNode_StayAni:getChildByName("Button_Close")
	gt.addBtnPressedListener(self.Button_Close, function()
		self:removeFromParent()
		gt.soundEngine:playMusic("bgm1", true)
	end)
	
	self.Text_CountDown = self.FileNode_StayAni:getChildByName("Text_CountDown")
	self.Text_CountDown:setString("")
	
	self.Button_Join = self.FileNode_StayAni:getChildByName("Button_Join")
	gt.addBtnPressedListener(self.Button_Join, function()
		local guilds = gt.UnionManager:getGuildList()
		if 0 == #guilds then
			self:joinGuild()
		else
			self.Panel_JoinUnion:setVisible(false)
			self.UnionJoinBg:setVisible(false)
			self.FileNode_JoinAni:stopAllActions()
			self.FileNode_StayAni:stopAllActions()
			
			gt.soundEngine:playMusic("union", true)
		end
	end)
	
	self.Button_Create = self.FileNode_StayAni:getChildByName("Button_Create")
	gt.addBtnPressedListener(self.Button_Create, function()
		local guilds = gt.UnionManager:getGuildList()
		if 0 < #guilds then
			self.Panel_JoinUnion:setVisible(false)
			self.UnionJoinBg:setVisible(false)
			self.FileNode_JoinAni:stopAllActions()
			self.FileNode_StayAni:stopAllActions()
			
			gt.soundEngine:playMusic("union", true)
		end
		self:createGuild()
	end)
end

function Union:showJoinUi(msgTbl)	
	gt.soundEngine:playEffect("unionJoin", false)
		
	self.Panel_JoinUnion:setVisible(true)
	self.UnionJoinBg:setVisible(true)
	
	local function setShowHide()
        gt.soundEngine:playMusic("unionActive", true)

		self.FileNode_StayAni:setVisible(true)
		self.stayAni:play("animation_Stay",true)
		
		self.FileNode_JoinAni:setVisible(false)

		if msgTbl.now_time > msgTbl.end_time  then
			self.Text_CountDown:setString("待开启")
		else
			if msgTbl.now_time < msgTbl.start_time  then
				self.Text_CountDown:setString("敬请期待")
			end
			self.startTime = msgTbl.start_time
			self.endTime = msgTbl.end_time
			self.nowTime = msgTbl.now_time
			self.localSubNetTime = os.time()- self.nowTime
			self:updateActivityTime()
			self.activeTimeSchedule = gt.scheduler:scheduleScriptFunc(handler(self, self.updateActivityTime), 1, false)
		end
	end

	self.FileNode_StayAni:setVisible(false)
	self.stayAni = cc.CSLoader:createTimeline("csd/texiao/dalianmeng.csb")
	self.FileNode_StayAni:runAction(self.stayAni)

	self.FileNode_JoinAni = gt.seekNodeByName(self.Panel_JoinUnion, "FileNode_JoinAni")
	local joinAni = cc.CSLoader:createTimeline("csd/texiao/dalianmeng_ruchang.csb")
    self.FileNode_JoinAni:runAction(joinAni)
    joinAni:play("animation_Join",false)
	
	self.csbNode:runAction(cc.Sequence:create(cc.DelayTime:create(85/60), cc.CallFunc:create(setShowHide)))
end
	
function Union:updateActivityTime()
	if self.Panel_JoinUnion:isVisible() then
		self.nowTime = os.time() - self.localSubNetTime
		if self.nowTime > self.endTime then
			self.Text_CountDown:setString("待开启")
			if self.activeTimeSchedule then
				gt.scheduler:unscheduleScriptEntry(self.activeTimeSchedule)
				self.activeTimeSchedule = nil
			end
		elseif self.nowTime > self.startTime then
			self.Text_CountDown:setString(gt.convertTimeSpanToString(self.endTime - self.nowTime))
		end
	else
		if self.activeTimeSchedule then
			gt.scheduler:unscheduleScriptEntry(self.activeTimeSchedule)
			self.activeTimeSchedule = nil
		end
	end
end

function Union:onRcvCheckActiveCode(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		require("app/views/CommonTips"):create("激活码验证成功,请输入大联盟名称继续创建.")
		local view = require("app/views/Guild/GuildInput"):create("union_create",msgTbl.active_code)
        self:addChild(view)
	elseif msgTbl.code == 1 then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "激活码已被使用,请重新输入", nil, nil, true)
	elseif msgTbl.code == 2 then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "激活码错误,请重新输入", nil, nil, true)
	end	
end


function Union:onRcvMatchRoom(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.guild_id ~= self.currentGuild.id then
		return
	end
	local function enterRoom(sender)
		local roomId = sender:getTag()
		self:joinRoom(roomId)
	end

	local function getPlayersData(datas,index_)
		local playerUid = 0
		local data_ = nil
		local i = 1;
		for k,v in pairs(datas) do
			if i == index_ then
				playerUid = k
				data_ = v
			end
			i = i+1
		end
		return playerUid,data_
	end

	self.lstRooms:removeAllChildren()
	self.playerHeadMgr:detachAll()

	local itemBase 
	local pItem 

	local guildRoomsData = msgTbl.rooms
	if #guildRoomsData > 0 then
		table.sort(guildRoomsData, function( a, b)
						if a.c_time and b.c_time then
							return a.c_time > b.c_time
						else
							return false
						end
					end)
	end

	self.guildRoomsData = guildRoomsData
	self.btnFastJoin:setVisible(true)

	self.playerHeadMgr:detachAll()

	for i, v in ipairs(guildRoomsData) do
		-- local pItem = self.pRoomTemplate:clone()
		if i % 2 == 1 then
			itemBase = self.pRoomTemplate:clone()
			self.lstRooms:pushBackCustomItem(itemBase)
			pItem = itemBase:getChildByName("panelItem0")
		else
			pItem = itemBase:getChildByName("panelItem1")
			pItem:setVisible(true)
		end

		local par = json.decode(v.kwargs)
		local btnInfo = pItem:getChildByName("Btn_Info")
		btnInfo:setTag(i)
		btnInfo:addClickEventListener(self.onRoomInfo)

		local btnDismiss = pItem:getChildByName("Btn_Dismiss")
		btnDismiss:setTag(v.id)
		btnDismiss:addClickEventListener(self.onRoomDismiss)
		btnDismiss:setVisible(gt.UnionManager:isGuildAdmin(self.guild_id) or gt.UnionManager:isGuildOwner(self.guild_id) )

		--癞子玩法
		local Image_MagicCardFlag = pItem:getChildByName("Image_MagicCardFlag")
		if not par.laizi or 0 == par.laizi then
			Image_MagicCardFlag:setVisible(false)
		else
			Image_MagicCardFlag:setVisible(true)
			if 1 == par.laizi then
				Image_MagicCardFlag:loadTexture("image/guild/NewBigUnion/UnionMagicCard.png")
			elseif 2 == par.laizi then
				Image_MagicCardFlag:loadTexture("image/guild/NewBigUnion/UnionMagicCardCrazy.png")
			end
		end
		
		-- 房号
		pItem:getChildByName("Label_RoomId"):setString(tostring(v.id))
		-- 玩法
		local strGameId = gt.getGameIdDesc(par)

		pItem:getChildByName("Label_PlayType"):setString(gt.getGameTypeDesc(par.game_id, par.game_type) .. "[" .. strGameId .. "]")
		-- 局数/人数
		v.emptyNum = par.max_chairs - v.player_count
		-- pItem:getChildByName("Label_Round"):setString(string.format("%d/%d局\n%d/%d人",v.round, par.rounds, v.player_count, par.max_chairs))
		pItem:getChildByName("Label_Round"):setString(string.format("%d/%d局",v.round, par.rounds))

		-- 付费
		local desc = ""
		local room_card = gt.getRoomCardConsume(par.game_id, par.pay, par.rounds, par.max_chairs)
		if par.pay == 1 then
			desc = "房主付费" .. string.format(" %d房卡", room_card)
		else
			desc = "AA付费" .. string.format(" %d房卡", room_card)
		end
		pItem:getChildByName("Label_Consume"):setString(desc)
		-- 进入房间
		-- local btnEnterroom = pItem:getChildByName("Btn_Enterroom")
		-- btnEnterroom:setTag(v.id)
		-- btnEnterroom:addClickEventListener(enterRoom)
		pItem:setTag(v.id)
		pItem:addClickEventListener(enterRoom)
		-- self.lstRooms:pushBackCustomItem(pItem)

		--desktop
		local imgDeskTop4 = pItem:getChildByName("imgDeskTop4")
		local imgDeskTop6 = pItem:getChildByName("imgDeskTop6")
		local imgDeskTop8 = pItem:getChildByName("imgDeskTop8")
		local imgDeskTop10 = pItem:getChildByName("imgDeskTop10")
		local imgDeskTop12 = pItem:getChildByName("imgDeskTop12")
		local curDeskTop = imgDeskTop6
		imgDeskTop4:setVisible(false)
		imgDeskTop6:setVisible(false)
		imgDeskTop8:setVisible(false)
		imgDeskTop10:setVisible(false)
		imgDeskTop12:setVisible(false)
		if par.max_chairs == 4 then
			curDeskTop = imgDeskTop4
		elseif par.max_chairs == 6 then
			curDeskTop = imgDeskTop6
		elseif par.max_chairs == 8 then
			curDeskTop = imgDeskTop8
		elseif par.max_chairs == 10 then
			curDeskTop = imgDeskTop10
		elseif par.max_chairs == 12 then
			curDeskTop = imgDeskTop12
		end
		curDeskTop:setVisible(true)

		for i = 1, par.max_chairs do
			local imgHead = curDeskTop:getChildByName("imgHead"..i)
			if imgHead then
				--TEST TODO
				-- if i <=  (index % par.max_chairs) then
				if i <=  v.player_count then
					imgHead:setVisible(true)

					local playerUid,playerData = getPlayersData(v.players,i)
					local playerPar = json.decode(playerData)
					if playerData and playerPar.icon ~= "" then
					    self.playerHeadMgr:attach(imgHead, playerUid, playerPar.icon)
				    end

					imgHead:setTouchEnabled(true)
					imgHead:addClickEventListener(function()
				        gt.soundEngine:playEffect(gt.clickBtnAudio, false)
				        local playData_ = {}
				        playData_.uid = playerUid
				        playData_.sex = playerPar.sex
				        playData_.nickname = playerPar.nick
				        -- playData_.ip = playerPar.ip
				        playData_.game_count = playerPar.game_count
				        playData_.reg_time = playerPar.reg_time
				        gt.dump(playData_)

						local playerInfoTips = require("app/views/PlayerInfoTips"):create(playData_, 1)
						self:addChild(playerInfoTips)
					end)
				else
					imgHead:setVisible(false)
				end
			end
		end

	end
	local guild = gt.UnionManager:getGuild(self.guild_id)
	self:showButtons(guild.owner_id == gt.playerData.uid or msgTbl.admin)
	-- self.Label_EmojiCost:setString("昨日表情消耗:".. tostring(msgTbl.out_dividend_score))
	self.btnAdminSetting:setVisible(guild.owner_id == gt.playerData.uid)

	self:refreshGuildPartnerView()
end

function Union:showButtons(visible)
	self.btnLimit:setVisible(visible)
	self.btnRoomSetting:setVisible(visible)
	-- self.btnSetting:setVisible(visible)
	-- self.btnMembers:setVisible(visible)
	self.btnCreateRoom:setVisible(visible)
	-- self.btnScoreRecord:setVisible(visible)
end

function Union:refreshScore()
	if self.currentGuild then
		self.lblUserScore:setString(gt.UnionManager:getMyScore(self.currentGuild.id))
		self.lblUserScore:setVisible(true)
		self.lblUserScoreStr:setVisible(true)
	end
end


function Union:regisMsgMember()
	gt.socketClient:registerMsgListener(gt.GUILD_MEMBER, self, self.onRcvGuildMember)
end

function Union:regisMsgInvite()
	gt.socketClient:registerMsgListener(gt.GUILD_INVITE, self, self.onRcvGuildInvite)
end

function Union:onNodeEvent(eventName)
	if "enter" == eventName then
		self:request(gt.GUILD_LIST)
		-- self:request(gt.GUILD_INVITE_LIST)
		self.scheduleHandler = gt.scheduler:scheduleScriptFunc(handler(self, self.update), 1, false)
	elseif "exit" == eventName then
		self.playerHeadMgr:close()
		
		if self.scheduleHandler then
			gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
			self.scheduleHandler = nil
		end
		if self.activeTimeSchedule then
			gt.scheduler:unscheduleScriptEntry(self.activeTimeSchedule)
			self.activeTimeSchedule = nil
		end
		
		gt.socketClient:unregisterMsgListener(gt.UNION_CHECK_ACTIVE_CODE)
		gt.socketClient:unregisterMsgListener(gt.MATCH_ROOM)
		gt.socketClient:unregisterMsgListener(gt.GUILD_INFO)
		gt.socketClient:unregisterMsgListener(gt.GUILD_MEMBER)

		gt.socketClient:unregisterMsgListener(gt.CREATE_GUILD)
		gt.socketClient:unregisterMsgListener(gt.APPLY_GUILD)
		gt.socketClient:unregisterMsgListener(gt.GUILD_LIST)
		gt.socketClient:unregisterMsgListener(gt.GUILD_MEMBER)
		gt.socketClient:unregisterMsgListener(gt.DISMISS_GUILD)
		gt.socketClient:unregisterMsgListener(gt.EXIT_GUILD)
		-- gt.socketClient:unregisterMsgListener(gt.DEL_MEMBER)
		gt.socketClient:unregisterMsgListener(gt.RENAME_GUILD)
		gt.socketClient:unregisterMsgListener(gt.GUILD_ROOM_PARAM)
		gt.socketClient:unregisterMsgListener(gt.RECV_GUILD_APPLY)
		gt.socketClient:unregisterMsgListener(gt.RECV_GUILD_REPLY)
		gt.socketClient:unregisterMsgListener(gt.GUILD_NULL)
		gt.socketClient:unregisterMsgListener(gt.GUILD_INVITE)
		gt.socketClient:unregisterMsgListener(gt.CREATE_ROOM)
		gt.socketClient:unregisterMsgListener(gt.JOIN_ROOM)
		gt.socketClient:unregisterMsgListener(gt.GUILD_INVITE_MEMBER)
		gt.socketClient:unregisterMsgListener(gt.GUILD_INVITE_LIST)

		self.pGuildTemplate:release()
		self.pRoomTemplate:release()
	end
end

function Union:update(dt)
	-- 刷新俱乐部房间
	if self.currentGuild then
		self.refreshTime = self.refreshTime + dt
		if self.refreshTime > 10 and self.pRooms:isVisible() then
			self:request(gt.MATCH_ROOM,self.currentGuild.id)
			self:request(gt.GUILD_INFO, self.currentGuild.id)
			self.refreshTime = 0
			self.btnFastJoin:setVisible(false)
		end
	end
end

function Union:initTopView()
	self.lblGuildId = gt.seekNodeByName(self.csbNode,"lblGuildId")
	self.lblGuildId:setVisible(false)

	self.lblUserScore = gt.seekNodeByName(self.csbNode,"lblUserScore")
	self.lblUserScore:setVisible(false)

	self.lblGuildIdStr = gt.seekNodeByName(self.csbNode,"lblGuildIdStr")
	self.lblGuildIdStr:setVisible(false)
	self.lblUserScoreStr = gt.seekNodeByName(self.csbNode,"lblUserScoreStr")
	self.lblUserScoreStr:setVisible(false)
end

-- 初始化俱乐部列表
function Union:initGuildListView()
	self.lstGuilds = gt.seekNodeByName(self.csbNode, "List_Guilds")
	
	--俱乐部列表高度 全屏适配
	local tableListSize = self.lstGuilds:getContentSize()
	tableListSize.height = tableListSize.height + (gt.winSize.height - 720)
	self.lstGuilds:setContentSize(tableListSize)
	
	self.pGuildTemplate = self.lstGuilds:getChildByName("Panel_Template")
	self.pGuildTemplate:retain()
	self.pRoomTabs = self.lstGuilds:getChildByName("Panel_Tabs")
	self.pRoomTabs:setTag(-1)
	self.pRoomTabs:retain()
	local function onNormal()
	 	gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		if self.currentGuild then
			self.btnNormal:setEnabled(false)
			self.btnMatch:setEnabled(true)
			self.pRooms:setVisible(true)
			self.pMatchView:setVisible(false)
			gt.dispatchEvent(gt.EventType.GUILD_REQUEST_INFO)
		end
	end

	local function onMatch()
	 	gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		if self.currentGuild then
			self.btnNormal:setEnabled(true)
			self.btnMatch:setEnabled(false)
			self.pRooms:setVisible(false)
			self.pMatchView:showGuildMatch(self.currentGuild.id)
		end
	end
	self.changeToMatchType = onMatch

	local function onRoomDismiss(sender)
		local roomId_ = sender:getTag()
		gt.log("~~~~~~~~~~~~~~~~~~")
		local function confirmDismiss()
			local msgToSend = {}
			msgToSend.cmd = gt.GUILD_DISMISS_ROOM
			msgToSend.room_id = roomId_
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.guild_id = self.guild_id

			gt.socketClient:sendMessage(msgToSend)
			
			self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function(sender)
	     		self:request(gt.MATCH_ROOM,self.currentGuild.id)
	     		self:request(gt.GUILD_INFO,self.currentGuild.id)
	     		end)))
		end

		local tips = string.format("您确定要直接解散房间%d?", roomId_)
		require("app/views/NoticeTips"):create("提示", tips, confirmDismiss, nil, false)
	end
	self.onRoomDismiss = onRoomDismiss


	local function onRoomInfo(sender)
		local tag = sender:getTag()
		gt.log("----tag:"..tag)
		local roomData = self.guildRoomsData[tag]
		if roomData then
			gt.soundEngine:playEffect(gt.clickBtnAudio, false)
			local tableSetting =  json.decode(roomData.kwargs)
			local view = require("app/views/RoomInfo"):create(tableSetting,nil,false)
			self:addChild(view) 
		else
			local tableSetting =  json.decode(self.guildKwargs) 
			local view = require("app/views/RoomInfo"):create(tableSetting,nil,false)
			self:addChild(view) 
		end
		
	end	
	self.onRoomInfo = onRoomInfo


	self.btnNormal = self.pRoomTabs:getChildByName("Btn_Normal")
	if self.btnNormal then
		self.btnNormal:addClickEventListener(onNormal)
	end
	self.btnMatch = self.pRoomTabs:getChildByName("Btn_Match")
	if self.btnMatch then
		self.btnMatch:addClickEventListener(onMatch)
	end

	self.lstGuilds:removeAllChildren()
	self.playerHeadMgr:detachAll()
end


-- 初始化俱乐部房间列表
function Union:initRoomsView()
	self.pRooms = gt.seekNodeByName(self.csbNode, "Panel_Rooms")
	self.pRooms:setVisible(false)
	
	self.pRoomTemplate = self.lstRooms:getChildByName("Panel_Template")
	self.pRoomTemplate:retain()
	self.lstRooms:removeAllChildren()
	self.playerHeadMgr:detachAll()
	
	
	--上排按钮
	local Node_Top_Right = self.csbNode:getChildByName("Node_Top_Right")
	
	--管理选项
	self.btnAdminSetting = Node_Top_Right:getChildByName("Btn_AdminSetting")
	gt.addBtnPressedListener(self.btnAdminSetting, function()
		if self.currentGuild then
			local view = require("app/views/Guild/GuildManUI"):create(self.currentGuild.id, handler(self, self.onTransGuild),true)
			self:addChild(view)
		end
	end)
	
	--比赛限制按钮
	self.btnLimit= Node_Top_Right:getChildByName("Btn_Limit")
	gt.addBtnPressedListener(self.btnLimit,function()
		if self.currentGuild then
			local view = require("app/views/Guild/MatchExtraPro"):create(self.currentGuild.id,self,true)
			self:addChild(view)
		end
	end)
	
	--玩法设置
	self.btnRoomSetting = Node_Top_Right:getChildByName("Btn_RoomSetting")
	gt.addBtnPressedListener(self.btnRoomSetting, function()
		if self.currentGuild then
			local view = require("app/views/CreateRoom"):create(self.currentGuild.id, 1)
			self:addChild(view)
		end
	end)

	--合伙人管理
	self.btnPartnerAdmin = Node_Top_Right:getChildByName("Btn_PartnerAdmin")
	gt.addBtnPressedListener(self.btnPartnerAdmin, function()
		if self.currentGuild then
			if self:getChildByName("guildPartnerView")== nil then
				local guildPartnerView = require("app/views/Guild/GuildPartner"):create(self.currentGuild.id, true)
				guildPartnerView:setName("guildPartnerView")
				self:addChild(guildPartnerView)

			end
		end
	end)

	--成员管理
	self.btnPartnerDetail = Node_Top_Right:getChildByName("Btn_PartnerMem")
	gt.addBtnPressedListener(self.btnPartnerDetail, function()
		if self.currentGuild then
			if self:getChildByName("GuildPartnerDetail")== nil then
				local userId = gt.playerData.uid
				local GuildPartnerDetailView = require("app/views/Guild/GuildPartnerDetail"):create(self.currentGuild.id , userId, true )
				GuildPartnerDetailView:setName("GuildPartnerDetail")
				self:addChild(GuildPartnerDetailView)

			end
		end
	end)

	--积分
	local btnScore = Node_Top_Right:getChildByName("Btn_Score")
	gt.addBtnPressedListener(btnScore, function()
		if gt.UnionManager:isGuildOwner(self.guild_id) then
			self.pScore:setVisible(not self.pScore:isVisible())
		else
			local view = require("app/views/Guild/GuildScoreGive"):create(self.guild_id,true)
			self:addChild(view)
		end
	end)

	--数据查看
	local btnGuildData =  Node_Top_Right:getChildByName("Btn_GuildData")
	gt.addBtnPressedListener(btnGuildData, function()
		-- local view = require("app/views/Guild/GuildRank"):create(self.guild_id)
		-- self:addChild(view)
		if self.currentGuild then
			self.pData:setVisible(not self.pData:isVisible())
		end
	end)

	--战绩查询
	local btnRecord = Node_Top_Right:getChildByName("Btn_Record")
	gt.addBtnPressedListener(btnRecord, function()
		if self.currentGuild then
			local view = require("app/views/Guild/MatchRecord"):create(self.currentGuild.id, true)
			self:addChild(view)
		end
	end)

	--设置
	local btnSetting = Node_Top_Right:getChildByName("Btn_Setting")
	gt.addBtnPressedListener(btnSetting, function()
		self.pSetting:setVisible(true)
		local hz = false
		if self.currentGuild and self.currentGuild.owner_id == gt.playerData.uid then
			hz = true
		end
		local Node_Top_Right = self.pSetting:getChildByName("Node_Top_Right")
		Node_Top_Right:getChildByName("Img_Bg_hz"):setVisible(hz)
--		Node_Top_Right:getChildByName("Btn_MergeGuild"):setVisible(hz)
		Node_Top_Right:getChildByName("Btn_Dismiss"):setVisible(hz)
		Node_Top_Right:getChildByName("Btn_Rename"):setVisible(hz)
		Node_Top_Right:getChildByName("Img_Bg"):setVisible(not hz)
		Node_Top_Right:getChildByName("Btn_Exit"):setVisible(not hz)
	end)

	--成员
	local btnMembers = Node_Top_Right:getChildByName("Btn_Members")
	gt.addBtnPressedListener(btnMembers, function()
		if self.currentGuild then
			-- self.pMember:setVisible(true)
			-- self:request(gt.GUILD_MEMBER, self.currentGuild.id, 0)
			local view = require("app/views/Guild/GuildMember"):create(self.currentGuild.id,true)
			self:addChild(view)
		end
	end)

	--默认隐藏按钮
	self.btnLimit:setVisible(false)
	self.btnPartnerAdmin:setVisible(false)
	self.btnPartnerDetail:setVisible(false)
	
	
	--下排按钮
	local Node_Bottom_Right = self.csbNode:getChildByName("Node_Bottom_Right")

	-- 合并公会
	self.btnMergeGuild = Node_Bottom_Right:getChildByName("Btn_MergeGuild")
	gt.addBtnPressedListener(self.btnMergeGuild, function()
		if self.currentGuild then		
			local view = require("app/views/Guild/UnionMergeGuild"):create(self.guild_id)--联盟id
			self:addChild(view)
		end
	end)
	
	--创建房间
	self.btnCreateRoom = Node_Bottom_Right:getChildByName("Btn_CreateRoom")
	gt.addBtnPressedListener(self.btnCreateRoom, function()
		if self.currentGuild then
			self:request(gt.CREATE_GUILD_ROOM, self.currentGuild.id, 1)
			gt.unionid = self.currentGuild.id
			gt.guildtype = 1
		end		
	end)
	
	--邀请
	self.btnInvite = Node_Bottom_Right:getChildByName("Btn_Invite")
	gt.addBtnPressedListener(self.btnInvite, function()
		if self.currentGuild then
			-- local view = require("app/views/Guild/GuildNumberPad"):create("guild_invite", self.currentGuild.id)
			local view = require("app/views/Guild/GuildNumberPad"):create("guild_invite_member", self.currentGuild.id)
			self:addChild(view)
		end
	end)

	-- 分享
	local shareBtn = Node_Bottom_Right:getChildByName("Btn_Share")
	gt.addBtnPressedListener(shareBtn, function()
		local title = "大联盟ID:"..self.currentGuild.id
		local guildName = gt.UnionManager:getGuild(self.currentGuild.id).name
		local description = "赶快加入【"..guildName.."】大联盟,大联盟会员私密局~"
		local url = gt.shareRoomWeb .. "&app_id=" .. gt.app_id .. "&roomid=" .."u_"..self.currentGuild.id.."_"..gt.playerData.uid
		gt.log("-------------test--------------title:"..title)
		gt.log("-------------test---------------des:"..description)
		gt.log("-------------test---------------url:"..url)
		extension.shareToURL(extension.SHARE_TYPE_SESSION, title, description, url)
	end)
	
	--快速加入
	self.btnFastJoin = Node_Bottom_Right:getChildByName("Btn_FastJoin")
	gt.addBtnPressedListener(self.btnFastJoin, function()
		local canJoinIndexs = {}
		for i,v in ipairs(self.guildRoomsData) do
			if v.emptyNum > 0 then
				table.insert(canJoinIndexs, i)
			end
		end
		gt.dump(canJoinIndexs)
		if #canJoinIndexs > 0 then
			local randomIndex = 1
			if math.random(1,100) > 50 then
				randomIndex = canJoinIndexs[math.random(1, #canJoinIndexs)]
			end
			self:joinRoom(self.guildRoomsData[randomIndex].id)
		else
			require("app/views/NoticeTips"):create("提示", "抱歉，暂时没有可以快速加入的房间。", nil, nil, true)
		end
	end)
	
	local actionTimeLine = cc.CSLoader:createTimeline("csd/texiao/kuaisujiaru.csb")
    self.csbNode:runAction(actionTimeLine)
    actionTimeLine:play("animation", true)
	
	local actionTimeLineBg = cc.CSLoader:createTimeline("csd/texiao/bjdh.csb")
    self.csbNode:runAction(actionTimeLineBg)
    actionTimeLineBg:play("animation", true)
end

function Union:onRcvGuildInviteList(msgTbl)
	gt.removeLoadingTips()
	
	local invite_list_data = msgTbl.invite_list
	if #invite_list_data > 0 then
		local view = require("app/views/Guild/GuildInvite"):create(invite_list_data)
		self:addChild(view)
	end
end

function Union:onRcvGuildInviteMember(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		require("app/views/NoticeTips"):create("提示", "邀请成功", nil, nil, true)
	elseif msgTbl.code == 1 then
		require("app/views/NoticeTips"):create("提示", "该玩家已经在大联盟", nil, nil, true)
	elseif msgTbl.code == 2 then
		require("app/views/NoticeTips"):create("提示", "您的大联盟已满员", nil, nil, true)
	elseif msgTbl.code == 3 then
		require("app/views/NoticeTips"):create("提示", "该玩家拥有大联盟数量超过限制", nil, nil, true)
	elseif msgTbl.code == 4 then
		require("app/views/NoticeTips"):create("提示", "该玩家已关闭邀请", nil, nil, false, nil, nil, true)
	elseif msgTbl.code == 5 then
		require("app/views/NoticeTips"):create("提示", "玩家不存在", nil, nil, true)
	elseif msgTbl.code == 6 then
		require("app/views/NoticeTips"):create("提示", "您没有权限进行该操作", nil, nil, true)
	else
		require("app/views/NoticeTips"):create("提示", "邀请失败"..msgTbl.code, nil, nil, true)
	end

end


function Union:onRcvGuildInfo(msgTbl)
	gt.removeLoadingTips()

	if msgTbl.user_score then
		gt.UnionManager:setMyScore(msgTbl.guild_id, msgTbl.user_score)
		gt.dispatchEvent(gt.EventType.GUILD_REFRESH_SCORE)
	end
	if msgTbl.guild_id then
		self.lblGuildId:setString(msgTbl.guild_id)
		self.lblGuildId:setVisible(true)
		self.lblGuildIdStr:setVisible(true)
	end

	gt.UnionManager:setGuildAdmin(msgTbl.guild_id, msgTbl.admin)
	gt.UnionManager:setGuildPartner(msgTbl.guild_id, msgTbl.partner)
	
	self:refreshGuildPartnerView()
end

function Union:initScoreView()		
	-- 积分模块
	self.pScore = gt.seekNodeByName(self.csbNode, "Panel_Score")
	if self.pScore then
		self.pScore:setVisible(false)
		self.pScore:addClickEventListener(function(sender)
			sender:setVisible(false)
		end)	
	end

	local Node_Top_Right = self.pScore:getChildByName("Node_Top_Right")

	local btnScoreCreate = Node_Top_Right:getChildByName("Btn_ScoreCreate")
	gt.addBtnPressedListener(btnScoreCreate, function()
		local view = require("app/views/Guild/GuildScoreCreate"):create(self.currentGuild.id, true)
		self:addChild(view)
		self.pScore:setVisible(false)
	end)
	self.btnScoreCreate = btnScoreCreate	

	local btnScoreGive = Node_Top_Right:getChildByName("Btn_ScoreGive")
	gt.addBtnPressedListener(btnScoreGive, function()
		local view = require("app/views/Guild/GuildScoreGive"):create(self.currentGuild.id, true)
		self:addChild(view)
		self.pScore:setVisible(false)
	end)
	self.btnScoreGive = btnScoreGive
	
	local btnScoreManage = Node_Top_Right:getChildByName("Btn_ScoreManage")
	gt.addBtnPressedListener(btnScoreManage, function()
		local view = require("app/views/Guild/UnionScoreManage"):create(self.currentGuild.id)
		self:addChild(view)
		self.pScore:setVisible(false)
	end)
	self.btnScoreCreate = btnScoreCreate	

end

function Union:initDataView()
		-- 数据模块
	self.pData = gt.seekNodeByName(self.csbNode, "Panel_Data")
	if self.pData then
		self.pData:setVisible(false)
		self.pData:addClickEventListener(function(sender)
			sender:setVisible(false)
		end)
	end

	local Node_Top_Right = self.pData:getChildByName("Node_Top_Right")

	local btnDataRank = Node_Top_Right:getChildByName("Btn_DataRank")
	gt.addBtnPressedListener(btnDataRank, function()
		
		local view = require("app/views/Guild/GuildRank"):create( self.currentGuild.id, true)
		self:addChild(view)

		self.pData:setVisible(false)
		
	end)
	self.btnDataRank = btnDataRank	

	local btnDataPerson = Node_Top_Right:getChildByName("Btn_DataPerson")
	gt.addBtnPressedListener(btnDataPerson, function()

		local user_id = gt.playerData.uid
		local view = require("app/views/Guild/GuildPersonInfo"):create( self.currentGuild.id, user_id, true)
		self:addChild(view)
		self.pData:setVisible(false)
	end)
	self.btnDataPerson = btnDataPerson
end

-- 初始化俱乐部设置
function Union:initSettingView()
	self.pSetting = gt.seekNodeByName(self.csbNode, "Panel_Setting")
	self.pSetting:setVisible(false)
	self.pSetting:addClickEventListener(function(sender)
		sender:setVisible(false)
	end)
	
	local Node_Top_Right = self.pSetting:getChildByName("Node_Top_Right")
	
	-- 解散公会
	local btnDismiss = Node_Top_Right:getChildByName("Btn_Dismiss")
	gt.addBtnPressedListener(btnDismiss, function()
		if self.currentGuild then
			require("app/views/NoticeTips"):create("提示", "是否确定解散大联盟", function()
				self:request(gt.DISMISS_GUILD, self.currentGuild.id)
			end, nil, false)
		end
		self.pSetting:setVisible(false)
	end)
	-- 俱乐部更名
	local btnRename = Node_Top_Right:getChildByName("Btn_Rename")
	gt.addBtnPressedListener(btnRename, function()
		if self.currentGuild then
			local view = require("app/views/Guild/GuildInput"):create("guild_rename", self.currentGuild.id)
			self:addChild(view)
		end
		self.pSetting:setVisible(false)
	end)
	-- 退出俱乐部
	local btnExit = Node_Top_Right:getChildByName("Btn_Exit")
	gt.addBtnPressedListener(btnExit, function()
		if self.currentGuild then
			require("app/views/NoticeTips"):create("提示", "是否确定退出大联盟，所有数据将清空包括剩余积分。", function()
				self:request(gt.EXIT_GUILD, self.currentGuild.id)
			end, nil, false, false, cc.c3b(182,132,205))
		end
		self.pSetting:setVisible(false)
	end)
end

-- 初始化比赛界面
function Union:initMatchView()
	local node = gt.seekNodeByName(self.csbNode, "Panel_Match")
	self.pMatchView = require("app/views/Guild/Match"):create(self)
	gt.seekNodeByName(self.csbNode, "Img_Background"):addChild(self.pMatchView)
	self.pMatchView:setVisible(false)
end

function Union:request(cmd, guild_id, tp)
	local msgToSend = {}
	msgToSend.cmd = cmd
	msgToSend.user_id = gt.playerData.uid
	msgToSend.open_id = gt.playerData.openid
	msgToSend.is_union = 1
	if guild_id then
		msgToSend.guild_id = guild_id
	end
	if tp ~= nil then
		msgToSend.tp = tp
	end
	gt.socketClient:sendMessage(msgToSend)
	gt.showLoadingTips("")
	self.refreshTime = 0
end

function Union:onRcvCreateGuild(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
        self.panelBtn:setVisible(false)
		self.Panel_JoinUnion:setVisible(false)
		self.UnionJoinBg:setVisible(false)
		self.FileNode_JoinAni:stopAllActions()
		self.FileNode_StayAni:stopAllActions()
		
		gt.soundEngine:playMusic("union", true)
		
		local tips = string.format("恭喜您创建成功，您已经是“%s”大联盟的盟主，您的大联盟ID是：%d\n邀请好友时，请让好友输入大联盟ID发起申请",
			msgTbl.name, msgTbl.guild_id)  
		require("app/views/NoticeTips"):create("提示", tips, nil, nil, true)
		
		local guild_info = {}
		guild_info.id = msgTbl.guild_id
		guild_info.owner_id = gt.playerData.uid
		guild_info.name = msgTbl.name
		guild_info.icon = msgTbl.icon
		guild_info.apply = 0
		guild_info.admin = false
		gt.UnionManager:addGuild(guild_info)

		self:refreshGuildListView()
		
		local view = require("app/views/Guild/UnionMergeGuild"):create(msgTbl.guild_id)--联盟id
		self:addChild(view)
			
	elseif msgTbl.code == 1 then
		require("app/views/NoticeTips"):create("提示", "大联盟名称重复", nil, nil, true)
	elseif msgTbl.code == 2 then
		require("app/views/NoticeTips"):create("提示", "大联盟数量超过限制", nil, nil, true)
	elseif msgTbl.code == 3 then
		require("app/views/NoticeTips"):create("提示", "大联盟数量超过限制", nil, nil, true)
	end
end

function Union:onRcvApplyGuild(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 3 then
		require("app/views/CommonTips"):create("您所输入的大联盟ID不存在，请输入正确大联盟ID", 2)
	elseif msgTbl.code == 4 then
		require("app/views/CommonTips"):create("您所输入的是俱乐部ID，请去俱乐部入口进行操作", 2)
	elseif msgTbl.code == 2 then
		require("app/views/CommonTips"):create("您已经加入该大联盟", 2)
	else
		require("app/views/CommonTips"):create("申请已发送", 2)
	end
end

function Union:onRcvGuildList(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == -1 then
		return
	end
	local guilds = {}
	for i, v in ipairs(msgTbl.guilds) do
		local guild_info = {}
		guild_info.id = v.id
		guild_info.owner_id = v.owner_id
		guild_info.icon = v.icon
		guild_info.name = v.name
		guild_info.apply = v.apply
		guild_info.admin = v.admin or false
		table.insert(guilds, guild_info)
	end
	gt.UnionManager:setGuildList(guilds)
    if #guilds == 0 then
        cc.UserDefault:getInstance():setIntegerForKey("unionid"..gt.playerData.uid, 0)
    end

    if self.isShowAnim > 0 then
		self:showJoinUi(msgTbl)
	end
	
	self:refreshGuildListView()
end


function Union:onRcvGuildMember(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == -1 then
		return
	end
	if msgTbl.tp == 1 then
		local guild_id = msgTbl.guild_id
		local members = {}
		for i, v in ipairs(msgTbl.players) do
			local member_info = {}
			member_info.id = v.id
			member_info.nick = v.nick
			member_info.icon = v.icon
			member_info.admin = v.admin
			table.insert(members, member_info)
		end
		
		gt.UnionManager:setGuildApplys(guild_id, members)
		local view = require("app/views/Guild/GuildApply"):create(guild_id,true)
		self.csbNode:addChild(view, 99)
	end
end

function Union:joinRoom(roomId_)
	gt.soundEngine:playEffect(gt.clickBtnAudio, false)
	local msgToSend = {}
	msgToSend.cmd = gt.JOIN_ROOM
	msgToSend.room_id = roomId_
	msgToSend.app_id = gt.app_id
	msgToSend.user_id = gt.playerData.uid
	msgToSend.ver = gt.version
	msgToSend.dev_id = gt.getDeviceId()
	gt.socketClient:sendMessage(msgToSend)

	if self.currentGuild then
		gt.unionid = self.currentGuild.id
		gt.guildtype = 1
	end
	gt.showLoadingTips(gt.getLocationString("LTKey_0006"))
end

function Union:showUnionBtns()
	self.panelBtn:setVisible(true)

	self.btnCreateGuild:setVisible(false)
	self.btnJoinGuild:setVisible(false)

	local scaleTime = 1.25
	local delay = cc.DelayTime:create(scaleTime)
	local lightNode = gt.seekNodeByName(self.panelBtn, "FileNode_1")
    if lightNode then
        lightNode:setVisible(false)
        lightNode:runAction(cc.Sequence:create(delay, cc.Show:create()))
    end
	local unionBg = gt.seekNodeByName(self.panelBtn, "Union_Bg")
	if unionBg then
		unionBg:setScale(1.5)
		unionBg:stopAllActions()
		unionBg:runAction(cc.ScaleTo:create(scaleTime, 1))
	end
	if self.btnCreateGuild then
		local move1 = cc.MoveBy:create(0.2, cc.p(-500, 0))
		local move2 = cc.EaseSineInOut:create(cc.MoveBy:create(0.5, cc.p(500, 0)))
		self.btnCreateGuild:stopAllActions()
		self.btnCreateGuild:runAction(cc.Sequence:create(delay, move1,cc.Show:create(),move2))
	end
	if self.btnJoinGuild then
		local move1 = cc.MoveBy:create(0.2, cc.p(500, 0))
		local move2 = cc.EaseSineInOut:create(cc.MoveBy:create(0.5, cc.p(-500, 0)))
		self.btnJoinGuild:stopAllActions()
		self.btnJoinGuild:runAction(cc.Sequence:create(delay, move1,cc.Show:create(),move2))
	end
	
	local actionTimeLine = cc.CSLoader:createTimeline("csd/texiao/UnionLightEffect.csb")
    self.csbNode:runAction(actionTimeLine)
    actionTimeLine:play("animation_frame",true)
end

function Union:onRcvDismissGuild(msgTbl)
	gt.removeLoadingTips()
	local guild_id = msgTbl.guild_id
	if self.currentGuild.id == guild_id then
		self.currentGuild = nil
	end
	gt.UnionManager:delGuild(guild_id)
    local guilds = gt.UnionManager:getGuildList()
    if #guilds == 0 then
        self:removeFromParent()
		gt.soundEngine:playMusic("bgm1", true)
	else
		self:refreshGuildListView()
    end
end

function Union:onRcvExitGuild(msgTbl)
	gt.removeLoadingTips()
	local guild_id = msgTbl.guild_id
	gt.UnionManager:delGuild(guild_id)
	if self.currentGuild.id == guild_id then
		self.currentGuild = nil
	end
    local guilds = gt.UnionManager:getGuildList()
    if #guilds == 0 then
        self:removeFromParent()
		gt.soundEngine:playMusic("bgm1", true)
    else
		self:refreshGuildListView()
    end
end

function Union:onRcvRenameGuild(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		require("app/views/NoticeTips"):create("提示", "改名成功", nil, nil, true)
		gt.UnionManager:renameGuild(msgTbl.guild_id, msgTbl.name)
		local children = self.lstGuilds:getChildren()
		for i, child in ipairs(children) do
			if msgTbl.guild_id == child:getTag() then
				child:getChildByName("Label_Name"):setString(msgTbl.name)
				break
			end
		end
	else
		require("app/views/NoticeTips"):create("提示", "大联盟名称重复", nil, nil, true)
	end
end

function Union:onRcvGuildRoomParam(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		require("app/views/NoticeTips"):create("提示", "设置成功", nil, nil, true)
	else
		require("app/views/NoticeTips"):create("提示", "设置失败", nil, nil, true)
	end
end

function Union:onRcvRecvGuildApply(msgTbl)
	local member_info = {}
	member_info.id = msgTbl.id
	member_info.nick = msgTbl.nick
	member_info.icon = msgTbl.icon
	gt.UnionManager:addGuildApply(msgTbl.guild_id, member_info)

	local children = self.lstGuilds:getChildren()
	for i, child in ipairs(children) do
		if msgTbl.guild_id == child:getTag() then
			child:getChildByName("Img_Tip"):setVisible(true)
			break
		end
	end
end

function Union:onRcvRecvGuildReply(msgTbl)
	local guild_info = {}
	guild_info.id = msgTbl.guild_id
	guild_info.owner_id = msgTbl.owner_id
	guild_info.name = msgTbl.name
	guild_info.icon = msgTbl.icon
	guild_info.apply = 0
	gt.UnionManager:addGuild(guild_info)
    self.panelBtn:setVisible(false)
	self:refreshGuildListView()
end

function Union:onRcvGuildNull(msgTbl)
	gt.removeLoadingTips()
	require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "您已被移出该大联盟", nil, nil, true)
	local guild_id = msgTbl.guild_id
	gt.UnionManager:delGuild(guild_id)
	self.currentGuild = nil
	self:refreshGuildListView()
	self:removeChildByTag(9999)
end

function Union:onRcvGuildInvite(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		require("app/views/NoticeTips"):create("提示", "邀请成功", nil, nil, true)
	elseif msgTbl.code == 1 then
		require("app/views/NoticeTips"):create("提示", "您的大联盟已满员", nil, nil, true)
	elseif msgTbl.code == 2 then
		require("app/views/NoticeTips"):create("提示", "该玩家拥有大联盟数量超过限制", nil, nil, true)
	elseif msgTbl.code == 3 then
		require("app/views/NoticeTips"):create("提示", "该玩家不存在", nil, nil, true)
	end
end

function Union:refreshGuildPartnerView()
	self.btnPartnerAdmin:setVisible(false)
	self.btnPartnerDetail:setVisible(false)

	local guild = gt.UnionManager:getGuild(self.currentGuild.id)
	if guild then
		if guild.owner_id == gt.playerData.uid or guild.admin then  -- 会长 或者 管理员
			self.btnPartnerAdmin:setVisible(true)
			self.btnInvite:setVisible(true)	
		elseif guild.partner then
			self.btnPartnerDetail:setVisible(true)	
			self.btnInvite:setVisible(true)	
		end
		self.btnMergeGuild:setVisible(guild.owner_id == gt.playerData.uid)	
	end

end

function Union:refreshGuildListView()
	local function onGuildChoose(sender)
		local guild_id = sender:getTag()
        cc.UserDefault:getInstance():setIntegerForKey("unionid"..gt.playerData.uid, guild_id)
		
		if sender:getChildByName("Img_Tip"):isVisible() then
			local guild = gt.UnionManager:getGuild(guild_id)
			if guild and guild.admin then  -- 管理员
				-- 显示申请列表
				local guild_applys = gt.UnionManager:getGuildApplys(guild_id)
				if guild_applys == nil then
					 -- 请求申请列表
					if guild.apply == 1 then
						self:request(gt.GUILD_MEMBER, guild_id, 1)
					end
				elseif #guild_applys > 0 then
					local view = require("app/views/Guild/GuildApply"):create(guild_id,true)
					self.csbNode:addChild(view, 99)
				end
				sender:getChildByName("Img_Tip"):setVisible(false)
			end
			sender:getChildByName("Img_Tip"):setVisible(false)
		end

		if self.currentGuild and self.currentGuild.id == guild_id then
			return
		end
		local children = self.lstGuilds:getChildren()
		for i, v in ipairs(children) do
			if v == sender then
				v:getChildByName("Img_Bg"):loadTexture("image/guild/NewBigUnion/unionItemSelected.png")
				self.itemParticle:removeFromParent()
                v:addChild(self.itemParticle)
				v:getChildByName("Label_Name"):setColor(cc.c3b(109,59,26))

			elseif v:getTag() > 0 then
				v:getChildByName("Img_Bg"):loadTexture("image/guild/NewBigUnion/unionItemNotSelected.png")
				v:getChildByName("Label_Name"):setColor(cc.c3b(255,255,255))
			end
		end

		self.btnAdminSetting:setVisible(false)
		self.btnRoomSetting:setVisible(false)
		self.btnInvite:setVisible(false)
		local guild = gt.UnionManager:getGuild(guild_id)
		if guild and guild.owner_id == gt.playerData.uid then  -- 会长
			self.btnAdminSetting:setVisible(true)
			self.btnRoomSetting:setVisible(true)
			self.btnInvite:setVisible(true)
		end

		if self.lstGuilds:getChildByName("Panel_Tabs") then
			self.lstGuilds:removeChildByName("Panel_Tabs")
		end
		local index = self.lstGuilds:getIndex(sender)
		-- self.lstGuilds:insertCustomItem(self.pRoomTabs, index+1)
		self.btnNormal:setEnabled(false)
		self.btnMatch:setEnabled(true)
		self.pRooms:setVisible(true)
		-- self.pMatchView:setVisible(false)

		-- 请求俱乐部房间
		self:request(gt.MATCH_ROOM, guild_id)
		self:request(gt.GUILD_INFO, guild_id)
		self.currentGuild = guild
		self.guild_id = guild_id
		self:refreshGuildPartnerView()
	end

	local lastGuildId = cc.UserDefault:getInstance():getIntegerForKey("unionid"..gt.playerData.uid, 0)
	local lastGuildType = cc.UserDefault:getInstance():getIntegerForKey("uniontype", 0)
	if not gt.UnionManager:getGuild(lastGuildId) then
		lastGuildId = 0
		lastGuildType = 0
	end

	self.lstGuilds:removeAllChildren()
	self.playerHeadMgr:detachAll()
	local guilds = gt.UnionManager:getGuildList()
	for i, guild in ipairs(guilds) do
		local pItem = self.pGuildTemplate:clone()
		pItem:getChildByName("Label_Name"):setString(gt.checkName(guild.name, 8))
		pItem:getChildByName("Label_ID"):setString(tostring(guild.id))
		local headImg = pItem:getChildByName("Img_Head")
		self.playerHeadMgr:attach(headImg, guild.owner_id, guild.icon)
		pItem:setTag(guild.id)
		pItem:addClickEventListener(onGuildChoose)
		if guild.apply == 1 then
			pItem:getChildByName("Img_Tip"):setVisible(true)
		end
		self.lstGuilds:pushBackCustomItem(pItem)

		if self.currentGuild then		-- 选中的俱乐部
			if self.currentGuild.id == guild.id then
				onGuildChoose(pItem)
			end
		else		
			if lastGuildId == 0 then  -- 没有选中的俱乐部，则默认选择第一个
				if i == 1 then
					onGuildChoose(pItem)
				end
			else
				if lastGuildId == guild.id then		-- 上次记住的俱乐部
					onGuildChoose(pItem)
				end
			end
		end
	end

	if #guilds == 0 then
		self.lstRooms:removeAllChildren()
		self.playerHeadMgr:detachAll()
	else
		-- if lastGuildType == 1 and self.lstGuilds:getChildByName("Panel_Tabs") then 
		-- 	self:changeToMatchType()
		-- end
		if self.currentGuild then
			self:request(gt.MATCH_ROOM,self.currentGuild.id)
			self:request(gt.GUILD_INFO,self.currentGuild.id)
		end
	end
end

function Union:onTransGuild(guild_id, owner_id)
	if self.currentGuild and guild_id == self.currentGuild.id then
		gt.UnionManager:setGuildOwner(guild_id, owner_id)
		self:sendRefreshGuild(guild_id)
	end
end

function Union:sendRefreshGuild(guild_id)
	self:request(gt.GUILD_INFO, guild_id)
	self:request(gt.MATCH_ROOM, guild_id)
	self.btnAdminSetting:setVisible(false)
	self.btnRoomSetting:setVisible(false)
	self.btnInvite:setVisible(false)
	self.btnPartnerDetail:setVisible(false)
	self.btnPartnerAdmin:setVisible(false)
end

function Union:onRcvCreateRoom(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		self:sendRefreshGuild(self.currentGuild.id)
		require("app/views/CommonTips"):create("创建房间成功", 2.5)
	else
		-- code: 1:未登录 2:服务器维护 3:账号校验失败 4:房卡不足 5:创建数量过多 6:参数错误
		if msgTbl.code == 1 or msgTbl.code == 3 then
			-- 未登录
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0053"), nil, nil, true)
		elseif msgTbl.code == 2 then
			-- 服务器维护中
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0054"), nil, nil, true)
		elseif msgTbl.code == 4 then
			-- 房卡不足
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0049"), nil, nil, true)
		elseif msgTbl.code == 5 then
			-- 创建过多
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0052"), nil, nil, true)
		elseif msgTbl.code == 6 then
			-- 参数错误
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0050"), nil, nil, true)
		elseif msgTbl.code == 7 then
			-- 参数错误
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "您没有在该大联盟创建房间的权限，需要管理员将房间开启。", nil, nil, true)
		elseif msgTbl.code == 8 then
			-- 参数错误
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "您报名的即时赛场即将开赛，您需要先退赛才能创建新的房间", nil, nil, true)
		elseif msgTbl.code == 9 then
            -- 参数错误
            require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0069"), nil, nil, true)
		end
	end
end


function Union:onRcvJoinRoom(msgTbl)
	if msgTbl.code ~= 0 then
		-- 进入房间失败
		gt.removeLoadingTips()
		-- 1：未登录 2：服务器维护中 3：房卡不足 4：人数已满 5：房间不存在 6：中途不能加入
		local errorMsg = ""
		if msgTbl.code == 1 then
			errorMsg = gt.getLocationString("LTKey_0058")
		elseif msgTbl.code == 2 then
			errorMsg = gt.getLocationString("LTKey_0054")
		elseif msgTbl.code == 3 then
			errorMsg = gt.getLocationString("LTKey_0049")
		elseif msgTbl.code == 4 then
			errorMsg = gt.getLocationString("LTKey_0018")
		elseif msgTbl.code == 5 then
			errorMsg = gt.getLocationString("LTKey_0015")
        elseif msgTbl.code == 6 then
			errorMsg = gt.getLocationString("LTKey_0057")
		elseif msgTbl.code == 7 then
			errorMsg = gt.getLocationString("LTKey_0065")
		elseif msgTbl.code == 8 then
			errorMsg = gt.getLocationString("LTKey_0067")
		elseif msgTbl.code == 9 then
			errorMsg = gt.getLocationString("LTKey_0069")
		end
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), errorMsg, nil, nil, true)
	end
end

return Union
