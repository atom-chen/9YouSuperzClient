cc.exports.ListViewHelper = class("ListViewHelper")
require("app.ExternalUtils")

function ListViewHelper:ctor(list_view, template_item, create_item_func, use_cache_item)
	self.list_view 		= list_view
	self.list_sz 		= list_view:getContentSize()
	self.inner_sz 		= list_view:getInnerContainerSize()
	self.template_item 	= template_item
	self.item_sz 		= template_item:getContentSize()
	self.item_sz.height = self.item_sz.height 	--在item之间留1像素的空隙
	self.create_item_func = create_item_func
	self.visible_top_i 	= -1
	self.data_list 		= {}	--外部传进来的列表数据
	self.item_pos_list 	= {} 	--用来记录每个item的坐标，以应对item之间有分栏的情况
	self.spaces_list 	= {}	--用来记录分栏信息{i:space}
	self.item_list 		= {} 	--当前显示的items

	self.use_cache_item = use_cache_item 	--是否复用item
	self.cached_items	= {}

	self.is_layout_dirty = false
	self.play_first_open_anim = true
end

function ListViewHelper:SetPlayOpenAnim(b)
	self.play_first_open_anim = b
end

--设置指定item上方的空位，如i==0，表示在最上方加空位
function ListViewHelper:SetSpecialSpace(i, space)
    if i == -1 then
        self.spaces_list = {}
        self.is_layout_dirty = true
    else
	    self.spaces_list[i] = space
	    self.is_layout_dirty = true
    end
end

function ListViewHelper:GetInnerSize()
	return self.inner_sz
end

function ListViewHelper:GetInnerContainer()
	return self.custom_cont
end

function ListViewHelper:SetItemsData(data_list, relayout)
	data_list = data_list or {}
	
	local old_data_list = self.data_list
	self.data_list 	= data_list

	--记录旧的位置
	local cont_pos = self.list_view:getInnerContainerPosition()
	local cont_sz = self.list_view:getInnerContainerSize()
	local cont_y_per = (cont_pos.y) / cont_sz.height

	self:Relayout(false)


	if old_data_list == nil or #old_data_list == 0 or self.inner_sz.height < self.list_sz.height or relayout then
		self.list_view:jumpToPercentVertical(0)
		self.first_update	= true 	--第一次打开时播放动画效果
	else
		self.list_view:setInnerContainerPosition(cc.p(0, cont_y_per * self.inner_sz.height))
	end

	if data_list == nil or #data_list == 0 then
		if self.schedule_handle then
			gt.scheduler:unscheduleScriptEntry(self.schedule_handle)
			self.schedule_handle = nil
		end
	else
		if self.schedule_handle == nil then
			local function update_func(dt_)
				self:Update()
			end
			self.schedule_handle = gt.scheduler:scheduleScriptFunc(update_func, 0.03, false)
		end
		--设置数据后要更新一次，以便创建某些必须控件
		self:Update()
	end
end


function ListViewHelper:Relayout(update_immediatly)
	for i, item in pairs(self.item_list) do
		if self.use_cache_item then
			self:CacheItem(i)
		else
			item:removeFromParent()
		end
	end
	self.item_list = {}
    self.showing_top = nil
    self.showing_bot = nil

	--倒序遍历，从尾部向上	
	self.item_pos_list = {}
	local y = 0
	for i=(#self.data_list), 1, -1 do
		local data = self.data_list[i]
		local space = self.spaces_list[i]
		if space ~= nil then
			y = y + space
		end
		y = y + self.item_sz.height  --注意item的anchor_pt是（0，1）
		self.item_pos_list[i] = cc.p(0, y)
	end
	--看有没有最开头的空位
	local space = self.spaces_list[0]
	if space ~= nil then
		y = y + space
	end
	self.inner_sz.height = y

	--ListView要求inner_sz不能小于list_sz
	if self.inner_sz.height < self.list_sz.height then
		local delta = self.list_sz.height - self.inner_sz.height
		self.inner_sz.height = self.list_sz.height

		for _, pos in pairs(self.item_pos_list) do
			pos.y = pos.y + delta
		end
	end

	--为了避免ListView自动排版造成的错乱和无法掌控，使用一个Custom Widget当容器来装载items
	if self.custom_cont == nil then
		self.custom_cont = ccui.Widget:create()
		self.custom_cont:setAnchorPoint(cc.p(0, 0))
		self.list_view:addChild(self.custom_cont)
	end
    
    --设置容器大小
	self.custom_cont:setContentSize(self.inner_sz)
	self.list_view:setInnerContainerSize(self.inner_sz)


	self.is_layout_dirty = false

	if update_immediatly then
		self:Update()
	end
end

function ListViewHelper:GetShowingIndex()
	local now_pos = self.list_view:getInnerContainerPosition()
	-- print("InnerPos:", self.list_view, now_pos.y)
	local visible_top = self.list_sz.height - now_pos.y
	local visible_bot = -now_pos.y

	local i1, i2 = nil, nil
	for i, pos in pairs(self.item_pos_list) do
		local y1 = pos.y - self.item_sz.height
		local y2 = pos.y
		--if not( 不可见)
		if not (y2 < visible_bot or y1 > visible_top) then 	--记录可见的最小和最大index
			if i1 == nil then
				i1 = i
			end
			i2 = i
		end
	end
	return i1, i2
end

function ListViewHelper:Release()
	self.item_list = {}
	self.data_list = {}
	self.cached_items = {}
	if self.schedule_handle then
		gt.scheduler:unscheduleScriptEntry(self.schedule_handle)
		self.schedule_handle = nil
	end
end

--把item移到复用队列
function ListViewHelper:CacheItem(i)
	local item = self.item_list[i]
	if item then
		item:stopAllActions()
		item:setVisible(false)
		self.item_list[i] = nil
		table.insert(self.cached_items, item)
	end
end

--从复用队列中取出一个item
function ListViewHelper:PopCachedItem()
	local n = #self.cached_items
	if n > 0 then
		local item = self.cached_items[n]
		self.cached_items[n] = nil
		item:setVisible(true)
		return item
	end
end


--创建需要显示的item
--隐藏不需要显示的item
--不需要删除
function ListViewHelper:CreateItem(i)
	local info = self.data_list[i]
	if info and self.item_list[i] == nil and self.create_item_func then
		--尝试取一个复用item
		local cached_item = nil
		if self.use_cache_item then
			cached_item = self:PopCachedItem()
		end

		--创建item的回调函数，（尝试把复用的item作参数传出去）
		local item = self.create_item_func(info, i, cached_item)

		if item then
			self.item_list[i] = item
			--print("创建Item:::::", i)
			local x = (self.inner_sz.width - self.item_sz.width) / 2
			local y = self.inner_sz.height - (i-1) * self.item_sz.height
			item:setAnchorPoint(cc.p(0, 1))
			item:setPosition(self.item_pos_list[i])
			if cached_item == nil then	--只有不是复用的item，才进行add
				self.custom_cont:addChild(item)
			end
			return item
		end
	end
end

function ListViewHelper:GetData(i)
	return self.data_list[i]
end

function ListViewHelper:GetItem(i)
	if self.item_list[i] == nil then
		self:CreateItem(i)
	end
	return self.item_list[i]
end

function ListViewHelper:Count()
	return #self.data_list
end

function ListViewHelper:Update()
	if self.is_layout_dirty then
		self:Relayout(false)
	end
	local i1, i2 = self:GetShowingIndex()

	if self.showing_top == i1 and self.showing_bot == i2 then
		return
	end
	self.showing_top = i1
	self.showing_bot = i2

	--隐藏不可见的item，创建新进入的item
	--不复用item
	if not self.use_cache_item then
		for i=1, #self.data_list do
			local item = self.item_list[i]
			if i < i1 or i > i2 then
				if item then
					item:setVisible(false)
				end
			else
				if item then
					item:setVisible(true)
				else
					item = self:CreateItem(i)
				end
			end
		end

	--复用item
	else
		for i, item in pairs(self.item_list) do
			if i < i1 or i > i2 then
				self:CacheItem(i)
			end
		end

		for i=i1, i2 do
			if self.item_list[i] == nil then
				self:CreateItem(i)
			end
		end
	end

	--播放打开时的效果
	if self.first_update and self.play_first_open_anim then
		local n = math.abs(i1 - i2) + 1
		if n > 0 then
			local delta = 100 / n
			for i=i1, i2 do
				local item = self.item_list[i]
				if item then
					ExternalUtils.ShowItemAnim2(item, 0.08 * (i-1), cc.p(0, 50))
				end
			end
			--
			self.first_update = nil
		end
	end
end