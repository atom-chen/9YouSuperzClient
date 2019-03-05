local gt = cc.exports.gt
require("json")
require("app.MyApp")

local CreateRoom = class("CreateRoom", function()
    return gt.createMaskLayer()
end )

CreateRoom.PlayerNum = {
    SIX = 6,
    EIGHT = 8,
    TEN = 10,
	TWELVE	= 12,
}

CreateRoom.Round = {
    Ten = 10,
    Twenty = 20,
    Thirty = 30,
    Three = 3,
    Six = 6,
    Nine = 9,
    Twelve = 12,
}

function CreateRoom:onNodeEvent(eventName)
	if "enter" == eventName then 
        
    elseif "exit" == eventName then
        for i, p in ipairs(self.panels) do
             p:release()
        end

        if not self.guild_id then
            gt.socketClient:unregisterMsgListener(gt.CREATE_ROOM)
        end

         self.nodeUIItemEffect:release()
         self.itemParticle:release()

         self:OnExitGamesConfig()
    end
end


function CreateRoom:ctor(guild_id, match)
    self:registerScriptHandler(handler(self, self.onNodeEvent))
    self.guild_id = guild_id
    self.lastCB_Game = nil
    match = match or 0
    self.match = match
    local csbNode = cc.CSLoader:createNode("csd/CreateRoom.csb")
    csbNode:setAnchorPoint(0.5, 0.5)
    csbNode:setPosition(gt.winCenter)
    self:addChild(csbNode)
    self.csbNode = csbNode

    self.nodeUIItemEffect = gt.seekNodeByName(csbNode,"nodeUIItemEffect")
    self.nodeUIItemEffect:retain()
    self.nodeUIItemEffect:removeFromParent()    

    self.itemParticle = gt.seekNodeByName(csbNode,"itemParticle")
    self.itemParticle:retain()
    self.itemParticle:removeFromParent()
    

    
    local userId = gt.playerData.uid
    self.storageKey = string.format("roomSetting%s",userId)
    self.storageKeyGameIdType = string.format("roomSetGameid%s",userId)
    if guild_id then
        self.storageKeyClub = string.format("roomSettingClub%s",guild_id)
        self.storageKeyClubGameIdType = string.format("roomClubGameid%s",guild_id)
        self.storageKeyMatch = string.format("roomSettingMatch%s",guild_id)
        self.storageKeyMatchGameIdType = string.format("roomMatchGameid%s",guild_id)
    end
    self.gameNum = 6 

    self.pTouch = gt.seekNodeByName(csbNode, "Panel_Touch")
    self.pTouch:setVisible(false)
    self.pTouch:addTouchEventListener( function(sender, touchType)
        if touchType == TOUCH_EVENT_ENDED then
            self.tuiTip:setVisible(false)
            self.tuiTipSG:setVisible(false)
            self.pledgeLimitTip:setVisible(false)
            self.buyPledgeTip:setVisible(false)
            self.stealTip:setVisible(false)
            self.laiziTip1:setVisible(false)
            self.laiziTip2:setVisible(false)
            self.doubleTip:setVisible(false)
            self.pRateTuizhu.Img_Tip:setVisible(false)
            sender:setVisible(false)
        end
    end )
    self.pTouchPop = gt.seekNodeByName(csbNode, "Panel_TouchPop")
    -- self.pTouchPop:setVisible(false)
    self.pTouchPop:addTouchEventListener( function(sender, touchType)
        if touchType == TOUCH_EVENT_ENDED then
            self:hidePopFrame()
            sender:setVisible(false)
        end
    end )

	if gt.isIOSReview() then
		gt.seekNodeByName(csbNode, "Img_Tip"):setVisible(false)
	end

    self.tuiTip = gt.seekNodeByName(csbNode, "ImgTuiTipBg")
    self.tuiTip:setVisible(false)
    self.tuiTipSG = gt.seekNodeByName(csbNode, "ImgSGTuiTipBg")
    self.tuiTipSG:setVisible(false)
    self.pledgeLimitTip = gt.seekNodeByName(csbNode, "ImgPledgeTipBg")
    self.pledgeLimitTip:setVisible(false)
    self.stealTip = gt.seekNodeByName(csbNode, "ImgStealTipBg")
    self.stealTip:setVisible(false)
    self.doubleTip = gt.seekNodeByName(csbNode, "ImgDoubleTipBg")
    self.doubleTip:setVisible(false)
    self.laiziTip1 = gt.seekNodeByName(csbNode, "ImgLaiziClassicTipBg")
    self.laiziTip1:setVisible(false)
    self.laiziTip2 = gt.seekNodeByName(csbNode, "ImgLaiziCrazyTipBg")
    self.laiziTip2:setVisible(false)
    self.buyPledgeTip = gt.seekNodeByName(csbNode, "ImgBuyPledgeTipBg")
    self.buyPledgeTip:setVisible(false)

    self.listViewTypes = gt.seekNodeByName(csbNode, "ListView_Left")
	
	local imgNei = self.listViewTypes:getChildByName("CB_Game6"):getChildByName("Img_New_0")
	if imgNei then
		imgNei:setVisible(false)
	end
    -- game_id=1 是牛牛  game_id=2 是三公
    self.game_id = gt.GameID.NIUNIU
    self.game_type = 4
    self.bClickPop = false

    for i = 1, self.gameNum do
        local name = string.format("CB_Game%d", i)
        local cbGame = self.listViewTypes:getChildByName(name)
        if cbGame then
            name = string.format("Panel_Item%d", i)
            local pItem = self.listViewTypes:getChildByName(name)

    	    for j = 1, 7 do
    		    local btn = pItem:getChildByTag(j)
                if btn then
    		        btn:addClickEventListener(function(sender)
                        gt.soundEngine:playEffect(gt.clickBtnAudio, false)
                        self:selPlayType(sender, pItem)
    		        end)
    		        -- 暂时隐藏炸金牛玩法
    		        if j == 3 then
    			        btn:setVisible(false)
    		        end            
                end
    	    end
			
        local size = pItem:getContentSize()
        cbGame:addTouchEventListener( function(sender, eventType)
            
            if eventType == ccui.TouchEventType.began then
                return true
            elseif eventType == ccui.TouchEventType.moved then
                return true
            elseif eventType == ccui.TouchEventType.ended then
                gt.soundEngine:playEffect(gt.clickBtnAudio, false)
                
                self:selGameType(sender, pItem, size)
                self:setPersonalSel()
                self:setRoomConsume()
            elseif eventType == ccui.TouchEventType.canceled then
                return true
            end

        end )
		end
    end

    local lstConfs = gt.seekNodeByName(csbNode, "List_Confs")
    lstConfs:addTouchEventListener( function(sender, touchType)
        if touchType == TOUCH_EVENT_ENDED then
            self:hidePopFrame()
        end
    end )
    self.pPlayerNum = lstConfs:getChildByName("Panel_PlayerNum")
    self.pPlayerNum12 = lstConfs:getChildByName("Panel_PlayerNum12")
	self.pRound = lstConfs:getChildByName("Panel_Round")
	self.pPay = lstConfs:getChildByName("Panel_Pay")
    local payCheck1 = self.pPay:getChildByName("Check_1")
    local payCheck2 = self.pPay:getChildByName("Check_2")
    self.lbPay1 = payCheck1:getChildByName("Label_Desc")
    self.lbPay2 = payCheck2:getChildByName("Label_Desc")

    self.pDoubleRate = lstConfs:getChildByName("Panel_DoubleRate")
    self.pPopDoubleRate = gt.seekNodeByName(self.pDoubleRate, "Panel_PopDoubleRate")
    self.pPopDoubleRate:setVisible(false)
    self.lbSelDoubelRate = gt.seekNodeByName(self.pDoubleRate, "Label_SelDoubleRate")

    self.pScore = lstConfs:getChildByName("Panel_Score")
    self.pQHScore = lstConfs:getChildByName("Panel_QHScore")
    self.pYsScore = lstConfs:getChildByName("Panel_YsScore")
    self.pSgScore = lstConfs:getChildByName("Panel_SgScore")
    self.pTTZScore = lstConfs:getChildByName("Panel_TTZScore")

    self.pPopScoreNormal = gt.seekNodeByName(self.pYsScore, "Panel_PopScoreNormal")
    self.pPopScoreNormal:setVisible(false)
    self.lblSelScoreNormal = gt.seekNodeByName(self.pYsScore, "lblSelScoreNormal")
    self.pPopScoreSpecial = gt.seekNodeByName(self.pYsScore, "Panel_PopScoreSpecial")
    self.pPopScoreSpecial:setVisible(false)
    self.lblSelScoreSpecial = gt.seekNodeByName(self.pYsScore, "lblSelScoreSpecial")

    self.pQHBaseScore = lstConfs:getChildByName("Panel_QHBaseScore")
    self.pBaseScore = lstConfs:getChildByName("Panel_BaseScore")
    self.pBanker = lstConfs:getChildByName("Panel_Banker")
    self.pOpenNum = lstConfs:getChildByName("Panel_OpenNum")
    self.pRateSel = lstConfs:getChildByName("Panel_RateSel")
    self.pBetNum = lstConfs:getChildByName("Panel_BetNum")
    self.pAdvanceOps = lstConfs:getChildByName("Panel_AdvanceOps")
    self.pRateTuizhu = lstConfs:getChildByName("Panel_RateTuizhu")

    self.pRoundZJH = lstConfs:getChildByName("Panel_Round_ZJH")
    self.pRoundZJH:getChildByName("Check_1"):getChildByName("Label_Desc"):setString("  6局")
    self.pRoundZJH:getChildByName("Check_2"):getChildByName("Label_Desc"):setString(" 9局")
    self.pRoundZJH:getChildByName("Check_3"):getChildByName("Label_Desc"):setString(" 12局")

    self.pBottomBet = lstConfs:getChildByName("Panel_BottomBet")
    self.pMaxTurn = lstConfs:getChildByName("Panel_MaxTurn")
    self.pMaxBets = lstConfs:getChildByName("Panel_MaxBets")
    self.pCmpType = lstConfs:getChildByName("Panel_CompareType")
    self.pLaizi = lstConfs:getChildByName("Panel_laizi")


    self.pOpsZJH = lstConfs:getChildByName("Panel_ZJH_Ops")
    self.pCmpZJH = lstConfs:getChildByName("Panel_compZJH")

    self.pPopZjhXi = gt.seekNodeByName(self.pOpsZJH, "Panel_PopZjhXi")
    self.pPopZjhXi:setVisible(false)
    self.lblSelZjhXi = gt.seekNodeByName(self.pOpsZJH, "lblSelZjhXi")

    self.pPopZjhBaoXi = gt.seekNodeByName(self.pOpsZJH, "Panel_PopZjhBaoXi")
    self.pPopZjhBaoXi:setVisible(false)
    self.lblSelZjhBaoXi = gt.seekNodeByName(self.pOpsZJH, "lblSelZjhBaoXi")

    self.pPopZjhMen = gt.seekNodeByName(self.pOpsZJH, "Panel_PopZjhMen")
    self.pPopZjhMen:setVisible(false)
    self.lblSelZjhMen = gt.seekNodeByName(self.pOpsZJH, "lblSelZjhMen")

    self.pPopZjhDrop = gt.seekNodeByName(self.pOpsZJH, "Panel_PopZjhDrop")
    self.pPopZjhDrop:setVisible(false)
    self.lblSelZjhDrop = gt.seekNodeByName(self.pOpsZJH, "lblSelZjhDrop")


    -- 扎金花
    local btnZjhXi = gt.seekNodeByName(self.pOpsZJH, "btnZjhXi")
    btnZjhXi:setZoomScale(0)
    btnZjhXi:addClickEventListener( function(sender)
        if not self.bClickPop then
            self.pPopZjhXi:setVisible(true)
        else
            self.pPopZjhXi:setVisible(false)   
        end
        self.bClickPop = not self.bClickPop
    end )
    local btnZjhBaoXi = gt.seekNodeByName(self.pOpsZJH, "btnZjhBaoXi")
    btnZjhBaoXi:setZoomScale(0)
    btnZjhBaoXi:addClickEventListener( function(sender)
        if not self.bClickPop then
            self.pPopZjhBaoXi:setVisible(true)
        else
            self.pPopZjhBaoXi:setVisible(false)   
        end
        self.bClickPop = not self.bClickPop
    end )

    local btnZjhMen = gt.seekNodeByName(self.pOpsZJH, "btnZjhMen")
    btnZjhMen:setZoomScale(0)
    btnZjhMen:addClickEventListener( function(sender)
        if not self.bClickPop then
            self.pPopZjhMen:setVisible(true)
        else
            self.pPopZjhMen:setVisible(false)   
        end
        self.bClickPop = not self.bClickPop
    end )

    local btnZjhDrop = gt.seekNodeByName(self.pOpsZJH, "btnZjhDrop")
    btnZjhDrop:setZoomScale(0)
    btnZjhDrop:addClickEventListener( function(sender)
        if not self.bClickPop then
            self.pPopZjhDrop:setVisible(true)
        else
            self.pPopZjhDrop:setVisible(false)   
        end
        self.bClickPop = not self.bClickPop
    end )

    self.pPopHua = gt.seekNodeByName(self.pLaizi, "Panel_PopHua")
    self.pPopHua:setVisible(false)
    self.lblSelHua = gt.seekNodeByName(self.pLaizi, "lblSelHua")

    local btnHua = gt.seekNodeByName(self.pLaizi, "btnHua")
    btnHua:setZoomScale(0)
    btnHua:addClickEventListener( function(sender)
        if not self.bClickPop then
            self.pPopHua:setVisible(true)
        else
            self.pPopHua:setVisible(false)   
        end
        self.bClickPop = not self.bClickPop
    end )
    self.btnHua = btnHua



	--屏蔽中途禁止加入 默认不开启
    --self.pOpsView = lstConfs:getChildByName("Panel_View_Ops")

    --推注Tip及按钮
    self.pRateTuizhu.Img_Tip = self.pRateTuizhu:getChildByName("ImgRateTuiTipBg")
    self.pRateTuizhu.Img_Tip:setVisible(false)
    self.pRateTuizhu.Btn_Tip = self.pRateTuizhu:getChildByName("Btn_WenHaoRateTui")
    self.pRateTuizhu.Btn_Tip:addClickEventListener(function()
        self.pTouch:setVisible(true)
        self.pRateTuizhu.Img_Tip:setVisible(true)
        self:hidePopFrame()
    end)

    self.pAutoStart = lstConfs:getChildByName("Panel_AutoStart")
    self.pSliderOps = lstConfs:getChildByName("Panel_SlideOptions")
    self.pSliderOps.Node_Show = gt.seekNodeByName(self.pSliderOps, "Node_Show")
    self.pSliderOps.Node_Tips = gt.seekNodeByName(self.pSliderOps, "Node_Tips")
    self.pSliderOps.Node_Show.List_Config = gt.seekNodeByName(self.pSliderOps, "ListView_Config")
    self.pSliderOps.Node_Show.List_Config:setScrollBarEnabled(false)
    -- 闲家推注
    self.pSliderOps.Node_Tips.Text_Tui = gt.seekNodeByName(self.pSliderOps, "Text_Tui")
    -- 抢庄倍数
    self.pSliderOps.Node_Tips.Text_Bei = gt.seekNodeByName(self.pSliderOps, "Text_Bei")
    -- 高级选项
    self.pSliderOps.Node_Tips.Text_AdvanceOps = gt.seekNodeByName(self.pSliderOps, "Text_AdvanceOps")
    -- 特殊牌型
    self.pSliderOps.Node_Tips.Text_Ops = gt.seekNodeByName(self.pSliderOps, "Text_Ops")
    -- 底分
    self.pSliderOps.Node_Show.Text_Difen = gt.seekNodeByName(self.pSliderOps.Node_Show, "Text_Difen")
    -- 人数
    self.pSliderOps.Node_Show.Text_PlayerNum = gt.seekNodeByName(self.pSliderOps.Node_Show, "Text_PlayerNum")
    -- 付费模式
    self.pSliderOps.Node_Show.Text_Pay = gt.seekNodeByName(self.pSliderOps.Node_Show, "Text_Pay")
    -- 翻倍规则
    self.pSliderOps.Node_Show.Text_Rate = gt.seekNodeByName(self.pSliderOps.Node_Show, "Text_Rate")
    self.pSliderOps.IsShow = false
    self.pSliderOps.IsRunning = false
    local pop = gt.seekNodeByName(self.pSliderOps, "Panel_SlidePop")
    local btn_Show = pop:getChildByName("Btn_Show")
    btn_Show:setZoomScale(0)
    btn_Show:addClickEventListener( function(sender)
        if self.pSliderOps.IsRunning then
            return
        else
            self.pSliderOps.IsRunning = true
        end
        local X = 916
        local minY = 220
        local maxY = 400
        local Times = 50
        local TotalTime = 0.5
        local hidePanels = {
            self.pPlayerNum,
            self.pScore,
            self.pRound,
            self.pPay,
            self.pDoubleRate,
            self.pSliderOps.Node_Tips
        }
        self:hidePopFrame()
        local i = 1
        if not self.pSliderOps.IsShow then
            btn_Show:loadTextureNormal("image/createroom/btn_slider2.png",ccui.TextureResType.plistType)
            self.pSliderOps.Node_Show:setVisible(true)
            pop:runAction(cc.Spawn:create(cc.CallFunc:create( function()
                for i, v in ipairs(hidePanels) do
                    v:runAction(cc.FadeOut:create(TotalTime))
                end
                self.pSliderOps.Node_Show:runAction(cc.FadeIn:create(TotalTime))
            end ), cc.Repeat:create(
            cc.Sequence:create(cc.CallFunc:create( function()
                pop:setContentSize(X, minY + (maxY - minY) * i / Times)
                ccui.Helper:doLayout(pop)
                i = i + 1
                if i == Times then
                    self.pSliderOps.IsRunning = false
                    self.pSliderOps.IsShow = true
                    self.pSliderOps.Node_Tips:setVisible(false)
                end
            end ), cc.DelayTime:create(TotalTime / Times)), Times)))
        else
            btn_Show:loadTextureNormal("image/createroom/btn_slider1.png",ccui.TextureResType.plistType)
            self.pSliderOps.Node_Tips:setVisible(true)
            pop:runAction(cc.Spawn:create(cc.CallFunc:create( function()
                for i, v in ipairs(hidePanels) do
                    v:runAction(cc.FadeIn:create(TotalTime))
                end
                self.pSliderOps.Node_Show:runAction(cc.FadeOut:create(TotalTime))
            end ), cc.Repeat:create(
            cc.Sequence:create(cc.CallFunc:create( function()
                pop:setContentSize(X, minY + (maxY - minY) * (Times - i) / Times)
                ccui.Helper:doLayout(pop)
                i = i + 1
                if i == Times then
                    self.pSliderOps.IsRunning = false
                    self.pSliderOps.IsShow = false
                    self.pSliderOps.Node_Show:setVisible(false)
                end
            end ), cc.DelayTime:create(TotalTime / Times)), Times)))
        end
    end )

    -- 压分规则按钮
    local btnScoreNormal = gt.seekNodeByName(self.pYsScore, "btnScoreNormal")
    btnScoreNormal:setZoomScale(0)
    btnScoreNormal:addClickEventListener( function(sender)
        if not self.bClickPop then
            self.pPopScoreNormal:setVisible(true)
            -- self.pTouchPop:setVisible(true)
        else
            self.pPopScoreNormal:setVisible(false)
            -- self.pTouchPop:setVisible(false)
        end
        self.bClickPop = not self.bClickPop
    end )
    local btnScoreSpecial = gt.seekNodeByName(self.pYsScore, "btnScoreSpecial")
    btnScoreSpecial:setZoomScale(0)
    btnScoreSpecial:addClickEventListener( function(sender)
        if not self.bClickPop then
            self.pPopScoreSpecial:setVisible(true)
            -- self.pTouchPop:setVisible(true)
        else
            self.pPopScoreSpecial:setVisible(false)
            -- self.pTouchPop:setVisible(false)
        end
        self.bClickPop = not self.bClickPop
    end )

    -- 翻倍规则按钮
    local btnDoubleRate = gt.seekNodeByName(self.pDoubleRate, "Button_DoubleRate")
    btnDoubleRate:setZoomScale(0)
    btnDoubleRate:addClickEventListener( function(sender)
        if not self.bClickPop then
            self.pPopDoubleRate:setVisible(true)
            -- self.pTouchPop:setVisible(true)
        else
            self.pPopDoubleRate:setVisible(false)
            -- self.pTouchPop:setVisible(false)
        end
        self.bClickPop = not self.bClickPop
    end )
    -- 下注限制提示语
    local btnWenHaoPledge = gt.seekNodeByName(self.pAdvanceOps, "Btn_WenHaoPledge")
    btnWenHaoPledge:setZoomScale(0)
    btnWenHaoPledge:addClickEventListener( function(sender)
        self.pTouch:setVisible(true)
        self.pledgeLimitTip:setVisible(true)
        self:hidePopFrame()
    end )
    -- 闲家推注提示语
    local btnWenHaoTui = gt.seekNodeByName(self.pAdvanceOps, "Btn_WenHaoTui")
    btnWenHaoTui:setZoomScale(0)
    btnWenHaoTui:addClickEventListener( function(sender)
        self.pTouch:setVisible(true)
        self:hidePopFrame()
        if self.game_id == gt.GameID.NIUNIU then
            self.tuiTip:setVisible(true)
        elseif self.game_id == gt.GameID.SANGONG then
            self.tuiTipSG:setVisible(true)
        end
    end )
    -- 翻倍提示语
    local btnWenHaoDouble = gt.seekNodeByName(self.pAdvanceOps, "Btn_WenHaoDouble")
    btnWenHaoDouble:setZoomScale(0)
    btnWenHaoDouble:addClickEventListener( function(sender)
        self.pTouch:setVisible(true)
        self.doubleTip:setVisible(true)
        self:hidePopFrame()
    end )
    -- 暗抢提示语
    local btnWenHaoSteal = gt.seekNodeByName(self.pAdvanceOps, "Btn_WenHaoSteal")
    btnWenHaoSteal:setZoomScale(0)
    btnWenHaoSteal:addClickEventListener( function(sender)
        self.pTouch:setVisible(true)
        self.stealTip:setVisible(true)
        self:hidePopFrame()
    end )




    --王癞提示语
    local btnLaiziClassic = gt.seekNodeByName(self.pLaizi, "Btn_LaiziClassic")
    if btnLaiziClassic then
        btnLaiziClassic:setZoomScale(0)
        btnLaiziClassic:addClickEventListener(function(sender)
            self.pTouch:setVisible(true)
            self.laiziTip1:setVisible(true)
            self:hidePopFrame()
        end)
    end
    local btnLaiziCrazy = gt.seekNodeByName(self.pLaizi, "Btn_LaiziCrazy")
    if btnLaiziCrazy then
        btnLaiziCrazy:setZoomScale(0)
        btnLaiziCrazy:addClickEventListener(function(sender)
            self.pTouch:setVisible(true)
            self.laiziTip2:setVisible(true)
            self:hidePopFrame()
        end)
    end

    self.pOptions = lstConfs:getChildByName("Panel_Options")
    --闲家买码提示语
    local btnBuyPledge = gt.seekNodeByName(self.pOptions, "Btn_BuyPledge")
    if btnBuyPledge then
        btnBuyPledge:setZoomScale(0)
        btnBuyPledge:addClickEventListener(function(sender)
            self.pTouch:setVisible(true)
            self.buyPledgeTip:setVisible(true)
            self:hidePopFrame()
        end)
    end
    --屏蔽中途禁止加入 默认不开启
    self.pOptions:getChildByTag(7):setSelected(false)
    self.pOptions:getChildByTag(7):setVisible(false)
    self.pPopCardsType = gt.seekNodeByName(self.pOptions, "Panel_PopCardsType")
    self.pPopCardsType:setVisible(false)
    self.lbSelCardsType = gt.seekNodeByName(self.pOptions, "Label_SelCardsType")
    -- 特殊牌型弹出按钮
    local btnCardsType = gt.seekNodeByName(self.pOptions, "Button_CardsType")
    btnCardsType:setZoomScale(0)
    btnCardsType:addClickEventListener( function(sender)

        if not self.bClickPop then
            self.pPopCardsType:setVisible(true)
            self:refreshPopCardsType()
            -- self.pTouchPop:setVisible(true)
        else
            self.pPopCardsType:setVisible(false)
            -- self.pTouchPop:setVisible(false)
        end
        self.bClickPop = not self.bClickPop
    end )

    --扎金花（底注）
    local textBet = gt.seekNodeByName(self.pBottomBet,"Text_BttmBet")
    local minuseBtn = gt.seekNodeByName(self.pBottomBet,"Btn_Minuse")
    local addBtn = gt.seekNodeByName(self.pBottomBet,"Btn_Add")
    self.addBtn = addBtn
    self.minuseBtn = minuseBtn
    gt.addBtnPressedListener(minuseBtn,function ()
        local betNum = tonumber(textBet:getString())
        betNum = betNum - 1
        betNum = math.max(betNum,1)
        textBet:setString(betNum)
        if betNum == 1 then
            minuseBtn:setEnabled(false)
        end
        addBtn:setEnabled(true)
    end)
    gt.addBtnPressedListener(addBtn,function ()
        local betNum = tonumber(textBet:getString())
        betNum = betNum + 1
        betNum = math.min(betNum,5)
        textBet:setString(betNum)
        if betNum == 5 then
            addBtn:setEnabled(false)
        end
        minuseBtn:setEnabled(true)
    end)

    self.pOptionsSG = lstConfs:getChildByName("Panel_OptionsSG")
    --屏蔽中途禁止加入 默认不开启
    self.pOptionsSG:getChildByTag(7):setSelected(false)
    self.pOptionsSG:getChildByTag(7):setVisible(false)
    self:setPersonalSel()

    --推筒子
    --观战设置
    --self.pWatcher=lstConfs:getChildByName("Panel_Watcher")
    --压分选项
    self.pRateSelTTZ=lstConfs:getChildByName("Panel_RateSelTTZ")
    --玩法设置
    self.pOptionsTTZ=lstConfs:getChildByName("Panel_OptionsTTZ")


    self.panels = {
        self.pPlayerNum,
        self.pRound,
        self.pPay,
        self.pDoubleRate,
        self.pScore,
        self.pQHScore,
       
        self.pQHBaseScore,
        self.pBaseScore,
        self.pBanker,
        self.pOpenNum,
        self.pRateSel,
        self.pBetNum,
        self.pAdvanceOps,
        self.pOptions,
        self.pOptionsSG,
        self.pSliderOps,
        self.pAutoStart,
		self.pRateTuizhu,
		--self.pWatcher,
		self.pRateSelTTZ,
		self.pOptionsTTZ,
        self.pRoundZJH,
        self.pBottomBet,
        self.pMaxTurn, 
        self.pMaxBets, 
        self.pCmpType, 
        self.pOpsZJH,
        --self.pOpsView,
        self.pLaizi,
        self.pPlayerNum12,
        self.pYsScore,
        self.pSgScore,
        self.pCmpZJH,
	    self.pTTZScore,
    }
    for i, p in ipairs(self.panels) do
        p:retain()
    end

    self.lstConfs = lstConfs
    -- 单选按钮处理
    local radios = {
        self.pPlayerNum,
        self.pRound,
        self.pDoubleRate,
        self.pPay,
        self.pScore, --5
        self.pQHScore, 
        self.pQHBaseScore,
        self.pBaseScore,
        self.pBanker,
        self.pOpenNum,--10
        self.pRateSel,
        self.pBetNum,
        self.pRateTuizhu,
        self.pAutoStart,
        self.pRateSelTTZ,--15
        self.pRoundZJH,
        self.pMaxTurn, 
        self.pMaxBets, 
        self.pCmpType,
        self.pLaizi,--20
        self.pPlayerNum12,
        self.pYsScore,
        self.pPopScoreNormal,
        self.pPopScoreSpecial,
        self.pPopZjhXi, --25
        self.pPopZjhMen, 
        self.pPopZjhDrop, 
        self.pSgScore, 
        self.pPopHua, 
        self.pPopZjhBaoXi,  --30
        self.pCmpZJH,  
        self.pTTZScore,  
    }

    for i, v in ipairs(radios) do
		for j = 1, 11 do
            local radio = v:getChildByTag(j)
            if i == 3 then
                local pPop = v:getChildByName("Panel_PopDoubleRate")
                radio = pPop:getChildByTag(j)
            end
            if radio then
                radio:setZoomScale(0)
                radio:addTouchEventListener( function(sender, eventType)
                    if eventType ~= ccui.TouchEventType.canceled and eventType ~= ccui.TouchEventType.ended then
                        return true
                    end
                    sender:setSelected(true)
                    if i ~= 3 then
                        self:hidePopFrame()
                    end
                    local parent = sender:getParent()
                    local tag = sender:getTag()
					for k = 1, 11 do
                        local btn = parent:getChildByTag(k)
                        if not btn then
                            break
                        end
                        if k ~= tag then
                            btn:setSelected(false)
                        else
                            btn:setSelected(true)
                        end
                    end
                    if i == 3 then
                        -- 选择翻倍规则
                        self:setDoubelRateSel()
                    end
                    if i == 4 then
                        self:setPayType()
                    end
                    if i == 1 or i == 2 or i == 16 or i == 21 then
                        -- 选择人数或者选择局数
                        self:setRoomConsume()
                    end
                    if i == 21 then
                        --选择人数    
                        self:setWuHua()
                        -- self:setScoreSel()
                    end
                    if i == 9 then
                        -- 选择上庄
                        self:setBanker9()
                    end
                    if i == 11 then
                        self:setRateSel()
                    end
                    if i == 5 then
                        self:setScoreType()
                    end
                    if i == 1 then
                        self:setPlayerNum()
                    end
                    if i == 13 then
                        self:setRateTuizhu()
                    end                   
                    if i == 22 or i == 23 or i == 24 then
                        self:setScoreSpecialSel()
                    end
                    if i == 25 then
                        self:setZjhXiSel()
                    end
                    if i == 26 then
                        self:setZjhMenSel()
                    end
                    if i == 27 then
                        self:setZjhDropSel()
                    end                         
                    if i == 28 then
                        self:setSgBigSmallSel()
                    end                         
                    if i == 29 then
                        self:setPopHuaSel()
                    end                         
                    if i == 30 then
                        self:setZjhBaoXiSel()
                    end                   
                    -- if i == 20 then
                    --     self:setLaizi()
                    -- end
                    --[[if i == 16 then
                        self:setMaxTurns()
                    end
                    if i == 17 then
                        self:setMaxBets()
                    end
                    if i == 18 then
                        self:setCmpType()
                    end--]]
				end)
			else
				break
			end
		end
	end

    -- 高级选项
    for i = 1, 6 do
        local radio = self.pAdvanceOps:getChildByTag(i)
        if radio then
            radio:setZoomScale(0)
            radio:addTouchEventListener( function(sender, eventType)
                if eventType ~= ccui.TouchEventType.canceled and eventType ~= ccui.TouchEventType.ended then
                    return true
                end
                self:hidePopFrame()
                self:setAdvanceType()
            end )
        else
            break
        end
    end

    -- 牛牛个性选择
	for i = 1, 15 do
        local radioName = string.format("Check_%d", i)
        local radio = gt.seekNodeByName(self.pOptions, radioName)
	 if not radio then
            radio = gt.seekNodeByName(self.pPopCardsType, radioName)
        end        
        if not radio then
            radio = gt.seekNodeByName(self.pLaizi, radioName)
        end
        -- self.pOptions:getChildByTag(i)
        if radio then
            radio:setZoomScale(0)
            radio:addTouchEventListener( function(sender, eventType)
                if eventType ~= ccui.TouchEventType.canceled and eventType ~= ccui.TouchEventType.ended then
                    return true
                end
                if i <= 5 or i >= 10 then
                    self:setCardsTypeSel()
                else
                    self:hidePopFrame()
                end
                -- 无花牌勾选后，隐藏银牛金牛并发送不勾选给服务器
                if i == 2 or i == 6 then
                    -- 五小牛，无花牌选项
                    self:setWuHua()
                end
                -- 托管（快速游戏）勾选后禁止搓牌要自动勾选
                if i == 8 or i == 15 then
                    local noRubCard = self.pOptions:getChildByTag(9)
                    local radio8 = self.pOptions:getChildByTag(8)
                    local radio15 = self.pOptions:getChildByTag(15)
                    if sender:isSelected() then
                        noRubCard:setSelected(true)
                        noRubCard:setTouchEnabled(false)
                    else
                        noRubCard:setSelected(false)
                        radio8:setSelected(false)
                        radio15:setSelected(false)

                        noRubCard:setTouchEnabled(true)                    
                    end
                end

                if i == 14 then

                    local wuhua = self.pLaizi:getChildByTag(6)
                    if sender:isSelected() then
                        wuhua:setSelected(true)
                    else
                        -- wuhua:setSelected(false)                  
                    end
                end
                self:setOptionTip()
            end )
        else
            break
        end
    end

    -- 三公个性选择
    for i = 7, 9 do
        local radio = self.pOptionsSG:getChildByTag(i)
        if radio then
            radio:setZoomScale(0)
            radio:addTouchEventListener( function(sender, eventType)
                if eventType ~= ccui.TouchEventType.canceled and eventType ~= ccui.TouchEventType.ended then
                    return true
                end
                self:hidePopFrame()
                -- 托管（快速游戏）勾选后禁止搓牌要自动勾选
                if i == 8 then
                    local noRubCard = self.pOptionsSG:getChildByTag(9)
                    if sender:isSelected() then
                        noRubCard:setSelected(true)
                        noRubCard:setTouchEnabled(false)
                    else
                        noRubCard:setSelected(false)
                        noRubCard:setTouchEnabled(true)
                    end
                end
            end )
        else
            break
        end
    end

    --推筒子观战设置
    --for i = 7,7 do
    --    local radio =self.pWatcher:getChildByTag(i)
    --    if radio then
    --        radio:setZoomScale(0)
    --        radio:addTouchEventListener( function(sender, eventType)
    --            if eventType ~= ccui.TouchEventType.canceled and eventType ~= ccui.TouchEventType.ended then
    --                return true
    --            end
	--
    --        end )
    --    end
    --end
    --推筒子玩法设置
    for i = 1,1 do
        local radio = self.pOptionsTTZ:getChildByTag(i)
        if radio then
            radio:setZoomScale(0)
            radio:addTouchEventListener( function(sender, eventType)
                if eventType ~= ccui.TouchEventType.canceled and eventType ~= ccui.TouchEventType.ended then
                    return true
                end
                --self:setOptionsTTZ(i)
            end )
        end
    end
	--扎金花个性选择
    for i=1,5 do 
        local radio = self.pOpsZJH:getChildByTag(i)
		if radio then
			radio:setZoomScale(0)
			radio:addTouchEventListener(function(sender, eventType)
				if eventType ~= ccui.TouchEventType.canceled and eventType ~= ccui.TouchEventType.ended then
                    return true
                end
                self:hidePopFrame()
            end)
        end
    end

    --读取本地设置

    local localGameidType = ""
    local setting = ""
    if guild_id and match == 0 then
        --俱乐部
        setting = cc.UserDefault:getInstance():getStringForKey(self.storageKeyClub, "")
        localGameidType = cc.UserDefault:getInstance():getStringForKey(self.storageKeyClubGameIdType, "")
    elseif guild_id and match == 1 then
        --比赛场
        setting = cc.UserDefault:getInstance():getStringForKey(self.storageKeyMatch, "")
        localGameidType = cc.UserDefault:getInstance():getStringForKey(self.storageKeyMatchGameIdType, "")
    else
        --普通场
        setting = cc.UserDefault:getInstance():getStringForKey(self.storageKey, "")
        localGameidType = cc.UserDefault:getInstance():getStringForKey(self.storageKeyGameIdType, "")
    end

    

   if (localGameidType ~= "") then
       localGameidType = json.decode(localGameidType)

         -- 选中上次记录的游戏类型和玩法类型
        self.game_type = localGameidType.game_type
        if localGameidType.game_id then
            self.game_id = localGameidType.game_id
        end
    end

    local roomSetting = ""

    if (setting ~= "") then
        roomSetting = json.decode(setting)
    end
    if (roomSetting ~= "") then
       

        -- 房间人数
        local bValid = gt.inTable( { 6, 8, 10 }, roomSetting.max_chairs)
        if (bValid) then
            for i = 1, 3 do
                self.pPlayerNum:getChildByTag(i):setSelected(false)
            end
            if roomSetting.max_chairs == 6 then
                self.pPlayerNum:getChildByTag(1):setSelected(true)
            elseif roomSetting.max_chairs == 8 then
                self.pPlayerNum:getChildByTag(3):setSelected(true)
            elseif roomSetting.max_chairs == 10 then
                self.pPlayerNum:getChildByTag(2):setSelected(true)
            end
        end     
        if self.game_id == gt.GameID.NIUNIU or self.game_id == gt.GameID.QIONGHAI or self.game_id == gt.GameID.NIUYE then
            local bValid = gt.inTable( { 6, 8, 10 ,12 }, roomSetting.max_chairs)
            if (bValid) then
                for i = 1, 4 do
                    self.pPlayerNum12:getChildByTag(i):setSelected(false)
                end
                if roomSetting.max_chairs == 6 then
                    self.pPlayerNum12:getChildByTag(1):setSelected(true)
                elseif roomSetting.max_chairs == 8 then
                    self.pPlayerNum12:getChildByTag(3):setSelected(true)
                elseif roomSetting.max_chairs == 10 then
                    self.pPlayerNum12:getChildByTag(2):setSelected(true)
                elseif roomSetting.max_chairs == 12 then
                    self.pPlayerNum12:getChildByTag(4):setSelected(true)
                end
            end
        end
        self:setPlayerNum()

        -- 房间局数
        local bValid = gt.inTable( { 10, 20 , 30}, roomSetting.rounds)
        if (bValid) then
            for i = 1, 3 do
                self.pRound:getChildByTag(i):setSelected(false)
            end
            if roomSetting.rounds == 10 then
                self.pRound:getChildByTag(1):setSelected(true)
            elseif roomSetting.rounds == 20 then
                self.pRound:getChildByTag(2):setSelected(true)
            else
                self.pRound:getChildByTag(3):setSelected(true)
            end
        end

        if self.game_id == gt.GameID.ZJH then 
            local bValid = gt.inTable( { 6 , 9 , 12}, roomSetting.rounds)
            if (bValid) then
                for i = 1, 3 do
                    self.pRoundZJH:getChildByTag(i):setSelected(false)
                end
                if roomSetting.rounds == 6 then
                    self.pRoundZJH:getChildByTag(1):setSelected(true)
                elseif roomSetting.rounds == 9 then
                    self.pRoundZJH:getChildByTag(2):setSelected(true)
                else
                    self.pRoundZJH:getChildByTag(3):setSelected(true)
                end
            end

            bValid = gt.inTable( { 0, 1, 2, 3}, roomSetting.zjh_bipai)
            if (bValid) then
                for i = 1, 4 do
                    self.pCmpZJH:getChildByTag(i):setSelected(false)
                end
                if roomSetting.zjh_bipai == 0 then
                    self.pCmpZJH:getChildByTag(1):setSelected(true)
                elseif roomSetting.zjh_bipai == 1 then
                    self.pCmpZJH:getChildByTag(2):setSelected(true)
                elseif roomSetting.zjh_bipai == 2 then
                    self.pCmpZJH:getChildByTag(3):setSelected(true)
                else
                    self.pCmpZJH:getChildByTag(4):setSelected(true)
                end
            end
        end

        -- 选择房费 1是房主付费 2是AA付费
        bValid = gt.inTable( { 1, 2 }, roomSetting.pay)
        if (bValid) then
            for i = 1, 2 do
                self.pPay:getChildByTag(i):setSelected(false)
            end
            if roomSetting.pay == 1 then
                self.pPay:getChildByTag(2):setSelected(true)
            else
                self.pPay:getChildByTag(1):setSelected(true)
            end
        end
        self:setPayType()

        -- 选择翻倍类型  1是牛八—牛九2倍，牛牛3倍   2是牛七—牛九2倍，牛牛4倍   4是牛七—牛九2倍，牛牛3倍
        bValid = gt.inTable({2,3,4,5}, roomSetting.double_type)
        if (bValid) then
            for i = 1, 4 do
                local radio = self.pPopDoubleRate:getChildByTag(i)
                if radio then
                    radio:setSelected(false)
                end
            end
            if (roomSetting.double_type == 5) then
                self.pPopDoubleRate:getChildByTag(4):setSelected(true)
                
            elseif (roomSetting.double_type == 4) then
                self.pPopDoubleRate:getChildByTag(3):setSelected(true)
            else
                self.pPopDoubleRate:getChildByTag(roomSetting.double_type):setSelected(true)
            end
            self:setDoubelRateSel()
        end

                --扎金花
        if self.game_id == gt.GameID.ZJH then
            --喜牌
            local selScores = { 0, 1, 2, 3, 4 }
            bValid = gt.inTable(selScores, roomSetting.zjh_xiqian)
            if (bValid) then
                for i = 1, 5 do
                    local radio = self.pPopZjhXi:getChildByTag(i)
                    if radio then
                        radio:setSelected(false)
                    end
                    if roomSetting.zjh_xiqian == selScores[i] then
                        self.pPopZjhXi:getChildByTag(i):setSelected(true)
                    end
                end
            end  

            --豹子喜牌
            selScores = { 0, 1, 2, 3, 4 }
            bValid = gt.inTable(selScores, roomSetting.zjh_xiqian2)
            if (bValid) then
                for i = 1, 5 do
                    local radio = self.pPopZjhBaoXi:getChildByTag(i)
                    if radio then
                        radio:setSelected(false)
                    end
                    if roomSetting.zjh_xiqian2 == selScores[i] then
                        self.pPopZjhBaoXi:getChildByTag(i):setSelected(true)
                    end
                end
            end

            selScores = { 0,1,2,3,4,5,6,7,8,9,10}
            bValid = gt.inTable(selScores, roomSetting.zjh_menpai)
            if (bValid) then
                for i = 1, 11 do
                    local radio = self.pPopZjhMen:getChildByTag(i)
                    if radio then
                        radio:setSelected(false)
                    end
                    if roomSetting.zjh_menpai == selScores[i] then
                        self.pPopZjhMen:getChildByTag(i):setSelected(true)
                    end
                end
            end

            selScores = { 15,30,60,90,120}
            bValid = gt.inTable(selScores, roomSetting.zjh_qipai)
            if (bValid) then
                for i = 1, 5 do
                    local radio = self.pPopZjhDrop:getChildByTag(i)
                    if radio then
                        radio:setSelected(false)
                    end
                    if roomSetting.zjh_qipai == selScores[i] then
                        self.pPopZjhDrop:getChildByTag(i):setSelected(true)
                    end
                end
            end

            self:setZjhXiSel()
            self:setZjhBaoXiSel()
            self:setZjhMenSel()
            self:setZjhDropSel()
        end

        -- 闲家买码
        if self.game_id == gt.GameID.QIONGHAI or self.game_id == gt.GameID.NIUYE or self.game_id == gt.GameID.NIUNIU then

            local radioBuyPledge = gt.seekNodeByName(self.pOptions, "Check_buyPledge")
            if radioBuyPledge then

                radioBuyPledge:setSelected(roomSetting.buy_pledge and roomSetting.buy_pledge > 0)
            end
        end

        -- 选择分数
        if self.game_id == gt.GameID.QIONGHAI then
            -- 琼海抢庄的闲家倍数相当于明牌抢庄的底分选择
            local selScores = { 5, 8 }
            bValid = gt.inTable(selScores, roomSetting.score)
            if (bValid) then
                for i = 1, 2 do
                    self.pQHScore:getChildByTag(i):setSelected(false)
                    if roomSetting.score == selScores[i] then
                        self.pQHScore:getChildByTag(i):setSelected(true)
                    end
                end
            end
        elseif self.game_id == gt.GameID.TTZ then
            local selScores = { 1,2,3,4,5,6}
            bValid = gt.inTable(selScores, roomSetting.score)
            if (bValid) then
                for i = 1, 6 do
                    self.pTTZScore:getChildByTag(i):setSelected(false)
                    if roomSetting.score == selScores[i] then
                        self.pTTZScore:getChildByTag(i):setSelected(true)
                    end
                end
            end

        elseif self:isScoreSpecial() then
            local selSpecialIndex = 1
            if roomSetting.score >= 11 and roomSetting.score <= 16 then
                local selScores = { 11,12,13,14,15,16}
                bValid = gt.inTable(selScores, roomSetting.score)
                if (bValid) then 
                    for i = 1, 6 do
                        self.pPopScoreSpecial:getChildByTag(i):setSelected(false)
                        if roomSetting.score == selScores[i] then
                            self.pPopScoreSpecial:getChildByTag(i):setSelected(true)
                        end
                    end
                end

                selSpecialIndex = 2
            else
                local selScores = {1,2,3,4,5}
                bValid = gt.inTable(selScores, roomSetting.score)
                if (bValid) then
                    for i = 1, 5 do
                        self.pPopScoreNormal:getChildByTag(i):setSelected(false)
                        if roomSetting.score == selScores[i] then
                            self.pPopScoreNormal:getChildByTag(i):setSelected(true)
                        end
                    end
                end

                selSpecialIndex = 1
            end

            for i = 1, 2 do
                self.pYsScore:getChildByTag(i):setSelected(false)
                if i == selSpecialIndex then
                    self.pYsScore:getChildByTag(i):setSelected(true)
                end
            end

            self:setScoreSpecialSel()
        else
            -- 1,2,3,4,5分
            local selScores = {1,2,3,4,5}
            if self.game_id == gt.GameID.NIUNIU or self.game_id == gt.GameID.NIUYE then
                if (self.game_type == 5) then
                    --通比牛牛  2,4,6,8,10分
                    selScores = {2,4,6,8,10}
                end
            elseif self.game_id == gt.GameID.SANGONG then
                -- if (self.game_type == gt.GameType.GAME_SG_BIGSMALL) then
                --     selScores = { 20, 100, 200 }
                -- else
                    selScores = { 5, 10, 20 }
                -- end
            end
            bValid = gt.inTable(selScores, roomSetting.score)
            if (bValid) then
                for i = 1, 5 do
                    self.pScore:getChildByTag(i):setSelected(false)
                    if roomSetting.score == selScores[i] and self.pScore:getChildByTag(i):isVisible() then
                        self.pScore:getChildByTag(i):setSelected(true)
                    end
                end
            end
        end
        self:setScoreType()

        -- 琼海抢庄的房间底分选择 1,2,3,4,5分
        bValid = gt.inTable( { 1, 2, 3, 4, 5 }, roomSetting.qh_base_score)
        if bValid then
            for i = 1, 5 do
                self.pQHBaseScore:getChildByTag(i):setSelected(false)
                if i == roomSetting.qh_base_score then
                    self.pQHBaseScore:getChildByTag(i):setSelected(true)
                end
            end
        end

        -- 下注封顶
        if self.game_id == gt.GameID.SANGONG and self.game_type == 7 then
            bValid = gt.inTable({100,500,1000}, roomSetting.sg_score)
            if (bValid) then
                for i = 1, 3 do
                    self.pSgScore:getChildByTag(i):setSelected(false)
                end
                if (roomSetting.sg_score == 100) then
                    self.pSgScore:getChildByTag(1):setSelected(true)
                elseif (roomSetting.sg_score == 500) then
                    self.pSgScore:getChildByTag(2):setSelected(true)
                elseif (roomSetting.sg_score == 1000) then
                    self.pSgScore:getChildByTag(3):setSelected(true)
                end
            end 
            self:setSgBigSmallSel()
        end

        -- 庄家底分 400， 600
        bValid = gt.inTable( { 400, 600 }, roomSetting.base_score)
        if (bValid) then
            for i = 1, 2 do
                self.pBaseScore:getChildByTag(i):setSelected(false)
            end
            if (roomSetting.base_score == 400) then
                self.pBaseScore:getChildByTag(1):setSelected(true)
            else
                self.pBaseScore:getChildByTag(2):setSelected(true)
            end
        end

        -- 选择上庄  1房主坐庄, 2轮流坐庄, 3牛牛上庄 4牌大坐庄（三公的牌大坐庄是3）
        bValid = gt.inTable({1,2,3,4}, roomSetting.banker)
        if bValid then
            for i = 1, 4 do
                self.pBanker:getChildByTag(i):setSelected(false)
            end
            self.pBanker:getChildByTag(roomSetting.banker):setSelected(true)
        end

        -- 明牌张数  3张，4张
        bValid = gt.inTable( { 3, 4 }, roomSetting.cards_count)
        if bValid then
            for i = 1, 2 do
                self.pOpenNum:getChildByTag(i):setSelected(false)
            end
            if (roomSetting.cards_count == 3) then
                self.pOpenNum:getChildByTag(1):setSelected(true)
            else
                self.pOpenNum:getChildByTag(2):setSelected(true)
            end
        end

        -- 倍数选择 1，2，3，4倍
        bValid = gt.inTable( { 1, 2, 3, 4 }, roomSetting.loot_dealer)
        if bValid then
            for i = 1, 4 do
                self.pRateSel:getChildByTag(i):setSelected(false)
            end
            self.pRateSel:getChildByTag(roomSetting.loot_dealer):setSelected(true)
        end
        self:setRateSel()


        local ops6 = tonumber(gt.charAt(roomSetting.options,6))
        local ops14 = tonumber(gt.charAt(roomSetting.options,14))
        for i = 1, 3 do
            self.pPopHua:getChildByTag(i):setSelected(false)
        end
        if ops6 == 0 then
            self.pPopHua:getChildByTag(1):setSelected(true)
        elseif ops6 == 1 and ops14 == 1 then
            self.pPopHua:getChildByTag(2):setSelected(true)
        elseif ops6 == 1 and ops14 == 0 then
            self.pPopHua:getChildByTag(3):setSelected(true)
        end
        self:setPopHuaSel()
        

        --下注次数 炸金牛里的暂时没有


        -- 下注限制  0关闭，1开启
        bValid = gt.inTable( { 0, 1 }, roomSetting.pledge_res)
        if bValid then
            self.pAdvanceOps:getChildByTag(1):setSelected(false)
            if (roomSetting.pledge_res == 1) then
                self.pAdvanceOps:getChildByTag(1):setSelected(true)
            end
			--推筒子
			self.pRateSelTTZ:getChildByTag(1):setSelected(roomSetting.pledge_res==0)
			self.pRateSelTTZ:getChildByTag(2):setSelected(roomSetting.pledge_res==1)
        end

        -- 闲家推注  0关闭，5倍
        if self.game_id == gt.GameID.NIUNIU or self.game_id == gt.GameID.SANGONG then
            bValid = gt.inTable( { 0, 5 }, roomSetting.push_pledge)
            if bValid then
                self.pAdvanceOps:getChildByTag(2):setSelected(false)
                if (roomSetting.push_pledge == 5) then
                    self.pAdvanceOps:getChildByTag(2):setSelected(true)
                end
            end
        elseif self.game_id == gt.GameID.NIUYE then
            bValid = gt.inTable( { 0, 5, 10, 20 }, roomSetting.push_pledge)
            if bValid then
                for i = 1, 4 do
                    self.pRateTuizhu:getChildByTag(i):setSelected(false)
                end
                local index = 1
                if roomSetting.push_pledge == 5 then
                    index = 2
                elseif roomSetting.push_pledge == 10 then
                    index = 3
                elseif roomSetting.push_pledge == 20 then
                    index = 4
                end
                self.pRateTuizhu:getChildByTag(index):setSelected(true)
            end
            self:setRateTuizhu()
        end

        -- 翻倍  0关闭，1开启(只有牛牛的明牌和自由抢庄有)
        bValid = gt.inTable( { 0, 1 }, roomSetting.pledge_double)
        if bValid then
            self.pAdvanceOps:getChildByTag(6):setSelected(false)
            if roomSetting.pledge_double == 1 then
                self.pAdvanceOps:getChildByTag(6):setSelected(true)
            end
        end
        self:setAdvanceType()

        -- 暗抢  0关闭，1开启
        if (roomSetting.steal ~= nil) then
            bValid = gt.inTable( { 0, 1 }, roomSetting.steal)
            if bValid then
                self.pAdvanceOps:getChildByTag(3):setSelected(false)
                if (roomSetting.steal == 1) then
                    self.pAdvanceOps:getChildByTag(3):setSelected(true)
                end
            end
        end   

        if (roomSetting.laizi ~= nil) then
            bValid = gt.inTable({0,1,2}, roomSetting.laizi)
            if bValid then
                for i = 1, 3 do
                    self.pLaizi:getChildByTag(i):setSelected(false)
                end
                local index = 1
                if roomSetting.laizi == 1 then
                    index = 2
                elseif roomSetting.laizi == 2 then
                    index = 3
                end
                self.pLaizi:getChildByTag(index):setSelected(true)
            end
        end

        -- 9点庄大 0关闭，1开启(只有三公霸王庄玩法的霸王庄模式有)
        bValid = gt.inTable( { 0, 1 }, roomSetting.banker9)
        if bValid then
            self.pAdvanceOps:getChildByTag(4):setSelected(false)
            if (roomSetting.banker9 == 1) then
                self.pAdvanceOps:getChildByTag(4):setSelected(true)
            end
        end

        -- 切牌/摇色子  0关闭，1开启(只有三公霸王庄玩法有)
        bValid = gt.inTable( { 0, 1 }, roomSetting.cut_dice)
        if bValid then
            self.pAdvanceOps:getChildByTag(5):setSelected(false)
            if roomSetting.cut_dice == 1 then
                self.pAdvanceOps:getChildByTag(5):setSelected(true)
            end
        end

        -- 个性选择
        for i = 1, string.len(roomSetting.options) do
            local radioName = string.format("Check_%d", i)
            local radio = gt.seekNodeByName(self.pOptions, radioName)
            if not radio then
                radio = gt.seekNodeByName(self.pPopCardsType, radioName)
            end
            if not radio then
                radio = gt.seekNodeByName(self.pLaizi, radioName)
            end
            radio:setSelected(false)
            local ops = tonumber(gt.charAt(roomSetting.options, i))
            if ops == 1 then
                radio:setSelected(true)
            end
            if i == 7 or i == 8 or i == 9 then
                self.pOptionsSG:getChildByTag(i):setSelected(false)
                if ops == 1 then
                    self.pOptionsSG:getChildByTag(i):setSelected(true)
                end
            end
            if i==7 then
                radio:setSelected(false)
                self.pOptionsSG:getChildByTag(7):setSelected(false)
            end
            -- if i == 6 or i == 14 then
            --     if roomSetting.max_chairs > 6 then
            --         self.pLaizi:getChildByTag(i):setVisible(false)
            --     else
            --         self.pLaizi:getChildByTag(i):setVisible(true)
            --     end
            -- end
        end
        --推筒子参数
        --28杠
        bValid = gt.inTable({1,0},roomSetting.two_eight)
        if bValid then
            self.pOptionsTTZ:getChildByTag(1):setSelected(bValid==1)
        end
        --bValid=gt.inTable({1,0},roomSetting.watcher)
        --if bValid then
        --    self.pWatcher:getChildByTag(7):setSelected(bValid==1)
        --end


        if self.game_id == gt.GameID.ZJH then
            for i=1,3 do
                self.pOpsZJH:getChildByTag(i):setSelected(false)
                local ops = tonumber(gt.charAt(roomSetting.options,i))
                if ops == 1 then
                    self.pOpsZJH:getChildByTag(i):setSelected(true)
                end
            end

            --watch
            if roomSetting.zjh_watch then
                self.pOpsZJH:getChildByTag(4):setSelected( roomSetting.zjh_watch > 0 )
            end

            -- straight bigger than flush
            if roomSetting.zjh_straight_big then
                self.pOpsZJH:getChildByTag(5):setSelected( roomSetting.zjh_straight_big > 0 )
            end
            
            --self.pOpsView:getChildByTag(1):setSelected(false)
            --local ops = tonumber(gt.charAt(roomSetting.options,6))
            --if ops == 1 then
            --    self.pOpsView:getChildByTag(1):setSelected(true)
            --end
        end

        --自动开桌
        bValid=gt.inTable({1,2,3,4},roomSetting.auto_player_num_index)
        if bValid then
            for i = 1,4 do
                self.pAutoStart:getChildByTag(i):setSelected(i==roomSetting.auto_player_num_index)
            end
        end

        --底注
        if roomSetting.zjh_base_score and tonumber(roomSetting.zjh_base_score) > 0 then
            gt.seekNodeByName(self.pBottomBet, "Text_BttmBet"):setString(roomSetting.zjh_base_score)
            if roomSetting.zjh_base_score == 1 then
                self.minuseBtn:setEnabled(false)
            elseif roomSetting.zjh_base_score == 5 then
                self.addBtn:setEnabled(false)
            end
        end
        
        --压分回合（最大回合数）
        bValid = gt.inTable({10,20,30}, roomSetting.now_rounds)
        if bValid then
            for i = 1, 3 do
                self.pMaxTurn:getChildByTag(i):setSelected(false)
            end
            if (roomSetting.now_rounds == 10) then
                self.pMaxTurn:getChildByTag(1):setSelected(true)
            elseif (roomSetting.now_rounds == 20) then
                self.pMaxTurn:getChildByTag(2):setSelected(true)
            else
                self.pMaxTurn:getChildByTag(3):setSelected(true)
            end
        end

        --压分选项（最大压分）
        bValid = gt.inTable({10,20,30}, roomSetting.score)
        if bValid then
            for i = 1, 3 do
                self.pMaxBets:getChildByTag(i):setSelected(false)
            end
            if (roomSetting.score == 10) then
                self.pMaxBets:getChildByTag(1):setSelected(true)
            elseif (roomSetting.score == 20) then
                self.pMaxBets:getChildByTag(2):setSelected(true)
            else
                self.pMaxBets:getChildByTag(3):setSelected(true)
            end
        end
        
        --同牌比较
        bValid = gt.inTable({0,1}, roomSetting.compare_type)
        if bValid then
            for i = 1, 2 do
                self.pCmpType:getChildByTag(i):setSelected(false)
            end
            if (roomSetting.compare_type == 0) then
                self.pCmpType:getChildByTag(1):setSelected(true)
            else
                self.pCmpType:getChildByTag(2):setSelected(true)
            end
        end

        self:setPersonalSel()
        self:setCardsTypeSel()
    end
    -- 无论设置是否存在都要显示这个tip
    self:setPlayerNum()
    self:setPayType()
    self:setDoubelRateSel()
    self:setScoreSpecialSel()
    self:setSgBigSmallSel()
    self:setZjhXiSel()
    self:setZjhBaoXiSel()
    self:setZjhMenSel()
    self:setZjhDropSel()
    self:setPopHuaSel()
    self:setScoreType()
    self:setRateSel()
    self:setRateTuizhu()
    self:setOptionTip()

    local itemName = string.format("CB_Game%d", self.game_id)
    local selCBGame = self.listViewTypes:getChildByName(itemName)
    if selCBGame then
        itemName = string.format("Panel_Item%d", self.game_id)
        local pItem = self.listViewTypes:getChildByName(itemName)
        local size = pItem:getContentSize()
        self:initSelGameType()
        self:selGameType(selCBGame, pItem, size)
    end
    -- selCBGame:setSelected(true)
    --TODO  temp
    -- selCBGame:setEnabled(false)

    self:setRoomConsume()
    --self:setScoreSel()

	-- 创建房间按钮
    local createBtn = gt.seekNodeByName(self, "Btn_Create")
    local lblOk = createBtn:getChildByName("lblOk")
    -- if lblOk then
    --     lblOk:setVisible(false)
    -- end
	if guild_id then
       
		-- createBtn:loadTextureNormal("image/common/an12_n.png")
        -- if lblOk then
        --     lblOk:setVisible(true)
        -- end
        lblOk:setString("确 定")

		if match > 0 then
            --比赛屏蔽三公
			-- self.listViewTypes:getChildByName("CB_Game2"):setVisible(false)
			-- self.listViewTypes:getChildByName("Panel_Item2"):setVisible(false)
			-- self.listViewTypes:getChildByName("CB_Game5"):setVisible(false)
			-- self.listViewTypes:getChildByName("Panel_Item5"):setVisible(false)
			-- --比赛屏蔽扎金花
   --          if self.listViewTypes:getChildByName("CB_Game6") then
   --              self.listViewTypes:getChildByName("CB_Game6"):setVisible(false)
   --          end
   --          if self.listViewTypes:getChildByName("Panel_Item6") then
   --  			self.listViewTypes:getChildByName("Panel_Item6"):setVisible(false)
   --          end
		end
	end

	gt.addBtnPressedListener(createBtn, function()
        
        self:hidePopFrame()	
        local localgameidType = {}
        localgameidType.game_id = self.game_id
        localgameidType.game_type = self.game_type
         localgameidType = json.encode(localgameidType)
       if guild_id and match == 0 then
            --俱乐部
            cc.UserDefault:getInstance():setStringForKey(self.storageKeyClubGameIdType, localgameidType)
        elseif guild_id and match == 1 then
            --比赛场
            cc.UserDefault:getInstance():setStringForKey(self.storageKeyMatchGameIdType, localgameidType)
        else
            --普通场
            cc.UserDefault:getInstance():setStringForKey(self.storageKeyGameIdType, localgameidType)
        end


       if gt.games_config_list[self.game_id] ~= nil  then
                
          self:createGamesRoom(gt.games_config_list[self.game_id])
          return
       end
       
		-- 房间人数
        local max_chairs = 6
        if (self.pPlayerNum:getChildByTag(2):isSelected()) then
            max_chairs = 10
        elseif self.pPlayerNum:getChildByTag(3):isSelected() then
            max_chairs = 8
        end

        if self.game_id == gt.GameID.NIUNIU or self.game_id == gt.GameID.QIONGHAI 
            or self.game_id == gt.GameID.NIUYE then
            if (self.pPlayerNum12:getChildByTag(1):isSelected()) then
                max_chairs = 6
            elseif (self.pPlayerNum12:getChildByTag(2):isSelected()) then
                max_chairs = 10
            elseif self.pPlayerNum12:getChildByTag(3):isSelected() then
                max_chairs = 8
            elseif self.pPlayerNum12:getChildByTag(4):isSelected() then
                max_chairs = 12
            end
        end

        -- 房间局数
        local rounds = 10
        if self.pRound:getChildByTag(2):isSelected() then
            rounds = 20
        elseif self.pRound:getChildByTag(3):isSelected() then
            rounds = 30
        end
        
        if self.game_id == gt.GameID.ZJH then 
            if self.pRoundZJH:getChildByTag(1):isSelected() then
                rounds = CreateRoom.Round.Six
            elseif self.pRoundZJH:getChildByTag(2):isSelected() then
                rounds = CreateRoom.Round.Nine
            elseif self.pRoundZJH:getChildByTag(3):isSelected() then
                rounds = CreateRoom.Round.Twelve
            end
        end

        -- 选择房费 1是房主付费 2是AA付费
        local pay = 2
        if self.pPay:getChildByTag(2):isSelected() then
            pay = 1
        end

        -- 选择翻倍类型  1是牛八2倍，牛九2倍，牛牛3倍  2是牛七2倍，牛八2倍，牛九3倍，牛牛4倍  4是牛七—牛九2倍，牛牛3倍
        local double_type = 1
        if self.pPopDoubleRate:getChildByTag(2):isSelected() then
            double_type = 2
        elseif self.pPopDoubleRate:getChildByTag(3):isSelected() then
            double_type = 4
        elseif self.pPopDoubleRate:getChildByTag(4):isSelected() then
            double_type = 5
        end

        -- 选择分数
        local score = 1
        if self:isScoreSpecial() then
            if self.pYsScore:getChildByTag(1):isSelected() then
                if self.pPopScoreNormal:getChildByTag(1):isSelected() then
                    score = 1
                elseif self.pPopScoreNormal:getChildByTag(2):isSelected() then
                    score = 2
                elseif self.pPopScoreNormal:getChildByTag(3):isSelected() then
                    score = 3
                elseif self.pPopScoreNormal:getChildByTag(4):isSelected() then
                    score = 4
                elseif self.pPopScoreNormal:getChildByTag(5):isSelected() then
                    score = 5
                end
            elseif self.pYsScore:getChildByTag(2):isSelected() then
                if self.pPopScoreSpecial:getChildByTag(1):isSelected() then
                    score = 11
                elseif self.pPopScoreSpecial:getChildByTag(2):isSelected() then
                    score = 12
                elseif self.pPopScoreSpecial:getChildByTag(3):isSelected() then
                    score = 13
                elseif self.pPopScoreSpecial:getChildByTag(4):isSelected() then
                    score = 14
                elseif self.pPopScoreSpecial:getChildByTag(5):isSelected() then
                    score = 15
                elseif self.pPopScoreSpecial:getChildByTag(6):isSelected() then
                    score = 16
                end
            end

        elseif self.game_id == gt.GameID.NIUNIU or self.game_id == gt.GameID.NIUYE then
            for i = 1, 5 do
                if self.pScore:getChildByTag(i):isSelected() then
                    score = i
                    -- 通比牛牛
                    if (self.game_type == 5) then
                        score = i*2
                    end
                end
            end
        elseif self.game_id == gt.GameID.TTZ then
            for i = 1, 6 do
                if self.pTTZScore:getChildByTag(i):isSelected() then
                    score = i
                end
            end
        elseif self.game_id == gt.GameID.SANGONG then
            --三公
		    score = 5
		    if self.pScore:getChildByTag(2):isSelected() then
			    score = 10
		    elseif self.pScore:getChildByTag(3):isSelected() then
			    score = 20
		    end
        elseif (self.game_id == gt.GameID.QIONGHAI and self.game_type == 7) then
            --琼海明牌抢庄
            score = 5
            if self.pQHScore:getChildByTag(2):isSelected() then
                score = 8
            end
        end

        -- 琼海抢庄房间底分
        local qh_base_score = 1
        for i = 1, 5 do
            if self.pQHBaseScore:getChildByTag(i):isSelected() then
                qh_base_score = i
            end
        end

        -- 庄家底分
        local base_score = 400
        if self.pBaseScore:getChildByTag(2):isSelected() then
            base_score = 600
        end

        -- 选择上庄
        local banker = 1
        for i = 1, 4 do
            if self.pBanker:getChildByTag(i):isSelected() then
                banker = i
                break
            end
        end

        -- 明牌张数
        local openNum = 3
        if self.pOpenNum:getChildByTag(2):isSelected() then
            openNum = 4
        end
        -- 暂时屏蔽明牌3张的，默认4张的
        openNum = 4
        -- 三公明牌抢庄默认明2张
        if self.game_id == gt.GameID.SANGONG then
            openNum = 2
        end
        --扎金花3张牌
        if self.game_id == gt.GameID.ZJH then 
            openNum = 3
        end

        -- 倍数选择
        local rate = 1
        if self.pRateSel:getChildByTag(2):isSelected() then
            rate = 2
        elseif self.pRateSel:getChildByTag(3):isSelected() then
            rate = 3
        elseif self.pRateSel:getChildByTag(4):isSelected() then
            rate = 4
        end
        if (self.game_id == gt.GameID.QIONGHAI and self.game_type == 7) then
            --琼海明牌抢庄倍数默认是4倍
            rate = 4
        end

        -- 下注次数
        local betNum = 2
        if self.pBetNum:getChildByTag(2):isSelected() then
            betNum = 3
        end

        -- 下注限制  0关闭，1开启
        local pledge_res = 0
		if self.game_id==gt.GameID.TTZ then
			if self.pRateSelTTZ:getChildByTag(2):isSelected() then
				pledge_res = 1
			end
		else
			if self.pAdvanceOps:getChildByTag(1):isSelected() then
				pledge_res = 1
			end
		end


        -- 闲家推注 0关闭，5倍
        local push_pledge = 0
        if self.game_id == gt.GameID.NIUNIU or self.game_id == gt.GameID.SANGONG then
            if self.pAdvanceOps:getChildByTag(2):isSelected() then
                push_pledge = 5
            end
        elseif self.game_id == gt.GameID.NIUYE then
            if self.pRateTuizhu:getChildByTag(2):isSelected() then
                push_pledge = 5
            elseif self.pRateTuizhu:getChildByTag(3):isSelected() then
                push_pledge = 10
            elseif self.pRateTuizhu:getChildByTag(4):isSelected() then
                push_pledge = 20
            end
        end

        -- 翻倍  0关闭，1开启
        local pledge_double = 0
        if self.pAdvanceOps:getChildByTag(6):isSelected() then
            pledge_double = 1
        end

        -- 暗抢  0关闭，1开启
        local steal = 0
        if self.pAdvanceOps:getChildByTag(3):isSelected() then
            steal = 1
        end

        -- 9点庄大 0关闭，1开启
        local banker9 = 0
        if self.pAdvanceOps:getChildByTag(4):isSelected() then
            banker9 = 1
        end

        -- 切牌/摇色子 0关闭, 1开启
        local cut_dice = 0
        if self.pAdvanceOps:getChildByTag(5):isSelected() then
            cut_dice = 1
        end

        -- 自动开桌
        local auto_player_num = 0
        local auto_player_num_index=1
        if self.pAutoStart:getChildByTag(2):isSelected() then
            auto_player_num = max_chairs - 4
            auto_player_num_index=2
        elseif self.pAutoStart:getChildByTag(3):isSelected() then
            auto_player_num = max_chairs - 3
            auto_player_num_index=3
        elseif self.pAutoStart:getChildByTag(4):isSelected() then
            auto_player_num = max_chairs-2
            auto_player_num_index=4
        end
        --底注
        local zjh_base_score = tonumber(gt.seekNodeByName(self.pBottomBet, "Text_BttmBet"):getString())

        --最大轮数
        local now_rounds = 10
        if self.pMaxTurn:getChildByTag(2):isSelected() then 
            now_rounds = 20
        elseif self.pMaxTurn:getChildByTag(3):isSelected() then
            now_rounds = 30
        end

        -- --三公大吃小
        -- if self.game_id == gt.GameID.SANGONG and self.game_type == 7 then
        --     score = 20
        --     if self.pScore:getChildByTag(2):isSelected() then 
        --         score = 100
        --     elseif self.pScore:getChildByTag(3):isSelected() then
        --         score = 200
        --     end
        -- end

        --最大押注数
        if self.game_id == gt.GameID.ZJH then
            score = 10
            if self.pMaxBets:getChildByTag(2):isSelected() then 
                score = 20
            elseif self.pMaxBets:getChildByTag(3):isSelected() then
                score = 30
            end
        end

        --同牌比较
        local compare_type = 0 --（0先比为输 1按花色比）
        if self.pCmpType:getChildByTag(2):isSelected() then 
            compare_type = 1
        end

        local ops6 = "0"
        local ops14 = "0"
        if self.pPopHua:getChildByTag(1):isSelected() then
            ops6 = "0"
            ops14 = "0"
        elseif self.pPopHua:getChildByTag(2):isSelected() then
            ops6 = "1"
            ops14 = "1"
        elseif self.pPopHua:getChildByTag(3):isSelected() then
            ops6 = "1"
            ops14 = "0"
        end

		-- 个性选择
		local options = ""
		for i = 1, 15 do
            local radioName = string.format("Check_%d", i)
		    local radio = gt.seekNodeByName(self.pOptions, radioName)
            if not radio then
              radio = gt.seekNodeByName(self.pPopCardsType, radioName)
            end
            if not radio then
              radio = gt.seekNodeByName(self.pLaizi, radioName)
            end

            if i==7 then
                options = options .. "0"
            elseif i==6 then
                options = options .. ops6
            elseif i==14 then
                options = options .. ops14
			else
				if radio:isSelected() then
					options = options .. "1"
				else
                    options = options .. "0"
                end
            end
        end
        if self.game_id == gt.GameID.SANGONG then
            local ops = string.sub(options, 1, 6)
            local ops2 = string.sub(options, 10, 13)
            for i = 7, 9 do
                if i==7 then
                    ops = ops .. "0"
                else
                    if self.pOptionsSG:getChildByTag(i):isSelected() then
                        ops = ops .. "1"
                    else
                        ops = ops .. "0"
                    end
                end
            end
            options = ops .. ops2
        end
        --推筒子参数
        --local watcher = self.pWatcher:getChildByTag(7):isSelected()
        local two_eight = self.pOptionsTTZ:getChildByTag(1):isSelected()
        --推筒子 第六位
        if self.game_id==gt.GameID.TTZ then
			--if watcher then
			--	options =string.sub(options,1,6).."1"..string.sub(options,8,13)
			--else
			--	options =string.sub(options,1,6).."0"..string.sub(options,8,13)
			--end
            --观战屏蔽 默认不开启
            options =string.sub(options,1,6).."0"..string.sub(options,8,13)
			if two_eight then
				options ="1"..string.sub(options,2,13)
			else
				options ="0"..string.sub(options,2,13)
			end
        end

        local zjh_watch = 0
        local zjh_straight_big = 0

		if self.game_id == gt.GameID.ZJH then
            local ops = ""
            for i = 1,3 do 
            if self.pOpsZJH:getChildByTag(i):isSelected() then
				    ops = ops .. "1"
			    else
				    ops = ops .. "0"
			    end
            end
            ops = ops .. string.sub(options,4,5)
            --ops = ops .. (self.pOpsView:getChildByTag(1):isSelected() and "1" or "0")
            ops = ops.."0"
            ops = ops .. string.sub(options,7,13)
            options = ops

            -- watch
            if self.pOpsZJH:getChildByTag(4):isSelected() then
                 zjh_watch = 1
            end
            -- straight
            if self.pOpsZJH:getChildByTag(5):isSelected() then
                 zjh_straight_big = 1
            end


        end

        --王癞
        local laizi = 0
        if self.game_id == gt.GameID.NIUNIU or self.game_id == gt.GameID.NIUYE or self.game_id == gt.GameID.QIONGHAI then 
            if self.pLaizi:getChildByTag(2):isSelected() then
                laizi = 1
            elseif self.pLaizi:getChildByTag(3):isSelected() then
                laizi = 2
            end
        end

        --闲家买码
        local buyPledge = 0
        if self.game_id == gt.GameID.NIUNIU or self.game_id == gt.GameID.NIUYE or self.game_id == gt.GameID.QIONGHAI then 
            local radioBuyPledge = gt.seekNodeByName(self.pOptions, "Check_buyPledge")
            if radioBuyPledge:isSelected() then
                buyPledge = 1
            end
        end
        --扎金花 喜
        local zjh_xiqian = 0
        if self.game_id == gt.GameID.ZJH then
            if self.pPopZjhXi:getChildByTag(1):isSelected() then
                zjh_xiqian = 0
            elseif self.pPopZjhXi:getChildByTag(2):isSelected() then
                zjh_xiqian = 1
            elseif self.pPopZjhXi:getChildByTag(3):isSelected() then
                zjh_xiqian = 2
            elseif self.pPopZjhXi:getChildByTag(4):isSelected() then
                zjh_xiqian = 3
            elseif self.pPopZjhXi:getChildByTag(5):isSelected() then
                zjh_xiqian = 4
            end
        end

        local zjh_xiqian2 = 0
        if self.game_id == gt.GameID.ZJH then
            if self.pPopZjhBaoXi:getChildByTag(1):isSelected() then
                zjh_xiqian2 = 0
            elseif self.pPopZjhBaoXi:getChildByTag(2):isSelected() then
                zjh_xiqian2 = 1
            elseif self.pPopZjhBaoXi:getChildByTag(3):isSelected() then
                zjh_xiqian2 = 2
            elseif self.pPopZjhBaoXi:getChildByTag(4):isSelected() then
                zjh_xiqian2 = 3
            elseif self.pPopZjhBaoXi:getChildByTag(5):isSelected() then
                zjh_xiqian2 = 4
            end
        end

        local zjh_menpai = 1
        if self.game_id == gt.GameID.ZJH then
            for i = 1, 11 do 
                if self.pPopZjhMen:getChildByTag(i):isSelected() then
                    zjh_menpai = i - 1
                end
            end
        end

        local zjh_qipai = 15
        if self.game_id == gt.GameID.ZJH then
            if self.pPopZjhDrop:getChildByTag(1):isSelected() then
                zjh_qipai = 15
            elseif self.pPopZjhDrop:getChildByTag(2):isSelected() then
                zjh_qipai = 30
            elseif self.pPopZjhDrop:getChildByTag(3):isSelected() then
                zjh_qipai = 60
            elseif self.pPopZjhDrop:getChildByTag(4):isSelected() then
                zjh_qipai = 90
            elseif self.pPopZjhDrop:getChildByTag(5):isSelected() then
                zjh_qipai = 120
            end
        end

        local zjh_bipai = 3
        if self.game_id == gt.GameID.ZJH then 
            if self.pCmpZJH:getChildByTag(1):isSelected() then
                zjh_bipai = 0
            elseif self.pCmpZJH:getChildByTag(2):isSelected() then
                zjh_bipai = 1
            elseif self.pCmpZJH:getChildByTag(3):isSelected() then
                zjh_bipai = 2
            else
                zjh_bipai = 3
            end
        end

        local sg_score = 100
        if self.game_id == gt.GameID.SANGONG and self.game_type == 7 then
            if self.pSgScore:getChildByTag(2):isSelected() then
                sg_score = 500
            elseif self.pSgScore:getChildByTag(3):isSelected() then
                sg_score = 1000
            end
        end

        --房间设置存储到本地
        local roomSetting = {}
        roomSetting.game_id = self.game_id
        roomSetting.game_type = self.game_type
        roomSetting.max_chairs = max_chairs
        roomSetting.rounds = rounds
        roomSetting.pay = pay
        roomSetting.double_type = double_type
        roomSetting.score = score
        roomSetting.qh_base_score = qh_base_score
        roomSetting.base_score = base_score
        roomSetting.banker = banker
        roomSetting.cards_count = openNum
        roomSetting.loot_dealer = rate
        roomSetting.push_pledge = push_pledge
        roomSetting.pledge_res = pledge_res
        roomSetting.pledge_double = pledge_double
        roomSetting.steal = steal
        roomSetting.banker9 = banker9
        roomSetting.cut_dice = cut_dice
        roomSetting.options = options
        roomSetting.auto_player_num = auto_player_num
        roomSetting.auto_player_num_index = auto_player_num_index
		roomSetting.watcher=watcher
		roomSetting.two_eight=two_eight
		roomSetting.zjh_base_score = zjh_base_score
        roomSetting.now_rounds = now_rounds
        roomSetting.compare_type = compare_type
        roomSetting.laizi = laizi
        roomSetting.buy_pledge = buyPledge
        roomSetting.zjh_watch = zjh_watch
        roomSetting.zjh_straight_big = zjh_straight_big
        roomSetting.zjh_xiqian = zjh_xiqian
        roomSetting.zjh_xiqian2 = zjh_xiqian2
        roomSetting.zjh_menpai = zjh_menpai
        roomSetting.zjh_qipai = zjh_qipai
        roomSetting.zjh_bipai = zjh_bipai
        roomSetting.sg_score = sg_score

        local jsonString = json.encode(roomSetting)
        if guild_id and match == 0 then
            --俱乐部
            cc.UserDefault:getInstance():setStringForKey(self.storageKeyClub, jsonString)
           
        elseif guild_id and match == 1 then
            --比赛场
            cc.UserDefault:getInstance():setStringForKey(self.storageKeyMatch, jsonString)
            
        else
            --普通场
            cc.UserDefault:getInstance():setStringForKey(self.storageKey, jsonString)
            gt.guildid = nil
        end

        -- 发送创建房间消息
        local msgToSend = {}
        if guild_id then
            msgToSend.cmd = gt.GUILD_ROOM_PARAM
            msgToSend.guild_id = guild_id
            msgToSend.tp = match
        else
            msgToSend.cmd = gt.CREATE_ROOM
        end
        msgToSend.app_id = gt.app_id
        msgToSend.user_id = gt.playerData.uid
        msgToSend.open_id = gt.playerData.openid
        msgToSend.ver = gt.version
        msgToSend.dev_id = gt.getDeviceId()

        msgToSend.max_chairs = max_chairs
        msgToSend.rounds = rounds
        msgToSend.game_id = self.game_id
        msgToSend.game_type = self.game_type
        msgToSend.pay = pay
        msgToSend.double_type = double_type
        msgToSend.score = score
        msgToSend.qh_base_score = qh_base_score
        msgToSend.base_score = base_score
        msgToSend.banker = banker
        msgToSend.cards_count = openNum
        msgToSend.loot_dealer = rate
        msgToSend.push_pledge = push_pledge
        msgToSend.pledge_res = pledge_res
        msgToSend.pledge_double = pledge_double
        msgToSend.steal = steal
        msgToSend.laizi = laizi
        msgToSend.buy_pledge = buyPledge
        msgToSend.zjh_watch = zjh_watch
        msgToSend.zjh_straight_big = zjh_straight_big
        msgToSend.zjh_xiqian = zjh_xiqian
        msgToSend.zjh_xiqian2 = zjh_xiqian2
        msgToSend.zjh_menpai = zjh_menpai
        msgToSend.zjh_qipai = zjh_qipai
        msgToSend.zjh_bipai = zjh_bipai
        msgToSend.sg_score = sg_score
        msgToSend.banker9 = banker9
        msgToSend.cut_dice = cut_dice
        msgToSend.options = options
        msgToSend.auto_player_num = auto_player_num

        msgToSend.zjh_base_score = zjh_base_score
        msgToSend.now_rounds = now_rounds
        msgToSend.compare_type = compare_type
		dump(msgToSend)

        gt.socketClient:sendMessage(msgToSend)
        -- 等待提示
        if guild_id then
            gt.showLoadingTips("")
            self:close()
        else
            gt.showLoadingTips(gt.getLocationString("LTKey_0005"))
        end
    end )

    -- 接收创建房间消息
    if not guild_id then
        gt.socketClient:registerMsgListener(gt.CREATE_ROOM, self, self.onRcvCreateRoom)
    end
    -- 返回按键
    local close = function()
        self:removeFromParent(true)
    end
    self.close = close

    local backBtn = gt.seekNodeByName(self, "Btn_Close")
    gt.addBtnPressedListener(backBtn, close)

   if self:showOptions(self.game_type) then
        self:playUIEffect()
    end

    self:initGamesConfig()
    
end

function CreateRoom:initGamesConfig()
      
      self.checkBoxs = {}
      self.initFireAndTouchFuns = {}
      self.tpanel_to_button = {}
      ---------------------------------------------------
     for k,v in pairs(gt.games_config_list) do
       self[v.str_tag.."_csbNode"] = cc.CSLoader:createNode("games/SSS/csb/CreateRoom_"..v.str_tag..".csb")
       self.tpanel_to_button[v.str_tag] = {}

       local i = 1
      
        while true do 
            local  panel =  gt.seekNodeByName(self[v.str_tag.."_csbNode"], "Panel_"..i)
            if panel == nil then break end
         
              gt.retainNodes(panel,v.str_tag.."_Panels")
           -- gt.getNodesReferenceCount(v.str_tag.."_Panels")
           local button_to_panel =  gt.seekNodeByName(self[v.str_tag.."_csbNode"], "button_to_panel_"..i)
           local panel_to_button =  gt.seekNodeByName(self[v.str_tag.."_csbNode"], "panel_to_button_"..i)
           if panel_to_button then
           self.tpanel_to_button[v.str_tag][i] = panel_to_button
            panel_to_button:setVisible(false)
          end

            if button_to_panel then
                button_to_panel:addClickEventListener(function ()

                    for _,v in pairs( self.tpanel_to_button[v.str_tag] ) do
                         if panel_to_button == v then
                                if panel_to_button:isVisible() then
                                   panel_to_button:setVisible(false)
                                else
                                    panel_to_button:setVisible(true)
                                end
                         else
                            v:setVisible(false)
                          end   
                    end

                    
                end)
            end
            
             i = i+1   
         end


       local CB_Game = gt.seekNodeByName(self[v.str_tag.."_csbNode"], "CB_Game"..v.game_id)
       if CB_Game then
            CB_Game:retain()
            CB_Game:removeFromParent()
            self.listViewTypes:pushBackCustomItem(CB_Game)
            CB_Game:release()
       end


       local Panel_Item = gt.seekNodeByName(self[v.str_tag.."_csbNode"], "Panel_Item"..v.game_id)


       local size = nil
       if Panel_Item then
            self.listViewTypes:pushBackCustomItem(Panel_Item)
            size =  Panel_Item:getContentSize()
           for j = 1, 7 do
    		    local btn = Panel_Item:getChildByTag(j)
                if btn then
                    self.initFireAndTouchFuns[v.game_id..j] = {}
                     self.initFireAndTouchFuns[v.game_id..j][1] = function(sender)
                        gt.soundEngine:playEffect(gt.clickBtnAudio, false)
                        self:selPlayType(sender, Panel_Item)
    		        end
                    self.initFireAndTouchFuns[v.game_id..j][2] = CB_Game
    		        btn:addClickEventListener(self.initFireAndTouchFuns[v.game_id..v.game_type][1])
    		                  
                end
    	    end
       end


       local CB_GameFun =  function(sender, eventType)
                if eventType == ccui.TouchEventType.ended then              
                    gt.soundEngine:playEffect(gt.clickBtnAudio, false)          
                    self:selGameType(sender, Panel_Item, size,v)
                    self:setPersonalSel()
                    self:setRoomConsume()
                end
            end
      
        if Panel_Item == nil then
            self.initFireAndTouchFuns[v.game_id..v.game_type] = {}
            self.initFireAndTouchFuns[v.game_id..v.game_type][1] = CB_GameFun
            self.initFireAndTouchFuns[v.game_id..v.game_type][2] = CB_Game
            self.initFireAndTouchFuns[v.game_id..v.game_type][3] = ccui.TouchEventType.ended
        end

       CB_Game:addTouchEventListener( CB_GameFun)

        
        self:setCheckBoxs(self[v.str_tag.."_csbNode"],v)
        self.gameNum = self.gameNum + 1
    end

      local allRoomSetting  = self:ReadLocalRoomConfiguration()

        for k,v in pairs(gt.games_config_list) do
        if cc.exports.gt["main_"..v.str_tag] then
                cc.exports.gt["main_"..v.str_tag](self,allRoomSetting)
        end
     end

end

function CreateRoom:setCheckBoxs(csbNode,tgame_config)
        
        self.checkBoxs[tgame_config.str_tag] = {}

        local checkBox_union = {}

        --checkBox_union[#checkBox_union+1] =  {}
       
        for k2,v2 in pairs(tgame_config.wanfa) do
            
            if v2[1] == "options" then
                self.checkBoxs[tgame_config.str_tag][v2[2]] = gt.seekNodeByName(csbNode, k2)
            else
                self.checkBoxs[tgame_config.str_tag][k2] =  gt.seekNodeByName(csbNode, k2)   
            end
            gt.seekNodeByName(csbNode, k2):setZoomScale(0)

            if k2 ~= "Default" then
               assert(string.sub(k2,1,5) == "Check","玩法 Check 配置错误") 
                local key =  string.sub(k2,6,6)   
               if key ~= "_" then

                    local flag = true
                    for k,v in pairs(checkBox_union) do   
                       if string.sub(v[1],6,6) == key then                               
                        table.insert(v,k2)
                        flag = false
                        break                 
                       end
                    end             
                      if  flag then   
                           checkBox_union[#checkBox_union+1] =  {}   
                           table.insert(checkBox_union[#checkBox_union],k2)
                      end              
                   end
            end

        end

        for k3,v3 in pairs(checkBox_union) do 
            local function checkbox_callback(sender,eventType)
                
               if eventType == ccui.TouchEventType.began then
                    for k4,v4 in pairs(v3) do 
--                      if sender == self.checkBoxs[tgame_config.str_tag][v4] then
--                        self.checkBoxs[tgame_config.str_tag][v4]:setSelected(true) 
--                      else
                        self.checkBoxs[tgame_config.str_tag][v4]:setSelected(false) 
--                      end      
                    end
                     if cc.exports.gt["checkBoxTouchCallBack_"..tgame_config.str_tag] then
                                    cc.exports.gt["checkBoxTouchCallBack_"..tgame_config.str_tag](self,sender)
                            end
                elseif eventType == ccui.TouchEventType.ended then
                    if cc.exports.gt["checkBoxTouchEndedCallBack"] then
                        cc.exports.gt["checkBoxTouchEndedCallBack"](self, sender)
                    end
                end
            end
            for k4,v4 in pairs(v3) do 
                self.checkBoxs[tgame_config.str_tag][v4]:addTouchEventListener(checkbox_callback)
                
            end
        end 
         
end

function CreateRoom:ReadLocalRoomConfiguration()
    local allRoomSetting = {}
      for k,v in pairs(gt.games_config_list) do
              local setting = ""
            if self.guild_id and self.match == 0 then
                --俱乐部
                setting = cc.UserDefault:getInstance():getStringForKey(self.storageKeyClub..v.game_id..v.game_type, "")
            elseif self.guild_id and self.match == 1 then
                --比赛场
                setting = cc.UserDefault:getInstance():getStringForKey(self.storageKeyMatch..v.game_id..v.game_type, "")
            else
                --普通场
                setting = cc.UserDefault:getInstance():getStringForKey(self.storageKey..v.game_id..v.game_type, "")
            end
            local roomSetting = ""
            if (setting ~= "") then
                roomSetting = json.decode(setting)
            end
            if (roomSetting ~= "") then
               allRoomSetting[k] = roomSetting
               local options_index = 1
               for k1,v1 in pairs(self.checkBoxs[v.str_tag] ) do 
                
                   
                   if type(k1) == "number" then
                       local b = roomSetting["options"]
                       if string.sub(b,options_index,options_index) == "1" then
                            v1:setSelected(true)
                       else
                            v1:setSelected(false) 
                       end
                       options_index = options_index + 1
                   else
                        local b = roomSetting[v.wanfa[k1][1]]
                        if b  then
                            if   v.wanfa[k1][2] == b   then
                                v1:setSelected(true)
                            else
                                v1:setSelected(false) 
                            end    
                        end
                    end
               end

            end
     end

     local  scheId = {}
     scheId[1] = gt.scheduler:scheduleScriptFunc(function (dt)

         gt.scheduler:unscheduleScriptEntry(scheId[1])
         scheId = nil

        if self.initFireAndTouchFuns[self.game_id..self.game_type] and 
         type(self.initFireAndTouchFuns[self.game_id..self.game_type]) == "table" then
                self.initFireAndTouchFuns[self.game_id..self.game_type][1](
                self.initFireAndTouchFuns[self.game_id..self.game_type][2],
                self.initFireAndTouchFuns[self.game_id..self.game_type][3])
         end

    end   ,0.1,false)
         return allRoomSetting
end

function CreateRoom:createGamesRoom(tgame_config)
        local checkBoxs = self.checkBoxs[tgame_config.str_tag]

        --房间设置存储到本地
        local roomSetting = {}
       
        local msgToSend = {}
        if self.guild_id then
            msgToSend.cmd = gt.GUILD_ROOM_PARAM
            msgToSend.guild_id = self.guild_id
            msgToSend.tp = self.match
        else
            msgToSend.cmd = gt.CREATE_ROOM
        end
        msgToSend.app_id = gt.app_id
        msgToSend.user_id = gt.playerData.uid
        msgToSend.open_id = gt.playerData.openid
        msgToSend.ver = gt.version
        msgToSend.dev_id = gt.getDeviceId()
        msgToSend.game_id = self.game_id
        msgToSend.game_type = self.game_type
        msgToSend["options"] = msgToSend["options"] or ""
        roomSetting["options"] = roomSetting["options"] or ""
        for k,v in pairs(checkBoxs) do 

          if type(k) == "number" then
                if v:isSelected() == true then
                    msgToSend["options"] = msgToSend["options"].."1"    
                    roomSetting["options"] = roomSetting["options"].."1"
                else
                    msgToSend["options"] = msgToSend["options"].."0"    
                    roomSetting["options"] = roomSetting["options"].."0"
                end
          else
                if v:isSelected() == true then
                    msgToSend[tgame_config.wanfa[k][1]] = tgame_config.wanfa[k][2]
                    roomSetting[tgame_config.wanfa[k][1]] = tgame_config.wanfa[k][2]
                end
          end          

            
        end

         gt.socketClient:sendMessage(msgToSend)

        local jsonString = json.encode(roomSetting)
        if self.guild_id and self.match == 0 then
            --俱乐部
            cc.UserDefault:getInstance():setStringForKey(self.storageKeyClub..self.game_id..self.game_type , jsonString)
        elseif self.guild_id and self.match == 1 then
            --比赛场
            cc.UserDefault:getInstance():setStringForKey(self.storageKeyMatch..self.game_id..self.game_type, jsonString)
        else
            --普通场
            cc.UserDefault:getInstance():setStringForKey(self.storageKey..self.game_id..self.game_type, jsonString)
        end

        if self.guild_id then
            gt.showLoadingTips("")
            self:close()
        else
            gt.showLoadingTips(gt.getLocationString("LTKey_0005"))
        end
end

function CreateRoom:isScoreSpecial()
    return self.game_id == gt.GameID.NIUYE
        or ( self.game_id == gt.GameID.NIUNIU and self.game_type == gt.GameType.GAME_BANKER)
end

function CreateRoom:OnExitGamesConfig()

     for k,v in pairs(gt.games_config_list) do
        gt.releaseNodes(v.str_tag.."_Panels",true)
     end
     
end


function CreateRoom:initSelGameType()
    for j = 1, self.gameNum do
        local name = string.format("CB_Game%d", j)
        local cbGame = self.listViewTypes:getChildByName(name)
        if cbGame then
            name = string.format("Panel_Item%d", j)
            local pItem = self.listViewTypes:getChildByName(name)
            local size = pItem:getContentSize()
            cbGame:loadTextureNormal("image/createroom/btn2.png")
            
            pItem:setContentSize(size.width,0)
            pItem:setVisible(false)
            
        end           
    end
end

function CreateRoom:selGameType(selCB, pItem_, size,tgame_config)
    -- if self.lastCB_Game == selCB then
    --      return
    -- end

    selCB:loadTextureNormal("image/createroom/btn1.png")
    self.itemParticle:removeFromParent()
    selCB:addChild(self.itemParticle)

    for j = 1, self.gameNum do
        local name = string.format("CB_Game%d", j)
        local cbGame = self.listViewTypes:getChildByName(name)
        if cbGame then
            if cbGame ~= selCB then
                cbGame:loadTextureNormal("image/createroom/btn2.png")
                name = string.format("Panel_Item%d", j)
                local pItem = self.listViewTypes:getChildByName(name)
                if pItem then
                    local size = pItem:getContentSize()             
                    -- cbGame:setSelected(false)
                    -- cbGame:setEnabled(true)
                    pItem:setContentSize(size.width,0)
                    pItem:setVisible(false)
                end
            else
                self.game_id = j
            end 
        end           
    end

   self.lastCB_Game = selCB

    if pItem_ == nil  then
        
        self.lstConfs:removeAllItems()
        self.pSliderOps.Node_Show.List_Config:removeAllItems()

        self.game_type = tgame_config.game_type

       -- gt.getNodesReferenceCount(tgame_config.str_tag.."_Panels")
        for k,v in pairs(gt.getNodes(tgame_config.str_tag.."_Panels")) do
             self.lstConfs:pushBackCustomItem(v)
        end
       --  gt.getNodesReferenceCount(tgame_config.str_tag.."_Panels")

        self.listViewTypes:refreshView()
        return
    end

    -- if not selCB:isEnabled() then
    if not pItem_:isVisible() then
        local selBtn = pItem_:getChildByTag(self.game_type)
        self:selPlayType(selBtn, pItem_)
        pItem_:setContentSize(size)
        -- pItem_:setVisible(true)
        pItem_:setScaleY(0)
        local showAction = cc.Sequence:create(cc.Show:create(), cc.EaseSineInOut:create(cc.ScaleTo:create(0.13, 1.0, 1.0)))
        pItem_:runAction(showAction)

        
        self.listViewTypes:refreshView()
    else
        -- pItem_:setVisible(false) 
        local hideAction = cc.Sequence:create( cc.EaseSineInOut:create(cc.ScaleTo:create(0.1, 1.0, 0)),cc.Hide:create()
            , cc.CallFunc:create(function() 
                pItem_:setContentSize(size.width, 0)
                self.listViewTypes:refreshView()
            end))
        pItem_:runAction(hideAction)
    end

    
end

-- 选中玩法类型
function CreateRoom:selPlayType(selBtn, pItem)
    if selBtn == nil and pItem then
        if self.game_id == gt.GameID.QIONGHAI then
            selBtn = pItem:getChildByTag(gt.GameType.GAME_QH_BANKER)
        elseif self.game_id==gt.GameID.TTZ then
            selBtn = pItem:getChildByTag(gt.GameType.GAME_TTZ_MJ)
        elseif self.game_id == gt.GameID.SANGONG then
            selBtn = pItem:getChildByTag(gt.GameType.GAME_BANKER)
	elseif self.game_id == gt.GameID.ZJH then
            selBtn = pItem:getChildByTag(gt.GameType.GAME_CLASSIC_ZJH)
        else
            selBtn = pItem:getChildByTag(gt.GameType.GAME_BANKER)
        end
    end
    for k = 1, 7 do
        local btn = pItem:getChildByTag(k)
        if btn then
            if btn == selBtn then
                btn:setEnabled(false)
                self.game_type = k
                self:showOptions(k)
                self:hidePopFrame()
            else
                btn:setEnabled(true)
            end
        end
    end
end


function CreateRoom:refreshBuyPledgeBtn()
    if self.game_id == gt.GameID.NIUNIU or self.game_id == gt.GameID.QIONGHAI or self.game_id == gt.GameID.NIUYE then
        local isShowBtn = true
        if self.game_type == 5 or self.game_type == 1 or self.game_type == 2 then
            isShowBtn = false
        end
        if self.pPlayerNum12:getChildByTag(4):isSelected() then
            isShowBtn = false
        end

        local radioBuyPledge = gt.seekNodeByName(self.pOptions, "Check_buyPledge")
        if radioBuyPledge then

            if isShowBtn then
               radioBuyPledge:setVisible(true)
            else
               radioBuyPledge:setVisible(false)
               radioBuyPledge:setSelected(false)
            end
        end
    end

end

function CreateRoom:showOptions(game_type)

    local name_ = string.format("Panel_Item%d", self.game_id)
    local pItem_ = self.listViewTypes:getChildByName(name_)
    if pItem_ == nil then
        return false
    end

    for k = 1,7 do
        local btn = pItem_:getChildByTag(k)
        if btn then
            if game_type == k then
                -- if btn:getChildByName("nodeUIEffect") then
                --     btn:getChildByName("nodeUIEffect"):setVisible(true)
                -- end
                self.nodeUIItemEffect:removeFromParent()
                btn:addChild(self.nodeUIItemEffect)
            else
                -- if btn:getChildByName("nodeUIEffect") then
                --    btn:getChildByName("nodeUIEffect"):setVisible(false)
                -- end
            end
        end
    end

    self:refreshBuyPledgeBtn()
    self.lstConfs:removeAllItems()
    self.pSliderOps.Node_Show.List_Config:removeAllItems()
    self:setBanker9()
    local btnCutDice = self.pAdvanceOps:getChildByTag(5)
    btnCutDice:setVisible(false)
    local noRubCard = self.pOptionsSG:getChildByTag(9)
    noRubCard:setVisible(true)
    if self.game_id == gt.GameID.SANGONG and game_type == 1 then
        -- 三公的霸王庄玩法显示 切牌/摇色子选项 不显示搓牌
        btnCutDice:setVisible(true)
        --noRubCard:setVisible(false)
    end

    for i = 1, 4 do
        local name = string.format("Label_Desc%d", i)
        local lbBanker = gt.seekNodeByName(self.pBanker, name)
        if i == 1 then
            lbBanker:setString("房主坐庄")
            if self.game_id == gt.GameID.SANGONG then
                lbBanker:setString("霸王庄")
            end
        elseif i == 3 then
            lbBanker:setString("牛牛上庄")
            if self.game_id == gt.GameID.SANGONG then
                lbBanker:setString("牌大坐庄")
            end
        elseif i == 4 then
            local check4 = self.pBanker:getChildByTag(4)
            if self.game_id == gt.GameID.SANGONG then
                check4:setVisible(false)
                if check4:isSelected() then
                    check4:setSelected(false)
                    self.pBanker:getChildByTag(1):setSelected(true)
                end
            else
                check4:setVisible(true)
            end
        end
    end


    local lbScore1 = gt.seekNodeByName(self.pScore, "Label_Desc1")
    local lbScore2 = gt.seekNodeByName(self.pScore, "Label_Desc2")
    local lbScore3 = gt.seekNodeByName(self.pScore, "Label_Desc3")
    local lbScore4 = gt.seekNodeByName(self.pScore, "Label_Desc4")
    local lbScore5 = gt.seekNodeByName(self.pScore, "Label_Desc5")
    if self.game_id == gt.GameID.NIUNIU or self.game_id == gt.GameID.NIUYE or self.game_id==gt.GameID.TTZ then
        if (game_type == 5) then
            -- 通比牛牛
            lbScore1:setString("2分")
            lbScore2:setString("4分")
            lbScore3:setString("6分")
            lbScore4:setString("8分")
            lbScore5:setString("10分")
        else
            lbScore1:setString("1/2分")
            lbScore2:setString("2/4分")
            lbScore3:setString("3/6分")
            lbScore4:setString("4/8分")
            lbScore5:setString("5/10分")
        end
    elseif self.game_id == gt.GameID.SANGONG then
        --三公 
        if game_type == 7 then     
            lbScore1:setString("5/10/20/50分")
            lbScore2:setString("10/30/50/100分")
            lbScore3:setString("20/50/100/250分")
        else
            lbScore1:setString("5/10/15/20分")
            lbScore2:setString("10/20/30/40分")
            lbScore3:setString("20/40/60/80分")
        end
    end
    -- 牛牛和牛爷有5个底分选项
    if self.game_id == gt.GameID.NIUYE or self.game_id == gt.GameID.NIUNIU or self.game_id==gt.GameID.TTZ then
        for i = 1, 5 do
            local check = gt.seekNodeByName(self.pScore, "Check_" .. i)
            check:setVisible(true)
            check:setPositionX(273 + 125 * (i - 1))
        end
    else
        for i = 1, 3 do
            local check = gt.seekNodeByName(self.pScore, "Check_" .. i)
            check:setVisible(true)
            check:setPositionX(273 + 225 * (i - 1))
        end
        local check4 = gt.seekNodeByName(self.pScore, "Check_4")
        local check5 = gt.seekNodeByName(self.pScore, "Check_5")
        check4:setVisible(false)
        check5:setVisible(false)
        if check4:isSelected() or check5:isSelected() then
            check4:setSelected(false)
            check5:setSelected(false)
            gt.seekNodeByName(self.pScore, "Check_1"):setSelected(true)
        end
    end

    -- 下注限制只有明牌抢庄和自由抢庄有
    local btnPledgeLimit = gt.seekNodeByName(self.pAdvanceOps, "Check_1")
    local btnDoublePledge = self.pAdvanceOps:getChildByTag(6)
    if (game_type == 4 or game_type == 6) then
        btnPledgeLimit:setVisible(true)
    else
        btnPledgeLimit:setVisible(false)
    end
    -- 翻倍只有牛牛的明牌抢庄和自由抢庄有
    if self.game_id == gt.GameID.NIUNIU and (game_type == 4 or game_type == 6) then
        btnDoublePledge:setVisible(true)
    else
        btnDoublePledge:setVisible(false)
    end
    -- 只有抢庄牛牛有暗抢
    local btnSteal = gt.seekNodeByName(self.pAdvanceOps, "Check_3")
    if (game_type == 4) then
        btnSteal:setVisible(true)
    else
        btnSteal:setVisible(false)
    end
    -- 元帅抢庄推注不显示 显示下注加倍
    local btntui = gt.seekNodeByName(self.pAdvanceOps, "Check_2")
    -- btnDoublePledge
    local lbdouble = gt.seekNodeByName(btnDoublePledge, "Label_Desc")
    local Btn_WenHaoDouble = gt.seekNodeByName(btnDoublePledge, "Btn_WenHaoDouble")
    -- btnSteal
    if self.game_id == gt.GameID.NIUYE then
        btntui:setVisible(false)
        btnDoublePledge:setVisible(true)
        btnDoublePledge:setPositionX(194)
        Btn_WenHaoDouble:setPositionX(186)
        btnSteal:setPositionX(650)
        self.doubleTip:setPositionX(305)
        lbdouble:setString("下注加倍")
    else
        btntui:setVisible(true)
        -- btnDoublePledge:setVisible(false)
        btnDoublePledge:setPositionX(650)
        Btn_WenHaoDouble:setPositionX(136)
        btnSteal:setPositionX(815)
        self.doubleTip:setPositionX(705)
        lbdouble:setString("翻倍")
    end

    -- 三公没有暗抢
    if self.game_id == gt.GameID.SANGONG then
        btnSteal:setVisible(false)
    end
    -- self:setScoreSel()
    -- 1：经典牛牛(霸王庄)  2：斗公牛  3：炸金牛  4：明牌抢庄  5：通比牛牛(无庄通比)  6：自由抢庄  7：琼海抢庄
    local panels = { self.pPlayerNum, self.pRound, self.pPay, self.pScore, self.pLaizi, self.pBanker,self.pDoubleRate, self.pAdvanceOps, self.pOptions }
    if self.game_id == gt.GameID.NIUNIU then
        if game_type == 1 then
            panels = { self.pPlayerNum12, self.pRound, self.pPay, self.pScore, self.pLaizi, self.pBanker,self.pDoubleRate, self.pAdvanceOps, self.pOptions }
        elseif game_type == 2 then
            panels = { self.pPlayerNum12, self.pRound, self.pPay, self.pScore, self.pLaizi, self.pBaseScore, self.pDoubleRate, self.pAdvanceOps, self.pOptions }
        elseif game_type == 3 then
            panels = { self.pPlayerNum12, self.pRound, self.pPay, self.pScore, self.pLaizi, self.pBetNum, self.pDoubleRate, self.pBanker, self.pOptions }
        elseif game_type == 4 then
            panels = { self.pPlayerNum12, self.pRound, self.pPay, self.pLaizi, self.pRateSel,self.pDoubleRate, self.pAdvanceOps, self.pYsScore, self.pOptions }
        elseif game_type == 5 then
            panels = { self.pPlayerNum12, self.pRound, self.pPay, self.pScore, self.pLaizi, self.pOptions, self.pDoubleRate }
        elseif game_type == 6 then
            panels = { self.pPlayerNum12, self.pRound, self.pPay, self.pScore, self.pLaizi, self.pAdvanceOps,self.pDoubleRate, self.pOptions }
        end
    elseif self.game_id == gt.GameID.SANGONG then
        panels = { self.pPlayerNum, self.pRound, self.pPay, self.pScore, self.pBanker, self.pAdvanceOps, self.pOptionsSG }
        if game_type == 4 or game_type == 6 then
            panels = {self.pPlayerNum, self.pRound, self.pPay, self.pScore, self.pAdvanceOps, self.pOptionsSG}
        elseif game_type == 7 then
		    panels = {self.pPlayerNum, self.pRound, self.pPay, self.pSgScore, self.pScore,self.pOptionsSG}
            self:setSgBigSmallSel()
        elseif game_type == 5 then
            panels = { self.pPlayerNum, self.pRound, self.pPay, self.pScore, self.pOptionsSG }
        end
    elseif self.game_id == gt.GameID.NIUYE then
        if game_type == 4 then
            -- panels = { self.pPlayerNum, self.pRound, self.pPay, self.pDoubleRate, self.pScore, self.pSliderOps }
            panels = { self.pPlayerNum12, self.pRound, self.pPay, self.pRateSel
                , self.pRateTuizhu, self.pLaizi, self.pDoubleRate, self.pYsScore, self.pAutoStart, self.pAdvanceOps, self.pOptions }
                
            -- local l2_panels = { self.pRateSel, self.pRateTuizhu, self.pAutoStart, self.pAdvanceOps, self.pOptions }
            -- for i, p in ipairs(l2_panels) do
            --     if not (gt.isIOSReview() and p == self.pPay) then
            --         p:setOpacity(255)
            --         self.pSliderOps.Node_Show.List_Config:pushBackCustomItem(p)
            --     end
            -- end
            self.pSliderOps.IsRunning = false
            self.pSliderOps.IsShow = false
            self.pSliderOps.Node_Show:setOpacity(0)
            self.pSliderOps.Node_Tips:setOpacity(255)
            self.pSliderOps.Node_Tips:setVisible(true)
            self.pSliderOps.Node_Show:setVisible(false)
            local pop = gt.seekNodeByName(self.pSliderOps, "Panel_SlidePop")
            local btn_Show = pop:getChildByName("Btn_Show")
            pop:setContentSize(916, 220)
            ccui.Helper:doLayout(pop)
            btn_Show:loadTextureNormal("image/createroom/btn_slider1.png",ccui.TextureResType.plistType)
        end
    elseif self.game_id == gt.GameID.QIONGHAI then
        if game_type == 7 then
            --琼海明牌
            panels = {self.pPlayerNum12, self.pRound, self.pPay, self.pQHScore, self.pLaizi, self.pQHBaseScore, self.pDoubleRate, self.pOptions}
        end
	elseif self.game_id==gt.GameID.TTZ then
		panels = {self.pPlayerNum, self.pRound, self.pPay, self.pRateSelTTZ, self.pTTZScore, self.pOptionsTTZ, --[[self.pWatcher]]}
	elseif self.game_id == gt.GameID.ZJH then
        if game_type == 1 then --经典扎金花
            panels = {self.pPlayerNum,self.pRoundZJH, self.pPay, self.pBottomBet, self.pMaxTurn, self.pMaxBets, self.pCmpType, self.pCmpZJH, self.pOpsZJH--[[, self.pOpsView]]}
            -- panels = {self.pPlayerNum,self.pRound, self.pPay, self.pBottomBet, self.pMaxTurn, self.pMaxBets, self.pCmpType, self.pOpsZJH--[[, self.pOpsView]]}
        end
    end

    for i, p in ipairs(panels) do
		if not (gt.isIOSReview() and p == self.pPay) then
	        p:setOpacity(255)
			self.lstConfs:pushBackCustomItem(p)
		end
	end

    return true
end

-- 设置牌局消耗的房卡信息
function CreateRoom:setRoomConsume()
    local playerNum = CreateRoom.PlayerNum.SIX
    if self.pPlayerNum:getChildByTag(2):isSelected() then
        playerNum = CreateRoom.PlayerNum.TEN
    end
    if self.pPlayerNum:getChildByTag(3):isSelected() then
        playerNum = CreateRoom.PlayerNum.EIGHT
    end

    if self.game_id == gt.GameID.NIUNIU or self.game_id == gt.GameID.QIONGHAI or self.game_id == gt.GameID.NIUYE then
        if self.pPlayerNum12:getChildByTag(1):isSelected() then
            playerNum = CreateRoom.PlayerNum.SIX
        elseif self.pPlayerNum12:getChildByTag(2):isSelected() then
            playerNum = CreateRoom.PlayerNum.TEN
        elseif self.pPlayerNum12:getChildByTag(3):isSelected() then
            playerNum=CreateRoom.PlayerNum.EIGHT
        elseif self.pPlayerNum12:getChildByTag(4):isSelected() then
            playerNum=CreateRoom.PlayerNum.TWELVE
        end
    end


    local round = CreateRoom.Round.Ten
    if self.pRound:getChildByTag(2):isSelected() then
        round = CreateRoom.Round.Twenty
    elseif self.pRound:getChildByTag(3):isSelected() then
        round = CreateRoom.Round.Thirty
    end

    if self.game_id == gt.GameID.ZJH then 
        if self.pRoundZJH:getChildByTag(1):isSelected() then
            round = CreateRoom.Round.Six
        elseif self.pRoundZJH:getChildByTag(2):isSelected() then
            round = CreateRoom.Round.Nine
        elseif self.pRoundZJH:getChildByTag(3):isSelected() then
            round = CreateRoom.Round.Twelve
        end
    end

    self.lbPay1:setString("AA付费(每人x"..gt.getRoomCardConsume(self.game_id, 2, round, playerNum)..")")
    self.lbPay2:setString("房主付费(房主x"..gt.getRoomCardConsume(self.game_id, 1, round, playerNum)..")")
    -- 设置自动开桌人数
    self.pAutoStart:getChildByTag(2):getChildByName("Label_Desc"):setString(string.format("满%d人开", playerNum - 4))
    self.pAutoStart:getChildByTag(3):getChildByName("Label_Desc"):setString(string.format("满%d人开", playerNum - 3))
    self.pAutoStart:getChildByTag(4):getChildByName("Label_Desc"):setString(string.format("满%d人开", playerNum-2))
end

-- 通比牛牛还是要显示2, 4, 8分，其他玩法在十人房时只显示123分选项(只有阿牛哥这样)
function CreateRoom:setScoreSel()
    if (self.pPlayerNum:getChildByTag(2):isSelected()  and self.game_type ~= 5) then
        self.pScore:getChildByTag(1):setSelected(true)
        self.pScore:getChildByTag(2):setSelected(false)
        self.pScore:getChildByTag(3):setSelected(false)
        self.pScore:getChildByTag(2):setVisible(false)
        self.pScore:getChildByTag(3):setVisible(false)
    else
        self.pScore:getChildByTag(2):setVisible(true)
        self.pScore:getChildByTag(3):setVisible(true)
    end
end

-- 设置付费模式
function CreateRoom:setPayType()
    local str = "AA付费"
    if self.pPay:getChildByTag(2):isSelected() then
        str = "房主付费"
    end
    self.pSliderOps.Node_Show.Text_Pay:setString("付费模式：" .. str)
end

function CreateRoom:setPlayerNum()
    local str = "人数：6人"
    if self.pPlayerNum:getChildByTag(2):isSelected() then
        str = "人数：10人"
    end
    if self.pPlayerNum:getChildByTag(3):isSelected() then
        str = "人数：8人"
    end
    self.pSliderOps.Node_Show.Text_PlayerNum:setString(str)
    self:refreshBuyPledgeBtn()
end

function CreateRoom:setAdvanceType()
    local str = "高级选项："
    if self.pAdvanceOps:getChildByTag(6):isSelected() then
        str = str .. "  下注加倍"
    end
    if self.pAdvanceOps:getChildByTag(1):isSelected() then
        str = str .. "  下注限制"
    end
    if self.pAdvanceOps:getChildByTag(3):isSelected() then
        str = str .. "  暗抢"
    end
    self.pSliderOps.Node_Tips.Text_AdvanceOps:setString(str)
end

-- 设置底分
function CreateRoom:setScoreType()
    local str = "1/2分"
    if self.pScore:getChildByTag(2):isSelected() then
        str = "2/4分"
    elseif self.pScore:getChildByTag(3):isSelected() then
        str = "3/4分"
    elseif self.pScore:getChildByTag(4):isSelected() then
        str = "4/8分"
    elseif self.pScore:getChildByTag(5):isSelected() then
        str = "5/10分"
    end
    self.pSliderOps.Node_Show.Text_Difen:setString("底分：" .. str)
end

-- 设置抢庄倍数
function CreateRoom:setRateSel()
    local value = 1
    if self.pRateSel:getChildByTag(2):isSelected() then
        value = 2
    elseif self.pRateSel:getChildByTag(3):isSelected() then
        value = 3
    elseif self.pRateSel:getChildByTag(4):isSelected() then
        value = 4
    end
    self.pSliderOps.Node_Tips.Text_Bei:setString("抢庄倍数：" .. value .. "倍")
end

-- 设置闲家推注倍数
function CreateRoom:setRateTuizhu()
    local str = "关"
    if self.pRateTuizhu:getChildByTag(2):isSelected() then
        str = "5倍"
    elseif self.pRateTuizhu:getChildByTag(3):isSelected() then
        str = "10倍"
    elseif self.pRateTuizhu:getChildByTag(4):isSelected() then
        str = "20倍"
    end
    self.pSliderOps.Node_Tips.Text_Tui:setString("闲家推注：" .. str)
end
--[[
function CreateRoom:setMaxTurns()
    local value = 10
    if self.pMaxTurn:getChildByTag(2):isSelected() then
        value = 20
    elseif self.pMaxTurn:getChildByTag(3):isSelected() then
        value = 30
    end
    self.pSliderOps.Node_Tips.Text_MaxTurns:setString("压分回合：" .. value .. "回合封顶")
end

function CreateRoom:setMaxBets()
    local value = 10
    if self.pMaxBets:getChildByTag(2):isSelected() then
        value = 20
    elseif self.pMaxBets:getChildByTag(3):isSelected() then
        value = 30
    end
    self.pSliderOps.Node_Tips.Text_MaxBets:setString("压分选项：" .. value .. "注封顶")
end

function CreateRoom:setCmpType()
    local value = "先比为输"
    if self.pRateSel:getChildByTag(2):isSelected() then
        value = "按花色比"
    end
    self.pSliderOps.Node_Tips.Text_CmpType:setString("同牌输赢：" .. value)
end
--]]
-- 三公大吃小
function CreateRoom:setSgBigSmallSel()
    if self.game_id == gt.GameID.SANGONG and self.game_type ==  7 then
        for i = 1,  3 do
            self.pScore:getChildByTag(i):setVisible(true)
        end
        if self.pSgScore:getChildByTag(1):isSelected() then
            self.pScore:getChildByTag(3):setVisible(false)
            if self.pScore:getChildByTag(3):isSelected() then
                self.pScore:getChildByTag(3):setSelected(false)
                self.pScore:getChildByTag(1):setSelected(true)
            end
        end
    end
end

-- 设置花牌
function CreateRoom:setPopHuaSel()
    local desc = "有花牌"
    if self.pPopHua:getChildByTag(1):isSelected() then
        desc = "有花牌"
    elseif self.pPopHua:getChildByTag(2):isSelected() then
        desc = "无花牌有10"
    elseif self.pPopHua:getChildByTag(3):isSelected() then
        desc = "无花牌无10"
    end
    self.lblSelHua:setString(desc)
end

-- 设置扎金花
function CreateRoom:setZjhXiSel()
    local desc = "同花不收喜"
    if self.pPopZjhXi:getChildByTag(1):isSelected() then
        desc = "同花不收喜"
    elseif self.pPopZjhXi:getChildByTag(2):isSelected() then
        desc = "同花顺5分"
    elseif self.pPopZjhXi:getChildByTag(3):isSelected() then
        desc = "同花顺10分"
    elseif self.pPopZjhXi:getChildByTag(4):isSelected() then
        desc = "同花顺15分"
    elseif self.pPopZjhXi:getChildByTag(5):isSelected() then
        desc = "同花顺30分"
    end
    self.lblSelZjhXi:setString(desc)
end

function CreateRoom:setZjhBaoXiSel()
    local desc = "豹子不收喜"
    if self.pPopZjhBaoXi:getChildByTag(1):isSelected() then
        desc = "豹子不收喜"
    elseif self.pPopZjhBaoXi:getChildByTag(2):isSelected() then
        desc = "豹子10分"
    elseif self.pPopZjhBaoXi:getChildByTag(3):isSelected() then
        desc = "豹子20分"
    elseif self.pPopZjhBaoXi:getChildByTag(4):isSelected() then
        desc = "豹子30分"
    elseif self.pPopZjhBaoXi:getChildByTag(5):isSelected() then
        desc = "豹子50分"
    end
    self.lblSelZjhBaoXi:setString(desc)
end


function CreateRoom:setZjhMenSel()
    local desc = "不闷牌"
    if self.pPopZjhMen:getChildByTag(1):isSelected() then
        desc = "不闷牌"
    elseif self.pPopZjhMen:getChildByTag(2):isSelected() then
        desc = "必闷1轮"
    elseif self.pPopZjhMen:getChildByTag(3):isSelected() then
        desc = "必闷2轮"
    elseif self.pPopZjhMen:getChildByTag(4):isSelected() then
        desc = "必闷3轮"
    elseif self.pPopZjhMen:getChildByTag(5):isSelected() then
        desc = "必闷4轮"
    elseif self.pPopZjhMen:getChildByTag(6):isSelected() then
        desc = "必闷5轮"
    elseif self.pPopZjhMen:getChildByTag(7):isSelected() then
        desc = "必闷6轮"
    elseif self.pPopZjhMen:getChildByTag(8):isSelected() then
        desc = "必闷7轮"
    elseif self.pPopZjhMen:getChildByTag(9):isSelected() then
        desc = "必闷8轮"
    elseif self.pPopZjhMen:getChildByTag(10):isSelected() then
        desc = "必闷9轮"
    elseif self.pPopZjhMen:getChildByTag(11):isSelected() then
        desc = "必闷10轮"
    end
    self.lblSelZjhMen:setString(desc)
end
function CreateRoom:setZjhDropSel()
    local desc = "15秒弃牌"
    if self.pPopZjhDrop:getChildByTag(1):isSelected() then
        desc = "15秒弃牌"
    elseif self.pPopZjhDrop:getChildByTag(2):isSelected() then
        desc = "30秒弃牌"
    elseif self.pPopZjhDrop:getChildByTag(3):isSelected() then
        desc = "60秒弃牌"
    elseif self.pPopZjhDrop:getChildByTag(4):isSelected() then
        desc = "90秒弃牌"
    elseif self.pPopZjhDrop:getChildByTag(5):isSelected() then
        desc = "120秒弃牌"
    end
    self.lblSelZjhDrop:setString(desc)
end

-- 设置翻倍规则
function CreateRoom:setScoreSpecialSel()
    local desc = "1分/2分"
    if self.pPopScoreNormal:getChildByTag(1):isSelected() then
        desc = "1分/2分"
    elseif self.pPopScoreNormal:getChildByTag(2):isSelected() then
        desc = "2分/4分"
    elseif self.pPopScoreNormal:getChildByTag(3):isSelected() then
        desc = "3分/6分"
    elseif self.pPopScoreNormal:getChildByTag(4):isSelected() then
        desc = "4分/8分"
    elseif self.pPopScoreNormal:getChildByTag(5):isSelected() then
        desc = "5分/10分"
    end
    self.lblSelScoreNormal:setString(desc)
    
    if self.pPopScoreSpecial:getChildByTag(1):isSelected() then
        desc = "2分/3分/4分/5分"
    elseif self.pPopScoreSpecial:getChildByTag(2):isSelected() then
        desc = "2分/4分/8分/10分"
    elseif self.pPopScoreSpecial:getChildByTag(3):isSelected() then
        desc = "3分/6分/12分/15分"
    elseif self.pPopScoreSpecial:getChildByTag(4):isSelected() then
        desc = "4分/8分/16分/20分"
    elseif self.pPopScoreSpecial:getChildByTag(5):isSelected() then
        desc = "5分/10分/20分/25分"
    elseif self.pPopScoreSpecial:getChildByTag(6):isSelected() then
        desc = "1分/2分/4分/5分"
    end
    self.lblSelScoreSpecial:setString(desc)
    
end

-- 设置翻倍规则
function CreateRoom:setDoubelRateSel()
    local desc = "牛八2倍，牛九2倍，牛牛3倍"
    if self.pPopDoubleRate:getChildByTag(2):isSelected() then
        desc = "牛七2倍，牛八2倍，牛九3倍，牛牛4倍"
    elseif self.pPopDoubleRate:getChildByTag(3):isSelected() then
        desc = "牛七牛八牛九2倍，牛牛3倍(新)"
    elseif self.pPopDoubleRate:getChildByTag(4):isSelected() then
        desc = "牛一 ~ 牛牛 分别对应1~10倍 (新)"
    end

    self.lbSelDoubelRate:setString(desc)
    self.pSliderOps.Node_Show.Text_Rate:setString("翻倍规则：" .. desc)
    self:hidePopFrame()
end

-- 设置牌型
function CreateRoom:setCardsTypeSel()
    local num = 0
    for i = 1, 5 do
        local radioName = string.format("Check_%d", i)
        local radio = gt.seekNodeByName(self.pOptions, radioName)
        if radio:isSelected() then
            num = num + 1
        end
    end
    for i = 10, 13 do
        local radioName = string.format("Check_%d", i)
        local radio = gt.seekNodeByName(self.pOptions, radioName)
        if radio:isSelected() then
            num = num + 1
        end
    end

    local desc = ""
    if num == 0 then
        desc = "特殊牌型：没有勾选"
    elseif num == 9 then
        desc = "特殊牌型：全部勾选"
    else
        desc = "特殊牌型：部分勾选"
    end
    self.lbSelCardsType:setString(desc)
    return desc
end

function CreateRoom:setOptionTip()
    local desc = self:setCardsTypeSel()
    if self.pOptions:getChildByTag(7):isSelected() then
        desc = desc .. "  开局后禁止加入"
    end
    if self.pOptions:getChildByTag(8):isSelected() then
        desc = desc .. "  快速游戏"
    end
    if self.pOptions:getChildByTag(9):isSelected() then
        desc = desc .. "  禁止搓牌"
    end
    if self.pLaizi:getChildByTag(6):isSelected() then
        desc = desc .. "  无花牌"
    end
    self.pSliderOps.Node_Tips.Text_Ops:setString("个性选择：" .. desc)
end

-- 无花牌勾选后，隐藏银牛金牛并发送不勾选给服务器
function CreateRoom:setWuHua()
    --8人房以上不显示无花牌选项 默认发送不勾选给服务器
    local btnWuHua = self.pLaizi:getChildByTag(6)
    local btnWuHua10 = self.pLaizi:getChildByTag(14)
    if self.pPlayerNum12:getChildByTag(1):isSelected() then
        -- btnWuHua:setVisible(true)
        -- btnWuHua10:setVisible(true)
        self.btnHua:setVisible(true)
    else
        btnWuHua:setSelected(false)
        btnWuHua:setVisible(false)
        btnWuHua10:setSelected(false)
        btnWuHua10:setVisible(false)
        self.btnHua:setVisible(false)
        self.pPopHua:setVisible(false)
    end

    self:refreshBuyPledgeBtn()
    --    local btnWuXiao = self.pOptions:getChildByTag(2)
    --    local lbDesc = btnWuXiao:getChildByName("Label_Desc")
    --    lbDesc:setString("银牛(5倍)/金牛(6倍)/五小牛(7倍)/炸弹牛(8倍)/一条龙(9倍)")
    --    local btnBomb = self.pOptions:getChildByTag(3)
    --    btnBomb:setSelected(false)
    --    btnBomb:setVisible(false)
    --    local btnJinNiu = self.pOptions:getChildByTag(4)
    --    btnJinNiu:setSelected(false)
    --    btnJinNiu:setVisible(false)
    --    local btnYinNiu = self.pOptions:getChildByTag(5)
    --    btnYinNiu:setSelected(false)
    --    btnYinNiu:setVisible(false)
    --    local btnYiTiaoLong = self.pOptions:getChildByTag(1)
    --    btnYiTiaoLong:setSelected(false)
    --    btnYiTiaoLong:setVisible(false)
    --    if btnWuXiao:isSelected() then
    --        btnBomb:setSelected(true)
    --        btnJinNiu:setSelected(true)
    --        btnYinNiu:setSelected(true)
    --        btnYiTiaoLong:setSelected(true)
    --    end
    --    if btnWuHua:isSelected() then
    --        lbDesc:setString("五小牛(7倍)/炸弹牛(8倍)/一条龙(9倍)")
    --        btnJinNiu:setSelected(false)
    --        btnYinNiu:setSelected(false)
    --    end
end

-- 设置9点庄大选项  (只有三公霸王庄玩法的霸王庄模式有)
function CreateRoom:setBanker9()
    -- 9点庄大
    local btnBanker9 = self.pAdvanceOps:getChildByTag(4)
    btnBanker9:setVisible(false)
    if self.game_id == gt.GameID.SANGONG and self.game_type == 1 and self.pBanker:getChildByTag(1):isSelected() then
        btnBanker9:setVisible(true)
    end
end

-- 设置个性选项
function CreateRoom:setPersonalSel()
    -- 10人房不显示无花牌选项 默认发送不勾选给服务器
    -- 无花牌勾选后，隐藏银牛金牛并发送不勾选给服务器
    self:setWuHua()

    -- 快速游戏（托管）被勾选后，禁止搓牌自动勾选且不能撤消
    local tuoGuan = self.pOptions:getChildByTag(8)
    local noRubCard = self.pOptions:getChildByTag(9)
    if self.game_id == gt.GameID.SANGONG then
        tuoGuan = self.pOptionsSG:getChildByTag(8)
        noRubCard = self.pOptionsSG:getChildByTag(9)
    end
    if tuoGuan:isSelected() then
        noRubCard:setSelected(true)
        noRubCard:setTouchEnabled(false)
    else
        noRubCard:setTouchEnabled(true)
    end
end

function CreateRoom:playUIEffect()
    local actionTimeLine = cc.CSLoader:createTimeline("csd/texiao/bisaichang.csb")
    self.csbNode:runAction(actionTimeLine)
    actionTimeLine:play("animation_matchItem",true)

end

function CreateRoom:refreshPopCardsType()
    local isLaizi = self.pPopDoubleRate:getChildByTag(4):isSelected()
    if isLaizi then
        self.pPopCardsType:getChildByTag(13):getChildByName("Label_Desc"):setString("同花顺(40倍)")
        self.pPopCardsType:getChildByTag(1):getChildByName("Label_Desc"):setString("一条龙(35倍)")
        self.pPopCardsType:getChildByTag(3):getChildByName("Label_Desc"):setString("炸弹牛(30倍)")
        self.pPopCardsType:getChildByTag(2):getChildByName("Label_Desc"):setString("五小牛(25倍)")
        self.pPopCardsType:getChildByTag(12):getChildByName("Label_Desc"):setString("葫芦牛(25倍)")
        self.pPopCardsType:getChildByTag(4):getChildByName("Label_Desc"):setString("金牛(20倍)")
        self.pPopCardsType:getChildByTag(11):getChildByName("Label_Desc"):setString("同花牛(20倍)")
        self.pPopCardsType:getChildByTag(5):getChildByName("Label_Desc"):setString("银牛(15倍)")
        self.pPopCardsType:getChildByTag(10):getChildByName("Label_Desc"):setString("顺子牛(15倍)")

    else
        self.pPopCardsType:getChildByTag(13):getChildByName("Label_Desc"):setString("同花顺(10倍)")
        self.pPopCardsType:getChildByTag(1):getChildByName("Label_Desc"):setString("一条龙(9倍)")
        self.pPopCardsType:getChildByTag(3):getChildByName("Label_Desc"):setString("炸弹牛(8倍)")
        self.pPopCardsType:getChildByTag(2):getChildByName("Label_Desc"):setString("五小牛(7倍)")
        self.pPopCardsType:getChildByTag(12):getChildByName("Label_Desc"):setString("葫芦牛(7倍)")
        self.pPopCardsType:getChildByTag(4):getChildByName("Label_Desc"):setString("金牛(6倍)")
        self.pPopCardsType:getChildByTag(11):getChildByName("Label_Desc"):setString("同花牛(6倍)")
        self.pPopCardsType:getChildByTag(5):getChildByName("Label_Desc"):setString("银牛(5倍)")
        self.pPopCardsType:getChildByTag(10):getChildByName("Label_Desc"):setString("顺子牛(5倍)")

    end
end

-- 隐藏POP弹出框
function CreateRoom:hidePopFrame()
    self.pPopDoubleRate:setVisible(false)
    self.pPopCardsType:setVisible(false)
    self.pPopScoreNormal:setVisible(false)
    self.pPopScoreSpecial:setVisible(false)
    self.pPopZjhXi:setVisible(false)
    self.pPopZjhBaoXi:setVisible(false)
    self.pPopZjhMen:setVisible(false)
    self.pPopZjhDrop:setVisible(false)
     self.pPopHua:setVisible(false)
     
    if self.tpanel_to_button then
       for k,v in pairs(self.tpanel_to_button) do 
            for k1,v1 in pairs(v) do
                v1:setVisible(false)    
            end
       end
    end
    self.bClickPop = false
end

--推筒子玩法设置
function CreateRoom:SetOptionsTTZ(index)

end

-- start --
--------------------------------
-- @class function
-- @description 创建房间消息
-- @param msgTbl 消息体
-- end --
function CreateRoom:onRcvCreateRoom(msgTbl)
    if msgTbl.code ~= 0 then
        -- 创建失败
        gt.removeLoadingTips()

        -- code: 1:未登录 2:服务器维护 3:账号校验失败 4:房卡不足 5:创建数量过多 6:参数错误
        if msgTbl.code == 1 or msgTbl.code == 3 then
            -- 未登录
            require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0053"), nil, nil, true)
        elseif msgTbl.code == 2 then
            -- 服务器维护中
            require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0054"), nil, nil, true)
        elseif msgTbl.code == 4 then
            -- 房卡不足
            require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0049"), nil, nil, true)
        elseif msgTbl.code == 5 then
            -- 创建过多
            require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0052"), nil, nil, true)
        elseif msgTbl.code == 6 then
            -- 参数错误
            require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0050"), nil, nil, true)
        elseif msgTbl.code == 8 then
            -- 参数错误
            require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "您报名的即时赛场即将开赛，您需要先退赛才能创建新的房间", nil, nil, true)
        elseif msgTbl.code == 9 then
            -- 参数错误
            require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0069"), nil, nil, true)
		end
    end
end
return CreateRoom

