extension ListWithIndex<T, E> on List<T> {
  List<E> mapWithIndex<E>(E Function(T item, int index) function) {
    final list = <E>[];
    asMap().forEach((index, element) {
      list.add(function(element, index));
    });
    return list;
  }
}
