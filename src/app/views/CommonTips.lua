local gt = cc.exports.gt

local CommonTips = class("CommonTips", function()
	return cc.Node:create()
end)

function CommonTips:ctor(tipText, delay)
	self:setName("CommonTips")

	local csbNode = cc.CSLoader:createNode("csd/CommonTips.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode, 10000000)

    local lbTip = gt.seekNodeByName(csbNode, "lbTip")
    lbTip:setString("")
	if tipText then
		lbTip:setString(tipText)
	end
    local callfun = function ()
        self:removeFromParent()
    end
	delay = delay or 1.5
    lbTip:runAction(cc.Sequence:create(cc.DelayTime:create(delay), cc.FadeOut:create(0.5), cc.CallFunc:create(callfun)))


	local runningScene = cc.Director:getInstance():getRunningScene()
	if runningScene then
		runningScene:addChild(self, gt.CommonZOrder.NOTICE_TIPS)
	end
end


return CommonTips
