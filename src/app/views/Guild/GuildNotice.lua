-- 俱乐部公告

local gt = cc.exports.gt

local GuildNotice = class("GuildNotice", function()
	return cc.Layer:create()
end)

function GuildNotice:ctor(guild_id, is_union)
	local csbNode = cc.CSLoader:createNode("csd/Guild/GuildNotice.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	self.is_union = is_union or false
	gt.log("-----openUI:GuildNotice")
    local guild = nil
    if self.is_union then
	    guild = gt.UnionManager:getGuild(guild_id)
	else
	    guild = gt.guildManager:getGuild(guild_id)
	end

	local pInfo = gt.seekNodeByName(csbNode, "Panel_Info")
	pInfo:addClickEventListener(function(sender)
		gt.socketClient:unregisterMsgListener(gt.GUILD_GET_NOTICE)
		sender:removeFromParent()
	end)

	self.lblPlay = gt.seekNodeByName(csbNode, "Label_Play")

	gt.socketClient:registerMsgListener(gt.GUILD_GET_NOTICE, self, self.onRcvGuildGetNotice)

	local msgToSend = {}
	msgToSend.cmd = gt.GUILD_GET_NOTICE
	msgToSend.user_id = gt.playerData.uid
	msgToSend.open_id = gt.playerData.openid
	msgToSend.guild_id = guild_id
	gt.socketClient:sendMessage(msgToSend)
	gt.showLoadingTips("")
end


function GuildNotice:onRcvGuildGetNotice(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == -1 then
		return
	end
	local par = json.decode(msgTbl.kwargs)
	local str = gt.getGameTypeDesc(par.game_id, par.game_type)
	
	local strGameId = ""
	if par.game_id == gt.GameID.NIUNIU then
		strGameId = "牛牛"
	elseif par.game_id == gt.GameID.SANGONG then
		strGameId = "三公"
    elseif par.game_id == gt.GameID.NIUYE then
        strGameId = "经典"
    elseif par.game_id == gt.GameID.ZJH then
        strGameId = "拼三张"
    elseif par.game_id == gt.GameID.TTZ then
        strGameId = "推筒子"
    elseif par.game_id == gt.GameID.QIONGHAI then
        strGameId = "琼海"
    elseif par.game_id == gt.GameID.SSS then
        strGameId = "十三水"
	end
	str = str .. "[" .. strGameId .. "]"

    -- 付费，翻倍规则，底分，倍数，推注，特殊牌型
    local strPay, strRate, strScore, baseScore, rate, strRule, strSpecial , SSS_str = gt.getRoomInfo(par, true)
    str = str..strPay..strScore..baseScore.."\n"..strRate.."\n"..strRule.."\n"..strSpecial

    if par.game_id == gt.GameID.SSS and par.game_type == 7 then
        self.lblPlay:setString(strRule..strScore.."\n"..SSS_str)
    else
        self.lblPlay:setString(str)
    end

--	self.lblPlay:setString(str)
	-- self.lblNotice:setString(msgTbl.notice)
end

return GuildNotice
