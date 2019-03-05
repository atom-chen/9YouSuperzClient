-- 比赛额外设置

local gt = cc.exports.gt

local MatchExtraEx2 = class("MatchExtraEx2", function()
	return gt.createMaskLayer()
end)

function MatchExtraEx2:ctor(guild_id)
	local csbNode = cc.CSLoader:createNode("csd/Guild/MatchExtraEx2.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	self.guild_id = guild_id

	local btnCancel = gt.seekNodeByName(csbNode, "Btn_Cancel")
	gt.addBtnPressedListener(btnCancel, function()
		self:close()
	end)
	local btnOk = gt.seekNodeByName(csbNode, "Btn_Ok")
	gt.addBtnPressedListener(btnOk, function()
		if self.sits < 200 then
			require("app/views/NoticeTips"):create("提示", "参与游戏分数不能低于200分", nil, nil, true)
			return
		end
		local msgToSend = {}
		msgToSend.cmd = gt.MATCH_EXTRA
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		msgToSend.guild_id = guild_id
		msgToSend.set = 1
		msgToSend.neg = self.neg
		msgToSend.sits = self.sits
		msgToSend.loots = self.loots
		gt.socketClient:sendMessage(msgToSend)
		gt.showLoadingTips("")
	end)

	self.neg = 0
	self.sits = 2000
	self.loots = 1000

	self.lblSitScore = gt.seekNodeByName(csbNode, "Label_SitScore")
	self.lblLootScore = gt.seekNodeByName(csbNode, "Label_LootScore")

	local btnModSitScore =  gt.seekNodeByName(csbNode, "Btn_ModSitScore")
	btnModSitScore:addClickEventListener(function ()
		local view = require("app/views/Guild/GuildNumberPad"):create("get_number", 0, 0, handler(self, self.modSitScore))
		self:addChild(view)
	end)

	local btnModLootScore =  gt.seekNodeByName(csbNode, "Btn_ModLootScore")
	btnModLootScore:addClickEventListener(function ()
		local view = require("app/views/Guild/GuildNumberPad"):create("get_number", 0, 0, handler(self, self.modLootScore))
		self:addChild(view)
	end)
	self.btnModLootScore = btnModLootScore

	self.chkNeg1 = gt.seekNodeByName(csbNode, "Chk_Neg1")
	self.chkNeg1:setTag(0)
	self.chkNeg2 = gt.seekNodeByName(csbNode, "Chk_Neg2")
	self.chkNeg2:setTag(1)
	local function onCheck(sender)
		self.neg = sender:getTag()
		self:refreshView()
	end
	self.chkNeg1:addClickEventListener(onCheck)
	self.chkNeg2:addClickEventListener(onCheck)

	self:refreshView()

	gt.socketClient:registerMsgListener(gt.MATCH_EXTRA, self, self.onRcvMatchExtra)

	local msgToSend = {}
	msgToSend.cmd = gt.MATCH_EXTRA
	msgToSend.user_id = gt.playerData.uid
	msgToSend.open_id = gt.playerData.openid
	msgToSend.guild_id = guild_id
	msgToSend.set = 0
	gt.socketClient:sendMessage(msgToSend)
	gt.showLoadingTips("")
end


function MatchExtraEx2:refreshView()
	self.lblSitScore:setString(tostring(self.sits))
	self.chkNeg1:setSelected(self.neg == 0)
	self.chkNeg2:setSelected(self.neg ~= 0)
	self.btnModLootScore:setEnabled(self.neg == 0)
	if self.neg ~= 0 then
		self.lblLootScore:setString("无限制")
	else
		self.lblLootScore:setString(tostring(self.loots))
	end
end

function MatchExtraEx2:modSitScore(score)
	self.sits = score
	self.lblSitScore:setString(tostring(score))
end

function MatchExtraEx2:modLootScore(score)
	self.loots = score
	self.lblLootScore:setString(tostring(score))
end

function MatchExtraEx2:onRcvMatchExtra(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.set == 0 then
		self.neg = msgTbl.neg
		self.sits = msgTbl.sits
		self.loots = msgTbl.loots
		self:refreshView()
	else
		if msgTbl.code == 0 then
			require("app/views/CommonTips"):create("设置成功", 2)
		end
		self:close()
	end
end

function MatchExtraEx2:close()
	gt.socketClient:unregisterMsgListener(gt.MATCH_EXTRA)
	self:removeFromParent()
end

return MatchExtraEx2
