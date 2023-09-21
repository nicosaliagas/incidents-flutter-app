import 'dart:convert';

import 'package:my_app/src/core/api/user_api.dart';
import 'package:my_app/src/core/model/user.dart';

class UserRepository {
  Future<User> postUser(User datas) async {
    final response = await UserApi.postUser(datas);

    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw json.decode(response.body);
    }
  }
}
