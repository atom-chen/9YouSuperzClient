-- 大联盟激活码活动界面

local gt = cc.exports.gt

local UnionKeyActive = class("UnionKeyActive", function()
	return gt.createMaskLayer()
end)

function UnionKeyActive:ctor(activeTime)
	self:registerScriptHandler(handler(self, self.onNodeEvent))

	local csbNode = cc.CSLoader:createNode("csd/Guild/UnionKeyActive.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
    ccui.Helper:doLayout(csbNode)
	self:addChild(csbNode)
	self.csbNode = csbNode
	
	gt.seekNodeByName(self.csbNode, "jiaru_66"):setVisible(false)
	gt.seekNodeByName(self.csbNode, "chuangjian_65"):setVisible(false)
	
	self.Img_RuleBg = gt.seekNodeByName(self.csbNode, "Img_RuleBg")
	self.Img_RuleBg:setVisible(false)
	
	self.FileNode_StayAni = gt.seekNodeByName(self.csbNode, "FileNode_StayAni")
	self.FileNode_StayAni:setVisible(false)
	self.stayAni = cc.CSLoader:createTimeline("csd/texiao/dalianmeng.csb")
	self.FileNode_StayAni:runAction(self.stayAni)
	
	self.Text_CountDown = self.FileNode_StayAni:getChildByName("Text_CountDown")
	self.Text_CountDown:setString("")
	
	local btnClose = self.FileNode_StayAni:getChildByName("Button_Close")
	gt.addBtnPressedListener(btnClose, function()
		self:close()
	end)
	local btnActiveRule = self.FileNode_StayAni:getChildByName("Button_ActiveRule")
	gt.addBtnPressedListener(btnActiveRule, function()
		self.Img_RuleBg:setVisible(true)
	end)
	local btnCancel = self.Img_RuleBg:getChildByName("Btn_Cancel")
	gt.addBtnPressedListener(btnCancel, function()
		self:close()
	end)
	local btnOk = self.Img_RuleBg:getChildByName("Btn_Ok")
	gt.addBtnPressedListener(btnOk, function()
		self:close()
	end)
	
	gt.soundEngine:stopMusic()
	gt.soundEngine:playEffect("unionJoin", false)

	local function setShowHide()
        gt.soundEngine:playMusic("unionActive", true)

		self.FileNode_StayAni:setVisible(true)
		self.stayAni:play("animation_Stay",true)
		
		self.FileNode_JoinAni:setVisible(false)

		if activeTime.now_time > activeTime.end_time  then
			self.Text_CountDown:setString("待开启")
		else
			if activeTime.now_time < activeTime.start_time  then
				self.Text_CountDown:setString("敬请期待")
			end
			self.startTime = activeTime.start_time
			self.endTime = activeTime.end_time
			self.nowTime = activeTime.now_time
			self.localSubNetTime = os.time()- self.nowTime
			self:updateActivityTime()
			self.activeTimeSchedule = gt.scheduler:scheduleScriptFunc(handler(self, self.updateActivityTime), 1, false)
		end
	end


	self.FileNode_JoinAni = gt.seekNodeByName(self.csbNode, "FileNode_JoinAni")
	local joinAni = cc.CSLoader:createTimeline("csd/texiao/dalianmeng_ruchang.csb")
    self.FileNode_JoinAni:runAction(joinAni)
    joinAni:play("animation_Join",false)
	
	self.csbNode:runAction(cc.Sequence:create(cc.DelayTime:create(85/60), cc.CallFunc:create(setShowHide)))
end
	
function UnionKeyActive:updateActivityTime()
	self.nowTime = os.time() - self.localSubNetTime
	if self.nowTime > self.endTime then
		self.Text_CountDown:setString("待开启")
		if self.activeTimeSchedule then
			gt.scheduler:unscheduleScriptEntry(self.activeTimeSchedule)
			self.activeTimeSchedule = nil
		end
	elseif self.nowTime > self.startTime then
		self.Text_CountDown:setString(gt.convertTimeSpanToString(self.endTime - self.nowTime))
	end
end

function UnionKeyActive:close()
	if self.activeTimeSchedule then
		gt.scheduler:unscheduleScriptEntry(self.activeTimeSchedule)
	end
	self:removeFromParent()
	gt.soundEngine:playMusic("guild", true)
end

return UnionKeyActive
