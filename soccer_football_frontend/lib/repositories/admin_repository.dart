import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soccer_football_frontend/config/locator.dart';
import 'package:soccer_football_frontend/models/userAdmin.dart';
import 'package:soccer_football_frontend/rest/rest_client.dart';
import 'package:soccer_football_frontend/services/services.dart';

// ignore: non_constant_identifier_names
String url_base = "http://localhost:8080";

class AdminRepository {
  late RestAuthenticatedClient _client;
  late LocalStorageService _localStorageService;

  AdminRepository() {
    _client = getIt<RestAuthenticatedClient>();
    _localStorageService = getIt<LocalStorageService>();
  }

  Future<UserAdmin> fecthUsers([int _startIndex = 0]) async {
    String page = "/user/?page=${_startIndex}";

    String? token = _localStorageService.getFromDisk('user_token');

    final response = await http.get(
      Uri.parse(url_base + page),
      headers: {'Authorization': 'Bearer $token'},
    );
    return UserAdmin.fromJson(jsonDecode(response.body));
  }

  Future<InfoUser> fecthUsersInfo(String uuid) async {
    String url = "/info/user/${uuid}";

    String? token = _localStorageService.getFromDisk('user_token');

    final response = await http.get(
      Uri.parse(url_base + url),
      headers: {'Authorization': 'Bearer $token'},
    );
    return InfoUser.fromJson(jsonDecode(response.body));
  }

  Future<dynamic> banUser(String uuid) async {
    String url = "/banUserByAdmin/${uuid}";

    String? token = _localStorageService.getFromDisk('user_token');

    final response = await http.post(
      Uri.parse(url_base + url),
      headers: {'Authorization': 'Bearer $token'},
    );
    print(response.statusCode);
  }

  Future<dynamic> changeRole(String uuid) async {
    String url = "/changeRole/${uuid}";

    String? token = _localStorageService.getFromDisk('user_token');

    final response = await http.post(
      Uri.parse(url_base + url),
      headers: {'Authorization': 'Bearer $token'},
    );
    print(response.statusCode);
  }

  Future<dynamic> deleteUserOrMe(String uuid) async {
    String url = "/user/$uuid";
    String? token = _localStorageService.getFromDisk('user_token');

    final response = await http.delete(Uri.parse(url_base + url), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json, text/plain'
    });
    print(response.statusCode);
  }
}