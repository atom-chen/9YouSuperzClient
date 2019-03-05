

local gt = cc.exports.gt

local FinalReport = class("FinalReport", function()
	return gt.createMaskLayer()
end)

function FinalReport:ctor(roomId, guildId, isMatch, roomPlayers, rptMsgTbl, tableSetting)
	-- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))
	
	local playerNum = #rptMsgTbl.player_data
	self.chartNum = 4
    local csbName = "csd/FinalReport4.csb"
    if 10 < playerNum then
		csbName="csd/FinalReport12.csb"
		self.chartNum = 12
	elseif 8 < playerNum then
		csbName="csd/FinalReport10.csb"
		self.chartNum = 10
	elseif 6 < playerNum then
		csbName="csd/FinalReport8.csb"
		self.chartNum = 8
	elseif 4 < playerNum then
		csbName="csd/FinalReport6.csb"
		self.chartNum = 6
	end
	local csbNode = cc.CSLoader:createNode(csbName)

	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
    ccui.Helper:doLayout(csbNode)
	self:addChild(csbNode)
	self.rootNode = csbNode
	
    self.tableSetting = tableSetting
    self.msgTbl = rptMsgTbl
    self.roomId = roomId
	
	local scoreBgs = {}
	for i = 1, self.chartNum do
		scoreBgs[i] = gt.seekNodeByName(csbNode, "Img_ScoreBg_"..i)
	end
	
	local textGuild = gt.seekNodeByName(self.rootNode, "Text_Guild")
	textGuild:setString("")
	if guildId and guildId > 0 then
		self.isShowId = false
		if gt.UnionManager then
			if string.len(guildId) == 5 then
				textGuild:setString("大联盟ID: "..tostring(guildId))
				self.isShowId = gt.UnionManager:isGuildAdmin(guildId) or gt.UnionManager:isGuildOwner(guildId)
			else
				textGuild:setString("俱乐部ID: "..tostring(guildId))
				self.isShowId = gt.guildManager:isGuildAdmin(guildId) or gt.guildManager:isGuildOwner(guildId)
			end
		end
	end

	local playerDatas = rptMsgTbl.player_data
	table.sort(playerDatas, function (a,b)
         return a.score > b.score
    		end)

    local score = {}

    local maxscore = 0
    local maxplayers={}
    local leastscore = 0
    local leastplayers={}
	for i, v in ipairs(playerDatas) do
		local seatIdx = v.seat + 1
		local roomPlayer = roomPlayers[seatIdx]
		local node = scoreBgs[i]
		-- 头像
		local head_image_file = string.format("%shead_%d.png", cc.FileUtils:getInstance():getWritablePath(), v.player)
		if cc.FileUtils:getInstance():isFileExist(head_image_file) then
			 gt.seekNodeByName(node, "Spr_Head"):setTexture(head_image_file)
		end
        -- 性别
        local sex = gt.seekNodeByName(node, "Img_Sex")
        -- 默认男
	    if v.sex == 2 then	-- 女
			sex:loadTexture("image/NewReport/woman.png")
		else
			sex:loadTexture("image/NewReport/man.png")
	    end
        --大赢家
        local winner = gt.seekNodeByName(node, "Img_Winner")
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
        
		-- 昵称
		--Error
		--在客户端切到后台回来的时候会清掉本地数据(为了解决卡21局一个错误的通信流程)
		--如果在结算之前客户端在后台 再回来必会出现昵称不显示
		if roomPlayer then
			node:getChildByName("Label_Nick"):setString(gt.checkName(roomPlayer.nickname, 6))
		end
		if v.nick then
			node:getChildByName("Label_Nick"):setString(gt.checkName(v.nick, 5))
		end
		
		-- ID
		node:getChildByName("Label_ID"):setString("ID:" ..  gt.commonTool:hideText(v.player, self.isShowId))

		-- 总分数
		local nodeScore
		local nodeMatch = node:getChildByName("Node_Match")
		local nodeNormal = node:getChildByName("Node_Normal")
		nodeMatch:setVisible(isMatch > 0)
		nodeNormal:setVisible(isMatch == 0)
		if isMatch > 0 then
			nodeScore = nodeMatch
			nodeScore:getChildByName("Label_MScore"):setString(v.pt)
		else
			nodeScore = nodeNormal
		end
		local Label_TotalWin = nodeScore:getChildByName("Label_TotalWin")
		local Label_TotalLose = nodeScore:getChildByName("Label_TotalLose")
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
	end
    
    for i = 1 ,#(maxplayers) do
        local reportNode = gt.seekNodeByName(csbNode, "Img_ScoreBg_"..maxplayers[i])
        local win = gt.seekNodeByName(reportNode, "Img_Winner")
        win:setVisible(true)
		win:loadTexture("image/NewReport/bigWinFlag.png")
    end
    for i = 1 ,#(leastplayers) do
        local reportNode = gt.seekNodeByName(csbNode, "Img_ScoreBg_"..leastplayers[i])
        local tycoon = gt.seekNodeByName(reportNode, "Img_Winner")
        tycoon:setVisible(true)
		tycoon:loadTexture("image/NewReport/bigLoseFlag.png")
    end

	--空座位
	for i = playerNum + 1, self.chartNum do
        scoreBgs[i]:removeAllChildren()
	end

 	-- 返回游戏大厅
	local backBtn = gt.seekNodeByName(csbNode, "Btn_Back")
	if isMatch > 0 then
		backBtn:loadTextureNormal("image/NewReport/btnBackRoom.png")
	end
	gt.addBtnPressedListener(backBtn, function()
		if isMatch > 0 then
			--gt.dispatchEvent(gt.EventType.PLAY_SCENE_RESTART)
			self:removeFromParent()
		else
			gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE)
		end
		--防止某些人狂点死锁
		backBtn:setEnabled(false)
		backBtn:runAction(cc.Sequence:create(cc.DelayTime:create(5),cc.CallFunc:create(function()
			if backBtn then
				backBtn:setEnabled(true)
			end
		end)))
	end)

	-- 分享
	local shareBtn = gt.seekNodeByName(csbNode, "Btn_Share")
	gt.addBtnPressedListener(shareBtn, function()
		shareBtn:setEnabled(false)
		self:screenshotShareToWX2()
	end)

	if gt.isIOSReview() then
		shareBtn:setVisible(false)
	else
		shareBtn:setVisible(true)
	end

	self:showTableSetting(tableSetting.game_type,tableSetting.game_id)

end

function FinalReport:showTableSetting(game_type,game_id)
    --房间信息
    local lbTitle = gt.seekNodeByName(self.rootNode, "lbTitle")
    local textTime = gt.seekNodeByName(self.rootNode, "Text_Time")
    local fraction = ""
    local strTui = ""
    if game_type ~= gt.GameType.GAME_TOGETHER and self.tableSetting.game_type ~= gt.GameType.GAME_QH_BANKER then
        if self.tableSetting.score == 1 then
            fraction = "1/2"
        elseif self.tableSetting.score == 2 then
            fraction = "2/4"
		elseif self.tableSetting.score == 3 then
			fraction = "3/6"
		elseif self.tableSetting.score == 4 then
			fraction = "4/8"
		elseif self.tableSetting.score == 5 then
			fraction = "5/10"
		elseif self.tableSetting.score == 11 then
			fraction = "2/3/4/5"
		elseif self.tableSetting.score == 12 then
			fraction = "2/4/8/10"
		elseif self.tableSetting.score == 13 then
			fraction = "3/6/12/15"
		elseif self.tableSetting.score == 14 then
			fraction = "4/8/16/20"
		elseif self.tableSetting.score == 15 then
			fraction = "5/10/20/25"
		end
        -- 通比牛牛和琼海抢庄没有推注
        if (self.tableSetting.push_pledge ~= 0) then
            strTui = "推注"
        end
    else
        fraction = ""..self.tableSetting.score
    end
    --三公
    if self.tableSetting.game_id == gt.GameID.SANGONG then
        fraction = "5/10/15/20"
    	if game_type  ==  7 then
	        if (self.tableSetting.score == 5) then
	            fraction = "5/10/20/50"
	        elseif(self.tableSetting.score == 10) then
	            fraction = "10/30/50/100"
	        elseif(self.tableSetting.score == 20) then
	            fraction = "20/50/100/250"
	        end
    	else
	        if (self.tableSetting.score == 10) then
	            fraction = "10/20/30/40"
	        elseif(self.tableSetting.score == 20) then
	            fraction = "20/40/60/80"
	        end    
    	end
    end

    --明牌抢庄 xx人 xx局 6/8/10分 4倍抢庄 推注
    local tip = ""
    local strGameType = gt.GameTypeDesc[game_type]
    if self.tableSetting.game_id == gt.GameID.SANGONG then
        strGameType = gt.GameSGTypeDesc[game_type]
	elseif self.tableSetting.game_id==gt.GameID.TTZ then
		strGameType = gt.GameTTZTypeDesc[game_type]
	elseif self.tableSetting.game_id == gt.GameID.ZJH then
        strGameType = gt.GameZJHTypeDesc[game_type]
    elseif self.tableSetting.game_id == gt.GameID.SSS and  self.tableSetting.game_type == 7 then
        strGameType = gt.GameSSSTypeDesc[game_type]
    end

    if game_type == gt.GameType.GAME_BANKER then
        tip = string.format("房间号:%d  %s  %d人  %d局  %s分  %d倍抢庄  %s", self.roomId, strGameType, self.tableSetting.max_chairs, self.tableSetting.rounds, fraction, self.tableSetting.loot_dealer, strTui)
        if self.tableSetting.game_id == gt.GameID.SANGONG then
            tip = string.format("房间号:%d  %s  %d人  %d局  %s分  %s", self.roomId, strGameType, self.tableSetting.max_chairs, self.tableSetting.rounds, fraction, strTui)
        end
    elseif game_type == 7 and game_id==gt.GameID.SSS then
        tip = string.format("房间号:%d  %s  %d人  %d局  %d倍", self.roomId, strGameType, self.tableSetting.max_chairs, self.tableSetting.rounds, self.tableSetting.score)

        if self.tableSetting.gun and  self.tableSetting.gun == 1 then
                tip = tip.." 计分+1"
       elseif  self.tableSetting.gun and  self.tableSetting.gun == 0 then
                tip = tip.." 计分X2"
       end
    elseif game_type == gt.GameType.GAME_BULL and game_id==gt.GameID.NIUNIU then
        tip = string.format("房间号:%d  %s  %d人  %d局  %s分  庄家底分%d分  %s", self.roomId, strGameType, self.tableSetting.max_chairs, self.tableSetting.rounds, fraction, self.tableSetting.base_score, strTui)
    elseif game_type == gt.GameType.GAME_QH_BANKER then
    	if self.tableSetting.game_id == gt.GameID.SANGONG then
	        tip = string.format("房间号:%d  %s  %d人  %d局  底分%s分", self.roomId, strGameType, self.tableSetting.max_chairs, self.tableSetting.rounds, fraction)
    	else
	        tip = string.format("房间号:%d  %s  %d人  %d局  %d倍  底分%d分", self.roomId, strGameType, self.tableSetting.max_chairs, self.tableSetting.rounds, self.tableSetting.score, self.tableSetting.qh_base_score)
	    end
    
        
    else
        tip = string.format("房间号:%d  %s  %d人  %d局  %s分  %s", self.roomId, strGameType, self.tableSetting.max_chairs, self.tableSetting.rounds, fraction, strTui)
    end

    if game_id == gt.GameID.ZJH then
        tip = string.format("房间号:%d  %s  %d人  %d局  %s分封顶", self.roomId, strGameType, self.tableSetting.max_chairs, self.tableSetting.rounds, self.tableSetting.score)
    end

    lbTitle:setString(tip)
    textTime:setString(self.msgTbl.round_time)
end

function FinalReport:screenshotShareToWX()
	local layerSize = self.rootNode:getContentSize()
	local screenshot = cc.RenderTexture:create(layerSize.width, layerSize.height)
	screenshot:setAnchorPoint(0,0)
	screenshot:beginWithClear(0,0,0,0)
	self.rootNode:getParent():visit()
	screenshot:endToLua()

	local screenshotFileName = string.format("wx-%s.jpg", os.date("%Y-%m-%d_%H:%M:%S", os.time()))
	screenshot:saveToFile(screenshotFileName, cc.IMAGE_FORMAT_JPEG, false)

	self.shareImgFilePath = cc.FileUtils:getInstance():getWritablePath() .. screenshotFileName
	self.scheduleHandler = gt.scheduler:scheduleScriptFunc(handler(self, self.update), 0.1, false)
end

function FinalReport:update()
	if self.shareImgFilePath and cc.FileUtils:getInstance():isFileExist(self.shareImgFilePath) then
		gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
		local shareBtn = gt.seekNodeByName(self.rootNode, "Btn_Share")
		shareBtn:setEnabled(true)

		extension.shareToImage(extension.SHARE_TYPE_SESSION, self.shareImgFilePath)
		self.shareImgFilePath = nil
	end
end

function FinalReport:screenshotShareToWX2()
	local function afterCaptured(succeed, outputFile)
		if succeed then
			local shareBtn = gt.seekNodeByName(self.rootNode, "Btn_Share")
			shareBtn:setEnabled(true)
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

function FinalReport:onNodeEvent(eventName)
	if "enter" == eventName then
		local listener = cc.EventListenerTouchOneByOne:create()
		listener:setSwallowTouches(true)
		listener:registerScriptHandler(handler(self, self.onTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
	elseif "exit" == eventName then
		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:removeEventListenersForTarget(self)
	end
end

function FinalReport:onTouchBegan(touch, event)
	return true
end

return FinalReport


