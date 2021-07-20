library core_router;

import 'package:foundation_injector/foundation_injector.dart';

import 'core_router.config.dart';

export 'package:core_router/core_router.dart' show configureRouterInjection;
export 'package:core_router/src/app_route_registry.dart' show AppRouteRegistry;
export 'package:core_router/src/navigation_dispatcher.dart'
    show NavigationDispatcher;

@injectableInit
Future<void> configureRouterInjection() async => $initGetIt(Injector.instance);
