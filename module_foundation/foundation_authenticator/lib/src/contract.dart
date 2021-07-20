import 'package:dio/dio.dart';

typedef ShouldRefresh = bool Function(Response? response);

typedef RefreshTokenCallback<T> = Future<T> Function(T? token, Dio httpClient);

typedef TokenHeaderBuilder<T> = Map<String, String> Function(T token);
