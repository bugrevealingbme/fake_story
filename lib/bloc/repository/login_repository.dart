abstract class LoginRepository {
  //List USER model--String is a dummy
  Future<List<String>> getCurrentUser();
}

class LoginDaoRepository implements LoginRepository {
  @override
  Future<List<String>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
}
