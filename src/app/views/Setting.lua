
local gt = cc.exports.gt

local Setting = class("Setting", function()
	return gt.createMaskLayer()
end)

function Setting:ctor(param, type , isTwelve--[[, node--]])
	if type == 1 or type == 3 then
		self.roomState = param.roomState
		self.owner = param.owner
		self.curRound = param.curRound
		self.isWait = param.isWait
        self.isMatch = param.isMatch  or 0
        self.playerState = param.playerState or 0
    else
        self.roomState = -1
    end

    local csbName = "csd/Setting.csb"
	if isTwelve then
		csbName = "csd/SettingTwelve.csb"
	end
	local csbNode = cc.CSLoader:createNode(csbName)

	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.rootNode = csbNode
	
	local roomSet = gt.seekNodeByName(csbNode, "Panel_RoomSet")
	local YSroomSet = gt.seekNodeByName(csbNode, "Panel_YSRoomSet")
	local mainSet = gt.seekNodeByName(csbNode, "Panel_MainSet")
	
	-- 关闭按钮
	local mainCloseBtn = gt.seekNodeByName(mainSet, "Btn_Close")
	gt.addBtnPressedListener(mainCloseBtn, function()
		self:removeFromParent()
	end)
	
	local roomCloseBtn = gt.seekNodeByName(roomSet, "Btn_Close")
	gt.addBtnPressedListener(roomCloseBtn, function()
		self:removeFromParent()
    end)
    
    local roomCloseBtn2 = gt.seekNodeByName(YSroomSet, "Btn_Close")
	gt.addBtnPressedListener(roomCloseBtn2, function()
		self:removeFromParent()
	end)
	
	
	--判断是房间设置还是大厅设置
	if type == 1 then
		roomSet:setVisible(true)
		mainSet:setVisible(false)
		YSroomSet:setVisible(false)
	elseif type == 2 then
		roomSet:setVisible(false)
		mainSet:setVisible(true)
		YSroomSet:setVisible(false)
	elseif type == 3 then
		roomSet:setVisible(false)
		mainSet:setVisible(false)
		YSroomSet:setVisible(true)
	end
	
	local function exitHall()
		self:removeFromParent()
		
		-- 关闭socket连接时,赢停止当前定时器
		if gt.socketClient.scheduleHandler then
			gt.scheduler:unscheduleScriptEntry(gt.socketClient.scheduleHandler)
		end
		-- 关闭事件回调
		gt.removeTargetAllEventListener(gt.socketClient)

		gt.socketClient:close()

		local loginScene = require("app/views/LoginScene"):create()
		cc.Director:getInstance():replaceScene(loginScene)
	end
	
	-- 大厅退出按钮
	local exitBtn = gt.seekNodeByName(mainSet, "Btn_Exit")
	gt.addBtnPressedListener(exitBtn, function()
		if gt.isIOSPlatform() then
			cc.UserDefault:getInstance():setStringForKey("WX_Access_Token", "")
			cc.UserDefault:getInstance():setStringForKey("WX_Refresh_Token", "")
			cc.UserDefault:getInstance():setStringForKey("WX_Access_Token_Time", "")
			cc.UserDefault:getInstance():setStringForKey("WX_Refresh_Token_Time", "")
			cc.UserDefault:getInstance():setStringForKey("WX_OpenId", "")
			cc.UserDefault:getInstance():setIntegerForKey( "LAST_LOGIN_TYPE", 0)
			
			exitHall()
		else
			cc.Director:getInstance():endToLua()
		end
	end)
	
	--在大厅注销账号
	local exitRoomBtn = gt.seekNodeByName(mainSet, "Btn_LogOut")
	gt.addBtnPressedListener(exitRoomBtn, function()
		cc.UserDefault:getInstance():setStringForKey("WX_Access_Token", "")
		cc.UserDefault:getInstance():setStringForKey("WX_Refresh_Token", "")
		cc.UserDefault:getInstance():setStringForKey("WX_Access_Token_Time", "")
		cc.UserDefault:getInstance():setStringForKey("WX_Refresh_Token_Time", "")
		cc.UserDefault:getInstance():setStringForKey("WX_OpenId", "")
		cc.UserDefault:getInstance():setIntegerForKey( "LAST_LOGIN_TYPE", 0)

		exitHall()
	end)
	
	-- 解散房间按钮
	local dismissRoomBtn = gt.seekNodeByName(roomSet, "Btn_RoomDisband")
	gt.addBtnPressedListener(dismissRoomBtn, function()
		if self.roomState <= 1 and self.curRound == 1 then
			local msgToSend = {}
			msgToSend.cmd = gt.DISMISS_ROOM
			gt.socketClient:sendMessage(msgToSend)
		else
			local dismiss = require("app/views/DismissRoom"):create(isTwelve or false)
			display.getRunningScene():addChild(dismiss)
		end
		
		self:removeFromParent()
	end)

	local dismissRoomBtn2 = gt.seekNodeByName(YSroomSet, "Btn_RoomDisband")
	gt.addBtnPressedListener(dismissRoomBtn2, function()
		if self.roomState <= 1 and self.curRound == 1 then
			local msgToSend = {}
			msgToSend.cmd = gt.DISMISS_ROOM
			gt.socketClient:sendMessage(msgToSend)
		else
			local dismiss = require("app/views/DismissRoom"):create(isTwelve or false)
			display.getRunningScene():addChild(dismiss)
		end
		
		self:removeFromParent()
	end)

	--退出房间
	local exitRoomBtn = gt.seekNodeByName(roomSet, "Btn_RoomExit")
	gt.addBtnPressedListener(exitRoomBtn, function()
		local msgToSend = {}
		msgToSend.cmd = gt.EXIT_ROOM
		gt.socketClient:sendMessage(msgToSend)
		
		self:removeFromParent()
    end)
    
    local exitRoomBtn2 = gt.seekNodeByName(YSroomSet, "Btn_RoomExit")
	gt.addBtnPressedListener(exitRoomBtn2, function()
		local msgToSend = {}
		msgToSend.cmd = gt.EXIT_ROOM
		gt.socketClient:sendMessage(msgToSend)
		
		self:removeFromParent()
	end)

	exitRoomBtn:setVisible(false)
	exitRoomBtn2:setVisible(false)
	dismissRoomBtn:setVisible(false)
	dismissRoomBtn2:setVisible(false)

	local posX_ = 469
	if(self.isWait) then   --是等待加入者
		if self.owner and self.roomState <= 1 and self.curRound == 1 then --是创建者并且未开局
			exitRoomBtn:setVisible(true)
			dismissRoomBtn:setVisible(true)		
			exitRoomBtn2:setVisible(true)
			dismissRoomBtn2:setVisible(true)		
        elseif self.playerState > 0 then --等待加入状态
    	 	dismissRoomBtn:setVisible(true)
			dismissRoomBtn:setPositionX(posX_)
			dismissRoomBtn2:setVisible(true)
	        dismissRoomBtn2:setPositionX(posX_)
		else
			exitRoomBtn:setVisible(true)
			exitRoomBtn:setPositionX(posX_)
			exitRoomBtn2:setVisible(true)
			exitRoomBtn2:setPositionX(posX_)
		end		
	elseif self.roomState <= 1 and self.curRound == 1 then --是未开局
		if self.owner and self.isMatch <= 0 then
			exitRoomBtn:setVisible(true)
			dismissRoomBtn:setVisible(true)
			exitRoomBtn2:setVisible(true)
			dismissRoomBtn2:setVisible(true)
		else
			exitRoomBtn:setVisible(true)
			exitRoomBtn:setPositionX(posX_)
			exitRoomBtn2:setVisible(true)
			exitRoomBtn2:setPositionX(posX_)
		end
	else	--已开局
		dismissRoomBtn:setVisible(true)
		dismissRoomBtn:setPositionX(posX_)
		dismissRoomBtn2:setVisible(true)
		dismissRoomBtn2:setPositionX(posX_)
	end
	
	--震动开关
	local btnOpenShock = gt.seekNodeByName(roomSet, "Btn_ShockOpen")
	local btnOpenShockYs = gt.seekNodeByName(YSroomSet, "Btn_ShockOpen")
	local btnCloseShock = gt.seekNodeByName(roomSet, "Btn_ShockClose")
	local btnCloseShockYs = gt.seekNodeByName(YSroomSet, "Btn_ShockClose")
	if cc.UserDefault:getInstance():getStringForKey("Shock") == "true" then
		btnOpenShock:setVisible(true)
		btnOpenShockYs:setVisible(true)
		btnCloseShock:setVisible(false)
		btnCloseShockYs:setVisible(false)
	else
		--默认关闭
		btnOpenShock:setVisible(false)
		btnOpenShockYs:setVisible(false)
		btnCloseShock:setVisible(true)
		btnCloseShockYs:setVisible(true)
	end
	gt.addBtnPressedListener(btnOpenShock, function()
		btnOpenShock:setVisible(false)
		btnCloseShock:setVisible(true)
		cc.UserDefault:getInstance():setStringForKey("Shock", "false")
	end)
	gt.addBtnPressedListener(btnOpenShockYs, function()
		btnOpenShockYs:setVisible(false)
		btnCloseShockYs:setVisible(true)
		cc.UserDefault:getInstance():setStringForKey("Shock", "false")
	end)
	gt.addBtnPressedListener(btnCloseShock, function()
		btnOpenShock:setVisible(true)
		btnCloseShock:setVisible(false)
		cc.UserDefault:getInstance():setStringForKey("Shock", "true")
	end)
	gt.addBtnPressedListener(btnCloseShockYs, function()
		btnOpenShockYs:setVisible(true)
		btnCloseShockYs:setVisible(false)
		cc.UserDefault:getInstance():setStringForKey("Shock", "true")
	end)

	
	--道具显示开关
	local Btn_ShowProp = gt.seekNodeByName(roomSet, "Btn_ShowProp")
	local Btn_ShowPropYs = gt.seekNodeByName(YSroomSet, "Btn_ShowProp")
	local Btn_HideProp = gt.seekNodeByName(roomSet, "Btn_HideProp")
	local Btn_HidePropYs = gt.seekNodeByName(YSroomSet, "Btn_HideProp")
	if cc.UserDefault:getInstance():getStringForKey("showProp") == "false" then
		Btn_ShowProp:setVisible(false)
		Btn_ShowPropYs:setVisible(false)
		Btn_HideProp:setVisible(true)
		Btn_HidePropYs:setVisible(true)
	else
		--默认开启
		Btn_ShowProp:setVisible(true)
		Btn_ShowPropYs:setVisible(true)
		Btn_HideProp:setVisible(false)
		Btn_HidePropYs:setVisible(false)
	end
	gt.addBtnPressedListener(Btn_ShowProp, function()
		Btn_ShowProp:setVisible(false)
		Btn_HideProp:setVisible(true)
		cc.UserDefault:getInstance():setStringForKey("showProp", "false")
	end)
	gt.addBtnPressedListener(Btn_ShowPropYs, function()
		Btn_ShowPropYs:setVisible(false)
		Btn_HidePropYs:setVisible(true)
		cc.UserDefault:getInstance():setStringForKey("showProp", "false")
	end)
	gt.addBtnPressedListener(Btn_HideProp, function()
		Btn_ShowProp:setVisible(true)
		Btn_HideProp:setVisible(false)
		cc.UserDefault:getInstance():setStringForKey("showProp", "true")
	end)
	gt.addBtnPressedListener(Btn_HidePropYs, function()
		Btn_ShowPropYs:setVisible(true)
		Btn_HidePropYs:setVisible(false)
		cc.UserDefault:getInstance():setStringForKey("showProp", "true")
	end)
	
	
	--桌面选择
	local imgDesktop1 = gt.seekNodeByName(roomSet, "Img_Desktop_1")
	local imgDesktop2 = gt.seekNodeByName(roomSet, "Img_Desktop_2")
	local imgDesktop3 = gt.seekNodeByName(roomSet, "Img_Desktop_3")
	local imgDesktop4 = gt.seekNodeByName(roomSet, "Img_Desktop_4")
	
	local YSimgDesktop1 = gt.seekNodeByName(YSroomSet, "Img_Desktop_1")
	local YSimgDesktop2 = gt.seekNodeByName(YSroomSet, "Img_Desktop_2")
	local YSimgDesktop3 = gt.seekNodeByName(YSroomSet, "Img_Desktop_3")
	local YSimgDesktop4 = gt.seekNodeByName(YSroomSet, "Img_Desktop_4")
	local YSimgDesktop5 = gt.seekNodeByName(YSroomSet, "Img_Desktop_5")
	
	local desktopChoice1 = gt.seekNodeByName(imgDesktop1, "Img_Choice_1")
	local desktopChoice2 = gt.seekNodeByName(imgDesktop2, "Img_Choice_2")
	local desktopChoice3 = gt.seekNodeByName(imgDesktop3, "Img_Choice_3")
	local desktopChoice4 = gt.seekNodeByName(imgDesktop4, "Img_Choice_4")
	
	local YSdesktopChoice1 = gt.seekNodeByName(YSimgDesktop1, "Img_Choice_1")
	local YSdesktopChoice2 = gt.seekNodeByName(YSimgDesktop2, "Img_Choice_2")
	local YSdesktopChoice3 = gt.seekNodeByName(YSimgDesktop3, "Img_Choice_3")
	local YSdesktopChoice4 = gt.seekNodeByName(YSimgDesktop4, "Img_Choice_4")
	local YSdesktopChoice5 = gt.seekNodeByName(YSimgDesktop5, "Img_Choice_5")
	
	desktopChoice1:setVisible(false)
	desktopChoice2:setVisible(true)
	desktopChoice3:setVisible(false)
	desktopChoice4:setVisible(false)
	
	YSdesktopChoice1:setVisible(false)
	YSdesktopChoice2:setVisible(true)
	YSdesktopChoice3:setVisible(false)
	YSdesktopChoice4:setVisible(false)
	YSdesktopChoice5:setVisible(false)
	
	imgDesktop1:addClickEventListener(function(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		desktopChoice1:setVisible(true)
		desktopChoice2:setVisible(false)
		desktopChoice3:setVisible(false)
		desktopChoice4:setVisible(false)
		cc.UserDefault:getInstance():setStringForKey("Desktop", "1")
		gt.dispatchEvent(gt.EventType.CHANGE_PLAY_BG)
	end)
	YSimgDesktop1:addClickEventListener(function(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		YSdesktopChoice1:setVisible(true)
		YSdesktopChoice2:setVisible(false)
		YSdesktopChoice3:setVisible(false)
		YSdesktopChoice4:setVisible(false)
		YSdesktopChoice5:setVisible(false)
		cc.UserDefault:getInstance():setStringForKey("YSDesktop", "1")
		gt.dispatchEvent(gt.EventType.CHANGE_PLAY_BG)
	end)
	imgDesktop2:addClickEventListener(function(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		desktopChoice1:setVisible(false)
		desktopChoice2:setVisible(true)
		desktopChoice3:setVisible(false)
		desktopChoice4:setVisible(false)
		cc.UserDefault:getInstance():setStringForKey("Desktop", "2")
		gt.dispatchEvent(gt.EventType.CHANGE_PLAY_BG)
	end)
	YSimgDesktop2:addClickEventListener(function(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		YSdesktopChoice1:setVisible(false)
		YSdesktopChoice2:setVisible(true)
		YSdesktopChoice3:setVisible(false)
		YSdesktopChoice4:setVisible(false)
		YSdesktopChoice5:setVisible(false)
		cc.UserDefault:getInstance():setStringForKey("YSDesktop", "2")
		gt.dispatchEvent(gt.EventType.CHANGE_PLAY_BG)
	end)
	imgDesktop3:addClickEventListener(function(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		desktopChoice1:setVisible(false)
		desktopChoice2:setVisible(false)
		desktopChoice3:setVisible(true)
		desktopChoice4:setVisible(false)
		cc.UserDefault:getInstance():setStringForKey("Desktop", "3")
		gt.dispatchEvent(gt.EventType.CHANGE_PLAY_BG)
	end)
	YSimgDesktop3:addClickEventListener(function(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		YSdesktopChoice1:setVisible(false)
		YSdesktopChoice2:setVisible(false)
		YSdesktopChoice3:setVisible(true)
		YSdesktopChoice4:setVisible(false)
		YSdesktopChoice5:setVisible(false)
		cc.UserDefault:getInstance():setStringForKey("YSDesktop", "3")
		gt.dispatchEvent(gt.EventType.CHANGE_PLAY_BG)
	end)
	imgDesktop4:addClickEventListener(function(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		desktopChoice1:setVisible(false)
		desktopChoice2:setVisible(false)
		desktopChoice3:setVisible(false)
		desktopChoice4:setVisible(true)
		cc.UserDefault:getInstance():setStringForKey("Desktop", "4")
		gt.dispatchEvent(gt.EventType.CHANGE_PLAY_BG)
	end)
	YSimgDesktop4:addClickEventListener(function(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		YSdesktopChoice1:setVisible(false)
		YSdesktopChoice2:setVisible(false)
		YSdesktopChoice3:setVisible(false)
		YSdesktopChoice4:setVisible(true)
		YSdesktopChoice5:setVisible(false)
		cc.UserDefault:getInstance():setStringForKey("YSDesktop", "4")
		gt.dispatchEvent(gt.EventType.CHANGE_PLAY_BG)
	end)
	YSimgDesktop5:addClickEventListener(function(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		YSdesktopChoice1:setVisible(false)
		YSdesktopChoice2:setVisible(false)
		YSdesktopChoice3:setVisible(false)
		YSdesktopChoice4:setVisible(false)
		YSdesktopChoice5:setVisible(true)
		cc.UserDefault:getInstance():setStringForKey("YSDesktop", "5")
		gt.dispatchEvent(gt.EventType.CHANGE_PLAY_BG)
    end)

	local DesktopValue = cc.UserDefault:getInstance():getStringForKey("Desktop","2")
	if DesktopValue then
		local value = tonumber(DesktopValue)
        desktopChoice1:setVisible(value == 1)
        desktopChoice2:setVisible(value == 2)
        desktopChoice3:setVisible(value == 3)
        desktopChoice4:setVisible(value == 4)
	end
	local YSDesktop = cc.UserDefault:getInstance():getStringForKey("YSDesktop", "5")
	if YSDesktop then
		local value = tonumber(YSDesktop)
		YSdesktopChoice1:setVisible(value == 1)
		YSdesktopChoice2:setVisible(value == 2)
		YSdesktopChoice3:setVisible(value == 3)
		YSdesktopChoice4:setVisible(value == 4)
		YSdesktopChoice5:setVisible(value == 5)
	end
	
	-- 音效调节
	local soundMainEftSlider = gt.seekNodeByName(mainSet, "Slider_MainEffect")
	local soundRoomEftSlider = gt.seekNodeByName(roomSet, "Slider_RoomEffect")
	local soundRoomEftSliderYS =gt.seekNodeByName(YSroomSet,"Slider_RoomEffect")
	local soundEftPercent = gt.soundEngine:getSoundEffectVolume()
	soundEftPercent = math.floor(soundEftPercent)
	self.soundEftPercent = soundEftPercent
	soundMainEftSlider:setPercent(soundEftPercent)
	soundRoomEftSlider:setPercent(soundEftPercent)
	soundRoomEftSliderYS:setPercent(soundEftPercent)
	soundMainEftSlider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			local soundEftPercent = soundMainEftSlider:getPercent()
			gt.soundEngine:setSoundEffectVolume(soundEftPercent)
		end
	end)
	soundRoomEftSlider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			local soundEftPercent = soundRoomEftSlider:getPercent()
			gt.soundEngine:setSoundEffectVolume(soundEftPercent)
		end
	end)
	soundRoomEftSliderYS:addEventListener(function(sender, eventType)
		if eventType==ccui.SliderEventType.percentChanged then
			local soundEftPercent=soundRoomEftSliderYS:getPercent()
			gt.soundEngine:setSoundEffectVolume(soundEftPercent)
		end
	end)
	
	-- 音乐调节
	local mainMusicSlider = gt.seekNodeByName(mainSet, "Slider_MainMusic")
	local roomMusicSlider = gt.seekNodeByName(roomSet, "Slider_RoomMusic")
	local YSroomMusicSlider=gt.seekNodeByName(YSroomSet,"Slider_RoomMusic")
	local musicPercent = gt.soundEngine:getMusicVolume()
	musicPercent = math.floor(musicPercent)
	self.musicPercent = musicPercent
	mainMusicSlider:setPercent(musicPercent)
	roomMusicSlider:setPercent(musicPercent)
	YSroomMusicSlider:setPercent(musicPercent)
	mainMusicSlider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			local musicPercent = mainMusicSlider:getPercent()
			gt.soundEngine:setMusicVolume(musicPercent)
		end
	end)
	roomMusicSlider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			local musicPercent = roomMusicSlider:getPercent()
			gt.soundEngine:setMusicVolume(musicPercent)
		end
	end)
	YSroomMusicSlider:addEventListener(function(sender, eventType)
		if eventType==ccui.SliderEventType.percentChanged then
			local musicPercent=YSroomMusicSlider:getPercent()
			gt.soundEngine:setMusicVolume(musicPercent)
		end
	end)

	--限时赛场屏蔽解散按钮 退出房间按钮
	if param and  param.sport_id and param.sport_id>0 then
		dismissRoomBtn2:setVisible(false)
		dismissRoomBtn:setVisible(false)
		exitRoomBtn2:setVisible(false)
		exitRoomBtn:setVisible(false)
	end
end

return Setting



