class UserchatModel {
  final String id;
  final String name;
  final String email;
  final String profileUrl;
  final String userUid;
  final bool isOnline; // New field for online status

  UserchatModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profileUrl,
    required this.userUid,
    this.isOnline = false, // Default to false

  });

  factory UserchatModel.fromMap(Map<String, dynamic> map) {
    return UserchatModel(
      id: map['userId'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      profileUrl: map['profileUrl'] ?? "",
      userUid: map['userUID'] ?? "",
      isOnline: map['userStatus'] ?? "",
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, image: $profileUrl, userUid: $userUid, isOnline: $isOnline}';
  }
}