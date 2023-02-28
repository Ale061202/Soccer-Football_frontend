import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:soccer_football_frontend/models/login.dart';
import 'package:soccer_football_frontend/rest/rest.dart';
import 'dart:convert';


@Order(-1)
@singleton
class AuthenticationRepository {

  late RestClient _client;

  AuthenticationRepository() {
    _client = GetIt.I.get<RestClient>();
    //_client = RestClient();
  }

  Future<dynamic> doLogin(String username, String password) async {
    String url = "/auth/login";

    var jsonResponse = await _client.post(url, LoginRequest(username: username, password: password));
    return LoginResponse.fromJson(jsonDecode(jsonResponse));

  }

  Future<dynamic> doSignUp(String username,String password, String first_name, String last_name) async{
    String url = "/auth/register/user";

    var jsonResponse = await _client.post(url, SignUpRequest(username: username, password: password, first_name: first_name, last_name: last_name));
    return LoginResponse.fromJson(jsonDecode(jsonResponse));
  }
}