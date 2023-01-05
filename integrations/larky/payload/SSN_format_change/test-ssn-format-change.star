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
    "tok_sandbox_hVSjiJJsA6a9VcAci7wo7g": "123456789"
}

def process(input, ctx):
    body = json.loads(str(input.body))
                      
    alias = body['ssn']
    ssn = vault.get(alias)
    body['vault-ssn'] = ssn
    
    # chnaging the format to ###-##-####
    body['ssn'] = "-".join((ssn[:3], ssn[3:5], ssn[5:]))
    
    input.body = builtins.bytes(json.dumps(body))
    return input


def test_process():
    body = b'{"ssn": "tok_sandbox_hVSjiJJsA6a9VcAci7wo7g"}'
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post", data=body, headers={}, method='POST')
    response = process(input, None)
    expected_body = b'{"ssn":"123-45-6789","vault-ssn":"123456789"}'
    print(response.body)
    print(expected_body)
    asserts.assert_that(response.body).is_equal_to(expected_body)


def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())