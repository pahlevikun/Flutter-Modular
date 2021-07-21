library shared_router;

import 'package:foundation_injector/foundation_injector.dart';

import 'shared_router.config.dart';

export 'package:shared_router/shared_router.dart' show configureRouterInjection;
export 'package:shared_router/src/app_route_registry.dart' show AppRouteRegistry;
export 'package:shared_router/src/navigation_dispatcher.dart'
    show NavigationDispatcher;

@injectableInit
Future<void> configureRouterInjection() async => $initGetIt(Injector.instance);
