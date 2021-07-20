class AggregatedException implements Exception {
  final String message;

  AggregatedException(this.message, this.exceptions)
      : lastException = exceptions.last,
        numberOfExceptions = exceptions.length;

  final List<Exception> exceptions;
  final Exception lastException;
  final int numberOfExceptions;

  String toString() {
    String result = '';
    exceptions.forEach((e) => result += e.toString() + '\\');
    return result;
  }
}
