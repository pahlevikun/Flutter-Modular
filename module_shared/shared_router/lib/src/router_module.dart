import 'package:shared_router/shared_router.dart';
import 'package:fluro/fluro.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RouterModule {
  @LazySingleton()
  FluroRouter provideFluroRouter() => FluroRouter();

  @LazySingleton()
  AppRouteRegistry provideInternalRouter(FluroRouter router) =>
      AppRouteRegistry(router);

  @LazySingleton()
  NavigationDispatcher provideNavigationDispatcher(AppRouteRegistry route) =>
      NavigationDispatcher(route);
}
