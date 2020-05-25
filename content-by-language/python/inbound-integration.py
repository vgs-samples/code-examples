import requests
response = requests.post("{reverseProxy}/post",
                          json={'account_number': 'account_value'})
print(str(response.content))
