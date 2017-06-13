source('huobi_io.R')


# =====================
# get_market_kline <- function(period='1min', symbol='ethcny',long_pooling='false')
# =====================
# input:
# period= 1min, 5min, 15min, 30min, 60min, 1day, 1mon, 1week, 1year
# =====================
# output:
# "tick": {
#    "id": K线id,
#    "amount": 成交量,
#    "count": 成交笔数,
#    "open": 开盘价,
#    "close": 收盘价,
#    "low": 最低价,
#    "high": 最高价,
#    "vol": 成交额, 即 sum(每一笔成交价 * 该笔的成交量)
#  }
# =====================
# print(get_market_kline(period='5min'))



# =====================
# get_market_depth <- function(type='step0', symbol='ethcny',long_pooling='false')
# =====================
# input:
# type=percent10(当前价上下10%深度), step0, step1, step2, step3, step4, step5（合并深度0-5）
# =====================
# "tick": {
#   "id": 消息id,
#   "ts": 消息生成时间，单位：毫秒,
#   "bids": 买盘,[price(成交价), amount(成交量)], 按price降序,
#   "asks": 卖盘,[price(成交价), amount(成交量)], 按price升序
# }
# =====================
# print(get_market_depth(type='step0'))



# =====================
# get_market_trade <- function(symbol='ethcny',long_pooling='false')
# =====================
# input:
# None
# =====================
# "tick": {
#   "id": 消息id,
#   "ts": 最新成交时间,
#   "data": [
#     {
#       "id": 成交id,
#       "price": 成交价钱,
#       "amount": 成交量,
#       "direction": 成交方向,
#       "ts": 成交时间
#     }
#   ]
# }
# =====================
# print(get_market_trade())




# =====================
# get_market_detail <- function(symbol='ethcny',long_pooling='false')
# =====================
# input:
# None
# =====================
# "tick": {
#     "id": 消息id,
#     "ts": 24小时统计时间,
#     "amount": 24小时成交量,
#     "open": 前推24小时成交价,
#     "close": 当前成交价,
#     "high": 近24小时最高价,
#     "low": 近24小时最低价,
#     "count": 近24小时累积成交数,
#     "vol": 近24小时累积成交额, 即 sum(每一笔成交价 * 该笔的成交量)
#   }
# =====================
# print(get_market_detail())





# print(get_timestamp())





# =====================
# get_balance <- function()
# =====================
# input:
# None
# =====================
# "data": {
#     "id": 100009,
#     "type": "spot",
#     "state": "working",
#     "list": [
#       {
#         "currency": "cny",
#         "type": "trade",
#         "balance": "500009195917.4362872650"
#       },
#       {
#         "currency": "cny",
#         "type": "frozen",
#         "balance": "328048.1199920000"
#       },
#       {
#         "currency": "eth",
#         "type": "trade",
#         "balance": "499999894616.1302471000"
#       },
#       {
#         "currency": "eth",
#         "type": "frozen",
#         "balance": "9786.6783000000"
#       }
#     ],
#     "user-id": 1000
#   }
# =====================
# print(get_balance())





# =====================
# get_order_info <-function(order_id)
# =====================
# input:
# order_id = 订单ID
# =====================
# output:
# {
#    "id": 订单ID
#    "symbol": "ethcny",
#    "account-id": 账户 ID
#    "amount": 限价单表示下单数量，市价买单时表示买多少钱，市价卖单时表示卖多少币
#    "price": 下单价格，市价单不传该参数
#    "created-at": 订单创建时间
#    "type": buy-market：市价买, sell-market：市价卖, buy-limit：限价买, sell-limit：限价卖
#    "field-amount": 已成交数量
#    "field-cash-amount": 已成交总金额
#    "field-fees": 已成交手续费（买入为币，卖出为钱）
#    "finished-at": 最后成交时间
#    "source": "api",
#    "state": pre-submitted 准备提交, submitting , submitted 已提交, partial-filled 部分成交, partial-canceled 部分成交撤销, filled 完全成交, canceled 已撤销
#    "canceled-at": 订单撤销时间
#  }
# =====================
print(get_order_info(1545863))





# =====================
# post_orders <- function(type, amount, price='3000000', symbol='ethcny')
# =====================
# input:
# type   = {buy-market ：市价买, sell-market ：市价卖, buy-limit ：限价买, sell-limit ：限价卖}
# amount = 限价单表示下单数量，市价买单时表示买多少钱，市价卖单时表示卖多少币
# price  = 下单价格，市价单不传该参数
# =====================
# output:
# "order_id"
# =====================
# print(post_orders(type='buy-market',amount=20))
# print(post_orders(type='sell-market',amount=0.01))
# print(post_orders(type='buy-limit', amount=0.01, price=1000))
# print(post_orders(type='sell-limit',amount=0.01,price=3000))





# ====================
# post_cancel_order <-function(order_id)
# ====================
# input:
# order_id = 订单ID
# ====================
# output:
# "order_id"
# ====================
# print(post_cancel_order(1443002))





# ====================
# temp
# ====================
# print(get_order_matchresult(1432743))







