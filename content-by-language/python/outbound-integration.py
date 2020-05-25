import os
import requests
os.environ['HTTPS_PROXY'] = '{forwardProxyURL}'
response = requests.post("https://echo.apps.verygood.systems/post",
                         json={'account_number': 'ALIAS'},
                         verify='/full/path/to/cert.pem')
print(str(response.content))
