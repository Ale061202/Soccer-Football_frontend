import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:soccer_football_frontend/blocs/infoAdmin/info_admin_event.dart';
import 'package:soccer_football_frontend/blocs/infoAdmin/info_admin_state.dart';
import 'package:soccer_football_frontend/repositories/admin_repository.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(milliseconds: 100);
int page = -1;

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class InfoAdminBloc extends Bloc<InfoAdminEvent, InfoAdminState> {
 InfoAdminBloc(this._adminRepository) : super(const InfoAdminState()) {
    on<InfoAdminFetched>(
      _onUserInfoFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final AdminRepository _adminRepository;

  Future<void> _onUserInfoFetched(
      InfoAdminFetched event, Emitter<InfoAdminState> emitter) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == InfoAdminStatus.initial) {
        page = 0;
        final response = await _adminRepository.fecthUsers(page);
        final users = response;
        return emitter(state.copyWith(
          status: InfoAdminStatus.success,
          users: users.content,
          hasReachedMax: response.totalPages! - 1 <= page,
        ));
      }
      page += 1;
      final response = await _adminRepository.fecthUsers(page);
      final users = response;

      emitter(state.copyWith(
          status: InfoAdminStatus.success,
          users: List.of(state.users)..addAll(users.content!),
          hasReachedMax: response.totalPages! - 1 <= page));
    } catch (_) {
      emitter(state.copyWith(status: InfoAdminStatus.failure));
    }
  }
}