import 'package:equatable/equatable.dart';

abstract class InfoUserDetailEvent extends Equatable {
  const InfoUserDetailEvent();

  @override
  List<Object> get props => [];
}

class InfoUserDetailFetched extends InfoUserDetailEvent {
  const InfoUserDetailFetched(this.id);
  final String id;
}