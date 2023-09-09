import 'dart:convert';

import 'package:my_app/src/core/model/user.dart';

class IncidentModel {
  final int id;
  final int category;
  final String description;
  final User user;

  const IncidentModel({
    this.id = 0,
    required this.category,
    required this.description,
    required this.user,
  });

  factory IncidentModel.fromJson(Map datas) {
    return IncidentModel(
      id: datas['id'],
      category: datas['category'],
      description: datas['description'],
      user: User.fromJson(datas['user']),
    );
  }

  Map toJson() {
    return {
      'id': id,
      'category': category,
      'description': description,
      'user': user,
    };
  }
}
