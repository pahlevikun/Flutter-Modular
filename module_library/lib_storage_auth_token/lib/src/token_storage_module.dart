import 'package:shared_storage/shared_storage.dart';
import 'package:foundation_authenticator/foundation_authenticator.dart';
import 'package:injectable/injectable.dart';
import 'package:lib_storage_auth_token/lib_authentication_token.dart';

@module
abstract class AuthenticationModule {
  @LazySingleton(as: TokenStorage)
  TokenGateway provideTokenGateway(StorageManager storage) {
    return TokenGateway(storage);
  }

  @Singleton()
  StorageManager provideStorageManager(SharedPreferences sharedPreferences) {
    return StorageManager(sharedPreferences);
  }

  @preResolve
  @Singleton()
  Future<SharedPreferences> provideSharedPreferences() {
    return SharedPreferences.getInstance();
  }
}
