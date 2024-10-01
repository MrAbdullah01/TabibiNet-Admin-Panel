class UserchatModel {
  final String id;
  final String name;
  final String email;
  final String profileUrl;
  final String userUid;

  UserchatModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profileUrl,
    required this.userUid,
  });

  factory UserchatModel.fromMap(Map<String, dynamic> map) {
    return UserchatModel(
      id: map['userId'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      profileUrl: map['profileUrl'] ?? "",
      userUid: map['userUID'] ?? "",
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, image: $profileUrl}';
  }
}