import requests
import binascii
import base64
from Crypto.Hash import SHA512
from Crypto.Hash import HMAC

method = 'POST'
uri = '/post'

headers = {
    'content-type': 'application/json',
    'date': 'Sun, 18 Sep 2022 10:52:03 UTC',
    'shared-secret': '3vQE4R45Q4yz7dMDHUz56waSnnPD7P'
}

body = '{"merchantTransactionId":"2022-09-18-0004","amount":"9.99","currency":"EUR"}'

content_type = headers['content-type']
date = headers['date']
secret = headers['shared-secret']

body_utf8 = bytes(body, encoding="utf-8")

h = SHA512.new()
h.update(body_utf8)
signature = h.hexdigest()

print('>>> Signature: ', signature)

hmac_input = "\n".join(
        [
            method,
            signature,
            content_type,
            date,
            uri
        ]
    )

hmac_input = bytes(hmac_input, encoding="utf-8")
secret = str.encode(secret)

hash_value = HMAC.new(secret, digestmod=SHA512)
hash_value.update(hmac_input)
result = base64.b64encode(hash_value.digest()).decode("utf-8")

print('>>> Result  :', result)
