// Take values from
// {forwardProxyURL}
// and insert them into the proper env settings:

curl_setopt($handle, CURLOPT_PROXY, "{HOST}" );
curl_setopt($handle, CURLOPT_PROXYPORT, "{PORT}");
curl_setopt($handle, CURLOPT_PROXYUSERPWD, "{USERNAME}:{PASSWORD}");
