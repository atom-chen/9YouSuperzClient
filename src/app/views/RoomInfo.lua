local gt = cc.exports.gt

local RoomInfo = class("RoomInfo", function()
	return gt.createMaskLayer()
end)

function RoomInfo:ctor(tableSetting, roomId, isTwelve,fun)
	self:setName("RoomInfo")
	local csbNode = cc.CSLoader:createNode("csd/RoomInfo.csb")
    if tableSetting.game_id == gt.GameID.SANGONG or tableSetting.game_id == gt.GameID.ZJH or tableSetting.game_id == gt.GameID.SSS then
        csbNode = cc.CSLoader:createNode("csd/RoomInfoSG.csb")
    end
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.rootNode = csbNode

    if isTwelve then
        csbNode:setRotation(-90)
    end

	-- 关闭按钮
	local closeBtn = gt.seekNodeByName(csbNode, "Btn_Close")
	gt.addBtnPressedListener(closeBtn, function()
		self:removeFromParent()
	end)

	-- 房间号
	local lbRoomID = gt.seekNodeByName(csbNode, "Label_RoomID")
	lbRoomID:setVisible(false)
	if roomId ~= nil then
		lbRoomID:setString(string.format("房间号:%d", roomId))
		lbRoomID:setVisible(true)
	end

	-- 玩法
	local lbType = gt.seekNodeByName(csbNode, "lbType")
	local strGameType = gt.GameTypeDesc[tableSetting.game_type]
	if tableSetting.game_id == gt.GameID.SANGONG then
		strGameType = gt.GameSGTypeDesc[tableSetting.game_type]
	elseif tableSetting.game_id==gt.GameID.TTZ then
		strGameType=gt.GameTTZTypeDesc[tableSetting.game_type]
	elseif tableSetting.game_id == gt.GameID.ZJH then
        strGameType = gt.GameZJHTypeDesc[tableSetting.game_type]
    elseif tableSetting.game_id == gt.GameID.SSS then
        strGameType = gt.GameSSSTypeDesc[tableSetting.game_type]
    end
    lbType:setString(strGameType)

    if tableSetting.game_id == gt.GameID.SSS and  tableSetting.game_type == 7 then
          if fun then
            fun(csbNode)
          end
        return 
    end

    local strPay, strRate, strScore, baseScore, rate, strRule, strSpecial = gt.getRoomInfo(tableSetting, true)

    local lbScoreTitle = gt.seekNodeByName(csbNode, "lbScoreTitle")
    if tableSetting.game_type == gt.GameType.GAME_QH_BANKER then
        -- 琼海抢庄
        lbScoreTitle:setString("闲家倍数")
        strScore = string.format("%d倍", tableSetting.score)
    else
        lbScoreTitle:setString("底分")
    end
	-- 底分
	local lbScore = gt.seekNodeByName(csbNode, "lbScore")
	lbScore:setString(strScore)

    --底分
    local lbScore = gt.seekNodeByName(csbNode, "lbScore")
    lbScore:setString(strScore)

    --翻倍规则(三公没有)
    if tableSetting.game_id ~= gt.GameID.SANGONG and tableSetting.game_id ~= gt.GameID.ZJH then
        local lbRateRule = gt.seekNodeByName(csbNode, "lbRateRule")
        lbRateRule:setString(strRate)
	elseif tableSetting.game_id==gt.GameID.TTZ then
		local lbRateRule = gt.seekNodeByName(csbNode, "lbRateRule")
		lbRateRule:setString(strRate)
	end

	-- 房间规则
	local rule = strPay..strRule
	local lbRoomRule = gt.seekNodeByName(csbNode, "lbRoomRule")
	lbRoomRule:setString(rule)

	-- 特殊玩法
	local lbRoomSpecial = gt.seekNodeByName(csbNode, "lbRoomSpecial")
	lbRoomSpecial:setString(strSpecial)

end

return RoomInfo

