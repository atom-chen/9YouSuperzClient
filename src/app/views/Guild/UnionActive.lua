-- 大联盟邀请码

local gt = cc.exports.gt

local UnionActive = class("UnionActive", function()
	return gt.createMaskLayer()
end)

function UnionActive:ctor(guild_id)
	local csbNode = cc.CSLoader:createNode("csd/Guild/UnionActive.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode

	local lblTitle = gt.seekNodeByName(csbNode, "Label_Title")
	local edtInput = gt.seekNodeByName(csbNode, "Edit_Input")
	local btnCancel = gt.seekNodeByName(csbNode, "Btn_Cancel")
	local btnOk = gt.seekNodeByName(csbNode, "Btn_Ok")
	local btnCtrlV = gt.seekNodeByName(csbNode, "btnCtrlV")
	
	gt.addBtnPressedListener(btnCtrlV, function()
			edtInput:setString(extension.getTextFromClipBoard())
		end)

	gt.addBtnPressedListener(btnOk, function()
		local activeCode = edtInput:getString()
		if string.len(activeCode) < 0 or string.len(activeCode) > 24 then
			require("app/views/CommonTips"):create("俱乐部名称在0到24个字符之间")
			return
		end
		require("app/ShieldWord")
		if gt.CheckShieldWord(activeCode) then
			require("app/views/CommonTips"):create("您输入的名称中含有敏感词")
			return
		end

		local msgToSend = {}
		msgToSend.cmd = gt.UNION_CHECK_ACTIVE_CODE
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		msgToSend.active_code = activeCode
		gt.socketClient:sendMessage(msgToSend)

		gt.showLoadingTips("")
		self:close()
	end)
	
	gt.addBtnPressedListener(btnCancel, function()
		self:close()
	end)

end

function UnionActive:close()
	self:removeFromParent()
end

return UnionActive
