-- 俱乐部合伙人

local gt = cc.exports.gt

local GuildPartner = class("GuildPartner", function()
	return gt.createMaskLayer()
end)

function GuildPartner:ctor(guild_id, is_union)
	local csbNode = cc.CSLoader:createNode("csd/Guild/GuildPartner.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	self.currentGuild = nil
	gt.log("-----openUI:GuildPartner")
	self.guild_id = guild_id
	self.is_union = is_union or false
	if self.is_union then
		self.currentGuild = gt.UnionManager:getGuild(guild_id)
	else
		self.currentGuild = gt.guildManager:getGuild(guild_id)
	end

	self:initUI()
	self:initListPartner()
	self:initListScore()
	self:initTab()

	self:changeTab(self.btnTabPartner)

	gt.socketClient:registerMsgListener(gt.GUILD_GET_PARTNERS, self, self.onRcvGuildPartners)
	gt.socketClient:registerMsgListener(gt.GUILD_SET_PARTNER, self, self.onRcvAddPartner)
	gt.socketClient:registerMsgListener(gt.PARTNER_MATCH_SCORE, self, self.onRcvPartnerMatchScore)
	gt.socketClient:registerMsgListener(gt.GUILD_SCORE_GIVE, self, self.onRcvPartnerScoreGive)

	gt.registerEventListener(gt.EventType.GUILD_SCORE_GIVE, self, self.regisMsgScoreGive)
end

function GuildPartner:regisMsgScoreGive()
	gt.socketClient:registerMsgListener(gt.GUILD_SCORE_GIVE, self, self.onRcvPartnerScoreGive)
end

function GuildPartner:initUI()
	local btnClose = gt.seekNodeByName(self.csbNode, "btnClose")
	gt.addBtnPressedListener(btnClose, function()
		self:close()
	end)

	local btnBack = gt.seekNodeByName(self.csbNode, "btnBack")
	gt.addBtnPressedListener(btnBack, function()
		self:close()
	end)

	self.pPanelPartner = gt.seekNodeByName(self.csbNode, "pPanelPartner")
	self.pPanelScore = gt.seekNodeByName(self.csbNode, "pPanelScore")


	local btnAddPartner = gt.seekNodeByName(self.csbNode, "btnAddPartner")
	gt.addBtnPressedListener(btnAddPartner, function()
		local view = require("app/views/Guild/GuildNumberPad"):create("add_partner", 0, 0, handler(self, self.addPartner))
		self:addChild(view)
	end)

	self.btnSearch = gt.seekNodeByName(self.csbNode, "btnSearch")
	gt.addBtnPressedListener(self.btnSearch, function()
		local view = require("app/views/Guild/GuildNumberPad"):create("search_user", 0, 0, handler(self, self.searchUser))
		self:addChild(view)
	end)

	self.btnShowAll = gt.seekNodeByName(self.csbNode, "btnShowAll")
	gt.addBtnPressedListener(self.btnShowAll, function()
		self:refreshSearchState(false)
		self:sendRefreshPartner()
	end)
	self.btnShowAll:setVisible(false)
	
	self.lblListNoStr = gt.seekNodeByName(self.csbNode, "lblListNoStr")
	self.lblListNoStr:setVisible(false)
	self.lblRoundYesterdayStr = gt.seekNodeByName(self.csbNode, "lblRoundYesterdayStr")
	self.lblRoundYesterdayStr:setVisible(false)
	self.lblRoundYesterDay = gt.seekNodeByName(self.csbNode, "lblRoundYesterDay")
	self.lblRoundYesterDay:setVisible(false)
end


function GuildPartner:initTab()
	self.btnTabPartner = gt.seekNodeByName(self.csbNode, "btnTabPartner")
	self.btnTabScore = gt.seekNodeByName(self.csbNode, "btnTabScore")
	
	local function onTab(sender, eventType)
		if eventType == TOUCH_EVENT_ENDED then
			self:changeTab(sender)
		end
	end
    self.btnTabPartner:addTouchEventListener(onTab)
	self.btnTabScore:addTouchEventListener(onTab)

	self.btnTabPartner:setVisible(false)
	self.btnTabScore:setVisible(false)
	if self.is_union then
		self.btnTabPartner:setVisible(true)
		self.btnTabScore:setVisible(true)
	end
end


function GuildPartner:changeTab(sender)
	self.curSender= sender
    self.btnTabPartner:setEnabled(true)
	self.btnTabScore:setEnabled(true)

	self.pPanelPartner:setVisible(false)
	self.pPanelScore:setVisible(false)

	if sender == self.btnTabPartner then
		self.btnTabPartner:setEnabled(false)
		self.pPanelPartner:setVisible(true)
		
		self:sendRefreshPartner()

	elseif sender == self.btnTabScore then
		self.btnTabScore:setEnabled(false)
		self.pPanelScore:setVisible(true)

		self:refreshScore()
	end
end

function GuildPartner:getMyScore()
	local myScore = 0 
	if self.is_union then
		myScore = gt.UnionManager:getMyScore(self.guild_id)
	else
		myScore = gt.guildManager:getMyScore(self.guild_id)
	end
	return myScore 
end

function GuildPartner:refreshScore()

	self.listScore_helper:SetItemsData({})
    local delay_call = function ()
    	self.listScore_helper:SetItemsData(self.lstData, true)
    	-- self:updateTotalScore()
    end
    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))

end


function GuildPartner:initListScore()
	local lstScore = gt.seekNodeByName(self.csbNode,"lstScore") 

	self.panelScoreItem = lstScore:getChildByName("panelItem")
	self.panelScoreItem:retain()

	lstScore:removeAllChildren()
	self.lstScore = lstScore

	local function onAddScore(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		if self.is_union then
			local view = require("app/views/Guild/GuildNumberPad"):create("partner_give_to", self.guild_id, sender:getTag(), nil, self:getMyScore())
			self:addChild(view)
		else
			local view = require("app/views/Guild/GuildNumberPad"):create("partner_add_score", self.guild_id, sender:getTag())
			self:addChild(view)
		end
	end	
	self.onAddScore = onAddScore

	local function onMinusScore(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)

		local curScore = 0
		local curId = sender:getTag()
		for i, v in ipairs(self.lstData) do
			if v.id == curId then
				curScore = v.score
			end
		end
		if curScore > 0 then

			if self.is_union then
				local view = require("app/views/Guild/GuildNumberPad"):create("partner_give_from", self.guild_id, sender:getTag(), nil, curScore)
				self:addChild(view)
			else
				local view = require("app/views/Guild/GuildNumberPad"):create("partner_minus_score", self.guild_id, curId ,nil,curScore )
				self:addChild(view)
			end
		else
			require("app/views/NoticeTips"):create("提示", "当前玩家已没有积分", nil, nil, true)
		end
	end
	self.onMinusScore = onMinusScore


	 --记录列表的辅助工具    
    if cc.exports.ListViewHelper == nil then
        require "app/ListViewHelper"
    end
    --创建列表item的函数
    if self.listScore_helper == nil then
        local create_item_func = function (v, i, cached_item)
            local item = self:CreateScoreItem(v, i, cached_item or self.panelScoreItem:clone())
            return item
        end
        self.listScore_helper = ListViewHelper:create(self.lstScore, self.panelScoreItem, create_item_func, true)
    end


end

function GuildPartner:initListPartner()
	local lstPartner = gt.seekNodeByName(self.csbNode,"List_Partners") 

	self.panelItem = lstPartner:getChildByName("panelItem")
	self.panelItem:retain()

	lstPartner:removeAllChildren()
	self.lstPartner = lstPartner

	local function onPartnerDelete(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)

		local member_id = sender:getTag()
		local function confirm()
			gt.soundEngine:playEffect(gt.clickBtnAudio, false)

			local msgToSend = {}
			msgToSend.cmd = gt.GUILD_SET_PARTNER
			msgToSend.open_id = gt.playerData.openid
			msgToSend.target_id = member_id
			msgToSend.guild_id = self.currentGuild.id
			msgToSend.option = 0

			gt.socketClient:sendMessage(msgToSend)
			gt.showLoadingTips("")
		end
		local tips = string.format("您确定要删除合伙人ID:%d吗?", member_id)
		require("app/views/NoticeTips"):create("提示", tips, confirm, nil, false)

    end
    self.onPartnerDelete = onPartnerDelete

    local function onPartnerDetail(sender)
    	gt.soundEngine:playEffect(gt.clickBtnAudio, false)

		local userId = sender:getTag()

		local GuildPartnerDetailView = require("app/views/Guild/GuildPartnerDetail"):create(self.currentGuild.id , userId, self.is_union )
		GuildPartnerDetailView:setName("GuildPartnerDetail")
		self:addChild(GuildPartnerDetailView)

    end
    self.onPartnerDetail = onPartnerDetail


    --记录列表的辅助工具    
    if cc.exports.ListViewHelper == nil then
        require "app/ListViewHelper"
    end
    --创建列表item的函数
    if self.listPartner_helper == nil then
        local create_item_func = function (v, i, cached_item)
            local item = self:CreatePartnerItem(v, i, cached_item or self.panelItem:clone())
            return item
        end
        self.listPartner_helper = ListViewHelper:create(self.lstPartner, self.panelItem, create_item_func, true)
    end

end

function GuildPartner:onRcvPartnerMatchScore(msgTbl)
	if msgTbl.code == 0 then
		gt.removeLoadingTips()

		local index_ = 0
		for i, v in ipairs(self.lstData) do
			if v.id == msgTbl.target_id then
				v.score = msgTbl.score
				index_ = i
			end
		end
		if self.isSearchState then
			index_ = 1
		end
		local item = self.listScore_helper:GetItem(index_)
		if item then
			item:getChildByName("lblScore"):setString(tostring(msgTbl.score))
			require("app/views/CommonTips"):create("操作成功", 2)
		end

	elseif msgTbl.code == 1 then
		gt.removeLoadingTips()
		require("app/views/NoticeTips"):create("提示", "玩家已离开俱乐部", nil, nil, true)
	elseif msgTbl.code == 2 then
		gt.removeLoadingTips()
		require("app/views/NoticeTips"):create("提示", "玩家正在游戏中，无法进行下分操作", nil, nil, true)
	elseif msgTbl.code == 3 then
		gt.removeLoadingTips()
		require("app/views/NoticeTips"):create("提示", "操作错误，数字过大", nil, nil, true)
	elseif msgTbl.code == 4 then
		gt.removeLoadingTips()
		require("app/views/NoticeTips"):create("提示", "操作错误，无法负分", function()
				self:sendRefreshPartner()
			end, nil, true)
		
	end
end

function GuildPartner:onRcvPartnerScoreGive(msgTbl)
	gt.removeLoadingTips()
	
	if msgTbl.code == 0 then
		
		if self.is_union then
			gt.UnionManager:setMyScore(self.guild_id, msgTbl.memScore)
		else
			gt.guildManager:setMyScore(self.guild_id, msgTbl.memScore)
		end

		local index_ = 0
		local myIndex_ = 0
		for i, v in ipairs(self.lstData) do
			if v.id == msgTbl.target_id then
				v.score = msgTbl.targetScore
				index_ = i
			end
			if v.id == gt.playerData.uid then
				v.score = msgTbl.memScore
				myIndex_ = i
			end
		end
		local item = self.listScore_helper:GetItem(index_)
		if item then
			item:getChildByName("lblScore"):setString(tostring(msgTbl.targetScore))
			require("app/views/CommonTips"):create("操作成功", 2)
		end
		local myItem = self.listScore_helper:GetItem(myIndex_)
		if myItem then
			myItem:getChildByName("lblScore"):setString(tostring(msgTbl.memScore))
		end

	elseif msgTbl.code == 1 then -- 分数过大
		require("app/views/CommonTips"):create("操作失败，您输入的分数过大，请重新输入",2)
	elseif msgTbl.code == 2 then --玩家离开俱乐部
		require("app/views/CommonTips"):create("操作失败，当前俱乐部没有该玩家",2)
	elseif msgTbl.code == 3 then -- 没有足够的分数进行转移
		require("app/views/CommonTips"):create("操作失败，您没有足够的分数进行赠送",2)
	elseif msgTbl.code == 4 then -- 游戏内无法 
		require("app/views/CommonTips"):create("操作失败，玩家正在游戏中，无法进行下分操作",2)
	elseif msgTbl.code == 5 then -- target超过限制 
		require("app/views/CommonTips"):create("操作失败，该玩家积分已超过上限",2)
	elseif msgTbl.code == 6 then -- member超过限制 
		require("app/views/CommonTips"):create("操作失败，您的积分已超过上限，请减少自己积分数量后进行操作(先下掉自己部分积分)",2)
	end
	
end

function GuildPartner:sendRefreshPartner()
	local msgToSend = {}
	msgToSend.cmd = gt.GUILD_GET_PARTNERS
	msgToSend.open_id = gt.playerData.openid
	msgToSend.guild_id = self.currentGuild.id
	
	gt.socketClient:sendMessage(msgToSend)
	gt.showLoadingTips("")
end
 
function GuildPartner:onRcvAddPartner(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "操作成功", nil, nil, true)
		self:sendRefreshPartner()
	elseif msgTbl.code == 1 then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "操作失败,您没有权限", nil, nil, true)
	elseif msgTbl.code == 2 then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "操作失败,此玩家不是该俱乐部成员", nil, nil, true)
	elseif msgTbl.code == 3 then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "操作失败,合伙人数量已达上限", nil, nil, true)
	elseif msgTbl.code == 4 then
		-- require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "没有权限", nil, nil, true)
	elseif msgTbl.code == 5 then
		if msgTbl.option == 1 then
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "操作失败,此玩家已经是合伙人了", nil, nil, true)
		else
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "操作失败,此玩家不是合伙人", nil, nil, true)
		end
	elseif msgTbl.code == 6 then
		local partner_id = msgTbl.partner_id or 0
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), string.format("操作失败,此玩家已经是合伙人ID:%d 的成员",partner_id), nil, nil, true)
	end
end

function GuildPartner:onRcvGuildPartners(msgTbl)
	gt.removeLoadingTips()

	self.lstData = msgTbl.partners

	self.lblRoundYesterdayStr:setVisible(true)
	self.lblRoundYesterDay:setVisible(true)
	self.lblRoundYesterDay:setString(msgTbl.total_count)

	if msgTbl.code == 0 then
		-- self:refreshListPartner()
		local count = #self.lstData
		self.lblListNoStr:setVisible(count<=0)

		if self.curSender == self.btnTabPartner then
			self.listPartner_helper:SetItemsData({})
		    local delay_call = function ()
		    	self.listPartner_helper:SetItemsData(self.lstData, true)
		    	-- self:updateTotalScore()
		    end
		    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
		elseif self.curSender == self.btnTabScore then
			self:refreshScore()
		end
	end
end

function GuildPartner:refreshSearchState(isSearch)
	self.btnShowAll:setVisible(isSearch)
	self.btnSearch:setVisible(not isSearch)
end

function GuildPartner:searchUser(user_id)

	local find = false
	local index_ = 0
	for i, v in ipairs(self.lstData) do
		if v.id == user_id then
			index_ = i
			find = true
		end
	end

	if find and self.lstData[index_] then

		self.listPartner_helper:SetItemsData({})
	    local delay_call = function ()
	    	self.listPartner_helper:SetItemsData({self.lstData[index_]}, true)
	    	self:refreshSearchState(true)
	    end
	    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
	end


	if not find then
		require("app/views/NoticeTips"):create("提示", "查无此玩家", nil, nil, true)
	end
end

function GuildPartner:CreateScoreItem(v, i, pItem)
	pItem:getChildByName("lblId"):setString(v.id)
	pItem:getChildByName("lblName"):setString(" ")
	pItem:getChildByName("lblName"):setString(v.nick)
	pItem:getChildByName("lblScore"):setString(v.score)


	local btnAdd = pItem:getChildByName("Btn_Add")
	if btnAdd and self.onAddScore then
		btnAdd:setTag(v.id)
		btnAdd:addClickEventListener(self.onAddScore)
	end

	local btnMinus = pItem:getChildByName("Btn_Minus")
	if btnMinus and self.onMinusScore then
		btnMinus:setTag(v.id)
		btnMinus:addClickEventListener(self.onMinusScore)
	end

	return pItem
end

function GuildPartner:CreatePartnerItem(v, i, pItem)

	pItem:getChildByName("lblId"):setString(v.id)
	pItem:getChildByName("lblName"):setString(" ")
	pItem:getChildByName("lblName"):setString(v.nick)
	pItem:getChildByName("lblYesterdayCount"):setString(v.last_day.count)
	pItem:getChildByName("lblYesterdayCost"):setString(v.last_day.emoition)
	pItem:getChildByName("lblYesterdayRich"):setString(v.last_day.rich)
	pItem:getChildByName("lblTotalCount"):setString(v.total_count)

	local btnDetail = pItem:getChildByName("btnDetail")
	if btnDetail and self.onPartnerDetail then
		btnDetail:setTag(v.id)
		btnDetail:addClickEventListener(self.onPartnerDetail)
	end

	local btnDelete = pItem:getChildByName("btnDelete")
	if btnDelete and self.onPartnerDelete then
		btnDelete:setTag(v.id)
		btnDelete:addClickEventListener(self.onPartnerDelete)
	end

	return pItem
end


function GuildPartner:refreshListPartner()
	self.lstPartner:removeAllChildren()

	local count = #self.lstData
	self.lblListNoStr:setVisible(count<=0)

	for i = 1, count do 
		local item =  self.panelItem:clone()
		local data = self.lstData[i]
		if data then
			item:getChildByName("lblId"):setString(data.id)
			item:getChildByName("lblName"):setString(data.nick)
			item:getChildByName("lblYesterdayCount"):setString(data.last_day.count)
			item:getChildByName("lblYesterdayCost"):setString(data.last_day.emoition)
			item:getChildByName("lblYesterdayRich"):setString(data.last_day.rich)
			item:getChildByName("lblTotalCount"):setString(data.total_count)

			local btnDetail = item:getChildByName("btnDetail")
			btnDetail:setTag(data.id)
			btnDetail:addClickEventListener(self.onPartnerDetail)

			local btnDelete = item:getChildByName("btnDelete")
			btnDelete:setTag(data.id)
			btnDelete:addClickEventListener(self.onPartnerDelete)

		end
		self.lstPartner:pushBackCustomItem(item)
	end
end

function GuildPartner:addPartner(target_id)
	local msgToSend = {}
	msgToSend.cmd = gt.GUILD_SET_PARTNER
	msgToSend.open_id = gt.playerData.openid
	msgToSend.target_id = target_id
	msgToSend.guild_id = self.currentGuild.id
	msgToSend.option = 1

	gt.socketClient:sendMessage(msgToSend)
	gt.showLoadingTips("")
end


function GuildPartner:close()

	gt.socketClient:unregisterMsgListener(gt.GUILD_GET_PARTNERS)
	gt.socketClient:unregisterMsgListener(gt.GUILD_SET_PARTNER)
	gt.socketClient:unregisterMsgListener(gt.PARTNER_MATCH_SCORE)
	gt.socketClient:unregisterMsgListener(gt.GUILD_SCORE_GIVE)

	self.lstPartner:removeAllChildren()
	self.lstScore:removeAllChildren()
	self.panelItem:release()
	self.panelScoreItem:release()

	if self.listPartner_helper then
        self.listPartner_helper:Release()
        self.listPartner_helper = nil
    end
	if self.listScore_helper then
        self.listScore_helper:Release()
        self.listScore_helper = nil
    end

	self:removeFromParent()
end

return GuildPartner