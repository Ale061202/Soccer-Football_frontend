import 'package:soccer_football_frontend/models/login.dart';

class User {
  String ? id;
  String ? username;
  String ? avatar;
  String ? first_name;
  String ? last_name;

  User({this.id, this.username, this.avatar, this.first_name, this.last_name});

    User.fromLoginResponse(LoginResponse response) {
      this.id = response.id;
      this.username = response.username;
      this.avatar = response.avatar;
      this.first_name = response.first_name;
      this.last_name = response.last_name;
    }
}

class UserResponse extends User {

  UserResponse(id, username, first_name, last_name, avatar) : super(id: id, username: username, first_name: first_name, last_name: last_name, avatar: avatar);

  UserResponse.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  username = json['username'];
  avatar = json['avatar'];
  first_name = json['first_name'];
  last_name = json['last_name'];
}
  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['username'] = this.username;
  data['avatar'] = this.avatar;
  data['first_name'] = this.first_name;
  data['last_name'] = this.last_name;
  return data;
}

}
