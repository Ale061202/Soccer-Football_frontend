import 'package:soccer_football_frontend/models/models.dart';

abstract class AuthenticationService {
  Future<User?> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

