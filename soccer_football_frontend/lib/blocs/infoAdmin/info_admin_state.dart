import 'package:equatable/equatable.dart';
import 'package:soccer_football_frontend/models/userAdmin.dart';

enum InfoAdminStatus { initial, success, failure }

class InfoAdminState extends Equatable {
  const InfoAdminState({
    this.status = InfoAdminStatus.initial,
    this.users = const <InfoUser>[],
    this.hasReachedMax = false,
  });

  final InfoAdminStatus status;
  final List<InfoUser> users;
  final bool hasReachedMax;

  InfoAdminState copyWith({
    InfoAdminStatus? status,
    List<InfoUser>? users,
    bool? hasReachedMax,
  }) {
    return InfoAdminState(
      status: status ?? this.status,
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''UsersState { status: $status, hasReachedMax: $hasReachedMax, posts: ${users.length} }''';
  }

  @override
  List<Object> get props => [status, users, hasReachedMax];
}