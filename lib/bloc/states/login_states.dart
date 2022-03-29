abstract class LoginState {
  LoginState();
}

class LoginInitState extends LoginState {
  LoginInitState();
}

class LoginLoadingState extends LoginState {
  LoginLoadingState();
}

class LoginLoadedState extends LoginState {
  ///Model
  List<String> userData;
  LoginLoadedState(this.userData);
}

class LoginErrorState extends LoginState {
  String errorMesage;
  LoginErrorState(this.errorMesage);
}
