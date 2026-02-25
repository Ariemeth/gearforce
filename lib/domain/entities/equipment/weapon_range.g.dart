// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weapon_range.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeaponRange _$WeaponRangeFromJson(Map<String, dynamic> json) => WeaponRange(
  minOptimal: (json['min'] as num?)?.toInt(),
  maxOptimal: (json['opt'] as num?)?.toInt(),
  max: (json['max'] as num?)?.toInt(),
);

Map<String, dynamic> _$WeaponRangeToJson(WeaponRange instance) =>
    <String, dynamic>{
      'min': instance.minOptimal,
      'opt': instance.maxOptimal,
      'max': instance.max,
    };
