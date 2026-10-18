import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/domain/rules/base/unit_level_rule.dart';
import 'package:gearforce/domain/entities/attribute/armor.dart';
import 'package:gearforce/domain/entities/attribute/classification.dart';
import 'package:gearforce/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/movement_type.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/attribute/skill.dart';
import 'package:gearforce/domain/entities/attribute/unit_actions.dart';
import 'package:gearforce/domain/entities/attribute/unit_level.dart';
import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/model_base.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/unit/variant.dart';

void main() {
  group('UnitLevelRule', () {
    late UnitLevelRule rule;
    late ModelBase base;

    setUp(() {
      rule = const UnitLevelRule();
      base = const ModelBase(
        'Test Model',
        unitId: 'test-unit',
        tv: 10,
        roles: {Role.gp},
        movement: Movement([MovementType.walker], 6),
        armor: Armor(5),
        hullStructure: HullStructure(hull: 4, structure: 3),
        actions: UnitActions(2),
        gu: Skill(4),
        pi: Skill(5),
        ew: Skill(6),
        traits: [],
        height: 1.5,
        classification: Classification.gear,
      );
    });

    Model buildModel(int id, {UnitLevel level = UnitLevel.regular}) {
      return Model(
        id: id,
        base: base,
        variant: Variant('Test Model', id: 'variant-$id', tv: 0),
        level: level,
      );
    }

    test('allows assignment when limit is not reached', () {
      const assetTable = AssetTable(
        greenSquads: 1,
        veteranSquads: 1,
        eliteSquads: 1,
      );
      final squad1 = Squad(
        id: 1,
        name: 'Squad 1',
        primaryRole: Role.gp,
        models: [buildModel(1)],
      );
      final squad2 = Squad(
        id: 2,
        name: 'Squad 2',
        primaryRole: Role.gp,
        models: [buildModel(2)],
      );

      final canAssign = rule.canAssignUnitLevel(
        model: squad1.models.first,
        newLevel: UnitLevel.green,
        squad: squad1,
        allSquads: [squad1, squad2],
        assetTable: assetTable,
      );

      expect(canAssign, true);
    });

    test('blocks assignment when limit is reached by another squad', () {
      const assetTable = AssetTable(
        greenSquads: 1,
        veteranSquads: 1,
        eliteSquads: 1,
      );
      final squad1 = Squad(
        id: 1,
        name: 'Squad 1',
        primaryRole: Role.gp,
        models: [buildModel(1, level: UnitLevel.green)],
      );
      final squad2 = Squad(
        id: 2,
        name: 'Squad 2',
        primaryRole: Role.gp,
        models: [buildModel(2)],
      );

      final canAssign = rule.canAssignUnitLevel(
        model: squad2.models.first,
        newLevel: UnitLevel.green,
        squad: squad2,
        allSquads: [squad1, squad2],
        assetTable: assetTable,
      );

      expect(canAssign, false);
    });

    test('allows assignment when squad already uses that level slot', () {
      const assetTable = AssetTable(
        greenSquads: 1,
        veteranSquads: 1,
        eliteSquads: 1,
      );
      final squad1 = Squad(
        id: 1,
        name: 'Squad 1',
        primaryRole: Role.gp,
        models: [
          buildModel(1, level: UnitLevel.green),
          buildModel(2),
        ],
      );
      final squad2 = Squad(
        id: 2,
        name: 'Squad 2',
        primaryRole: Role.gp,
        models: [buildModel(3)],
      );

      final canAssign = rule.canAssignUnitLevel(
        model: squad1.models[1],
        newLevel: UnitLevel.green,
        squad: squad1,
        allSquads: [squad1, squad2],
        assetTable: assetTable,
      );

      expect(canAssign, true);
    });

    test('blocks veteran assignment when veteran limit is reached', () {
      const assetTable = AssetTable(
        greenSquads: 1,
        veteranSquads: 1,
        eliteSquads: 1,
      );
      final squad1 = Squad(
        id: 1,
        name: 'Squad 1',
        primaryRole: Role.gp,
        models: [buildModel(1, level: UnitLevel.veteran)],
      );
      final squad2 = Squad(
        id: 2,
        name: 'Squad 2',
        primaryRole: Role.gp,
        models: [buildModel(2)],
      );

      final canAssign = rule.canAssignUnitLevel(
        model: squad2.models.first,
        newLevel: UnitLevel.veteran,
        squad: squad2,
        allSquads: [squad1, squad2],
        assetTable: assetTable,
      );

      expect(canAssign, false);
    });
  });
}
