-- 俱乐部输入界面

local gt = cc.exports.gt

local GuildInput = class("GuildInput", function()
	return gt.createMaskLayer()
end)

function GuildInput:ctor(type, guild_id, update_guild_id)
	local csbNode = cc.CSLoader:createNode("csd/Guild/UnionInput.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	gt.log("-----openUI:GuildInput")
	local btnClose = gt.seekNodeByName(csbNode, "Btn_Close")
	gt.addBtnPressedListener(btnClose, function()
		self:removeFromParent()
	end)
	
	self.type = type
	local lblTitle = gt.seekNodeByName(csbNode, "Label_Title")
	local edtInput = gt.seekNodeByName(csbNode, "Edit_Input")
	local btnCancel = gt.seekNodeByName(csbNode, "Btn_Cancel")
	local btnOk = gt.seekNodeByName(csbNode, "Btn_Ok")
	if type == "guild_create" then		-- 创建俱乐部
		gt.addBtnPressedListener(btnOk, function()
			local name = edtInput:getString()
			if string.len(name) < 4 or string.len(name) > 24 then
				require("app/views/CommonTips"):create("俱乐部名称在4到16个字符之间")
				return
			end
			require("app/ShieldWord")
			if gt.CheckShieldWord(name) then
				require("app/views/CommonTips"):create("您输入的名称中含有敏感词")
				return
			end

			local msgToSend = {}
			msgToSend.cmd = gt.CREATE_GUILD
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.name = name
			gt.socketClient:sendMessage(msgToSend)

			gt.showLoadingTips("")
			self:close()
		end)
	elseif type == "union_create" then	-- 创建大联盟
		gt.addBtnPressedListener(btnOk, function()
			local name = edtInput:getString()
			if string.len(name) < 4 or string.len(name) > 24 then
				require("app/views/CommonTips"):create("俱乐部名称在4到16个字符之间")
				return
			end
			require("app/ShieldWord")
			if gt.CheckShieldWord(name) then
				require("app/views/CommonTips"):create("您输入的名称中含有敏感词")
				return
			end

			local msgToSend = {}
			msgToSend.cmd = gt.CREATE_GUILD
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.name = name
			msgToSend.active_code = guild_id
			if update_guild_id then
				msgToSend.update_guild_id = update_guild_id
			end
			gt.socketClient:sendMessage(msgToSend)

			gt.showLoadingTips("")
			
			self:close()
		end)
	elseif type == "guild_invite" then	-- 邀请入会
		lblTitle:setString("玩家ID")
		edtInput:setPlaceHolder("请输入邀请玩家ID")
		gt.addBtnPressedListener(btnOk, function()
			local id = edtInput:getString()
			local user_id = tonumber(id)
			if not user_id or user_id <= 0 or user_id > 99999999 or user_id ~= math.floor(user_id) then
				require("app/views/CommonTips"):create("您输入的ID不正确")
				return
			end

			local msgToSend = {}
			msgToSend.cmd = gt.GUILD_INVITE
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.invite_id = user_id
			msgToSend.guild_id = guild_id
			gt.socketClient:sendMessage(msgToSend)

			gt.showLoadingTips("")
			self:close()
		end)
	elseif type == "guild_apply" then	-- 申请入会
		lblTitle:setString("俱乐部ID")
		edtInput:setPlaceHolder("请输入俱乐部ID")
		gt.addBtnPressedListener(btnOk, function()
			local id = edtInput:getString()
			local guild_id = tonumber(id)
			if not guild_id or guild_id <= 0 or guild_id > 99999999  or guild_id ~= math.floor(guild_id) then
				require("app/views/CommonTips"):create("您输入的ID不正确")
				return
			end

			local msgToSend = {}
			msgToSend.cmd = gt.APPLY_GUILD
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.icon = gt.playerData.headURL
			msgToSend.nick = gt.playerData.nickname
			msgToSend.guild_id = guild_id
			gt.socketClient:sendMessage(msgToSend)

			self:close()
		end)
	elseif type == "guild_rename" then		-- 俱乐部更名
		gt.addBtnPressedListener(btnOk, function()
			local name = edtInput:getString()
			if string.len(name) < 4 or string.len(name) > 24 then
				require("app/views/CommonTips"):create("俱乐部名称在4到16个字符之间")
				return
			end
			require("app/ShieldWord")
			if gt.CheckShieldWord(name) then
				require("app/views/CommonTips"):create("您输入的名称中含有敏感词")
				return
			end

			local msgToSend = {}
			msgToSend.cmd = gt.RENAME_GUILD
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.guild_id = guild_id
			msgToSend.name = name
			gt.socketClient:sendMessage(msgToSend)

			gt.showLoadingTips("")
			self:close()
		end)
	end

	gt.addBtnPressedListener(btnCancel, function()
		self:close()
	end)

end

function GuildInput:close()
	self:removeFromParent()
end

return GuildInput
