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
    "tok_sandbox_a4JULYBMphkeL2iV7ipwdL": "4111111111111111"
}

def process(input, ctx):
    headers = input.headers
    protocol = input.url       # returns 'https://'
    host = headers['Host']     # returns 'VAULT_ID.sandbox.verygoodproxy.com' for Inbound Route
                               # and 'echo.apps.verygood.systems' for Outbound Route (i.e. upstream)
    path = input.path          # returns '/post'
    query = input.query_string # returns 'account=homer'

    headers['x-request-uri'] = protocol + host + path + '?' + query

    input.headers = headers
    return input


def test_process():
    body = b''
    headers = {
        "Content-type": "application/json",
        "Host": "echo.apps.verygood.systems"
    }
    input = VGSHttpRequest("https://echo.apps.verygood.systems/post?account=homer", data=body, headers=headers, method='POST')
    response = process(input, None)
    expected_headers = {"Content-type": "application/json", "Host": "echo.apps.verygood.systems", "x-request-uri": "https://echo.apps.verygood.systems/post?account=homerecho.apps.verygood.systems/post?account=homer"}
    print(response.headers)
    print(expected_headers)
    asserts.assert_that(response.headers).is_equal_to(expected_headers)


def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())