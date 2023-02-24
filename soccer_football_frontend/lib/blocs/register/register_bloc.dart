import 'package:bloc/bloc.dart';
import 'package:soccer_football_frontend/blocs/authentication/authentication.dart';
import 'package:soccer_football_frontend/blocs/login/login.dart';
import 'package:soccer_football_frontend/blocs/register/register.dart';
import 'package:soccer_football_frontend/rest/rest_client.dart';
import 'package:soccer_football_frontend/services/services.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;

  RegisterBloc(AuthenticationBloc authenticationBloc, AuthenticationService authenticationService)
      : assert(authenticationBloc != null),
      assert(authenticationService != null),
      _authenticationBloc = authenticationBloc,
      _authenticationService = authenticationService,
      super(RegisterInitial()){
        on<RegisterButtonPressed>(__onRegisterButtonPressed);
      }

  __onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      final user = await _authenticationService.signUpWithAllData(event.username, event.password, event.first_name, event.last_name);
      if(user != null){
        _authenticationBloc.add(UserLoggedIn(user: user));
        emit(RegisterSuccess());
        emit(RegisterInitial());
      } else {
        emit(RegisterFailure(error: 'Something went wrong'));
      }
    } on AuthenticationException catch (e) {
      emit(RegisterFailure(error: e.message));
    } on CustomException catch(err){
      emit(RegisterFailure(error: 'An unknown error occurred ${err.message}'));
    } 
  }
}