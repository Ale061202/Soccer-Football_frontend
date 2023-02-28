class UserAdmin {
  List<InfoUser>? content;
  int? totalPages;

  UserAdmin({this.content, this.totalPages});

  UserAdmin.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <InfoUser>[];
      json['content'].forEach((v) {
        content!.add(new InfoUser.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class InfoUser {
  String? id;
  String? username;
  String? createdAt;
  String? avatar;
  String? birthday;
  bool? enabled;
  List<String>? roles;
  List<Posts>? posts;

  InfoUser(
      {this.id,
      this.username,
      this.createdAt,
      this.avatar,
      this.birthday,
      this.enabled,
      this.roles,
      this.posts});

  InfoUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    createdAt = json['createdAt'];
    avatar = json['avatar'];
    birthday = json['birthday'];
    enabled = json['enabled'];
    roles = json['roles'].cast<String>();
    if (json['myPost'] != null) {
      posts = <Posts>[];
      json['myPost'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['createdAt'] = this.createdAt;
    data['avatar'] = this.avatar;
    data['birthday'] = this.birthday;
    data['enabled'] = this.enabled;
    data['roles'] = this.roles;
    if (this.posts != null) {
      data['myPost'] = this.posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
  Posts();

  // ignore: empty_constructor_bodies
  Posts.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}