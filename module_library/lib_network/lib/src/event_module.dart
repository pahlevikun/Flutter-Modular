import 'package:shared_utilities/utilities.dart';
import 'package:foundation_injector/foundation_injector.dart';
import 'package:lib_event/lib_event.dart';

@module
abstract class NetworkEventModule extends EventModule {
  @override
  RxBus provideRxBus() {
    return super.provideRxBus();
  }
}
