-- 赛场记录

local gt = cc.exports.gt

local SportRecord = class("SportRecord", function()
	return gt.createMaskLayer()
end)

function SportRecord:ctor()
	self:registerScriptHandler(handler(self, self.onNodeEvent))

	local csbNode = cc.CSLoader:createNode("csd/Sport/SportRecord.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode

	local btnClose = gt.seekNodeByName(csbNode, "Btn_Close")
	gt.addBtnPressedListener(btnClose, function()
        self:removeFromParent()
	end)

	self.btnRank = gt.seekNodeByName(csbNode, "Btn_Rank")
	gt.addBtnPressedListener(self.btnRank, function()
        self:showPanel(1)
	end)

	self.btnRecord = gt.seekNodeByName(csbNode, "Btn_Record")
	gt.addBtnPressedListener(self.btnRecord, function()
        self:showPanel(2)
	end)

	self.pRank = gt.seekNodeByName(csbNode, "Panel_Rank")
	self.lstRank = self.pRank:getChildByName("List_Rank")
	self.pRankTemplate = self.lstRank:getChildByName("Panel_Template")
	self.pRankTemplate:retain()
	self.lstRank:removeAllChildren()
	self.rankData = false

	self.pRecord = gt.seekNodeByName(csbNode, "Panel_Record")
	self.lstRecord = self.pRecord:getChildByName("List_Record")
	self.pRecordTemplate = self.lstRecord:getChildByName("Panel_Template")
	self.pRecordTemplate:retain()
	self.lstRecord:removeAllChildren()
	self.recordData = false

	gt.socketClient:registerMsgListener(gt.SPORT_RECORD, self, self.onRcvSportRecord)
	gt.socketClient:registerMsgListener(gt.SPORT_RANK, self, self.onRcvSportRank)
	gt.socketClient:registerMsgListener(gt.SPORT_GET_AWARD, self, self.onRcvSportGetAward)
end

function SportRecord:onNodeEvent(eventName)
	if "enter" == eventName then
		self:showPanel(1)
	elseif "exit" == eventName then
		gt.socketClient:unregisterMsgListener(gt.SPORT_RECORD)
		gt.socketClient:unregisterMsgListener(gt.SPORT_RANK)
		gt.socketClient:unregisterMsgListener(gt.SPORT_GET_AWARD)
	end
end

function SportRecord:showPanel(idx)
	local btns = {self.btnRank, self.btnRecord}
	local panels = {self.pRank, self.pRecord}
	for i = 1, 2 do
		btns[i]:setEnabled(idx~=i)
		panels[i]:setVisible(idx==i)
	end
	if idx == 1 and not self.rankData then
		self.rankData = true
		local msgToSend = {}
		msgToSend.cmd = gt.SPORT_RANK
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		gt.socketClient:sendMessage(msgToSend)
		gt.showLoadingTips("")
	elseif idx == 2 and not self.recordData then
		self.recordData = true
		local msgToSend = {}
		msgToSend.cmd = gt.SPORT_RECORD
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		gt.socketClient:sendMessage(msgToSend)
		gt.showLoadingTips("")
	end
end

function SportRecord:onRcvSportRank(msgTbl)
	gt.removeLoadingTips()
	self.lstRank:removeAllChildren()
	table.sort(msgTbl.ranks, function(a, b) return a.rk < b.rk end)
	for i, v in ipairs(msgTbl.ranks) do
		local pItem = self.pRankTemplate:clone()
		gt.seekNodeByName(pItem,"Label_Rank"):setString("第"..tostring(v.rk).."名")
		gt.seekNodeByName(pItem,"Label_Nick"):setString(tostring(v.nk))
		gt.seekNodeByName(pItem,"Label_Id"):setString(tostring(v.id))
		gt.seekNodeByName(pItem,"Label_Score"):setString(tostring(v.sc))
		self.lstRank:pushBackCustomItem(pItem)
	end
end


function SportRecord:onRcvSportRecord(msgTbl)
	gt.removeLoadingTips()
	self.lstRecord:removeAllChildren()

	local function onSubmit(sender)
		local sport_id = sender:getTag()
		local submit = require("app/views/Sport/SportSubmit"):create(sport_id)
		self:addChild(submit)
	end

	local function onAward(sender)
		local sport_id = sender:getTag()
		local msgToSend = {}
		msgToSend.cmd = gt.SPORT_GET_AWARD
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		msgToSend.sport_id = sport_id
		msgToSend.phone = ""
		msgToSend.addr = ""
		gt.socketClient:sendMessage(msgToSend)
		gt.showLoadingTips("")
	end

	for i, v in ipairs(msgTbl.records) do
		local desc = ""
		local reward = ""
		if v.rank <= 0 then
			desc = string.format("很遗憾，您在 %s 的比赛中被淘汰", v.time)
		else
			desc = string.format("恭喜您在 %s 的比赛中获得了第 %d 名", v.time, v.rank) 
		end
		if v.redeem ~= "" then
			reward = string.format("获得奖品兑换码: %s，请联系客服兑换奖励", v.redeem)
		elseif v.reward > 0 then
			reward = string.format("获得奖品%d张房卡", v.reward)
		end

		local pItem = self.pRecordTemplate:clone()
		pItem:getChildByName("Label_Desc"):setString(desc)
		pItem:getChildByName("Label_Reward"):setString(reward)
		pItem:getChildByName("Img_Award"):setVisible(v.submit>0)
		local btnAward = pItem:getChildByName("Btn_Award")
		btnAward:setVisible(false)
		if v.submit == 0 then
			if v.reward > 0 or v.redeem ~= "" then
				btnAward:setVisible(true)
				btnAward:setTag(v.id)
				if v.redeem ~= "" then
					btnAward:addClickEventListener(onSubmit)
				else
					btnAward:addClickEventListener(onAward)
				end
			end
		end
		self.lstRecord:pushBackCustomItem(pItem)
	end
end

function SportRecord:onRcvSportGetAward(msgTbl)
	gt.removeLoadingTips()
	local desc = "系统错误"
	if msgTbl.code == 0 then
		if msgTbl.reward > 0 then
			desc = string.format("恭喜您获得奖励%d房卡", msgTbl.reward)
		else
			desc = "领奖信息提交成功，请等待客服与您联系"
		end
		self.recordData = false
		self:showPanel(2)
	elseif msgTbl.code == 1 then
		desc = "您已经领取过该奖励"
	elseif msgTbl.code == 2 then
		desc = "信息填写不完整"
	end

	require("app/views/NoticeTips"):create("提示", desc, nil, nil, true)
end


return SportRecord
