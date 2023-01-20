load("@stdlib//unittest", "unittest")
load("@vendor//asserts", "asserts")
load("@stdlib//hashlib", "hashlib")
load("@stdlib//binascii", "binascii")
load("@vgs//vault", "vault")
load("@vgs//http/request", "VGSHttpRequest")
load("@stdlib//builtins", builtins="builtins")
load("@stdlib//json", json="json")
load("@stdlib//urllib/parse", parse="parse")

vault = {
    "tok_sandbox_a4JULYBMphkeL2iV7ipwdL": "4111111111111111"
}

def process(input, ctx):
    #body = json.loads(str(input.body))
    query = input.query_string
    qs = dict(parse.parse_qsl(query))
    qs['account'] = vault.get(qs['account']) # aka Reveal
    query = ''
    for key,value in qs.items():
        query += '='.join([key,value])
        query += '&'
    input.query_string = query[:-1] # without last '&'
    return input


def test_process():
    body = b'{}'
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post?account=tok_sandbox_a4JULYBMphkeL2iV7ipwdL&amount=100", data=body, headers={}, method='POST')
    response = process(input, None)
    expected_qs = 'account=4111111111111111&amount=100'
    print(response.query_string)
    print(expected_qs)
    asserts.assert_that(response.query_string).is_equal_to(expected_qs)


def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())
