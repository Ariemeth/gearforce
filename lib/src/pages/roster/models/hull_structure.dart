import 'package:meta/meta.dart';

@immutable
class HullStructure {
  final int hull;
  final int structure;

  const HullStructure({
    required this.hull,
    required this.structure,
  })  : assert(hull >= 0, 'Hull value must be 0 or positive'),
        assert(structure >= 0, 'Structure value must be 0 or positive');

  @override
  String toString() {
    if (hull == 0 && structure == 0) {
      return '-';
    }
    return '$hull/$structure';
  }
}
