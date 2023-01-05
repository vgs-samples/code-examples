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
    "tok_sandbox_asnbhwEnXEYAuT9enzW3Fp": "09",
    "tok_sandbox_23hB4vQyEGRBGcQPxmHwom": "2029",
    "tok_sandbox_vk7w1jtbKgM2jjgzUgchsT": "29"
}

def process(input, ctx):
    body = json.loads(str(input.body))
                      
    alias_mm = body['exp_month']
    alias_yy = body['exp_year']
    mm = vault.get(alias_mm)
    yy = vault.get(alias_yy)
    body['vault_month'] = mm
    body['vault_year'] = yy

    # concatenating:
    if len(yy) == 4: # if 4 digits, taking the last 2
      yy = yy[2:]
    body['exp_date'] = mm + '/' + yy

    body.pop('exp_month') # removing useless
    body.pop('exp_year')
    input.body = builtins.bytes(json.dumps(body))
    return input


def test_process():
    body = b'{"exp_month": "tok_sandbox_asnbhwEnXEYAuT9enzW3Fp", "exp_year": "tok_sandbox_23hB4vQyEGRBGcQPxmHwom"}'
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post", data=body, headers={}, method='POST')
    response = process(input, None)
    expected_body = b'{"exp_date":"09/29","vault_month":"09","vault_year":"2029"}'
    print(response.body)
    print(expected_body)
    asserts.assert_that(response.body).is_equal_to(expected_body)

def test_process_2():
    body = b'{"exp_month": "tok_sandbox_asnbhwEnXEYAuT9enzW3Fp", "exp_year": "tok_sandbox_vk7w1jtbKgM2jjgzUgchsT"}'
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post", data=body, headers={}, method='POST')
    response = process(input, None)
    expected_body = b'{"exp_date":"09/29","vault_month":"09","vault_year":"29"}'
    print(response.body)
    print(expected_body)
    asserts.assert_that(response.body).is_equal_to(expected_body)

def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  _suite.addTest(unittest.FunctionTestCase(test_process_2))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())