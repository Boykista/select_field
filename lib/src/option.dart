/// `label` is what is shown in menu.
///
/// `value` is the "content".
class Option<T> {
  final String label;
  final T value;

  Option({
    required this.label,
    required this.value,
  });

  @override
  bool operator ==(Object other) {
    if (other is Option<T>) {
      return this.label == other.label && this.value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => label.hashCode + value.hashCode;
}
