// Run with flag: -Djdk.http.auth.tunneling.disabledSchemes=""
// More info: https://www.oracle.com/java/technologies/javase/8u111-relnotes.html

package com.verygoodsecurity;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.ProxySelector;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.security.GeneralSecurityException;
import java.security.KeyStore;
import java.security.cert.Certificate;
import java.security.cert.CertificateFactory;
import java.util.Base64;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.TrustManagerFactory;

public class OutboundIntegration {
  public static void main(String[] args) throws IOException, InterruptedException, GeneralSecurityException {
    System.setProperty("jdk.http.auth.tunneling.disabledSchemes", "");
    final String proxyHost = "{VAULT_HOST}";
    final var proxyPort = {PORT};
    final String proxyUser = "{USERNAME}";
    final String proxyPassword = "{PASSWORD}";

    final HttpClient client = HttpClient.newBuilder()
        .sslContext(buildSSLContext())
        .proxy(ProxySelector.of(new InetSocketAddress(proxyHost, proxyPort)))
        .build();
    final String proxyAuthentication = proxyUser + ":" + proxyPassword;
    final String proxyAuthenticationEncoded = new String(Base64.getEncoder().encode(proxyAuthentication.getBytes()));
    final HttpRequest request = HttpRequest.newBuilder()
        .uri(URI.create("{VGS_SAMPLE_ECHO_SERVER}/post"))
        .header("Content-Type", "application/json")
        .POST(HttpRequest.BodyPublishers.ofString("{\"account_number\":\"{ALIAS}\"}"))
        .setHeader("Proxy-Authorization", "Basic " + proxyAuthenticationEncoded)
        .build();
    final HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

    System.out.println("status code=" + response.statusCode());
    System.out.println("response=" + response.body());
  }

  private static SSLContext buildSSLContext() throws IOException, GeneralSecurityException {
    final KeyStore keyStore = KeyStore.getInstance(KeyStore.getDefaultType());
    keyStore.load(null);

    FileInputStream fileInputStream = new FileInputStream("{CERT_LOCATION}");

    final Certificate certificate = CertificateFactory.getInstance("X.509")
        .generateCertificate(fileInputStream);
    keyStore.setCertificateEntry("vgs", certificate);

    final TrustManagerFactory tmf = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
    tmf.init(keyStore);
    final TrustManager[] trustManagers = tmf.getTrustManagers();

    final SSLContext sslContext = SSLContext.getInstance("TLS");
    sslContext.init(null, trustManagers, null);
    return sslContext;
  }
}
