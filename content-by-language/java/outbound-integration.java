package com.verygoodsecurity;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.util.Arrays;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContexts;
import org.apache.http.util.EntityUtils;

public class OutboundIntegration {

  public static void main(String[] args) throws IOException, CertificateException, NoSuchAlgorithmException, KeyStoreException, KeyManagementException {
    tlsProxy();
  }

  private static void tlsProxy() throws IOException, CertificateException, NoSuchAlgorithmException, KeyStoreException, KeyManagementException {
    final int proxyPort = {SECURE_PORT};
    CredentialsProvider credsProvider = new BasicCredentialsProvider();
    credsProvider.setCredentials(
        new AuthScope("{VAULT_HOST}", proxyPort),
        new UsernamePasswordCredentials("{USERNAME}", "{PASSWORD}"));
    HttpHost proxy = new HttpHost("{VAULT_HOST}", proxyPort, "https");
    HttpHost target = new HttpHost("{VGS_SAMPLE_ECHO_SERVER}", 443, "https");

    CloseableHttpClient httpclient = HttpClients.custom()
        .setSSLSocketFactory(getSslConnectionSocketFactory())
        .setDefaultCredentialsProvider(credsProvider).build();

    try {

      RequestConfig config = RequestConfig.custom()
          .setProxy(proxy)
          .build();
      HttpPost httpPost = getRequest(config);


      CloseableHttpResponse response = httpclient.execute(target, httpPost);
      try {
        System.out.println("status code=" + response.getStatusLine());
        System.out.println("response=" + EntityUtils.toString(response.getEntity()));
      } finally {
        response.close();
      }
    } catch (ClientProtocolException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    } finally {
      httpclient.close();
    }
  }

  private static HttpPost getRequest(RequestConfig config) throws UnsupportedEncodingException {
    HttpPost httpPost = new HttpPost("/post");
    HttpEntity requestEntity = new StringEntity("{\"account_number\":\"{ALIAS}\"}");
    httpPost.setHeader("Content-Type", "application/json");
    httpPost.setEntity(requestEntity);
    httpPost.setConfig(config);
    return httpPost;
  }

  private static SSLConnectionSocketFactory getSslConnectionSocketFactory() throws CertificateException, NoSuchAlgorithmException, KeyStoreException, IOException, KeyManagementException {

    SSLContext sslcontext = SSLContexts.custom()
        .loadTrustMaterial(getKeystore(), null)
        .build();
    return new SSLConnectionSocketFactory(
        sslcontext,
        new String[] { "TLSv1.2" },
        null,
        SSLConnectionSocketFactory.getDefaultHostnameVerifier());

  }

  private static KeyStore getKeystore() throws KeyStoreException, CertificateException, IOException, NoSuchAlgorithmException {
    KeyStore ks = KeyStore.getInstance(KeyStore.getDefaultType());
    ks.load(null, "vgs".toCharArray());

    FileInputStream fis = new FileInputStream("{CERT_LOCATION}");
    X509Certificate vgsSelfSigned = (X509Certificate) CertificateFactory.getInstance("X.509")
        .generateCertificate(new BufferedInputStream(fis));
    ks.setCertificateEntry("VGS Self Signed Certificate", vgsSelfSigned);
    URL destinationURL = new URL("https://" + "{VAULT_HOST}");
    HttpsURLConnection conn = (HttpsURLConnection) destinationURL.openConnection();
    conn.connect();
    Arrays.stream(conn.getServerCertificates()).forEach(certificate -> {
      try {
        ks.setCertificateEntry(String.valueOf(certificate.hashCode()), certificate);
      } catch (KeyStoreException e) {
        e.printStackTrace();
      }
    });
    return ks;
  }
}
