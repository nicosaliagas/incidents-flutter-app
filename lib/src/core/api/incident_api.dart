import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:my_app/src/core/api/error_interceptor.dart';
import 'package:my_app/src/core/model/incident.dart';

const baseUrl = "http://localhost:8080/api";

class IncidentApi {
  InterceptedClient client = InterceptedClient.build(interceptors: [
    ErrorInterceptor(),
  ]);

  Future postIncident(IncidentModel datas) {
    return client.post(
      Uri.parse("$baseUrl/incidents"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        datas,
      ),
    );
  }
}
