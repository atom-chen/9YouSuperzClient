-- 俱乐部排行榜

local gt = cc.exports.gt

local GuildRank = class("GuildRank", function()
	return gt.createMaskLayer()
end)

function GuildRank:ctor(guild_id, is_union)
	self:registerScriptHandler(handler(self, self.onNodeEvent))

	local csbNode = cc.CSLoader:createNode("csd/Guild/GuildRank.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	self.currentGuild = nil
	gt.log("-----openUI:GuildRank")
	self.guild_id = guild_id
	self.is_union = is_union or false
	if self.is_union then
		self.currentGuild = gt.UnionManager:getGuild(guild_id)
		self.isShowId = gt.UnionManager:isGuildAdmin(guild_id) or gt.UnionManager:isGuildOwner(guild_id)
	else
		self.currentGuild = gt.guildManager:getGuild(guild_id)
		self.isShowId = gt.guildManager:isGuildAdmin(guild_id) or gt.guildManager:isGuildOwner(guild_id)
	end

	self:initUI()
	self:initListRank()
	self:initTab()

	self:changeTab(self.btnTabScore)

	gt.socketClient:registerMsgListener(gt.MATCH_RANK, self, self.onRcvMatchRank)
end 

function GuildRank:initTab()
	self.btnTabScore = gt.seekNodeByName(self.csbNode, "btnTabScore")
	self.btnTabWin7 = gt.seekNodeByName(self.csbNode, "btnTabWin7")
	self.btnTabTotal7 = gt.seekNodeByName(self.csbNode, "btnTabTotal7")
	self.btnTabYesterdayWin = gt.seekNodeByName(self.csbNode, "btnTabYesterdayWin")
	self.btnTabYesterdayLose = gt.seekNodeByName(self.csbNode, "btnTabYesterdayLose")

	local function onTab(sender, eventType)
		if eventType == TOUCH_EVENT_ENDED then
			self:changeTab(sender)
		end
	end
	self.btnTabScore:addTouchEventListener(onTab)
    self.btnTabWin7:addTouchEventListener(onTab)
    self.btnTabTotal7:addTouchEventListener(onTab)
    self.btnTabYesterdayWin:addTouchEventListener(onTab)
    self.btnTabYesterdayLose:addTouchEventListener(onTab)

	self.lblHeadScore = gt.seekNodeByName(self.csbNode, "lblHeadScore")
	self.lblHead7 = gt.seekNodeByName(self.csbNode, "lblHead7")
	self.lblHeadYesterday = gt.seekNodeByName(self.csbNode, "lblHeadYesterday")


	self.btnTabYesterdayWin:setVisible(self.isShowId)
	self.btnTabYesterdayLose:setVisible(self.isShowId)
end


function GuildRank:changeTab(sender)
	self.curSender= sender
	self.btnTabScore:setEnabled(true)
    self.btnTabWin7:setEnabled(true)
    self.btnTabTotal7:setEnabled(true)
    self.btnTabYesterdayWin:setEnabled(true)
    self.btnTabYesterdayLose:setEnabled(true)
    self:refreshSearchState(false)

    self.lblHeadScore:setVisible(false)
    self.lblHead7:setVisible(false)
    self.lblHeadYesterday:setVisible(false)

    self.lblTips:setVisible(false)
    local limit = 5000
    self.listRank_helper:SetItemsData({})
	if sender == self.btnTabScore then
		self.btnTabScore:setEnabled(false)
    	self.lblHeadScore:setVisible(true)
    	self.lblTips:setVisible(true)
		self:sendRankScore()
		limit = 10000
		
	elseif sender == self.btnTabWin7 then
		self.btnTabWin7:setEnabled(false)
    	self.lblHead7:setVisible(true)
    	self.lblTips:setVisible(true)
		self:sendRefreshHistory(1)

	elseif sender == self.btnTabTotal7 then
		self.btnTabTotal7:setEnabled(false)
    	self.lblHead7:setVisible(true)
    	self.lblTips:setVisible(true)
		self:sendRefreshHistory(2)

	elseif sender == self.btnTabYesterdayWin then
		self.btnTabYesterdayWin:setEnabled(false)
    	self.lblHeadYesterday:setVisible(true)
    	self.lblTips:setVisible(true)
		self:sendRefreshYesterday(1)
		limit = 200

	elseif sender == self.btnTabYesterdayLose then
		self.btnTabYesterdayLose:setEnabled(false)
    	self.lblHeadYesterday:setVisible(true)
    	self.lblTips:setVisible(true)
		self:sendRefreshYesterday(2)
		limit = 200

	end

	self.lblTips:setString(string.format("* 排行榜只显示当前俱乐部前%d名",limit))
	
end


function GuildRank:searchUser(user_id)

	local find = false
	local index_ = 0
	for i, v in ipairs(self.ranksData) do
		if v.id == user_id then
			index_ = i
			find = true
		end
	end

	if find and self.ranksData[index_] then

		self.listRank_helper:SetItemsData({})
	    local delay_call = function ()
	    	self.listRank_helper:SetItemsData({self.ranksData[index_]}, true)
	    	self:refreshSearchState(true)
	    end
	    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
	end


	if not find then
		require("app/views/NoticeTips"):create("提示", "查无此玩家", nil, nil, true)
	end
end

function GuildRank:refreshSearchState(isSearch)
	self.btnShowAll:setVisible(isSearch)
	self.btnSearch:setVisible(not isSearch)
end

--[[
1.历史大赢家、总局数排行榜
http://api.mgklqp.9you.net:8080/api/guildrecord/guild_total_rank
{"guild_id":115469,"user_id":732964,"time":1534843257,"limit":100,"game_type":"klnn","sign":"3e548efc8d2c718d851867d34f01fb33"}

]]
function GuildRank:sendRefreshHistory(type_) -- 1.大赢家  2.总局数

	local url = "http://api.mgklqp.9you.net:8080/api/guildrecord/guild_total_rank"

	local param = {}
	for i = 1,4 do 
		param[i] = {}
	end
	param[1].guild_id = self.guild_id
	param[2].user_id = gt.playerData.uid
	param[3].time = os.time()
	param[4].limit = 5000

	local sendParam = gt.commonTool:encodeSign(param)

	gt.commonTool:sendHttpUnion(url,sendParam, function( rankData )
		gt.removeLoadingTips()
		self.ranksData = rankData.list_datas
		self.lblListNoStr:setVisible(#self.ranksData <= 0)

		if type_ == 1 then
			table.sort(self.ranksData, function( a, b)
					if a.rich_rounds == b.rich_rounds then
						return a.total_rounds > b.total_rounds
					else
						return a.rich_rounds > b.rich_rounds
					end
				end)
			for i = 1,#self.ranksData do
				self.ranksData[i].rank = i
			end

			table.sort(self.ranksData, function( a, b)
				if a.user_id == gt.playerData.uid then
					return true
				elseif b.user_id == gt.playerData.uid then
					return false
				elseif a.rich_rounds == b.rich_rounds then
					return a.rank < b.rank
				else
					return a.rich_rounds > b.rich_rounds
				end
			end)
		elseif type_ == 2 then
			for i = 1,#self.ranksData do
				self.ranksData[i].rank = i
			end

			table.sort(self.ranksData, function( a, b)
				if a.user_id == gt.playerData.uid then
					return true
				elseif b.user_id == gt.playerData.uid then
					return false
				elseif a.total_rounds == b.total_rounds then
					return a.rank < b.rank
				else
					return a.total_rounds > b.total_rounds
				end
			end)
		end

		-- self.listRank_helper:SetItemsData({})
	    local delay_call = function ()
	    	self.listRank_helper:SetItemsData(self.ranksData, true)
	    	-- self:updateTotalScore()
	    end
	    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
			
		
	end)
end

--[[
2.昨日赢分、昨日总局数排行
http://api.mgklqp.9you.net:8080/api/guildrecord/guild_yesterday_record
{"guild_id":115469,"type":1,"time":1534843257,"limit":100,"game_type":"klnn","sign":"b2d91d9c4d9b09adcac9c7155efad0fd"}

]]
function GuildRank:sendRefreshYesterday(winType) -- 1 win  2 lose

	local url = "http://api.mgklqp.9you.net:8080/api/guildrecord/guild_yesterday_record"

	local param = {}
	for i = 1,4 do 
		param[i] = {}
	end
	param[1].guild_id = self.guild_id
	param[2].type = winType
	param[3].time = os.time()
	param[4].limit = 200

	local sendParam = gt.commonTool:encodeSign(param)

	gt.commonTool:sendHttpUnion(url,sendParam, function(rankData)
		-- body
		gt.removeLoadingTips()
		self.ranksData = rankData.list_datas
		self.lblListNoStr:setVisible(#self.ranksData <= 0)
		
		if winType == 1 then
			table.sort(self.ranksData, function( a, b)
					if a.total_score == b.total_score then
						return a.total_rounds >= b.total_rounds 
					else
						return a.total_score > b.total_score
					end
				end)
		else
			table.sort(self.ranksData, function( a, b)
					if a.total_score == b.total_score then
						return a.total_rounds >= b.total_rounds 
					else
						return a.total_score < b.total_score
					end
				end)
		end

		-- self.listRank_helper:SetItemsData({})
	    local delay_call = function ()
	    	self.listRank_helper:SetItemsData(self.ranksData, true)
	    	-- self:updateTotalScore()
	    end
	    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
	end)
end

function GuildRank:refreshRankScore()

	self.lblListNoStr:setVisible(#self.ranksData <= 0)

	for i = 1,#self.ranksData do
		self.ranksData[i].rank = i
	end

	table.sort(self.ranksData, function( a, b)
		return a.score > b.score
		end)
	for i = 1,#self.ranksData do
		self.ranksData[i].rank = i
	end
	table.sort(self.ranksData, function( a, b)
		if a.id == gt.playerData.uid then
			return true
		elseif b.id == gt.playerData.uid then
			return false
		elseif a.score == b.score then
			return a.rank < b.rank
		else
			return a.score > b.score
		end
	end)
 	-- self.listRank_helper:SetItemsData({})
    local delay_call = function ()
    	self.listRank_helper:SetItemsData(self.ranksData, true)
    	-- self:updateTotalScore()
    end
    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
end

function GuildRank:initUI()
	local btnClose = gt.seekNodeByName(self.csbNode, "btnClose")
	gt.addBtnPressedListener(btnClose, function()
		self:close()
	end)

	self.lblTips = gt.seekNodeByName(self.csbNode, "lblTips")

	self.lblTitle = gt.seekNodeByName(self.csbNode, "lblTitle")
	if self.is_union then
		self.lblTitle:setString("大联盟排行榜")
	else
		self.lblTitle:setString("俱乐部排行榜")
	end

	self.btnSearch = gt.seekNodeByName(self.csbNode, "btnSearch")
	gt.addBtnPressedListener(self.btnSearch, function()
		local view = require("app/views/Guild/GuildNumberPad"):create("search_user", 0, 0, handler(self, self.searchUser))
		self:addChild(view)
	end)
	self.btnShowAll = gt.seekNodeByName(self.csbNode, "btnShowAll")
	gt.addBtnPressedListener(self.btnShowAll, function()
		self:refreshSearchState(false)
		self:changeTab(self.curSender)
	end)
end


function GuildRank:onNodeEvent(eventName)
	if "enter" == eventName then
		
	elseif "exit" == eventName then
		
		if self.listRank_helper then
            self.listRank_helper:Release()
            self.listRank_helper = nil
        end
	end
end

function GuildRank:initListRank()

	self.lstRanks = gt.seekNodeByName(self.csbNode,"List_Rank") 
	
	self.pRankTemplate = self.lstRanks:getChildByName("panelItem")
	self.pRankTemplate:retain()
	self.lstRanks:removeAllChildren()

	self.lblListNoStr = gt.seekNodeByName(self.csbNode,"lblListNoStr") 
	self.lblListNoStr:setVisible(false)

	--记录列表的辅助工具    
    if cc.exports.ListViewHelper == nil then
        require "app/ListViewHelper"
    end
    --创建列表item的函数
    if self.listRank_helper == nil then
        local create_item_func = function (v, i, cached_item)
        	local item = self:CreateRankItem(v, i, cached_item or self.pRankTemplate:clone())
        	return item
        end
        self.listRank_helper = ListViewHelper:create(self.lstRanks, self.pRankTemplate, create_item_func, true)
    end

	local function onPersonInfo(sender)
		local user_id = sender:getTag()
		local view = require("app/views/Guild/GuildPersonInfo"):create(self.guild_id,user_id,self.is_union)
		self:addChild(view)
	end
	self.onPersonInfo = onPersonInfo
end

function GuildRank:sendRankScore() 
	local msgToSend = {}
	msgToSend.cmd = gt.MATCH_RANK
	msgToSend.open_id = gt.playerData.openid
	msgToSend.guild_id = self.guild_id
	msgToSend.user_id = gt.playerData.uid
	msgToSend.score_type = scoreType
	gt.socketClient:sendMessage(msgToSend)

	gt.showLoadingTips("")
end

function GuildRank:CreateRankItem(v, i, pItem)
	local detailId = gt.playerData.uid
	local rank = i

	if self.curSender == self.btnTabScore then
		pItem:getChildByName("lblRecordId"):setString(tostring(v.rank))
		pItem:getChildByName("lblRecordV1"):setString(tostring(gt.commonTool:hideText(v.id, self.isShowId)))
		pItem:getChildByName("lblRecordV2"):setVisible(false)

		pItem:getChildByName("imgMe"):setVisible(v.id == gt.playerData.uid )
		pItem:getChildByName("lblRecordV3"):setString(tostring(v.score))
		detailId = v.id
		rank = v.rank

	elseif self.curSender == self.btnTabWin7 or self.curSender == self.btnTabTotal7 then
		pItem:getChildByName("lblRecordId"):setString(tostring(v.rank))
		pItem:getChildByName("lblRecordV1"):setString(tostring(gt.commonTool:hideText(v.user_id, self.isShowId)))

		pItem:getChildByName("lblRecordV2"):setVisible(true)
		pItem:getChildByName("lblRecordV2"):setString(tostring(v.total_rounds))

		pItem:getChildByName("imgMe"):setVisible(v.user_id == gt.playerData.uid )
		pItem:getChildByName("lblRecordV3"):setString(tostring(v.rich_rounds))
		detailId = v.user_id
		rank = v.rank

	elseif self.curSender == self.btnTabYesterdayWin or self.curSender == self.btnTabYesterdayLose then
		pItem:getChildByName("lblRecordId"):setString(i)

		pItem:getChildByName("lblRecordV1"):setString(tostring(gt.commonTool:hideText(v.user_id, self.isShowId)))

		pItem:getChildByName("lblRecordV2"):setVisible(true)
		pItem:getChildByName("lblRecordV2"):setString(tostring(v.total_rounds))

		pItem:getChildByName("imgMe"):setVisible(v.user_id == gt.playerData.uid )
		pItem:getChildByName("lblRecordV3"):setString(tostring(v.total_score))
		detailId = v.user_id
	end
	if rank <= 3 then
		pItem:getChildByName("imgRank"):setVisible(true )
		pItem:getChildByName("imgRank"):loadTexture("image/guild/rank".. rank .."_bg.png", ccui.TextureResType.plistType)

	else
		pItem:getChildByName("imgRank"):setVisible(false)
	end

	local btnDetail = pItem:getChildByName("btnDetail") 
	btnDetail:setVisible(false)

	if btnDetail and self.isShowId then
		btnDetail:setVisible(true)
		btnDetail:setTag(detailId)

		-- btnDetail:removeAllHandlers()
		btnDetail:addClickEventListener(self.onPersonInfo)
	end
	return pItem
end
 
function GuildRank:onRcvMatchRank(msgTbl)
	gt.removeLoadingTips()
	
	local page = msgTbl.page + 1
	if page == 1 then
		self.ranksData = msgTbl.ranks
	else
		if self.ranksData then
			for i, v in ipairs(msgTbl.ranks) do
				table.insert(self.ranksData, v)
			end
		end
	end
	if page * msgTbl.pre_page >= msgTbl.total then

		self:refreshRankScore()
	end
end


function GuildRank:close()

	gt.socketClient:unregisterMsgListener(gt.MATCH_RANK)

	gt.dispatchEvent(gt.EventType.GUILD_REQUEST_MATCHRANK)
	
	self.lstRanks:removeAllChildren()
	self.pRankTemplate:release()

	if self.listRank_helper then
        self.listRank_helper:Release()
        self.listRank_helper = nil
    end

	self:removeFromParent()
end

return GuildRank