local gt = cc.exports.gt

local RecordManager = class("RecordManager",function()
	return cc.Node:create()
end)

function RecordManager:ctor()
	-- 注册节点事件
	self:registerScriptHandler(handler(self,self.onNodeEvent))
end

local PlayScene

function RecordManager:InitScene( mainScene,enterRoomMsgTbl )
	PlayScene = mainScene
	self.game_id = enterRoomMsgTbl.game_id
	PlayScene.seatOffset = 0
	self:Init(enterRoomMsgTbl)
	-- 保存原始消息
	self.RawMsg = enterRoomMsgTbl
	--处理玩家信息
	self:ProcessPlayers(enterRoomMsgTbl.player_data)
	--处理录像回放
	self:ProcessStep(enterRoomMsgTbl.replay)
	--开启计时器
	self.scheduleRecord = gt.scheduler:scheduleScriptFunc(handler(self,self.UpdatePlayRecord),0.1,false)
end

-- 初始化录像管理器
function RecordManager:Init(enterRoomMsgTbl)
	--self:registerScriptHandler(handler(self, self.onNodeEvent))
	local csbNode = cc.CSLoader:createNode("csd/RecordManager.csb")
	csbNode:setAnchorPoint(0.5,0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)

	--录像不显示的UI
	--为了不动游戏里面的逻辑 这里直接移到十万八千里外面去
	local function hideSceneNode(nodeName)
		if not nodeName then
			return
		end
		local node = gt.seekNodeByName(PlayScene,nodeName)
		if node then
			node:setPosition(9999,9999)
		end
	end

	hideSceneNode("Node_decisionBtn")
	hideSceneNode("Node_RateBtn")
	hideSceneNode("Btn_ready")
	hideSceneNode("Btn_Start")
	hideSceneNode("Btn_setting")
	hideSceneNode("Btn_OpenCard")
	hideSceneNode("Btn_RubCard")
	hideSceneNode("Btn_Trusteeship")

	--三公
	hideSceneNode("Btn_RollDice")
	hideSceneNode("Node_BtnCutCard")

	--扎金花
	hideSceneNode("Node_Operates")
	hideSceneNode("Btn_Show_Card")
	hideSceneNode("Btn_View_Card")

	--返回大厅按钮
	PlayScene.Btn_BackLobby = gt.seekNodeByName(csbNode,"Btn_BackLobby")
	gt.addBtnPressedListener(PlayScene.Btn_BackLobby,function()
		extension.callBackHandler = {}
		-- 事件回调
		gt.removeTargetAllEventListener(PlayScene)
		-- 消息回调
		PlayScene:unregisterAllMsgListener()
		PlayScene:removeFromParent()
	end)
	--快进按钮
	PlayScene.Btn_Speed = gt.seekNodeByName(csbNode,"Btn_Speed")
	gt.addBtnPressedListener(PlayScene.Btn_Speed,function()
		PlayScene.PlaySpeed = PlayScene.PlaySpeed == 1 and 2 or 1
		PlayScene.Btn_Speed:loadTextureNormal("image/replay/speed" .. PlayScene.PlaySpeed .. ".png")
	end)
	--播放暂停按钮
	PlayScene.Btn_Play = gt.seekNodeByName(csbNode,"Btn_Play")
	gt.addBtnPressedListener(PlayScene.Btn_Play,function()
		PlayScene.IsPlay = PlayScene.IsPlay == 1 and 0 or 1
		if PlayScene.IsPlay == 1 then
			PlayScene.Btn_Play:loadTextureNormal("image/replay/pause2.png")
		else
			PlayScene.Btn_Play:loadTextureNormal("image/replay/play2.png")
		end
	end)
	--重播按钮
	PlayScene.Btn_Replay = gt.seekNodeByName(csbNode,"Btn_Replay")
	gt.addBtnPressedListener(PlayScene.Btn_Replay,function()
		if PlayScene.reInitScene then
			PlayScene:reInitScene(true)
		else
			--清掉各种乱七八糟的东西
			PlayScene:stopAllActions()
			PlayScene:hidePlayersReadySign()
			PlayScene:resetCardsPos()
			PlayScene:hideCardViews()
			PlayScene.readyBtn:setVisible(false)
			PlayScene.startBtn:setVisible(false)
			PlayScene.inviteFriendBtn:setVisible(false)
			PlayScene.imgGuanZhan:setVisible(false)
			PlayScene.decisionBtnNode:setVisible(false)
			PlayScene.rateBtnNode:setVisible(false)
			PlayScene.rateBtnNode:stopAllActions()
			PlayScene.showCardBtn:setVisible(false)
			PlayScene.rubCardBtn:setVisible(false)
			PlayScene.openCardBtn:setVisible(false)
			PlayScene.openCardBtn:stopAllActions()
			PlayScene.bgWaitingTip:setVisible(false)
			PlayScene:hidePlayersRobZhuangFrame()
			PlayScene:hideCardViewsActions()
			PlayScene:hidePlayersPledgeSign()
			PlayScene:hidePlayersRateSign()

			if (PlayScene.tongSha ~= nil) then
				PlayScene.tongSha:removeFromParent()
				PlayScene.tongSha = nil
			end
			PlayScene.waitType = nil
			-- 不同类型游戏特有的单独清理工作
			if self.game_id == gt.GameID.NIUYE or self.game_id == gt.GameID.NIUNIU then
				PlayScene:clearNiuEffect()
				PlayScene:resetCardSigns()
				--清除亮牌的一些东西
				for i,v in pairs(PlayScene.cardViews) do
					v.imgNiuTypeBg:stopAllActions()
					v.imgNiuType:stopAllActions()
					for j,vv in ipairs(v.imgCards) do
						vv:stopAllActions()
					end
					v.node:setVisible(false)
				end
			end
		end
		--处理玩家信息
		self:ProcessPlayers(self.RawMsg.player_data)

		--分数
		for i,v in ipairs(PlayScene.PlayerInfos) do
			PlayScene.roomPlayers[v.seat + 1].scoreLabel:setString(tostring(v.pt - v.score))
		end
		PlayScene.Btn_Speed:loadTextureNormal("image/replay/speed1.png")
		PlayScene.Btn_Play:loadTextureNormal("image/replay/pause2.png")
		--播放速度
		PlayScene.PlaySpeed = 1
		--当前录像帧
		PlayScene.CurPlayStepsIndex = 1
		--是否暂停  0暂停
		PlayScene.IsPlay = 1
		--下一步骤需要的时间
		PlayScene.NextStepsTime = PlayScene.PlaySteps[1].time
		PlayScene.CurPlayTime = PlayScene.PlaySteps[1].time
	end)
	--房间号
	gt.seekNodeByName(PlayScene,"Label_RoomNumber"):setString(enterRoomMsgTbl.room_id)
	--局数
	local remainTilesLabel = gt.seekNodeByName(PlayScene,"Label_Round")
	remainTilesLabel:setString("局数：" .. string.format("%d/%d",(enterRoomMsgTbl.current_round),enterRoomMsgTbl.rounds))
	remainTilesLabel:setVisible(true)
	--底分 玩法
	if PlayScene.showPlayTitle then
		PlayScene:showPlayTitle()
	end
	----房间信息
	--if self.game_id == gt.GameID.NIUYE then
	--
	--else
	--	--房间号
	--	gt.seekNodeByName(PlayScene,"Label_RoomNumber"):setString(enterRoomMsgTbl.room_id)
	--end
end

function RecordManager:onNodeEvent(eventName)
	if "enter" == eventName then

	elseif "exit" == eventName then
		gt.scheduler:unscheduleScriptEntry(self.scheduleRecord)
	end
end

function RecordManager:UpdatePlayRecord(delta)
	PlayScene.CurPlayTime = PlayScene.CurPlayTime + delta * 1000 * PlayScene.PlaySpeed * PlayScene.IsPlay
	if PlayScene.NextStepsTime ~= -1 and PlayScene.CurPlayTime >= PlayScene.NextStepsTime then
		PlayScene.CurPlayTime = PlayScene.NextStepsTime
		self:PlayStep(PlayScene.PlaySteps,PlayScene.CurPlayStepsIndex)
		PlayScene.CurPlayStepsIndex = PlayScene.CurPlayStepsIndex + 1
	end
end

--[[    @desc: 播放某一逻辑帧
    author:{author}
    time:2017-11-03 15:53:17
    --@steps:
	--@index:
    return
]]
function RecordManager:PlayStep(steps,index)
	local step = steps[index]
	if step ~= nil then
		dump(step.data,"PlayStep")
		gt.socketClient:dispatchMessage(step.data)
		--gt.dispatchEvent(step.cmd, step.data)
		PlayScene.CurPlayTime = steps[index] and steps[index].time or os.time()
		PlayScene.NextStepsTime = steps[index + 1] and steps[index + 1].time or -1
		if PlayScene.NextStepsTime - PlayScene.CurPlayTime > 5000 then
			PlayScene.NextStepsTime = PlayScene.CurPlayTime + 5000
		end
	else
		PlayScene.NextStepsTime = -1
	end
end

--[[    @desc: 处理玩家信息
    author:{author}
    time:2017-11-03 19:20:36
    --@msg:
    return
]]
function RecordManager:ProcessPlayers(msg)
	PlayScene.roomPlayers = {}
	PlayScene.PlayerInfos = json.decode(msg)
	for i,v in ipairs(PlayScene.PlayerInfos) do
		--local info = json.decode(v.info)
		local player = {}
		player.seat = v.seat
		player.score = v.pt - v.score
		player.info = v.info
		player.player = v.player
		player.is_wait = false
		PlayScene:onEnterRoomOther(player)
	end
end

--[[    @desc: 解析服务器下发的数据
    author:{author}
    time:2017-11-03 11:04:43
    --@msg:
    return
]]
function RecordManager:ProcessStep(msg)
	--不需要处理的类型
	--0x010A 准备 0x0103 玩家进入房间 0x0110 当前局数 最大局数
	for i,v in ipairs(msg) do
		if not v.data.cmd then
			v.data.cmd = v.cmd
		end
	end
	local Excludelist = {
		260, -- 退出房间
		4111, -- 玩家中途加入坐下
		gt.TRUSTEESHIP, --托管
		--4107,			-- 提示玩家可以压倍率
		--4105,			-- 提示玩家可以亮牌
	}

	if self.game_id ~= gt.GameID.ZJH then
		--扎金花不屏蔽开始游戏消息
		table.insert(Excludelist,4102) -- 开始游戏
	end

	--播放速度
	PlayScene.PlaySpeed = 1
	--录像步骤
	PlayScene.PlaySteps = {}
	--当前录像帧
	PlayScene.CurPlayStepsIndex = 1
	--录像计时器
	PlayScene.CurPlayTime = os.time()
	--是否暂停  0暂停
	PlayScene.IsPlay = 1
	PlayScene.PlaySteps = msg
	--排除不需要的操作
	for i = #PlayScene.PlaySteps,1,-1 do
		if gt.inTable(Excludelist,PlayScene.PlaySteps[i].cmd) then
			table.remove(PlayScene.PlaySteps,i)
		end
	end
	--标记最后一次发牌消息
	for i = #PlayScene.PlaySteps,1,-1 do
		if PlayScene.PlaySteps[i].cmd == gt.DEAL then
			PlayScene.PlaySteps[i].data.GOGOGO = true
			break
		end
	end

	--标记最后一次发牌2消息
	for i = #PlayScene.PlaySteps,1,-1 do
		if PlayScene.PlaySteps[i].cmd == gt.DEAL2_DN then
			PlayScene.PlaySteps[i].data.GOGOGO = true
			break
		end
	end
	--下一步骤需要的时间
	PlayScene.NextStepsTime = PlayScene.PlaySteps[1].time
	PlayScene.CurPlayTime = PlayScene.PlaySteps[1].time
end

return RecordManager