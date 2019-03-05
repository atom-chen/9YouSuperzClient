
local gt = cc.exports.gt

local LoadingTips = class("LoadingTips", function()
	return gt.createMaskLayer(1)
end)

function LoadingTips:ctor(tipsText)
	self:setName("LoadingTips")
	self:registerScriptHandler(handler(self, self.onNodeEvent))
	self.tipsCount_ = 0

	local csbNode = cc.CSLoader:createNode("csd/LoadingTips.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)

	local imgBg = gt.seekNodeByName(csbNode, "Img_Bg")
	imgBg:stopAllActions()
	imgBg:runAction(cc.Sequence:create(cc.Hide:create(), cc.DelayTime:create(0.5), cc.Show:create()))

	local sp = gt.seekNodeByName(csbNode, "Spr_Loading")
	sp:runAction(cc.RepeatForever:create(cc.RotateBy:create(2, 360)))

	self:addChild(csbNode)

	local runningScene = cc.Director:getInstance():getRunningScene()
	if runningScene then
		runningScene:addChild(self, gt.CommonZOrder.LOADING_TIPS)
	end

	self:setTipsText(tipsText)
end

function LoadingTips:onNodeEvent(eventName)
	if "enter" == eventName then
		self.scheduleHandler = gt.scheduler:scheduleScriptFunc(handler(self, self.update), 0.5, false)
	elseif "exit" == eventName then
		if self.scheduleHandler then
			gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
			self.scheduleHandler = nil
		end
	end
end 

function LoadingTips:setTipsText(tipsText)
	if tipsText then
		local tipsLabel = gt.seekNodeByName(self, "Label_Tips")
		tipsLabel:setString(tipsText)
		self.tipsCount_ = 0
	end
end

function LoadingTips:update(delta)
	self.tipsCount_ = self.tipsCount_ + 1
	-- gt.log("self.tipsCount_:"..self.tipsCount_)

	if self.tipsCount_ >= 32 and gt.localVersion == false then
	-- if self.tipsCount_ >= 32 then
		if self.scheduleHandler then
			gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
			self.scheduleHandler = nil
		end
		-- require("app/views/NoticeTips"):create("��ʾ", "���������������,�����µ�¼"
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0068")
			, function() 
				-- gt.dispatchEvent(gt.EventType.BACK_MAIN_SCENE) 
				-- self:remove()

				-- �ر�socket����ʱ,Ӯֹͣ��ǰ��ʱ��
				if gt.socketClient.scheduleHandler then
					gt.scheduler:unscheduleScriptEntry( gt.socketClient.scheduleHandler )
				end
				-- �ر��¼��ص�
				gt.removeTargetAllEventListener(gt.socketClient)

				gt.socketClient:close()

				local loginScene = require("app/views/LoginScene"):create()
				cc.Director:getInstance():replaceScene(loginScene)

				gt.removeLoadingTips()

			end, nil, true)
	end
end

function LoadingTips:remove()
	self:removeFromParent()
end

return LoadingTips
