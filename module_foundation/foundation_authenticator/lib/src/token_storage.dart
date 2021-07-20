abstract class TokenStorage<T> {
  Future<T?> read();

  Future<void> write(T token);

  Future<void> delete();
}

/*
This is default class for storing token in runtime memory
 */
class InMemoryTokenStorage<T> implements TokenStorage<T> {
  T? _token;

  @override
  Future<void> delete() async {
    _token = null;
  }

  @override
  Future<T?> read() async {
    return _token;
  }

  @override
  Future<void> write(T token) async {
    _token = token;
  }
}
