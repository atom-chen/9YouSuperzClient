

local tnode = {}
local tCount = {}
local function retainNodes(node,nodesName)
    assert(type(node)=="userdata","retainNode func")
    assert(type(nodesName)=="string","retainNode func")
    node:retain() 
    if tnode[nodesName] == nil then
        tnode[nodesName] = {}
    end
    table.insert(tnode[nodesName],node)
    return tnode[nodesName]
end
gt.retainNodes=retainNodes

local function releaseNodes(nodesName,isClear)
    assert(type(nodesName)=="string","releaseNodes func")
    for k,v in pairs(tnode[nodesName]) do  
           
        if v:getReferenceCount() == 1  then
            tnode[nodesName][k] = nil
        end
            v:release()
    end

    if isClear then
        tnode[nodesName] = {}
    end
    
end
gt.releaseNodes=releaseNodes


local function getNodes(nodesName)
    assert(type(nodesName)=="string","getNodes func")
    return tnode[nodesName]
end
gt.getNodes=getNodes

local function getNodesReferenceCount(nodesName)
assert(type(nodesName)=="string","getNodesReferenceCount func")

    for k,v in pairs(tnode[nodesName]) do  
        print("ReferenceCount:".. v:getReferenceCount())     
    end

end
gt.getNodesReferenceCount = getNodesReferenceCount

local function clearNodes()
    assert(type(nodesName)=="string","retainNode func")
    for k,v in pairs(tnode) do
            for k1,v1 in pairs(v) do
                v1:release()
            end     
     end 
    tnode = {}
end
gt.clearNodes=clearNodes


local function  getScreenTouchPos(node)
    local touchNode = cc.Node:create()
    node:addChild(touchNode,100)

    local listener = cc.EventListenerTouchOneByOne:create()  --创建一个单点事件监听
	listener:setSwallowTouches(false) 
	local function OnTouchBegan(touch,event)
        local touch = touch:getLocation()
		print("touch screen pos =",touch.x,touch.y)
		return false
	end
	listener:registerScriptHandler(OnTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
	local eventDispatcher = touchNode:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener,touchNode) --分发监听事件
end
gt.getScreenTouchPos = getScreenTouchPos

local function  getEventListenerTouchOneByOne(node,OnTouchBegan,OnTouchMoved,OnTouchEnd)
  
    local listener = cc.EventListenerTouchOneByOne:create()  --创建一个单点事件监听
	listener:setSwallowTouches(false) 
--	local function OnTouchBegan(touch,event)
--        local touch = touch:getLocation()
--		print("touch screen pos =",touch.x,touch.y)
--		return false
--	end
    if OnTouchBegan then
	    listener:registerScriptHandler(OnTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
    end
    if OnTouchMoved then
	    listener:registerScriptHandler(OnTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
    end
    if OnTouchEnd then
	    listener:registerScriptHandler(OnTouchEnd,cc.Handler.EVENT_TOUCH_ENDED)
    end
	local eventDispatcher = node:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener,node) --分发监听事件
    return listener
end
gt.getEventListenerTouchOneByOne = getEventListenerTouchOneByOne

local function removeCocosEventListener(this,_listener)
    if _listener then
       local eventDispatcher = this:getEventDispatcher()
        eventDispatcher:removeEventListener(_listener)         
    end
end
gt.removeCocosEventListener = removeCocosEventListener

local function delayRun(time,fun)
    local scheid = {}
    scheid[1]  = gt.scheduler:scheduleScriptFunc(function (dt)
                                 if scheid[1] then
                                    gt.scheduler:unscheduleScriptEntry(scheid[1])
                                    scheid[1] = nil
                                    scheid = nil
                                end
                                fun()

                             end , time, false)
    return scheid[1]
end

gt.delayRun = delayRun


local function stopWatch(time,fun,endFun)
    local time = time
    local scheid = {}
    local stopSche = function (isStop)
             if scheid[1] and (time<=1 or isStop)then
                          gt.scheduler:unscheduleScriptEntry(scheid[1])
                            scheid[1] = nil
                            scheid = nil
                             if endFun then      
                                   endFun()
                               end
                          end
          end

    scheid[1]  = gt.scheduler:scheduleScriptFunc(function (dt)
                      
                            stopSche()    
                                
                                time = time - 1
                               if fun then 
                               local res =  fun(time)
                                   if res == false then
                                    stopSche(true)
                                   end
                             end 
                             end , 1, false)
   return scheid[1]

end

gt.stopWatch = stopWatch


local function switchParentNode(node,parentNode,Zorder)
    node:retain()
    node:removeFromParent()
    if Zorder then
        parentNode:addChild(node,Zorder)
    else
        parentNode:addChild(node)
    end
    
    node:release()
end

gt.switchParentNode = switchParentNode