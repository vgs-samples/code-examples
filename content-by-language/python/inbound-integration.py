import requests
response = requests.post("{REVERSE_PROXY}/post",
                          json={'account_number': 'account_value'})
print(str(response.content))
