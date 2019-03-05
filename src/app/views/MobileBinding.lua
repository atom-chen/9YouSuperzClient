local MobileBinding = class("MobileBinding", function()
	return gt.createMaskLayer()
end)

local gt = cc.exports.gt

function MobileBinding:ctor()
	-- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))

	local csbNode = cc.CSLoader:createNode("csd/MobileBinding.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.rootNode = csbNode
	
	self.panelBind = gt.seekNodeByName(csbNode, "node_bind")
	self.panelPsw = gt.seekNodeByName(csbNode, "node_password")
	self.panelShow = gt.seekNodeByName(csbNode, "node_show")
	self.resetPwdMode = false
	
	if gt.playerData.phone == nil or gt.playerData.phone == "" or gt.playerData.phone == 0 then
		self:initView(1)
	else
		self:initView(3)
	end
	
	--绑定界面
	self.verifyBtn = gt.seekNodeByName(self.panelBind, "Btn_identify")
	gt.addBtnPressedListener(self.verifyBtn, function()
		local number = gt.seekNodeByName(self.panelBind, "Img_number_Bg"):getChildByName("TextField_InputCode"):getString()
        self:sendMsgText(number)
    end)
	self.verifyCD = 60
	self.vertfyState = false
	self.vertfyText = self.verifyBtn:getChildByName("Text_2")
	
	self.bindBtn = gt.seekNodeByName(self.panelBind, "Btn_Bind")
	gt.addBtnPressedListener(self.bindBtn, function()
		local number = gt.seekNodeByName(self.panelBind, "Img_number_Bg"):getChildByName("TextField_InputCode"):getString()
		local code = gt.seekNodeByName(self.panelBind, "Img_identify_Bg"):getChildByName("TextField_InputCode"):getString()
        self:sendBinding(number, code)
    end)
	
	--密码界面
	self.btn_cfm = gt.seekNodeByName(self.panelPsw, "Btn_Confirm")
	gt.addBtnPressedListener(self.btn_cfm, function()
		local psw1 = gt.seekNodeByName(self.panelPsw, "Img_password_Bg"):getChildByName("TextField_InputCode"):getString()
		local psw2 = gt.seekNodeByName(self.panelPsw, "Img_passwordcfm_Bg"):getChildByName("TextField_InputCode"):getString()
		self:onConfirmPswClicked(psw1, psw2)
    end)
	
	--展示界面
	self.btn_mobile = gt.seekNodeByName(self.panelShow, "Btn_mobile")
	gt.addBtnPressedListener(self.btn_mobile, function()
		self:initView(1)
    end)
	
	self.btn_psw = gt.seekNodeByName(self.panelShow, "Btn_Psw")
	gt.addBtnPressedListener(self.btn_psw, function()
		self.resetPwdMode = true
		self:initView(1)
    end)		

	local btnClose = gt.seekNodeByName(csbNode, "Btn_Close")
	gt.addBtnPressedListener(btnClose, function()
		self:closeInterface()
    end)
	
	-- 注册消息回调
	gt.socketClient:registerMsgListener(gt.SET_LOGIN_PHONE_PWD, self, self.onPswSet)
	gt.socketClient:registerMsgListener(gt.BINDING_PHONE_NUM, self, self.onBindPhone)
end

function MobileBinding:initView(type)
	self.panelBind:setVisible(type == 1)
	self.panelPsw:setVisible(type == 2)
	self.panelShow:setVisible(type == 3)
	
	if type == 3 then
		gt.seekNodeByName(self.panelShow, "Img_number_bg"):getChildByName("Text"):setString(gt.playerData.phone)
	end
	
	if type == 1 then
		gt.seekNodeByName(self.panelBind, "Img_number_Bg"):getChildByName("TextField_InputCode"):setString("")
		gt.seekNodeByName(self.panelBind, "Img_identify_Bg"):getChildByName("TextField_InputCode"):setString("")
		if self.resetPwdMode == true then
			gt.seekNodeByName(self.panelBind, "Img_number_Bg"):getChildByName("TextField_InputCode"):setString(gt.playerData.phone)
		end
	end
	
	if type == 2 then
		gt.seekNodeByName(self.panelPsw, "Img_password_Bg"):getChildByName("TextField_InputCode"):setString("")
		gt.seekNodeByName(self.panelPsw, "Img_passwordcfm_Bg"):getChildByName("TextField_InputCode"):setString("")
	end
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

function MobileBinding:sendMsgText(number)
	if tonumber(number) == nil or string.len(number) ~= 11 then
		require("app/views/CommonTips"):create("请输入正确的手机号")
		return
	end
	local url = "http://ems.9you.com/vcode_qipai.php?client=MJHUNAN&mobile="..number.."&userIp="..gt.playerData.ip.."&vcode=test&type=KLMJ&action=1"
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
				require("app/views/CommonTips"):create("发送成功")
			elseif respJson.state == "01" or respJson.state == 1 then 
				self.verifyBtn:setEnabled(true)
				require("app/views/CommonTips"):create("无效的用户IP")
			end
		elseif xhr.readyState == 1 and xhr.status == 0 then
			-- 请求出错
			gt.log("发送短信验证码失败")
			self.verifyBtn:setEnabled(true)
		end
        xhr:unregisterScriptHandler()
    end )
    xhr:send()
	self.verifyBtn:setEnabled(false)
	self.verifyCD = 60
	self.vertfyState = true
end

function MobileBinding:update(delta)
	if self.vertfyState == true then
		self.vertfyText:setString("发送短信"..math.floor(self.verifyCD))
		self.verifyCD = self.verifyCD - delta
		if self.verifyCD <= 0 or self.verifyBtn:isEnabled() == true then
			self.vertfyState = false
			self.verifyBtn:setEnabled(true)
			self.vertfyText:setString("发送短信")
		end
	end
end

function MobileBinding:sendBinding(number, verifyCode)
	if tonumber(number) == nil or string.len(number) ~= 11 then
		require("app/views/CommonTips"):create("请输入正确的手机号")
		return
	end	
	if tonumber(verifyCode) == nil then
		require("app/views/CommonTips"):create("请输入验证码")
		return
	end
	if self.resetPwdMode == true then
		if number ~= gt.playerData.phone then
			require("app/views/CommonTips"):create("手机号不一致")
			return
		end
	end
	local url = "http://ems.9you.com/vcode_qipai.php?client=MJHUNAN&mobile="..number.."&userIp="..gt.playerData.ip.."&vcode="..verifyCode.."&type=KLMJ&action=2"
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
				require("app/views/CommonTips"):create("验证成功")
				self.verifyBtn:setEnabled(true)
				self.bindBtn:setEnabled(true)
				local msgToSend = {}
				if self.resetPwdMode == false then
					msgToSend.cmd = gt.BINDING_PHONE_NUM
					msgToSend.phone_num = number
					msgToSend.user_id = gt.playerData.uid
					gt.socketClient:sendMessage(msgToSend)
					gt.showLoadingTips("")
				else
					self:initView(2)
				end
			elseif respJson.state == "01" then
				self.bindBtn:setEnabled(true)
				require("app/views/CommonTips"):create("请输入正确的验证码")
			elseif respJson.state == "02" or respJson.state == 2 then 
				self.bindBtn:setEnabled(true)
				require("app/views/CommonTips"):create("验证码错误")
			end
		elseif xhr.readyState == 1 and xhr.status == 0 then
			-- 请求出错
			gt.log("绑定手机失败")
			self.bindBtn:setEnabled(true)
		end
        xhr:unregisterScriptHandler()
    end )
    xhr:send()
	self.bindBtn:setEnabled(false)
end

function MobileBinding:onConfirmPswClicked(psw1, psw2)
	if psw1 == "" or psw1 == nil then
		require("app/views/CommonTips"):create("密码不能为空")
		return
	end
	if psw1 ~= psw2 then
		require("app/views/CommonTips"):create("密码不一致")
		return
	end
	
	gt.showLoadingTips("")
	local msgToSend = {}
	msgToSend.cmd = gt.SET_LOGIN_PHONE_PWD
	msgToSend.user_id = gt.playerData.uid
	msgToSend.phone_num = gt.playerData.phone
	msgToSend.phone_pwd = gt.encodeBase64(tostring(psw1))
	gt.socketClient:sendMessage(msgToSend)
end

function MobileBinding:onBindPhone(msgTbl)
	if msgTbl.code == 0 then
		gt.playerData.phone = msgTbl.phone_num
		self:initView(2)
	elseif msgTbl.code == 1 then
		require("app/views/CommonTips"):create("绑定失败！")
	elseif msgTbl.code == 2 then
		require("app/views/CommonTips"):create("重复绑定！")
	elseif msgTbl.code == 3 then
		require("app/views/CommonTips"):create("绑定失败！")
	elseif msgTbl.code == 4 then
		require("app/views/CommonTips"):create("该手机已绑定过账号！")
	elseif msgTbl.code == 5 then
		require("app/views/CommonTips"):create("绑定失败！")
	end
	gt.removeLoadingTips()
end

function MobileBinding:onPswSet(msgTbl)
	if msgTbl.code == 0 then
		require("app/views/CommonTips"):create("密码设置成功")
		self:initView(3)
	else
		require("app/views/CommonTips"):create("密码设置失败，请重试")
		gt.seekNodeByName(self.panelPsw, "Img_password_Bg"):getChildByName("TextField_InputCode"):setString("")
		gt.seekNodeByName(self.panelPsw, "Img_passwordcfm_Bg"):getChildByName("TextField_InputCode"):setString("")
	end
	gt.removeLoadingTips()
end

function MobileBinding:onNodeEvent(eventName)
	if "enter" == eventName then
		self.scheduleHandler = gt.scheduler:scheduleScriptFunc(handler(self, self.update), 0.1, false)
		
	elseif "exit" == eventName then
		gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
		gt.socketClient:unregisterMsgListener(gt.SET_LOGIN_PHONE_PWD,self)
		gt.socketClient:unregisterMsgListener(gt.BINDING_PHONE_NUM,self)
	end
end

function MobileBinding:closeInterface()
	self:removeFromParent()
end

return MobileBinding