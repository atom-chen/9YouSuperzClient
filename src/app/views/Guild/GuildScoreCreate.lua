local gt = cc.exports.gt

local GuildScoreCreate = class("GuildScoreCreate",function()
	return gt.createMaskLayer()
end)

function GuildScoreCreate:ctor(guild_id, is_union)
	local csbName = "csd/Guild/GuildScoreCreate.csb"
	if is_union then
		csbName = "csd/Guild/UnionScoreCreate.csb"
	end
	local csbNode = cc.CSLoader:createNode(csbName)
	csbNode:setAnchorPoint(0.5,0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	self.guild_id = guild_id
	gt.log("-----openUI:GuildScoreCreate")

	self.score = 0

	local btnCancel = gt.seekNodeByName(csbNode,"Btn_Close")
	gt.addBtnPressedListener(btnCancel,function()
		self:close()
	end)

	self.lblScore = gt.seekNodeByName(csbNode,"lblScore")
	self.btnModScore = gt.seekNodeByName(csbNode,"btnModScore")
	self.btnModScore:addClickEventListener(function()
		local view = require("app/views/Guild/GuildNumberPad"):create("score_create",0,0,handler(self,self.modScore))
		self:addChild(view)
	end)


	--确认按钮
	local btnOk = gt.seekNodeByName(csbNode,"Btn_Ok")
	gt.addBtnPressedListener(btnOk,function()
		if self.score > 1000000 then
			require("app/views/NoticeTips"):create("提示","增加的分数不能超过1000000",nil,nil,true)
			return
		elseif self.score <= 0 then
			require("app/views/NoticeTips"):create("提示","请输入要增加的积分",nil,nil,true)
			return
		end
		
		local msgToSend = {}
		msgToSend.cmd = gt.GUILD_SCORE_CREATE
		msgToSend.open_id = gt.playerData.openid
		msgToSend.user_id = gt.playerData.uid
		msgToSend.guild_id = guild_id
		msgToSend.score = self.score
		gt.socketClient:sendMessage(msgToSend)
		gt.showLoadingTips("")

	end)

	gt.socketClient:registerMsgListener(gt.GUILD_SCORE_CREATE,self,self.onRcvGuildScoreCreate)
end

function GuildScoreCreate:onRcvGuildScoreCreate(msgTbl)
	gt.removeLoadingTips()
	
	if msgTbl.code == 0 then
		require("app/views/CommonTips"):create(string.format("增加积分%d成功",self.score),2)
		gt.UnionManager:setMyScore(self.guild_id, msgTbl.score)
		gt.dispatchEvent(gt.EventType.GUILD_REFRESH_SCORE)

		self:close()
	elseif msgTbl.code == 1 then --分数过大
		require("app/views/CommonTips"):create("增加失败，您输入的分数过大，请重新输入",2)

	elseif msgTbl.code == 2 then  --不是管理员
		require("app/views/CommonTips"):create("增加失败，您没有这个权限",2)

	elseif msgTbl.code == 3 then  --超过携带上限
		require("app/views/CommonTips"):create("增加失败，玩家积分已超过上限",2)
		
	end
	
end

function GuildScoreCreate:modScore(value)
	self.score = value
	self.lblScore:setString(tostring(value))
end


function GuildScoreCreate:close()
	gt.socketClient:unregisterMsgListener(gt.GUILD_SCORE_CREATE)
	self:removeFromParent()
end

return GuildScoreCreate
--[[
1.历史大赢家、总局数排行榜
http://api.mgklqp.9you.net:8080/api/guildrecord/guild_total_rank
{"guild_id":115469,"user_id":732964,"time":1534843257,"limit":100,"game_type":"klnn","sign":"3e548efc8d2c718d851867d34f01fb33"}

2.昨日赢分、昨日总局数排行
http://api.mgklqp.9you.net:8080/api/guildrecord/guild_yesterday_record
{"guild_id":115469,"type":1,"time":1534843257,"limit":100,"game_type":"klnn","sign":"b2d91d9c4d9b09adcac9c7155efad0fd"}

3.个人上下分流水数据
http://api.mgklqp.9you.net:8080/api/guildrecord/guild_playerscore_change_record
{"guild_id":115469,"time":1534843257,"user_id":732964,"limit":100,"game_type":"klnn","sign":"a1114b1084c5916faa27eb871dcc6716"}

4.个人输赢分流水
http://api.mgklqp.9you.net:8080/api/guildrecord/guild_playerscore_winlose_record
{"guild_id":115469,"user_id":732964,"time":1534843257,"limit":100,"game_type":"klnn","sign":"3e548efc8d2c718d851867d34f01fb33"}

5.个人抽水流水
http://api.mgklqp.9you.net:8080/api/guildrecord/guild_player_emoition
{"guild_id":115469,"time":1534843257,"limit":100,"game_type":"klnn","sign":"7cbbd8e15a5fe7ff6c587627da0fedab"}  --sign不通过
{"user_id":732964,"guild_id":115469,"time":1534843257,"limit":100,"game_type":"klnn","sign":"96c9e1fa7910c62effeb68a5d09bf4fd"}

6.昨日表情消耗
http://api.mgklqp.9you.net:8080/api/guildrecord/guild_yesterday_emotion
{"guild_id":115469,"time":1534843257,"game_type":"klnn","sign":"40af37d99184a0c4174265e551519c57"}

7.俱乐部创造积分
http://api.mgklqp.9you.net:8080/api/guildrecord/guild_create_score_record
{"guild_id":115469,"time":1534843257,"game_type":"klnn","sign":"40af37d99184a0c4174265e551519c57"}

8.合伙人列表
http://api.mgklqp.9you.net:8080/api/guildrecord/guild_get_partners
{"guild_id":115469,"time":1534843257,"game_type":"klnn","sign":"40af37d99184a0c4174265e551519c57"}

{
    "data": "",
    "message": "Object reference not set to an instance of an object.",
    "success": false,
    "status": "500"
}

9.合伙人成员信息
http://api.mgklqp.9you.net:8080/api/guildrecord/guild_partner_info
{"guild_id":115469,"partner_id":732964,"time":1534843257,"game_type":"klnn","sign":"49d5c3b00e83962310a50ba45c4bc362"}
{
    "data": "",
    "message": "Object reference not set to an instance of an object.",
    "success": false,
    "status": "500"
}
]]