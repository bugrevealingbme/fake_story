import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fake_story/api/api_calls/profil_page_calls.dart';

import '../../data/model/categorymodel.dart';
import '../../utils/config.dart';
import '../../utils/shared_prefs_ext.dart';

class UploadPageCalls {
  static String BASEURL = BaseUtils.getBaseUrl();
  static Future<bool> createPost(String filepath, String title, bool isVideo,
      String description, String categoryString) async {
    // shared pref ten token cekilecek burada
    //File alınacak yada path burada yükleme işlemi olacak profile photo
    var userModel = await ProfilCalss.userInformations();
    var language = userModel.profileRelate!.language;
    var token = await CustomSharedPref.readStringDataToLanguage("accessToken");
    var dio = Dio();
    Response response;
    List result = [];
    if (categoryString.isNotEmpty) {
      for (var item in categoryString.split("#")) {
        if (item.isNotEmpty) {
          result.add(item);
        }
      }
    }
    print(result);
    dio.options.headers["Authorization"] = 'Bearer $token';
    var formData = FormData.fromMap({
      "title": title,
      "isVideo": isVideo.toString(),
      "language": language,
      "description": description,
      "categorys": jsonEncode(result),
      'file': await MultipartFile.fromFile(filepath,
          filename: "testtt." + filepath.split('.').last)
    });
    response = await dio.post(BASEURL + "app/post/", data: formData);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
