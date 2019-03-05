local ShareSelect = class("ShareSelect", function()
	return gt.createMaskLayer()
end)

local gt = cc.exports.gt

function ShareSelect:ctor(description, title, url)
	-- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))

	local csbNode = cc.CSLoader:createNode("csd/Share.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.rootNode = csbNode

    --注册消息回调
    gt.socketClient:registerMsgListener(gt.SHARE_AWARD, self, self.onRcvShare)

    --关闭按钮
    local btnClose = gt.seekNodeByName(csbNode, "Btn_Close")
    gt.addBtnPressedListener(btnClose, function()
        self:removeFromParent()
    end)

	self.description = description
	self.title = title
	self.url = url
	--分享好友
--	local btn_haoyou = gt.seekNodeByName(self.rootNode, "Btn_ShareToFriend")
--	gt.addBtnPressedListener(btn_haoyou, function()
--		extension.shareToURL(extension.SHARE_TYPE_SESSION, self.title, self.description, self.url)
--		self:removeFromParent()
--	end)
	--分享朋友圈
	local btn_pengyou = gt.seekNodeByName(self.rootNode, "Btn_ShareToCircle")
	gt.addBtnPressedListener(btn_pengyou, function()
		extension.shareToURL(extension.SHARE_TYPE_TIMELINE, self.title .. self.description, "", self.url, handler(self, self.shareCallBack))
	end)

    local imgShare = gt.seekNodeByName(btn_pengyou, "Img_Share")
    if gt.playerData.isShare then
        imgShare:loadTexture("image/share/bg2.png")
        btn_pengyou:setEnabled(false)
    else
        imgShare:loadTexture("image/share/bg1.png")
        btn_pengyou:setEnabled(true)
    end

end

function ShareSelect:shareCallBack(respJson)
	if tonumber(respJson.status) == 1 then	-- 分享成功
		gt.log("分享成功")

		local msgToSend = {}
		msgToSend.cmd = gt.SHARE_AWARD
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		gt.socketClient:sendMessage(msgToSend)
	else
		gt.log("分享失败")
        self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
            require("app/views/NoticeTips"):create("提示", "分享失败", nil, nil, true)
            self:closeView()
        end)))
	end
end

function ShareSelect:onRcvShare(msgTbl)
    if msgTbl.code == 0 then
        gt.playerData.isShare = true
        local strTip = string.format("分享成功，恭喜您获得房卡%d张", msgTbl.award_num)
        require("app/views/NoticeTips"):create("提示", strTip, nil, nil, true)     
	else
		-- 1:会话已过期，请重新登录
		-- 2:账号校验失败，请重新登录
        gt.dispatchEvent(gt.EventType.EXIT_HALL)
    end
    self:closeView()    
end

function ShareSelect:closeView()
    gt.socketClient:unregisterMsgListener(gt.SHARE_AWARD)
    self:removeFromParent()
end

function ShareSelect:onNodeEvent(eventName)
	if "enter" == eventName then
		local listener = cc.EventListenerTouchOneByOne:create()
		listener:setSwallowTouches(true)
		listener:registerScriptHandler(handler(self, self.onTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
		listener:registerScriptHandler(handler(self, self.onTouchEnded), cc.Handler.EVENT_TOUCH_ENDED)
		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
	elseif "exit" == eventName then
		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:removeEventListenersForTarget(self)
	end
end

function ShareSelect:onTouchBegan(touch, event)
	return true
end

function ShareSelect:onTouchEnded(touch, event)
	local bg = gt.seekNodeByName(self.rootNode, "Img_bg")
	if bg then
		local point = bg:convertToNodeSpace(touch:getLocation())
		local rect = cc.rect(0, 0, bg:getContentSize().width, bg:getContentSize().height)
		if not cc.rectContainsPoint(rect, cc.p(point.x, point.y)) then
			self:removeFromParent()
		end
	end
end

return ShareSelect