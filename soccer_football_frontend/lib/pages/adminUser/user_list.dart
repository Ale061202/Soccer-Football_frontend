import 'package:flutter/material.dart';
import 'package:soccer_football_frontend/models/models.dart';
import 'package:soccer_football_frontend/models/userAdmin.dart';
import 'package:soccer_football_frontend/pages/infoUser/info_details.dart';
import 'package:soccer_football_frontend/repositories/admin_repository.dart';
import 'package:soccer_football_frontend/repositories/post_repository.dart';

class UserListItem extends StatelessWidget {
  final User user;
  final PostRepository postRepository;
  final AdminRepository userAdminRepository;
  final InfoUser users;

  const UserListItem({
    Key? key,
    required this.user,
    required this.postRepository,
    required this.userAdminRepository,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: FutureBuilder<Image>(
          future: postRepository.getImage('${users.avatar}'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                width: 40,
                height: 40,
                child: CircleAvatar(
                  backgroundImage: snapshot.data!.image,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      title: Text('${users.username}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Posts:  ${users.posts == null ? 0 : users.posts!.length} '),
          if (users.roles!.contains('ADMIN')) const Text('Administrador'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    // ignore: prefer_const_constructors
                    title: Text(
                      "WARNING!",
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          color: Colors.redAccent, fontWeight: FontWeight.bold),
                    ),
                    content: Text("Are you sure you want to delete this user?"),
                    actions: [
                      TextButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text("Delete"),
                        onPressed: () {
                          userAdminRepository.deleteUserOrMe('${users.id}');
                          // Aquí iría el código para eliminar la publicación
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsUser(
                    details: users,
                    postRepository: postRepository,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}