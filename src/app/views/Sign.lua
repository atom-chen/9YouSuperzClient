local Sign = class("Sign", function()
	return gt.createMaskLayer()
end)

local gt = cc.exports.gt

function Sign:ctor(msgTbl)
    local csbNode = cc.CSLoader:createNode("csd/Sign.csb")
    csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.rootNode = csbNode

    --注册消息回调
    gt.socketClient:registerMsgListener(gt.SIGN_DAILY, self, self.onRcvSign)
    
    self.day = msgTbl.day
    --这个月第一天时周几
    self.week = msgTbl.week
    self.strDays = msgTbl.str_days

    --关闭按钮
    local btnClose = gt.seekNodeByName(csbNode, "Btn_Close")
    gt.addBtnPressedListener(btnClose, function()
        self:closeView()
    end)

    local lbTip = gt.seekNodeByName(csbNode, "TextTip")
    lbTip:setString(string.format("每天签到可以获得%d张房卡", msgTbl.daily_award_num))
    --连续签到天数
    local lbSignNum = gt.seekNodeByName(csbNode, "TextSignNum")
    lbSignNum:setString(tostring(msgTbl.count))
    --日期
    local lbDate = gt.seekNodeByName(csbNode, "TextDate")
    lbDate:setString(string.format("%d年%d月", msgTbl.year, msgTbl.month))

    --签到按钮
    local btnSign = gt.seekNodeByName(csbNode, "Btn_Sign")
    gt.addBtnPressedListener(btnSign, function()
		local msgToSend = {}
		msgToSend.cmd = gt.SIGN_DAILY
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		gt.socketClient:sendMessage(msgToSend)        
    end)
    local lbSign = gt.seekNodeByName(btnSign, "lbSign")
    if gt.playerData.isSign then
        lbSign:setString("今日已领")
        btnSign:setEnabled(false)
    else
        lbSign:setString("签到领卡")
        btnSign:setEnabled(true)
    end

    self:updateView()
end

function Sign:updateView()
    for i = 1, 37 do
        local name = string.format("Node%d", i)
        local node = gt.seekNodeByName(self.rootNode, name)
        local lbDay = gt.seekNodeByName(node, "Text")
        lbDay:setVisible(false)
        local imgSigned = gt.seekNodeByName(node, "Image_Signed")
        imgSigned:setVisible(false)
        local imgNoSign = gt.seekNodeByName(node, "Image_NoSign")
        imgNoSign:setVisible(false)
    end
    
    local num = string.len(self.strDays)
    local offIdx = self.week
    if self.week == 7 then
        offIdx = 0
    end
    for i = 1, num do
        local val = tonumber(gt.charAt(self.strDays,i))  
        local name = string.format("Node%d", i+offIdx)
        local node = gt.seekNodeByName(self.rootNode, name)
        local lbDay = gt.seekNodeByName(node, "Text")
        lbDay:setString(tostring(i))
        lbDay:setVisible(true)
        local imgSigned = gt.seekNodeByName(node, "Image_Signed")
        local imgNoSign = gt.seekNodeByName(node, "Image_NoSign")
        
        if val == 1 then
            --已签到
            imgSigned:setVisible(true)
        else
            --未签到且是当天
            if self.day == i then
                imgNoSign:setVisible(true)
            end
        end
    end
end

--签到回调
function Sign:onRcvSign(msgTbl)
    if msgTbl.code == 0 then
        gt.playerData.isSign = true
        local strTip = string.format("恭喜您获得房卡%d张", msgTbl.award_num)
        require("app/views/CommonTips"):create(strTip)     
	else
		-- 1:会话已过期，请重新登录
		-- 2:账号校验失败，请重新登录
        gt.dispatchEvent(gt.EventType.EXIT_HALL)
    end
    self:closeView()    
end

function Sign:closeView()
    gt.socketClient:unregisterMsgListener(gt.SIGN_DAILY)
    self:removeFromParent()
end

return Sign
