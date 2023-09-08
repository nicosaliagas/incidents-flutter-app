class IncidentModel {
  final int id;
  final int category;
  final String description;
  final int userId;

  const IncidentModel({
    this.id = 0,
    required this.category,
    required this.description,
    required this.userId,
  });

  factory IncidentModel.fromJson(Map json) {
    return IncidentModel(
      id: json['id'],
      category: json['category'],
      description: json['description'],
      userId: json['userId'],
    );
  }

  Map toJson() {
    return {
      'id': id,
      'category': category,
      'description': description,
      'userId': userId,
    };
  }
}
