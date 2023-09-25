import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/src/core/model/user.dart';

const baseUrl = "http://localhost:8080/api";

class UserApi {
  static Future findUserByMail(String mail) {
    return http.get(
      Uri.parse("$baseUrl/users/mail/$mail"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

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

  static Future updateUser(User datas) {
    return http.put(
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
