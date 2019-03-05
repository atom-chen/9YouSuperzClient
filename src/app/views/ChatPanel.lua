
local gt = cc.exports.gt
require("app/ShieldWord")

local ChatPanel = class("ChatPanel", function()
	return cc.Layer:create()
end)

function ChatPanel:ctor(msg,isTwelve,is_shutup)
	-- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))

    self.seat = seat

    local csbName = "csd/Chat.csb"
    if isTwelve then
        csbName = "csd/ChatTwelve.csb"
    end
	local csbNode = cc.CSLoader:createNode(csbName)

	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
    ccui.Helper:doLayout(csbNode)
	self:addChild(csbNode)
	self.rootNode = csbNode
	self.msg = msg
    local playerData = gt.playerData

    local panelChat = gt.seekNodeByName(csbNode, "Panel_Bg")
    local fix = gt.seekNodeByName(csbNode, "Panel_Fix")
    local expression = gt.seekNodeByName(csbNode,"Panel_Emoji")
    local record = gt.seekNodeByName(csbNode, "Panel_Record")
    local listRecord = gt.seekNodeByName(record, "ListVw_Record")
    local pTemplate = gt.seekNodeByName(listRecord, "Panel_Chat")
    self.pTemplate = pTemplate

    panelChat:addClickEventListener(function(sender)
        self:removeFromParent()
    end)

    pTemplate:retain()
	listRecord:removeAllChildren()
    fix:setVisible(false)
    expression:setVisible(true)
    record:setVisible(false)
    --emoji:setVisible(false)

    if msg ~= false then
        for i = #msg, 1, -1 do
            local item = pTemplate:clone()
            local nickBg = gt.seekNodeByName(item, "Img_NickBg")
            local textNick = gt.seekNodeByName(nickBg, "Text_Nickname")
            local imgContentBg = gt.seekNodeByName(item, "Img_Content_Bg")
            local imgChatEmoji = gt.seekNodeByName(imgContentBg, "Img_ChatEmoji")
            imgChatEmoji:setVisible(false)
            if msg[i].type == gt.ChatType.FIX_MSG or msg[i].type == gt.ChatType.INPUT_MSG then
                local textContent = gt.seekNodeByName(imgContentBg, "Text_ChatContent")
                textContent:setString(msg[i].content)
            elseif msg[i].type == gt.ChatType.EMOJI then
                imgChatEmoji:setVisible(true)
                imgChatEmoji:loadTexture("image/Chat/emoji/"..msg[i].content..".png", ccui.TextureResType.plistType)
            end
            textNick:setString(gt.checkName(msg[i].nick, 4))
            listRecord:pushBackCustomItem(item)
        end
    end
    local panelChatEmoji = gt.seekNodeByName(csbNode, "Panel_Chat_Emoji")
    local panelChatFix = gt.seekNodeByName(csbNode, "Panel_Chat_Fix")
    local panelChatRecord = gt.seekNodeByName(csbNode, "Panel_Chat_Record")
    local choiceBg = gt.seekNodeByName(csbNode, "Img_ChoiceBg")

    local Img_Chat = gt.seekNodeByName(csbNode, "Img_Chat")
    local Img_Fix = gt.seekNodeByName(csbNode, "Img_Fix")
    local Img_Emoji = gt.seekNodeByName(csbNode, "Img_Emoji")

    --快捷语
    for i = 1, 6 do
		local btnFix = gt.seekNodeByName(fix, "Btn_Fix"..i)
        local txtFix = gt.seekNodeByName(btnFix, "Text_Fix"..i)
        txtFix:setString(gt.getLocationString("LTKey_0028_" .. i))
        gt.addBtnPressedListener(btnFix, function()
            self:sendChatMsg(gt.ChatType.FIX_MSG, playerData.nickname, txtFix:getString())
            self:removeFromParent()
        end)
	end
    local fixMsgListVw = gt.seekNodeByName(fixMsgNode, "ListVw_fixMsg")
    gt.addBtnPressedListener(panelChatFix, function()
        fix:setVisible(true)
        expression:setVisible(false)
        record:setVisible(false)
        choiceBg:setPositionY(Img_Fix:getPositionY())
    end)

    gt.addBtnPressedListener(panelChatRecord, function()
        fix:setVisible(false)
        expression:setVisible(false)
        record:setVisible(true)
        choiceBg:setPositionY(Img_Chat:getPositionY())
    end)

    --表情
    local emoticons = {"emoticon_angry", "emoticon_cool", "emoticon_cry", "emoticon_happy", "emoticon_suprise", "emoticon_tears"}
    for i = 1, 6 do
        local btnEmoji = gt.seekNodeByName(expression, "Btn_Emoji_"..i)
        gt.addBtnPressedListener(btnEmoji, function()
            self:sendChatMsg(gt.ChatType.EMOJI, playerData.nickname, emoticons[i])
            self:removeFromParent()
        end)
    end
    gt.addBtnPressedListener(panelChatEmoji, function()
        fix:setVisible(false)
        expression:setVisible(true)
        record:setVisible(false)
        choiceBg:setPositionY(Img_Emoji:getPositionY())
    end)

    --发送按钮
    local btnSend = gt.seekNodeByName(csbNode, "Btn_Send")
	if 1 == is_shutup then
		btnSend:setVisible(false)
		gt.seekNodeByName(csbNode, "Img_Input"):setVisible(false)
	end
    gt.addBtnPressedListener(btnSend, function()
        fix:setVisible(false)
        expression:setVisible(false)
        record:setVisible(true)
        local inputMsgExtField = gt.seekNodeByName(csbNode, "TextField_Enter")
        local inputString = inputMsgExtField:getString()
        if string.len(inputString) > 0 then
            if gt.CheckShieldWord(inputString) then
                self:removeFromParent()
                require("app/views/NoticeTips"):create("提示", "您输入的词语含有敏感词，请重新输入", nil, nil, true)
            else
                self:sendChatMsg(gt.ChatType.INPUT_MSG, playerData.nickname, inputString)
                self:removeFromParent()
            end
        end
    end)
end

function ChatPanel:onNodeEvent(eventName)
	if "enter" == eventName then
		local listener = cc.EventListenerTouchOneByOne:create()
		listener:setSwallowTouches(true)
		listener:registerScriptHandler(handler(self, self.onTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
		listener:registerScriptHandler(handler(self, self.onTouchEnded), cc.Handler.EVENT_TOUCH_ENDED)
		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
	elseif "exit" == eventName then
        
        self.pTemplate:release()

		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:removeEventListenersForTarget(self)
	end
end

function ChatPanel:onTouchBegan(touch, event)
	return true
end

function ChatPanel:onTouchEnded(touch, event)
	--self:removeFromParent()
end

function ChatPanel:switchChatTab(sender)
	local tabTag = sender:getTag()
	for i, tabData in ipairs(self.chatTabBtns) do
		if i == tabTag then
			tabData[1]:setBrightStyle(ccui.BrightStyle.highlight)
			tabData[2]:setVisible(true)
		else
			tabData[1]:setBrightStyle(ccui.BrightStyle.normal)
			tabData[2]:setVisible(false)
		end
	end
	local fixMsgNode = gt.seekNodeByName(csbNode, "Node_fixMsg")
	local emojiNode = gt.seekNodeByName(csbNode, "Node_emoji")
end

function ChatPanel:fixMsgClickEvent(sender, eventType)
	self:sendChatMsg(gt.ChatType.FIX_MSG, sender:getTag())
end

function ChatPanel:emojiClickEvent(sender)
	self:sendChatMsg(gt.ChatType.EMOJI, 0, sender:getName())
end

function ChatPanel:fixMsgLogClickEvent(sender, eventType)
	self:sendChatMsg(gt.ChatType.INPUT_MSG,sender:getTag(),self.msg[sender:getTag()].abstract)
end

function ChatPanel:TxtFieldClickEvent(sender, eventType)

	if eventType == 0 then
		if gt.isIOSPlatform() then
			local moveTo = cc.MoveTo:create(0.5,cc.p(0,300))
			self:runAction(moveTo)
		end
	elseif eventType == 1 then
		if gt.isIOSPlatform() then
			local moveTo = cc.MoveTo:create(0.5,cc.p(0,0))
			self:runAction(moveTo)
		end
	end
 end 

function ChatPanel:sendChatMsg(chatType, chatNick, chatString)
	chatNick = chatNick or 1
	chatString = chatString or ""

	local msgToSend = {}
	msgToSend.cmd = gt.SPEAKER
	msgToSend.type = chatType
	msgToSend.nick = chatNick
	msgToSend.msg = chatString
	gt.socketClient:sendMessage(msgToSend)
	cc.Director:getInstance():getOpenGLView():setIMEKeyboardState(false)
end

return ChatPanel


