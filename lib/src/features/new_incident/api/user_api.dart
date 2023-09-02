import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/src/features/new_incident/models/user.dart';

const baseUrl = "http://localhost:8080/api";

class UserApi {
  static Future postUser(User datas) {
    return http.post(
      Uri.parse("$baseUrl/users"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        datas,
      ),
    );
  }
}
