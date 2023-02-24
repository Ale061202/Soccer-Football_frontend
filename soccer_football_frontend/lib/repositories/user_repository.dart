import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:soccer_football_frontend/config/locator.dart';
import 'package:soccer_football_frontend/models/models.dart';
import 'package:soccer_football_frontend/rest/rest.dart';

@Order(-1)
@singleton
class UserRepository {

  late RestAuthenticatedClient _client;

  UserRepository() {
    _client = getIt<RestAuthenticatedClient>();
  }

  Future<dynamic> me() async {
    String url = "/me";

    var jsonResponse = await _client.get(url);
    return UserResponse.fromJson(jsonDecode(jsonResponse));

  }
}