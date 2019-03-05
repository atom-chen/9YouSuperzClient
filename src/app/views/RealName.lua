--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local gt = cc.exports.gt

local RealName = class("RealName", function()
	return gt.createMaskLayer()
end)

function RealName:ctor()
    local csbNode = cc.CSLoader:createNode("csd/RealName.csb")
    csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
    self:addChild(csbNode)
    self.rootNode = csbNode
    
    gt.socketClient:registerMsgListener(gt.USER_INFO, self, self.onRcvUserInfo)

    --关闭按钮
    local btnClose = gt.seekNodeByName(csbNode, "Btn_Close")
    gt.addBtnPressedListener(btnClose, function()
        gt.socketClient:unregisterMsgListener(gt.USER_INFO)
		self:removeFromParent()
	end)

    local textBoxName = gt.seekNodeByName(csbNode, "Img_InfoBgName")
    local textBoxID = gt.seekNodeByName(csbNode, "Img_InfoBgID")

    local textFieldName = gt.seekNodeByName(textBoxName, "Text_EnterName")
    local textFieldID = gt.seekNodeByName(textBoxID, "Text_EnterID")
    textFieldName:setPlaceHolderColor(cc.c3b(100,166,255))
    textFieldID:setPlaceHolderColor(cc.c3b(100,166,255))


--    textFieldName:addClickEventListener(function(sender)
--        textFieldName:setString(nil)
--        dump(textFieldID:getString())
--        if #textFieldID:getString() == 0 then
--            textFieldID:setString("请输入身份证号")
--        end
--    end)
--    textFieldID:addClickEventListener(function(sender)
--        textFieldID:setString(nil)
--        if #textFieldName:getString() == 0 then
--            textFieldName:setString("请输入姓名")
--        end
--    end)
    --确定按钮
    local btnOK = gt.seekNodeByName(csbNode, "Btn_OK")
    gt.addBtnPressedListener(btnOK, function()
		local msgToSend = {}
		msgToSend.nick = textFieldName:getString()
		msgToSend.open_id = textFieldID:getString()
        msgToSend.cmd = gt.USER_INFO
		--gt.socketClient:sendMessage(msgToSend)
        self:removeFromParent()
	end)


end

function RealName:onRcvUserInfo(msgTbl)
	if msgTbl.code == 0 then
        return
    else
        self:removeFromParent()
        require("app/views/NoticeTips"):create("提示", "信息出错，请重新输入", nil, nil, true)
    end
end

return RealName

--endregion
