local gt = cc.exports.gt

local GuildScoreGive = class("GuildScoreGive",function()
	return gt.createMaskLayer()
end)

function GuildScoreGive:ctor(guild_id,is_union)
	local csbName = "csd/Guild/GuildScoreGive.csb"
	if is_union then
		csbName = "csd/Guild/UnionScoreGive.csb"
	end
	local csbNode = cc.CSLoader:createNode(csbName)
	csbNode:setAnchorPoint(0.5,0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	self.guild_id = guild_id
	self.is_union = is_union or false
	gt.log("-----openUI:GuildScoreGive")

	self.targetId = 0
	self.score = 0

	local btnCancel = gt.seekNodeByName(csbNode,"Btn_Close")
	gt.addBtnPressedListener(btnCancel,function()
		self:close()
	end)

	self.lblTargetID = gt.seekNodeByName(csbNode,"lblTargetID")
	self.btnTargetID = gt.seekNodeByName(csbNode,"btnTargetID")
	self.btnTargetID:addClickEventListener(function()
		local view = require("app/views/Guild/GuildNumberPad"):create("score_give_id",0,0,handler(self,self.modTargetId))
		self:addChild(view)
	end)

	self.lblScore = gt.seekNodeByName(csbNode,"lblScore")
	self.btnScore = gt.seekNodeByName(csbNode,"btnScore")
	self.btnScore:addClickEventListener(function()
		local view = require("app/views/Guild/GuildNumberPad"):create("score_give",0,0,handler(self,self.modScore))
		self:addChild(view)
	end)


	--确认按钮
	local btnOk = gt.seekNodeByName(csbNode,"Btn_Ok")
	gt.addBtnPressedListener(btnOk,function()
		if self.score > 1000000000 then
			require("app/views/NoticeTips"):create("提示","赠送的分数不能超过1000000000",nil,nil,true)
			return
		elseif self.targetId <= 0 then
			require("app/views/NoticeTips"):create("提示","请输入要赠送的玩家ID",nil,nil,true)
			return
		elseif self.score <= 0 then
			require("app/views/NoticeTips"):create("提示","请输入要赠送的积分",nil,nil,true)
			return
		end
		
		local msgToSend = {}
		msgToSend.cmd = gt.GUILD_SCORE_GIVE
		msgToSend.open_id = gt.playerData.openid
		msgToSend.user_id = gt.playerData.uid
		msgToSend.target_id = self.targetId
		msgToSend.guild_id = guild_id
		msgToSend.score = self.score
		gt.socketClient:sendMessage(msgToSend)
		
		gt.showLoadingTips("")

	end)

	gt.socketClient:registerMsgListener(gt.GUILD_SCORE_GIVE,self,self.onRcvGuildScoreGive)
end

function GuildScoreGive:onRcvGuildScoreGive(msgTbl)
	gt.removeLoadingTips()
	
	if msgTbl.code == 0 then
		require("app/views/CommonTips"):create(string.format("成功赠送给玩家%d积分:%d",self.targetId,self.score),2)
		if self.is_union then
			gt.UnionManager:setMyScore(self.guild_id, msgTbl.score)
		else
			gt.guildManager:setMyScore(self.guild_id, msgTbl.score)
		end
		gt.dispatchEvent(gt.EventType.GUILD_REFRESH_SCORE)
		self:close()
	elseif msgTbl.code == 1 then -- 分数过大
		require("app/views/CommonTips"):create("增加失败，您输入的分数过大，请重新输入",2)
	elseif msgTbl.code == 2 then --玩家离开俱乐部
		require("app/views/CommonTips"):create("增加失败，当前俱乐部没有该玩家",2)
	elseif msgTbl.code == 3 then -- 没有足够的分数进行转移
		require("app/views/CommonTips"):create("增加失败，您没有足够的分数进行赠送",2)
	elseif msgTbl.code == 4 then -- 游戏内无法 
		require("app/views/CommonTips"):create("增加失败，玩家正在游戏中，无法进行下分操作",2)
	elseif msgTbl.code == 5 then -- target超过限制 
		require("app/views/CommonTips"):create("操作失败，该玩家积分已超过上限",2)
	elseif msgTbl.code == 6 then -- member超过限制 
		require("app/views/CommonTips"):create("操作失败，您的积分已超过上限，请减少自己积分数量后进行操作(先下掉自己部分积分)",2)
	end
	
end

function GuildScoreGive:modScore(value)
	self.score = value
	self.lblScore:setString(tostring(value))
end

function GuildScoreGive:modTargetId(value)
	self.targetId = value
	self.lblTargetID:setString(tostring(value))
end


function GuildScoreGive:close()
	gt.socketClient:unregisterMsgListener(gt.GUILD_SCORE_GIVE)
	self:removeFromParent()
end

return GuildScoreGive