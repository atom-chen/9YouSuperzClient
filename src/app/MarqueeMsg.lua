
local gt = cc.exports.gt

local MarqueeMsg = class("MarqueeMsg", function()
	return cc.CSLoader:createNode("csd/MarqueeBar.csb")
end)

function MarqueeMsg:ctor()
	self:registerScriptHandler(handler(self, self.onNodeEvent))

	self.msgText = ""
	self.showNextMsg = true
end

function MarqueeMsg:onNodeEvent(eventName)
	if "enter" == eventName then
		self.scheduleHandler = gt.scheduler:scheduleScriptFunc(handler(self, self.update), 0, false)
	elseif "exit" == eventName then
		gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
	end
end

function MarqueeMsg:update(delta)
	if not self.showNextMsg then
		return
	end

	if string.len(self.msgText) == 0 then
		return
	end

	self.showNextMsg = false

	local msgText = self.msgText

	local msgBarPanel = gt.seekNodeByName(self, "Panel_Bar")
	local barSize = msgBarPanel:getContentSize()
	local msgContentLabel = gt.createTTFLabel(msgText, 22)
	local textWidth = msgContentLabel:getContentSize().width
	msgContentLabel:setPosition(barSize.width + textWidth * 0.5, barSize.height * 0.5)

	msgBarPanel:addChild(msgContentLabel)

	msgContentLabel:stopAllActions()
	local moveToAction = cc.MoveTo:create(30, cc.p(-textWidth * 0.5, barSize.height * 0.5))
	local callFunc = cc.CallFunc:create(function(sender)
		self.showNextMsg = true
		sender:removeFromParent()

	end)
	msgContentLabel:setTextColor(cc.c3b(209, 219, 226))
	msgContentLabel:runAction(cc.Sequence:create(moveToAction, callFunc))
end

function MarqueeMsg:showMsg(msgText)
	if not msgText or string.len(msgText) == 0 then
		return
	end
	self:setVisible(true)

	self.msgText = msgText
end

return MarqueeMsg

