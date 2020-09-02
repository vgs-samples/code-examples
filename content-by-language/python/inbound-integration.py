import requests

response = requests.post("{VAULT_URL}/post",
                          json={'account_number': 'ACC00000000000000000'})
print(str(response.text))
