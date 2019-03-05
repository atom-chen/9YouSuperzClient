local gt = cc.exports.gt

local GuildUpgradeUnion = class("GuildUpgradeUnion",function()
	return gt.createMaskLayer()
end)

function GuildUpgradeUnion:ctor(guild_id, cost, activeTime, joinUnionFun)
	local csbNode = cc.CSLoader:createNode("csd/Guild/GuildUpgradeUnion.csb")
	csbNode:setAnchorPoint(0.5,0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	
	self.guild_id = guild_id
	
	local Image_UpgradeRuleBg = self.csbNode:getChildByName("Image_UpgradeRuleBg")
	Image_UpgradeRuleBg:setVisible(false)
	self.Image_mask = self.csbNode:getChildByName("Image_mask")
	self.Image_mask:setVisible(false)
	gt.log("-----openUI:GuildUpgradeUnion")

	--升级层按钮
	local btnClose = gt.seekNodeByName(csbNode,"Btn_Close")
	gt.addBtnPressedListener(btnClose,function()
		self:removeFromParent()
	end)
	
	local btnInfo = gt.seekNodeByName(csbNode, "Btn_Info")
	gt.addBtnPressedListener(btnInfo, function()
		Image_UpgradeRuleBg:setVisible(true)
		Image_UpgradeRuleBg:getChildByName("Text_UpgradeRule"):setVisible(true)
		Image_UpgradeRuleBg:getChildByName("Text_GetKey"):setVisible(false)
		self.Image_mask:setVisible(true)
	end)

	local btnGetKey = gt.seekNodeByName(csbNode, "Btn_GetKey")
	gt.addBtnPressedListener(btnGetKey, function()
		local view = require("app/views/Guild/UnionKeyActive"):create(activeTime)
		self:addChild(view)
	end)

	gt.seekNodeByName(csbNode, "Text_cardNum"):setString(cost.."房卡")

	self.activeCodeText = gt.seekNodeByName(csbNode, "Text_key")
	self.activeCodeText:setString("")
	
	local btnUpgrade = gt.seekNodeByName(csbNode, "Btn_Upgrade")
	gt.addBtnPressedListener(btnUpgrade, function()
		local activeCode = self.activeCodeText:getString()
		if 1 > string.len(activeCode)then
			require("app/views/CommonTips"):create("请输入激活码")
		else
			if gt.playerData.roomCardsCount[1] < cost then
				require("app/views/NoticeTips"):create("升级大联盟", "操作失败,房卡不足！", nil, nil, true)
			else
				local msgToSend = {}
				msgToSend.cmd = gt.UNION_CHECK_ACTIVE_CODE
				msgToSend.user_id = gt.playerData.uid
				msgToSend.open_id = gt.playerData.openid
				msgToSend.active_code = activeCode
				gt.socketClient:sendMessage(msgToSend)
			end
		end
	end)
	
	local btnHaveUnion = gt.seekNodeByName(csbNode, "Btn_HaveUnion")
	gt.addBtnPressedListener(btnHaveUnion, function()
		local function closeUpgradeFunc()
			self:removeFromParent()
		end
		local view = require("app/views/Guild/GuildJoinUnion"):create(self.guild_id, closeUpgradeFunc, joinUnionFun)
		self:addChild(view)
	end)
	
	
	--规则按钮
	local btnCloseUpgradeRule = gt.seekNodeByName(csbNode,"Btn_CloseUpgradeRule")
	gt.addBtnPressedListener(btnCloseUpgradeRule,function()
		Image_UpgradeRuleBg:setVisible(false)
		self.Image_mask:setVisible(false)
	end)
	local btnOkUpgradeRule = gt.seekNodeByName(csbNode,"Btn_OkUpgradeRule")
	gt.addBtnPressedListener(btnOkUpgradeRule,function()
		Image_UpgradeRuleBg:setVisible(false)
		self.Image_mask:setVisible(false)
	end)
	
	gt.socketClient:registerMsgListener(gt.UNION_CHECK_ACTIVE_CODE, self, self.onRcvCheckActiveCode)
end

function GuildUpgradeUnion:onRcvCheckActiveCode(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		require("app/views/CommonTips"):create("房卡足够，激活码验证成功，请继续创建")		
		local view = require("app/views/Guild/GuildInput"):create("union_create", msgTbl.active_code, self.guild_id)
		self:addChild(view)
			
	elseif msgTbl.code == 1 then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "激活码已被使用,请重新输入", nil, nil, true)
		self.activeCodeText:setString("")
	elseif msgTbl.code == 2 then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "激活码错误,请重新输入", nil, nil, true)
		self.activeCodeText:setString("")
	end	
end

return GuildUpgradeUnion