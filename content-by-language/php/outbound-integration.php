<?php
$url = 'https://echo.apps.verygood.systems/post';
$data = json_encode(array('account_number' => 'tok_sandbox_w8CBfH8vyYL2xWSmMWe3Ds'));
$proxy = 'tntsfeqzp4a.sandbox.verygoodproxy.com:8080';
$proxyauth = 'USiyQvWcT7wcpy8gvFb1GVmz:2b48a642-615a-4b3c-8db5-e02a88147174';
$certpath = '../../mixed-content/sandbox_cert.pem';

$cURL = curl_init();
$options = array( 
  CURLOPT_URL => $url,
  CURLOPT_PROXY => $proxy,
  CURLOPT_PROXYUSERPWD => $proxyauth,
  CURLOPT_FOLLOWLOCATION => 1,
  CURLOPT_POSTFIELDS => $data,
  CURLOPT_HTTPHEADER => array (
    'Accept: application/json',
    'Content-Type:application/json'
  ),
  CURLOPT_SSL_VERIFYPEER => false,
  CURLOPT_CAINFO => $certpath,
  CURLOPT_POST => true
);

curl_setopt_array($cURL, $options);
$result = curl_exec($cURL);
curl_close($cURL);
?>
