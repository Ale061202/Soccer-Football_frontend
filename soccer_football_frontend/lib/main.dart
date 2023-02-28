import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_football_frontend/blocs/authentication/authentication.dart';
import 'package:soccer_football_frontend/config/locator.dart';
import 'package:soccer_football_frontend/pages/home_page.dart';
import 'package:soccer_football_frontend/pages/login_page.dart';
import 'package:soccer_football_frontend/repositories/admin_repository.dart';
import 'package:soccer_football_frontend/repositories/post_repository.dart';
import 'package:soccer_football_frontend/repositories/search_repository.dart';
import 'package:soccer_football_frontend/services/services.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //await SharedPreferences.getInstance();
  setupAsyncDependencies();
  configureDependencies();
  //await getIt.allReady();

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      //GlobalContext.ctx = context;
      final authService = getIt<JwtAuthenticationService>();
      return AuthenticationBloc(authService)..add(AppLoaded());
    },
    child: MyApp(),
  ));
}

class GlobalContext {
  static late BuildContext ctx;
}

class MyApp extends StatelessWidget {
  //static late  AuthenticationBloc _authBloc;

  static late MyApp _instance;

  static Route route() {
    print("Enrutando al login");
    return MaterialPageRoute<void>(builder: (context) {
      var authBloc = BlocProvider.of<AuthenticationBloc>(context);
      authBloc..add(SessionExpiredEvent());
      return _instance;
    });
  }

  MyApp() {
    _instance = this;
  }

  @override
  Widget build(BuildContext context) {
    //GlobalContext.ctx = context;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Authentication Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            GlobalContext.ctx = context;
            if (state is AuthenticationAuthenticated) {
              // show home page with authenticated user
              return HomePage(
                postRepository: PostRepository(),
                searchRepositories: SearchRepositories(),
                adminRepository: AdminRepository(),
                user: state.user, // pass authenticated user
              );
            }
            return LoginPage();
          },
        )
        );
  }
}