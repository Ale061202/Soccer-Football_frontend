class RegisterRequest {
  String? username;
  String? email;
  String? phone;
  String? password;
  String? avatar;
  String? first_name;
  String? last_name;
  String? birthday;

  RegisterRequest({
    this.username,
    this.email,
    this.phone,
    this.password,
    this.avatar,
    this.birthday,
    this.first_name,
    this.last_name
  });

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    avatar = json['avatar'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    birthday = json['birthday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['avatar'] = avatar;
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    data['birthday'] = birthday;
    return data;
  }
}