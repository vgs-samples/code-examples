load("@stdlib//unittest", "unittest")
load("@vendor//asserts", "asserts")
load("@vgs//http/request", "VGSHttpRequest")
load("@stdlib//json", json="json")
load("@stdlib//builtins", builtins="builtins")
load("@vendor//Crypto/Cipher/AES", AES="AES")
load("@stdlib//base64", base64="base64")


def process(input, ctx):
    TAG_LENGTH = 8
    session_key = b'vbfhg768ghvbfhg768ghvbfhg768gh12'
    nonce = b'asd456fgh012'

    body_str = str(input.body)
    body = json.loads(body_str)

    # GCM:
    cipher_aes = AES.new(session_key, AES.MODE_GCM, nonce=nonce, mac_len=TAG_LENGTH)
    ciphertext, tag = cipher_aes.encrypt_and_digest(builtins.bytes(body_str, 'utf-8'))
    ciphertext_tag = b"".join([cipher_aes.nonce, ciphertext, tag])
    ciphertext_b64_GCM = base64.b64encode(ciphertext_tag).decode('utf-8')
    # decrypt:
    cipher = AES.new(session_key, AES.MODE_GCM, nonce=nonce)
    plaintext = cipher.decrypt(ciphertext)
    body['GCM'] = ciphertext_b64_GCM
    body['GCM_decrypted'] = json.loads(str(plaintext))

    # CCM:
    cipher_aes = AES.new(session_key, AES.MODE_CCM, nonce=nonce, mac_len=TAG_LENGTH)
    ciphertext, tag = cipher_aes.encrypt_and_digest(builtins.bytes(body_str, 'utf-8'))
    ciphertext_tag = b"".join([cipher_aes.nonce, ciphertext, tag])
    ciphertext_b64_CCM = base64.b64encode(ciphertext_tag).decode('utf-8')
    # decrypt:
    cipher = AES.new(session_key, AES.MODE_CCM, nonce=nonce)
    plaintext = cipher.decrypt(ciphertext)
    body['CCM'] = ciphertext_b64_CCM
    body['CCM_decrypted'] = json.loads(str(plaintext))

    body.pop('card_number')
    input.body = builtins.bytes(json.dumps(body))
    return input


def test_process():
    headers = {}
    body = b'{"card_number":"4111111111111111"}'
    input = VGSHttpRequest("https://test.com", data=body, headers=headers, method='POST')
    response = process(input, None)
    expected_body = b'{"CCM":"YXNkNDU2ZmdoMDEysNf+zbjlTcFG/q1TPyuLIJwELXp6pSwIx1bwpV8Zw92S6G2FpI3OpWEJ","CCM_decrypted":{"card_number":"4111111111111111"},"GCM":"YXNkNDU2ZmdoMDEyql2O8UB53Ux94KWoIaIDarnm+6xKaXL2FNfHl5XOCtbv590W5x6ISEI3","GCM_decrypted":{"card_number":"4111111111111111"}}'
    print(response.body)
    print(expected_body)
    asserts.assert_that(response.body).is_equal_to(expected_body)


def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())

