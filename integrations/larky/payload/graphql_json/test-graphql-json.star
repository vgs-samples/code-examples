load("@stdlib//unittest", "unittest")
load("@vendor//asserts", "asserts")
load("@stdlib//hashlib", "hashlib")
load("@stdlib//binascii", "binascii")
load("@vgs//vault", "vault")
load("@vgs//http/request", "VGSHttpRequest")
load("@stdlib//json", json="json")
load("@stdlib//codecs", codecs="codecs")
load("@stdlib//re","re")

vault = {
    "4757140000000001": "tok_sandbox_i7NMjE9TmueQrWGQmnoHBZ",
    "123": "tok_sandbox_3vLZ4BABiso9ziwzUF7Yz2"
}

def process(input, ctx):
    # Get JSON body.
    body = json.loads(str(input.body))

    body['variables']['input']['pan'] = vault.get(body['variables']['input']['pan'])
    body['variables']['input']['cvv'] = vault.get(body['variables']['input']['cvv'])

    ## Rewrite body and return response message.
    input.body = codecs.encode(json.dumps(body),'utf-8','error', False)
    return input
    

def test_process():
    body = b'''{
        "query": "\\n  mutation AddCard($input: AddCardInput!) {\\n    addCard(input: $input) {\\n      ...CardInfo\\n    }\\n  }\\n  \\n  fragment CardInfo on Card {\\n    id\\n    userID\\n    lastDigits\\n    expiryMonth\\n    expiryYear\\n    cardType\\n    verificationStatus\\n    createdAt\\n  }\\n\\n",
        "variables":{
            "input":{
                "pan":"4757140000000001",
                "cvv":"123",
                "expiry":{
                    "expiryMonth":"12",
                    "expiryYear":"25"
                },
                "billingDetails":{
                    "email":"homer.simpson@cartoons.com",
                    "city":"Springfield",
                    "country":"US",
                    "name":"Homer Visa",
                    "province": "ON",
                    "street": "123 Fake Street",
                    "zip": "M6K1X1"
                }
            }
        }
    }'''
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post", data=body, headers={}, method='POST')
    response = process(input, None)
    expected_body = b'{"query":"\\n  mutation AddCard($input: AddCardInput!) {\\n    addCard(input: $input) {\\n      ...CardInfo\\n    }\\n  }\\n  \\n  fragment CardInfo on Card {\\n    id\\n    userID\\n    lastDigits\\n    expiryMonth\\n    expiryYear\\n    cardType\\n    verificationStatus\\n    createdAt\\n  }\\n\\n","variables":{"input":{"billingDetails":{"city":"Springfield","country":"US","email":"homer.simpson@cartoons.com","name":"Homer Visa","province":"ON","street":"123 Fake Street","zip":"M6K1X1"},"cvv":"tok_sandbox_3vLZ4BABiso9ziwzUF7Yz2","expiry":{"expiryMonth":"12","expiryYear":"25"},"pan":"tok_sandbox_i7NMjE9TmueQrWGQmnoHBZ"}}}'
    print(response.body)
    print(expected_body)
    asserts.assert_that(response.body).is_equal_to(expected_body)

def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())