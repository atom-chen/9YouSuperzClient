local gt = cc.exports.gt

package.loaded["app/Extension"] = nil
package.preload["app/Extension"] = nil
cc.FileUtils:getInstance():purgeCachedEntries()


local logonmanifest_filename = "logon.manifest"
local logonmanifest_romote_url = "http://apps.xmsgl2017.com/szn/logon/logon.manifest"
local writePath = cc.FileUtils:getInstance():getWritablePath()

require("app/localizations/LocationUtil")
require("app/DefineConfig")
require("app/Extension")
require("app/views/MyTools")
gt.SocketClientManage = require("app/SocketClientManage")

local LoginScene = class("LoginScene", function()
	return cc.Scene:create()
end)

function LoginScene:ctor()
	--清理纹理
	cc.SpriteFrameCache:getInstance():removeUnusedSpriteFrames()
	cc.Director:getInstance():getTextureCache():removeUnusedTextures()
	
	if gt.isShowPoco == true then
		local pocoManager = require('lib.poco.poco_manager')
	    pocoManager:init_server(15004)
	end

	self.needLoginWXState = 0 -- 本地微信登录状态
	-- 注册节点事件
	self:registerScriptHandler(handler(self, self.onNodeEvent))

	local csbNode = cc.CSLoader:createNode("csd/Login.csb")
    	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
    ccui.Helper:doLayout(csbNode)
	self:addChild(csbNode)
	self.rootNode = csbNode
    self.reLoginCnt = 0


    for i = 1, 2 do
        local scrollWord = gt.seekNodeByName(csbNode, "Img_Scroll_Word"..i)
        scrollWord:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(1, cc.p(-40, 0)),
        cc.CallFunc:create(function()
        if scrollWord:getPositionX() <= -2042 then
            scrollWord:setPositionX(2042)
        end
        end))))
    end

	self.skLogo = sp.SkeletonAnimation:create("image/login/logo.json", "image/login/logo.atlas")
	gt.seekNodeByName(csbNode, "Node_Logo"):addChild(self.skLogo)
    self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
			self.skLogo :setAnimation(0, "in", false)
		end),
		cc.DelayTime:create(2),
		cc.CallFunc:create(function()
			self.skLogo:setAnimation(0, "daiji", true)
		end)))
    gt.soundEngine:playEffect("open_animation", nil)

	-- gt.messageManager = require("app/protocols/MessageManager"):create()
	-- 初始化Socket网络通信
	gt.socketClient = require("app/SocketClient"):create()

	-- Tools
	gt.commonTool = require("app/CommonTool"):create()

	-- 初始化比赛管理
	gt.sportManager = require("app/views/Sport/SportManager"):create()

	-- 微信登录
	local wxLoginBtn = gt.seekNodeByName(csbNode, "Btn_WxLogin")
		-- 微信登录按钮
	gt.addBtnPressedListener(wxLoginBtn, function()
		if not self:checkAgreement() then
			return
		end

		if self.autoLoginRet == true then
			return
		end

		-- 提示安装微信客户端
		if not extension.isInstallWeiXin() then
			-- 安卓一直显示微信登录按钮
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0031"), nil, nil, true)
			return
		end

		-- 微信授权登录
		extension.getWeixinToken(handler(self, self.pushWXAuthCode))
	end)

	-- 游客登录
	local travelerLoginBtn = gt.seekNodeByName(csbNode, "Btn_TravelerLogin")

	gt.addBtnPressedListener(travelerLoginBtn, function()

		if not self:checkAgreement() then
			return
		end

		gt.showLoadingTips(gt.getLocationString("LTKey_0003"))

		-- 获取名字
		local userNameEdit = gt.seekNodeByName(csbNode, "Edit_UserName")
		local openUDID = userNameEdit:getString()
		if ""==openUDID then
			openUDID = "w1"
		end
		if "1"== openUDID then
			openUDID = ""
		end
		local nickname = openUDID
		if string.len(openUDID)==0 then -- 没有填写用户名
			openUDID = cc.UserDefault:getInstance():getStringForKey("openUDID_TIME")
			if string.len(openUDID) == 0 then
				openUDID = tostring(os.time())
				cc.UserDefault:getInstance():setStringForKey("openUDID_TIME", openUDID)
			end
		end
		if string.len(nickname) == 0 then
			cc.UserDefault:getInstance():getStringForKey("openUDID")
			if string.len(nickname) == 0 then
				nickname = "游客:" .. gt.getRangeRandom(1, 9999)

				cc.UserDefault:getInstance():setStringForKey("openUDID", nickname)
			end
		end

		gt.log("====链接的ip和端口",gt.LoginServer.ip, gt.LoginServer.port)

		gt.socketClient:connect(gt.LoginServer.ip, gt.LoginServer.port, true)

		local msgToSend = {}
		msgToSend.cmd = gt.LOGIN
		msgToSend.open_id = openUDID
		msgToSend.union_id = "visitor"..nickname
		msgToSend.logon_type = 2  --游客登陆
		msgToSend.nick = nickname
		msgToSend.plate = "local"
		msgToSend.ver = gt.resVersion
		msgToSend.ac_token = "visitor"..nickname
		msgToSend.rf_token = "visitor"..nickname
		msgToSend.app_id = gt.app_id
		msgToSend.sex = 1
		msgToSend.icon = ""
		msgToSend.loc = ""
		msgToSend.t = tostring(os.time())
		local checkStr1 = msgToSend.open_id..msgToSend.ac_token..msgToSend.plate..msgToSend.ver.."#klqp"
		local checkStr2 = msgToSend.union_id..msgToSend.rf_token..msgToSend.t.."#klqp"
		msgToSend.c1 = gt.CRC(checkStr1, string.len(checkStr1))
		msgToSend.c2 = gt.CRC(checkStr2, string.len(checkStr2))
        
		gt.socketClient:sendMessage(msgToSend)

		local playerData = gt.playerData
		playerData.openid = openUDID

		-- 保存sex,nikename,headimgurl,uuid,serverid等内容
		cc.UserDefault:getInstance():setStringForKey( "WX_Sex", tostring(1) )
		cc.UserDefault:getInstance():setStringForKey( "WX_Uuid", msgToSend.union_id )
		gt.wxNickName = msgToSend.nick
		cc.UserDefault:getInstance():setStringForKey( "WX_ImageUrl", msgToSend.icon )
	end)
	
	-- 手机登录
	local mobileLoginBtn = gt.seekNodeByName(csbNode, "Btn_MobileLogin")
	gt.addBtnPressedListener(mobileLoginBtn, function()
		if not self:checkAgreement() then
			return
		end
		self.needLoginWXState = 3
		local mob = require("app/views/MobileLogin"):create()
		self:addChild(mob)
	end)

	if gt.isIOSReview() then
		-- 苹果设备在评审状态没有安装微信情况下显示游客登录
		travelerLoginBtn:setVisible(true)
		wxLoginBtn:setVisible(false)
		mobileLoginBtn:setVisible(false)
		gt.seekNodeByName(csbNode, "Img_UserName"):setVisible(false)
        travelerLoginBtn:setPositionX(travelerLoginBtn:getParent():getContentSize().width*0.5)
	elseif gt.localVersion == false then
		travelerLoginBtn:setVisible(false)
		wxLoginBtn:setVisible(true)
		mobileLoginBtn:setVisible(true)
		gt.seekNodeByName(csbNode, "Img_UserName"):setVisible(false)
        --wxLoginBtn:setPositionX(wxLoginBtn:getParent():getContentSize().width*0.5)
		mobileLoginBtn:setPosition(travelerLoginBtn:getPosition())
	end

	-- 用户协议
    local nodeUserAgreement = gt.seekNodeByName(csbNode, "Node_UserAgreement")
	local btnUserAgreement = gt.seekNodeByName(nodeUserAgreement, "Btn_Pop_UserAgreement")
    gt.addBtnPressedListener(btnUserAgreement, function()
		local userAgreement = require("app/views/UserAgreement"):create()
		self:addChild(userAgreement, 6)
	end)

  	self.m_agreeMark = gt.seekNodeByName(nodeUserAgreement, "Img_Mark")
    local btnAgree = gt.seekNodeByName(nodeUserAgreement, "Btn_Agree_UserAgreement")
    gt.addBtnPressedListener(btnAgree, function ()
        self.m_agreeMark:setVisible(not self.m_agreeMark:isVisible())
    end)

	-- 资源版本号
	local versionLabel = gt.seekNodeByName(csbNode, "Label_version")
	versionLabel:setString(gt.resVersion)

	gt.socketClient:registerMsgListener(gt.LOGIN, self, self.onRcvLogin)
	gt.socketClient:registerMsgListener(gt.NOTICE, self, self.onRcvMarquee)
	gt.socketClient:registerMsgListener(gt.ENTER_HALL, self, self.onRcvEnterHall)

	gt.socketClient:setIsLogined(false)

    local Img_Bg = gt.seekNodeByName(csbNode, "Img_Bg")

    
end

function LoginScene:getHttpServerIp(uuid)
	local xhr = cc.XMLHttpRequest:new()
	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
	xhr:open("POST", gt.loginIpUrl)
	local function onResp()
		if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
			local response = xhr.response
			gt.log(response)
			require("json")
			local respJson = json.decode(response)
			if respJson.code == 0 or respJson.code == "0" then 
				gt.LoginServer.ip = respJson.ip -- 获得可用ip
				gt.LoginServer.port = respJson.port -- port
			end
		elseif xhr.readyState == 1 and xhr.status == 0 then
			-- 请求出错
			gt.log("获取登录IP失败")
		end
		xhr:unregisterScriptHandler()
		self:sendRealLogin( self.accessToken, self.refreshToken, self.openid, self.sex, self.nickname, self.headimgurl, self.unionid)
	end
	xhr:registerScriptHandler(onResp)
	xhr:send(string.format("app_id=%d&uuid=%s", gt.app_id, uuid))
end

function LoginScene:onNodeEvent(eventName)
	if "enter" == eventName then

		if not gt.localVersion and not gt.isIOSReview() then
			self:startUpdate()
		end

		-- if gt.localVersion == false and not gt.isIOSReview() then
		-- 	-- 自动登录
		-- 	self.autoLoginRet = self:checkAutoLogin()
		-- 	if self.autoLoginRet == false then -- 需要重新登录的话,停止转圈
		-- 		gt.removeLoadingTips()
		-- 	end
		-- end
		-- 播放背景音乐
		gt.soundEngine:playMusic("bgm1", true)

		-- 触摸事件
		local listener = cc.EventListenerTouchOneByOne:create()
		listener:setSwallowTouches(true)
		listener:registerScriptHandler(handler(self, self.onTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
		listener:registerScriptHandler(handler(self, self.onTouchEnded), cc.Handler.EVENT_TOUCH_ENDED)
		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
	elseif "exit" == eventName then
		self:unregisterAllMsgListener()

		if self.scheduleHandler then
	        gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
			self.scheduleHandler = nil
	    end 

	    if self.scheduleLogin then
            gt.scheduler:unscheduleScriptEntry(self.scheduleLogin)
            self.scheduleLogin = nil
        end 
	end
end

function LoginScene:onTouchBegan(touch, event)
	return true
end

function LoginScene:onTouchEnded(touch, event)
end

function LoginScene:unregisterAllMsgListener()
	gt.socketClient:unregisterMsgListener(gt.LOGIN)
	gt.socketClient:unregisterMsgListener(gt.NOTICE)
	gt.socketClient:unregisterMsgListener(gt.ENTER_HALL)
	
	if self.xhrAccessToken then
		self.xhrAccessToken:unregisterScriptHandler()
	end
end

function LoginScene:checkAutoLogin()

	local lastLoginType = cc.UserDefault:getInstance():getIntegerForKey( "LAST_LOGIN_TYPE",0 )  -- 0 first 1.mobile. 2.wx
	if lastLoginType  == 1 then
		self.needLoginWXState = 3 
		local mob = require("app/views/MobileLogin"):create(1)
		self:addChild(mob)
		return true
	end
	
	-- 转圈
	gt.showLoadingTips(gt.getLocationString("LTKey_0003"))

	-- 获取记录中的token,freshtoken时间
	local accessTokenTime  = cc.UserDefault:getInstance():getStringForKey( "WX_Access_Token_Time" )
	local refreshTokenTime = cc.UserDefault:getInstance():getStringForKey( "WX_Refresh_Token_Time" )

	if string.len(accessTokenTime) == 0 or string.len(refreshTokenTime) == 0 then -- 未记录过微信token,freshtoken,说明是第一次登录
		return false
	end

	-- 检测是否超时
	local curTime = os.time()
	local accessTokenReconnectTime  = 5400    -- 3600*1.5   微信accesstoken默认有效时间未2小时,这里取1.5,1.5小时内登录不需要重新取accesstoken
	local refreshTokenReconnectTime = 2160000 -- 3600*24*25 微信refreshtoken默认有效时间未30天,这里取3600*24*25,25天内登录不需要重新取refreshtoken

	-- 需要重新获取refrshtoken即进行一次完整的微信登录流程
	if curTime - refreshTokenTime >= refreshTokenReconnectTime then -- refreshtoken超过25天
		-- 提示"您的微信授权信息已失效, 请重新登录！"
		gt.removeLoadingTips()
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0030")..":1", nil, nil, true)
		return false
	end

	-- 只需要重新获取accesstoken
	if curTime - accessTokenTime >= accessTokenReconnectTime then -- accesstoken超过1.5小时
		local xhr = cc.XMLHttpRequest:new()
		xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
		local appID = gt.wxId;
		local refreshTokenURL = string.format("https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%s&grant_type=refresh_token&refresh_token=%s", appID, cc.UserDefault:getInstance():getStringForKey( "WX_Refresh_Token" ))
		xhr:open("GET", refreshTokenURL)
		local function onResp()
			gt.log("xhr.readyState is:" .. xhr.readyState .. " xhr.status is: " .. xhr.status)
			if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
				local response = xhr.response
				require("json")
				local respJson = json.decode(response)
				if respJson.errcode then
					-- 申请失败,清除accessToken,refreshToken等信息
					cc.UserDefault:getInstance():setStringForKey("WX_Access_Token", "")
					cc.UserDefault:getInstance():setStringForKey("WX_Refresh_Token", "")
					cc.UserDefault:getInstance():setStringForKey("WX_Access_Token_Time", "")
					cc.UserDefault:getInstance():setStringForKey("WX_Refresh_Token_Time", "")
					cc.UserDefault:getInstance():setStringForKey("WX_OpenId", "")

					-- 清理掉圈圈
					gt.removeLoadingTips()
					self.autoLoginRet = false
				else
					self.needLoginWXState = 2 -- 需要更新accesstoken以及其时间

					local accessToken = respJson.access_token
					local refreshToken = respJson.refresh_token
					local openid = respJson.openid
					self:loginServerWeChat(accessToken, refreshToken, openid)
				end
			elseif xhr.readyState == 1 and xhr.status == 0 then
				-- 本地网络连接断开
				require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0014"), nil, nil, true)
				-- 清理掉圈圈
				gt.removeLoadingTips()
				self.autoLoginRet = false
			end
			xhr:unregisterScriptHandler()
		end
		xhr:registerScriptHandler(onResp)
		xhr:send()

		return true
	end

	-- accesstoken未过期,freshtoken未过期 则直接登录即可
	self.needLoginWXState = 1

	local accessToken 	= cc.UserDefault:getInstance():getStringForKey( "WX_Access_Token" )
	local refreshToken 	= cc.UserDefault:getInstance():getStringForKey( "WX_Refresh_Token" )
	local openid 		= cc.UserDefault:getInstance():getStringForKey( "WX_OpenId" )

	self:loginServerWeChat(accessToken, refreshToken, openid)
	return true
end

function LoginScene:onRcvLogin(msgTbl)
	gt.removeLoadingTips()
	self.autoLoginRet = false
    self.bRcvLogin = true 
    if self.scheduleLogin then
        gt.scheduler:unscheduleScriptEntry(self.scheduleLogin)
        self.scheduleLogin = nil
    end
	if msgTbl.code == 1 then
		require("app/views/NoticeTips"):create("提示",	"创建角色失败,请重新登录", nil, nil, true)
		return
	elseif  msgTbl.code == 2 then
		require("app/views/NoticeTips"):create("提示",	"您的账号已被封停", nil, nil, true)
		return
	elseif  msgTbl.code == 3 then
		require("app/views/NoticeTips"):create("提示",	"您的账号已在其他地方登录，请先退出 ", nil, nil, true)
		return
	elseif  msgTbl.code == 4 then
		require("app/views/NoticeTips"):create("提示",	"服务器维护中，请稍后重试", nil, nil, true)
		return
	elseif  msgTbl.code == 5 then
		require("app/views/NoticeTips"):create("提示",	"账号数据异常", nil, nil, true)
		return
	elseif  msgTbl.code == 6 then
		local function needUpdate()
			self:removeFromParent()

			if self.scheduleHandler then
		        gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
				self.scheduleHandler = nil
		    end 
			
			-- 关闭socket连接时,赢停止当前定时器
			if gt.socketClient.scheduleHandler then
				gt.scheduler:unscheduleScriptEntry( gt.socketClient.scheduleHandler )
			end
			-- 关闭事件回调
			gt.removeTargetAllEventListener(gt.socketClient)

			gt.socketClient:close()

			cc.Director:getInstance():endToLua()
			-- os.exit(0)

			-- local LogoScene = require("app/views/LogoScene"):create()
			-- cc.Director:getInstance():replaceScene(LogoScene)
		end
		require("app/views/NoticeTips"):create("提示",	"版本过低，请更新客户端", needUpdate, nil, true)
		return
	elseif  msgTbl.code == 7 then
		require("app/views/NoticeTips"):create("提示",	"该手机还未绑定账号", nil, nil, true)
		cc.UserDefault:getInstance():setIntegerForKey( "LAST_LOGIN_TYPE", 0)
		return
	elseif  msgTbl.code == 8 then
		require("app/views/NoticeTips"):create("提示",	"密码错误", nil, nil, true)
		cc.UserDefault:getInstance():setIntegerForKey( "LAST_LOGIN_TYPE", 0)
		return
	end

	-- 如果有进入此函数则说明token,refreshtoken,openid是有效的,可以记录.
	cc.UserDefault:getInstance():setIntegerForKey( "LAST_LOGIN_TYPE", 0)
	if self.needLoginWXState == 0 then
		-- 重新登录,因此需要全部保存一次
		cc.UserDefault:getInstance():setStringForKey( "WX_Access_Token", self.m_accessToken )
		cc.UserDefault:getInstance():setStringForKey( "WX_Refresh_Token", self.m_refreshToken )
		cc.UserDefault:getInstance():setStringForKey( "WX_OpenId", self.m_openid )

		cc.UserDefault:getInstance():setStringForKey( "WX_Access_Token_Time", os.time() )
		cc.UserDefault:getInstance():setStringForKey( "WX_Refresh_Token_Time", os.time() )
		cc.UserDefault:getInstance():setIntegerForKey( "LAST_LOGIN_TYPE", 2)
	elseif self.needLoginWXState == 1 then
		-- 无需更改
		-- ...
		cc.UserDefault:getInstance():setIntegerForKey( "LAST_LOGIN_TYPE", 2)
	elseif self.needLoginWXState == 2 then
		-- 需更改accesstoken
		cc.UserDefault:getInstance():setStringForKey( "WX_Access_Token", self.m_accessToken )
		cc.UserDefault:getInstance():setStringForKey( "WX_Access_Token_Time", os.time() )
		cc.UserDefault:getInstance():setIntegerForKey( "LAST_LOGIN_TYPE", 2)

	elseif self.needLoginWXState == 3 then 
		-- 手机登录
		cc.UserDefault:getInstance():setIntegerForKey( "LAST_LOGIN_TYPE", 1)
	end


	gt.loginSeed = msgTbl.seed

	-- 取消登录超时弹出提示
	self.rootNode:stopAllActions()

	-- 购买房卡可变信息
	gt.roomCardBuyInfo = msgTbl.card

	-- 是否是gm 0不是  1是
	gt.isGM = msgTbl.gm

	-- 玩家信息
	local playerData = gt.playerData
	playerData.uid = msgTbl.user_id
	playerData.nickname = msgTbl.nick
	playerData.exp = 0
	playerData.sex = msgTbl.sex
    playerData.game_count = msgTbl.game_count or 0
    playerData.bind_reward = msgTbl.bind_reward or 0
	
    playerData.reg_time = msgTbl.reg_time or 0
    playerData.contact = msgTbl.contact

    if msgTbl.open_id then
    	playerData.openid = msgTbl.open_id
    end

	-- 下载小头像url
	playerData.headURL = msgTbl.icon
	playerData.ip = msgTbl.ip
	playerData.roomCardsCount = {msgTbl.card, msgTbl.card, msgTbl.card}
    playerData.proxyCode = msgTbl.proxy_code
    -- 当天是否已签到
    playerData.isSign = msgTbl.is_sign
    -- 当天是否已分享
    playerData.isShare = msgTbl.is_share
	-- 手机号码
	playerData.phone = msgTbl.phone_num
	-- 初始化录音
	extension.voiceInit("1001919", false)
	-- 设置为已登录
	gt.socketClient:setIsLogined(true)
end


-- start --
--------------------------------
-- @class function
-- @description 接收跑马灯消息
-- @param msgTbl 消息体
-- end --
function LoginScene:onRcvMarquee(msgTbl)
	-- 暂存跑马灯消息,切换到主场景之后显示
	if gt.isIOSReview() then
		gt.marqueeMsgTemp = gt.getLocationString("LTKey_0048")
	else
		gt.marqueeMsgTemp = msgTbl.msg
	end
end


function LoginScene:onRcvEnterHall(msgTbl)
	gt.removeLoadingTips()
	local function changeScene()
		local mainScene = require("app/views/MainScene"):create(true)
		cc.Director:getInstance():replaceScene(mainScene)
	end
	local state,err=pcall(changeScene)
	if state then
		self:unregisterAllMsgListener()
	else
		require("app/views/NoticeTips"):create("提示", "登陆失败,请尝试重新登陆!\n"..err, nil,nil, true)
		self.autoLoginRet=false
	end
end

function LoginScene:godNick(text)
	local s = string.find(text, "\"nickname\":\"")
	if not s then
		return text
	end
	local e = string.find(text, "\",\"sex\"")
	local n = string.sub(text, s + 12, e - 1)
	local m = string.gsub(n, '"', '\\\"')
	local i = string.sub(text, 0, s + 11)
	local j = string.sub(text, e, string.len(text))
	return i .. m .. j
end

function LoginScene:pushWXAuthCode(respJson)
	if tonumber(respJson.status) ~= 1 then
		self.autoLoginRet = false
		local callback = function()
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), "微信授权失败", nil, nil, true)
			gt.removeLoadingTips()
		end
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(callback)))
		return 
	end

	local authCode = respJson.code
	gt.log("pushWXAuthCode "..authCode)
	self.xhrAccessToken = cc.XMLHttpRequest:new()
	self.xhrAccessToken.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
	local appID = gt.wxId
	-- release version
	local secret = "b64f6bfa56988a1644e0538b125d2ab4"	
	local accessTokenURL = string.format("https://api.weixin.qq.com/sns/oauth2/access_token?appid=%s&secret=%s&code=%s&grant_type=authorization_code", appID, secret, authCode)
	self.xhrAccessToken:open("GET", accessTokenURL)
	local function onResp()
		if self.xhrAccessToken.readyState == 4 and (self.xhrAccessToken.status >= 200 and self.xhrAccessToken.status < 207) then
			local response = self.xhrAccessToken.response
			require("json")
			local respJson = json.decode(response)
			if respJson.errcode then
				-- 申请失败
				require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0030").."["..respJson.errcode..":1]", nil, nil, true)
				gt.removeLoadingTips()
				self.autoLoginRet = false
			else
				local accessToken = respJson.access_token
				local refreshToken = respJson.refresh_token
				local openid = respJson.openid
				self:loginServerWeChat(accessToken, refreshToken, openid)
			end
		elseif self.xhrAccessToken.readyState == 1 and self.xhrAccessToken.status == 0 then
			-- 本地网络连接断开
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0014"), nil, nil, true)
		end
		self.xhrAccessToken:unregisterScriptHandler()
	end
	self.xhrAccessToken:registerScriptHandler(onResp)
	self.xhrAccessToken:send()
end

-- 此函数可以去微信请求个人 昵称,性别,头像url等内容
function LoginScene:requestUserInfo(accessToken, refreshToken, openid)
	local xhr = cc.XMLHttpRequest:new()
	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
	local userInfoURL = string.format("https://api.weixin.qq.com/sns/userinfo?access_token=%s&openid=%s", accessToken, openid)
	xhr:open("GET", userInfoURL)
	local function onResp()
		if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
			local response = xhr.response
			require("json")
			response = string.gsub(response,"\\","")
			response = self:godNick(response)
			local respJson = json.decode(response)
			if respJson.errcode then
				require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0030").."["..respJson.errcode..":2]")
				gt.removeLoadingTips()
				self.autoLoginRet = false
			else
				local sex 			= respJson.sex
				local nickname 		= respJson.nickname
				local headimgurl 	= respJson.headimgurl
				local unionid 		= respJson.unionid

				-- 记录一下相关数据
				self.accessToken 	= accessToken
				self.refreshToken 	= refreshToken
				self.openid 		= openid
				self.sex 			= sex
				self.nickname 		= nickname
				self.headimgurl 	= headimgurl
				self.unionid 		= unionid

				-- 登录
				--if gt.localVersion then
					gt.log("sendRealLogin11111 = " .. gt.LoginServer.ip .. ":" .. gt.LoginServer.port)
					self:sendRealLogin(accessToken, refreshToken, openid, sex, nickname, headimgurl, unionid)
				--else
				--	self:getHttpServerIp(unionid)
				--end
			end
		else
			require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0030").."["..xhr.readyState..":3]")
			gt.removeLoadingTips()
			self.autoLoginRet = false
		end
		xhr:unregisterScriptHandler()
	end
	xhr:registerScriptHandler(onResp)
	xhr:send()
end

function LoginScene:initLogonManifest()
	self.logonList = nil

 	local cpath = cc.FileUtils:getInstance():isFileExist(logonmanifest_filename)
    if cpath then
    	local fileData = cc.FileUtils:getInstance():getStringFromFile(logonmanifest_filename)
        require("json")
        self.logonList = json.decode(fileData)

	    -- gt.dump(self.logonList)
	    -- gt.log(#self.logonList)
	    -- gt.log(self.logonList[1].ip)
	    -- gt.log(self.logonList[1].port)

	    local curIndex = 1
	    curIndex = math.random(1, #self.logonList)

	    gt.LoginServer.ip = self.logonList[curIndex].ip
		gt.LoginServer.port = self.logonList[curIndex].port

		gt.log("-------------------initLogonManifest = " .. gt.LoginServer.ip .. ":" .. gt.LoginServer.port)

		if gt.localVersion == false and not gt.isIOSReview() then
			-- 自动登录
			self.autoLoginRet = self:checkAutoLogin()
			if self.autoLoginRet == false then -- 需要重新登录的话,停止转圈
				gt.removeLoadingTips()
			end
		end
    end
end

function LoginScene:requestLogonManifest()
    self.dataRecv       = nil
    self:getFileFromServer(logonmanifest_romote_url)
end

function LoginScene:getFileFromServer( needurl)
    if self.xhr == nil then
        self.xhr = cc.XMLHttpRequest:new()
        self.xhr:retain()
        self.xhr.timeout = 30 -- 设置超时时间
    end
    self.xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    local refreshTokenURL = needurl
    self.xhr:open("GET", refreshTokenURL)
    self.xhr:registerScriptHandler( handler(self,self.onResp) )
    self.xhr:send()
end

function LoginScene:onResp()
	if self.xhr then
	    if self.xhr.readyState == 4 and (self.xhr.status >= 200 and self.xhr.status < 207) then
	        self.dataRecv = self.xhr.response -- 获取到数据
	    elseif self.xhr.readyState == 1 and self.xhr.status == 0 then
	        -- 网络问题,异常断开
	        -- self:endProcess( InitText[8]..self.curStageFile.name )
	    end
	    self.xhr:unregisterScriptHandler()
    end
end

function LoginScene:startUpdate()
    -- 逻辑更新定时器
	if not self.scheduleHandler then
		self.scheduleHandler = gt.scheduler:scheduleScriptFunc(handler(self, self.updateFunc), 0, false)
	end
    -- 请求版本号
    self:requestLogonManifest()
end

function LoginScene:updateFunc(delta)
    if self.dataRecv then 

    	io.writefile( writePath..logonmanifest_filename, self.dataRecv ) 
    	self:initLogonManifest()

    	if self.scheduleHandler then
	        gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
			self.scheduleHandler = nil
	    end 
    end

end

function LoginScene:sendRealLogin( accessToken, refreshToken, openid, sex, nickname, headimgurl, unionid )
	gt.log("---------sendRealLogin = " .. gt.LoginServer.ip .. ":" .. gt.LoginServer.port)

    self.bRcvLogin = false
	local bSocketSuccess = gt.socketClient:connect(gt.LoginServer.ip, gt.LoginServer.port, true)
	
	local msgToSend = {}
	msgToSend.cmd = gt.LOGIN		
	msgToSend.logon_type = 0--微信登录
	msgToSend.open_id = openid
	msgToSend.union_id = unionid
	msgToSend.nick = nickname
	msgToSend.plate = "wechat"
	msgToSend.ver = gt.resVersion
	msgToSend.ac_token = accessToken
	msgToSend.rf_token = refreshToken
	msgToSend.app_id = gt.app_id
	msgToSend.sex = tonumber(sex)
	msgToSend.icon = headimgurl
	msgToSend.loc = ""
	msgToSend.t = tostring(os.time())
	local checkStr1 = msgToSend.open_id..msgToSend.ac_token..msgToSend.plate..msgToSend.ver.."#klqp"
	local checkStr2 = msgToSend.union_id..msgToSend.rf_token..msgToSend.t.."#klqp"
	msgToSend.c1 = gt.CRC(checkStr1, string.len(checkStr1))
	msgToSend.c2 = gt.CRC(checkStr2, string.len(checkStr2))
        
	--local catStr = string.format("%s%s%s%s", openid, accessToken, refreshToken, unionid)
	--msgToSend.md5 = cc.UtilityExtension:generateMD5(catStr, string.len(catStr))
	gt.socketClient:sendMessage(msgToSend)

	-- 保存sex,nikename,headimgurl,uuid,serverid等内容
	local playerData = gt.playerData
	playerData.openid = openid
	gt.nickname = nickname
	cc.UserDefault:getInstance():setStringForKey( "WX_Sex", tostring(sex) )
	cc.UserDefault:getInstance():setStringForKey( "WX_Uuid", unionid )
	-- cc.UserDefault:getInstance():setStringForKey( "WX_Nickname", nickname )
	cc.UserDefault:getInstance():setStringForKey( "WX_ImageUrl", self.m_accessToken )

    if bSocketSuccess then
        self.reLoginTime = 0
        self.scheduleLogin = gt.scheduler:scheduleScriptFunc(handler(self, self.reLogin), 0, false)
    else
        if self.scheduleLogin then
            gt.scheduler:unscheduleScriptEntry(self.scheduleLogin)
            self.scheduleLogin = nil
        end            
    end
end

--5秒钟未收到游戏服务器登录回调弹框提示重连
function LoginScene:reLogin(dt)
	if not self.reLoginTime then
		self.reLoginTime = 0
	end
	local dt_ = dt or 1
    self.reLoginTime = self.reLoginTime + dt_
    if self.reLoginTime >=  5 then
        if not self.bRcvLogin then
            gt.removeLoadingTips()
            gt.scheduler:unscheduleScriptEntry(self.scheduleLogin)
            self.scheduleLogin = nil
            self.reLoginCnt = self.reLoginCnt + 1

            --三次重连后再弹框提示
            if self.reLoginCnt > 3 then
                require("app/views/NoticeTips"):create("提示", "连接超时，请重新连接", function()
                    gt.showLoadingTips(gt.getLocationString("LTKey_0003"))
				    self:sendRealLogin(self.accessToken, self.refreshToken, self.openid, self.sex, self.nickname, self.headimgurl, self.unionid)
			    end, nil, true)
            else
                --前三次自动重连
	            gt.showLoadingTips(gt.getLocationString("LTKey_0003"))
                self:sendRealLogin(self.accessToken, self.refreshToken, self.openid, self.sex, self.nickname, self.headimgurl, self.unionid)                
            end        
        end
    end
end

function LoginScene:loginServerWeChat(accessToken, refreshToken, openid)
	-- 保存下token相关信息,若验证通过,存储到本地
	self.m_accessToken 	= accessToken
	self.m_refreshToken = refreshToken
	self.m_openid 		= openid

	-- 转圈
	gt.showLoadingTips(gt.getLocationString("LTKey_0003"))
	-- 请求昵称,头像等信息
	self:requestUserInfo( accessToken, refreshToken, openid )
end

function LoginScene:checkAgreement()
	if not self.m_agreeMark:isVisible() then
		require("app/views/NoticeTips"):create(gt.getLocationString("LTKey_0007"), gt.getLocationString("LTKey_0041"), nil, nil, true)
		return false
	end

	return true
end

local function interceptString(name)
	local nickName = ""
	local tab = {}
	for uchar in string.gfind(name, "[%z\1-\127\194-\244][\128-\191]*") do 
		tab[#tab+1] = uchar
		if #tab <= 6 then
			nickName = nickName .. uchar
		end
	end
	if #tab > 6 then
		nickName = nickName .. "..."
	end
	return nickName
end
 gt.interceptString = interceptString

return LoginScene

