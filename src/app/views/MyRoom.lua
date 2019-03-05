
local gt = cc.exports.gt

--local MyRoom = class("MyRoom", function()
--	return gt.createMaskLayer()
--end)
local MyRoom = class("MyRoom")

function MyRoom:ctor(myRoomList, pTemplate, imgTip)
--	local csbNode = cc.CSLoader:createNode("csd/MyRoom.csb")
--	csbNode:setAnchorPoint(0.5, 0.5)
--	csbNode:setPosition(gt.winCenter)
--	self:addChild(csbNode)
--	self.csbNode = csbNode
	self.refreshTime = 0
	self.roomsCurrent = nil
	self.roomsHistory = nil
	self.roomInfo = nil

--	-- 关闭按键
--	local closeBtn = gt.seekNodeByName(csbNode, "Btn_Close")
--	gt.addBtnPressedListener(closeBtn, function()
--		self:close()
--	end)

--	-- 详情界面
--	self.pDetails = gt.seekNodeByName(csbNode, "Panel_Details")
--	self.pDetails:setVisible(false)
--	-- 关闭房间按键
--	local btnBack = self.pDetails:getChildByName("Btn_Back")
--	gt.addBtnPressedListener(btnBack, function()
--		self.pDetails:setVisible(false)
--		self.pView:setVisible(true)
--	end)
	-- 分享按键
--	local btnShare = self.pDetails:getChildByName("Btn_ShareRoom")
--	gt.addBtnPressedListener(btnShare, function()
--		if self.roomInfo then
--			self:shareRoom(self.roomInfo)
--		end
--	end)
--	if gt.isIOSReview() then
--		btnShare:setVisible(false)
--	end

	-- 当前房间列表
--	self.pCurrent = gt.seekNodeByName(csbNode, "Panel_Current")
--	self.pView = self.pCurrent
    self.imgTip = imgTip
	self.listCurrent = myRoomList
	self.pTemplate = pTemplate
	self.pTemplate:retain()
	self.listCurrent:removeAllChildren()
	
	-- 刷新按钮
--	local refreshBtn = gt.seekNodeByName(self.pCurrent, "Btn_Refresh")
--	gt.addBtnPressedListener(refreshBtn, function()
--		self:refresh()
--	end)
	-- 查看对局按钮
--	local historyBtn = gt.seekNodeByName(self.pCurrent, "Btn_Check_Game")
--	gt.addBtnPressedListener(historyBtn, function()
--		if self.roomsHistory == nil then
--			local msgToSend = {}
--			msgToSend.cmd = gt.ROOM_HISTORY
--			msgToSend.user_id = gt.playerData.uid
--			gt.socketClient:sendMessage(msgToSend)

--			gt.showLoadingTips("")
--		end
--		self.pCurrent:setVisible(false)
--		self.pHistory:setVisible(true)
--	end)

	--历史记录列表
--	self.pHistory = gt.seekNodeByName(csbNode, "Panel_History")
--	self.pHistory:setVisible(false)
--	self.listHistory = self.pHistory:getChildByName("List_History")
--	self.pTemplateHistory = self.listHistory:getChildByName("Panel_Template")
--	self.pTemplateHistory:retain()
--	self.listHistory:removeAllChildren()
	-- 我的房间按钮
--	local currentBtn = self.pHistory:getChildByName("Btn_Current")
--	gt.addBtnPressedListener(currentBtn, function()
--		self.pHistory:setVisible(false)
--		self.pCurrent:setVisible(true)
--	end)

	gt.socketClient:registerMsgListener(gt.ROOM_LIST, self, self.onRcvRoomList)
--	gt.socketClient:registerMsgListener(gt.ROOM_HISTORY, self, self.onRcvRoomHistory)
	gt.socketClient:registerMsgListener(gt.JOIN_ROOM, self, self.onRcvJoinRoom)

	self:refresh()
end

function MyRoom:refresh()
	local current = os.time()
	if self.refreshTime + 5 > current then
		return
	end
	self.refreshTime = current

	local msgToSend = {}
	msgToSend.cmd = gt.ROOM_LIST
	msgToSend.user_id = gt.playerData.uid
	gt.socketClient:sendMessage(msgToSend)

	gt.showLoadingTips("")
end

function MyRoom:shareRoom(roomInfo)
	gt.getRoomShareString(roomInfo.conf, #roomInfo.players, roomInfo.id)
end


function MyRoom:onRcvRoomList(msgTbl)
	gt.removeLoadingTips()
    gt.dump(msgTbl, "onRcvRoomList--------")
	local function onEnter(sender)
        gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		local tag = sender:getTag()
		local roomID = self.roomsCurrent[tag].id
		-- 发送进入房间消息
		local msgToSend = {}
		msgToSend.cmd = gt.JOIN_ROOM
		msgToSend.room_id = roomID
		msgToSend.app_id = gt.app_id
		msgToSend.user_id = gt.playerData.uid
		msgToSend.ver = gt.version
		msgToSend.dev_id = gt.getDeviceId()
		gt.socketClient:sendMessage(msgToSend)

		gt.showLoadingTips(gt.getLocationString("LTKey_0006"))
	end

	local function onShare(sender)
        gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		local tag = sender:getTag()
		local roomInfo = self.roomsCurrent[tag]
		self:shareRoom(roomInfo)
	end

	local function onDetail(sender)
        gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		local tag = sender:getTag()
		self:showRoomDetail(self.roomsCurrent[tag])
	end

	local function onDismiss(sender)
        gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		local tag = sender:getTag()
	end


	self.roomsCurrent = msgTbl.rooms
	self.listCurrent:removeAllChildren()
	for i, v in ipairs(self.roomsCurrent) do
		local item = self.pTemplate:clone()
		v.conf = json.decode(v.kwargs)
		item:getChildByName("Label_RoomId"):setString(tostring(v.id))
		item:getChildByName("Label_RoomRound"):setString(string.format("%d/%d局", v.round, v.conf.rounds))
        if v.conf.game_id == gt.GameID.SANGONG then
            item:getChildByName("Label_RoomRound"):setString(string.format("%d/%d局", v.round, v.conf.rounds))
        elseif v.conf.game_id == gt.GameID.ZJH then
            item:getChildByName("Label_RoomRound"):setString(string.format("%d/%d局", v.round, v.conf.rounds))
        end
		local playerCount = #(v.players)
		item:getChildByName("Label_PlayerCount"):setString(string.format("%d/%d", playerCount, v.conf.max_chairs))
        local fraction = "1/2"
	    if v.conf.game_id==gt.GameID.NIUYE or v.conf.game_id == gt.GameID.NIUNIU then
		    if v.conf.score == 2 then
			    fraction = "2/4"
		    elseif v.conf.score == 4 then
			    fraction = "4/8"
		    elseif v.conf.score==3 then
			    fraction="3/6"
		    elseif v.conf.score==5 then
			    fraction="5/10"
		    end
        elseif v.conf.game_id == gt.GameID.SANGONG then
            fraction = "5/10/15/20"
            if v.conf.score == 10 then
                fraction = "10/20/30/40"
            elseif v.conf.score == 20 then
                fraction = "20/40/60/80"
            end
        elseif v.conf.game_id == gt.GameID.QIONGHAI then
            fraction = tostring(v.conf.qh_base_score)
        elseif v.conf.game_id == gt.GameID.ZJH then
            fraction = tostring(v.conf.zjh_base_score)
	    end
        local labelScore = gt.seekNodeByName(item, "Label_Score")
        labelScore:setString(fraction)
--        item:getChildByName("Label_Score"):setString(fraction)
--		local img_State = item:getChildByName("Img_State")
--		if v.state == 0 then
--			img_State:loadTexture("image/myroom/img_notstart.png", ccui.TextureResType.plistType)
--		else
--			img_State:loadTexture("image/myroom/in_game.png", ccui.TextureResType.plistType)
--		end
		-- 进入
--		local btnEnter = item:getChildByName("Btn_EnterRoom")
		item:setTag(i)
		item:addClickEventListener(onEnter)

		-- 分享
		local btnShare = item:getChildByName("Btn_InvitePlayer")
		btnShare:setTag(i)
		btnShare:addClickEventListener(onShare)
		if gt.isIOSReview() then
			btnShare:setVisible(false)
		end

		-- 详情
--		local btnDetail = item:getChildByName("Btn_ShowDetails")
--		btnDetail:setTag(i)
--		btnDetail:addClickEventListener(onDetail)

		-- 关闭
--		local btnDismiss = item:getChildByName("Btn_CloseRoom")
--		btnDismiss:setTag(i)
--		btnDismiss:addClickEventListener(onDismiss)

		self.listCurrent:pushBackCustomItem(item)
	end
    if #msgTbl.rooms == 0 then
        self.imgTip:setVisible(true)
    else
        self.imgTip:setVisible(false)
    end
end

function MyRoom:getMyRoomList()
    return self.listCurrent
end

function MyRoom:showRoomDetail(roomInfo)
    local tableSetting = roomInfo.conf
    local game_type = gt.GameTypeDesc[tableSetting.game_type]
    if tableSetting.game_id == gt.GameID.SANGONG then
        game_type = gt.GameSGTypeDesc[tableSetting.game_type]
    end
	if self.pCurrent:isVisible() then
		self.pView = self.pCurrent
	else
		self.pView = self.pHistory
	end
	self.pView:setVisible(false)
	self.pDetails:setVisible(true)
	self.roomInfo = roomInfo

	self.pDetails:getChildByName("Label_RoomId"):setString("房间号: "..tostring(roomInfo.id))
	if roomInfo.round ~= nil then
		self.pDetails:getChildByName("Label_RoomRound"):setString(string.format("%s: %d/%d局", game_type, roomInfo.round, roomInfo.conf.rounds))
	else
		self.pDetails:getChildByName("Label_RoomRound"):setString(string.format("%s: %d局", game_type, roomInfo.conf.rounds))
	end
	local playerCount = #(roomInfo.players)
	self.pDetails:getChildByName("Label_PlayerCount"):setString(string.format("人数: %d/%d", playerCount, roomInfo.conf.max_chairs))
	local img_State = self.pDetails:getChildByName("Img_State")
	if roomInfo.state == nil then
        --已结束
		img_State:loadTexture("image/myroom/over.png", ccui.TextureResType.plistType)
	elseif roomInfo.state == 0 then
        --未开始
		img_State:loadTexture("image/myroom/img_notstart.png", ccui.TextureResType.plistType)
	else
        --游戏中
		img_State:loadTexture("image/myroom/in_game.png", ccui.TextureResType.plistType)
	end

	local playerList = ""
	for i, v in pairs(roomInfo.players) do
		playerList = playerList .. "    " .. gt.checkName(v.nick, 6)  
	end
	self.pDetails:getChildByName("Label_PlayerList"):setString(playerList)
	
	local desc = string.format("%s  %d人  %d局\n", game_type, tableSetting.max_chairs, tableSetting.rounds)
	
    local pay, doubleRate, score, baseScore, rate, strRule, strSpecial , SSS_str = gt.getRoomInfo(tableSetting, false)
    desc = desc..pay..rate..score..baseScore..doubleRate.."\n"..strRule..strSpecial

    if cellData.room_setting.game_id == gt.GameID.SSS and cellData.game_type == 7 then
        roomInfo:setString(strRule..strScore..SSS_str)
    else
    	self.pDetails:getChildByName("Label_Config"):setString(desc)
    end
end

function MyRoom:onRcvRoomHistory(msgTbl)
	gt.removeLoadingTips()
    gt.dump(msgTbl, "onRcvRoomHistory--------")

	local function onDetail(sender)
        gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		local tag = sender:getTag()
		self:showRoomDetail(self.roomsHistory[tag])
	end

	self.roomsHistory = msgTbl.rooms
	self.listHistory:removeAllChildren()
	for i, v in ipairs(self.roomsHistory) do
		local item = self.pTemplateHistory:clone()
		v.conf = json.decode(v.kwargs)
		item:getChildByName("Label_RoomId"):setString("房间号: "..tostring(v.id))
		item:getChildByName("Label_RoomRound"):setString(string.format("%s: %d局", gt.GameTypeDesc[v.conf.game_type], v.conf.rounds))
        if msgTbl.game_id == gt.GameID.SANGONG then
            item:getChildByName("Label_RoomRound"):setString(string.format("%s: %d局", gt.GameSGTypeDesc[v.conf.game_type], v.conf.rounds))
        end
		local playerCount = #(v.players)
		item:getChildByName("Label_PlayerCount"):setString(string.format("人数: %d/%d", playerCount, v.conf.max_chairs))
		-- 详情
		local btnDetail = item:getChildByName("Btn_ShowDetails")
		btnDetail:setTag(i)
		btnDetail:addClickEventListener(onDetail)

		self.listHistory:pushBackCustomItem(item)
	end
end

function MyRoom:onRcvJoinRoom(msgTbl)
	if msgTbl.code == 0 then
		self:close()
	else
		-- 进入房间失败
		gt.removeLoadingTips()
		-- 1：未登录 2：服务器维护中 3：房卡不足 4：人数已满 5：房间不存在 6：中途不能加入
		local errorMsg = ""
		if msgTbl.code == 1 then
			errorMsg = gt.getLocationString("LTKey_0058")
		elseif msgTbl.code == 2 then
			errorMsg = gt.getLocationString("LTKey_0054")
		elseif msgTbl.code == 3 then
			errorMsg = gt.getLocationString("LTKey_0049")
		elseif msgTbl.code == 4 then
			errorMsg = gt.getLocationString("LTKey_0018")
		elseif msgTbl.code == 5 then
			errorMsg = gt.getLocationString("LTKey_0015")
        elseif msgTbl.code == 6 then
			errorMsg = gt.getLocationString("LTKey_0057")
		elseif msgTbl.code == 7 then
			errorMsg = gt.getLocationString("LTKey_0065")
		elseif msgTbl.code == 8 then
			errorMsg = gt.getLocationString("LTKey_0067")
		end
        require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), errorMsg, nil, nil, true)
	end
end

function MyRoom:close()
	self.pTemplate:release()
	self.pTemplateHistory:release()
	gt.socketClient:unregisterMsgListener(gt.ROOM_LIST)
	gt.socketClient:unregisterMsgListener(gt.ROOM_HISTORY)
	gt.socketClient:unregisterMsgListener(gt.JOIN_ROOM)
	self:removeFromParent()
end

return MyRoom

