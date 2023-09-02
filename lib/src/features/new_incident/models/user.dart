class User {
  final int id;
  final String firstName;
  final String lastName;
  final String mail;
  final String phone;

  const User({
    this.id = 0,
    required this.firstName,
    required this.lastName,
    required this.mail,
    required this.phone,
  });

  factory User.fromJson(Map json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      mail: json['mail'],
      phone: json['phone'],
    );
  }

  Map toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'mail': mail,
      'phone': phone,
    };
  }
}
