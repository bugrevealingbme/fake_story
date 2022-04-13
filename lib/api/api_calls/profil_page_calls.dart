import 'package:dio/dio.dart';
import 'package:fake_story/data/model/tokenmodel.dart';

import '../../data/model/usermodel.dart';
import '../../utils/shared_prefs_ext.dart';

class ProfilCalss {
  static String BASEURL = "http://185.174.61.27:8888/";
  static Future<UserModel> userInformations() async {
    // shared pref ten token cekilecek burada
    var token = await CustomSharedPref.readStringDataToLanguage("accessToken");
    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';
    response = await dio.get(BASEURL + "user/me/");
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    var user = UserModel.fromJson(response.data);
    return user;
  }

  static Future<bool> createToken(String username, String password) async {
    // ordering kullanımı -like like stream -stream created_at -created_at
    var dio = Dio();
    Response response;
    response = await dio.post(BASEURL + "user/token/",
        data: {"username": username, "password": password});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    if (response.statusCode == 200) {
      var tokenResponse = TokenModel.fromJson(response.data);

      await CustomSharedPref.writeStringDataToSharedPref(
          "accessToken", tokenResponse.access!);
      // Shared pref yazılacak access token
      return true;
    } else {
      // login başarısız
      return false;
    }
  }
}
