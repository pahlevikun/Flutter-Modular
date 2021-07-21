import 'package:shared_storage/shared_storage.dart';
import 'package:foundation_injector/foundation_injector.dart';
import 'package:lib_storage_auth_token/lib_authentication_token.dart';

@module
abstract class AuthModule extends AuthenticationModule {
  @override
  Future<SharedPreferences> provideSharedPreferences() {
    return super.provideSharedPreferences();
  }

  @override
  StorageManager provideStorageManager(SharedPreferences sharedPreferences) {
    return super.provideStorageManager(sharedPreferences);
  }

  @override
  TokenGateway provideTokenGateway(StorageManager storage) {
    return super.provideTokenGateway(storage);
  }
}
