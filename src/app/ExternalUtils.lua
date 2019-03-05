cc.exports.ExternalUtils = cc.exports.ExternalUtils or {}

--滑动弹出控件的方法
function ExternalUtils.ShowItemAnim2(item, delay_sec, offset, move_time)
    delay_sec = delay_sec or 0.8
    move_time = move_time or 0.1
    local cur_scale = item:getScale()
    item:setVisible(false)
    local x, y = item:getPosition()
    item:setPosition(x-offset.x, y-offset.y)

    local delay = cc.DelayTime:create(delay_sec)
    local call_func = cc.CallFunc:create(function () item:setVisible(true) end)
    local move_1 = cc.MoveBy:create(move_time, offset)
    item:runAction(cc.Sequence:create(delay, call_func, move_1))
end
