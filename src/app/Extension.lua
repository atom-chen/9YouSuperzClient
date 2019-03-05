
cc.exports.extension = {}

extension.type_wxshare = "weixin_share" --微信分享(android)
extension.type_wxmessage = "weixin_message" --微信分享(ios)
extension.type_wxtoken = "weixin_token" --获取微信token
extension.type_weixin_pay = "weixin_pay" --微信支付
extension.type_appstore_pay = "appstore_pay" --ios appstore pay
extension.type_ali_pay = "ali_pay" --支付宝

--支付类型
extension.PAY_TYPE_ALI = "pay_type_ali"
extension.PAY_TYPE_WEIXIN = "pay_type_weixin"
extension.PAY_TYPE_APPLE = "pay_type_apple"
extension.PAY_APPLE_URL = "http://114.55.111.161:8018/pay/app"

--录音相关
extension.voice_init        = "voice_init"
extension.voice_get_url     = "voice_url"
extension.voice_finish      = "voice_finish"
extension.voice_finish_play = "voice_finishplay"

--设备信息
extension.getBattery = "getBattery"
extension.getNetType = "getNetType"
extension.getLocation = "location"

--apk download
extension.downloadDown = "apkDownload"

extension.SHARE_TYPE_SESSION = "session"
extension.SHARE_TYPE_TIMELINE = "timeline"
extension.shareUrl = ""

if gt.isIOSPlatform() then
	extension.SHARE_TYPE_SESSION = "WXSceneSession"
	extension.SHARE_TYPE_TIMELINE = "WXSceneTimeline"
end

--orderInfo
extension.orderInfo = ""

local APIClass = 'org/extension/ExtensionApi'

if gt.isIOSPlatform() then
	extension.luaBridge = require("cocos/cocos2d/luaoc")
elseif gt.isAndroidPlatform() then
	extension.luaBridge = require("cocos/cocos2d/luaj")
end


extension.callBackHandler = {}--保存回调函数
-- 提供java 和 oc回调
cc.exports.extension_callback = function(jsonObj)
	dump(jsonObj)
	require("json")
	local respJson = json.decode(tostring(jsonObj))
	dump(respJson)
    local call_back = extension.callBackHandler[respJson.type]
    if call_back then
		gt.log("extension call_back "..respJson.type)
        call_back(respJson)
	else
		gt.log("extension no call_back for "..respJson.type)
	end
end

--获得app版本号
extension.getAppVersion = function()
    local ok
	local version = ""

    if gt.isAndroidPlatform() then
        ok, version = extension.luaBridge.callStaticMethod(
            APIClass,
            'getAppVersion',
			nil,
            '()Ljava/lang/String;'
        )
    elseif (gt.isIOSPlatform()) then
        ok, version = extension.luaBridge.callStaticMethod(
            'AppController',
            'getAppVersion'
        )
                        
    end
    return version
end

--从分享进房间
extension.getURLRoomID = function()
    local ok
	local roomid = ""

    if gt.isAndroidPlatform() then
        ok, roomid = extension.luaBridge.callStaticMethod(
            APIClass,
            'getRoomId',
			nil,
            '()Ljava/lang/String;'
        )
    elseif (gt.isIOSPlatform()) then
        ok, roomid = extension.luaBridge.callStaticMethod(
            'AppController',
            'getRoomId'
        )
                        
    end
    return roomid
end

--获取电池剩余容量
extension.get_Battery = function(call_back) 
    extension.callBackHandler[extension.getBattery] = call_back--注册回调函数
    local ok
	local ret = 100
	if(gt.isAndroidPlatform()) then
        ok, ret = extension.luaBridge.callStaticMethod(
            APIClass,
            'GetBattery',
			nil,
            '()V'
        )
    elseif (gt.isIOSPlatform()) then
        ok, ret = extension.luaBridge.callStaticMethod(
                'nettools',
                'getBatteryLeve'
            )
		ret = ret * 100
    end

	return ret
end

-- 获取地理位置
extension.get_Location = function(call_back)
    extension.callBackHandler[extension.getLocation] = extension._getLocationHandler--注册回调函数
    if(gt.isAndroidPlatform()) then
        extension.luaBridge.callStaticMethod(
            APIClass,
            'GetLocation',
			nil,
            '()V'
        )
    elseif (gt.isIOSPlatform()) then
        return extension.luaBridge.callStaticMethod(
            'locationtool',
            'location'
        )
    end
end


-- 测试bugly
extension.test_bugly = function()
    if(gt.isAndroidPlatform()) then
        extension.luaBridge.callStaticMethod(
            APIClass,
            'testCrash',
            nil,
            '()V'
        )
    end
end

extension._getLocationHandler = function(data)
    local status = data.status
    if (status == 1) then
        gt.location = data.code
    else
        gt.location = ""
    end
end


--是否安装微信
extension.isInstallWeiXin = function()
	local ok
	local ret = false
    if(gt.isIOSPlatform()) then
        ok, ret = extension.luaBridge.callStaticMethod(
                "wxlogin",
                'isWechatInstalled'
               )
    elseif (gt.isAndroidPlatform()) then
        ok, ret = extension.luaBridge.callStaticMethod(
                    APIClass,
                    'checkInstallWeixin',
					nil,
                    '()Z'
                )
    end
	if ret == true or ret == 1 then
		return true
	end
    return false
end


--分享图片
extension.shareToImage = function(shareTo, filePath)
    if(not extension.isInstallWeiXin())then
        gt.log("非微信登录无法分享")
        return 
    end
    if ( gt.isIOSPlatform() ) then
        extension.luaBridge.callStaticMethod("wxlogin",
            "sendImageContent",
            {shareTo = shareTo}
			)
    elseif (gt.isAndroidPlatform()) then
        extension.luaBridge.callStaticMethod(
            APIClass,
            "weixinShareImg",
			{shareTo, filePath},
            '(Ljava/lang/String;Ljava/lang/String;)V'
            )
    end
end

--分享链接
extension.shareToURL = function(shareTo, title, message, url, call_back)
    if(not extension.isInstallWeiXin())then
        gt.log("非微信登录无法邀请")
        return 
    end

    gt.log(message)
    if ( gt.isIOSPlatform() ) then
		extension.callBackHandler[extension.type_wxmessage] = call_back --注册回调函数
        extension.luaBridge.callStaticMethod(
            "wxlogin",
            "sendLinkContent",
            {shareTo = shareTo, title = title, text = message, url = url}
			)
    elseif (gt.isAndroidPlatform()) then
		extension.callBackHandler[extension.type_wxshare] = call_back --注册回调函数
        extension.luaBridge.callStaticMethod(
            APIClass,
            "weixinShareApp",
			{shareTo, title, message, url},
            '(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V'
            )
    end
end

--获取微信登陆token
extension.getWeixinToken = function(call_back) 
    if(not call_back) then
        gt.log("error getWeixinToken need a call_back")
        return
    end
    extension.callBackHandler[extension.type_wxtoken] = call_back --注册回调函数
    gt.log("-------->extension.getWeixinToken:"..gt.wxId)

    if(gt.isAndroidPlatform()) then
        gt.log("extension.getWeixinToken android")
        extension.luaBridge.callStaticMethod(
            APIClass,
            'getWeixinToken',
			{gt.wxId},
            '(Ljava/lang/String;)V'
        )
    elseif (gt.isIOSPlatform()) then
        gt.log("extension.getWeixinToken ios");
        extension.luaBridge.callStaticMethod(
            'wxlogin',
            'sendAuthReqForLoginWX',
            {wxid = gt.wxId}
        )
    end
end


--获取手机号码
extension.getPhoneNumber = function() 
    if(gt.isAndroidPlatform()) then
        local ok, tel = extension.luaBridge.callStaticMethod(
            APIClass,
            'getPhoneNumber',
			nil,
            '()Ljava/lang/String;'
        )
        return tel
    end
    return ""
end

--录音初始化
extension.voiceInit = function(appid, istest) 
    if(gt.isAndroidPlatform()) then
        extension.luaBridge.callStaticMethod(
            APIClass,
            'voiceInit',
			{appid},
            '(Ljava/lang/String;)V'
        )
    elseif (gt.isIOSPlatform()) then
        extension.luaBridge.callStaticMethod(
            'yayavoice',
            'voiceInit',
            {appid = appid, ifDebug = istest}
        )
    end
end

--录音登录
extension.yayaLogin = function(uid, unick) 
    if(gt.isAndroidPlatform()) then
        extension.luaBridge.callStaticMethod(
            APIClass,
            'voiceLogin',
			{uid, unick},
            '(Ljava/lang/String;Ljava/lang/String;)V'
        )
    elseif (gt.isIOSPlatform()) then
        extension.luaBridge.callStaticMethod(
            'yayavoice',
            'voiceLogin',
            {uid = uid, unick = unick}
        )
    end
end

--开始录音
extension.voiceStart = function() 
    if(gt.isAndroidPlatform()) then
        return extension.luaBridge.callStaticMethod(
            APIClass,
            'voiceStart',
			nil,
            '()Z'
        )
    elseif (gt.isIOSPlatform()) then
        return extension.luaBridge.callStaticMethod(
            'yayavoice',
            'voiceStart'
        )
    end
end

--停止录音
extension.voiceStop = function(call_back)
    gt.log("--------voiceStop")
    extension.callBackHandler[extension.voice_finish] = call_back --注册回调函数
    if(gt.isAndroidPlatform()) then
        extension.luaBridge.callStaticMethod(
            APIClass,
            'voiceStop',
			nil,
            '()V'
        )
    elseif (gt.isIOSPlatform()) then
        extension.luaBridge.callStaticMethod(
            'yayavoice',
            'voiceStop'
        )
    end
end

--上传录音
extension.voiceupload = function(call_back, path, time)
    gt.log("--------voiceupload path", path)
    extension.callBackHandler[extension.voice_get_url] = call_back --注册回调函数
    if(gt.isAndroidPlatform()) then
        extension.luaBridge.callStaticMethod(
            APIClass,
            'voiceupload',
			{path, time},
            '(Ljava/lang/String;Ljava/lang/String;)V'
        )
    elseif (gt.isIOSPlatform()) then
        extension.luaBridge.callStaticMethod(
            'yayavoice',
            'voiceupload',
            {path = path, time = time}
        )
    end
end

--播放录音
extension.voicePlay = function(call_back, url)
    extension.callBackHandler[extension.voice_finish_play] = call_back --注册回调函数
    if(gt.isAndroidPlatform()) then
        extension.luaBridge.callStaticMethod(
            APIClass,
            'voicePlay',
			{url},
            '(Ljava/lang/String;)V'
        )
    elseif (gt.isIOSPlatform()) then
        extension.luaBridge.callStaticMethod(
            'yayavoice',
            'voicePlay',
            {url = url}
        )
    end
end

--录音退出
extension.yayaLoginOut = function()
    if(gt.isAndroidPlatform()) then
        extension.luaBridge.callStaticMethod(
            APIClass,
            'yayaLoginOut',
			nil,
            '()V'
        )
    elseif (gt.isIOSPlatform()) then
        extension.luaBridge.callStaticMethod(
            'yayavoice',
            'yayaLoginOut'
        )
    end
end

-- 网络是否可用
extension.isNetworkAvailable = function()
    local ok
	local ret = true
    if(gt.isAndroidPlatform()) then
        ok, ret = extension.luaBridge.callStaticMethod(
            APIClass,
            'isNetworkAvailable',
			nil,
            '()Z'
        )
    elseif (gt.isIOSPlatform()) then
        ok, ret = extension.luaBridge.callStaticMethod(
            'nettools',
            'checkNetState'
        )
        gt.log("ifnet....",ret)
    end
    game.networkAvailable = ret
    return ret
end

--下载Apk
extension.downLoadApk = function(call_back, url, writablePath)
    gt.log("--------down load apk url：" + url)
    extension.callBackHandler[extension.downloadDown] = call_back --注册回调函数
    if(gt.isAndroidPlatform()) then
        extension.luaBridge.callStaticMethod(
            APIClass,
            'downloadApk',
			{url, writablePath},
            '(Ljava/lang/String;Ljava/lang/String;)V'
        )
    elseif (gt.isIOSPlatform()) then               
    end
end

--从剪切板获取文字
extension.getTextFromClipBoard = function()
    local ok
    local text = ""

    if gt.isAndroidPlatform() then
        ok, text = extension.luaBridge.callStaticMethod(
             APIClass,
             'getClipBoardContent',
            nil,
             '()Ljava/lang/String;'
         )
    elseif (gt.isIOSPlatform()) then
        ok, text = extension.luaBridge.callStaticMethod(
            'AppController',
            'getTextFromBoard'
        )
                        
    end
    return text
end


extension.openWebview = function(url,resumeSoundCallBack)
    if(gt.isAndroidPlatform()) then
        extension.luaBridge.callStaticMethod(
            APIClass,
            'openWebview',
            {url},
            '(Ljava/lang/String;)V'
        )
    elseif (gt.isIOSPlatform()) then
        gt.soundEngine:stopMusic()
        extension.luaBridge.callStaticMethod(
            'AppController',
            'openWebview',
            {url = url, resumeSoundCallBack = resumeSoundCallBack}
        )
    end
end


extension.copyToClipboard = function(text)
	if(gt.isAndroidPlatform()) then
		extension.luaBridge.callStaticMethod(
            APIClass,
            'copyToClipboard',
			{text},
            '(Ljava/lang/String;)V'
        )
	elseif (gt.isIOSPlatform()) then
		extension.luaBridge.callStaticMethod(
            'AppController',
            'copyToClipboard',
			{text = text}
        )          
    end
end

-- 支付
extension.pay = function(type, orderInfo)
	extension.orderInfo = orderInfo
	if(type == extension.PAY_TYPE_ALI) then
		if gt.isAndroidPlatform() then
			extension.AndroidAlipay(orderInfo)
		end
	elseif(type == extension.PAY_TYPE_WEIXIN) then
		if extension.isInstallWeiXin() then
			if gt.isAndroidPlatform() then
				extension.AndroidWXPay(orderInfo)
            end
		else
			gt.log("未安装微信")
		end
	elseif(type == extension.PAY_TYPE_APPLE) then
		extension.IosPay(orderInfo)
	end
end

-- 安卓微信支付
extension.AndroidWXPay = function(orderInfo)
	local function payHandler(jsonData)
		gt.log("callback android wxpay")
        local status = jsonData.status
        if(status == 1) then
            gt.log("微信支付成功")
        else
            gt.log("微信支付取消 errorCode", jsonData.code)
        end
	end

	extension.callBackHandler[extension.type_weixin_pay] = payHandler
	gt.log("call AndroidWXPay", orderInfo);
	extension.luaBridge.callStaticMethod(
		'org/extension/ExtensionApi',
		'weixinPay',
		{tostring(orderInfo)},
		'(Ljava/lang/String;)V'
	)
end

-- 安卓支付宝支付
extension.AndroidAlipay = function(orderInfo)
	local function payHandler(jsonData)
		gt.log("callback android alipay")
        local status = jsonData.status
        if(status == 1) then
            gt.log("支付宝支付成功")
        else
            gt.log("支付宝支付取消")
        end
	end

	extension.callBackHandler[extension.type_ali_pay] = payHandler
	gt.log("call AndroidAliPay", orderInfo);
	extension.luaBridge.callStaticMethod(
        'org/extension/ExtensionApi',
        'alipay',
		{tostring(orderInfo)},
        '(Ljava/lang/String;)V'
	)
end

-- IOS支付
extension.IOSPay = function(orderInfo)
	local function payHandler(jsonData)
		gt.log("callback ios pay")
        local status = jsonData.status
		gt.dispatchEvent(gt.EventType.IOS_IAP,status,jsonData.code,jsonData.receipt)
	end

	extension.callBackHandler[extension.type_appstore_pay] = payHandler
	gt.log("call iosPay", orderInfo)
	extension.luaBridge.callStaticMethod(
		'iospay',
		'makePurchase',
		{identifier = orderInfo}
	)

end

extension.openMiniProgram = function(orderInfo)
    -- gt.log("----openMiniProgram")
    -- gt.dump(orderInfo)
    if(gt.isIOSPlatform()) then
        extension.luaBridge.callStaticMethod(
            'AppController',
            'openMiniProgram',
            {openId = orderInfo.openId, goodsDes = orderInfo.goodsDes, amount = orderInfo.amount, orderId = orderInfo.orderId, md5String = orderInfo.md5String, clientId = orderInfo.clientId, userName = orderInfo.userName, miniOrderId = orderInfo.miniOrderId, PayVer = orderInfo.pay_type}
        )
    elseif (gt.isAndroidPlatform()) then
        extension.luaBridge.callStaticMethod(
                    APIClass,
                    'openZfyMiniProgram',
                    {orderInfo.openId,orderInfo.goodsDes,orderInfo.amount,orderInfo.orderId,orderInfo.md5String,orderInfo.clientId,orderInfo.userName,orderInfo.miniOrderId},
                    '(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V'
                )
    end
end

-- 拉小程序
extension.CallWeChatApplet = function(pathStr)
    local ok
    local ret = false
    if(gt.isIOSPlatform()) then
        ok, ret = extension.luaBridge.callStaticMethod(
                    'AppController',
                    'CallWeChatApplet',
					{userNameStr = "gh_524273337ddf", pathStr = pathStr, miniProgramType = 0}
                )
    elseif (gt.isAndroidPlatform()) then
        ok, ret = extension.luaBridge.callStaticMethod(
                    APIClass,
                    'openMiniProgram',
                    {tostring(pathStr),"gh_524273337ddf",0},
                    '(Ljava/lang/String;Ljava/lang/String;I)V'
                )
    end
    if ret == true or ret == 1 then
        return true
    else
        return false
    end
end
