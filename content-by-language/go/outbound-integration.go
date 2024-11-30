package main

import (
  "bytes"
  "encoding/json"
  "io/ioutil"
  "fmt"
  "net/http"
  "os"
  "crypto/tls"
  "crypto/x509"
)


type Payload struct {
  Account string `json:"account_number"`
}

func main() {
  // You can set the proxy as an HTTPS env variable proxyUrl and go will use by default:
  os.Setenv("HTTPS_PROXY", "{SECURE_PROTOCOL}://{ACCESS_CREDENTIALS}@{VAULT_HOST}:{SECURE_PORT}")

  data := Payload{
    Account: "{ALIAS}",
  }
  payloadBytes, err := json.Marshal(data)
  if err != nil {
    fmt.Println(err)
  }

  body := bytes.NewReader(payloadBytes)

  caCert, err := ioutil.ReadFile("{CERT_LOCATION}")
  if err != nil {
    fmt.Println(err)
  }
  caCertPool := x509.NewCertPool()
  caCertPool.AppendCertsFromPEM(caCert)

  client := &http.Client{
    Transport: &http.Transport{
      Proxy: http.ProxyFromEnvironment,
      TLSClientConfig: &tls.Config{
        RootCAs: caCertPool,
        InsecureSkipVerify: false,
      },
    },
  }

  req, err := http.NewRequest("POST", "{VGS_SAMPLE_ECHO_SERVER}/post", body)
  if err != nil {
    fmt.Println(err)
  }
  req.Header.Set("Content-Type", "application/json")

  resp, err := client.Do(req)
  if err != nil {
    fmt.Println(err)
  }

  defer resp.Body.Close()

  respB, err := ioutil.ReadAll(resp.Body)
  if err != nil {
    fmt.Println(err)
  }
  fmt.Println(string(respB))
}
