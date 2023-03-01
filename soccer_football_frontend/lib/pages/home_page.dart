import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_football_frontend/blocs/authentication/authentication.dart';
import 'package:soccer_football_frontend/blocs/bottomNavigator/bottom_navigator_bloc.dart';
import 'package:soccer_football_frontend/blocs/infoAdmin/info_admin_bloc.dart';
import 'package:soccer_football_frontend/blocs/infoAdmin/info_admin_event.dart';
import 'package:soccer_football_frontend/blocs/photo/photo_bloc.dart';
import 'package:soccer_football_frontend/blocs/photo/route/generate_route.dart';
import 'package:soccer_football_frontend/blocs/photo/route/route_name.dart';
import 'package:soccer_football_frontend/blocs/post/post_bloc.dart';
import 'package:soccer_football_frontend/blocs/post/post_state.dart';
import 'package:soccer_football_frontend/config/locator.dart';
import 'package:soccer_football_frontend/models/models.dart';
import 'package:soccer_football_frontend/pages/login_page.dart';
import 'package:soccer_football_frontend/pages/posts/post_page.dart';
import 'package:soccer_football_frontend/pages/profile_page.dart';
import 'package:soccer_football_frontend/repositories/admin_repository.dart';
import 'package:soccer_football_frontend/repositories/post_repository.dart';
import 'package:soccer_football_frontend/repositories/search_repository.dart';
import 'package:soccer_football_frontend/services/authentication_service.dart';

import 'adminUser/user_page.dart';

class HomePage extends StatefulWidget {
  final PostRepository postRepository;
  final SearchRepositories searchRepositories;
  final AdminRepository adminRepository;
  final User user;

  const HomePage(
      {required this.postRepository,
      required this.searchRepositories,
      required this.adminRepository,
      required this.user});
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BottomNavigationBloc _bottomNavigationBloc;
  int _selectedIndex = 0;

  @override
  void initState() {
    _bottomNavigationBloc = BottomNavigationBloc();
    super.initState();
  }

  @override
  void dispose() {
    _bottomNavigationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0
                    ? Colors.white
                    : Colors.grey),
            label: 'Home',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add,
                  color: _selectedIndex == 1
                    ? Colors.white
                    : Colors.grey),
              label: '',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite,
                  color: _selectedIndex == 2
                    ? Colors.white
                    : Colors.grey),
              label: 'Fav',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: _selectedIndex == 3
                    ? Colors.white
                    : Colors.grey),
              label: 'Profile',
              backgroundColor: Colors.green),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _bottomNavigationBloc.setIndex(index);
        },
      ),
      body: StreamBuilder<int>(
        stream: _bottomNavigationBloc.indexStream,
        initialData: 0,
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case 0:
              return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    title: Text('Soccer & Football',
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                  ),
                  body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      if (state is AuthenticationAuthenticated) {
                        return BlocProvider(
                            create: (_) => PostBloc(widget.postRepository)
                              ..add(PostFetched()),
                            child: PostList(
                              user: state.user,
                            ));
                      } else {
                        return LoginPage();
                      }
                    },
                  ));
            case 1:
              return BlocProvider(
                create: (_) => PhotoBloc(),
                child: MaterialApp(
                  initialRoute: routeHome,
                  onGenerateRoute: RouteGenerator.generateRoute,
                ),
              );
            case 2:
              return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    title: Text('Soccer & Football',
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                  ),
                  );
            case 3:
              return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationAuthenticated) {
                    return ProfileScreen(
                      user: state.user,
                      postRepository: PostRepository(),
                      adminRepository: AdminRepository(),
                    );
                  } else {
                    return LoginPage();
                  }
                },
              );
            case 4:
              return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    title: Text('Soccer & Football',
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                  ),
                  body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      if (state is AuthenticationAuthenticated) {
                        return BlocProvider(
                            create: (_) => InfoAdminBloc(widget.adminRepository)
                              ..add(InfoAdminFetched()),
                            child: UserList(user: state.user));
                      } else {
                        return LoginPage();
                      }
                    },
                  ));
            default:
              return Container();
          }
        },
      ),
    );
  }
}