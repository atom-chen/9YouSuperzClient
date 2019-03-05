require("json")
local gt = cc.exports.gt

local Trusteeship = class("Trusteeship",function()
	return gt.createMaskLayer()
end)

local TipText = {
	--下注
	{
		--Title
		"明牌抢庄玩法中，前4张牌满足一下任意1种牌型时，自动下注本局最大分数。",
		--第一行
		"在3张牌点数相加为10的整倍数，且另外1张牌点数为8或9或10.",
		--后面的
		{ "前4张牌为顺子", "【房主开启“顺子牛”】" },
		{ "前4张牌花色相同", "【房主开启“同花牛”】" },
		{ "前4张牌为公牌或3张公牌1张10", "【房主开启“金牛和银牛”】" },
		{ "前4张牌有3张相同牌", "【房主开启“炸弹牛或葫芦牛牛”】" },
		{ "前4张牌有2对牌", "【房主开启“葫芦牛牛”】" },
		{ "前4张牌花色相同且为顺子", "【房主开启“同花顺”】" },
	},
	--抢庄
	{
		"明牌抢庄玩法中，前4张牌满足一下任意1种牌型时，自动按照设定抢庄倍数去抢庄。",

		"在3张牌点数相加为10的整倍数，且另外1张牌点数为8或9或10.",

		{ "前4张牌为顺子", "【房主开启“顺子牛”】" },
		{ "前4张牌花色相同", "【房主开启“同花牛”】" },
		{ "前4张牌为公牌或3张公牌1张10", "【房主开启“金牛和银牛”】" },
		{ "前4张牌有3张相同牌", "【房主开启“炸弹牛或葫芦牛牛”】" },
		{ "前4张牌有2对牌", "【房主开启“葫芦牛牛”】" },
		{ "前4张牌花色相同且为顺子", "【房主开启“同花顺”】" },
	},
	--推注
	{
		"明牌抢庄玩法中，前4张牌满足一下任意1种牌型时，若符合推注规则，则进行推注操作。",

		"在3张牌点数相加为10的整倍数，且另外1张牌点数为8或9或10.",

		{ "前4张牌为顺子", "【房主开启“顺子牛”】" },
		{ "前4张牌花色相同", "【房主开启“同花牛”】" },
		{ "前4张牌为公牌或3张公牌1张10", "【房主开启“金牛和银牛”】" },
		{ "前4张牌有3张相同牌", "【房主开启“炸弹牛或葫芦牛牛”】" },
		{ "前4张牌有2对牌", "【房主开启“葫芦牛牛”】" },
		{ "前4张牌花色相同且为顺子", "【房主开启“同花顺”】" },
	},
	--王癞
	{
		"明牌抢庄玩法中，前4张牌满足一下任意1种牌型时，若符合推注规则，则进行推注操作。若勾选有癞必抢选项，前四张有癞子则遵循玩家设定的下注/抢庄/推注设定",

		"在3张牌点数相加为10的整倍数，且另外1张牌点数为8或9或10.",

		{ "前4张牌为顺子", "【房主开启“顺子牛”】" },
		{ "前4张牌花色相同", "【房主开启“同花牛”】" },
		{ "前4张牌为公牌或3张公牌1张10", "【房主开启“金牛和银牛”】" },
		{ "前4张牌有3张相同牌", "【房主开启“炸弹牛或葫芦牛牛”】" },
		{ "前4张牌有2对牌", "【房主开启“葫芦牛牛”】" },
		{ "前4张牌花色相同且为顺子", "【房主开启“同花顺”】" },
	}
}

--琼海4个分数选项
local QHScore = {
	{ 1, 2, 4, 5 }, --5倍 可选分数	score:5
	{ 1, 3, 5, 8 }  --8倍 可选分数	score:8
}

--Ang3个分数选项
local AngScore = {
	{ 1, 2, 3 }, --				score:1
	{ 3, 4, 5 }, --				score:3
	{ 6, 8, 10 } --				score:6
}

local StorageKey = "TrusteeshipSetting"

function Trusteeship:ctor(tableSetting , isTwelve)

 	local csbName = "csd/Trusteeship.csb"
	if isTwelve then
		csbName = "csd/TrusteeshipTwelve.csb"
	end
	local csbNode = cc.CSLoader:createNode(csbName)
	csbNode:setAnchorPoint(0.5,0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.rootNode = csbNode

	gt.registerEventListener("Close_Trusteeship",self,self.Close)
	self.Score = tableSetting.score

	--关闭按钮
	local close = gt.seekNodeByName(csbNode,"Btn_Close")
	gt.addBtnPressedListener(close,function()
		self:Close()
	end)
	local close2 = gt.seekNodeByName(csbNode,"Btn_Cancel")
	gt.addBtnPressedListener(close2,function()
		self:Close()
	end)

	self.Node_laizi = gt.seekNodeByName(csbNode,"pLaizi")

	self.Node_Pledge = gt.seekNodeByName(csbNode,"pledge")
	self.Node_PledgeType = gt.seekNodeByName(csbNode,"pledge_type")
	--是否选中开关
	self.Node_LootDealerTypeSwitch = gt.seekNodeByName(csbNode,"loot_dealer_type")
	self.Node_LootDealerType = gt.seekNodeByName(csbNode,"loot_dealer_type2")
	self.Node_LootDealer = gt.seekNodeByName(csbNode,"loot_dealer")
	--是否选中开关
	self.Node_PushPledgeTypeSwitch = gt.seekNodeByName(csbNode,"push_pledge_type")
	self.Node_PushPledgeType = gt.seekNodeByName(csbNode,"push_pledge_type2")

	--底分
	--琼海4个分数选项
	if tableSetting.game_id == gt.GameID.QIONGHAI then
		for i = 1,4 do
			self.Node_Pledge:getChildByName("Check_" .. i):setVisible(true)
			self.Node_Pledge:getChildByName("Check_" .. i):setPositionX(130 + (i - 1) * 100)
			if self.Score == 5 then
				self.Node_Pledge:getChildByName("Check_" .. i):getChildByName("Label_Desc1"):setString(QHScore[1][i] .. "分")
				self.Node_Pledge:getChildByName("Check_" .. i):setTag(QHScore[1][i])
				self.MaxScore = QHScore[1][4]
			else
				self.Node_Pledge:getChildByName("Check_" .. i):getChildByName("Label_Desc1"):setString(QHScore[2][i] .. "分")
				self.Node_Pledge:getChildByName("Check_" .. i):setTag(QHScore[2][i])
				self.MaxScore = QHScore[2][4]
			end
		end
	elseif self.Score > 10 then
		for i = 1,4 do
			self.Node_Pledge:getChildByName("Check_" .. i):setVisible(true)
			self.Node_Pledge:getChildByName("Check_" .. i):setPositionX(130 + (i - 1) * 100)
			
			local specialScore = gt.getScoreSpecialDetail(self.Score, i)

			self.Node_Pledge:getChildByName("Check_" .. i):getChildByName("Label_Desc1"):setString(specialScore .. "分")
			self.Node_Pledge:getChildByName("Check_" .. i):setTag(specialScore)
			self.MaxScore = specialScore
		end

		--阿牛哥中的牛牛
	elseif gt.app_id == 101 and tableSetting.game_id == gt.GameID.NIUNIU then
		for i = 1,3 do
			self.Node_Pledge:getChildByName("Check_" .. i):setVisible(true)
			self.Node_Pledge:getChildByName("Check_" .. i):setPositionX(130 + (i - 1) * 133)
			if self.Score == 1 then
				self.Node_Pledge:getChildByName("Check_" .. i):getChildByName("Label_Desc1"):setString(AngScore[1][i] .. "分")
				self.Node_Pledge:getChildByName("Check_" .. i):setTag(AngScore[1][i])
				self.MaxScore = AngScore[1][3]
			elseif self.Score == 1 then
				self.Node_Pledge:getChildByName("Check_" .. i):getChildByName("Label_Desc1"):setString(AngScore[2][i] .. "分")
				self.Node_Pledge:getChildByName("Check_" .. i):setTag(AngScore[2][i])
				self.MaxScore = AngScore[2][3]
			else
				self.Node_Pledge:getChildByName("Check_" .. i):getChildByName("Label_Desc1"):setString(AngScore[3][i] .. "分")
				self.Node_Pledge:getChildByName("Check_" .. i):setTag(AngScore[3][i])
				self.MaxScore = AngScore[3][3]
			end
		end
		self.Node_Pledge:getChildByName("Check_4"):setVisible(false)
		--默认2个选项
	else
		self.Node_Pledge:getChildByName("Check_1"):getChildByName("Label_Desc1"):setString(self.Score .. "分")
		self.Node_Pledge:getChildByName("Check_1"):setPositionX(130)
		self.Node_Pledge:getChildByName("Check_1"):setTag(self.Score)
		self.Node_Pledge:getChildByName("Check_2"):getChildByName("Label_Desc1"):setString((self.Score * 2) .. "分")
		self.Node_Pledge:getChildByName("Check_2"):setPositionX(350)
		self.Node_Pledge:getChildByName("Check_2"):setTag(self.Score * 2)
		self.Node_Pledge:getChildByName("Check_3"):setVisible(false)
		self.Node_Pledge:getChildByName("Check_4"):setVisible(false)
		self.MaxScore = self.Score * 2
	end

	--倍数
	for i = 1,4 do
		self.Node_LootDealer:getChildByName("Check_" .. i):setVisible(i <= tableSetting.loot_dealer)
	end

	self.Node_PledgeType:getChildByName("Check_1"):getChildByName("Label_Desc1"):setString(string.format("牛八以上压%d分",self.MaxScore))
	self.Node_PledgeType:getChildByName("Check_2"):getChildByName("Label_Desc1"):setString(string.format("牛九以上压%d分",self.MaxScore))
	self.Node_PledgeType:getChildByName("Check_3"):getChildByName("Label_Desc1"):setString(string.format("牛牛以上压%d分",self.MaxScore))

	--提示tip
	self.Panel_TipInfo = gt.seekNodeByName(csbNode,"Panel_TipInfo")
	gt.addBtnPressedListener(self.Panel_TipInfo,function()
		self.Panel_TipInfo:setVisible(false)
	end)
	self.Panel_TipInfo:setVisible(false)
	self.List_Tips = gt.seekNodeByName(self.Panel_TipInfo,"List_Tips")
	self.Text_Title = gt.seekNodeByName(self.Panel_TipInfo,"Text_Title")
	--下注
	self.Btn_pledge = gt.seekNodeByName(csbNode,"Btn_pledge")
	--抢庄
	self.Btn_loot_dealer = gt.seekNodeByName(csbNode,"Btn_loot_dealer")
	--推注
	self.Btn_push_pledge = gt.seekNodeByName(csbNode,"Btn_push_pledge")

	self.Btn_laizi = gt.seekNodeByName(csbNode,"Btn_laizi")

	gt.addBtnPressedListener(self.Btn_pledge,function()
		self:OpenTipsPanel(1)
	end)
	gt.addBtnPressedListener(self.Btn_loot_dealer,function()
		self:OpenTipsPanel(2)
	end)
	gt.addBtnPressedListener(self.Btn_push_pledge,function()
		self:OpenTipsPanel(3)
	end)	
	gt.addBtnPressedListener(self.Btn_laizi,function()
		self:OpenTipsPanel(4)
	end)

	self.Panels = {
		{ self.Node_Pledge, self.OnPledge },
		{ self.Node_PledgeType, self.OnPledgeType },
		{ self.Node_LootDealerTypeSwitch, self.OnLootDealerTypeSwitch },
		{ self.Node_LootDealerType, self.OnLootDealerType },
		{ self.Node_LootDealer, self.OnLootDealer },
		{ self.Node_PushPledgeTypeSwitch, self.OnPushPledgeTypeSwitch },
		{ self.Node_PushPledgeType, self.OnPushPledgeType },
		{ self.Node_laizi, self.onLaizi },
	}

	--处理单选按钮
	for _,value in ipairs(self.Panels) do
		--最多5个Check
		local panel = value[1]
		local func = value[2]
		for i = 1,5 do
			local child = panel:getChildByName("Check_" .. i)
			if child then
				child:setZoomScale(0)
				child:addTouchEventListener( function(sender,eventType)
					if eventType ~= ccui.TouchEventType.canceled and eventType ~= ccui.TouchEventType.ended then
						return true
					end
					--取消其他选中
					for j = 1,5 do
						local radio = panel:getChildByName("Check_" .. j)
						if radio then
							if i == j then
								radio:setSelected(true)
								func(self,i,value[1])
							else
								radio:setSelected(false)
							end
						end
					end
				end)
			end
		end
	end

	self.ListItem = {}
	self.ListParam = {}
	--最多3个选项
	self.ListView = gt.seekNodeByName(csbNode,"List_Config")
	for i = 1,3 do
		local item = self.ListView:getChildByName("Item" .. i)
		local param = self.ListView:getChildByName("Param" .. i)
		self.ListItem[i] = item
		self.ListParam[i] = param
	end
	local item4 = self.ListView:getChildByName("Item4")
	self.ListItem[4] = item4

	--默认50高度并且隐藏
	for i,v in ipairs(self.ListParam) do
		if v then
			local size = v:getContentSize()
			v:setContentSize(size.width,20)
			v:setVisible(false)
		end
	end

	self:LoadConfig()

	--确定按钮
	self.Btn_Confirm = gt.seekNodeByName(csbNode,"Btn_Confirm")
	gt.addBtnPressedListener(self.Btn_Confirm,function()
		--托管类型(0:无效 1:系统托管 2：手动托管)
		local ai_type = 2
		-- 押分类型 （例：0默认 1代表牛八以上押注  .... ）
		local pledge_type = 0
		if self.Node_Pledge:getChildByName("Check_5"):isSelected() then
			pledge_type = 1
			if self.Node_PledgeType:getChildByName("Check_2"):isSelected() then
				pledge_type = 2
			end
			if self.Node_PledgeType:getChildByName("Check_3"):isSelected() then
				pledge_type = 3
			end
		end
		-- 压分分数
		local pledge = self.Score
		local pledgeIndex = 1
		--如果是选中智能压分  分数选项一个都不会被选中  这个时候发最高分
		if pledge_type ~= 0 then
			pledge = self.MaxScore
		else
			for i = 1,4 do
				if self.Node_Pledge:getChildByName("Check_" .. i):isVisible() and self.Node_Pledge:getChildByName("Check_" .. i):isSelected() then
					pledge = self.Node_Pledge:getChildByName("Check_" .. i):getTag()
					pledgeIndex = i
				end
			end
		end
		-- 推注
		local push_pledge_type = 0
		if self.Node_PushPledgeTypeSwitch:getChildByName("Check_3"):isSelected() then
			push_pledge_type = 1
			if self.Node_PushPledgeType:getChildByName("Check_2"):isSelected() then
				push_pledge_type = 2
			end
			if self.Node_PushPledgeType:getChildByName("Check_3"):isSelected() then
				push_pledge_type = 3
			end
		end
		--抢庄
		local loot_dealer_type = 0
		if self.Node_LootDealerTypeSwitch:getChildByName("Check_3"):isSelected() then
			loot_dealer_type = 1
			if self.Node_LootDealerType:getChildByName("Check_2"):isSelected() then
				loot_dealer_type = 2
			end
			if self.Node_LootDealerType:getChildByName("Check_3"):isSelected() then
				loot_dealer_type = 3
			end
		end
		--抢庄倍数
		local loot_dealer = 1
		if self.Node_LootDealer:getChildByName("Check_2"):isSelected() then
			loot_dealer = 2
		elseif self.Node_LootDealer:getChildByName("Check_3"):isSelected() then
			loot_dealer = 3
		elseif self.Node_LootDealer:getChildByName("Check_4"):isSelected() then
			loot_dealer = 4
		end

		--王癞
		local laizi_type = 0
		if self.Node_laizi:getChildByName("Check_2"):isSelected() then
			laizi_type = 1
		end

		self:SaveConfig(pledge_type,pledgeIndex,push_pledge_type,loot_dealer_type,loot_dealer,laizi_type)
		local msg = {}
		msg.cmd = gt.TRUSTEESHIP
		msg.ai_type = ai_type
		msg.pledge_type = pledge_type
		msg.pledge = pledge
		msg.push_pledge_type = push_pledge_type
		msg.loot_dealer_type = loot_dealer_type
		msg.loot_dealer = loot_dealer
		msg.laizi_type = laizi_type

		dump(msg)
		gt.socketClient:sendMessage(msg)
	end)
end

function Trusteeship:SaveConfig(pledge_type,pledgeIndex,push_pledge_type,loot_dealer_type,loot_dealer,laizi_type)
	local setting = {}
	setting.pledge_type = pledge_type
	setting.pledgeIndex = pledgeIndex
	setting.push_pledge_type = push_pledge_type
	setting.loot_dealer_type = loot_dealer_type
	setting.loot_dealer = loot_dealer
	setting.laizi_type = laizi_type
	local jsonStr = json.encode(setting)
	cc.UserDefault:getInstance():setStringForKey(StorageKey,jsonStr)
end

function Trusteeship:LoadConfig()
	local setting = ""
	setting = cc.UserDefault:getInstance():getStringForKey(StorageKey,"")
	if setting ~= "" then
		setting = json.decode(setting)
	end
	if setting ~= "" then
		--押分类型
		local bValid = gt.inTable({ 1, 2, 3 },setting.pledge_type)
		if bValid then
			self.Node_Pledge:getChildByName("Check_1"):setSelected(false)
			self.Node_Pledge:getChildByName("Check_2"):setSelected(false)
			self.Node_Pledge:getChildByName("Check_3"):setSelected(true)
			for i = 1,3 do
				self.Node_PledgeType:getChildByName("Check_" .. i):setSelected(setting.pledge_type == i)
			end
		end
		-- 压分分数
		local bValid = gt.inTable({ 1, 2, 3, 4 },setting.pledgeIndex)
		if bValid then
			if setting.pledge_type == 0 then
				for i = 1,4 do
					self.Node_Pledge:getChildByName("Check_" .. i):setSelected(setting.pledgeIndex == i)
				end
			else
				self.Node_Pledge:getChildByName("Check_1"):setSelected(false)
				self.Node_Pledge:getChildByName("Check_2"):setSelected(false)
				self.Node_Pledge:getChildByName("Check_3"):setSelected(false)
				self.Node_Pledge:getChildByName("Check_4"):setSelected(false)
				self.Node_Pledge:getChildByName("Check_5"):setSelected(true)
			end
			--如果选中的这个是隐藏的 则选第一个默认的
			if setting.pledge_type == 0 and not self.Node_Pledge:getChildByName("Check_" .. setting.pledgeIndex):isVisible() then
				self.Node_Pledge:getChildByName("Check_" .. setting.pledgeIndex):setSelected(false)
				self.Node_Pledge:getChildByName("Check_1"):setSelected(true)
			end
		end
		-- 推注
		local bValid = gt.inTable({ 1, 2, 3 },setting.push_pledge_type)
		if bValid then
			self.Node_PushPledgeTypeSwitch:getChildByName("Check_1"):setSelected(false)
			self.Node_PushPledgeTypeSwitch:getChildByName("Check_3"):setSelected(true)
			for i = 1,3 do
				self.Node_PushPledgeType:getChildByName("Check_" .. i):setSelected(setting.push_pledge_type == i)
			end
		else
			self.Node_PushPledgeTypeSwitch:getChildByName("Check_1"):setSelected(true)
			self.Node_PushPledgeTypeSwitch:getChildByName("Check_3"):setSelected(false)
		end
		-- 抢庄
		local bValid = gt.inTable({ 1, 2, 3 },setting.loot_dealer_type)
		if bValid then
			self.Node_LootDealerTypeSwitch:getChildByName("Check_1"):setSelected(false)
			self.Node_LootDealerTypeSwitch:getChildByName("Check_3"):setSelected(true)
			for i = 1,3 do
				self.Node_LootDealerType:getChildByName("Check_" .. i):setSelected(setting.loot_dealer_type == i)
			end
		else
			self.Node_LootDealerTypeSwitch:getChildByName("Check_1"):setSelected(true)
			self.Node_LootDealerTypeSwitch:getChildByName("Check_3"):setSelected(false)
		end
		-- 抢庄倍数
		local bValid = gt.inTable({ 1, 2, 3, 4 },setting.loot_dealer)
		if bValid then
			local index
			for i = 1,4 do
				self.Node_LootDealer:getChildByName("Check_" .. i):setSelected(setting.loot_dealer == i)
				index = i
			end
			--如果被选中的是隐藏的 则选第一个默认的
			if not self.Node_LootDealer:getChildByName("Check_"..index):isVisible() and self.Node_LootDealer:getChildByName("Check_"..index):isSelected() then
				self.Node_LootDealer:getChildByName("Check_"..index):setSelected(false)
				self.Node_LootDealer:getChildByName("Check_1"):setSelected(true)
			end
		end	

		-- 王癞
		local bValid = gt.inTable({ 0,1 },setting.laizi_type)
		if bValid then
			local index
			for i = 1,2 do
				self.Node_laizi:getChildByName("Check_" .. i):setSelected(setting.laizi_type == (i-1))
				index = i
			end
			--如果被选中的是隐藏的 则选第一个默认的
			if not self.Node_laizi:getChildByName("Check_"..index):isVisible() and self.Node_laizi:getChildByName("Check_"..index):isSelected() then
				self.Node_laizi:getChildByName("Check_"..index):setSelected(false)
				self.Node_laizi:getChildByName("Check_1"):setSelected(true)
			end
		end
	end
end

function Trusteeship:Close()
	gt.removeTargetAllEventListener(self)
	self:removeFromParent()
end

function Trusteeship:OpenTipsPanel(type)
	local tipsCount = self.List_Tips:getChildrenCount()
	for i = 1,tipsCount do
		local tip = self.List_Tips:getChildByName("Panel_Tip" .. i)
		tip:setVisible(false)
	end
	local text = TipText[type]
	for i,v in ipairs(text) do
		if i == 1 then
			self.Text_Title:setString(v)
		elseif i == 2 then
			local tip = self.List_Tips:getChildByName("Panel_Tip" .. (i - 1))
			if tip then
				tip:getChildByName("Text_1"):setString(v)
				tip:setVisible(true)
			end
		else
			local tip = self.List_Tips:getChildByName("Panel_Tip" .. (i - 1))
			if tip then
				tip:getChildByName("Text_1"):setString(v[1])
				tip:getChildByName("Text_2"):setString(v[2])
				tip:setVisible(true)
			end
		end
	end
	self.Panel_TipInfo:setVisible(true)
end

function Trusteeship:onLaizi(index,parent)
	self.ListParam[1]:setVisible(false)
	self.ListParam[2]:setVisible(false)
	self.ListParam[3]:setVisible(false)
	local size = self.ListParam[1]:getContentSize()
	self.ListParam[1]:setContentSize(size.width,10)
	self.ListParam[2]:setContentSize(size.width,10)
	self.ListParam[3]:setContentSize(size.width,10)
	self.ListView:refreshView()
end

function Trusteeship:OnPledge(index,parent)
	if index == 5 then
		self.ListParam[1]:setVisible(true)
		self.ListParam[2]:setVisible(false)
		self.ListParam[3]:setVisible(false)
		local size = self.ListParam[1]:getContentSize()
		self.ListParam[1]:setContentSize(size.width,50)
		self.ListParam[2]:setContentSize(size.width,10)
		self.ListParam[3]:setContentSize(size.width,10)
		self.ListView:refreshView()
	else
		self.ListParam[1]:setVisible(false)
	end

end

function Trusteeship:OnPledgeType(index)

end

function Trusteeship:OnLootDealerTypeSwitch(index)
	if index == 3 then
		self.ListParam[2]:setVisible(true)
		self.ListParam[1]:setVisible(false)
		self.ListParam[3]:setVisible(false)
		local size = self.ListParam[2]:getContentSize()
		self.ListParam[1]:setContentSize(size.width,10)
		self.ListParam[2]:setContentSize(size.width,110)
		self.ListParam[3]:setContentSize(size.width,10)
		self.ListView:refreshView()
	else
		self.ListParam[2]:setVisible(false)
	end
end

function Trusteeship:OnLootDealerType(index)

end

function Trusteeship:OnLootDealer(index)

end

function Trusteeship:OnPushPledgeTypeSwitch(index)
	if index == 3 then
		self.ListParam[3]:setVisible(true)
		self.ListParam[1]:setVisible(false)
		self.ListParam[2]:setVisible(false)
		local size = self.ListParam[3]:getContentSize()
		self.ListParam[1]:setContentSize(size.width,10)
		self.ListParam[2]:setContentSize(size.width,10)
		self.ListParam[3]:setContentSize(size.width,50)
		self.ListView:refreshView()
	else
		self.ListParam[3]:setVisible(false)
	end
end

function Trusteeship:OnPushPledgeType(index)

end

return Trusteeship