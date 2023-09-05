class Category {
  final int id;
  final String name;

  const Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }

  Map toJson() {
    return {'id': id, 'name': name};
  }
}
