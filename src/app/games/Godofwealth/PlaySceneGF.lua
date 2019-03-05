local gt = cc.exports.gt

require "app/games/Godofwealth/config"

local PlaySceneGF = class("PlaySceneGF", function()
	return cc.Scene:create()
end)

function PlaySceneGF:ctor(msgTbl)
	local csbNode = cc.CSLoader:createNode("games/Godofwealth/csb/Godofwealth.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
    ccui.Helper:doLayout(csbNode)
	self:addChild(csbNode)
	self.csbNode = csbNode

	self:initUI()
	self:initRollUI()
	self:initMammonAni()
	self:playJoinAni()
	
	self.noticeList = {}
	self.scheduleRollNotice = {}
		
	gt.socketClient:registerMsgListener(gt.MINI_ENTER_GAME, self, self.onRcvEnterGame)
	gt.socketClient:registerMsgListener(gt.MINI_EXIT_GAME, self, self.onRcvExitGame)
	gt.socketClient:registerMsgListener(gt.MINI_SPIN, self, self.onRcvSpinResult)
	gt.socketClient:registerMsgListener(gt.EXCHANGE_COIN, self, self.onRcvExchangeCoin)
	gt.socketClient:registerMsgListener(gt.EXCHANGE_RECORD, self, self.onRcvExchangeRecord)
	gt.socketClient:registerMsgListener(gt.MINI_GAME_RECORD, self, self.onRcvGameRecord)
	gt.socketClient:registerMsgListener(gt.MINI_GAME_NOTICE, self, self.onRcvGameNotice)
	
	local msgToSend = {}
	msgToSend.cmd = gt.MINI_ENTER_GAME
	msgToSend.user_id = gt.playerData.uid
	msgToSend.open_id = gt.playerData.openid
	msgToSend.game_id = gt.GameID.GF
	gt.socketClient:sendMessage(msgToSend)

	gt.showLoadingTips("")
	
	gt.soundEngine:playMusic("Godofwealth/csd-bgm-1", true)
end

function PlaySceneGF:onRcvEnterGame(msgTbl)
	gt.removeLoadingTips()
	
	if -1 == msgTbl.code then
		require("app/views/CommonTips"):create("进入游戏失败，请稍后重试")
		self:onRcvExitGame()
		return
	end
	
	self.ownCoin = msgTbl.coin
	self.BFL_OwnCoin:setString(self.ownCoin)
	self.winCoin = 0
	self.BFL_WinCoin:setString(self.winCoin)
	
	self.betCoin = cc.UserDefault:getInstance():getIntegerForKey("betCoin")
	self.betMulList = msgTbl.bet_mul
	self.betMulIndex = 0
	for i, mul in ipairs(msgTbl.bet_mul) do
		if mul == self.betCoin then
			self.betMulIndex = i
			break
		end
	end
	if 0 == self.betMulIndex then
		self.betMulIndex = 1
		self.betCoin = msgTbl.bet_mul[self.betMulIndex]
	end
	self.BFL_BetCoin:setString(self.betCoin)

	if 0 < msgTbl.free_cnt then
		self.lastFreeCnt = msgTbl.free_cnt
		self:setFreeUI(true)
		self.BFL_FreeCount:setString(msgTbl.free_cnt)
		self:gameStart()
	else
		self.lastFreeCnt = 0
	end
end

function PlaySceneGF:onRcvExitGame()
	gt.socketClient:unregisterMsgListener(gt.MINI_ENTER_GAME)
	gt.socketClient:unregisterMsgListener(gt.MINI_EXIT_GAME)
	gt.socketClient:unregisterMsgListener(gt.MINI_SPIN)
	gt.socketClient:unregisterMsgListener(gt.EXCHANGE_COIN)
	gt.socketClient:unregisterMsgListener(gt.EXCHANGE_RECORD)
	gt.socketClient:unregisterMsgListener(gt.MINI_GAME_RECORD)
	gt.socketClient:unregisterMsgListener(gt.MINI_GAME_NOTICE)
	
	if self.scheduleUpdateGetCoin then
		gt.scheduler:unscheduleScriptEntry(self.scheduleUpdateGetCoin)
	end
	if self.scheduleUpdateFreeCoin then
		gt.scheduler:unscheduleScriptEntry(self.scheduleUpdateFreeCoin)
	end
	if self.scheduleShowGameBtn then
		gt.scheduler:unscheduleScriptEntry(self.scheduleShowGameBtn)
	end
	for i = 1, 2 do
		if self.scheduleRollNotice[i] then
			gt.scheduler:unscheduleScriptEntry(self.scheduleRollNotice[i])
		end
	end
	
	self:removeFromParent()
	gt.soundEngine:playMusic("bg",true)
end

function PlaySceneGF:onRcvExchangeCoin(msgTbl)
	self.Panel_Mask:setVisible(false)
	self.Image_Exchange:setVisible(false)
	if 0 == msgTbl.code then
		require("app/views/CommonTips"):create("兑换成功！")
		
		self.ownCoin = msgTbl.coin
		self.BFL_OwnCoin:setString(self.ownCoin)
		
		gt.playerData.roomCardsCount[1] = msgTbl.card
		gt.dispatchEvent(gt.EventType.UPDATE_ROOMCARD)
	else
		require("app/views/CommonTips"):create("兑换失败！")
	end
end

function PlaySceneGF:onRcvExchangeRecord(msgTbl)	--EXCHANGE_RECORD
	self.recordList:removeAllChildren()	
	if 0 < #msgTbl.logs then
		self.Node_Record:getChildByName("Text_NoRecordTips"):setVisible(false)
		for i, v in ipairs(msgTbl.logs) do
			local pItem = self.recordItemTemp:clone()
			local str = nil
			if 1 == v.tp then	--选择兑换 房卡 1 
				str = "使用"..math.abs(v.coin).."个元宝兑换"..v.card.."张房卡"
			elseif 0 == v.tp then
				str = "使用"..math.abs(v.card).."张房卡兑换"..v.coin.."个元宝"
			end
			pItem:getChildByName("Text_Info"):setString(str)
			pItem:getChildByName("Text_Time"):setString(v.t)
			self.recordList:pushBackCustomItem(pItem)
		end
	end
end

function PlaySceneGF:onRcvGameRecord(msgTbl)	--MINI_GAME_RECORD
	if 0 == msgTbl.code then
	
	end
end

function PlaySceneGF:onRcvGameNotice(msgTbl)	--MINI_GAME_NOTICE
	if 0 >= #msgTbl.msgs then
		return
	end
	local noticeCount = #self.noticeList
	if 0 == noticeCount or 1 < #msgTbl.msgs then
		for i, msg in ipairs(msgTbl.msgs) do
			self.noticeList[i] = msg
			self.noticeList[i].nick = gt.checkName(self.noticeList[i].nick, 6)
			self.noticeList[i].bIsShow = true	--是否显示过
		end
		-- 显示第一条（最左边）公告节点对应的消息队列位置
		self.firstShowIndex = 1
		-- 当前最左边的公告节点 在UI队列self.Text_NoticeList中的位置
		self.leftNodeIndex = 1
		
		noticeCount = #self.noticeList
		for i = 1, 2 do
			local showIndex = self.firstShowIndex + i - 1
			if showIndex > noticeCount then
				showIndex = showIndex - noticeCount
			end
			self.noticeList[showIndex].bIsShow = true
			self.Text_NoticeList[i].Text_Notice:stopAllActions()	
			self.Text_NoticeList[i].Text_Notice:setPositionX(900)
			self.Text_NoticeList[i].Text_Name:setString(self.noticeList[showIndex].nick)
			self.Text_NoticeList[i].Text_Mul:setString(self.noticeList[showIndex].wincoin/self.noticeList[showIndex].betcoin)
			self.Text_NoticeList[i].Text_WinCoin:setString(self.noticeList[showIndex].wincoin)
			ccui.Helper:doLayout(self.Text_NoticeList[i].Text_Notice)
			local sequence = cc.Sequence:create(cc.DelayTime:create((i-1)*5), cc.MoveTo:create(10, cc.p(-800, 23)))
			self.Text_NoticeList[i].Text_Notice:runAction(sequence)
		end
		self:playNoticeAni()
	else
		msgTbl.msgs[1].nick = gt.checkName(msgTbl.msgs[1].nick, 6)
		msgTbl.msgs[1].bIsShow = false
		--最多同时显示2条大奖公告,先找到最后一条公告节点对应的消息队列位置 lastShowIndex
		local lastShowIndex = self.firstShowIndex + 1
		if lastShowIndex > noticeCount then
			lastShowIndex = lastShowIndex - noticeCount
		end
		
		--从 lastShowIndex+1 位置开始寻找已显示过的消息(不在当前显示的三消息中寻找)，若找到，则在该位置插队
		local bIsFindIndex = false
		local newMsgIndex = 0
		for i = 1, noticeCount - 2 do
			newMsgIndex = lastShowIndex + i
			if newMsgIndex > noticeCount then
				newMsgIndex = newMsgIndex - noticeCount
			end
			if self.noticeList[newMsgIndex].bIsShow then
				table.insert(self.noticeList, newMsgIndex, msgTbl.msgs[1])
				if self.firstShowIndex >= newMsgIndex then
					self.firstShowIndex = self.firstShowIndex + 1
				end
				if 99 < noticeCount then
					table.remove(self.noticeList, newMsgIndex + 1)
				end
				bIsFindIndex = true
				break
			end
		end
		--若没有找到已显示过的消息，则在当前第一条显示消息的位置插队
		if not bIsFindIndex then
			table.insert(self.noticeList, self.firstShowIndex, msgTbl.msgs[1])
			self.firstShowIndex = self.firstShowIndex + 1
		end
	end
end

function PlaySceneGF:playNoticeAni()	
	for i = 1, 2 do
		local startRollNoticeFunc = cc.CallFunc:create(function(sender)
			local function updateRollNotice()
				local showIndex = self.firstShowIndex + 2
				showIndex = math.fmod(showIndex-1, #self.noticeList)+1
				self.noticeList[showIndex].bIsShow = true
				self.Text_NoticeList[self.leftNodeIndex].Text_Notice:stopAllActions()	
				self.Text_NoticeList[self.leftNodeIndex].Text_Notice:setPositionX(900)
				self.Text_NoticeList[self.leftNodeIndex].Text_Name:setString(self.noticeList[showIndex].nick)
				self.Text_NoticeList[self.leftNodeIndex].Text_Mul:setString(self.noticeList[showIndex].wincoin/self.noticeList[showIndex].betcoin)
				self.Text_NoticeList[self.leftNodeIndex].Text_WinCoin:setString(self.noticeList[showIndex].wincoin)
				ccui.Helper:doLayout(self.Text_NoticeList[self.leftNodeIndex].Text_Notice)
				self.Text_NoticeList[self.leftNodeIndex].Text_Notice:runAction(cc.MoveTo:create(10, cc.p(-800, 23)))
				self.leftNodeIndex = self.leftNodeIndex + 1
				if 2 < self.leftNodeIndex then
					self.leftNodeIndex = self.leftNodeIndex  - 2
				end
				if 100 < #self.noticeList then
					table.remove(self.noticeList, self.firstShowIndex)
				else
					self.firstShowIndex = self.firstShowIndex + 1
					if self.firstShowIndex > #self.noticeList then
						self.firstShowIndex = self.firstShowIndex - #self.noticeList
					end
				end					
			end
			if self.scheduleRollNotice[i] then
				gt.scheduler:unscheduleScriptEntry(self.scheduleRollNotice[i])
			end
			self.scheduleRollNotice[i] = gt.scheduler:scheduleScriptFunc(updateRollNotice, 10, false)
		end)
		self:runAction(cc.Sequence:create(cc.DelayTime:create((i-1)*5), startRollNoticeFunc))
	end
end

function PlaySceneGF:onRcvSpinResult(msgTbl)	
	gt.log("--------------------------------------------------test onRcvSpinResult")
	
	if self.scheduleShowGameBtn then
		gt.scheduler:unscheduleScriptEntry(self.scheduleShowGameBtn)
	end
	
	if -2 == msgTbl.code then
		require("app/views/CommonTips"):create("元宝不足，请兑换！")

		self.Panel_Mask:setVisible(true)
		self.Image_Exchange:setVisible(true)
		self:showExchangeType(1)
		
		self.btnSub:setEnabled(true)
		self.btnAdd:setEnabled(true)
		self.btnAllIn:setEnabled(true)
		self.btnStart:setEnabled(true)
		
		self.bIsAuto = false
		self.btnAuto:setVisible(true)
		self.btnStopAuto:setVisible(false)
		return	
	elseif -1 == msgTbl.code then 
		require("app/views/CommonTips"):create("游戏滚动失败，请重试！")
		
		self.btnSub:setEnabled(true)
		self.btnAdd:setEnabled(true)
		self.btnAllIn:setEnabled(true)
		self.btnStart:setEnabled(true)
		
		self.bIsAuto = false
		self.btnAuto:setVisible(true)
		self.btnStopAuto:setVisible(false)
		return	
	end
	
	self.bIsRolling = true
	
	for c = 1, self.col do
		for r = self.row - 2, self.row do
			self.imageItemList[c][r]:setVisible(true)
			self.aniItemList[c][r]:removeAllChildren()
		end
	end
	self.BFL_SpinWinCoin:stopAllActions()
	self.BFL_SpinWinCoin:setVisible(false)
	
	--先扣除下注金额，动画显示结果后，再加上获得奖金
	if 0 == self.lastFreeCnt then
		self.BFL_OwnCoin:setString(self.ownCoin - msgTbl.betcoin)
	end
	self.ownCoin = msgTbl.coin
	self.BFL_WinCoin:setString(0)
	self.winCoin = msgTbl.wincoin
	
	self:refreshRollData(msgTbl.result_cards)
	self:playRollAni(msgTbl)
end

function PlaySceneGF:refreshRollData(result_cards)
	for c = 1, self.col do
		for r = 1, 3 do
			self.itemDataList[c][r] = self.itemDataList[c][self.row - 3 + r]
			self.imageItemList[c][r]:loadTexture("item_nml_"..self.itemDataList[c][r]..".png", ccui.TextureResType.plistType)
		end
	end
	
	for c = 1, self.col do
		for r = self.row - 2, self.row do
			self.itemDataList[c][r] = result_cards[(self.row - r) * self.col + c]
			self.imageItemList[c][r]:loadTexture("item_nml_"..self.itemDataList[c][r]..".png", ccui.TextureResType.plistType)
		end
	end
end

function PlaySceneGF:playRollAni(msgTbl)
	local rollDistance = self.itemHeight * (self.row - 3)
	local timeDelay = 0.4
	local rollTime1 = 0.2
	local rollTime2 = 2
	if self.bIsSpeedUp then
		timeDelay = timeDelay * 0.4
		rollTime1 = rollTime1 * 0.4
		rollTime2 = rollTime2 * 0.4
	end
	gt.soundEngine:playEffect("Godofwealth/roll", false)
	for i = 1, self.col do
		self.imageLineList[i]:setPositionY(self.lineNodePosY)
		local oldPosX = self.imageLineList[i]:getPositionX()
		
		local delayTime = cc.DelayTime:create(timeDelay * (i - 1))
		
		--图片变幻滚动序列内容
		local blurFunc = cc.CallFunc:create(function(sender)
			for j = 1, self.row do
				self.imageItemList[i][j]:loadTexture("item_blur_"..self.itemDataList[i][j]..".png", ccui.TextureResType.plistType)
			end
		end)
		local moveToUp = cc.MoveTo:create(rollTime1, cc.p(oldPosX, self.lineNodePosY + 50))
		local moveToDown = cc.EaseSineInOut:create(cc.MoveTo:create(rollTime2, cc.p(oldPosX, self.lineNodePosY - rollDistance - 50)))
		local nmlFunc = cc.CallFunc:create(function(sender)
			gt.soundEngine:playEffect("Godofwealth/DownEnd", false)
			for j = 1, self.row do
				self.imageItemList[i][j]:loadTexture("item_nml_"..self.itemDataList[i][j]..".png", ccui.TextureResType.plistType)
			end
		end)
		local moveToUp1 = cc.MoveTo:create(rollTime1, cc.p(oldPosX, self.lineNodePosY - rollDistance))
		local sequenceBlurMove = cc.Sequence:create(blurFunc, moveToUp, moveToDown, nmlFunc, moveToUp1)
		
		--动画相关序列内容
		self.aniTime = 1
		local playAniFunc = cc.CallFunc:create(function(sender)
			if i == self.col then
				if msgTbl.all_free_cnt == msgTbl.free_cnt and 0 == self.lastFreeCnt then
					self.Image_FreeTips:runAction(cc.Sequence:create(cc.FadeIn:create(0.2), cc.DelayTime:create(0.3), cc.FadeOut:create(0.1)))
					gt.soundEngine:playMusic("Godofwealth/csd-free-bgm", true)
					self:playStartFreeAni()
					self.BFL_FreeCount:setString(msgTbl.free_cnt)
					self.aniTime = 3
				elseif 0 < msgTbl.free_cnt then
					self.BFL_FreeCount:setString(msgTbl.free_cnt)
				elseif 0 == msgTbl.free_cnt and 1 == self.lastFreeCnt then
					self.BFL_FreeCount:setString(msgTbl.free_cnt)
					self:playFreeEndBgAni(msgTbl.free_win_coin, msgTbl.betcoin)
					self.aniTime = 8.5
				end
				self.lastFreeCnt = msgTbl.free_cnt
				
				--全压结束,改回原压住额
				if 0 == self.betCoin then
					self.betCoin = self.betMulList[self.betMulIndex]
					self.BFL_BetCoin:setString(self.betCoin)
				end
				self.BFL_OwnCoin:setString(self.ownCoin)
				self.BFL_WinCoin:setString(self.winCoin)
				self:playMammonAni(msgTbl.wincoin/msgTbl.betcoin)
				if 0 < msgTbl.wincoin then
					self:playAwardItemAni(msgTbl.zj_luxian[1].indexs)
					self:playGetCoinAni(msgTbl.zj_luxian[1].coin)
				end
			end
		end)
		
		local delayEndFunc = cc.CallFunc:create(function(sender)
			local delayTime = cc.DelayTime:create(self.aniTime)
			local endFunc = cc.CallFunc:create(function(sender)
				if i == self.col then
					self.bIsRolling = false
					if self.bIsAuto or 0 < msgTbl.free_cnt then
						self:gameStart()
					else
						self.btnSub:setEnabled(true)
						self.btnAdd:setEnabled(true)
						self.btnAllIn:setEnabled(true)
						self.btnStart:setEnabled(true)
					end
				end
			end)
			self:runAction(cc.Sequence:create(delayTime, endFunc))
		end)
		local sequenceAni = cc.Sequence:create(playAniFunc, delayEndFunc)
		
		local sequence = cc.Sequence:create(delayTime, sequenceBlurMove, sequenceAni)
		self.imageLineList[i]:runAction(sequence)
	end
end

function PlaySceneGF:playStartFreeAni()
	gt.soundEngine:playEffect("Godofwealth/csd_freetime_2", false)
	local JBP_UpPos = cc.p(self.Node_JuBaoPen_PosX, self.Node_JuBaoPen_PosY + 250)
	
	self.Node_JuBaoPen:setScale(0.3)
	self.Node_JuBaoPen:setPosition(self.Node_JuBaoPen_PosX, self.Node_JuBaoPen_PosY)
	self.FileNode_JuBaoPen_Collect:setVisible(true)
	local spawn = cc.Spawn:create(cc.ScaleTo:create(0.5, 1 ), cc.MoveTo:create(0.5, JBP_UpPos))
	local collectAniFunc = cc.CallFunc:create(function(sender)
		gt.soundEngine:playEffect("Godofwealth/csd_freetime_3", false)
		self.ani_collect:play("animation0", false)
		
		local spawn1 = cc.Spawn:create(cc.ScaleTo:create(1, 0.1), cc.MoveTo:create(1, JBP_UpPos))
		local sequence = cc.Sequence:create(cc.DelayTime:create(0.2), spawn1, cc.Hide:create())
		self.Image_PlayBg:runAction(sequence)
	end)
	local collectAniDelayTime = cc.DelayTime:create(1.5)
	local movetoCenter = cc.MoveTo:create(0.5, cc.p(self.Image_PlayBg_PosX, self.Image_PlayBg_PosY))
	local openAniFunc = cc.CallFunc:create(function(sender)
		gt.soundEngine:playEffect("Godofwealth/csd_freetime_4", false)
		self.FileNode_JuBaoPen_Collect:setVisible(false)
		self.FileNode_JuBaoPen_Open:setVisible(true)
		self.ani_open:play("animation0", false)
		
		local aniEndFunc = cc.CallFunc:create(function(sender)
			gt.soundEngine:playEffect("Godofwealth/csd_freetime_5", false)
			self.FileNode_JuBaoPen_Open:setVisible(false)
			self:setFreeUI(true)
		end)
		self.Image_PlayBg:setPosition(cc.p(self.Image_PlayBg_PosX, self.Image_PlayBg_PosY))
		local sequence = cc.Sequence:create(cc.DelayTime:create(0.4), cc.Show:create(), cc.ScaleTo:create(0.3, 1), aniEndFunc)
		self.Image_PlayBg:runAction(sequence)
	end)
	self.Node_JuBaoPen:runAction(cc.Sequence:create(spawn, collectAniFunc, collectAniDelayTime, movetoCenter, openAniFunc))
end

function PlaySceneGF:playFreeEndBgAni(free_win_coin, betcoin)
	local delayTime = cc.DelayTime:create(1)
	local callFunc = cc.CallFunc:create(function(sender)
		self.Image_FreeEndBg:setVisible(true)
		self.Image_FreeEndBg:getChildByName("BFL_freeTotalWin"):setString(free_win_coin)
		local Sprite_flare = self.Image_FreeEndBg:getChildByName("Sprite_flare")
		Sprite_flare:runAction(cc.RepeatForever:create(cc.RotateBy:create(1.5, 200)))
	end)
	local delayTime1 = cc.DelayTime:create(1.5)
	local playCoinAniFunc = cc.CallFunc:create(function(sender)
		self.Image_FreeEndBg:setVisible(false)
		self:playFreeEndCoinAni(free_win_coin, betcoin)
	end)
	self.Image_FreeEndBg:runAction(cc.Sequence:create(delayTime, callFunc, delayTime1, playCoinAniFunc))	
end

function PlaySceneGF:playFreeEndCoinAni(free_win_coin, betcoin)
	self.Node_FreeEndAni:setVisible(true)
	
	--背景光效
	local Sprite_flare = self.Node_FreeEndAni:getChildByName("Sprite_flare")
	Sprite_flare:runAction(cc.RepeatForever:create(cc.RotateBy:create(1.5, 200)))
	
	--中奖倍率 得分更新
	local Image_WinType = self.Node_FreeEndAni:getChildByName("Image_WinType")
	local BFL_freeTotalWin = self.Node_FreeEndAni:getChildByName("BFL_freeTotalWin")
	local curWinCoin = 0
	local function updateFreeCoin(dt_)
		curWinCoin = curWinCoin + free_win_coin / 50
		if curWinCoin > free_win_coin then
			curWinCoin = free_win_coin
		end
		BFL_freeTotalWin:setString('+'..string.format("%.2f", curWinCoin))
		
		if 40 < curWinCoin / betcoin then
			Image_WinType:loadTexture("invincible_big_reward.png", ccui.TextureResType.plistType)
		elseif 20 < curWinCoin / betcoin then
			Image_WinType:loadTexture("super_big_reward.png", ccui.TextureResType.plistType)
		elseif 10 < curWinCoin / betcoin then
			Image_WinType:loadTexture("super_reward.png", ccui.TextureResType.plistType)
		end
		if curWinCoin >= free_win_coin then
			gt.scheduler:unscheduleScriptEntry(self.scheduleUpdateFreeCoin)
		end
	end
	self.scheduleUpdateFreeCoin = gt.scheduler:scheduleScriptFunc(updateFreeCoin, 0.1, false)
	
	--金币动画
	local spriteFrame = cc.SpriteFrameCache:getInstance( )  
	spriteFrame:addSpriteFrames( "games/Godofwealth/image/lhj_gold_coin_big.plist" )  
	local coinAnimation = cc.Animation:create()  
	for i = 0, 49 do 
		 local blinkFrame = spriteFrame:getSpriteFrame( string.format( "gold_coin_big_000%02d.png", i ) )  
		coinAnimation:addSpriteFrame( blinkFrame )  
	end 
	coinAnimation:setDelayPerUnit(0.016)--设置每帧的播放间隔  
	coinAnimation:setRestoreOriginalFrame( true )--设置播放完成后是否回归最初状态
	local coinAction = cc.Animate:create(coinAnimation)
	
	local Node_Coin = self.Node_FreeEndAni:getChildByName("Node_Coin")
	Node_Coin:removeAllChildren()
	--金币数量
	for i = 1, 100 do
		local spriteCoin = cc.Sprite:createWithSpriteFrameName("gold_coin_big_00000.png")  
		spriteCoin:setPosition(math.random(-100,100), math.random(-100,100))
		spriteCoin:setVisible(false)
		Node_Coin:addChild(spriteCoin)
		spriteCoin:runAction(cc.RepeatForever:create(coinAction:clone()))
		
		local showDelayTime = cc.DelayTime:create(i * 0.05)
		local jumpBy = cc.JumpBy:create(1, cc.p(math.random(-500,500), -600), math.random(400,600), 1)
		local aniSequence = cc.Sequence:create(showDelayTime, cc.Show:create(), jumpBy, cc.RemoveSelf:create())
		spriteCoin:runAction(aniSequence)
	end
	local setFreeUIFunc = cc.CallFunc:create(function(sender)
		self.Node_FreeEndAni:setVisible(false)
		self:setFreeUI(false)
		gt.soundEngine:playMusic("Godofwealth/csd-bgm-1", true)
	end)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(6), setFreeUIFunc))
end

function PlaySceneGF:setFreeUI(bIsShouFree)
	self.Image_FreeBg:setVisible(bIsShouFree)
	
	local Image_Bg = self.csbNode:getChildByName("Image_Bg")
	local Image_ListBg = self.Image_PlayBg:getChildByName("Image_ListBg")
	local Image_OwnBg = gt.seekNodeByName(self.csbNode,"Image_OwnBg")
	local btnExchange = gt.seekNodeByName(self.csbNode,"Button_Exchange")
	local btnHelp = gt.seekNodeByName(self.csbNode,"Button_Help")
	local btnSoundSet = gt.seekNodeByName(self.csbNode,"Button_SoundSet")
	if bIsShouFree then
		Image_Bg:loadTexture("games/Godofwealth/image/gowv2_bg_freetime.jpg")
		self.Image_PlayBg:loadTexture("games/Godofwealth/image/gowv2_box_bg_freetime.png")
		Image_ListBg:loadTexture("games/Godofwealth/image/gowv2_box_list_freetime.png")
		Image_OwnBg:loadTexture("games/Godofwealth/image/ingot/gowv2_own_bg_freetime.png")
		btnExchange:loadTextureNormal("games/Godofwealth/image/ingot/btnExchangeFree.png")
		btnHelp:loadTextureNormal("gowv2_btn_help_freetime.png", ccui.TextureResType.plistType)
		btnSoundSet:loadTextureNormal("gowv2_btn_setting_freetime.png", ccui.TextureResType.plistType)
	else
		Image_Bg:loadTexture("games/Godofwealth/image/gowv2_bg.jpg")
		self.Image_PlayBg:loadTexture("games/Godofwealth/image/gowv2_box_bg.png")
		Image_ListBg:loadTexture("games/Godofwealth/image/gowv2_box_list.png")
		Image_OwnBg:loadTexture("games/Godofwealth/image/ingot/gowv2_own_bg.png")
		btnExchange:loadTextureNormal("games/Godofwealth/image/ingot/btnExchange.png")
		btnHelp:loadTextureNormal("gowv2_btn_help.png", ccui.TextureResType.plistType)
		btnSoundSet:loadTextureNormal("gowv2_btn_setting.png", ccui.TextureResType.plistType)
	end
end

function PlaySceneGF:playMammonAni(winMul)
	self.FileNode_Idle:setVisible(false)
	self.FileNode_NotWinning:setVisible(false)
	self.FileNode_Winning:setVisible(false)
	self.FileNode_BigWinning:setVisible(false)

	local timeDelay = 0
	if 0 == winMul then
		self.FileNode_NotWinning:setVisible(true)
		self.ani_NotWinning:play("animation_NotWinning", false)
		timeDelay = 74/60
	elseif 10 > winMul then
		gt.soundEngine:playEffect("Godofwealth/csd_laughing", false)
		self.FileNode_Winning:setVisible(true)
		self.ani_Winning:play("animation_Winning", false)
		timeDelay = 62/60
	else
		gt.soundEngine:playEffect("Godofwealth/csd_laughing", false)
		self.FileNode_BigWinning:setVisible(true)
		self.ani_BigWinning:play("animation_BigWinning", false)
		timeDelay = 95/60
	end
	
	local playIdleFunc = cc.CallFunc:create(function(sender)		
		self.FileNode_NotWinning:setVisible(false)
		self.FileNode_Winning:setVisible(false)
		self.FileNode_BigWinning:setVisible(false)
		
		self.FileNode_Idle:setVisible(true)
		self.ani_NotWinning:play("animation_Idle", true)
	end)
	
	self:runAction(cc.Sequence:create(cc.DelayTime:create(timeDelay), playIdleFunc))
end

function PlaySceneGF:playAwardItemAni(indexs)
	--显示所有中奖项(显示动画,隐藏图片)
--	for i, line in ipairs(indexs) do
		for j, itemIndex in ipairs(indexs) do
			local row = self.row - math.modf((itemIndex) / self.col)--服务器位置index为0-14，客户端为1-15
			local col = 1 + math.fmod((itemIndex ), self.col)
			
			local frameCsbPath = "games/Godofwealth/csb/texiao/kuang.csb"
			local frameAniNode = cc.CSLoader:createNode(frameCsbPath)
			self.aniItemList[col][row]:addChild(frameAniNode)
			frameAniNode:setPosition(48.5, 49)
			local frameAniTimeline = cc.CSLoader:createTimeline(frameCsbPath)
			frameAniNode:runAction(frameAniTimeline)
			frameAniTimeline:play("animation0", true)
			
			local effectCsbPath = "games/Godofwealth/csb/texiao/texiao"..self.itemDataList[col][row]..".csb"
			local effectAniNode = cc.CSLoader:createNode(effectCsbPath)
			self.aniItemList[col][row]:addChild(effectAniNode)
			effectAniNode:setPosition(48.5, 49)
			local effectAniTimeline = cc.CSLoader:createTimeline(effectCsbPath)
			effectAniNode:runAction(effectAniTimeline)
			effectAniTimeline:play("animation0", true)
			
			self.imageItemList[col][row]:setVisible(false)
		end
--	end
end

function PlaySceneGF:playGetCoinAni(coin)
	self.getCoin = coin
	self.curCoin = 0
	
	self.BFL_SpinWinCoin:setVisible(true)
	self.BFL_SpinWinCoin:setString('+'..self.curCoin)
	self.BFL_SpinWinCoin:setScale(0.5)
	local spawn = cc.Spawn:create(cc.ScaleTo:create(0.5, 1), cc.FadeIn:create(0.5))
	self.BFL_SpinWinCoin:runAction(cc.Sequence:create(spawn, cc.DelayTime:create(2.5), cc.Hide:create()))
	
	local function updateGetCoin(dt_)
		self.curCoin = self.curCoin + self.getCoin / 5
		self.BFL_SpinWinCoin:setString('+'..self.curCoin)
		if self.curCoin == self.getCoin then
			gt.scheduler:unscheduleScriptEntry(self.scheduleUpdateGetCoin)
		end
	end
	self.scheduleUpdateGetCoin = gt.scheduler:scheduleScriptFunc(updateGetCoin, 0.1, false)
end

function PlaySceneGF:gameStart()
	local msgToSend = {}
	msgToSend.cmd = gt.MINI_SPIN
	msgToSend.user_id = gt.playerData.uid
	msgToSend.open_id = gt.playerData.openid
	msgToSend.betcoin = self.betCoin
	gt.socketClient:sendMessage(msgToSend)
	
	self.btnSub:setEnabled(false)
	self.btnAdd:setEnabled(false)
	self.btnAllIn:setEnabled(false)
	self.btnStart:setEnabled(false)
	
	--收不到消息回复时，处理方式
	local function showGameBtn()
		self.btnSub:setEnabled(true)
		self.btnAdd:setEnabled(true)
		self.btnAllIn:setEnabled(true)
		self.btnStart:setEnabled(true)
		
		self.bIsAuto = false
		self.btnAuto:setVisible(true)
		self.btnStopAuto:setVisible(false)
		
		gt.scheduler:unscheduleScriptEntry(self.scheduleShowGameBtn)
	end
	self.scheduleShowGameBtn = gt.scheduler:scheduleScriptFunc(showGameBtn, 10, false)
	
	gt.log("--------------------------------------------------test gameStart")
end

function PlaySceneGF:initUI()
	self.BFL_OwnCoin = gt.seekNodeByName(self.csbNode,"BFL_Own")
	self.BFL_OwnCoin:setString("")
	self.BFL_WinCoin = gt.seekNodeByName(self.csbNode,"BFL_Win")
	self.BFL_WinCoin:setString("")
	self.BFL_BetCoin = gt.seekNodeByName(self.csbNode,"BFL_Bet")
	self.BFL_BetCoin:setString("")
	
	local Button_AddCoin = gt.seekNodeByName(self.csbNode,"Button_AddCoin")
	gt.addBtnPressedListener(Button_AddCoin,function()
		self.Panel_Mask:setVisible(true)
		self.Image_Exchange:setVisible(true)
		self:showExchangeType(1)
	end)
	
	local Panel__NoticeBg = self.csbNode:getChildByName("Panel__NoticeBg")
	self.Text_NoticeList = {}
	for i = 1, 2 do
		self.Text_NoticeList[i] = {}
		self.Text_NoticeList[i].Text_Notice = Panel__NoticeBg:getChildByName("Text_Notice"..i)
		self.Text_NoticeList[i].Text_Notice:setPositionX(900)
		self.Text_NoticeList[i].Text_Name = gt.seekNodeByName(self.Text_NoticeList[i].Text_Notice, "Text_Name")
		self.Text_NoticeList[i].Text_Mul = gt.seekNodeByName(self.Text_NoticeList[i].Text_Notice, "Text_Mul")
		self.Text_NoticeList[i].Text_WinCoin = gt.seekNodeByName(self.Text_NoticeList[i].Text_Notice, "Text_WinCoin")
	end
	
	self.Panel_Mask = self.csbNode:getChildByName("Panel_Mask")
	self.Panel_Mask:setVisible(false)
	self.Panel_Mask:addClickEventListener(function(sender)
		self.Panel_Mask:setVisible(false)
		self.Image_Exchange:setVisible(false)
		self.Image_Help:setVisible(false)
	end)
	
	--兑换
	self:initExchangeUI()
	
	--帮助
	self:initHelpUI()
	
	--免费总得分背景
	self.Image_FreeEndBg = self.csbNode:getChildByName("Image_FreeEndBg")
	self.Image_FreeEndBg:setVisible(false)
	--免费总得分金币动画
	self.Node_FreeEndAni = self.csbNode:getChildByName("Node_FreeEndAni")
	self.Node_FreeEndAni:setVisible(false)
	
	local btnBack = gt.seekNodeByName(self.csbNode,"Button_Back")
	gt.addBtnPressedListener(btnBack,function()
		local msgToSend = {}
		msgToSend.cmd = gt.MINI_EXIT_GAME
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		msgToSend.game_id = gt.GameID.GF
		gt.socketClient:sendMessage(msgToSend)
	end)
	
	self.btnSub = gt.seekNodeByName(self.csbNode,"Button_Sub")
	gt.addBtnPressedListener(self.btnSub,function()
		self.betMulIndex = self.betMulIndex - 1
		if 1 > self.betMulIndex then
			self.betMulIndex = #self.betMulList
		end
		self.betCoin = self.betMulList[self.betMulIndex]
		self.BFL_BetCoin:setString(self.betCoin)
		cc.UserDefault:getInstance():setIntegerForKey("betCoin", self.betCoin)
		self.BFL_WinCoin:setString("")
		self.BFL_SpinWinCoin:setVisible(false)
	end)
	
	self.btnAdd = gt.seekNodeByName(self.csbNode,"Button_Add")
	gt.addBtnPressedListener(self.btnAdd,function()
		self.betMulIndex = self.betMulIndex + 1
		if #self.betMulList < self.betMulIndex then
			self.betMulIndex = 1
		end
		self.betCoin = self.betMulList[self.betMulIndex]
		self.BFL_BetCoin:setString(self.betCoin)
		cc.UserDefault:getInstance():setIntegerForKey("betCoin", self.betCoin)
		self.BFL_WinCoin:setString("")
		self.BFL_SpinWinCoin:setVisible(false)
	end)
	
	self.btnAllIn = gt.seekNodeByName(self.csbNode,"Button_AllIn")
	gt.addBtnPressedListener(self.btnAllIn,function()
		self.betCoin = 0
		local allInBetCoin = self.ownCoin - math.fmod(self.ownCoin, 10)
		self.BFL_BetCoin:setString(allInBetCoin)
		self.BFL_WinCoin:setString("")
		self.BFL_SpinWinCoin:setVisible(false)
	end)
	
	--默认不加速
	local btnSpeedUp = gt.seekNodeByName(self.csbNode,"Button_SpeedUp")
	local btnStopSpeedUp = gt.seekNodeByName(self.csbNode,"Button_StopSpeedUp")
	
	self.bIsSpeedUp = false
	btnSpeedUp:setVisible(true)
	btnStopSpeedUp:setVisible(false)
	
	gt.addBtnPressedListener(btnSpeedUp,function()
		self.bIsSpeedUp = true
		btnSpeedUp:setVisible(false)
		btnStopSpeedUp:setVisible(true)
	end)
	gt.addBtnPressedListener(btnStopSpeedUp,function()
		self.bIsSpeedUp = false
		btnSpeedUp:setVisible(true)
		btnStopSpeedUp:setVisible(false)
	end)
	
	
	--默认不自动
	self.btnAuto = gt.seekNodeByName(self.csbNode,"Button_Auto")
	self.btnStopAuto = gt.seekNodeByName(self.csbNode,"Button_StopAuto")
	
	self.bIsAuto = false
	self.btnAuto:setVisible(true)
	self.btnStopAuto:setVisible(false)
	
	gt.addBtnPressedListener(self.btnAuto,function()
		self.bIsAuto = true
		self.btnAuto:setVisible(false)
		self.btnStopAuto:setVisible(true)
		if not self.bIsRolling then
			self:gameStart()
		end
	end)
	gt.addBtnPressedListener(self.btnStopAuto,function()
		self.bIsAuto = false
		self.btnAuto:setVisible(true)
		self.btnStopAuto:setVisible(false)
	end)
	
	--默认不滚动
	self.bIsRolling = false
	
	--开始滚动
	self.btnStart = gt.seekNodeByName(self.csbNode,"Button_Start")
	gt.addBtnPressedListener(self.btnStart,function()
		if not self.bIsRolling then
			self:gameStart()
		end
	end)
end

function PlaySceneGF:initExchangeUI()
	self.Image_Exchange = self.csbNode:getChildByName("Image_Exchange")
	self.Image_Exchange:setVisible(false)
	local btnExchange = gt.seekNodeByName(self.csbNode,"Button_Exchange")
	gt.addBtnPressedListener(btnExchange,function()
		self.Panel_Mask:setVisible(true)
		self.Image_Exchange:setVisible(true)
		self:showExchangeType(1)
	end)
	local btnCloseExchange = self.Image_Exchange:getChildByName("Button_CloseExchange")
	gt.addBtnPressedListener(btnCloseExchange,function()
		self.Panel_Mask:setVisible(false)
		self.Image_Exchange:setVisible(false)
	end)
	
	self.Node_Exchange = self.Image_Exchange:getChildByName("Node_Exchange")
	--输入框
	self.Text_Input = gt.seekNodeByName(self.Node_Exchange, "Text_Input")
	self.Text_Input:setString("")
	local Image_InputBg = gt.seekNodeByName(self.Node_Exchange, "Image_InputBg")
	Image_InputBg:addClickEventListener(function(sender)
		local maxInputNum = self.ownCoin - math.fmod(self.ownCoin, 100)
		if not self.btnExchangeIngot:isEnabled() then
			maxInputNum = gt.playerData.roomCardsCount[1]
		end
		local view = require("app/views/Guild/GuildNumberPad"):create("mammon_inputNum", 0, 0, function(inputNum)
			if not self.btnExchangeIngot:isEnabled() then
				--兑换元宝按钮未授权,说明被点选,输入房卡数,
				if gt.playerData.roomCardsCount[1] < inputNum then
					inputNum = gt.playerData.roomCardsCount[1]
				end
			else
				--输入元宝数,
				if self.ownCoin < inputNum then
					inputNum = self.ownCoin
				end
				inputNum = inputNum - math.fmod(inputNum, 100)
			end
			self.Text_Input:setString(tostring(inputNum))
		end, maxInputNum)
		self:addChild(view)
	end)
	
	self.Node_Record = self.Image_Exchange:getChildByName("Node_Record")
	self.recordList = self.Node_Record:getChildByName("ListView_Record")
	self.recordItemTemp = self.recordList:getChildByName("Panel_Template")
	self.recordItemTemp:retain()
	self.recordList:removeAllChildren()
	
	self.btnExchangeIngot = self.Image_Exchange:getChildByName("Button_ExchangeIngot")
	gt.addBtnPressedListener(self.btnExchangeIngot,function()
		self:showExchangeType(1)
	end)
	self.btnExchangeCard = self.Image_Exchange:getChildByName("Button_ExchangeCard")
	gt.addBtnPressedListener(self.btnExchangeCard,function()
		self:showExchangeType(2)
	end)
	self.btnExchangeRecord = self.Image_Exchange:getChildByName("Button_ExchangeRecord")
	gt.addBtnPressedListener(self.btnExchangeRecord,function()
		self:showExchangeType(3)
		
		local msgToSend = {}
		msgToSend.cmd = gt.EXCHANGE_RECORD
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		gt.socketClient:sendMessage(msgToSend)
	end)
	
	self.btnConfire= gt.seekNodeByName(self.Image_Exchange,"Button_Confire")
	gt.addBtnPressedListener(self.btnConfire,function()
		local inputNum = tonumber(self.Text_Input:getString())
		if nil == inputNum or 0 >= inputNum then
			require("app/views/CommonTips"):create("请输入有效数字")
		else
			local msgToSend = {}
			if not self.btnExchangeIngot:isEnabled() then
				msgToSend.tp = 0	--选择兑换元宝		
			else
				msgToSend.tp = 1	--选择兑换房卡
			end
			msgToSend.cmd = gt.EXCHANGE_COIN
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.count = inputNum
			gt.socketClient:sendMessage(msgToSend)
		end
	end)
end

function PlaySceneGF:initHelpUI()
	self.Image_Help = self.csbNode:getChildByName("Image_Help")
	self.Image_Help:setVisible(false)
	local btnHelp = gt.seekNodeByName(self.csbNode,"Button_Help")
	gt.addBtnPressedListener(btnHelp,function()
		self.Panel_Mask:setVisible(true)
		self.Image_Help:setVisible(true)
	end)
	local btnCloseHelp = gt.seekNodeByName(self.Image_Help,"Button_CloseHelp")
	gt.addBtnPressedListener(btnCloseHelp,function()
		self.Panel_Mask:setVisible(false)
		self.Image_Help:setVisible(false)
	end)
	
	local btnRule = gt.seekNodeByName(self.Image_Help,"Button_Rule")
	local btnMul = gt.seekNodeByName(self.Image_Help,"Button_Mul")
	local Image_Rule = gt.seekNodeByName(self.Image_Help,"Image_Rule")
	local Image_Mul = gt.seekNodeByName(self.Image_Help,"Image_Mul")
	local function onBtnRule()
		btnRule:setEnabled(false)
		btnMul:setEnabled(true)
		Image_Rule:setVisible(true)
		Image_Mul:setVisible(false)
	end
	local function onBtnMul()
		btnRule:setEnabled(true)
		btnMul:setEnabled(false)
		Image_Rule:setVisible(false)
		Image_Mul:setVisible(true)
	end
	gt.addBtnPressedListener(btnRule,onBtnRule)
	gt.addBtnPressedListener(btnMul,onBtnMul)
	onBtnRule()
end

function PlaySceneGF:showExchangeType(type)
	self.btnExchangeIngot:setEnabled(1 ~= type)
	self.btnExchangeCard:setEnabled(2 ~= type)
	self.btnExchangeRecord:setEnabled(3 ~= type)
	
	self.Node_Exchange:setVisible(3 ~= type)
	self.Node_Record:setVisible(3 == type)

	self.Text_Input:setString("")
		
	if 1 == type then	--兑换元宝 显示房卡
		gt.seekNodeByName(self.Node_Exchange,"Image_typeText"):loadTexture("games/Godofwealth/image/exchange/curCardText.png")
		gt.seekNodeByName(self.Node_Exchange,"Image_typeFlag"):loadTexture("games/Godofwealth/image/exchange/card.png")
		gt.seekNodeByName(self.Node_Exchange,"Text_typeNum"):setString(gt.playerData.roomCardsCount[1])
		self.Text_Input:setString("请输入房卡数量")
	elseif 2 == type then	--兑换房卡 显示元宝
		gt.seekNodeByName(self.Node_Exchange,"Image_typeText"):loadTexture("games/Godofwealth/image/exchange/curIngotText.png")
		gt.seekNodeByName(self.Node_Exchange,"Image_typeFlag"):loadTexture("games/Godofwealth/image/exchange/ingot.png")
		gt.seekNodeByName(self.Node_Exchange,"Text_typeNum"):setString(self.ownCoin)
		self.Text_Input:setString("请输入元宝数量")
	end
end

function PlaySceneGF:initRollUI()
	--滚动获得金币显示
	self.BFL_SpinWinCoin = gt.seekNodeByName(self.csbNode, "BFL_SpinWinCoin")
	self.BFL_SpinWinCoin:setVisible(false)
	
	--免费奖励提示
	self.Image_FreeTips = gt.seekNodeByName(self.csbNode, "Image_FreeTips")
	self.Image_FreeTips:runAction(cc.FadeOut:create(0.01))
	
	--免费奖励次数
	self.Image_FreeBg = gt.seekNodeByName(self.csbNode, "Image_FreeBg")
	self.Image_FreeBg:setVisible(false)
	self.BFL_FreeCount = self.Image_FreeBg:getChildByName("BFL_FreeCount")
	
	--滚动框
	self.Image_PlayBg = gt.seekNodeByName(self.csbNode, "Image_PlayBg")
	self.Image_PlayBg_PosX = self.Image_PlayBg:getPositionX()
	self.Image_PlayBg_PosY = self.Image_PlayBg:getPositionY()
	
	--初始化 滚动UI Data
	self.Panel_Image = gt.seekNodeByName(self.csbNode, "Panel_Image")
	self.imageTemp = self.Panel_Image:getChildByName("Image_Temp")
	
	self.Ani_Root = gt.seekNodeByName(self.csbNode, "Ani_Root")
	self.aniTemp = self.Ani_Root:getChildByName("Ani_Temp")
	
	--按列分组  图片动画 分开处理
	self.imageLineList = {}
	self.imageItemList = {}
	
	self.aniLineList = {}
	self.aniItemList = {}
	
	self.itemDataList = {}
	self.row = 20
	self.col = 5
	self.itemHeight = 125.6
	
	for c = 1, self.col do
		self.itemDataList[c] = {}
		
		self.imageLineList[c] = self.Panel_Image:getChildByName("Image_Line"..c)
		self.imageLineList[c]:removeAllChildren()
		self.imageItemList[c] = {}
		for r = 1, self.row do
			self.imageItemList[c][r] = self.imageTemp:clone()
			self.imageItemList[c][r]:setPosition(0, self.itemHeight * (r - 1))
			self.imageLineList[c]:addChild(self.imageItemList[c][r])
		end
		
		self.aniLineList[c] = self.Ani_Root:getChildByName("Ani_Line"..c)
		self.aniLineList[c]:removeAllChildren()
		self.aniItemList[c] = {}
		--动画只需要设置最后三行
		for r = self.row - 2, self.row  do
			self.aniItemList[c][r] = self.aniTemp:clone()
			self.aniItemList[c][r]:setPosition(0, self.itemHeight * (r - self.row + 2))
			self.aniLineList[c]:addChild(self.aniItemList[c][r])
		end
	end
	self.lineNodePosY = self.imageLineList[1]:getPositionY()
	
	math.randomseed(os.time())
	
	for c = 1, self.col do
		for r = 1, self.row - 3 do
			self.itemDataList[c][r] = math.random(1, 11)
			self.imageItemList[c][r]:loadTexture("item_nml_"..self.itemDataList[c][r]..".png", ccui.TextureResType.plistType)
		end
		for r = self.row - 2, self.row do
			self.itemDataList[c][r] = self.itemDataList[c][r - self.row + 3]
		end
		
		for r = self.row - 2, self.row do
			local frameCsbPath = "games/Godofwealth/csb/texiao/kuang.csb"
			local frameAniNode = cc.CSLoader:createNode(frameCsbPath)
			self.aniItemList[c][r]:addChild(frameAniNode)
			frameAniNode:setPosition(48.5, 49)
			local frameAniTimeline = cc.CSLoader:createTimeline(frameCsbPath)
			frameAniNode:runAction(frameAniTimeline)
			frameAniTimeline:play("animation0", true)			
		end
	end
end

function PlaySceneGF:initMammonAni()
	--财神动画
	self.FileNode_Idle = gt.seekNodeByName(self.csbNode, "FileNode_Idle")
	self.ani_Idle = cc.CSLoader:createTimeline("games/Godofwealth/csb/texiao/MammonIdle.csb")
    self.FileNode_Idle:runAction(self.ani_Idle)
    self.ani_Idle:play("animation_Idle", true)

	self.FileNode_NotWinning = gt.seekNodeByName(self.csbNode, "FileNode_NotWinning")
	self.ani_NotWinning = cc.CSLoader:createTimeline("games/Godofwealth/csb/texiao/MammonNotWinning.csb")
    self.FileNode_NotWinning:runAction(self.ani_NotWinning)
--    self.ani_NotWinning:play("animation_NotWinning", false)
	self.FileNode_NotWinning:setVisible(false)

	self.FileNode_Winning = gt.seekNodeByName(self.csbNode, "FileNode_Winning")
	self.ani_Winning= cc.CSLoader:createTimeline("games/Godofwealth/csb/texiao/MammonWinning.csb")
    self.FileNode_Winning:runAction(self.ani_Winning)
--    self.ani_Winning:play("animation_Winning", false)
	self.FileNode_Winning:setVisible(false)

	self.FileNode_BigWinning = gt.seekNodeByName(self.csbNode, "FileNode_BigWinning")
	self.ani_BigWinning  = cc.CSLoader:createTimeline("games/Godofwealth/csb/texiao/MammonBigWinning.csb")
    self.FileNode_BigWinning:runAction(self.ani_BigWinning)
--    self.ani_BigWinning:play("animation_BigWinning", false)
	self.FileNode_BigWinning:setVisible(false)
	
	--聚宝盆
	self.Node_JuBaoPen = gt.seekNodeByName(self.csbNode, "Node_JuBaoPen")
	self.Node_JuBaoPen_PosX =  self.Node_JuBaoPen:getPositionX()
	self.Node_JuBaoPen_PosY =  self.Node_JuBaoPen:getPositionY()
	
	self.FileNode_JuBaoPen_Collect = self.Node_JuBaoPen:getChildByName("FileNode_JuBaoPen_Collect")
	self.ani_collect = cc.CSLoader:createTimeline("games/Godofwealth/csb/texiao/juBaoPen_collect.csb")
	self.FileNode_JuBaoPen_Collect:runAction(self.ani_collect)
--    self.ani_collect:play("animation0", false)
	self.FileNode_JuBaoPen_Collect:setVisible(false)
	
	self.FileNode_JuBaoPen_Open = self.Node_JuBaoPen:getChildByName("FileNode_JuBaoPen_Open")
	self.ani_open = cc.CSLoader:createTimeline("games/Godofwealth/csb/texiao/juBaoPen_open.csb")
	self.FileNode_JuBaoPen_Open:runAction(self.ani_open)
--    self.ani_open:play("animation0", false)
	self.FileNode_JuBaoPen_Open:setVisible(false)
end

function PlaySceneGF:playJoinAni()	
	gt.soundEngine:playEffect("Godofwealth/csd_clouds", false)
		
	--入场云动画
	self.FileNode_Cloud = gt.seekNodeByName(self.csbNode, "FileNode_Cloud")
	self.ani_Cloud = cc.CSLoader:createTimeline("games/Godofwealth/csb/texiao/cloud.csb")
    self.FileNode_Cloud:runAction(self.ani_Cloud)
    self.ani_Cloud:play("animation0", false)
	self.FileNode_Cloud:runAction(cc.Sequence:create(cc.DelayTime:create(1.2), cc.RemoveSelf:create()))
	-- up
	local Node_Top_Left = gt.seekNodeByName(self.csbNode,"Node_Top_Left")
	local oldPosX, oldPosY = Node_Top_Left:getPosition()
	Node_Top_Left:setPositionY(oldPosY + 100)
	local moveTo = cc.MoveTo:create(0.5, cc.p(oldPosX, oldPosY))
	Node_Top_Left:runAction(moveTo)
	
	local Node_Top_Right = gt.seekNodeByName(self.csbNode,"Node_Top_Right")
	Node_Top_Right:setScale(0)
	local scaleTo = cc.ScaleTo:create(0.5, 1)
	Node_Top_Right:runAction(scaleTo)
	
	-- down
	local intervalTime = 0.1
	local offsetDown = -105
	local offsetUp = 10
	local delayTime = nil
	local moveTo1 = nil
	local moveTo2 = nil
	local sequence = nil
	
	local Image_BetBg = gt.seekNodeByName(self.csbNode,"Image_BetBg")
	oldPosX, oldPosY = Image_BetBg:getPosition()
	Image_BetBg:setPositionY(offsetDown)
	delayTime = cc.DelayTime:create(intervalTime * 1)
	moveTo1 = cc.MoveTo:create(0.5, cc.p(oldPosX, oldPosY + offsetUp))
	moveTo2 = cc.MoveTo:create(0.1, cc.p(oldPosX, oldPosY))
	Image_BetBg:runAction(cc.Sequence:create(delayTime, moveTo1, moveTo2))
	
	local Image_RewardBg = gt.seekNodeByName(self.csbNode,"Image_RewardBg")
	oldPosX, oldPosY = Image_RewardBg:getPosition()
	Image_RewardBg:setPositionY(offsetDown)
	delayTime = cc.DelayTime:create(intervalTime * 2)
	moveTo1 = cc.MoveTo:create(0.5, cc.p(oldPosX, oldPosY + offsetUp))
	moveTo2 = cc.MoveTo:create(0.1, cc.p(oldPosX, oldPosY))
	Image_RewardBg:runAction(cc.Sequence:create(delayTime, moveTo1, moveTo2))
	
	local Button_SpeedUp = gt.seekNodeByName(self.csbNode,"Button_SpeedUp")
	oldPosX, oldPosY = Button_SpeedUp:getPosition()
	Button_SpeedUp:setPositionY(offsetDown)
	delayTime = cc.DelayTime:create(intervalTime * 3)
	moveTo1 = cc.MoveTo:create(0.5, cc.p(oldPosX, oldPosY + offsetUp))
	moveTo2 = cc.MoveTo:create(0.1, cc.p(oldPosX, oldPosY))
	Button_SpeedUp:runAction(cc.Sequence:create(delayTime, moveTo1, moveTo2))
	
	local Button_Auto = gt.seekNodeByName(self.csbNode,"Button_Auto")
	oldPosX, oldPosY = Button_Auto:getPosition()
	Button_Auto:setPositionY(offsetDown)
	delayTime = cc.DelayTime:create(intervalTime * 4)
	moveTo1 = cc.MoveTo:create(0.5, cc.p(oldPosX, oldPosY + offsetUp))
	moveTo2 = cc.MoveTo:create(0.1, cc.p(oldPosX, oldPosY))
	Button_Auto:runAction(cc.Sequence:create(delayTime, moveTo1, moveTo2))
	
	local Button_Start = gt.seekNodeByName(self.csbNode,"Button_Start")
	oldPosX, oldPosY = Button_Start:getPosition()
	Button_Start:setPositionY(-150)
	delayTime = cc.DelayTime:create(intervalTime * 5)
	moveTo1 = cc.MoveTo:create(0.5, cc.p(oldPosX, oldPosY + offsetUp))
	moveTo2 = cc.MoveTo:create(0.1, cc.p(oldPosX, oldPosY))
	Button_Start:runAction(cc.Sequence:create(delayTime, moveTo1, moveTo2))
end

return PlaySceneGF

