
local gt = cc.exports.gt

local HelpLayer = class("HelpLayer", function()
	return gt.createMaskLayer()
end)

function HelpLayer:ctor()
	local csbNode = cc.CSLoader:createNode("csd/Rule.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.rootNode = csbNode
    
	
	-- 关闭按钮
	local backBtn = gt.seekNodeByName(csbNode, "Btn_Close")
	gt.addBtnPressedListener(backBtn, function()
		-- 移除界面,返回主界面
		self:removeFromParent()
	end)
	
    local btnNiu = gt.seekNodeByName(csbNode, "Btn_Niu")
    local btnSG = gt.seekNodeByName(csbNode, "Btn_SG")
    local btnTTZ = gt.seekNodeByName(csbNode, "Btn_TTZ")
    local btnZJH = gt.seekNodeByName(csbNode, "Btn_ZJH")
     local btnSSS = gt.seekNodeByName(csbNode, "Btn_SSS")
    local scrollVwNiu = gt.seekNodeByName(csbNode, "ScrollView_Niu")
    local scrollVwSG = gt.seekNodeByName(csbNode, "ScrollView_SG")
    local scrollVwTTZ = gt.seekNodeByName(csbNode, "ScrollView_TTZ")
    local scrollVwZJH = gt.seekNodeByName(csbNode, "ScrollView_ZJH")
    local scrollVwSSS = gt.seekNodeByName(csbNode, "ScrollView_SSS")

    scrollVwNiu:setVisible(true)
    scrollVwSG:setVisible(false)
    scrollVwTTZ:setVisible(false)
    scrollVwZJH:setVisible(false)
    scrollVwSSS:setVisible(false)

    local function showBtnAndScroll(type)
        btnNiu:setEnabled(type ~= 1)
        btnSG:setEnabled(type ~= 2)
        btnTTZ:setEnabled(type ~= 3)
        btnZJH:setEnabled(type ~= 4)
        btnSSS:setEnabled(type ~= 5)

        scrollVwNiu:setVisible(type == 1)
        scrollVwSG:setVisible(type == 2)
        scrollVwTTZ:setVisible(type == 3)
        scrollVwZJH:setVisible(type == 4)
        scrollVwSSS:setVisible(type == 5)
    end

    gt.addBtnPressedListener(btnNiu, function(sender)
        showBtnAndScroll(1)
    end)
    gt.addBtnPressedListener(btnSG, function(sender)
        showBtnAndScroll(2)
    end)
    gt.addBtnPressedListener(btnTTZ, function(sender)
        showBtnAndScroll(3)
    end)
     gt.addBtnPressedListener(btnZJH, function(sender)
        showBtnAndScroll(4)
    end)
     gt.addBtnPressedListener(btnSSS, function(sender)
        showBtnAndScroll(5)
    end)
end

return HelpLayer

