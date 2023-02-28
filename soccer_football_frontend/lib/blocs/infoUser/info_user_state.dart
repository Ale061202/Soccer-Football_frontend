import 'package:equatable/equatable.dart';
import 'package:soccer_football_frontend/models/userAdmin.dart';

enum InfoUserDetailStatus { initial, success, failure }

class InfoUserDetailState extends Equatable {
  const InfoUserDetailState(
      {this.status = InfoUserDetailStatus.initial, this.userDetails});

  final InfoUserDetailStatus status;
  final InfoUser? userDetails;

  InfoUserDetailState copyWith({
    InfoUserDetailStatus? status,
    InfoUser? userDetails,
  }) {
    return InfoUserDetailState(
        status: status ?? this.status,
        userDetails: userDetails ?? this.userDetails);
  }

  @override
  String toString() {
    return '''UserInfoDetailState { status: $status }''';
  }

  @override
  List<Object> get props => [status];
}