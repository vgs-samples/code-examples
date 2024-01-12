# SFTP proxy GPG files encryption/decryption

This sample includes steps to follow in order to setup PGP Encryption and Decryption of NACHA files with the help of Operations in SFTP route.

## Quick start

Clone this repo for easy start. Make sure you have permissions to configure SFTP routes (i.e. you're able to see SFTP tab on Dashboard in Routes section). If not, contact support@verygoodsecurity.com.

#### 1. Fill in the .env file:

```
VAULT="tntenbznyv2"
ENVIRONMENT="sandbox"
NAME="Corey Taylor"
EMAIL="corey.taylor@email.com"
TESTFILE="file.txt"
```

#### 2. Install gnupg:

```
pip install python-gnupg
```

#### 3. Generate keys:

It will ask you for the passphrase. You'll get the fingerprint on the output:
```
python quick_start.py generate_keys
```
If you have GPG Keychain installed, the keys are automatically added there.

#### 4. Import inbound_route.yml:

No need to edit the YAML file.
This is the basic Inbound Route that redacts three JSON fields: `$.private_key`, `$.public_key` and `$.passphrase`.
Make sure it does not conflict with another Inbound Route.

#### 5. Alias the keys:

It will again ask for the passphrase since the script needs to get the private key from GPG DB:
```
python quick_start.py create_aliases
```
Output sample:
```
>>> private_key alias:  tok_sandbox_kjTBbQtYadkgjeDBQ9YDpD
>>> public_key alias:   tok_sandbox_iGmX6JWUb9NzNrDA8vEQRa
>>> passphrase alias:   tok_sandbox_s84qntSGbwCkJkLRvsvUMN
```

#### 6. Insert the aliases into sftp_route.yml:

Public key alias for encryption:

<img width="743" alt="image" src="https://user-images.githubusercontent.com/78090218/180273372-959ccdba-0697-44f2-9f6f-b857f93c3f42.png">

Private key alias and passphrase for decryption:

<img width="744" alt="image" src="https://user-images.githubusercontent.com/78090218/180273598-7e7e11e1-231d-44c1-87d7-c29d3897e3ef.png">

#### 7. Load the new route into your vault

- Save sftp_route.yml with the new public and private keys loaded in
- Import the sftP-route.yml file into your vault via the VGS Dashboard, or the [VGS CLI](https://www.verygoodsecurity.com/docs/vgs-cli/commands#apply-1)

#### 8. Setup the upstream for SFTP route:

<img width="665" alt="image" src="https://user-images.githubusercontent.com/78090218/180274134-147c0593-beae-41cb-acfb-176c442ba67f.png">

#### 9. This is it! You are ready to test!


## Testing

SFTP route settings:
- If file-path ends with `decrypted`, it does ecryption on GET
- If file-path ends with `encrypted`, it does decryption on GET

#### 1. Encrypt and Decrypt the file with route:

a) PUT and GET the file from SFTP for encryption:

<img width="697" alt="image" src="https://user-images.githubusercontent.com/78090218/180479105-86645bf1-8df5-4830-b13a-8d7957a8d9a6.png">

b) PUT and GET the file again for decryption:

<img width="863" alt="image" src="https://user-images.githubusercontent.com/78090218/180479635-3b25de51-283d-4760-b484-20c34e7c8199.png">

#### 2. Encrypt using script and Decrypt using route:

Encrypt the `file.txt`:
```
python quick_start.py encrypt_file
```
Repeat step b) from scenario #1.

#### 3. Encrypt using route and Decrypt using script:

Repeat step a) from scenario #1.

Decrypt the file using script:
```
python quick_start.py decrypt_file
```

### Troubleshooting:

- If you change smth in the SFTP route (or in YAML and re-import it), you always have to re-login to SFTP. Otherwise the changes won't come into effect.
- To install GPG Keychain use `brew install gpg-suite`
- Python 3.9.13
- gpg (GnuPG/MacGPG2) 2.2.34 and libgcrypt 1.8.9
- This example only demonstrates encrypting/decrypting files. If reveal/redact operations are needed, you will need an additional route filter to reveal/redact the data. https://www.verygoodsecurity.com/docs/features/sftp/#process-csv-files
