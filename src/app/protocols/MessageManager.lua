local gt = cc.exports.gt

require("app/protocols/MessageInit")

local MessageManager = class("MessageManager")

function MessageManager:ctor()
	
	self.rcvMsgPreListeners = {}
end

function MessageManager:registerPreMsgListener(msgId)
	if gt.msgFiles and gt.msgFiles[msgId] ~= nil then
		if self.rcvMsgPreListeners[msgId] == nil then
			local msgFile = require(gt.msgFiles[msgId]):create()
			self.rcvMsgPreListeners[msgId] = msgFile
		end
	end
end


function MessageManager:unregisterPreMsgListener(msgId)
	if self.rcvMsgPreListeners[msgId] then
		self.rcvMsgPreListeners[msgId] = nil
	end
end

function MessageManager:dispatchPreMessage(msgTbl)
	if msgTbl == nil then return end
	local msgId = msgTbl.cmd
	if self.rcvMsgPreListeners[msgId] then
		-- gt.log("----------------msgManager_start")
		-- gt.dump(msgTbl)
		self.rcvMsgPreListeners[msgId]:dispatch(msgTbl)
		-- gt.log("----------------msgManager_end")
	end
end

return MessageManager