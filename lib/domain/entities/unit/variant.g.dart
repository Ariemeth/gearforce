// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Variant _$VariantFromJson(Map<String, dynamic> json) => Variant(
  json['name'] as String,
  id: json['id'] as String,
  tv: (json['tv'] as num).toInt(),
  roles: (json['roles'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$RoleEnumMap, e))
      .toSet(),
  movement: json['movement'] == null
      ? null
      : Movement.fromJson(json['movement'] as Map<String, dynamic>),
  armor: json['armor'] == null ? null : Armor.fromJson(json['armor']),
  hullStructure: json['hullStructure'] == null
      ? null
      : HullStructure.fromJson(json['hullStructure'] as Map<String, dynamic>),
  actions: json['actions'] == null
      ? null
      : UnitActions.fromJson(json['actions']),
  gu: json['gu'] == null ? null : Skill.fromJson(json['gu']),
  pi: json['pi'] == null ? null : Skill.fromJson(json['pi']),
  ew: json['ew'] == null ? null : Skill.fromJson(json['ew']),
  weapons: _$JsonConverterFromJson<List<dynamic>, List<WeaponSpec>>(
    json['weapons'],
    const WeaponSpecListConverter().fromJson,
  ),
  traits: _$JsonConverterFromJson<List<dynamic>, List<Trait>>(
    json['traits'],
    const TraitListConverter().fromJson,
  ),
);

Map<String, dynamic> _$VariantToJson(Variant instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'tv': instance.tv,
  'roles': instance.roles?.map((e) => _$RoleEnumMap[e]!).toList(),
  'movement': instance.movement,
  'armor': instance.armor,
  'hullStructure': instance.hullStructure,
  'actions': instance.actions,
  'gu': instance.gu,
  'pi': instance.pi,
  'ew': instance.ew,
  'weapons': _$JsonConverterToJson<List<dynamic>, List<WeaponSpec>>(
    instance.weapons,
    const WeaponSpecListConverter().toJson,
  ),
  'traits': _$JsonConverterToJson<List<dynamic>, List<Trait>>(
    instance.traits,
    const TraitListConverter().toJson,
  ),
};

const _$RoleEnumMap = {
  Role.gp: 'GP',
  Role.sk: 'SK',
  Role.rc: 'RC',
  Role.fs: 'FS',
  Role.so: 'SO',
  Role.eg: 'EG',
  Role.mb: 'MB',
  Role.as: 'AS',
  Role.ft: 'FT',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
