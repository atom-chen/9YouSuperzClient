local gt = cc.exports.gt

local RubCardsAni = class("RubCardsAni", function()
	return cc.Node:create()
end)

function RubCardsAni:ctor(cards, cardsInHand, gameId , isTwelve)
	-- cards = {74}
	self:setName("RubCardsAni")

 	local csbName = "csd/RubCardsAni.csb"
	if isTwelve then
		csbName = "csd/RubCardsAniTwelve.csb"
	end
	local csbNode = cc.CSLoader:createNode(csbName)
	self.isTwelve = isTwelve or false

	csbNode:setAnchorPoint(0.5, 0.5)
	csbNode:setPosition(gt.winCenter)
	csbNode:setContentSize(gt.winSize)
    ccui.Helper:doLayout(csbNode)
    self:addChild(csbNode)
	self.csbNode = csbNode
	
	self.back = "image/rub_card/back2.png"
	-- local desktop = cc.UserDefault:getInstance():getStringForKey("Desktop")
	-- if desktop == "3" or desktop == "4" then
	-- 	self.back = "image/rub_card/back.png"
	-- end

    -- 消息分发函数
    gt.registerEventListener(gt.EventType.SHOW_CARD_OVER, self, self.showCardOverEvt)

	-- 关闭按钮
	local closeBtn = gt.seekNodeByName(csbNode, "BtnClose")
	gt.addBtnPressedListener(closeBtn, function()
        gt.dispatchEvent(gt.EventType.RUB_CARD_OVER)
		self:closeView()
	end)

	--明牌展示
    local pShowCardNiu = gt.seekNodeByName(csbNode, "Node_ShowCard")
    pShowCardNiu:setVisible(false)
    local pShowCardSG = gt.seekNodeByName(csbNode, "Node_ShowCardSG")
    pShowCardSG:setVisible(false)
	local pShowCardTTZ=gt.seekNodeByName(csbNode,"Node_ShowCardTTZ")
	pShowCardTTZ:setVisible(false)
    self.pShowCard = pShowCardNiu
    --明牌展示的张数
    self.showCardNum = 4
    --牌的总张数
    self.cardsNum = 5
    if gameId == gt.GameID.SANGONG then
        self.showCardNum = 2
        self.cardsNum = 3
        self.pShowCard = pShowCardSG
	elseif gameId == gt.GameID.TTZ then
		self.showCardNum = 1
		self.cardsNum = 2
		self.pShowCard = pShowCardTTZ
    end

	if TurnCard and #cards == 1 then
		if TurnCard.getVersion then
			if TurnCard:getVersion() == 2 then 
				self:RubCard3D_V2(cards, cardsInHand)
			elseif TurnCard:getVersion() == 3 then
				self:RubCard3D_V3(cards, cardsInHand)
			end
		else
			self:RubCard3D_V1(cards, cardsInHand)
		end
		return
	end

    -- 初始化牌
    self.imgCards = {}
    if (#cards == 1) then
        --搓1张牌
        for i = 1, 5 do
            if (i <= self.showCardNum) then
                local showCardName = string.format("Image_%d",i)
                local imgShowCard = gt.seekNodeByName(self.pShowCard, showCardName)
                imgShowCard:loadTexture(string.format("image/card/%02x.png", cardsInHand[i]), ccui.TextureResType.plistType)
                self.pShowCard:setVisible(true)
            end

            local cardName = string.format("Img_Card%d", i)
            local imgCard = gt.seekNodeByName(csbNode, cardName)
            if (i < 4) then
                imgCard:setVisible(false)
            else
                if (i == 4) then
            	 	local cardInHand = cards[1] 

	                if cardInHand > 224 then
	                	if cardInHand > 240 then
	                		cardInHand = 240
	                	else
	                		cardInHand = 224
	                	end

	                    imgCard:loadTexture(string.format("%02x.png", cardInHand), ccui.TextureResType.plistType)
	                elseif cardInHand >= 74 then
	                    imgCard:loadTexture(string.format("%02x.png", cardInHand), ccui.TextureResType.plistType)
	                else
	                    imgCard:loadTexture(string.format("image/rub_card/%02x.png", cards[1]), ccui.TextureResType.plistType)
	                end
                else
                    imgCard:loadTexture("image/rub_card/back.png", ccui.TextureResType.plistType)
                end
                table.insert(self.imgCards, imgCard)
            end
        end
    elseif (#cards == 2) then
        --搓2张牌
        for i = 1, 5 do
            local cardName = string.format("Img_Card%d", i)
            local imgCard = gt.seekNodeByName(csbNode, cardName)
            if (i < 4) then
                imgCard:setVisible(false)
            else
            	local cardInHand = cards[i-3]
				-- local cardInHand = 241
                if cardInHand > 224 then
                	if cardInHand > 240 then
                		cardInHand = 240
                	else
                		cardInHand = 224
                	end
                	imgCard:loadTexture(string.format("%02x.png", cardInHand), ccui.TextureResType.plistType)
                elseif cardInHand >= 74 then
                    imgCard:loadTexture(string.format("%02x.png", cardInHand), ccui.TextureResType.plistType)
	            else    	
                	imgCard:loadTexture(string.format("image/rub_card/%02x.png", cards[i-3]), ccui.TextureResType.plistType)
                end
                table.insert(self.imgCards, imgCard)
            end
        end        
    else
        --搓5张牌(三公搓三张牌)
        for i = 1, 5 do
            local cardName = string.format("Img_Card%d", i)
            local imgCard = gt.seekNodeByName(csbNode, cardName)
            if gameId == gt.GameID.NIUNIU then
            	local cardInHand = cards[i]
			-- local cardInHand = 241
                if cardInHand > 224 then
                	if cardInHand > 240 then
                		cardInHand = 240
                	else
                		cardInHand = 224
                	end
                	imgCard:loadTexture(string.format("%02x.png",cardInHand), ccui.TextureResType.plistType)
                elseif cardInHand >= 74 then
                    imgCard:loadTexture(string.format("%02x.png", cardInHand), ccui.TextureResType.plistType)
                else
                	imgCard:loadTexture(string.format("image/rub_card/%02x.png", cards[i]), ccui.TextureResType.plistType)
                end
                table.insert(self.imgCards, imgCard)            
            elseif gameId == gt.GameID.SANGONG then
                if i > 3 then
                    imgCard:setVisible(false)
                else
                    imgCard:loadTexture(string.format("image/rub_card/%02x.png", cards[i]), ccui.TextureResType.plistType)
                    table.insert(self.imgCards, imgCard) 
                end
            end
        end            
    end    
    
    for i = 1, #self.imgCards do
        local imgCard = self.imgCards[i]

        local function onTouchBegan(touch, event)
            -- 不要忘了return true  否则你懂的（事件不能响应）       
            local target = event:getCurrentTarget()  --获取当前的控件
            local posInCard = target:convertToNodeSpace(touch:getLocation())
            local size = target:getContentSize()
            local rect = cc.rect(0, 0, size.width, size.height)
         
            if (cc.rectContainsPoint(rect, posInCard)) then
                return true
            end

            return false      
        end

        local function onTouchEnded(touch, event)
            -- body
            --gt.log("------onTouchEnded")
            local bOver = self:isRubOver()
            if bOver then
                self:overAni()
            end
            
        end
 
        local function onTouchMoved(touch, event)
            --gt.log("------onTouchMoved")
            local target = event:getCurrentTarget()  --获取当前的控件
            local posX,posY = target:getPosition()  --获取当前的位置
            local delta = touch:getDelta() --获取滑动的距离
            target:setPosition(cc.p(posX + delta.x, posY + delta.y)) --重新设置位置
        end
 
        local listener = cc.EventListenerTouchOneByOne:create()  --创建一个单点事件监听
        listener:setSwallowTouches(true)  --是否向下传递
        listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
        listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
        listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
        local eventDispatcher = self:getEventDispatcher() 
        eventDispatcher:addEventListenerWithSceneGraphPriority(listener, imgCard) --分发监听事件        
    end
end

-- 是否搓牌完成
function RubCardsAni:isRubOver()
    for i = 1, #self.imgCards do
        local card = self.imgCards[i]
        local posX,posY = card:getPosition()
        for j = #self.imgCards, 1, -1 do
            local tmpCard = self.imgCards[j]
            local tmpPosX,tmpPosY = tmpCard:getPosition()
            if (j > i) then
                local dx = tmpPosX - posX
                local dy = tmpPosY - posY
                if ((dx > -450 and dx < 40) and (dy > -130 and dy < 560)) then
                    return false
                end                    
            elseif (j < i) then
                local dx = posX - tmpPosX
                local dy = posY - tmpPosY
                if ((dx > -450 and dx < 40) and (dy > -130 and dy < 560)) then
                    return false
                end                    
            end 
        end
    end

    return true
end

function RubCardsAni:overAni()
    for i = 1, #self.imgCards do
        local card = self.imgCards[i]
        local pos = cc.p(640, -100)
        card:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, pos)))
        card:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.RotateTo:create(0.5, 8*(i-1), 8*(i-1))))
    end

    local func = function()
        gt.dispatchEvent(gt.EventType.RUB_CARD_OVER)
        self:closeView()
    end
    self:runAction(cc.Sequence:create(cc.DelayTime:create(1.1), cc.CallFunc:create(func)))
end

function RubCardsAni:showCardOverEvt()
    self:closeView()        
end

function RubCardsAni:closeView()
    gt.removeTargetAllEventListener(self)
	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:removeEventListenersForTarget(self)
	if self.scheduleHandler then
		gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
	end
	self:removeFromParent()        
end

function RubCardsAni:RubCard3D_V1(cards, cardsInHand)
	for i = 1, 5 do
        local imgCard = gt.seekNodeByName(self.csbNode, string.format("Img_Card%d", i))
		imgCard:setVisible(false)
	end

	self.pShowCard:setVisible(true)
    for i = 1, self.showCardNum do
		if  cardsInHand[i] then
			local imgShowCard = gt.seekNodeByName(self.pShowCard, string.format("Image_%d",i))
			imgShowCard:loadTexture(string.format("image/card/%02x.png", cardsInHand[i]), ccui.TextureResType.plistType)
		end
    end
	
	cc.SpriteFrameCache:getInstance():addSpriteFrames("image/rub_card/rub_card_blank.plist")
	cc.SpriteFrameCache:getInstance():addSpriteFrames("image/rub_card/rub_king.plist")
	cc.SpriteFrameCache:getInstance():addSpriteFrames("image/rub_card/rub_hua.plist")
	
	local index = -1
	local TurnCornerParam = {
		--角度,半径,最大偏移量
		{angle = 0,				radius = 90, maxoffset = 320, dir = cc.p(-1, 0)},	--右边
		{angle = -math.pi*0.3,	radius = 70, maxoffset = 280, dir = cc.p(2, 2)},	--右下角
		{angle = -math.pi*0.5,	radius = 90, maxoffset = 360, dir = cc.p(0, 1)},	--下边
		{angle = -math.pi*0.7,	radius = 70, maxoffset = 280, dir = cc.p(-2, 2)},	--左下角
		{angle = math.pi,		radius = 90, maxoffset = 320, dir = cc.p(1, 0)},	--左边
		{angle = math.pi*0.7,	radius = 70, maxoffset = 280, dir = cc.p(-2, -2)},	--左上角
		{angle = math.pi*0.5,	radius = 90, maxoffset = 340, dir = cc.p(0, -1)},	--上边
		{angle = math.pi*0.3,	radius = 70, maxoffset = 280, dir = cc.p(2, -2)}	--右上角
	}
	local width = 620  --708
	local height = 444  --508

	local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()

	local pos = cc.p(visibleSize.width/2+origin.x, visibleSize.height/2+origin.y)
	local gridRect = cc.rect(pos.x - width/2,
		pos.y - height/2 - 60,
		width,
		height)
	local card_node = cc.NodeGrid:create()
	card_node:setGridRect(gridRect)
	card_node:setContentSize(cc.size(width, height))
	card_node:setPosition(pos.x - width/2, pos.y - height/2 - 60)

	local action = TurnCard:create(0, cc.size(70, 50))
	action:setBackSpriteFrame(self.back)
	card_node:runAction(action)
	self:addChild(card_node)
	local t = 0

	local function update(dt)
		t = t + dt
		if t > 0.5 then
			if self.scheduleHandler then
				gt.scheduler:unscheduleScriptEntry(self.scheduleHandler)
				self.scheduleHandler = nil
			end
			card_node:runAction(cc.Sequence:create(cc.FadeOut:create(0.1), cc.RemoveSelf:create()))
			local sp 

			local cardInHand = cards[1]
			-- local cardInHand = 241
            if cardInHand > 224 then
            	if cardInHand > 240 then
            		cardInHand = 240
            	else
            		cardInHand = 224
            	end
				sp= cc.Sprite:createWithSpriteFrameName(string.format("%02x.png",cardInHand))
			elseif cardInHand >= 74 then
				sp= cc.Sprite:createWithSpriteFrameName(string.format("%02x.png",cardInHand)) 
            else
				sp= cc.Sprite:createWithSpriteFrameName(string.format("image/rub_card/%02x.png", cards[1]))
			end
			sp:setOpacity(0)
			sp:runAction(cc.FadeIn:create(0.1))
			sp:setScale(1.4)
			sp:setPosition(pos.x, pos.y-60)
			sp:setRotation(90)
			self:addChild(sp)

			self:runAction(cc.Sequence:create(cc.DelayTime:create(1.1), cc.CallFunc:create(function()
				gt.dispatchEvent(gt.EventType.RUB_CARD_OVER)
				self:closeView()
			end)))
		end
		if (action) then
			local deltaRate = 1.2 --控制卷曲的速度
			local angle = TurnCornerParam[index+1].angle
			local dir = cc.p(-math.cos(angle), -math.sin(angle))
			local dir2 = cc.pMul(TurnCornerParam[index+1].dir, dt*TurnCornerParam[index+1].maxoffset*2)
			action:addDelta(cc.pDot(dir2, dir) * deltaRate)
		end
	end
	
    local function onTouchBegan(touch, event)
   		local target = event:getCurrentTarget()
		local locationInNode = target:convertToNodeSpace(touch:getLocation())
		local s = target:getContentSize()
		local d = 40
		local rect = cc.rect(-d, -d, s.width+d, s.height+d)

		if (cc.rectContainsPoint(rect,locationInNode)) then
			if (action) then
				action:setReturnBack(false)
			end
			return true
		end
		return false
    end

    local function onTouchEnded(touch, event)
		if (action and index > -1) then
			if action:getDelta() >= TurnCornerParam[index+1].maxoffset then
				self:getEventDispatcher():removeEventListenersForTarget(self)
				action:setMaxDelta(10000)
				self.scheduleHandler = gt.scheduler:scheduleScriptFunc(update, 0.05, false)
			else
				action:setReturnBack(true)
				index = -1
			end
		end
    end
 
    local function onTouchMoved(touch, event)
		if (index == -1) then
			local delta = cc.pSub(touch:getLocation(), touch:getStartLocation())
			if (cc.pGetLength(delta) > 1) then --滑动一段距离才判定是否执行翻转操作
				--首先判断落点
				local locationInNode = event:getCurrentTarget():convertToNodeSpace(touch:getLocation())
				if (locationInNode.x < width * 0.3) then
					if (locationInNode.y < height * 0.3) then
						index = 3  --左下角
					elseif (locationInNode.y > height * 0.7) then
						index = 5  --左上角
					else
						index = 4  --左边
					end
				elseif (locationInNode.x > width * 0.7) then
					if (locationInNode.y < height * 0.3) then
						index = 1  --右下角
					elseif (locationInNode.y > height * 0.7) then
						index = 7  --右上角
					else
						index = 0  --右边
					end
				else
					if (locationInNode.y < height * 0.3) then
						index = 2  --下边
					elseif (locationInNode.y > height * 0.7) then
						index = 6  --上边
					end
				end

				if (index ~= -1) then
					action:setAngle(TurnCornerParam[index+1].angle)
					action:setRadius(TurnCornerParam[index+1].radius)
					action:setMaxDelta(TurnCornerParam[index+1].maxoffset)
					
					if (index == 2 or index == 6) then
						--如果是上下，则要显示无字牌
						local cardInHand = cards[1]
						-- local cardInHand = 241
			            if cardInHand > 224 then
			            	if cardInHand > 240 then
			            		cardInHand = 240
			            	else
			            		cardInHand = 224
			            	end
					
							action:setFrontSpriteFrame(string.format("%02x.png",cardInHand))
						elseif cardInHand >= 74 then
							action:setFrontSpriteFrame(string.format("%02x.png",cardInHand))
						else
							action:setFrontSpriteFrame(string.format("image/rub_card_blank/%02x.png", cards[1]))
						end
					else
						local cardInHand = cards[1]
						-- local cardInHand = 241
			            if cardInHand > 224 then
			            	if cardInHand > 240 then
			            		cardInHand = 240
			            	else
			            		cardInHand = 224
			            	end
					
							action:setFrontSpriteFrame(string.format("%02x.png",cardInHand))
						elseif cardInHand >= 74 then
							action:setFrontSpriteFrame(string.format("%02x.png",cardInHand))
						else
							action:setFrontSpriteFrame(string.format("image/rub_card/%02x.png", cards[1]))
						end
					end
				end
			end
		else
			if (action) then
				local deltaRate = 1.5 --控制卷曲的速度
				local angle = TurnCornerParam[index+1].angle
				local dir = cc.p(-math.cos(angle), -math.sin(angle))

				action:addDelta(cc.pDot(touch:getDelta(), dir) * deltaRate)
			end
		end
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, card_node)
end

function RubCardsAni:RubCard3D_V2(cards, cardsInHand)
	for i = 1, 5 do
        local imgCard = gt.seekNodeByName(self.csbNode, string.format("Img_Card%d", i))
		imgCard:setVisible(false)
	end

	self.pShowCard:setVisible(true)
    for i = 1, self.showCardNum do
		if cardsInHand[i] then
			local imgShowCard = gt.seekNodeByName(self.pShowCard, string.format("Image_%d",i))
			imgShowCard:loadTexture(string.format("image/card/%02x.png", cardsInHand[i]), ccui.TextureResType.plistType)
			imgShowCard:setVisible(true)
		end
    end
	
	cc.SpriteFrameCache:getInstance():addSpriteFrames("image/rub_card/rub_hua.plist")
	cc.SpriteFrameCache:getInstance():addSpriteFrames("image/rub_card/rub_king.plist")
	cc.SpriteFrameCache:getInstance():addSpriteFrames("image/rub_card/rub_card_blank.plist")
	
	local index = -1
	local TurnCornerParam = {
		--角度,半径,最大偏移量
		{angle = 0,				radius = 45, maxoffset = 300, dir = cc.p(-1, 0) , orbview = false},	--右边
		{angle = -math.pi*0.25,	radius = 60, maxoffset = 400, dir = cc.p(2, 2)  , orbview = true},	--右下角
		{angle = -math.pi*0.5,	radius = 60, maxoffset = 600, dir = cc.p(0, 1)  , orbview = false},	--下边
		{angle = -math.pi*0.75,	radius = 60, maxoffset = 400, dir = cc.p(-2, 2) , orbview = true},	--左下角
		{angle = math.pi,		radius = 45, maxoffset = 300, dir = cc.p(1, 0)  , orbview = false},	--左边
		{angle = math.pi*0.7,	radius = 60, maxoffset = 320, dir = cc.p(-2, -2) , orbview = true},	--左上角
		{angle = math.pi*0.5,	radius = 60, maxoffset = 500, dir = cc.p(0, -1) , orbview = false},	--上边
		{angle = math.pi*0.3,	radius = 60, maxoffset = 320, dir = cc.p(2, -2) , orbview = true}	--右上角
	}
	local width = 708  --708
	local height = 508  --508

	local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()

	local pos = cc.p(visibleSize.width/2+origin.x, visibleSize.height/2+origin.y)
	local gridRect = cc.rect(pos.x - width/2,
		pos.y - height/2 - 60,
		width,
		height)
	local card_node = cc.NodeGrid:create()
	card_node:setGridRect(gridRect)
	card_node:setContentSize(visibleSize)

	local action = TurnCard:create(0, cc.size(100, 80))
	action:setBackSpriteFrame(self.back)
	card_node:runAction(action)
	self:addChild(card_node)

	local TurnInfoParam = {
		{show = true , info="arrow_lr.png", flip=true , anioffset = cc.p(-20,0) , infopos = cc.p(gridRect.x + gridRect.width + 90,gridRect.y + gridRect.height / 2),correct = -50 }, --右边
		{show = false, info="arrow_lr.png", flip=true,  anioffset = cc.p(-20,0) , infopos = cc.p(0,0) ,correct = -50}, --右下角
		{show = true, info="arrow_up.png", flip=false,  anioffset = cc.p(0,20),   infopos=cc.p(gridRect.x - 80,gridRect.y - 30) ,  correct = -50}, --下边
		{show = false,info="arrow_lr.png",  flip=true,  anioffset = cc.p(-20,0),  infopos=cc.p(0,0) ,correct = -50},--左下角
		{show = true,info="arrow_lr.png",   flip=false, anioffset = cc.p(20,0),   infopos=cc.p( gridRect.x - 90,gridRect.y + gridRect.height /2 ),correct = -50},--左边
		{show = true,info="arrow_top_lr.png",flip=false,anioffset = cc.p(20,-20),  infopos=cc.p(gridRect.x  - 50,gridRect.y + gridRect.height + 50),correct = -50},--左上
		{show = true,info="arrow_up.png",   flip=false,  anioffset = cc.p(0,20),  infopos= cc.p(gridRect.x + gridRect.width + 80, gridRect.y - 30),correct = -50}, --上边
		{show = true,info="arrow_top_lr.png",flip=true, anioffset = cc.p(-20,-20),infopos=cc.p(gridRect.x  + gridRect.width + 50,gridRect.y + gridRect.height + 50),correct = -50},--右上
	}
	local info_nodes = {}

	--创建提示动画
	for k,data_conf in pairs(TurnInfoParam) do 
		if data_conf.show ~= nil and data_conf.show then 
			local spr_node = cc.Sprite:create("image/rub_card/"..data_conf.info)
			local move_to  = cc.MoveBy:create(0.3, data_conf.anioffset)
			local move_back = move_to:reverse()
			spr_node:setPosition( data_conf.infopos )
			spr_node:runAction( cc.RepeatForever:create( cc.Sequence:create(move_to, move_back) ) )
			spr_node:setFlipX( data_conf.flip )
			spr_node:setOpacity(128)
			self:addChild(spr_node)
			table.insert(info_nodes,spr_node)
		end 
	end 
	
    local function onTouchBegan(touch, event)
		if action:isInAniTurnStep() then
			return false
		end
   		local target = event:getCurrentTarget()
		local locationInNode = target:convertToNodeSpace(touch:getLocation())
		locationInNode = cc.pSub(locationInNode,cc.p(gridRect.x,gridRect.y))

        action:setReturnBack(false)
        --[[if locationInNode.x <= 0 then 
            if locationInNode.y <= height * 0.3 then 
                index = 3
            elseif locationInNode.y >= height then 
                index = 6
            else 
                index = 5
            end 
        elseif locationInNode.x >= width then 
            if locationInNode.y <= height * 0.3 then 
                index = 3
            elseif locationInNode.y >= height then 
                index = 8
            else 
                index = 1
            end 
        else
            if locationInNode.y >= height * 0.7 then 
                index = 7
            else 
                index = 3
            end 
        end --]]
		index = 3

		print("index is "..index)
        action:setAngle(TurnCornerParam[index].angle)
        action:setRadius(TurnCornerParam[index].radius)
        action:setMaxDelta(TurnCornerParam[index].maxoffset)
        action:setUserOrbCamera(TurnCornerParam[index].orbview)
		action:setCorrectOffset( TurnInfoParam[index].correct )
        if (index == 3 or index == 7) then
			--如果是上下，则要显示无字牌
			local cardInHand = cards[1]
		-- local cardInHand = 241
            if cardInHand > 224 then
            	if cardInHand > 240 then
            		cardInHand = 240
            	else
            		cardInHand = 224
            	end
		
				action:setFrontSpriteFrame(string.format("%02x.png",cardInHand))
			elseif cardInHand >= 74 then
				action:setFrontSpriteFrame(string.format("%02x.png",cardInHand))
			else
				action:setFrontSpriteFrame(string.format("image/rub_card_blank/%02x.png", cards[1]))
			end			
		else
			local cardInHand = cards[1]
		-- local cardInHand = 241
            if cardInHand > 224 then
            	if cardInHand > 240 then
            		cardInHand = 240
            	else
            		cardInHand = 224
            	end
		
				action:setFrontSpriteFrame(string.format("%02x.png",cardInHand))
			elseif cardInHand >= 74 then
				action:setFrontSpriteFrame(string.format("%02x.png",cardInHand))
			else
				action:setFrontSpriteFrame(string.format("image/rub_card/%02x.png", cards[1]))
			end
		end
		
        local dir2 = cc.p( - math.cos(TurnCornerParam[index].angle), - math.sin(TurnCornerParam[index].angle) );
        if index == 3 then 
			local delta = math.min( math.max(locationInNode.y, 0) , TurnCornerParam[index].maxoffset-10)
            action:setDelta(delta );
        elseif index == 1 then
            action:setDelta( math.max(gridRect.width - locationInNode.x ,0))
        elseif index == 5 then 
            action:setDelta( math.max(locationInNode.x, 0) )
        elseif index == 7 then 
            action:setDelta( math.max(gridRect.height - locationInNode.y, 0) )
        elseif index == 8 then 
            locationInNode = cc.pSub(locationInNode ,cc.p(gridRect.width,gridRect.height))
            action:setDelta( math.max( cc.pDot(locationInNode,dir2) , 0))
            action:setTurnToAngle(0)
        elseif index == 6 then 
            locationInNode = cc.pSub(locationInNode ,cc.p(0,gridRect.height))
            action:setDelta( math.max( cc.pDot(locationInNode,dir2) , 0))
            action:setTurnToAngle(math.pi)
        end 

		for k,node in pairs(info_nodes) do 
			node:setVisible(false)
		end 

		return true
    end

    local function onTouchEnded(touch, event)
		if (action and index > -1) then
            action:setReturnBack(true)
			index = -1
		end
    end
 
    local function onTouchMoved(touch, event)
        local target = event:getCurrentTarget()
		local locationInNode = target:convertToNodeSpace(touch:getLocation())
		locationInNode = cc.pSub(locationInNode,cc.p(gridRect.x,gridRect.y))
        if index == 3 then 
            action:addDelta(touch:getDelta().y * 2.5)
        elseif index == 1 then
            action:addDelta(-touch:getDelta().x)
        elseif index == 5 then
            action:addDelta(touch:getDelta().x)
        elseif index == 7 then 
            action:addDelta(-touch:getDelta().y)
        elseif index == 8 then 
            locationInNode = cc.pSub(cc.p(gridRect.width/2, gridRect.height/2),locationInNode )
            locationInNode = cc.pNormalize(locationInNode)
			action:addDelta( cc.pDot(touch:getDelta(),locationInNode) )
        elseif index == 6 then 
            locationInNode = cc.pSub(cc.p(gridRect.width/2, gridRect.height/2),locationInNode )
            locationInNode = cc.pNormalize(locationInNode)
			action:addDelta( cc.pDot(touch:getDelta(),locationInNode) )
        end

		if action:isInAniTurnStep() then 
			local cardInHand = cards[1]
			-- local cardInHand = 241
            if cardInHand > 224 then
            	if cardInHand > 240 then
            		cardInHand = 240
            	else
	            	cardInHand = 224
            	end
		
				action:setFrontSpriteFrame(string.format("%02x.png",cardInHand))
			elseif cardInHand >= 74 then
				action:setFrontSpriteFrame(string.format("%02x.png",cardInHand))
			else
	            action:setFrontSpriteFrame(string.format("image/rub_card/%02x.png", cards[1]))
	        end
			
			self:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
				gt.dispatchEvent(gt.EventType.RUB_CARD_OVER)
				self:closeView()
			end)))
        end 
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, card_node)
end


function RubCardsAni:RubCard3D_V3(cards, cardsInHand)
	for i = 1, 5 do
        local imgCard = gt.seekNodeByName(self.csbNode, string.format("Img_Card%d", i))
		imgCard:setVisible(false)
	end

	self.pShowCard:setVisible(true)
    for i = 1, self.showCardNum do
		if cardsInHand[i] then
			local imgShowCard = gt.seekNodeByName(self.pShowCard, string.format("Image_%d",i))
			imgShowCard:loadTexture(string.format("image/card/%02x.png", cardsInHand[i]), ccui.TextureResType.plistType)
		end
    end
	
	cc.SpriteFrameCache:getInstance():addSpriteFrames("image/rub_card/rub_card_blank.plist")
	cc.SpriteFrameCache:getInstance():addSpriteFrames("image/rub_card/rub_card_word.plist")
	cc.SpriteFrameCache:getInstance():addSpriteFrames("image/rub_card/rub_king.plist")
	cc.SpriteFrameCache:getInstance():addSpriteFrames("image/rub_card/rub_hua.plist")
	
	local index = -1
	local TurnCornerParam = {
		--角度,半径,最大偏移量
		{angle = 0,				radius = 45, maxoffset = 300, dir = cc.p(-1, 0) , orbview = false},	--右边
		{angle = -math.pi*0.25,	radius = 60, maxoffset = 400, dir = cc.p(2, 2)  , orbview = true},	--右下角
		{angle = -math.pi*0.5,	radius = 60, maxoffset = 500, dir = cc.p(0, 1)  , orbview = false},	--下边
		{angle = -math.pi*0.75,	radius = 60, maxoffset = 400, dir = cc.p(-2, 2) , orbview = true},	--左下角
		{angle = math.pi,		radius = 45, maxoffset = 300, dir = cc.p(1, 0)  , orbview = false},	--左边
		{angle = math.pi*0.7,	radius = 60, maxoffset = 320, dir = cc.p(-2, -2) , orbview = true},	--左上角
		{angle = math.pi*0.5,	radius = 60, maxoffset = 500, dir = cc.p(0, -1) , orbview = false},	--上边
		{angle = math.pi*0.3,	radius = 60, maxoffset = 320, dir = cc.p(2, -2) , orbview = true}	--右上角
	}
	local width = 708  --708
	local height = 508  --508

	local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()

	local pos = cc.p(visibleSize.width/2+origin.x, visibleSize.height/2+origin.y)
	local gridRect = cc.rect(pos.x - width/2,
		-- pos.y - height/2 - 60,
		pos.y - height/2,
		width,
		height)
	local card_node = cc.NodeGrid:create()
	card_node:setGridRect(gridRect)
	card_node:setContentSize(visibleSize)

	local action = TurnCard:create(0, cc.size(100, 80))
	action:setBackSpriteFrame(self.back)
	action:setFade(50,0)
	card_node:runAction(action)

	self:addChild(card_node)

	local TurnInfoParam = {
		{show = false , info="arrow_lr.png", flip=true , anioffset = cc.p(-20,0) , infopos = cc.p(gridRect.x + gridRect.width + 90,gridRect.y + gridRect.height / 2),correct = -50 }, --右边
		{show = false, info="arrow_lr.png", flip=true,  anioffset = cc.p(-20,0) , infopos = cc.p(0,0) ,correct = -50}, --右下角
		{show = true, info="arrow_up.png", flip=false,  anioffset = cc.p(0,20),   infopos=cc.p(gridRect.x - 80,gridRect.y - 30) ,  correct = -50}, --下边
		{show = false,info="arrow_lr.png",  flip=true,  anioffset = cc.p(-20,0),  infopos=cc.p(0,0) ,correct = -50},--左下角
		{show = false,info="arrow_lr.png",   flip=false, anioffset = cc.p(20,0),   infopos=cc.p( gridRect.x - 90,gridRect.y + gridRect.height /2 ),correct = -50},--左边
		{show = false,info="arrow_top_lr.png",flip=false,anioffset = cc.p(20,-20),  infopos=cc.p(gridRect.x  - 50,gridRect.y + gridRect.height + 50),correct = -50},--左上
		{show = true,info="arrow_up.png",   flip=false,  anioffset = cc.p(0,20),  infopos= cc.p(gridRect.x + gridRect.width + 80, gridRect.y - 30),correct = -50}, --上边
		{show = false,info="arrow_top_lr.png",flip=true, anioffset = cc.p(-20,-20),infopos=cc.p(gridRect.x  + gridRect.width + 50,gridRect.y + gridRect.height + 50),correct = -50},--右上
	}


	if self.isTwelve then
		TurnInfoParam = {
			{show = true , info="arrow_lr.png", flip=true , anioffset = cc.p(-20,0) , infopos = cc.p(gridRect.x + gridRect.width + 90,gridRect.y + gridRect.height / 2),correct = -50 }, --右边
			{show = true, info="arrow_lr.png", flip=true,  anioffset = cc.p(-20,0) , infopos = cc.p(0,0) ,correct = -50}, --右下角
			{show = false, info="arrow_up.png", flip=false,  anioffset = cc.p(0,20),   infopos=cc.p(gridRect.x - 80,gridRect.y - 30) ,  correct = -50}, --下边
			{show = false,info="arrow_lr.png",  flip=true,  anioffset = cc.p(-20,0),  infopos=cc.p(0,0) ,correct = -50},--左下角
			{show = false,info="arrow_lr.png",   flip=false, anioffset = cc.p(20,0),   infopos=cc.p( gridRect.x - 90,gridRect.y + gridRect.height /2 ),correct = -50},--左边
			{show = false,info="arrow_top_lr.png",flip=false,anioffset = cc.p(20,-20),  infopos=cc.p(gridRect.x  - 50,gridRect.y + gridRect.height + 50),correct = -50},--左上
			{show = false,info="arrow_up.png",   flip=false,  anioffset = cc.p(0,20),  infopos= cc.p(gridRect.x + gridRect.width + 80, gridRect.y - 30),correct = -50}, --上边
			{show = false,info="arrow_top_lr.png",flip=true, anioffset = cc.p(-20,-20),infopos=cc.p(gridRect.x  + gridRect.width + 50,gridRect.y + gridRect.height + 50),correct = -50},--右上
		}
	end

	local info_nodes = {}

	--创建提示动画
	for k,data_conf in pairs(TurnInfoParam) do 
		if data_conf.show ~= nil and data_conf.show then 
			local spr_node = cc.Sprite:create("image/rub_card/"..data_conf.info)
			local move_to  = cc.MoveBy:create(0.3, data_conf.anioffset)
			local move_back = move_to:reverse()
			spr_node:setPosition( data_conf.infopos )
			spr_node:runAction( cc.RepeatForever:create( cc.Sequence:create(move_to, move_back) ) )
			spr_node:setFlipX( data_conf.flip )
			spr_node:setOpacity(128)
			self:addChild(spr_node)
			table.insert(info_nodes,spr_node)
		end 
	end 
	
    local function onTouchBegan(touch, event)
		if action:isInAniTurnStep() then
			return false
		end
   		local target = event:getCurrentTarget()
		local locationInNode = target:convertToNodeSpace(touch:getLocation())
		locationInNode = cc.pSub(locationInNode,cc.p(gridRect.x,gridRect.y))

        action:setReturnBack(false)
        --[[if locationInNode.x <= 0 then 
            if locationInNode.y <= height * 0.3 then 
                index = 3
            elseif locationInNode.y >= height then 
                index = 6
            else 
                index = 5
            end 
        elseif locationInNode.x >= width then 
            if locationInNode.y <= height * 0.3 then 
                index = 3
            elseif locationInNode.y >= height then 
                index = 8
            else 
                index = 1
            end 
        else
            if locationInNode.y >= height * 0.7 then 
                index = 7
            else 
                index = 3
            end 
        end --]]
        index = 3
        if self.isTwelve then
			index = 1
		end

		print("index is "..index)
        action:setAngle(TurnCornerParam[index].angle)
        action:setRadius(TurnCornerParam[index].radius)
        action:setMaxDelta(TurnCornerParam[index].maxoffset)
        action:setUserOrbCamera(TurnCornerParam[index].orbview)
		action:setCorrectOffset( TurnInfoParam[index].correct )

		--显示无字
		local cardInHand = cards[1]
		-- local cardInHand = 241
        if cardInHand > 224 then
        	if cardInHand > 240 then
        		cardInHand = 240
        	else
        		cardInHand = 224
        	end
	
			action:setFrontSpriteFrame(string.format("%02x.png",cardInHand))
		elseif cardInHand >= 74 then
			action:setFrontSpriteFrame(string.format("%02x.png",cardInHand))
		else
			action:setFrontSpriteFrame(string.format("image/rub_card_blank/%02x.png", cards[1]))
		end

        --[[if (index == 3 or index == 7) then
			--如果是上下，则要显示无字牌
			action:setFrontSpriteFrame(string.format("image/rub_card_blank/%02x.png", cards[1]))
		else
			action:setFrontSpriteFrame(string.format("image/rub_card/%02x.png", cards[1]))
		end--]]
		
        local dir2 = cc.p( - math.cos(TurnCornerParam[index].angle), - math.sin(TurnCornerParam[index].angle) );
        if index == 3 then 
			local delta = math.min( math.max(locationInNode.y, 0) , TurnCornerParam[index].maxoffset-10)
            action:setDelta(delta );
        elseif index == 1 then
            action:setDelta( math.max(gridRect.width - locationInNode.x ,0))
        elseif index == 5 then 
            action:setDelta( math.max(locationInNode.x, 0) )
        elseif index == 7 then 
            action:setDelta( math.max(gridRect.height - locationInNode.y, 0) )
        elseif index == 8 then 
            locationInNode = cc.pSub(locationInNode ,cc.p(gridRect.width,gridRect.height))
            action:setDelta( math.max( cc.pDot(locationInNode,dir2) , 0))
            action:setTurnToAngle(0)
        elseif index == 6 then 
            locationInNode = cc.pSub(locationInNode ,cc.p(0,gridRect.height))
            action:setDelta( math.max( cc.pDot(locationInNode,dir2) , 0))
            action:setTurnToAngle(math.pi)
        end 

		for k,node in pairs(info_nodes) do 
			node:setVisible(false)
		end 

		return true
    end

    local function onTouchEnded(touch, event)
		if (action and index > -1) then
            action:setReturnBack(true)
			index = -1
		end
    end
 
    local function onTouchMoved(touch, event)
        local target = event:getCurrentTarget()
		local locationInNode = target:convertToNodeSpace(touch:getLocation())
		locationInNode = cc.pSub(locationInNode,cc.p(gridRect.x,gridRect.y))
        if index == 3 then 
            local delta = math.max(locationInNode.y, 0)
            action:setDelta(delta );
        elseif index == 1 then
            action:addDelta(-touch:getDelta().x)
        elseif index == 5 then
            action:addDelta(touch:getDelta().x)
        elseif index == 7 then 
            action:addDelta(-touch:getDelta().y)
        elseif index == 8 then 
            locationInNode = cc.pSub(cc.p(gridRect.width/2, gridRect.height/2),locationInNode )
            locationInNode = cc.pNormalize(locationInNode)
			action:addDelta( cc.pDot(touch:getDelta(),locationInNode) )
        elseif index == 6 then 
            locationInNode = cc.pSub(cc.p(gridRect.width/2, gridRect.height/2),locationInNode )
            locationInNode = cc.pNormalize(locationInNode)
			action:addDelta( cc.pDot(touch:getDelta(),locationInNode) )
        end

		if action:isInAniTurnStep() and cards[1] < 74 then 
			--action:setFrontSpriteFrame(string.format("image/rub_card/%02x.png", cards[1]))
			local color = math.floor(cards[1] / 0x10)
			if color == 0 or color == 2 then
				action:setWordSpriteFrame(string.format("image/rub_card_word/%02x.png", cards[1]%16))
			else
				action:setWordSpriteFrame(string.format("image/rub_card_word/%02x.png", 0x10 + cards[1]%16))
			end

			self:runAction(cc.Sequence:create(cc.DelayTime:create(1.1), cc.CallFunc:create(function()
				gt.dispatchEvent(gt.EventType.RUB_CARD_OVER)
				self:closeView()
			end)))
        end 
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, card_node)
end

return RubCardsAni
