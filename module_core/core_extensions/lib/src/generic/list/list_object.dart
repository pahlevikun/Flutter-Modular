part of '../../extensions.dart';

/// Supercharged extensions on [List].
extension ListSC<T> on List<T> {
  /// Converts this list into a JSON string.
  ///
  /// Use optional parameter [toEncodable] to convert types that are not a
  /// number, boolean, string, null, list or a map with string keys.
  ///
  /// See [jsonEncode].
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].toJSON(); // [1,2,3]
  /// ```
  String toJSON({required Object Function(Object? nonEncodable) toEncodable}) {
    return jsonEncode(this, toEncodable: toEncodable);
  }
}
