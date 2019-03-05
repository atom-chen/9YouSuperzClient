-- 俱乐部数字输入界面

local gt = cc.exports.gt

local GuildNumberPad = class("GuildNumberPad", function()
	return gt.createMaskLayer()
end)

function GuildNumberPad:ctor(type, guild_id, target_id, callback , value_)
	local csbNode = cc.CSLoader:createNode("csd/Guild/MatchAddScore.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	local maxScore = 1000000

	local btnClose = gt.seekNodeByName(csbNode, "Btn_Close")
	gt.addBtnPressedListener(btnClose, function()
		self:removeFromParent()
	end)

	self.lblNumber = gt.seekNodeByName(csbNode, "Lable_Number")
	self.lblNumber:setString("")
	local lblTitle = gt.seekNodeByName(csbNode, "Lable_Title")
	local lblOwn = gt.seekNodeByName(csbNode, "lblOwn")
	local btnConfirm = gt.seekNodeByName(csbNode, "Btn_Confirm")
	lblOwn:setVisible(false)
	self.type_ =  type
	self.value_ =  value_
	
	if type == "guild_invite" then	-- 邀请入会
		lblTitle:setString("请输入要邀请的玩家ID")
		gt.addBtnPressedListener(btnConfirm, function()
			local user_id = tonumber(self.lblNumber:getString()) or 0
			if user_id <= 0 or user_id > 99999999 then
				require("app/views/CommonTips"):create("您输入的ID不正确")
				return
			end

			local msgToSend = {}
			msgToSend.cmd = gt.GUILD_INVITE
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.invite_id = user_id
			msgToSend.guild_id = guild_id
			gt.socketClient:sendMessage(msgToSend)

			gt.showLoadingTips("")
			self:removeFromParent()
		end)
	elseif type == "guild_invite_member" then	-- 邀请玩家加入
		lblTitle:setString("请输入要邀请的玩家ID")
		gt.addBtnPressedListener(btnConfirm, function()
			local user_id = tonumber(self.lblNumber:getString()) or 0
			if user_id <= 0 or user_id > 99999999 then
				require("app/views/CommonTips"):create("您输入的ID不正确")
				return
			end

			local msgToSend = {}
			msgToSend.cmd = gt.GUILD_INVITE_MEMBER
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.target_id = user_id
			msgToSend.guild_id = guild_id
			gt.socketClient:sendMessage(msgToSend)

			gt.showLoadingTips("")
			self:removeFromParent()
		end)

	elseif type == "guild_apply" then	-- 申请入会
		local is_union = 0
		if guild_id == 1 then
			is_union = 1
			lblTitle:setString("请输入大联盟ID")
		else
			lblTitle:setString("请输入俱乐部ID")
		end
		gt.addBtnPressedListener(btnConfirm, function()
			local guild_id = tonumber(self.lblNumber:getString()) or 0
			if guild_id <= 0 or guild_id > 99999999 then
				require("app/views/CommonTips"):create("您输入的ID不正确")
				return
			end

			local msgToSend = {}
			msgToSend.cmd = gt.APPLY_GUILD
			msgToSend.user_id = gt.playerData.uid
			msgToSend.open_id = gt.playerData.openid
			msgToSend.icon = gt.playerData.headURL
			msgToSend.nick = gt.playerData.nickname
			msgToSend.guild_id = guild_id
			msgToSend.is_union = is_union
			gt.socketClient:sendMessage(msgToSend)

			gt.showLoadingTips("")
			self:removeFromParent()
		end)
	elseif type == "minus_score" then
		lblTitle:setString("请输入玩家减少的分数")
		lblOwn:setVisible(true)
		lblOwn:setString(string.format("当前拥有：%d",value_))


		local function confirm()
			local score = tonumber(self.lblNumber:getString())
			if score and score > 0 then
				local msgToSend = {}
				msgToSend.cmd = gt.MATCH_SCORE
				msgToSend.user_id = gt.playerData.uid
				msgToSend.open_id = gt.playerData.openid
				msgToSend.target_id = target_id
				msgToSend.guild_id = guild_id
				msgToSend.score = -score
				gt.socketClient:sendMessage(msgToSend)

				gt.showLoadingTips("")
				self:removeFromParent()
			end
		end
		
		gt.addBtnPressedListener(btnConfirm, function()
			local score = tonumber(self.lblNumber:getString())
			if score and score > 0 then
				if score >= 100000 then
					local tips = string.format("您确定要给 ID:%d 的玩家进行减 %d 分操作吗?", target_id ,score)
					require("app/views/NoticeTips"):create("提示", tips, confirm, nil, false)
				else
					local msgToSend = {}
					msgToSend.cmd = gt.MATCH_SCORE
					msgToSend.user_id = gt.playerData.uid
					msgToSend.open_id = gt.playerData.openid
					msgToSend.target_id = target_id
					msgToSend.guild_id = guild_id
					msgToSend.score = -score
					gt.socketClient:sendMessage(msgToSend)

					gt.showLoadingTips("")
					self:removeFromParent()
				end
			end
		end)

	elseif type == "add_score" then
		lblTitle:setString("请输入玩家增加分数")

		local function confirm()
			local score = tonumber(self.lblNumber:getString())
			if score and score > 0 then
				local msgToSend = {}
				msgToSend.cmd = gt.MATCH_SCORE
				msgToSend.user_id = gt.playerData.uid
				msgToSend.open_id = gt.playerData.openid
				msgToSend.target_id = target_id
				msgToSend.guild_id = guild_id
				msgToSend.score = score
				gt.socketClient:sendMessage(msgToSend)

				gt.showLoadingTips("")
				self:removeFromParent()
			end
		end

		gt.addBtnPressedListener(btnConfirm, function()
			local score = tonumber(self.lblNumber:getString())
			if score and score > 0 then
				if score >= 100000 then
					local tips = string.format("您确定要给 ID:%d 的玩家进行加 %d 分的操作吗?", target_id ,score)
					require("app/views/NoticeTips"):create("提示", tips, confirm, nil, false)
				else
					local msgToSend = {}
					msgToSend.cmd = gt.MATCH_SCORE
					msgToSend.user_id = gt.playerData.uid
					msgToSend.open_id = gt.playerData.openid
					msgToSend.target_id = target_id
					msgToSend.guild_id = guild_id
					msgToSend.score = score
					gt.socketClient:sendMessage(msgToSend)

					gt.showLoadingTips("")
					self:removeFromParent()
				end
			end
		end)


	elseif type == "partner_minus_score" then
		lblTitle:setString("请输入合伙人减少的分数")
		lblOwn:setVisible(true)
		lblOwn:setString(string.format("当前拥有：%d",value_))


		local function confirm()
			local score = tonumber(self.lblNumber:getString())
			if score and score > 0 then
				local msgToSend = {}
				msgToSend.cmd = gt.PARTNER_MATCH_SCORE
				msgToSend.user_id = gt.playerData.uid
				msgToSend.open_id = gt.playerData.openid
				msgToSend.target_id = target_id
				msgToSend.guild_id = guild_id
				msgToSend.score = -score
				gt.socketClient:sendMessage(msgToSend)

				gt.showLoadingTips("")
				self:removeFromParent()
			end
		end
		
		gt.addBtnPressedListener(btnConfirm, function()
			local score = tonumber(self.lblNumber:getString())
			if score and score > 0 then
				if score >= 100000 then
					local tips = string.format("您确定要给 ID:%d 的合伙人进行减 %d 分操作吗?", target_id ,score)
					require("app/views/NoticeTips"):create("提示", tips, confirm, nil, false)
				else
					local msgToSend = {}
					msgToSend.cmd = gt.PARTNER_MATCH_SCORE
					msgToSend.user_id = gt.playerData.uid
					msgToSend.open_id = gt.playerData.openid
					msgToSend.target_id = target_id
					msgToSend.guild_id = guild_id
					msgToSend.score = -score
					gt.socketClient:sendMessage(msgToSend)

					gt.showLoadingTips("")
					self:removeFromParent()
				end
			end
		end)
	elseif type == "partner_add_score" then
		lblTitle:setString("请输入合伙人增加分数")

		local function confirm()
			local score = tonumber(self.lblNumber:getString())
			if score and score > 0 then
				local msgToSend = {}
				msgToSend.cmd = gt.PARTNER_MATCH_SCORE
				msgToSend.user_id = gt.playerData.uid
				msgToSend.open_id = gt.playerData.openid
				msgToSend.target_id = target_id
				msgToSend.guild_id = guild_id
				msgToSend.score = score
				gt.socketClient:sendMessage(msgToSend)

				gt.showLoadingTips("")
				self:removeFromParent()
			end
		end

		gt.addBtnPressedListener(btnConfirm, function()
			local score = tonumber(self.lblNumber:getString())
			if score and score > 0 then
				if score >= 100000 then
					local tips = string.format("您确定要给 ID:%d 的合伙人进行加 %d 分的操作吗?", target_id ,score)
					require("app/views/NoticeTips"):create("提示", tips, confirm, nil, false)
				else
					local msgToSend = {}
					msgToSend.cmd = gt.PARTNER_MATCH_SCORE
					msgToSend.user_id = gt.playerData.uid
					msgToSend.open_id = gt.playerData.openid
					msgToSend.target_id = target_id
					msgToSend.guild_id = guild_id
					msgToSend.score = score
					gt.socketClient:sendMessage(msgToSend)

					gt.showLoadingTips("")
					self:removeFromParent()
				end
			end
		end)


	elseif type == "partner_give_from" then --联盟赠与下分
		lblTitle:setString("请输入给合伙人减少的分数")
		if value_ then
			lblOwn:setVisible(true)
			lblOwn:setString(string.format("当前可减少：%d",value_))
		end
		maxScore = 1000000
		
		local function confirm()
			local score = tonumber(self.lblNumber:getString())
			if score and score > 0 then
				local msgToSend = {}
				msgToSend.cmd = gt.GUILD_SCORE_GIVE
				msgToSend.user_id = gt.playerData.uid
				msgToSend.open_id = gt.playerData.openid
				msgToSend.target_id = target_id
				msgToSend.guild_id = guild_id
				msgToSend.score = -score
				gt.socketClient:sendMessage(msgToSend)

				gt.showLoadingTips("")
				self:removeFromParent()
			end
		end

		gt.addBtnPressedListener(btnConfirm, function()
			local score = tonumber(self.lblNumber:getString())
			if score and score > 0 then
				if score >= 100000 then
					local tips = string.format("您确定要给 ID:%d 的合伙人进行减 %d 分的操作吗?", target_id ,score)
					require("app/views/NoticeTips"):create("提示", tips, confirm, nil, false)
				else
					local msgToSend = {}
					msgToSend.cmd = gt.GUILD_SCORE_GIVE
					msgToSend.user_id = gt.playerData.uid
					msgToSend.open_id = gt.playerData.openid
					msgToSend.target_id = target_id
					msgToSend.guild_id = guild_id
					msgToSend.score = -score
					gt.socketClient:sendMessage(msgToSend)

					gt.showLoadingTips("")
					self:removeFromParent()
				end
			end
		end)

	elseif type == "partner_give_to" then --联盟赠与上分
		lblTitle:setString("请输入给合伙人赠送的分数")
		if value_ then
			lblOwn:setVisible(true)
			lblOwn:setString(string.format("当前可赠送：%d",value_))
		end
		maxScore = 1000000

		local function confirm()
			local score = tonumber(self.lblNumber:getString())
			if score and score > 0 then
				local msgToSend = {}
				msgToSend.cmd = gt.GUILD_SCORE_GIVE
				msgToSend.user_id = gt.playerData.uid
				msgToSend.open_id = gt.playerData.openid
				msgToSend.target_id = target_id
				msgToSend.guild_id = guild_id
				msgToSend.score = score
				gt.socketClient:sendMessage(msgToSend)

				gt.showLoadingTips("")
				self:removeFromParent()
			end
		end

		gt.addBtnPressedListener(btnConfirm, function()
			local score = tonumber(self.lblNumber:getString()) or 0
			if score > 1000000 then
			require("app/views/NoticeTips"):create("提示","赠送的分数不能超过1000000",nil,nil,true)
				return
			elseif target_id <= 0 then
				require("app/views/NoticeTips"):create("提示","请输入要赠送的玩家ID",nil,nil,true)
				return
			elseif score <= 0 then
				require("app/views/NoticeTips"):create("提示","请输入要赠送的积分",nil,nil,true)
				return
			end

			if score >= 100000 then
					local tips = string.format("您确定要给 ID:%d 的合伙人进行赠送 %d 分的操作吗?", target_id ,score)
					require("app/views/NoticeTips"):create("提示", tips, confirm, nil, false)
				else
					local msgToSend = {}
					msgToSend.cmd = gt.GUILD_SCORE_GIVE
					msgToSend.user_id = gt.playerData.uid
					msgToSend.open_id = gt.playerData.openid
					msgToSend.target_id = target_id
					msgToSend.guild_id = guild_id
					msgToSend.score = score
					gt.socketClient:sendMessage(msgToSend)

					gt.showLoadingTips("")
					self:removeFromParent()
				end
		end)

	elseif type == "partnerMember_give_from" then --联盟成员赠与下分
		lblTitle:setString("请输入给成员减少的分数")
		if value_ then
			lblOwn:setVisible(true)
			lblOwn:setString(string.format("当前可减少：%d",value_))
		end
		maxScore = 1000000

		local function confirm()
			local score = tonumber(self.lblNumber:getString())
			if score and score > 0 then
				local msgToSend = {}
				msgToSend.cmd = gt.GUILD_SCORE_GIVE
				msgToSend.user_id = gt.playerData.uid
				msgToSend.open_id = gt.playerData.openid
				msgToSend.target_id = target_id
				msgToSend.guild_id = guild_id
				msgToSend.score = -score
				gt.socketClient:sendMessage(msgToSend)

				gt.showLoadingTips("")
				self:removeFromParent()
			end
		end

		gt.addBtnPressedListener(btnConfirm, function()
			local score = tonumber(self.lblNumber:getString())
			if score and score > 0 then
				if score >= 100000 then
					local tips = string.format("您确定要给 ID:%d 的成员进行减 %d 分的操作吗?", target_id ,score)
					require("app/views/NoticeTips"):create("提示", tips, confirm, nil, false)
				else
					local msgToSend = {}
					msgToSend.cmd = gt.GUILD_SCORE_GIVE
					msgToSend.user_id = gt.playerData.uid
					msgToSend.open_id = gt.playerData.openid
					msgToSend.target_id = target_id
					msgToSend.guild_id = guild_id
					msgToSend.score = -score
					gt.socketClient:sendMessage(msgToSend)

					gt.showLoadingTips("")
					self:removeFromParent()
				end
			end
		end)

	elseif type == "partnerMember_give_to" then --联盟成员赠与上分
		lblTitle:setString("请输入给成员赠送的分数")
		if value_ then
			lblOwn:setVisible(true)
			lblOwn:setString(string.format("当前可赠送：%d",value_))
		end
		maxScore = 1000000

		local function confirm()
			local score = tonumber(self.lblNumber:getString())
			if score and score > 0 then
				local msgToSend = {}
				msgToSend.cmd = gt.GUILD_SCORE_GIVE
				msgToSend.user_id = gt.playerData.uid
				msgToSend.open_id = gt.playerData.openid
				msgToSend.target_id = target_id
				msgToSend.guild_id = guild_id
				msgToSend.score = score
				gt.socketClient:sendMessage(msgToSend)

				gt.showLoadingTips("")
				self:removeFromParent()
			end
		end

		gt.addBtnPressedListener(btnConfirm, function()
			local score = tonumber(self.lblNumber:getString()) or 0
			if score > 1000000 then
			require("app/views/NoticeTips"):create("提示","赠送的分数不能超过1000000",nil,nil,true)
				return
			elseif target_id <= 0 then
				require("app/views/NoticeTips"):create("提示","请输入要赠送的玩家ID",nil,nil,true)
				return
			elseif score <= 0 then
				require("app/views/NoticeTips"):create("提示","请输入要赠送的积分",nil,nil,true)
				return
			end

			if score >= 100000 then
					local tips = string.format("您确定要给 ID:%d 的成员进行赠送 %d 分的操作吗?", target_id ,score)
					require("app/views/NoticeTips"):create("提示", tips, confirm, nil, false)
				else
					local msgToSend = {}
					msgToSend.cmd = gt.GUILD_SCORE_GIVE
					msgToSend.user_id = gt.playerData.uid
					msgToSend.open_id = gt.playerData.openid
					msgToSend.target_id = target_id
					msgToSend.guild_id = guild_id
					msgToSend.score = score
					gt.socketClient:sendMessage(msgToSend)

					gt.showLoadingTips("")
					self:removeFromParent()
				end
		end)


	elseif type == "search_user" then
		lblTitle:setString("请输入要查询玩家的ID")
		gt.addBtnPressedListener(btnConfirm, function()
			local user_id = tonumber(self.lblNumber:getString()) or 0
			if callback then
				callback(user_id)
			end
			self:removeFromParent()
		end)
	elseif type == "score_give_id" then
		lblTitle:setString("请输入要赠送积分的玩家的ID")
		gt.addBtnPressedListener(btnConfirm, function()
			local user_id = tonumber(self.lblNumber:getString()) or 0
			if callback then
				callback(user_id)
			end
			self:removeFromParent()
		end)

	elseif type == "add_partnerMem" then
		lblTitle:setString("请输入要调配的成员ID")
		gt.addBtnPressedListener(btnConfirm, function()
			local user_id = tonumber(self.lblNumber:getString()) or 0
			if callback then
				callback(user_id)
			end
			self:removeFromParent()
		end)
		
	elseif type == "add_partner" then
		lblTitle:setString("请输入合伙人ID")
		gt.addBtnPressedListener(btnConfirm, function()
			local user_id = tonumber(self.lblNumber:getString()) or 0
			if callback then
				callback(user_id)
			end
			self:removeFromParent()
		end)


	elseif type == "get_number" then
		lblTitle:setString("")
		gt.addBtnPressedListener(btnConfirm, function()
			local number = tonumber(self.lblNumber:getString()) or 0
			if callback then
				callback(number)
			end
			self:removeFromParent()
		end)

	elseif type == "score_create" then
		lblTitle:setString("请输入需要增加的积分")
		maxScore = 1000000
		self.value_ =  1000000
		gt.addBtnPressedListener(btnConfirm, function()
			local user_id = tonumber(self.lblNumber:getString()) or 0
			if callback then
				callback(user_id)
			end
			self:removeFromParent()
		end)	

	elseif type == "score_give" then
		lblTitle:setString("请输入需要赠送的积分")
		-- maxScore = 1000000
		gt.addBtnPressedListener(btnConfirm, function()
			local user_id = tonumber(self.lblNumber:getString()) or 0
			if callback then
				callback(user_id)
			end
			self:removeFromParent()
		end)
		
	elseif type == "mammon_inputNum" then
		maxScore = 1000000
		lblTitle:setString("")
		gt.addBtnPressedListener(btnConfirm, function()
			local number = tonumber(self.lblNumber:getString()) or 0
			if callback then
				callback(number)
			end
			self:removeFromParent()
		end)
		
	end

	local btnClear = gt.seekNodeByName(csbNode, "Btn_Clear")
	btnClear:addClickEventListener(function ()
		self.lblNumber:setString("")
	end)

	local function onNumber(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		local num = sender:getTag()
		local score = tonumber(self.lblNumber:getString()) or 0
		num = score * 10 + num
		if num <= maxScore then
			self.lblNumber:setString(tostring(num))
		end
		if self.type_ == "minus_score" 
			or self.type_ == "partner_give_to"
			or self.type_ == "partner_give_from"
			or self.type_ == "partnerMember_give_to"
			or self.type_ == "partnerMember_give_from"
			or self.type_ == "mammon_inputNum"
			or self.type_ == "score_create"
		then
			if num > self.value_ then
				self.lblNumber:setString(tostring(self.value_))
			end
		end
	end
	for i = 0, 9 do
		local btn = gt.seekNodeByName(csbNode, "Btn_"..tostring(i))
		btn:addClickEventListener(onNumber)
	end
end

return GuildNumberPad
