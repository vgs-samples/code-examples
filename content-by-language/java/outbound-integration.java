package com.verygoodsecurity;

import org.apache.commons.io.IOUtils;
import org.apache.http.HttpHost;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.ssl.SSLContextBuilder;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;
import java.security.KeyStore;
import java.security.cert.Certificate;
import java.security.cert.CertificateFactory;

import javax.net.ssl.SSLContext;

public class OutboundIntegration {
  public static void main(String[] args) throws IOException, GeneralSecurityException {
    final String proxyHost = "{VAULT_URL}";
    final int proxyPort = {PORT};
    final String proxyUser = "{USERNAME}";
    final String proxyPassword = "{PASSWORD}";
    final HttpHost proxy = new HttpHost(proxyHost, proxyPort);

    final CredentialsProvider provider = new BasicCredentialsProvider();
    provider.setCredentials(AuthScope.ANY,
        new UsernamePasswordCredentials(proxyUser, proxyPassword));

    final CloseableHttpClient client = HttpClientBuilder
        .create()
        .setProxy(proxy)
        .setDefaultCredentialsProvider(provider)
        .setSSLContext(buildSSLContext())
        .build();

    final HttpPost httpPost = new HttpPost("{VGS_SAMPLE_ECHO_SERVER}/post");
    httpPost.setHeader("Content-Type", "application/json");
    httpPost.setEntity(new StringEntity("{\"account_number\":\"{ALIAS}\"}"));

    final CloseableHttpResponse response = client.execute(httpPost);

    final String content = IOUtils.toString(response.getEntity().getContent(), StandardCharsets.UTF_8);

    System.out.println("response=" + content);
    client.close();
  }

  private static SSLContext buildSSLContext() throws IOException, GeneralSecurityException {
    final KeyStore keyStore = KeyStore.getInstance(KeyStore.getDefaultType());
    keyStore.load(null);

    final Certificate certificate = CertificateFactory.getInstance("X.509")
        .generateCertificate(OutboundIntegration.class
            .getClassLoader().getResourceAsStream(("{CERT_LOCATION}")));
    keyStore.setCertificateEntry("vgs", certificate);

    return SSLContextBuilder.create().loadTrustMaterial(keyStore, null).build();
  }
}
