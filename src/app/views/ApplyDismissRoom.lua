
local ApplyDismissRoom = class("ApplyDismissRoom", function()
	return gt.createMaskLayer()
end)

function ApplyDismissRoom:ctor(msgTbl, isWait , isTwelve)
	-- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))
	dump(isWait)

	local csbName = "csd/ApplyDismissRoom.csb"
	if isTwelve then
		csbName = "csd/ApplyDismissRoomTwelve.csb"
	end
	local csbNode = cc.CSLoader:createNode(csbName)
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)

	self.rootNode = csbNode
	self.players = {}
    if isWait == nil then
        isWait = false
    end
	-- 同意
	self.agreeBtn = gt.seekNodeByName(self.rootNode, "Btn_Agree")
	self.agreeBtn:setTag(1)
	gt.addBtnPressedListener(self.agreeBtn, handler(self, self.buttonClickEvt))

	-- 拒绝
	self.refuseBtn = gt.seekNodeByName(self.rootNode, "Btn_Refuse")
	self.refuseBtn:setTag(0)
	gt.addBtnPressedListener(self.refuseBtn, handler(self, self.buttonClickEvt))

	local sponsor = msgTbl.sponsor
	self.players = msgTbl.players

	-- 倒计时初始化
	self.dimissTimeCD = msgTbl.seconds or msgTbl.expire_seconds
	--[[ --]]
	local dismissTimeCDLabel = gt.seekNodeByName(self.rootNode, "Text_Countdown")
	dismissTimeCDLabel:setString(tostring(self.dimissTimeCD))

	-- 玩家列表初始化
	local idx = 1
	for i, v in ipairs(msgTbl.players) do
		if v.uid == sponsor then
			gt.seekNodeByName(self.rootNode, "Label_Sponsor"):setString(gt.getLocationString("LTKey_0023", v.nickname))
		else
			local imgHead = gt.seekNodeByName(self.rootNode, "Img_Head_"..idx)
			imgHead:setTag(v.uid)
			gt.seekNodeByName(imgHead, "Label_Nick"):setString(gt.checkName(v.nickname, 5))
			gt.seekNodeByName(imgHead, "Label_State"):setString(gt.getLocationString("LTKey_0024"))
			idx = idx + 1
		end
	end

	for i = idx, 11 do
		local imgHead = gt.seekNodeByName(self.rootNode, "Img_Head_"..i)
		if imgHead then
			imgHead:setTag(0)
			imgHead:setVisible(false)
		end
	end

	if isWait or sponsor == gt.playerData.uid then
		self.agreeBtn:setVisible(false)
		self.refuseBtn:setVisible(false)
    end
end

function ApplyDismissRoom:onNodeEvent(eventName)
	if "enter" == eventName then
		self.scheduleHandler = gt.scheduler:scheduleScriptFunc(handler(self, self.update), 0, false)
		-- 注册解散房间事件
		gt.registerEventListener(gt.EventType.APPLY_DIMISS_ROOM, self, self.dismissRoomEvt)
        -- 注册关闭解散房间事件
        gt.registerEventListener(gt.EventType.CLOSE_APPLY_DISMISSROOM, self, self.closeDismissRoom)
	elseif "exit" == eventName then
		gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
		-- 事件回调
		gt.removeTargetAllEventListener(self)
	end
end

-- start --
--------------------------------
-- @class function
-- @description 更新解散房间倒计时
-- end --
function ApplyDismissRoom:update(delta)
	if not self.rootNode or not self.dimissTimeCD then
		return
	end

	self.dimissTimeCD = self.dimissTimeCD - delta
	if self.dimissTimeCD < 0 then
		self.dimissTimeCD = 0

		self:closeDismissRoom()
	end
	if self.dimissTimeCD == nil then
		return
	end
	local timeCD = math.ceil(tonumber(self.dimissTimeCD))
	--[[ --]]
	local dismissTimeCDLabel = gt.seekNodeByName(self.rootNode, "Text_Countdown")
	dismissTimeCDLabel:setString(tostring(timeCD))
end

-- start --
--------------------------------
-- @class function
-- @description 接收解散房间消息事件ReadyPlay接收消息以事件方式发送过来
-- @param eventType
-- @param msgTbl
-- end --
function ApplyDismissRoom:dismissRoomEvt(eventType, msgTbl)
	if msgTbl.cmd == gt.VOTE then
		for i = 1, 11 do
			local imgHead = gt.seekNodeByName(self.rootNode, "Img_Head_"..i)
			if imgHead and imgHead:getTag() == msgTbl.player and msgTbl.flag then
				gt.seekNodeByName(imgHead, "Label_State"):setString(gt.getLocationString("LTKey_0025"))
			end
		end

		if msgTbl.player == gt.playerData.uid then
			self.agreeBtn:setVisible(false)
			self.refuseBtn:setVisible(false)
		end

		if not msgTbl.flag then
			local refuser = ""
			for i, v in ipairs(self.players) do
				if v.uid == msgTbl.player then
					refuser = v.nickname
				end
			end
			-- 有一个人拒绝，解散失败
            local strTip = gt.getLocationString("LTKey_0026", refuser)
            require("app/views/CommonTips"):create(strTip)
            self:removeFromParent()
--			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"),
--				gt.getLocationString("LTKey_0026", refuser),
--				function()
--					self:removeFromParent()
--				end, nil, true)
		end
	end
end

function ApplyDismissRoom:closeDismissRoom()
    self:removeFromParent()
end

function ApplyDismissRoom:buttonClickEvt(sender)
	self.agreeBtn:setVisible(false)
	self.refuseBtn:setVisible(false)
	
	local msgToSend = {}
	msgToSend.cmd = gt.VOTE
	msgToSend.flag = true
	if sender:getTag() == 0 then
		msgToSend.flag = false
	end
	gt.socketClient:sendMessage(msgToSend)
end

return ApplyDismissRoom

