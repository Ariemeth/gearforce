import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'weapon_range.g.dart';

@immutable
@JsonSerializable()
class WeaponRange {
  @JsonKey(name: 'min')
  final int? minOptimal;
  @JsonKey(name: 'opt')
  final int? maxOptimal;
  final int? max;

  const WeaponRange({this.minOptimal, this.maxOptimal, this.max})
    : assert(
        minOptimal == null || minOptimal >= 0,
        'Minimum range must be null or 0 or positive',
      ),
      assert(
        maxOptimal == null || (minOptimal == null || maxOptimal >= minOptimal),
        'Normal range must be greater than or equal to minimum range if both are provided',
      ),
      assert(
        max == null || (maxOptimal != null && max > maxOptimal),
        'Max range must be greater than or equal to normal range if provided',
      );

  factory WeaponRange.fromJson(Map<String, dynamic> json) =>
      _$WeaponRangeFromJson(json);

  Map<String, dynamic> toJson() => _$WeaponRangeToJson(this);

  @override
  String toString() {
    final minOptimalStr = minOptimal != null ? 'Min: $minOptimal, ' : '';
    final maxOptimalStr = maxOptimal != null ? 'Normal: $maxOptimal, ' : '';
    final maxStr = max != null ? 'Max: $max' : '';
    return '$minOptimalStr$maxOptimalStr$maxStr'.trim();
  }

  String shortString() {
    final minOptimalStr = minOptimal != null ? '$minOptimal' : '';
    final maxOptimalStr = maxOptimal != null ? '$maxOptimal' : '';
    final maxStr = max != null ? '$max' : '';
    return '$minOptimalStr-$maxOptimalStr/$maxStr'.trim();
  }
}
