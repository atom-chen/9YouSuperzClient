local gt = cc.exports.gt

local UnionScoreManage = class("UnionScoreManage",function()
	return gt.createMaskLayer()
end)

function UnionScoreManage:ctor(guild_id)
	local csbNode = cc.CSLoader:createNode("csd/Guild/UnionScoreManage.csb")
	csbNode:setAnchorPoint(0.5,0.5)
	csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
--    ccui.Helper:doLayout(csbNode)
	self:addChild(csbNode)
	self.csbNode = csbNode
	
	--列表背景 高适配
	self.Image_ListBg = gt.seekNodeByName(csbNode, "Image_ListBg")
	local listBgSize = self.Image_ListBg:getContentSize()
	listBgSize.height = listBgSize.height + (gt.winSize.height - 720)
	self.Image_ListBg:setContentSize(listBgSize)
	
	--列表 宽+高适配	
	self.listItem = gt.seekNodeByName(csbNode, "List_Item")
	local listSize = self.listItem:getContentSize()
	listSize.width = listSize.width + (gt.winSize.width - 1280)
	listSize.height = listSize.height + (gt.winSize.height - 720)
	self.listItem:setContentSize(listSize)
	
	--列表项 宽度适配
	self.ItemTemplate = self.listItem:getChildByName("Panel_Template")
	local ItemSize = self.ItemTemplate:getContentSize()
	ItemSize.width = ItemSize.width + (gt.winSize.width - 1280)
	self.ItemTemplate:setContentSize(ItemSize)
	
	ccui.Helper:doLayout(csbNode)
	
	self.guild_id = guild_id
	
	
	self:initUI()
	self:initListScore()

	self:sendScoreList()

	gt.socketClient:registerMsgListener(gt.MATCH_RANK, self, self.onRcvMatchRank)
	gt.socketClient:registerMsgListener(gt.GUILD_SCORE_GIVE, self, self.onRcvPartnerScoreGive)
end

function UnionScoreManage:initUI()
	local btnClose = gt.seekNodeByName(self.csbNode, "Button_Close")
	gt.addBtnPressedListener(btnClose, function()
		self:close()
	end)


	self.btnSearch = gt.seekNodeByName(self.csbNode, "Button_SearchPlayer")
	gt.addBtnPressedListener(self.btnSearch, function()
		local view = require("app/views/Guild/GuildNumberPad"):create("search_user", 0, 0, handler(self, self.searchUser))
		self:addChild(view)
	end)
	self.btnShowAll = gt.seekNodeByName(self.csbNode, "Button_CheckAll")
	gt.addBtnPressedListener(self.btnShowAll, function()
		self:refreshSearchState(false)
		self:sendScoreList()
	end)

end

function UnionScoreManage:initListScore()
	self.lstScore = gt.seekNodeByName(self.csbNode,"List_Item") 
	
	self.pTemplate = self.lstScore:getChildByName("Panel_Template")
	self.pTemplate:retain()
	self.lstScore:removeAllChildren()


	--记录列表的辅助工具    
    if cc.exports.ListViewHelper == nil then
        require "app/ListViewHelper"
    end
    --创建列表item的函数
    if self.listScore_helper == nil then
        local create_item_func = function (v, i, cached_item)
        	local item = self:CreateScoreItem(v, i, cached_item or self.pTemplate:clone())
        	return item
        end
        self.listScore_helper = ListViewHelper:create(self.lstScore, self.pTemplate, create_item_func, true)
    end

    local function onAddScore(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		
		local view = require("app/views/Guild/GuildNumberPad"):create("partnerMember_give_to", self.guild_id, sender:getTag(), nil, self:getMyScore())
		self:addChild(view)
		
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

			local view = require("app/views/Guild/GuildNumberPad"):create("partnerMember_give_from", self.guild_id, sender:getTag(), nil, curScore)
			self:addChild(view)
		else
			require("app/views/NoticeTips"):create("提示", "当前玩家已没有积分", nil, nil, true)
		end
	end
	self.onMinusScore = onMinusScore

end


function UnionScoreManage:searchUser(user_id)

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

		self:refreshScoreList()
	end


	if not find then
		require("app/views/NoticeTips"):create("提示", "查无此玩家", nil, nil, true)
	end
end

function UnionScoreManage:refreshSearchState(isSearch)
	self.isSearch = isSearch
	self.btnShowAll:setVisible(isSearch)
	self.btnSearch:setVisible(not isSearch)
end


function UnionScoreManage:getMyScore()
	local myScore = gt.UnionManager:getMyScore(self.guild_id)

	return myScore 
end

function UnionScoreManage:CreateScoreItem(v, i, pItem)

	pItem:getChildByName("Label_Name"):setString(tostring(v.nick))
	pItem:getChildByName("Label_ID"):setString(tostring(gt.commonTool:hideText(v.id, true)))
	pItem:getChildByName("Label_Score"):setString(tostring(v.score))

	local btnAdd = pItem:getChildByName("Btn_Add")
	if btnAdd and self.onAddScore then
		btnAdd:setTag(v.id)
		btnAdd:addClickEventListener(self.onAddScore)
		btnAdd:setVisible(v.id ~= gt.playerData.uid)
	end
	local btnMinus = pItem:getChildByName("Btn_Minus")
	if btnMinus and self.onMinusScore then
		btnMinus:setTag(v.id)
		btnMinus:addClickEventListener(self.onMinusScore)
		btnMinus:setVisible(v.id ~= gt.playerData.uid )
	end

	return pItem
end

function UnionScoreManage:sendScoreList() 
	local msgToSend = {}
	msgToSend.cmd = gt.MATCH_RANK
	msgToSend.open_id = gt.playerData.openid
	msgToSend.guild_id = self.guild_id
	msgToSend.user_id = gt.playerData.uid
	msgToSend.score_type = scoreType
	gt.socketClient:sendMessage(msgToSend)
	
	self:refreshSearchState(false)
	gt.showLoadingTips("")
end

function UnionScoreManage:onRcvMatchRank(msgTbl)
	gt.removeLoadingTips()

	local page = msgTbl.page + 1
	if page == 1 then
		self.lstData = msgTbl.ranks
	else
		if self.lstData then
			for i, v in ipairs(msgTbl.ranks) do
				table.insert(self.lstData, v)
			end
		end
	end
	if page * msgTbl.pre_page >= msgTbl.total then

		self:refreshScoreList()
	end
end


function UnionScoreManage:onRcvPartnerScoreGive(msgTbl)
	gt.removeLoadingTips()
	
	if msgTbl.code == 0 then
		
		gt.UnionManager:setMyScore(self.guild_id, msgTbl.memScore)

		local index_ = 0
		local myIndex_ = 0
		if self.isSearch and self.searchIndex and self.lstData[self.searchIndex] then
			if self.lstData[self.searchIndex].id == msgTbl.target_id then
				self.lstData[self.searchIndex].score = msgTbl.targetScore
				index_ = i
			end
			if self.lstData[self.searchIndex].id == gt.playerData.uid then
				self.lstData[self.searchIndex].score = msgTbl.memScore
				myIndex_ = i
			end
    	else 	   		
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
    	end
		local item 
		if self.isSearch and self.searchIndex and self.lstData[self.searchIndex] then 	
			item = self.listScore_helper:GetItem(1)
		else
			item = self.listScore_helper:GetItem(index_)
		end
		if item then
			item:getChildByName("Label_Score"):setString(tostring(msgTbl.targetScore))
			require("app/views/CommonTips"):create("操作成功", 2)
		end
		local myItem = self.listScore_helper:GetItem(myIndex_)
		if myItem then
			myItem:getChildByName("Label_Score"):setString(tostring(msgTbl.memScore))
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

function UnionScoreManage:refreshScoreList()
	table.sort(self.lstData, function( a, b)
		return a.score > b.score
		end)

	table.sort(self.lstData, function( a, b)
		if a.id == gt.playerData.uid then
			return true
		elseif b.id == gt.playerData.uid then
			return false
		elseif a.score == b.score then
			return a.id < b.id
		else
			return a.score > b.score
		end
	end)
 	-- self.listScore_helper:SetItemsData({})
    local delay_call = function ()
    	if self.isSearch and self.searchIndex and self.lstData[self.searchIndex] then
    		self.listScore_helper:SetItemsData({self.lstData[self.searchIndex]}, true)
    	else 	   		
    		self.listScore_helper:SetItemsData(self.lstData, true)
    	end
    	-- self:updateTotalScore()
    end
    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
end

function UnionScoreManage:close()
	gt.socketClient:unregisterMsgListener(gt.MATCH_RANK)
	gt.socketClient:unregisterMsgListener(gt.GUILD_SCORE_GIVE)

	self.lstScore:removeAllChildren()
	self.pTemplate:release()

	if self.listScore_helper then
        self.listScore_helper:Release()
        self.listScore_helper = nil
    end

	self:removeFromParent()
end

return UnionScoreManage
