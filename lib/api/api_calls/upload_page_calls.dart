import 'package:dio/dio.dart';

class UploadPageCalls {
  static String BASEURL = "http://185.174.61.27:8888/";
  static Future<bool> createPost(
      String filepath, String title, String language, bool isVideo) async {
    // shared pref ten token cekilecek burada
    //File alınacak yada path burada yükleme işlemi olacak profile photo
    var token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo1MjQ5NTQzNjA3LCJpYXQiOjE2NDk1NDM2MDcsImp0aSI6Ijc5ZGE4ZDEwZGQzNTQxYTFiYjcwOGJhY2U0MmI0MGYwIiwidXNlcl9pZCI6Mn0.GrUwwbmokE5UdLhb7XN0g-Tzf2YF7F8rIYqvne8TXLM";
    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';
    var formData = FormData.fromMap({
      "title": title,
      "isVideo": isVideo.toString(),
      "language": language,
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
