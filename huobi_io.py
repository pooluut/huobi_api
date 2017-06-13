from hbsdk import ApiClient, ApiError
from huobi_config import *
import json
import argparse

def pp_json(json_thing, sort=True, indents=4):
    if type(json_thing) is str:
        print(json.dumps(json.loads(json_thing), sort_keys=sort, indent=indents,ensure_ascii=False))
    else:
        print(json.dumps(json_thing, sort_keys=sort, indent=indents,ensure_ascii=False))



def get_market_kline(**params):
    print(client.get_public('/market/kline',**params))

def get_market_depth(**params):
    print(client.get_public('/market/depth',**params))

def get_market_trade(**params):
    print(client.get_public('/market/trade',**params))

def get_market_detail(**params):
    print(client.get_public('/market/detail',**params))

def get_timestamp(**params):
    print(client.get_public('/v1/common/timestamp',**params))

def get_balance(**params):
    print(str(client.get('/v1/account/accounts/%s/balance'%ACCOUNT_ID,**params)).replace("'",'"'))

def get_order_info(**params):
    order_info = client.get('/v1/order/orders/%s' % params['order_id'])
    print(str(order_info).replace("'",'"'))

def get_order_matchresult(**params):
    order_info = client.get('/v1/order/orders/%s/matchresults' % params['order_id'])
    print(str(order_info).replace("'",'"'))

def post_cancel_order(**params):
    print(client.post('/v1/order/orders/%s/submitcancel' % params['order_id']))


def post_orders(**params):
    if (params['type']=='buy-market' or params['type']=='sell-market'):
        order_id = client.post('/v1/order/orders',{
            'account-id': ACCOUNT_ID,
            'amount': params['amount'],
            # 'price': params['price'],
            'symbol': params['symbol'],
            'type': params['type'],
            'source': 'api'
            })
    else:
        order_id = client.post('/v1/order/orders',{
            'account-id': ACCOUNT_ID,
            'amount': params['amount'],
            'price': params['price'],
            'symbol': params['symbol'],
            'type': params['type'],
            'source': 'api'
            })
    client.post('/v1/order/orders/%s/place' % order_id)
    print(order_id)
    # order_info = client.get('/v1/order/orders/%s' % order_id)
    # print(str(order_info).replace("'",'"'))




# def get_orders(**params):
#     print(str(client.get('/v1/account/accounts/%s/balance'%ACCOUNT_ID,**params)).replace("'",'"'))







parser = argparse.ArgumentParser()
parser.add_argument('command')
parser.add_argument('-s',dest='params')

args = parser.parse_args()
if(args.params):
    params=json.loads(args.params)
else:
    params={}

client = ApiClient(API_KEY, API_SECRET)

eval("%s(**params)"%(args.command))




# acc = client.get('/v1/account/accounts/%s/balance'%ACCOUNT_ID)
# pp_json(acc)


# client.get('/v1/market/kline')
