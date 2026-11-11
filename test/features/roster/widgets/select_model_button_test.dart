import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/core/generated/i18n/app_localizations.dart';
import 'package:gearforce/domain/entities/attribute/armor.dart';
import 'package:gearforce/domain/entities/attribute/classification.dart';
import 'package:gearforce/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/movement_type.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/attribute/skill.dart';
import 'package:gearforce/domain/entities/attribute/unit_actions.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/model_base.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/entities/unit/variant.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/select_model_button.dart';

class _MockUnitRepository implements UnitRepository {
  @override
  Future<List<Unit>> getUnitsByFaction(Faction faction) async => const [];

  @override
  Future<Unit?> getUnitById(String unitId) async {
    return null;
  }
}

Widget _testApp({required Widget child, required RosterCubit cubit}) {
  return BlocProvider<RosterCubit>.value(
    value: cubit,
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  group('SelectModelButton', () {
    late RosterCubit cubit;

    setUp(() {
      cubit = RosterCubit(_MockUnitRepository());
    });

    tearDown(() {
      cubit.close();
    });

    testWidgets('is enabled when squad can add units', (tester) async {
      final squad = Squad(
        id: 1,
        name: 'Alpha',
        primaryRole: Role.gp,
        models: [_buildModel(id: 1)],
      );

      await tester.pumpWidget(
        _testApp(
          child: SelectModelButton(updatedSquad: squad),
          cubit: cubit,
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('is disabled when squad is at max unit count', (tester) async {
      final fullSquad = Squad(
        id: 1,
        name: 'Full Squad',
        primaryRole: Role.gp,
        models: List<Model>.generate(9, (index) => _buildModel(id: index + 1)),
      );

      await tester.pumpWidget(
        _testApp(
          child: SelectModelButton(updatedSquad: fullSquad),
          cubit: cubit,
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });
  });
}

Model _buildModel({required int id}) {
  return Model(
    id: id,
    base: const ModelBase(
      'Test Unit',
      unitId: 'test-unit',
      tv: 0,
      roles: {Role.gp},
      movement: Movement([MovementType.walker], 6),
      armor: Armor(5),
      hullStructure: HullStructure(hull: 2, structure: 2),
      actions: UnitActions(1),
      gu: Skill(4),
      pi: Skill(4),
      ew: Skill(4),
      traits: [],
      height: 1.5,
      classification: Classification.gear,
    ),
    variant: Variant('Test Unit', id: 'variant-$id', tv: 0),
  );
}
