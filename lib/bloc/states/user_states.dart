import 'package:fake_story/data/model/user_model.dart';

import '../../data/model/user_post_model.dart';

abstract class UserState {
  UserState();
}

class UserInitState extends UserState {
  UserInitState();
}

class UserLoadingState extends UserState {
  UserLoadingState();
}

class UserLoadedState extends UserState {
  ///Model
  UserModel userData;
  UserLoadedState(this.userData);
}

class UserCreatedState extends UserState {
  ///Model
  UserPostModel userPostModel;
  UserCreatedState(this.userPostModel);
}

class AccesTokenCreatedState extends UserState {
  ///Model
  String accessToken;
  AccesTokenCreatedState(this.accessToken);
}

class UserErrorState extends UserState {
  String errorMesage;
  UserErrorState(this.errorMesage);
}
