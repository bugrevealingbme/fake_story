class TokenModel {
  String? refresh;
  String? access;

  TokenModel({this.refresh, this.access});

  TokenModel.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['refresh'] = refresh;
    data['access'] = access;
    return data;
  }
}
