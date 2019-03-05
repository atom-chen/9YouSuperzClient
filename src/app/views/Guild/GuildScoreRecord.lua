-- 俱乐部上下分日志

local gt = cc.exports.gt

local GuildScoreRecord = class("GuildScoreRecord", function()
	return gt.createMaskLayer()
end)

function GuildScoreRecord:ctor(guild_id)
	self:registerScriptHandler(handler(self, self.onNodeEvent))

	local csbNode = cc.CSLoader:createNode("csd/Guild/GuildScoreRecord.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode
	self.currentGuild = nil

	self.guild_id = guild_id
	self.currentGuild = gt.guildManager:getGuild(guild_id)
	gt.log("-----openUI:GuildScoreRecord")
	self:initUI()
	self:initListRecord()
	self:initSelect()
	self:sendScoreRecords(1)

	gt.socketClient:registerMsgListener(gt.GUILD_SCORE_RECORDS, self, self.onRcvScoreRecords)
end 

function GuildScoreRecord:initUI()
	local btnClose = gt.seekNodeByName(self.csbNode, "btnClose")
	gt.addBtnPressedListener(btnClose, function()
		self:close()
	end)

	local btnBack = gt.seekNodeByName(self.csbNode, "btnBack")
	gt.addBtnPressedListener(btnBack, function()
		self:close() 
	end)

	local btnRecordUp = gt.seekNodeByName(self.csbNode, "btnRecordUp")
	gt.addBtnPressedListener(btnRecordUp, function()
		self:sendScoreRecords(1)
	end)
	self.btnRecordUp = btnRecordUp


	local btnRecordDown = gt.seekNodeByName(self.csbNode, "btnRecordDown")
	gt.addBtnPressedListener(btnRecordDown, function()
		self:sendScoreRecords(2)
	end)
	self.btnRecordDown = btnRecordDown

	self.lblScoreYesterDay = gt.seekNodeByName(self.csbNode, "lblScoreYesterDay")
	self.lblScoreYesterDay:setVisible(false)
	self.lblHeadUp = gt.seekNodeByName(self.csbNode, "lblHeadUp")
	self.lblHeadUp:setVisible(false)
	self.lblHeadDown = gt.seekNodeByName(self.csbNode, "lblHeadDown")
	self.lblHeadDown:setVisible(false)
	self.lblScoreUpYesterdayStr = gt.seekNodeByName(self.csbNode, "lblScoreUpYesterdayStr")
	self.lblScoreUpYesterdayStr:setVisible(false)
	self.lblScoreDownYesterdayStr = gt.seekNodeByName(self.csbNode, "lblScoreDownYesterdayStr")
	self.lblScoreDownYesterdayStr:setVisible(false)

	self.curTag = 999
end


function GuildScoreRecord:onNodeEvent(eventName)
	if "enter" == eventName then
		
	elseif "exit" == eventName then
		
		if self.listRecord_helper then
            self.listRecord_helper:Release()
            self.listRecord_helper = nil
        end
	end
end

function GuildScoreRecord:initSelect()

	local imgSelectBg = gt.seekNodeByName(self.csbNode,"imgSelectBg")
	self.popSelect = imgSelectBg:getChildByName("ImgSelectPop")
	self.popSelect:setVisible(false)
	imgSelectBg:addClickEventListener(function()
		self.popSelect:setVisible(not self.popSelect:isVisible())
	end)

	local btnOpen = imgSelectBg:getChildByName("Btn_Open")
	btnOpen:addClickEventListener(function()
		self.popSelect:setVisible(not self.popSelect:isVisible())
	end)

	self.lblSelect = gt.seekNodeByName(self.csbNode,"lblSelect")

	self.lstSelects = gt.seekNodeByName(self.csbNode,"lstSelects")
	self.panelItem = self.lstSelects:getChildByName("btnChose")
	self.panelItem:retain()

	local function onItemChose(sender)
		local tag = sender:getTag()
		  
		self.popSelect:setVisible(false)

		self.curTag = tag
		self:refreshSelect()
	end
	self.onItemChose = onItemChose

end

function GuildScoreRecord:refreshSelect()

	local curData = self.recordsData
	self.lblSelect:setString("All")
	if self.curTag ~= 999 and self.recordsAdminData and self.recordsAdminData[self.curTag] and #self.recordsAdminData[self.curTag] > 0 then
		curData = self.recordsAdminData[self.curTag] 
		self.lblSelect:setString(self.curTag)
	end

	self.listRecord_helper:SetItemsData({})
    local delay_call = function ()
    	self.listRecord_helper:SetItemsData(curData, true)
    end
    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))

    local curTotal = 0
    if self.curTag == 999 then
    	curTotal = self.msgTbl.yesterdayTotal
    else
    	-- gt.dump(self.msgTbl.yesterdayTotals)
    	for k, v in pairs(self.msgTbl.yesterdayTotals) do
    		if k == self.curTag then
    			curTotal = v
    		end
    	end
    end
	self.lblScoreYesterDay:setVisible(true)
	self.lblScoreYesterDay:setString(curTotal)
end

function GuildScoreRecord:initListRecord()

	self.lstRecords = gt.seekNodeByName(self.csbNode,"List_Records") 
	
	self.pRecordTemplate = self.lstRecords:getChildByName("panelItem")
	self.pRecordTemplate:retain()
	self.lstRecords:removeAllChildren()

	self.lblListNoStr = gt.seekNodeByName(self.csbNode,"lblListNoStr") 
	self.lblListNoStr:setVisible(false)

	--记录列表的辅助工具    
    if cc.exports.ListViewHelper == nil then
        require "app/ListViewHelper"
    end
    --创建列表item的函数
    if self.listRecord_helper == nil then
        local create_item_func = function (v, i, cached_item)
            local item = self:CreateRecordItem(v, i, cached_item or self.pRecordTemplate:clone())
            return item
        end
        self.listRecord_helper = ListViewHelper:create(self.lstRecords, self.pRecordTemplate, create_item_func, true)
    end
end

function GuildScoreRecord:refreshUpDownState() -- scoreType 1 up 2 down
	self.btnRecordUp:setEnabled(self.scoreType ~= 1)
	self.btnRecordDown:setEnabled(self.scoreType ~= 2)
	self.lblHeadUp:setVisible(self.scoreType == 1)
	self.lblHeadDown:setVisible(self.scoreType == 2)
	self.lblScoreUpYesterdayStr:setVisible(self.scoreType == 1)
	self.lblScoreDownYesterdayStr:setVisible(self.scoreType == 2)
end

function GuildScoreRecord:sendScoreRecords(scoreType) --scoreType 1 up 2 down
	self.scoreType = scoreType

	local msgToSend = {}
	msgToSend.cmd = gt.GUILD_SCORE_RECORDS
	msgToSend.open_id = gt.playerData.openid
	msgToSend.guild_id = self.guild_id
	msgToSend.user_id = gt.playerData.uid
	msgToSend.score_type = scoreType
	gt.socketClient:sendMessage(msgToSend)

	gt.showLoadingTips("")
	self:refreshUpDownState()
end

function GuildScoreRecord:CreateRecordItem(v, i, pItem)
	
	pItem:getChildByName("lblRecordAdminName"):setString(tostring(v.admin_nick))
	pItem:getChildByName("lblRecordAdminId"):setString(tostring(v.admin_id))
	pItem:getChildByName("lblRecordTargetId"):setString(tostring(v.target_id))
	pItem:getChildByName("lblRecordScore"):setString(tostring(v.score))
	pItem:getChildByName("lblRecordTime"):setString(os.date("%Y.%m.%d  %H:%M:%S", v.record_time))

	return pItem
end

function GuildScoreRecord:convertToAdminList(listData_)
	local lstDataAdmin = {}
	-- lstData5 = listData_
	-- gt.dump(listData_)

	for i, record in ipairs(listData_) do
		local x = listData_[i].admin_id
		if lstDataAdmin[x] == nil then 
			lstDataAdmin[x] = {} 
		end
		table.insert(lstDataAdmin[x], record)
	end

	-- gt.dump(lstDataAdmin)
	return lstDataAdmin
end
 
function GuildScoreRecord:refreshSelectsList()
	self.lstSelects:removeAllChildren()

	local itemAll =  self.panelItem:clone()
	itemAll:setTag(999)
	itemAll:addClickEventListener(self.onItemChose)
	self.lstSelects:pushBackCustomItem(itemAll)

	self.recordsAdminData = self:convertToAdminList(self.recordsData)

	for k,v in pairs(self.recordsAdminData) do
		if #v > 0 then
			local item =  self.panelItem:clone()
			item:setTitleText(k)
			item:setTag(k)
			item:addClickEventListener(self.onItemChose)
			self.lstSelects:pushBackCustomItem(item)
		end
	end
end

function GuildScoreRecord:onRcvScoreRecords(msgTbl)
	gt.removeLoadingTips()
	self.msgTbl = msgTbl

	local page = msgTbl.page + 1
	if page == 1 then
		self.recordsData = msgTbl.records
	else
		if self.recordsData then
			for i, v in ipairs(msgTbl.records) do
				table.insert(self.recordsData, v)
			end
		end
	end

	table.sort(self.recordsData, function( a, b)
		return a.record_time > b.record_time
	end)

	self.lblListNoStr:setVisible(#self.recordsData <= 0)

	if page * msgTbl.pre_page >= msgTbl.total then

		self:refreshSelectsList()

		-- self.listRecord_helper:SetItemsData({})
	 --    local delay_call = function ()
	 --    	self.listRecord_helper:SetItemsData(self.recordsData, true)
	 --    	-- self:updateTotalScore()
	 --    end
	 --    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(delay_call)))
	 	self:refreshSelect()
	end
	-- self.lblScoreYesterDay:setVisible(true)
	-- self.lblScoreYesterDay:setString(msgTbl.yesterdayTotal)

end


function GuildScoreRecord:close()

	gt.socketClient:unregisterMsgListener(gt.GUILD_SCORE_RECORDS)

	self.lstRecords:removeAllChildren()
	self.pRecordTemplate:release()

	if self.listRecord_helper then
        self.listRecord_helper:Release()
        self.listRecord_helper = nil
    end

	self:removeFromParent()
end

return GuildScoreRecord