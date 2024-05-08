class UserService {
  UserService._();

  static final _instance = UserService._();
  static UserService get instance => _instance;

  String nickname = '';
  String email = '';
  String characterImgUrl = '';
}
