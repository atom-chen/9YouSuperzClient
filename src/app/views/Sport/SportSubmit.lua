-- 提交领奖信息

local gt = cc.exports.gt

local SportSubmit = class("SportSubmit", function()
	return gt.createMaskLayer()
end)

function SportSubmit:ctor(sport_id)
	local csbNode = cc.CSLoader:createNode("csd/Sport/SportSubmit.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	self.sport_id = sport_id

	local btnClose = gt.seekNodeByName(csbNode, "Btn_Close")
	gt.addBtnPressedListener(btnClose, function()
		self:removeFromParent()
	end)

	local btnSubmit = gt.seekNodeByName(csbNode, "Btn_Confirm")
	gt.addBtnPressedListener(btnSubmit, function()
		local phone = gt.seekNodeByName(csbNode, "TextField_Phone"):getString()
		local addr = gt.seekNodeByName(csbNode, "TextField_Addr"):getString()
		local name = gt.seekNodeByName(csbNode,"TextField_Name"):getString()
		local IDCard = gt.seekNodeByName(csbNode,"TextField_IDCard"):getString()
		if string.len(phone) < 7 or string.len(addr) < 8 or string.len(name)<2 or string.len(IDCard)<15 then
			require("app/views/NoticeTips"):create("提示", "请填入完整的联系信息", nil, nil, true)
			return
		end
		if string.len(addr) > 200 then
			require("app/views/NoticeTips"):create("提示", "地址信息过长，请重新填写", nil, nil, true)
			return
		end

		local msgToSend = {}
		msgToSend.cmd = gt.SPORT_GET_AWARD
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		msgToSend.sport_id = self.sport_id
		msgToSend.phone = phone
		msgToSend.addr = addr
		msgToSend.name = name
		msgToSend.identity_id = IDCard
		gt.socketClient:sendMessage(msgToSend)
		gt.showLoadingTips("")

		self:removeFromParent()
	end)
end


return SportSubmit