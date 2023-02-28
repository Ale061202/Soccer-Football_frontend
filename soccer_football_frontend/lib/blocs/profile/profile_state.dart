import 'package:soccer_football_frontend/models/post.dart';

class ProfileState {
  final String username;
  final String biography;
  final List<Post> myPost;

  ProfileState({
    required this.username,
    required this.biography,
    required this.myPost,
  });

  copyWith({required String username, required String biography, required List<Post> myPost}) {}
}