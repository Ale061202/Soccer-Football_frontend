import 'package:soccer_football_frontend/repositories/authentication_repository.dart'
    as _i4;
import 'package:soccer_football_frontend/repositories/user_repository.dart'
    as _i5;
import 'package:soccer_football_frontend/rest/rest_client.dart' as _i3;
import 'package:soccer_football_frontend/services/authentication_service.dart'
    as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.RestAuthenticatedClient>(_i3.RestAuthenticatedClient());
    gh.singleton<_i3.RestClient>(_i3.RestClient());
    gh.singleton<_i4.AuthenticationRepository>(_i4.AuthenticationRepository());
    gh.singleton<_i5.UserRepository>(_i5.UserRepository());
    gh.singleton<_i6.JwtAuthenticationService>(_i6.JwtAuthenticationService());
    return this;
  }
}