import requests
response = requests.post("{VAULT_URL}/post",
                          json={'account_number': 'account_value'})
print(str(response.content))
