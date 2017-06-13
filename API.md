# API Reference

### 行情API

1. GET /market/kline 获取 KLine 数据

请求参数:

| 参数名称         | 是否必须  | 类型     | 描述                | 默认值   | 取值范围                                     |
| ------------ | ----- | ------ | ----------------- | ----- | ---------------------------------------- |
| symbol       | true  | string | 币种                |       | ethcny                                   |
| period       | true  | string | KLine 类型          |       | 1min, 5min, 15min, 30min, 60min, 1day, 1mon, 1week, 1year |
| long-polling | false | string | 是否启用 Long-polling | false | true, false                              |

响应数据:

| 参数名称   | 是否必须 | 数据类型   | 描述                                       | 取值范围           |
| ------ | ---- | ------ | ---------------------------------------- | -------------- |
| status | true | string | 请求处理结果                                   | "ok" , "error" |
| ts     | true | number | 响应生成时间点，单位：毫秒                            |                |
| tick   | true | object | KLine 数据                                 |                |
| ch     | true | string | 数据所属的 channel，格式： market.$symbol.kline.$period |                |

tick 说明:

```
  "tick": {
    "id": K线id,
    "amount": 成交量,
    "count": 成交笔数,
    "open": 开盘价,
    "close": 收盘价,
    "low": 最低价,
    "high": 最高价,
    "vol": 成交额, 即 sum(每一笔成交价 * 该笔的成交量)
  }

```

请求响应示例:

```
/* GET /market/kline?symbol=ethcny&period=1min */
{
  "status": "ok",
  "ch": "market.btccny.kline.1min",
  "ts": 1489474081631,
  "tick": {
    "id": 1489464480,
    "amount": 0.0,
    "count": 0,
    "open": 7962.62,
    "close": 7962.62,
    "low": 7962.62,
    "high": 7962.62,
    "vol": 0.0
  }
}


/* GET /market/kline?symbol=ethcny&period=not-exist */
{
  "ts": 1490758171271,
  "status": "error",
  "err-code": "invalid-parameter",
  "err-msg": "invalid period"
}


/* GET /market/kline?symbol=not-exists&period=1min */
{
  "ts": 1490758221221,
  "status": "error",
  "err-code": "invalid-parameter",
  "err-msg": "invalid symbol"
}
```

2. GET /market/depth 获取 Market Depth 数据

请求参数:

| 参数名称         | 是否必须  | 类型     | 描述                | 默认值   | 取值范围                                     |
| ------------ | ----- | ------ | ----------------- | ----- | ---------------------------------------- |
| symbol       | true  | string | 币种                |       | ethcny                                   |
| type         | true  | string | Depth 类型          |       | percent10(当前价上下10%深度), step0, step1, step2, step3, step4, step5（合并深度0-5） |
| long-polling | false | string | 是否启用 Long-polling | false | true, false                              |

响应数据:

| 参数名称   | 是否必须 | 数据类型   | 描述                                       | 取值范围            |
| ------ | ---- | ------ | ---------------------------------------- | --------------- |
| status | true | string |                                          | "ok" 或者 "error" |
| ts     | true | number | 响应生成时间点，单位：毫秒                            |                 |
| tick   | true | object | Depth 数据                                 |                 |
| ch     | true | string | 数据所属的 channel，格式： market.$symbol.depth.$type |                 |

tick 说明:

```
  "tick": {
    "id": 消息id,
    "ts": 消息生成时间，单位：毫秒,
    "bids": 买盘,[price(成交价), amount(成交量)], 按price降序,
    "asks": 卖盘,[price(成交价), amount(成交量)], 按price升序
  }
```

请求响应示例:

```
/* GET /market/depth?symbol=ethcny&type=step1 */
{
  "status": "ok",
  "ch": "market.btccny.depth.step1",
  "ts": 1489472598812,
  "tick": {
    "id": 1489464585407,
    "ts": 1489464585407,
    "bids": [
      [7964, 0.0678], // [price, amount]
      [7963, 0.9162],
      [7961, 0.1],
      [7960, 12.8898],
      [7958, 1.2],
      [7955, 2.1009],
      [7954, 0.4708],
      [7953, 0.0564],
      [7951, 2.8031],
      [7950, 13.7785],
      [7949, 0.125],
      [7948, 4],
      [7942, 0.4337],
      [7940, 6.1612],
      [7936, 0.02],
      [7935, 1.3575],
      [7933, 2.002],
      [7932, 1.3449],
      [7930, 10.2974],
      [7929, 3.2226]
    ],
    "asks": [
      [7979, 0.0736],
      [7980, 1.0292],
      [7981, 5.5652],
      [7986, 0.2416],
      [7990, 1.9970],
      [7995, 0.88],
      [7996, 0.0212],
      [8000, 9.2609],
      [8002, 0.02],
      [8008, 1],
      [8010, 0.8735],
      [8011, 2.36],
      [8012, 0.02],
      [8014, 0.1067],
      [8015, 12.9118],
      [8016, 2.5206],
      [8017, 0.0166],
      [8018, 1.3218],
      [8019, 0.01],
      [8020, 13.6584]
    ]
  }
}

/* GET /market/depth?symbol=ethcny&type=not-exist */
{
  "ts": 1490759358099,
  "status": "error",
  "err-code": "invalid-parameter",
  "err-msg": "invalid type"
}
```


3. GET /market/trade 获取 Trade Detail 数据

请求参数:

| 参数名称         | 是否必须  | 类型     | 描述                | 默认值   | 取值范围        |
| ------------ | ----- | ------ | ----------------- | ----- | ----------- |
| symbol       | true  | string | 币种                |       | ethcny      |
| long-polling | false | string | 是否启用 Long-polling | false | true, false |

响应数据:

| 参数名称   | 是否必须 | 数据类型   | 描述                                       | 取值范围            |
| ------ | ---- | ------ | ---------------------------------------- | --------------- |
| status | true | string |                                          | "ok" 或者 "error" |
| ts     | true | number | 响应生成时间点，单位：毫秒                            |                 |
| tick   | true | object | Trade 数据                                 |                 |
| ch     | true | string | 数据所属的 channel，格式： market.$symbol.depth.$type |                 |

tick 说明：

```
  "tick": {
    "id": 消息id,
    "ts": 最新成交时间,
    "data": [
      {
        "id": 成交id,
        "price": 成交价钱,
        "amount": 成交量,
        "direction": 成交方向,
        "ts": 成交时间
      }
    ]
  }
```

请求响应例子:

```
/* GET /market/trade?symbol=ethcny */
{
  "status": "ok",
  "ch": "market.btccny.trade.detail",
  "ts": 1489473346905,
  "tick": {
    "id": 600848670,
    "ts": 1489464451000,
    "data": [
      {
        "id": 600848670,
        "price": 7962.62,
        "amount": 0.0122,
        "direction": "buy",
        "ts": 1489464451000
      }
    ]
  }
}

/* GET /market/trade?symbol=not-exist */
{
  "ts": 1490759506429,
  "status": "error",
  "err-code": "invalid-parameter",
  "err-msg": "invalid symbol"
}
```


4. GET /market/detail 获取 Market Detail 24小时成交量数据

 请求参数:

| 参数名称         | 是否必须  | 类型     | 描述                | 默认值   | 取值范围        |
| ------------ | ----- | ------ | ----------------- | ----- | ----------- |
| symbol       | true  | string | 币种                |       | ethcny      |
| long-polling | false | string | 是否启用 Long-polling | false | true, false |

 响应数据:

| 参数名称   | 是否必须 | 数据类型   | 描述                                       | 取值范围            |
| ------ | ---- | ------ | ---------------------------------------- | --------------- |
| status | true | string |                                          | "ok" 或者 "error" |
| ts     | true | number | 响应生成时间点，单位：毫秒                            |                 |
| tick   | true | object | Detail 数据                                |                 |
| ch     | true | string | 数据所属的 channel，格式： market.$symbol.depth.$type |                 |

tick 说明:

```
  "tick": {
    "id": 消息id,
    "ts": 24小时统计时间,
    "amount": 24小时成交量,
    "open": 前推24小时成交价,
    "close": 当前成交价,
    "high": 近24小时最高价,
    "low": 近24小时最低价,
    "count": 近24小时累积成交数,
    "vol": 近24小时累积成交额, 即 sum(每一笔成交价 * 该笔的成交量)
  }
```


请求响应例子

```
/* GET /market/detail?symbol=ethcny */
{
  "status": "ok",
  "ch": "market.btccny.detail",
  "ts": 1489473538996,
  "tick": {
    "amount": 4316.4346,
    "open": 8090.54,
    "close": 7962.62,
    "high": 8119.00,
    "ts": 1489464451000,
    "id": 1489464451,
    "count": 9595,
    "low": 7875.00,
    "vol": 34497276.905760
  }
}

/* GET /market/detail?symbol=not-exists */
{
  "ts": 1490759594752,
  "status": "error",
  "err-code": "invalid-parameter",
  "err-msg": "invalid symbol"
}
```

### 公共API

1.  GET /v1/common/symbols 查询系统支持的所有交易对

 请求参数:
(无)

响应数据:

| 参数名称           | 是否必须 | 数据类型   | 描述    | 取值范围 |
| -------------- | ---- | ------ | ----- | ---- |
| base-currency  | true | string | 基础币种  |      |
| quote-currency | true | string | 计价币种  |      |
| symbol         | true | string | 交易对名称 |      |

 请求响应例子:

```
/* GET /v1/common/symbols */
{
  "status": "ok",
  "data": [
    {
      "base-currency": "eth",
      "quote-currency": "cny",
      "symbol": "ethcny"
    }
  ]
}
```

2. GET /v1/common/currencys 查询系统支持的所有币种

 请求参数:

(无)

 响应数据:

```
currency list
```

请求响应例子:

```
/* GET /v1/common/currencys */
{
  "status": "ok",
  "data": [
    "cny",
    "eth"
  ]
}
```

3.  GET /v1/common/timestamp 查询系统当前时间

请求参数:

(无)

 响应数据:

```
系统时间戳
```

请求响应例子

```
/* GET /v1/timestamp */
{
  "status": "ok",
  "data": 1494900087029
}
```

### 用户资产API

1. GET /v1/account/accounts 查询当前用户的所有账户

请求参数:

无

响应数据:

| 参数名称  | 是否必须 | 数据类型   | 描述    | 取值范围                   |
| ----- | ---- | ------ | ----- | ---------------------- |
| id    | true | long   | 账户 ID |                        |
| state | true | string | 账户状态  | working：正常, lock：账户被锁定 |
| type  | true | string | 账户类型  | spot：现货账户              |

请求响应例子:

```
/* GET /v1/account/accounts */
{
  "status": "ok",
  "data": [
    {
      "id": 100009,
      "type": "spot",
      "state": "working",
      "user-id": 1000
    }
  ]
}
```

2.  GET /v1/account/accounts/{account-id}/balance 查询指定账户的余额

请求参数

| 参数名称       | 是否必须 | 类型     | 描述              | 默认值  | 取值范围 |
| ---------- | ---- | ------ | --------------- | ---- | ---- |
| account-id | true | string | 账户 ID，填在 path 中 |      |      |

响应数据:

| 参数名称  | 是否必须  | 数据类型   | 描述    | 取值范围                   |
| ----- | ----- | ------ | ----- | ---------------------- |
| id    | true  | long   | 账户 ID |                        |
| state | true  | string | 账户状态  | working：正常  lock：账户被锁定 |
| type  | true  | string | 账户类型  | spot：现货账户              |
| list  | false | Array  | 子账户数组 |                        |

list字段说明

| 参数名称     | 是否必须 | 数据类型   | 描述   | 取值范围                     |
| -------- | ---- | ------ | ---- | ------------------------ |
| balance  | true | string | 余额   |                          |
| currency | true | string | 币种   |                          |
| type     | true | string | 类型   | trade: 交易余额，frozen: 冻结余额 |

请求响应例子:

```
/* GET /v1/account/accounts/{account-id}/balance */
{
  "status": "ok",
  "data": {
    "id": 100009,
    "type": "spot",
    "state": "working",
    "list": [
      {
        "currency": "cny",
        "type": "trade",
        "balance": "500009195917.4362872650"
      },
      {
        "currency": "cny",
        "type": "frozen",
        "balance": "328048.1199920000"
      },
      {
        "currency": "eth",
        "type": "trade",
        "balance": "499999894616.1302471000"
      },
      {
        "currency": "eth",
        "type": "frozen",
        "balance": "9786.6783000000"
      }
    ],
    "user-id": 1000
  }
}
```

### 交易API

1. POST /v1/order/orders 创建一个新的订单请求

请求参数

| 参数名称       | 是否必须  | 类型     | 描述                                | 默认值  | 取值范围                                     |
| ---------- | ----- | ------ | --------------------------------- | ---- | ---------------------------------------- |
| account-id | true  | string | 账户 ID                             |      |                                          |
| amount     | true  | string | 限价单表示下单数量，市价买单时表示买多少钱，市价卖单时表示卖多少币 |      |                                          |
| price      | false | string | 下单价格，市价单不传该参数                     |      |                                          |
| source     | false | string | 订单来源                              | api  |                                          |
| symbol     | true  | string | 交易对                               |      |                                          |
| type       | true  | string | 订单类型                              |      | buy-market：市价买, sell-market：市价卖, buy-limit：限价买, sell-limit：限价卖 |

响应数据:

| 参数名称 | 是否必须 | 数据类型 | 描述   | 取值范围 |
| ---- | ---- | ---- | ---- | ---- |
| data | true | long | 订单号  |      |

请求响应例子:

```
/* POST /v1/order/orders {
   "account-id": "100009",
   "amount": "10.1",
   "price": "100.1",
   "source": "api",
   "symbol": "ethcny",
   "type": "buy-limit"
 } */
{
  "status": "ok",
  "data": 59378
}
```

2.  POST /v1/order/orders/{order-id}/place 执行一个订单

请求参数:

| 参数名称     | 是否必须 | 类型     | 描述            | 默认值  | 取值范围 |
| -------- | ---- | ------ | ------------- | ---- | ---- |
| order-id | true | string | 订单ID ，填在path中 |      |      |

响应数据:

| 参数名称 | 是否必须  | 数据类型   | 描述       | 取值范围 |
| ---- | ----- | ------ | -------- | ---- |
| data | false | string | 执行的订单 ID |      |

请求响应例子:

```
/* POST /v1/order/orders/{order-id}/place */
{
  "status": "ok",
  "data": 59378
}
```

3. POST /v1/order/orders/{order-id}/submitcancel  申请撤销一个订单请求

请求参数:

| 参数名称     | 是否必须 | 类型     | 描述           | 默认值  | 取值范围 |
| -------- | ---- | ------ | ------------ | ---- | ---- |
| order-id | true | string | 订单ID，填在path中 |      |      |

响应数据:

| 参数名称 | 是否必须 | 数据类型   | 描述    | 取值范围 |
| ---- | ---- | ------ | ----- | ---- |
| data | true | string | 订单 ID |      |

请求响应例子:

```
/* POST /v1/order/orders/{order-id}/submitcancel */
{
  "status": "ok",
  "data": 59378
}
```

4.  GET /v1/order/orders/{order-id} 查询某个订单详情

请求参数:

| 参数名称     | 是否必须 | 类型     | 描述           | 默认值  | 取值范围 |
| -------- | ---- | ------ | ------------ | ---- | ---- |
| order-id | true | string | 订单ID，填在path中 |      |      |

响应数据:

| 参数名称              | 是否必须  | 数据类型   | 描述                | 取值范围                                     |
| ----------------- | ----- | ------ | ----------------- | ---------------------------------------- |
| account-id        | true  | long   | 账户 ID             |                                          |
| amount            | true  | string | 订单数量              |                                          |
| canceled-at       | false | long   | 订单撤销时间            |                                          |
| created-at        | true  | long   | 订单创建时间            |                                          |
| field-amount      | true  | string | 已成交数量             |                                          |
| field-cash-amount | true  | string | 已成交总金额            |                                          |
| field-fees        | true  | string | 已成交手续费（买入为币，卖出为钱） |                                          |
| finished-at       | false | long   | 最后成交时间            |                                          |
| id                | true  | long   | 订单ID              |                                          |
| price             | true  | string | 订单价格              |                                          |
| source            | true  | string | 订单来源              | api                                      |
| state             | true  | string | 订单状态              | pre-submitted 准备提交, submitting , submitted 已提交, partial-filled 部分成交, partial-canceled 部分成交撤销, filled 完全成交, canceled 已撤销 |
| symbol            | true  | string | 交易对               |                                          |
| type              | true  | string | 订单类型              | buy-market：市价买, sell-market：市价卖, buy-limit：限价买, sell-limit：限价卖 |


请求响应例子:

```
/* GET /v1/order/orders/{order-id} */
{
  "status": "ok",
  "data": {
    "id": 59378,
    "symbol": "ethcny",
    "account-id": 100009,
    "amount": "10.1000000000",
    "price": "100.1000000000",
    "created-at": 1494901162595,
    "type": "buy-limit",
    "field-amount": "10.1000000000",
    "field-cash-amount": "1011.0100000000",
    "field-fees": "0.0202000000",
    "finished-at": 1494901400468,
    "user-id": 1000,
    "source": "api",
    "state": "filled",
    "canceled-at": 0,
    "exchange": "huobi",
    "batch": ""
  }
}
```

5. GET /v1/order/orders/{order-id}/matchresults  查询某个订单的成交明细

请求参数:

| 参数名称     | 是否必须 | 类型     | 描述           | 默认值  | 取值范围 |
| -------- | ---- | ------ | ------------ | ---- | ---- |
| order-id | true | string | 订单ID，填在path中 |      |      |

响应数据:

| 参数名称          | 是否必须 | 数据类型   | 描述       | 取值范围                                     |
| ------------- | ---- | ------ | -------- | ---------------------------------------- |
| created-at    | true | long   | 成交时间     |                                          |
| filled-amount | true | string | 成交数量     |                                          |
| filled-fees   | true | string | 成交手续费    |                                          |
| id            | true | long   | 订单成交记录ID |                                          |
| match-id      | true | long   | 撮合ID     |                                          |
| order-id      | true | long   | 订单 ID    |                                          |
| price         | true | string | 成交价格     |                                          |
| source        | true | string | 订单来源     | api                                      |
| symbol        | true | string | 交易对      |                                          |
| type          | true | string | 订单类型     | buy-market：市价买, sell-market：市价卖, buy-limit：限价买, sell-limit：限价卖 |

请求响应例子:

```
/* GET /v1/order/orders/{order-id}/matchresults */
{
  "status": "ok",
  "data": [
    {
      "id": 29553,
      "order-id": 59378,
      "match-id": 59335,
      "symbol": "ethcny",
      "type": "buy-limit",
      "source": "api",
      "price": "100.1000000000",
      "filled-amount": "9.1155000000",
      "filled-fees": "0.0182310000",
      "created-at": 1494901400435
    }
  ]
}
```

6. GET /v1/order/orders 查询当前委托、历史委托

请求参数:

| 参数名称       | 是否必须  | 类型     | 描述                     | 默认值  | 取值范围                                     |
| ---------- | ----- | ------ | ---------------------- | ---- | ---------------------------------------- |
| symbol     | true  | string | 交易对                    |      |                                          |
| types      | false | string | 查询的订单类型组合，使用','分割      |      | buy-market：市价买, sell-market：市价卖, buy-limit：限价买, sell-limit：限价卖 |
| start-date | false | string | 查询开始日期, 日期格式yyyy-mm-dd |      |                                          |
| end-date   | false | string | 查询开始日期, 日期格式yyyy-mm-dd |      |                                          |
| states     | true  | string | 查询的订单状态组合，使用','分割      |      | pre-submitted 准备提交, submitted 已提交, partial-filled 部分成交, partial-canceled 部分成交撤销, filled 完全成交, canceled 已撤销 |
| from       | false | string | 查询起始 ID                |      |                                          |
| direct     | false | string | 查询方向                   |      | prev 向前，next 向后                          |
| size       | false | string | 查询记录大小                 |      |                                          |

响应数据:

| 参数名称              | 是否必须  | 数据类型   | 描述                | 取值范围                                     |
| ----------------- | ----- | ------ | ----------------- | ---------------------------------------- |
| account-id        | true  | long   | 账户 ID             |                                          |
| amount            | true  | string | 订单数量              |                                          |
| canceled-at       | false | long   | 订单撤销时间            |                                          |
| created-at        | true  | long   | 订单创建时间            |                                          |
| field-amount      | true  | string | 已成交数量             |                                          |
| field-cash-amount | true  | string | 已成交总金额            |                                          |
| field-fees        | true  | string | 已成交手续费（买入为币，卖出为钱） |                                          |
| finished-at       | false | long   | 最后成交时间            |                                          |
| id                | true  | long   | 订单ID              |                                          |
| price             | true  | string | 订单价格              |                                          |
| source            | true  | string | 订单来源              | api                                      |
| state             | true  | string | 订单状态              | pre-submitted 准备提交, submitting , submitted 已提交, partial-filled 部分成交, partial-canceled 部分成交撤销, filled 完全成交, canceled 已撤销 |
| symbol            | true  | string | 交易对               |                                          |
| type              | true  | string | 订单类型              | submit-cancel：已提交撤单申请  ,buy-market：市价买, sell-market：市价卖, buy-limit：限价买, sell-limit：限价卖 |


请求响应例子:

```
/* GET /v1/order/orders */
{
  "status": "ok",
  "data": [
    {
      "id": 59378,
      "symbol": "ethcny",
      "account-id": 100009,
      "amount": "10.1000000000",
      "price": "100.1000000000",
      "created-at": 1494901162595,
      "type": "buy-limit",
      "field-amount": "10.1000000000",
      "field-cash-amount": "1011.0100000000",
      "field-fees": "0.0202000000",
      "finished-at": 1494901400468,
      "user-id": 1000,
      "source": "api",
      "state": "filled",
      "canceled-at": 0,
      "exchange": "huobi",
      "batch": ""
    }
  ]
}
```

7.  GET /v1/order/matchresults 查询当前成交、历史成交

请求参数:

| 参数名称       | 是否必须  | 类型     | 描述                     | 默认值  | 取值范围                                     |
| ---------- | ----- | ------ | ---------------------- | ---- | ---------------------------------------- |
| symbol     | true  | string | 交易对                    |      |                                          |
| types      | false | string | 查询的订单类型组合，使用','分割      |      | buy-market：市价买, sell-market：市价卖, buy-limit：限价买, sell-limit：限价卖 |
| start-date | false | string | 查询开始日期, 日期格式yyyy-mm-dd |      |                                          |
| end-date   | false | string | 查询开始日期, 日期格式yyyy-mm-dd |      |                                          |
| from       | false | string | 查询起始 ID                |      |                                          |
| direct     | false | string | 查询方向                   |      | prev 向前，next 向后                          |
| size       | false | string | 查询记录大小                 |      |                                          |

响应数据:

| 参数名称          | 是否必须 | 数据类型   | 描述       | 取值范围                                     |
| ------------- | ---- | ------ | -------- | ---------------------------------------- |
| created-at    | true | long   | 成交时间     |                                          |
| filled-amount | true | string | 成交数量     |                                          |
| filled-fees   | true | string | 成交手续费    |                                          |
| id            | true | long   | 订单成交记录ID |                                          |
| match-id      | true | long   | 撮合ID     |                                          |
| order-id      | true | long   | 订单 ID    |                                          |
| price         | true | string | 成交价格     |                                          |
| source        | true | string | 订单来源     | api                                      |
| symbol        | true | string | 交易对      |                                          |
| type          | true | string | 订单类型     | buy-market：市价买, sell-market：市价卖, buy-limit：限价买, sell-limit：限价卖 |

请求响应例子:

```
/* GET /v1/order/orders/matchresults */
{
  "status": "ok",
  "data": [
    {
      "id": 29555,
      "order-id": 59378,
      "match-id": 59335,
      "symbol": "ethcny",
      "type": "buy-limit",
      "source": "api",
      "price": "100.1000000000",
      "filled-amount": "0.9845000000",
      "filled-fees": "0.0019690000",
      "created-at": 1494901400487
    }
  ]
}
```

## 虚拟币提现API

> **仅支持提现到【安全地址】**

1. GET /v1/dw/withdraw-virtual/addresses 查询虚拟币提现地址

请求参数:

| 参数名称     | 是否必须 | 类型     | 描述   | 默认值  | 取值范围 |
| -------- | ---- | ------ | ---- | ---- | ---- |
| currency | true | string | 币种   |      |      |

响应数据:

| 参数名称 | 是否必须  | 数据类型 | 描述     | 取值范围 |
| ---- | ----- | ---- | ------ | ---- |
| data | false | list | 提现地址集合 |      |

请求响应例子:

```
/* GET /v1/dw/withdraw-virtual/addresses */
{
  "status": "ok",
  "data": [
    {
      "id": 190,
      "address": "fa3f6acf7f33273e09318c0a3f8dfaddc63d9b47",
      "level": "default",
      "alias": "1000eth"
    }
  ]
}
```

2. POST /v1/dw/withdraw-virtual/create 申请提现虚拟币

请求参数:

| 参数名称       | 是否必须 | 类型     | 描述     | 默认值  | 取值范围 |
| ---------- | ---- | ------ | ------ | ---- | ---- |
| address-id | true | long   | 提现地址ID |      |      |
| amount     | true | string | 提币数量   |      |      |

响应数据:

| 参数名称 | 是否必须  | 数据类型 | 描述   | 取值范围 |
| ---- | ----- | ---- | ---- | ---- |
| data | false | long | 提现ID |      |

请求响应例子:

```
/* POST /v1/dw/withdraw-virtual/create {
   "address-id": "190",
   "amount": "10.1"
 } */
{
  "status": "ok",
  "data": 700
}
```

3.  POST /v1/dw/withdraw-virtual/{withdraw-id}/place 确认申请虚拟币提现

请求参数:

| 参数名称        | 是否必须 | 类型   | 描述           | 默认值  | 取值范围 |
| ----------- | ---- | ---- | ------------ | ---- | ---- |
| withdraw-id | true | long | 提现ID，填在path中 |      |      |

响应数据:

| 参数名称 | 是否必须  | 数据类型 | 描述   | 取值范围 |
| ---- | ----- | ---- | ---- | ---- |
| data | false | long | 提现ID |      |

请求响应例子:

```
/* POST /v1/dw/withdraw-virtual/{withdraw-id}/place */
{
  "status": "ok",
  "data": 700
}
```

4. POST /v1/dw/withdraw-virtual/{withdraw-id}/cancel 申请取消提现虚拟币

请求参数:

| 参数名称        | 是否必须 | 类型   | 描述           | 默认值  | 取值范围 |
| ----------- | ---- | ---- | ------------ | ---- | ---- |
| withdraw-id | true | long | 提现ID，填在path中 |      |      |

响应数据:

| 参数名称 | 是否必须  | 数据类型 | 描述    | 取值范围 |
| ---- | ----- | ---- | ----- | ---- |
| data | false | long | 提现 ID |      |

请求响应例子:

```
/* POST /v1/dw/withdraw-virtual/{withdraw-id}/cancel */
{
  "status": "ok",
  "data": 700
}
```