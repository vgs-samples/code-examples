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
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;
import java.security.KeyStore;
import java.security.cert.Certificate;
import java.security.cert.CertificateFactory;
import javax.net.ssl.SSLContext;

public class App {
public static void main(String[] args) throws IOException, GeneralSecurityException {

  final String proxyHost = "{vaultIdentifier}.sandbox.verygoodproxy.com";
  final int proxyPort = {port};
  final String proxyUser = {username};
  final String proxyPassword = {password};
  HttpHost proxy = new HttpHost(proxyHost, proxyPort);

  CredentialsProvider provider = new BasicCredentialsProvider();
  provider.setCredentials(AuthScope.ANY,
                          new UsernamePasswordCredentials(proxyUser, proxyPassword));

  CloseableHttpClient client = HttpClientBuilder
    .create()
    .setProxy(proxy)
    .setDefaultCredentialsProvider(provider)
    .setSSLContext(buildSSLContext())
    .build();

  HttpPost httpPost = new HttpPost("https://echo.apps.verygood.systems/post");
  httpPost.setHeader("Content-Type", "application/json");
  httpPost.setEntity(new StringEntity("{\"account_number\":\"ALIAS\"}"));

  CloseableHttpResponse response = client.execute(httpPost);

  String content = IOUtils.toString(response.getEntity().getContent(), StandardCharsets.UTF_8);

  System.out.println("response=" + content);
  client.close();
}

private static SSLContext buildSSLContext() throws IOException, GeneralSecurityException {
  KeyStore keyStore = KeyStore.getInstance(KeyStore.getDefaultType());
  keyStore.load(null);

  Certificate certificate = CertificateFactory.getInstance("X.509")
    .generateCertificate(new FileInputStream("/full/path/to/cert.pem"));
  keyStore.setCertificateEntry("vgs", certificate);

  return SSLContextBuilder.create().loadTrustMaterial(keyStore, null).build();
}
}
