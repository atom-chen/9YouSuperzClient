--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local gt = cc.exports.gt
require("json")
local RoundRecord = class("RoundRecord", function()
	return cc.Scene:create()
end)
local sszCardTools =require("app/games/SSS/sszCardTools")

local Type2Rate = {
--	["0"] = 1,
--	["10"] = 1,
--	["15"] = 1,
--	["20"] = 1,
--	["25"] = 1,
--	["30"] = 1,
--	["35"] = 1,
--	["40"] = 1,
--	["45"] = 1,
--	["50"] = 1,
--	["55"] = 1,
--	["60"] = 1,
--	["65"] = 1,
--	["70"] = 1,
--	["75"] = 1,
	["80"] = 2,
	["85"] = 2,
	["90"] = 3,
	["95"] = 3,
	["110"] = 3,
	["120"] = 4, --豹子
	["130"] = 5, --白板豹子
}

function RoundRecord:ctor(roomData, game_id, tableScore, chairs)
    local csb = "csd/RoundRecord.csb"
    if game_id == gt.GameID.SANGONG or game_id == gt.GameID.ZJH then
        csb = "csd/RoundRecordSG.csb"
    elseif game_id == gt.GameID.TTZ then
        csb = "csd/RoundRecordTTZ.csb"
    elseif game_id == gt.GameID.SSS then
        csb = "games/SSS/csb/RoundRecordSSS.csb"
        chairs = 8
    end
    self:registerScriptHandler(handler(self, self.onNodeEvent))
	local csbNode = cc.CSLoader:createNode(csb)
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
    --ccui.Helper:doLayout(csbNode)
	self:addChild(csbNode)
	self.rootNode = csbNode
    self.roomData = roomData
    self.game_id = game_id
    self.tableScore = tableScore
    self.chairs = chairs

    local panelNickScore6 = gt.seekNodeByName(csbNode, "Panel_Nick_Score6")
	if panelNickScore6 then
		panelNickScore6:setVisible(false)
	end
    local panelNickScore8 = gt.seekNodeByName(csbNode, "Panel_Nick_Score8")
	if panelNickScore8 then
		panelNickScore8:setVisible(false)
	end
    local panelNickScore10 = gt.seekNodeByName(csbNode, "Panel_Nick_Score10")
	if panelNickScore10 then
		panelNickScore10:setVisible(false)
	end
    local panelNickScore12 = gt.seekNodeByName(csbNode, "Panel_Nick_Score12")
	if panelNickScore12 then
		panelNickScore12:setVisible(false)
	end
	
	local panelNickScore = gt.seekNodeByName(csbNode, "Panel_Nick_Score6")
	if 8 == chairs then
		panelNickScore = gt.seekNodeByName(csbNode, "Panel_Nick_Score8")
	elseif 10 == chairs then
		panelNickScore = gt.seekNodeByName(csbNode, "Panel_Nick_Score10")
	elseif 12 == chairs then
		panelNickScore = gt.seekNodeByName(csbNode, "Panel_Nick_Score12")
	end
	panelNickScore:setVisible(true)
	self.roundListView = panelNickScore:getChildByName("ListView_Round")
	self.pTemplate_1 = self.roundListView:getChildByName("Panel_Template")
	self.pTemplate_1:retain()
    self.pTemplate_2 = self.roundListView:getChildByName("Panel_RoundInfo")
	self.pTemplate_2:retain()

	--panel 高适配
	local panelSize = panelNickScore:getContentSize()
--	panelSize.width = panelSize.width + (gt.winSize.width - 1280)
	panelSize.height = panelSize.height + (gt.winSize.height - 720)
	panelNickScore:setContentSize(panelSize)
	
	--列表 宽+高适配
	local listSize = self.roundListView:getContentSize()
	listSize.width = listSize.width + (gt.winSize.width - 1280)
	listSize.height = listSize.height + (gt.winSize.height - 720)
	self.roundListView:setContentSize(listSize)
		
	--列表项 宽适配
	local tempSize = self.pTemplate_1:getContentSize()
	tempSize.width = tempSize.width + (gt.winSize.width - 1280)
	self.pTemplate_1:setContentSize(tempSize)
	
	--昵称栏 宽适配
	local imageNick = panelNickScore:getChildByName("Image_Top_Nick")
	imageNick:setContentSize(tempSize)
	
	tempSize.height = self.pTemplate_2:getContentSize().height
	self.pTemplate_2:setContentSize(tempSize)
	
	ccui.Helper:doLayout(csbNode)
	
	self.roundListView:removeAllChildren()

    self.lbRoundTip = gt.seekNodeByName(csbNode, "Text_Round_Tip")
    self.lbRoundTip:setVisible(false)

    --返回按钮
    local btnBack = gt.seekNodeByName(csbNode, "Btn_Back")
    gt.addBtnPressedListener(btnBack, function()
        self.pTemplate_1:release()
        self.pTemplate_2:release()
        self:removeFromParent()
        gt.dispatchEvent(gt.EventType.CLOSE_ROUNDRECORD)
    end)

    --隐藏昵称与总积分
	local imageScore = panelNickScore:getChildByName("Image_Bottom_Score")
    for i = 1, chairs do
        local nickName = imageNick:getChildByName("Text_Nick"..i)
        nickName:setVisible(false)
		
        local totalScoreWin = imageScore:getChildByName("Text_TotalScoreWin"..i)
        totalScoreWin:setVisible(false)
        local totalScoreLose = imageScore:getChildByName("Text_TotalScoreLose"..i)
        totalScoreLose:setVisible(false)
    end
    --玩家昵称
    for i, v in ipairs(roomData.players) do
        local nickName = imageNick:getChildByName("Text_Nick"..i)
        nickName:setString(gt.checkName(v.nick,6))
        nickName:setVisible(true)
    end
    --玩家总得分
    for i = 1, #tableScore do
        local totalScoreWin = imageScore:getChildByName("Text_TotalScoreWin"..i)
		local totalScoreLose = imageScore:getChildByName("Text_TotalScoreLose"..i)
		if tableScore[i] > 0 then
			totalScoreWin:setVisible(true)
			totalScoreLose:setVisible(false)
			totalScoreWin:setString("/"..tostring(tableScore[i]))
		else
			totalScoreWin:setVisible(false)
			totalScoreLose:setVisible(true)
			if 0 == tableScore[i] then
				totalScoreLose:setString(tostring(tableScore[i]))
			else
				totalScoreLose:setString("/"..tostring(tableScore[i]))
			end
		end
    end

    self:onHistoryList()
end

-- 局数列表
function RoundRecord:onHistoryList()
    self.lbRoundTip:setVisible(false)
    if (#self.roomData.round_data_list == 0) then
        self.lbRoundTip:setVisible(true)
    end
	-- 显示列表
	for i, cellData in ipairs(self.roomData.round_data_list) do
        local historyItem = self:roundHistoryItem(i, cellData, self.pTemplate_1:clone())
		self.roundListView:pushBackCustomItem(historyItem)
	end
end

function RoundRecord:roundHistoryItem(tag, cellData, item)
    local lbRound = item:getChildByName("Text_Round")
    lbRound:setString(cellData.current_round)

    -- 回访码
    local replayCold = item:getChildByName("Text_ReplayCold")
    replayCold:setString("")


    --分数
    for i = 1, self.chairs do
        local scoreWin = item:getChildByName("Text_ScoreWin"..i)
        scoreWin:setVisible(false)
        local scoreLose = item:getChildByName("Text_ScoreLose"..i)
        scoreLose:setVisible(false)
    end
    for i, v in ipairs(self.roomData.players) do
        for j = 1, #(cellData.player_data) do
            local playerData = cellData.player_data[j]
            if playerData.player == v.player and playerData.score then
				local scoreWin = item:getChildByName("Text_ScoreWin"..i)
				local scoreLose = item:getChildByName("Text_ScoreLose"..i)
				if playerData.score > 0 then
					scoreWin:setVisible(true)
					scoreLose:setVisible(false)
					scoreWin:setString("/"..tostring(playerData.score))
				else
					scoreWin:setVisible(false)
					scoreLose:setVisible(true)
					if 0 == playerData.score then
						scoreLose:setString(tostring(playerData.score))
					else
						scoreLose:setString("/"..tostring(playerData.score))
					end
				end
            end
        end
    end

    local function showItem(list, s, Item)
        local index = list:getIndex(s:getParent()) + 1
        local bClicked = s:getTag()

        if bClicked == 0 then
            local infoItem = self:infoItem(index, cellData, Item)
            list:insertCustomItem(infoItem, index)
            list:jumpToItem(index, cc.p(0,0), cc.p(0,0))
            s:setTag(1)
            s:setRotation(180)
        else
            list:removeItem(index)
            list:jumpToItem(index-1,cc.p(0,0),cc.p(0,0))
            s:setRotation(0)
            s:setTag(0)
        end
    end

    local btnInfo = gt.seekNodeByName(item, "Button_Info")
    btnInfo:setTag(0)
    gt.addBtnPressedListener(btnInfo, function(sender)
        showItem(self.roundListView, sender, self.pTemplate_2:clone())
        self.replayCold = replayCold
    end)

    return item
end

function RoundRecord:infoItem(index, cellData, item)
--    local btnClose = gt.seekNodeByName(item, "Btn_Close")
--    btnClose:setVisible(false)

--    local imgInner = item:getChildByName("Img_Inner")
--    local children = imgInner:getChildren()
--    print("count", #children)
--    for i, v in pairs(children) do
--        print("child", i, v:getName())
--    end

--[[    -- 分享
    local btnShare = gt.seekNodeByName(item, "Btn_Share")
    gt.addBtnPressedListener(btnShare, function(sender)
--        extension.shareToURL(extension.SHARE_TYPE_SESSION, self.replayCold:getString())
        require("app/views/NoticeTips"):create("提示", "敬请期待", nil, nil, true)
    end)
    -- 回放
    local btnReplay = gt.seekNodeByName(item, "Btn_Replay")
    gt.addBtnPressedListener(btnReplay, function(sender)
        --local msg={}
        --msg.cmd=gt.ROOM_REPLAY
        --msg.replay_code=cellData.replay_code
        --gt.socketClient:sendMessage(msg)
        require("app/views/NoticeTips"):create("提示", "敬请期待", nil, nil, true)
    end)--]]

    --先隐藏所有牌型
    for i = 1, self.chairs, 1 do
        local nodeItem = item:getChildByName(string.format("Node_Item%d", i))
        nodeItem:setVisible(false)
    end
    --展示每个人的牌型
    for i, v in ipairs(self.roomData.players) do
        local nodeItem = item:getChildByName(string.format("Node_Item%d", i))
        for j, playerData in ipairs(cellData.player_data) do
            if playerData.player == v.player and playerData.score then
                nodeItem:setVisible(true)
                if self.game_id ~= gt.GameID.TTZ and self.game_id ~= gt.GameID.SSS  then
                -- 显示抢庄倍数
                local loot_dealer = nodeItem:getChildByName("Img_LootDealer")
                loot_dealer:setVisible(false)
                if self.roomData.game_type == gt.GameType.GAME_BANKER or self.roomData.game_type == gt.GameType.GAME_FREE_BANKER or self.roomData.game_type == gt.GameType.GAME_QH_BANKER then
                    if playerData.q and playerData.q > 0 then
                        
                        loot_dealer:loadTexture( string.format("image/record/loot_dealer"..playerData.q..".png"), ccui.TextureResType.plistType)
                        loot_dealer:setVisible(true)
                        end
                    end
                end

                --牌型
                local pledgeBg = nodeItem:getChildByName("Image_PledgeBg")
                local lbPledge = nil
                local imgZhuang = nodeItem:getChildByName("Image_Zhuang")
                local nodeCard = nodeItem:getChildByName("Node_Card")
                local special_type_Node = gt.seekNodeByName(nodeItem, "special_type")
		        local buyPledgeBg = nodeItem:getChildByName("Image_BuyPledgeBg")
                nodeCard:setVisible(true)
                if pledgeBg then
                    pledgeBg:setVisible(true)
					lbPledge = pledgeBg:getChildByName("BFL_Pledge")
                end
                if imgZhuang then
                  imgZhuang:setVisible(false)
                end
                if buyPledgeBg then
                    buyPledgeBg:setVisible(false)
                end
                if (playerData.pledge ~= nil) then
                    --pledge押分字段是后来加的，之前没这个字段，要兼容旧版本
--                    if #playerData.cards_in_hand > 5 then
--                        return
--                    end

                    
                     if   playerData.scores  then
                        for k = 1, #playerData.scores do
                            local score  = nodeCard:getChildByName("score_"..k)
                            score:setString(playerData.scores[k])
                        end
                     end

                     if playerData.special_type  then
                        
                         local specialName  = sszCardTools:getspecailKeyToString(playerData.special_type)
                        if  specialName then
                            special_type_Node:setString(specialName)
                        else
                             special_type_Node:setString("")
                        end

                     end

                    for k = 1, #playerData.cards_in_hand do
                        local handCard = {}
                        local cardVal = playerData.cards_in_hand[k]
                        local imgCard = nodeCard:getChildByName(string.format("Img_Card%d", k))
                        table.insert(handCard, imgCard)
                        imgCard:loadTexture(string.format("image/record/%02x.png", cardVal), ccui.TextureResType.plistType)
                        if self.game_id == gt.GameID.TTZ and self.roomData.game_type ==gt.GameType.GAME_TTZ_MJ then
                            imgCard:loadTexture(string.format("image/record/ttz/mj%02x.png", cardVal), ccui.TextureResType.plistType)
                        end

                        if self.game_id ~= gt.GameID.SSS or self.roomData.game_type ~= 7 then
                            --牛类型
                            local imgNiuType = nodeCard:getChildByName("Image_NiuType")
                            if self.game_id == gt.GameID.NIUNIU or self.game_id == gt.GameID.QIONGHAI then
                                imgNiuType:loadTexture(string.format("image/record/%s.png", gt.NIU_NAME[playerData.niu+1]), ccui.TextureResType.plistType)
                            elseif self.game_id == gt.GameID.NIUYE then
                                imgNiuType:loadTexture(string.format("image/record/ys_%s.png", gt.NIU_NAME[playerData.niu+1]), ccui.TextureResType.plistType)
                            elseif self.game_id == gt.GameID.SANGONG then
                                imgNiuType:loadTexture(string.format("image/record/sg%d.png", playerData.niu), ccui.TextureResType.plistType)
                            elseif self.game_id == gt.GameID.TTZ then
                                imgNiuType:loadTexture(string.format("image/record/ttz/%d.png", playerData.niu), ccui.TextureResType.plistType)
                            else
                                imgNiuType:setVisible(false)
                            end

                            --牛倍数
                            local imgRate = nodeCard:getChildByName("Image_Rate")
                            local ratePath = nil
                            if self.game_id == gt.GameID.SANGONG then
                                ratePath = gt.getSGRateResPath(playerData.niu, true)
                            elseif self.game_id == gt.GameID.TTZ then
                                if playerData.niu >= 80 then
                                    local rate = Type2Rate[tostring(playerData.niu)]
                                    ratePath = string.format("image/record/b%d.png",rate)
                                end

                            elseif self.game_id == gt.GameID.ZJH then
                                ratePath = nil
                            else
                                ratePath = gt.getNiuRateResPath(self.roomData.double_type, playerData.niu, true)
                            end

                            if (ratePath ~= nil) then
                                imgRate:loadTexture(ratePath, ccui.TextureResType.plistType)
                                imgRate:setVisible(true)
                            else
                                imgRate:setVisible(false)
                            end

                            -- buy_pledge_dict 记录别人在你这里的买码
                            if playerData.buy_pledge_dict and false then
                                local total_buyPledge = 0
                                for k,v in pairs(playerData.buy_pledge_dict) do
                                    total_buyPledge = total_buyPledge + tonumber(v)
                                end
                                if total_buyPledge > 0 and buyPledgeBg then
                                    buyPledgeBg:setVisible(true)
                                    local lblBuyPledge = buyPledgeBg:getChildByName("lblBuyPledge")
                                    if lblBuyPledge then
                                        lblBuyPledge:setString(total_buyPledge)
                                    end
                                end
                            end

                            -- buy_pledge_other_dict 你买的别人的码
                            if playerData.buy_pledge_other_dict then
                                for k,v in pairs(playerData.buy_pledge_other_dict) do
                                    if buyPledgeBg and tonumber(v) > 0 then
                                        buyPledgeBg:setVisible(true)
                                        local lblBuyPledge = buyPledgeBg:getChildByName("BFL_Pledge")
                                        if lblBuyPledge then
                                            lblBuyPledge:setString(tonumber(v))
                                        end
                                        local lblBuyName = buyPledgeBg:getChildByName("Text_1")
                                        if lblBuyName then
                                            local buyPlayer = nil
                                            for x_, p_ in ipairs(cellData.player_data) do
                                                if p_.seat == tonumber(k) then
                                                    buyPlayer = p_
                                                    break
                                                end 
                                            end
                                            if buyPlayer then
                                                local infos = json.decode(buyPlayer.info)
                                                lblBuyName:setString(string.format("%s",gt.checkName(infos.nick, 3) ))
                                            end
                                        end
                                    end
                                end
                            end


                            if (playerData.z == 1) then
                                --是庄家
                                imgZhuang:setVisible(true)
                                pledgeBg:setVisible(false)
                                if self.game_id == gt.GameID.ZJH then
                                    pledgeBg:setVisible(true)
                                    imgZhuang:setPositionY(imgZhuang:getPositionY() - 15)
                                    lbPledge:setString(playerData.pledge_max.."分")
	                            end
                            else
                                imgZhuang:setVisible(false)
                                pledgeBg:setVisible(true)
                                lbPledge:setString(playerData.pledge.."分")
	                            if self.game_id == gt.GameID.QIONGHAI then
	                                --琼海抢庄
	                                lbPledge:setString("x"..playerData.pledge)
                                elseif self.game_id == gt.GameID.ZJH then
                                    lbPledge:setString(playerData.pledge_max.."分")
	                                end
                                end
                            end
                    end
                else
                    nodeCard:setVisible(false)
                    pledgeBg:setVisible(false)
                    imgZhuang:setVisible(false)
                    buyPledgeBg:setVisible(false)       
                end
            end
        end
    end
    return item
end

function RoundRecord:onNodeEvent(eventName)
    if "enter" == eventName then
        gt.socketClient:registerMsgListener(gt.ROOM_REPLAY, self, self.onRcvReplay)
    elseif "exit" == eventName then
        gt.socketClient:unregisterMsgListener(gt.ROOM_REPLAY)
    end
end

function RoundRecord:onRcvReplay(msg)
	if msg.code==0 then
		local enterRoomMsg=msg.replay.room.param
		enterRoomMsg.player_data=msg.replay.player_data
		enterRoomMsg.current_round=msg.replay.current_round
		enterRoomMsg.owner_id=msg.replay.owner_id
		enterRoomMsg.room_id=msg.replay.room.room_id
		enterRoomMsg.IsReplay=true
		enterRoomMsg.replay=msg.replay.replay_data

		local replayLayer
		if msg.replay.room.param.game_id==gt.GameID.NIUNIU or msg.replay.room.param.game_id==gt.GameID.QIONGHAI then
			replayLayer = require("app/views/PlayScene"):create(enterRoomMsg)
		elseif msg.replay.room.param.game_id==gt.GameID.NIUYE then
			replayLayer = require("app/views/PlaySceneYS"):create(enterRoomMsg)
		elseif msg.replay.room.param.game_id==gt.GameID.SANGONG then
			replayLayer = require("app/views/PlaySceneSG"):create(enterRoomMsg)
        elseif msg.replay.room.param.game_id==gt.GameID.TTZ then
            replayLayer = require("app/views/PlaySceneTTZ"):create(enterRoomMsg)
        elseif msg.replay.room.param.game_id==gt.GameID.ZJH then
            replayLayer = require("app/views/PlaySceneZJH"):create(enterRoomMsg)
        end
        self:addChild(replayLayer, 6)
    else

	end
end

return RoundRecord

--endregion