import 'dart:io';

import 'package:flutter/material.dart';
import 'package:soccer_football_frontend/blocs/photo/route/route_name.dart';
import 'package:soccer_football_frontend/pages/newPost/new_page.dart';

import '../../../pages/newPost/edit_Page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeEdit:
        //default: // else
        return MaterialPageRoute(
            builder: (_) => EditPhotoPage(
                  image: settings.arguments as File,
                ));
      //break;
      //case routeHome:
      default:
        return MaterialPageRoute(builder: (_) => const NewPost());
      //break;
    }
  }
}