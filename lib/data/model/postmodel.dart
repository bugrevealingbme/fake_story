

import 'package:fake_story/data/model/user_model.dart';

import 'categorymodel.dart';

class PostModel {
  int? id;
  UserModel? user;
  bool? isVideo;
  String? link;
  String? language;
  int? stream;
  String? title;
  List<UserModel>? like;
  List<CategoryModel>? category;
  List<UserModel>? favori;
  String? createdAt;

  PostModel(
      {this.id,
      this.user,
      this.isVideo,
      this.link,
      this.language,
      this.stream,
      this.title,
      this.like,
      this.category,
      this.favori,
      this.createdAt});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ?  UserModel.fromJson(json['user']) : null;
    isVideo = json['isVideo'];
    link = json['link'];
    language = json['language'];
    stream = json['stream'];
    title = json['title'];
    if (json['like'] != null) {
      like = <UserModel>[];
      json['like'].forEach((v) {
        like!.add( UserModel.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <CategoryModel>[];
      json['category'].forEach((v) {
        category!.add(CategoryModel.fromJson(v));
      });
    }
    if (json['favori'] != null) {
      favori = <UserModel>[];
      json['favori'].forEach((v) {
        favori!.add( UserModel.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['isVideo'] = isVideo;
    data['link'] = link;
    data['language'] = language;
    data['stream'] = stream;
    data['title'] = title;
    if (like != null) {
      data['like'] = like!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    if (favori != null) {
      data['favori'] = favori!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    return data;
  }
}




 
