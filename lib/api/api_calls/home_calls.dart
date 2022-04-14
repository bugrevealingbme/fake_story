import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:fake_story/api/api_calls/profil_page_calls.dart';
import 'package:fake_story/utils/shared_prefs_ext.dart';
import 'package:logger/logger.dart';

import '../../data/model/categoryGetModel.dart';
import '../../data/model/categorymodel.dart';
import '../../data/model/postmodel.dart';

class HomeCall {
  static String BASEURL = "http://185.174.61.27:8888/";
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

  static Future<List<CategoryModel>> getListCategory() async {
    var logger = Logger();
    logger.i("getListCategory girdik");
    var userModel = await ProfilCalss.userInformations();
    var language = userModel.profileRelate!.language;
    var dio = Dio();
    Response response;
    response = await dio.get(
        BASEURL + 'app/category/?ordering=-stream' + "&language=" + language!);

    List<CategoryModel> result = [];
    for (var item in response.data) {
      var category = CategoryModel.fromJson(item);
      result.add(category);
    }
    logger.i(response.data);
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
      String searchtxt, bool isVideo, String ordering, bool isAll) async {
    // ordering kullanımı -like like stream -stream created_at -created_at
    var dio = Dio();
    Response response;
    var userModel = await ProfilCalss.userInformations();
    var language = userModel.profileRelate!.language;
    response = await dio.get(BASEURL +
        "app/post/?search=" +
        searchtxt +
        (isAll ? "" : "&isVideo=" + isVideo.toString()) +
        "&ordering=" +
        ordering +
        "&language=" +
        language!);
    print('Response status searchPost: ${response.statusCode}');
    print('Response status searchPost: ${response.data.length}');

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
    var token = await CustomSharedPref.readStringDataToLanguage("accessToken");
    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';

    response = await dio
        .get(BASEURL + "app/followingpost?isVideo=${isVideo.toString()}");
    print('Response following status: ${response.statusCode}');
    print('Response following body: ${response.data}');
    List<PostModel> result = [];
    for (var item in response.data) {
      var post = PostModel.fromJson(item);
      result.add(post);
    }
    return result;
  }
}
