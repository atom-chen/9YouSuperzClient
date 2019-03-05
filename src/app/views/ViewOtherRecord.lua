
local gt = cc.exports.gt

local ViewOtherRecord = class("ViewOtherRecord", function()
	return gt.createMaskLayer()
end)

function ViewOtherRecord:ctor(parent)
	self.parent = parent

	local csbNode = cc.CSLoader:createNode("ViewOtherRecord.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.rootNode = csbNode

	self.textField_code = gt.seekNodeByName(self.rootNode, "TxtField_code")
	self.textField_code:setPlaceHolder("请输入他人分享的回放码")

	-- 取消按钮
	local cancelBtn = gt.seekNodeByName(self.rootNode, "Btn_cancel")
	gt.addBtnPressedListener(cancelBtn, function()
		self:destroy()
	end)

	-- 确定按钮
	local okBtn = gt.seekNodeByName(self.rootNode, "Btn_ok")
	gt.addBtnPressedListener(okBtn, function()
		local codeStr = self.textField_code:getString()
		local codeNum = tonumber(codeStr)
		if codeNum ~= nil then
			-- 发送请求战绩消息
			local msgToSend = {}
			msgToSend.cmd = gt.SHAREVIDEO
			msgToSend.m_shareID = codeNum
			gt.socketClient:sendMessage(msgToSend)
		else
			self.textField_code:setString("")
			self.textField_code:setPlaceHolder("你输入的回放码有误，请重新输入")
		end
	end)

	gt.socketClient:registerMsgListener(gt.SHAREVIDEO, self, self.onRcvShareVideo)
	gt.socketClient:registerMsgListener(gt.ROOM_REPLAY, self, self.onRcvReplay)
end

function ViewOtherRecord:onRcvShareVideo(msgTbl)
	if msgTbl.m_errorId == 1 then
		self:historyItemClickEvent(msgTbl)

	else
		self.textField_code:setString("")
		self.textField_code:setPlaceHolder("你查询的录像不存在，请重新输入")

	end
end

function ViewOtherRecord:historyItemClickEvent(msgTbl)
	--服务器定义消息msgTbl(m_errorId(0,1),m_match(m_nike(),m_score()[待定],m_time(),m_videoId()))
	gt.log("yyyyyyyyyyyyyyyy")
	dump(msgTbl.m_data)
	local detailPanel = cc.CSLoader:createNode("HistoryDetailSearch.csb")
	detailPanel:setAnchorPoint(0.5,0.5)
	detailPanel:setPosition(gt.winCenter)
	self:addChild(detailPanel)
	local gameData = msgTbl.m_data
	local headNode = gt.seekNodeByName(detailPanel, "Node_header")
	local player3 = gt.seekNodeByName(headNode, "Label_nickname_3")
	for i,v in ipairs(gameData) do
		if v.m_nDeskType == 2 or v.m_nDeskType == 3 then
			player3:setVisible(false)
		else
			player3:setVisible(true)
		end
		break
	end

	local contentListVw = gt.seekNodeByName(detailPanel, "ListVw_content")

	local closeBtn = gt.seekNodeByName(detailPanel, "Btn_close")
	gt.addBtnPressedListener(closeBtn, function()
		self:destroy()
	end)

	for i,v in ipairs(msgTbl.m_data) do
		local detailCellNode = cc.CSLoader:createNode("HistoryDetailCell.csb")
		local playerName3 = gt.seekNodeByName(detailCellNode, "Label_score_3")
		if v.m_nDeskType == 2 or v.m_nDeskType == 3 then
			playerName3:setVisible(false)
		else
			playerName3:setVisible(true)
		end
		
		-- 序号
		local numLabel = gt.seekNodeByName(detailCellNode, "Label_num")
		--numLabel:setTextColor(cc.YELLOW)
		numLabel:setString(tostring(i))
		-- 对战时间
		local timeLabel = gt.seekNodeByName(detailCellNode, "Label_time")
		--timeLabel:setTextColor(cc.YELLOW)
		local timeTbl = os.date("*t", v.m_time)
		timeLabel:setString(string.format("%d-%d %d:%d", timeTbl.month, timeTbl.day, timeTbl.hour, timeTbl.min))
		-- 对战分数
		-- dump(v.m_nike)
		for j, m_nike in ipairs(v.m_nike) do
			if j == 4 then
				break
			end
			local scoreLabel = gt.seekNodeByName(detailCellNode, "Label_score_" .. j)
			--scoreLabel:setTextColor(cc.YELLOW)
			scoreLabel:setString(tostring(m_nike))
		end

		-- 查牌按钮
		local replayBtn = gt.seekNodeByName(detailCellNode, "Btn_replay")
		replayBtn.videoId = v.m_videoId
		replayBtn:setPositionX(replayBtn:getPositionX())
		gt.addBtnPressedListener(replayBtn, function(sender)
			local btnTag = sender.videoId
			local msgToSend = {}
			msgToSend.cmd = gt.GETSHAREVIDEO
			msgToSend.m_videoId = btnTag
			gt.socketClient:sendMessage(msgToSend)
		end)

		local shareBtn = gt.seekNodeByName(detailCellNode, "Btn_share")
		shareBtn:setVisible(false)

		local cellSize = detailCellNode:getContentSize()
		local detailItem = ccui.Widget:create()
		detailItem:setContentSize(cellSize)
		detailItem:addChild(detailCellNode)
		contentListVw:pushBackCustomItem(detailItem)
	end
end

function ViewOtherRecord:onRcvReplay(msgTbl)
	local replayLayer = require("app/views/ReplayLayer"):create(msgTbl,false)
	self:addChild(replayLayer, 6)
end

function ViewOtherRecord:destroy()
	gt.socketClient:unregisterMsgListener(gt.SHAREVIDEO)
	 gt.socketClient:unregisterMsgListener(gt.ROOM_REPLAY)
	 gt.socketClient:registerMsgListener(gt.ROOM_REPLAY, self.parent, self.parent.onRcvReplay)
	self:removeSelf()
end

return ViewOtherRecord
