import 'package:uuid/uuid.dart';

class User {
  String id = "";
  String name = "";
  String profilePhoto = "";

  User(this.id, this.name, this.profilePhoto);
  User.newUser();
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'];
    profilePhoto = json['profilePhoto'];
  }

  Map<String, dynamic> toJson() => {
        'id': id != "" ? id : Uuid().v1(),
        'name': name,
        'profilePhoto': profilePhoto
      };
}
