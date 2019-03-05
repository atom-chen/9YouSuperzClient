
local gt = cc.exports.gt
require "app/games/SSS/config"
require "app/effect/shaderEffect"

local sszCardTools =require("app/games/SSS/sszCardTools")


 local function main_SSS(...)
   local t = {...}
   local self = t[1]
   local allRoomSetting = t[2] 
   local card_1 =  gt.seekNodeByName(self.SSS_csbNode, "card_1") 
   local card_2 =  gt.seekNodeByName(self.SSS_csbNode, "card_2")
   local card_3 =  gt.seekNodeByName(self.SSS_csbNode, "card_3")
   
   local mapaiCheck  =  self.checkBoxs.SSS["Check_2"]
   
   local isRestore = true
   if sszCardTools.hasElement(allRoomSetting)  == false or allRoomSetting[gt.GameID.SSS] == nil    then
        gt.MyShader.setNodeDarken(card_1)
        gt.MyShader.setNodeDarken(card_2)
        gt.MyShader.setNodeDarken(card_3)
        gt.games_config_list[gt.GameID.SSS].wanfa.Check_2[2] = 1
        isRestore = false
   end

   
   mapaiCheck:addClickEventListener(function (sender)
        if sender:isSelected() == false then
           gt.MyShader.setNodeDarken(card_1)
            gt.MyShader.setNodeDarken(card_2)
            gt.MyShader.setNodeDarken(card_3)
            gt.games_config_list[gt.GameID.SSS].wanfa.Check_2[2] = 1
        else
            gt.MyShader.setNodeRestore(card_1)
            gt.MyShader.setNodeDarken(card_2)
            gt.MyShader.setNodeDarken(card_3)
            gt.games_config_list[gt.GameID.SSS].wanfa.Check_2[2] = 5
        end
end)
   

   local cards = {card_1,card_2,card_3}
   local mapai_v = {5,10,13}
   for k,v in pairs(cards) do
        v:setTouchEnabled(true)
        if isRestore then
         if allRoomSetting[gt.GameID.SSS].mapai == mapai_v[k] then
                 gt.MyShader.setNodeRestore(v)
                 mapaiCheck:setSelected(true)
                 gt.games_config_list[gt.GameID.SSS].wanfa.Check_2[2] = mapai_v[k]
         else
                 gt.MyShader.setNodeDarken(v)             
         end
       end 
       v:addClickEventListener(function (sender)     
            gt.MyShader.setNodeDarken(card_1)
            gt.MyShader.setNodeDarken(card_2)
            gt.MyShader.setNodeDarken(card_3)
            gt.MyShader.setNodeRestore(sender)
            gt.games_config_list[gt.GameID.SSS].wanfa.Check_2[2] = mapai_v[k]
        end)
   end

  
  
    local flag1 = true
    local flag2 = true

        for i=1,8 do
           local v = self.checkBoxs.SSS[i]
           v:addClickEventListener(
            function (sender)
                 

                 gt.delayRun(0.0,
                           function ()
                                  local flag1 = true
                                  local flag2 = true

                                  for i=1,8 do
                                   local v = self.checkBoxs.SSS[i]
                                    if v:isSelected() == false then
                                            flag1 = false 
                                    else
                                           flag2 = false
                                    end
                               end

                               if flag2 then
                                    gt.seekNodeByName(self.lstConfs, "Label_SelCardsType"):setText("特殊牌型：无勾选")
                               elseif flag1 then
                                    gt.seekNodeByName(self.lstConfs, "Label_SelCardsType"):setText("特殊牌型：全勾选")
                                else
                                    gt.seekNodeByName(self.lstConfs, "Label_SelCardsType"):setText("特殊牌型：部分勾选")
                               end

                           end
                           )

            end
           )
                   
            if v:isSelected() == false then
                    flag1 = false 
            else
                   flag2 = false
            end
       end

       if flag2 then
            gt.seekNodeByName(self.SSS_csbNode, "Label_SelCardsType"):setText("特殊牌型：无勾选")
       elseif flag1 then
            gt.seekNodeByName(self.SSS_csbNode, "Label_SelCardsType"):setText("特殊牌型：全勾选")
        else
            gt.seekNodeByName(self.SSS_csbNode, "Label_SelCardsType"):setText("特殊牌型：部分勾选")
       end

  
       for i=1 ,7 do
        local sender =  self.checkBoxs.SSS["Check6_"..i]
             if sender:isSelected() == true then    
            -- local a=   this.lstConfs:getChildByName("Panel_5"):getChildren()
               local str  = sender:getChildByName("Label_Desc"):getString()
                gt.seekNodeByName(self.SSS_csbNode, "Label_SelDoubleRate"):setString("人数选择:"..str)
                break
             end
   
       end

end

gt.main_SSS = main_SSS

local function checkBoxTouchCallBack_SSS(this,sender)
    

   if  string.sub( sender:getName(), 1,7)  == "Check6_" then
         if sender:isSelected() == false then    
        -- local a=   this.lstConfs:getChildByName("Panel_5"):getChildren()
           local str  = sender:getChildByName("Label_Desc"):getString()
            gt.seekNodeByName(this.lstConfs, "Label_SelDoubleRate"):setString("人数选择:"..str) 
         end
    -- elseif string.sub(sender:getName(), 1, 7)  == "Check1_" then
    --     print("111111111111111111111111111111111111")
        -- refreshConsumeDisplay(self)
   end
end


gt.checkBoxTouchCallBack_SSS = checkBoxTouchCallBack_SSS

local function checkBoxTouchEndedCallBack(this,sender)
    local function refreshConsumeDisplay(this)
        local round = 10
        if this.checkBoxs["SSS"]["Check1_2"]:isSelected() then
            round = 20
        elseif this.checkBoxs["SSS"]["Check1_3"]:isSelected() then
            round = 30
        end

        local playerNum = 4
        if this.checkBoxs["SSS"]["Check6_2"]:isSelected() then
            playerNum = 8
        end

        local aaPay = gt.getRoomCardConsume(this.game_id, 2, round, playerNum)
        local ownerPay = gt.getRoomCardConsume(this.game_id, 1, round, playerNum)

        this.checkBoxs["SSS"]["Check2_1"]:getChildByName("Label_Desc"):setString("AA付费(每人x" .. aaPay .. ")")
        this.checkBoxs["SSS"]["Check2_2"]:getChildByName("Label_Desc"):setString("房主付费(房卡x" .. ownerPay .. ")")
    end

    if string.sub(sender:getName(), 1, 7) == "Check1_" or string.sub( sender:getName(), 1, 7) == "Check6_" then
        refreshConsumeDisplay(this)
   end
end

gt.checkBoxTouchEndedCallBack = checkBoxTouchEndedCallBack

