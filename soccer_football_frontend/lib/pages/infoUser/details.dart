import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_football_frontend/blocs/infoUser/info_user_bloc.dart';
import 'package:soccer_football_frontend/blocs/infoUser/info_user_state.dart';
import 'package:soccer_football_frontend/pages/infoUser/info_details.dart';
import 'package:soccer_football_frontend/repositories/post_repository.dart';

class UserInfoDetailsL extends StatefulWidget {
  UserInfoDetailsL({super.key});

  @override
  State<UserInfoDetailsL> createState() => _UserInfoDetailsState();
}

class _UserInfoDetailsState extends State<UserInfoDetailsL> {
  final postRepository = PostRepository();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoUserDetailsBloc, InfoUserDetailState>(
      builder: (context, state) {
        switch (state.status) {
          case InfoUserDetailStatus.failure:
            return const Center(child: Text('failed to fetch details of user'));
          case InfoUserDetailStatus.success:
            if (state.status.toString().isEmpty) {
              return const Center(
                  child: Text('No exists details like this user'));
            }
            return DetailsUser(
              details: state.userDetails!,
              postRepository: postRepository,
            );
          case InfoUserDetailStatus.initial:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}