-- 赛场界面

local gt = cc.exports.gt

local SportView = class("SportView", function()
	return gt.createMaskLayer()
end)

function SportView:ctor()
	self:registerScriptHandler(handler(self, self.onNodeEvent))

	local csbNode = cc.CSLoader:createNode("csd/Sport/SportView.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode

	local btnClose = gt.seekNodeByName(csbNode, "Btn_Close")
	gt.addBtnPressedListener(btnClose, function()
        self:removeFromParent()
		gt.soundEngine:playMusic("bgm1",true)
	end)

	local btnRecord= gt.seekNodeByName(csbNode, "Btn_Record")
	gt.addBtnPressedListener(btnRecord, function()
        local record = require("app/views/Sport/SportRecord"):create()
        self:addChild(record)
	end)

	local btnTicket = gt.seekNodeByName(csbNode, "Btn_Ticket")
	btnTicket:addClickEventListener(function()
        local buyCard = require("app/views/Store"):create(gt.playerData.proxyCode ~= 0)
		display.getRunningScene():addChild(buyCard)
        self:removeFromParent()
	end)

	self.lblTicket = gt.seekNodeByName(csbNode, "Label_Ticket")
	self.lstSports = gt.seekNodeByName(csbNode, "List_Sports")
	self.pTemplate = self.lstSports:getChildByName("Panel_Template")
	self.pTemplate:retain()
	self.lstSports:removeAllChildren()

	gt.socketClient:registerMsgListener(gt.SPORT_LIST, self, self.onRcvSportList)
	gt.socketClient:registerMsgListener(gt.SPORT_SIGN, self, self.onRcvSportSign)
end

function SportView:onNodeEvent(eventName)
	if "enter" == eventName then
		gt.soundEngine:playMusic("bgmSport1",true)
		self:request()
		self.scheduleHandler = gt.scheduler:scheduleScriptFunc(handler(self, self.request), 10, false)
	elseif "exit" == eventName then
		if self.scheduleHandler then
			gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
			self.scheduleHandler = 0
		end
		gt.socketClient:unregisterMsgListener(gt.SPORT_LIST)
		gt.socketClient:unregisterMsgListener(gt.SPORT_SIGN)
		self.pTemplate:release()
	end
end

function SportView:request()
	local msgToSend = {}
	msgToSend.cmd = gt.SPORT_LIST
	msgToSend.user_id = gt.playerData.uid
	msgToSend.open_id = gt.playerData.openid
	gt.socketClient:sendMessage(msgToSend)
	gt.showLoadingTips("")
end

function SportView:onRcvSportList(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == -1 then return end
	self.lblTicket:setString(tostring(msgTbl.room_card2))
	local sportList = msgTbl.sports
	gt.sportManager:setSportList(sportList)
	self:refreshSportList()
end

function SportView:refreshSportList()
	local sportList = gt.sportManager:getSportList()

	local function onDetail(sender)
		local detail = require("app/views/Sport/SportDetail"):create(sender:getTag())
        self:addChild(detail)
	end

	local function sendSign(sport_id, sign)
		local sport = gt.sportManager:getSport(sport_id)
		if not sport then return end
		local msgToSend = {}
		msgToSend.cmd = gt.SPORT_SIGN
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		msgToSend.sport_id = sport_id
		msgToSend.sport_tid = sport.tid
		msgToSend.sign = sign
		gt.socketClient:sendMessage(msgToSend)
		gt.showLoadingTips("")
	end

	local function onSign(sender)
		sendSign(sender:getTag(), 1)
	end

	local function onRetire(sender)
		sendSign(sender:getTag(), 0)
	end

	self.lstSports:removeAllChildren()
	--先排大奖赛 再按ID排
	local showlist={}
	for i,v in ipairs(sportList) do
		local config = gt.sportManager:getConfigByTid(v.tid)
		if config then
			table.insert(showlist,{cf=config,msg=v})
		end
	end
	table.sort(showlist,function (a,b)
		if a.cf.displayIndex ~= b.cf.displayIndex then
			return a.cf.displayIndex < b.cf.displayIndex
		else
			return a.msg.tid < b.msg.tid
		end
	end)
	for i, v in ipairs(showlist) do
		local cf = v.cf
		local pItem = self.pTemplate:clone()
		pItem:setTag(v.msg.id)
		if cf.icon=="" then
			pItem:getChildByName("Img_Icon"):setVisible(false)
		else
			pItem:getChildByName("Img_Icon"):setVisible(true)
			pItem:getChildByName("Img_Icon"):loadTexture("image/sport/"..cf.icon, ccui.TextureResType.plistType)
		end
		if cf.maskIcon and cf.maskIcon~="" then
			pItem:getChildByName("Img_Mask"):setVisible(true)
			pItem:getChildByName("Img_Mask"):loadTexture("image/sport/"..cf.maskIcon,ccui.TextureResType.plistType)
		else
			pItem:getChildByName("Img_Mask"):setVisible(false)
		end
		pItem:getChildByName("Label_RuleDesc"):setString(cf.rule_desc)
		pItem:getChildByName("Label_ModeDesc"):setString(cf.mode_desc)
		pItem:getChildByName("Label_Title"):setString(cf.title)
		pItem:getChildByName("Label_Desc"):setString(cf.desc)
		pItem:getChildByName("Label_Fee"):setString("X"..tostring(v.msg.fee))
		pItem:getChildByName("Label_Num"):setString(tostring(v.msg.show_num))

		local btnDetail = pItem:getChildByName("Btn_Detail")
		btnDetail:setTag(v.msg.tid)
		btnDetail:addClickEventListener(onDetail)

		local btnSign = pItem:getChildByName("Btn_Sign")
		btnSign:setVisible(v.msg.status == 1 and (not v.msg.is_sign))
		btnSign:setTag(v.msg.id)
		btnSign:addClickEventListener(onSign)

		local btnRetire = pItem:getChildByName("Btn_Retire")
		btnRetire:setVisible(v.msg.status == 1 and v.msg.is_sign)
		btnRetire:setTag(v.msg.id)
		btnRetire:addClickEventListener(onRetire)

		local imgGoing = pItem:getChildByName("Img_Going")
		imgGoing:setVisible(v.msg.status ~= 1)

		self.lstSports:pushBackCustomItem(pItem)
	end
end

function SportView:addItem(config,id)

end

function SportView:onRcvSportSign(msgTbl)
	gt.removeLoadingTips()
	self.lblTicket:setString(tostring(msgTbl.room_card2))
	if msgTbl.code == 0 then
		gt.sportManager:setSign(msgTbl.sport_id, msgTbl.sign)
		self:refreshSportList()
		local tips = {
			[0] = "退赛成功",
			[1] = "报名成功，等待比赛开始"
		}
		require("app/views/NoticeTips"):create("提示", tips[msgTbl.sign], nil, nil, true)
	else
		local errs = {
			[-1] = "系统错误",
			[1] = "您的参赛券不足",
			[2] = "当前时间不接收报名",
			[3] = "您已报名其他比赛",
			[4] = "该比赛已经开始，不再接受报名，请等待下一轮"
		}
		require("app/views/NoticeTips"):create("提示", errs[msgTbl.code], nil, nil, true)
	end
end


return SportView
