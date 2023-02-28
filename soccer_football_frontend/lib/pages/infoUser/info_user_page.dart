import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_football_frontend/blocs/infoUser/info_user_bloc.dart';
import 'package:soccer_football_frontend/blocs/infoUser/info_user_event.dart';
import 'package:soccer_football_frontend/pages/infoUser/details.dart';
import 'package:soccer_football_frontend/repositories/admin_repository.dart';

class InfoUserPage extends StatelessWidget {
  const InfoUserPage({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final adminRepository = AdminRepository();
        return InfoUserDetailsBloc(adminRepository)
          ..add(InfoUserDetailFetched(id));
      },
      child: UserInfoDetailsL(),
    );
  }
}