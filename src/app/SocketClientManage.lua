
local gt = cc.exports.gt
local SocketClientManage = class("SocketClientManage")

local _instance = nil

gt.socketType = {
    Login = 1,
    Game = 2    
}

function SocketClientManage.getInstance(isOneSocket)  --设置全局仅一个socket
       if _instance == nil then
            _instance = SocketClientManage.new(isOneSocket)
       end
       return _instance
end

function SocketClientManage:ctor(isOneSocket)
     self.m_manage = {}
     self.isOneSocket = isOneSocket or false

end

function SocketClientManage:getLoginConnectSocket(ip,port,successCallBack)

   return self:getConnectSocket(gt.socketType.Login,ip,port,successCallBack)

end

function SocketClientManage:getGameConnectSocket(ip,port,successCallBack)

   return self:getConnectSocket(gt.socketType.Game,ip,port,successCallBack)

end

function SocketClientManage:getLoginSocket()
    
    if self.isOneSocket == true then
        for k,v in pairs(self.m_manage) do 
            v:close()
            self.m_manage[k] = nil
        end
    else
        if self.m_manage[gt.socketType.Login] then
            self.m_manage[gt.socketType.Login]:close()
            self.m_manage[gt.socketType.Login] = nil
        end 
    end

   self.m_manage[gt.socketType.Login] = require("app/SocketClient"):create(gt.socketType.Login , true)
   gt.socketClient  = self.m_manage[gt.socketType.Login]
   return self.m_manage[gt.socketType.Login]
end

function SocketClientManage:getConnectSocket(_socketType,ip,port,successCallBack)

    if self.isOneSocket == true then
        for k,v in pairs(self.m_manage) do 
            v:close()
            self.m_manage[k] = nil
        end
    else
        if self.m_manage[_socketType] then
            self.m_manage[_socketType]:close()
            self.m_manage[_socketType] = nil
        end 
    end


    

   self.m_manage[_socketType] = require("app/SocketClient"):create(_socketType)
   gt.socketClient  = self.m_manage[_socketType]
   self.m_manage[_socketType]:connect(ip, port, true,successCallBack)
   return self.m_manage[_socketType] 

end


return SocketClientManage


