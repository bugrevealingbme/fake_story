class UserModel {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  ProfileRelate? profileRelate;
  List<Following>? following;
  List<Followers>? followers;
  List<LikeRelated>? likeRelated;
  List<LikeRelated>? favoriRelated;
  List<LikeRelated>? userRelated;

  UserModel(
      {this.id,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.profileRelate,
      this.following,
      this.followers,
      this.likeRelated,
      this.favoriRelated,
      this.userRelated});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileRelate = json['profile_relate'] != null
        ? ProfileRelate.fromJson(json['profile_relate'])
        : null;
    if (json['following'] != null) {
      following = <Following>[];
      json['following'].forEach((v) {
        following!.add(Following.fromJson(v));
      });
    }
    if (json['followers'] != null) {
      followers = <Followers>[];
      json['followers'].forEach((v) {
        followers!.add(Followers.fromJson(v));
      });
    }
    if (json['like_related'] != null) {
      likeRelated = <LikeRelated>[];
      json['like_related'].forEach((v) {
        likeRelated!.add(LikeRelated.fromJson(v));
      });
    }
    if (json['favori_related'] != null) {
      favoriRelated = <LikeRelated>[];
      json['favori_related'].forEach((v) {
        favoriRelated!.add(LikeRelated.fromJson(v));
      });
    }
    if (json['user_related'] != null) {
      userRelated = <LikeRelated>[];
      json['user_related'].forEach((v) {
        userRelated!.add(LikeRelated.fromJson(v));
      });
    }
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
    if (following != null) {
      data['following'] = following!.map((v) => v.toJson()).toList();
    }
    if (followers != null) {
      data['followers'] = followers!.map((v) => v.toJson()).toList();
    }
    if (likeRelated != null) {
      data['like_related'] = likeRelated!.map((v) => v.toJson()).toList();
    }
    if (favoriRelated != null) {
      data['favori_related'] = favoriRelated!.map((v) => v.toJson()).toList();
    }
    if (userRelated != null) {
      data['user_related'] = userRelated!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileRelate {
  int? id;
  int? user;
  String? bio;
  String? website;
  bool? visible;
  bool? premium;

  ProfileRelate(
      {this.id, this.user, this.bio, this.website, this.visible, this.premium});

  ProfileRelate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    bio = json['bio'];
    website = json['website'];
    visible = json['visible'];
    premium = json['premium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user'] = user;
    data['bio'] = bio;
    data['website'] = website;
    data['visible'] = visible;
    data['premium'] = premium;
    return data;
  }
}

class Following {
  int? id;
  FollowingUserId? followingUserId;

  Following({this.id, this.followingUserId});

  Following.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    followingUserId = json['following_user_id'] != null
        ? FollowingUserId.fromJson(json['following_user_id'])
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

class FollowingUserId {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  ProfileRelate? profileRelate;

  FollowingUserId(
      {this.id,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.profileRelate});

  FollowingUserId.fromJson(Map<String, dynamic> json) {
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

class Followers {
  int? id;
  FollowingUserId? userId;

  Followers({this.id, this.userId});

  Followers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'] != null
        ? FollowingUserId.fromJson(json['user_id'])
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

class LikeRelated {
  int? id;
  String? link;
  String? title;
  bool? isVideo;

  LikeRelated({this.id, this.link, this.title, this.isVideo});

  LikeRelated.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    title = json['title'];
    isVideo = json['isVideo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['link'] = link;
    data['title'] = title;
    data['isVideo'] = isVideo;
    return data;
  }
}
