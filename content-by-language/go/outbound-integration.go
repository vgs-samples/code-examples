package main

import (
  "bytes"
  "encoding/json"
  "io/ioutil"
  "log"
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
  os.Setenv("HTTPS_PROXY", "USiyQvWcT7wcpy8gvFb1GVmz:2b48a642-615a-4b3c-8db5-e02a88147174@tntsfeqzp4a.sandbox.verygoodproxy.com:8080")

  data := Payload{
    Account: "tok_sandbox_oTktJmBaAhUyGHnNJt7WMA",
  }
  payloadBytes, err := json.Marshal(data)
  if err != nil {
    log.Fatal(err)
  }

  body := bytes.NewReader(payloadBytes)

  caCert, err := ioutil.ReadFile("../../mixed-content/sandbox_cert.pem")
  if err != nil {
    log.Fatal(err)
  }
  caCertPool := x509.NewCertPool()
  caCertPool.AppendCertsFromPEM(caCert)

  client := &http.Client{
    Transport: &http.Transport{
      Proxy: http.ProxyFromEnvironment,
      TLSClientConfig: &tls.Config{
        RootCAs: caCertPool,
        InsecureSkipVerify: true,
      },
    },
  }

  req, err := http.NewRequest("POST", "https://echo.apps.verygood.systems/post", body)
  if err != nil {
    log.Fatal(err)
  }
  req.Header.Set("Content-Type", "application/json")

  resp, err := client.Do(req)
  if err != nil {
    log.Fatal(err)
  }

  defer resp.Body.Close()

  respB, err := ioutil.ReadAll(resp.Body)
  if err != nil {
    log.Fatal(err)
  }
  log.Println(string(respB))
}
