import 'dart:ffi';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:fake_story/data/model/categoryGetModel.dart';
import 'package:fake_story/data/model/categorymodel.dart';
import 'package:fake_story/data/model/postmodel.dart';
import 'package:fake_story/data/model/user_model.dart';
import 'package:logger/logger.dart';

class DetailPageCalls {
  static String BASEURL = "http://192.168.0.15:8000/";

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

  static Future<List<PostModel>?> getCategory(String categoryid) async {
    var dio = Dio();
    Response response;
    response = await dio.get(BASEURL + "app/category/" + categoryid);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    var category = CategoryGetModel.fromJson(response.data);
    var postlist = category.categoryRelated;
    print('Response body: ${postlist![0].link}');

    return postlist;
  }
  static Future<bool> createCategory(String title,String language) async {
    var dio = Dio();
    Response response;
    response = await dio.post(BASEURL + "app/category/", data:{"title":title,"language":language});

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
   if (response.statusCode==201) {
     return true;
     
   } else {
     return false;
   }
  }


  static Future<List<PostModel>?> getPostList(
      String language, Bool isVideo) async {
    var dio = Dio();
    Response response;
    response = await dio.get(BASEURL +
        "app/post/" +
        "&language=" +
        language +
        "&isVideo=" +
        isVideo.toString());
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    List<PostModel> result = [];
    for (var item in response.data) {
      var post = PostModel.fromJson(item);
      result.add(post);
    }
    return result;
  }

  static Future<PostModel?> getPost(String postid) async {
    var dio = Dio();
    Response response;
    response = await dio.get(BASEURL + "app/post/" + postid);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    var post = PostModel.fromJson(response.data);
    return post;
  }

  static Future<List<CategoryModel>> getListCategory(String language) async {
    var dio = Dio();
    Response response;
    response = await dio.get(
        BASEURL + 'app/category/?ordering=-stream' + "&language=" + language);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');

    List<CategoryModel> result = [];
    for (var item in response.data) {
      var category = CategoryModel.fromJson(item);
      result.add(category);
    }
    return result;
  }

  static Future<List<PostModel>?> getSearchPostList(
      String searchtxt, Bool isVideo, String ordering, String language) async {
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
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    List<PostModel> result = [];
    for (var item in response.data) {
      var post = PostModel.fromJson(item);
      result.add(post);
    }
    return result;
  }
  static Future<List<PostModel>?> getFollowUserPostList() async {
    // Takip ettiğin kullanıcılların postlarını gosterme 

     // shared pref ten token cekilecek burada
    var token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo1MjQ5NDYwOTY1LCJpYXQiOjE2NDk0NjA5NjUsImp0aSI6ImNkYTllZTA3ZDQxYjRiNzc4YzI3YzY1N2Q3MjY0YzcwIiwidXNlcl9pZCI6OH0.NJnUXmslXZ3PklaK7GZg7h0GrGP8RpImhvFSXrFN_jo";
    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';
    
    response = await dio.get(BASEURL +"app/followingpost" );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    List<PostModel> result = [];
    for (var item in response.data) {
      var post = PostModel.fromJson(item);
      result.add(post);
    }
    return result;
  }

  static Future<List<UserModel>?> getSearchUserList(
      String searchtxt, String language) async {
    // ordering kullanımı -like like stream -stream created_at -created_at
    var dio = Dio();
    Response response;
    response = await dio.get(BASEURL +
        "user/profile/?search=" +
        searchtxt +
        "&language=" +
        language);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    List<UserModel> result = [];
    for (var item in response.data) {
      var post = UserModel.fromJson(item);
      result.add(post);
    }
    return result;
  }

  static Future<bool> userRegistirations(
    String username,
    String password,
    String email,
    String firstName,
    String lastname,
  ) async {
    // ordering kullanımı -like like stream -stream created_at -created_at
    var dio = Dio();
    Response response;
    response = await dio.post(BASEURL + "user/register/", data: {
      "username": username,
      "email": email,
      "password": password,
      "password2": password,
      "first_name": firstName,
      "last_name": lastname
      // ignore: avoid_print
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> userLogin(String username, String password) async {
    // ordering kullanımı -like like stream -stream created_at -created_at
    var dio = Dio();
    Response response;
    response = await dio.post(BASEURL + "user/register/",
        data: {"username": username, "password": password});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    if (response.statusCode == 200) {
      // Shared pref yazılacak access token
      return true;
    } else {
      // login başarısız
      return false;
    }
  }

  static Future<UserModel> userInformations() async {
    // shared pref ten token cekilecek burada
    var token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo1MjQ5NDYwOTY1LCJpYXQiOjE2NDk0NjA5NjUsImp0aSI6ImNkYTllZTA3ZDQxYjRiNzc4YzI3YzY1N2Q3MjY0YzcwIiwidXNlcl9pZCI6OH0.NJnUXmslXZ3PklaK7GZg7h0GrGP8RpImhvFSXrFN_jo";
    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';
    response = await dio.get(BASEURL + "user/me/");
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    var user = UserModel.fromJson(response.data);
    return user;
  }

  static Future<ProfileRelate> userProfileUpdate(dynamic data) async {
    //update edilecek yer {"profileimage":"http://enesakoluk.ml/1" ,"bio":"testbio"} bu şekilde butun modelden gelebilir
    // shared pref ten token cekilecek burada
    var token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo1MjQ5NDYwOTY1LCJpYXQiOjE2NDk0NjA5NjUsImp0aSI6ImNkYTllZTA3ZDQxYjRiNzc4YzI3YzY1N2Q3MjY0YzcwIiwidXNlcl9pZCI6OH0.NJnUXmslXZ3PklaK7GZg7h0GrGP8RpImhvFSXrFN_jo";
    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';
    response = await dio.patch(BASEURL + "user/me/", data: data);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');

    var user = ProfileRelate.fromJson(response.data);
    return user;
  }

  static Future<UserModel> anotheruserInformations(int anotheruserid) async {
    // shared pref ten token cekilecek burada
    var token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo1MjQ5NDYwOTY1LCJpYXQiOjE2NDk0NjA5NjUsImp0aSI6ImNkYTllZTA3ZDQxYjRiNzc4YzI3YzY1N2Q3MjY0YzcwIiwidXNlcl9pZCI6OH0.NJnUXmslXZ3PklaK7GZg7h0GrGP8RpImhvFSXrFN_jo";
    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';
    response =
        await dio.get(BASEURL + "user/profile/" + anotheruserid.toString());
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    var user = UserModel.fromJson(response.data);
    return user;
  }

  static Future<UserModel> followUnfollow(int followuserid) async {
    // shared pref ten token cekilecek burada
    var token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo1MjQ5NDYwOTY1LCJpYXQiOjE2NDk0NjA5NjUsImp0aSI6ImNkYTllZTA3ZDQxYjRiNzc4YzI3YzY1N2Q3MjY0YzcwIiwidXNlcl9pZCI6OH0.NJnUXmslXZ3PklaK7GZg7h0GrGP8RpImhvFSXrFN_jo";
    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';
    response =
        await dio.get(BASEURL + "user/follow/" + followuserid.toString());
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    var user = UserModel.fromJson(response.data);
    return user;
  }

  static Future<UserModel> blocUnblock(int blockuserid) async {
    // shared pref ten token cekilecek burada
    var token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo1MjQ5NDYwOTY1LCJpYXQiOjE2NDk0NjA5NjUsImp0aSI6ImNkYTllZTA3ZDQxYjRiNzc4YzI3YzY1N2Q3MjY0YzcwIiwidXNlcl9pZCI6OH0.NJnUXmslXZ3PklaK7GZg7h0GrGP8RpImhvFSXrFN_jo";
    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';
    response = await dio.get(BASEURL + "user/block/" + blockuserid.toString());
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    var user = UserModel.fromJson(response.data);
    return user;
  }

  static Future<PostModel> likeUnlike(int postid) async {
    // shared pref ten token cekilecek burada
    var token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo1MjQ5NDYwOTY1LCJpYXQiOjE2NDk0NjA5NjUsImp0aSI6ImNkYTllZTA3ZDQxYjRiNzc4YzI3YzY1N2Q3MjY0YzcwIiwidXNlcl9pZCI6OH0.NJnUXmslXZ3PklaK7GZg7h0GrGP8RpImhvFSXrFN_jo";
    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';
    response = await dio.get(BASEURL + "app/like/" + postid.toString());
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    var user = PostModel.fromJson(response.data);
    return user;
  }

  static Future<PostModel> favoriUnfavori(int postid) async {
    // shared pref ten token cekilecek burada
    var token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo1MjQ5NDYwOTY1LCJpYXQiOjE2NDk0NjA5NjUsImp0aSI6ImNkYTllZTA3ZDQxYjRiNzc4YzI3YzY1N2Q3MjY0YzcwIiwidXNlcl9pZCI6OH0.NJnUXmslXZ3PklaK7GZg7h0GrGP8RpImhvFSXrFN_jo";
    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';
    response = await dio.get(BASEURL + "app/favorite/" + postid.toString());
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    var user = PostModel.fromJson(response.data);
    return user;
  }

  static Future<ProfileRelate> profilPhotoUpload(String filepath) async {
    // shared pref ten token cekilecek burada
    //File alınacak yada path burada yükleme işlemi olacak profile photo
    var token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo1MjQ5NDYwOTY1LCJpYXQiOjE2NDk0NjA5NjUsImp0aSI6ImNkYTllZTA3ZDQxYjRiNzc4YzI3YzY1N2Q3MjY0YzcwIiwidXNlcl9pZCI6OH0.NJnUXmslXZ3PklaK7GZg7h0GrGP8RpImhvFSXrFN_jo";
    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';
    var formData = FormData.fromMap({'file': await MultipartFile.fromFile('./text.txt', filename: 'upload.txt')
    });
    response = await dio.put(BASEURL + "user/me/",data:formData);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    var user = ProfileRelate.fromJson(response.data);
    return user;
  }
  static Future<bool> createPost(String filepath,String title,String language,Bool isVideo) async {
    // shared pref ten token cekilecek burada
    //File alınacak yada path burada yükleme işlemi olacak profile photo
    var token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo1MjQ5NDYwOTY1LCJpYXQiOjE2NDk0NjA5NjUsImp0aSI6ImNkYTllZTA3ZDQxYjRiNzc4YzI3YzY1N2Q3MjY0YzcwIiwidXNlcl9pZCI6OH0.NJnUXmslXZ3PklaK7GZg7h0GrGP8RpImhvFSXrFN_jo";
    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';
    var formData = FormData.fromMap({
      "title":title,
      "isVideo":isVideo,
      "language":language,
      'file': await MultipartFile.fromFile('./text.txt', filename: 'upload.txt')
    });
    response = await dio.put(BASEURL + "user/me/",data:formData);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
   if (response.statusCode==201) {
     return true;
   } else {
     return false;
   }
  }
  static Future<bool> deletePost(int postid) async {
    // shared pref ten token cekilecek burada
    //File alınacak yada path burada yükleme işlemi olacak profile photo
    var token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo1MjQ5NDYwOTY1LCJpYXQiOjE2NDk0NjA5NjUsImp0aSI6ImNkYTllZTA3ZDQxYjRiNzc4YzI3YzY1N2Q3MjY0YzcwIiwidXNlcl9pZCI6OH0.NJnUXmslXZ3PklaK7GZg7h0GrGP8RpImhvFSXrFN_jo";
    var dio = Dio();
    Response response;
    dio.options.headers["Authorization"] = 'Bearer $token';
   
    response = await dio.delete(BASEURL + "app/post/"+postid.toString());
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
   if (response.statusCode==204) {
     return true;
   } else {
     return false;
   }
  }
}
