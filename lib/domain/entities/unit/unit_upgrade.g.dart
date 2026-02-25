// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_upgrade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitUpgrade _$UnitUpgradeFromJson(Map<String, dynamic> json) => UnitUpgrade(
  json['name'] as String,
  id: json['id'] as String,
  description: json['description'] as String? ?? '',
);

Map<String, dynamic> _$UnitUpgradeToJson(UnitUpgrade instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'name': instance.name,
    };
