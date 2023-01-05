load("@stdlib//unittest", "unittest")
load("@vendor//asserts", "asserts")
load("@stdlib//hashlib", "hashlib")
load("@stdlib//binascii", "binascii")
load("@vgs//vault", "vault")
load("@vgs//http/response", "VGSHttpResponse")
load("@stdlib//base64", base64="base64")
load("@vendor//Crypto/Hash/HMAC", HMAC="HMAC")
load("@vendor//Crypto/Hash/SHA256", SHA256="SHA256")
load("@stdlib//builtins", builtins="builtins")
load("@stdlib//json", json="json")
load("@stdlib//codecs", codecs="codecs")

def process(input, ctx):
    headers = input.headers
                      
    if input.status_code == 200:
        headers['x-status'] = str(input.status_code) + ' OK'
    else:
        headers['x-status'] = 'Smth went wrong...'

    input.headers = headers
    return input


def test_process():
    headers = {"Content-type": "application/json", "Content-length": "0"}
    input = VGSHttpResponse("https://VAULT_ID.sandbox.verygoodproxy.com/status/200", headers=headers, status_code=200)
    response = process(input, None)
    expected_headers = {"Content-type": "application/json", "Content-length": "0", "x-status": "200 OK"}
    print(response.headers)
    print(expected_headers)
    asserts.assert_that(response.headers).is_equal_to(expected_headers)

def test_process_2():
    headers = {"Content-type": "application/json", "Content-length": "0"}
    input = VGSHttpResponse("https://VAULT_ID.sandbox.verygoodproxy.com/status/300", headers=headers, status_code=300)
    response = process(input, None)
    expected_headers = {"Content-type": "application/json", "Content-length": "0", "x-status": "Smth went wrong..."}
    print(response.headers)
    print(expected_headers)
    asserts.assert_that(response.headers).is_equal_to(expected_headers)

def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  _suite.addTest(unittest.FunctionTestCase(test_process_2))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())