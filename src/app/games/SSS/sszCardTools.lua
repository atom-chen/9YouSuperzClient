local gt = cc.exports.gt

local sszCardTools = {}

--function sszCardTools.new()
--       local self = {}
--	    setmetatable(self,{__index = sszCardTools})
--	    return self
--end

function sszCardTools.color(a) --获取牌型花色
        return math.floor(a/16)
end

function sszCardTools.value(a) --获取牌型值
        return a%16
end

--单前资源 A最大，A为1
function sszCardTools:setAValue(x)   --设置A牌的值为14
     if x == 1 then x =14 end
     return x
end

function sszCardTools:setA_1to14(cards)  --设置A牌的值为14
    for k,v in pairs(cards) do
        if v%16 == 1 then
            cards[k] = v + 13
        end
    end
    return cards
end

function sszCardTools:setA_14to1(cards)  --设置A牌的值为1
     for k,v in pairs(cards) do
        if v%16 == 14 then
            cards[k] = v - 13
        end
    end
end

--发牌时，扑克牌排序 从小到大进行排序
function sszCardTools:CardSortFun(cards)

    table.sort(cards,function (a,b)
         if self.value(a) == self.value(b)  then
           return  self.color(a) <self.color(b)
         else 
         
           return self:setAValue(self.value(a)) < self:setAValue(self.value(b))  
         end
   end)

   return cards
end

-- 从长度为m的数组中选n个元素的组合
function sszCardTools.zuhe(atable, n)
    if n > #atable then
        return {}
    end

    local len = #atable
    local meta = {}
    -- init meta data
    for i=1, len do
        if i <= n then
            table.insert(meta, 1)
        else
            table.insert(meta, 0)
        end
    end

    local result = {}

    -- 记录一次组合
    local tmp = {}
    for i=1, len do
        if meta[i] == 1 then
            table.insert(tmp, atable[i])
        end
    end
    table.insert(result, tmp)

    while true do
        -- 前面连续的0
        local zero_count = 0
        for i=1, len-n do
            if meta[i] == 0 then
                zero_count = zero_count + 1
            else
                break
            end
        end
        -- 前m-n位都是0，说明处理结束
        if zero_count == len-n then
            break
        end

        local idx
        for j=1, len-1 do
            -- 10 交换为 01
            if meta[j]==1 and meta[j+1] == 0 then
                meta[j], meta[j+1] = meta[j+1], meta[j]
                idx = j
                break
            end
        end
        -- 将idx左边所有的1移到最左边
        local k = idx-1
        local count = 0
        while count <= k do
            for i=k, 2, -1 do
                if meta[i] == 1 then
                    meta[i], meta[i-1] = meta[i-1], meta[i]
                end
            end
            count = count + 1
        end

        -- 记录一次组合
        local tmp = {}
        for i=1, len do
            if meta[i] == 1 then
                table.insert(tmp, atable[i])
            end
        end
        table.insert(result, tmp)
    end

    return result
end

--判断table里面有没有元素
function sszCardTools.hasElement(args)
   local flag = false
      for k, v in pairs(args) do
         flag = true
         break
      end
      return flag
end

--删除t1中有t2中的值
function sszCardTools.removeCardTableFromV(t1,t2)
    for k1,v1 in pairs(t2) do
        for k2,v2 in pairs(t1) do   
            if v1 == v2  then
                table.remove(t1,k2)
                break
            end
        end
    end

    return t1
end

function sszCardTools.copyTable(t1)
     local t2 = {}
    for k,v in pairs(t1) do
        t2[k]  = v
    end
    return t2
end

function sszCardTools.cardsCompares(t1,t2)  --相同是true
    if sszCardTools.hasElement(t1) == false or sszCardTools.hasElement(t2) == false or #t1 ~= #t2 then
        return false
    end

    for i =1,#t1 do 
        if t1[i] ~= t2[i] then
            return false
        end
    end
       
      return true
end
function sszCardTools.tableClear(t1)  --相同是true
    for k,v in pairs(t1) do
        t1[k] = nil
    end    
end

function sszCardTools:tableSameValue(cards)
 local tSameTable = {}    
   
   for i=1 ,#cards do 
      local c = self.value(cards[i])
      local card = cards[i]
      if c == 1 then 
          c = 14
          card = card+ 13 
      end

      if tSameTable[c] == nil then
        tSameTable[c] ={}
      end

       tSameTable[c][#tSameTable[c]+1] = card

   end

  -- self:dumpValue(tduizi,2)
   return tSameTable
end

function sszCardTools:tableSameColor(cards)
 local tSameTable = {}    
    
   for i=1 ,#cards do
      local c = self.color(cards[i])
      if tSameTable[c] == nil then
        tSameTable[c] ={}
      end
       tSameTable[c][#tSameTable[c]+1] = cards[i]
   end

  -- self:dumpValue(tduizi,2)
   return tSameTable
end

function sszCardTools.reverseTable(tab) ---table倒序
	local tmp = {}
	for i = 1, #tab do
		local key = #tab
		tmp[i] = table.remove(tab)
	end

	return tmp
end

function sszCardTools:getDuiZi(cards,isliuduiban)
    isliuduiban = isliuduiban or false
   local tSameTable = self:tableSameValue(cards)
   local tDuiZi = {}
   local duiziV = nil

   for k,v in pairs (tSameTable) do
    if isliuduiban then
     
     if #v >= 2 then
       table.insert(tDuiZi,v)
       duiziV = v[1]
     end
    else
        if #v == 2 then
       table.insert(tDuiZi,v)
       duiziV = v[1]
     end
   end
  end
   --tDuiZi = self.reverseTable()
  if (#cards == 5 or #cards == 3) and #tDuiZi == 1 then
       local lastTable  = self.removeCardTableFromV(self.copyTable(cards),tDuiZi[1])
        self:CardSortFun(lastTable)   
        return tDuiZi,duiziV,lastTable
  end
   
   return tDuiZi
end

function sszCardTools:getDanPai(cards)
    cards = self.copyTable(cards)
   local tSameTable = self:tableSameValue(cards)
   local tWuLong = {}
   for k,v in pairs (tSameTable) do
     if #v == 1 then
       table.insert(tWuLong,v[1])
     end
  end
   --tDuiZi = self.reverseTable()
   return tWuLong
end

function sszCardTools:getDoubleDuiZi(cards)
  local tDuizi =  self:getDuiZi(cards)
  local tDoubleDuizi = {}
--  local duiziV_1 = nil
--  local duiziV_2 = nil
  
    for i = 1,#tDuizi do    --
        for j = i+1,#tDuizi do
         local tt = {}
         self.tableCombin(tt,tDuizi[i])
         self.tableCombin(tt,tDuizi[j])
         self:CardSortFun(tt)
         table.insert(tDoubleDuizi,tt)
        end
    end

    if #cards == 5 and #tDoubleDuizi == 1 then
       local lastTable  = self.removeCardTableFromV(self.copyTable(cards),tDoubleDuizi[1])
        self:CardSortFun(lastTable)   
        return tDoubleDuizi,tDoubleDuizi[1][3],tDoubleDuizi[1][1],lastTable[#lastTable]
    end

     return tDoubleDuizi 
end

function sszCardTools:getThreeCards(cards)
     local tSameTable = self:tableSameValue(cards)
       local tSt = {}
       local st_v = nil
       for k,v in pairs (tSameTable) do
         if #v == 3 then          
           table.insert(tSt,v)
           st_v = v[1]
         end
       end

       if (#cards == 5 or #cards == 3) and #tSt == 1 then
           local lastTable  = self.removeCardTableFromV(self.copyTable(cards),tSt[1])
            self:CardSortFun(lastTable)   
            return tSt,st_v,lastTable
       end

       return tSt
end

function sszCardTools:getShunZi(cards )
     
     self:CardSortFun(cards)
     local tSameTable = self:tableSameValue(cards)
    
     local tv = {}
--     for k,v in pairs(tSameTable) do
--         table.insert(tv,v[1])
--     end
    for i=2 ,14 do
       if tSameTable[i] then
            table.insert(tv,tSameTable[i][1])
       end         
    end

     local isLianXun = function (cards)
          for i = 2,#cards do
           
             if self.value(cards[i-1]) + 1 ~= self.value(cards[i]) then
                    return false     
             end
          end
          return true ,cards
     end 

      local fiveCards = {}
      local allLianXuCards = {}
               
               local toushun = nil
               if #tv ==3 and #cards == 3 then
                 toushun = 2
               else
                 toushun = 4
               end
              
                  for i = 1, #tv - toushun do
                   for j = i ,i+toushun do
                       table.insert(fiveCards,tv[j])             
                   end
                           if isLianXun(fiveCards) then
                                table.insert(allLianXuCards,fiveCards)
                           end
                           fiveCards = {}
                    end
               

               if #cards == 3 then
                    local t_10jqka = {2,3,14}
                    local flag = true
                    for k1,v1 in pairs(cards) do
                        if self.value(v1) ~= t_10jqka[k1] then
                            flag = false
                            break
                        end
                    end
                    if flag then
                        table.insert(allLianXuCards,cards)
                    end
                    return allLianXuCards
               else
                   local t_10jqka = {10,11,12,13,14}
                    local has_10jqka = true
                 if self.hasElement(allLianXuCards) then             
                    for k,v in pairs(allLianXuCards[#allLianXuCards]) do
                       if self.value(v) ~= t_10jqka[k] then
                        has_10jqka = false
                            break
                       end
                    end
                else
                       has_10jqka = false        
                end

                     local t_12345 = {14,2,3,4,5}
                     local flag = true
                     for i = 1,5 do
                        if tSameTable[t_12345[i]] == nil then
                           flag = false
                            break
                        end
                     end
                     if flag then
                        if has_10jqka then
                          if self.hasElement(allLianXuCards) then
                                table.insert(allLianXuCards,#allLianXuCards,{tSameTable[14][1],tSameTable[2][1],
                                  tSameTable[3][1],tSameTable[4][1],tSameTable[5][1]})
                          else
                                table.insert(allLianXuCards,{tSameTable[14][1],tSameTable[2][1],
                                  tSameTable[3][1],tSameTable[4][1],tSameTable[5][1]})
                          end
                            
                        else
                            table.insert(allLianXuCards,{tSameTable[14][1],tSameTable[2][1],
                            tSameTable[3][1],tSameTable[4][1],tSameTable[5][1]})
                        end
                   
                     end

                     return allLianXuCards
               end

end

function sszCardTools:getTongHuaShunZi(cards,useTongHuaSun)
    useTongHuaSun = useTongHuaSun or false
   local tSame = self:tableSameColor(cards)
   local tres = {}
    for k,v in pairs(tSame) do
        local  sunzi = {}
     if #v >= 5  or useTongHuaSun then
          sunzi =   self:getShunZi(v)
     end
     if self.hasElement(sunzi) then
         for k,v in pairs(sunzi) do
            table.insert(tres,v)
         end
     end    
    end
    return tres 

end

function sszCardTools.tableCombin(t1,t2)
    for k,v in pairs(t2) do
        if t1[k]   then
          if type(k) == "number" then
            table.insert(t1,v)
          elseif type(k) == "string" then
            print("tableCombin ..error", k)
          end   
        else
          t1[k] = v 
        end
    end
    return t1 
end

function sszCardTools:getHeadJin(cards)
    if #cards == 3 then
       return self:getTongHua(cards)
    end
    return {}
end

function sszCardTools:getHeadShun(cards)
    if #cards == 3 then
       return self:getShunZi(cards)
    end
    return {}
end

function sszCardTools:getTongHua(cards)
    self:CardSortFun(cards)
   self:setA_1to14(cards)
   if #cards < 3 then
       return {}
   end
   
   local tSame = self:tableSameColor(cards)
   local tres = {}
   local tonghuaLen = nil
   if #cards < 5 then
      tonghuaLen = #cards
   else
      tonghuaLen = 5  
   end
     
    for k,v in pairs (tSame) do
        if #v >= tonghuaLen then
            for k1,v1 in pairs(self.zuhe(v,tonghuaLen)) do
                
                table.insert(tres,v1)
            end
        end
    end

    table.sort(tres,function (a,b)
         if self.value(a[tonghuaLen]) == self.value(b[tonghuaLen])  then
           return  self.color(a[tonghuaLen]) <self.color(b[tonghuaLen])
         else 

           return self:setAValue(self.value(a[tonghuaLen])) < self:setAValue(self.value(b[tonghuaLen]))  
         end
   end)

   -- table.sort(tres,)

    return tres 

end

function sszCardTools:getHuLu(cards)
   local tSameTable = self:tableSameValue(cards)
   local t3ge = nil
   local t2ge = nil
   local tres = {}
   

   for k,v in pairs (tSameTable) do
     if #v >= 3 then
      
      for k1,v1 in pairs(self.zuhe(v,3)) do
        local copys1 = self.copyTable(cards)
        local tsv = self:tableSameValue(self.removeCardTableFromV(copys1,v1))

        for k2,v2 in pairs(tsv) do
            if #v2 >= 2 and self.value(v1[1]) ~= self.value(v2[1]) then
                for k3,v3 in pairs(self.zuhe(v2,2)) do
                   local copys2 = self.copyTable(v1)
                   t3ge = v1[1]
                   table.insert(tres,self.tableCombin(copys2,v3))  
                   t2ge = v3[1]                   
                end
             end
        end

      end
      
     end
   end

   if #cards == 5 and #tres == 1 then
        
        return tres,t3ge,t2ge
    end

    return tres 
end

function sszCardTools:getTieZi(cards)
    local tSameTable = self:tableSameValue(cards)
    local tres = {}
    local t4ge = nil
    
    for k,v in pairs (tSameTable) do
        if #v == 4 then
            for k1,v1 in pairs (tSameTable) do
                if #v1 >= 1 and #v1 < 4 then
                    for k2,v2 in pairs(v1) do
                        local copys = self.copyTable(v)
                        t4ge = v[1]
                        table.insert(copys,v2)
                        table.insert(tres, copys)
                    end
                end
            end
        end
    end

    if #cards == 5 and #tres == 1 then
       local lastTable  = self.removeCardTableFromV(self.copyTable(cards),tres[1])
        self:CardSortFun(lastTable)   
        return tres,t4ge,lastTable[#lastTable]
  end

    return tres 
end

function sszCardTools:getWuTong(cards)
    
    local tSameTable = self:tableSameValue(cards)
    local tres = {}
    local t4ge = {}
    
    for k,v in pairs (tSameTable) do
        if #v >= 5 then
            for k1,v1 in pairs(self.zuhe(v,5)) do
                table.insert(tres,v1)
            end
        end
    end

    return tres 
end

local CardTypefuns = {handler(sszCardTools,sszCardTools.getWuTong),handler(sszCardTools,sszCardTools.getTongHuaShunZi),handler(sszCardTools,sszCardTools.getTieZi),
handler(sszCardTools,sszCardTools.getHuLu),handler(sszCardTools,sszCardTools.getTongHua),handler(sszCardTools,sszCardTools.getShunZi),handler(sszCardTools,sszCardTools.getThreeCards),
handler(sszCardTools,sszCardTools.getHeadJin),handler(sszCardTools,sszCardTools.getHeadShun),handler(sszCardTools,sszCardTools.getDoubleDuiZi),handler(sszCardTools,sszCardTools.getDuiZi)}


local CardTypefunsIterator= 0 
--[[
    1 五同, 2 同花顺, 3 铁支 4 葫芦 5.同花 6 顺子 7 三张 8头金  9头顺  10 两对 11 一对 12 乌龙
]]--
local PaiXing_ToTextKey = {
  [1] ={ "五同","同花顺","铁支","葫芦","同花","顺子","三张","同花","顺子","两对","一对","乌龙"},
  [2] = {   90,  80,  70,  60,  50,   40,  30,  26,  23,  20,  10,  0}
} 

function sszCardTools:getType(cards,index_begin,index_end,wafaTouJin)
        if index_begin == nil or index_end == nil then
            return nil
        end
        if index_begin > index_end then
            return nil
        end

        wafaTouJin = wafaTouJin or false

        if #cards == 3 then
                index_begin = 7
        end
        

        if #cards == 3 and wafaTouJin == false  then
            for i = index_begin ,index_end do
               if i == 8 or i == 9 or i == 10 then

               else
                    local res,v1,v2,v3 = CardTypefuns[i](cards)
                    if  self.hasElement(res) == true then
                        return i , res  ,{v1,v2,v3}
                    end
                end
            
            end
        else
        
            for i = index_begin ,index_end do
          
                local res,v1,v2,v3 = CardTypefuns[i](cards)
                if  self.hasElement(res) == true then
                    local temp = i
                    if temp == 8 then
                        temp = 5
                    elseif temp == 9 then
                        temp = 6
                    end
                    return temp , res  ,{v1,v2,v3}
                end
            
            end
            
        end

        return nil
end

function sszCardTools:getTypes(cards,index_begin,index_end,wafaTouJin)
        if index_begin == nil or index_end == nil then
            return nil
        end
        if index_begin > index_end then
            return nil
        end

        wafaTouJin = wafaTouJin or false

        if #cards == 3 then
            index_begin = 7
        end

        local resTable = {}

        cards = sszCardTools.copyTable(cards)
        
        if #cards == 3 and wafaTouJin == false  then
            for i = index_begin ,index_end do
                if i == 8 or i == 9 or i == 10 then

               else
                    local res = CardTypefuns[i](cards)
                    if  self.hasElement(res) == true then
                       -- return i , res 
                       for k,v in pairs(res) do
                          self:setA_14to1(res[k]) 
                       end
                       resTable[i] = res
                    end
                end
            end
        else
               for i = index_begin ,index_end do
                local res = CardTypefuns[i](cards)
                if  self.hasElement(res) == true then
                   -- return i , res 
                   for k,v in pairs(res) do
                      self:setA_14to1(res[k]) 
                   end
                   resTable[i] = res
                end
            end
            
        end

        return resTable
end


function sszCardTools:getSortCardType(cards, _cardTypefuns ,tres ,indexRes ,recordlastData,isUp,last_vi,wafaTouJin)
      if isUp == false or isUp == nil then         
        CardTypefunsIterator = CardTypefunsIterator + 1
         
      end   
      
       if #indexRes >=2 then
            if CardTypefunsIterator  <= 6 then
                CardTypefunsIterator = 7
            elseif wafaTouJin == false and (CardTypefunsIterator == 8 or CardTypefunsIterator == 9) then
                CardTypefunsIterator = 11
            elseif   CardTypefunsIterator  == 10 then  
                CardTypefunsIterator  = 11
            end
    end
       
        local fun = _cardTypefuns[CardTypefunsIterator]
        if fun == nil or #indexRes >= 3 then    
         
          table.insert(recordlastData,self.copyTable(last_vi))
          if tres[1] == nil  then 
            tres[1] = nil
            return true
          end
          if tres[3] == nil  then tres[3] = {} end
         if tres[2] == nil  then tres[2] = {} end
         local daoshu = { 5,5,3 }
         local flag = true
         local daoshuJiaZhi = {false,false,false}

         for k,v in pairs(self.copyTable(cards)) do
           if #tres[1] < daoshu[1] then
                table.insert(tres[1],v)
                daoshuJiaZhi[1] = true
           elseif #tres[3] < daoshu[3] then
                if #tres[2] < daoshu[2] and flag == false then
                flag = true
                daoshuJiaZhi[2] = true
                table.insert(tres[2],v)
                else
                flag = false
                daoshuJiaZhi[3] = true
                table.insert(tres[3],v)
                end
           elseif  #tres[2] < daoshu[2]  then
                daoshuJiaZhi[2] = true
                table.insert(tres[2],v)
           end
         end

        for i = 1,3 do 
         if  daoshuJiaZhi[i] then
         
         if indexRes[i] then
             if self:getType(tres[i],1,indexRes[i],wafaTouJin) ~= indexRes[i] then
                indexRes[1] =  -1  -- 移除这一组就这么干
                return true
             end
          
          else
          
              local index = self:getType(tres[i],1,11,wafaTouJin)
                if index ~= nil then
                    indexRes[1] = -1  -- 移除这一组就这么干
                    return true
                end
             end  
         end
      end   
            return true
        end
        
        local tc = fun(cards)
        
        if self.hasElement(tc) then
             tc = self.reverseTable(tc)
            for k1,v1 in pairs(tc) do

               local flag = false
               for k2,v2 in pairs(recordlastData) do
                    if self.cardsCompares(v1,v2)  then
                        flag = true
                    end
               end
              if  flag == false   then 
                 self.removeCardTableFromV(cards,v1)
                 
                 table.insert(indexRes,CardTypefunsIterator)


                 if #indexRes <= 3 then
                    -- if indexRes[#indexRes] == indexRes[#indexRes - 1] and #indexRes~=3 then
                  --           table.insert(tres,#tres,v1)
                   --          else
                                   table.insert(tres,v1)
                   --        end
                 end       
                 
                 local vv = nil
                 if #indexRes >= 3 then
                       vv  = last_vi 
                 else
                       vv = v1
                       
                 end

                if self:getSortCardType(cards,_cardTypefuns,tres,indexRes,recordlastData,true,vv,wafaTouJin) then
                      return true
                end

              
               end 
            end
             _cardTypefuns[CardTypefunsIterator] = nil
            self:getSortCardType(cards,_cardTypefuns,tres,indexRes,recordlastData,false,last_vi,wafaTouJin)
        else
            _cardTypefuns[CardTypefunsIterator] = nil
            self:getSortCardType(cards,_cardTypefuns,tres,indexRes,recordlastData,false,last_vi,wafaTouJin)
        end

        return true
end

function sszCardTools:getAllCardType(cards,wafaTouJin)
      local tres = {}
      local indexRes = {}  
      local recordlastData = {}
      local paixingText = {}
      local paixingIndex = {}
     
      local cards11 =  self:setA_1to14(self.copyTable(cards))

     local i=1
     local onceToWULONG = 0
      for  j=1,60  do
        local cards22 = self.copyTable(cards11)
        local funs = self.copyTable(CardTypefuns)
        tres[i] = {}
        indexRes[i] = {}
        paixingText[i] = {}
        paixingIndex[i] = {}
        CardTypefunsIterator = 0
        print("-------->>>>>",i)
        self:getSortCardType(cards22,funs,tres[i],indexRes[i],recordlastData,false,{},wafaTouJin)
             
      --  if indexRes[i][1] == -1 or guolvTongPai then 
        if indexRes[i][1] == -1  then
            table.remove(tres,i)
            table.remove(indexRes,i)
            table.remove(paixingText,i)
            table.remove(paixingIndex,i)
        else

            local guolvPai = false
       for k,v in pairs(indexRes) do
            if k == i then
                break
            end
            if indexRes[i][1] == v[1] and indexRes[i][2] == v[2] and indexRes[i][3] == v[3] then
                guolvPai = true
                break
            end
       end

       if indexRes[i][2] == nil  and indexRes[i][3] == nil  then
                if onceToWULONG < 1 then
                    onceToWULONG = onceToWULONG +1
                else
                    guolvPai = true
                end
       end
           
           if guolvPai == false then

                    if  tres[i][1] == nil or self.hasElement(tres[i][1]) == false then
                    table.remove(tres,i)
                    table.remove(indexRes,i)
                    paixingText[i] = nil
                    paixingIndex[i] = nil
                    break
                end
        
                for k,v in pairs(indexRes[i]) do 
                   paixingText[i][k] = self:getPaiXingOrigalKeyToString(v,k)
                   paixingIndex[i][k] = PaiXing_ToTextKey[2][v] 
                end

                    i = i+1
            else
                 table.remove(tres,i)
                 table.remove(indexRes,i)
                 table.remove(paixingText,i)
                 table.remove(paixingIndex,i)
            end
        end

        if i>10 then break  end
        
      end

      for k1,v1 in pairs(tres) do
        for k2,v2 in pairs(v1) do
             self:setA_14to1(v2)
        end
      end

      recordlastData = {}

      return tres,paixingText,paixingIndex
end

local keyIndexs = {}

function sszCardTools:keepIndexs(cards)
        self.tableClear(keyIndexs)
       for k,v in pairs(cards) do
           keyIndexs[k] = v
           print("card :"..k,v)
       end
end

function sszCardTools:getLuaIndexs(cards) 
   local resKeys = {}
   local repeatRecord = {}
   for i = 1 ,#cards do
        for k2,v2 in pairs(keyIndexs) do
            if cards[i] == v2 then
                table.insert(resKeys,k2)
                 keyIndexs[k2] = nil            
            end
        end
   end

     return resKeys
end

function sszCardTools:getCIndexs(cards)
   
   local resKeys = {}
   local repeatRecord = {}
   for i = 1 ,#cards do
        for k2,v2 in pairs(keyIndexs) do
            if cards[i] == v2 then
                resKeys[#resKeys+1] = k2 - 1
                 keyIndexs[k2] = nil  
                 break          
            end
        end
   end

     return resKeys
end

local specailKeyToString = {
[10] = "三同花",
[11] = "三顺子",
[20] = "六对半",
[90] = "四套三条",
[110] = "三分天下",
[120] = "三同花顺",
[160] = "一条龙",
[170] = "至尊清龙"
}

local specailKeyToScore = {
[10] = "4",
[11] = "4",
[20] = "4",
[90] = "8",
[110] = "16",
[120] = "18",
[160] = "26",
[170] = "108"
}

function sszCardTools:getspecailKeyToScore(key)
   return specailKeyToScore[key]
end

function sszCardTools:getspecailKeyToString(key)
   return specailKeyToString[key] 
end

function sszCardTools:getPaiXingKeyToString(key)
    local res = nil
    local index = nil
   for k,v in pairs(PaiXing_ToTextKey[2])  do
        if v== key then
            index = k
        end
   end

   if index then
     return PaiXing_ToTextKey[1][index]
   else
     return nil  
   end
    
end

function sszCardTools:getPaiXingOrigalKeyToString(key,daoshu,wafaTouJin)
        
            local res = nil
             if daoshu == 2 and key  == 4 then
                    res = "中墩葫芦"
              elseif daoshu == 3 and key  == 7 then
                    res = "冲三"
              else
                    res = PaiXing_ToTextKey[1][key]            
              end   

--                    if daoshu == 3 and key  == 6 then   --屏蔽头道顺子
--                        res = PaiXing_ToTextKey[1][10]
--                    elseif daoshu == 2 and key  == 4 then
--                        res = "中墩葫芦"
--                    elseif daoshu == 3 and key  == 7 then
--                        res = "冲三"
--                    else
--                        res = PaiXing_ToTextKey[1][key]            
--                    end
                  res = res or "乌龙"      
             return    res
end

function sszCardTools:checkDaoShui(cards,isCompareColor,wafaTouJin)
    isCompareColor = isCompareColor or false

    local weiInfo = {}
    local zhongInfo = {}
    local touInfo = {}

    local cards11 = self.copyTable(cards)
    for k,v in pairs(cards11) do
        cards11[k]  = self:setA_1to14(v)
    end

     weiInfo[1],weiInfo[2],weiInfo[3] = sszCardTools:getType(cards11[1],1,11,wafaTouJin)
    zhongInfo[1],zhongInfo[2],zhongInfo[3] = sszCardTools:getType(cards11[2],1,11,wafaTouJin)
    touInfo[1],touInfo[2],touInfo[3] = sszCardTools:getType(cards11[3],1,11,wafaTouJin)

-- 比较两个无牌型的数组大小，默认两个数组的长度相同，且按照升序排列
    local function compareDanPai(cards_1, cards_2)
        local length = #cards_1
        for i = length, 1, -1 do
            if self.value(cards_1[i]) > self.value(cards_2[i]) then
                return false
            elseif self.value(cards_1[i]) < self.value(cards_2[i]) then
                return true
            else
                -- 比到最后一张且数值还相等，那么就比较最大的一张的花色
                if i == 1 then
                    if isCompareColor then
                        if self.color(cards_1[length]) > self.color(cards_2[length]) then
                          return false
                        elseif self.color(cards_1[length]) < self.color(cards_2[length]) then
                            return true
                        else
                            return false
                        end
                    else
                        return false
                    end
                end
            end
        end
    end

    -- 如果1比2大，就是正常，返回false，否则返回true
    -- cardType    getType的第一个返回值
    -- result      getType的第二个返回值
    -- add         getType的第三个返回值
    local function checkDao(info_1, info_2, cards_1, cards_2)
        local cardType_1 = info_1[1]
        local result_1 = info_1[2]
        local add_1 = info_1[3]
        local cardType_2 = info_2[1]
        local result_2 = info_2[2]
        local add_2 = info_2[3]

        if cardType_1 == nil and cardType_2 then
            -- 1是乌龙，2不是乌龙
            return true
        elseif cardType_1 and cardType_2 == nil then
            -- 1不是乌龙，2是乌龙
            return false
        elseif cardType_1 == nil and cardType_2 == nil then
            -- 1 2 都是乌龙，需要比较所有的牌
            if #cards_2 == 3 then  -- 只有第二手牌可能是头道
                -- 第一手牌需要删除掉前两张
                local temp_1 = sszCardTools.copyTable(cards_1)
                table.remove(temp_1, 1)
                table.remove(temp_1, 1)
                local result = compareDanPai(temp_1, cards_2)
                return result
            else
                local result = compareDanPai(cards_1, cards_2)
                return result
            end
        elseif cardType_2 == 8 then    -- 头金
            if cardType_1 < 5 then
                return false
            elseif cardType_1 == 5 then
                local temp_1 = sszCardTools.copyTable(cards_1)
                table.remove(temp_1, 1)
                table.remove(temp_1, 1)
                local result = compareDanPai(temp_1, cards_2)
                return result
            else
                return true
            end
        elseif cardType_2 == 9 then    -- 头顺
            if cardType_1 < 6 then
                return false
            elseif cardType_1 == 6 then
                if self.value(result_1[1][#result_1[1]]) > self.value(result_2[1][#result_2[1]])  then
                    return false
                elseif self.value(result_1[1][#result_1[1]]) < self.value(result_2[1][#result_2[1]]) then
                    return true
                else
                    if isCompareColor then
                        local color_1 = self.color(result_1[1][#result_1[1]])
                        local color_2 = self.color(result_2[1][#result_2[1]])

                        if color_1 > color_2 then
                            return false
                        elseif color_1 < color_2 then
                            return true
                        else
                            color_1 = self.color(result_1[1][#result_1[1] - 1])
                            color_2 = self.color(result_2[1][#result_2[1] - 1])

                            if color_1 > color_2 then
                                return false
                            elseif color_1 < color_2 then
                                return true
                            else
                                color_1 = self.color(result_1[1][#result_1[1] - 2])
                                color_2 = self.color(result_2[1][#result_2[1] - 2])

                                if color_1 > color_2 then
                                    return false
                                elseif color_1 < color_2 then
                                    return true
                                else
                                    return false
                                end
                            end
                        end
                    else
                        return false
                    end
                end
            else
                return true
            end
        elseif cardType_1 < cardType_2 then
            return false
        elseif cardType_1 > cardType_2 then
            return true
        elseif cardType_1 == cardType_2 then
            if cardType_1 == 11 then  -- 对子
                if #cards_2 == 3 then
                    local dui_1 = self.value(add_1[1])
                    local dui_2 = self.value(add_2[1])
                    if dui_1 > dui_2 then
                        return false
                    elseif dui_1 < dui_2 then
                        return true
                    else
                        local result = compareDanPai({add_1[2][1]}, {add_2[2][1]})
                        return result
                    end
                else
                    local dui_1 = self.value(add_1[1])
                    local dui_2 = self.value(add_2[1])
                    if dui_1 > dui_2 then
                        return false
                    elseif dui_1 < dui_2 then
                        return true
                    else
                        local result = compareDanPai(add_1[2], add_2[2])
                        return result
                    end
                end
            elseif cardType_1 == 10 then  -- 两对
                local dui_1_1 = self.value(add_1[1])
                local dui_1_2 = self.value(add_1[2])
                local dui_2_1 = self.value(add_2[1])
                local dui_2_2 = self.value(add_2[2])
                if dui_1_1 > dui_2_1 then
                    return false
                elseif dui_1_1 < dui_2_1 then
                    return true
                else
                    if dui_1_2 > dui_2_2 then
                        return false
                    elseif dui_1_2 < dui_2_2 then
                        return true
                    else
                        local result = compareDanPai({add_1[3]}, {add_2[3]})
                        return result
                    end
                end
            elseif cardType_1 == 7 then -- 三张
                if self.value(add_1[1]) > self.value(add_2[1]) then
                    return false
                elseif self.value(add_1[1]) < self.value(add_2[1]) then
                    return true
                else
                    local result = compareDanPai(add_1[2], add_2[2])
                    return result
                end
            elseif cardType_1 == 6 then  -- 顺子
                if self.value(result_1[1][#result_1[1]]) > self.value(result_2[1][#result_2[1]])  then
                    if self.value(result_1[1][#result_1[1]]) ~= 14 and self.value(result_2[1][#result_2[1]]) == 5 then
                        return true
                    end
                    return false
                elseif self.value(result_1[1][#result_1[1]]) < self.value(result_2[1][#result_2[1]]) then
                    if self.value(result_1[1][#result_1[1]]) == 5 and self.value(result_2[1][#result_2[1]]) ~= 14 then
                        return false
                    end
                    return true
                else
                    if isCompareColor then
                        for i=1,#result_1[1] do
                            local color_1 = self.color(result_1[1][#result_1[1] - i + 1])
                            local color_2 = self.color(result_2[1][#result_2[1] - i + 1])

                            if color_1 > color_2 then
                                return false
                            elseif color_1 < color_2 then
                                return true
                            else
                                if i == 5 then
                                    return false
                                end
                            end
                        end
                    else
                        return false
                    end   
                end
            elseif cardType_1 == 5 then  -- 同花
                local result = compareDanPai(cards_1, cards_2)
                return result
            elseif cardType_1 == 4 then  -- 葫芦
                if self.value(add_1[1]) > self.value(add_2[1]) then
                    return false
                elseif self.value(add_1[1]) < self.value(add_2[1]) then
                    return true
                else
                    if self.value(add_1[2]) > self.value(add_2[2]) then
                        return false
                    elseif self.value(add_1[2]) < self.value(add_2[2]) then
                        return true
                    else
                        return false
                    end
                end
            elseif cardType_1 == 3 then  -- 铁支
                if self.value(add_1[1]) > self.value(add_2[1]) then
                    return false
                elseif self.value(add_1[1]) < self.value(add_2[1]) then
                    return true
                else
                    local result = compareDanPai({add_1[2]}, {add_2[2]})
                    return result
                end
            elseif cardType_1 == 2 then  -- 同花顺
                local result = compareDanPai(cards_1, cards_2)
                return result
            elseif cardType_1 == 1 then  -- 五同
                if self.value(cards_1[1]) > self.value(cards_2[1]) then
                    return false
                else
                    return true
                end
            end
        end
    end

--       local flag = true

--        flag =  checkDao(weiInfo,zhongInfo,  self.value(sszCardTools:CardSortFun(cards11[1])[#cards11[1]]),self.value(sszCardTools:CardSortFun(cards11[2])[#cards11[2]]))
--        if flag == false then return flag end
--        flag =  checkDao(zhongInfo,touInfo ,self.value(sszCardTools:CardSortFun(cards11[2])[#cards11[2]]),self.value(sszCardTools:CardSortFun(cards11[3])[#cards11[3]]))

--        return flag   
       
       if checkDao(weiInfo, zhongInfo, sszCardTools:CardSortFun(cards11[1]), sszCardTools:CardSortFun(cards11[2])) then
           return 1
       end

       if checkDao(zhongInfo, touInfo, sszCardTools:CardSortFun(cards11[2]), sszCardTools:CardSortFun(cards11[3])) then
           return 2
       end

       return 0
    
end

-- cards1比cards2大 返回true
function sszCardTools:comparesCards(cards1,cards2,isCompareColor,wafaTouJin)
    isCompareColor = isCompareColor or false

    local weiInfo = {}
    local zhongInfo = {}
    weiInfo[1],weiInfo[2],weiInfo[3] = sszCardTools:getType(cards1,1,11,wafaTouJin)
    zhongInfo[1],zhongInfo[2],zhongInfo[3] = sszCardTools:getType(cards2,1,11,wafaTouJin)
    

    -- 比较两个无牌型的数组大小，默认两个数组的长度相同，且按照升序排列
    local function compareDanPai(cards_1, cards_2)
        local length = #cards_1
        dump(cards_1)
        dump(cards_2)
        for i = length, 1, -1 do
            if self.value(cards_1[i]) > self.value(cards_2[i]) then
                return false
            elseif self.value(cards_1[i]) < self.value(cards_2[i]) then
                return true
            else
                -- 比到最后一张且数值还相等，那么就比较最大的一张的花色
                if i == 1 then
                    if isCompareColor then
                        if self.color(cards_1[length]) > self.color(cards_2[length]) then
                          return false
                        elseif self.color(cards_1[length]) < self.color(cards_2[length]) then
                            return true
                        else
                            return false
                        end
                    else
                        return false
                    end
                end
            end
        end
    end

    -- 如果1比2大，就是正常，返回false，否则返回true
    -- cardType    getType的第一个返回值
    -- result      getType的第二个返回值
    -- add         getType的第三个返回值
    local function checkDao(info_1, info_2, cards_1, cards_2)
        local cardType_1 = info_1[1]
        local result_1 = info_1[2]
        local add_1 = info_1[3]
        local cardType_2 = info_2[1]
        local result_2 = info_2[2]
        local add_2 = info_2[3]

        if cardType_1 == nil and cardType_2 then
            -- 1是乌龙，2不是乌龙
            return true
        elseif cardType_1 and cardType_2 == nil then
            -- 1不是乌龙，2是乌龙
            return false
        elseif cardType_1 == nil and cardType_2 == nil then
            -- 1 2 都是乌龙，需要比较所有的牌
            if #cards_2 == 3 then  -- 只有第二手牌可能是头道
                -- 第一手牌需要删除掉前两张
                local temp_1 = sszCardTools.copyTable(cards_1)
                table.remove(temp_1, 1)
                table.remove(temp_1, 1)
                local result = compareDanPai(temp_1, cards_2)
                return result
            else
                local result = compareDanPai(cards_1, cards_2)
                return result
            end
        elseif cardType_2 == 8 then    -- 头金
            if cardType_1 < 5 then
                return false
            elseif cardType_1 == 5 then
                local temp_1 = sszCardTools.copyTable(cards_1)
                table.remove(temp_1, 1)
                table.remove(temp_1, 1)
                local result = compareDanPai(temp_1, cards_2)
                return result
            else
                return true
            end
        elseif cardType_2 == 9 then    -- 头顺
            if cardType_1 < 6 then
                return false
            elseif cardType_1 == 6 then
                if self.value(result_1[1][#result_1[1]]) > self.value(result_2[1][#result_2[1]])  then
                    return false
                elseif self.value(result_1[1][#result_1[1]]) < self.value(result_2[1][#result_2[1]]) then
                    return true
                else
                    if isCompareColor then
                        local color_1 = self.color(result_1[1][#result_1[1]])
                        local color_2 = self.color(result_2[1][#result_2[1]])

                        if color_1 > color_2 then
                            return false
                        elseif color_1 < color_2 then
                            return true
                        else
                            color_1 = self.color(result_1[1][#result_1[1] - 1])
                            color_2 = self.color(result_2[1][#result_2[1] - 1])

                            if color_1 > color_2 then
                                return false
                            elseif color_1 < color_2 then
                                return true
                            else
                                color_1 = self.color(result_1[1][#result_1[1] - 2])
                                color_2 = self.color(result_2[1][#result_2[1] - 2])

                                if color_1 > color_2 then
                                    return false
                                elseif color_1 < color_2 then
                                    return true
                                else
                                    return false
                                end
                            end
                        end
                    else
                        return false
                    end
                end
            else
                return true
            end
        elseif cardType_1 < cardType_2 then
            return false
        elseif cardType_1 > cardType_2 then
            return true
        elseif cardType_1 == cardType_2 then
            if cardType_1 == 11 then  -- 对子
                if #cards_2 == 3 then
                    local dui_1 = self.value(add_1[1])
                    local dui_2 = self.value(add_2[1])
                    if dui_1 > dui_2 then
                        return false
                    elseif dui_1 < dui_2 then
                        return true
                    else
                        local result = compareDanPai({add_1[2][1]}, {add_2[2][1]})
                        return result
                    end
                else
                    local dui_1 = self.value(add_1[1])
                    local dui_2 = self.value(add_2[1])
                    if dui_1 > dui_2 then
                        return false
                    elseif dui_1 < dui_2 then
                        return true
                    else
                        local result = compareDanPai(add_1[2], add_2[2])
                        return result
                    end
                end
            elseif cardType_1 == 10 then  -- 两对
                local dui_1_1 = self.value(add_1[1])
                local dui_1_2 = self.value(add_1[2])
                local dui_2_1 = self.value(add_2[1])
                local dui_2_2 = self.value(add_2[2])
                if dui_1_1 > dui_2_1 then
                    return false
                elseif dui_1_1 < dui_2_1 then
                    return true
                else
                    if dui_1_2 > dui_2_2 then
                        return false
                    elseif dui_1_2 < dui_2_2 then
                        return true
                    else
                        local result = compareDanPai({add_1[3]}, {add_2[3]})
                        return result
                    end
                end
            elseif cardType_1 == 7 then -- 三张
                if self.value(add_1[1]) > self.value(add_2[1]) then
                    return false
                elseif self.value(add_1[1]) < self.value(add_2[1]) then
                    return true
                else
                    local result = compareDanPai(add_1[2], add_2[2])
                    return result
                end
            elseif cardType_1 == 6 then  -- 顺子
                if self.value(result_1[1][#result_1[1]]) > self.value(result_2[1][#result_2[1]])  then
                    if self.value(result_1[1][#result_1[1]]) ~= 14 and self.value(result_2[1][#result_2[1]]) == 5 then
                        return true
                    end
                    return false
                elseif self.value(result_1[1][#result_1[1]]) < self.value(result_2[1][#result_2[1]]) then
                    if self.value(result_1[1][#result_1[1]]) == 5 and self.value(result_2[1][#result_2[1]]) ~= 14 then
                        return false
                    end
                    return true
                else
                    if isCompareColor then
                        for i=1,#result_1[1] do
                            local color_1 = self.color(result_1[1][#result_1[1] - i + 1])
                            local color_2 = self.color(result_2[1][#result_2[1] - i + 1])

                            if color_1 > color_2 then
                                return false
                            elseif color_1 < color_2 then
                                return true
                            else
                                if i == 5 then
                                    return false
                                end
                            end
                        end
                    else
                        return false
                    end   
                end
            elseif cardType_1 == 5 then  -- 同花
                local result = compareDanPai(cards_1, cards_2)
                return result
            elseif cardType_1 == 4 then  -- 葫芦
                if self.value(add_1[1]) > self.value(add_2[1]) then
                    return false
                elseif self.value(add_1[1]) < self.value(add_2[1]) then
                    return true
                else
                    if self.value(add_1[2]) > self.value(add_2[2]) then
                        return false
                    elseif self.value(add_1[2]) < self.value(add_2[2]) then
                        return true
                    else
                        return false
                    end
                end
            elseif cardType_1 == 3 then  -- 铁支
                if self.value(add_1[1]) > self.value(add_2[1]) then
                    return false
                elseif self.value(add_1[1]) < self.value(add_2[1]) then
                    return true
                else
                    local result = compareDanPai({add_1[2]}, {add_2[2]})
                    return result
                end
            elseif cardType_1 == 2 then  -- 同花顺
                local result = compareDanPai(cards_1, cards_2)
                return result
            elseif cardType_1 == 1 then  -- 五同
                if self.value(cards_1[1]) > self.value(cards_2[1]) then
                    return false
                else
                    return true
                end
            end
        end
    end

       if checkDao(weiInfo, zhongInfo, sszCardTools:CardSortFun(cards1), sszCardTools:CardSortFun(cards2)) then
          return false 
       end
       return true
end

function sszCardTools:getAngleByPos(p1,p2)  
    local p = {}  
    p.x = p2.x - p1.x  
    p.y = p2.y - p1.y  
             
    local r = math.atan2(p.y,p.x)*180/math.pi  
    print("夹角[-180 - 180]:",r)  
    return r  
end

function sszCardTools:getTwoPosDisStance(p1,p2)  
    return p2[1]- p1[1],p2[2]- p1[2]
end  

function sszCardTools:getSanTongHuaShun(cards)
    local res3  = {}
    local res2  = {}
    local res1  = sszCardTools:getTongHuaShunZi(cards) 
--    local weidao_cards = {}
--    local zhongdao_cards = {}
--    local toudao_cards = {}
    
    for k1,v1 in pairs(res1) do
      local res11 =  sszCardTools.copyTable(sszCardTools:setA_1to14(cards))
       res11 =  sszCardTools.removeCardTableFromV(res11,v1)
       res2  = sszCardTools:getTongHuaShunZi(res11) 
       for k2,v2 in pairs(res2) do
        local  res22 =  sszCardTools.copyTable(res11)
            res22 =  sszCardTools.removeCardTableFromV(res22,v2)
            res3 =  sszCardTools:getTongHuaShunZi(res22,true)
                for k3,v3 in pairs(res3) do
                  local res =  {v1,v2,v3}
                      for k1,v1 in pairs(res) do
                          self:setA_14to1(v1)
                      end

                      return res

                end
       end
    end

end

 function sszCardTools:getliuduiban(cards)      
    local res = {}
    local  tduizi  = sszCardTools:getDuiZi(cards,true)
    if #tduizi == 6 then
      
        res = {{cards[1],cards[2],cards[3],cards[4],cards[5]},
            {cards[6],cards[7],cards[8],cards[9],cards[10]},
            {cards[11],cards[12],cards[13]}}
        return true , res
    else
        return false
    end

 end

 function sszCardTools:setCardWithInterval(cards,num,interval,b_winx)      
      if #cards == 0 then
        return 
      end

      local mid_num =  num/2
      if math.floor(mid_num) < mid_num then
            mid_num = math.floor(mid_num)
            mid_num = mid_num + 1  
      end

      if b_winx then
        cards[mid_num]:setPositionX(b_winx)
      end

       for i=1,num do
            cards[i]:setPositionX((mid_num-i)*interval+cards[mid_num]:getPositionX())
       end

 end

 function sszCardTools:getFirstElementAndRemove(table)
    local key = nil 
    local value = nil
        for k,v in pairs(table) do
           key = k
           value = v
           break     
        end

        if key then
            table[key] = nil
       end

       return key,value
 end

 function sszCardTools:getLastElementAndRemove(table)
    local key = nil 
    local value = nil
        for k,v in pairs(table) do
           key = k
           value = v     
        end

        if key then
            table[key] = nil
       end

       return key,value
 end

return sszCardTools
