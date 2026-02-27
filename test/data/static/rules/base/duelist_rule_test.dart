import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/data/static/rules/base/duelist_rule.dart';
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
  group('DuelistRule', () {
    late DuelistRule rule;
    late ModelBase base;

    setUp(() {
      rule = const DuelistRule();
      base = ModelBase(
        'Test Model',
        tv: 10,
        roles: {Role.gp},
        movement: Movement([MovementType.walker], 6),
        armor: Armor(5),
        hullStructure: HullStructure(hull: 4, structure: 3),
        actions: UnitActions(2),
        gu: Skill(4),
        pi: Skill(5),
        ew: Skill(6),
        traits: const [],
        height: 1.5,
        classification: Classification.gear,
      );
    });

    Model buildModel(
      int id, {
      UnitLevel level = UnitLevel.regular,
      bool isDuelist = false,
    }) {
      return Model(
        id: id,
        base: base,
        variant: Variant('Test Model', id: 'variant-$id', tv: 0),
        level: level,
        isDuelist: isDuelist,
      );
    }

    test('allows assignment when limit is not reached', () {
      final assetTable = AssetTable(
        greenSquads: 1,
        veteranSquads: 1,
        eliteSquads: 1,
        duelistOrAces: 2,
      );
      final squad1 = Squad(
        id: 1,
        name: 'Squad 1',
        primaryRole: Role.gp,
        models: [buildModel(1, isDuelist: true)],
      );
      final squad2 = Squad(
        id: 2,
        name: 'Squad 2',
        primaryRole: Role.gp,
        models: [buildModel(2)],
      );

      final canAssign = rule.canAssignDuelist(
        model: squad2.models.first,
        newDuelistStatus: true,
        squad: squad2,
        allSquads: [squad1, squad2],
        assetTable: assetTable,
      );

      expect(canAssign, true);
    });

    test('blocks duelist assignment when limit is reached', () {
      final assetTable = AssetTable(
        greenSquads: 1,
        veteranSquads: 1,
        eliteSquads: 1,
        duelistOrAces: 1,
      );
      final squad1 = Squad(
        id: 1,
        name: 'Squad 1',
        primaryRole: Role.gp,
        models: [buildModel(1, isDuelist: true)],
      );
      final squad2 = Squad(
        id: 2,
        name: 'Squad 2',
        primaryRole: Role.gp,
        models: [buildModel(2)],
      );

      final canAssign = rule.canAssignDuelist(
        model: squad2.models.first,
        newDuelistStatus: true,
        squad: squad2,
        allSquads: [squad1, squad2],
        assetTable: assetTable,
      );

      expect(canAssign, false);
    });

    test('allows unlimited duelists when asset table has no limit', () {
      final assetTable = AssetTable.unlimited();
      final squad1 = Squad(
        id: 1,
        name: 'Squad 1',
        primaryRole: Role.gp,
        models: [
          buildModel(1, isDuelist: true),
          buildModel(2, isDuelist: true),
        ],
      );
      final squad2 = Squad(
        id: 2,
        name: 'Squad 2',
        primaryRole: Role.gp,
        models: [buildModel(3)],
      );

      final canAssign = rule.canAssignDuelist(
        model: squad2.models.first,
        newDuelistStatus: true,
        squad: squad2,
        allSquads: [squad1, squad2],
        assetTable: assetTable,
      );

      expect(canAssign, true);
    });

    test('blocks green unit from becoming duelist', () {
      final assetTable = AssetTable(
        greenSquads: 1,
        veteranSquads: 1,
        eliteSquads: 1,
        duelistOrAces: 2,
      );
      final squad = Squad(
        id: 1,
        name: 'Squad 1',
        primaryRole: Role.gp,
        models: [buildModel(1, level: UnitLevel.green)],
      );

      final canAssign = rule.canAssignDuelist(
        model: squad.models.first,
        newDuelistStatus: true,
        squad: squad,
        allSquads: [squad],
        assetTable: assetTable,
      );

      expect(canAssign, false);
    });

    test('allows removing duelist status', () {
      final assetTable = AssetTable(
        greenSquads: 1,
        veteranSquads: 1,
        eliteSquads: 1,
        duelistOrAces: 0,
      );
      final squad = Squad(
        id: 1,
        name: 'Squad 1',
        primaryRole: Role.gp,
        models: [buildModel(1, isDuelist: true)],
      );

      final canAssign = rule.canAssignDuelist(
        model: squad.models.first,
        newDuelistStatus: false,
        squad: squad,
        allSquads: [squad],
        assetTable: assetTable,
      );

      expect(canAssign, true);
    });

    test('allows assigning same duelist status (no change)', () {
      final assetTable = AssetTable(
        greenSquads: 1,
        veteranSquads: 1,
        eliteSquads: 1,
        duelistOrAces: 0,
      );
      final squad = Squad(
        id: 1,
        name: 'Squad 1',
        primaryRole: Role.gp,
        models: [buildModel(1, isDuelist: true)],
      );

      final canAssign = rule.canAssignDuelist(
        model: squad.models.first,
        newDuelistStatus: true,
        squad: squad,
        allSquads: [squad],
        assetTable: assetTable,
      );

      expect(canAssign, true);
    });

    test('counts duelists correctly across multiple squads', () {
      final assetTable = AssetTable(
        greenSquads: 1,
        veteranSquads: 1,
        eliteSquads: 1,
        duelistOrAces: 2,
      );
      final squad1 = Squad(
        id: 1,
        name: 'Squad 1',
        primaryRole: Role.gp,
        models: [buildModel(1, isDuelist: true), buildModel(2)],
      );
      final squad2 = Squad(
        id: 2,
        name: 'Squad 2',
        primaryRole: Role.gp,
        models: [buildModel(3, isDuelist: true), buildModel(4)],
      );

      // Trying to make a third duelist should fail
      final canAssign = rule.canAssignDuelist(
        model: squad1.models[1],
        newDuelistStatus: true,
        squad: squad1,
        allSquads: [squad1, squad2],
        assetTable: assetTable,
      );

      expect(canAssign, false);
    });
  });
}
