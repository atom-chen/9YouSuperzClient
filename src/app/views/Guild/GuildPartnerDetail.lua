-- 俱乐部合伙人成员

local gt = cc.exports.gt

local GuildPartnerDetail = class("GuildPartnerDetail", function()
	return gt.createMaskLayer()
end)

function GuildPartnerDetail:ctor(guild_id , partner_id, is_union)
	local csbNode = cc.CSLoader:createNode("csd/Guild/GuildPartnerDetail.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	gt.log("-----openUI:GuildPartnerDetail")
	self.guild_id = guild_id
	self.is_union = is_union or false
	self.partner_id = partner_id

	if self.is_union then
		self.currentGuild = gt.UnionManager:getGuild(guild_id)
	else
		self.currentGuild = gt.guildManager:getGuild(guild_id)
	end

	self:initUI()
	self:initListMember()
	self:initListScore()
	-- self:sendRefreshPartnerInfo()


	self:initTab()

	self:changeTab(self.btnTabPartner)


	gt.socketClient:registerMsgListener(gt.GUILD_PARTNER_INFO, self, self.onRcvGuildPartnerInfo)
	gt.socketClient:registerMsgListener(gt.GUILD_TAG_MEMBER, self, self.onRcvGuildTagMem)
	gt.socketClient:registerMsgListener(gt.GUILD_INVITE, self, self.onRcvGuildInvite)
	gt.socketClient:registerMsgListener(gt.GUILD_SCORE_GIVE, self, self.onRcvPartnerScoreGive)
end

function GuildPartnerDetail:initUI()
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

	local btnAddPartnerMem = gt.seekNodeByName(self.csbNode, "btnAddPartnerMem")
	gt.addBtnPressedListener(btnAddPartnerMem, function()
		local view = require("app/views/Guild/GuildNumberPad"):create("add_partnerMem", 0, 0, handler(self, self.addPartnerMem))
		self:addChild(view)
	end)

	local btnInvite = gt.seekNodeByName(self.csbNode, "btnInvite")
	gt.addBtnPressedListener(btnInvite, function()
		if self.currentGuild then
			-- local view = require("app/views/Guild/GuildNumberPad"):create("guild_invite", self.currentGuild.id)
			
			local view = require("app/views/Guild/GuildNumberPad"):create("guild_invite_member", self.currentGuild.id)
			self:addChild(view)
		end
	end)

	btnAddPartnerMem:setVisible( self:isShowAddBtn() )   


	self.btnSearch = gt.seekNodeByName(self.csbNode, "btnSearch")
	gt.addBtnPressedListener(self.btnSearch, function()
		local view = require("app/views/Guild/GuildNumberPad"):create("search_user", 0, 0, handler(self, self.searchUser))
		self:addChild(view)
	end)

	self.btnShowAll = gt.seekNodeByName(self.csbNode, "btnShowAll")
	gt.addBtnPressedListener(self.btnShowAll, function()
		self:refreshSearchState(false)
		self:sendRefreshPartnerInfo()
	end)

	self.btnSearch:setVisible(false)
	self.btnShowAll:setVisible(false)
	if not self:isShowAddBtn() then --非管理员
		self.btnSearch:setVisible(true)
	end

	self.lblListNoStr = gt.seekNodeByName(self.csbNode, "lblListNoStr")
	self.lblListNoStr:setVisible(false)
	self.lblRoundYesterdayStr = gt.seekNodeByName(self.csbNode, "lblRoundYesterdayStr")
	self.lblRoundYesterdayStr:setVisible(false)
	self.lblRoundYesterDay = gt.seekNodeByName(self.csbNode, "lblRoundYesterDay")
	self.lblRoundYesterDay:setVisible(false)
	self.lblMemCountStr = gt.seekNodeByName(self.csbNode, "lblMemCountStr")
	self.lblMemCountStr:setVisible(false)
	self.lblMemCount = gt.seekNodeByName(self.csbNode, "lblMemCount")
	self.lblMemCount:setVisible(false)
end


function GuildPartnerDetail:refreshSearchState(isSearch)
	if not self:isShowAddBtn() then
		self.isSearch = isSearch
		self.btnShowAll:setVisible(isSearch)
		self.btnSearch:setVisible(not isSearch)
	end
end

function GuildPartnerDetail:searchUser(user_id)

	local find = false
	local index_ = 0
	for i, v in ipairs(self.lstData) do
		if v.id == user_id then
			index_ = i
			find = true
		end
	end

	if find and self.lstData[index_] then
		self.searchIndex = index_
		self:refreshSearchState(true)
		
		if self.curSender == self.btnTabPartner then
			self:refreshPartner()
	    else
	    	self:refreshScore()
	    end
	end


	if not find then
		require("app/views/NoticeTips"):create("提示", "查无此玩家", nil, nil, true)
	end
end



function GuildPartnerDetail:initTab()
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


function GuildPartnerDetail:changeTab(sender)
	self.curSender= sender
    self.btnTabPartner:setEnabled(true)
	self.btnTabScore:setEnabled(true)

	self.pPanelPartner:setVisible(false)
	self.pPanelScore:setVisible(false)

	if sender == self.btnTabPartner then
		self.btnTabPartner:setEnabled(false)
		self.pPanelPartner:setVisible(true)
		
		self:sendRefreshPartnerInfo()

	elseif sender == self.btnTabScore then
		self.btnTabScore:setEnabled(false)
		self.pPanelScore:setVisible(true)

		self:refreshScore()
	end
end


function GuildPartnerDetail:initListScore()
	local lstScore = gt.seekNodeByName(self.csbNode,"lstScore") 

	self.panelScoreItem = lstScore:getChildByName("panelItem")
	self.panelScoreItem:retain()

	lstScore:removeAllChildren()
	self.lstScore = lstScore

	local function onAddScore(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		if self.is_union then
			local view = require("app/views/Guild/GuildNumberPad"):create("partnerMember_give_to", self.guild_id, sender:getTag(), nil, self:getMyScore())
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
				local view = require("app/views/Guild/GuildNumberPad"):create("partnerMember_give_from", self.guild_id, sender:getTag(), nil, curScore)
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


function GuildPartnerDetail:getMyScore()
	local myScore = 0 
	if self.is_union then
		myScore = gt.UnionManager:getMyScore(self.guild_id)
	else
		myScore = gt.guildManager:getMyScore(self.guild_id)
	end
	return myScore 
end

function GuildPartnerDetail:refreshPartner()

	self.listMember_helper:SetItemsData({})
    local delay_call = function ()
   	 	if self.isSearch and self.searchIndex and self.lstData[self.searchIndex] then
    		self.listMember_helper:SetItemsData({self.lstData[self.searchIndex]}, true)
    	else
    		self.listMember_helper:SetItemsData(self.lstData, true)
    	end
    end
    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))

end

function GuildPartnerDetail:refreshScore()

	self.listScore_helper:SetItemsData({})
    local delay_call = function ()
    	if self.isSearch and self.searchIndex and self.lstData[self.searchIndex] then
    		self.listScore_helper:SetItemsData({self.lstData[self.searchIndex]}, true)
    	else 	   		
    		self.listScore_helper:SetItemsData(self.lstData, true)
    	end
    end
    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))

end


function GuildPartnerDetail:isShowAddBtn()
	return self.currentGuild.owner_id == gt.playerData.uid or self.currentGuild.admin
end

function GuildPartnerDetail:initListMember()
	local lstMembers = gt.seekNodeByName(self.csbNode,"lstMembers") 

	self.panelItem = lstMembers:getChildByName("panelItem")
	self.panelItem:retain()

	lstMembers:removeAllChildren()
	self.lstMembers = lstMembers

	local function onMemDelete(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)

		local member_id = sender:getTag()
		local function confirm()
			local msgToSend = {}
			msgToSend.cmd = gt.GUILD_TAG_MEMBER
			msgToSend.open_id = gt.playerData.openid
			msgToSend.target_id = member_id
			msgToSend.partner_id = 0
			msgToSend.guild_id = self.currentGuild.id

			gt.socketClient:sendMessage(msgToSend)
			gt.showLoadingTips("")
		end
		local tips = string.format("您确定要删除成员ID:%d吗?", member_id)
		require("app/views/NoticeTips"):create("提示", tips, confirm, nil, false)

    end
    self.onMemDelete = onMemDelete

     --记录列表的辅助工具    
    if cc.exports.ListViewHelper == nil then
        require "app/ListViewHelper"
    end
    --创建列表item的函数
    if self.listMember_helper == nil then
        local create_item_func = function (v, i, cached_item)
            local item = self:CreateMemberItem(v, i, cached_item or self.panelItem:clone())
            return item
        end
        self.listMember_helper = ListViewHelper:create(self.lstMembers, self.panelItem, create_item_func, true)
    end


end


function GuildPartnerDetail:addPartnerMem(target_id)
	local msgToSend = {}
	msgToSend.cmd = gt.GUILD_TAG_MEMBER
	msgToSend.open_id = gt.playerData.openid
	msgToSend.target_id = target_id
	msgToSend.partner_id = self.partner_id
	msgToSend.guild_id = self.currentGuild.id

	gt.socketClient:sendMessage(msgToSend)
	gt.showLoadingTips("")
end



function GuildPartnerDetail:sendRefreshPartnerInfo()
	local msgToSend = {}
	msgToSend.cmd = gt.GUILD_PARTNER_INFO
	msgToSend.open_id = gt.playerData.openid
	msgToSend.guild_id = self.currentGuild.id
	msgToSend.partner_id = self.partner_id

	gt.socketClient:sendMessage(msgToSend)
	gt.showLoadingTips("")
end


function GuildPartnerDetail:onRcvPartnerScoreGive(msgTbl)
	gt.removeLoadingTips()
	
	if msgTbl.code == 0 then
		
		if self.is_union then
			gt.UnionManager:setMyScore(self.guild_id, msgTbl.memScore)
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
		require("app/views/CommonTips"):create("增加失败，您输入的分数过大，请重新输入",2)
	elseif msgTbl.code == 2 then --玩家离开俱乐部
		require("app/views/CommonTips"):create("增加失败，当前俱乐部没有该玩家",2)
	elseif msgTbl.code == 3 then -- 没有足够的分数进行转移
		require("app/views/CommonTips"):create("增加失败，您没有足够的分数进行赠送",2)
	elseif msgTbl.code == 4 then -- 游戏内无法 
		require("app/views/CommonTips"):create("增加失败，玩家正在游戏中，无法进行下分操作",2)
	elseif msgTbl.code == 5 then -- target超过限制 
		require("app/views/CommonTips"):create("操作失败，该玩家积分已超过上限",2)
	elseif msgTbl.code == 6 then -- member超过限制 
		require("app/views/CommonTips"):create("操作失败，您的积分已超过上限，请减少自己积分数量后进行操作(先下掉自己部分积分)",2)
	end
	
end


function GuildPartnerDetail:onRcvGuildInvite(msgTbl)
	gt.removeLoadingTips()

	if msgTbl.code == 0 then
		require("app/views/NoticeTips"):create("提示", "邀请成功", nil, nil, true)
		self:sendRefreshPartnerInfo()

	elseif msgTbl.code == 1 then
		require("app/views/NoticeTips"):create("提示", "您的俱乐部已满员", nil, nil, true)
	elseif msgTbl.code == 2 then
		require("app/views/NoticeTips"):create("提示", "该玩家拥有俱乐部数量超过限制", nil, nil, true)
	elseif msgTbl.code == 3 then
		require("app/views/NoticeTips"):create("提示", "该玩家不存在", nil, nil, true)
	end
end


function GuildPartnerDetail:onRcvGuildTagMem(msgTbl)
	gt.removeLoadingTips()

	if msgTbl.code == 0 then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "操作成功", nil, nil, true)
		self:sendRefreshPartnerInfo()

	elseif msgTbl.code == 1 then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "操作失败,您没有权限", nil, nil, true)
	elseif msgTbl.code == 2 then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "操作失败,俱乐部没有此玩家", nil, nil, true)
	elseif msgTbl.code == 3 then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "操作失败,此玩家是合伙人或管理员,不能成为别人的下线", nil, nil, true)
	elseif msgTbl.code == 4 then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "操作失败,您没有权限", nil, nil, true)
	elseif msgTbl.code == 5 then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "操作失败,该玩家已经是合伙人成员,需要清除标签之后才能操作", nil, nil, true)
	
	end

end

function GuildPartnerDetail:onRcvGuildPartnerInfo(msgTbl)
	gt.removeLoadingTips()
	self:refreshSearchState(false)

	local page = msgTbl.page + 1
	if page == 1 then
		self.lstData = msgTbl.players
	else
		if self.lstData then
			for i, v in ipairs(msgTbl.players) do
				table.insert(self.lstData, v)
			end
		end
	end

	-- self.lstData = msgTbl.players
	if page * msgTbl.pre_page >= msgTbl.total then
		if msgTbl.code == 0 then
			-- self:refreshListMember()
			local count = #self.lstData
			self.lblListNoStr:setVisible(count<=0)

			table.sort(self.lstData, function (a,b)
               return a.last_day.emoition > b.last_day.emoition
            end)

			if self.curSender == self.btnTabPartner then
				self:refreshPartner()
			else
				self:refreshScore()
			end
		end

		if #self.lstData > 0 then
			self.lblRoundYesterdayStr:setVisible(true)
			self.lblRoundYesterDay:setVisible(true)
			self.lblRoundYesterDay:setString(msgTbl.count)
			self.lblMemCountStr:setVisible(true)
			self.lblMemCount:setVisible(true)
			self.lblMemCount:setString(tostring(#self.lstData))
		end
	end

end

function GuildPartnerDetail:isShowScoreBtns()
	return self.partner_id == gt.playerData.uid
			-- or self.currentGuild.owner_id == gt.playerData.uid --self:isShowAddBtn()
end

function GuildPartnerDetail:CreateScoreItem(v, i, pItem)
	pItem:getChildByName("lblId"):setString(v.id)
	pItem:getChildByName("lblName"):setString(" ")
	pItem:getChildByName("lblName"):setString(v.nick)
	pItem:getChildByName("lblScore"):setString(v.score)

	local btnAdd = pItem:getChildByName("Btn_Add")
	if btnAdd and self.onAddScore then
		btnAdd:setTag(v.id)
		btnAdd:addClickEventListener(self.onAddScore)
		btnAdd:setVisible(self:isShowScoreBtns())
	end

	local btnMinus = pItem:getChildByName("Btn_Minus")
	if btnMinus and self.onMinusScore then
		btnMinus:setTag(v.id)
		btnMinus:addClickEventListener(self.onMinusScore)
		btnMinus:setVisible(self:isShowScoreBtns())
	end

	return pItem
end


function GuildPartnerDetail:CreateMemberItem(v, i, pItem)

	pItem:getChildByName("lblId"):setString(v.id)
	pItem:getChildByName("lblName"):setString(" ")
	pItem:getChildByName("lblName"):setString(v.nick)
	pItem:getChildByName("lblYesterdayCount"):setString(v.last_day.count)
	pItem:getChildByName("lblYesterdayCost"):setString(v.last_day.emoition)
	pItem:getChildByName("lblYesterdayScore"):setString(v.last_day.score)
	pItem:getChildByName("lblYesterdayRich"):setString(v.last_day.rich)

	pItem:getChildByName("lblTotalCount"):setString(v.total_count)

	-- totalCount = totalCount + v.last_day.count

	local btnDelete = pItem:getChildByName("btnDelete")
	if btnDelete and self.onMemDelete then
		btnDelete:setTag(v.id)
		btnDelete:addClickEventListener(self.onMemDelete)
	end

	return pItem
end
 
function GuildPartnerDetail:refreshListMember()
	self.lstMembers:removeAllChildren()

	local count = #self.lstData
	self.lblListNoStr:setVisible(count<=0)

	local totalCount = 0

	for i = 1, count do 
		local item =  self.panelItem:clone()
		local data = self.lstData[i]
		if data then
			item:getChildByName("lblId"):setString(data.id)
			item:getChildByName("lblName"):setString(data.nick)
			item:getChildByName("lblYesterdayCount"):setString(data.last_day.count)
			item:getChildByName("lblYesterdayCost"):setString(data.last_day.emoition)
			item:getChildByName("lblYesterdayScore"):setString(data.last_day.score)
			item:getChildByName("lblYesterdayRich"):setString(data.last_day.rich)

			item:getChildByName("lblTotalCount"):setString(data.total_count)

			totalCount = totalCount + data.last_day.count

			local btnDelete = item:getChildByName("btnDelete")
			btnDelete:setTag(data.id)
			btnDelete:addClickEventListener(self.onMemDelete)

		end
		self.lstMembers:pushBackCustomItem(item)
	end

	-- if count > 0 then
	-- 	self.lblRoundYesterdayStr:setVisible(true)
	-- 	self.lblRoundYesterDay:setVisible(true)
	-- 	self.lblRoundYesterDay:setString(totalCount)
	-- end
end



function GuildPartnerDetail:close()
	gt.socketClient:unregisterMsgListener(gt.GUILD_TAG_MEMBER)
	gt.socketClient:unregisterMsgListener(gt.GUILD_PARTNER_INFO)
	gt.socketClient:unregisterMsgListener(gt.GUILD_INVITE)

	gt.socketClient:unregisterMsgListener(gt.GUILD_SCORE_GIVE)

	gt.dispatchEvent(gt.EventType.GUILD_PARTNER_INVITE)

	if self.listMember_helper then
        self.listMember_helper:Release()
        self.listMember_helper = nil
    end
	if self.listScore_helper then
        self.listScore_helper:Release()
        self.listScore_helper = nil
    end
    
	self.lstMembers:removeAllChildren()
	self.lstScore:removeAllChildren()
	self.panelItem:release()
	self.panelScoreItem:release()

	gt.dispatchEvent(gt.EventType.GUILD_SCORE_GIVE)

	self:removeFromParent()
end

return GuildPartnerDetail