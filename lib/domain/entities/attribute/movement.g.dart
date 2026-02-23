// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movement _$MovementFromJson(Map<String, dynamic> json) => Movement(
  (json['types'] as List<dynamic>)
      .map((e) => $enumDecode(_$MovementTypeEnumMap, e))
      .toList(),
  (json['value'] as num).toInt(),
);

Map<String, dynamic> _$MovementToJson(Movement instance) => <String, dynamic>{
  'types': instance.types.map((e) => _$MovementTypeEnumMap[e]!).toList(),
  'value': instance.value,
};

const _$MovementTypeEnumMap = {
  MovementType.walker: 'W',
  MovementType.ground: 'G',
  MovementType.hover: 'H',
};
