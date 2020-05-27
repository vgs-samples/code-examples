package main

import (
"bytes"
"encoding/json"
"io/ioutil"
"log"
"net/http"
)

type Payload struct {
Account string 'json:"account_number"'
}

func main() {
data := Payload{
  // fill struct
}
payloadBytes, err := json.Marshal(data)
if err != nil {
  log.Fatal(err)
}

body := bytes.NewReader(payloadBytes)

req, err := http.NewRequest("POST", "https://{VAULT_IDENTIFIER}.SANDBOX.verygoodproxy.com/post", body)
if err != nil {
  log.Fatal(err)
}
req.Header.Set("Content-Type", "application/json")

resp, err := http.DefaultClient.Do(req)
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
