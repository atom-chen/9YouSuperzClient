local gt = cc.exports.gt

local CutCardsAni = class("CutCardsAni", function()
	return cc.Node:create()
end)

function CutCardsAni:ctor(bOperator, operatorName, time)
	self:setName("CutCardsAni")

	local csbNode = cc.CSLoader:createNode("csd/CutCardsAni.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
    self:addChild(csbNode)
	self.csbNode = csbNode
    self.bOperator = bOperator
    self.operatorName = operatorName
    self.waitTime = time
    gt.socketClient:registerMsgListener(gt.CUT_CARD_DN, self, self.onRcvCutCard) --选择切牌位置结果（可以播放切牌动画了）
    gt.registerEventListener(gt.EventType.CLOSE_CUT_CARD, self, self.closeView)

    self.lbWaitTip = gt.seekNodeByName(self.csbNode, "lbWaitTip")
    self.cutCards = {}
    for i = 1, 52 do
        self.cutCards[i] = {}
        self.cutCards[i].imgCard = gt.seekNodeByName(self.csbNode, "imgCrad"..i)
        self.cutCards[i].imgCard:setZOrder(i)
        self.cutCards[i].initPos = cc.p(self.cutCards[i].imgCard:getPosition())
    end
    self.nodeHide = gt.seekNodeByName(self.csbNode, "NodeHide")
    self.nodeHide:setZOrder(100)

    self.scheduleCutWait = gt.scheduler:scheduleScriptFunc(handler(self, self.updateCutWaitCD), 0.1, false)
    self:showCutCards()
end

function CutCardsAni:showCutCards()
    self.nodeHide:setVisible(self.bOperator)

    local lbCardNum = gt.seekNodeByName(self.csbNode, "TextCardNum")
    local cutNum = 26
    lbCardNum:setString(string.format("第%d张牌",cutNum))
    local imgShadeCut = gt.seekNodeByName(self.csbNode, "ImgShadeCut")
    imgShadeCut:setContentSize(570.0, 175.0)
    local slider = gt.seekNodeByName(self.csbNode, "SliderCut")
    slider:setPercent(46)

    slider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			local sliderPercent = slider:getPercent()
            local size = slider:getContentSize()
			local width = math.ceil(size.width * (sliderPercent / 100)) + 9
            imgShadeCut:setContentSize(width, 175.0)
            cutNum = math.ceil(width / 22)
            if cutNum > 52 then
                cutNum = 52
            end
            lbCardNum:setString(string.format("第%d张牌",cutNum))
        elseif eventType == ccui.SliderEventType.slideBallUp then
            local msgToSend = {}
            msgToSend.cmd = gt.CUT_CARD_DN
            msgToSend.card_seat = cutNum
            gt.socketClient:sendMessage(msgToSend)
		end
	end)
end

function CutCardsAni:onRcvCutCard(msgTbl)
    self.nodeHide:setVisible(false)
    self.lbWaitTip:setVisible(false)
    local moveTime1 = 0.5
    local moveTime2 = 0.3
    local cutNum = msgTbl.card_seat
    local function aniFunc(startPos, endPos, pos)
        local num = endPos - startPos + 1
        for i = endPos, startPos, -1 do
            local moveTime = moveTime1 * ((i-startPos+1) / num)
            local delayTime = moveTime1 - moveTime
            self.cutCards[i].imgCard:runAction(cc.Sequence:create(cc.DelayTime:create(delayTime), cc.MoveTo:create(moveTime, pos)))
        end
                
        local ani2Func = function()
            for i = startPos-1, endPos do
                self.cutCards[i].imgCard:setVisible(false)
                if (i == endPos) then
                    self.cutCards[i].imgCard:setVisible(true)
                    local zOrder = math.abs(100000-i)
                    self.cutCards[i].imgCard:setZOrder(zOrder)
                    self.cutCards[i].imgCard:runAction(cc.MoveTo:create(moveTime2, cc.p(640, 510)))
                end
            end
        end
            self:runAction(cc.Sequence:create(cc.DelayTime:create(moveTime1+0.1), cc.CallFunc:create(ani2Func)))
    end

    local function aniFunc2(sender, param)
        aniFunc(param.startIdx, param.endIdx, param.pos)
    end

    local function aniFunc3()
        self:closeView()
    end

    if cutNum == 1 then
        local pos = self.cutCards[cutNum+1].initPos
        local startIdx = cutNum + 2
        local endIdx = 52
        aniFunc(startIdx, endIdx, pos)
        local funcTmp = function ()
            self.cutCards[1].imgCard:setZOrder(100000)
            self.cutCards[1].imgCard:runAction(cc.MoveTo:create(moveTime2, cc.p(640, 510)))
        end
        self:runAction(cc.Sequence:create(cc.DelayTime:create(moveTime1+moveTime2+0.1), cc.CallFunc:create(funcTmp), cc.DelayTime:create(moveTime1+moveTime2+0.5), cc.CallFunc:create(aniFunc3)))
    elseif cutNum == 51 then
        self.cutCards[52].imgCard:runAction(cc.MoveTo:create(moveTime2, cc.p(640, 510)))
        local param = {pos = self.cutCards[1].initPos, startIdx = 2, endIdx = cutNum}
        self:runAction(cc.Sequence:create(cc.DelayTime:create(moveTime2), cc.CallFunc:create(aniFunc2, param), cc.DelayTime:create(moveTime1+moveTime2+0.5), cc.CallFunc:create(aniFunc3)))
    elseif cutNum == 52 then
        local pos = self.cutCards[1].initPos
        local startIdx = 2
        local endIdx = 52
        aniFunc(startIdx, endIdx, pos)
        self:runAction(cc.Sequence:create(cc.DelayTime:create(moveTime1+moveTime2+0.5), cc.CallFunc:create(aniFunc3)))
    else
        local pos = self.cutCards[cutNum+1].initPos
        local startIdx = cutNum + 2
        local endIdx = 52
        aniFunc(startIdx, endIdx, pos)
        local param = {pos = self.cutCards[1].initPos, startIdx = 2, endIdx = cutNum}
        self:runAction(cc.Sequence:create(cc.DelayTime:create(moveTime1+moveTime2), cc.CallFunc:create(aniFunc2, param), cc.DelayTime:create(moveTime1+moveTime2+0.5), cc.CallFunc:create(aniFunc3)))
    end           
end

--更新自动托管等待时间
function CutCardsAni:updateCutWaitCD(delta)
    delta = delta or 0
	self.waitTime = self.waitTime - delta
	if self.waitTime < 0 then
		self.waitTime = 0
    end

    self.lbWaitTip:setString(string.format("%s正在切牌...%ds", self.operatorName, self.waitTime))
end

function CutCardsAni:closeView()
    gt.scheduler:unscheduleScriptEntry(self.scheduleCutWait)
    gt.socketClient:unregisterMsgListener(gt.CUT_CARD_DN)
    --注销事件回调
	gt.removeTargetAllEventListener(self)

	self:removeFromParent()        
end

return CutCardsAni
