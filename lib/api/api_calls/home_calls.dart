import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class HomeCall {
  static Future<void> getAllPosts(String language, String? token) async {
    var logger = Logger();
    logger.i("get usera girdik");
    var dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer $token';
    Response response;
    response = await dio.get("146.19.57.51:8888/app/post/1");
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
