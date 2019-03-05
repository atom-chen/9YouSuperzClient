-- 比赛额外设置

local gt = cc.exports.gt

local MatchExtra = class("MatchExtra", function()
	return gt.createMaskLayer()
end)

function MatchExtra:ctor(guild_id)
	local csbNode = cc.CSLoader:createNode("csd/Guild/MatchExtra.csb")
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
		local msgToSend = {}
		msgToSend.cmd = gt.MATCH_EXTRA
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		msgToSend.guild_id = guild_id
		msgToSend.set = 1
		msgToSend.style = self.style
		msgToSend.amount = self.amount
		msgToSend.score = self.score
		msgToSend.winners = self.winners
		gt.socketClient:sendMessage(msgToSend)
		gt.showLoadingTips("")
	end)

	self.style = 1
	self.amount = 1
	self.score = 100
	self.winners = 0

	self.pWinners = gt.seekNodeByName(csbNode, "Panel_Winners")
	self.pAmount = gt.seekNodeByName(csbNode, "Panel_Amount")
	self.pScore = gt.seekNodeByName(csbNode, "Panel_Score")

	local lstWinners = gt.seekNodeByName(self.pWinners, "List_Winners")
	local pTemplate = lstWinners:getChildByName("Panel_Template")
	pTemplate:retain()
	
	--  赢家设置
	lstWinners:removeAllChildren()
	local function onChooseWinners(sender, touchType)
		if touchType == TOUCH_EVENT_ENDED then
			self.winners = sender:getTag()
			self:refreshView()
		end
	end
	local descs = {"所有赢家", "一个赢家", "两个赢家", "三个赢家"}
	for i = 0, 3 do
		local pItem = pTemplate:clone()
		pItem:getChildByName("Text_Desc"):setString(descs[i+1])
		pItem:setTag(i)
		pItem:addTouchEventListener(onChooseWinners)
		lstWinners:pushBackCustomItem(pItem)
	end
	self.lstWinners = lstWinners

	-- 赠送设置
	local function onChooseAmount(sender, touchType)
		if touchType == TOUCH_EVENT_ENDED then
			self.amount = sender:getTag()
			self:refreshView()
		end
	end
	local lstAmount = gt.seekNodeByName(self.pAmount, "List_Amount")
	lstAmount:removeAllChildren()
	for i = 0, 10 do
		local pItem = pTemplate:clone()
		pItem:getChildByName("Text_Desc"):setString(string.format("赠送表情%d次", i))
		pItem:setTag(i)
		pItem:addTouchEventListener(onChooseAmount)
		lstAmount:pushBackCustomItem(pItem)
	end
	self.lstAmount = lstAmount

	-- 分数选择
	local function onChooseScore(sender, touchType)
		if touchType == TOUCH_EVENT_ENDED then
			self.score = sender:getTag()
			self:refreshView()
		end
	end
	local lstScore = gt.seekNodeByName(self.pScore, "List_Score")
	lstScore:removeAllChildren()
	local scores = {0, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000}
	for i = 1, #scores do
		local pItem = pTemplate:clone()
		pItem:getChildByName("Text_Desc"):setString(string.format("%d分", scores[i]))
		pItem:setTag(scores[i])
		pItem:addTouchEventListener(onChooseScore)
		lstScore:pushBackCustomItem(pItem)
	end
	self.lstScore = lstScore

	pTemplate:release()


	-- 类型选择
	local function onChooseStyle(sender, touchType)
		if touchType == TOUCH_EVENT_ENDED then
			self.style = sender:getTag()
			self:refreshView()
		end
	end
	self.tabs = {}
	for i = 1, 2 do
		local tab = gt.seekNodeByName(csbNode, "Chk_Style"..i)
		tab:setTag(i)
		tab:addTouchEventListener(onChooseStyle)
		self.tabs[i] = tab
	end
	
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

function MatchExtra:setListCheckValue(lstView, value)
	local childs = lstView:getChildren()
	for i, v in ipairs(childs) do
		local check = v:getChildByName("Img_Ckeck")
		check:setVisible(v:getTag() == value)
	end
end

function MatchExtra:refreshView()
	if self.style == 1 then
		self.tabs[1]:setSelected(false)
		self.tabs[2]:setSelected(true)
		self.pWinners:setVisible(false)
		self.pAmount:setPositionX(900*0.33)
		self.pScore:setPositionX(900*0.67)
	else
		self.tabs[1]:setSelected(true)
		self.tabs[2]:setSelected(false)
		self.pWinners:setVisible(true)
		self.pAmount:setPositionX(900*0.5)
		self.pScore:setPositionX(900*0.83)
	end
	self:setListCheckValue(self.lstWinners, self.winners)
	self:setListCheckValue(self.lstAmount, self.amount)
	self:setListCheckValue(self.lstScore, self.score)
end

function MatchExtra:onRcvMatchExtra(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.set == 0 then
		self.style = msgTbl.style
		self.amount = msgTbl.amount
		self.score = msgTbl.score
		self.winners = msgTbl.winners or 0
		self:refreshView()
	else
		if msgTbl.code == 0 then
			require("app/views/CommonTips"):create("设置成功", 2)
		end
		self:close()
	end
end

function MatchExtra:close()
	gt.socketClient:unregisterMsgListener(gt.MATCH_EXTRA)
	self:removeFromParent()
end

return MatchExtra
