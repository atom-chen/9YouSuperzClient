-- 俱乐部界面

local gt = cc.exports.gt

local Guild = class("Guild", function()
	return gt.createMaskLayer()
end)

function Guild:ctor(joinUnionFun)
	self:registerScriptHandler(handler(self, self.onNodeEvent))
	gt.log("-----openUI:Guild")
	local csbNode = cc.CSLoader:createNode("csd/Guild/Guild.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
    --ccui.Helper:doLayout(csbNode)
	self:addChild(csbNode)
	self.csbNode = csbNode
	
	self:setName("guildNode")
	self.joinUnionFun = joinUnionFun

	self:initUI()
	-- 初始化视图
	self:initGuildListView()
	self:initRoomsView()
	self:initSettingView()
	self:initMemberView()
	self:initMatchView()

	gt.socketClient:registerMsgListener(gt.CREATE_GUILD, self, self.onRcvCreateGuild)
	gt.socketClient:registerMsgListener(gt.APPLY_GUILD, self, self.onRcvApplyGuild)
	gt.socketClient:registerMsgListener(gt.GUILD_LIST, self, self.onRcvGuildList)
	gt.socketClient:registerMsgListener(gt.GUILD_MEMBER, self, self.onRcvGuildMember)
	gt.socketClient:registerMsgListener(gt.GUILD_INFO, self, self.onRcvGuildInfo)
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
	gt.registerEventListener(gt.EventType.GUILD_MEMBER_MSG, self, self.regisMsgMember)
    gt.registerEventListener(gt.EventType.GUILD_SHARE_SET, self, self.regisShareSet)
end


function Guild:initUI()
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
	gt.guildManager = require("app/views/Guild/GuildManager"):create()

	local btnClose = gt.seekNodeByName(self.csbNode, "Btn_Close")
	gt.addBtnPressedListener(btnClose, function()
		self:close()
	end)
	
	local btnClose1 = gt.seekNodeByName(self.csbNode, "btnClose")
	gt.addBtnPressedListener(btnClose1, function()
		self:close()
	end)


	-- 头像下载管理器
	local playerHeadMgr = require("app/PlayerHeadManager"):create("Guild")
	self.csbNode:addChild(playerHeadMgr)
	self.playerHeadMgr = playerHeadMgr

    self.itemParticle = gt.seekNodeByName(self.csbNode,"itemParticle")
    self.itemParticle:retain()
    self.itemParticle:removeFromParent()

    self.panelBtn = gt.seekNodeByName(self.csbNode, "Panel_Btn")
    self.panelBtn:setVisible(false)
    local btnCreateGuild = gt.seekNodeByName(self.panelBtn, "Btn_CreateGuild")
    gt.addBtnPressedListener(btnCreateGuild, function()
		self:createGuild()
	end)
    local btnJoinGuild = gt.seekNodeByName(self.panelBtn, "Btn_JoinGuild")
    gt.addBtnPressedListener(btnJoinGuild, function()
		self:joinGuild()
	end)


	local btnCreate = gt.seekNodeByName(self.csbNode,"Btn_Create")
	gt.addBtnPressedListener(btnCreate, function()
		self:createGuild()
	end)

	local btnJoin = gt.seekNodeByName(self.csbNode,"Btn_Join")
	gt.addBtnPressedListener(btnJoin, function()
		self:joinGuild()
	end)
	
	local function enterRoom(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)

		local roomId = sender:getTag()
		local msgToSend = {}
		msgToSend.cmd = gt.JOIN_ROOM
		msgToSend.room_id = roomId
		msgToSend.app_id = gt.app_id
		msgToSend.user_id = gt.playerData.uid
		msgToSend.ver = gt.version
		msgToSend.dev_id = gt.getDeviceId()
		gt.socketClient:sendMessage(msgToSend)

		if self.currentGuild then
			gt.guildid = self.currentGuild.id
			gt.guildtype = 0
		end
		gt.showLoadingTips(gt.getLocationString("LTKey_0006"))
	end
	self.enterRoom = enterRoom

	local function createRoom()
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		
		if self.currentGuild then
			self:request(gt.CREATE_GUILD_ROOM, self.currentGuild.id)
			gt.guildid = self.currentGuild.id
			gt.guildtype = 0
		end		
	end
	self.createRoom = createRoom
end

function Guild:createGuild()
    local guilds = gt.guildManager:getGuildList()
    if #guilds >= 10 then
		require("app/views/NoticeTips"):create("提示", "您创建和加入的俱乐部数量超过限制", nil, nil, false)
		return
	end
	local view = require("app/views/Guild/GuildInput"):create("guild_create")
    self:addChild(view)
end

function Guild:joinGuild()
    local guilds = gt.guildManager:getGuildList()
    if #guilds >= 10 then
		require("app/views/NoticeTips"):create("提示", "您创建和加入的俱乐部数量超过限制", nil, nil, false)
		return
	end
	local view = require("app/views/Guild/GuildNumberPad"):create("guild_apply")
    self:addChild(view)
end

function Guild:regisShareSet(eventType, is_share)
	self.is_share = is_share
end

function Guild:regisMsgMember()
	gt.socketClient:registerMsgListener(gt.GUILD_MEMBER, self, self.onRcvGuildMember)
end

function Guild:regisMsgInvite()
	-- gt.socketClient:registerMsgListener(gt.GUILD_INVITE, self, self.onRcvGuildInvite)
	gt.socketClient:registerMsgListener(gt.GUILD_INVITE_MEMBER, self, self.onRcvGuildInviteMember)
end

function Guild:onNodeEvent(eventName)
	if "enter" == eventName then
        gt.soundEngine:playMusic("guild", true)
		self:request(gt.GUILD_LIST)
		-- self:request(gt.GUILD_INVITE_LIST)
		self.scheduleHandler = gt.scheduler:scheduleScriptFunc(handler(self, self.update), 1, false)
	elseif "exit" == eventName then

		if self.scheduleHandler then
			gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
			self.scheduleHandler = 0
		end

		gt.socketClient:unregisterMsgListener(gt.CREATE_GUILD)
		gt.socketClient:unregisterMsgListener(gt.APPLY_GUILD)
		gt.socketClient:unregisterMsgListener(gt.GUILD_LIST)
		gt.socketClient:unregisterMsgListener(gt.GUILD_MEMBER)
		gt.socketClient:unregisterMsgListener(gt.GUILD_INFO)
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
		self.pMemberTemplate:release()
	end
end

function Guild:update(dt)
	-- 刷新俱乐部房间
	if self.currentGuild then
		self.refreshTime = self.refreshTime + dt
		if self.refreshTime > 10 and self.pRooms:isVisible() then
			local msgToSend = {}
			msgToSend.cmd = gt.GUILD_INFO
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.guild_id = self.currentGuild.id
			gt.socketClient:sendMessage(msgToSend)
			self.refreshTime = 0
		end
	end
end


-- 初始化俱乐部列表
function Guild:initGuildListView()
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
	 	-- gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		self.effectNormal:setVisible(true)
		self.effectMatch:setVisible(false)
		if self.currentGuild then
			self.btnNormal:setEnabled(false)
			self.btnMatch:setEnabled(true)
			self.pRooms:setVisible(true)
			self.Node_Top_Right:setVisible(true)
			self.Node_Bottom_Right:setVisible(true)
			self.pMatchView:setVisible(false)
		end
	end

	local function onMatch()
	 	-- gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		self.effectNormal:setVisible(false)
		self.effectMatch:setVisible(true)
		if self.currentGuild then
			self.btnNormal:setEnabled(true)
			self.btnMatch:setEnabled(false)
			self.pRooms:setVisible(false)
			self.Node_Top_Right:setVisible(false)
			self.Node_Bottom_Right:setVisible(false)
			self.pMatchView:showGuildMatch(self.currentGuild.id)
		end
	end
	self.changeToMatchType = onMatch

	self.btnNormal = self.pRoomTabs:getChildByName("Btn_Normal")
	if self.btnNormal then
		self.btnNormal:addClickEventListener(onNormal)
	end
	self.btnMatch = self.pRoomTabs:getChildByName("Btn_Match")
	if self.btnMatch then
		self.btnMatch:addClickEventListener(onMatch)
	end
	self.effectNormal = self.btnNormal:getChildByName("nodeUIEffect")
	self.effectMatch = self.btnMatch:getChildByName("nodeUIEffect")
	-- self.effectNormal:setVisible(false)
	-- self.effectMatch:setVisible(false)

	self:playUIEffect()

	self.lstGuilds:removeAllChildren()
	self.playerHeadMgr:detachAll()
end


function Guild:playUIEffect()
	local actionTimeLine = cc.CSLoader:createTimeline("csd/texiao/bisaichang.csb")
    self.csbNode:runAction(actionTimeLine)
    actionTimeLine:play("animation_matchItem",true)

    local actionTimeLineGuild = cc.CSLoader:createTimeline("csd/texiao/julebufang.csb")
    self.csbNode:runAction(actionTimeLineGuild)
    actionTimeLineGuild:play("animation_Itemguild",true)
end


-- 初始化俱乐部房间列表
function Guild:initRoomsView()
	self.pRooms = gt.seekNodeByName(self.csbNode, "Panel_Rooms")
	self.pRooms:setVisible(false)
	self.lstRooms = self.pRooms:getChildByName("List_Rooms")
	self.pRoomTemplate = self.lstRooms:getChildByName("Panel_Template")
	self.pRoomTemplate:retain()
	self.lstRooms:removeAllChildren()
	self.playerHeadMgr:detachAll()
	
	--上排按钮
	self.Node_Top_Right = self.csbNode:getChildByName("Node_Top_Right")
	self.Node_Top_Right:setVisible(false)
	
	--管理选项
	local btnAdminSetting = self.Node_Top_Right:getChildByName("Btn_AdminSetting")
	gt.addBtnPressedListener(btnAdminSetting, function()
		if self.currentGuild then
			local view = require("app/views/Guild/GuildManUI"):create(self.currentGuild.id, handler(self, self.onTransGuild))
			self:addChild(view)
		end
	end)
	self.btnAdminSetting = btnAdminSetting

	--玩法设置
	local btnRoomSetting = self.Node_Top_Right:getChildByName("Btn_RoomSetting")
	gt.addBtnPressedListener(btnRoomSetting, function()
		if self.currentGuild then
			local view = require("app/views/CreateRoom"):create(self.currentGuild.id, 0)
			self:addChild(view)
		end
	end)
	self.btnRoomSetting = btnRoomSetting
	
	--合伙人管理
	local btnPartnerAdmin = self.Node_Top_Right:getChildByName("Btn_PartnerAdmin")
	gt.addBtnPressedListener(btnPartnerAdmin, function()
		if self.currentGuild then
			if self:getChildByName("guildPartnerView")== nil then
				local guildPartnerView = require("app/views/Guild/GuildPartner"):create(self.currentGuild.id)
				guildPartnerView:setName("guildPartnerView")
				self:addChild(guildPartnerView)
			end
		end
	end)
	self.btnPartnerAdmin = btnPartnerAdmin
	
	--我的成员
	local btnPartnerDetail = self.Node_Top_Right:getChildByName("Btn_PartnerMem")
	gt.addBtnPressedListener(btnPartnerDetail, function()
		if self.currentGuild then
			if self:getChildByName("GuildPartnerDetail")== nil then
				local userId = gt.playerData.uid
				local GuildPartnerDetailView = require("app/views/Guild/GuildPartnerDetail"):create(self.currentGuild.id , userId )
				GuildPartnerDetailView:setName("GuildPartnerDetail")
				self:addChild(GuildPartnerDetailView)
			end
		end
	end)
	self.btnPartnerDetail = btnPartnerDetail

	-- 战绩
	local recordBtn = self.Node_Top_Right:getChildByName("Btn_Record")
	gt.addBtnPressedListener(recordBtn, function()
		-- local historyRecord = require("app/views/HistoryRecord"):create(gt.playerData.uid, gt.guildid, 1)
		-- self:addChild(historyRecord)
		local view = require("app/views/Guild/MatchRecord"):create(self.currentGuild.id,false,true)
		self:addChild(view)
	end)
	
	--设置
	local btnSetting = self.Node_Top_Right:getChildByName("Btn_Setting")
	gt.addBtnPressedListener(btnSetting, function()
		self.pSetting:setVisible(true)
		local hz = false
		if self.currentGuild and self.currentGuild.owner_id == gt.playerData.uid then
			hz = true
		end
		local Node_Top_Right = self.pSetting:getChildByName("Node_Top_Right")
		Node_Top_Right:getChildByName("Btn_Dismiss"):setVisible(hz)
		Node_Top_Right:getChildByName("Btn_Rename"):setVisible(hz)
		Node_Top_Right:getChildByName("Btn_Exit"):setVisible(not hz)
		Node_Top_Right:getChildByName("Img_Bg_hz"):setVisible(hz)
		Node_Top_Right:getChildByName("Img_Bg"):setVisible(not hz)
	end)
	
	--成员
	local btnMembers = self.Node_Top_Right:getChildByName("Btn_Members")
	gt.addBtnPressedListener(btnMembers, function()
		if self.currentGuild then
			-- self.pMember:setVisible(true)
			-- self:request(gt.GUILD_MEMBER, self.currentGuild.id, 0)
			local view = require("app/views/Guild/GuildMember"):create(self.currentGuild.id)
			self:addChild(view)
		end
	end)

	--消息
	local btnInfo = self.Node_Top_Right:getChildByName("Btn_Info")
	gt.addBtnPressedListener(btnInfo, function()
		if self.currentGuild then
			local view = require("app/views/Guild/GuildNotice"):create(self.currentGuild.id)
			view:setTag(9999)
			self:addChild(view)
		end
	end)

	--默认隐藏
	self.btnPartnerAdmin:setVisible(false)
	self.btnPartnerDetail:setVisible(false)


	--下排按钮
	self.Node_Bottom_Right = self.csbNode:getChildByName("Node_Bottom_Right")
	self.Node_Bottom_Right:setVisible(false)

	--升级联盟
	self.btnUpgradeUnion = self.Node_Bottom_Right:getChildByName("Btn_UpgradeUnion")
	gt.addBtnPressedListener(self.btnUpgradeUnion, function()
		if self.currentGuild then
			local view = require("app/views/Guild/GuildUpgradeUnion"):create(self.currentGuild.id, self.cost, self.activeTime,self.joinUnionFun)
			self:addChild(view)
		end
	end)
	
	--邀请
	local btnInvite = self.Node_Bottom_Right:getChildByName("Btn_Invite")
	gt.addBtnPressedListener(btnInvite, function()
		if self.currentGuild then
			-- local view = require("app/views/Guild/GuildNumberPad"):create("guild_invite", self.currentGuild.id)
			local view = require("app/views/Guild/GuildNumberPad"):create("guild_invite_member", self.currentGuild.id)
			self:addChild(view)
		end
	end)
	self.btnInvite = btnInvite
	
	--创建房间
	local btnCreateRoom = self.Node_Bottom_Right:getChildByName("Btn_CreateRoom")
	gt.addBtnPressedListener(btnCreateRoom, function()
		if self.currentGuild then
			self:request(gt.CREATE_GUILD_ROOM, self.currentGuild.id, 0)
			gt.guildid = self.currentGuild.id
			gt.guildtype = 0
		end
	end)
	
	-- 分享 拉人
	local shareBtn = self.Node_Bottom_Right:getChildByName("Btn_Share")
	gt.addBtnPressedListener(shareBtn, function()
		if self.is_share and 1 == self.is_share then
			local title = "俱乐部ID:"..self.currentGuild.id
			local guildName = gt.guildManager:getGuild(self.currentGuild.id).name
			local description = "赶快加入【"..guildName.."】俱乐部,俱乐部会员私密局~"
			local url = gt.shareRoomWeb .. "&app_id=" .. gt.app_id .. "&roomid=" .."g_"..self.currentGuild.id.."_"..gt.playerData.uid
			gt.log("-------------test--------------title:"..title)
			gt.log("-------------test---------------des:"..description)
			gt.log("-------------test---------------url:"..url)
			extension.shareToURL(extension.SHARE_TYPE_SESSION, title, description, url)
		else
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "操作失败，管理员已设置禁止分享拉人", nil, nil, true)
		end
	end)
end

-- 初始化俱乐部设置
function Guild:initSettingView()
	self.pSetting = gt.seekNodeByName(self.csbNode, "Panel_Setting")
	if self.pSetting then
		self.pSetting:setVisible(false)
		self.pSetting:addClickEventListener(function(sender)
			sender:setVisible(false)
		end)
	end

	local Node_Top_Right = self.pSetting:getChildByName("Node_Top_Right")
	
	-- 解散俱乐部
	local btnDismiss = Node_Top_Right:getChildByName("Btn_Dismiss")
	gt.addBtnPressedListener(btnDismiss, function()
		if self.currentGuild then
			require("app/views/NoticeTips"):create("提示", "是否确定解散俱乐部", function()
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
			require("app/views/NoticeTips"):create("提示", "是否确定退出俱乐部，所有数据将清空包括剩余积分。", function()
				self:request(gt.EXIT_GUILD, self.currentGuild.id)
			end, nil, false, false, cc.c3b(182,132,205))
		end
		self.pSetting:setVisible(false)
	end)
end

-- 初始化俱乐部成员列表
function Guild:initMemberView()
	self.pMember = gt.seekNodeByName(self.csbNode, "Panel_Members")
	if self.pMember then
		self.pMember:setVisible(false)
		self.pMember:addClickEventListener(function(sender)
			sender:setVisible(false)
		end)
		self.lstMembers = gt.seekNodeByName(self.pMember, "List_Members")
		self.pMemberTemplate = self.lstMembers:getChildByName("Panel_Template")
		self.pMemberTemplate:retain()
		self.lstMembers:removeAllChildren()

		local btnDel = gt.seekNodeByName(self.pMember, "Btn_Del")
		if btnDel then
			btnDel:addClickEventListener(function()
				local children = self.lstMembers:getChildren()
				for i, child in ipairs(children) do
					if child:getTag() == 0 then
						child:getChildByName("Btn_Delete"):setVisible(true)
					end
				end
			end)
		end

		local btnSearch = gt.seekNodeByName(self.pMember, "Btn_Search")
		if btnSearch then
			btnSearch:addClickEventListener(function()
				local view = require("app/views/Guild/GuildNumberPad"):create("search_user", 0, 0, handler(self, self.searchUser))
				self:addChild(view)
			end)
		end
	end

end

-- 初始化比赛界面
function Guild:initMatchView()
	local node = gt.seekNodeByName(self.csbNode, "Panel_Match")
	self.pMatchView = require("app/views/Guild/Match"):create(self)
	gt.seekNodeByName(self.csbNode, "Panel_Left"):addChild(self.pMatchView)
	self.pMatchView:setVisible(false)
end

function Guild:request(cmd, guild_id, tp)
	local msgToSend = {}
	msgToSend.cmd = cmd
	msgToSend.user_id = gt.playerData.uid
	msgToSend.open_id = gt.playerData.openid
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

function Guild:onRcvCreateGuild(msgTbl)
	gt.removeLoadingTips()
	
	if 0 == msgTbl.is_union then	--0：创建俱乐部
		if msgTbl.code == 0 then
			self.panelBtn:setVisible(false)
			local tips = string.format("恭喜您创建成功，您已经是“%s”俱乐部的群主，您的俱乐部ID是：%d\n邀请好友时，请让好友输入俱乐部ID发起申请",
				msgTbl.name, msgTbl.guild_id)
			require("app/views/NoticeTips"):create("提示", tips, nil, nil, true)

			local guild_info = {}
			guild_info.id = msgTbl.guild_id
			guild_info.owner_id = gt.playerData.uid
			guild_info.name = msgTbl.name
			guild_info.icon = msgTbl.icon
			guild_info.apply = 0
			guild_info.admin = false
			gt.guildManager:addGuild(guild_info)

			self:refreshGuildListView()
		elseif msgTbl.code == 1 then
			require("app/views/NoticeTips"):create("提示", "俱乐部名称重复", nil, nil, true)
		else
			require("app/views/NoticeTips"):create("提示", "俱乐部数量超过限制", nil, nil, true)
		end
		
	elseif 1 == msgTbl.is_union then	--1：升级联盟
		if msgTbl.code == 0 then
			cc.UserDefault:getInstance():setIntegerForKey("unionid"..gt.playerData.uid, msgTbl.guild_id)
			if self.joinUnionFun then
				local joinUnionFun = self.joinUnionFun
				self:close()
				joinUnionFun()
			end
			local tips = string.format("恭喜您升级成功，您已经是“%s”大联盟的盟主，您的大联盟ID是：%d\n邀请好友时，请让好友输入大联盟ID发起申请\n您的原俱乐部还在！",
				msgTbl.name, msgTbl.guild_id)  
			require("app/views/NoticeTips"):create("提示", tips, nil, nil, true)	
		elseif msgTbl.code == 1 then
			require("app/views/NoticeTips"):create("提示", "大联盟名称重复", nil, nil, true)
		elseif msgTbl.code == 2 then
			require("app/views/NoticeTips"):create("提示", "大联盟数量超过限制", nil, nil, true)
		elseif msgTbl.code == 3 then
			require("app/views/NoticeTips"):create("提示", "激活码已使用", nil, nil, true)
		elseif msgTbl.code == 11 then
			require("app/views/NoticeTips"):create("提示", "该俱乐部不存在", nil, nil, true)
		elseif msgTbl.code == 12 then
			require("app/views/NoticeTips"):create("提示", "您不是俱乐部会长", nil, nil, true)
		elseif msgTbl.code == 13 then
			require("app/views/NoticeTips"):create("提示", "该俱乐部已经是联盟", nil, nil, true)
		elseif msgTbl.code == 14 then
			require("app/views/NoticeTips"):create("提示", "房卡不够", nil, nil, true)
		end
	end
end

function Guild:onRcvApplyGuild(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 3 then
		require("app/views/CommonTips"):create("您所输入的俱乐部ID不存在，请输入正确俱乐部ID", 2)
	elseif msgTbl.code == 2 then
		require("app/views/CommonTips"):create("您已经加入该俱乐部", 2)
	else
		require("app/views/CommonTips"):create("申请已发送", 2)
	end
end

function Guild:onRcvGuildList(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == -1 then
		return
	end
	
	self.activeTime = {}
	self.activeTime.start_time = msgTbl.start_time
	self.activeTime.end_time = msgTbl.end_time
	self.activeTime.now_time = msgTbl.now_time
	
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
	gt.guildManager:setGuildList(guilds)
    if #guilds == 0 then
        self.panelBtn:setVisible(true)
        cc.UserDefault:getInstance():setIntegerForKey("guildid"..gt.playerData.uid, 0)
    end
	self:refreshGuildListView()
end

function Guild:onRcvGuildInviteList(msgTbl)
	gt.removeLoadingTips()
	
	local invite_list_data = msgTbl.invite_list
	if #invite_list_data > 0 then
		local view = require("app/views/Guild/GuildInvite"):create(invite_list_data)
		self:addChild(view)
	end
end

function Guild:onRcvGuildMember(msgTbl)
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

		gt.guildManager:setGuildApplys(guild_id, members)
		local view = require("app/views/Guild/GuildApply"):create(guild_id)
		self:addChild(view)
	end
end

function Guild:getPlayersData(datas,index_)
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


function Guild:updateRoomItem(pItem, room_id, round, player_count, kwargs, callback,isCreateByAdmin,players)
	local par = json.decode(kwargs)
	-- 房号
	if room_id == 0 then
		pItem:getChildByName("Label_RoomId"):setString("待开启")
		if isCreateByAdmin ==1 then
			pItem:getChildByName("Btn_Enterroom"):getChildByName("Label_Enter"):setString("待开启")
		else
			pItem:getChildByName("Btn_Enterroom"):getChildByName("Label_Enter"):setString("加  入")
		end
	else
		pItem:getChildByName("Label_RoomId"):setString(tostring(room_id))
		pItem:getChildByName("Btn_Enterroom"):getChildByName("Label_Enter"):setString("加  入")
	end
	-- 玩法
	local strGameId = gt.getGameIdDesc(par)

	pItem:getChildByName("Label_PlayType"):setString(gt.getGameTypeDesc(par.game_id, par.game_type) .. "[" .. strGameId .. "]")
	-- 局数/人数
	pItem:getChildByName("Label_Round"):setString(string.format("%d/%d局",round, par.rounds))
	
	-- 付费
	local desc = ""
	local room_card = gt.getRoomCardConsume(par.game_id, par.pay, par.rounds, par.max_chairs)
	if par.pay == 1 then
		desc = "房主付费" .. string.format(" %d房卡", room_card)
	else
		desc = "AA付费" .. string.format(" %d房卡", room_card)
	end
	pItem:getChildByName("Label_Consume"):setString(desc)
	
	--癞子玩法
	local Image_MagicCardFlag = pItem:getChildByName("Image_MagicCardFlag")
	if not par.laizi or 0 == par.laizi then
		Image_MagicCardFlag:setVisible(false)
	else
		Image_MagicCardFlag:setVisible(true)
		if 1 == par.laizi then
			Image_MagicCardFlag:loadTexture("image/guild/magicCard.png")
		elseif 2 == par.laizi then
			Image_MagicCardFlag:loadTexture("image/guild/magicCardCrazy.png")
		end
	end

	pItem:setTag(room_id)
	pItem:addClickEventListener(callback)

	--desktop
	local imgDeskTop6 = pItem:getChildByName("imgDeskTop6")
	local imgDeskTop8 = pItem:getChildByName("imgDeskTop8")
	local imgDeskTop10 = pItem:getChildByName("imgDeskTop10")
	local imgDeskTop12 = pItem:getChildByName("imgDeskTop12")
	local curDeskTop = imgDeskTop6
	imgDeskTop6:setVisible(false)
	imgDeskTop8:setVisible(false)
	imgDeskTop10:setVisible(false)
	imgDeskTop12:setVisible(false)
	if par.max_chairs == 6 then
		curDeskTop = imgDeskTop6
	elseif par.max_chairs == 8 then
		curDeskTop = imgDeskTop8
	elseif par.max_chairs == 10 then
		curDeskTop = imgDeskTop10
	elseif par.max_chairs == 12 then
		curDeskTop = imgDeskTop12
	end
	curDeskTop:setVisible(true)

	-- self.playerHeadMgr:detachAll()
	for i = 1, par.max_chairs do
		local imgHead = curDeskTop:getChildByName("imgHead"..i)
		if imgHead then
			--TEST TODO
			-- if i <=  (index % par.max_chairs) then
			if i <=  player_count then
				imgHead:setVisible(true)

				local playerUid,playerData = self:getPlayersData(players,i)
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



	return pItem
end



function Guild:onRcvGuildInfo(msgTbl)
	gt.removeLoadingTips()
	if not self.currentGuild or msgTbl.guild_id ~= self.currentGuild.id then
		return
	end

	self.cost = msgTbl.cost
	self.is_share = msgTbl.is_share
	
	self.lstRooms:removeAllChildren()
	self.playerHeadMgr:detachAll()

	local itemBase 
	local item 
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
	

	local count = #msgTbl.rooms
	if msgTbl.kwargs then
		count = #msgTbl.rooms + 1
	end
	for i = 1, count do
		if i % 2 == 1 then
			itemBase = self.pRoomTemplate:clone()
			self.lstRooms:pushBackCustomItem(itemBase)
			item = itemBase:getChildByName("panelItem0")
		else
			item = itemBase:getChildByName("panelItem1")
			item:setVisible(true)
		end
		local roomData = guildRoomsData[i]
		if i == count and msgTbl.kwargs then
			self:updateRoomItem(item,0, 0, 0, msgTbl.kwargs, self.createRoom, msgTbl.open,{})
		else
			self:updateRoomItem(item, roomData.id, roomData.round, roomData.player_count, roomData.kwargs, self.enterRoom,msgTbl.open,roomData.players)
		end
	end

	gt.guildManager:setGuildAdmin(msgTbl.guild_id, msgTbl.admin)
	gt.guildManager:setGuildPartner(msgTbl.guild_id, msgTbl.partner)
	
	self:refreshGuildPartnerView()

	if msgTbl.admin then
		self.btnRoomSetting:setVisible(msgTbl.admin)
		self.btnInvite:setVisible(msgTbl.admin)
	end
end

function Guild:onRcvDismissGuild(msgTbl)
	gt.removeLoadingTips()
	local guild_id = msgTbl.guild_id
	if self.currentGuild.id == guild_id then
		self.currentGuild = nil
	end
	gt.guildManager:delGuild(guild_id)
    local guilds = gt.guildManager:getGuildList()
    if #guilds == 0 then
        self.panelBtn:setVisible(true)
        self.pRooms:setVisible(false)
		self.Node_Top_Right:setVisible(false)
		self.Node_Bottom_Right:setVisible(false)
    end
	self:refreshGuildListView()
end

function Guild:onRcvExitGuild(msgTbl)
	gt.removeLoadingTips()
	local guild_id = msgTbl.guild_id
	gt.guildManager:delGuild(guild_id)
	if self.currentGuild.id == guild_id then
		self.currentGuild = nil
	end
    local guilds = gt.guildManager:getGuildList()
    if #guilds == 0 then
        self.panelBtn:setVisible(true)
        self.pRooms:setVisible(false)
		self.Node_Top_Right:setVisible(false)
		self.Node_Bottom_Right:setVisible(false)
    end
	self:refreshGuildListView()
end

function Guild:onRcvDelMember(msgTbl)
	gt.removeLoadingTips()
	local guild_id = msgTbl.guild_id
	local member_id = msgTbl.member_id
	gt.guildManager:delGuildMember(guild_id, member_id)
	self:refreshGuildMembersView()
end

function Guild:onRcvRenameGuild(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		require("app/views/NoticeTips"):create("提示", "改名成功", nil, nil, true)
		gt.guildManager:renameGuild(msgTbl.guild_id, msgTbl.name)
		local children = self.lstGuilds:getChildren()
		for i, child in ipairs(children) do
			if msgTbl.guild_id == child:getTag() then
				child:getChildByName("Label_Name"):setString(msgTbl.name)
				break
			end
		end
	else
		require("app/views/NoticeTips"):create("提示", "俱乐部名称重复", nil, nil, true)
	end
end

function Guild:onRcvGuildRoomParam(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		require("app/views/NoticeTips"):create("提示", "设置成功", nil, nil, true)
	else
		require("app/views/NoticeTips"):create("提示", "设置失败", nil, nil, true)
	end
end

function Guild:onRcvRecvGuildApply(msgTbl)
	local member_info = {}
	member_info.id = msgTbl.id
	member_info.nick = msgTbl.nick
	member_info.icon = msgTbl.icon
	gt.guildManager:addGuildApply(msgTbl.guild_id, member_info)

	local children = self.lstGuilds:getChildren()
	for i, child in ipairs(children) do
		if msgTbl.guild_id == child:getTag() then
			child:getChildByName("Img_Tip"):setVisible(true)
			break
		end
	end
end

function Guild:onRcvRecvGuildReply(msgTbl)
	local guild_info = {}
	guild_info.id = msgTbl.guild_id
	guild_info.owner_id = msgTbl.owner_id
	guild_info.name = msgTbl.name
	guild_info.icon = msgTbl.icon
	guild_info.apply = 0
	gt.guildManager:addGuild(guild_info)
    self.panelBtn:setVisible(false)
	self:refreshGuildListView()
end

function Guild:onRcvGuildNull(msgTbl)
	gt.removeLoadingTips()
	require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "您已被移出该俱乐部", nil, nil, true)
	local guild_id = msgTbl.guild_id
	gt.guildManager:delGuild(guild_id)
	self.currentGuild = nil
	self:refreshGuildListView()
	self.pMember:setVisible(false)
	self:removeChildByTag(9999)
end

function Guild:onRcvGuildInviteMember(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		require("app/views/NoticeTips"):create("提示", "邀请成功", nil, nil, true)
	elseif msgTbl.code == 1 then
		require("app/views/NoticeTips"):create("提示", "已经在俱乐部", nil, nil, true)
	elseif msgTbl.code == 2 then
		require("app/views/NoticeTips"):create("提示", "您的俱乐部已满员", nil, nil, true)
	elseif msgTbl.code == 3 then
		require("app/views/NoticeTips"):create("提示", "该玩家拥有俱乐部数量超过限制", nil, nil, true)
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

function Guild:onRcvGuildInvite(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		require("app/views/NoticeTips"):create("提示", "邀请成功", nil, nil, true)
	elseif msgTbl.code == 1 then
		require("app/views/NoticeTips"):create("提示", "您的俱乐部已满员", nil, nil, true)
	elseif msgTbl.code == 2 then
		require("app/views/NoticeTips"):create("提示", "该玩家拥有俱乐部数量超过限制", nil, nil, true)
	elseif msgTbl.code == 3 then
		require("app/views/NoticeTips"):create("提示", "该玩家不存在", nil, nil, true)
	end
end

function Guild:refreshGuildPartnerView()
	self.btnPartnerAdmin:setVisible(false)
	self.btnPartnerDetail:setVisible(false)

	local guild = gt.guildManager:getGuild(self.currentGuild.id)
	if guild then
		if guild.owner_id == gt.playerData.uid or guild.admin then  -- 会长 或者 管理员
			self.btnPartnerAdmin:setVisible(true)
		elseif guild.partner then
			self.btnPartnerDetail:setVisible(true)	
			self.btnInvite:setVisible(true)	
		end
	end

end

function Guild:refreshGuildListView()
	local function onGuildChoose(sender)
		local guild_id = sender:getTag()
		-- gt.guildid = guild_id
		cc.UserDefault:getInstance():setIntegerForKey("guildid"..gt.playerData.uid, guild_id)

		if sender:getChildByName("Img_Tip"):isVisible() then
			local guild = gt.guildManager:getGuild(guild_id)
			if guild and guild.admin then  -- 管理员
				-- 显示申请列表
				local guild_applys = gt.guildManager:getGuildApplys(guild_id)
				if guild_applys == nil then
					 -- 请求申请列表
					if guild.apply == 1 then
						self:request(gt.GUILD_MEMBER, guild_id, 1)
					end
				elseif #guild_applys > 0 then
					local view = require("app/views/Guild/GuildApply"):create(guild_id)
					self:addChild(view)
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
				v:getChildByName("Img_Bg"):loadTexture("image/guild/guild_item_2.png", ccui.TextureResType.plistType)

				self.itemParticle:removeFromParent()
                v:addChild(self.itemParticle)

			elseif v:getTag() > 0 then
				v:getChildByName("Img_Bg"):loadTexture("image/guild/guild_item_1.png", ccui.TextureResType.plistType)
			end
		end

		self.btnAdminSetting:setVisible(false)
		self.btnUpgradeUnion:setVisible(false)
		self.btnRoomSetting:setVisible(false)
		self.btnInvite:setVisible(false)
		local guild = gt.guildManager:getGuild(guild_id)
		if guild and guild.owner_id == gt.playerData.uid then  -- 会长
			self.btnAdminSetting:setVisible(true)
			self.btnUpgradeUnion:setVisible(true)
			self.btnRoomSetting:setVisible(true)
			self.btnInvite:setVisible(true)
		end

		if self.lstGuilds:getChildByName("Panel_Tabs") then
			self.lstGuilds:removeChildByName("Panel_Tabs")
		end
		local index = self.lstGuilds:getIndex(sender)
		self.lstGuilds:insertCustomItem(self.pRoomTabs, index+1)
		self.btnNormal:setEnabled(false)
		self.btnMatch:setEnabled(true)
		self.effectMatch:setVisible(false)
		self.effectNormal:setVisible(true)
		self.pRooms:setVisible(true)
		self.Node_Top_Right:setVisible(true)
		self.Node_Bottom_Right:setVisible(true)
		self.pMatchView:setVisible(false)


		-- 请求俱乐部房间
		self:request(gt.GUILD_INFO, guild_id)
		self.currentGuild = guild
		self:refreshGuildPartnerView()
	end

	local lastGuildId = cc.UserDefault:getInstance():getIntegerForKey("guildid"..gt.playerData.uid, 0)
	local lastGuildType = cc.UserDefault:getInstance():getIntegerForKey("guildtype", 0)
	if not gt.guildManager:getGuild(lastGuildId) then
		lastGuildId = 0
		lastGuildType = 0
	end

	self.lstGuilds:removeAllChildren()
	self.playerHeadMgr:detachAll()
	local guilds = gt.guildManager:getGuildList()
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
		if lastGuildType == 1 and self.lstGuilds:getChildByName("Panel_Tabs") then
			self:changeToMatchType()
		end
	end
end

function Guild:searchUser(user_id)
	local children = self.lstMembers:getChildren()
	local find = false
	for i, child in ipairs(children) do
		local lblID = child:getChildByName("Label_ID")
		if lblID:getString() == "ID:"..user_id then
			lblID:setTextColor(cc.c3b(255,165,0))
			local index = self.lstMembers:getIndex(child)
			self.lstMembers:scrollToItem(index, cc.p(0.5, 0.5), cc.p(0.5, 0.5))
			find = true
		else
			lblID:setTextColor(cc.c3b(255,255,255))
		end
	end
	if not find then
		require("app/views/NoticeTips"):create("提示", "查无此玩家", nil, nil, true)
	end
end

function Guild:refreshGuildMembersView()
	if not self.currentGuild then return end

	local function onDelete(sender)
		local member_id = sender:getTag()
		local function confirm()
			local msgToSend = {}
			msgToSend.cmd = gt.DEL_MEMBER
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.member_id = member_id
			msgToSend.guild_id = self.currentGuild.id
			gt.socketClient:sendMessage(msgToSend)
			gt.showLoadingTips("")
		end
		local tips = string.format("您确定要删除成员ID:%d吗?", member_id)
		require("app/views/NoticeTips"):create("提示", tips, confirm, nil, false)
	end

	local members = gt.guildManager:getGuildMembers(self.currentGuild.id)
	if not members then return end
	local sorted_members = clone(members)
	for i, member in ipairs(sorted_members) do
		if member.id == self.currentGuild.owner_id then
			member.weight = 2
		elseif member.admin then
			member.weight = 1
		else
			member.weight = 0
		end
	end
	table.sort(sorted_members, function(a, b) return a.weight > b.weight end)
	self.playerHeadMgr:detachAll()
	self.lstMembers:removeAllChildren()
	for i, member in ipairs(sorted_members) do
		local pItem = self.pMemberTemplate:clone()
		pItem:getChildByName("Label_Name"):setString(member.nick)
		pItem:getChildByName("Label_ID"):setString("ID:"..member.id)
		local btnDelete = pItem:getChildByName("Btn_Delete")
		btnDelete:setTag(member.id)
		btnDelete:setVisible(false)
		btnDelete:addClickEventListener(onDelete)
		local headImg = pItem:getChildByName("Img_Head")
		self.playerHeadMgr:attach(headImg, member.id, member.icon)
		local imgTag = pItem:getChildByName("Img_Tag")
		if member.weight == 2 then
			imgTag:loadTexture("image/guild/tag_owner.png", ccui.TextureResType.plistType)
		elseif member.weight == 1 then
			imgTag:loadTexture("image/guild/tag_admin.png", ccui.TextureResType.plistType)
		else
			imgTag:setVisible(false)
		end
		pItem:setTag(member.weight)

		self.lstMembers:pushBackCustomItem(pItem)
	end

	local pBg = self.pMember:getChildByName("Img_Bg")
	local num = #members
	if (self.currentGuild.owner_id == gt.playerData.uid or self.currentGuild.admin) then -- 会长
		pBg:getChildByName("Label_Del"):setString(string.format("删除成员(%d)", num))
		pBg:getChildByName("Btn_Del"):setVisible(true)
	else
		pBg:getChildByName("Label_Del"):setString(string.format("成员列表(%d)", num))
		pBg:getChildByName("Btn_Del"):setVisible(false)
	end
end

function Guild:onTransGuild(guild_id, owner_id)
	if self.currentGuild and guild_id == self.currentGuild.id then
		gt.guildManager:setGuildOwner(guild_id, owner_id)
		self:sendRefreshGuild(guild_id)
	end
end

function Guild:sendRefreshGuild(guild_id)
	self:request(gt.GUILD_INFO, guild_id)
	self.btnAdminSetting:setVisible(false)
	self.btnUpgradeUnion:setVisible(false)
	self.btnRoomSetting:setVisible(false)
	self.btnInvite:setVisible(false)
	self.btnPartnerDetail:setVisible(false)
	self.btnPartnerAdmin:setVisible(false)
end

function Guild:onRcvCreateRoom(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		if self.pMatchView:isVisible() then
			self:changeToMatchType()
		else
			self:sendRefreshGuild(self.currentGuild.id)
		end
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
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "您没有在该俱乐部创建房间的权限，需要管理员将房间开启。", nil, nil, true)
		elseif msgTbl.code == 8 then
			-- 参数错误
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "您报名的即时赛场即将开赛，您需要先退赛才能创建新的房间", nil, nil, true)
		elseif msgTbl.code == 9 then
            -- 参数错误
            require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0069"), nil, nil, true)
		end
	end
end


function Guild:close()
	self.playerHeadMgr:close()
	
	self:removeFromParent()
	gt.soundEngine:playMusic("bgm1", true)
end

function Guild:onRcvJoinRoom(msgTbl)
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

return Guild
