-- 赛场状态

local gt = cc.exports.gt

local SportStatus = class("SportStatus", function()
	return gt.createMaskLayer()
end)

function SportStatus:ctor(msg, showBtn)
	self:setName("SportStatus")

	local csbNode = cc.CSLoader:createNode("csd/Sport/SportStatus.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode

	local lblMsg = gt.seekNodeByName(csbNode, "Label_Msg")
	lblMsg:setString(msg)

	local btnOk = gt.seekNodeByName(csbNode, "Btn_Ok")
	gt.addBtnPressedListener(btnOk, function()
		self:removeFromParent()
	end)
	if showBtn then
		btnOk:setVisible(true)
	else
		btnOk:setVisible(false)
	end
end

return SportStatus
