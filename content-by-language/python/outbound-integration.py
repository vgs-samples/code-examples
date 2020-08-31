import os
import requests

os.environ['HTTPS_PROXY'] = 'https://{ACCESS_CREDENTIALS}@{VAULT_HOST}:{PORT}'
response = requests.post('{VGS_SAMPLE_ECHO_SERVER}/post',
                         json={'account_number': '{ALIAS}'},
                         verify='{CERT_LOCATION}')
print(str(response.json()))
