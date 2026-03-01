// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Unit _$UnitFromJson(Map<String, dynamic> json) => Unit(
  ModelBase.fromJson(json['base'] as Map<String, dynamic>),
  id: json['id'] as String,
  variants:
      (json['variants'] as List<dynamic>?)
          ?.map((e) => Variant.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  availableUnitUpgrades:
      (json['upgrades'] as List<dynamic>?)
          ?.map((e) => ModelUpgrade.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$UnitToJson(Unit instance) => <String, dynamic>{
  'id': instance.id,
  'base': instance.base,
  'variants': instance.variants,
  'upgrades': instance.availableUnitUpgrades,
};
