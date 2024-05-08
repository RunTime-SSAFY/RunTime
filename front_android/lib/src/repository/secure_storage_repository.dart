import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepository {
  SecureStorageRepository._();

  static final SecureStorageRepository _instance = SecureStorageRepository._();
  static SecureStorageRepository get instance => _instance;

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  late final _storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  FlutterSecureStorage get storage => _storage;

  Future<String?> get accessToken async => await _storage.read(
        key: 'accessToken',
      );

  Future<String?> get refreshToken async =>
      await _storage.read(key: 'refreshToken');

  Future<DateTime> get refreshTokenExpireDate async => DateTime.parse(
      await _storage.read(key: 'expireDate') ?? '2000-01-01T12:00:00.000Z');

  Future<void> setAccessToken(String token) async {
    await _storage.write(key: 'accessToken', value: token);
  }

  Future<void> setRefreshToken(String? token) async {
    await _storage.write(key: 'refreshToken', value: token);
  }
}
