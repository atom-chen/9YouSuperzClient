--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local gt = cc.exports.gt

local MessageTips = class("MessageTips", function()
	return cc.Layer:create()
end)

function MessageTips:ctor(value, textFieldCode, diamond, money, rechargetype)
	self:registerScriptHandler(handler(self, self.onNodeEvent))

    local csbNode = cc.CSLoader:createNode("csd/MessageTips.csb")
    csbNode:setAnchorPoint(0.5,0.5)
    csbNode:setPosition(gt.winCenter)
    self:addChild(csbNode)

    local imgBg = gt.seekNodeByName(csbNode, "Img_Bg")
    local node1 = gt.seekNodeByName(csbNode, "Node_Invite")
    local node2 = gt.seekNodeByName(csbNode, "Node_Daichong")
    if value == 1 then
        --邀请码
        node2:setVisible(false)
        local tip = gt.seekNodeByName(node1, "Text_Tip")
        tip:setString( string.format("是否绑定%s邀请码，绑定后不可更改！", textFieldCode:getString()))
        local btnCancel = gt.seekNodeByName(node1, "Btn_Cancel")
        gt.addBtnPressedListener(btnCancel, function()
            self:removeFromParent()
        end)
        local btnOk = gt.seekNodeByName(node1, "Btn_OK")
        gt.addBtnPressedListener(btnOk, function()
            local proxy_code = tonumber(textFieldCode:getString()) or 0
			local msgToSend = {}
		    msgToSend.proxy_code = proxy_code
            msgToSend.cmd = gt.BINDING_PROXY_CODE
            msgToSend.user_id = gt.playerData.uid
		    gt.socketClient:sendMessage(msgToSend)
        end)
    else
        --代充
        node1:setVisible(false)
        local inputBg = gt.seekNodeByName(node2, "Img_Input_Bg")
        local inputContent = gt.seekNodeByName(inputBg, "TextField_Input_ID")
        local btnOk = gt.seekNodeByName(node2, "Btn_OK")
        gt.addBtnPressedListener(btnOk, function()
			local rechargeUserid = inputContent:getString()
			local nUserId = tonumber(rechargeUserid)
			if nUserId == nil or nUserId < 0 or tostring(nUserId) ~= rechargeUserid then
				require("app/views/NoticeTips"):create("提示",	"您输入的代充ID错误", nil, nil, true)
			else
				local verify = require("app/views/RechargeTips"):create(1, diamond, money, nUserId, rechargetype)
				self:getParent():addChild(verify)
				self:removeFromParent()
			end
        end)
    end

    local panel = gt.seekNodeByName(csbNode, "Panel_Bg")
    panel:addClickEventListener(function(sender)
		self:removeFromParent()
    end)
    -- 注册消息回调
	gt.socketClient:registerMsgListener(gt.BINDING_PROXY_CODE, self, self.onRcvBind)
end

function MessageTips:onNodeEvent(eventName)
	if "exit" == eventName then
		gt.socketClient:unregisterMsgListener(gt.BINDING_PROXY_CODE)
	end
end

function MessageTips:onRcvBind(msgTbl)
    if msgTbl.code == 0 then
        require("app/views/NoticeTips"):create("提示",	"邀请码绑定成功", nil, nil, true)
		gt.playerData.proxyCode = msgTbl.proxy_code
        gt.dispatchEvent(gt.EventType.CLOSE_INVITE)
    elseif msgTbl.code == 1 then
        require("app/views/NoticeTips"):create("提示",	"请先登录", nil, nil, true)
    else
        require("app/views/NoticeTips"):create("提示",	"该邀请码错误，请重新输入", nil, nil, true)
        self:removeFromParent()
    end
end

return MessageTips
--endregion
