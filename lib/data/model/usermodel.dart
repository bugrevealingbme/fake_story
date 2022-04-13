
import 'followModel.dart';
import 'profilemodel.dart';
class UserModel{
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  ProfileRelate? profileRelate;
  List<Following>? following;
  List<Followers>? followers;
  List<MiniPost>? likeRelated;
  List<MiniPost>? favoriRelated;
  List<MiniPost>? postRelated;
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
      this.postRelated});

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
      likeRelated = <MiniPost>[];
      json['like_related'].forEach((v) {
        likeRelated!.add(MiniPost.fromJson(v));
      });
    }
    if (json['favori_related'] != null) {
      favoriRelated = <MiniPost>[];
      json['favori_related'].forEach((v) {
        favoriRelated!.add(MiniPost.fromJson(v));
      });
    }
    if (json['post_related'] != null) {
      postRelated = <MiniPost>[];
      json['post_related'].forEach((v) {
        postRelated!.add(MiniPost.fromJson(v));
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
      data['favori_related'] =
          favoriRelated!.map((v) => v.toJson()).toList();
    }
    if (postRelated != null) {
      data['post_related'] = postRelated!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class MiniPost {
  int? id;
  String? link;
  String? title;
  bool? isVideo;

  MiniPost({this.id, this.link, this.title, this.isVideo});

  MiniPost.fromJson(Map<String, dynamic> json) {
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