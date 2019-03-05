local gt = cc.exports.gt

local RubTTZ = class("RubTTZ",function()
	return cc.Node:create()
end)

function RubTTZ:ctor(cards,gameId)
	self:setName("RubTTZ")

	local csbNode = cc.CSLoader:createNode("csd/RubTTZ.csb")
	csbNode:setAnchorPoint(0.5,0.5)
	csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
    ccui.Helper:doLayout(csbNode)
	self:addChild(csbNode)
	self.csbNode = csbNode

	self.back = "image/rub_card/back2.png"
	local desktop = cc.UserDefault:getInstance():getStringForKey("Desktop")
	if desktop == "3" or desktop == "4" then
		self.back = "image/rub_card/back.png"
	end

	-- 消息分发函数
	gt.registerEventListener(gt.EventType.SHOW_CARD_OVER,self,self.showCardOverEvt)

	-- 关闭按钮
	local closeBtn = gt.seekNodeByName(csbNode,"BtnClose")
	gt.addBtnPressedListener(closeBtn,function()
		gt.dispatchEvent(gt.EventType.RUB_CARD_OVER)
		self:closeView()
	end)
	self.MAX_CARD=2
	--牌
	self.Img_Card = {}
	for i = 1,self.MAX_CARD do
		self.Img_Card[i] = self.csbNode:getChildByName("Img_Card" .. i)
		if cards[i] then
			self.Img_Card[i]:loadTexture(string.format("image/playttz/card/%02x.png",cards[i]),ccui.TextureResType.plistType)
		end

		local listener = cc.EventListenerTouchOneByOne:create()  --创建一个单点事件监听
		listener:setSwallowTouches(true)  --不向下传递
		--Moved
		local function OnCardMoved(touch, event)
			local target = event:getCurrentTarget()  --获取当前的控件
			local posX,posY = target:getPosition()  --获取当前的位置
			local delta = touch:getDelta() --获取滑动的距离
			target:setPosition(cc.p(posX + delta.x, posY + delta.y)) --重新设置位置
		end
		--Ended
		local function OnCardEnded(touch, event)
			local target = event:getCurrentTarget()
			if self:IsOver() then
				self:OnRubOver()
			end
		end
		--Began
		local function OnCardBegan(touch, event)
			local target = event:getCurrentTarget()  --获取当前的控件
			local posInCard = target:convertToNodeSpace(touch:getLocation())
			local size = target:getContentSize()
			local rect = cc.rect(0, 0, size.width, size.height)

			if (cc.rectContainsPoint(rect, posInCard)) then
				return true
			end

			return false
		end
		listener:registerScriptHandler(OnCardBegan,cc.Handler.EVENT_TOUCH_BEGAN)
		listener:registerScriptHandler(OnCardMoved,cc.Handler.EVENT_TOUCH_MOVED)
		listener:registerScriptHandler(OnCardEnded,cc.Handler.EVENT_TOUCH_ENDED)
		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self.Img_Card[i]) --分发监听事件
	end
end

function RubTTZ:showCardOverEvt()
	self:closeView()
end

function RubTTZ:closeView()
	gt.removeTargetAllEventListener(self)
	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:removeEventListenersForTarget(self)
	self:removeFromParent()
end

function RubTTZ:IsOver()
	for i = 1,self.MAX_CARD do
		for j = 1,self.MAX_CARD do
			if i~=j then
				local x1=self.Img_Card[i]:getPositionX()
				local y1=self.Img_Card[i]:getPositionY()
				local x2=self.Img_Card[j]:getPositionX()
				local y2=self.Img_Card[j]:getPositionY()
				local size=self.Img_Card[i]:getContentSize()
				if math.abs(x1-x2)<size.width and math.abs(y1-y2)<size.height then
					return false
				end
			end
		end
	end
	return true
end

function RubTTZ:OnRubOver()
	local pos={
		cc.p(540,150),
		cc.p(740,150)
	}
	for i = 1, #self.Img_Card do
		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:removeEventListenersForTarget(self.Img_Card[i]) --分发监听事件
		self.Img_Card[i]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, pos[i])))
	end
	local func = function()
		gt.dispatchEvent(gt.EventType.RUB_CARD_OVER)
		self:closeView()
	end
	self:runAction(cc.Sequence:create(cc.DelayTime:create(1.1), cc.CallFunc:create(func)))
end

return RubTTZ
