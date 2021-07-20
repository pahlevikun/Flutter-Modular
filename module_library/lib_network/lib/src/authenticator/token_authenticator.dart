import 'dart:async';

import 'package:dio/dio.dart';
import 'package:foundation_authenticator/foundation_authenticator.dart';
import 'package:lib_network/src/authenticator/token_authenticator_mixin.dart';
import 'package:lib_network/src/authenticator/token_authenticator_model.dart';

class TokenAuthenticator<String> extends Interceptor
    with TokenAuthenticatorMixin {
  TokenAuthenticator({
    required TokenHeaderBuilder tokenHeader,
    required TokenStorage<String> tokenStorage,
    required RefreshTokenCallback<String> refreshToken,
    ShouldRefresh? shouldRefresh,
    Dio? httpClient,
  })  : _refreshToken = refreshToken,
        _tokenHeader = tokenHeader,
        _shouldRefresh = shouldRefresh ?? _defaultShouldRefresh,
        _httpClient = httpClient ?? Dio() {
    this.tokenStorage = tokenStorage;
  }

  final Dio _httpClient;
  final TokenHeaderBuilder _tokenHeader;
  final ShouldRefresh _shouldRefresh;
  final RefreshTokenCallback<String> _refreshToken;

  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    super.onRequest(options, handler);
    final currentToken = await token;
    if (currentToken != null) {
      options.headers.addAll(_tokenHeader(currentToken));
    }
    handler.next(options);
  }

  @override
  Future<dynamic> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (await token == null || !_shouldRefresh(response)) {
      return handler.next(response);
    }
    try {
      final refreshResponse = await _tryRefresh(response);
      handler.resolve(refreshResponse);
    } on DioError catch (error) {
      handler.reject(error);
    }
  }

  @override
  Future<dynamic> onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    if (response == null ||
        await token == null ||
        err.error is RevokeTokenException ||
        !_shouldRefresh(response)) {
      return handler.next(err);
    }
    try {
      final refreshResponse = await _tryRefresh(response);
      handler.resolve(refreshResponse);
    } on DioError catch (error) {
      handler.next(error);
    }
  }

  Future<Response<dynamic>> _tryRefresh(Response response) async {
    late final String refreshedToken;
    try {
      refreshedToken = await _refreshToken(await token, _httpClient);
    } on RevokeTokenException catch (error) {
      await clearToken();
      throw DioError(
        requestOptions: response.requestOptions,
        error: error,
        response: response,
      );
    }

    await setToken(refreshedToken);
    _httpClient.options.baseUrl = response.requestOptions.baseUrl;
    return await _httpClient.request<dynamic>(
      response.requestOptions.path,
      cancelToken: response.requestOptions.cancelToken,
      data: response.requestOptions.data,
      onReceiveProgress: response.requestOptions.onReceiveProgress,
      onSendProgress: response.requestOptions.onSendProgress,
      queryParameters: response.requestOptions.queryParameters,
      options: Options(
        method: response.requestOptions.method,
        sendTimeout: response.requestOptions.sendTimeout,
        receiveTimeout: response.requestOptions.receiveTimeout,
        extra: response.requestOptions.extra,
        headers: response.requestOptions.headers
          ..addAll(_tokenHeader(refreshedToken)),
        responseType: response.requestOptions.responseType,
        contentType: response.requestOptions.contentType,
        validateStatus: response.requestOptions.validateStatus,
        receiveDataWhenStatusError:
            response.requestOptions.receiveDataWhenStatusError,
        followRedirects: response.requestOptions.followRedirects,
        maxRedirects: response.requestOptions.maxRedirects,
        requestEncoder: response.requestOptions.requestEncoder,
        responseDecoder: response.requestOptions.responseDecoder,
        listFormat: response.requestOptions.listFormat,
      ),
    );
  }

  static bool _defaultShouldRefresh(Response? response) {
    return response?.statusCode == 401;
  }
}
