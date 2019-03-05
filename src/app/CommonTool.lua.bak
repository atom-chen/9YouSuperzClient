
local gt = cc.exports.gt

require("json")
local md5 = require("app.libs.pure_lua_md5")
local KEY_UNION = "DASss39KDgi8s0zdkD812kslFgx8"
local KEY_RECORD = "ABsiui39Daljf9ajzp0KjfOahf9x"
local GAME_TYPE = "szn"

local CommonTool = class("CommonTool")
function CommonTool:ctor()
end

function CommonTool:encodeSign(param_)
	local dataStr = ""
	local sendParam = {}
	for i,value in ipairs(param_) do
		for k,v in pairs(value) do
			dataStr = dataStr..string.format("%s=%s&",tostring(k),tostring(v))
			sendParam[k]= v
		end
	end
	-- local temp = string.sub(dataStr,1,string.len(dataStr) -1)	
	local temp = dataStr.."game_type="..GAME_TYPE
	local signStr = md5.sumhexa(temp..KEY_UNION)
	sendParam.game_type = GAME_TYPE
	sendParam.sign = signStr
	gt.dump(sendParam)
	return sendParam
end

function CommonTool:encodeSignRecord(param_)
	local dataStr = "app_type="..GAME_TYPE
	local sendParam = {}
	for i,value in ipairs(param_) do
		for k,v in pairs(value) do
			dataStr = dataStr..string.format("&%s=%s",tostring(k),tostring(v))
			sendParam[k]= v
		end
	end
	-- local temp = string.sub(dataStr,1,string.len(dataStr) -1)	
	local temp = dataStr..KEY_RECORD
	local signStr = md5.sumhexa(temp)
	sendParam.app_type = GAME_TYPE
	sendParam.sign = signStr
	gt.dump(sendParam)
	return sendParam
end

function CommonTool:hideText(content, isShow)
	if isShow or content == gt.playerData.uid then
		return content
	else
		return string.format("%s****%s",string.sub(content,1,1),string.sub(content,-1,-1))
	end
end

function CommonTool:sendHttpUrl(callback_)
	local url = "http://api.mgklqp.9you.net:10071/geturl?name="..GAME_TYPE
	self:sendHttpGET(url, callback_)
end

function CommonTool:sendHttpGET(url_, callback_)
	local xhr = cc.XMLHttpRequest:new()
	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
 	xhr:open("GET", url_)
 	local function onResp()
		if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
			local response = xhr.response
			gt.log(response)

			local respJson = json.decode(response)
			if respJson.Code == 200 or respJson.Code == "200" then 
				local urlDatas = respJson.Data
				for i, urlData in ipairs(urlDatas) do
					-- gt.dump(urlData)
					if urlData.name == "downurl" then
						gt.http_url_down = urlData.urls
					elseif urlData.name == "starturl" then
						gt.http_url_start =  "http://"..urlData.urls.."/?app="..GAME_TYPE.."&start_type=1"
					end 
				end
				-- gt.log(gt.http_url_down)
				-- gt.log(gt.http_url_start)

				callback_(respJson)
			end
		elseif xhr.readyState == 1 and xhr.status == 0 then
			-- 请求出错
			gt.log("请求失败")
		end
		xhr:unregisterScriptHandler()
	end
 	xhr:registerScriptHandler(onResp)
	xhr:send()
end

function CommonTool:sendHttpRecord(url_, sendParam_, callback_)
	self:sendHttpPost(url_,sendParam_,callback_)
end

function CommonTool:sendHttpUnion(url_, sendParam_, callback_)
	self:sendHttpPost(url_,sendParam_,callback_)
end

function CommonTool:sendHttpPost(url_, sendParam_, callback_)
	
	local xhr = cc.XMLHttpRequest:new()
	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
 	xhr:setRequestHeader("Content-Type", "application/json")
	xhr:open("POST", url_)
	local function onResp()
		if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
			local response = xhr.response
			gt.log(response)

			local respJson = json.decode(response)
			if respJson.code == 0 or respJson.code == "0" then 
				callback_(respJson)
			end
		elseif xhr.readyState == 1 and xhr.status == 0 then
			-- 请求出错
			gt.log("请求失败")
		end
		xhr:unregisterScriptHandler()
	end
	xhr:registerScriptHandler(onResp)

	local jsonString = json.encode(sendParam_)

--	gt.log("url:"..url_)
--	gt.log("jsonString:"..jsonString)
	xhr:send(jsonString)
end

-- 星空背景 屏幕适配
gt.xkbjScaleX = 1
gt.xkbjScaleY = 1
-- 场景被拉伸后，金币飞行起点/终点位置纠正
gt.OffsetX = 0
if (gt.winSize.width / gt.winSize.height) > (1280 / 720) then		-- 场景被拉宽
	gt.OffsetX = (gt.winSize.width - 1280) / 2
	gt.xkbjScaleX = (gt.winSize.width / gt.winSize.height) / (1280 / 720)
end
gt.OffsetY = 0
if (gt.winSize.height / gt.winSize.width) > (720 / 1280) then		-- 场景被拉高
	gt.OffsetY = (gt.winSize.height- 720) / 2
	gt.xkbjScaleY = (gt.winSize.height / gt.winSize.width) / (720 / 1280)
end

--base64加密
local function encodeBase64(source_str)  
    local b64chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'  
    local s64 = ''  
    local str = source_str  
  
    while #str > 0 do  
        local bytes_num = 0  
        local buf = 0  
  
        for byte_cnt=1,3 do  
            buf = (buf * 256)  
            if #str > 0 then  
                buf = buf + string.byte(str, 1, 1)  
                str = string.sub(str, 2)  
                bytes_num = bytes_num + 1  
            end  
        end  
  
        for group_cnt=1,(bytes_num+1) do  
            local b64char = math.fmod(math.floor(buf/262144), 64) + 1  
            s64 = s64 .. string.sub(b64chars, b64char, b64char)  
            buf = buf * 64  
        end  
  
        for fill_cnt=1,(3-bytes_num) do  
            s64 = s64 .. '='  
        end  
    end  
  
    return s64  
end 
gt.encodeBase64 = encodeBase64


return CommonTool


