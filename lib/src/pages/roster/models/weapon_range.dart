import 'package:meta/meta.dart';

@immutable
class WeaponRange {
  final int? minOptimal;
  final int? maxOptimal;
  final int? max;

  const WeaponRange({
    this.minOptimal,
    this.maxOptimal,
    this.max,
  })  : assert(minOptimal == null || minOptimal >= 0,
            'Minimum range must be null or 0 or positive'),
        assert(
            maxOptimal == null ||
                (minOptimal == null || maxOptimal >= minOptimal),
            'Normal range must be greater than or equal to minimum range if both are provided'),
        assert(max == null || (maxOptimal != null && max > maxOptimal),
            'Max range must be greater than or equal to normal range if provided');

  @override
  String toString() {
    final minOptimalStr = minOptimal != null ? 'Min: $minOptimal, ' : '';
    final maxOptimalStr = maxOptimal != null ? 'Normal: $maxOptimal, ' : '';
    final maxStr = max != null ? 'Max: $max' : '';
    return '$minOptimalStr$maxOptimalStr$maxStr'.trim();
  }
}
