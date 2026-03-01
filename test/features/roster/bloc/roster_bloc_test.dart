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
import 'package:gearforce/domain/entities/equipment/weapon.dart';
import 'package:gearforce/domain/entities/equipment/weapon_mode.dart';
import 'package:gearforce/domain/entities/equipment/weapon_range.dart';
import 'package:gearforce/domain/entities/attribute/size_bands.dart';
import 'package:gearforce/domain/entities/unit/model_base.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/unit/squad_upgrade_model_upgrade_mapper.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/entities/unit/variant.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/repositories/weapon_repository.dart';
import 'package:gearforce/data/static/weapon_factory.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';

class MockUnitRepository implements UnitRepository {
  @override
  Future<List<Unit>> getUnitsByFaction(Faction faction) async {
    return const [];
  }
}

class MockWeaponRepository implements WeaponRepository {
  @override
  Future<List<Weapon>> getWeapons() async => const [];

  @override
  Weapon? getWeaponByCode(String code, {bool hasReact = false}) {
    final baseCode = code.length > 1 ? code.substring(1) : code;
    return Weapon(
      baseCode: baseCode,
      name: code,
      range: const WeaponRange(minOptimal: 0, maxOptimal: 12, max: 24),
      modes: {WeaponMode.direct},
      damageBands: const DamageSizeBands(l: 5, m: 6, h: 7),
      isReact: hasReact,
    );
  }
}

ModelBase _createTestModelBase({
  String name = 'Test Gear',
  int tv = 8,
  Set<Role> roles = const {Role.gp, Role.sk},
}) {
  return ModelBase(
    name,
    tv: tv,
    roles: roles,
    movement: Movement([MovementType.walker], 6),
    armor: Armor(5),
    hullStructure: HullStructure(hull: 4, structure: 3),
    actions: UnitActions(1),
    gu: Skill(4),
    pi: Skill(5),
    ew: Skill(6),
    height: 1.5,
    classification: Classification.gear,
  );
}

Variant _createTestVariant({String name = 'Test Gear', String id = 'V1'}) {
  return Variant(name, id: id, tv: 0);
}

void main() {
  late MockUnitRepository mockUnitRepository;
  late MockWeaponRepository mockWeaponRepository;

  setUp(() {
    mockUnitRepository = MockUnitRepository();
    mockWeaponRepository = MockWeaponRepository();
    WeaponFactory.setRepository(mockWeaponRepository);
  });

  group('RosterBloc initial state', () {
    test('has correct initial values', () {
      final bloc = RosterBloc(mockUnitRepository);
      expect(bloc.state, isA<RosterInitial>());
      expect(bloc.state.playerName, '');
      expect(bloc.state.rosterName, '');
      expect(bloc.state.squads, isEmpty);
      expect(bloc.state.selectedFaction, Faction.north);
      expect(bloc.state.selectedSubfaction, Faction.north.subfactions.first);
      bloc.close();
    });
  });

  group('UpdatePlayerName', () {
    blocTest<RosterBloc, RosterState>(
      'emits state with updated player name',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) => bloc.add(UpdatePlayerName(playerName: 'John')),
      expect: () => [
        isA<RosterState>().having((s) => s.playerName, 'playerName', 'John'),
      ],
    );
  });

  group('UpdateRosterName', () {
    blocTest<RosterBloc, RosterState>(
      'emits state with updated roster name',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) => bloc.add(UpdateRosterName(rosterName: 'My Roster')),
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
    blocTest<RosterBloc, RosterState>(
      'adds a squad with default role',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) => bloc.add(AddNewSquad(name: 'Alpha Squad')),
      expect: () => [
        isA<RosterState>().having((s) => s.squads.length, 'squad count', 1),
      ],
      verify: (bloc) {
        final squad = bloc.state.squads.first;
        expect(squad.name, 'Alpha Squad');
        expect(squad.primaryRole, Role.gp);
        expect(squad.secondaryRole, isNull);
        expect(squad.models, isEmpty);
        expect(squad.upgrades, isEmpty);
      },
    );

    blocTest<RosterBloc, RosterState>(
      'adds a squad with specified roles',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) => bloc.add(
        AddNewSquad(
          name: 'Strike Team',
          primaryRole: Role.sk,
          secondaryRole: Role.gp,
        ),
      ),
      verify: (bloc) {
        final squad = bloc.state.squads.first;
        expect(squad.primaryRole, Role.sk);
        expect(squad.secondaryRole, Role.gp);
      },
    );

    blocTest<RosterBloc, RosterState>(
      'adds multiple squads with unique IDs',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) {
        bloc.add(AddNewSquad(name: 'Squad A'));
        bloc.add(AddNewSquad(name: 'Squad B'));
        bloc.add(AddNewSquad(name: 'Squad C'));
      },
      verify: (bloc) {
        expect(bloc.state.squads.length, 3);
        final ids = bloc.state.squads.map((s) => s.id).toSet();
        expect(ids.length, 3, reason: 'All squad IDs should be unique');
      },
    );
  });

  group('RemoveSquad', () {
    blocTest<RosterBloc, RosterState>(
      'removes the specified squad',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Only Squad'));
        await Future<void>.delayed(Duration.zero);
        final squad = bloc.state.squads.first;
        bloc.add(RemoveSquad(squad: squad));
      },
      verify: (bloc) {
        expect(bloc.state.squads, isEmpty);
      },
    );

    blocTest<RosterBloc, RosterState>(
      'removes correct squad when multiple exist',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Keep'));
        bloc.add(AddNewSquad(name: 'Remove'));
        await Future<void>.delayed(Duration.zero);
        // After both are added, remove the second
        final squadToRemove = bloc.state.squads.firstWhere(
          (s) => s.name == 'Remove',
        );
        bloc.add(RemoveSquad(squad: squadToRemove));
      },
      verify: (bloc) {
        expect(bloc.state.squads.length, 1);
        expect(bloc.state.squads.first.name, 'Keep');
      },
    );
  });

  group('DuplicateSquad', () {
    blocTest<RosterBloc, RosterState>(
      'duplicates squad with copied models and unique squad/model IDs',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Alpha'));
        await Future<void>.delayed(Duration.zero);

        var squad = bloc.state.squads.first;
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(id: 'V1'),
          ),
        );
        await Future<void>.delayed(Duration.zero);

        squad = bloc.state.squads.first;
        bloc.add(DuplicateSquad(squad: squad, name: 'Squad 2'));
      },
      verify: (bloc) {
        expect(bloc.state.squads.length, 2);

        final original = bloc.state.squads[0];
        final duplicate = bloc.state.squads[1];

        expect(duplicate.name, 'Squad 2');
        expect(duplicate.id, isNot(original.id));
        expect(duplicate.models.length, original.models.length);

        if (original.models.isNotEmpty && duplicate.models.isNotEmpty) {
          expect(duplicate.models.first.id, isNot(original.models.first.id));
        }
      },
    );

    blocTest<RosterBloc, RosterState>(
      'does not duplicate CO command level when duplicating a squad',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Command Squad'));
        await Future<void>.delayed(Duration.zero);

        var squad = bloc.state.squads.first;
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(id: 'V1'),
          ),
        );
        await Future<void>.delayed(Duration.zero);

        squad = bloc.state.squads.first;
        final model = squad.models.first;
        bloc.add(
          UpdateModelCommandLevel(
            squad: squad,
            model: model,
            commandLevel: Command.co,
          ),
        );
        await Future<void>.delayed(Duration.zero);

        squad = bloc.state.squads.first;
        bloc.add(DuplicateSquad(squad: squad, name: 'Squad 2'));
      },
      verify: (bloc) {
        final allModels = bloc.state.squads.expand((s) => s.models).toList();
        final coCount = allModels.where((m) => m.command == Command.co).length;
        expect(coCount, 1);
      },
    );
  });

  group('RenameSquad', () {
    blocTest<RosterBloc, RosterState>(
      'renames the specified squad',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Old Name'));
        await Future<void>.delayed(Duration.zero);
        final squad = bloc.state.squads.first;
        bloc.add(RenameSquad(squad: squad, newName: 'New Name'));
      },
      verify: (bloc) {
        expect(bloc.state.squads.first.name, 'New Name');
      },
    );
  });

  group('AddModel', () {
    blocTest<RosterBloc, RosterState>(
      'adds a model to the specified squad',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Model Squad'));
        await Future<void>.delayed(Duration.zero);
        final squad = bloc.state.squads.first;
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(),
          ),
        );
      },
      verify: (bloc) {
        expect(bloc.state.squads.first.models.length, 1);
        expect(bloc.state.squads.first.models.first.base.name, 'Test Gear');
      },
    );

    blocTest<RosterBloc, RosterState>(
      'auto-assigns 1iC when squad has no command',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Command Squad'));
        await Future<void>.delayed(Duration.zero);
        final squad = bloc.state.squads.first;
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(),
          ),
        );
      },
      verify: (bloc) {
        final model = bloc.state.squads.first.models.first;
        expect(model.command, Command.firstIC);
      },
    );
  });

  group('RemoveModel', () {
    blocTest<RosterBloc, RosterState>(
      'removes a model from the specified squad',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Test Squad'));
        await Future<void>.delayed(Duration.zero);
        final squad = bloc.state.squads.first;
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        final updatedSquad = bloc.state.squads.first;
        final model = updatedSquad.models.first;
        bloc.add(RemoveModel(squad: updatedSquad, model: model));
      },
      verify: (bloc) {
        expect(bloc.state.squads.first.models, isEmpty);
      },
    );

    blocTest<RosterBloc, RosterState>(
      'promotes another model to 1iC when current 1iC is removed',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Command Reassign Squad'));
        await Future<void>.delayed(Duration.zero);

        var squad = bloc.state.squads.first;
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(id: 'V1'),
          ),
        );
        await Future<void>.delayed(Duration.zero);

        squad = bloc.state.squads.first;
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(id: 'V2'),
          ),
        );
        await Future<void>.delayed(Duration.zero);

        squad = bloc.state.squads.first;
        final firstIcModel = squad.models.firstWhere(
          (model) => model.command == Command.firstIC,
        );

        bloc.add(RemoveModel(squad: squad, model: firstIcModel));
      },
      verify: (bloc) {
        final models = bloc.state.squads.first.models;
        expect(models.length, 1);
        expect(models.single.command, Command.firstIC);
      },
    );
  });

  group('DuplicateModel', () {
    blocTest<RosterBloc, RosterState>(
      'duplicates model with command reset and conditional level/duelist copy',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Duplicate Model Squad'));
        await Future<void>.delayed(Duration.zero);

        var squad = bloc.state.squads.first;
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(),
          ),
        );
        await Future<void>.delayed(Duration.zero);

        squad = bloc.state.squads.first;
        var sourceModel = squad.models.first;

        bloc.add(
          UpdateModelLevel(
            squad: squad,
            model: sourceModel,
            level: UnitLevel.veteran,
          ),
        );
        await Future<void>.delayed(Duration.zero);

        squad = bloc.state.squads.first;
        sourceModel = squad.models.first;
        bloc.add(
          UpdateModelIsDuelist(
            squad: squad,
            model: sourceModel,
            isDuelist: true,
          ),
        );
        await Future<void>.delayed(Duration.zero);

        squad = bloc.state.squads.first;
        sourceModel = squad.models.first;
        bloc.add(DuplicateModel(squad: squad, model: sourceModel));
      },
      verify: (bloc) {
        final squad = bloc.state.squads.first;
        expect(squad.models.length, 2);

        final sourceModel = squad.models[0];
        final duplicatedModel = squad.models[1];

        final expectedBaseModel = sourceModel.copyWith(
          id: duplicatedModel.id,
          command: Command.none,
          level: UnitLevel.regular,
          isDuelist: false,
        );

        final canCopyLevel = bloc.state.ruleSet.canAssignUnitLevel(
          model: expectedBaseModel,
          newLevel: sourceModel.level,
          squad: squad,
          allSquads: bloc.state.squads,
        );
        final expectedLevel = canCopyLevel
            ? sourceModel.level
            : UnitLevel.regular;

        final modelAfterLevel = expectedBaseModel.copyWith(
          level: expectedLevel,
        );
        final canCopyDuelist =
            sourceModel.isDuelist &&
            bloc.state.ruleSet.canAssignDuelist(
              model: modelAfterLevel,
              newDuelistStatus: true,
              squad: squad,
              allSquads: bloc.state.squads,
            );

        expect(duplicatedModel.command, Command.none);
        expect(duplicatedModel.level, expectedLevel);
        expect(duplicatedModel.isDuelist, canCopyDuelist);
      },
    );
  });

  group('UpdateModelLevel', () {
    blocTest<RosterBloc, RosterState>(
      'updates model level to veteran',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Level Squad'));
        await Future<void>.delayed(Duration.zero);
        final squad = bloc.state.squads.first;
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        final updatedSquad = bloc.state.squads.first;
        final model = updatedSquad.models.first;
        bloc.add(
          UpdateModelLevel(
            squad: updatedSquad,
            model: model,
            level: UnitLevel.veteran,
          ),
        );
      },
      verify: (bloc) {
        expect(bloc.state.squads.first.models.first.level, UnitLevel.veteran);
      },
    );

    blocTest<RosterBloc, RosterState>(
      'does not auto-promote to 2iC when 2iC becomes green',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        // Create squad with GP role
        bloc.add(AddNewSquad(name: 'Auto Promote Squad', primaryRole: Role.gp));
        await Future<void>.delayed(Duration.zero);
        var squad = bloc.state.squads.first;

        // Add model 1 (will auto-become 1iC)
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(id: 'V1'),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        squad = bloc.state.squads.first;

        // Add model 2 (will become 2iC)
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(id: 'V2'),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        squad = bloc.state.squads.first;

        // Add model 3
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(id: 'V3'),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        squad = bloc.state.squads.first;
        final model2 = squad.models[1];

        // Make model2 the 2iC
        bloc.add(
          UpdateModelCommandLevel(
            squad: squad,
            model: model2,
            commandLevel: Command.secondIC,
          ),
        );
        await Future<void>.delayed(Duration.zero);
        squad = bloc.state.squads.first;

        // Now make model2 green - model3 should NOT be promoted
        var updatedModel2 = squad.models.firstWhere((m) => m.id == model2.id);
        bloc.add(
          UpdateModelLevel(
            squad: squad,
            model: updatedModel2,
            level: UnitLevel.green,
          ),
        );
      },
      verify: (bloc) {
        final squad = bloc.state.squads.first;
        final model2 = squad.models[1];
        final model3 = squad.models[2];

        // model2 should be green with no command
        expect(model2.level, UnitLevel.green);
        expect(model2.command, Command.none);

        // model3 should not be promoted (remains none)
        expect(model3.command, Command.none);
      },
    );

    blocTest<RosterBloc, RosterState>(
      'auto-promotes another unit to 1iC when 1iC becomes green',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        // Create squad with GP role
        bloc.add(
          AddNewSquad(name: 'Promote to 1iC Squad', primaryRole: Role.gp),
        );
        await Future<void>.delayed(Duration.zero);
        var squad = bloc.state.squads.first;

        // Add model 1 (will auto-become 1iC)
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(id: 'V1'),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        squad = bloc.state.squads.first;

        // Add model 2
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(id: 'V2'),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        squad = bloc.state.squads.first;
        final model1 = squad.models[0];

        // Make model1 green - model2 should be promoted to 1iC
        bloc.add(
          UpdateModelLevel(squad: squad, model: model1, level: UnitLevel.green),
        );
      },
      verify: (bloc) {
        final squad = bloc.state.squads.first;
        final model1 = squad.models[0];
        final model2 = squad.models[1];

        // model1 should be green with no command
        expect(model1.level, UnitLevel.green);
        expect(model1.command, Command.none);

        // model2 should be promoted to 1iC
        expect(model2.command, Command.firstIC);
      },
    );

    blocTest<RosterBloc, RosterState>(
      'auto-assigns 1iC when unit changes from green back to regular',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        // Create squad with GP role
        bloc.add(AddNewSquad(name: 'Auto Assign Squad', primaryRole: Role.gp));
        await Future<void>.delayed(Duration.zero);
        var squad = bloc.state.squads.first;

        // Add only model (will auto-become 1iC)
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        squad = bloc.state.squads.first;

        // Make it green (command should become none)
        var model = squad.models.first;
        bloc.add(
          UpdateModelLevel(squad: squad, model: model, level: UnitLevel.green),
        );
        await Future<void>.delayed(Duration.zero);
        squad = bloc.state.squads.first;

        // Change it back to regular - should become 1iC
        model = squad.models.first;
        bloc.add(
          UpdateModelLevel(
            squad: squad,
            model: model,
            level: UnitLevel.regular,
          ),
        );
      },
      verify: (bloc) {
        final model = bloc.state.squads.first.models.first;
        expect(model.level, UnitLevel.regular);
        expect(model.command, Command.firstIC);
      },
    );
  });

  group('UpdateModelIsDuelist', () {
    blocTest<RosterBloc, RosterState>(
      'marks model as duelist',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Duelist Squad'));
        await Future<void>.delayed(Duration.zero);
        final squad = bloc.state.squads.first;
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        final updatedSquad = bloc.state.squads.first;
        final model = updatedSquad.models.first;
        bloc.add(
          UpdateModelIsDuelist(
            squad: updatedSquad,
            model: model,
            isDuelist: true,
          ),
        );
      },
      verify: (bloc) {
        expect(bloc.state.squads.first.models.first.isDuelist, isTrue);
      },
    );
  });

  group('UpdateModelCommandLevel', () {
    blocTest<RosterBloc, RosterState>(
      'updates model command level',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Command Squad'));
        await Future<void>.delayed(Duration.zero);
        final squad = bloc.state.squads.first;
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        final updatedSquad = bloc.state.squads.first;
        final model = updatedSquad.models.first;
        bloc.add(
          UpdateModelCommandLevel(
            squad: updatedSquad,
            model: model,
            commandLevel: Command.co,
          ),
        );
      },
      verify: (bloc) {
        expect(bloc.state.squads.first.models.first.command, Command.co);
      },
    );

    blocTest<RosterBloc, RosterState>(
      'automatically clears conflicting command level in same squad',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Command Squad'));
        await Future<void>.delayed(Duration.zero);
        var squad = bloc.state.squads.first;

        // Add two models
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        squad = bloc.state.squads.first;
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(),
          ),
        );
        await Future<void>.delayed(Duration.zero);

        // Assign 1iC to first model
        squad = bloc.state.squads.first;
        final model1 = squad.models[0];
        bloc.add(
          UpdateModelCommandLevel(
            squad: squad,
            model: model1,
            commandLevel: Command.firstIC,
          ),
        );
        await Future<void>.delayed(Duration.zero);

        // Assign CO to second model (should clear 1iC from first)
        squad = bloc.state.squads.first;
        final model2 = squad.models[1];
        bloc.add(
          UpdateModelCommandLevel(
            squad: squad,
            model: model2,
            commandLevel: Command.co,
          ),
        );
      },
      verify: (bloc) {
        final squad = bloc.state.squads.first;
        expect(squad.models[0].command, Command.none);
        expect(squad.models[1].command, Command.co);
      },
    );

    blocTest<RosterBloc, RosterState>(
      'automatically clears conflicting command level across squads',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        // Add first squad with CO
        bloc.add(AddNewSquad(name: 'Squad 1'));
        await Future<void>.delayed(Duration.zero);
        var squad1 = bloc.state.squads.first;
        bloc.add(
          AddModel(
            squad: squad1,
            base: _createTestModelBase(),
            variant: _createTestVariant(),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        squad1 = bloc.state.squads.first;
        final model1 = squad1.models.first;
        bloc.add(
          UpdateModelCommandLevel(
            squad: squad1,
            model: model1,
            commandLevel: Command.co,
          ),
        );
        await Future<void>.delayed(Duration.zero);

        // Add second squad and assign CO to it (should clear CO from first squad)
        bloc.add(AddNewSquad(name: 'Squad 2'));
        await Future<void>.delayed(Duration.zero);
        final squad2 = bloc.state.squads.last;
        bloc.add(
          AddModel(
            squad: squad2,
            base: _createTestModelBase(),
            variant: _createTestVariant(),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        final updatedSquad2 = bloc.state.squads.last;
        final model2 = updatedSquad2.models.first;
        bloc.add(
          UpdateModelCommandLevel(
            squad: updatedSquad2,
            model: model2,
            commandLevel: Command.co,
          ),
        );
      },
      verify: (bloc) {
        expect(bloc.state.squads, hasLength(2));
        expect(bloc.state.squads[0].models.first.command, Command.firstIC);
        expect(bloc.state.squads[1].models.first.command, Command.co);
      },
    );

    blocTest<RosterBloc, RosterState>(
      'does not auto-assign 1iC to green unit when assigning 2iC',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Mixed Squad', primaryRole: Role.gp));
        await Future<void>.delayed(Duration.zero);
        var squad = bloc.state.squads.first;

        // Add first model
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(id: 'V1'),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        squad = bloc.state.squads.first;

        // Add second model
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(id: 'V2'),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        squad = bloc.state.squads.first;

        // Make first model green
        final model1 = squad.models[0];
        bloc.add(
          UpdateModelLevel(squad: squad, model: model1, level: UnitLevel.green),
        );
        await Future<void>.delayed(Duration.zero);
        squad = bloc.state.squads.first;

        // Assign 2iC to second model - should NOT auto-assign 1iC to green unit
        final model2 = squad.models[1];
        bloc.add(
          UpdateModelCommandLevel(
            squad: squad,
            model: model2,
            commandLevel: Command.secondIC,
          ),
        );
      },
      verify: (bloc) {
        final squad = bloc.state.squads.first;
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
    blocTest<RosterBloc, RosterState>(
      'changes faction and resets squads',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        // Add a squad first so we can verify it gets cleared
        bloc.add(AddNewSquad(name: 'Will Be Removed'));
        await Future<void>.delayed(Duration.zero);
        bloc.add(UpdateFaction(faction: Faction.south));
      },
      verify: (bloc) {
        expect(bloc.state.selectedFaction, Faction.south);
        expect(bloc.state.selectedSubfaction, Faction.south.subfactions.first);
        expect(
          bloc.state.squads,
          isEmpty,
          reason: 'Squads should be cleared on faction change',
        );
      },
    );

    blocTest<RosterBloc, RosterState>(
      'does not emit when selecting same faction',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) => bloc.add(UpdateFaction(faction: Faction.north)),
      expect: () => <RosterState>[],
    );
  });

  group('UpdateSubfaction', () {
    blocTest<RosterBloc, RosterState>(
      'changes subfaction',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) =>
          bloc.add(UpdateSubfaction(subfaction: Subfaction.norguard)),
      verify: (bloc) {
        expect(bloc.state.selectedSubfaction, Subfaction.norguard);
      },
    );

    blocTest<RosterBloc, RosterState>(
      'does not emit when selecting same subfaction',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) => bloc.add(
        UpdateSubfaction(subfaction: Faction.north.subfactions.first),
      ),
      expect: () => <RosterState>[],
    );
  });

  group('UpdateSquadRoles', () {
    blocTest<RosterBloc, RosterState>(
      'updates squad roles',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Roles Squad'));
        await Future<void>.delayed(Duration.zero);
        final squad = bloc.state.squads.first;
        bloc.add(
          UpdateSquadRoles(
            squad: squad,
            primaryRole: Role.sk,
            secondaryRole: Role.rc,
          ),
        );
      },
      verify: (bloc) {
        final squad = bloc.state.squads.first;
        expect(squad.primaryRole, Role.sk);
        expect(squad.secondaryRole, Role.rc);
      },
    );

    blocTest<RosterBloc, RosterState>(
      'filters out models with invalid roles when roles change',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Filter Squad', primaryRole: Role.gp));
        await Future<void>.delayed(Duration.zero);
        final squad = bloc.state.squads.first;
        // Add a model that only has fs role
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(roles: {Role.fs}),
            variant: _createTestVariant(),
          ),
        );
        await Future<void>.delayed(Duration.zero);
        final updatedSquad = bloc.state.squads.first;
        expect(updatedSquad.models.length, 1);
        // Change roles to sk only - the fs-only model should be filtered out
        bloc.add(UpdateSquadRoles(squad: updatedSquad, primaryRole: Role.sk));
      },
      verify: (bloc) {
        final squad = bloc.state.squads.first;
        expect(
          squad.models,
          isEmpty,
          reason: 'Model with only fs role should be removed',
        );
      },
    );
  });

  group('UpdateSquads', () {
    blocTest<RosterBloc, RosterState>(
      'replaces all squads',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) {
        final squads = [
          Squad(
            id: 99,
            name: 'Imported Squad',
            models: const [],
            upgrades: const [],
          ),
        ];
        bloc.add(UpdateSquads(squads: squads));
      },
      verify: (bloc) {
        expect(bloc.state.squads.length, 1);
        expect(bloc.state.squads.first.name, 'Imported Squad');
      },
    );
  });

  group('UpdateSquad', () {
    blocTest<RosterBloc, RosterState>(
      'updates a squad by name',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Update Me'));
        await Future<void>.delayed(Duration.zero);
        final squad = bloc.state.squads.first;
        final updatedSquad = squad.copyWith(primaryRole: Role.fs);
        bloc.add(UpdateSquad(updatedSquad: updatedSquad));
      },
      verify: (bloc) {
        expect(bloc.state.squads.first.primaryRole, Role.fs);
      },
    );
  });

  group('UpdateSquadUpgradeEnabled', () {
    blocTest<RosterBloc, RosterState>(
      'enables a squad upgrade for a squad',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Upgrade Squad'));
        await Future<void>.delayed(Duration.zero);

        final squad = bloc.state.squads.first;
        final upgradeId = bloc.state.ruleSet.availableSquadUpgrades.first.id;

        bloc.add(
          UpdateSquadUpgradeEnabled(
            squad: squad,
            upgradeId: upgradeId,
            enabled: true,
          ),
        );
      },
      verify: (bloc) {
        final squad = bloc.state.squads.first;
        expect(squad.upgrades.length, 1);
        expect(
          squad.upgrades.first.id,
          bloc.state.ruleSet.availableSquadUpgrades.first.id,
        );
      },
    );

    blocTest<RosterBloc, RosterState>(
      'disables a previously selected squad upgrade',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Upgrade Squad'));
        await Future<void>.delayed(Duration.zero);

        final squad = bloc.state.squads.first;
        final upgradeId = bloc.state.ruleSet.availableSquadUpgrades.first.id;

        bloc.add(
          UpdateSquadUpgradeEnabled(
            squad: squad,
            upgradeId: upgradeId,
            enabled: true,
          ),
        );
        await Future<void>.delayed(Duration.zero);

        bloc.add(
          UpdateSquadUpgradeEnabled(
            squad: bloc.state.squads.first,
            upgradeId: upgradeId,
            enabled: false,
          ),
        );
      },
      verify: (bloc) {
        final squad = bloc.state.squads.first;
        expect(squad.upgrades, isEmpty);
      },
    );

    blocTest<RosterBloc, RosterState>(
      'enabling grenades-light allows selecting derived 1TV Add LHG model upgrade',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Upgrade Squad'));
        await Future<void>.delayed(Duration.zero);

        final squad = bloc.state.squads.first;
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(),
          ),
        );
        await Future<void>.delayed(Duration.zero);

        final squadAfterModel = bloc.state.squads.first;
        const squadUpgradeId = 'squad-grenades-light';
        bloc.add(
          UpdateSquadUpgradeEnabled(
            squad: squadAfterModel,
            upgradeId: squadUpgradeId,
            enabled: true,
          ),
        );
        await Future<void>.delayed(Duration.zero);

        final updatedSquad = bloc.state.squads.first;
        final model = updatedSquad.models.first;
        bloc.add(
          UpdateModelUpgradeEnabled(
            squad: updatedSquad,
            model: model,
            upgradeId: squadUpgradeModelUpgradeId(squadUpgradeId),
            enabled: true,
          ),
        );
      },
      verify: (bloc) {
        final squad = bloc.state.squads.first;
        final model = squad.models.first;
        expect(
          model.selectedModelUpgrades.any(
            (upgrade) => upgrade.id == 'squad-model-upgrade-squad-grenades-light',
          ),
          isTrue,
        );
        expect(
          model.weapons.any((weaponSpec) => weaponSpec.code == 'LHG'),
          isTrue,
        );
      },
    );

    blocTest<RosterBloc, RosterState>(
      'disabling a selected squad upgrade removes corresponding derived model upgrade selection',
      build: () => RosterBloc(mockUnitRepository),
      act: (bloc) async {
        bloc.add(AddNewSquad(name: 'Upgrade Squad'));
        await Future<void>.delayed(Duration.zero);

        final squad = bloc.state.squads.first;
        bloc.add(
          AddModel(
            squad: squad,
            base: _createTestModelBase(),
            variant: _createTestVariant(),
          ),
        );
        await Future<void>.delayed(Duration.zero);

        const squadUpgradeId = 'squad-grenades-light';
        var currentSquad = bloc.state.squads.first;
        bloc.add(
          UpdateSquadUpgradeEnabled(
            squad: currentSquad,
            upgradeId: squadUpgradeId,
            enabled: true,
          ),
        );
        await Future<void>.delayed(Duration.zero);

        currentSquad = bloc.state.squads.first;
        bloc.add(
          UpdateModelUpgradeEnabled(
            squad: currentSquad,
            model: currentSquad.models.first,
            upgradeId: squadUpgradeModelUpgradeId(squadUpgradeId),
            enabled: true,
          ),
        );
        await Future<void>.delayed(Duration.zero);

        currentSquad = bloc.state.squads.first;
        bloc.add(
          UpdateSquadUpgradeEnabled(
            squad: currentSquad,
            upgradeId: squadUpgradeId,
            enabled: false,
          ),
        );
      },
      verify: (bloc) {
        final squad = bloc.state.squads.first;
        final model = squad.models.first;
        expect(
          model.selectedModelUpgrades.any(
            (upgrade) => upgrade.id == 'squad-model-upgrade-squad-grenades-light',
          ),
          isFalse,
        );
      },
    );
  });
}
