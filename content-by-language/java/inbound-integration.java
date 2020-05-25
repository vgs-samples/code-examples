import org.apache.commons.io.IOUtils;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

public class App {
public static void main(String[] args) throws IOException {
  CloseableHttpClient client = HttpClients.createDefault();
  HttpPost httpPost = new HttpPost("{reverseProxy}/post");
  httpPost.setEntity(new StringEntity("{"account_number":"account_value"}"));
  httpPost.setHeader("Content-Type", "application/json");

  CloseableHttpResponse response = client.execute(httpPost);
  String content = IOUtils.toString(response.getEntity().getContent(), StandardCharsets.UTF_8);
  System.out.println("response=" + content);
  client.close();
}
}
