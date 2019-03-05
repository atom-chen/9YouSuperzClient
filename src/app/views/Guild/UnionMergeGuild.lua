-- 合并俱乐部界面

local gt = cc.exports.gt

local UnionMergeGuild = class("UnionMergeGuild", function()
	return gt.createMaskLayer()
end)

function UnionMergeGuild:ctor(union_id)
	local csbNode = cc.CSLoader:createNode("csd/Guild/UnionMergeGuild.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	gt.log("-----openUI:UnionMergeGuild")
	self.union_id = union_id
	
	self:initUI()
	
	local msgToSend = {}
	msgToSend.cmd = gt.UNION_MERGE_LIST
	msgToSend.user_id = gt.playerData.uid
	msgToSend.open_id = gt.playerData.openid
	msgToSend.union_id = self.union_id
	gt.socketClient:sendMessage(msgToSend)
			
	gt.socketClient:registerMsgListener(gt.UNION_MERGE_LIST, self, self.onRcvGuildMergeList)
	gt.socketClient:registerMsgListener(gt.UNION_MERGE, self, self.onRcvGuildMerge)
end

function UnionMergeGuild:initUI()
	self.Image_GuildSelectBg = self.csbNode:getChildByName("Image_GuildSelectBg")
	self.Image_ConfirmTipsBg = self.csbNode:getChildByName("Image_ConfirmTipsBg")
	self.Image_ConfirmTipsBg:setVisible(false)
	local Image_ExplainBg = self.csbNode:getChildByName("Image_ExplainBg")
	Image_ExplainBg:setVisible(false)
	local Image_mask = self.csbNode:getChildByName("Image_mask")
	Image_mask:setVisible(false)
	
	self.guildListView = gt.seekNodeByName(self.csbNode, "ListView_GuildSelect")
	self.rowTemplate = self.guildListView:getChildByName("Layout_Row")
	self.rowTemplate:retain()
	self.guildListView:removeAllChildren()
	self.btnSelectTable = {}
	self.curSelectIndex = nil
	
	self.Image_GuildItemBg = self.Image_ConfirmTipsBg:getChildByName("Image_GuildItemBg")
	self.imageGuildHead = self.Image_GuildItemBg:getChildByName("Image_Head")
	self.guildHeadPos = cc.p(self.imageGuildHead:getPosition())
	self.imageGuildHead:retain()
	
	self.imageGuildHead:removeFromParent()

	-- 头像下载管理器
	local playerHeadMgr = require("app/PlayerHeadManager"):create()
	self.csbNode:addChild(playerHeadMgr)
	self.playerHeadMgr = playerHeadMgr

	local stencil = cc.Sprite:create("image/guild/bigUnion/MergeGuild/clipper.png")
	local clipper = cc.ClippingNode:create()
	clipper:setStencil(stencil)
	clipper:setInverted(true)
	clipper:setAlphaThreshold(0)

	self.Image_GuildItemBg:addChild(clipper)
	clipper:setPosition(self.guildHeadPos)
	clipper:addChild(self.imageGuildHead)
	self.imageGuildHead:setPosition(cc.p(0,0))
	
	--Image_GuildSelectBg btn
	local btnClose = gt.seekNodeByName(self.csbNode, "Btn_Close")
	gt.addBtnPressedListener(btnClose, function()
		self:close()
	end)
	local btnOK = gt.seekNodeByName(self.csbNode, "Btn_OK")
	gt.addBtnPressedListener(btnOK, function()
		if self.curSelectIndex then
			self:setSelectedGuild(self.guilds[self.curSelectIndex], self.cost)
			self.Image_ConfirmTipsBg:setVisible(true)
			Image_mask:setVisible(true)
		end
	end)
	local btnExplain = gt.seekNodeByName(self.csbNode, "Btn_Explain")
	gt.addBtnPressedListener(btnExplain, function()
		Image_ExplainBg:setVisible(true)
		Image_mask:setVisible(true)
	end)
	
	--Image_ConfirmTipsBg btn
	local btnOKTips = gt.seekNodeByName(self.csbNode, "Btn_OKTips")
	gt.addBtnPressedListener(btnOKTips, function()
		if gt.playerData.roomCardsCount[1] < self.cost then
			self:close()
			require("app/views/NoticeTips"):create("合并俱乐部", "操作失败,房卡不足！", nil, nil, true)
		else
			local msgToSend = {}
			msgToSend.cmd = gt.UNION_MERGE
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.guild_id = self.guilds[self.curSelectIndex].id
			msgToSend.union_id = self.union_id
			msgToSend.cost = self.cost
			msgToSend.ignore_partner = 0
			gt.socketClient:sendMessage(msgToSend)
			
			self.Image_ConfirmTipsBg:setVisible(false)
			Image_mask:setVisible(false)
		end
	end)
	local btnCancelTips = gt.seekNodeByName(self.csbNode, "Btn_CancelTips")
	gt.addBtnPressedListener(btnCancelTips, function()
		self.Image_ConfirmTipsBg:setVisible(false)
		Image_mask:setVisible(false)
	end)
	
	--Image_ExplainBg btn
	local btnCloseExplain = gt.seekNodeByName(self.csbNode, "Btn_CloseExplain")
	gt.addBtnPressedListener(btnCloseExplain, function()
		Image_ExplainBg:setVisible(false)
		Image_mask:setVisible(false)
	end)
end

function UnionMergeGuild:onRcvGuildMergeList(msgTbl)
	if 0 == msgTbl.code then
		self.cost = msgTbl.cost
		if msgTbl.guilds and (0 < #msgTbl.guilds) then
			self.guilds = msgTbl.guilds
			self.Image_GuildSelectBg:getChildByName("Text_NoGuildTip"):setVisible(false)
			
			table.sort(self.guilds, function( a, b)
				return a.member_num > b.member_num
			end)
			self:initGuildList()
		else
			self.Image_GuildSelectBg:getChildByName("Text_NoGuildTip"):setVisible(true)
			gt.seekNodeByName(self.csbNode, "ListView_GuildSelect"):setVisible(false)
		end
	elseif 1 == msgTbl.code then
		self:close()
		require("app/views/NoticeTips"):create("合并俱乐部", "该大联盟不存在！", nil, nil, true)
	elseif 2 == msgTbl.code then
		self:close()
		require("app/views/NoticeTips"):create("合并俱乐部", "该ID不是大联盟！", nil, nil, true)
	elseif 3 == msgTbl.code then
		self:close()
		require("app/views/NoticeTips"):create("合并俱乐部", "您不是会长，无此权限！", nil, nil, true)
	end
end

function UnionMergeGuild:onRcvGuildMerge(msgTbl)
	
	if 10 == msgTbl.code then
		
		local function okFunc()
			local msgToSend = {}
			msgToSend.cmd = gt.UNION_MERGE
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.guild_id = self.guilds[self.curSelectIndex].id
			msgToSend.union_id = self.union_id
			msgToSend.cost = self.cost
			msgToSend.ignore_partner = 1
			gt.socketClient:sendMessage(msgToSend)
		end
		local function cancelFunc()
			self:close()
		end
	
		local tipStr = string.format("由于合伙人达到200人上限，您本次合并将会有%s个合伙人无法成为该联盟合伙人，若要继续合并，将会被当做普通成员拉进联盟",msgTbl.not_merge_partner_num)
		require("app/views/NoticeTips"):create("合并俱乐部", tipStr, okFunc, cancelFunc, false)
	else
		self:close()
		if 0 == msgTbl.code then
			local noticeStr = "恭喜，合并成功"
			require("app/views/NoticeTips"):create("合并俱乐部", noticeStr, nil, nil, true)	
		elseif 1 == msgTbl.code then
			require("app/views/NoticeTips"):create("合并俱乐部", "联盟不存在", nil, nil, true)
		elseif 2 == msgTbl.code then
			require("app/views/NoticeTips"):create("合并俱乐部", "俱乐部不存在", nil, nil, true)
		elseif 3 == msgTbl.code then
			require("app/views/NoticeTips"):create("合并俱乐部", "您不是联盟管理员，无此权限！", nil, nil, true)
		elseif 4 == msgTbl.code then
			require("app/views/NoticeTips"):create("合并俱乐部", "您不是俱乐部管理员，无此权限！", nil, nil, true)
		elseif 5 == msgTbl.code then
			require("app/views/NoticeTips"):create("合并俱乐部", "房卡消耗有变动！", nil, nil, true)
		elseif 6 == msgTbl.code then
			require("app/views/NoticeTips"):create("合并俱乐部", "联盟ID错误！", nil, nil, true)
		elseif 7 == msgTbl.code then
			require("app/views/NoticeTips"):create("合并俱乐部", "俱乐部ID错误", nil, nil, true)
		elseif 8 == msgTbl.code then
			require("app/views/NoticeTips"):create("合并俱乐部", "人数超过上限", nil, nil, true)
		elseif 9 == msgTbl.code then
			require("app/views/NoticeTips"):create("合并俱乐部", "钱不够，老板快去冲钱", nil, nil, true)
		end
	end
end

function UnionMergeGuild:initGuildList()
	local guildNum = #self.guilds
	for index = 1, guildNum, 2 do
		if index+1 > guildNum then
			self:createGulidRow(self.rowTemplate:clone(), index, {self.guilds[index]})
		else
			self:createGulidRow(self.rowTemplate:clone(), index, {self.guilds[index], self.guilds[index+1]})
		end
	end
	
	self:setSelectItem(1)
end
	
function UnionMergeGuild:createGulidRow(rowNode, index, guildDataS)
	for i, guildData in ipairs(guildDataS) do
		local guildItemNode = rowNode:getChildByName("guildItemBg"..i)
		gt.seekNodeByName(guildItemNode, "Label_Name"):setString(tostring(guildData.name))
		gt.seekNodeByName(guildItemNode, "Label_ID"):setString(tostring(guildData.id))
		
		local imageGuildHead = guildItemNode:getChildByName("Image_Head")
		local oldPosX,oldPosY = imageGuildHead:getPosition()
		imageGuildHead:removeFromParent()

		local stencil = cc.Sprite:create("image/guild/bigUnion/MergeGuild/clipper.png")
		local clipper = cc.ClippingNode:create()
		clipper:setStencil(stencil)
		clipper:setInverted(true)
		clipper:setAlphaThreshold(0)

		guildItemNode:addChild(clipper)
		clipper:setPosition(cc.p(oldPosX,oldPosY))
		clipper:addChild(imageGuildHead)
		imageGuildHead:setPosition(cc.p(0,0))

		self.playerHeadMgr:attach(imageGuildHead, gt.playerData.uid, guildData.icon)
		
		local btnSelect= guildItemNode:getChildByName("Button_Select")
		btnSelect:setEnabled(true)
		self.btnSelectTable[index+i-1] = btnSelect
		
		guildItemNode:setTag(guildData.id)
		gt.addBtnPressedListener(guildItemNode, function()
			self:setSelectItem(index+i-1)
		end)
	end
	if 1 == #guildDataS then
		rowNode:getChildByName("guildItemBg2"):setVisible(false)
	end
	
	self.guildListView:pushBackCustomItem(rowNode)
end

function UnionMergeGuild:setSelectItem(selectedIndex)
	if self.curSelectIndex then
		self.btnSelectTable[self.curSelectIndex]:setEnabled(true)
	end
	self.curSelectIndex = selectedIndex
	self.btnSelectTable[self.curSelectIndex]:setEnabled(false)
end

function UnionMergeGuild:setSelectedGuild(guildData, cost)
	self.Image_ConfirmTipsBg:getChildByName("Text_cardNum"):setString(tostring(cost))
	local Image_GuildItemBg = self.Image_ConfirmTipsBg:getChildByName("Image_GuildItemBg")
	gt.seekNodeByName(Image_GuildItemBg, "Label_Name"):setString(tostring(guildData.name))
	gt.seekNodeByName(Image_GuildItemBg, "Label_ID"):setString(tostring(guildData.id))
	self.playerHeadMgr:attach(self.imageGuildHead, gt.playerData.uid, guildData.icon)
end

function UnionMergeGuild:close()
	self.rowTemplate:release()
	self.imageGuildHead:release()
	self:removeFromParent()
end

return UnionMergeGuild
