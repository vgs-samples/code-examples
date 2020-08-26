package com.verygoodsecurity;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class InboundIntegration {
  public static void main(String[] args) throws IOException, InterruptedException {
    final HttpClient client = HttpClient.newBuilder().build();
    final HttpRequest request = HttpRequest.newBuilder()
        .uri(URI.create("{VAULT_URL}/post"))
        .header("Content-Type", "application/json")
        .POST(HttpRequest.BodyPublishers.ofString("{\"account_number\":\"ACC00000000000000000\"}"))
        .build();
    final HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

    System.out.println("response=" + response.body());
  }
}
