import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/data/static/rules/base/command_level_rule.dart';
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

void main() {
  group('CommandLevelRule', () {
    late CommandLevelRule rule;
    late Model model1;
    late Model model2;
    late Model model3;
    late Squad squad1;
    late Squad squad2;

    setUp(() {
      rule = const CommandLevelRule();

      final base = ModelBase(
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
        weapons: [],
        traits: [],
        height: 1.5,
        classification: Classification.gear,
      );

      model1 = Model(
        id: 1,
        base: base,
        variant: Variant('Test Model', id: '1', tv: 0),
      );

      model2 = Model(
        id: 2,
        base: base,
        variant: Variant('Test Model', id: '1', tv: 0),
      );

      model3 = Model(
        id: 3,
        base: base,
        variant: Variant('Test Model', id: '1', tv: 0),
      );

      squad1 = Squad(
        id: 1,
        name: 'Squad 1',
        primaryRole: Role.gp,
        models: [model1, model2],
        upgrades: const [],
      );

      squad2 = Squad(
        id: 2,
        name: 'Squad 2',
        primaryRole: Role.gp,
        models: [model3],
        upgrades: const [],
      );
    });

    test('should allow assigning Command.none to any model', () {
      expect(
        rule.canAssignCommandLevel(
          model: model1,
          newCommandLevel: Command.none,
          squad: squad1,
          allSquads: [squad1, squad2],
        ),
        true,
      );
    });

    group('required command presence', () {
      test('should require one of 1iC, CO, or XO', () {
        expect(rule.hasRequiredCommand(squad1.models), false);

        final squadWith1iC = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.firstIC),
            model2,
          ],
        );

        expect(rule.hasRequiredCommand(squadWith1iC.models), true);
      });

      test('should treat CO or XO as satisfying the requirement', () {
        final squadWithCO = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.co),
            model2,
          ],
        );

        final squadWithXO = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.xo),
            model2,
          ],
        );

        expect(rule.hasRequiredCommand(squadWithCO.models), true);
        expect(rule.hasRequiredCommand(squadWithXO.models), true);
      });
    });

    group('1iC constraints', () {
      test(
        'should allow assigning 1iC to a model when no other 1iC exists',
        () {
          expect(
            rule.canAssignCommandLevel(
              model: model1,
              newCommandLevel: Command.firstIC,
              squad: squad1,
              allSquads: [squad1, squad2],
            ),
            true,
          );
        },
      );

      test('should not allow multiple 1iC in the same squad', () {
        final squadWith1iC = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.firstIC),
            model2,
          ],
        );

        expect(
          rule.canAssignCommandLevel(
            model: model2,
            newCommandLevel: Command.firstIC,
            squad: squadWith1iC,
            allSquads: [squadWith1iC, squad2],
          ),
          false,
        );
      });

      test('should not allow 1iC in squad that has CO', () {
        final squadWithCO = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.co),
            model2,
          ],
        );

        expect(
          rule.canAssignCommandLevel(
            model: model2,
            newCommandLevel: Command.firstIC,
            squad: squadWithCO,
            allSquads: [squadWithCO, squad2],
          ),
          false,
        );
      });

      test('should not allow 1iC in squad that has XO', () {
        final squadWithXO = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.xo),
            model2,
          ],
        );

        expect(
          rule.canAssignCommandLevel(
            model: model2,
            newCommandLevel: Command.firstIC,
            squad: squadWithXO,
            allSquads: [squadWithXO, squad2],
          ),
          false,
        );
      });
    });

    group('2iC constraints', () {
      test(
        'should allow assigning 2iC to a model when no other 2iC exists',
        () {
          expect(
            rule.canAssignCommandLevel(
              model: model1,
              newCommandLevel: Command.secondIC,
              squad: squad1,
              allSquads: [squad1, squad2],
            ),
            true,
          );
        },
      );

      test('should not allow multiple 2iC in the same squad', () {
        final squadWith2iC = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.secondIC),
            model2,
          ],
        );

        expect(
          rule.canAssignCommandLevel(
            model: model2,
            newCommandLevel: Command.secondIC,
            squad: squadWith2iC,
            allSquads: [squadWith2iC, squad2],
          ),
          false,
        );
      });

      test('should allow 2iC in squad that has 1iC', () {
        final squadWith1iC = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.firstIC),
            model2,
          ],
        );

        expect(
          rule.canAssignCommandLevel(
            model: model2,
            newCommandLevel: Command.secondIC,
            squad: squadWith1iC,
            allSquads: [squadWith1iC, squad2],
          ),
          true,
        );
      });

      test('should allow 2iC in squad that has XO', () {
        final squadWithXO = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.xo),
            model2,
          ],
        );

        expect(
          rule.canAssignCommandLevel(
            model: model2,
            newCommandLevel: Command.secondIC,
            squad: squadWithXO,
            allSquads: [squadWithXO, squad2],
          ),
          true,
        );
      });
    });

    group('CO constraints', () {
      test('should allow assigning CO when no other CO exists in roster', () {
        expect(
          rule.canAssignCommandLevel(
            model: model1,
            newCommandLevel: Command.co,
            squad: squad1,
            allSquads: [squad1, squad2],
          ),
          true,
        );
      });

      test('should not allow multiple CO in the roster', () {
        final squad2WithCO = squad2.copyWith(
          models: [model3.copyWith(command: Command.co)],
        );

        expect(
          rule.canAssignCommandLevel(
            model: model1,
            newCommandLevel: Command.co,
            squad: squad1,
            allSquads: [squad1, squad2WithCO],
          ),
          false,
        );
      });

      test('should not allow CO in squad that has 1iC', () {
        final squadWith1iC = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.firstIC),
            model2,
          ],
        );

        expect(
          rule.canAssignCommandLevel(
            model: model2,
            newCommandLevel: Command.co,
            squad: squadWith1iC,
            allSquads: [squadWith1iC, squad2],
          ),
          false,
        );
      });

      test('should not allow CO in squad that has XO', () {
        final squadWithXO = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.xo),
            model2,
          ],
        );

        expect(
          rule.canAssignCommandLevel(
            model: model2,
            newCommandLevel: Command.co,
            squad: squadWithXO,
            allSquads: [squadWithXO, squad2],
          ),
          true,
        );
      });
    });

    group('XO constraints', () {
      test('should allow assigning XO when no other XO exists in roster', () {
        expect(
          rule.canAssignCommandLevel(
            model: model1,
            newCommandLevel: Command.xo,
            squad: squad1,
            allSquads: [squad1, squad2],
          ),
          true,
        );
      });

      test('should not allow multiple XO in the roster', () {
        final squad2WithXO = squad2.copyWith(
          models: [model3.copyWith(command: Command.xo)],
        );

        expect(
          rule.canAssignCommandLevel(
            model: model1,
            newCommandLevel: Command.xo,
            squad: squad1,
            allSquads: [squad1, squad2WithXO],
          ),
          false,
        );
      });

      test('should not allow XO in squad that has 1iC', () {
        final squadWith1iC = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.firstIC),
            model2,
          ],
        );

        expect(
          rule.canAssignCommandLevel(
            model: model2,
            newCommandLevel: Command.xo,
            squad: squadWith1iC,
            allSquads: [squadWith1iC, squad2],
          ),
          false,
        );
      });

      test('should not allow XO in squad that has CO', () {
        final squadWithCO = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.co),
            model2,
          ],
        );

        expect(
          rule.canAssignCommandLevel(
            model: model2,
            newCommandLevel: Command.xo,
            squad: squadWithCO,
            allSquads: [squadWithCO, squad2],
          ),
          true,
        );
      });

      test('should allow XO in squad that has 2iC', () {
        final squadWith2iC = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.secondIC),
            model2,
          ],
        );

        expect(
          rule.canAssignCommandLevel(
            model: model2,
            newCommandLevel: Command.xo,
            squad: squadWith2iC,
            allSquads: [squadWith2iC, squad2],
          ),
          true,
        );
      });
    });

    group('role constraints for command assignments', () {
      late Model modelWithGPRole;
      late Model modelWithStrikeRole;
      late Squad squadWithGPRole;

      setUp(() {
        final baseGP = ModelBase(
          'GP Model',
          tv: 10,
          roles: {Role.gp},
          movement: Movement([MovementType.walker], 6),
          armor: Armor(5),
          hullStructure: HullStructure(hull: 4, structure: 3),
          actions: UnitActions(2),
          gu: Skill(4),
          pi: Skill(5),
          ew: Skill(6),
          weapons: [],
          traits: [],
          height: 1.5,
          classification: Classification.gear,
        );

        final baseStrike = ModelBase(
          'Strike Model',
          tv: 8,
          roles: {Role.sk},
          movement: Movement([MovementType.walker], 8),
          armor: Armor(3),
          hullStructure: HullStructure(hull: 3, structure: 2),
          actions: UnitActions(3),
          gu: Skill(3),
          pi: Skill(4),
          ew: Skill(5),
          weapons: [],
          traits: [],
          height: 1.0,
          classification: Classification.gear,
        );

        modelWithGPRole = Model(
          id: 10,
          base: baseGP,
          variant: Variant('GP Model', id: '1', tv: 0),
        );

        modelWithStrikeRole = Model(
          id: 11,
          base: baseStrike,
          variant: Variant('Strike Model', id: '1', tv: 0),
        );

        squadWithGPRole = Squad(
          id: 10,
          name: 'GP Squad',
          primaryRole: Role.gp,
          models: [modelWithGPRole, modelWithStrikeRole],
          upgrades: const [],
        );
      });

      test(
        'should allow 1iC assignment to model with matching primary role',
        () {
          expect(
            rule.canAssignCommandLevel(
              model: modelWithGPRole,
              newCommandLevel: Command.firstIC,
              squad: squadWithGPRole,
              allSquads: [squadWithGPRole],
            ),
            true,
          );
        },
      );

      test(
        'should not allow 1iC assignment to model without matching primary role',
        () {
          expect(
            rule.canAssignCommandLevel(
              model: modelWithStrikeRole,
              newCommandLevel: Command.firstIC,
              squad: squadWithGPRole,
              allSquads: [squadWithGPRole],
            ),
            false,
          );
        },
      );

      test(
        'should allow CO assignment to model with matching primary role',
        () {
          expect(
            rule.canAssignCommandLevel(
              model: modelWithGPRole,
              newCommandLevel: Command.co,
              squad: squadWithGPRole,
              allSquads: [squadWithGPRole],
            ),
            true,
          );
        },
      );

      test(
        'should not allow CO assignment to model without matching primary role',
        () {
          expect(
            rule.canAssignCommandLevel(
              model: modelWithStrikeRole,
              newCommandLevel: Command.co,
              squad: squadWithGPRole,
              allSquads: [squadWithGPRole],
            ),
            false,
          );
        },
      );

      test(
        'should allow XO assignment to model with matching primary role',
        () {
          expect(
            rule.canAssignCommandLevel(
              model: modelWithGPRole,
              newCommandLevel: Command.xo,
              squad: squadWithGPRole,
              allSquads: [squadWithGPRole],
            ),
            true,
          );
        },
      );

      test(
        'should not allow XO assignment to model without matching primary role',
        () {
          expect(
            rule.canAssignCommandLevel(
              model: modelWithStrikeRole,
              newCommandLevel: Command.xo,
              squad: squadWithGPRole,
              allSquads: [squadWithGPRole],
            ),
            false,
          );
        },
      );

      test('should allow 2iC assignment to any model (role not required)', () {
        expect(
          rule.canAssignCommandLevel(
            model: modelWithStrikeRole,
            newCommandLevel: Command.secondIC,
            squad: squadWithGPRole,
            allSquads: [squadWithGPRole],
          ),
          true,
        );
      });

      test(
        'should return error message when model lacks required role for 1iC',
        () {
          final message = rule.getValidationMessage(
            model: modelWithStrikeRole,
            newCommandLevel: Command.firstIC,
            squad: squadWithGPRole,
            allSquads: [squadWithGPRole],
          );

          expect(message, isNotNull);
          expect(message, contains('required role'));
          expect(message, contains('GP'));
        },
      );

      test(
        'should return error message when model lacks required role for CO',
        () {
          final message = rule.getValidationMessage(
            model: modelWithStrikeRole,
            newCommandLevel: Command.co,
            squad: squadWithGPRole,
            allSquads: [squadWithGPRole],
          );

          expect(message, isNotNull);
          expect(message, contains('required role'));
          expect(message, contains('GP'));
        },
      );

      test(
        'should return error message when model lacks required role for XO',
        () {
          final message = rule.getValidationMessage(
            model: modelWithStrikeRole,
            newCommandLevel: Command.xo,
            squad: squadWithGPRole,
            allSquads: [squadWithGPRole],
          );

          expect(message, isNotNull);
          expect(message, contains('required role'));
          expect(message, contains('GP'));
        },
      );
    });

    group('validation messages', () {
      test('should return null for valid assignments', () {
        expect(
          rule.getValidationMessage(
            model: model1,
            newCommandLevel: Command.none,
            squad: squad1,
            allSquads: [squad1, squad2],
          ),
          null,
        );

        expect(
          rule.getValidationMessage(
            model: model1,
            newCommandLevel: Command.firstIC,
            squad: squad1,
            allSquads: [squad1, squad2],
          ),
          null,
        );
      });

      test('should return message when 1iC already exists in squad', () {
        final squadWith1iC = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.firstIC),
            model2,
          ],
        );

        final message = rule.getValidationMessage(
          model: model2,
          newCommandLevel: Command.firstIC,
          squad: squadWith1iC,
          allSquads: [squadWith1iC, squad2],
        );

        expect(message, isNotNull);
        expect(message, contains('already has a 1iC'));
      });

      test('should return message when CO already exists in roster', () {
        final squad2WithCO = squad2.copyWith(
          models: [model3.copyWith(command: Command.co)],
        );

        final message = rule.getValidationMessage(
          model: model1,
          newCommandLevel: Command.co,
          squad: squad1,
          allSquads: [squad1, squad2WithCO],
        );

        expect(message, isNotNull);
        expect(message, contains('already has a CO'));
      });

      test('should return message about squad exclusivity', () {
        final squadWith1iC = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.firstIC),
            model2,
          ],
        );

        final message = rule.getValidationMessage(
          model: model2,
          newCommandLevel: Command.co,
          squad: squadWith1iC,
          allSquads: [squadWith1iC, squad2],
        );

        expect(message, isNotNull);
        expect(message, contains('cannot have a 1iC alongside a CO'));
      });

      test('should return null message when XO coexists with 2iC', () {
        final squadWith2iC = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.secondIC),
            model2,
          ],
        );

        final message = rule.getValidationMessage(
          model: model2,
          newCommandLevel: Command.xo,
          squad: squadWith2iC,
          allSquads: [squadWith2iC, squad2],
        );

        expect(message, isNull);
      });
    });

    group('getModelsToClear', () {
      test('should return empty list for Command.none', () {
        final modelsToClear = rule.getModelsToClear(
          model: model1,
          newCommandLevel: Command.none,
          squad: squad1,
          allSquads: [squad1, squad2],
        );

        expect(modelsToClear, isEmpty);
      });

      test('should identify existing 1iC to clear when assigning new 1iC', () {
        final squadWith1iC = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.firstIC),
            model2,
          ],
        );

        final modelsToClear = rule.getModelsToClear(
          model: model2,
          newCommandLevel: Command.firstIC,
          squad: squadWith1iC,
          allSquads: [squadWith1iC, squad2],
        );

        expect(modelsToClear, hasLength(1));
        expect(modelsToClear.first.model.id, model1.id);
        expect(modelsToClear.first.squad.id, squad1.id);
      });

      test('should identify CO to clear when assigning 1iC in same squad', () {
        final squadWithCO = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.co),
            model2,
          ],
        );

        final modelsToClear = rule.getModelsToClear(
          model: model2,
          newCommandLevel: Command.firstIC,
          squad: squadWithCO,
          allSquads: [squadWithCO, squad2],
        );

        expect(modelsToClear, hasLength(1));
        expect(modelsToClear.first.model.id, model1.id);
        expect(modelsToClear.first.model.command, Command.co);
      });

      test('should identify XO to clear when assigning 1iC in same squad', () {
        final squadWithXO = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.xo),
            model2,
          ],
        );

        final modelsToClear = rule.getModelsToClear(
          model: model2,
          newCommandLevel: Command.firstIC,
          squad: squadWithXO,
          allSquads: [squadWithXO, squad2],
        );

        expect(modelsToClear, hasLength(1));
        expect(modelsToClear.first.model.id, model1.id);
        expect(modelsToClear.first.model.command, Command.xo);
      });

      test('should identify existing 2iC to clear when assigning new 2iC', () {
        final squadWith2iC = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.secondIC),
            model2,
          ],
        );

        final modelsToClear = rule.getModelsToClear(
          model: model2,
          newCommandLevel: Command.secondIC,
          squad: squadWith2iC,
          allSquads: [squadWith2iC, squad2],
        );

        expect(modelsToClear, hasLength(1));
        expect(modelsToClear.first.model.id, model1.id);
      });

      test('should not clear XO when assigning 2iC in same squad', () {
        final squadWithXO = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.xo),
            model2,
          ],
        );

        final modelsToClear = rule.getModelsToClear(
          model: model2,
          newCommandLevel: Command.secondIC,
          squad: squadWithXO,
          allSquads: [squadWithXO, squad2],
        );

        expect(modelsToClear, isEmpty);
      });

      test(
        'should identify CO in other squad to clear when assigning new CO',
        () {
          final squad2WithCO = squad2.copyWith(
            models: [model3.copyWith(command: Command.co)],
          );

          final modelsToClear = rule.getModelsToClear(
            model: model1,
            newCommandLevel: Command.co,
            squad: squad1,
            allSquads: [squad1, squad2WithCO],
          );

          expect(modelsToClear, hasLength(1));
          expect(modelsToClear.first.model.id, model3.id);
          expect(modelsToClear.first.squad.id, squad2.id);
        },
      );

      test('should identify 1iC to clear when assigning CO in same squad', () {
        final squadWith1iC = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.firstIC),
            model2,
          ],
        );

        final modelsToClear = rule.getModelsToClear(
          model: model2,
          newCommandLevel: Command.co,
          squad: squadWith1iC,
          allSquads: [squadWith1iC, squad2],
        );

        expect(modelsToClear, hasLength(1));
        expect(modelsToClear.first.model.id, model1.id);
      });

      test(
        'should identify XO in other squad to clear when assigning new XO',
        () {
          final squad2WithXO = squad2.copyWith(
            models: [model3.copyWith(command: Command.xo)],
          );

          final modelsToClear = rule.getModelsToClear(
            model: model1,
            newCommandLevel: Command.xo,
            squad: squad1,
            allSquads: [squad1, squad2WithXO],
          );

          expect(modelsToClear, hasLength(1));
          expect(modelsToClear.first.model.id, model3.id);
          expect(modelsToClear.first.squad.id, squad2.id);
        },
      );

      test('should not clear 2iC when assigning XO in same squad', () {
        final squadWith2iC = squad1.copyWith(
          models: [
            model1.copyWith(command: Command.secondIC),
            model2,
          ],
        );

        final modelsToClear = rule.getModelsToClear(
          model: model2,
          newCommandLevel: Command.xo,
          squad: squadWith2iC,
          allSquads: [squadWith2iC, squad2],
        );

        expect(modelsToClear, isEmpty);
      });

      test(
        'should identify multiple models to clear when assigning CO with conflicts',
        () {
          final squadWith1iC = squad1.copyWith(
            models: [
              model1.copyWith(command: Command.firstIC),
              model2,
            ],
          );
          final squad2WithCO = squad2.copyWith(
            models: [model3.copyWith(command: Command.co)],
          );

          final modelsToClear = rule.getModelsToClear(
            model: model2,
            newCommandLevel: Command.co,
            squad: squadWith1iC,
            allSquads: [squadWith1iC, squad2WithCO],
          );

          expect(modelsToClear, hasLength(2));
          expect(modelsToClear.any((e) => e.model.id == model1.id), true);
          expect(modelsToClear.any((e) => e.model.id == model3.id), true);
        },
      );
    });
  });
}
