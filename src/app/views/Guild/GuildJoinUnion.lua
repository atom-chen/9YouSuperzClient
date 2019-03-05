local gt = cc.exports.gt

local GuildJoinUnion = class("GuildJoinUnion",function()
	return gt.createMaskLayer()
end)

function GuildJoinUnion:ctor(guild_id, closeUpgradeFunc, joinUnionFun)
	local csbNode = cc.CSLoader:createNode("csd/Guild/GuildJoinUnion.csb")
	csbNode:setAnchorPoint(0.5,0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	gt.log("-----openUI:GuildJoinUnion")
	self.guild_id = guild_id
	
	self.closeUpgradeFunc = closeUpgradeFunc
	self.joinUnionFun = joinUnionFun
	
	self.Image_ConfirmTipsBg = self.csbNode:getChildByName("Image_ConfirmTipsBg")
	self.Image_ConfirmTipsBg:setVisible(false)
	local Image_RuleInfoBg = self.csbNode:getChildByName("Image_RuleInfoBg")
	Image_RuleInfoBg:setVisible(false)
	local Image_mask = self.csbNode:getChildByName("Image_mask")
	Image_mask:setVisible(false)
	
	-- 头像下载管理器
	local playerHeadMgr = require("app/PlayerHeadManager"):create()
	self.csbNode:addChild(playerHeadMgr)
	self.playerHeadMgr = playerHeadMgr
	
	--选择层
	local btnClose = gt.seekNodeByName(csbNode,"Btn_Close")
	gt.addBtnPressedListener(btnClose,function()
		self:close()
	end)
	
	local btnRuleInfo = gt.seekNodeByName(csbNode, "Btn_RuleInfo")
	gt.addBtnPressedListener(btnRuleInfo, function()
		Image_RuleInfoBg:setVisible(true)
		Image_mask:setVisible(true)
	end)
	
	local btnConfirm = gt.seekNodeByName(csbNode, "Btn_Confirm")
	gt.addBtnPressedListener(btnConfirm, function()
		if self.unionSelectIndex then
			self:setSelectedUnion(self.unions[self.unionSelectIndex], self.cost)
			self.Image_ConfirmTipsBg:setVisible(true)
			Image_mask:setVisible(true)
		else
			self:close()
		end
	end)
	
	self.unionListView = gt.seekNodeByName(self.csbNode, "ListView_UnionSelect")
	self.rowTemplate = self.unionListView:getChildByName("Layout_Row")
	self.rowTemplate:retain()
	self.unionListView:removeAllChildren()

	self.unionSelectList = {}
	self.unionSelectIndex = nil
	
	gt.seekNodeByName(self.csbNode, "Text_NoUnionTip"):setVisible(false)
	
	
	--规则层
	local btnCloseRuleInfo = gt.seekNodeByName(csbNode, "Btn_CloseRuleInfo")
	gt.addBtnPressedListener(btnCloseRuleInfo, function()
		Image_RuleInfoBg:setVisible(false)
		Image_mask:setVisible(false)
	end)
	
	
	--提示层
	local btnCloseJoinTip = gt.seekNodeByName(csbNode,"Btn_CloseJoinTip")
	gt.addBtnPressedListener(btnCloseJoinTip,function()
		self.Image_ConfirmTipsBg:setVisible(false)
		Image_mask:setVisible(false)
	end)
	local btnCancelTips = gt.seekNodeByName(csbNode,"Btn_CancelTips")
	gt.addBtnPressedListener(btnCancelTips,function()
		self.Image_ConfirmTipsBg:setVisible(false)
		Image_mask:setVisible(false)
	end)
	local btnOKTips = gt.seekNodeByName(self.csbNode, "Btn_OKTips")
	gt.addBtnPressedListener(btnOKTips, function()
		if gt.playerData.roomCardsCount[1] < self.cost then
			self:close()
			require("app/views/NoticeTips"):create("加入大联盟", "操作失败,房卡不足！", nil, nil, true)
		else
			local msgToSend = {}
			msgToSend.cmd = gt.UNION_MERGE
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.guild_id = self.guild_id
			msgToSend.union_id = self.unions[self.unionSelectIndex].id
			msgToSend.cost = self.cost
			msgToSend.ignore_partner = 0
			gt.socketClient:sendMessage(msgToSend)
			
			self.Image_ConfirmTipsBg:setVisible(false)
			Image_mask:setVisible(false)
		end
	end)
	
	
	local msgToSend = {}
	msgToSend.cmd = gt.GUILD_UPDATE_UNION_LIST
	msgToSend.user_id = gt.playerData.uid
	msgToSend.open_id = gt.playerData.openid
	msgToSend.guild_id = self.guild_id
	gt.socketClient:sendMessage(msgToSend)
	
	gt.socketClient:registerMsgListener(gt.GUILD_UPDATE_UNION_LIST, self, self.onRcvJoinUnionList)
	gt.socketClient:registerMsgListener(gt.UNION_MERGE, self, self.onRcvJoinUnion)
end

function GuildJoinUnion:onRcvJoinUnion(msgTbl)
	gt.log("-----test-----onRcvJoinUnion:code"..msgTbl.code)
	if 10 == msgTbl.code then
		local function okFunc()
			local msgToSend = {}
			msgToSend.cmd = gt.UNION_MERGE
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.guild_id = self.guild_id
			msgToSend.union_id = self.unions[self.unionSelectIndex].id
			msgToSend.cost = self.cost
			msgToSend.ignore_partner = 1
			gt.socketClient:sendMessage(msgToSend)
		end
		local function cancelFunc()
			self:close()
		end
		
		local tipStr = string.format("由于合伙人达到200人上限，您本次加入将会有%s个合伙人无法成为该联盟合伙人，若要继续加入，将会被当做普通成员拉进联盟",msgTbl.not_merge_partner_num)
		require("app/views/NoticeTips"):create("加入联盟", tipStr, okFunc, cancelFunc, false)
	else
		if 0 == msgTbl.code and self.closeUpgradeFunc then
			cc.UserDefault:getInstance():setIntegerForKey("unionid"..gt.playerData.uid, self.unions[self.unionSelectIndex].id)
			local joinUnionFun = self.joinUnionFun
			self.closeUpgradeFunc()
			joinUnionFun()
		else
			self:close()
		end
		
		if 0 == msgTbl.code then
			local noticeStr = "恭喜，加入联盟成功"
			require("app/views/NoticeTips"):create("加入联盟", noticeStr, nil, nil, true)	
		elseif 1 == msgTbl.code then
			require("app/views/NoticeTips"):create("加入联盟", "联盟不存在", nil, nil, true)
		elseif 2 == msgTbl.code then
			require("app/views/NoticeTips"):create("加入联盟", "俱乐部不存在", nil, nil, true)
		elseif 3 == msgTbl.code then
			require("app/views/NoticeTips"):create("加入联盟", "您不是联盟管理员，无此权限！", nil, nil, true)
		elseif 4 == msgTbl.code then
			require("app/views/NoticeTips"):create("加入联盟", "您不是俱乐部管理员，无此权限！", nil, nil, true)
		elseif 5 == msgTbl.code then
			require("app/views/NoticeTips"):create("加入联盟", "房卡消耗有变动！", nil, nil, true)
		elseif 6 == msgTbl.code then
			require("app/views/NoticeTips"):create("加入联盟", "联盟ID错误！", nil, nil, true)
		elseif 7 == msgTbl.code then
			require("app/views/NoticeTips"):create("加入联盟", "俱乐部ID错误", nil, nil, true)
		elseif 8 == msgTbl.code then
			require("app/views/NoticeTips"):create("加入联盟", "人数超过上限", nil, nil, true)
		elseif 9 == msgTbl.code then
			require("app/views/NoticeTips"):create("加入联盟", "钱不够，老板快去冲钱", nil, nil, true)
		end
	end
end

function GuildJoinUnion:onRcvJoinUnionList(msgTbl)
	if 0 == msgTbl.code then
		self.cost = msgTbl.cost
		if msgTbl.unions and (0 < #msgTbl.unions) then
			self.unions = msgTbl.unions
			self:showUnionList()
		else
			gt.seekNodeByName(self.csbNode, "Text_NoUnionTip"):setVisible(true)
		end
	elseif 1 == msgTbl.code then
		self:close()
		require("app/views/NoticeTips"):create("加入大联盟", "该俱乐部不存在！", nil, nil, true)
	elseif 2 == msgTbl.code then
		self:close()
		require("app/views/NoticeTips"):create("加入大联盟", "该俱乐部已经是大联盟！", nil, nil, true)
	elseif 3 == msgTbl.code then
		self:close()
		require("app/views/NoticeTips"):create("加入大联盟", "您不是俱乐部会长，无此权限！", nil, nil, true)
	end
end

function GuildJoinUnion:showUnionList()
	local unionNum = #self.unions
	for index = 1, unionNum, 2 do
		if index+1 > unionNum then
			self:createUnionRow(self.rowTemplate:clone(), index, {self.unions[index]})
		else
			self:createUnionRow(self.rowTemplate:clone(), index, {self.unions[index], self.unions[index+1]})
		end
	end
	
	self:setSelectItem(1)
end
	
function GuildJoinUnion:createUnionRow(rowNode, index, unionsDataS)
	for i, unionsData in ipairs(unionsDataS) do
		local unionItemNode = rowNode:getChildByName("unionItemBg"..i)
		gt.seekNodeByName(unionItemNode, "Label_Name"):setString(tostring(unionsData.name))
		gt.seekNodeByName(unionItemNode, "Label_ID"):setString(tostring(unionsData.id))
		
		local imageUnionHead = unionItemNode:getChildByName("Image_Head")
		self.playerHeadMgr:attach(imageUnionHead, gt.playerData.uid, unionsData.icon)
		
		local btnSelect= unionItemNode:getChildByName("Button_Select")
		btnSelect:setEnabled(true)
		self.unionSelectList[index+i-1] = btnSelect
		
		unionItemNode:setTag(unionsData.id)
		gt.addBtnPressedListener(unionItemNode, function()
			self:setSelectItem(index+i-1)
		end)
	end
	if 1 == #unionsDataS then
		rowNode:getChildByName("unionItemBg2"):setVisible(false)
	end
	
	self.unionListView:pushBackCustomItem(rowNode)
end

function GuildJoinUnion:setSelectItem(selectedIndex)
	if self.unionSelectIndex then
		self.unionSelectList[self.unionSelectIndex]:setEnabled(true)
	end
	self.unionSelectIndex = selectedIndex
	self.unionSelectList[self.unionSelectIndex]:setEnabled(false)
end

function GuildJoinUnion:setSelectedUnion(unionData, cost)
	local Image_GuildItemBg = self.Image_ConfirmTipsBg:getChildByName("unionItemBg")
	local imageGuildHead = gt.seekNodeByName(Image_GuildItemBg, "Image_Head")
	self.playerHeadMgr:attach(imageGuildHead, gt.playerData.uid, unionData.icon)
	gt.seekNodeByName(Image_GuildItemBg, "Label_Name"):setString(tostring(unionData.name))
	gt.seekNodeByName(Image_GuildItemBg, "Label_ID"):setString(tostring(unionData.id))
	
	self.Image_ConfirmTipsBg:getChildByName("Text_cardNum"):setString(tostring(cost))
end

function GuildJoinUnion:close()
	self.rowTemplate:release()
	self:removeFromParent()
end

return GuildJoinUnion