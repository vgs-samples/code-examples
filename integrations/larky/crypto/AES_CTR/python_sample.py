import hmac
import hashlib
import base64
import secrets
from Crypto.Cipher import AES
from Crypto.Util import Counter
import binascii
from base64 import b64encode
import string
API_SECRET = '...'
query = 'MID=4111111111111111&exp_year=2030&exp_month=09&cvv=123&name=CoreyTaylor&amount=100'
secondKey = '...='

"""hashpart"""
secret = API_SECRET.encode()
query_tohash = query + API_SECRET
hashValue = hmac.new(secret,bytes(query_tohash, encoding='utf-8'),digestmod=hashlib.sha256)

"""Aes CTR encryption part"""
to_encrypt = query + '&alg=SHA256&hashed_query=' + hashValue.hexdigest()
secondKey = base64.b64decode(secondKey)
ivv = '...' 
h = binascii.hexlify(bytes(ivv,encoding='utf-8'))
ctr = Counter.new(128, initial_value=int(h, 16))
chiper = AES.new(secondKey, AES.MODE_CTR, counter=ctr)
chipertext = chiper.encrypt(bytes(to_encrypt,encoding='utf-8'))
encString = base64.urlsafe_b64encode(chipertext).decode()
payload =  '&encryptedData='+encString+'&iv='+ivv

""" final result to be send"""
print(base64.b64encode(payload.encode()).decode())
