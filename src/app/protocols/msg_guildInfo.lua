local gt = cc.exports.gt

local msg_guildInfo = class("msg_guildInfo")

function msg_guildInfo:ctor()
end

function msg_guildInfo:dispatch(msgTbl)
	if gt.guildManager then
		gt.guildManager:setGuildAdmin(msgTbl.guild_id, msgTbl.admin)
		gt.guildManager:setGuildPartner(msgTbl.guild_id, msgTbl.partner)
		if msgTbl.owner_id then
			gt.guildManager:setGuildOwner(msgTbl.guild_id, msgTbl.owner_id)
		end
	end
end

return msg_guildInfo