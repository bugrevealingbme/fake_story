import 'package:fake_story/data/model/postmodel.dart';

class CategoryGetModel {
  int? id;
  String? title;
  int? stream;
  String? language;
  String? createdAt;
  List<PostModel>? categoryRelated;

  CategoryGetModel(
      {this.id,
      this.title,
      this.stream,
      this.language,
      this.createdAt,
      this.categoryRelated});

  CategoryGetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    stream = json['stream'];
    language = json['language'];
    createdAt = json['created_at'];
    if (json['category_related'] != null) {
      categoryRelated = <PostModel>[];
      json['category_related'].forEach((v) {
        categoryRelated!.add(PostModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['stream'] = this.stream;
    data['language'] = this.language;
    data['created_at'] = this.createdAt;
    if (this.categoryRelated != null) {
      data['category_related'] =
          this.categoryRelated!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

