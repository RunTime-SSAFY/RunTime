import 'package:front_android/src/service/https_request_service.dart';

class UserService {
  UserService._();

  static final _instance = UserService._();
  static UserService get instance => _instance;

  String nickname = '';
  String email = '';
  String characterImgUrl = '';
  double weight = 65;

  Future<bool> changeUserInfor({
    required String newNickname,
    required double newWeight,
  }) async {
    try {
      await apiInstance.patch('api/members', data: {
        "nickname": newNickname,
        "weight": newWeight,
      });
      nickname = newNickname;
      weight = newWeight;
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> getUserInfor() async {
    try {
      var response = await apiInstance.get('api/members');
      print(response);
      var data = response.data;
      nickname = data['nickname'];
      weight = data['weight'];
      return true;
    } catch (error) {
      return false;
    }
  }
}
