load("@stdlib//unittest", "unittest")
load("@vendor//asserts", "asserts")
load("@stdlib//hashlib", "hashlib")
load("@stdlib//binascii", "binascii")
load("@vgs//vault", "vault")
load("@vgs//http/request", "VGSHttpRequest")
load("@stdlib//json", json="json")
load("@stdlib//builtins", builtins="builtins")

vault = {
    "4757140000000001": "tok_sandbox_i7NMjE9TmueQrWGQmnoHBZ",
    "123": "tok_sandbox_3vLZ4BABiso9ziwzUF7Yz2"
}

def process(input, ctx):
    body = json.loads(str(input.body))
    
    body_str = json.dumps(body)

    #print('BEFORE: ', body_str)
    body_str = body_str.replace(':',': ')
    body_str = body_str.replace(',',', ')
    #print('AFTER: ', body_str)
    
    input.body = builtins.bytes(body_str)
    return input
    

def test_process():
    body = b'''{
        "pan":"4242424242424242",
        "cvv":"123",
        "expiry":{
            "expiryMonth":"12",
            "expiryYear":"25"
        }
    }'''
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post", data=body, headers={}, method='POST')
    response = process(input, None)
    expected_body = b'{"cvv": "123", "expiry": {"expiryMonth": "12", "expiryYear": "25"}, "pan": "4242424242424242"}'
    print(response.body)
    print(expected_body)
    asserts.assert_that(response.body).is_equal_to(expected_body)

def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())