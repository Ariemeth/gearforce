import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/data/static/rules/default_rule_set.dart';
import 'package:gearforce/domain/entities/attribute/armor.dart';
import 'package:gearforce/domain/entities/attribute/classification.dart';
import 'package:gearforce/domain/entities/attribute/command.dart';
import 'package:gearforce/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/movement_type.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/attribute/skill.dart';
import 'package:gearforce/domain/entities/attribute/unit_actions.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/rule.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/data/static/rules/base/squad_size_rule.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/model_base.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/entities/unit/variant.dart';

void main() {
  group('RuleSet squad size rules', () {
    test('includes standard rules by default', () {
      final ruleSet = DefaultRuleSet();

      expect(ruleSet.rules.length, 3);
      expect(ruleSet.rules.first, isA<SquadSizeRule>());
      expect((ruleSet.rules.first as SquadSizeRule).id, 'squad-size-rule');
    });

    test('activeRules returns only enabled rules', () {
      final ruleSet = _TestRuleSet(
        extraRules: const [
          Rule(
            name: 'Disabled Rule',
            id: 'disabled-rule',
            description: 'Disabled test rule',
            isEnabled: false,
          ),
        ],
      );

      expect(ruleSet.activeRules.length, 3);
      expect(ruleSet.activeRules.first.id, 'squad-size-rule');
    });

    test('specialized rulesets can include extra rules', () {
      final ruleSet = _TestRuleSet(
        extraRules: const [
          Rule(
            name: 'North Extra Rule',
            id: 'north-extra-rule',
            description: 'Example specialized rule',
          ),
        ],
      );

      expect(ruleSet.rules.length, 4);
      expect(ruleSet.rules.first.id, 'squad-size-rule');
      expect(ruleSet.rules.last.id, 'north-extra-rule');
    });

    test('default squad size rule field is included in rules', () {
      final ruleSet = _TestRuleSet(
        extraRules: const [
          Rule(
            name: 'Non Squad Rule',
            id: 'non-squad-rule',
            description: 'Does not define squad sizing',
          ),
        ],
      );

      expect(ruleSet.squadSizeRule, isA<SquadSizeRule>());
      expect(ruleSet.squadSizeRule.id, 'squad-size-rule');
      expect(ruleSet.rules.any((rule) => rule is SquadSizeRule), isTrue);
    });

    test('uses base squad size rule when extra SquadSizeRule is disabled', () {
      final ruleSet = _TestRuleSet(
        extraRules: const [
          SquadSizeRule(
            id: 'override-squad-size',
            name: 'Override Squad Size',
            description: 'Override list rule',
            isEnabled: false,
            minimumEffectiveUnits: 1,
            maximumUnits: 1,
          ),
        ],
      );

      final squad = _buildSquad([_buildModel(id: 1)]);
      expect(
        ruleSet.canAddUnitToSquad(squad: squad, unit: _buildModel(id: 2)),
        isTrue,
      );
    });

    test('uses last active SquadSizeRule when multiple are present', () {
      final ruleSet = _TestRuleSet(
        extraRules: const [
          SquadSizeRule(
            id: 'override-squad-size-1',
            name: 'Override Squad Size 1',
            description: 'First override list rule',
            minimumEffectiveUnits: 2,
            maximumUnits: 5,
          ),
          SquadSizeRule(
            id: 'override-squad-size-2',
            name: 'Override Squad Size 2',
            description: 'Second override list rule',
            minimumEffectiveUnits: 1,
            maximumUnits: 1,
          ),
        ],
      );

      final squad = _buildSquad([_buildModel(id: 1)]);
      expect(
        ruleSet.canAddUnitToSquad(squad: squad, unit: _buildModel(id: 2)),
        isFalse,
      );
    });

    test('allows additional disabled SquadSizeRule in extraRules', () {
      final ruleSet = _TestRuleSet(
        extraRules: const [
          SquadSizeRule(
            id: 'disabled-override-squad-size',
            name: 'Disabled Override Squad Size',
            description: 'Disabled override list rule',
            isEnabled: false,
            minimumEffectiveUnits: 2,
            maximumUnits: 5,
          ),
        ],
      );

      expect(ruleSet.rules.whereType<SquadSizeRule>().length, 2);
      expect(ruleSet.activeRules.whereType<SquadSizeRule>().length, 1);
    });

    test('counts units with 2+ actions as 2 effective units', () {
      final ruleSet = DefaultRuleSet();
      final squad = _buildSquad([
        _buildModel(id: 1, actions: 2, command: Command.firstIC),
        _buildModel(id: 2, actions: 2),
      ]);

      expect(ruleSet.getEffectiveSquadUnitCount(squad), 4);
      expect(ruleSet.isSquadComplete(squad), isTrue);
    });

    test('counts Repair and Medic units as 2 effective units', () {
      final ruleSet = DefaultRuleSet();
      final squad = _buildSquad([
        _buildModel(
          id: 1,
          traits: const [Trait.repair(level: 1)],
          command: Command.firstIC,
        ),
        _buildModel(id: 2, traits: const [Trait.medic(level: 1)]),
      ]);

      expect(ruleSet.getEffectiveSquadUnitCount(squad), 4);
      expect(ruleSet.isSquadComplete(squad), isTrue);
    });

    test('allows adding units up to 9 total models', () {
      final ruleSet = DefaultRuleSet();
      final squad = _buildSquad(
        List<Model>.generate(8, (index) => _buildModel(id: index + 1)),
      );

      expect(
        ruleSet.canAddUnitToSquad(squad: squad, unit: _buildModel(id: 99)),
        isTrue,
      );
    });

    test(
      'disallows adding a 10th model even if weighted count would exceed 9',
      () {
        final ruleSet = DefaultRuleSet();
        final squad = _buildSquad([
          _buildModel(id: 1, actions: 2, command: Command.firstIC),
          ...List<Model>.generate(
            8,
            (index) => _buildModel(id: index + 2, actions: 2),
          ),
        ]);

        expect(ruleSet.getEffectiveSquadUnitCount(squad), 18);
        expect(ruleSet.isSquadComplete(squad), isTrue);
        expect(
          ruleSet.canAddUnitToSquad(squad: squad, unit: _buildModel(id: 100)),
          isFalse,
        );
      },
    );
  });
}

Squad _buildSquad(List<Model> models) {
  return Squad(id: 1, name: 'Test Squad', primaryRole: Role.gp, models: models);
}

Model _buildModel({
  required int id,
  int actions = 1,
  List<Trait> traits = const [],
  Command command = Command.none,
}) {
  return Model(
    id: id,
    base: ModelBase(
      'Test Unit',
      tv: 0,
      roles: {Role.gp},
      movement: Movement([MovementType.walker], 6),
      armor: Armor(5),
      hullStructure: HullStructure(hull: 2, structure: 2),
      actions: UnitActions(actions),
      gu: Skill(4),
      pi: Skill(4),
      ew: Skill(4),
      traits: traits,
      height: 1.5,
      classification: Classification.gear,
    ),
    variant: Variant('Test Unit', id: 'variant-$id', tv: 0),
    command: command,
  );
}

class _TestRuleSet extends RuleSet {
  const _TestRuleSet({super.extraRules = const []})
    : super(name: 'Test RuleSet', assetTable: const AssetTable.unlimited());

  @override
  Future<List<Unit>> getAvailableUnits() async {
    return const [];
  }
}
