import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final String username;
  final String password;
  final String first_name;
  final String last_name;

  RegisterButtonPressed({required this.username, required this.password, required this.first_name, required this.last_name});

  @override
  List<Object> get props => [username, password, first_name, last_name];
}