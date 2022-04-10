import 'package:fake_story/data/model/usermodel.dart';

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
  UserModel userPostModel;
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
