--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local Announcement = class("Announcement", function()
	return gt.createMaskLayer()
end)

function Announcement:ctor(msgTbl)
    local csbNode = cc.CSLoader:createNode("csd/Announcement.csb")
	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	self:addChild(csbNode)
	self.rootNode = csbNode

    self.panelStatement = gt.seekNodeByName(csbNode, "Panel_Statement")
    self.panelUpdata = gt.seekNodeByName(csbNode, "Panel_Updata")
    self.textUpdata = gt.seekNodeByName(self.panelUpdata, "Text_Updata")
    self.panelStatement0=gt.seekNodeByName(csbNode,"Panel_Statement0")
    self.panelActivity=gt.seekNodeByName(csbNode,"Panel_Activity")
    self.btnEnterActivity=gt.seekNodeByName(self.panelActivity,"Btn_EnterActivity")
    if self.btnEnterActivity then
        self.btnEnterActivity:setEnabled(gt.openSport)
        self.btnEnterActivity:addClickEventListener(function()
            gt.soundEngine:playEffect(gt.clickBtnAudio, false)
            local sportLayer = require("app/views/Sport/SportView"):create()
            self:addChild(sportLayer)
        end)
    end
    self.panelAgencyLogin = gt.seekNodeByName(csbNode,"Panel_AgencyLogin")
    -- 关闭按钮
    local btnClose = gt.seekNodeByName(csbNode, "Btn_Close")
    gt.addBtnPressedListener(btnClose, function()
        self:removeFromParent()
        gt.dispatchEvent(gt.EventType.CLOSE_ANNOUNCEMENTLAYER)
        gt.removeTargetEventListenerByType(self, gt.EventType.SHOW_UPDATA_ANNOUNCE)
    end)
    
    self.btnUpdata = gt.seekNodeByName(csbNode, "Btn_Updata")
    self.btnStatement = gt.seekNodeByName(csbNode, "Btn_Statement")
    self.btnStatement0 = gt.seekNodeByName(csbNode, "Btn_Statement0")
    self.btnActivity = gt.seekNodeByName(csbNode, "Btn_Activity")
    self.btnAgencyLogin = gt.seekNodeByName(csbNode, "Btn_AgencyLogin")

    -- 声明公告(悬赏)
    gt.addBtnPressedListener(self.btnStatement, function()
        self:showAnnouncementPanel(1)
    end)
        
    -- 更新公告
    gt.addBtnPressedListener(self.btnUpdata, function()
        self:showAnnouncementPanel(2)
    end)

    --声明公告
    gt.addBtnPressedListener(self.btnStatement0,function()
        self:showAnnouncementPanel(3)
    end)

    --限时活动
    gt.addBtnPressedListener(self.btnActivity,function()
        self:showAnnouncementPanel(4)
    end)
	
	--代理登录
    gt.addBtnPressedListener(self.btnAgencyLogin,function()
        self:showAnnouncementPanel(5)
    end)

    local time = os.time()
    --屏蔽限时活动
    self:showAnnouncementPanel(5)
    self.btnActivity:setVisible(false)
    if msgTbl then
        self:showAnnouncementPanel(2)
    end
    self:refreshTextUpdate()
    gt.registerEventListener(gt.EventType.SHOW_UPDATA_ANNOUNCE, self, self.showUpdatePanel)
end

function Announcement:showAnnouncementPanel(type)
    self.panelStatement:setVisible(type == 1)
    self.panelUpdata:setVisible(type == 2)
    self.panelStatement0:setVisible(type==3)
    self.panelActivity:setVisible(type==4)
    self.panelAgencyLogin:setVisible(type==5)
	
    self.btnStatement:setEnabled(type ~= 1)
    self.btnUpdata:setEnabled(type ~= 2)
    self.btnStatement0:setEnabled(type~=3)
    self.btnActivity:setEnabled(type~=4)
    self.btnAgencyLogin:setEnabled(type~=5)
end

function Announcement:refreshTextUpdate()
    local updataContent = cc.UserDefault:getInstance():getStringForKey("updataContent", "")
    self.textUpdata:setString(updataContent)
    local textSize = self.textUpdata:getContentSize()
    self.textUpdata:setVisible(false)

    -- updataContent = "<big>本次更新内容111:</big><br/>1.这是个<u>下划线</u>的字, 还有<del>删除线</del>的字<br/>2.这个是<i>斜体</i>字<br/>3.这个是<b>加粗</b>字<br/>4.这个是<big>大</big>的<small>小</small>的字体<br/>5. 还可以有<glow color='#AF00EE'>发光</glow>的字<br/><img src='image/mainNew/flagLantern.png'  width='157' height='185'/><br/>维护时间：<font color='#ff0000'>变红2019.2.14 </font>  <font color='#00ff00'>变绿6:00-10:00</font>.<br/>服务器进行维护，请不要在维护时间内进行游戏，以免带来不必要损失。"

    local xmlString = string.format("<font face='font/main.ttf' size='24'>%s</font>",updataContent)
    gt.log("----:"..xmlString)

    self.richLabel = ccui.RichText:createWithXML(xmlString,{})
    if self.richLabel == nil then
        self.textUpdata:setString(updataContent)
        self.textUpdata:setVisible(true)
    else
        self.richLabel:setContentSize(textSize)
        self.richLabel:ignoreContentAdaptWithSize(false)
        self.richLabel:setAnchorPoint(0.5,1)
        self.richLabel:setPosition(self.textUpdata:getPosition())
        self.textUpdata:getParent():addChild(self.richLabel)
    end

end

function Announcement:showUpdatePanel()
    self:refreshTextUpdate()
    self:showAnnouncementPanel(2)
end

return Announcement
--endregion
