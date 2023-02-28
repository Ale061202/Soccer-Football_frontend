import 'package:equatable/equatable.dart';

abstract class InfoAdminEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InfoAdminFetched extends InfoAdminEvent {}
