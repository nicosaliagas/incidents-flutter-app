import 'dart:convert';

import 'package:my_app/src/core/api/user_api.dart';
import 'package:my_app/src/core/model/user.dart';

class UserRepository {
  Future<User> postIncidentUser(User datas) async {
    final response = await UserApi.postUser(datas);

    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to post user');
    }
  }
}