
local gt = cc.exports.gt

local MatchRecord = class("MatchRecord", function()
	return gt.createMaskLayer()
end)

function MatchRecord:ctor(guild_id, is_union, is_guild)
	local csbNode = cc.CSLoader:createNode("csd/Guild/MatchRecord.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
    --ccui.Helper:doLayout(csbNode)
	self:addChild(csbNode)
	self.rootNode = csbNode
    
	self.is_union = is_union or false
	self.is_guild = is_guild or false

	if self.is_union then
		self.isShowId = gt.UnionManager:isGuildAdmin(guild_id) or gt.UnionManager:isGuildOwner(guild_id)
	else
		self.isShowId = gt.guildManager:isGuildAdmin(guild_id) or gt.guildManager:isGuildOwner(guild_id)
	end

    gt.showLoadingTips("")

	-- 注册消息回调
	gt.socketClient:registerMsgListener(gt.MATCH_RECORD, self, self.onRcvMatchRecord)
    gt.socketClient:registerMsgListener(gt.RECORD_INFO, self, self.onRcvHistoryOne)
    gt.registerEventListener(gt.EventType.CLOSE_ROUNDRECORD, self, self.showMatchRecord)


    local lblTitle = gt.seekNodeByName(csbNode, "lblTitle")
    if lblTitle and self.is_guild then
    	lblTitle:setString("普通房战绩")
    end

    --不显示战绩
    self.emptyInfo = gt.seekNodeByName(csbNode, "Text_Info")
    self.emptyInfo:setVisible(false)

    self.lstRecord = gt.seekNodeByName(csbNode, "List_Record")
    self.pRecord6 = self.lstRecord:getChildByName("Panel_Record6")
    self.pRecord8 = self.lstRecord:getChildByName("Panel_Record8")
    self.pRecord10 = self.lstRecord:getChildByName("Panel_Record10")
    self.pRecord12 = self.lstRecord:getChildByName("Panel_Record12")
	
	--列表 宽+高适配
	local listSize = self.lstRecord:getContentSize()
	listSize.width = listSize.width + (gt.winSize.width - 1280)
	listSize.height = listSize.height + (gt.winSize.height - 720)
	self.lstRecord:setContentSize(listSize)
		
	--列表项 宽度适配
	local tempSize = self.pRecord6:getContentSize()
	tempSize.width = tempSize.width + (gt.winSize.width - 1280)
	self.pRecord6:setContentSize(tempSize)
	self.pRecord8:setContentSize(tempSize)
	self.pRecord10:setContentSize(tempSize)
	
	self.pRecord6:retain()
    self.pRecord8:retain()
    self.pRecord10:retain()
    if self.pRecord12 then
		self.pRecord12:setContentSize(tempSize)
	    self.pRecord12:retain()
	end

    ccui.Helper:doLayout(csbNode)
	self.lstRecord:removeAllChildren()
	

	-- 关闭按钮
	local backBtn = gt.seekNodeByName(csbNode, "Btn_Close")
	gt.addBtnPressedListener(backBtn, function()
		-- 移除消息回调
		gt.socketClient:unregisterMsgListener(gt.MATCH_RECORD)
		gt.socketClient:unregisterMsgListener(gt.RECORD_INFO)
        -- 移除事件回调
		gt.removeTargetAllEventListener(self)
        self.pRecord6:release()
        self.pRecord8:release()
        self.pRecord10:release()
        if self.pRecord12 then
	        self.pRecord12:release()
	    end

		-- 移除界面,返回主界面
		self:removeFromParent()
	end)

	self.lblPage = gt.seekNodeByName(csbNode, "Text_Page")
	-- 上一页
	self.btnPrevPage = gt.seekNodeByName(csbNode, "Btn_PrevPage")
	gt.addBtnPressedListener(self.btnPrevPage, function()
		if self.page > 1 then
			self.page = self.page - 1
			self.lblPage:setString(tostring(self.page))
			-- self:requestData()
			self:sendRefreshRecord()
		end
	end)
	-- 下一页
	self.btnNextPage = gt.seekNodeByName(csbNode, "Btn_NextPage")
	gt.addBtnPressedListener(self.btnNextPage, function()
		self.page = self.page + 1
		self.lblPage:setString(tostring(self.page))
		-- self:requestData()
		self:sendRefreshRecord()
	end)

	self.recordType = 1
	self.guild_id = guild_id
	self.page = 1
	
	-- self:requestData()
	self:sendRefreshRecord()
end

function MatchRecord:sendRefreshRecord()

	local url = "http://api.mgklqp.9you.net:8080/api/guildrecord/match_record_3days"
	if self.is_guild then
		url = "http://api.mgklqp.9you.net:8080/api/guildrecord/guild_record_3days"
	end
	local param = {}
	for i = 1,2 do 
		param[i] = {}
	end
	param[1].guild = self.guild_id
	param[2].page = self.page

	local sendParam = gt.commonTool:encodeSignRecord(param)
    gt.showLoadingTips("")

	gt.commonTool:sendHttpRecord(url,sendParam, function(infoData)
		-- body
		gt.removeLoadingTips()
		self.room_data = infoData.room_data

		self.emptyInfo:setVisible(#self.room_data == 0 and self.page == 1)
		
		-- -- self.listInfo_helper:SetItemsData({})
	 --    local delay_call = function ()
	 --    	self.listInfo_helper:SetItemsData(self.infoScoreData, true)
	 --    	-- self:updateTotalScore()
	 --    end
	 --    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
	 	self.lstRecord:removeAllChildren()
	  	for i, cellData in ipairs(self.room_data) do
			local item
			if cellData.room_setting.max_chairs == 4 then
                		item = self:createRecordItem(self.pRecord6:clone(), i, cellData)      
			elseif cellData.room_setting.max_chairs == 6 then
				item = self:createRecordItem(self.pRecord6:clone(), i, cellData)
			elseif cellData.room_setting.max_chairs == 8 then
				item = self:createRecordItem(self.pRecord8:clone(), i, cellData)
			elseif cellData.room_setting.max_chairs == 10 then
				item = self:createRecordItem(self.pRecord10:clone(), i, cellData)
			else
				item = self:createRecordItem(self.pRecord12:clone(), i, cellData)
			end
			self.lstRecord:pushBackCustomItem(item)
		end

	 	if #self.room_data < 10 then
			self.btnNextPage:setEnabled(false)
		else
			self.btnNextPage:setEnabled(true)
		end
		if self.page == 1 then
			self.btnPrevPage:setEnabled(false)
		else
			self.btnPrevPage:setEnabled(true)
		end

	end)
end

function MatchRecord:requestData()
	local msgToSend = {}
	msgToSend.cmd = gt.MATCH_RECORD
	msgToSend.user_id = gt.playerData.uid
    msgToSend.game_id = self.recordType
    msgToSend.guild_id = self.guild_id
	msgToSend.page = self.page
	gt.socketClient:sendMessage(msgToSend)
    gt.showLoadingTips("")
end

function MatchRecord:showMatchRecord()
	self.lstRecord:setVisible(true)
end

function MatchRecord:onRcvMatchRecord(msgTbl)
	gt.removeLoadingTips()

	self.msgTbl = msgTbl
	self.lstRecord:removeAllChildren()
	if #msgTbl.room_data_list == 0 and msgTbl.page == 1 then
		self.emptyInfo:setVisible(true)
	else
        self.emptyInfo:setVisible(false)
		-- 显示战绩列表
        for i, cellData in ipairs(msgTbl.room_data_list) do
			local item
            if cellData.room_setting.max_chairs == 4 then
                item = self:createRecordItem(self.pRecord6:clone(), i, cellData)      
			elseif cellData.room_setting.max_chairs == 6 then
				item = self:createRecordItem(self.pRecord6:clone(), i, cellData)
			elseif cellData.room_setting.max_chairs == 8 then
				item = self:createRecordItem(self.pRecord8:clone(), i, cellData)
			elseif cellData.room_setting.max_chairs == 10 then
				item = self:createRecordItem(self.pRecord10:clone(), i, cellData)
			else
				item = self:createRecordItem(self.pRecord12:clone(), i, cellData)
			end
			self.lstRecord:pushBackCustomItem(item)
		end
	end
	if #msgTbl.room_data_list < 10 then
		self.btnNextPage:setEnabled(false)
	else
		self.btnNextPage:setEnabled(true)
	end
	if msgTbl.page == 1 then
		self.btnPrevPage:setEnabled(false)
	else
		self.btnPrevPage:setEnabled(true)
	end
end

function MatchRecord:onRcvReplay(msgTbl)
	gt.log("----------nowtime---------")
	local replayLayer = require("app/views/ReplayLayer"):create(msgTbl,true)
	self:addChild(replayLayer, 6)
end

function MatchRecord:onRcvShareVideoId(msgTbl)
	local nameString =  gt.interceptString(gt.nickname)
	local description = "玩家[".. nameString .. "]分享了一个回放码：" .. msgTbl.shareId .. "，在大厅点击进入战绩页面，然后点击查看他人回放回访按钮，输入回访码点击确定后即可查看。"
	gt.log(description)
	
	extension.shareToURL(extension.SHARE_TYPE_SESSION, "战斗牛", description, gt.shareWeb)
end

-- start --
--------------------------------
-- @class function
-- @description 创建战绩条目
-- @param cellData 条目数据
-- end --
function MatchRecord:createRecordItem(item, tag, cellData)
	--房间号
	local roomIDLabel = item:getChildByName("Text_RoomID")
	roomIDLabel:setString(string.format("房间号:%d", cellData.room_id))

    -- 分享
    local btnShare = item:getChildByName("Btn_Share")
    gt.addBtnPressedListener(btnShare, function(sender)
		self.lstRecord:jumpToItem(tag-1, cc.p(0,0), cc.p(0,0))
        local Item = sender:getParent()
		self:screenshotShareToWX(Item, tag, cellData)
	end)

    --房间信息
    local roomInfo = item:getChildByName("Text_RoomInfo")
    local strRule, strRate, strScore, baseScore, rate, tuizhu, strSpecial , SSS_str = gt.getRoomInfo(cellData.room_setting, true)
   -- roomInfo:setString(strRule..strRate..strScore..baseScore..rate..tuizhu..strSpecial)

    if cellData.room_setting.game_id == gt.GameID.SSS and cellData.game_type == 7 then
        roomInfo:setString(strRule..strScore..SSS_str)
    else
        roomInfo:setString(strRule..strRate..strScore..baseScore..rate..tuizhu..strSpecial..SSS_str)
    end

	--对战时间
	local timeLabel = item:getChildByName("Text_Time")
	timeLabel:setString(cellData.time)

    --游戏类型
    local gameType = item:getChildByName("Text_GameType")
	gameType:setString(gt.getGameTypeDesc(cellData.room_setting.game_id,cellData.room_setting.game_type))


    local num = #(cellData.players)
    local maxscore = 0
    local maxplayers={}
    local leastscore = 0
    local leastplayers={}
	-- 玩家分数
	for i, v in ipairs(cellData.players or {}) do
        local panelPlayer = item:getChildByName("Panel_Player"..i)
        
        local imgHead = panelPlayer:getChildByName("Img_Head")
        local head_image_file = string.format("%shead_%d.png", cc.FileUtils:getInstance():getWritablePath(), v.user_id)
        if cc.FileUtils:getInstance():isFileExist(head_image_file) then
            imgHead:loadTexture(head_image_file)
        else
            imgHead:loadTexture("image/common/img_head.png")
        end

        --玩家昵称
		local nickname = panelPlayer:getChildByName("Text_PlayerName")
        nickname:setString(gt.interceptString(gt.checkName(v.info.nick,8)))

        --玩家ID
        local lableID = panelPlayer:getChildByName("Text_ID")
        lableID:setString( string.format("ID:%s", gt.commonTool:hideText(v.user_id, self.isShowId) ))

        --分数
		local Label_TotalWin = panelPlayer:getChildByName("Text_TotalWin")
		local Label_TotalLose = panelPlayer:getChildByName("Text_TotalLose")
		if v.score > 0 then
			Label_TotalWin:setVisible(true)
			Label_TotalLose:setVisible(false)
			Label_TotalWin:setString("/"..tostring(v.score))
		else
			Label_TotalWin:setVisible(false)
			Label_TotalLose:setVisible(true)
			if 0 == v.score then
				Label_TotalLose:setString(tostring(v.score))
			else
				Label_TotalLose:setString("/"..tostring(v.score))
			end
		end
        
		-- 积分
		local ptLabel = panelPlayer:getChildByName("Text_MScore")
		ptLabel:setString(v.pt)

        local winner = panelPlayer:getChildByName("Img_Winner")
        --大赢家
        winner:setVisible(false)
		if v.score > maxscore then 
		    maxscore = v.score
		    maxplayers = {}
		    table.insert(maxplayers,i)
		elseif v.score == maxscore then 
			table.insert(maxplayers,i)
		end

        --土豪
		if v.score < leastscore then 
		    leastscore = v.score
		    leastplayers = {}
		    table.insert(leastplayers,i)
		elseif v.score == leastscore then 
			table.insert(leastplayers,i)
		end     

        --性别
        local sex = panelPlayer:getChildByName("Img_Sex")
        if v.info.sex == 2 then
            sex:loadTexture("image/NewReport/woman.png")
		else
			sex:loadTexture("image/NewReport/man.png")
	    end
	end

    for i = 1 ,#(maxplayers) do
        local panelPlayer = item:getChildByName("Panel_Player"..maxplayers[i])
        local win = panelPlayer:getChildByName("Img_Winner")
        win:setVisible(true)
		win:loadTexture("image/record/img_sign.png", ccui.TextureResType.plistType)
    end
    for i = 1 ,#(leastplayers) do
        local panelPlayer = item:getChildByName("Panel_Player"..leastplayers[i])
        local tycoon = panelPlayer:getChildByName("Img_Winner")
        tycoon:setVisible(true)
		tycoon:loadTexture("image/record/img_tycoon.png", ccui.TextureResType.plistType)
    end

    -- 多余界面
	for i = num+1, cellData.room_setting.max_chairs do
		local panel = item:getChildByName("Panel_Player"..i)
        panel:removeAllChildren()
	end
	if 4 == cellData.room_setting.max_chairs then
		item:getChildByName("Panel_Player"..5):removeAllChildren()
		item:getChildByName("Panel_Player"..6):removeAllChildren()
	end

    item:addClickEventListener(function(sender)
        self.tableScore = {}
        gt.soundEngine:playEffect(gt.clickBtnAudio, false)
        local data = self.room_data[tag]
        if data and data.room_setting and data.room_setting.game_id then
	        self.recordType = data.room_setting.game_id
	    end

        for i = 1, #data.players do
            table.insert(self.tableScore, data.players[i].score)  
        end
		self.chairs = data.room_setting.max_chairs
        local msgToSend = {}
        msgToSend.cmd = gt.RECORD_INFO
        msgToSend.id = data.id
        gt.socketClient:sendMessage(msgToSend)
		gt.showLoadingTips("")
    end)

    return item
end

-- 服务器返回某条战绩的牌局数据
function MatchRecord:onRcvHistoryOne(msgTbl)
    gt.removeLoadingTips()
    if (msgTbl.code == 0) then
        self.lstRecord:setVisible(false)
        local roundHistory = require("app/views/RoundRecord"):create(msgTbl.room_data, self.recordType, self.tableScore, self.chairs)
        self:addChild(roundHistory)
        roundHistory:setTag(10000)
        self.roundRecord = true
    end
end

function MatchRecord:screenshotShareToWX(item, tag, cellData)
	local function afterCaptured(succeed, outputFile)
		if succeed then
			extension.shareToImage(extension.SHARE_TYPE_SESSION, self.shareImgFilePath)
		else

		end
	end
	local screenshotFileName = string.format("wx-%s.jpg", os.date("%Y-%m-%d_%H:%M:%S", os.time()))

	self.shareImgFilePath = cc.FileUtils:getInstance():getWritablePath() .. screenshotFileName
	-- 移除纹理缓存
	cc.Director:getInstance():getTextureCache():removeTextureForKey(self.shareImgFilePath)
	-- 截屏
	cc.utils:captureScreen(afterCaptured, screenshotFileName)
end

return MatchRecord

