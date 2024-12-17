class UserModel {
  final String name;
  final String email;
  final String panCard;

  UserModel({required this.name, required this.email, required this.panCard});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'panCard': panCard,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      panCard: map['panCard'],
    );
  }
}
