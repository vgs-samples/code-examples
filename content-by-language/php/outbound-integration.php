// Take values from
// {forwardProxyURL}
// and insert them into the proper env settings:

curl_setopt($handle, CURLOPT_PROXY, "{VAULT_HOST}" );
curl_setopt($handle, CURLOPT_PROXYPORT, "{PORT}");
curl_setopt($handle, CURLOPT_PROXYUSERPWD, "{ACCESS_CREDENTIALS}");
