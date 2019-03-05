local gt = cc.exports.gt

local HistoryRecord = class("HistoryRecord",function()
	return gt.createMaskLayer()
end)

--参数 showType： 0.只显示大厅战绩，1.只显示俱乐部战绩，否则两者都显示
function HistoryRecord:ctor(uid, guildId_, showType, gameType_)

	local csbNode = cc.CSLoader:createNode("csd/FinalRecord.csb")
	csbNode:setAnchorPoint(0.5,0.5)
	csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
    --ccui.Helper:doLayout(csbNode)
	self:addChild(csbNode)
	self.rootNode = csbNode

	gt.showLoadingTips("")

	-- 注册消息回调
	gt.socketClient:registerMsgListener(gt.RECORD,self,self.onRcvHistoryRecord)
	gt.socketClient:registerMsgListener(gt.RECORD_INFO,self,self.onRcvHistoryOne)
	gt.registerEventListener(gt.EventType.CLOSE_ROUNDRECORD,self,self.showHistoryRecord)
	--gt.socketClient:registerMsgListener(gt.ROOM_REPLAY, self, self.onRcvReplay)
	--gt.socketClient:registerMsgListener(gt.RETSHAREVIDEOID, self, self.onRcvShareVideoId)

	self.emptyInfo = gt.seekNodeByName(csbNode,"Text_Info")
	self.emptyInfo:setVisible(false)
	
	self.panelBtn = gt.seekNodeByName(csbNode, "Panel_Btn")
	self.panelBtn:setContentSize(gt.winSize)
	local btnNiu = gt.seekNodeByName(self.panelBtn, "Btn_NiuNiu")
    local btnSG = gt.seekNodeByName(self.panelBtn, "Btn_SanGong")
    local btnYS = gt.seekNodeByName(self.panelBtn, "Btn_YSNiu")
    local btnQH = gt.seekNodeByName(self.panelBtn, "Btn_QH")
    local btnTTZ = gt.seekNodeByName(self.panelBtn, "Btn_TTZ")
    local btnZJH = gt.seekNodeByName(self.panelBtn, "Btn_ZJH")
    local btnSSS = gt.seekNodeByName(self.panelBtn,"Btn_SSS")
    local btnHistoryRecord = gt.seekNodeByName(csbNode, "Btn_History")
    local btnGuildRecord = gt.seekNodeByName(csbNode, "Btn_Guild")
	
	--panel ptemplateTable
	self.ptemplateTable = {}
--[[	self.panelNiu = gt.seekNodeByName(csbNode,"Panel_Niuniu")
	self.panelNiu:setVisible(true)--]]
	self.guildListVw = gt.seekNodeByName(csbNode, "ListView_GuildContent")
	local ptGuild6 = gt.seekNodeByName(self.guildListVw, "Panel_Template_6")
    local ptGuild8 = gt.seekNodeByName(self.guildListVw, "Panel_Template_8")
    local ptGuild10 = gt.seekNodeByName(self.guildListVw, "Panel_Template_10")
    local ptGuild12 = gt.seekNodeByName(self.guildListVw, "Panel_Template_12")

	--列表 宽+高适配
	local listSize = self.guildListVw:getContentSize()
	listSize.width = listSize.width + (gt.winSize.width - 1280)
	listSize.height = listSize.height + (gt.winSize.height - 720)
	self.guildListVw:setContentSize(listSize)
		
	--列表项 宽度适配
	local tempSize = ptGuild6:getContentSize()
	tempSize.width = tempSize.width + (gt.winSize.width - 1280)
	ptGuild6:setContentSize(tempSize)
	ptGuild8:setContentSize(tempSize)
	ptGuild10:setContentSize(tempSize)
	
	ptGuild6:retain()
	ptGuild8:retain()
	ptGuild10:retain()
	table.insert(self.ptemplateTable, ptGuild6)
	table.insert(self.ptemplateTable, ptGuild8)
	table.insert(self.ptemplateTable, ptGuild10)
	if ptGuild12 then
		ptGuild12:setContentSize(tempSize)
		ptGuild12:retain()
		table.insert(self.ptemplateTable, ptGuild12)
	end
	ccui.Helper:doLayout(csbNode)
	self.guildListVw:removeAllChildren()
	self.guildListVw:setVisible(true)
	
	self.page = 1
	self.refreshTime = 0
    self.roundRecord = false
	
    self.recordType = cc.UserDefault:getInstance():getIntegerForKey("recordType", 1)  -- 1表示牛牛，2表示三公，3表示元帅抢庄
    self.guild = cc.UserDefault:getInstance():getIntegerForKey("guildType", 0)
    if gameType_ then
    	self.recordType = gameType_
    end
    if guildId_ then
    	self.guild = guildId_
--    	if guildId_ == 0 then
--    		self.recordType = 0
--    	end
    end
	
	--参数 showType： 0.只显示大厅战绩，1.只显示俱乐部战绩，否则两者都显示
	btnHistoryRecord:setVisible(false)
	btnGuildRecord:setVisible(false)
	if 0 == showType then
		self.guild = 0
	elseif 1 == showType then
		self.guild = 1
	else
		btnHistoryRecord:setVisible(true)
		btnGuildRecord:setVisible(true)
	end
	
    -- 关闭按钮
	local closeBtn = gt.seekNodeByName(csbNode, "Btn_Close")
	gt.addBtnPressedListener(closeBtn, function()
		self:close()
	end)

    -- 返回按钮
    local backBtn = gt.seekNodeByName(csbNode, "Btn_Back")
    gt.addBtnPressedListener(backBtn, function(sender)
		if self.panelBtn:isVisible() then
			self:close()
		else
			self.panelBtn:setVisible(true)
		end
    end)

	--查看对局按钮
	--    local btnCheckGame = gt.seekNodeByName(csbNode, "Btn_Check")
	--	gt.addBtnPressedListener(btnCheckGame, function()
	--        local roundRecord = require("app/views/RoundRecord"):create(uid)
	--        self:addChild(roundRecord,10)
	--        self:refresh()
	--	end)

	--	-- 查看他人战绩按钮
	--	local replayBtn = gt.seekNodeByName(csbNode, "Btn_replay")
	--	gt.addBtnPressedListener(replayBtn, function(sender)
	--		local viewOtherRecord = require("app/views/ViewOtherRecord"):create(self)
	--		self:addChild(viewOtherRecord)
	--	end)
	
    local function setShowPanelAndBtn(recordType, guild)
        if recordType == 0 then
            self.panelBtn:setVisible(true)
        else
            self.panelBtn:setVisible(false)
			
            btnHistoryRecord:setEnabled(guild == 1)
            btnGuildRecord:setEnabled(guild == 0)
        end
    end

	local function requestData(recordType, guild, page)
		
		self.guildListVw:removeAllChildren()
		
		self:sendHttpRequest(recordType,page)
		-- local msgToSend = {}
		-- msgToSend.cmd = gt.RECORD
		-- msgToSend.user_id = uid
		-- msgToSend.game_id = recordType
		-- msgToSend.guild = guild
  --       msgToSend.page = page
		-- gt.socketClient:sendMessage(msgToSend)
		gt.showLoadingTips("")
	end

	local function showPanel(recordType, guild)
        cc.UserDefault:getInstance():setIntegerForKey("recordType", recordType)
        cc.UserDefault:getInstance():setIntegerForKey("guildType", guild)
		if self.roundRecord == true then
			self:removeChildByTag(10000)
		end

        setShowPanelAndBtn(recordType, guild)

		self.recordType = recordType
		self.guild = guild	
		requestData(recordType, guild, 1)
	end

	-- 牛牛按钮
	gt.addBtnPressedListener(btnNiu,function(sender)
		showPanel(1,self.guild)
	end)

	-- 三公按钮
	gt.addBtnPressedListener(btnSG,function(sender)
		showPanel(2,self.guild)
	end)

	-- 元帅抢庄
	gt.addBtnPressedListener(btnYS,function(sender)
		showPanel(3,self.guild)
	end)

    -- 琼海抢庄
	gt.addBtnPressedListener(btnQH,function(sender)
		showPanel(4,self.guild)
    end)

    -- 推筒子
    gt.addBtnPressedListener(btnTTZ, function(sender)
        showPanel(5, self.guild)
	end)

    --炸金花
    gt.addBtnPressedListener(btnZJH, function(sender)
        showPanel(6, self.guild)
    end)

    --十三水
    gt.addBtnPressedListener(btnSSS, function(sender)
        showPanel(7, self.guild)
    end)

    -- 历史战绩
    gt.addBtnPressedListener(btnHistoryRecord, function(sender)
		showPanel(self.recordType, 0)
    end)

	-- 俱乐部战绩
	gt.addBtnPressedListener(btnGuildRecord,function(sender)
		showPanel(self.recordType, 1)
	end)

    self.lblPage = gt.seekNodeByName(csbNode, "Text_Page")
	-- 上一页
	self.btnPrevPage = gt.seekNodeByName(csbNode, "Btn_PrevPage")
	gt.addBtnPressedListener(self.btnPrevPage, function()
		if self.page > 1 then
			self.page = self.page - 1
			self.lblPage:setString(tostring(self.page))
			requestData(self.recordType, self.guild, self.page)
		end
	end)
	
	-- 下一页
	self.btnNextPage = gt.seekNodeByName(csbNode, "Btn_NextPage")
	gt.addBtnPressedListener(self.btnNextPage, function()
		self.page = self.page + 1
		self.lblPage:setString(tostring(self.page))
		requestData(self.recordType, self.guild, self.page)
	end)
	
	--查看他人战绩
	local btnCheck = gt.seekNodeByName(csbNode,"Btn_CheckReplay")
	gt.addBtnPressedListener(btnCheck,function(sender)
		require("app/views/NoticeTips"):create("提示","敬请期待",nil,nil,true)
	end)

	-- 发送请求战绩消息
	requestData(self.recordType, self.guild, self.page)
    setShowPanelAndBtn(self.recordType, self.guild)
end

function HistoryRecord:close()
	-- 移除消息回调
	gt.socketClient:unregisterMsgListener(gt.RECORD)
	gt.socketClient:unregisterMsgListener(gt.RECORD_INFO)
    -- 移除事件回调
	gt.removeTargetAllEventListener(self)
    for k, v in ipairs(self.ptemplateTable) do
        v:release()
    end
	-- 移除界面,返回主界面
	self:removeFromParent()
end

function HistoryRecord:refresh()
	local current = os.time()
	if self.refreshTime + 5 > current then
		return
	end
	self.refreshTime = current

	local msgToSend = {}
	msgToSend.cmd = gt.RECORD
	msgToSend.user_id = gt.playerData.uid
	gt.socketClient:sendMessage(msgToSend)

	gt.showLoadingTips("")
end

function HistoryRecord:showHistoryRecord()
--	self.panelNiu:setVisible(true)
end

function HistoryRecord:sendHttpRequest(recordType, page)
	local url = "http://api.mgklqp.9you.net:8080/api/guildrecord/player_record_3days"

	local param = {}
	for i = 1,3 do 
		param[i] = {}
	end
	param[1].user_id = gt.playerData.uid
	param[2].game_id = recordType
	param[3].page = page

	local sendParam = gt.commonTool:encodeSignRecord(param)

	gt.commonTool:sendHttpRecord(url,sendParam, function(infoData)
		-- body
		gt.removeLoadingTips()
		self.room_data = infoData.room_data

	    if #self.room_data == 0 and self.page == 1 then
			-- 没有战绩
			--gt.log("----------nowtime---------",#msgTbl.m_data)
			self.emptyInfo:setVisible(true)
		else
			self.emptyInfo:setVisible(false) 
            local function createList(ptemplateTable, guildListVw, roomDataList)
				for i,cellData in ipairs(roomDataList) do
					local index = cellData.room_setting.max_chairs/2 - 2
					if 0 == index then
						index = 1
					end
					local historyItem = self:createHistoryItem(ptemplateTable[index]:clone(), i, cellData)
			        guildListVw:pushBackCustomItem(historyItem)
		        end
            end
			createList(self.ptemplateTable, self.guildListVw, self.room_data)

	    end	    
	    self:refreshPageAndPreNext()

	end)
end

function HistoryRecord:onRcvHistoryRecord(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
	    if #msgTbl.room_data_list == 0 and msgTbl.page == 1 then
			-- 没有战绩
			--gt.log("----------nowtime---------",#msgTbl.m_data)
			self.emptyInfo:setVisible(true)
		else
			self.emptyInfo:setVisible(false)
            local function createList(ptemplateTable, guildListVw, roomDataList)
				for i,cellData in ipairs(roomDataList) do
					local index = cellData.room_setting.max_chairs/2 - 2
					if 0 == index then
						index = 1
					end
					local historyItem = self:createHistoryItem(ptemplateTable[index]:clone(), i, cellData)
			        guildListVw:pushBackCustomItem(historyItem)
		        end
            end
			createList(self.ptemplateTable, self.guildListVw, msgTbl.room_data_list)
			self.msgTbl = msgTbl
	    end	    
	    self:refreshPageAndPreNext(msgTbl)
    end
end

function HistoryRecord:refreshPageAndPreNext(msgTbl)
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
    
    -- self.page = msgTbl.page
    self.lblPage:setString(tostring(self.page))
end

function HistoryRecord:onRcvReplay(msgTbl)
	gt.log("----------nowtime---------")
	local replayLayer = require("app/views/ReplayLayer"):create(msgTbl,true)
	self:addChild(replayLayer,6)
end

function HistoryRecord:onRcvShareVideoId(msgTbl)
	-- local nickName = ""
	-- local tab = {}
	-- for uchar in string.gfind(gt.nickname, "[%z\1-\127\194-\244][\128-\191]*") do 
	-- 	tab[#tab+1] = uchar
	-- 	if #tab <= 6 then
	-- 		nickName = nickName .. uchar
	-- 	end
	-- end
	-- if #tab > 6 then
	-- 	nickName = nickName .. "..."
	-- end
	local nameString = gt.interceptString(gt.nickname)
	local description = "玩家[" .. nameString .. "]分享了一个回放码：" .. msgTbl.shareId .. "，在大厅点击进入战绩页面，然后点击查看他人回放回访按钮，输入回访码点击确定后即可查看。"
	gt.log(description)
	
	extension.shareToURL(extension.SHARE_TYPE_SESSION, "战斗牛", description, gt.shareWeb)

end

-- start --
--------------------------------
-- @class function
-- @description 创建战绩条目
-- @param cellData 条目数据
-- end --
function HistoryRecord:createHistoryItem(item,tag,cellData)
	--    local item = self.pTemplate:clone()

	-- 俱乐部ID
	local guildIDNode = gt.seekNodeByName(item,"Text_GuildID")
	if self.guild == 1 then
		guildIDNode:setVisible(true)
		guildIDNode:setString(string.format("俱乐部ID:%d", cellData.guild_id))
	else
		guildIDNode:setVisible(false)
    end

	--房间号
	local roomIDLabel = item:getChildByName("Text_RoomID")
	roomIDLabel:setString(string.format("房间号:%d", cellData.room_id))

	--规则详情按钮
	--    local btnRuleInfo = gt.seekNodeByName(item, "Btn_RuleInfo")
	--    gt.addBtnPressedListener(btnRuleInfo, function()
	--        local roomInfo = require("app/views/RoomInfo"):create(cellData.room_setting, cellData.room_id)
	--	    self:addChild(roomInfo)
	--    end)
	--    btnRuleInfo:setVisible(false)

	-- 分享
	local btnShare = gt.seekNodeByName(item,"Btn_Share")
	gt.addBtnPressedListener(btnShare,function(sender)
		self.guildListVw:jumpToItem(tag-1, cc.p(0,0), cc.p(0,0))
		local Item = sender:getParent()
		self:screenshotShareToWX(Item,tag,cellData)
	end)

    --房间信息
    local roomInfo = gt.seekNodeByName(item, "Text_RoomInfo")
    local strRule, strRate, strScore, baseScore, rate, tuizhu, strSpecial, sssStr = gt.getRoomInfo(cellData.room_setting, true)
    roomInfo:setString(strRule..strRate..strScore..baseScore..rate..tuizhu..strSpecial..sssStr)

	--对战时间
	local timeLabel = gt.seekNodeByName(item,"Text_Time")
	timeLabel:setString(cellData.time)

	--游戏类型
	local gameType = gt.seekNodeByName(item,"Text_GameType")
--	gameType:setString(gt.GameTypeDesc[cellData.room_setting.game_type])
	local strGameType = gt.GameTypeDesc[cellData.room_setting.game_type]
	if cellData.room_setting.game_id == gt.GameID.SANGONG then
--		gameType:setString(gt.GameSGTypeDesc[cellData.room_setting.game_type])
		strGameType = gt.GameSGTypeDesc[cellData.room_setting.game_type]
    elseif cellData.room_setting.game_id == gt.GameID.TTZ then
--        gameType:setString(gt.GameTTZTypeDesc[cellData.room_setting.game_type])
		strGameType = gt.GameTTZTypeDesc[cellData.room_setting.game_type]
    elseif cellData.room_setting.game_id == gt.GameID.ZJH then
--        gameType:setString(gt.GameZJHTypeDesc[cellData.room_setting.game_type])
		strGameType = gt.GameZJHTypeDesc[cellData.room_setting.game_type]
    elseif cellData.room_setting.game_id == gt.GameID.SSS then
--        gameType:setString(gt.GameSSSTypeDesc[cellData.room_setting.game_type])
		strGameType = gt.GameSSSTypeDesc[cellData.room_setting.game_type]
    end

	gameType:setString(strGameType..string.format("(%d局)",cellData.rounds))

	--游戏总局数
--[[	local txtRounds = gt.seekNodeByName(item,"Txt_Rounds")
	txtRounds:setString("")--]]

	local num = #(cellData.players)
	local maxscore = 0
	local maxplayers = {}
	local leastscore = 0
	local leastplayers = {}
	-- 玩家分数
	for i,v in ipairs(cellData.players or {}) do
		local panelPlayer = gt.seekNodeByName(item,"Panel_Player" .. i)
		local nickname = gt.seekNodeByName(panelPlayer,"Text_PlayerName")

		--显示玩家数据
		--        local player = gt.seekNodeByName(item, "Panel_Player_"..i)
		--        player:setVisible(true)

		-- 玩家头像
		local imgHead = panelPlayer:getChildByName("Img_Head")
		local head_image_file = string.format("%shead_%d.png",cc.FileUtils:getInstance():getWritablePath(),v.user_id)
		if cc.FileUtils:getInstance():isFileExist(head_image_file) then
			imgHead:loadTexture(head_image_file)
		else
			imgHead:loadTexture("image/common/img_head.png")
		end

		--玩家昵称
		local nameString = gt.interceptString(gt.checkName(v.info.nick,5))
		nickname:setString(nameString)

		--玩家ID
		local lableID = gt.seekNodeByName(panelPlayer,"Text_ID")
		lableID:setString( string.format("ID:%d",v.user_id))

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

		local winner = gt.seekNodeByName(panelPlayer,"Img_Winner")
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
		local sex = gt.seekNodeByName(panelPlayer,"Img_Sex")
		local path = "man"
		if v.info.sex == 2 then
			path = "woman"
		end
		sex:loadTexture("image/common/" .. path .. ".png")
	end

	for i = 1,#(maxplayers) do
		local panelPlayer = gt.seekNodeByName(item,"Panel_Player" .. maxplayers[i])
		local win = gt.seekNodeByName(panelPlayer,"Img_Winner")
		win:setVisible(true)
		win:loadTexture("image/record/img_sign.png",ccui.TextureResType.plistType)
	end
	for i = 1,#(leastplayers) do
		local panelPlayer = gt.seekNodeByName(item,"Panel_Player" .. leastplayers[i])
		local tycoon = gt.seekNodeByName(panelPlayer,"Img_Winner")
		tycoon:setVisible(true)
		tycoon:loadTexture("image/record/img_tycoon.png",ccui.TextureResType.plistType)
	end

    -- 多余界面
	for i = num+1, cellData.room_setting.max_chairs do
		local panel = gt.seekNodeByName(item, "Panel_Player"..i)
		if panel then
	        panel:removeAllChildren()
	    end
	end
	for i = cellData.room_setting.max_chairs+1, 6 do
		local panel = gt.seekNodeByName(item, "Panel_Player"..i)
		if panel then
	        panel:removeAllChildren()
	    end
	end
	item:addClickEventListener(function()
		gt.showLoadingTips("")
		self.tableScore = {}
		gt.soundEngine:playEffect(gt.clickBtnAudio,false)
		local data = self.room_data[tag]
		
        self.chairs = data.room_setting.max_chairs
        for i = 1, #data.players do
            table.insert(self.tableScore, data.players[i].score)
        end
        local msgToSend = {}
        msgToSend.cmd = gt.RECORD_INFO
        msgToSend.id = data.id
        gt.socketClient:sendMessage(msgToSend)
    end)

	return item
end

-- 服务器返回某条战绩的牌局数据
function HistoryRecord:onRcvHistoryOne(msgTbl)
	gt.removeLoadingTips()
	if (msgTbl.code == 0) then
        local roundHistory = require("app/views/RoundRecord"):create(msgTbl.room_data, self.recordType, self.tableScore, self.chairs)
        self:addChild(roundHistory)
        roundHistory:setTag(10000)
        self.roundRecord = true
    end
end


function HistoryRecord:screenshotShareToWX(item,tag,celldata)
	
	local function afterCaptured(succeed, outputFile)
		if succeed then
			extension.shareToImage(extension.SHARE_TYPE_SESSION,self.shareImgFilePath)
		end
	end
	local screenshotFileName = string.format("wx-%s.jpg", os.date("%Y-%m-%d_%H:%M:%S", os.time()))

	self.shareImgFilePath = cc.FileUtils:getInstance():getWritablePath() .. screenshotFileName
	-- 移除纹理缓存
	cc.Director:getInstance():getTextureCache():removeTextureForKey(self.shareImgFilePath)
	-- 截屏
	cc.utils:captureScreen(afterCaptured, screenshotFileName)
end

return HistoryRecord

