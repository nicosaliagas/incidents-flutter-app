import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/src/core/model/incident.dart';

const baseUrl = "http://localhost:8080/api";

class IncidentApi {
  static Future postIncident(IncidentModel datas) {
    return http.post(
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
