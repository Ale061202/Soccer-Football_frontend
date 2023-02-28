import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:soccer_football_frontend/models/models.dart';
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

    var jsonResponse = await _client.post(
        url, LoginRequest(username: username, password: password));
    return User.fromJson(jsonDecode(jsonResponse));
  }
}