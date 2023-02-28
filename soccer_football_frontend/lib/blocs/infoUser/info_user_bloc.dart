import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:soccer_football_frontend/blocs/infoUser/info_user_event.dart';
import 'package:soccer_football_frontend/blocs/infoUser/info_user_state.dart';
import 'package:soccer_football_frontend/models/userAdmin.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../repositories/admin_repository.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class InfoUserDetailsBloc
    extends Bloc<InfoUserDetailEvent, InfoUserDetailState> {
  final AdminRepository _adminRepository;
  InfoUserDetailsBloc(AdminRepository _adminRepository)
      : assert(_adminRepository != null),
        _adminRepository = _adminRepository,
        super(const InfoUserDetailState()) {
    on<InfoUserDetailFetched>(
      _onUserInfoDetailFetched,
    );
  }

  Future<void> _onUserInfoDetailFetched(
    InfoUserDetailFetched event,
    Emitter<InfoUserDetailState> emit,
  ) async {
    if (state.props.isEmpty) return;
    try {
      if (state.status == InfoUserDetailStatus.initial) {
        // ignore: unused_local_variable
        final usersInfoDetails =
            await _adminRepository.fecthUsersInfo(event.id);
        return emit(state.copyWith(
            userDetails: usersInfoDetails,
            status: InfoUserDetailStatus.success));
      }
    } catch (_) {
      emit(state.copyWith(status: InfoUserDetailStatus.failure));
    }
  }
}