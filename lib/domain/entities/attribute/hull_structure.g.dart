// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hull_structure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HullStructure _$HullStructureFromJson(Map<String, dynamic> json) =>
    HullStructure(
      hull: (json['hull'] as num).toInt(),
      structure: (json['structure'] as num).toInt(),
    );

Map<String, dynamic> _$HullStructureToJson(HullStructure instance) =>
    <String, dynamic>{'hull': instance.hull, 'structure': instance.structure};
