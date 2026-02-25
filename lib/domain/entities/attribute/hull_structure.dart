import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'hull_structure.g.dart';

@immutable
@JsonSerializable()
class HullStructure {
  final int hull;
  final int structure;

  const HullStructure({required this.hull, required this.structure})
    : assert(hull >= 0, 'Hull value must be 0 or positive'),
      assert(structure >= 0, 'Structure value must be 0 or positive');

  factory HullStructure.fromJson(Map<String, dynamic> json) =>
      _$HullStructureFromJson(json);

  Map<String, dynamic> toJson() => _$HullStructureToJson(this);

  HullStructure copyWith({int? hull, int? structure}) {
    return HullStructure(
      hull: hull ?? this.hull,
      structure: structure ?? this.structure,
    );
  }

  @override
  String toString() {
    if (hull == 0 && structure == 0) {
      return '-';
    }
    return '$hull/$structure';
  }
}
