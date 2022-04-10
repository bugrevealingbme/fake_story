import 'package:get/get.dart';

import '../../data/model/postmodel.dart';

class Controller extends GetxController {
  var count = 0.obs;
  increment() => count++;

  var postList = [].obs;
  addPostList(List<PostModel> post) =>
      {postList.clear(), postList.addAll(post)};
  var postVideoList = [].obs;
  addPostVideoList(List<PostModel> post) =>
      {postVideoList.clear(), postVideoList.addAll(post)};

  var language = "".obs;
  changeLanguage(String newLanguage) => language.value = newLanguage;
}
