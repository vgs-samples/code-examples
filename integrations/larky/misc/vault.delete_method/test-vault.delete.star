load("@stdlib//unittest", "unittest")
load("@vendor//asserts", "asserts")
load("@stdlib//hashlib", "hashlib")
load("@stdlib//binascii", "binascii")
load("@vgs//vault", "vault")
load("@vgs//http/request", "VGSHttpRequest")
load("@stdlib//json", json="json")
load("@stdlib//builtins", builtins="builtins")


def process(input, ctx):
    body = json.loads(str(input.body))

    if body['action'] == 'reveal':
        body['card_number'] = vault.reveal(body['card_number'])
    if body['action'] == 'delete':
        vault.delete(body['card_number'])
        body['action'] = 'deleted'

    input.body = builtins.bytes(json.dumps(body))
    return input
    

def test_process():
    body = b'''{
        "card_number": "4211424211114242",
        "action": "delete"
    }'''
    print(str(body))
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post", data=body, headers={}, method='POST')
    response = process(input, None)
    expected_body = b'{"action":"delete","card_number":"4211424211114242"}'
    print(response.body)
    print(expected_body)
    asserts.assert_that(response.body).is_not_equal_to(expected_body)

def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())