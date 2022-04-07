import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DetailPageCalls {
  static Future<void> followUser(String userId, String? token) async {
    var logger = Logger();
    logger.i("get usera girdik");
    var dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer $token';
    Response response;
    response = await dio.post("146.19.57.51:8888/user/follow/$userId");
    logger.i(response.data);
    // var user = UserModel.fromJson(response.data);
    //  logger.i(user.firstName);
  }

  static Future<void> getOwnerFollowers(String userId) async {
    var logger = Logger();
    logger.i("get usera girdik");
    var dio = Dio();
    // dio.options.headers["Authorization"] = 'Bearer $token';
    Response response;
    response = await dio.get("146.19.57.51:8888/user/profile/$userId");
    logger.i(response.data);
    // var user = UserModel.fromJson(response.data);
    //  logger.i(user.firstName);
  }

  static Future<void> getMorePost(String userId) async {
    var logger = Logger();
    logger.i("get usera girdik");
    var dio = Dio();
    // dio.options.headers["Authorization"] = 'Bearer $token';
    Response response;
    response = await dio.get("146.19.57.51:8888/user/profile/$userId");
    logger.i(response.data);
    // var user = UserModel.fromJson(response.data);
    //  logger.i(user.firstName);
  }
}
