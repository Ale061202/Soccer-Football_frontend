import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:soccer_football_frontend/config/locator.dart';
import 'package:soccer_football_frontend/models/models.dart';
import 'package:soccer_football_frontend/repositories/repositories.dart';
import 'package:soccer_football_frontend/services/localstorage_service.dart';

abstract class AuthenticationService {
  Future<User?> getCurrentUser();
  Future<User> signInWithUserNameAndPassword(String username, String password);
  Future<void> signOut();
}

@Order(2)
@singleton
class JwtAuthenticationService extends AuthenticationService {
  late AuthenticationRepository _authenticationRepository;
  late LocalStorageService _localStorageService;
  late UserRepository _userRepository;

  JwtAuthenticationService() {
    _authenticationRepository = getIt<AuthenticationRepository>();
    _userRepository = getIt<UserRepository>();
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  @override
  Future<User?> getCurrentUser() async {
    print("get current user");
    String? token = _localStorageService.getFromDisk('user_token');
    print(token);
    if (token != null) {
      UserResponse response = await _userRepository.me();
      return response;
    }
    return null;
  }

  @override
  Future<User> signInWithUserNameAndPassword(
      String username, String password) async {
    User response = await _authenticationRepository.doLogin(username, password);
    await _localStorageService.saveToDisk('user_token', response.token);
    return User(
        avatar: response.avatar,
        username: response.username,
        email: response.email,
        phone: response.phone,
        birthday: response.birthday,
        posts: response.posts,
        roles: response.roles,
        id: response.id);
  }

  @override
  Future<void> signOut() async {
    print("borrando token");
    await _localStorageService.deleteFromDisk("user_token");
  }
}