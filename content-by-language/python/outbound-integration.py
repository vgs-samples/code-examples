import os
import requests

os.environ['HTTPS_PROXY'] = 'https://{ACCESS_CREDENTIALS}@{VAULT_HOST}:{PORT}'
response = requests.post('{VGS_SAMPLE_ECHO_SERVER}/post',
                         json={'account_number': 'tok_sandbox_w8CBfH8vyYL2xWSmMWe3Ds'},
                         verify='/opt/app/cert.pem')
print(str(response.json()))