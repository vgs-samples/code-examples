import os
USERNAME = os.environ.get('USERNAME')
PASSWORD = os.environ.get('PASSWORD')
TENANT_ID = os.environ.get('TENANT_ID')
HTTPS_PROXY = "%s:%s@%s.SANDBOX.verygoodproxy.com:8080".format(USERNAME, PASSWORD, TENANT_ID)
