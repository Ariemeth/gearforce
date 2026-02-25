// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelBase _$ModelBaseFromJson(Map<String, dynamic> json) => ModelBase(
  json['name'] as String,
  tv: (json['tv'] as num).toInt(),
  roles: (json['roles'] as List<dynamic>)
      .map((e) => $enumDecode(_$RoleEnumMap, e))
      .toSet(),
  movement: Movement.fromJson(json['movement'] as Map<String, dynamic>),
  armor: Armor.fromJson(json['armor']),
  hullStructure: HullStructure.fromJson(
    json['hullStructure'] as Map<String, dynamic>,
  ),
  actions: UnitActions.fromJson(json['actions']),
  gu: Skill.fromJson(json['gu']),
  pi: Skill.fromJson(json['pi']),
  ew: Skill.fromJson(json['ew']),
  weapons: const WeaponSpecListConverter().fromJson(json['weapons'] as List),
  traits: const TraitListConverter().fromJson(json['traits'] as List),
  height: (json['height'] as num).toDouble(),
  classification: $enumDecode(_$ClassificationEnumMap, json['classification']),
  subtype: json['subtype'] as String?,
  manufacturer: json['manufacturer'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$ModelBaseToJson(ModelBase instance) => <String, dynamic>{
  'name': instance.name,
  'tv': instance.tv,
  'roles': instance.roles.map((e) => _$RoleEnumMap[e]!).toList(),
  'movement': instance.movement,
  'armor': instance.armor,
  'hullStructure': instance.hullStructure,
  'actions': instance.actions,
  'gu': instance.gu,
  'pi': instance.pi,
  'ew': instance.ew,
  'weapons': const WeaponSpecListConverter().toJson(instance.weapons),
  'traits': const TraitListConverter().toJson(instance.traits),
  'height': instance.height,
  'classification': _$ClassificationEnumMap[instance.classification]!,
  'subtype': instance.subtype,
  'manufacturer': instance.manufacturer,
  'description': instance.description,
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

const _$ClassificationEnumMap = {
  Classification.cavalry: 'Cavalry',
  Classification.counter: 'Counter',
  Classification.fortifications: 'Fortifications',
  Classification.gear: 'Gear',
  Classification.infantry: 'Infantry',
  Classification.strider: 'Strider',
  Classification.terrain: 'Terrain',
  Classification.unknown: 'Unknown',
};
