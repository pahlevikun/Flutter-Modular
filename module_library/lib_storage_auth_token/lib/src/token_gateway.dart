import 'package:shared_manifest/manifest.dart';
import 'package:shared_storage/shared_storage.dart';
import 'package:foundation_authenticator/foundation_authenticator.dart';

class TokenGateway implements TokenStorage<String> {
  final StorageManager _storageManager;

  TokenGateway(this._storageManager);

  static const _KEY_ACCESS_TOKEN =
      "${BuildConfig.APP_ID}.pref.credentials.access_token";

  @override
  Future<void> delete() async {
    return _storageManager.removeFromDisk(_KEY_ACCESS_TOKEN);
  }

  @override
  Future<String> read() {
    return _storageManager.getFromDisk(_KEY_ACCESS_TOKEN) ?? '';
  }

  @override
  Future<void> write(String token) async {
    return _storageManager.saveToDisk(_KEY_ACCESS_TOKEN, token);
  }
}
