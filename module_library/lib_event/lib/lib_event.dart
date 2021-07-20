library lib_event;

import 'package:foundation_injector/foundation_injector.dart';

import 'lib_event.config.dart';

export 'package:lib_event/lib_event.dart' show configureEventInjection;
export 'package:lib_event/src/event_module.dart' show EventModule;

@injectableInit
Future<void> configureEventInjection() async => $initGetIt(Injector.instance);
