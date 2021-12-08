import 'dart:io';

class User {
  String id = "";
  String name = "";

  ///URL
  String urlProfilePhoto = "";
  File? profilePhoto;

  User(this.id, this.name, this.urlProfilePhoto);
  User.newUser();
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'];
    urlProfilePhoto = json['profilePhoto'];
  }
}
