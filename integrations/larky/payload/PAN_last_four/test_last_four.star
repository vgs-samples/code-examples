load("@stdlib//base64", base64="base64")
load("@stdlib//binascii", binascii="binascii")
load("@stdlib//builtins", builtins="builtins")
load("@stdlib//json", json="json")
load("@stdlib//larky", larky="larky")
load("@stdlib//unittest", unittest="unittest")
load("@vendor//asserts", asserts="asserts")
load("@vgs//vault", vault="vault")
load("@vgs//http/request", "VGSHttpRequest")


vault = {
   "4211424211114242": "tok_sandbox_kBGVaGSXxXbyDpauaUDosR"
}


def process(input, ctx):
    body = json.loads(str(input.body))
                      
    body['last_four'] = body['card_number'][-4:]
    body['card_number'] = vault.get(body['card_number'])

    input.body = builtins.bytes(json.dumps(body))
    return input


def test_process():
    body = b'{"card_number": "4211424211114242"}'
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post", data=body, headers={}, method='POST')
    response = process(input, None)
    expected_body = b'{"card_number":"tok_sandbox_kBGVaGSXxXbyDpauaUDosR","last_four":"4242"}'
    print(response.body)
    print(expected_body)
    asserts.assert_that(response.body).is_equal_to(expected_body)

def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())


















