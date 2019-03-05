local gt = cc.exports.gt

local GameBrief = class("GameBrief", function()
	return cc.Layer:create()
end)

function GameBrief:ctor(msgTbl, curRound)
	self:setName("GameBrief")
	
    local csbNode = cc.CSLoader:createNode("games/SSS/csb/GameSmallResult.csb")
    csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.rootNode = csbNode

	self.Btn_HideResult = gt.seekNodeByName(self.rootNode, "Btn_HideResult")
	gt.addBtnPressedListener(self.Btn_HideResult,function()
		self:removeFromParent()
	end)

	self:showResult(msgTbl, curRound)
end

function GameBrief:showResult(msgTbl, curRound)	
	gt.seekNodeByName(self.rootNode, "Text_Round"):setString("第" .. curRound .. "局")
	local playerNum = #msgTbl.player_data
	if playerNum <= 4 then
		local upLine = gt.seekNodeByName(self.rootNode, "upLine")
		upLine:setPositionY(-40)
		gt.seekNodeByName(self.rootNode, "downLine"):setVisible(false)
	end
	
	for i=1, playerNum do
		local playerNode = gt.seekNodeByName(self.rootNode, "Panel_player"..i)
		local playerInfo = msgTbl.player_data[i]
		if playerNode and playerInfo then
			if gt.playerData.uid == playerInfo.player then
				if playerInfo.score > 0 then
					gt.seekNodeByName(self.rootNode, "Image_TitleWin"):setVisible(true)
					gt.seekNodeByName(self.rootNode, "Image_TitleLose"):setVisible(false)
				else
					gt.seekNodeByName(self.rootNode, "Image_TitleWin"):setVisible(false)
					gt.seekNodeByName(self.rootNode, "Image_TitleLose"):setVisible(true)
				end
			end
			
			local playerInfoStrs = json.decode(playerInfo.info)
			gt.seekNodeByName(playerNode, "Text_Name"):setString(playerInfoStrs.nick)
			
			local head_image_file = string.format("%shead_%d.png", cc.FileUtils:getInstance():getWritablePath(), playerInfo.player)
			if cc.FileUtils:getInstance():isFileExist(head_image_file) then
				gt.seekNodeByName(playerNode, "Sprite_Head"):setTexture(head_image_file)
			end
			
			local scoreNode = playerNode:getChildByName("Text_Score")
			if playerInfo.score > 0 then
				scoreNode:setString("+"..tostring(playerInfo.score))
				scoreNode:setFntFile("res/font/add.fnt")
			else
				scoreNode:setString(tostring(playerInfo.score))
				scoreNode:setFntFile("res/font/reduce.fnt")
			end
		end
		local cardBgNode = playerNode:getChildByName("Image_CardBg")
		for i=1, 13 do
			local cardNode = cardBgNode:getChildByName("lcard"..i)
			local head_image_file = string.format("image/card/%02x.png", playerInfo.cards_in_hand[i])
			cardNode:loadTexture(head_image_file, ccui.TextureResType.plistType)
		end
		for i=1, 3 do
			local scoreNode = cardBgNode:getChildByName("Text_CardScore_"..i)
			if playerInfo.scores[i] > 0 then
				scoreNode:setString("+"..tostring(playerInfo.scores[i]))
				scoreNode:setFntFile("res/font/cardScoreWin.fnt")
			else
				scoreNode:setString(tostring(playerInfo.scores[i]))
				scoreNode:setFntFile("res/font/cardScoreLose.fnt")
			end
		end
	end
	
	for i=playerNum + 1, 8 do
		gt.seekNodeByName(self.rootNode, "Panel_player"..i):setVisible(false)
	end
end

return GameBrief
