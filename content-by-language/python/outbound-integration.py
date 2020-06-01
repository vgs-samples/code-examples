import os
import requests
os.environ['HTTPS_PROXY'] = '{FORWARD_PROXY_URL}'
response = requests.post("https://echo.apps.verygood.systems/post",
                         json={'account_number': '{ALIAS}'},
                         verify='/full/path/to/cert.pem')
print(str(response.content))
