-- 俱乐部邀请列表

local gt = cc.exports.gt

local GuildInvite = class("GuildInvite", function()
	return gt.createMaskLayer()
end)

function GuildInvite:ctor(inviteListData,is_union)
	local csbNode = cc.CSLoader:createNode("csd/Guild/GuildInvite.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	self.is_union = is_union or false
	gt.log("-----openUI:GuildInvite")
	local btnClose = gt.seekNodeByName(csbNode, "Btn_Close")
	gt.addBtnPressedListener(btnClose, function()
		self:close()
	end)

	gt.dump(inviteListData)
	self.inviteListData = inviteListData

	local lstInvites = gt.seekNodeByName(csbNode, "List_Invite")
	local pTemplate = lstInvites:getChildByName("Panel_Template")
	pTemplate:retain()
	lstInvites:removeAllChildren()

	-- 头像下载管理器
	local playerHeadMgr = require("app/PlayerHeadManager"):create()
	self.csbNode:addChild(playerHeadMgr)
	self.playerHeadMgr = playerHeadMgr

	local function reply(index_, r , item)
		local inviteData = self.inviteListData[index_]
		if inviteData then

			local msgToSend = {}
			msgToSend.cmd = gt.GUILD_INVITE_REPLY
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.guild_id = inviteData.guild_id
			msgToSend.invite_id = inviteData.user_id
			msgToSend.is_union = inviteData.is_union
			msgToSend.reply = r
			gt.socketClient:sendMessage(msgToSend)
			if item then
				item:getChildByName("Btn_Refuse"):setVisible(false)
				item:getChildByName("Btn_Agree"):setVisible(false)
				local lblDealStr = item:getChildByName("lblDealStr")
				lblDealStr:setVisible(true)
				if r == 1 then
					lblDealStr:setString("已拒绝")
				elseif r == 0 then
					lblDealStr:setString("已同意")
				end

				inviteData.isDeal = true
			end
		-- 	if self.is_union then
		-- 		gt.UnionManager:delGuildApply(guild_id, apply_id)
		-- 	else
		-- 		gt.guildManager:delGuildApply(guild_id, apply_id)
		-- 	end
			gt.showLoadingTips("")
		end
	end

	local function onRefuse(sender)
		local index_ = sender:getTag()
		reply(index_, 1, sender:getParent())
	end

	local function onAgree(sender)
		local index_ = sender:getTag()
		reply(index_, 0, sender:getParent())
	end
	local lblTitle = gt.seekNodeByName(csbNode, "lblTitle")
	if self.is_union then
		lblTitle:setString("大联盟邀请")
	end

	if inviteListData then
		for i, v in ipairs(inviteListData) do
			local pItem = pTemplate:clone()
			pItem:getChildByName("lblName"):setString(v.guild_name)
			pItem:getChildByName("lblGuildId"):setString(v.guild_id)
			pItem:getChildByName("lblUserId"):setString(v.user_id)
			pItem:getChildByName("lblDealStr"):setVisible(false)
			if self.is_union then
				pItem:getChildByName("Label_Desc"):setString("邀请您加入大联盟")
			else
				pItem:getChildByName("Label_Desc"):setString("邀请您加入俱乐部")
			end
			local btnRefuse = pItem:getChildByName("Btn_Refuse")
			btnRefuse:setTag(i)
			btnRefuse:addClickEventListener(onRefuse)
			local btnAgree = pItem:getChildByName("Btn_Agree")
			btnAgree:setTag(i)
			btnAgree:addClickEventListener(onAgree)
			local headImg = pItem:getChildByName("Img_Head")
			self.playerHeadMgr:attach(headImg, v.guild_id * 10, v.guild_icon)

			lstInvites:pushBackCustomItem(pItem)
		end
	end

	pTemplate:release()

	gt.socketClient:registerMsgListener(gt.GUILD_INVITE_REPLY, self, self.onRcvReplyGuildInvite)
end

function GuildInvite:onRcvReplyGuildInvite(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		require("app/views/CommonTips"):create("操作成功", 2)
	elseif msgTbl.code == 1 then
		require("app/views/CommonTips"):create("已在俱乐部", 2)
	elseif msgTbl.code == 2 then
		require("app/views/CommonTips"):create("俱乐部人数已满", 2)
	elseif msgTbl.code == 3 then
		require("app/views/CommonTips"):create("俱乐部已经上限", 2)
	elseif msgTbl.code == 8 then
		require("app/views/CommonTips"):create("俱乐部不存在", 2)
	elseif msgTbl.code == 9 then
		require("app/views/CommonTips"):create("邀请人没权限", 2)
	else
		require("app/views/CommonTips"):create("操作失败,错误码:"..msgTbl.code, 2)
	end

	-- local guild_applys = {}
	-- if self.is_union then
	-- 	guild_applys = gt.UnionManager:getGuildApplys(guild_id)
	-- else
	-- 	guild_applys = gt.guildManager:getGuildApplys(guild_id)
	-- end
	-- if guild_applys == nil or #guild_applys == 0 then
	-- 	self:close()
	-- end
end

function GuildInvite:close()
	self.playerHeadMgr:detachAll()
	gt.socketClient:unregisterMsgListener(gt.GUILD_INVITE_REPLY)
	self:removeFromParent()
end

return GuildInvite
