import 'dart:convert';

import 'package:soccer_football_frontend/config/locator.dart';
import 'package:soccer_football_frontend/models/post.dart';
import 'package:soccer_football_frontend/rest/rest_client.dart';
import 'package:soccer_football_frontend/services/services.dart';
import 'package:http/http.dart' as http;

String url_base = "http://localhost:8080";

class SearchRepositories {
  // ignore: unused_field
  late RestAuthenticatedClient _client;
  late LocalStorageService _localStorageService;

  SearchRepositories() {
    _client = getIt<RestAuthenticatedClient>();
    _localStorageService = getIt<LocalStorageService>();
  }

  // ignore: unused_element
  Future<List<Post>> searchRepositories(String query) async {
    String? token = _localStorageService.getFromDisk('user_token');
    /*  String search = "/post/?s=tag:${query.toLowerCase()}";
*/
    String search = "/post/?s=tag:messi";
    final response = await http.get(
      Uri.parse(url_base + search),
      headers: {'Authorization': 'Bearer $token'},
    );

    print(response.statusCode);

    return PostResponse.fromJson(jsonDecode(response.body)).content
        as List<Post>;
  }
}