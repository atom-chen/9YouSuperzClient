-- 赛场详情

local gt = cc.exports.gt

local SportDetail = class("SportDetail", function()
	return gt.createMaskLayer()
end)

function SportDetail:ctor(tid)
	local csbNode = cc.CSLoader:createNode("csd/Sport/SportDetail.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.csbNode = csbNode

	local lblDetail = gt.seekNodeByName(csbNode, "Label_Detail")
	local config = gt.sportManager:getConfigByTid(tid)
	lblDetail:setString(config.detail)

	local pDetail = gt.seekNodeByName(csbNode, "Panel_Detail")
	pDetail:addClickEventListener(function(sender)
		self:removeFromParent()
	end)
end


return SportDetail
