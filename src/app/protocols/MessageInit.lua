
local gt = cc.exports.gt

gt.CREATE_ROOM = 0x100                   -- 创建房间
gt.JOIN_ROOM = 0x101                     -- 加入房间
gt.ENTER_ROOM = 0x0102                   -- 进入房间
gt.ENTER_ROOM_OTHER = 0x0103             -- 其他玩家进入房间
gt.EXIT_ROOM = 0x0104                    -- 玩家退出房间
gt.DISMISS_ROOM = 0x0105                 -- 房主解散房间
gt.SPONSOR_VOTE = 0x0106                 -- 发起投票解散
gt.VOTE = 0x0107                         -- 玩家选择投票
gt.ONLINE_STATUS = 0x0108                -- 在线状态广播
gt.SPEAKER = 0x0109                      -- 超级广播命令
gt.READY = 0x010A                        -- 准备
gt.DEAL = 0x010B                         -- 起手发牌
gt.SORT_CARD = 0x1021                    -- 整牌
gt.DRAW = 0x010C                         -- 摸牌
gt.DISCARD = 0x010D                      -- 出牌
gt.SYNCHRONISE_CARDS = 0x010E            -- 服务端主动同步手牌
gt.HEARTBEAT = 0x010F            		 -- 服务端主动检测心跳
gt.ROUND_STATE = 0x0110                  -- 当前局数/最大局数
gt.SAMEIP = 0x0199                       -- 广播相同IP玩家
gt.BINDING_PROXY_CODE = 0x0111           -- 绑定邀请码
gt.RECHARGE_INFO = 0x0113                -- 充值记录
gt.PAY_ORDER = 0x0112					 -- 请求订单
gt.PAY_RESULT = 0x0114					 -- 充值结果
gt.SYNC_SCORE = 0x0115					 -- 同步积分
gt.SCORE_LEAK = 0x0116					 -- 积分不足
gt.PAUSE = 0x0117                        -- 暂停
gt.PAY_GOODS = 0x0118					 -- 商品列表
gt.IOS_PAY_ORDER = 0x119				--苹果IAP

gt.WEBGAME_URL = 0x120						--游戏url

gt.ENTER_GAME = 0x200                    -- 进入游戏
gt.LOGIN = 0x201                         -- 玩家登录
gt.ROOM_CARD = 0x202                     -- 玩家房卡
gt.ROOM_LIST = 0x203                     -- 房间列表
gt.RECORD = 0x204                        -- 房间战绩
gt.RECORD_INFO = 0x205                   -- 战绩详情
gt.ROOM_REPLAY = 0x206                   -- 游戏回放
gt.NOTICE = 0x207                        -- 游戏公告
gt.LOGIN_USERID = 0x208                  -- ID登录
gt.ENTER_HALL = 0x209					 -- 进入大厅
gt.ROOM_HISTORY = 0x210					 -- 房间历史记录
gt.USER_INFO = 0x220                     -- 玩家信息提交

-- 战绩
gt.SHAREVIDEO = 0x221					--玩家请求查看某shareid的分享录像
gt.REQSHAREVIDEO = 0x222				--玩家请求分享某录像
gt.RETSHAREVIDEOID = 0x223				--服务器返回分享的id
gt.GETSHAREVIDEO = 0x224				--玩家通过精确的videoid查看分享的某录像

gt.OPEN_SIGN = 0x211                     --打开签到界面
gt.SIGN_DAILY = 0x212                    --签到
gt.SHARE_AWARD = 0x213                   --分享奖励
gt.OPEN_DIAL = 0x214                     --打开转盘抽奖界面
gt.DIAL_AWARD = 0x215                    --点击转盘抽奖
gt.SYSTEM_NOTICE = 0x216                 --系统维护公告

-- 俱乐部
gt.CREATE_GUILD = 0x300                  -- 创建俱乐部
gt.DISMISS_GUILD = 0x301                 -- 解散俱乐部
gt.APPLY_GUILD = 0x302                   -- 申请加入俱乐部
gt.REPLY_GUILD = 0x303                   -- 同意/拒绝加入俱乐部
gt.GUILD_MEMBER = 0x304                  -- 俱乐部玩家列表
gt.GUILD_ROOM = 0x305                    -- 俱乐部房间列表
gt.DEL_MEMBER = 0x306                    -- 删除成员
gt.RENAME_GUILD = 0x307                  -- 俱乐部更名
gt.GUILD_LIST = 0x308                    -- 俱乐部列表
gt.EXIT_GUILD = 0x309					 -- 退出俱乐部
gt.GUILD_INVITE = 0x310					 -- 俱乐部邀请
gt.CREATE_GUILD_ROOM = 0x311			 -- 俱乐部开房
gt.GUILD_ROOM_PARAM = 0x312				 -- 俱乐部房间设置
gt.GUILD_SET_NOTICE = 0x313				 -- 设置公告				
gt.GUILD_GET_NOTICE = 0x314				 -- 获取公告
gt.RECV_GUILD_APPLY = 0x315				 -- 收到俱乐部申请
gt.RECV_GUILD_REPLY = 0x316				 -- 收到批准入会回复
gt.GUILD_NULL = 0x317					 -- 俱乐部不存在
gt.GUILD_GET_PARAM = 0x318				 -- 获取房间设置
gt.MATCH_ROOM = 0x319					 -- 俱乐部房间
gt.MATCH_RANK = 0x31A                    -- 比赛排行榜
gt.MATCH_SCORE = 0x31B                   -- 修改比赛积分
gt.MATCH_RECORD = 0x31C					 -- 比赛战绩
gt.MATCH_EXTRA = 0x31D                   -- 比赛额外设置
gt.TRANS_GUILD = 0x31E                   -- 转让会长
gt.GUILD_SET_ADMIN = 0x31F               -- 设置管理员
gt.GUILD_GET_ADMIN = 0x320               -- 管理员列表
gt.GUILD_MAN_PARAM = 0x321               -- 俱乐部设置
gt.GUILD_INFO = 0x322                    -- 俱乐部信息
gt.GUILD_DEL_MEMBERS = 0x323             -- 删除俱乐部成员们

gt.GUILD_SET_PARTNER = 0x324             -- 设置合伙人
gt.GUILD_GET_PARTNERS = 0x325            -- 获取合伙人列表
gt.GUILD_TAG_MEMBER = 0x326              -- 给玩家设置属于哪一个合伙人标签
gt.GUILD_PARTNER_INFO = 0x327            -- 获取合伙人成员列表
gt.GUILD_SCORE_RECORDS = 0x328           -- 查看俱乐部上下分日志

gt.GUILD_SCORE_CREATE = 0x329           -- 俱乐部管理员创建积分
gt.GUILD_SCORE_GIVE = 0x32A           -- 俱乐部积分赠送

gt.GUILD_DISMISS_ROOM = 0x32B           -- 俱乐部解散房间

gt.UNION_CHECK_ACTIVE_CODE = 0x32C         -- 大联盟检查激活码

gt.PARTNER_MATCH_SCORE = 0x32D         -- 合伙人修改积分


gt.GUILD_INVITE_SWITCH = 0x330           -- 俱乐部邀请开关
gt.GUILD_INVITE_MEMBER = 0x331           -- 俱乐部邀请玩家
gt.GUILD_INVITE_LIST = 0x332          	 -- 俱乐部邀请列表
gt.GUILD_INVITE_REPLY = 0x333          	 -- 俱乐部邀请处理

-- 手机登录
gt.BINDING_PHONE_NUM = 0x334
gt.SET_LOGIN_PHONE_PWD = 0x335
gt.CAN_SET_PHONE_PWD = 0x336



gt.UNION_MERGE_LIST = 0x340          	 -- 俱乐部邀请处理
gt.UNION_MERGE = 0x341          	 	 -- 俱乐部邀请处理

gt.GUILD_UPDATE_UNION_LIST = 0x342    	 -- 俱乐部邀请处理

gt.SPORT_LIST = 0x400					 -- 赛场列表
gt.SPORT_SIGN = 0x401					 -- 赛场报名/退赛
gt.SPORT_STATUS = 0x403					 -- 比赛状态同步
gt.SPORT_RECORD = 0x404					 -- 比赛记录
gt.SPORT_REDAY = 0x405					 -- 比赛就位
gt.SPORT_RANK = 0x406					 -- 比赛排行榜
gt.SPORT_GET_AWARD = 0x407				 -- 比赛领奖

-- 游戏
gt.RECONNECT_DN = 0x1000  			     -- 玩家断线重连
gt.SETTLEMENT_FOR_ROUND_DN = 0x1001	     -- 结算
gt.ACTION_DN = 0x1002				     -- 玩家动作
gt.PROMPT_PLEDGE_DN = 0x1003			 -- 提示玩家可以压分
gt.SETTLEMENT_FOR_ROOM_DN = 0x1004       -- 总结算
gt.PLEDGE_DN = 0x1005                    -- 押分
gt.START_DN = 0x1006                     -- 开始游戏
gt.PROMPT_START_DN = 0x1007              -- 提示玩家可以开始游戏(flag=0可以,flag=1不可以)
gt.SHOW_CARD_DN = 0x1008                 -- 亮牌
gt.PROMPT_CARD_DN = 0x1009               -- 提示玩家可以亮牌
gt.DEALER_SEAT = 0x100A					 -- 庄家位置
gt.PROMPT_LOOT_DEALER_DN = 0x100B        -- 提示玩家可以压倍率
gt.LOOT_DEALER_DN = 0x100C               -- 抢庄 倍率
gt.DEAL2_DN = 0x0100D                    -- 发牌2
gt.WAIT_DN = 0x100F                      -- 预准备等待
gt.READY_LATE = 0x1010                   -- 准备晚了，座位被占了
gt.DOUBLE_PLEDGE = 0x1011                -- 加倍
gt.TRUSTEESHIP = 0x101F					 -- 托管
gt.PUSH_PLEDGE = 0x1020                  -- 推注提示

gt.BUY_PLEDGE = 0x1021                 	-- 闲家买码
gt.PROMPT_BUY_PLEDGE = 0x1022        	-- 提示闲家可以买码

--推筒子
gt.CARDSIGN_IN_HAND = 0x1012			 -- 桌子剩余牌

--三公
gt.PROMPT_IS_CUT_CARD_DN = 0x1011        -- 提示玩家显示切牌按钮
gt.IS_CUT_CARD_DN = 0x1012               -- 选择是否切牌
gt.PROMPT_CUT_CARD_DN = 0x1013           -- 提示玩家显示切牌界面
gt.CUT_CARD_DN = 0x1014                  -- 选择切牌位置
gt.PROMPT_ROLL_DICE_DN = 0x1015          -- 提示玩家显示摇色子按钮
gt.ROLL_DICE_DN = 0x1016                 -- 摇色子结果
gt.SG_DEAL_DN = 0x1017                   -- 摇色子后三公发明牌


--扎金花
gt.ACTIVITY_SEAT = 0x2000                --玩家操作
gt.LOOK_CARDS =   0x2001                 --看牌
gt.COMPARE_DN = 0x2002                   --比牌
gt.WAIVE = 0x2003                      --弃牌



gt.msgFiles = {}
gt.msgFiles[gt.GUILD_INFO] = "app/protocols/msg_guildInfo"
gt.msgFiles[gt.MATCH_ROOM] = "app/protocols/msg_matchRoom"

