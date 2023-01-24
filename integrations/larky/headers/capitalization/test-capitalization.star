load("@stdlib//unittest", "unittest")
load("@vendor//asserts", "asserts")
load("@stdlib//hashlib", "hashlib")
load("@stdlib//binascii", "binascii")
load("@vgs//vault", "vault")
load("@vgs//http/request", "VGSHttpRequest")
load("@stdlib//base64", base64="base64")
load("@stdlib//builtins", builtins="builtins")
load("@stdlib//json", json="json")
load("@stdlib//codecs", codecs="codecs")

vault = {
    "123": "tok_sandbox_3vLZ4BABiso9ziwzUF7Yz2"
}

def process(input, ctx):
    body = json.loads(str(input.body))
    headers = input.headers                      

    # looping through headers dict --> keys
    # making key uppercase and matching against expected name
    # applying different operations depending on the header name
    for key in headers.keys():
        if key.upper() == 'SECRET':
            secret = headers[key]
            body[key] = '********'
            headers.pop(key)
        elif key.upper() == 'NAME':
            body[key] = 'Welcome on board ' + headers[key]
            headers.pop(key)
        elif key.upper() == 'CVV':
            body[key] = vault.get(headers[key])
            headers.pop(key)
        elif key.upper() == 'X-ADDRESS':
            body[key] = headers[key] + '/24'
            headers.pop(key)

    input.headers = headers
    input.body = builtins.bytes(json.dumps(body))
    return input


def test_process():
    body = b'{}'
    headers = {
        "SecreT": "qwerty",
        "NamE": "John",
        "cVv": "123",
        "x-address": "11.22.33.44"
    }
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post", data=body, headers=headers, method='POST')
    response = process(input, None)
    expected_body = b'{"NamE":"Welcome on board John","SecreT":"********","cVv":"tok_sandbox_3vLZ4BABiso9ziwzUF7Yz2","x-address":"11.22.33.44/24"}'
    print(response.body)
    print(expected_body)
    asserts.assert_that(response.body).is_equal_to(expected_body)


def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())