local gt = cc.exports.gt

local MatchExtraPro = class("MatchExtraPro",function()
	return gt.createMaskLayer()
end)

function MatchExtraPro:ctor(guild_id,matchView, is_union)
	local csbName = "csd/Guild/MatchExtraPro.csb"
	if is_union then
		csbName = "csd/Guild/UnionExtraPro.csb"
	end
	gt.log("-----openUI:MatchExtraPro")
	local csbNode = cc.CSLoader:createNode(csbName)
	csbNode:setAnchorPoint(0.5,0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	self.guild_id = guild_id
	self.matchView = matchView
	self.is_union = is_union or false

	self.CurPopPanel = nil
	self.style = 1
	self.amount = 1
	self.score = 100
	self.winners = 0

	self.neg = 0
	self.sits = 2000
	self.loots = 1000

	local btnCancel = gt.seekNodeByName(csbNode,"Btn_Close")
	gt.addBtnPressedListener(btnCancel,function()
		self:close()
	end)

	--参与游戏分数
	local Img_ScoreBG = gt.seekNodeByName(csbNode,"Img_ScoreBG")
	self.Text_ModSitScore = gt.seekNodeByName(csbNode,"Text_ModSitScore")
	self.Btn_Modsit = gt.seekNodeByName(Img_ScoreBG,"Btn_ModSitScore")
	self.Btn_Modsit:addClickEventListener(function()
		local view = require("app/views/Guild/GuildNumberPad"):create("get_number",0,0,handler(self,self.modSitScore))
		self:addChild(view)
		self:setGuideVisable(self.ImgGuide2,false,2)
	end)

	--参与抢庄分数
	local Img_Score2BG = gt.seekNodeByName(csbNode,"Img_Score2BG")
	self.Text_ModLootScore = gt.seekNodeByName(Img_Score2BG,"Text_ModLootScore")
	self.Btn_ModLootScore = gt.seekNodeByName(Img_Score2BG,"Btn_ModLootScore")
	self.Btn_ModLootScore:addClickEventListener(function()
		local view = require("app/views/Guild/GuildNumberPad"):create("get_number",0,0,handler(self,self.modLootScore))
		self:addChild(view)
		self:setGuideVisable(self.ImgGuide3,false,3)
	end)

	--是否允许负分
	local Img_RuleBG = gt.seekNodeByName(csbNode,"Img_RuleBG")
	self.chkNeg1 = gt.seekNodeByName(Img_RuleBG,"Chk_Neg1")
	self.chkNeg1:setTag(0)
	self.chkNeg2 = gt.seekNodeByName(Img_RuleBG,"Chk_Neg2")
	self.chkNeg2:setTag(1)
	local function onCheck(sender)
		self.neg = sender:getTag()
		self:setGuideVisable(self.ImgGuide4,false,4)
		self:refreshView()
	end
	self.chkNeg1:addClickEventListener(onCheck)
	self.chkNeg2:addClickEventListener(onCheck)

	--赠送
	local Img_EmojiBG = gt.seekNodeByName(csbNode,"Img_EmojiBG")
	local Img_WinnersBG = gt.seekNodeByName(Img_EmojiBG,"Img_WinnersBG")
	local Img_AmountBG = gt.seekNodeByName(Img_EmojiBG,"Img_AmountBG")
	local Img_ScoreBG = gt.seekNodeByName(Img_EmojiBG,"Img_ScoreBG")

	--弹出框
	self.Pop_Winners = Img_WinnersBG:getChildByName("Img_SelectBG")
	self.Pop_Amount = Img_AmountBG:getChildByName("Img_SelectBG")
	self.Pop_Score = Img_ScoreBG:getChildByName("Img_SelectBG")
	self.popPanel = {}
	table.insert(self.popPanel,self.Pop_Amount)
	table.insert(self.popPanel,self.Pop_Score)
	table.insert(self.popPanel,self.Pop_Winners)
	for i,v in ipairs(self.popPanel) do
		v:setVisible(false)
	end

	--打开按钮
	self.Panel_PopTouch = gt.seekNodeByName(csbNode,"Panel_PopTouch")
	self.Btn_OpenWinners = Img_WinnersBG:getChildByName("Btn_Open")
	self.Btn_OpenWinners:addClickEventListener(function()
		if self.CurPopPanel == self.Pop_Winners then
			self:closePopPanel(self.Pop_Winners)
		else
			self:closeAllPopPanel()
			self:openPopPanel(self.Pop_Winners)
		end
		-- self._guide5_1 = true
		self.ImgGuide5:setVisible(false)
		-- if self._guide5_1 and self._guide5_2 and self._guide5_3 then
		-- 	self:setGuideVisable(self.ImgGuide5,false,5)
		-- end
	end)
	self.Btn_OpenAmount = Img_AmountBG:getChildByName("Btn_Open")
	self.Btn_OpenAmount:addClickEventListener(function()
		if self.CurPopPanel == self.Pop_Amount then
			self:closePopPanel(self.Pop_Amount)
		else
			self:closeAllPopPanel()
			self:openPopPanel(self.Pop_Amount)
		end
		-- self._guide5_2 = true
		self.ImgGuide5:setVisible(false)
		-- if self._guide5_1 and self._guide5_2 and self._guide5_3 then
		-- 	self:setGuideVisable(self.ImgGuide5,false,5)
		-- end
	end)
	self.Btn_OpenScore = Img_ScoreBG:getChildByName("Btn_Open")
	self.Btn_OpenScore:addClickEventListener(function()
		if self.CurPopPanel == self.Pop_Score then
			self:closePopPanel(self.Pop_Score)
		else
			self:closeAllPopPanel()
			self:openPopPanel(self.Pop_Score)
		end
		-- self._guide5_3 = truze
		self.ImgGuide5:setVisible(false)
		-- if self._guide5_1 and self._guide5_2 and self._guide5_3 then
		-- 	self:setGuideVisable(self.ImgGuide5,false,5)
		-- end
	end)

	self.Panel_PopTouch:addTouchEventListener(function(sender,eventType)
		self:closeAllPopPanel()
	end)
	self.Panel_PopTouch:setVisible(false)

	--赢家设置
	for _,v in ipairs(self.Pop_Winners:getChildren()) do
		if v:getName()~="delimiter" then
			v:addClickEventListener(function(sender)
				for __,btn in ipairs(self.Pop_Winners:getChildren()) do
					if v:getName()~="delimiter" then
						if btn ~= sender then
							local tag = sender:getTag()
							if tag == 99 then
								self.style = 1
							else
								self.style = 0
								self.winners = sender:getTag()
							end
							btn:setEnabled(true)
						else
							btn:setEnabled(false)
							Img_WinnersBG:getChildByName("Text_Desc"):setString(btn:getTitleText())
						end
						self:closeAllPopPanel()
						self._guide5_1 = true
						if self._guide5_1 and self._guide5_2 and self._guide5_3 then
							self:setGuideVisable(self.ImgGuide5,false,5)
						end
					end
				end
			end)
		end
	end
	--赠送表情
	for _,v in ipairs(self.Pop_Amount:getChildByName("ListView"):getChildren()) do
		if v:getName()~="delimiter" then
			v:addClickEventListener(function(sender)
				for __,btn in ipairs(self.Pop_Amount:getChildByName("ListView"):getChildren()) do
					if v:getName()~="delimiter" then
						if btn ~= sender then
							self.amount = sender:getTag()
							btn:setEnabled(true)
						else
							btn:setEnabled(false)
							Img_AmountBG:getChildByName("Text_Desc"):setString(btn:getTitleText())
						end
						self:closeAllPopPanel()
						self._guide5_2 = true
						if self._guide5_1 and self._guide5_2 and self._guide5_3 then
							self:setGuideVisable(self.ImgGuide5,false,5)
						end
					end
				end
			end)
		end
	end
	--分数
	for _,v in ipairs(self.Pop_Score:getChildByName("ListView"):getChildren()) do
		if v:getName()~="delimiter" then
			v:addClickEventListener(function(sender)
				for __,btn in ipairs(self.Pop_Score:getChildByName("ListView"):getChildren()) do
					if v:getName()~="delimiter" then
						if btn ~= sender then
							self.score = sender:getTag()
							btn:setEnabled(true)
						else
							btn:setEnabled(false)
							Img_ScoreBG:getChildByName("Text_Desc"):setString(btn:getTitleText())
						end
						self:closeAllPopPanel()
						self._guide5_3 = true
						if self._guide5_1 and self._guide5_2 and self._guide5_3 then
							self:setGuideVisable(self.ImgGuide5,false,5)
						end
					end
				end
			end)
		end
	end



	--确认按钮
	local btnOk = gt.seekNodeByName(csbNode,"Btn_Ok")
	gt.addBtnPressedListener(btnOk,function()
		if self.sits < 100 then
			require("app/views/NoticeTips"):create("提示","参与游戏分数不能低于100分",nil,nil,true)
			return
		end
		self:setGuideVisable(self.ImgGuide6,false,6)
		local msgToSend = {}
		msgToSend.cmd = gt.MATCH_EXTRA
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		msgToSend.guild_id = guild_id
		msgToSend.set = 1
		msgToSend.neg = self.neg
		msgToSend.sits = self.sits
		msgToSend.loots = self.loots
		msgToSend.style = self.style
		msgToSend.amount = self.amount
		msgToSend.score = self.score
		msgToSend.winners = self.winners
		gt.socketClient:sendMessage(msgToSend)
		gt.showLoadingTips("")
		if not self.is_union then
			self.matchView:checkGuide()
		end
	end)

	--遮罩处理

	gt.socketClient:registerMsgListener(gt.MATCH_EXTRA,self,self.onRcvMatchExtra)

	local msgToSend = {}
	msgToSend.cmd = gt.MATCH_EXTRA
	msgToSend.user_id = gt.playerData.uid
	msgToSend.open_id = gt.playerData.openid
	msgToSend.guild_id = guild_id
	msgToSend.set = 0
	gt.socketClient:sendMessage(msgToSend)
	gt.showLoadingTips("")


	self.ImgGuide2 = gt.seekNodeByName(csbNode , "ImgGuide2")
	if self.ImgGuide2 then
		self.ImgGuide2:setVisible(false)
		gt.addBtnPressedListener(self.ImgGuide2:getChildByName("btnGuide"), function()
			self:setGuideVisable(self.ImgGuide2,false,2)
		end)
	end	
	self.ImgGuide3 = gt.seekNodeByName(csbNode , "ImgGuide3")
	if self.ImgGuide3 then
		self.ImgGuide3:setVisible(false)
		gt.addBtnPressedListener(self.ImgGuide3:getChildByName("btnGuide"), function()
			self:setGuideVisable(self.ImgGuide3,false,3)
		end)
	end	
	self.ImgGuide4 = gt.seekNodeByName(csbNode , "ImgGuide4")
	if self.ImgGuide4 then
		self.ImgGuide4:setVisible(false)
		gt.addBtnPressedListener(self.ImgGuide4:getChildByName("btnGuide"), function()
			self:setGuideVisable(self.ImgGuide4,false,4)
		end)
	end	
	self.ImgGuide5 = gt.seekNodeByName(csbNode , "ImgGuide5")
	if self.ImgGuide5 then
		self.ImgGuide5:setVisible(false)
		gt.addBtnPressedListener(self.ImgGuide5:getChildByName("btnGuide"), function()
			self:setGuideVisable(self.ImgGuide5,false,5)
		end)
	end	
	self.ImgGuide6 = gt.seekNodeByName(csbNode , "ImgGuide6")
	if self.ImgGuide6 then
		self.ImgGuide6:setVisible(false)
		gt.addBtnPressedListener(self.ImgGuide6:getChildByName("btnGuide"), function()
			self:setGuideVisable(self.ImgGuide6,false,6)
		end)
	end
	self._guide5_1 = false
	self._guide5_2 = false
	self._guide5_3 = false


	self:checkGuide()
end

function MatchExtraPro:checkGuide()
	--guide
	local guild =nil
	if self.is_union then
		guild= gt.UnionManager:getGuild(self.guild_id)
	else
		guild= gt.guildManager:getGuild(self.guild_id)
	end
	if guild.owner_id == gt.playerData.uid then  
		local guideIndex = cc.UserDefault:getInstance():getIntegerForKey("guildGuide", 0)
		if guideIndex == 1 then
			self:setGuideVisable(self.ImgGuide2,true)
		elseif guideIndex == 2 then
			self:setGuideVisable(self.ImgGuide3,true)
		elseif guideIndex == 3 then
			self:setGuideVisable(self.ImgGuide4,true)
		elseif guideIndex == 4 then
			self._guide5_1 = false
			self._guide5_2 = false
			self._guide5_3 = false
			self:setGuideVisable(self.ImgGuide5,true)
		elseif guideIndex == 5 then
			self:setGuideVisable(self.ImgGuide6,true)
		end
	end
end

function MatchExtraPro:setGuideVisable(sender, isShow,hideValue)
	if isShow then
		gt.scaleNode(sender)
	else
		if cc.UserDefault:getInstance():getIntegerForKey("guildGuide", 0) == hideValue -1  then
			cc.UserDefault:getInstance():setIntegerForKey("guildGuide", hideValue)
		end
		self:checkGuide()
		sender:stopAllActions()
	end
	sender:setVisible(isShow)
end

function MatchExtraPro:onRcvMatchExtra(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.set == 0 then
		self.neg = msgTbl.neg
		self.sits = msgTbl.sits
		self.loots = msgTbl.loots
		self.style = msgTbl.style
		self.amount = msgTbl.amount
		self.score = msgTbl.score
		self.winners = msgTbl.winners or 0
		self:refreshView()
	else
		if msgTbl.code == 0 then
			require("app/views/CommonTips"):create("设置成功",2)
		end
		self:close()
	end
end

function MatchExtraPro:openPopPanel(panel)
	panel:setVisible(true)
	self.CurPopPanel = panel
	self.Panel_PopTouch:setVisible(true)
end

function MatchExtraPro:closePopPanel(panel)
	panel:setVisible(false)
	self.CurPopPanel = nil
	self.Panel_PopTouch:setVisible(false)
end

function MatchExtraPro:closeAllPopPanel()
	for i,v in ipairs(self.popPanel) do
		v:setVisible(false)
	end
	self.Panel_PopTouch:setVisible(false)
	self.CurPopPanel = nil
end

function MatchExtraPro:refreshView()
	self.Text_ModSitScore:setString(tostring(self.sits))
	self.chkNeg1:setSelected(self.neg == 0)
	self.chkNeg2:setSelected(self.neg ~= 0)
	self.Btn_ModLootScore:setEnabled(self.neg == 0)
	if self.neg ~= 0 then
		self.Text_ModLootScore:setString("无限制")
	else
		self.Text_ModLootScore:setString(tostring(self.loots))
	end
	--大赢家
	if self.style == 1 then

	else --赢家

	end
	self:setListValue(self.Pop_Winners,self.winners)
	self:setListValue(self.Pop_Amount,self.amount)
	self:setListValue(self.Pop_Score,self.score)
end

function MatchExtraPro:setListValue(list,value)
	local childs
	if list == self.Pop_Winners then
		childs = list:getChildren()
	else
		childs = list:getChildByName("ListView"):getChildren()
	end
	if list == self.Pop_Winners and self.style == 1 then
		value = 99
	end
	for i,v in ipairs(childs) do
		if v:getName()~="delimiter" then
			if v:getTag() == value then
				list:getParent():getChildByName("Text_Desc"):setString(v:getTitleText())
				v:setEnabled(false)
			else
				v:setEnabled(true)
			end
		end
	end
end

function MatchExtraPro:modSitScore(value)
	self.sits = value
	self.Text_ModSitScore:setString(tostring(value))
	self:setGuideVisable(self.ImgGuide2,false,2)
end

function MatchExtraPro:modLootScore(value)
	self.loots = value
	self.Text_ModLootScore:setString(tostring(value))
	self:setGuideVisable(self.ImgGuide3,false,3)
end

function MatchExtraPro:close()
	gt.socketClient:unregisterMsgListener(gt.MATCH_EXTRA)
	if not self.is_union then
		self.matchView:checkGuide()
	end
	self:removeFromParent()
end

return MatchExtraPro