import json
import tempfile

import requests # requires requests==2.26.0 and urllib3==1.26.7
from requests import utils

def send_post_request(url, proxy, payload, headers, ca):
    return requests.post(url, proxies={{SECURE_PROTOCOL}: proxy},
                         data=json.dumps(payload),
                         headers=headers, verify=ca)


def vgs_proxy():
    payload = {'account_number': '{ALIAS}'}
    path_to_lib_ca = utils.DEFAULT_CA_BUNDLE_PATH
    path_to_vgs_ca = '{CERT_LOCATION}'
    with tempfile.NamedTemporaryFile() as ca_file:
        ca_file.write(read_file(path_to_vgs_ca))
        ca_file.write(str.encode('\n'))
        ca_file.write(read_file(path_to_lib_ca))
        read_file(ca_file.name)
        return send_post_request(
            url=f'{VGS_SAMPLE_ECHO_SERVER}/post',
            proxy=f'{SECURE_PROTOCOL}://{ACCESS_CREDENTIALS}@{VAULT_HOST}:{SECURE_PORT}',
            payload=payload,
            headers={
                'Content-type': 'application/json',
                'User-Agent': "requests-python"
            },
            ca=ca_file.name).content


def read_file(path):
    with open(path, mode='rb') as file:
        return file.read()


print(vgs_proxy())
