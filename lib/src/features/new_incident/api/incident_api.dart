import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const baseUrl = "http://localhost:8080/api";

class IncidentApi {
  static Future postIncident() {
    return http.post(
      Uri.parse("$baseUrl/incidents"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'title': 'dfd'}),
    );
  }
}
