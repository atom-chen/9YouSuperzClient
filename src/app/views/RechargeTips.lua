--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local gt = cc.exports.gt

local RechargeTips = class("RechargeTips", function()
    return cc.Layer:create()
end)

function RechargeTips:ctor(showType, diamond, money, chargeUser, rcType)
    local csbNode = cc.CSLoader:createNode("csd/RechargeTips.csb")
    csbNode:setAnchorPoint(0.5, 0.5)
    csbNode:setPosition(gt.winCenter)
    self:addChild(csbNode)

    local node1 = gt.seekNodeByName(csbNode, "Node_Daichong")
    local node2 = gt.seekNodeByName(csbNode, "Node_Recharge_Success")

    if showType == 1 then  -- 代充界面
        node2:setVisible(false)
        local idBg = gt.seekNodeByName(node1, "Text_ID"):setString(chargeUser)
        local diamondValue = gt.seekNodeByName(node1,"Text_DiamondValue")
        local moneyValue = gt.seekNodeByName(node1, "Text_MoneyValue")
        diamondValue:setString(diamond)
        moneyValue:setString( string.format("￥ %s", money))
        local btnOk = gt.seekNodeByName(node1, "Btn_Ok")
        gt.addBtnPressedListener(btnOk, function()
            gt.dispatchEvent(gt.EventType.CREATE_PAY_ORDER, chargeUser)
			self:removeFromParent()
        end)
		local btnCancel = gt.seekNodeByName(node1, "Btn_Cancel")
        gt.addBtnPressedListener(btnCancel, function()
            self:removeFromParent()
        end)
    elseif showType == 2 then  -- 充值成功
        node1:setVisible(false)
		local tip = ""
        if rcType == 0 then
            if chargeUser == gt.playerData.uid then
			    tip = "恭喜获得"..diamond.."房卡"
		    else
			    tip = "您给用户ID："..chargeUser.."代充"..diamond.."房卡已成功到账"
		    end
        else
		    if chargeUser == gt.playerData.uid then
			    tip = "恭喜获得"..diamond.."比赛券"
		    else
			    tip = "您给用户ID："..chargeUser.."代充"..diamond.."比赛券已成功到账"
		    end
        end
        node2:getChildByName("Text_Tip"):setString(tip)
        local btnOk = gt.seekNodeByName(node2, "Btn_OK")
        gt.addBtnPressedListener(btnOk, function()
            self:removeFromParent()
        end)
    end

    local panel = gt.seekNodeByName(csbNode, "Panel_Bg")
    panel:addClickEventListener(function(sender)
        self:removeFromParent()
    end)
end

return RechargeTips

--endregion
