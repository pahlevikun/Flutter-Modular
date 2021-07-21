import 'package:get_it/get_it.dart';

final _locator = GetIt.instance..allowReassignment = true;

class Injector {
  static final instance = _locator;
}
