import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front_android/src/repository/secure_storage_repository.dart';

final authProvider = StateProvider((ref) => AuthService());

class AuthService with ChangeNotifier {
  AuthService() {
    _init();
  }

  String? _accessToken;
  String? _refreshToken;
  DateTime? _expireDate;

  Future<void> _init() async {
    const storage = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
    try {
      _accessToken = await storage.read(key: 'accessToken');
      _refreshToken = await storage.read(key: 'refreshToken');
      String? expireDateString = await storage.read(key: 'expireDate');
      _expireDate =
          expireDateString != null ? DateTime.parse(expireDateString) : null;
    } catch (err) {
      debugPrint(err.toString());
    }
    notifyListeners();
  }

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  DateTime? get refreshTokenExpireDate => _expireDate;

  Future<void> setAccessToken(String token) async {
    _accessToken = token;
    notifyListeners();
  }

  Future<void> setRefreshToken(String token, DateTime expireDate) async {
    _refreshToken = token;
    _expireDate = expireDate;
    SecureStorageRepository.setRefreshToken(token, expireDate);
    notifyListeners();
  }
}
