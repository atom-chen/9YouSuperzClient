-- 个人信息

local gt = cc.exports.gt

local GuildPersonInfo = class("GuildPersonInfo", function()
	return gt.createMaskLayer()
end)

function GuildPersonInfo:ctor(guild_id, user_id,is_union)
	self:registerScriptHandler(handler(self, self.onNodeEvent))

	local csbNode = cc.CSLoader:createNode("csd/Guild/GuildPersonInfo.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	self.currentGuild = nil
	gt.log("-----openUI:GuildPersonInfo")
	self.guild_id = guild_id
	self.user_id = user_id
	self.is_union = is_union or false

	if self.is_union then
		self.currentGuild = gt.UnionManager:getGuild(guild_id)
		self.isShowId = gt.UnionManager:isGuildAdmin(guild_id) or gt.UnionManager:isGuildOwner(guild_id)
	else
		self.currentGuild = gt.guildManager:getGuild(guild_id)
		self.isShowId = gt.guildManager:isGuildAdmin(guild_id) or gt.guildManager:isGuildOwner(guild_id)
	end

	self:initUI()
	self:initListInfo()
	self:initTab()

	self:changeTab(self.btnTabGame)
end 

function GuildPersonInfo:initTab()
	self.btnTabGame = gt.seekNodeByName(self.csbNode, "btnTabGame")
	self.btnTabScore = gt.seekNodeByName(self.csbNode, "btnTabScore")
	self.btnTabEmoj = gt.seekNodeByName(self.csbNode, "btnTabEmoj")

	local function onTab(sender, eventType)
		if eventType == TOUCH_EVENT_ENDED then
			self:changeTab(sender)
		end
	end
    self.btnTabGame:addTouchEventListener(onTab)
	self.btnTabScore:addTouchEventListener(onTab)
    self.btnTabEmoj:addTouchEventListener(onTab)

	self.lblHeadGame = gt.seekNodeByName(self.csbNode, "lblHeadGame")
	self.lblHeadScore = gt.seekNodeByName(self.csbNode, "lblHeadScore")
	self.lblHeadEmoj = gt.seekNodeByName(self.csbNode, "lblHeadEmoj")

	self.btnTabEmoj:setVisible(self:isShowEmojYesterday())
	self.btnTabScore:setVisible( self.is_union)

	if self.is_union then
		self.btnTabEmoj:setPositionX(430)
	end

	if self:isShowEmojYesterday()  then
		self:sendRefreshScoreCreate()
		self:sendRefreshEmojYesterday()
	end
end


function GuildPersonInfo:changeTab(sender)
	self.curSender= sender
    self.btnTabGame:setEnabled(true)
	self.btnTabScore:setEnabled(true)
    self.btnTabEmoj:setEnabled(true)

    --head
    self.lblHeadGame:setVisible(false)
    self.lblHeadScore:setVisible(false)
    self.lblHeadEmoj:setVisible(false)

    --emoj
    -- self.lblEmojYesterdayStr:setVisible(false)
    -- self.lblEmojYesterday:setVisible(false)

    -- create score
    -- self.pCreateScore:setVisible(false)

    self.listInfo_helper:SetItemsData({})
	if sender == self.btnTabGame then
		self.btnTabGame:setEnabled(false)
    	self.lblHeadGame:setVisible(true)
		self:sendRefreshGame()

	elseif sender == self.btnTabScore then
		self.btnTabScore:setEnabled(false)
    	self.lblHeadScore:setVisible(true)
		self:sendRefreshScore()
		-- if self:isShowEmojYesterday()  then
		-- 	self:sendRefreshScoreCreate()
		-- end

	elseif sender == self.btnTabEmoj then
		self.btnTabEmoj:setEnabled(false)
    	self.lblHeadEmoj:setVisible(true)
		self:sendRefreshEmoj()
		-- if self:isShowEmojYesterday()  then
		-- 	self:sendRefreshEmojYesterday()
		-- end

	end

	
end

function GuildPersonInfo:isShowEmojYesterday()
	if self.is_union then
		return gt.UnionManager:isGuildAdmin(self.guild_id) or gt.UnionManager:isGuildOwner(self.guild_id)
	else
		return gt.guildManager:isGuildAdmin(self.guild_id) or gt.guildManager:isGuildOwner(self.guild_id)
	end
end

--[[
4.个人输赢分流水
http://api.mgklqp.9you.net:8080/api/guildrecord/guild_playerscore_winlose_record
{"guild_id":115469,"user_id":732964,"time":1534843257,"limit":100,"game_type":"klnn","sign":"3e548efc8d2c718d851867d34f01fb33"}

]]
function GuildPersonInfo:sendRefreshGame()

	local url = "http://api.mgklqp.9you.net:8080/api/guildrecord/guild_playerscore_winlose_record"

	local param = {}
	for i = 1,4 do 
		param[i] = {}
	end
	param[1].guild_id = self.guild_id
	param[2].user_id = self.user_id
	param[3].time = os.time()
	param[4].limit = 500

	local sendParam = gt.commonTool:encodeSign(param)

	gt.commonTool:sendHttpUnion(url,sendParam, function( infoData )
		gt.removeLoadingTips()
		self.infoGameData = infoData.list_datas
		self.lblListNoStr:setVisible(#self.infoGameData <= 0)
		
		-- self.listInfo_helper:SetItemsData({})
	    local delay_call = function ()
	    	self.listInfo_helper:SetItemsData(self.infoGameData, true)
	    	-- self:updateTotalScore()
	    end
	    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
			
		
	end)
end

--[[
3.个人上下分流水数据
http://api.mgklqp.9you.net:8080/api/guildrecord/guild_playerscore_change_record
{"guild_id":115469,"time":1534843257,"user_id":732964,"limit":100,"game_type":"klnn","sign":"a1114b1084c5916faa27eb871dcc6716"}

]]
function GuildPersonInfo:sendRefreshScore()

	local url = "http://api.mgklqp.9you.net:8080/api/guildrecord/guild_playerscore_change_record"

	local param = {}
	for i = 1,4 do 
		param[i] = {}
	end
	param[1].guild_id = self.guild_id
	param[2].time = os.time()
	param[3].user_id = self.user_id
	param[4].limit = 500

	local sendParam = gt.commonTool:encodeSign(param)

	gt.commonTool:sendHttpUnion(url,sendParam, function(infoData)
		-- body
		gt.removeLoadingTips()
		self.infoScoreData = infoData.list_datas
		self.lblListNoStr:setVisible(#self.infoScoreData <= 0)
		
		-- self.listInfo_helper:SetItemsData({})
	    local delay_call = function ()
	    	self.listInfo_helper:SetItemsData(self.infoScoreData, true)
	    	-- self:updateTotalScore()
	    end
	    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
	end)
end

--[[
5.个人抽水流水
http://api.mgklqp.9you.net:8080/api/guildrecord/guild_player_emoition
{"guild_id":115469,"time":1534843257,"limit":100,"game_type":"klnn","sign":"7cbbd8e15a5fe7ff6c587627da0fedab"}  --sign不通过
{"user_id":732964,"guild_id":115469,"time":1534843257,"limit":100,"game_type":"klnn","sign":"96c9e1fa7910c62effeb68a5d09bf4fd"}

]]
function GuildPersonInfo:sendRefreshEmoj()

	local url = "http://api.mgklqp.9you.net:8080/api/guildrecord/guild_player_emoition"


	local param = {}
	for i = 1,4 do 
		param[i] = {}
	end
	param[1].user_id = self.user_id
	param[2].guild_id = self.guild_id
	param[3].time = os.time()
	param[4].limit = 500

	local sendParam = gt.commonTool:encodeSign(param)

	gt.commonTool:sendHttpUnion(url,sendParam, function(infoData)
		-- body
		gt.removeLoadingTips()
		self.infoEmojData = infoData.list_datas
		self.lblListNoStr:setVisible(#self.infoEmojData <= 0)
		
		-- self.listInfo_helper:SetItemsData({})
	    local delay_call = function ()
	    	self.listInfo_helper:SetItemsData(self.infoEmojData, true)
	    	-- self:updateTotalScore()
	    end
	    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
	end)
end
--[[
6.昨日表情消耗
http://api.mgklqp.9you.net:8080/api/guildrecord/guild_yesterday_emotion
{"guild_id":115469,"time":1534843257,"game_type":"klnn","sign":"40af37d99184a0c4174265e551519c57"}

]]
function GuildPersonInfo:sendRefreshEmojYesterday()

	local url = "http://api.mgklqp.9you.net:8080/api/guildrecord/guild_yesterday_emotion"

	local param = {}
	for i = 1,2 do 
		param[i] = {}
	end
	param[1].guild_id = self.guild_id
	param[2].time = os.time()
	local sendParam = gt.commonTool:encodeSign(param)
	
	gt.commonTool:sendHttpUnion(url,sendParam, function(infoData)
		-- body
		gt.removeLoadingTips()
		
		self.lblEmojYesterdayStr:setVisible(true)
		self.lblEmojYesterday:setVisible(true)
		self.lblEmojYesterday:setString(infoData.list_datas.lastday_emoition)
	end)
end

--[[
7.俱乐部创造积分
http://api.mgklqp.9you.net:8080/api/guildrecord/guild_create_score_record

]]
function GuildPersonInfo:sendRefreshScoreCreate()

	local url = "http://api.mgklqp.9you.net:8080/api/guildrecord/guild_create_score_record"

	local param = {}
	for i = 1,2 do 
		param[i] = {}
	end
	param[1].guild_id = self.guild_id
	param[2].time = os.time()
	local sendParam = gt.commonTool:encodeSign(param)
	
	gt.commonTool:sendHttpUnion(url,sendParam, function(infoData)
		-- body
		gt.removeLoadingTips()
		
		self.pCreateScore:setVisible(true)
		self.lblScorePool:setString(infoData.list_datas.cur_score_pool)
		self.lblScoreCreate:setString(infoData.list_datas.total_create_score)
	end)
end

function GuildPersonInfo:refreshRankScore()

	self.lblListNoStr:setVisible(#self.ranksData <= 0)

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
		end
		return a.score > b.score
	end)
 	self.listInfo_helper:SetItemsData({})
    local delay_call = function ()
    	self.listInfo_helper:SetItemsData(self.ranksData, true)
    	-- self:updateTotalScore()
    end
    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
end

function GuildPersonInfo:initUI()
	local btnClose = gt.seekNodeByName(self.csbNode, "btnClose")
	gt.addBtnPressedListener(btnClose, function()
		self:close()
	end)

	self.lblEmojYesterdayStr = gt.seekNodeByName(self.csbNode, "lblEmojYesterdayStr")
	self.lblEmojYesterdayStr:setVisible(false)
	self.lblEmojYesterday = gt.seekNodeByName(self.csbNode, "lblEmojYesterday")
	self.lblEmojYesterday:setVisible(false)

	self.pCreateScore = gt.seekNodeByName(self.csbNode, "pCreateScore")
	self.lblScorePool = gt.seekNodeByName(self.csbNode, "lblScorePool")
	self.lblScoreCreate = gt.seekNodeByName(self.csbNode, "lblScoreCreate")
	self.pCreateScore:setVisible(false)

	self.lblUserId = gt.seekNodeByName(self.csbNode, "lblUserId")
	self.lblUserId:setString(self.user_id)

	self.lblTips = gt.seekNodeByName(self.csbNode, "lblTips")
    local limit = 500
	self.lblTips:setString(string.format("* 只显示最近%d条变动信息",limit))
end


function GuildPersonInfo:onNodeEvent(eventName)
	if "enter" == eventName then
		
	elseif "exit" == eventName then
		
		if self.listInfo_helper then
            self.listInfo_helper:Release()
            self.listInfo_helper = nil
        end
	end
end

function GuildPersonInfo:initListInfo()

	self.lstInfos = gt.seekNodeByName(self.csbNode,"List_Info") 
	
	self.pInfoTemplate = self.lstInfos:getChildByName("panelItem")
	self.pInfoTemplate:retain()
	self.lstInfos:removeAllChildren()

	self.lblListNoStr = gt.seekNodeByName(self.csbNode,"lblListNoStr") 
	self.lblListNoStr:setVisible(false)

	--记录列表的辅助工具    
    if cc.exports.ListViewHelper == nil then
        require "app/ListViewHelper"
    end
    --创建列表item的函数
    if self.listInfo_helper == nil then
        local create_item_func = function (v, i, cached_item)
        	local item = self:CreateInfoItem(v, i, cached_item or self.pInfoTemplate:clone())
        	return item
        end
        self.listInfo_helper = ListViewHelper:create(self.lstInfos, self.pInfoTemplate, create_item_func, true)
    end
end

function GuildPersonInfo:CreateInfoItem(v, i, pItem)

	if self.curSender == self.btnTabGame then
		pItem:getChildByName("lblRecordV1"):setString(tostring(v.room_id))
		pItem:getChildByName("lblRecordV2"):setVisible(false)
		pItem:getChildByName("lblRecordV3"):setString(tostring(v.score))
		pItem:getChildByName("lblRecordV4"):setString(tostring(v.create_date))


	elseif self.curSender == self.btnTabScore  then
		if self.user_id == v.user_id then 
			if v.score > 0 then --赠送积分
				pItem:getChildByName("lblRecordV1"):setString("赠送积分")
				pItem:getChildByName("lblRecordV2"):setString(v.target_id) 
				pItem:getChildByName("lblRecordV3"):setString("-"..tostring(v.score)) 
			else -- 下分获得
				pItem:getChildByName("lblRecordV1"):setString("下分获得积分")
				pItem:getChildByName("lblRecordV2"):setString(v.target_id) 
				pItem:getChildByName("lblRecordV3"):setString("+"..tostring(math.abs(v.score))) 
			end

		elseif self.user_id == v.target_id then 
			if v.score > 0 then --收到赠送积分
				pItem:getChildByName("lblRecordV1"):setString("获得积分")
				pItem:getChildByName("lblRecordV2"):setString(v.user_id) 
				pItem:getChildByName("lblRecordV3"):setString("+"..tostring(v.score)) 
			else -- 下分减少
				pItem:getChildByName("lblRecordV1"):setString("被下分减少积分")
				pItem:getChildByName("lblRecordV2"):setString(v.user_id) 
				pItem:getChildByName("lblRecordV3"):setString(tostring(v.score))
			end
		end
		pItem:getChildByName("lblRecordV2"):setVisible(true)
		pItem:getChildByName("lblRecordV4"):setString(tostring(v.create_date))

	elseif self.curSender == self.btnTabEmoj then
		pItem:getChildByName("lblRecordV1"):setString(tostring(v.room_id))
		pItem:getChildByName("lblRecordV2"):setVisible(false)
		pItem:getChildByName("lblRecordV3"):setString(tostring(v.emoition))
		pItem:getChildByName("lblRecordV4"):setString(tostring(v.create_date))
	end

	-- pItem:getChildByName("btnDetail"):setVisible(false)

	return pItem
end



function GuildPersonInfo:close()
	self.lstInfos:removeAllChildren()
	self.pInfoTemplate:release()

	if self.listInfo_helper then
        self.listInfo_helper:Release()
        self.listInfo_helper = nil
    end

	self:removeFromParent()
end

return GuildPersonInfo