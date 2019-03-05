
local gt = cc.exports.gt

local NoticeTipsForUpdate = class("NoticeTipsForUpdate", function()
	return gt.createMaskLayer()
end)

function NoticeTipsForUpdate:ctor(titleText, tipsText, okFunc, cancelFunc, singleBtn)
	self:setName("NoticeTipsForUpdate")

	local csbNode = cc.CSLoader:createNode("csd/NoticeTipsNew.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)

	if titleText then
		local titleLabel = gt.seekNodeByName(csbNode, "Label_Title")
		titleLabel:setString(titleText)
	end

	if tipsText then
		local tipsLabel = gt.seekNodeByName(csbNode, "Label_Tips")
		tipsLabel:setString(tipsText)
	end

	local okBtn = gt.seekNodeByName(csbNode, "Btn_Ok")
	gt.addBtnPressedListener(okBtn, function()
		self:removeFromParent()
		if okFunc then
			okFunc()
		end
	end)

	local cancelBtn = gt.seekNodeByName(csbNode, "Btn_Cancel")
	gt.addBtnPressedListener(cancelBtn, function()
		self:removeFromParent()
		if cancelFunc then
			cancelFunc()
		end
	end)

	local closeBtn = gt.seekNodeByName(csbNode, "Btn_Close")
	gt.addBtnPressedListener(closeBtn, function()
		self:removeFromParent()
		if cancelFunc then
			cancelFunc()
		end
	end)

	if singleBtn then
		local width = okBtn:getParent():getContentSize().width
		okBtn:setPositionX(width/2)
		cancelBtn:setVisible(false)
	end

	local runningScene = cc.Director:getInstance():getRunningScene()
	if runningScene then
		runningScene:addChild(self, 67)
	end
end

return NoticeTipsForUpdate

