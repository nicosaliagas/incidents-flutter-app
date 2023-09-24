import 'dart:convert';

import 'package:my_app/config/constants/http_constant.dart';
import 'package:my_app/src/core/api/user_api.dart';
import 'package:my_app/src/core/model/user.dart';

class UserRepository {
  Future<User?> findUserByEmail(String mail) async {
    final response = await UserApi.findUserByMail(mail);

    // TODO: fichier de const
    // 200 : ok
    // 201 : created

    if (response.statusCode == statusCode['HTTP_SUCCEED']) {
      if (json.decode(response.body) != null) {
        return User.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } else {
      dynamic message;

      try {
        message = json.decode(response.body);
      } catch (e) {
        message = response.body;
      } finally {
        throw message;
      }
    }
  }

  Future<User> postUser(User datas) async {
    final response = await UserApi.postUser(datas);

    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      dynamic message;

      try {
        message = json.decode(response.body);
      } catch (e) {
        message = response.body;
      } finally {
        throw message;
      }
    }
  }
}
