import 'profilemodel.dart';
class UserModel {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  ProfileRelate? profileRelate;

  UserModel(
      {this.id,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.profileRelate});

  UserModel.fromJson(Map<String, dynamic> json) {
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

