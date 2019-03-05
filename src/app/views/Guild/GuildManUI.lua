-- 比赛额外设置

local gt = cc.exports.gt

local GuildManUI = class("GuildManUI", function()
	return gt.createMaskLayer()
end)

function GuildManUI:ctor(guild_id, trans_call_back, bIsUnion)
	local csbName = "csd/Guild/GuildManage.csb"
	if bIsUnion then
		csbName = "csd/Guild/UnionManage.csb"
	end
	local csbNode = cc.CSLoader:createNode(csbName)
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	self.guild_id = guild_id
	self.trans_call_back = trans_call_back
	self.trans_id = 0
	self.admin_id = 0
	self.admins = {}
	gt.log("-----openUI:GuildManUI")
	local btnCancel = gt.seekNodeByName(csbNode, "Btn_Cancel")
	gt.addBtnPressedListener(btnCancel, function()
		self:close()
	end)

	-- 头像下载管理器
	local playerHeadMgr = require("app/PlayerHeadManager"):create()
	self.csbNode:addChild(playerHeadMgr)
	self.playerHeadMgr = playerHeadMgr

	-- 转让俱乐部
	self.lblTransId = gt.seekNodeByName(csbNode, "Label_TransId")
	local transBg = gt.seekNodeByName(csbNode, "Img_TransBg")
	transBg:addClickEventListener(function(sender)
		local view = require("app/views/Guild/GuildNumberPad"):create("get_number", 0, 0, function(number)
			self.trans_id = number
			self.lblTransId:setString(tostring(number))
		end)
		self:addChild(view)
	end)
	local btnTrans = gt.seekNodeByName(csbNode, "Btn_Trans")
	local function sendTransMsg()
		local msgToSend = {}
		msgToSend.cmd = gt.TRANS_GUILD
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		msgToSend.guild_id = guild_id
		msgToSend.target_id = self.trans_id
		gt.socketClient:sendMessage(msgToSend)
		gt.showLoadingTips("")
	end
	gt.addBtnPressedListener(btnTrans, function()
		if self.trans_id > 0 then
			require("app/views/NoticeTips"):create("提示", 
				"转让管理员无需对方确认，可直接转让\n转让后您将无法再对工会进行管理操作\n是否继续?",
				 sendTransMsg, nil, false)
		end
	end)

	-- 多个副管理
	self.lblAdminId = gt.seekNodeByName(csbNode, "Label_AdminId")
	local adminBg = gt.seekNodeByName(csbNode, "Img_AdminBg")
	adminBg:addClickEventListener(function(sender)
		local view = require("app/views/Guild/GuildNumberPad"):create("get_number", 0, 0, function(number)
			self.admin_id = number
			self.lblAdminId:setString(tostring(number))
		end)
		self:addChild(view)
	end)
	local btnSetAdmin = gt.seekNodeByName(csbNode, "Btn_SetAdmin")
	local function sendSetAdminMsg()
		local msgToSend = {}
		msgToSend.cmd = gt.GUILD_SET_ADMIN
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		msgToSend.guild_id = guild_id
		msgToSend.target_id = self.admin_id
		msgToSend.admin = 1
		gt.socketClient:sendMessage(msgToSend)
		gt.showLoadingTips("")
	end
	gt.addBtnPressedListener(btnSetAdmin, function()
		if self.admin_id > 0 then
			local tips = string.format("ID:%d玩家将被您授予副管理员权限，其可以对俱乐部部分功能进行操作\n是否要提升其为副管理员", self.admin_id)
			require("app/views/NoticeTips"):create("提示", tips, sendSetAdminMsg, nil, false)
		end
	end)

	self.lstAdmins = gt.seekNodeByName(csbNode, "List_Admins")
	self.pTemplate = self.lstAdmins:getChildByName("Panel_Template")
	self.pTemplate:retain()
	self.lstAdmins:removeAllChildren()

	-- 开房管理
	self.chkOpen1 = gt.seekNodeByName(csbNode, "Chk_Open1")
	self.chkOpen2 = gt.seekNodeByName(csbNode, "Chk_Open2")
	self.chkAuto = gt.seekNodeByName(csbNode, "Chk_Auto")
	self.chkAuto:setVisible(false)
	local function onCheck(sender)
		self.chkOpen1:setSelected(self.chkOpen1 == sender)
		self.chkOpen2:setSelected(self.chkOpen2 == sender)
		self:refreshRoomAutoOption(true)
	end
	self.chkOpen1:addClickEventListener(onCheck)
	self.chkOpen2:addClickEventListener(onCheck)
	local btnOpenRoom = gt.seekNodeByName(csbNode, "Btn_OpenRoom")
	gt.addBtnPressedListener(btnOpenRoom, function()
		local msgToSend = {}
		msgToSend.cmd = gt.GUILD_MAN_PARAM
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		msgToSend.guild_id = guild_id
		msgToSend.set = 1
		msgToSend.open = 0
		msgToSend.auto = 0
		if self.chkOpen1:isSelected() then
			msgToSend.open = 1
		end
		if self.chkAuto:isSelected() then
			msgToSend.auto = 1
		end
		gt.socketClient:sendMessage(msgToSend)
		gt.showLoadingTips("")
	end)

	--禁止聊天 默认不禁止 1:禁止 0:不禁止 
	local Img_SilentBG = gt.seekNodeByName(csbNode,"Img_SilentBG")
	self.Button_ForbidChat = Img_SilentBG:getChildByName("Button_ForbidChat")
	gt.addBtnPressedListener(self.Button_ForbidChat, function()
		self.Button_ForbidChat:setEnabled(false)
		self.Button_NoForbidChat:setEnabled(true)
	end)
	self.Button_NoForbidChat = Img_SilentBG:getChildByName("Button_NoForbidChat")
	gt.addBtnPressedListener(self.Button_NoForbidChat, function()
		self.Button_ForbidChat:setEnabled(true)
		self.Button_NoForbidChat:setEnabled(false)
	end)
	local Btn_SetForbidChat = Img_SilentBG:getChildByName("Btn_SetForbidChat")
	gt.addBtnPressedListener(Btn_SetForbidChat, function()
		local msgToSend = {}
		msgToSend.cmd = gt.GUILD_MAN_PARAM
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		msgToSend.guild_id = guild_id
		msgToSend.set = 1
		msgToSend.is_shutup = 0
		if self.Button_NoForbidChat:isEnabled() then
			msgToSend.is_shutup = 1
		end
		gt.socketClient:sendMessage(msgToSend)
		gt.showLoadingTips("")
	end)	
	
	-- 禁止拉人
	self.bIsUnion = bIsUnion
	if not self.bIsUnion then
		self.chkForbidInvite = gt.seekNodeByName(csbNode, "Chk_ForbidInvite")
		self.chkNoForbidInvite = gt.seekNodeByName(csbNode, "Chk_NoForbidInvite")
		local function onForbidInviteCheck(sender)
			self.chkForbidInvite:setSelected(self.chkForbidInvite == sender)
			self.chkNoForbidInvite:setSelected(self.chkNoForbidInvite == sender)
		end
		self.chkForbidInvite:addClickEventListener(onForbidInviteCheck)
		self.chkNoForbidInvite:addClickEventListener(onForbidInviteCheck)
		local btnForbidInviteOk = gt.seekNodeByName(csbNode, "Btn_ForbidInviteOk")
		gt.addBtnPressedListener(btnForbidInviteOk, function()
			local msgToSend = {}
			msgToSend.cmd = gt.GUILD_MAN_PARAM
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.guild_id = guild_id
			msgToSend.set = 1
			msgToSend.is_share = 0
			if self.chkNoForbidInvite:isSelected() then
				msgToSend.is_share = 1
			end
			gt.socketClient:sendMessage(msgToSend)
			gt.showLoadingTips("")
		end)
	end
	

	gt.socketClient:registerMsgListener(gt.TRANS_GUILD, self, self.onRcvTransGuild)
	gt.socketClient:registerMsgListener(gt.GUILD_SET_ADMIN, self, self.onRcvGuildSetAdmin)
	gt.socketClient:registerMsgListener(gt.GUILD_GET_ADMIN, self, self.onRcvGuildGetAdmin)
	gt.socketClient:registerMsgListener(gt.GUILD_MAN_PARAM, self, self.onRcvGuildManParam)

	-- 请求信息
	local msgToSend = {}
	msgToSend.user_id = gt.playerData.uid
	msgToSend.open_id = gt.playerData.openid
	msgToSend.guild_id = guild_id

	msgToSend.cmd = gt.GUILD_GET_ADMIN
	gt.socketClient:sendMessage(msgToSend)

	msgToSend.cmd = gt.GUILD_MAN_PARAM
	msgToSend.set = 0
	gt.socketClient:sendMessage(msgToSend)

	gt.showLoadingTips("")
end

function GuildManUI:refreshRoomAutoOption(isNeedCheck)
	if self.chkOpen1:isSelected() then
		self.chkAuto:setVisible(false)
		if isNeedCheck then
			self.chkAuto:setSelected(false)
		end
	elseif self.chkOpen2:isSelected() then
		self.chkAuto:setVisible(true)
		if isNeedCheck	then
			self.chkAuto:setSelected(true)
		end
	end
end

function GuildManUI:refreshAdminListView()
	local function onDelete(sender)
		local target_id = sender:getTag()
		local function confirm()
			local msgToSend = {}
			msgToSend.cmd = gt.GUILD_SET_ADMIN
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.target_id = target_id
			msgToSend.guild_id = self.guild_id
			msgToSend.admin = 0
			gt.socketClient:sendMessage(msgToSend)
			gt.showLoadingTips("")
		end
		local tips = string.format("您确定要删除管理员ID:%d吗?", target_id)
		require("app/views/NoticeTips"):create("提示", tips, confirm, nil, false)
	end

	self.playerHeadMgr:detachAll()
	self.lstAdmins:removeAllChildren()
	for i, v in ipairs(self.admins) do
		local pItem = self.pTemplate:clone()
		pItem:getChildByName("Label_Name"):setString(v.nick)
		pItem:getChildByName("Label_ID"):setString("ID:"..tostring(v.id))
		local headImg = pItem:getChildByName("Img_Head")
		self.playerHeadMgr:attach(headImg, v.id, v.icon)
		local btnDel = pItem:getChildByName("Btn_Del")
		btnDel:addClickEventListener(onDelete)
		btnDel:setTag(v.id)
		self.lstAdmins:pushBackCustomItem(pItem)
	end
end

function GuildManUI:onRcvTransGuild(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		if self.trans_call_back then
			self.trans_call_back(msgTbl.guild_id, msgTbl.target_id)
		end
		self:close()
	end
	local errs = {}
	errs[0] = "转让成功"
	errs[1] = "没有权限"
	errs[2] = "对方不是俱乐部成员"
	errs[3] = "转让失败"
	errs[4] = "转让失败"
	errs[5] = "转让失败,该玩家是其他合伙人的下线"
	if errs[msgTbl.code] then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), errs[msgTbl.code], nil, nil, true)
	end
end

function GuildManUI:onRcvGuildSetAdmin(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		if msgTbl.admin == 0 then
			for i, v in ipairs(self.admins) do
				if v.id == msgTbl.target_id then
					table.remove(self.admins, i)
					break
				end
			end
		elseif msgTbl.admin == 1 then
			local info = {id = msgTbl.target_id, nick = msgTbl.nick, icon = msgTbl.icon}
			table.insert(self.admins, info)
		end
		self:refreshAdminListView()
	end
	local errs = {}
	if msgTbl.admin == 1 then errs[0] = "添加成功" else errs[0] = "删除成功" end
	errs[1] = "没有权限"
	errs[2] = "对方不是俱乐部成员"
	errs[3] = "最多只能设置15名管理员"
	errs[4] = "设置失败"
	errs[5] = "设置失败,已是副管理员无法再设置为副管理员"
	errs[6] = "设置失败,该玩家是其他合伙人的下线,不能被设置为管理员"
	if errs[msgTbl.code] then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), errs[msgTbl.code], nil, nil, true)
	end
end

function GuildManUI:onRcvGuildGetAdmin(msgTbl)
	gt.removeLoadingTips()
	for i, v in ipairs(msgTbl.players) do
		local info = {id = v.id, nick = v.nick, icon = v.icon}
		table.insert(self.admins, info)
	end
	self:refreshAdminListView()
end

function GuildManUI:onRcvGuildManParam(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.set == 1 and msgTbl.code == 0 then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "设置成功", nil, nil, true)
	end
	self.chkOpen1:setSelected(msgTbl.open ~= 0)
	self.chkOpen2:setSelected(msgTbl.open == 0)
	self.chkAuto:setSelected(msgTbl.auto ~= 0)
	
	if not self.bIsUnion then
		self.chkForbidInvite:setSelected(msgTbl.is_share == 0)
		self.chkNoForbidInvite:setSelected(msgTbl.is_share ~= 0)
		gt.dispatchEvent(gt.EventType.GUILD_SHARE_SET, msgTbl.is_share)
	end
	
	--禁止聊天 1:禁止 0:不禁止 
	self.Button_ForbidChat:setEnabled(0 == msgTbl.is_shutup)
	self.Button_NoForbidChat:setEnabled(0 ~= msgTbl.is_shutup)
	
	self:refreshRoomAutoOption(false)
end

function GuildManUI:close()
	gt.socketClient:unregisterMsgListener(gt.TRANS_GUILD)
	gt.socketClient:unregisterMsgListener(gt.GUILD_SET_ADMIN)
	gt.socketClient:unregisterMsgListener(gt.GUILD_GET_ADMIN)
	gt.socketClient:unregisterMsgListener(gt.GUILD_MAN_PARAM)
	self.playerHeadMgr:detachAll()
	self.pTemplate:release()
	self:removeFromParent()
end

return GuildManUI
