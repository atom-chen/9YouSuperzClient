--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local Service = class("Service", function()
	return gt.createMaskLayer()
end)

local gt = cc.exports.gt

function Service:ctor()
    local csbNode = cc.CSLoader:createNode("csd/Service.csb")
    csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode

    --关闭按钮
    local btnClose = gt.seekNodeByName(csbNode, "Btn_Close")
    gt.addBtnPressedListener(btnClose, function()
        self:removeFromParent()
    end)

    self:initListContacts()
    self:refreshListContacts()
end

function Service:initListContacts()
    local lstContacts = gt.seekNodeByName(self.csbNode,"lstContacts") 

    self.panelItemWX = lstContacts:getChildByName("panelWX")
    self.panelItemWX:retain()
    self.panelItemWXPublic = lstContacts:getChildByName("panelWXPublic")
    self.panelItemWXPublic:retain()

    lstContacts:removeAllChildren()
    self.lstContacts = lstContacts
end

function Service:refreshListContacts()
    local lstData = gt.playerData.contact
    gt.dump(lstData)

    local count = #lstData
    for i = 1, count do 
        local item
        if i == 2 then
            item =  self.panelItemWXPublic:clone()
        else
            item =  self.panelItemWX:clone()
        end
		
		local lblContact = item:getChildByName("lblContact")
        if lstData[i] then
            lblContact:setString(lstData[i])
        end
		
		 --复制按钮
		local btnCopy = item:getChildByName("Btn_Copy")
		gt.addBtnPressedListener(btnCopy, function()
			local contactStr = lblContact:getString()
			extension.copyToClipboard(contactStr)
		end)
	
        self.lstContacts:pushBackCustomItem(item)
    end

end

return Service
--endregion
