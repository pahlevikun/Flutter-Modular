import 'package:shared_utilities/src/exception/aggregated_exception.dart';

class FutureHelper {
  static Future retry<T>(OnRun onRun,
      {int numberOfRetries = 3,
      Duration delayToRetry = const Duration(milliseconds: 1000),
      String message = ''}) async {
    int retry = numberOfRetries;
    List<Exception> exceptions = [];

    while (retry-- > 0) {
      try {
        onRun.call();
      } catch (e) {
        exceptions.add(e as Exception);
      }
      if (message.isNotEmpty)
        print('$message:  retry - ${numberOfRetries - retry}');
      await Future.delayed(delayToRetry);
    }
    throw AggregatedException(message, exceptions);
  }
}

typedef void OnRun();
