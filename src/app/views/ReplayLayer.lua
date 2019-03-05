

local gt = cc.exports.gt

local ReplayLayer = class("ReplayLayer", function()
	return cc.Layer:create()
end)

function ReplayLayer:ctor(replayData,flag)
	gt.log("rrrrrrdfdfdfddf1111111",gt.playerData.uid)
	dump(replayData)
	-- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))
	-- local csbNode = cc.CSLoader:createNode("ReplayLayer.csb")
		-- 玩家操作记录
	self.replayStepsData = replayData.m_oper
	-- 容错处理，默认1
	self.playerSeatIdx = 1

	-- 加载界面资源
	local csbNode
	if replayData.m_state == 0 or replayData.m_state == 1 then
		csbNode = cc.CSLoader:createNode("ReplayLayer.csb")
	elseif replayData.m_state == 2 or replayData.m_state == 3  then
		
		if flag == false then
			csbNode = cc.CSLoader:createNode("ReplayLayerT.csb")
		end

		for seatIdx, uid in ipairs(replayData.m_userid) do
			if gt.playerData.uid == uid then
				-- self.playerSeatIdx = seatIdx
				if seatIdx == 2 then
					csbNode = cc.CSLoader:createNode("ReplayLayerT_0.csb")
					gt.log("hhhhhhhhhhhhhhhhhhhhhhhhh")
				elseif seatIdx == 1 then
					csbNode = cc.CSLoader:createNode("ReplayLayerT.csb")
					gt.log("hhhhhhhhhhhhhhhhhhhhhhhhh1111111")
				end
				break
			end
		end
	end
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.rootNode = csbNode
	
	-- 桌号
	-- replayData.m_deskId

	-- 时间
	--replayData.m_time
	self.time_now = replayData.m_time
	gt.log("----------nowtime---------",replayData.m_time)
	self.holdTime = 0
	self:updateCurrentTime()

	-- 玩家id
	-- replayData.m_userid

	-- 玩家昵称
	-- replayData.m_nike

	-- 玩家性别
	-- replayData.m_sex

	-- 玩家积分
	-- replayData.m_score

	-- 玩家头像
	-- replayData.m_imageUrl

	-- 1号位置牌
	-- replayData.m_card0

	-- 2号位置牌
	-- replayData.m_card1

	-- 3号位置牌
	-- replayData.m_card2
	for seatIdx, uid in ipairs(replayData.m_userid) do
		if gt.playerData.uid == uid then
			self.playerSeatIdx = seatIdx

				-- if replayData.m_state == 0 or replayData.m_state == 1 then
				-- 	self.playerFixDispSeat = 3
				-- elseif replayData.m_state == 2 or replayData.m_state == 3  then
				-- 	self.playerFixDispSeat = 2
				-- end
				self.playerFixDispSeat = 3
		
			-- 逻辑座位和显示座位偏移量(从0编号开始)
			local seatOffset = (self.playerFixDispSeat - 1) - (seatIdx - 1)
			self.seatOffset = seatOffset
			break
		end
	end



	local paramTbl = {}
	paramTbl.roomID = replayData.m_deskId
	paramTbl.playerSeatIdx = self.playerSeatIdx

	self.m_text_progress = gt.seekNodeByName(csbNode,"Text_progress")
	self:initRoomPlayersData(replayData)
	self.replayData = replayData

	self.isPause = false
	local optBtnsSpr = gt.seekNodeByName(csbNode, "Spr_optBtns")
	-- 播放按键
	local playBtn = gt.seekNodeByName(optBtnsSpr, "Btn_play")
	playBtn:setVisible(false)
	self.playBtn = playBtn
	
	-- 暂停
	local pauseBtn = gt.seekNodeByName(optBtnsSpr, "Btn_pause")
	self.pauseBtn = pauseBtn
	gt.addBtnPressedListener(playBtn, function()
		self:setPause(false)
	end)
	gt.addBtnPressedListener(pauseBtn, function()
		self:setPause(true)
	end)

	-- 退出
	local exitBtn = gt.seekNodeByName(optBtnsSpr, "Btn_exit")
	gt.addBtnPressedListener(exitBtn, function()
		self:removeFromParent()
	end)

	--前进
	local nextBtn = gt.seekNodeByName(optBtnsSpr, "Btn_next")
	gt.addBtnPressedListener(nextBtn,function ()
		self:nextRound()
	end)

	--后退
	local preBtn = gt.seekNodeByName(optBtnsSpr, "Btn_pre")
	gt.addBtnPressedListener(preBtn,function ()
		self:preRound()
	end)

	-- 快进或者快退的步数
	self.quickStepNum	= 1
	-- 点击快进/快退开始的时间
	self.quickStartTime = 0

end

function ReplayLayer:onNodeEvent(eventName)
	if "enter" == eventName then
		local listener = cc.EventListenerTouchOneByOne:create()
		listener:setSwallowTouches(true)
		listener:registerScriptHandler(handler(self, self.onTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)

		-- 逻辑更新定时器
		self.scheduleHandler = gt.scheduler:scheduleScriptFunc(handler(self, self.update), 0, false)
	elseif "exit" == eventName then
		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:removeEventListenersForTarget(self)

		gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
	end
end

function ReplayLayer:onTouchBegan(touch, event)
	return true
end

-- 快推的话,原理是将牌恢复到最初始状态
-- 然后快速行进到当前状态
function ReplayLayer:preRound()
	if self.curReplayStep <= 1 then
		return
	end

	self.quickStartTime = os.time()

	-- 计算回退到何步骤
	local wihldReplayStep = self.curReplayStep - self.quickStepNum - 1
	if wihldReplayStep < 0 then
		wihldReplayStep = 0
	end

	-- 清理桌面上的牌
	self:initRoomPlayersData(self.replayData)
	-- 步数设置为1
	self.curReplayStep = 1

	for i = 1,wihldReplayStep do
		if not self.isReplayFinish then
			self:doAction( self.curReplayStep, true, true )
		end
	end

end

-- 快速回合播放
function ReplayLayer:nextRound()
	self.quickStartTime = os.time()

	for i = 1,self.quickStepNum do
		if not self.isReplayFinish then
			self:doAction( self.curReplayStep, true )
		end
	end
end

function ReplayLayer:doAction(curReplayStep, isQuick, isPre )
	local replayStepData = self.replayStepsData[self.curReplayStep]
	if replayStepData then
		local seatIdx = replayStepData[1] + 1
		local optType = replayStepData[2]
		local card = replayStepData[3]

		self.curReplayStep = self.curReplayStep + 1
		
		if self.curReplayStep > #self.replayStepsData then
			self.isReplayFinish = true
			self.curReplayStep = #self.replayStepsData
		end
	end

	self:updateProgress()
end

function ReplayLayer:updateProgress()
	local amount = #self.replayStepsData
	if amount == nil or self.curReplayStep == nil then
		return false
	end

	if self.curReplayStep > amount then
		self.curReplayStep = amount
	end

	local number = string.format("%0" .. string.len(amount) .. "d", self.curReplayStep)
	self.m_text_progress:setString("进度:" .. number .. "/" .. amount)

end


function ReplayLayer:update(delta)
	if self.isPause or self.isReplayFinish then
		return
	end

	if os.time() - self.quickStartTime < 2 then-- 如果已经有2s没有触摸快进/快退按钮了,那么可以播放自动录像了
		return
	end

	self.holdTime = self.holdTime + delta
	self:updateCurrentTime()

	self.showDelayTime = self.showDelayTime + delta
	if self.showDelayTime > 1.5 then
		self.showDelayTime = 0

		self:doAction(self.curReplayStep)
	end
end

function ReplayLayer:initRoomPlayersData(replayData)
	for seatIdx, uid in ipairs(replayData.m_userid) do
		local roomPlayer = {}
		roomPlayer.seatIdx = seatIdx
		roomPlayer.uid = uid
		roomPlayer.nickname = replayData.m_nike[seatIdx]
		roomPlayer.headURL = replayData.m_imageUrl[seatIdx]
		roomPlayer.sex = replayData.m_sex[seatIdx]
		roomPlayer.score = replayData.m_score[seatIdx]

	end

	self.curReplayStep = 1
	self.showDelayTime = 2
	self.isReplayFinish = false
	self:updateProgress()
end

function ReplayLayer:setPause(isPause)
	self.isPause = isPause

	self.pauseBtn:setVisible(not isPause)
	self.playBtn:setVisible(isPause)
end

function ReplayLayer:updateCurrentTime()
	local presentTime = math.ceil(self.time_now+self.holdTime)

	local curTimeStr = os.date("%X", presentTime)
	local timeSections = string.split(curTimeStr, ":")
	local timeLabel = gt.seekNodeByName(self, "Label_time")
	--timeLabel:setVisible(false)

	-- 时:分
	timeLabel:setString(string.format("%s:%s", timeSections[1], timeSections[2]))
end

return ReplayLayer

