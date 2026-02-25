// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weapon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weapon _$WeaponFromJson(Map<String, dynamic> json) => Weapon(
  baseCode: json['code'] as String,
  name: json['name'] as String,
  range: WeaponRange.fromJson(json['range'] as Map<String, dynamic>),
  modes: (json['modes'] as List<dynamic>)
      .map((e) => $enumDecode(_$WeaponModeEnumMap, e))
      .toSet(),
  baseTraits: json['traits'] == null
      ? const []
      : const TraitListConverter().fromJson(json['traits'] as List),
  baseAlternateTraits: json['altTraits'] == null
      ? const []
      : const TraitListConverter().fromJson(json['altTraits'] as List),
  damageBands: DamageSizeBands.fromJson(json['damage'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WeaponToJson(Weapon instance) => <String, dynamic>{
  'code': instance.baseCode,
  'name': instance.name,
  'range': instance.range,
  'modes': instance.modes.map((e) => _$WeaponModeEnumMap[e]!).toList(),
  'traits': const TraitListConverter().toJson(instance.baseTraits),
  'altTraits': const TraitListConverter().toJson(instance.baseAlternateTraits),
  'damage': instance.damageBands,
};

const _$WeaponModeEnumMap = {
  WeaponMode.direct: 'direct',
  WeaponMode.indirect: 'indirect',
};
