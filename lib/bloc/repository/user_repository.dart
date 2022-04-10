import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fake_story/api/endpoints.dart';
import 'package:fake_story/data/model/user_post_model.dart';
import 'package:fake_story/utils/shared_prefs_ext.dart';
import 'package:logger/logger.dart';

import '../../data/model/usermodel.dart';

abstract class UserRepository {
  Future<UserModel?> register(String username, String password, String email,
      String? firstName, String? lastname);
  Future<UserModel> getCurrentUser(String token);
  Future<String> getAccessToken(String username, String password);
}

class UserDaoRepository implements UserRepository {
  @override
  Future<UserModel> getCurrentUser(String token) async {
    var logger = Logger();
    logger.i("get usera girdik");
    var dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer $token';
    Response response;
    response = await dio.get(UserEndPoints.userGetEndpoint.endpointName);
    logger.i(response.data);
    var user = UserModel.fromJson(response.data);
    logger.i(user.firstName.toString());
    return user;
  }

  @override
  Future<UserModel?> register(String username, String password, String email,
      String? firstName, String? lastname) async {
    var logger = Logger();
    logger.i("logine girdik");
    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    Response response;
    response =
        await dio.post(UserEndPoints.userRegisterEndpoint.endpointName, data: {
      "username": username,
      "email": email,
      "password": password,
      "password2": password,
      "first_name": firstName,
      "last_name": lastname
      // ignore: avoid_print
    });
    logger.i(response);

    if (response.statusCode == 201) {
      final body = response.data;
      logger.i("body");
      return UserModel(
        username: body['username'],
        email: body['email'],
      );
    } else {
      logger.i("hata");
      return null;
    }
  }

  @override
  Future<String> getAccessToken(String username, String password) async {
    var logger = Logger();
    logger.i("acces tokena girdik");

    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    Response response;
    response = await dio
        .post(UserEndPoints.userCreateTokenEndPoint.endpointName, data: {
      "username": username,
      "password": password,
      // ignore: avoid_print
    });

    if (response.statusCode == 200) {
      final body = response.data;
      final token = body["access"];
      CustomSharedPref.writeStringDataToSharedPref("accessToken", token);
      logger.i(body["access"]);
      return body["access"];
    } else {
      logger.i("acces token hata");
      return "";
    }
  }
}
