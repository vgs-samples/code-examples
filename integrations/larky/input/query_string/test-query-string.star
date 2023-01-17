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
    path = input.path
    query = input.query_string
    body = json.loads(str(input.body))

    lst = query.split('=')
    alias = lst[-1]

    body['account'] = vault.get(alias)
    body['query'] = query
    body['path'] = path

    input.body = builtins.bytes(json.dumps(body))
    return input


def test_process():
    body = b'{"amount":"10"}'
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post?account=tok_sandbox_a4JULYBMphkeL2iV7ipwdL", data=body, headers={}, method='POST')
    response = process(input, None)
    expected_body = b'{"account":"4111111111111111","amount":"10","path":"/post","query":"account=tok_sandbox_a4JULYBMphkeL2iV7ipwdL"}'
    print(response.body)
    print(expected_body)
    asserts.assert_that(response.body).is_equal_to(expected_body)


def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())