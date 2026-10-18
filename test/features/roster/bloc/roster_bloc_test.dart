import 'package:bloc_test/bloc_test.dart';
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
import 'package:gearforce/domain/entities/attribute/unit_level.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/subfaction.dart';
import 'package:gearforce/domain/entities/unit/model_base.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/entities/unit/variant.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';

class MockUnitRepository implements UnitRepository {
  @override
  Future<List<Unit>> getUnitsByFaction(Faction faction) async {
    return const [];
  }

  @override
  Future<Unit?> getUnitById(String unitId) async {
    return null;
  }
}

ModelBase _createTestModelBase({
  String name = 'Test Gear',
  int tv = 8,
  Set<Role> roles = const {Role.gp, Role.sk},
}) {
  return ModelBase(
    name,
    unitId: 'test-unit',
    tv: tv,
    roles: roles,
    movement: const Movement([MovementType.walker], 6),
    armor: const Armor(5),
    hullStructure: const HullStructure(hull: 4, structure: 3),
    actions: const UnitActions(1),
    gu: const Skill(4),
    pi: const Skill(5),
    ew: const Skill(6),
    height: 1.5,
    classification: Classification.gear,
  );
}

Variant _createTestVariant({String name = 'Test Gear', String id = 'V1'}) {
  return Variant(name, id: id, tv: 0);
}

void main() {
  late MockUnitRepository mockUnitRepository;

  setUp(() {
    mockUnitRepository = MockUnitRepository();
  });

  group('RosterCubit initial state', () {
    test('has correct initial values', () {
      final cubit = RosterCubit(mockUnitRepository);
      expect(cubit.state, isA<RosterInitial>());
      expect(cubit.state.playerName, '');
      expect(cubit.state.rosterName, '');
      expect(cubit.state.squads, isEmpty);
      expect(cubit.state.selectedFaction, Faction.north);
      expect(cubit.state.selectedSubfaction, Faction.north.subfactions.first);
      cubit.close();
    });
  });

  group('UpdatePlayerName', () {
    blocTest<RosterCubit, RosterState>(
      'emits state with updated player name',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) => cubit.updatePlayerName('John'),
      expect: () => [
        isA<RosterState>().having((s) => s.playerName, 'playerName', 'John'),
      ],
    );
  });

  group('UpdateRosterName', () {
    blocTest<RosterCubit, RosterState>(
      'emits state with updated roster name',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) => cubit.updateRosterName('My Roster'),
      expect: () => [
        isA<RosterState>().having(
          (s) => s.rosterName,
          'rosterName',
          'My Roster',
        ),
      ],
    );
  });

  group('AddNewSquad', () {
    blocTest<RosterCubit, RosterState>(
      'adds a squad with default role',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) => cubit.addNewSquad(name: 'Alpha Squad'),
      expect: () => [
        isA<RosterState>().having((s) => s.squads.length, 'squad count', 1),
      ],
      verify: (cubit) {
        final squad = cubit.state.squads.first;
        expect(squad.name, 'Alpha Squad');
        expect(squad.primaryRole, Role.gp);
        expect(squad.secondaryRole, isNull);
        expect(squad.models, isEmpty);
      },
    );

    blocTest<RosterCubit, RosterState>(
      'adds a squad with specified roles',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) => cubit.addNewSquad(
        name: 'Strike Team',
        primaryRole: Role.sk,
        secondaryRole: Role.gp,
      ),
      verify: (cubit) {
        final squad = cubit.state.squads.first;
        expect(squad.primaryRole, Role.sk);
        expect(squad.secondaryRole, Role.gp);
      },
    );

    blocTest<RosterCubit, RosterState>(
      'adds multiple squads with unique IDs',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) {
        cubit.addNewSquad(name: 'Squad A');
        cubit.addNewSquad(name: 'Squad B');
        cubit.addNewSquad(name: 'Squad C');
      },
      verify: (cubit) {
        expect(cubit.state.squads.length, 3);
        final ids = cubit.state.squads.map((s) => s.id).toSet();
        expect(ids.length, 3, reason: 'All squad IDs should be unique');
      },
    );
  });

  group('RemoveSquad', () {
    blocTest<RosterCubit, RosterState>(
      'removes the specified squad',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Only Squad');
        await Future<void>.delayed(Duration.zero);
        final squad = cubit.state.squads.first;
        cubit.removeSquad(squad);
      },
      verify: (cubit) {
        expect(cubit.state.squads, isEmpty);
      },
    );

    blocTest<RosterCubit, RosterState>(
      'removes correct squad when multiple exist',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Keep');
        cubit.addNewSquad(name: 'Remove');
        await Future<void>.delayed(Duration.zero);
        // After both are added, remove the second
        final squadToRemove = cubit.state.squads.firstWhere(
          (s) => s.name == 'Remove',
        );
        cubit.removeSquad(squadToRemove);
      },
      verify: (cubit) {
        expect(cubit.state.squads.length, 1);
        expect(cubit.state.squads.first.name, 'Keep');
      },
    );
  });

  group('DuplicateSquad', () {
    blocTest<RosterCubit, RosterState>(
      'duplicates squad with copied models and unique squad/model IDs',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Alpha');
        await Future<void>.delayed(Duration.zero);

        var squad = cubit.state.squads.first;
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(id: 'V1'),
        );
        await Future<void>.delayed(Duration.zero);

        squad = cubit.state.squads.first;
        cubit.duplicateSquad(squad: squad, name: 'Squad 2');
      },
      verify: (cubit) {
        expect(cubit.state.squads.length, 2);

        final original = cubit.state.squads[0];
        final duplicate = cubit.state.squads[1];

        expect(duplicate.name, 'Squad 2');
        expect(duplicate.id, isNot(original.id));
        expect(duplicate.models.length, original.models.length);

        if (original.models.isNotEmpty && duplicate.models.isNotEmpty) {
          expect(duplicate.models.first.id, isNot(original.models.first.id));
        }
      },
    );

    blocTest<RosterCubit, RosterState>(
      'does not duplicate CO command level when duplicating a squad',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Command Squad');
        await Future<void>.delayed(Duration.zero);

        var squad = cubit.state.squads.first;
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(id: 'V1'),
        );
        await Future<void>.delayed(Duration.zero);

        squad = cubit.state.squads.first;
        final model = squad.models.first;
        cubit.updateModelCommandLevel(
          squad: squad,
          model: model,
          commandLevel: Command.co,
        );
        await Future<void>.delayed(Duration.zero);

        squad = cubit.state.squads.first;
        cubit.duplicateSquad(squad: squad, name: 'Squad 2');
      },
      verify: (cubit) {
        final allModels = cubit.state.squads.expand((s) => s.models).toList();
        final coCount = allModels.where((m) => m.command == Command.co).length;
        expect(coCount, 1);
      },
    );
  });

  group('RenameSquad', () {
    blocTest<RosterCubit, RosterState>(
      'renames the specified squad',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Old Name');
        await Future<void>.delayed(Duration.zero);
        final squad = cubit.state.squads.first;
        cubit.renameSquad(squad: squad, newName: 'New Name');
      },
      verify: (cubit) {
        expect(cubit.state.squads.first.name, 'New Name');
      },
    );
  });

  group('AddModel', () {
    blocTest<RosterCubit, RosterState>(
      'adds a model to the specified squad',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Model Squad');
        await Future<void>.delayed(Duration.zero);
        final squad = cubit.state.squads.first;
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(),
        );
      },
      verify: (cubit) {
        expect(cubit.state.squads.first.models.length, 1);
        expect(cubit.state.squads.first.models.first.base.name, 'Test Gear');
      },
    );

    blocTest<RosterCubit, RosterState>(
      'auto-assigns 1iC when squad has no command',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Command Squad');
        await Future<void>.delayed(Duration.zero);
        final squad = cubit.state.squads.first;
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(),
        );
      },
      verify: (cubit) {
        final model = cubit.state.squads.first.models.first;
        expect(model.command, Command.firstIC);
      },
    );
  });

  group('RemoveModel', () {
    blocTest<RosterCubit, RosterState>(
      'removes a model from the specified squad',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Test Squad');
        await Future<void>.delayed(Duration.zero);
        final squad = cubit.state.squads.first;
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(),
        );
        await Future<void>.delayed(Duration.zero);
        final updatedSquad = cubit.state.squads.first;
        final model = updatedSquad.models.first;
        cubit.removeModel(squad: updatedSquad, model: model);
      },
      verify: (cubit) {
        expect(cubit.state.squads.first.models, isEmpty);
      },
    );

    blocTest<RosterCubit, RosterState>(
      'promotes another model to 1iC when current 1iC is removed',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Command Reassign Squad');
        await Future<void>.delayed(Duration.zero);

        var squad = cubit.state.squads.first;
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(id: 'V1'),
        );
        await Future<void>.delayed(Duration.zero);

        squad = cubit.state.squads.first;
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(id: 'V2'),
        );
        await Future<void>.delayed(Duration.zero);

        squad = cubit.state.squads.first;
        final firstIcModel = squad.models.firstWhere(
          (model) => model.command == Command.firstIC,
        );

        cubit.removeModel(squad: squad, model: firstIcModel);
      },
      verify: (cubit) {
        final models = cubit.state.squads.first.models;
        expect(models.length, 1);
        expect(models.single.command, Command.firstIC);
      },
    );
  });

  group('DuplicateModel', () {
    blocTest<RosterCubit, RosterState>(
      'duplicates model with command reset and conditional level/duelist copy',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Duplicate Model Squad');
        await Future<void>.delayed(Duration.zero);

        var squad = cubit.state.squads.first;
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(),
        );
        await Future<void>.delayed(Duration.zero);

        squad = cubit.state.squads.first;
        var sourceModel = squad.models.first;

        cubit.updateModelLevel(
          squad: squad,
          model: sourceModel,
          level: UnitLevel.veteran,
        );
        await Future<void>.delayed(Duration.zero);

        squad = cubit.state.squads.first;
        sourceModel = squad.models.first;
        cubit.updateModelIsDuelist(
          squad: squad,
          model: sourceModel,
          isDuelist: true,
        );
        await Future<void>.delayed(Duration.zero);

        squad = cubit.state.squads.first;
        sourceModel = squad.models.first;
        cubit.duplicateModel(squad: squad, model: sourceModel);
      },
      verify: (cubit) {
        final squad = cubit.state.squads.first;
        expect(squad.models.length, 2);

        final sourceModel = squad.models[0];
        final duplicatedModel = squad.models[1];

        final expectedBaseModel = sourceModel.copyWith(
          id: duplicatedModel.id,
          command: Command.none,
          level: UnitLevel.regular,
          isDuelist: false,
        );

        final canCopyLevel = cubit.state.ruleSet.canAssignUnitLevel(
          model: expectedBaseModel,
          newLevel: sourceModel.level,
          squad: squad,
          allSquads: cubit.state.squads,
        );
        final expectedLevel = canCopyLevel
            ? sourceModel.level
            : UnitLevel.regular;

        final modelAfterLevel = expectedBaseModel.copyWith(
          level: expectedLevel,
        );
        final canCopyDuelist =
            sourceModel.isDuelist &&
            cubit.state.ruleSet.canAssignDuelist(
              model: modelAfterLevel,
              newDuelistStatus: true,
              squad: squad,
              allSquads: cubit.state.squads,
            );

        expect(duplicatedModel.command, Command.none);
        expect(duplicatedModel.level, expectedLevel);
        expect(duplicatedModel.isDuelist, canCopyDuelist);
      },
    );
  });

  group('UpdateModelLevel', () {
    blocTest<RosterCubit, RosterState>(
      'updates model level to veteran',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Level Squad');
        await Future<void>.delayed(Duration.zero);
        final squad = cubit.state.squads.first;
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(),
        );
        await Future<void>.delayed(Duration.zero);
        final updatedSquad = cubit.state.squads.first;
        final model = updatedSquad.models.first;
        cubit.updateModelLevel(
          squad: updatedSquad,
          model: model,
          level: UnitLevel.veteran,
        );
      },
      verify: (cubit) {
        expect(cubit.state.squads.first.models.first.level, UnitLevel.veteran);
      },
    );

    blocTest<RosterCubit, RosterState>(
      'does not auto-promote to 2iC when 2iC becomes green',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        // Create squad with GP role
        cubit.addNewSquad(name: 'Auto Promote Squad', primaryRole: Role.gp);
        await Future<void>.delayed(Duration.zero);
        var squad = cubit.state.squads.first;

        // Add model 1 (will auto-become 1iC)
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(id: 'V1'),
        );
        await Future<void>.delayed(Duration.zero);
        squad = cubit.state.squads.first;

        // Add model 2 (will become 2iC)
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(id: 'V2'),
        );
        await Future<void>.delayed(Duration.zero);
        squad = cubit.state.squads.first;

        // Add model 3
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(id: 'V3'),
        );
        await Future<void>.delayed(Duration.zero);
        squad = cubit.state.squads.first;
        final model2 = squad.models[1];

        // Make model2 the 2iC
        cubit.updateModelCommandLevel(
          squad: squad,
          model: model2,
          commandLevel: Command.secondIC,
        );
        await Future<void>.delayed(Duration.zero);
        squad = cubit.state.squads.first;

        // Now make model2 green - model3 should NOT be promoted
        var updatedModel2 = squad.models.firstWhere((m) => m.id == model2.id);
        cubit.updateModelLevel(
          squad: squad,
          model: updatedModel2,
          level: UnitLevel.green,
        );
      },
      verify: (cubit) {
        final squad = cubit.state.squads.first;
        final model2 = squad.models[1];
        final model3 = squad.models[2];

        // model2 should be green with no command
        expect(model2.level, UnitLevel.green);
        expect(model2.command, Command.none);

        // model3 should not be promoted (remains none)
        expect(model3.command, Command.none);
      },
    );

    blocTest<RosterCubit, RosterState>(
      'auto-promotes another unit to 1iC when 1iC becomes green',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        // Create squad with GP role
        cubit.addNewSquad(name: 'Promote to 1iC Squad', primaryRole: Role.gp);
        await Future<void>.delayed(Duration.zero);
        var squad = cubit.state.squads.first;

        // Add model 1 (will auto-become 1iC)
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(id: 'V1'),
        );
        await Future<void>.delayed(Duration.zero);
        squad = cubit.state.squads.first;

        // Add model 2
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(id: 'V2'),
        );
        await Future<void>.delayed(Duration.zero);
        squad = cubit.state.squads.first;
        final model1 = squad.models[0];

        // Make model1 green - model2 should be promoted to 1iC
        cubit.updateModelLevel(
          squad: squad,
          model: model1,
          level: UnitLevel.green,
        );
      },
      verify: (cubit) {
        final squad = cubit.state.squads.first;
        final model1 = squad.models[0];
        final model2 = squad.models[1];

        // model1 should be green with no command
        expect(model1.level, UnitLevel.green);
        expect(model1.command, Command.none);

        // model2 should be promoted to 1iC
        expect(model2.command, Command.firstIC);
      },
    );

    blocTest<RosterCubit, RosterState>(
      'auto-assigns 1iC when unit changes from green back to regular',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        // Create squad with GP role
        cubit.addNewSquad(name: 'Auto Assign Squad', primaryRole: Role.gp);
        await Future<void>.delayed(Duration.zero);
        var squad = cubit.state.squads.first;

        // Add only model (will auto-become 1iC)
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(),
        );
        await Future<void>.delayed(Duration.zero);
        squad = cubit.state.squads.first;

        // Make it green (command should become none)
        var model = squad.models.first;
        cubit.updateModelLevel(
          squad: squad,
          model: model,
          level: UnitLevel.green,
        );
        await Future<void>.delayed(Duration.zero);
        squad = cubit.state.squads.first;

        // Change it back to regular - should become 1iC
        model = squad.models.first;
        cubit.updateModelLevel(
          squad: squad,
          model: model,
          level: UnitLevel.regular,
        );
      },
      verify: (cubit) {
        final model = cubit.state.squads.first.models.first;
        expect(model.level, UnitLevel.regular);
        expect(model.command, Command.firstIC);
      },
    );
  });

  group('UpdateModelIsDuelist', () {
    blocTest<RosterCubit, RosterState>(
      'marks model as duelist',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Duelist Squad');
        await Future<void>.delayed(Duration.zero);
        final squad = cubit.state.squads.first;
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(),
        );
        await Future<void>.delayed(Duration.zero);
        final updatedSquad = cubit.state.squads.first;
        final model = updatedSquad.models.first;
        cubit.updateModelIsDuelist(
          squad: updatedSquad,
          model: model,
          isDuelist: true,
        );
      },
      verify: (cubit) {
        expect(cubit.state.squads.first.models.first.isDuelist, isTrue);
      },
    );
  });

  group('UpdateModelCommandLevel', () {
    blocTest<RosterCubit, RosterState>(
      'updates model command level',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Command Squad');
        await Future<void>.delayed(Duration.zero);
        final squad = cubit.state.squads.first;
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(),
        );
        await Future<void>.delayed(Duration.zero);
        final updatedSquad = cubit.state.squads.first;
        final model = updatedSquad.models.first;
        cubit.updateModelCommandLevel(
          squad: updatedSquad,
          model: model,
          commandLevel: Command.co,
        );
      },
      verify: (cubit) {
        expect(cubit.state.squads.first.models.first.command, Command.co);
      },
    );

    blocTest<RosterCubit, RosterState>(
      'automatically clears conflicting command level in same squad',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Command Squad');
        await Future<void>.delayed(Duration.zero);
        var squad = cubit.state.squads.first;

        // Add two models
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(),
        );
        await Future<void>.delayed(Duration.zero);
        squad = cubit.state.squads.first;
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(),
        );
        await Future<void>.delayed(Duration.zero);

        // Assign 1iC to first model
        squad = cubit.state.squads.first;
        final model1 = squad.models[0];
        cubit.updateModelCommandLevel(
          squad: squad,
          model: model1,
          commandLevel: Command.firstIC,
        );
        await Future<void>.delayed(Duration.zero);

        // Assign CO to second model (should clear 1iC from first)
        squad = cubit.state.squads.first;
        final model2 = squad.models[1];
        cubit.updateModelCommandLevel(
          squad: squad,
          model: model2,
          commandLevel: Command.co,
        );
      },
      verify: (cubit) {
        final squad = cubit.state.squads.first;
        expect(squad.models[0].command, Command.none);
        expect(squad.models[1].command, Command.co);
      },
    );

    blocTest<RosterCubit, RosterState>(
      'automatically clears conflicting command level across squads',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        // Add first squad with CO
        cubit.addNewSquad(name: 'Squad 1');
        await Future<void>.delayed(Duration.zero);
        var squad1 = cubit.state.squads.first;
        cubit.addModel(
          squad: squad1,
          base: _createTestModelBase(),
          variant: _createTestVariant(),
        );
        await Future<void>.delayed(Duration.zero);
        squad1 = cubit.state.squads.first;
        final model1 = squad1.models.first;
        cubit.updateModelCommandLevel(
          squad: squad1,
          model: model1,
          commandLevel: Command.co,
        );
        await Future<void>.delayed(Duration.zero);

        // Add second squad and assign CO to it (should clear CO from first squad)
        cubit.addNewSquad(name: 'Squad 2');
        await Future<void>.delayed(Duration.zero);
        final squad2 = cubit.state.squads.last;
        cubit.addModel(
          squad: squad2,
          base: _createTestModelBase(),
          variant: _createTestVariant(),
        );
        await Future<void>.delayed(Duration.zero);
        final updatedSquad2 = cubit.state.squads.last;
        final model2 = updatedSquad2.models.first;
        cubit.updateModelCommandLevel(
          squad: updatedSquad2,
          model: model2,
          commandLevel: Command.co,
        );
      },
      verify: (cubit) {
        expect(cubit.state.squads, hasLength(2));
        expect(cubit.state.squads[0].models.first.command, Command.firstIC);
        expect(cubit.state.squads[1].models.first.command, Command.co);
      },
    );

    blocTest<RosterCubit, RosterState>(
      'does not auto-assign 1iC to green unit when assigning 2iC',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Mixed Squad', primaryRole: Role.gp);
        await Future<void>.delayed(Duration.zero);
        var squad = cubit.state.squads.first;

        // Add first model
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(id: 'V1'),
        );
        await Future<void>.delayed(Duration.zero);
        squad = cubit.state.squads.first;

        // Add second model
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(),
          variant: _createTestVariant(id: 'V2'),
        );
        await Future<void>.delayed(Duration.zero);
        squad = cubit.state.squads.first;

        // Make first model green
        final model1 = squad.models[0];
        cubit.updateModelLevel(
          squad: squad,
          model: model1,
          level: UnitLevel.green,
        );
        await Future<void>.delayed(Duration.zero);
        squad = cubit.state.squads.first;

        // Assign 2iC to second model - should NOT auto-assign 1iC to green unit
        final model2 = squad.models[1];
        cubit.updateModelCommandLevel(
          squad: squad,
          model: model2,
          commandLevel: Command.secondIC,
        );
      },
      verify: (cubit) {
        final squad = cubit.state.squads.first;
        final model1 = squad.models[0];
        final model2 = squad.models[1];

        // model1 should remain green with no command
        expect(model1.level, UnitLevel.green);
        expect(model1.command, Command.none);

        // model2 should have 2iC
        expect(model2.command, Command.secondIC);
      },
    );
  });

  group('UpdateFaction', () {
    blocTest<RosterCubit, RosterState>(
      'changes faction and resets squads',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        // Add a squad first so we can verify it gets cleared
        cubit.addNewSquad(name: 'Will Be Removed');
        await Future<void>.delayed(Duration.zero);
        cubit.updateFaction(Faction.south);
      },
      verify: (cubit) {
        expect(cubit.state.selectedFaction, Faction.south);
        expect(cubit.state.selectedSubfaction, Faction.south.subfactions.first);
        expect(
          cubit.state.squads,
          isEmpty,
          reason: 'Squads should be cleared on faction change',
        );
      },
    );

    blocTest<RosterCubit, RosterState>(
      'does not emit when selecting same faction',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) => cubit.updateFaction(Faction.north),
      expect: () => <RosterState>[],
    );
  });

  group('UpdateSubfaction', () {
    blocTest<RosterCubit, RosterState>(
      'changes subfaction',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) => cubit.updateSubfaction(Subfaction.norguard),
      verify: (cubit) {
        expect(cubit.state.selectedSubfaction, Subfaction.norguard);
      },
    );

    blocTest<RosterCubit, RosterState>(
      'does not emit when selecting same subfaction',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) => cubit.updateSubfaction(Faction.north.subfactions.first),
      expect: () => <RosterState>[],
    );
  });

  group('UpdateSquadRoles', () {
    blocTest<RosterCubit, RosterState>(
      'updates squad roles',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Roles Squad');
        await Future<void>.delayed(Duration.zero);
        final squad = cubit.state.squads.first;
        cubit.updateSquadRoles(
          squad: squad,
          primaryRole: Role.sk,
          secondaryRole: Role.rc,
        );
      },
      verify: (cubit) {
        final squad = cubit.state.squads.first;
        expect(squad.primaryRole, Role.sk);
        expect(squad.secondaryRole, Role.rc);
      },
    );

    blocTest<RosterCubit, RosterState>(
      'filters out models with invalid roles when roles change',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Filter Squad', primaryRole: Role.gp);
        await Future<void>.delayed(Duration.zero);
        final squad = cubit.state.squads.first;
        // Add a model that only has fs role
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(roles: {Role.fs}),
          variant: _createTestVariant(),
        );
        await Future<void>.delayed(Duration.zero);
        final updatedSquad = cubit.state.squads.first;
        expect(updatedSquad.models.length, 1);
        // Change roles to sk only - the fs-only model should be filtered out
        cubit.updateSquadRoles(squad: updatedSquad, primaryRole: Role.sk);
      },
      verify: (cubit) {
        final squad = cubit.state.squads.first;
        expect(
          squad.models,
          isEmpty,
          reason: 'Model with only fs role should be removed',
        );
      },
    );
  });

  group('ReorderSquad', () {
    blocTest<RosterCubit, RosterState>(
      'reorders squads down',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Squad A');
        cubit.addNewSquad(name: 'Squad B');
        cubit.addNewSquad(name: 'Squad C');
        await Future<void>.delayed(Duration.zero);
        // Move Squad A (index 0) down to index 3 (after Squad C)
        cubit.reorderSquad(oldIndex: 0, newIndex: 3);
      },
      verify: (cubit) {
        expect(cubit.state.squads.map((s) => s.name).toList(), [
          'Squad B',
          'Squad C',
          'Squad A',
        ]);
      },
    );

    blocTest<RosterCubit, RosterState>(
      'ignores out-of-bounds reorderSquad',
      build: () => RosterCubit(mockUnitRepository),
      seed: () => RosterInitial(mockUnitRepository),
      act: (cubit) => cubit.reorderSquad(oldIndex: -1, newIndex: 5),
      expect: () => <RosterState>[],
    );
  });

  group('ReorderModel', () {
    blocTest<RosterCubit, RosterState>(
      'reorders models up',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Squad A');
        await Future<void>.delayed(Duration.zero);
        var squad = cubit.state.squads.first;
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(name: 'Model 1'),
          variant: _createTestVariant(id: 'V1'),
        );
        await Future<void>.delayed(Duration.zero);
        squad = cubit.state.squads.first;
        cubit.addModel(
          squad: squad,
          base: _createTestModelBase(name: 'Model 2'),
          variant: _createTestVariant(id: 'V2'),
        );
        await Future<void>.delayed(Duration.zero);
        squad = cubit.state.squads.first;
        // Move Model 2 (index 1) to top (index 0)
        cubit.reorderModel(squad: squad, oldIndex: 1, newIndex: 0);
      },
      verify: (cubit) {
        final models = cubit.state.squads.first.models;
        expect(models.map((m) => m.base.name).toList(), ['Model 2', 'Model 1']);
      },
    );
  });

  group('UpdateSquads', () {
    blocTest<RosterCubit, RosterState>(
      'replaces all squads',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) {
        final squads = [
          const Squad(id: 99, name: 'Imported Squad', models: [], upgrades: []),
        ];
        cubit.updateSquads(squads);
      },
      verify: (cubit) {
        expect(cubit.state.squads.length, 1);
        expect(cubit.state.squads.first.name, 'Imported Squad');
      },
    );
  });

  group('UpdateSquad', () {
    blocTest<RosterCubit, RosterState>(
      'updates a squad by name',
      build: () => RosterCubit(mockUnitRepository),
      act: (cubit) async {
        cubit.addNewSquad(name: 'Update Me');
        await Future<void>.delayed(Duration.zero);
        final squad = cubit.state.squads.first;
        final updatedSquad = squad.copyWith(primaryRole: Role.fs);
        cubit.updateSquad(updatedSquad);
      },
      verify: (cubit) {
        expect(cubit.state.squads.first.primaryRole, Role.fs);
      },
    );
  });
}
