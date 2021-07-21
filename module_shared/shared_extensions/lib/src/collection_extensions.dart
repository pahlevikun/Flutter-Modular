part of 'extensions.dart';

extension ListExt<T> on List<T> {
  List<R> mapReversed<R>(R Function(T) convert) =>
      this.reversed.map(convert).toList();

  List updateAt(int index, T item) {
    List<T> list = List.empty(growable: true);
    list.add(item);
    replaceRange(index, index + 1, list);
    return this;
  }
}
