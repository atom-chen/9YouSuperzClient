--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local gt = cc.exports.gt

local DismissRoom = class("DismissRoom", function()
	return gt.createMaskLayer()
end)

function DismissRoom:ctor(isTwelve)
    -- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))

	local csbNode = cc.CSLoader:createNode("csd/DimissRoom.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.rootNode = csbNode

	if isTwelve then
		csbNode:getChildByName("Img_Bg"):setRotation(-90)
	end

    local btnQuxiao = gt.seekNodeByName(csbNode, "Btn_Cancel")
    gt.addBtnPressedListener(btnQuxiao, function()
        self:removeFromParent()
    end)

    local btnOk = gt.seekNodeByName(csbNode, "Btn_Ok")
    gt.addBtnPressedListener(btnOk, function()
        local msgToSend = {}
		msgToSend.cmd = gt.DISMISS_ROOM
		gt.socketClient:sendMessage(msgToSend)
		self:removeFromParent()
    end)
end

return DismissRoom
--endregion
