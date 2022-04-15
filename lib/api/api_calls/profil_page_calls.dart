import 'package:dio/dio.dart';
import 'package:fake_story/data/model/tokenmodel.dart';
import 'package:logger/logger.dart';

import '../../data/model/profilemodel.dart';
import '../../data/model/usermodel.dart';
import '../../utils/config.dart';
import '../../utils/shared_prefs_ext.dart';

class ProfilCalss {
  static String BASEURL = BaseUtils.getBaseUrl();
  static Future<UserModel> userInformations() async {
    // shared pref ten token cekilecek burada
    var logger = Logger();

    var token = await CustomSharedPref.readStringDataToLanguage("accessToken");

    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';
    response = await dio.get(BASEURL + "user/me/");
    logger.i('Response status: ${response.statusCode}');

    print('Response body: ${response.data}');
    var user = UserModel.fromJson(response.data);
    logger.i(user.username);
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

  static Future<ProfileRelate> profilPhotoUpload(String filepath) async {
    // shared pref ten token cekilecek burada
    //File alınacak yada path burada yükleme işlemi olacak profile photo
    var token = await CustomSharedPref.readStringDataToLanguage("accessToken");
    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filepath,
          filename: "testtt." + filepath.split('.').last)
    });
    response = await dio.put(BASEURL + "user/me/", data: formData);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    var user = ProfileRelate.fromJson(response.data);
    return user;
  }

  static Future<ProfileRelate> userProfileUpdate(dynamic data) async {
    //update edilecek yer {"profileimage":"http://enesakoluk.ml/1" ,"bio":"testbio"} bu şekilde butun modelden gelebilir
    // shared pref ten token cekilecek burada
    var token = await CustomSharedPref.readStringDataToLanguage("accessToken");

    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';
    response = await dio.patch(BASEURL + "user/me/", data: data);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');

    var user = ProfileRelate.fromJson(response.data);
    return user;
  }
}
