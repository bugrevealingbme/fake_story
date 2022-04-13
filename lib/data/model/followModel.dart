
import 'profilemodel.dart';
class Following {
  int? id;
  UserMini? followingUserId;

  Following({this.id, this.followingUserId});

  Following.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    followingUserId = json['following_user_id'] != null
        ? UserMini.fromJson(json['following_user_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (followingUserId != null) {
      data['following_user_id'] = followingUserId!.toJson();
    }
    return data;
  }
}

class Followers {
  int? id;
  UserMini? userId;

  Followers({this.id, this.userId});

  Followers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'] != null
        ? UserMini.fromJson(json['user_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (userId != null) {
      data['user_id'] = userId!.toJson();
    }
    return data;
  }
}


class UserMini {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  ProfileRelate? profileRelate;

  UserMini(
      {this.id,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.profileRelate});

  UserMini.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileRelate = json['profile_relate'] != null
        ? ProfileRelate.fromJson(json['profile_relate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    if (profileRelate != null) {
      data['profile_relate'] = profileRelate!.toJson();
    }
    return data;
  }
}