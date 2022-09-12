import builtins
import json
from requests.auth import HTTPProxyAuth
import base64
from Crypto.Cipher import AES

TAG_LENGTH = 8

session_key = b'vbfhg768ghvbfhg768ghvbfhg768gh12'
nonce = b'asd456fgh012'

body = b'{"card_number":"4111111111111111"}'

cipher_aes = AES.new(session_key, AES.MODE_GCM, nonce=nonce, mac_len=TAG_LENGTH)
ciphertext, tag = cipher_aes.encrypt_and_digest(body)
ciphertext_tag = b"".join([cipher_aes.nonce, ciphertext, tag])
result_GCM = base64.b64encode(ciphertext_tag).decode('utf-8')
print('\n>>> Encrypted GCM: ', result_GCM)

#decrypt GCM:
cipher = AES.new(session_key, AES.MODE_GCM, nonce=nonce)
plaintext = cipher.decrypt(ciphertext)
print("\n>>> GCM decrypted: " + str(plaintext))

cipher_aes = AES.new(session_key, AES.MODE_CCM, nonce=nonce, mac_len=TAG_LENGTH)
ciphertext, tag = cipher_aes.encrypt_and_digest(body)
ciphertext_tag = b"".join([cipher_aes.nonce, ciphertext, tag])
result_CCM = base64.b64encode(ciphertext_tag).decode('utf-8')
print('\n>>> Encrypted CCM: ', result_CCM)

#decrypt CCM:
cipher = AES.new(session_key, AES.MODE_CCM, nonce=nonce)
plaintext = cipher.decrypt(ciphertext)
print("\n>>> CCM decrypted: " + str(plaintext) + '\n')

