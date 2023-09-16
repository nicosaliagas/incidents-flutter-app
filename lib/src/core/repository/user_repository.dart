import 'dart:convert';

import 'package:my_app/src/core/api/user_api.dart';
import 'package:my_app/src/core/model/user.dart';

class UserRepository {
  Future<User> postUser(User datas) async {
    final response = await UserApi.postUser(datas);

    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      //return json.decode(response);
      //return response;
      throw json.decode(response.body);

      /*print('Erreur HTTP: ${jsonc['mail']}');

      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(json.decode(response.body));*/
    }
  }
}
