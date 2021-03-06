local SetDebug = class("SetDebug", function()
	return cc.Layer:create()
end)

function SetDebug:ctor()
	local csbNode = cc.CSLoader:createNode("SetDebug.csb")
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)

	self.key = "SetTest_"

	self:loadCheckBox(csbNode)
	self:loadIP(csbNode)
	self:loadRobot(csbNode)
	self:loadTiaoPai(csbNode)
	self:loadAssets(csbNode)
	self:initOk(csbNode)
end

-- 设置结束回调
function SetDebug:setCallback(_callback)
	self.m_callback = _callback
end

-- 设置完成
function SetDebug:initOk(csbNode)
	local Button_ok = gt.seekNodeByName(csbNode, "Button_ok")
	gt.addBtnPressedListener(Button_ok, function()
		-- ip
		local TextField_IP = gt.seekNodeByName(csbNode, "TextField_IP")
		gt.debugInfo.ip = TextField_IP:getString()
		cc.UserDefault:getInstance():setStringForKey(self.key .. "IP", gt.debugInfo.ip)

		-- 端口
		local TextField_Port = gt.seekNodeByName(csbNode, "TextField_Port")
		gt.debugInfo.port = TextField_Port:getString()
		cc.UserDefault:getInstance():setStringForKey(self.key .. "Port", gt.debugInfo.port)

		-- 热更新地址
		local TextField_Assets = gt.seekNodeByName(csbNode, "TextField_Assets")
		gt.debugInfo.assets = TextField_Assets:getString()
		cc.UserDefault:getInstance():setStringForKey(self.key .. "Assets", gt.debugInfo.assets)

		-- 调牌数据
		local TextField_PaiXing = gt.seekNodeByName(csbNode, "TextField_PaiXing")
		gt.debugInfo.paixing = TextField_PaiXing:getString()
		cc.UserDefault:getInstance():setStringForKey(self.key .. "PaiXing", gt.debugInfo.paixing)

		-- 机器人数量
		local TextField_Count = gt.seekNodeByName(csbNode, "TextField_Count")
		gt.debugInfo.count = TextField_Count:getString()
		cc.UserDefault:getInstance():setStringForKey(self.key .. "Count", gt.debugInfo.count)

		cc.UserDefault:getInstance():flush()

		if self.m_callback and type(self.m_callback) == "function" then
			self.m_callback()
		end
		self:removeFromParent()
	end)
end

-- 读取热更地址设置
function SetDebug:loadAssets(csbNode)
	local TextField_Assets = gt.seekNodeByName(csbNode, "TextField_Assets")
	local data_assets = cc.UserDefault:getInstance():getStringForKey(self.key .. "Assets")
	if data_assets ~= "" then
		TextField_Assets:setString(data_assets)
	end
end

-- 读取ip设置
function SetDebug:loadIP(csbNode)
	local TextField_IP = gt.seekNodeByName(csbNode, "TextField_IP")
	local TextField_Port = gt.seekNodeByName(csbNode, "TextField_Port")
	local data_ip = cc.UserDefault:getInstance():getStringForKey(self.key .. "IP")
	local data_port = cc.UserDefault:getInstance():getStringForKey(self.key .. "Port")
	if data_ip ~= "" then
		TextField_IP:setString(data_ip)
	end
	if data_port ~= "" then
		TextField_Port:setString(data_port)
	end
end

-- 读取机器人设置
function SetDebug:loadRobot(csbNode)
	local TextField_Count = gt.seekNodeByName(csbNode, "TextField_Count")
	local data_count = cc.UserDefault:getInstance():getStringForKey(self.key .. "Count")
	if data_count ~= "" then
		TextField_Count:setString(data_count)
	end
end

-- 读取调牌设置
function SetDebug:loadTiaoPai(csbNode)
	local TextField_PaiXing = gt.seekNodeByName(csbNode, "TextField_PaiXing")
	local data_paixing = cc.UserDefault:getInstance():getStringForKey(self.key .. "PaiXing")
	if data_paixing ~= "" then
		TextField_PaiXing:setString(data_paixing)
	end
end

-- 读取开启选项
function SetDebug:loadCheckBox(csbNode)
	local list = {"YouKe", "Debug", "AppStore", "TiaoPai", "JQR", "Update", "YunDun"}
	for i, v in ipairs(list) do
		local checkbox = gt.seekNodeByName(csbNode, "CheckBox_" .. v)
		local data = cc.UserDefault:getInstance():getStringForKey(self.key .. v)
		checkbox:setSelected(false)
		gt.debugInfo[v] = false
		if data == "true" then
			checkbox:setSelected(true)
			gt.debugInfo[v] = true
		end
		local function checkboxEvent(sender, eventType)
			if eventType == ccui.CheckBoxEventType.selected then
				gt.debugInfo[v] = true
				cc.UserDefault:getInstance():setStringForKey(self.key .. v, "true")
			elseif eventType == ccui.CheckBoxEventType.unselected then
				gt.debugInfo[v] = false
				cc.UserDefault:getInstance():setStringForKey(self.key .. v, "false")
			end
		end
		checkbox:addEventListener(checkboxEvent)
	end
end

return SetDebug