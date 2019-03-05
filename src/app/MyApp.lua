
require("app/UtilityTools")

local gt = cc.exports.gt

local MyApp = class("MyApp", cc.load("mvc").AppBase)

function MyApp:ctor()
	--cc.Director:getInstance():setDisplayStats(true)
	cc.Director:getInstance():setAnimationInterval(1.0/40)
	gt.setRandomSeed()
	
	local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
	local customListenerBg = cc.EventListenerCustom:create("APP_ENTER_BACKGROUND_EVENT",
								handler(self, self.onEnterBackground))
	
	eventDispatcher:addEventListenerWithFixedPriority(customListenerBg, 1)
	local customListenerFg = cc.EventListenerCustom:create("APP_ENTER_FOREGROUND_EVENT",
								handler(self, self.onEnterForeground))
	eventDispatcher:addEventListenerWithFixedPriority(customListenerFg, 1)
	-- 音效引擎
	gt.soundEngine = require("app/Sound"):create()
	cc.Device:setKeepScreenOn(true)
end

function MyApp:run()
	local logoScene = require("app/views/LogoScene"):create()
	-- local logoScene = require("app/views/LibScene"):create()
	cc.Director:getInstance():replaceScene(logoScene)
end

function MyApp:onEnterBackground()
    gt.log("onEnterBackground")
    self.enterBackTime = os.time()
	if cc.PLATFORM_OS_WINDOWS == gt.targetPlatform then
		gt.soundEngine:pauseAllSound()
	end
end

function MyApp:onEnterForeground()
    gt.log("onEnterForeground")
    self.enterForeTime = os.time()
	--第一次进入到这里self.enterBackTime为空
	if not self.enterBackTime then
		return
	end
    if (self.enterForeTime - self.enterBackTime > 3) then
        gt.log("onEnterForeground........")
		--存在gt.EventType 还未初始化的情况
		if gt.EventType and gt.EventType.PLAY_SCENE_RESET then
			gt.dispatchEvent(gt.EventType.PLAY_SCENE_RESET)
		end
    end
	if cc.PLATFORM_OS_WINDOWS == gt.targetPlatform then
		gt.soundEngine:resumeAllSound()
	end
end

return MyApp
