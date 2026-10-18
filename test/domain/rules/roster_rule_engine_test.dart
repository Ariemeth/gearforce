import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/domain/entities/attribute/armor.dart';
import 'package:gearforce/domain/entities/attribute/classification.dart';
import 'package:gearforce/domain/entities/attribute/command.dart';
import 'package:gearforce/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/movement_type.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/attribute/skill.dart';
import 'package:gearforce/domain/entities/attribute/unit_actions.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/model_base.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/unit/variant.dart';
import 'package:gearforce/domain/rules/default_rule_set.dart';
import 'package:gearforce/domain/rules/roster_rule_engine.dart';

void main() {
  Model buildModel({
    required int id,
    int tv = 10,
    Command command = Command.none,
  }) {
    return Model(
      id: id,
      base: ModelBase(
        'Hunter',
        unitId: 'hunter',
        tv: tv,
        roles: const {Role.gp},
        movement: const Movement([MovementType.walker], 6),
        armor: const Armor(5),
        hullStructure: const HullStructure(hull: 2, structure: 2),
        actions: const UnitActions(1),
        gu: const Skill(4),
        pi: const Skill(4),
        ew: const Skill(4),
        height: 1.5,
        classification: Classification.gear,
      ),
      variant: Variant('Hunter Standard', id: 'v1', tv: 0),
      command: command,
    );
  }

  group('RosterRuleEngine Calculations', () {
    test('calculateTotalTv sums TV across all squads', () {
      final squad1 = Squad(
        id: 1,
        name: 'Squad 1',
        primaryRole: Role.gp,
        models: [buildModel(id: 1, tv: 10), buildModel(id: 2, tv: 12)],
      );

      final squad2 = Squad(
        id: 2,
        name: 'Squad 2',
        primaryRole: Role.sk,
        models: [buildModel(id: 3, tv: 15)],
      );

      expect(RosterRuleEngine.calculateTotalTv([squad1, squad2]), 37);
    });

    test('calculateModelCount counts total models in force', () {
      final squad1 = Squad(
        id: 1,
        name: 'Squad 1',
        primaryRole: Role.gp,
        models: [buildModel(id: 1), buildModel(id: 2)],
      );

      final squad2 = Squad(
        id: 2,
        name: 'Squad 2',
        primaryRole: Role.sk,
        models: [buildModel(id: 3)],
      );

      expect(RosterRuleEngine.calculateModelCount([squad1, squad2]), 3);
    });

    test('calculateActivationCount counts squads', () {
      final squads = [
        Squad(id: 1, name: 'S1', primaryRole: Role.gp, models: const []),
        Squad(id: 2, name: 'S2', primaryRole: Role.sk, models: const []),
      ];

      expect(RosterRuleEngine.calculateActivationCount(squads), 2);
    });

    test('calculateTotalCp calculates CPs for command levels', () {
      final squad = Squad(
        id: 1,
        name: 'Squad 1',
        primaryRole: Role.gp,
        models: [
          buildModel(id: 1, command: Command.co),
          buildModel(id: 2, command: Command.xo),
          buildModel(id: 3, command: Command.firstIC),
          buildModel(id: 4, command: Command.secondIC),
          buildModel(id: 5, command: Command.none),
        ],
      );

      // CO(3) + XO(2) + 1iC(1) + 2iC(1) = 7
      expect(RosterRuleEngine.calculateTotalCp([squad]), 7);
    });
  });

  group('RosterRuleEngine Validation', () {
    test('validateRoster returns error if squads list is empty', () {
      final result = RosterRuleEngine.validateRoster(
        squads: [],
        ruleSet: DefaultRuleSet(),
      );

      expect(result.isValid, isFalse);
      expect(result.errors, contains('Force requires at least one squad.'));
    });

    test('validateRoster returns valid for complete squad', () {
      final squad = Squad(
        id: 1,
        name: 'Squad 1',
        primaryRole: Role.gp,
        models: [
          buildModel(id: 1, command: Command.firstIC),
          buildModel(id: 2),
          buildModel(id: 3),
          buildModel(id: 4),
        ],
      );

      final result = RosterRuleEngine.validateRoster(
        squads: [squad],
        ruleSet: DefaultRuleSet(),
      );

      expect(result.isValid, isTrue);
      expect(result.errors, isEmpty);
    });
  });
}
