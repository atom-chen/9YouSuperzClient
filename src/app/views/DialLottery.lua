local DialLottery = class("Sign", function()
	return gt.createMaskLayer()
end)

local gt = cc.exports.gt

function DialLottery:ctor(msgTbl)
    local csbNode = cc.CSLoader:createNode("csd/Dial.csb")
    csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.rootNode = csbNode

    --注册消息回调
    gt.socketClient:registerMsgListener(gt.DIAL_AWARD, self, self.onRcvLottery)
    
    --可抽奖次数
    self.lotteryNum = msgTbl.left_award_num
    --是否正在抽奖
    self.bDrawing = false
    self.maxCount = 6
    self.rotateTime = 5
    self.lightIndex = nil
    self.reward1 = {2, 5}
    self.reward2 = {3, 6}
    self.reward3 = {1, 4}

    --关闭按钮
    local btnClose = gt.seekNodeByName(csbNode, "Btn_Close")
    gt.addBtnPressedListener(btnClose, function()
        self:closeView()
    end)

    --可抽奖次数
    self.lbLeftNum = gt.seekNodeByName(csbNode, "Text_Num")
    self.lbLeftNum:setString(tostring(self.lotteryNum))

    --亮片
    self.imgLight = gt.seekNodeByName(csbNode, "Image_Light")

    --抽奖按钮
    self.btnLottery = gt.seekNodeByName(csbNode, "Btn_lottery")
    gt.addBtnPressedListener(self.btnLottery, function()
        if self.lotteryNum <= 0 then
            require("app/views/CommonTips"):create("抽奖次数不足！")
        else
            self.btnLottery:setTouchEnabled(false)
		    local msgToSend = {}
		    msgToSend.cmd = gt.DIAL_AWARD
		    msgToSend.user_id = gt.playerData.uid
		    msgToSend.open_id = gt.playerData.openid
		    gt.socketClient:sendMessage(msgToSend)
        end        
    end)
end


--抽奖回调
function DialLottery:onRcvLottery(msgTbl)
    if msgTbl.code == 0 then
        self.lotteryNum = self.lotteryNum - 1
        self.lbLeftNum:setString(tostring(self.lotteryNum))
        --获得的奖励数量
        self.getAwardNum = msgTbl.award_num
        self:getReward(self.getAwardNum)     
	elseif msgTbl.code == 3 then
        --次数不足
        require("app/views/CommonTips"):create("抽奖次数不足！")
        self.btnLottery:setTouchEnabled(true)
    else
		-- 1:会话已过期，请重新登录
		-- 2:账号校验失败，请重新登录
        gt.dispatchEvent(gt.EventType.EXIT_HALL)
        self:closeView()
    end
        
end

function DialLottery:rotateTo(index)
	local degPerCount = 360 / self.maxCount
	local deg = degPerCount * index - math.random(degPerCount * 0.2, degPerCount * 0.8)
	local randomDeg = 360 * math.random(10, 11)
    self.monitorTime = 0
    self.bDrawing = true
    self.scheduleRotate = gt.scheduler:scheduleScriptFunc(handler(self, self.drawLight), 0, false)
    self.btnLottery:runAction(cc.EaseSineInOut:create(cc.RotateTo:create(self.rotateTime, randomDeg + deg)))
end

function DialLottery:drawLight(dt)
	local deg = self.btnLottery:getRotation()
    local index = math.floor(deg /(360 / self.maxCount))
	if self.lightIndex ~= index then
		self.lightIndex = index
        local angle = self.lightIndex * 360 / self.maxCount
        self.imgLight:setRotation(angle)
	end

    self.monitorTime = self.monitorTime + dt
    if self.monitorTime >=  self.rotateTime then
        gt.scheduler:unscheduleScriptEntry(self.scheduleRotate)
        self.bDrawing = false
        self.btnLottery:setTouchEnabled(true)
        local strTip = string.format("恭喜您获得房卡%d张", self.getAwardNum)
        require("app/views/CommonTips"):create(strTip)
    end
end

function DialLottery:getReward(i)
	local target
	if i == 1 then
		target = self.reward1[math.random(1, #self.reward1)]
	elseif i == 2 then
		target = self.reward2[math.random(1, #self.reward2)]
	elseif i == 3 then
		target = self.reward3[math.random(1, #self.reward3)]
	else
		return
	end
	self:rotateTo(target)
end

function DialLottery:closeView()
    if not self.bDrawing then
        gt.socketClient:unregisterMsgListener(gt.DIAL_AWARD)
        self:removeFromParent()        
    end
end

return DialLottery

