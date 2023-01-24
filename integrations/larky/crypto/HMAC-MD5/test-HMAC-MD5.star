load("@stdlib//unittest", "unittest")
load("@vendor//asserts", "asserts")
load("@stdlib//hashlib", "hashlib")
load("@stdlib//binascii", "binascii")
load("@vgs//vault", "vault")
load("@vgs//http/request", "VGSHttpRequest")
load("@stdlib//builtins", builtins="builtins")
load("@stdlib//json", json="json")
load("@stdlib//codecs", codecs="codecs")
load("@vendor//Crypto/Hash/HMAC", HMAC="HMAC")
load("@vendor//Crypto/Hash/MD5", MD5="MD5")

vault = {
    "tok_sandbox_a4JULYBMphkeL2iV7ipwdL": "4111111111111111",
    "tok_sandbox_bmNL9mL5BjNoxEbyMmQomF": "abcdefgh12345678"
}

def bytes_to_string(by):
    return by.decode("utf-8")

def string_to_bytes(s):
    return builtins.bytes(s, encoding="utf-8")

def process(input, ctx):
    headers = input.headers
    body = json.loads(str(input.body))
    KEY = string_to_bytes(vault.get('tok_sandbox_bmNL9mL5BjNoxEbyMmQomF'))
    ID = headers['x-customer-id']
    card_number = vault.get(body['account'])
    body['account'] = card_number
    plainText = '|'.join([card_number, ID])
    # create hmac of body
    body_as_bytes = string_to_bytes(plainText)
    hash_value = HMAC.new(KEY, body_as_bytes, digestmod=MD5).digest()
    hmac_header = bytes_to_string(binascii.hexlify(hash_value))
    headers['x-hash'] = hmac_header                 
    input.headers = headers
    input.body = builtins.bytes(json.dumps(body))
    return input


def test_process():
    body = b'{"account":"tok_sandbox_a4JULYBMphkeL2iV7ipwdL"}'
    headers = {"x-customer-id": "1q2W3e4R5t6Y7u8I9o0P"}
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post", data=body, headers=headers, method='POST')
    response = process(input, None)
    expected_body = b'{"account":"4111111111111111"}'
    expected_headers = {"x-customer-id": "1q2W3e4R5t6Y7u8I9o0P", "x-hash": "cec8313d134368778d8e3ae4b9268ed4"}
    print(response.body)
    print(expected_body)
    print(response.headers)
    print(expected_headers)
    asserts.assert_that(response.body).is_equal_to(expected_body)
    asserts.assert_that(response.headers).is_equal_to(expected_headers)


def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())