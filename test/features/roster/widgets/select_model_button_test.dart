import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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

Widget _testApp({required Widget child, required RosterBloc bloc}) {
  return BlocProvider<RosterBloc>.value(
    value: bloc,
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  group('SelectModelButton', () {
    testWidgets('is enabled when squad can add units', (tester) async {
      final bloc = RosterBloc(_MockUnitRepository());
      final squad = Squad(
        id: 1,
        name: 'Alpha',
        primaryRole: Role.gp,
        models: [_buildModel(id: 1)],
      );

      await tester.pumpWidget(
        _testApp(
          child: SelectModelButton(updatedSquad: squad),
          bloc: bloc,
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);

      bloc.close();
    });

    testWidgets('is disabled when squad is at max unit count', (tester) async {
      final bloc = RosterBloc(_MockUnitRepository());
      final fullSquad = Squad(
        id: 1,
        name: 'Full Squad',
        primaryRole: Role.gp,
        models: List<Model>.generate(9, (index) => _buildModel(id: index + 1)),
      );

      await tester.pumpWidget(
        _testApp(
          child: SelectModelButton(updatedSquad: fullSquad),
          bloc: bloc,
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);

      bloc.close();
    });
  });
}

Model _buildModel({required int id}) {
  return Model(
    id: id,
    base: ModelBase(
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
      traits: const [],
      height: 1.5,
      classification: Classification.gear,
    ),
    variant: Variant('Test Unit', id: 'variant-$id', tv: 0),
  );
}
