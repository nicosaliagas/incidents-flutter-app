import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:my_app/src/core/api/error_interceptor.dart';

const baseUrl = "http://localhost:8080/api";

class CategoryApi {
  InterceptedClient client = InterceptedClient.build(interceptors: [
    ErrorInterceptor(),
  ]);

  Future getCategories() {
    return client.get(Uri.parse("$baseUrl/incident-categories"));
  }
}
