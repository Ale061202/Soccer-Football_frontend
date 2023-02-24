import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:soccer_football_frontend/config/locator.config.dart';
import 'package:soccer_football_frontend/services/localstorage_service.dart';

export 'locator.config.dart';

final getIt = GetIt.instance;


@InjectableInit()
void configureDependencies() => getIt.init();

void setupAsyncDependencies() {
  //var localStorageService = await LocalStorageService.getInstance();
  //getIt.registerSingleton(localStorageService);
  getIt.registerSingletonAsync<LocalStorageService>(() => LocalStorageService.getInstance());
}