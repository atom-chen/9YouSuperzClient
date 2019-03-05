
local gt = cc.exports.gt

local UserInfo = class("UserInfo", function()
	return cc.LayerColor:create(cc.c4b(85, 85, 85, 85), gt.winSize.width, gt.winSize.height)
end)

function UserInfo:ctor()
	-- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))

	local csbNode = cc.CSLoader:createNode("UserInfo.csb")
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.rootNode = csbNode

	local isCorrect = true
	--取消
	local cancel = gt.seekNodeByName(csbNode, "Button_cancel")
	gt.addBtnPressedListener(cancel, function()
		self:removeFromParent()
	end)

	--姓名
	local inputName = gt.seekNodeByName(csbNode, "TextField_name")
	inputName:setPlaceHolderColor(cc.c3b(255,255,255))

	--电话
	local inputTel = gt.seekNodeByName(csbNode, "TextField_tel")
	inputTel:setPlaceHolderColor(cc.c3b(255,255,255))

	--地址
	local inputAddress = gt.seekNodeByName(csbNode, "TextField_address")
	inputAddress:setPlaceHolderColor(cc.c3b(255,255,255))

	--提交
	local submit = gt.seekNodeByName(csbNode, "Button_submit")
	gt.addBtnPressedListener(submit, function()
		--姓名
		local inputName = gt.seekNodeByName(csbNode, "TextField_name")
		local name = inputName:getString()
		--电话
		local inputTel = gt.seekNodeByName(csbNode, "TextField_tel")
		local tel = inputTel:getString()
		--地址
		local inputAddress = gt.seekNodeByName(csbNode, "TextField_address")
		local address = inputAddress:getString()
		local msgToSend = {}
		msgToSend.cmd = gt.USER_INFO
		msgToSend.m_NameStr = name
		msgToSend.m_PhoneNumStr = tel
		msgToSend.m_AddressStr = address
		if name == "" or tel == "" or  address == "" then
			--信息不完整提示
			require("app/views/NoticeTips"):create("温馨提示", "信息不全,报名失败!", nil, nil, true)
		else
			for i=1, inputTel:getStringLength() do
				local telNum = string.sub(tel,i,i)
				local tempNum = string.byte(telNum)
				if tempNum < 48 or tempNum > 57 then
					require("app/views/NoticeTips"):create("温馨提示", "电话号码填写错误!", nil, nil, true)
					isCorrect = false
					break
				end
			end
			--成功提示
			if isCorrect == true then
				gt.socketClient:sendMessage(msgToSend)
				require("app/views/NoticeTips"):create("温馨提示", "恭喜您报名成功!", nil, nil, true)
			end
			
		end
		self:getParent():removeFromParent()
		gt.log("infoinfoinfoinfo")
		dump(msgToSend)
	end)



end

function UserInfo:onNodeEvent(eventName)
	if "enter" == eventName then
		local listener = cc.EventListenerTouchOneByOne:create()
		listener:setSwallowTouches(true)
		listener:registerScriptHandler(handler(self, self.onTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
		-- listener:registerScriptHandler(handler(self, self.onTouchEnded), cc.Handler.EVENT_TOUCH_ENDED)
		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
	elseif "exit" == eventName then
		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:removeEventListenersForTarget(self)
	end
end

function UserInfo:onTouchBegan(touch, event)
	return true
end

function UserInfo:onTouchEnded(touch, event)
	self:removeFromParent()
end

return UserInfo



