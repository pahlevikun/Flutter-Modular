class StringHelper {
  static bool isEmailValid(String _email) {
    return _email.isNotEmpty
        ? RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
            .hasMatch(_email)
        : false;
  }
}
