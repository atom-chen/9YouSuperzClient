
local gt = cc.exports.gt

local UserAgreement = class("UserAgreement", function()
	return gt.createMaskLayer(89)
end)

function UserAgreement:ctor()
	-- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))

	local csbNode = cc.CSLoader:createNode("csd/UserAgreement.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.rootNode = csbNode

    --关闭按钮
	local closeBtn = gt.seekNodeByName(csbNode, "Btn_Close")
	gt.addBtnPressedListener(closeBtn, function()
		self:removeFromParent()
	end)

    --打开网址
    -- local openUrl = gt.seekNodeByName(csbNode, "Button_Link")
    -- gt.addBtnPressedListener(openUrl, function ()
	   --  cc.Application:getInstance():openURL("http://apps.9you.net/klmj/privacy.html")
    -- end)
end

-- function UserAgreement:onNodeEvent(eventName)
-- 	if "enter" == eventName then
-- 		local listener = cc.EventListenerTouchOneByOne:create()
-- 		listener:setSwallowTouches(true)
-- 		listener:registerScriptHandler(handler(self, self.onTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
-- 		local eventDispatcher = self:getEventDispatcher()
-- 		eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)

-- 	elseif "exit" == eventName then
-- 		local eventDispatcher = self:getEventDispatcher()
-- 		eventDispatcher:removeEventListenersForTarget(self)
-- 	end
-- end

-- function UserAgreement:onTouchBegan(touch, event)
-- 	return true
-- end

return UserAgreement

