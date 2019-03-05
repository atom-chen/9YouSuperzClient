
local gt = cc.exports.gt

local PlayerHeadManager = class("PlayerHeadManager", function()
	return cc.Node:create()
end )

function PlayerHeadManager:ctor(name_)
	-- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))
	self.name_ = name_ or ""
	self.count_ = 0
	self.headImageObservers = { }
end

function PlayerHeadManager:onNodeEvent(eventName)
	if "enter" == eventName then
		self.scheduleHandler = gt.scheduler:scheduleScriptFunc(handler(self, self.update), 0.1, false)
	elseif "exit" == eventName then
		if self.scheduleHandler then
			gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
			self.scheduleHandler = nil
		end
		self.headImageObservers = { }
	end
end

function PlayerHeadManager:update(delta)
	local transObservers = { }
	self.count_ = self.count_ + 1
	-- gt.log(self.name_ .. "-----------------------11111111111:"..#self.headImageObservers.." count:"..self.count_)
	local curTime = os.time()
	for i, observerData in ipairs(self.headImageObservers) do
		if observerData and observerData.headSpr then
			-- gt.log(self.name_ .. "-----------------------333333333333:"..(curTime - observerData.startTime))
			if (curTime - observerData.startTime) > 1 and cc.FileUtils:getInstance():isFileExist(observerData.imgFileName) then
				if iskindof(observerData.headSpr, "ccui.ImageView") then
					observerData.headSpr:loadTexture(observerData.imgFileName)
				else
					observerData.headSpr:setTexture(observerData.imgFileName)
				end
			else
				table.insert(transObservers, observerData)
			end
		else
			-- gt.log("----------1111111111111")
		end
	end
	self.headImageObservers = transObservers
end

function PlayerHeadManager:attach(headSpr, playerUID, headUrl)
	-- print("=========",headSpr,playerUID,headURL)
	if not headSpr or not headUrl or string.len(headUrl) < 8 then
		return
	end

	local imgFileName = string.format("head_%d.png", playerUID)

	local observerData = { }
	local headURL = string.sub(headUrl, 1, string.lastString(headUrl, "/")) .. "96"
	-- observerData.target = target
	observerData.headSpr = headSpr
	observerData.imgFileName = imgFileName
	observerData.headURL = headURL
	table.insert(self.headImageObservers, observerData)

	if cc.FileUtils:getInstance():isFileExist(observerData.imgFileName) then
		if iskindof(observerData.headSpr, "ccui.ImageView") then
			observerData.headSpr:loadTexture(observerData.imgFileName)
		else
			observerData.headSpr:setTexture(observerData.imgFileName)
		end
	end

	observerData.startTime = os.time()

	local xhr = cc.XMLHttpRequest:new()
	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
	xhr:open("GET", headURL)
	local function onReadyStateChanged()
		if xhr.readyState == 4 and(xhr.status >= 200 and xhr.status < 207) then
			local fileData = xhr.response
			local fullFileName = cc.FileUtils:getInstance():getWritablePath() .. imgFileName
			local file = io.open(fullFileName, "wb")
			file:write(fileData)
			file:close()
		else
			gt.log("xhr.readyState is:" .. xhr.readyState .. " xhr.status is: " .. xhr.status)
		end
		xhr:unregisterScriptHandler()
	end
	xhr:registerScriptHandler(onReadyStateChanged)
	xhr:send()
end

function PlayerHeadManager:detach(headSpr)
	for i, observerData in ipairs(self.headImageObservers) do
		if observerData.headSpr == headSpr then
			table.remove(self.headImageObservers, i)
			break
		end
	end
end

function PlayerHeadManager:resetHeadSpr(headSpr)
	if headSpr ~= nil and cc.FileUtils:getInstance():isFileExist("image/play/default_avatar.png") then
    	if iskindof(headSpr, "ccui.ImageView") then
			headSpr:loadTexture("image/play/default_avatar.png")
		else
			headSpr:setTexture("image/play/default_avatar.png")
	    end
	end
end


function PlayerHeadManager:close()
	self:detachAll()
	self:removeFromParent()
end

function PlayerHeadManager:detachAll()
	for i, observerData in ipairs(self.headImageObservers) do
		observerData = nil
	end
	self.headImageObservers = { }
end

return PlayerHeadManager

