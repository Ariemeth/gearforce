import 'package:meta/meta.dart';

@immutable
class ModelActions {
  final int value;

  const ModelActions(
    this.value,
  ) : assert(value >= 0, 'Action value must be 0 or positive');

  @override
  String toString() {
    return '$value'; // Return the value as a string
  }
}
