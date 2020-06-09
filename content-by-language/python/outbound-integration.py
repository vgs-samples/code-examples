import os
import requests
os.environ['HTTPS_PROXY'] = '{ACCESS_CREDENTIALS}@{VAULT_HOST}:{PORT}'
response = requests.post("{VGS_SAMPLE_ECHO_SERVER}/post",
                         json={'account_number': '{ALIAS}'},
                         verify='/full/path/to/cert.pem')
print(str(response.content))
