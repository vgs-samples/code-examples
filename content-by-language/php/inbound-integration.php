<?php
$url = "{VAULT_URL}/post";
$data = json_encode(array("account_number" => "ACC00000000000000000"));

$cURL = curl_init();
$options = array( 
  CURLOPT_URL => $url,
  CURLOPT_FOLLOWLOCATION => 1,
  CURLOPT_POSTFIELDS => $data,
  CURLOPT_HTTPHEADER => array (
    'Accept: application/json',
    'Content-Type:application/json'
  ),
  CURLOPT_POST => true
);

curl_setopt_array($cURL, $options);
$result = curl_exec($cURL);
$errors = curl_error($cURL);
curl_close($cURL);

echo $result;
echo $errors;
?>
