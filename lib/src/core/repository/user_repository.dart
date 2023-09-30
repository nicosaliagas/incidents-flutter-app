import 'dart:convert';

import 'package:my_app/config/constants/http_constant.dart';
import 'package:my_app/src/core/api/user_api.dart';
import 'package:my_app/src/core/model/user.dart';

class UserRepository {
  UserApi userApi = UserApi();

  Future<User?> findUserByEmail(String mail) async {
    final response = await userApi.findUserByMail(mail);

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
    final response = await userApi.postUser(datas);

    if (response.statusCode == statusCode['HTTP_CREATED']) {
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

  Future<User> putUser(User datas) async {
    final response = await userApi.updateUser(datas);

    if (response.statusCode == statusCode['HTTP_SUCCEED']) {
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
