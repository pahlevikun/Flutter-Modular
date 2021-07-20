import 'package:dio/dio.dart';
import 'package:lib_network/src/authenticator/token_authenticator.dart';
import 'package:lib_storage_auth_token/lib_authentication_token.dart';

class DioTokenInterceptor {
  Dio _dio;
  TokenGateway _tokenGateway;

  DioTokenInterceptor(this._dio, this._tokenGateway);

  Dio build() {
    final authenticator = TokenAuthenticator<String>(
      tokenHeader: (token) {
        return {
          "Authorization": "Bearer $token",
        };
      },
      tokenStorage: _tokenGateway,
      refreshToken: (token, client) async {
        // TODO: Refresh token & store new token here
        return "newTokenWillBeHere";
      },
      httpClient: _dio,
    );
    _dio.interceptors.add(authenticator);
    return _dio;
  }
}
