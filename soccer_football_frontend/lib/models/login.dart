class LoginResponse {
  String? id;
  String? username;
  String? first_name;
  String? last_name;
  String? createdAt;
  String? avatar;
  String? token;
  String? refreshToken;

  LoginResponse(
      {this.id,
      this.username,
      this.first_name,
      this.last_name,
      this.createdAt,
      this.avatar,
      this.token,
      this.refreshToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    createdAt = json['createdAt'];
    avatar = json['avatar'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    data['token'] = token;
    data['avatar'] = avatar;
    data['refreshToken'] = refreshToken;
    return data;
  }
  
}


class LoginRequest {
  String? username;
  String? password;

  LoginRequest({this.username, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}

class SignUpRequest {
  String? username;
  String? password;
  String? first_name;
  String? last_name;

  SignUpRequest({this.username, this.password, this.first_name, this.last_name});

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    first_name = json['first_name'];
    last_name = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    return data;
  }
}