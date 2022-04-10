import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../data/model/categoryGetModel.dart';
import '../../data/model/categorymodel.dart';
import '../../data/model/postmodel.dart';

class HomeCall {
  static String BASEURL = "http://146.19.57.51:8888/";
  static Future<List<PostModel>> getAllPosts(
      String language, bool? isVideo) async {
    var logger = Logger();
    logger.i("get usera girdik");
    var dio = Dio();
    Response response;
    response = await dio.get(BASEURL +
        "app/post/" +
        "?language=" +
        language +
        "&isVideo=" +
        isVideo.toString());
    print('Response status: ${response.statusCode}');

    List<PostModel> result = [];
    for (var item in response.data) {
      var post = PostModel.fromJson(item);
      result.add(post);
    }
    return result;
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

  static Future<List<CategoryModel>> getListCategory(String language) async {
    var logger = Logger();
    logger.i("getListCategory girdik");
    var dio = Dio();
    Response response;
    response = await dio.get(
        BASEURL + 'app/category/?ordering=-stream' + "&language=" + language);

    List<CategoryModel> result = [];
    for (var item in response.data) {
      var category = CategoryModel.fromJson(item);
      result.add(category);
    }

    return result;
  }

  static Future<List<PostModel>?> getCategory(
      String categoryid, bool isVideo) async {
    List<PostModel> categorisedList = [];
    var logger = Logger();
    logger.i("getCategory calisti ");
    var dio = Dio();
    Response response;
    response = await dio.get(BASEURL +
        "app/post/?isVideo=${isVideo.toString()}&category__id=" +
        categoryid);

    for (var item in response.data) {
      var category = PostModel.fromJson(item);
      categorisedList.add(category);
    }

    return categorisedList;
  }

  static Future<List<PostModel>?> getSearchPostList(
      String searchtxt, bool isVideo, String ordering, String language) async {
    // ordering kullanımı -like like stream -stream created_at -created_at
    var dio = Dio();
    Response response;
    response = await dio.get(BASEURL +
        "app/post/?search=" +
        searchtxt +
        "&isVideo=" +
        isVideo.toString() +
        "&ordering=" +
        ordering +
        "&language=" +
        language);
    print('Response status searchPost: ${response.statusCode}');

    List<PostModel> result = [];
    for (var item in response.data) {
      var post = PostModel.fromJson(item);
      result.add(post);
    }
    return result;
  }

  static Future<List<PostModel>?> getFollowUserPostList(bool isVideo) async {
    // Takip ettiğin kullanıcılların postlarını gosterme

    // shared pref ten token cekilecek burada
    var token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo1MjQ5NTQzNjA3LCJpYXQiOjE2NDk1NDM2MDcsImp0aSI6Ijc5ZGE4ZDEwZGQzNTQxYTFiYjcwOGJhY2U0MmI0MGYwIiwidXNlcl9pZCI6Mn0.GrUwwbmokE5UdLhb7XN0g-Tzf2YF7F8rIYqvne8TXLM";
    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';

    response = await dio
        .get(BASEURL + "app/followingpost?isVideo=${isVideo.toString()}");
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    List<PostModel> result = [];
    for (var item in response.data) {
      var post = PostModel.fromJson(item);
      result.add(post);
    }
    return result;
  }
}
