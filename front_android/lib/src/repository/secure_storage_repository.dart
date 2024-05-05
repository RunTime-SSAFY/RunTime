import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepository {
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  static final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  static Future<String?> get accessToken async => await storage.read(
        key: 'accessToken',
      );

  static Future<String?> get refreshToken async =>
      await storage.read(key: 'refreshToken');

  static Future<DateTime> get refreshTokenExpireDate async => DateTime.parse(
      await storage.read(key: 'expireDate') ?? '2000-01-01T12:00:00.000Z');

  static Future<void> setAccessToken(String token) async {
    await storage.write(key: 'accessToken', value: token);
  }

  static Future<void> setRefreshToken(String token, DateTime expireDate) async {
    List<Future> asyncTasks = [
      storage.write(key: 'refreshToken', value: token),
      storage.write(key: 'expireDate', value: expireDate.toIso8601String()),
    ];

    await Future.wait(asyncTasks);
  }
}
