import 'package:fake_story/api/api_calls/profil_page_calls.dart';
import 'package:fake_story/bloc/getx/user_state_enum.dart';
import 'package:fake_story/data/model/profilemodel.dart';
import 'package:fake_story/data/model/usermodel.dart';
import 'package:fake_story/utils/shared_prefs_ext.dart';
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

  var postLanguage = "".obs;
  changePostLanguage(String newLanguage) => {
        postLanguage.value = newLanguage,
        ProfilCalss.userProfileUpdate({"language": newLanguage}),
      };

  var isUserLogin = false.obs;
  setUserLoginState() async =>
      {isUserLogin.value = await CustomSharedPref.isUserLogin()};
  var userState = UserStates.loading.obs;
  setUserStateLoaded() {
    userState.value = UserStates.loaded;
    isUserLogin.value = true;
  }

  setUserStateLoading() {
    userState.value = UserStates.loading;
  }

  setUserStateError() {
    userState.value = UserStates.error;
  }

  var userModel = [].obs;
  setUserModel(UserModel post) => {userModel.clear(), userModel.add(post)};

  var miniPostList = [].obs;
  setMiniPostList(List<MiniPost> post) =>
      {miniPostList.clear(), miniPostList.addAll(post)};

  var miniSerachPostList = [].obs;
  setMiniSearchPostList(List<MiniPost> post) =>
      {miniSerachPostList.clear(), miniSerachPostList.addAll(post)};

  var isVideo = true.obs;
  setHomeTabIsVideo(int value) {
    if (value == 0) {
      isVideo.value = true;
    } else {
      isVideo.value = false;
    }
  }
}
