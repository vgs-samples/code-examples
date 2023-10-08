load("@stdlib//unittest", "unittest")
load("@vendor//asserts", "asserts")
#load("@stdlib//hashlib", "hashlib")
#load("@stdlib//binascii", "binascii")
#load("@vgs//vault", "vault")
load("@vgs//http/request", "VGSHttpRequest")
#load("@stdlib//base64", base64="base64")
#load("@stdlib//builtins", builtins="builtins")
#load("@stdlib//json", json="json")
#load("@stdlib//codecs", codecs="codecs")
load("@stdlib//re", re="re")


def process(input, ctx):
    headers = input.headers
    value = headers['x-forwarded-for']
    headers['x-forwarded-for'] = re.split(",", value)[0] # remove everything except first
    input.headers = headers
    return input


def test_process():
    body = b'{}'
    headers = {
        "x-forwarded-for": "83.218.249.30, 10.6.30.200"
    }
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post", data=body, headers=headers, method='POST')
    response = process(input, None)
    expected_headers = {
        "x-forwarded-for": "83.218.249.30",
    }
    print(response.headers)
    print(expected_headers)
    asserts.assert_that(response.headers).is_equal_to(expected_headers)


def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())