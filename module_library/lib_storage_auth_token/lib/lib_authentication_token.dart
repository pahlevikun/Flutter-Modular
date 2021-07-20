library lib_authentication_token;

import 'package:foundation_injector/foundation_injector.dart';

import 'lib_authentication_token.config.dart';

export 'package:lib_storage_auth_token/lib_authentication_token.dart'
    show configureAuthTokenInjection;
export 'package:lib_storage_auth_token/src/token_gateway.dart'
    show TokenGateway;
export 'package:lib_storage_auth_token/src/token_storage_module.dart'
    show AuthenticationModule;

@injectableInit
Future<void> configureAuthTokenInjection() async =>
    $initGetIt(Injector.instance);
