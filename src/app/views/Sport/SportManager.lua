-- 赛场管理
local gt = cc.exports.gt

local sportConfig = require("app/views/Sport/SportConfig")

local SPORT_STATUS = {
	END = 0,		-- 结束
	INIT = 1,		-- 未开始
	START = 2,		-- 开始
	ASSIGN = 3,		-- 分配房间
	GOING = 4,		-- 进行中
	WAIT = 5,		-- 每轮结束之后，等待10秒后开始下一轮
}

local SPORT_STATUS_ZORDER = 2000

local SportManager = class("SportManager")


function SportManager:ctor()
	self.sportList = {}  --{id, tid, mode, fee, num, status, is_sign}
	self.curSportId = 0

	gt.socketClient:registerMsgListener(gt.ENTER_GAME, self, self.onRcvEnterGame)
	gt.socketClient:registerMsgListener(gt.SPORT_STATUS, self, self.onRcvSportStatus)
end


function SportManager:onRcvEnterGame(msgTbl)
	gt.removeLoadingTips()

    gt.GameServer.ip 	= msgTbl.host
	gt.GameServer.port 	= msgTbl.port
	gt.token			= msgTbl.token

	gt.socketClient:close()
	if gt.socketClient:connect(gt.GameServer.ip, gt.GameServer.port, true) then
		if gt.guildid then
			cc.UserDefault:getInstance():setIntegerForKey("guildid"..gt.playerData.uid, gt.guildid)
			cc.UserDefault:getInstance():setIntegerForKey("guildtype", gt.guildtype)
		end
	    local playScene = nil
        if msgTbl.game_id == gt.GameID.NIUNIU or msgTbl.game_id == gt.GameID.QIONGHAI then
			--牛牛 
            playScene = require("app/views/PlayScene"):create(msgTbl)
        elseif msgTbl.game_id == gt.GameID.SANGONG then
            --三公
			playScene = require("app/views/PlaySceneSG"):create(msgTbl)
		elseif msgTbl.game_id==gt.GameID.NIUYE then
			playScene = require("app/views/PlaySceneYS"):create(msgTbl)
		elseif msgTbl.game_id==gt.GameID.TTZ then
			playScene = require("app/views/PlaySceneTTZ"):create(msgTbl)
		elseif msgTbl.game_id == gt.GameID.ZJH then --扎金花
            playScene = require("app/views/PlaySceneZJH"):create(msgTbl)
        elseif msgTbl.game_id == gt.GameID.SSS then
          --   package.loaded['app/views/PlaySceneSSS'] = nil
            playScene = require("app/games/SSS/PlaySceneSSS"):create(msgTbl)
        end


	    cc.Director:getInstance():replaceScene(playScene)
    end
end

function SportManager:onRcvSportStatus(msgTbl)
	local status = msgTbl.status
	if status == -1 then
		if self.curSportId ~= 0 then
			self:showSportStatus("很遗憾，您已被淘汰", true)
		end
		self.curSportId = 0

	elseif status == SPORT_STATUS.END then
		if self.curSportId ~= 0 then
			self:showSportStatus("限时比赛已结束，请前往赛场结果界面查看您的成绩", true)
		end
		self.curSportId = 0

	elseif status == SPORT_STATUS.INIT then
		self.curSportId = msgTbl.id
		
	elseif status == SPORT_STATUS.START then
		self:showSportStatus("比赛即将开始，请做好准备", false)
		self.curSportId = msgTbl.id

		-- 返回比赛就绪的消息
		local msgToSend = {}
		msgToSend.cmd = gt.SPORT_REDAY
		msgToSend.user_id = gt.playerData.uid
		msgToSend.open_id = gt.playerData.openid
		msgToSend.sport_id = msgTbl.id
		gt.socketClient:sendMessage(msgToSend)

	elseif status == SPORT_STATUS.ASSIGN then
		self:showSportStatus("正在给您分配游戏座位", false)
		self.curSportId = msgTbl.id

	elseif status == SPORT_STATUS.GOING then
		self:showSportStatus("等待其他玩家完成比赛", false)
		self.curSportId = msgTbl.id
		
	elseif status == SPORT_STATUS.WAIT then
		self:showSportStatus("等待进入下一轮比赛", false)
		self.curSportId = msgTbl.id

	end
end

function SportManager:showSportStatus(msg, showBtn)
	local ss = display.getRunningScene():getChildByName("SportStatus")
	if ss then ss:removeFromParent() end
	local sportStatus = require("app/views/Sport/SportStatus"):create(msg, showBtn)
	display.getRunningScene():addChild(sportStatus, SPORT_STATUS_ZORDER)
end

function SportManager:setSportList(sportList)
	local nums = {}
	local show_nums = {}
	for i, v in ipairs(self.sportList) do
		nums[v.id] = v.num
		show_nums[v.id] = v.show_num
	end
	self.sportList = sportList
	for i, v in ipairs(self.sportList) do
		if v.mode == 1 then
			local old_num = nums[v.id] or 0
			local old_show_num = show_nums[v.id] or math.random(0, 4)
			if v.num == old_num then
				v.show_num = old_show_num
			else
				v.show_num = v.num * 5 + math.random(0, 4)
			end
		else
			v.show_num = v.num
		end
	end
end

function SportManager:getSportList()
	return self.sportList
end

function SportManager:getSport(sport_id)
	for i, v in ipairs(self.sportList) do
		if v.id == sport_id then
			return v
		end
	end
end

function SportManager:getSportByTid(sport_tid)
	for i, v in ipairs(self.sportList) do
		if v.tid == sport_tid then
			return v
		end
	end
end

function SportManager:setSign(sport_id, sign)
	for i, v in ipairs(self.sportList) do
		if v.id == sport_id then
			v.is_sign = (sign > 0)
			return
		end
	end
end

function SportManager:getConfigByTid(tid)
	for i, v in pairs(sportConfig) do
		if tid == v.tid then
			return v
		end
	end
end



return SportManager
