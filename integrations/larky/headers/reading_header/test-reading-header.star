load("@stdlib//unittest", "unittest")
load("@vendor//asserts", "asserts")
load("@stdlib//hashlib", "hashlib")
load("@stdlib//binascii", "binascii")
load("@vgs//vault", "vault")
load("@vgs//http/request", "VGSHttpRequest")
load("@stdlib//base64", base64="base64")
load("@vendor//Crypto/Hash/HMAC", HMAC="HMAC")
load("@vendor//Crypto/Hash/SHA256", SHA256="SHA256")
load("@stdlib//builtins", builtins="builtins")
load("@stdlib//json", json="json")
load("@stdlib//codecs", codecs="codecs")

vault = {
    "tok_sandbox_kqRvua3pGhpP5V2GK2yxL": "v3ry-53cr3t-w0rd!"
}

def process(input, ctx):
    headers = input.headers
    body = json.loads(str(input.body))

    alias = headers['secret']

    body['secret'] = vault.get(alias)
    headers.pop('secret')

    input.headers = headers
    input.body = builtins.bytes(json.dumps(body))
    return input


def test_process():
    body = b'{}'
    headers = {
        "secret": "tok_sandbox_kqRvua3pGhpP5V2GK2yxL"
    }
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post", data=body, headers=headers, method='POST')
    response = process(input, None)
    expected_body = b'{"secret":"v3ry-53cr3t-w0rd!"}'
    print(response.body)
    print(expected_body)
    asserts.assert_that(response.body).is_equal_to(expected_body)


def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())