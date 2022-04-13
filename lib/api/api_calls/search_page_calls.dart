import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class SearchPageCalls {
  static Future<void> searchUser(String searchTerm) async {
    var logger = Logger();
    logger.i("get usera girdik");
    var dio = Dio();

    Response response;
    response = await dio
        .post("http://185.174.61.27:8888/app/post/?search=$searchTerm");
    logger.i(response.data);
    // var user = UserModel.fromJson(response.data);
    //  logger.i(user.firstName);
  }

  static Future<void> getAllCategories(String language, String? token) async {
    var logger = Logger();
    logger.i("get usera girdik");
    var dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer $token';
    Response response;
    response = await dio.get("146.19.57.51:8888/app/category/1");
    logger.i(response.data);
    // var user = UserModel.fromJson(response.data);
    //  logger.i(user.firstName);
  }
}
