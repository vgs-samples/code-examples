load("@stdlib//unittest", "unittest")
load("@vendor//asserts", "asserts")
load("@vgs//http/request", "VGSHttpRequest")
load("@stdlib//json", json="json")
load("@stdlib//builtins", builtins="builtins")
load("@stdlib//hashlib", "hashlib")
load("@stdlib//binascii", "binascii")
load("@vgs//vault", "vault")
load("@stdlib//base64", base64="base64")
load("@vendor//Crypto/Hash/HMAC", HMAC="HMAC")
load("@stdlib//string", string="string")
load("@stdlib//random", random="random") # instead of 'secrets'
load("@vendor//Crypto/Cipher/AES", AES="AES")
load("@vendor//Crypto/Util/Counter", Counter="Counter") # correct?
load("@vendor//Crypto/Hash/SHA256", SHA256="SHA256")


def process(input, ctx):
    API_SECRET = '...'
    secondKey = '...'

    body_str = str(input.body)
    body = json.loads(body_str)
    query = body['query']

    """hashpart"""
    secret = bytes(API_SECRET, encoding='utf-8')
    query_tohash = query+API_SECRET
    hashValue = HMAC.new(secret, bytes(query_tohash, encoding='utf-8'), digestmod=SHA256)
    print (hashValue.hexdigest())

    """Aes CTR encryption part"""
    to_encrypt = query + '&alg=SHA256&hashed_query='+hashValue.hexdigest()
    ivv = '...' # made it static to compare with Python
    secondKey = base64.b64decode(secondKey)
    h = binascii.hexlify(bytes(ivv,encoding='utf-8'))
    ctr = Counter.new(128, initial_value=int(str(h), 16))
    chiper = AES.new(secondKey, AES.MODE_CTR, counter=ctr)
    chipertext = chiper.encrypt(bytes(to_encrypt,encoding='utf-8'))
    encString = base64.urlsafe_b64encode(chipertext).decode()
    payload =  '&encryptedData='+encString+'&iv='+ivv

    """ final result to be send"""
    enc = bytes(payload, encoding='utf-8')
    final = base64.b64encode(enc).decode()

    body['larky_'] = final
    body.pop('query')

    input.body = builtins.bytes(json.dumps(body))
    return input


def test_process():
    headers = {}
    body = b'{"query": "MID=4111111111111111&exp_year=2030&exp_month=09&cvv=123&name=CoreyTaylor&amount=100"}'
    input = VGSHttpRequest("https://test.com", data=body, headers=headers, method='POST')
    response = process(input, None)
    expected_body = b'{"larky_":"JmVuY3J5cHRlZERhdGE9UnMxSHg0NGZROWVFUXpKaVRGSHBSWU93a0NIS0lpZmxLVFhlLXAtWmlBMDhDa3VHWF96c2x3TzROa2Nfd0dZVzlBcVVTenEzT1NyN2RLOEo1c05WU20zQ0xtckU0ejFhNnRCYnE2TjN5dmdnVXhLb1JTVWp4Nnp4Z1dYTm1BZDdrZjVyYlhydlhnR2UwZVZjdlBFQUE3ZkVmbUJYZDdMM2pWT1JKekJIMGdMWDE0Ry1vQ2pFQVg0VmcxQ2xUbnQwZmVva255VXphczVUcHJld1dGOUJoQ1kzN3VYTVM2U2pNalJiRmc9PSZpdj1zZUJoZU5OWXpFVVJ1eVFS"}'
    print(response.body)
    print(expected_body)
    asserts.assert_that(response.body).is_equal_to(expected_body)


def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())
