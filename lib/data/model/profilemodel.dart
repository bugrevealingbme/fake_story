class ProfileRelate {
  int? id;
  int? user;
  List<int>? block;
  String? profileimage;
  String? language;
  String? bio;
  String? website;
  bool? visible;
  bool? premium;

  ProfileRelate(
      {this.id,
      this.user,
      this.block,
      this.profileimage,
      this.language,
      this.bio,
      this.website,
      this.visible,
      this.premium});

  ProfileRelate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    block = json['block'].cast<int>();
    profileimage = json['profileimage'];
    language = json['language'];
    bio = json['bio'];
    website = json['website'];
    visible = json['visible'];
    premium = json['premium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user'] = user;
    data['block'] = block;
    data['profileimage'] = profileimage;
    data['language'] = language;
    data['bio'] = bio;
    data['website'] = website;
    data['visible'] = visible;
    data['premium'] = premium;
    return data;
  }
}