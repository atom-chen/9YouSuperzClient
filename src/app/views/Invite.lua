--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local gt = cc.exports.gt

local Invite = class("Invite", function()
	return gt.createMaskLayer()
end)

function Invite:ctor(isBinded)
    local csbNode = cc.CSLoader:createNode("csd/Invite.csb")
    csbNode:setAnchorPoint(0.5, 0.5)
    csbNode:setPosition(gt.winCenter)
    self:addChild(csbNode)
    
    local unbounded = gt.seekNodeByName(csbNode, "Node_Unbounded")
    local binded = gt.seekNodeByName(csbNode, "Node_Binded")

    --关闭按钮
    local btn_Close = gt.seekNodeByName(csbNode, "Btn_Close")
    gt.addBtnPressedListener(btn_Close, function()
        self:closeInterface()
    end)
    local textFieldCode = gt.seekNodeByName(csbNode, "TextField_Code")
    textFieldCode:setPlaceHolderColor(cc.c3b(100,166,255))

    local lbAwardTip = gt.seekNodeByName(unbounded, "lbAwardTip")
    lbAwardTip:setString(string.format("请输入邀请码，绑定成功后赠送%d张房卡", gt.playerData.bind_reward))

    if isBinded == false then
        binded:setVisible(false)
        --确定按钮
        local btnOK = gt.seekNodeByName(csbNode, "Btn_OK")
        gt.addBtnPressedListener(btnOK, function()
            if #textFieldCode:getString() == 0 then
                require("app/views/NoticeTips"):create("提示", "邀请码不能为空", nil, nil, true)
            else
                local tip = require("app/views/MessageTips"):create(1,textFieldCode)
                self:addChild(tip)
            end
	    end)
    else
        unbounded:setVisible(false)
        local textBinded = gt.seekNodeByName(binded, "Text_Binded")
        local tip = string.format("已绑定邀请码：%s", gt.playerData.proxyCode)
        textBinded:setString(tip)
        --确定按钮
        local btnOK = gt.seekNodeByName(csbNode, "Btn_OK")
        gt.addBtnPressedListener(btnOK, function(sender)
            self:closeInterface()
        end)
    end
    gt.registerEventListener(gt.EventType.CLOSE_INVITE, self, self.closeInterface)
end

function Invite:closeInterface()
	gt.removeTargetEventListenerByType(self, gt.EventType.CLOSE_INVITE)
    self:removeFromParent()
end

return Invite
--endregion
