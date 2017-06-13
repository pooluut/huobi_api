#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from hbsdk import ApiClient, ApiError
from huobi_config import *

import json

def pp_json(json_thing, sort=True, indents=4):
    if type(json_thing) is str:
        print(json.dumps(json.loads(json_thing,ensure_ascii=False), sort_keys=sort, indent=indents,ensure_ascii=False))
    else:
        print(json.dumps(json_thing, sort_keys=sort, indent=indents,ensure_ascii=False))


client = ApiClient(API_KEY, API_SECRET)

accs = client.get('/v1/account/accounts')

if DEBUG:
    pp_json(accs)
account_id = accs[0].id

print ("ACCOUNT_ID:%s"%account_id)

