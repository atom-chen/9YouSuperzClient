
local gt = cc.exports.gt

local JoinRoom = class("JoinRoom", function()
	return gt.createMaskLayer()
end)

function JoinRoom:ctor()
	local csbNode = cc.CSLoader:createNode("csd/JoinRoom.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode

	self.textInputNumber = gt.seekNodeByName(csbNode, "Text_InputNumber")
	self.textInputNumber:setString("")
	
	local function getInputNumber()
		local inputString, bitNumber = string.gsub(self.textInputNumber:getString(), " ", "");
		local inputNumber = tonumber(inputString) or 0
		if 0 < inputNumber then
			bitNumber = bitNumber + 1
		end
		return inputNumber, bitNumber
	end
	
	local function setInputString(inputNumber)
		if nil == inputNumber then
			self.textInputNumber:setString("")
		else
			local inputString = ""
			while 9 < inputNumber do
				local remainderNumber = math.mod(inputNumber, 10)
				inputNumber = math.modf(inputNumber/10)
				inputString = " "..tostring(remainderNumber)..inputString
			end
			inputString = tostring(inputNumber)..inputString
			self.textInputNumber:setString(inputString)
		end
	end
	
	local function sendJoinRoomMsg(inputNumber)
		-- 发送进入房间消息 
		local msgToSend = {}
		msgToSend.cmd = gt.JOIN_ROOM
		msgToSend.room_id = inputNumber
		msgToSend.app_id = gt.app_id
		msgToSend.user_id = gt.playerData.uid
		msgToSend.ver = gt.version
		msgToSend.dev_id = gt.getDeviceId()

		gt.socketClient:sendMessage(msgToSend)
	end
	
	local function onNumber(sender)
		gt.soundEngine:playEffect(gt.clickBtnAudio, false)
		local inputNumber = getInputNumber()
		inputNumber = inputNumber* 10 + sender:getTag()
		setInputString(inputNumber)
		local inputNumber1, bitNumber = getInputNumber()
		if 8 == bitNumber then
			sendJoinRoomMsg(inputNumber)
		end
	end
	for i = 0, 9 do
		local btn = gt.seekNodeByName(csbNode, "Btn_Number"..tostring(i))
		btn:addClickEventListener(onNumber)
	end
	
	local btnReset = gt.seekNodeByName(csbNode, "Btn_Reset")
	gt.addBtnPressedListener(btnReset, function()
		setInputString(nil)
	end)

	local btnDelete = gt.seekNodeByName(csbNode, "Btn_Delete")
	gt.addBtnPressedListener(btnDelete, function()
		local inputNumber = getInputNumber()
		if 10 > inputNumber then
			setInputString(nil)
		else
			inputNumber = math.modf(inputNumber/10)
			setInputString(inputNumber)
		end
	end)
	
	local btnEnter = gt.seekNodeByName(csbNode, "Btn_Enter")
	gt.addBtnPressedListener(btnEnter, function()
		local inputNumber, bitNumber = getInputNumber()
		if 6 == bitNumber then
			sendJoinRoomMsg(inputNumber)
		end
	end)
	
--[[	-- 最大输入6个数字
	self.inputMaxCount = 6
	-- 数字文本
	self.inputNumLabels = {}
	self.curInputIdx = 1
	for i = 1, self.inputMaxCount do
		local numLabel = gt.seekNodeByName(csbNode, "Label_Num_" .. i)
		numLabel:setString("")
		self.inputNumLabels[i] = numLabel
	end

	-- 数字按键
	for i = 0, 9 do
		local numBtn = gt.seekNodeByName(csbNode, "Btn_Number" .. i)  --遍历数字按键
		gt.log("----- numBtn-------",i,numBtn)
		numBtn:setTag(i)  --设置标记为0-9
		numBtn:addClickEventListener(handler(self, self.numBtnPressed))  --添加点击事件
	end

	-- 重置按键
	local resetBtn = gt.seekNodeByName(csbNode, "Btn_Reset")
	resetBtn:addClickEventListener(handler(self, self.resetPressed))


   -- 删除按键
	local delBtn = gt.seekNodeByName(csbNode, "Btn_Delete")
	delBtn:addClickEventListener(handler(self, self.delPressed))--]]

	-- 关闭按键
	local closeBtn = gt.seekNodeByName(csbNode, "Btn_Close")
	gt.addBtnPressedListener(closeBtn, function()
		self:removeFromParent()
	end)

	gt.socketClient:registerMsgListener(gt.JOIN_ROOM, self, self.onRcvJoinRoom)
end

--[[function JoinRoom:resetPressed( senderBtn )
	gt.soundEngine:playEffect(gt.clickBtnAudio, false)
	for i = self.inputMaxCount, 1 , -1 do
		local numLabel = gt.seekNodeByName(self.csbNode, "Label_Num_" .. i)
		numLabel:setString("")
	end
	self.curInputIdx = 1  --光标设置在第一位
end

function JoinRoom:delPressed( senderBtn )
	gt.soundEngine:playEffect(gt.clickBtnAudio, false)
	for i = self.curInputIdx - 1, 1 , -1 do	
		if self.curInputIdx - 1  >= 1 then
			local numLabel = gt.seekNodeByName(self.csbNode, "Label_Num_" .. i)
			numLabel:setString("")
			self.curInputIdx = self.curInputIdx - 1
		end
		break
	end
end--]]

--[[function JoinRoom:numBtnPressed(senderBtn)
	gt.log("00---------------senderBtnsenderBtnsenderBtn")
    gt.soundEngine:playEffect(gt.clickBtnAudio, false)
	local btnTag = senderBtn:getTag()
	local numLabel = self.inputNumLabels[self.curInputIdx]
	--某下情况下(可能是机子卡)self.curInputIdx为7的时候进入到这里 这个时候应该是输入了房间号等待返回
	if not numLabel then
		return
	end
	numLabel:setString(tostring(btnTag))
	if self.curInputIdx >= #self.inputNumLabels then
		local roomID = 0
		local tmpAry = {100000, 10000, 1000, 100, 10, 1}
		for i = 1, self.inputMaxCount do
			local inputNum = tonumber(self.inputNumLabels[i]:getString())
			roomID = roomID + inputNum * tmpAry[i]
		end
		-- 发送进入房间消息
		local msgToSend = {}
		msgToSend.cmd = gt.JOIN_ROOM
		msgToSend.room_id = roomID
		msgToSend.app_id = gt.app_id
		msgToSend.user_id = gt.playerData.uid
		msgToSend.ver = gt.version
		msgToSend.dev_id = gt.getDeviceId()

		gt.socketClient:sendMessage(msgToSend)

		gt.showLoadingTips(gt.getLocationString("LTKey_0006"))
	end
	self.curInputIdx = self.curInputIdx + 1
end--]]

function JoinRoom:onRcvJoinRoom(msgTbl)
	if msgTbl.code ~= 0 then
		-- 进入房间失败
		gt.removeLoadingTips()
		-- 1：未登录 2：服务器维护中 3：房卡不足 4：人数已满 5：房间不存在 6：中途不能加入
		local errorMsg = ""
		if msgTbl.code == 1 then
			errorMsg = gt.getLocationString("LTKey_0058")
		elseif msgTbl.code == 2 then
			errorMsg = gt.getLocationString("LTKey_0054")
		elseif msgTbl.code == 3 then
			errorMsg = gt.getLocationString("LTKey_0049")
		elseif msgTbl.code == 4 then
			errorMsg = gt.getLocationString("LTKey_0018")
		elseif msgTbl.code == 5 then
			errorMsg = gt.getLocationString("LTKey_0015")
        elseif msgTbl.code == 6 then
			errorMsg = gt.getLocationString("LTKey_0057")
		elseif msgTbl.code == 7 then
			errorMsg = gt.getLocationString("LTKey_0065")
		elseif msgTbl.code == 8 then
			errorMsg = gt.getLocationString("LTKey_0067")
		elseif msgTbl.code == 9 then
			errorMsg = gt.getLocationString("LTKey_0069")
		end
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), errorMsg, nil, nil, true)

--[[		self.curInputIdx = 1
		for i = 1, self.inputMaxCount do
			local numLabel = self.inputNumLabels[i]
			numLabel:setString("")
		end--]]
		self.textInputNumber:setString("")
	end
end

return JoinRoom

