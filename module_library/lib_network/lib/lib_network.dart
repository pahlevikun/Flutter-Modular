library lib_network;

import 'package:foundation_injector/foundation_injector.dart';

import 'lib_network.config.dart';

export 'package:lib_network/lib_network.dart' show configureNetworkInjection;

@injectableInit
Future<void> configureNetworkInjection() async => $initGetIt(Injector.instance);
