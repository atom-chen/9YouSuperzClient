-- collectgarbage("setpause", 100) 
-- collectgarbage("setstepmul", 5000)
cc.FileUtils:getInstance():setPopupNotify(false)

local writePath = cc.FileUtils:getInstance():getWritablePath()
local resSearchPaths = {
	writePath,
	writePath .. "src/",
	writePath .. "res/",
	"src/",
	"res/"
}
cc.FileUtils:getInstance():setSearchPaths(resSearchPaths)
package.path = package.path .. "src/?.lua"..";res/?.lua"
--cc.Director:getInstance():setDisplayStats(true)

require "socket"
pcall(function() require("md5.core") end)  --protected call, in case md5 lib not been compiled into application
require "config"
require "cocos.init"

local function main()
    require("app.MyApp"):create():run()
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
 