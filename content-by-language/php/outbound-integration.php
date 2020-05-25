// Take values from
// {forwardProxyURL}
// and insert them into the proper env settings:

curl_setopt($handle, CURLOPT_PROXY, "{host}" );
curl_setopt($handle, CURLOPT_PROXYPORT, "{port}");
curl_setopt($handle, CURLOPT_PROXYUSERPWD, "{username}:{password}");
