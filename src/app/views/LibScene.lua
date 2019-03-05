
local gt = cc.exports.gt

local LibScene = class("LibScene", function()
	return cc.Scene:create()
end)


function LibScene:ctor()
	-- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))
end

function LibScene:onNodeEvent(eventName)
	if "enter" == eventName then
		local btnEnter = ccui.Button:create("image/common/Btn_YellowSmall.png", "image/common/Btn_YellowSmall.png")
		btnEnter:setTitleText("Enter Game~")
		-- btnEnter:setPosition( display.cx + 200, display.cy - 100 )
		btnEnter:setPosition( display.cx, display.cy - 100 )
		btnEnter:addClickEventListener(function(sender)
	        local logoScene = require("app/views/LogoScene"):create()
			cc.Director:getInstance():replaceScene(logoScene)
	    end)
	    self:addChild(btnEnter)

	    local lblTips = ccui.Text:create("Libs already Start~", "Arial", 30)
	    lblTips:setPosition( display.cx, display.cy)
	    lblTips:setVisible(false)
	    self:addChild(lblTips)

	    if true then
	    	local pocoManager = require('lib.poco.poco_manager')
	   		pocoManager:init_server(15004)
	        lblTips:setVisible(true)
	    end

	    local btnLib = ccui.Button:create("image/common/Btn_BuleSmall.png", "image/common/Btn_BuleSmall.png")
		btnLib:setTitleText("Lib")
		btnLib:setPosition( display.cx - 200, display.cy - 100 )
		btnLib:addClickEventListener(function(sender)
			local pocoManager = require('lib.poco.poco_manager')
	   		pocoManager:init_server(15004)
	        lblTips:setVisible(true)
	    end)
	    btnLib:setVisible(false)
	    self:addChild(btnLib)

		-- local delayAction = cc.FadeIn:create(1)
		-- local fadeOutAction = cc.FadeOut:create(1)
		-- local callFunc = cc.CallFunc:create(function(sender)
		-- 	-- 动画播放完毕之后再走这些内容
		-- 	changeScene()

		-- 	-- 30s启动Lua垃圾回收器
		-- 	gt.scheduler:scheduleScriptFunc(function(delta)
		-- 		local preMem = collectgarbage("count")
		-- 		-- 调用lua垃圾回收器
		-- 		for i = 1, 3 do
		-- 			collectgarbage("collect")
		-- 		end
		-- 		local curMem = collectgarbage("count")
		-- 		gt.log(string.format("Collect lua memory:[%d] cur cost memory:[%d]", (curMem - preMem), curMem))
		-- 		local luaMemLimit = 30720
		-- 		if curMem > luaMemLimit then
		-- 			gt.log("Lua memory limit exceeded!")
		-- 		end
		-- 	end, 60, false)
		-- end)


		--gt.soundEngine:playEffect("logo", false)
	end
end


return LibScene


