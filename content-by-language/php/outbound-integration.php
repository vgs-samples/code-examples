<?php
$url = '{VGS_SAMPLE_ECHO_SERVER}/post';
$data = json_encode(array('account_number' => '{ALIAS}'));
$proxy = '{VAULT_URL}:{PORT}';
$proxyauth = '{ACCESS_CREDENTIALS}';
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
