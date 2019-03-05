--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local gt = cc.exports.gt

local RechargeRecord = class("RechargeRecord", function()
	return gt.createMaskLayer()
end)

function RechargeRecord:ctor(payType, parent)
    local csbNode = cc.CSLoader:createNode("csd/RechargeHistory.csb")
    csbNode:setAnchorPoint(0.5, 0.5)
    csbNode:setPosition(gt.winCenter)
    self:addChild(csbNode)

	self.payType = payType
	self.parent = parent or nil
	
    --不显示充值历史
    self.emptyInfo = gt.seekNodeByName(csbNode, "Text_Info")
    self.emptyInfo:setVisible(false)
    self.historyListVw = gt.seekNodeByName(csbNode, "ListView_Record")
    self.pTemplate = self.historyListVw:getChildByName("Panel_Template")
	self.pTemplate:retain()
	self.historyListVw:removeAllChildren()

	--记录类型切换
	local Image_RechargeSelect = gt.seekNodeByName(csbNode, "Image_RechargeSelect")
    local btnRecharge = gt.seekNodeByName(csbNode, "Btn_Recharge")
	local btnDaichong = gt.seekNodeByName(csbNode, "Btn_Daichong")
	gt.addBtnPressedListener(btnRecharge, function()
		Image_RechargeSelect:loadTexture("image/newStore/RechargeHistory/btnReChargeForbidden.png")
		Image_RechargeSelect:stopAllActions()
		Image_RechargeSelect:runAction(cc.MoveTo:create(0.3, cc.p(-126, 0)))
		
		btnRecharge:setEnabled(false)
		btnDaichong:setEnabled(true)
		
		local msgToSend = {}
		msgToSend.cmd = gt.RECHARGE_INFO
		msgToSend.user_id = gt.playerData.uid
		msgToSend.is_for_other = 0
		gt.socketClient:sendMessage(msgToSend)
	end)
	gt.addBtnPressedListener(btnDaichong, function()
		Image_RechargeSelect:loadTexture("image/newStore/RechargeHistory/btnHelpReChargeForbidden.png")
		Image_RechargeSelect:stopAllActions()
		Image_RechargeSelect:runAction(cc.MoveTo:create(0.3, cc.p(126, 0)))
		
		btnRecharge:setEnabled(true)
		btnDaichong:setEnabled(false)
		
		local msgToSend = {}
		msgToSend.cmd = gt.RECHARGE_INFO
		msgToSend.user_id = gt.playerData.uid
		msgToSend.is_for_other = 1
		gt.socketClient:sendMessage(msgToSend)
	end)
	
    -- 关闭按钮
	local closeBtn = gt.seekNodeByName(csbNode, "Btn_Close")
	gt.addBtnPressedListener(closeBtn, function()
	    self.historyListVw:removeAllChildren()
        --移除消息回调
        gt.socketClient:unregisterMsgListener(gt.RECHARGE_INFO)
		-- 移除界面,返回主界面
		self:removeFromParent()
	end)

    --发送请求记录消息
    local msgToSend = {}
    msgToSend.cmd = gt.RECHARGE_INFO
    msgToSend.user_id = gt.playerData.uid
	msgToSend.is_for_other = 0
    gt.socketClient:sendMessage(msgToSend)

    --注册消息回调
    gt.socketClient:registerMsgListener(gt.RECHARGE_INFO, self, self.onRcvRechargeRecord)
end

function RechargeRecord:onRcvRechargeRecord(msgTbl)
	self.historyListVw:removeAllChildren()
    if msgTbl.code == 0 then
        if #msgTbl.records == 0 then
            self.emptyInfo:setVisible(true)
        else
            -- 显示充值历史列表
            for i, cellData in ipairs(msgTbl.records) do
                local historyItem = self:createRecordItem(i, cellData)
                self.historyListVw:pushBackCustomItem(historyItem)
            end
        end
    elseif msgTbl.code == 1 then
        require("app/views/NoticeTips"):create("提示",	"请先登录", nil, nil, true)
    end
end

function RechargeRecord:createRecordItem(tag, cellData)
    local item = self.pTemplate:clone()

	if cellData.pay_target == gt.playerData.uid then
		item:getChildByName("Image_helpReChargeFlag"):setVisible(false)
	end
    --充值ID
    item:getChildByName("Text_ID_Value"):setString(tostring(cellData.pay_target))
    --充值数量
    item:getChildByName("Text_Amount_Value"):setString(tostring(cellData.room_card))
    --金额
    item:getChildByName("Text_Money_Value"):setString(tostring(cellData.money))
    --邀请码
    item:getChildByName("Text_Recharge_Value"):setString(tostring(cellData.proxy_code))
    --时间
    item:getChildByName("Text_Time_Value"):setString(cellData.time)

	local btnAgainPay = item:getChildByName("Button_AgainPay")
	gt.addBtnPressedListener(btnAgainPay, function()
		local msgToSend = {}
		msgToSend.cmd = gt.PAY_ORDER
		msgToSend.user_id = gt.playerData.uid
		msgToSend.app_id = gt.app_id
		msgToSend.platform = "pmt"
		msgToSend.payMoney = cellData.money * 100
		msgToSend.chargeUser = cellData.pay_target
		msgToSend.pay_type = self.payType
		gt.socketClient:sendMessage(msgToSend)
		
		if self.parent then
			self.parent.diamondNumber = cellData.room_card
		end
		self:removeFromParent()
	end)
	
    return item
end

return RechargeRecord
--endregion
