import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_football_frontend/blocs/photo/photo_bloc.dart';
import 'package:soccer_football_frontend/blocs/photo/route/route_name.dart';
import 'package:image_picker/image_picker.dart';


class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  late File _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[              
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  filled: true,
                  isDense: true,
                ),
                maxLines: 5,
                maxLength: 200,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required.';
                  }
                  return null;
                },
              ),
              /*const SizedBox(height: 12),
              BlocBuilder<PhotoBloc, PhotoState>(
                bloc: BlocProvider.of<PhotoBloc>(context),
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      _showSelectionDialog();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: state is PhotoInitial
                          ? Icon(Icons.camera_alt_outlined, size: 50)
                          : Image.file((state as PhotoSet).photo,
                              fit: BoxFit.cover),
                    ),
                  );
                },
              ),*/
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Colors.white,
                ),
                onPressed: () {},
                child: Text('Add Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future selectOrTakePhoto(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // ignore: unnecessary_cast
        Navigator.pushNamed(context, routeEdit, arguments: _image);
      } else
        print('No photo was selected or taken');
    });
  }

  Future _showSelectionDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: Text('Select photo'),
        children: <Widget>[
          SimpleDialogOption(
            child: Text('From gallery'),
            onPressed: () {
              selectOrTakePhoto(ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
          SimpleDialogOption(
            child: Text('Take a photo'),
            onPressed: () {
              selectOrTakePhoto(ImageSource.camera);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}