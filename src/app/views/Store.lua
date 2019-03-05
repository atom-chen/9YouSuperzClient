--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local gt = cc.exports.gt

local Store = class("Store", function()
	return gt.createMaskLayer()
end)

function Store:ctor(isBindInvite)
	self:registerScriptHandler(handler(self, self.onNodeEvent))
    local csbNode = cc.CSLoader:createNode("csd/Store.csb")
    csbNode:setAnchorPoint(0.5, 0.5)
    csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
--    ccui.Helper:doLayout(csbNode)
    self:addChild(csbNode)
    self.rootNode = csbNode
	
	self.Panel_Items = gt.seekNodeByName(csbNode, "Panel_Items")
	local panelItemsSize = self.Panel_Items:getContentSize()
	panelItemsSize.width = panelItemsSize.width + (gt.winSize.width - 1280)
	panelItemsSize.height = panelItemsSize.height + (gt.winSize.height - 720)
	self.Panel_Items:setContentSize(panelItemsSize)	

	ccui.Helper:doLayout(csbNode)
	
	self.payMoney = 0
    self.isBindInvite = isBindInvite
    
	--充值按钮
	self.isDaichong = false
	local Image_RechargeSelect = gt.seekNodeByName(csbNode, "Image_RechargeSelect")
    local btnRecharge = gt.seekNodeByName(csbNode, "Btn_Recharge")
	gt.addBtnPressedListener(btnRecharge, function()
		self.isDaichong = false
		Image_RechargeSelect:loadTexture("image/newStore/btnReChargeForbidden.png")
		Image_RechargeSelect:stopAllActions()
		Image_RechargeSelect:runAction(cc.MoveTo:create(0.3, cc.p(-160, -15)))
	end)
	local btnDaichong = gt.seekNodeByName(csbNode, "Btn_Daichong")
	gt.addBtnPressedListener(btnDaichong, function()
		self.isDaichong = true
		Image_RechargeSelect:loadTexture("image/newStore/btnHelpReChargeForbidden.png")
		Image_RechargeSelect:stopAllActions()
		Image_RechargeSelect:runAction(cc.MoveTo:create(0.3, cc.p(160, -15)))
	end)


	--微信充值
    self.btnWeixinPay = gt.seekNodeByName(csbNode, "Button_WeixinPay")
    gt.addBtnPressedListener(self.btnWeixinPay, function()
        self.btnWeixinPay:setEnabled(false)
		self.btnAliPay:setEnabled(true)
		self.btnBankCardPay:setEnabled(true)
		self.payType = 1
    end)
	--支付宝充值
	self.btnAliPay = gt.seekNodeByName(csbNode, "Button_AliPay")
    gt.addBtnPressedListener(self.btnAliPay, function()
        self.btnWeixinPay:setEnabled(true)
		self.btnAliPay:setEnabled(false)
		self.btnBankCardPay:setEnabled(true)
        self.payType = 2
    end)
	--银行卡充值
	self.btnBankCardPay = gt.seekNodeByName(csbNode, "Button_BankCardpay")
    gt.addBtnPressedListener(self.btnBankCardPay, function()
        self.btnWeixinPay:setEnabled(true)
		self.btnAliPay:setEnabled(true)
		self.btnBankCardPay:setEnabled(false)
        self.payType = 3
    end)
	--默认微信支付
	self.payType = 1
	self.btnWeixinPay:setEnabled(false)
	self.btnAliPay:setEnabled(true)
	self.btnBankCardPay:setEnabled(true)
		
    --充值记录
    local btnRecord = gt.seekNodeByName(csbNode, "Btn_Record")
    gt.addBtnPressedListener(btnRecord, function()
        local record = require("app/views/RechargeRecord"):create(self.payType,self)
        self:addChild(record)
    end)

    --关闭
    local btnClose = gt.seekNodeByName(csbNode, "Btn_Close")
    gt.addBtnPressedListener(btnClose, function()
        self:removeFromParent()
    end)

    --充值
	local doubleActivity = false  -- 双倍活动
    for i = 1, 8 do
        local imgFrameBg = gt.seekNodeByName(csbNode, "Img_Frame_Bg" .. i)
		imgFrameBg:setVisible(false)
        local diamond = gt.seekNodeByName(imgFrameBg, "Text_Numbel")
        local money = gt.seekNodeByName(imgFrameBg, "Text_Money")
        local imgPreferential = gt.seekNodeByName(imgFrameBg, "Img_Preferential")
		if doubleActivity then
			imgPreferential:setVisible(false)
			local sp = cc.Sprite:create("image/store/double.png")
			sp:setPosition(238, 210)
			imgFrameBg:addChild(sp)
		end
    end
	if gt.isIOSReview() then
		gt.seekNodeByName(csbNode, "Node_Top_Center"):setVisible(false)
		btnRecord:setVisible(false)
		btnDaichong:setVisible(false)
		gt.seekNodeByName(csbNode,"TextHelp"):setVisible(false)
	else
		gt.seekNodeByName(csbNode,"TextHelp"):setVisible(false)
	end

	gt.socketClient:registerMsgListener(gt.PAY_ORDER, self, self.onRecvPayOrder)
    gt.socketClient:registerMsgListener(gt.PAY_GOODS, self, self.createStoreList)

	gt.registerEventListener(gt.EventType.IOS_IAP, self, self.OnIOSIAP)

	gt.showLoadingTips("")
	local msgToSend = {}
	msgToSend.cmd = gt.PAY_GOODS
	gt.socketClient:sendMessage(msgToSend)
end

function Store:OnIOSIAP(eventType,state,code,receipt)
gt.log(code)
	if state == "1" then --充值成功
		--发送到服务器
		local msgToSend = {}
		msgToSend.cmd = gt.IOS_PAY_ORDER
		msgToSend.user_id = gt.playerData.uid
		msgToSend.app_id = gt.app_id
		msgToSend.platform = "pmt"
		msgToSend["receipt-data"]=receipt
		msgToSend.chargeUser = gt.playerData.uid
		gt.socketClient:sendMessage(msgToSend)

        gt.showLoadingTips(code or "请稍后...")
        return

    elseif state == "2" then --充值过程
        gt.showLoadingTips(code or "请稍后...")
        return
    elseif state == "0" then --充值失败
        --todo...
	end
    gt.removeLoadingTips()
    require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), code or "支付失败，请稍后重试！", nil, nil, true)
end

function Store:onNodeEvent(eventName)
	if "enter" == eventName then
		gt.registerEventListener(gt.EventType.CREATE_PAY_ORDER, self, self.createPayOrder)
	elseif "exit" == eventName then
		gt.removeTargetAllEventListener(self)
	end
end

function Store:createPayOrder(eventType, chargeUser)
	-- 发送创建订单消息
	local msgToSend = {}
	msgToSend.cmd = gt.PAY_ORDER
	msgToSend.user_id = gt.playerData.uid
	msgToSend.app_id = gt.app_id
	msgToSend.platform = "pmt"
	msgToSend.payMoney = self.payMoney*100
	msgToSend.chargeUser = chargeUser
	msgToSend.pay_type = self.payType
	gt.socketClient:sendMessage(msgToSend)

	gt.showLoadingTips("")
end

function Store:onRecvPayOrder(msgTbl)
	gt.removeLoadingTips()
	if msgTbl.code == 0 then
		--local payUrl = "http://payment.xmsgl2017.com/payment.do"  -- 战斗牛
		--local payUrl = "http://payment.kuailuoqipai.com/payment.do" -- 快络牛牛，阿牛哥
		
		if 1 == self.payType and (2 == msgTbl.pay_type) then	
			if extension.isInstallWeiXin() then
				local pathStr = "pages/index/index?" .. "goodsDes=" .. self.diamondNumber .. "张房卡"
				for k, v in pairs(msgTbl) do
					if k ~= "code" and k ~= "cmd" and k ~= "pay_type" then
						pathStr = pathStr .. "&" .. k .. "=" .. v
					end
				end
				gt.log("-----test-----pathStr:"..pathStr)
				extension.CallWeChatApplet(pathStr)
			else
				require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0031"), nil, nil, true)
			end
		elseif 1 == self.payType and (3 == msgTbl.pay_type) then	
			if extension.isInstallWeiXin() then
				msgTbl.goodsDes = self.diamondNumber .. "张房卡"
				extension.openMiniProgram(msgTbl)
			else
				require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0031"), nil, nil, true)
			end
		else
			local payUrl = msgTbl.payUrl
			if payUrl then
				local urlParam = ""
				for k, v in pairs(msgTbl) do
					if k ~= "code" and k ~= "cmd" and k ~= "payUrl" then
						if urlParam == "" then
							urlParam = urlParam .. k .. "=" .. v
						else
							urlParam = urlParam .. "&" .. k .. "=" .. v
						end
					end
				end
				local url = payUrl .. "?" .. urlParam
				gt.log(url)
				cc.Application:getInstance():openURL(url)
				self:removeFromParent()
			else
				gt.log("----no payurl")
			end
		end
	
	else
		local errorMsg = ""
		if msgTbl.code == 1 then
			errorMsg = gt.getLocationString("LTKey_0058")
		elseif msgTbl.code == 2 then
			errorMsg = "未绑定代理"
		elseif msgTbl.code == 3 then
			errorMsg = "订单生成失败"
		elseif msgTbl.code == 4 then
			errorMsg = "游戏ID不正确"
		elseif msgTbl.code == 5 then
			errorMsg = "没有该金额对应商品"
		end
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), errorMsg, nil, nil, true)
	end
end

function Store:createStoreList(msgTbl)
	gt.removeLoadingTips()

    self.cardArrary = {}
    self.couponArray = {}
    for k, v in pairs(msgTbl.goods) do
		v.money = math.floor(k / 100)
        if v.genre == 0 then
            table.insert(self.cardArrary, v)
        else
			--苹果IAP中没有5块钱跟10块钱的价格选项
			--新增6块12块的在苹果审核中显示 正式版不显示6块跟12块的
			if gt.isIOSReview() then
				if v.money==6 or v.money==12 then
					table.insert(self.couponArray, v)
				end
			else
				if v.money~=6 and v.money~=12 then
					table.insert(self.couponArray, v)
				end
			end
        end
    end
	if #self.cardArrary + #self.couponArray <= 0 then
		return
	end
    table.sort(self.cardArrary,function (a,b) return a.card < b.card end)
    table.sort(self.couponArray,function (a,b) return a.card < b.card end)
    for i = 1, 8 do
        local imgFrameBg = gt.seekNodeByName(self.rootNode, "Img_Frame_Bg" .. i)
        local diamond = gt.seekNodeByName(imgFrameBg, "TA_CardNum")
        local money = gt.seekNodeByName(imgFrameBg, "TA_RechargeNum")
        local imgPreferential = gt.seekNodeByName(imgFrameBg, "Img_Preferential")
        imgPreferential:setVisible(false)
        if i <= #self.cardArrary then
			imgFrameBg:setVisible(true)
            if self.isBindInvite then
                imgPreferential:setVisible(true)
                if imgPreferential:getChildByName("TA_GiveNum") then
	                imgPreferential:getChildByName("TA_GiveNum"):setString(self.cardArrary[i].donate)
	            end
            end
            diamond:setString(tostring(self.cardArrary[i].card))
            money:setString(tostring(self.cardArrary[i].money))
        else
			local idx = i - #self.cardArrary
			if idx > 0 and self.couponArray[idx] then
	            diamond:setString(tostring(self.couponArray[idx].card))
	            money:setString(tostring(self.couponArray[idx].money))
				imgFrameBg:setEnabled(gt.openSport)
			end
			imgFrameBg:setVisible(false)
        end

		imgFrameBg:addClickEventListener(function(sender)
			--苹果审核走IAP
			if gt.isIOSReview() then
				if gt.IAPItem[i] then
					extension.IOSPay(gt.IAPItem[i])
					gt.showLoadingTips("请求支付中...")
				end
			else
				self.payMoney =  tonumber(money:getString())
				self.diamondNumber =  tonumber(diamond:getString())
				local rechargeType
				if i <= #self.cardArrary then
					rechargeType = 0
				else
					rechargeType = 1
				end
				if self.isDaichong then
					--代充
					local daichongTip = require("app/views/MessageTips"):create(2, nil, diamond:getString(), money:getString(), rechargeType)
					self:addChild(daichongTip)
				else
                    --自己充
					gt.dispatchEvent(gt.EventType.CREATE_PAY_ORDER, gt.playerData.uid)
				end
			end
        end)
    end
end

return Store

