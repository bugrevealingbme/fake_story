class CategoryModel {
  int? id;
  String? title;
  int? stream;
  String? language;
  String? createdAt;

  CategoryModel(
      {this.id, this.title, this.stream, this.language, this.createdAt});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    stream = json['stream'];
    language = json['language'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['stream'] = stream;
    data['language'] = language;
    data['created_at'] = createdAt;
    return data;
  }
}
