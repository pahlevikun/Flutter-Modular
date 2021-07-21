import 'package:alice/alice.dart';
import 'package:shared_manifest/manifest.dart';
import 'package:shared_utilities/utilities.dart';
import 'package:dio/dio.dart';
import 'package:foundation_injector/foundation_injector.dart';
import 'package:lib_network/src/dio_logger.dart';
import 'package:lib_storage_auth_token/lib_authentication_token.dart';

import 'authenticator/dio_token_interceptor.dart';

@module
abstract class NetworkModule {
  @LazySingleton()
  Dio provideDio(
    BaseOptions baseOptions,
    @Named("build_mode") bool shouldShowLogger,
    RxBus rxBus,
    DioLogger dioLogger,
    Alice alice,
    TokenGateway tokenGateway,
  ) {
    final dio = Dio(baseOptions);
    if (shouldShowLogger) {
      dio.interceptors.add(alice.getDioInterceptor());
      dio.interceptors.add(dioLogger);
    }
    return DioTokenInterceptor(dio, tokenGateway).build();
  }

  @Singleton()
  DioLogger provideDioLogger() => DioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
      );

  @Singleton()
  BaseOptions provideDioBaseOptions(
          @Named("base_url") String baseUrl,
          @Named("headers") Map<String, String> headers,
          @Named("connect_time_out") int connectTimeOut,
          @Named("read_time_out") int readTimeOut) =>
      BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        connectTimeout: connectTimeOut,
        receiveTimeout: readTimeOut,
      );

  @LazySingleton()
  Alice provideAlice(@Named("build_mode") bool shouldActive) =>
      Alice(showNotification: shouldActive, showInspectorOnShake: shouldActive);

  @Named("headers")
  Map<String, String> provideHeaders() => {"Accept": "application/json"};

  @Named("read_time_out")
  int get readTimeOut => 15000;

  @Named("connect_time_out")
  int get connectTimeOut => 15000;

  @Named("build_mode")
  bool get buildMode => BuildConfig.STAGING;

  @Named("base_url")
  String get baseUrl => BuildConfig.BASE_URL;
}
