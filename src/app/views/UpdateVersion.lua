

local gt = cc.exports.gt

local UpdateVersion = class("UpdateVersion", function()
	return gt.createMaskLayer()
end)

function UpdateVersion:ctor(url)
	local csbNode = cc.CSLoader:createNode("csd/NoticeTipsNew.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode, 1000000)

	local titleLabel = gt.seekNodeByName(csbNode, "Label_Title")
	titleLabel:setString("系统提示")

	local tipsLabel = gt.seekNodeByName(csbNode, "Label_Tips")
	tipsLabel:setString("游戏有新版本，请前往更新")

	local okBtn = gt.seekNodeByName(csbNode, "Btn_Ok")
	gt.addBtnPressedListener(okBtn, function()
		cc.Application:getInstance():openURL(url)
	end)

	local width = okBtn:getParent():getContentSize().width
	okBtn:setPositionX(width/2)

	local cancelBtn = gt.seekNodeByName(csbNode, "Btn_Cancel")
	cancelBtn:setVisible(false)
	
	local closeBtn = gt.seekNodeByName(csbNode, "Btn_Close")
	closeBtn:setVisible(false)
end


return UpdateVersion


