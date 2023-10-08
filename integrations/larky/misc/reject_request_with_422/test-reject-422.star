load("@stdlib//unittest", "unittest")
load("@vendor//asserts", "asserts")
load("@stdlib//hashlib", "hashlib")
load("@stdlib//binascii", "binascii")
load("@vgs//vault", "vault")
load("@vgs//http/request", "VGSHttpRequest")
load("@stdlib//json", json="json")
load("@stdlib//builtins", builtins="builtins")
load("@vendor//option/result", safe="safe")


safe_loads = safe(json.loads)

def process(input, ctx):
    result = safe_loads(str(input.body))

    if result != None and result.is_ok:
        body = result.unwrap()
        cc = body['card_number']
        alias = vault.redact(cc)
        body['card_number'] = alias
        input.body = builtins.bytes(json.dumps(body))
    else:
        input.body = b'{"message":"Unexpected request"}'
    return input
    

def test_process_malformed():
    body = b'''{
        "card_number": "4211424211114242",
    }'''
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post", data=body, headers={}, method='POST')
    response = process(input, None)
    expected_body = b'{"message":"Unexpected request"}'
    print(response.body)
    print(expected_body)
    asserts.assert_that(response.body).is_equal_to(expected_body)

def test_process_proper():
    body = b'''{
        "card_number": "4211424211114242"
    }'''
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post", data=body, headers={}, method='POST')
    response = process(input, None)
    expected_body = b'{"message":"Unexpected request"}'
    print(response.body)
    print(expected_body)
    asserts.assert_that(response.body).is_not_equal_to(expected_body)

def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process_malformed))
  _suite.addTest(unittest.FunctionTestCase(test_process_proper))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())