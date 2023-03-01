import 'package:flutter/material.dart';
import 'package:soccer_football_frontend/models/login.dart';

class User {
  String? id;
  String? username;
  String? avatar;
  String? first_name;
  String? last_name;
  String? phone;
  String? email;
  String? token;
  List<Posts>? posts;

  User(
      {this.id,
      this.username,
      this.avatar,
      this.first_name,
      this.last_name,
      this.email,
      this.phone,
      this.token,
      this.posts}
  );

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    avatar = json['avatar'];
    phone = json['phone'];
    if (json['myPost'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['phone'] = this.phone;
    if (this.posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    data['token'] = this.token;
    return data;
  }  
}

class UserResponse extends User {
  UserResponse(id, username, first_name, last_name, avatar, birthday, phone, token, email, posts, roles)
      : super(
            id: id,
            username: username,
            first_name: first_name,
            last_name: last_name,
            avatar: avatar,
            phone: phone,
            token: token,
            email: email,
            posts: posts,
          );

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    posts = (json['posts'] as List<dynamic>)
        .map((e) => Posts.fromJson(e))
        .toList();
    avatar = json['avatar'];
    token = json['token'];
  }
 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['posts'] = posts;
    data['avatar'] = avatar;
    data['token'] = token;
    return data;
  }
}

class Posts {
  int? id;
  String? title;
  String? image;
  String? date;
  String? author;
  List<Commentaries>? commentaries;

  Posts(
      {this.id,
      this.image,
      this.date,
      this.author,
      this.title,
      this.commentaries});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    date = json['date'];
    author = json['author'];  
    if (json['commentaries'] != null) {
      commentaries = <Commentaries>[];
      json['commentaries'].forEach((v) {
        commentaries!.add(new Commentaries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['date'] = this.date;
    data['author'] = this.author;
    data['title'] = this.title;
    if (this.commentaries != null) {
      data['commentaries'] = this.commentaries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Commentaries {
  String? message;
  String? user;
  String? date;

  Commentaries({this.message, this.user, this.date  });

  Commentaries.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user'] = this.user;
    data['date'] = this.date;
    return data;
  }
}




