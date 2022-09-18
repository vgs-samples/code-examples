load("@stdlib//unittest", "unittest")
load("@vendor//asserts", "asserts")
load("@stdlib//hashlib", "hashlib")
load("@stdlib//binascii", "binascii")
load("@vgs//vault", "vault")
load("@vgs//http/request", "VGSHttpRequest")
load("@stdlib//base64", base64="base64")
load("@vendor//Crypto/Hash/HMAC", HMAC="HMAC")
load("@vendor//Crypto/Cipher/AES", AES="AES")
load("@vendor//Crypto/Hash/SHA256", SHA256="SHA256")
load("@stdlib//builtins", builtins="builtins")
load("@stdlib//json", json="json")
load("@vendor//Crypto/Random", get_random_bytes="get_random_bytes")
load("@vendor//Crypto/Hash/MD5", MD5="MD5")
load("@vendor//Crypto/Util/Padding", pad="pad")


def bytes_to_string(by):
    return by.decode("utf-8")

def string_to_bytes(s):
    return builtins.bytes(s, encoding="utf-8")

def process(input, ctx):
    body_str = str(input.body)
    body = json.loads(body_str)
    ssn = body['ssn']
    # encrypt SSN
    #KEY = get_random_bytes(16)
    #IV = get_random_bytes(16)
    KEY = b'abcdefgh12345678' # static for test purposes
    IV = b'09876543stuvwxyz'
    pad_ssn = pad(bytes(ssn, encoding='utf-8'), 16)
    cipher = AES.new(KEY, AES.MODE_CBC, IV)
    encrypted_ssn = cipher.encrypt(pad_ssn)
    
    # convert encrypted SSN to bytes, encode as base64, convert back to string
    body['ssn'] = bytes_to_string(base64.b64encode(string_to_bytes(encrypted_ssn)))
    body_as_bytes = string_to_bytes(str(body))

    # create md5 of body
    md5_hash = MD5.new(body_as_bytes).digest()
    md5_string = bytes_to_string(binascii.hexlify(md5_hash))

    # create hmac of body
    hash_value = HMAC.new(KEY, body_as_bytes, digestmod=SHA256).digest()
    hmac_header = bytes_to_string(binascii.hexlify(hash_value))
    body['x-hmac'] = hmac_header

    input.body = builtins.bytes(json.dumps(body))
    return input


def test_process():
    headers = {}
    body = b'{"ssn":"0987654321"}'
    input = VGSHttpRequest("https://test.com", data=body, headers=headers, method='POST')
    response = process(input, None)
    expected_body = b'{"ssn":"9/k9Y5B9XoPQ7LtMkIcttg==","x-hmac":"0e951a70f6296acfe7c8adf66f6eee511661a0a953b405d26d9fa8192c0373e2"}'
    print(response.body)
    print(expected_body)
    asserts.assert_that(response.body).is_equal_to(expected_body)


def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())