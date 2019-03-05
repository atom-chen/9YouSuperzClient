-- 俱乐部成员

local gt = cc.exports.gt

local GuildMember = class("GuildMember", function()
	return gt.createMaskLayer()
end)

function GuildMember:ctor(guild_id, is_union)
	local csbNode = cc.CSLoader:createNode("csd/Guild/GuildMember.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	self.currentGuild = nil
	gt.log("-----openUI:GuildMember")
	self.guild_id = guild_id
	self.is_union = is_union or false
	if self.is_union then
		self.currentGuild = gt.UnionManager:getGuild(guild_id)
		self.isShowId = gt.UnionManager:isGuildAdmin(guild_id) or gt.UnionManager:isGuildOwner(guild_id)
	else
		self.currentGuild = gt.guildManager:getGuild(guild_id)
		self.isShowId = gt.guildManager:isGuildAdmin(guild_id) or gt.guildManager:isGuildOwner(guild_id)
	end

		-- 头像下载管理器
	local playerHeadMgr = require("app/PlayerHeadManager"):create("GuildMember")
	self.csbNode:addChild(playerHeadMgr)
	self.playerHeadMgr = playerHeadMgr

	local btnClose = gt.seekNodeByName(csbNode, "btnClose")
	gt.addBtnPressedListener(btnClose, function()
		self:close()
	end)
	self.isDeleteModle = false
	self.deleteTbl = {}

	self:initMemberList()
	self:initUI()
	self:sendRefreshMember()

	self:setDeleteModle(false)

	gt.socketClient:registerMsgListener(gt.GUILD_MEMBER, self, self.onRcvGuildMember)
	gt.socketClient:registerMsgListener(gt.GUILD_DEL_MEMBERS, self, self.onRcvDelMembers)
end

function GuildMember:sendRefreshMember()
	local msgToSend = {}
	msgToSend.cmd = gt.GUILD_MEMBER
	msgToSend.user_id = gt.playerData.uid
	msgToSend.open_id = gt.playerData.openid
	msgToSend.guild_id = self.guild_id
	msgToSend.tp = 0
	
	gt.socketClient:sendMessage(msgToSend)
	gt.showLoadingTips("")

end

function GuildMember:setDeleteModle(isDelete)
	local hz = false
	if self.currentGuild and self.currentGuild.owner_id == gt.playerData.uid then
		hz = true
	end
	if not hz then
		return
	end

	self.isDeleteModle = isDelete
	self:refreshDeleteModle()
end

function GuildMember:refreshDeleteModle()
	if self.isDeleteModle then
		self.btnDelete:setVisible(false)
		self.btnBack:setVisible(true)
		self.btnDeleteConfirm:setVisible(true)
		self.deleteTbl = {}
	else
		self.btnDelete:setVisible(true)
		self.btnBack:setVisible(false)
		self.btnDeleteConfirm:setVisible(false)
		self.deleteTbl = {}

		if self.listMember_helper and self.listMember_helper:GetInnerContainer() then
			local children = self.listMember_helper:GetInnerContainer():getChildren()
			-- gt.log("#children:"..#children)
			for i, child in ipairs(children) do
				for j = 1, 5 do
					-- gt.log("----------:delete:"..(i-1)*5 + j.." i:"..i .. " j:"..j)
					local item = child:getChildByName("pItem"..(j-1))
					if item then
						item:getChildByName("imgCheck"):setVisible(false)
					end
				end
			end
		end
	end
end


function GuildMember:initUI()
	local btnDeleteConfirm = gt.seekNodeByName(self.csbNode,"btnDeleteConfirm")
	btnDeleteConfirm:addClickEventListener(function()
		gt.log("-----------------btnDeleteConfirm")
		gt.dump(self.deleteTbl)
		if #self.deleteTbl <= 0 then
		 	require("app/views/NoticeTips"):create("提示", "请选择成员后再点击删除。", nil, nil, true)
		else
			local msgToSend = {}
			msgToSend.cmd = gt.GUILD_DEL_MEMBERS
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.guild_id = self.guild_id
			msgToSend.member_id = self.deleteTbl
			msgToSend.tp = 0
			gt.socketClient:sendMessage(msgToSend)
			gt.showLoadingTips("")

			self:setDeleteModle(false)
		end
	end)
	self.btnDeleteConfirm = btnDeleteConfirm
	self.btnDeleteConfirm:setVisible(false)

	local btnDelete = gt.seekNodeByName(self.csbNode,"btnDelete")
	btnDelete:addClickEventListener(function()
		-- local children = self.lstMember:getChildren()
		-- for i, child in ipairs(children) do
			-- if child:getTag() == 0 then
			-- 	child:getChildByName("Btn_Delete"):setVisible(true)
			-- end
		-- end
		self:setDeleteModle(true)
	end)
	btnDelete:setVisible(false)
	self.btnDelete = btnDelete

	local btnBack = gt.seekNodeByName(self.csbNode, "btnBack")
	btnBack:addClickEventListener(function()
		self:setDeleteModle(false)
	end)
	btnBack:setVisible(false)
	self.btnBack = btnBack


	local btnSearch = gt.seekNodeByName(self.csbNode,"BtnSearch")
	btnSearch:addClickEventListener(function()
		local view = require("app/views/Guild/GuildNumberPad"):create("search_user", 0, 0, handler(self, self.searchUserPref))
		self:addChild(view)
	end)
	self.btnSearch = btnSearch
	-- BtnSearch:setVisible(false)

	local btnShowAll = gt.seekNodeByName(self.csbNode,"btnShowAll")
	btnShowAll:addClickEventListener(function()
		self.btnShowAll:setVisible(false)
		self.btnSearch:setVisible(true)
		self:sendRefreshMember()
	end)
	self.btnShowAll = btnShowAll
	btnShowAll:setVisible(false)

	local lblMember = gt.seekNodeByName(self.csbNode,"lblMember")
	self.lblMember = lblMember
	self.lblMember:setVisible(false)


end

function GuildMember:searchUserPref(user_id)

	local find = false
	local index_ = 0
	for i, v in ipairs(self.sorted_members) do
		if v.id == user_id then
			index_ = i
			find = true
		end
	end

	if find and self.sorted_members[index_] then

		self.sorted_members = {self.sorted_members[index_]}

		self.listMember_helper:SetItemsData({})
	    local delay_call = function ()
			self.btnShowAll:setVisible(true)
			self.btnSearch:setVisible(false)

	    	local searchData = self:convertTo5List(self.sorted_members)

	    	self.listMember_helper:SetItemsData(searchData, true)
	    end
	    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
	end

	if not find then
		require("app/views/NoticeTips"):create("提示", "查无此玩家", nil, nil, true)
	end

end

function GuildMember:searchUser(user_id)
	local children = self.lstMember:getChildren()
	local find = false
	for i, child in ipairs(children) do
		for j = 1, 5 do
			local item = child:getChildByName("pItem"..(j-1))
			if item then
				local lblID = item:getChildByName("lblID")
				if lblID:getString() == "ID:"..user_id then
					lblID:setTextColor(cc.c3b(255,185,0))
					local index = self.lstMember:getIndex(child)
					self.lstMember:scrollToItem(index, cc.p(0.5, 0.5), cc.p(0.5, 0.5))
					find = true
				else
					lblID:setTextColor(cc.c3b(255,255,255))
				end

			end
		end
		
	end
	if not find then
		require("app/views/NoticeTips"):create("提示", "查无此玩家", nil, nil, true)
	end
end

function GuildMember:onRcvDelMembers(msgTbl)
	gt.removeLoadingTips()
	self:sendRefreshMember()
end

function GuildMember:onRcvGuildMember(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == -1 then
		return
	end
	local guild_id = msgTbl.guild_id
	local tp = msgTbl.tp
	local members = {}
	for i, v in ipairs(msgTbl.players) do
		local member_info = {}
		member_info.id = v.id
		member_info.nick = v.nick
		member_info.icon = v.icon
		member_info.admin = v.admin
		table.insert(members, member_info)
	end

	if tp == 0 then  -- 俱乐部玩家列表
		local page = msgTbl.page
		if page == 1 then
			if self.is_union then
				gt.UnionManager:setGuildMembers(guild_id, members)
			else
				gt.guildManager:setGuildMembers(guild_id, members)
			end
		else
			if self.is_union then
				gt.UnionManager:addGuildMemberByList(guild_id, members)
			else
				gt.guildManager:addGuildMemberByList(guild_id, members)
			end
		end
		if page * msgTbl.per_page >= msgTbl.total then
			self:UpdateMemberList()
		end
	end
end

function GuildMember:initMemberList()
	local lstMember = gt.seekNodeByName(self.csbNode, "lstMember")
	self.panelItem = lstMember:getChildByName("panelItem")
	self.panelItem:retain()
	lstMember:removeAllChildren()
	self.lstMember = lstMember

	local function onItemCheck(sender)
		if not self.isDeleteModle then return end

		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		
		local index_ = sender:getTag()
		local memData = self.sorted_members[index_]

		local isCheck,checkIndex = self:isInDeleteTbl(memData.id)
		if isCheck then
			self:removeDeleteTbl(index_,sender)
		else
			self:addDeleteTbl(index_,sender)
		end

	end
	self.onItemCheck = onItemCheck


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
        self.listMember_helper = ListViewHelper:create(self.lstMember, self.panelItem, create_item_func, true)
    end

end

function GuildMember:CreateMemberItem(v, i, itemBase)
	
	itemBase:getChildByName("pItem0"):setVisible(false)
	itemBase:getChildByName("pItem1"):setVisible(false)
	itemBase:getChildByName("pItem2"):setVisible(false)
	itemBase:getChildByName("pItem3"):setVisible(false)
	itemBase:getChildByName("pItem4"):setVisible(false)

	local pItem
	for j, member in ipairs(v) do
		if j % 5 == 1 then
			pItem = itemBase:getChildByName("pItem0")
			pItem:setVisible(true)		
		elseif j % 5 == 2 then
			pItem = itemBase:getChildByName("pItem1")
			pItem:setVisible(true)		
		elseif j % 5 == 3 then
			pItem = itemBase:getChildByName("pItem2")
			pItem:setVisible(true)		
		elseif j % 5 == 4 then
			pItem = itemBase:getChildByName("pItem3")
			pItem:setVisible(true)
		else
			pItem = itemBase:getChildByName("pItem4")
			pItem:setVisible(true)
		end

		pItem:getChildByName("lblName"):setString(" ")
		pItem:getChildByName("lblName"):setString(gt.checkName(member.nick, 8))
		pItem:getChildByName("lblID"):setString("ID:".. gt.commonTool:hideText(member.id, self.isShowId))

		local imgCheck = pItem:getChildByName("imgCheck")
		imgCheck:setTag(member.id)
		imgCheck:setVisible(false)

		local imgHead = pItem:getChildByName("imgHead")
		-- imgHead:setVisible(false)
		self.playerHeadMgr:resetHeadSpr(imgHead)
		self.playerHeadMgr:attach(imgHead, member.id, member.icon)

		local imgTag = pItem:getChildByName("ImgTag")
		imgTag:setVisible(true)
		if member.weight == 2 then
			imgTag:loadTexture("image/guild/tag_owner.png", ccui.TextureResType.plistType)
		elseif member.weight == 1 then
			imgTag:loadTexture("image/guild/tag_admin.png", ccui.TextureResType.plistType)
		else
			imgTag:setVisible(false)
		end
		-- pItem:setTag(member.weight)
		pItem:setTag( 5*(i-1) + j )
		pItem:addClickEventListener(self.onItemCheck)


		local isCheck,checkIndex = self:isInDeleteTbl(member.id)
		pItem:getChildByName("imgCheck"):setVisible(checkIndex > 0)

	end

	return itemBase
end

function GuildMember:isInDeleteTbl(id_)
	local isCheck = false
	local checkIndex = 0
	-- gt.dump(self.deleteTbl)
	for i, v in ipairs(self.deleteTbl) do
		gt.log("type：v"..type(v).." v:"..v)
		gt.log("type：id_"..type(id_).." id_:"..id_)

		if v == id_ then
			isCheck = true
			checkIndex = i
		end
	end
	return isCheck,checkIndex
end

function GuildMember:addDeleteTbl(index_, sender)
	local memData = self.sorted_members[index_]
	if memData.weight > 0 then
		return
	end
	local isCheck = self:isInDeleteTbl(memData.id)
	if not isCheck then
		table.insert(self.deleteTbl, memData.id)
		sender:getChildByName("imgCheck"):setVisible(true)
	end
	-- self.btnDeleteConfirm:setVisible(#self.deleteTbl > 0)
end

function GuildMember:removeDeleteTbl(index_, sender)
	local memData = self.sorted_members[index_]

	local isCheck,checkIndex = self:isInDeleteTbl(memData.id)
	if checkIndex > 0 then
		sender:getChildByName("imgCheck"):setVisible(false)
		table.remove(self.deleteTbl, checkIndex)
	end

end

function GuildMember:convertTo5List(listData_)
	local lstData5 = {}
	-- lstData5 = listData_
	-- gt.dump(listData_)

	for i, member in ipairs(listData_) do
		local x = math.ceil(i/5)
		local y = i % 5 > 0 and i % 5 or 5
		-- gt.log("-----------:".. x .. "  "..y)
		if lstData5[x] == nil then lstData5[x] = {} end
		lstData5[x][y] = member
	end

	-- gt.dump(lstData5)
	return lstData5
end

function GuildMember:UpdateMemberList()
	if not self.currentGuild then return end

	local members = nil
	if self.is_union then
		members = gt.UnionManager:getGuildMembers(self.currentGuild.id)
	else
		members = gt.guildManager:getGuildMembers(self.currentGuild.id)
	end
	if not members then return end

	self.lblMember:setString(string.format("人数：  %d/10000",#members))
	self.lblMember:setVisible(true)

	local sorted_members = clone(members)
	for i, member in ipairs(sorted_members) do
		if member.id == self.currentGuild.owner_id then
			member.weight = 2
		elseif member.admin then
			member.weight = 1
		else
			member.weight = 0
		end
	end
	table.sort(sorted_members, function(a, b) return a.weight > b.weight end)

	self.playerHeadMgr:detachAll()
	-- self.lstMember:removeAllChildren()
	self.sorted_members = sorted_members

	self:showAllMember()
	-- gt.log("-------------------------------------------------------")
	-- gt.dump(self.sorted_members)
	-- local itemBase 
	-- local pItem 
	-- for i, member in ipairs(sorted_members) do
	-- 	if i % 5 == 1 then
	-- 		itemBase = self.panelItem:clone()
	-- 		self.lstMember:pushBackCustomItem(itemBase)
	-- 		pItem = itemBase:getChildByName("pItem0")
	-- 	elseif i % 5 == 2 then
	-- 		pItem = itemBase:getChildByName("pItem1")
	-- 		pItem:setVisible(true)		
	-- 	elseif i % 5 == 3 then
	-- 		pItem = itemBase:getChildByName("pItem2")
	-- 		pItem:setVisible(true)		
	-- 	elseif i % 5 == 4 then
	-- 		pItem = itemBase:getChildByName("pItem3")
	-- 		pItem:setVisible(true)
	-- 	else
	-- 		pItem = itemBase:getChildByName("pItem4")
	-- 		pItem:setVisible(true)
	-- 	end

	-- 	pItem:getChildByName("lblName"):setString(gt.checkName(member.nick, 8))
	-- 	pItem:getChildByName("lblID"):setString("ID:"..member.id)

	-- 	local imgCheck = pItem:getChildByName("imgCheck")
	-- 	imgCheck:setTag(member.id)
	-- 	imgCheck:setVisible(false)

	-- 	local imgHead = pItem:getChildByName("imgHead")
	-- 	self.playerHeadMgr:attach(imgHead, member.id, member.icon)

	-- 	local imgTag = pItem:getChildByName("ImgTag")
	-- 	if member.weight == 2 then
	-- 		imgTag:loadTexture("image/guild/tag_owner.png", ccui.TextureResType.plistType)
	-- 	elseif member.weight == 1 then
	-- 		imgTag:loadTexture("image/guild/tag_admin.png", ccui.TextureResType.plistType)
	-- 	else
	-- 		imgTag:setVisible(false)
	-- 	end
	-- 	-- pItem:setTag(member.weight)
	-- 	pItem:setTag(i)
	-- 	pItem:addClickEventListener(self.onItemCheck)

	-- end
end

function GuildMember:showAllMember()
	self.sorted_5_members = self:convertTo5List(self.sorted_members)
	-- gt.dump(self.sorted_5_members)

	if self.listMember_helper then
		self.listMember_helper:SetItemsData({})
	    local delay_call = function ()
	    	self.listMember_helper:SetItemsData(self.sorted_5_members, true)
	    	-- self:updateTotalScore()
	    end
	    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
   end
end

function GuildMember:close()

	gt.socketClient:unregisterMsgListener(gt.GUILD_MEMBER)
	gt.socketClient:unregisterMsgListener(gt.GUILD_DEL_MEMBERS)

	gt.dispatchEvent(gt.EventType.GUILD_MEMBER_MSG)

	self.playerHeadMgr:detachAll()
	self.lstMember:removeAllChildren()
	self.panelItem:release()

	if self.listMember_helper then
        self.listMember_helper:Release()
        self.listMember_helper = nil
    end

	self:removeFromParent()
end

return GuildMember