import 'dart:convert';

import 'package:my_app/src/core/api/category_api.dart';
import 'package:my_app/src/core/model/category.dart';

class CategoryRepository {
  CategoryApi categoryApi = CategoryApi();

  Future<List<Category>> fetchIncidentCategories() async {
    final response = await categoryApi.getCategories();

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Iterable list = json.decode(response.body);

      return list.map((model) => Category.fromJson(model)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load incident categories');
    }
  }
}
