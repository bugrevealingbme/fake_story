enum UserEndPoints {
  baseUrl,
  userGetEndpoint,
  userRegisterEndpoint,
  userCreateTokenEndPoint,
}

extension Enpoints on UserEndPoints {
  String get endpointName {
    switch (this) {
      case UserEndPoints.baseUrl:
        return "http://146.19.57.51:8888/";
      case UserEndPoints.userGetEndpoint:
        return "http://146.19.57.51:8888/user/me";
      case UserEndPoints.userRegisterEndpoint:
        return "http://146.19.57.51:8888/user/register/";
      case UserEndPoints.userCreateTokenEndPoint:
        return "http://146.19.57.51:8888/user/token/";
      default:
        return "";
    }
  }
}
