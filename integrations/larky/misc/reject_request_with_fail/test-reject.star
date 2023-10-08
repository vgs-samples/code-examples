load("@stdlib//unittest", "unittest")
load("@vendor//asserts", "asserts")
load("@stdlib//hashlib", "hashlib")
load("@stdlib//binascii", "binascii")
load("@vgs//vault", "vault")
load("@vgs//http/request", "VGSHttpRequest")
load("@stdlib//json", json="json")
load("@stdlib//builtins", builtins="builtins")


blacklist = ['4716247115929972','4024007171488157','4532811659588023',
             '4024007105611817','4724834302207419','5264373430771619',
             '5172879945507448','5555520118703383','5590420984436787']

def process(input, ctx):
    body = json.loads(str(input.body))

    if body['card'] in blacklist:
        body = {
            "message": "This card is blocked"
        }
    else:
        body['card'] = vault.get(body['card'])

    input.body = builtins.bytes(json.dumps(body))
    return input
    

def test_process():
    body = b'''{
        "card":"4716247115929972",
        "cvv":"123",
        "expiry":{
            "expiryMonth":"12",
            "expiryYear":"25"
        }
    }'''
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post", data=body, headers={}, method='POST')
    response = process(input, None)
    expected_body = b'{"message":"This card is blocked"}'
    print(response.body)
    print(expected_body)
    asserts.assert_that(response.body).is_equal_to(expected_body)

def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())