import 'package:shared_utilities/utilities.dart';
import 'package:injectable/injectable.dart';

@module
abstract class EventModule {
  @Singleton()
  RxBus provideRxBus() {
    return RxBus();
  }
}
