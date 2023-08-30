import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://localhost:8080/api";

class CategoryApi {
  static Future getCategories() {
    return http.get(Uri.parse("$baseUrl/incident-categories"));
  }
}
