import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:soccer_football_frontend/blocs/infoAdmin/info_admin_bloc.dart';
import 'package:soccer_football_frontend/blocs/infoAdmin/info_admin_event.dart';
import 'package:soccer_football_frontend/blocs/infoAdmin/info_admin_state.dart';
import 'package:soccer_football_frontend/models/models.dart';
import 'package:soccer_football_frontend/pages/adminUser/user_list.dart';
import 'package:soccer_football_frontend/pages/posts/view.dart';
import 'package:soccer_football_frontend/repositories/admin_repository.dart';
import 'package:soccer_football_frontend/repositories/post_repository.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final _postRepository = PostRepository();
  final _adminRepository = AdminRepository();
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoAdminBloc, InfoAdminState>(
      builder: (context, state) {
        switch (state.status) {
          case InfoAdminStatus.failure:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Icon(Icons.person_2, size: 50),
                  const SizedBox(height: 20),
                  const Text(
                    'You do not have any users',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            );
          case InfoAdminStatus.success:
            if (state.users.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(child: Text('Any posts found!')),
                ],
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.users.length
                    ? const BottomLoader()
                    : UserListItem(
                        users: state.users[index],
                        postRepository: _postRepository,
                        userAdminRepository: _adminRepository,
                        user: widget.user,
                      );
              },
              scrollDirection: Axis.vertical,
              itemCount: state.hasReachedMax
                  ? state.users.length
                  : state.users.length + 1,
              controller: _scrollController,
            );
          case InfoAdminStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<InfoAdminBloc>().add(InfoAdminFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}