-- 俱乐部数据管理
local gt = cc.exports.gt

local GuildManager = class("GuildManager")

function GuildManager:ctor()
	self.guilds = {}		-- 俱乐部列表，数组 [{id, owner_id, name, apply, admin,partner}...]
	self.guild_applys = {}	-- 俱乐部申请列表，字典{guild_id:[{id, nick, icon}...]}
	self.guild_members = {}	-- 俱乐部成员列表，字典{guild_id:[{id, nick, icon, admin}...]}

	self.guild_myScores = {} -- 我的积分 字典 {guild_id:score,guild_id:score...}
end

-- 设置俱乐部列表
function GuildManager:setGuildList(guilds)
	self.guilds = guilds
end

-- 获得俱乐部列表
function GuildManager:getGuildList()
	return self.guilds
end

-- 获得俱乐部
function GuildManager:getGuild(guild_id)
	for i, v in ipairs(self.guilds) do
		if v.id == guild_id then
			return v
		end
	end
end

function GuildManager:isGuildAdmin(guild_id)
	local isAdmin = false
	local guild = self:getGuild(guild_id)
	if guild then
		isAdmin = guild.admin
	end
	return isAdmin
end

function GuildManager:isGuildOwner(guild_id)
	local isOwner_ = false
	local guild = self:getGuild(guild_id)
	if guild and guild.owner_id == gt.playerData.uid then
		isOwner_ = true
	end
	return isOwner_
end

-- 增加俱乐部
function GuildManager:addGuild(guild_info)
	for i, v in ipairs(self.guilds) do  -- 去重
		if v.id == guild_info.id then
			return
		end
	end
	table.insert(self.guilds, guild_info)
end

-- 删除俱乐部
function GuildManager:delGuild(guild_id)
	for i, v in ipairs(self.guilds) do
		if v.id == guild_id then
			table.remove(self.guilds, i)
			break
		end
	end
end

-- 俱乐部会长
function GuildManager:setGuildOwner(guild_id, owner_id)
	for i, v in ipairs(self.guilds) do
		if v.id == guild_id then
			v.owner_id = owner_id
			break
		end
	end
end

-- 俱乐部管理
function GuildManager:setGuildAdmin(guild_id, admin)
	for i, v in ipairs(self.guilds) do
		if v.id == guild_id then
			v.admin = admin
			break
		end
	end
end

-- 俱乐部合伙人
function GuildManager:setGuildPartner(guild_id, partner)
	for i, v in ipairs(self.guilds) do
		if v.id == guild_id then
			v.partner = partner
			break
		end
	end
end

-- 俱乐部改名
function GuildManager:renameGuild(guild_id, new_name)
	for i, v in ipairs(self.guilds) do
		if v.id == guild_id then
			v.name = new_name
			break
		end
	end
end

-- 获得俱乐部成员列表
function GuildManager:getGuildMembers(guild_id)
	return self.guild_members[guild_id]
end

-- 设置俱乐部成员列表
function GuildManager:setGuildMembers(guild_id, guild_member_list)
	self.guild_members[guild_id] = guild_member_list
end

-- 批量添加俱乐部成员
function GuildManager:addGuildMemberByList(guild_id, guild_member_list)
	local guild_members = self.guild_members[guild_id]
	if guild_members then
		for i, v in ipairs(guild_member_list) do
			table.insert(guild_members, v)
		end
	end
end

-- 添加俱乐部成员
-- member_info{id, nick, icon}
function GuildManager:addGuildMember(guild_id, member_info)
	local guild_members = self.guild_members[guild_id]
	if guild_members then
		for i, v in ipairs(guild_members) do  -- 去重
			if v.id == member_info.id then
				return
			end
		end
		table.insert(guild_members, member_info)
	end
end

-- 删除俱乐部成员
function GuildManager:delGuildMember(guild_id, user_id)
	local guild_members = self.guild_members[guild_id]
	if guild_members then
		for i, v in ipairs(guild_members) do
			if v.id == user_id then
				table.remove(guild_members, i)
				break
			end
		end
	end
end


function GuildManager:setMyScore(guild_id, myScore)
	self.guild_myScores[guild_id] = myScore
end

-- 获取自己在这个俱乐部的积分
function GuildManager:getMyScore(guild_id)
	return self.guild_myScores[guild_id]
end


-- 获取申请列表
function GuildManager:getGuildApplys(guild_id)
	return self.guild_applys[guild_id]
end

-- 设置申请列表
-- guild_applys[{id, nick, icon}...]
function GuildManager:setGuildApplys(guild_id, guild_applys)
	self.guild_applys[guild_id] = guild_applys 
end

-- 添加申请
function GuildManager:addGuildApply(guild_id, member_info)
	local guild_applys = self.guild_applys[guild_id]
	if not guild_applys then
		guild_applys = {}
		self.guild_applys[guild_id] = guild_applys
	end
	for i, v in ipairs(guild_applys) do  -- 去重
		if v.id == member_info.id then
			return
		end
	end
	table.insert(guild_applys, member_info)
	
	for i, v in ipairs(self.guilds) do
		if v.id == guild_id then
			v.apply = 1
		end
	end
end

-- 删除申请玩家
function GuildManager:delGuildApply(guild_id, user_id)
	local guild_applys = self.guild_applys[guild_id]
	if guild_applys then
		for i, v in ipairs(guild_applys) do
			if v.id == user_id then
				table.remove(guild_applys, i)
				break
			end
		end
		
		if #guild_applys == 0 then
			local guild = self:getGuild(guild_id)
			if guild then guild.apply = 0 end
		end
	end
end



return GuildManager
