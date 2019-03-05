-- 比赛界面

local gt = cc.exports.gt

local Match = class("Match", function()
	return cc.Node:create()
end)

function Match:ctor(m_parent)
	self:registerScriptHandler(handler(self, self.onNodeEvent))
	gt.log("-----openUI:Match")
	local csbNode = cc.CSLoader:createNode("csd/Guild/Match.csb")
	csbNode:setContentSize(gt.winSize)
	self:addChild(csbNode)
	self.csbNode = csbNode
	
	self:screenAdaptive()
	
	self.m_parent = m_parent or nil
	self.refreshTime = 0


	self:initUI()
	self:initListUI()
	self:initSettingView()
	
	gt.socketClient:registerMsgListener(gt.MATCH_ROOM, self, self.onRcvMatchRoom)
	gt.socketClient:registerMsgListener(gt.MATCH_RANK, self, self.onRcvMatchRank)
	gt.socketClient:registerMsgListener(gt.MATCH_SCORE, self, self.onRcvMatchScore)

end


function Match:initUI()
		-- 头像下载管理器
	local playerHeadMgr = require("app/PlayerHeadManager"):create("Match")
	self.csbNode:addChild(playerHeadMgr)
	self.playerHeadMgr = playerHeadMgr

	-- 顶部
	local Node_Top_Right = gt.seekNodeByName(self.csbNode, "Node_Top_Right")
	
	--管理选项
	local btnAdminSetting = Node_Top_Right:getChildByName("Btn_AdminSetting")
	gt.addBtnPressedListener(btnAdminSetting, function()
		local view = require("app/views/Guild/GuildManUI"):create(self.guild_id, handler(self, self.onTransGuild))
		if self.m_parent then
			self.m_parent:addChild(view)
		else
			self:addChild(view)
		end
	end)
	self.btnAdminSetting = btnAdminSetting

	--比赛限制按钮
	self.btnLimit = Node_Top_Right:getChildByName("Btn_Limit")
	gt.addBtnPressedListener(self.btnLimit,function()
		self:setGuideVisable(self.ImgGuide1,false,1)
		local view = require("app/views/Guild/MatchExtraPro"):create(self.guild_id,self)
		if self.m_parent then
			self.m_parent:addChild(view)
		else
			self:addChild(view)
		end
	end)
	
	--玩法设置
	self.btnSetting = Node_Top_Right:getChildByName("Btn_Setting")
	gt.addBtnPressedListener(self.btnSetting, function()
		--这里改成打开玩法设置
		self:setGuideVisable(self.ImgGuide2,false,7)
		local view = require("app/views/CreateRoom"):create(self.guild_id, 1)
		if self.m_parent then
			self.m_parent:addChild(view)
		else
			self:addChild(view)
		end
	end)
	
	--成员管理
	self.btnMembers = Node_Top_Right:getChildByName("Btn_Members")
	gt.addBtnPressedListener(self.btnMembers, function()
		self.listMem_helper:SetItemsData({})
		self:showPanel(2)
	end)
	
	--合伙人管理
	local btnPartnerAdmin = Node_Top_Right:getChildByName("Btn_PartnerAdmin")
	gt.addBtnPressedListener(btnPartnerAdmin, function()
		if self:getChildByName("guildPartnerView")== nil then
			local view = require("app/views/Guild/GuildPartner"):create(self.guild_id)
			view:setName("guildPartnerView")
			if self.m_parent then
				self.m_parent:addChild(view)
			else
				self:addChild(view)
			end
		end
		
	end)
	self.btnPartnerAdmin = btnPartnerAdmin

	--我的成员
	local btnPartnerDetail = Node_Top_Right:getChildByName("Btn_PartnerMem")
	gt.addBtnPressedListener(btnPartnerDetail, function()
		if self:getChildByName("GuildPartnerDetail")== nil then
			local userId = gt.playerData.uid
			local view = require("app/views/Guild/GuildPartnerDetail"):create(self.guild_id , userId )
			view:setName("GuildPartnerDetail")
			if self.m_parent then
				self.m_parent:addChild(view)
			else
				self:addChild(view)
			end
		end
	end)
	self.btnPartnerDetail = btnPartnerDetail
	
	--积分排行
	self.btnRank = Node_Top_Right:getChildByName("Btn_Rank")
	gt.addBtnPressedListener(self.btnRank, function()
		self.listRank_helper:SetItemsData({})
		self:showPanel(3)
	end)
	
	--战绩查询
	local btnRecord = Node_Top_Right:getChildByName("Btn_Record")
	gt.addBtnPressedListener(btnRecord, function()
		local view = require("app/views/Guild/MatchRecord"):create(self.guild_id)
		if self.m_parent then
			self.m_parent:addChild(view)
		else
			self:addChild(view)
		end
	end)

	--设置
	local btn_Setting = Node_Top_Right:getChildByName("btnSetting")
	gt.addBtnPressedListener(btn_Setting, function()
		self.pSetting:setVisible(true)
		local hz = gt.guildManager:isGuildOwner(self.guild_id)

		local Node_Top_Right = self.pSetting:getChildByName("Node_Top_Right")
		Node_Top_Right:getChildByName("Btn_Dismiss"):setVisible(hz)
		Node_Top_Right:getChildByName("Btn_Rename"):setVisible(hz)
		Node_Top_Right:getChildByName("Btn_Exit"):setVisible(not hz)
		Node_Top_Right:getChildByName("Img_Bg_hz"):setVisible(hz)
		Node_Top_Right:getChildByName("Img_Bg"):setVisible(not hz)
	end)
	
	--成员
	local btnMember = Node_Top_Right:getChildByName("btnMember")
	gt.addBtnPressedListener(btnMember, function()
		local view = require("app/views/Guild/GuildMember"):create(self.guild_id)
		if self.m_parent then
			self.m_parent:addChild(view)
		else
			self:addChild(view)
		end
	end)

	self.btnPartnerAdmin:setVisible(false)
	self.btnPartnerDetail:setVisible(false)
	
	
	
	--下排按钮
	self.Node_Bottom_Right = self.csbNode:getChildByName("Node_Bottom_Right")
	
	--升级联盟
	self.btnUpgradeUnion = self.Node_Bottom_Right:getChildByName("Btn_UpgradeUnion")
	gt.addBtnPressedListener(self.btnUpgradeUnion, function()
		if self.currentGuild then
			local view = require("app/views/Guild/GuildUpgradeUnion"):create(self.currentGuild.id, self.m_parent.cost, self.m_parent.activeTime, self.m_parent.joinUnionFun)
			if self.m_parent then
				self.m_parent:addChild(view)
			else
				self:addChild(view)
			end
		end
	end)
	
	-- 邀请
	self.btnInvite = self.Node_Bottom_Right:getChildByName("Btn_Invite")
	gt.addBtnPressedListener(self.btnInvite, function()
		if self.currentGuild then
			-- local view = require("app/views/Guild/GuildNumberPad"):create("guild_invite", self.currentGuild.id)
			local view = require("app/views/Guild/GuildNumberPad"):create("guild_invite_member", self.currentGuild.id)
			if self.m_parent then
				self.m_parent:addChild(view)
			else
				self:addChild(view)
			end
		end
	end)
	
	--创建房间
	self.btnCreateRoom = self.Node_Bottom_Right:getChildByName("Btn_CreateRoom")
	gt.addBtnPressedListener(self.btnCreateRoom, function()
		self:request(gt.CREATE_GUILD_ROOM, 1)
		gt.guildid = self.guild_id
		gt.guildtype = 1
	end)

	-- 分享
	local shareBtn = self.Node_Bottom_Right:getChildByName("Btn_Share")
	gt.addBtnPressedListener(shareBtn, function()
		if self.m_parent.is_share and 1 == self.m_parent.is_share then
			local title = "俱乐部ID:"..self.currentGuild.id
			local guildName = gt.guildManager:getGuild(self.currentGuild.id).name
			local description = "赶快加入【"..guildName.."】俱乐部,俱乐部会员私密局~"
			local url = gt.shareRoomWeb .. "&app_id=" .. gt.app_id .. "&roomid=" .."g_"..self.currentGuild.id.."_"..gt.playerData.uid
			gt.log("-------------test--------------title:"..title)
			gt.log("-------------test---------------des:"..description)
			gt.log("-------------test---------------url:"..url)
			extension.shareToURL(extension.SHARE_TYPE_SESSION, title, description, url)
		else
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "操作失败，管理员已设置禁止分享拉人", nil, nil, true)
		end
	end)
	
	
	-- 成员管理
	--self.pMember = gt.seekNodeByName(csbNode, "Panel_Member")
	local btnBack = self.pMember:getChildByName("Btn_Back")
	gt.addBtnPressedListener(btnBack, function()
		self:showPanel(1)
	end)
	gt.seekNodeByName(self.pMember, "Label_TotalScore"):setVisible(false)
	
	self.isSearchState = false
	local btnSearch = self.pMember:getChildByName("Btn_Search")
	gt.addBtnPressedListener(btnSearch, function()
		if self.isSearchState then
			self:refreshMemSearchState(false)
			self.listMem_helper:SetItemsData({})
			self:showPanel(2)
		else
			local view = require("app/views/Guild/GuildNumberPad"):create("search_user", 0, 0, handler(self, self.searchUser))
			if self.m_parent then
				self.m_parent:addChild(view)
			else
				self:addChild(view)
			end
		end
	end)

	local btnScoreRecord = self.pMember:getChildByName("btnScoreRecord")
	gt.addBtnPressedListener(btnScoreRecord, function()	
		local view = require("app/views/Guild/GuildScoreRecord"):create(self.guild_id)
		if self.m_parent then
			self.m_parent:addChild(view)
		else
			self:addChild(view)
		end
	end)
	self.btnScoreRecord = btnScoreRecord


	-- 积分排行
	--self.pRank = gt.seekNodeByName(csbNode, "Panel_Rank")
	local btnBack2 = self.pRank:getChildByName("Btn_Back")
	gt.addBtnPressedListener(btnBack2, function()
		self:showPanel(1)
	end)


	self.pGuide = gt.seekNodeByName(self.csbNode, "PanelGuide")
	self.ImgGuide1 = gt.seekNodeByName(self.pGuide , "ImgGuide1")
	if self.ImgGuide1 then
		self.ImgGuide1:setVisible(false)
		gt.addBtnPressedListener(self.ImgGuide1:getChildByName("btnGuide"), function()
			self:setGuideVisable(self.ImgGuide1,false,1)
		end)
	end

	self.ImgGuide2 = gt.seekNodeByName(self.pGuide , "ImgGuide2")
	if self.ImgGuide2 then
		self.ImgGuide2:setVisible(false)
		gt.addBtnPressedListener(self.ImgGuide2:getChildByName("btnGuide"), function()
			self:setGuideVisable(self.ImgGuide2,false,7)
		end)
	end

	--昨日表情消耗
	self.Label_EmojiCost=gt.seekNodeByName(self.csbNode,"Label_EmojiCost")

	local function enterRoom(sender)
		local roomId = sender:getTag()
		local msgToSend = {}
		msgToSend.cmd = gt.JOIN_ROOM
		msgToSend.room_id = roomId
		msgToSend.app_id = gt.app_id
		msgToSend.user_id = gt.playerData.uid
		msgToSend.ver = gt.version
		msgToSend.dev_id = gt.getDeviceId()
		gt.socketClient:sendMessage(msgToSend)
		
		gt.guildid = self.guild_id
		gt.guildtype = 1
		gt.showLoadingTips(gt.getLocationString("LTKey_0006"))
	end
	self.enterRoom = enterRoom
	
end

function Match:initSettingView()
	self.pSetting = gt.seekNodeByName(self.csbNode, "Panel_Setting")
	if self.pSetting then
		self.pSetting:setVisible(false)
		self.pSetting:addClickEventListener(function(sender)
			sender:setVisible(false)
		end)
	end

	local Node_Top_Right = self.pSetting:getChildByName("Node_Top_Right")

	-- 解散俱乐部
	local btnDismiss = Node_Top_Right:getChildByName("Btn_Dismiss")
	gt.addBtnPressedListener(btnDismiss, function()
		require("app/views/NoticeTips"):create("提示", "是否确定解散俱乐部", function()
			self:request(gt.DISMISS_GUILD, self.guild_id)
		end, nil, false)
		
		self.pSetting:setVisible(false)
	end)
	-- 俱乐部更名
	local btnRename = Node_Top_Right:getChildByName("Btn_Rename")
	gt.addBtnPressedListener(btnRename, function()
		local view = require("app/views/Guild/GuildInput"):create("guild_rename", self.guild_id)
		if self.m_parent then
			self.m_parent:addChild(view)
		else
			self:addChild(view)
		end
		self.pSetting:setVisible(false)
	end)
	-- 退出俱乐部
	local btnExit = Node_Top_Right:getChildByName("Btn_Exit")
	gt.addBtnPressedListener(btnExit, function()
		require("app/views/NoticeTips"):create("提示", "是否确定退出俱乐部，所有数据将清空包括剩余积分。", function()  --#8FFF00
			self:request(gt.EXIT_GUILD, self.guild_id)
		end, nil, false, false, cc.c3b(182,132,205))
		self.pSetting:setVisible(false)
	end)
end

function Match:onTransGuild(guild_id, owner_id) 
	if guild_id == self.guild_id then
		gt.guildManager:setGuildOwner(guild_id, owner_id)
		self.btnAdminSetting:setVisible(false)
		self.btnUpgradeUnion:setVisible(false)
		self.btnPartnerDetail:setVisible(false)
		self.btnPartnerAdmin:setVisible(false)
		-- self:showPanel(1)
		if self.m_parent then
			self.m_parent:close()
		end
	end
end

function Match:screenAdaptive()
	
	--俱乐部房间列表 宽度 适配
	self.pRooms = gt.seekNodeByName(self.csbNode, "Panel_Rooms")
	self.lstRooms = self.pRooms:getChildByName("List_Rooms")
	local roomListSize = self.lstRooms:getContentSize()
	roomListSize.width = roomListSize.width + (gt.winSize.width - 1280)
	self.lstRooms:setContentSize(roomListSize)
	
	
	--右边成员内容 高度 适配
	self.pMember = gt.seekNodeByName(self.csbNode, "Panel_Member")
	local memberSize = self.pMember:getContentSize()
	memberSize.height = memberSize.height + (gt.winSize.height - 720)
	self.pMember:setContentSize(memberSize)
	
	--右边列表列标题 宽度 适配
	local lstMembersTitle = self.pMember:getChildByName("Panel_HeadTitle")
	local lstMembersTitleSize = lstMembersTitle:getContentSize()
	lstMembersTitleSize.width = lstMembersTitleSize.width + (gt.winSize.width - 1280)
	lstMembersTitle:setContentSize(lstMembersTitleSize)
	
	--右边列表 宽+高适配
	self.lstMembers = self.pMember:getChildByName("List_Members")
	local lstMembersSize = self.lstMembers:getContentSize()
	lstMembersSize.width = lstMembersSize.width + (gt.winSize.width - 1280)
	lstMembersSize.height = lstMembersSize.height + (gt.winSize.height - 720)
	self.lstMembers:setContentSize(lstMembersSize)
		
	--右边成员列表项 宽度适配
	self.pMemberTemplate = self.lstMembers:getChildByName("Panel_Template")
	local memberTempSize = self.pMemberTemplate:getContentSize()
	memberTempSize.width = memberTempSize.width + (gt.winSize.width - 1280)
	self.pMemberTemplate:setContentSize(memberTempSize)
	
	
	--右边排行列表 高度全屏适配
	self.pRank = gt.seekNodeByName(self.csbNode, "Panel_Rank")
	self.rankSize = self.pRank:getContentSize()
	self.rankSize.height = self.rankSize.height + (gt.winSize.height - 720)
	self.pRank:setContentSize(self.rankSize)
	
	--右边列表列标题 宽度 适配
	local lstRankTitle = self.pRank:getChildByName("Panel_HeadTitle")
	local lstRankTitleSize = lstRankTitle:getContentSize()
	lstRankTitleSize.width = lstRankTitleSize.width + (gt.winSize.width - 1280)
	lstRankTitle:setContentSize(lstRankTitleSize)
	
	--右边列表 宽+高适配
	self.lstRanks = self.pRank:getChildByName("List_Ranks")
	local lstRankSize = self.lstRanks:getContentSize()
	lstRankSize.width = lstRankSize.width + (gt.winSize.width - 1280)
	lstRankSize.height = lstRankSize.height + (gt.winSize.height - 720)
	self.lstRanks:setContentSize(lstRankSize)
		
	--右边成员列表项 宽度适配
	self.pRankTemplate = self.lstRanks:getChildByName("Panel_Template")
	local rankTempSize = self.pRankTemplate:getContentSize()
	rankTempSize.width = rankTempSize.width + (gt.winSize.width - 1280)
	self.pRankTemplate:setContentSize(rankTempSize)
	
	ccui.Helper:doLayout(self.csbNode)
end
function Match:initListUI()

	local function onAddScore(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		local view = require("app/views/Guild/GuildNumberPad"):create("add_score", self.guild_id, sender:getTag())
		if self.m_parent then
			self.m_parent:addChild(view)
		else
			self:addChild(view)
		end
	end	
	self.onAddScore = onAddScore

	local function onMinusScore(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		local curScore = 0
		local curId = sender:getTag()
		for i, v in ipairs(self.ranksData) do
			if v.id == curId then
				curScore = v.score
			end
		end
		if curScore > 0 then
			local view = require("app/views/Guild/GuildNumberPad"):create("minus_score", self.guild_id, curId ,nil,curScore )
			if self.m_parent then
				self.m_parent:addChild(view)
			else
				self:addChild(view)
			end
		else
			require("app/views/NoticeTips"):create("提示", "当前玩家已没有积分", nil, nil, true)
		end
	end
	self.onMinusScore = onMinusScore

	local function onResetScore(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		local target_id = sender:getTag()
		local str = string.format("是否确定将玩家ID:%d的积分清零?", target_id)
		require("app/views/NoticeTips"):create("提示", str, function()
			local msgToSend = {}
			msgToSend.cmd = gt.MATCH_SCORE
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.target_id = target_id
			msgToSend.guild_id = self.guild_id
			msgToSend.score = 0
			gt.socketClient:sendMessage(msgToSend)
			gt.showLoadingTips("")
		end, nil, false)
	end
	self.onResetScore = onResetScore

	-- lists
	--self.lstRooms = self.pRooms:getChildByName("List_Rooms")
	self.pRoomTemplate = self.lstRooms:getChildByName("Panel_Template")
	self.pRoomTemplate:retain()
	self.lstRooms:removeAllChildren()
	self.playerHeadMgr:detachAll()

	--self.lstMembers = self.pMember:getChildByName("List_Members")
	--self.pMemberTemplate = self.lstMembers:getChildByName("Panel_Template")
	self.pMemberTemplate:retain()
	self.lstMembers:removeAllChildren()


	--成员列表的辅助工具    
    if cc.exports.ListViewHelper == nil then
        require "app/ListViewHelper"
    end
    --创建列表item的函数
    if self.listMem_helper == nil then
        local create_item_func = function (v, i, cached_item)
            local item = self:CreateMemItem(v, i, cached_item or self.pMemberTemplate:clone())
            return item
        end

        self.listMem_helper = ListViewHelper:create(self.lstMembers, self.pMemberTemplate, create_item_func, true)
    end

	--self.lstRanks = self.pRank:getChildByName("List_Ranks")
	--self.pRankTemplate = self.lstRanks:getChildByName("Panel_Template")
	self.pRankTemplate:retain()
	self.lstRanks:removeAllChildren()

    if self.listRank_helper == nil then
        local create_item_func = function (v, i, cached_item)
            local item = self:CreateRankItem(v, i, cached_item or self.pRankTemplate:clone())
            return item
        end
	
        self.listRank_helper = ListViewHelper:create(self.lstRanks, self.pRankTemplate, create_item_func, true)
    end

end

function Match:CreateMemItem(v, i, pItem)
	local nickName = gt.checkName(v.nick, 5)
	--gt.log("---------------------------："..nickName)
	local lblNick = pItem:getChildByName("Label_Nick")
	-- lblNick:getVirtualRenderer():setLineBreakWithoutSpace(true)
	lblNick:setString(" ")
	lblNick:setString(nickName)
	pItem:getChildByName("Label_ID"):setString(tostring(v.id))
	pItem:getChildByName("Label_Win"):setString(tostring(v.win))
--[[	pItem:getChildByName("Label_S100"):setString(tostring(v.s100))
	pItem:getChildByName("Label_S300"):setString(tostring(v.s300))
	pItem:getChildByName("Label_S500"):setString(tostring(v.s500))--]]
	pItem:getChildByName("Label_Score"):setString(tostring(v.score))
	pItem:setTag(v.id)
	
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

function Match:CreateRankItem(v, i, pItem)
	pItem:getChildByName("Label_Nick"):setString(" ")
	pItem:getChildByName("Label_Nick"):setString(gt.checkName(v.nick, 5))
	pItem:getChildByName("Label_ID"):setString(gt.commonTool:hideText(v.id, self.isShowId))
	pItem:getChildByName("Label_Win"):setString(tostring(v.win))
--[[	pItem:getChildByName("Label_S100"):setString(tostring(v.s100))
	pItem:getChildByName("Label_S300"):setString(tostring(v.s300))
	pItem:getChildByName("Label_S500"):setString(tostring(v.s500))--]]
	pItem:getChildByName("Label_Score"):setString(tostring(v.score))
	pItem:setTag(v.id)

	pItem:getChildByName("Label_Rank"):setString(tostring(v.rank))
	
	return pItem
end

function Match:showGuildMatch(guild_id)
	self.guild_id = guild_id
	local guild = gt.guildManager:getGuild(guild_id)
	self.currentGuild = guild
	self.isShowId = gt.guildManager:isGuildAdmin(guild_id) or gt.guildManager:isGuildOwner(guild_id)
	self:showButtons(guild.owner_id == gt.playerData.uid or guild.admin)
	self:refreshGuildPartnerView()
	self.btnAdminSetting:setVisible(gt.guildManager:isGuildOwner(guild_id))
	self.btnUpgradeUnion:setVisible(gt.guildManager:isGuildOwner(guild_id))

	self:showPanel(1)
	self:setVisible(true)

	self:checkGuide()
end

function Match:checkGuide()
	self.ImgGuide1:setVisible(false)
	self.ImgGuide2:setVisible(false)
	
	local guild = gt.guildManager:getGuild(self.guild_id)
	if guild.owner_id == gt.playerData.uid then
		local guideIndex = cc.UserDefault:getInstance():getIntegerForKey("guildGuide", 0)
		if guideIndex == 0 then
			self:setGuideVisable(self.ImgGuide1,true)
		elseif guideIndex == 6 then
			self:setGuideVisable(self.ImgGuide2,true)
		end
	end
end

function Match:setGuideVisable(sender, isShow,hideValue)
	if isShow then
		gt.scaleNode(sender)
	else
		if cc.UserDefault:getInstance():getIntegerForKey("guildGuide", 0) == hideValue - 1  then
			cc.UserDefault:getInstance():setIntegerForKey("guildGuide", hideValue)
		end
		self:checkGuide()
		sender:stopAllActions()
	end
	sender:setVisible(isShow)
end

function Match:showButtons(visible)
	self.btnLimit:setVisible(visible)
	self.btnSetting:setVisible(visible)
	self.btnMembers:setVisible(visible)
	self.btnCreateRoom:setVisible(visible)
	self.btnScoreRecord:setVisible(visible)
end

function Match:onNodeEvent(eventName)
	if "enter" == eventName then
		self.scheduleHandler = gt.scheduler:scheduleScriptFunc(handler(self, self.update), 1, false)
	elseif "exit" == eventName then
		-- self.playerHeadMgr:detachAll()

		if self.scheduleHandler then
			gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
			self.scheduleHandler = 0
		end

		gt.socketClient:unregisterMsgListener(gt.MATCH_ROOM)
		gt.socketClient:unregisterMsgListener(gt.MATCH_RANK)
		gt.socketClient:unregisterMsgListener(gt.MATCH_SCORE)


		if self.listMem_helper then
            self.listMem_helper:Release()
            self.listMem_helper = nil
        end
		if self.listRank_helper then
            self.listRank_helper:Release()
            self.listRank_helper = nil
        end

  --       if self.schedule_ListMem then
		-- 	gt.scheduler:unscheduleScriptEntry(self.schedule_ListMem)
		-- 	self.schedule_ListMem = nil
		-- end

		self.pRoomTemplate:release()
		self.pMemberTemplate:release()
		self.pRankTemplate:release()
	end
end

function Match:update(dt)
	-- 刷新比赛房间
	self.refreshTime = self.refreshTime + dt
	if self.refreshTime > 10 and self:isVisible() and self.pRooms:isVisible() then
		self:request(gt.MATCH_ROOM)
		self.refreshTime = 0
	end
end

function Match:showPanel(idx)
	local panels = {self.pRooms, self.pMember, self.pRank}
	for i = 1, 3 do
		panels[i]:setVisible(i == idx)
	end
	self.Node_Bottom_Right:setVisible(1 == idx)	

	if idx == 1 then
		self:request(gt.MATCH_ROOM)
	else
		self:request(gt.MATCH_RANK)
	end
end				 



function Match:request(cmd, tp)
	local msgToSend = {}
	msgToSend.cmd = cmd
	msgToSend.user_id = gt.playerData.uid
	msgToSend.open_id = gt.playerData.openid
	msgToSend.guild_id = self.guild_id
	if tp then
		msgToSend.tp = tp
	end
	gt.socketClient:sendMessage(msgToSend)
	gt.showLoadingTips("")
	self.refreshTime = 0
end

function Match:getPlayersData(datas,index_)
	local playerUid = 0
	local data_ = nil
	local i = 1;
	for k,v in pairs(datas) do
		if i == index_ then
			playerUid = k
			data_ = v
		end
		i = i+1
	end
	return playerUid,data_
end

function Match:onRcvMatchRoom(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.guild_id ~= self.guild_id then
		return
	end


	self.lstRooms:removeAllChildren()
	self.playerHeadMgr:detachAll()

	local itemBase 
	local pItem 

	local guildRoomsData = msgTbl.rooms
	if #guildRoomsData > 0 then
		table.sort(guildRoomsData, function( a, b)
						if a.c_time and b.c_time then
							return a.c_time > b.c_time
						else
							return false
						end
					end)
	end


	for i, v in ipairs(guildRoomsData) do
		-- local pItem = self.pRoomTemplate:clone()
		if i % 2 == 1 then
			itemBase = self.pRoomTemplate:clone()
			self.lstRooms:pushBackCustomItem(itemBase)
			pItem = itemBase:getChildByName("panelItem0")
		else
			pItem = itemBase:getChildByName("panelItem1")
			pItem:setVisible(true)
		end

		local par = json.decode(v.kwargs)
		-- 房号
		pItem:getChildByName("Label_RoomId"):setString(tostring(v.id))
		-- 玩法
		local strGameId = gt.getGameIdDesc(par)
		
		pItem:getChildByName("Label_PlayType"):setString(gt.getGameTypeDesc(par.game_id, par.game_type) .. "[" .. strGameId .. "]")
		-- 局数/人数
		-- pItem:getChildByName("Label_Round"):setString(string.format("%d/%d局\n%d/%d人",v.round, par.rounds, v.player_count, par.max_chairs))
		pItem:getChildByName("Label_Round"):setString(string.format("%d/%d局",v.round, par.rounds))

		--癞子玩法
		local Image_MagicCardFlag = pItem:getChildByName("Image_MagicCardFlag")
		if not par.laizi or 0 == par.laizi then
			Image_MagicCardFlag:setVisible(false)
		else
			Image_MagicCardFlag:setVisible(true)
			if 1 == par.laizi then
				Image_MagicCardFlag:loadTexture("image/guild/magicCard.png")
			elseif 2 == par.laizi then
				Image_MagicCardFlag:loadTexture("image/guild/magicCardCrazy.png")
			end
		end

		-- 付费
		local desc = ""
		local room_card = gt.getRoomCardConsume(par.game_id, par.pay, par.rounds, par.max_chairs)
		if par.pay == 1 then
			desc = "房主付费" .. string.format(" %d房卡", room_card)
		else
			desc = "AA付费" .. string.format(" %d房卡", room_card)
		end
		pItem:getChildByName("Label_Consume"):setString(desc)

		pItem:setTag(v.id)
		pItem:addClickEventListener(self.enterRoom)

		--desktop
		local imgDeskTop6 = pItem:getChildByName("imgDeskTop6")
		local imgDeskTop8 = pItem:getChildByName("imgDeskTop8")
		local imgDeskTop10 = pItem:getChildByName("imgDeskTop10")
		local imgDeskTop12 = pItem:getChildByName("imgDeskTop12")
		local curDeskTop = imgDeskTop6
		imgDeskTop6:setVisible(false)
		imgDeskTop8:setVisible(false)
		imgDeskTop10:setVisible(false)
		imgDeskTop12:setVisible(false)
		if par.max_chairs == 6 then
			curDeskTop = imgDeskTop6
		elseif par.max_chairs == 8 then
			curDeskTop = imgDeskTop8
		elseif par.max_chairs == 10 then
			curDeskTop = imgDeskTop10
		elseif par.max_chairs == 12 then
			curDeskTop = imgDeskTop12
		end
		curDeskTop:setVisible(true)

		for i = 1, par.max_chairs do
			local imgHead = curDeskTop:getChildByName("imgHead"..i)
			if imgHead then
				--TEST TODO
				-- if i <=  (index % par.max_chairs) then
				if i <=  v.player_count then
					imgHead:setVisible(true)

					local playerUid,playerData = self:getPlayersData(v.players,i)
					local playerPar = json.decode(playerData)
					if playerData and playerPar.icon ~= "" then
					    self.playerHeadMgr:attach(imgHead, playerUid, playerPar.icon)
				    end

					imgHead:setTouchEnabled(true)
					imgHead:addClickEventListener(function()
				        gt.soundEngine:playEffect(gt.clickBtnAudio, false)
				        local playData_ = {}
				        playData_.uid = playerUid
				        playData_.sex = playerPar.sex
				        playData_.nickname = playerPar.nick
				        -- playData_.ip = playerPar.ip
				        playData_.game_count = playerPar.game_count
				        playData_.reg_time = playerPar.reg_time
				        gt.dump(playData_)

						local playerInfoTips = require("app/views/PlayerInfoTips"):create(playData_, 1)
						self:addChild(playerInfoTips)
					end)
				else
					imgHead:setVisible(false)
				end
			end
		end

	end
	local guild = gt.guildManager:getGuild(self.guild_id)
	if guild then
		self:showButtons(guild.owner_id == gt.playerData.uid or msgTbl.admin)
		self.Label_EmojiCost:setString("昨日表情消耗:".. tostring(msgTbl.out_dividend_score))
	end
	self:refreshGuildPartnerView()
end

function Match:onRcvMatchRank(msgTbl)
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
		if self.pRank:isVisible() then
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

		 	self.listRank_helper:SetItemsData({})
		    local delay_call = function ()
		    	self.listRank_helper:SetItemsData(self.ranksData, true)
		    	self:updateTotalScore()
		    end
		    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
			-- self:refreshListRank()
		else
			-- self:refreshListMember()

		 	self.listMem_helper:SetItemsData({})
		    local delay_call = function ()
		    	self.listMem_helper:SetItemsData(self.ranksData, true)
		    	self:updateTotalScore()
		    end
		    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))

		end
	end
end

function Match:refreshListRank()

	self.lstRanks:removeAllChildren()
	for i, v in ipairs(self.ranksData) do
		local pItem = self.pRankTemplate:clone()
		pItem:getChildByName("Label_Nick"):setString(gt.checkName(v.nick, 5))
		pItem:getChildByName("Label_ID"):setString(tostring(v.id))
		pItem:getChildByName("Label_Win"):setString(tostring(v.win))
--[[		pItem:getChildByName("Label_S100"):setString(tostring(v.s100))
		pItem:getChildByName("Label_S300"):setString(tostring(v.s300))
		pItem:getChildByName("Label_S500"):setString(tostring(v.s500))--]]
		pItem:getChildByName("Label_Score"):setString(tostring(v.score))
		pItem:setTag(v.id)
		
		pItem:getChildByName("Label_Rank"):setString(tostring(i))
		
		self.lstRanks:pushBackCustomItem(pItem)
	end
end

function Match:refreshListMember()
	
	self.lstMembers:removeAllChildren()

	local count = #self.ranksData

	-- if self.schedule_ListMem then
	-- 	gt.scheduler:unscheduleScriptEntry(self.schedule_ListMem)
	-- 	self.schedule_ListMem = nil
	-- end
	-- if count > 0 then
	-- 	self.lstMemIndex = 1

	-- 	if self.schedule_handle == nil then
	-- 		local function update_func(dt_)
	-- 			local count_ = #self.ranksData
	-- 			gt.log("---update:"..self.lstMemIndex)
	-- 			if self.lstMemIndex > count_ then
	-- 				gt.scheduler:unscheduleScriptEntry(self.schedule_ListMem)
	-- 				self.schedule_ListMem = nil
	-- 				self:updateTotalScore()
	-- 			else
	-- 				local v = self.ranksData[self.lstMemIndex]
	-- 				if v then
	-- 					local pItem = self.pMemberTemplate:clone()
	-- 					pItem:getChildByName("Label_Nick"):setString(gt.checkName(v.nick, 5))
	-- 					pItem:getChildByName("Label_ID"):setString(tostring(v.id))
	-- 					pItem:getChildByName("Label_Win"):setString(tostring(v.win))
	-- 					pItem:getChildByName("Label_S100"):setString(tostring(v.s100))
	-- 					pItem:getChildByName("Label_S300"):setString(tostring(v.s300))
	-- 					pItem:getChildByName("Label_S500"):setString(tostring(v.s500))
	-- 					pItem:getChildByName("Label_Score"):setString(tostring(v.score))
	-- 					pItem:setTag(v.id)
						
	-- 					local btnAdd = pItem:getChildByName("Btn_Add")
	-- 					btnAdd:setTag(v.id)
	-- 					btnAdd:addClickEventListener(self.onAddScore)

	-- 					local btnReset = pItem:getChildByName("Btn_Reset")
	-- 					btnReset:setTag(v.id)
	-- 					btnReset:addClickEventListener(self.onResetScore)

	-- 					local btnMinus = pItem:getChildByName("Btn_Minus")
	-- 					if btnMinus then
	-- 						btnMinus:setTag(v.id)
	-- 						btnMinus:addClickEventListener(self.onMinusScore)
	-- 					end

	-- 					self.lstMembers:pushBackCustomItem(pItem)
	-- 					self.lstMemIndex = self.lstMemIndex + 1
	-- 				end
	-- 			end
	-- 		end
	-- 		self.schedule_ListMem = gt.scheduler:scheduleScriptFunc(update_func, 0.001, false)
	-- 	end

	-- end

	for i = 1, count do
		local v = self.ranksData[i]

		local pItem = self.pMemberTemplate:clone()
		pItem:getChildByName("Label_Nick"):setString(gt.checkName(v.nick, 5))
		pItem:getChildByName("Label_ID"):setString(tostring(v.id))
		pItem:getChildByName("Label_Win"):setString(tostring(v.win))
--[[		pItem:getChildByName("Label_S100"):setString(tostring(v.s100))
		pItem:getChildByName("Label_S300"):setString(tostring(v.s300))
		pItem:getChildByName("Label_S500"):setString(tostring(v.s500))--]]
		pItem:getChildByName("Label_Score"):setString(tostring(v.score))
		pItem:setTag(v.id)
		
		local btnAdd = pItem:getChildByName("Btn_Add")
		btnAdd:setTag(v.id)
		btnAdd:addClickEventListener(self.onAddScore)

		local btnReset = pItem:getChildByName("Btn_Reset")
		btnReset:setTag(v.id)
		btnReset:addClickEventListener(self.onResetScore)

		local btnMinus = pItem:getChildByName("Btn_Minus")
		if btnMinus then
			btnMinus:setTag(v.id)
			btnMinus:addClickEventListener(self.onMinusScore)
		end

		self.lstMembers:pushBackCustomItem(pItem)
	end
	self:updateTotalScore()

end


function Match:onRcvMatchScore(msgTbl)
	
	if msgTbl.code == 0 then
		gt.removeLoadingTips()

		-- for i, v in ipairs(self.ranksData) do
		-- 	if v.id == msgTbl.target_id then
		-- 		v.score = msgTbl.score
		-- 	end
		-- end

		-- local children = self.lstMembers:getChildren()
		-- for i, child in ipairs(children) do
		-- 	if child:getTag() == msgTbl.target_id then
		-- 		child:getChildByName("Label_Score"):setString(tostring(msgTbl.score))
		-- 		if msgTbl.score == 0 then
		-- 			child:getChildByName("Label_Win"):setString("0")
		-- 			child:getChildByName("Label_S100"):setString("0")
		-- 			child:getChildByName("Label_S300"):setString("0")
		-- 			child:getChildByName("Label_S500"):setString("0")
		-- 		end
		-- 		self:updateTotalScore()
		-- 		break
		-- 	end
		-- end
		
		local index_ = 0
		for i, v in ipairs(self.ranksData) do
			if v.id == msgTbl.target_id then
				v.score = msgTbl.score
				index_ = i
			end
		end
		if self.isSearchState then
			index_ = 1
		end
		local item = self.listMem_helper:GetItem(index_)
		if item then
			item:getChildByName("Label_Score"):setString(tostring(msgTbl.score))
			require("app/views/CommonTips"):create("操作成功", 2)

		end

		self:updateTotalScore()

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
				self:request(gt.MATCH_RANK)
			end, nil, true)
	elseif msgTbl.code == 5 then
		gt.removeLoadingTips()
		require("app/views/NoticeTips"):create("提示", "操作失败，玩家积分已超过上限", nil, nil, true)
		
	end
end

function Match:searchUser(user_id)
	local children = self.lstMembers:getChildren()
	local find = false
	local index_ = 0
	for i, v in ipairs(self.ranksData) do
		if v.id == user_id then
			index_ = i
			find = true
		end
	end

	if find and self.ranksData[index_] then
		-- local item = self.listMem_helper:GetItem(index_)
		-- if item then
		-- 	local index = self.lstMembers:getIndex(item)
		-- 	self.lstMembers:scrollToItem(index, cc.p(0.5, 0.5), cc.p(0.5, 0.5))
		-- end

		self.listMem_helper:SetItemsData({})
	    local delay_call = function ()
	    	self.listMem_helper:SetItemsData({self.ranksData[index_]}, true)
	    	self:refreshMemSearchState(true)
	    end
	    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))



	end


	-- for i, child in ipairs(children) do
	-- 	local uid = child:getChildByName("Label_ID"):getString()
	-- 	if tonumber(uid) == user_id then
	-- 		child:getChildByName("Img_Bg"):setColor(cc.c3b(0,192,192))
	-- 		local index = self.lstMembers:getIndex(child)
	-- 		self.lstMembers:scrollToItem(index, cc.p(0.5, 0.5), cc.p(0.5, 0.5))
	-- 		find = true
	-- 	else
	-- 		child:getChildByName("Img_Bg"):setColor(cc.c3b(255,255,255))
	-- 	end
	-- end
	if not find then
		require("app/views/NoticeTips"):create("提示", "查无此玩家", nil, nil, true)
	end
end

function Match:refreshMemSearchState(curState_)
	self.isSearchState = curState_
	if self.isSearchState then
		gt.seekNodeByName(self.pMember, "Label_Search"):setString("查看所有")
	else

		gt.seekNodeByName(self.pMember, "Label_Search"):setString("快速查询")
	end
end

function Match:refreshGuildPartnerView()
	self.btnPartnerAdmin:setVisible(false)
	self.btnPartnerDetail:setVisible(false)
	self.btnInvite:setVisible(false)

	local guild = gt.guildManager:getGuild(self.guild_id)
	if guild then
		if guild.owner_id == gt.playerData.uid or guild.admin then  -- 会长 或者 管理员
			self.btnPartnerAdmin:setVisible(true)
			self.btnInvite:setVisible(true)
		elseif guild.partner then
			self.btnPartnerDetail:setVisible(true)	
			self.btnInvite:setVisible(true)
		end
	end

end

function Match:updateTotalScore()
	local sum = 0
	-- local children = self.lstMembers:getChildren()

	for i, v in ipairs(self.ranksData) do
		sum = sum + tonumber(v.score)
	end
	gt.seekNodeByName(self.pMember, "Label_TotalScore"):setVisible(true)
	gt.seekNodeByName(self.pMember, "Label_TotalScore"):setString("积分池:  "..tostring(sum))
end


return Match
