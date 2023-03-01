import 'dart:convert';

import 'package:soccer_football_frontend/models/register.dart';
import 'package:http/http.dart' as http;

String url_base = "http://localhost:8080/auth/register/user";

class RegisterRepository {


  Future<http.Response> doRegister(String username, String email, String phone,
      String password, String avatar, String first_name, String last_name, String birthday) async {
    final response = await http.post(Uri.parse(url_base),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'NoAuth'
        },
        body: jsonEncode(RegisterRequest(
          username: username,
          email: email,
          password: password,
          phone: phone,
          first_name: first_name,
          last_name: last_name,
          avatar: avatar,
          birthday: birthday
        )));
    print(response.body);
    return response;
  }
}