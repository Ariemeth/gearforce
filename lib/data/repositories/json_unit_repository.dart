import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
import 'package:gearforce/domain/entities/equipment/weapon_parser.dart';
import 'package:gearforce/domain/entities/attribute/armor.dart';
import 'package:gearforce/domain/entities/attribute/classification.dart';
import 'package:gearforce/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/movement_type.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/attribute/skill.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/entities/attribute/unit_actions.dart';
import 'package:gearforce/domain/entities/unit/unit_upgrade.dart';
import 'package:gearforce/domain/entities/unit/variant.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/data/static/mod_functions.dart';
import 'package:gearforce/data/static/trait_factory.dart';

class JsonUnitRepository implements UnitRepository {
  final Map<String, List<Unit>> _cache = {};

  @override
  Future<List<Unit>> getUnitsByFaction(String factionId) async {
    final lowerFactionId = factionId.toLowerCase();
    if (_cache.containsKey(lowerFactionId)) {
      return _cache[lowerFactionId]!;
    }

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/units/$lowerFactionId.json',
      );
      final List<dynamic> jsonData = json.decode(jsonString);
      final List<Unit> units = jsonData.map((data) => parseUnit(data)).toList();
      _cache[lowerFactionId] = units;
      return units;
    } catch (e) {
      print('Error loading units for $factionId: $e');
      return [];
    }
  }

  @visibleForTesting
  Unit parseUnit(Map<String, dynamic> data) {
    return Unit.fromJson(data);
  }

  Role _parseRole(String role) {
    return Role.values.firstWhere((r) => r.abbreviation == role);
  }

  Movement _parseMovement(Map<String, dynamic> data) {
    return Movement(
      (data['types'] as List).map((t) => _parseMovementType(t)).toList(),
      data['value'],
    );
  }

  MovementType _parseMovementType(String type) {
    return MovementType.values.firstWhere((t) => t.abbreviation == type);
  }

  Classification _parseClassification(String classification) {
    return Classification.values.firstWhere(
      (c) => c.name.toLowerCase() == classification.toLowerCase(),
      orElse: () => Classification.unknown,
    );
  }

  Variant _parseVariant(Map<String, dynamic> data) {
    return Variant(
      data['name'],
      id: data['id'],
      tv: data['tv'],
      roles: data['roles'] != null
          ? (data['roles'] as List).map((r) => _parseRole(r)).toSet()
          : null,
      movement: data['movement'] != null
          ? _parseMovement(data['movement'])
          : null,
      armor: data['armor'] != null ? Armor(data['armor']) : null,
      hullStructure: data['hull'] != null
          ? HullStructure(hull: data['hull'], structure: data['structure'])
          : null,
      actions: data['actions'] != null ? UnitActions(data['actions']) : null,
      gu: data['gu'] != null ? Skill(data['gu']) : null,
      pi: data['pi'] != null ? Skill(data['pi']) : null,
      ew: data['ew'] != null ? Skill(data['ew']) : null,
      weapons: data['weapons'] != null
          ? (data['weapons'] as List)
                .map((w) => WeaponParser.parseWeaponString(w))
                .toList()
          : null,
      traits: data['traits'] != null
          ? (data['traits'] as List)
                .map((t) => TraitFactory.traitFromString(t))
                .toList()
          : null,
    );
  }

  UnitUpgrade _parseUpgrade(Map<String, dynamic> data) {
    return UnitUpgrade(
      data['name'],
      id: data['id'],
      description: data['description'] ?? '',
      tvMod: createIntAdjustmentMod(data['tv'] ?? 0),
      hullStructureMod: data['hull'] != null
          ? createHullStructureSetMod(h: data['hull'], s: data['structure'])
          : (v, c) => v,
      traitsMod: data['traits'] != null
          ? createAddTraitsMod(
              (data['traits'] as List)
                  .map((t) => TraitFactory.traitFromString(t))
                  .toList(),
            )
          : (v, c) => v,
      weaponsMod: data['weapons'] != null
          ? createAddWeaponsMod(
              (data['weapons'] as List)
                  .map((w) => WeaponParser.parseWeaponString(w))
                  .toList(),
            )
          : (v, c) => v,
    );
  }
}
