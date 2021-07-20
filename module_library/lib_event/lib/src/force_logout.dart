import 'package:lib_event/src/base_event.dart';

class ForceLogout extends BaseEvent {
  static const event = "ForceLogout";

  @override
  String getName() => event;
}
