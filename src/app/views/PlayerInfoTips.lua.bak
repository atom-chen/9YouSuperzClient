

local gt = cc.exports.gt

local PlayerInfoTips = class("PlayerInfoTips", function()
	return cc.Layer:create()
end)

function PlayerInfoTips:ctor(playerData, type , isTwelve)
	-- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))

	local csbName = "csd/PlayerInfoTips.csb"
	if isTwelve then
		csbName = "csd/PlayerInfoTipsTwelve.csb"
	end
	local csbNode = cc.CSLoader:createNode(csbName)

	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
    csbNode:setContentSize(gt.winSize)
    ccui.Helper:doLayout(csbNode)
	self:addChild(csbNode)

	self.type = type

    self.panelMain = gt.seekNodeByName(csbNode, "Panel_Main")
    self.panelRoom = gt.seekNodeByName(csbNode, "Panel_Room")
	local btnClose = gt.seekNodeByName(csbNode, "btnClose")
	if btnClose then
		btnClose:addClickEventListener(function(sender)
			self:removeFromParent()
		end)
	end
	local Btn_Close = gt.seekNodeByName(csbNode, "Btn_Close")
 	if Btn_Close then
		Btn_Close:addClickEventListener(function(sender)
			self:removeFromParent()
		end)
	end
    local panel = gt.seekNodeByName(csbNode, "Panel_Bg")
    panel:addClickEventListener(function(sender)
        if type > 1 then
        	self:removeFromParent()
        end
    end)

    if type == 1 or type == 0 then
	    self:showPlayerInfo(self.panelMain, playerData)
        self.panelRoom:setVisible(false)
    else
        self:showPlayerInfo(self.panelRoom, playerData)
        self.panelMain:setVisible(false)
        local emojiAnimations = {"gunshootFX_hit","cock","roseFX_2","courtship","throwingEggs","cheers","daoshuiFX","woshou","jiuping"}
        for i = 1, 9 do
            local btnEmoji = gt.seekNodeByName(self.panelRoom, "Btn_Emoji"..i)
            local time_cur = os.time()
            if time_cur < gt.playerData.emojiActTime + 3 then
                btnEmoji:setEnabled(false)
                local t = gt.playerData.emojiActTime + 3 - time_cur
                btnEmoji:runAction(cc.Sequence:create(cc.DelayTime:create(t), cc.CallFunc:create(function(sender) sender:setEnabled(true) end)))
            end
            gt.addBtnPressedListener(btnEmoji, function(sender)
                local msgToSend = {}
	            msgToSend.cmd = gt.SPEAKER
	            msgToSend.type = gt.ChatType.ACT_EMOJI
                msgToSend.msg = emojiAnimations[i]
                msgToSend.id = playerData.uid
                gt.socketClient:sendMessage(msgToSend)
                self:removeFromParent()

                if emojiAnimations[i] == "gunshootFX_hit" then
                    gt.dispatchEvent(emojiAnimations[i])
                end

                gt.playerData.emojiActTime = os.time()
            end)
        end
    end


	gt.socketClient:registerMsgListener(gt.GUILD_INVITE_SWITCH, self, self.onRcvGuildInviteSwitch)
end


function PlayerInfoTips:onRcvGuildInviteSwitch(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		gt.playerData.is_accept_invite = msgTbl.is_accept_invite
		self:refreshSwitch()
	elseif msgTbl.code == 1 then
		require("app/views/NoticeTips"):create("提示", "会话已过期，请重新登录", nil, nil, true)
        gt.dispatchEvent(gt.EventType.EXIT_HALL)
	elseif msgTbl.code == 2 then
		require("app/views/NoticeTips"):create("提示", "账号校验失败，请重新登录", nil, nil, true)
        gt.dispatchEvent(gt.EventType.EXIT_HALL)
	end
end

function PlayerInfoTips:refreshSwitch()
    self.btnYes:setSelected(false)
	self.btnNo:setSelected(false)
	self.btnYes:setTouchEnabled(false)
	self.btnNo:setTouchEnabled(false)
	if gt.playerData.is_accept_invite == 1 then
    	self.btnYes:setSelected(true)
		self.btnNo:setTouchEnabled(true)
	elseif gt.playerData.is_accept_invite == 2 or gt.playerData.is_accept_invite == 0 then
    	self.btnNo:setSelected(true)
		self.btnYes:setTouchEnabled(true)
	end
end

function PlayerInfoTips:onNodeEvent(eventName)
	if "enter" == eventName then
		local listener = cc.EventListenerTouchOneByOne:create()
		listener:setSwallowTouches(true)
		listener:registerScriptHandler(handler(self, self.onTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
		listener:registerScriptHandler(handler(self, self.onTouchEnded), cc.Handler.EVENT_TOUCH_ENDED)
		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
	elseif "exit" == eventName then
		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:removeEventListenersForTarget(self)

		gt.socketClient:unregisterMsgListener(gt.GUILD_INVITE_SWITCH)
	end
end


function PlayerInfoTips:onTouchBegan(touch, event)
	return true
end

function PlayerInfoTips:onTouchEnded(touch, event)
	self:removeFromParent()
end

function PlayerInfoTips:sendRequestIsInvite(isInvite)
	local msgToSend = {}
    msgToSend.cmd = gt.GUILD_INVITE_SWITCH
    msgToSend.user_id = gt.playerData.uid
   	msgToSend.open_id = gt.playerData.openid
    if isInvite and isInvite > 0 then
	    msgToSend.is_invite = isInvite
	end
    gt.socketClient:sendMessage(msgToSend)
    gt.showLoadingTips("")
end

function PlayerInfoTips:showPlayerInfo(parent, playerData)
	gt.dump(playerData)
    -- 头像
	local headSpr = gt.seekNodeByName(parent, "Img_Head")
	headSpr:loadTexture(string.format("%shead_%d.png", cc.FileUtils:getInstance():getWritablePath(), playerData.uid))

	-- 性别
	local sexImg = gt.seekNodeByName(parent, "Img_Sex")
	-- 默认男
	local sexFrameName = "man"
	if playerData.sex == 2 then
		-- 女
		sexFrameName = "woman"
	end
	sexImg:loadTexture("image/common/"..sexFrameName ..".png")

	-- 昵称
	local nicknameLabel = gt.seekNodeByName(parent, "Text_Nickname")
    if parent == self.panelRoom then
        nicknameLabel:setString(gt.checkName(playerData.nickname, 4))
    else
         nicknameLabel:setString(playerData.nickname)
    end
	

	-- ID
	local uidLabel = gt.seekNodeByName(parent, "Text_ID")
	-- uidLabel:setString("ID：" .. playerData.uid)
	uidLabel:setString("******")
	-- uidLabel:setVisible(false)

	-- ip
	local ipLabel = gt.seekNodeByName(parent, "Text_IP")
    if playerData.ip then
	    ipLabel:setString(playerData.ip)
    else
        ipLabel:setString(" ")
    end

    --局数
    local rounds = gt.seekNodeByName(parent, "Text_Rounds")
	if playerData.game_count then
		rounds:setString( string.format("对战局数：%d局", playerData.game_count))
	else
		rounds:setString("")
	end

    --创建时间
    local createTime = gt.seekNodeByName(parent, "Text_CreateTime")
	if playerData.reg_time then
		createTime:setString(playerData.reg_time)
	end

	-- 接受邀请
	local isMe = playerData.uid == gt.playerData.uid and self.type == 0
    local bgInvite = gt.seekNodeByName(parent, "Img_TypeBgInvite")
    local nodeInvite = gt.seekNodeByName(parent, "Img_InviteBg")
    if bgInvite then
    	bgInvite:setVisible(isMe)
    end
    if nodeInvite then
    	nodeInvite:setVisible(isMe)

	 	local btnYes = gt.seekNodeByName(parent, "Btn_InviteOpen")
	    local btnNo = gt.seekNodeByName(parent, "Btn_InviteClose")
	    btnYes:setSelected(false)
	    btnNo:setSelected(false)
		self.btnYes = btnYes
		self.btnNo = btnNo

    	if isMe then
			self:sendRequestIsInvite()

			btnYes:addTouchEventListener(function(sender, eventType)
                if eventType ~= ccui.TouchEventType.canceled and eventType ~= ccui.TouchEventType.ended then
                    return true
                end
				self:sendRequestIsInvite(1)
		    end)
			btnNo:addTouchEventListener(function(sender, eventType)
                if eventType ~= ccui.TouchEventType.canceled and eventType ~= ccui.TouchEventType.ended then
                    return true
                end
				self:sendRequestIsInvite(2)
		        -- require("app/views/NoticeTips"):create("提示", "接受任意邀请后自动切换回不接受", nil, nil, true)
			end)

    	end
    end

end

return PlayerInfoTips


