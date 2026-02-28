// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_upgrade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelUpgrade _$ModelUpgradeFromJson(Map<String, dynamic> json) => ModelUpgrade(
  json['name'] as String,
  id: json['id'] as String,
  description: json['description'] as String? ?? '',
);

Map<String, dynamic> _$ModelUpgradeToJson(ModelUpgrade instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'name': instance.name,
    };
