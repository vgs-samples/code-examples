import requests

response = requests.post("https://tntsfeqzp4a.sandbox.verygoodproxy.com/post",
                          json={'account_number': 'ACC00000000000000000'})
print(str(response.json()))
