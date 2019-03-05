local MobileLogin = class("MobileLogin", function()
	return gt.createMaskLayer()
end)

local gt = cc.exports.gt

function MobileLogin:ctor(isAuto)
	-- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))

	local csbNode = cc.CSLoader:createNode("csd/MobileLogin.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.rootNode = csbNode
	self.isAuto = isAuto or 0

	self.panelLogin = gt.seekNodeByName(csbNode, "node_login")
	self.panelFind = gt.seekNodeByName(csbNode, "node_rebind")
	self.panelReset = gt.seekNodeByName(csbNode, "node_resetPsw")
	require("socket")
	self.ip = socket.dns.toip(socket.dns.gethostname())
	self:initView(1)
	
	--登录界面
	self.loginBtn = gt.seekNodeByName(self.panelLogin, "Btn_login")
	gt.addBtnPressedListener(self.loginBtn, function()
		local number = gt.seekNodeByName(self.panelLogin, "Img_number_Bg"):getChildByName("TextField_InputCode"):getString()
		local psw = gt.seekNodeByName(self.panelLogin, "Img_psw_Bg"):getChildByName("TextField_InputCode"):getString()
		local encodePsw = gt.encodeBase64(tostring(psw))
        self:onLogin(number, encodePsw)
    end)
	
	self.forgetPsw = gt.seekNodeByName(self.panelLogin, "forget_psw")
	self.forgetPsw:addTouchEventListener(function(sender)
		self:initView(2)
    end)
	
	--找回界面
	self.btn_cfm = gt.seekNodeByName(self.panelFind, "Btn_cfm")
	gt.addBtnPressedListener(self.btn_cfm, function()
		local number = gt.seekNodeByName(self.panelFind, "Img_number_Bg"):getChildByName("TextField_InputCode"):getString()
		local code = gt.seekNodeByName(self.panelFind, "Img_code_Bg"):getChildByName("TextField_InputCode"):getString()
		self:sendBinding(number, code)
    end)
	
	self.btn_send = gt.seekNodeByName(self.panelFind, "Btn_send")
	gt.addBtnPressedListener(self.btn_send, function()
		local number = gt.seekNodeByName(self.panelFind, "Img_number_Bg"):getChildByName("TextField_InputCode"):getString()
		self:sendMsgText(number)
    end)
	self.verifyCD = 60
	self.vertfyState = false
	self.vertfyText = self.btn_send:getChildByName("Text_1")
	
	self.phoneNum = ""
	
	--重置界面
	self.btn_reset = gt.seekNodeByName(self.panelReset, "Btn_cfm")
	gt.addBtnPressedListener(self.btn_reset, function()
		local psw1 = gt.seekNodeByName(self.panelReset, "Img_psw_Bg"):getChildByName("TextField_InputCode"):getString()
		local psw2 = gt.seekNodeByName(self.panelReset, "Img_pswcfm_Bg"):getChildByName("TextField_InputCode"):getString()
		self:onConfirmPswClicked(psw1, psw2)
    end)		

	local btnClose = gt.seekNodeByName(csbNode, "Btn_Close")
	gt.addBtnPressedListener(btnClose, function()
		self:closeInterface()
    end)
	
	-- 注册消息回调
	gt.socketClient:registerMsgListener(gt.SET_LOGIN_PHONE_PWD, self, self.onPswSet)
	gt.socketClient:registerMsgListener(gt.CAN_SET_PHONE_PWD, self, self.onCheckPhone)

	local number = cc.UserDefault:getInstance():getStringForKey( "Login_Mobile_Phone","")
	gt.seekNodeByName(self.panelLogin, "Img_number_Bg"):getChildByName("TextField_InputCode"):setString(number)
	if self.isAuto == 1 then
     	local delay_call = function ()
	    	local psw = cc.UserDefault:getInstance():getStringForKey( "Login_Mobile_Psw","")
			gt.seekNodeByName(self.panelLogin, "Img_psw_Bg"):getChildByName("TextField_InputCode"):setString("******")
	        self:onLogin(number, psw)
	    end
	    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
	end
end

function MobileLogin:initView(type)
	self.panelLogin:setVisible(type == 1)	
	self.panelFind:setVisible(type == 2)
	self.panelReset:setVisible(type == 3)
end

local function convertString(str)
	local newStr = ""
	for i = 1, string.len(str) do
		local curChar = string.sub(str,i,i)
		if curChar == [[\]] then
			newStr = newStr .. [[\\]]
		else
			newStr = newStr .. curChar
		end
	end
	return newStr
end

function MobileLogin:onLogin(phone, psw)
	if phone == "" or phone == nil then
		require("app/views/NoticeTips"):create("提  示", "请输入手机号", nil, nil, true)
		return
	end
	if tonumber(phone) == nil or string.len(phone) ~= 11 then
		require("app/views/NoticeTips"):create("提  示","请输入正确的手机号", nil, nil, true)
		return
	end
	-- if self.isAuto ~= 1 then
		cc.UserDefault:getInstance():setStringForKey( "Login_Mobile_Phone",phone)
		cc.UserDefault:getInstance():setStringForKey( "Login_Mobile_Psw",psw)
	-- end
    gt.showLoadingTips(gt.getLocationString("LTKey_0003"))
    
	gt.socketClient:connect(gt.LoginServer.ip, gt.LoginServer.port, true)
	local msgToSend = {}
	msgToSend.cmd = gt.LOGIN
	msgToSend.logon_type = 1--手机登录
	msgToSend.phone_num = phone
	msgToSend.phone_pwd = psw
	msgToSend.ver = gt.version
	msgToSend.plate = "phoneNum"
	local checkStr1 = msgToSend.phone_num..msgToSend.phone_pwd..msgToSend.plate..msgToSend.ver.."#klqp"
	msgToSend.c1 = gt.CRC(checkStr1, string.len(checkStr1))
	gt.socketClient:sendMessage(msgToSend)

	-- self:closeInterface()
end

function MobileLogin:onPswSet(msgTbl)
	if msgTbl.code == 0 then
		require("app/views/NoticeTips"):create("提  示", "密码设置成功！", nil, nil, true)
		self:initView(1)
	else
		require("app/views/NoticeTips"):create("提  示", "密码设置失败，请重试", nil, nil, true)
		gt.seekNodeByName(self.panelReset, "Img_psw_Bg"):getChildByName("TextField_InputCode"):setString("")
		gt.seekNodeByName(self.panelReset, "Img_pswcfm_Bg"):getChildByName("TextField_InputCode"):setString("")
	end
	gt.removeLoadingTips()
end

function MobileLogin:onCheckPhone(msgTbl)
	if msgTbl.code == 0 then
		self:initView(3)
	elseif msgTbl.code == 1 then
		require("app/views/NoticeTips"):create("提  示", "该手机号尚未绑定!", nil, nil, true)
	else
		require("app/views/NoticeTips"):create("提  示", "手机号检测出错!", nil, nil, true)
	end
	gt.removeLoadingTips()
end

function MobileLogin:sendMsgText(number)
	if tonumber(number) == nil or string.len(number) ~= 11 then
		require("app/views/NoticeTips"):create("提  示","请输入正确的手机号", nil, nil, true)
		return
	end
	local url = "http://ems.9you.com/vcode_qipai.php?client=MJHUNAN&mobile="..number.."&userIp="..self.ip.."&vcode=test&type=KLMJ&action=1"
	local xhr = cc.XMLHttpRequest:new()
    xhr.timeout = 30
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    xhr:open("GET", url)
    xhr:registerScriptHandler( function ()
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
			local response = xhr.response
			gt.log(response)
			require("json")
			response = convertString(response)
			local respJson = json.decode(response)
			if respJson.state == "00" or respJson.state == 0 then 
			require("app/views/NoticeTips"):create("提  示", "发送成功", nil, nil, true)
			elseif respJson.state == "01" or respJson.state == 1 then 
				self.btn_send:setEnabled(true)
			require("app/views/NoticeTips"):create("提  示", "无效的用户IP！", nil, nil, true)
			end
		elseif xhr.readyState == 1 and xhr.status == 0 then
			-- 请求出错
			gt.log("发送短信验证码失败")
			self.btn_send:setEnabled(true)
		end
        xhr:unregisterScriptHandler()
    end )
    xhr:send()
	self.btn_send:setEnabled(false)
	self.verifyCD = 60
	self.vertfyState = true
end

function MobileLogin:update(delta)
	if self.vertfyState == true then
		self.vertfyText:setString("发送短信"..math.floor(self.verifyCD))
		self.verifyCD = self.verifyCD - delta
		if self.verifyCD <= 0 or self.btn_send:isEnabled() == true then
			self.vertfyState = false
			self.btn_send:setEnabled(true)
			self.vertfyText:setString("发送短信")
		end
	end
end

function MobileLogin:sendBinding(number, verifyCode)
	if tonumber(number) == nil or string.len(number) ~= 11 then
		require("app/views/NoticeTips"):create("提  示","请输入正确的手机号", nil, nil, true)
		return
	end
	local url = "http://ems.9you.com/vcode_qipai.php?client=MJHUNAN&mobile="..number.."&userIp="..self.ip.."&vcode="..verifyCode.."&type=KLMJ&action=2"
	local xhr = cc.XMLHttpRequest:new()
    xhr.timeout = 30
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    xhr:open("GET", url)
    xhr:registerScriptHandler( function ()
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
			local response = xhr.response
			gt.log(response)
			require("json")
			response = convertString(response)
			local respJson = json.decode(response)
			if respJson.state == "00" or respJson.state == 0 then 
				require("app/views/NoticeTips"):create("提  示", "验证成功", nil, nil, true)
				gt.playerData.phone = number
				self.btn_send:setEnabled(true)
				self.btn_reset:setEnabled(true)
				self.phoneNum = number
				gt.showLoadingTips("")
				gt.socketClient:connect(gt.LoginServer.ip, gt.LoginServer.port, true)
				local msgToSend = {}
				msgToSend.cmd = gt.CAN_SET_PHONE_PWD
				msgToSend.phone_num = number
				gt.socketClient:sendMessage(msgToSend)
				--self:initView(3)
			elseif respJson.state == "02" or respJson.state == 2 then 
				self.btn_reset:setEnabled(true)
				require("app/views/NoticeTips"):create("提  示", "验证码错误", nil, nil, true)
			end
		elseif xhr.readyState == 1 and xhr.status == 0 then
			-- 请求出错
			gt.log("绑定手机失败")
			self.btn_reset:setEnabled(true)
		end
        xhr:unregisterScriptHandler()
    end )
    xhr:send()
	self.btn_reset:setEnabled(false)
end

function MobileLogin:onConfirmPswClicked(psw1, psw2)
	if psw1 == "" or psw1 == nil then
		require("app/views/NoticeTips"):create("提  示", "密码不能为空", nil, nil, true)
		return
	end
	if psw1 ~= psw2 then
		require("app/views/NoticeTips"):create("提  示", "密码不一致", nil, nil, true)
		return
	end
	
	gt.showLoadingTips("")
	gt.socketClient:connect(gt.LoginServer.ip, gt.LoginServer.port, true)
	local msgToSend = {}
	msgToSend.cmd = gt.SET_LOGIN_PHONE_PWD
	--msgToSend.user_id = gt.playerData.uid
	msgToSend.phone_num = self.phoneNum
	msgToSend.phone_pwd = gt.encodeBase64(tostring(psw1))
	gt.socketClient:sendMessage(msgToSend)
end

function MobileLogin:onNodeEvent(eventName)
	if "enter" == eventName then
		self.scheduleHandler = gt.scheduler:scheduleScriptFunc(handler(self, self.update), 0.1, false)
		
	elseif "exit" == eventName then
		gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
		gt.socketClient:unregisterMsgListener(gt.SET_LOGIN_PHONE_PWD,self)
		gt.socketClient:unregisterMsgListener(gt.CAN_SET_PHONE_PWD,self)
	end
end

function MobileLogin:closeInterface()
	self:removeFromParent()
end

return MobileLogin