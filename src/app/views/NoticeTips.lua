
local gt = cc.exports.gt

local NoticeTips = class("NoticeTips", function()
	return gt.createMaskLayer()
end)

function NoticeTips:ctor(titleText, tipsText, okFunc, cancelFunc, singleBtn, isTwelve, color, isInviteFailed)
	self:setName("NoticeTips")

	local csbNode = cc.CSLoader:createNode("csd/NoticeTipsNew.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode, 1000000)

	local tipsLayer = gt.seekNodeByName(csbNode, "Image_TipsBg")
	local solveTipsLayer = gt.seekNodeByName(csbNode, "Image_SolveTipsBg")
	solveTipsLayer:setVisible(false)
	
	if isTwelve then
		csbNode:setRotation(-90)
	end

    --关闭按钮
    local btnClose = gt.seekNodeByName(csbNode, "Btn_Close")
    gt.addBtnPressedListener(btnClose, function()
		self:removeFromParent()
		if cancelFunc then
			cancelFunc()
		end
	end)

	if titleText then
		local titleLabel = gt.seekNodeByName(csbNode, "Label_Title")
		titleLabel:setString(titleText)
	end

	if tipsText then
		local tipsLabel = gt.seekNodeByName(csbNode, "Label_Tips")
		tipsLabel:setString(tipsText)
		if color then
			tipsLabel:setTextColor(color)
		end
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
	
	local solveCloseBtn = gt.seekNodeByName(csbNode, "Btn_Solve_Close")
	gt.addBtnPressedListener(solveCloseBtn, function()
		self:removeFromParent()
	end)

	local solveBtn = gt.seekNodeByName(csbNode, "Btn_Solve")
	gt.addBtnPressedListener(solveBtn, function()
		tipsLayer:setVisible(false)
		solveTipsLayer:setVisible(true)
	end)
	if isInviteFailed then
		solveBtn:setVisible(true)
		cancelBtn:setVisible(false)
	else
		solveBtn:setVisible(false)
	end

	if singleBtn then
		local width = okBtn:getParent():getContentSize().width
		okBtn:setPositionX(width/2)
		cancelBtn:setVisible(false)
	end

	local runningScene = cc.Director:getInstance():getRunningScene()
	if runningScene then
		runningScene:addChild(self, gt.CommonZOrder.NOTICE_TIPS)
	end
end

return NoticeTips

