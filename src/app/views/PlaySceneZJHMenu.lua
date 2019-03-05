--[[
-- Huwenliang
-- 2017/12/27 18:40
-- 把场景中设置、聊天、语音、规则、信号、电量、时间相关控制代码转移到此
-- 减少场景文件代码量，方便维护
--]]

local gt = cc.exports.gt
local YvYin_Node = require("app/views/YvYinNode")


local PlaySceneZJHMenu = class("PlaySceneZJHMenu")

function PlaySceneZJHMenu:ctor(superNode,rootNode)
    --场景节点
    self.superNode = superNode
    --csb根节点
    self.rootNode = rootNode

    self.roomPlayers = self.superNode.roomPlayers
    self.playerSeatIdx = self.superNode.playerSeatIdx
    self.isMatch = self.superNode.isMatch
    
    
    --聊天记录
	self.ChatLog = {}
    --语音聊天互动CD时间
    self.chatCD = 5
    --表情动作计时
    gt.playerData.emojiActTime = 0
    --初始化
    self:init()
    -- 注册节点事件
	self.rootNode:registerScriptHandler(handler(self, self.onNodeEvent))
end

function PlaySceneZJHMenu:init()
    --处理按钮
    self:handleBtns()
    --处理聊天
    self:handleChatBg()
    --处理语音
    self:handleVoice()
    self:registerMsgLister()
end

function PlaySceneZJHMenu:registerMsgLister()
	gt.socketClient:registerMsgListener(gt.SPEAKER, self, self.onRcvChatMsg)
end

function PlaySceneZJHMenu:unregisterMsgLister()
	gt.socketClient:unregisterMsgListener(gt.SPEAKER)
end

function PlaySceneZJHMenu:onNodeEvent(eventName)
	if "enter" == eventName then
		-- 计算更新当前时间倒计时
		local curTimeStr = os.date("%X", os.time())
		local timeSections = string.split(curTimeStr, ":")
		local secondTime = tonumber(timeSections[3])
		self.updateTimeCD = 60 - secondTime
		self:updateCurrentTime()
		self.updateBatteryAndNetworkCD = 5
		self:updateBatteryAndNetwork()

		-- 逻辑更新定时器
		self.scheduleHandler = gt.scheduler:scheduleScriptFunc(handler(self, self.update), 0.1, false)
	elseif "exit" == eventName then
        self:unregisterMsgLister()
		gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
	end
end

function PlaySceneZJHMenu:update(delta)
	self.updateTimeCD = self.updateTimeCD - delta
	if self.updateTimeCD <= 0 then
		self.updateTimeCD = 60
		self:updateCurrentTime()
	end
	 self.updateBatteryAndNetworkCD = self.updateBatteryAndNetworkCD - delta
	 if self.updateBatteryAndNetworkCD <= 0 then
	 	self.updateBatteryAndNetworkCD = 5
	 	self:updateBatteryAndNetwork()
	 end
end

function PlaySceneZJHMenu:handleBtns()
    --添加设置
    self.settingBtn = gt.seekNodeByName(self.rootNode, "Btn_setting")
	gt.addBtnPressedListener(self.settingBtn, function()
		local playerState_ = -1
		if self.superNode.roomPlayers and self.superNode.roomPlayers[self.superNode.playerSeatIdx] then
			if self.superNode.roomPlayers[self.superNode.playerSeatIdx].state == 9 then
				playerState_ = 1
			end
		end

		local param = {isMatch = self.isMatch, playerState= playerState_, isWait=self.superNode.isWait, roomState=self.superNode.roomState, curRound=self.superNode.curRound, owner=self.superNode:isRoomOwner(),sport_id=self.superNode.sport_id}
        local settingPanel = require("app/views/Setting"):create(param, 1)
		self.superNode:addChild(settingPanel, 18)
	end)

     -- 房间信息按钮
    local btnInfo = gt.seekNodeByName(self.rootNode, "Btn_Info")
    gt.addBtnPressedListener(btnInfo, handler(self, self.infoBtnClickEvt))
end

-- 房间信息按钮回调
function PlaySceneZJHMenu:infoBtnClickEvt()
    local roomInfo = require("app/views/RoomInfo"):create(self.superNode.tableSetting)
	self.superNode:addChild(roomInfo, 18)
end

function PlaySceneZJHMenu:handleChatBg()
    -- 聊天背景
	local chatBgNode = gt.seekNodeByName(self.rootNode, "Node_chatBg")
    self.chat_bg_pos = {}
    for i = 1, self.superNode.roomChairs do
		local nodeChatBg = gt.seekNodeByName(chatBgNode, "Node_PlayerChatBg_" .. i)
        local imgChatBg = gt.seekNodeByName(nodeChatBg, "Img_playerChatBg")
		nodeChatBg:setVisible(false)

        local emojiNode = gt.seekNodeByName(chatBgNode, "Node_Emoji_"..i)
        emojiNode:setVisible(false)
        self.chat_bg_pos[i] = cc.p(nodeChatBg:getPosition())
	end

    self.chatBtn = gt.seekNodeByName(self.rootNode, "Btn_Chat")
    self.chatBtn:setVisible(false)
	gt.addBtnPressedListener(self.chatBtn, function()
		local chatPanel
		if #self.ChatLog > 0 then
			chatPanel = require("app/views/ChatPanel"):create(self.ChatLog, false, self.superNode.is_shutup)
		else
		 	chatPanel = require("app/views/ChatPanel"):create(false, false, self.superNode.is_shutup)
		end
		chatPanel:setPosition(0,0)
		self.superNode:addChild(chatPanel, 20)
	end)
end

function PlaySceneZJHMenu:showChatBtns(isVisible)
   if isVisible == nil then 
        isVisible = true
   end
   self.chatBtn:setVisible(isVisible)
   self.yuyinBtn:setVisible(isVisible)
end

--语音，表情，文字消息
function PlaySceneZJHMenu:onRcvChatMsg(msgTbl)

	local weizhi = 0
    local seatIdx = msgTbl.seat + 1

	local function CDTime(imgPath,pos,parent)
		local sp = cc.Sprite:create(imgPath)
		local progressTimer = cc.ProgressTimer:create(sp)
		parent:addChild(progressTimer)
		progressTimer:setPosition(pos)
		progressTimer:setBarChangeRate(cc.p(1,0))
		progressTimer:setMidpoint(cc.p(1,0))
		progressTimer:setType(kCCProgressTimerTypeBar)
		local delayTime = cc.DelayTime:create(self.chatCD)
		local callFunc = cc.CallFunc:create(function(sender)
			sender:setEnabled(true)
		end)
		local seq = cc.Sequence:create(delayTime,callFunc)
		parent:runAction(seq)
		progressTimer:runAction(cc.Sequence:create(cc.ProgressFromTo:create(self.chatCD,100,0),cc.RemoveSelf:create()))
	end
	
	if msgTbl.type == gt.ChatType.VOICE_MSG then
		--语音
		gt.soundEngine:pauseAllSound()
		local url = msgTbl.url
		local videoTime = msgTbl.time / 1000.0
		self.yuyinChatNode:setVisible(true)
		self.rootNode:reorderChild(self.yuyinChatNode, 110)
		for i = 1, self.superNode.roomChairs do
			local chatBgImg = gt.seekNodeByName(self.yuyinChatNode, "Image_" .. i)
			chatBgImg:setVisible(false)
		end
		local roomPlayer = self.superNode.roomPlayers[seatIdx]
		if roomPlayer then
			local chatBgImg = gt.seekNodeByName(self.yuyinChatNode, "Image_" .. roomPlayer.displaySeatIdx)
			chatBgImg:setVisible(true)
		end
		self.yuyinChatNode:stopAllActions()
		local fadeInAction = cc.FadeIn:create(0.5)
		local delayTime = cc.DelayTime:create(videoTime)
		local fadeOutAction = cc.FadeOut:create(0.5)
		local callFunc = cc.CallFunc:create(function(sender)
			sender:setVisible(false)
			gt.soundEngine:resumeAllSound()
		end)
		self.yuyinChatNode:runAction(cc.Sequence:create(fadeInAction, delayTime, fadeOutAction, callFunc))
		extension.voicePlay(nil, url)
		--语音CD
		local path = "image/play/btn_voice_hui.png"
		local position = cc.p(self.yuyinBtn:getContentSize().width / 2,self.yuyinBtn:getContentSize().height / 2)
		CDTime(path,position,self.yuyinBtn)
		--扔表情特效
    elseif msgTbl.type == gt.ChatType.ACT_EMOJI then
        if cc.UserDefault:getInstance():getStringForKey("showProp") ~= "false" then
			self:showEmojiAnimation(msgTbl.msg, seatIdx, msgTbl.id, msgTbl.user_id)
		end
	else
		local chatBgNode = gt.seekNodeByName(self.rootNode, "Node_chatBg")
		chatBgNode:setVisible(true)
		local roomPlayer = self.superNode:GetPlayerBySeatIdx(seatIdx)
		if not roomPlayer then return end
	
		local nodeChatBg = gt.seekNodeByName(chatBgNode, "Node_PlayerChatBg_" .. roomPlayer.displaySeatIdx)
        local emojiNode = gt.seekNodeByName(chatBgNode, "Node_Emoji_" .. roomPlayer.displaySeatIdx)
		local textContend = gt.seekNodeByName(nodeChatBg, "Text_Contend")
        local imgChatBg = gt.seekNodeByName(nodeChatBg, "Img_playerChatBg")
		weizhi = roomPlayer.displaySeatIdx
        local talk = {}
        local isTextMsg = false
        local isEmojiMsg = false

        --文字
        if msgTbl.type == gt.ChatType.FIX_MSG or msgTbl.type == gt.ChatType.INPUT_MSG then
            nodeChatBg:setVisible(true)
            emojiNode:setVisible(false)
            textContend:setString(msgTbl.msg)
            isTextMsg = true
            isEmojiMsg = false
            talk.type = msgTbl.type
            talk.nick = roomPlayer.nickname ..":"
            talk.content = string.format("%s", msgTbl.msg)
            if #self.ChatLog > 49 then
				table.remove(self.ChatLog,1)
			end
			table.insert(self.ChatLog, talk)
            if msgTbl.type == gt.ChatType.FIX_MSG then
                local playerFixEffect = "man/f"
                --local playerMe = self.superNode.roomPlayers[self.superNode.playerSeatIdx]
                if roomPlayer.sex == 2 then
                    playerFixEffect = "woman/f"
                end
                for i = 1 ,6 do
                    if msgTbl.msg == gt.getLocationString("LTKey_0028_" .. i) then
                        gt.soundEngine:playEffect(playerFixEffect..i, false)
                        break
                    end
                end
            end
        --表情
        elseif msgTbl.type == gt.ChatType.EMOJI then
            emojiNode:setVisible(true)
            nodeChatBg:setVisible(false)
            ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("image/Chat/emoji/"..msgTbl.msg..".ExportJson")
	        local ar = ccs.Armature:create(msgTbl.msg)
            ar:getAnimation():play("Animation2")
            ar:setScale(0.7)
            gt.soundEngine:playEffect("chat/"..msgTbl.msg, false)
	        emojiNode:addChild(ar)
            isTextMsg = false
            isEmojiMsg = true
            talk.type = msgTbl.type
            talk.nick = roomPlayer.nickname ..":"
            talk.content = string.format("%s", msgTbl.msg)
            if #self.ChatLog > 49 then
				table.remove(self.ChatLog,1)
			end
			table.insert(self.ChatLog, talk)
        end

		if isTextMsg == true then
            nodeChatBg:stopAllActions()
            nodeChatBg:setPosition(self.chat_bg_pos[roomPlayer.displaySeatIdx].x, self.chat_bg_pos[roomPlayer.displaySeatIdx].y)
            nodeChatBg:runAction(cc.FadeIn:create(0.01))
			local msgLabel_delayTime1 = cc.DelayTime:create(1)
			local msgLabel_moveto = cc.MoveTo:create(1,cc.p(self.chat_bg_pos[roomPlayer.displaySeatIdx].x, self.chat_bg_pos[roomPlayer.displaySeatIdx].y + 25))
            local msgLabel_delayTime2 = cc.DelayTime:create(1)
            local msgLabel_fadeout = cc.FadeOut:create(1)
            local msgLabel_dismiss = cc.Spawn:create(msgLabel_delayTime2, msgLabel_fadeout)
			local msgLabel_callFunc = cc.CallFunc:create(function(sender)
				nodeChatBg:setVisible(false)
			end)
			local msgLabel_Sequence = cc.Sequence:create(msgLabel_delayTime1,
                                                        msgLabel_moveto,
														msgLabel_dismiss, 
														msgLabel_callFunc,
                                                        msgLabel_fadein)
			nodeChatBg:runAction(msgLabel_Sequence)
        elseif isEmojiMsg == true then
            local msgLabel_delayTime = cc.DelayTime:create(2)
			local msgLabel_callFunc = cc.CallFunc:create(function(sender)
				sender:setVisible(false)
                sender:removeAllChildren()
			end)
			local msgLabel_Sequence = cc.Sequence:create(msgLabel_delayTime,
														msgLabel_callFunc)
            emojiNode:setVisible(true)
            emojiNode:runAction(msgLabel_Sequence)
		end
	end

	if weizhi == 1 then
		self.chatBtn:setEnabled(false)
		CDTime("image/play/btn_chat_hui.png",cc.p(self.chatBtn:getContentSize().width / 2,self.chatBtn:getContentSize().height / 2),self.chatBtn)
	end 
end

function PlaySceneZJHMenu:showEmojiAnimation(emojiAnimation, seatIdxStart, id, user_id)
    local function call_back(sender)
        gt.soundEngine:playEffect("emoji_act/"..emojiAnimation, false)
        local aniNode, action = gt.createCSAnimation("image/play/mj_biaoqingefect/"..emojiAnimation..".csb")
		action:gotoFrameAndPlay(0,false)
        action:setFrameEventCallFunc(function (frameEventName)
            local frameName = frameEventName:getEvent()
            if (frameName == "endAni") then
                aniNode:removeFromParent()
            end
        end)
        sender:addChild(aniNode)
    end

    local startPlayer = self.superNode:GetPlayerBySeatIdx(seatIdxStart)
    if startPlayer then
	    local playerNodeStart = gt.seekNodeByName(self.rootNode, "Node_playerInfo_" .. startPlayer.displaySeatIdx)
	    local pos1 = cc.p(playerNodeStart:getPosition())


	    local seatIdxEnd = nil
	    for seatIdx, roomPlayer in pairs(self.superNode.roomPlayers) do
	        if roomPlayer.uid == id then
	            seatIdxEnd = roomPlayer.displaySeatIdx
	        end
	    end
	    local playerNodeEnd = gt.seekNodeByName(self.rootNode, "Node_playerInfo_" .. seatIdxEnd)
	    local pos2 = cc.p(playerNodeEnd:getPosition())
		pos1.x = pos1.x + gt.OffsetX
		pos1.y = pos1.y + gt.OffsetY
		pos2.x = pos2.x + gt.OffsetX
		pos2.y = pos2.y + gt.OffsetY
	    if emojiAnimation ~= "gunshootFX_hit" then
	        display.loadSpriteFrames("image/play/emoji/emoji.plist", "image/play/emoji/emoji.png")
	        local imgEmoji = cc.Sprite:createWithSpriteFrameName("image/play/emoji/".. emojiAnimation ..".png")
	        imgEmoji:setPosition(pos1)
	      
	        imgEmoji:setLocalZOrder(100)
	        self.rootNode:addChild(imgEmoji)
	        imgEmoji:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, pos2), cc.DelayTime:create(0.1), cc.RemoveSelf:create()))
	    end
	    local actionNode = cc.Node:create()
	    actionNode:setPosition(pos2)
	    actionNode:setLocalZOrder(100)
	    self.rootNode:addChild(actionNode)
	    actionNode:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(call_back), cc.DelayTime:create(3), cc.RemoveSelf:create()))
	end
end

function PlaySceneZJHMenu:handleVoice()
    --语音按钮
	self.yuyinBtn = gt.seekNodeByName(self.rootNode, "Btn_Voice")
    self.yuyinBtn:setVisible(false)
	--发送语音提示
	local yuyinNode = gt.seekNodeByName(self.rootNode, "Node_yuyin")
	yuyinNode:setLocalZOrder(1000)
	if yuyinNode then
		yuyinNode:setVisible(true)
		
		self.YvYin_Node = YvYin_Node:create()
		self.YvYin_Node:setAnchorPoint(0.5, 0.5)
		self.YvYin_Node:setCallback(function( state )
			self:stopAudio()
		end)
		yuyinNode:addChild(self.YvYin_Node)
	end
	-- 语音聊天喇叭
	self.yuyinChatNode = gt.seekNodeByName(self.rootNode, "Node_Yuyin_Dlg")
	self.yuyinChatNode:setLocalZOrder(20)
	self.yuyinChatNode:setVisible(false)

	--语音点击回调
	local function touchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
			if 1 == self.superNode.is_shutup then
				require("app/views/CommonTips"):create("管理员已禁止语音聊天", 2)
				return
			end
            self.yuyinBtn:stopAllActions()
	        gt.soundEngine:pauseAllSound()
	        self:startAudio()
	        self.YvYin_Node:setState(YvYin_Node.YVYIN)
        elseif eventType == ccui.TouchEventType.moved then
        	if math.abs(sender:getTouchBeganPosition().y - sender:getTouchMovePosition().y) >= 100 then
		        self.YvYin_Node:setState(YvYin_Node.QVXIAO)
		    end
        elseif eventType == ccui.TouchEventType.ended then
	    	gt.soundEngine:resumeAllSound()
	    	if self.YvYin_Node:getState() == YvYin_Node.QVXIAO then
	    		self:stopAudio(true)
	    	elseif self.YvYin_Node:getState() == YvYin_Node.YVYIN then
	    		self:stopAudio(false)
	    	end
	    	self.YvYin_Node:setState(YvYin_Node.YINCANG)
        elseif eventType == ccui.TouchEventType.canceled then
            gt.soundEngine:resumeAllSound()
		    self:stopAudio(true)
		    self.YvYin_Node:setState(YvYin_Node.YINCANG)
        end
    end
	self.yuyinBtn:addTouchEventListener(touchEvent)
end

--更新当前时间
function PlaySceneZJHMenu:updateCurrentTime()
	local timeLabel = gt.seekNodeByName(self.rootNode, "Label_Time")
	local curTimeStr = os.date("%X", os.time())
	local timeSections = string.split(curTimeStr, ":")
	-- 时:分
	timeLabel:setString(string.format("%s:%s", timeSections[1], timeSections[2]))
end

--更新电量和网络状态
function PlaySceneZJHMenu:updateBatteryAndNetwork()
    local bg = gt.seekNodeByName(self.rootNode, "Img_NetworkBg")
	local barBattery = gt.seekNodeByName(bg, "LoadingBar_Battery")
	local lblNetwork = gt.seekNodeByName(bg, "Label_Network")
    local imgNetwork = gt.seekNodeByName(bg, "Img_Network")

	if not barBattery or not lblNetwork then return end

	if gt.isAndroidPlatform() then
		local function setBattery(respJson)
--			lblBattery:setString(string.format("电量:%d", respJson.code))
            barBattery:setPercent(tonumber(respJson.code))
		end
		extension.get_Battery(setBattery)
	else
		local battery = extension.get_Battery()
--		lblBattery:setString(string.format("电量:%d", battery))
        barBattery:setPercent(battery)
	end

    cc.SpriteFrameCache:getInstance():addSpriteFrames("image/play/netandbattery.plist")
	local ping = gt.socketClient:getLastReplayInterval()
	lblNetwork:setString(string.format("%dms", math.floor(ping*1000)))
    local pingValue = math.floor(ping*1000)
    if pingValue <= 100 then
        lblNetwork:setTextColor(cc.c3b(0, 128, 0))
        imgNetwork:loadTexture("image/play/network_13.png", ccui.TextureResType.plistType)
    elseif pingValue > 100 and pingValue <= 500 then
        lblNetwork:setTextColor(cc.c3b(255, 182, 0))
        imgNetwork:loadTexture("image/play/network_12.png", ccui.TextureResType.plistType)
    else
        lblNetwork:setTextColor(cc.c3b(254, 64, 64))
        imgNetwork:loadTexture("image/play/network_11.png", ccui.TextureResType.plistType)
    end
end

-- 开始录音
function PlaySceneZJHMenu:startAudio()
	local ret = extension.voiceStart()
	if not ret then
		gt.log("voice not open");
		return false
	end
	gt.log("start voice")
end

function PlaySceneZJHMenu:getVoiceUrl(respJson)
	gt.log("getVoiceUrl", respJson)
	local status = tonumber(respJson.status)
	if(status == 1) then
		gt.log("get voice url success");
		local code = respJson.code;
		local dataArr = string.split(code, "#")
		local time = dataArr[2]
		if time and tonumber(time) > 0 then
			--获得到地址上传给服务器
			local msgToSend = {}
			msgToSend.cmd = gt.SPEAKER
			msgToSend.type = gt.ChatType.VOICE_MSG -- 语音聊天
			msgToSend.url = tostring(dataArr[1])
			msgToSend.time = tonumber(time)
			gt.socketClient:sendMessage(msgToSend)
		else
		    gt.log("----------get voice url fail: time null url:", tostring(dataArr[1]))
		end
	end
end

function PlaySceneZJHMenu:uploadVoice(path, time)
	gt.log("uploadVoice", path, time)
	extension.voiceupload(handler(self, self.getVoiceUrl), path, time)
end

function PlaySceneZJHMenu:onVoiceFinish(respJson)
	gt.log("onVoiceFinish")
	if self.cancelVoice == true then
		return
	end
	local status = tonumber(respJson.status)
	if (status == 1) then
		gt.log("voice done")
		local code = respJson.code
		local dataArr = string.split(code, "#")

		local path = dataArr[1]
		local time = dataArr[2]

		if ( 500 > tonumber(time)) then
			gt.log("voice time too short");
		else
            local callFunc1 = cc.CallFunc:create(function ()
			    self.yuyinBtn:setEnabled(false)
		    end)
		    local delayTime = cc.DelayTime:create(self.chatCD)
		    local callFunc2 = cc.CallFunc:create(function ()
			    self.yuyinBtn:setEnabled(true)
		    end)
		    local sequence = cc.Sequence:create(callFunc1,delayTime,callFunc2)
		    self.yuyinBtn:runAction(sequence)
				
			self:uploadVoice(path, tostring(time))
		end
	else
		gt.log("voice fail")
	end
end

--停止录音
function PlaySceneZJHMenu:stopAudio(cancel)
	gt.log("stop audio", cancel)
	self.cancelVoice = cancel

	extension.voiceStop(handler(self, self.onVoiceFinish))
end

return PlaySceneZJHMenu

