import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:my_app/src/core/api/error_interceptor.dart';
import 'package:my_app/src/core/model/user.dart';

const baseUrl = "http://localhost:8080/api";

class UserApi {
  InterceptedClient client = InterceptedClient.build(interceptors: [
    ErrorInterceptor(),
  ]);

  Future findUserByMail(String mail) {
    return client.get(
      Uri.parse("$baseUrl/users/mail/$mail"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future postUser(User datas) {
    return client.post(
      Uri.parse("$baseUrl/users"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        datas,
      ),
    );
  }

  Future updateUser(User datas) {
    return client.put(
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
