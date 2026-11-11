import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/core/generated/i18n/app_localizations.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/add_squad_button.dart';
import 'package:gearforce/features/roster/widgets/squad_display.dart';

class MockUnitRepository implements UnitRepository {
  @override
  Future<List<Unit>> getUnitsByFaction(Faction faction) async => const [];

  @override
  Future<Unit?> getUnitById(String unitId) async {
    return null;
  }
}

/// Wraps a widget with MaterialApp, localization delegates, and RosterCubit.
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
  group('SquadDisplay', () {
    late RosterCubit cubit;

    setUp(() {
      cubit = RosterCubit(MockUnitRepository());
    });

    tearDown(() {
      cubit.close();
    });

    testWidgets('shows empty text when no squads', (tester) async {
      await tester.pumpWidget(
        _testApp(
          child: const SquadDisplay(squads: []),
          cubit: cubit,
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('There are no squads in the combat group.'),
        findsOneWidget,
      );
    });

    testWidgets('shows squad names when squads exist', (tester) async {
      final squads = [
        const Squad(
          id: 1,
          name: 'Alpha Squad',
          primaryRole: Role.gp,
          models: [],
        ),
        const Squad(
          id: 2,
          name: 'Bravo Squad',
          primaryRole: Role.sk,
          models: [],
        ),
      ];
      await tester.pumpWidget(
        _testApp(
          child: SquadDisplay(squads: squads),
          cubit: cubit,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Alpha Squad'), findsOneWidget);
      expect(find.text('Bravo Squad'), findsOneWidget);
    });

    testWidgets('shows actions menu button for each squad', (tester) async {
      final squads = [
        const Squad(id: 1, name: 'Alpha', primaryRole: Role.gp, models: []),
      ];
      await tester.pumpWidget(
        _testApp(
          child: SquadDisplay(squads: squads),
          cubit: cubit,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('shows confirmation dialog when delete is tapped', (
      tester,
    ) async {
      final squads = [
        const Squad(id: 1, name: 'Alpha', primaryRole: Role.gp, models: []),
      ];
      await tester.pumpWidget(
        _testApp(
          child: SquadDisplay(squads: squads),
          cubit: cubit,
        ),
      );
      await tester.pumpAndSettle();

      // Tap the more_vert button to open the actions menu
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Tap the delete option in the actions menu
      await tester.tap(find.byIcon(Icons.delete_forever_outlined));
      await tester.pumpAndSettle();

      expect(find.text('Remove Squad'), findsOneWidget);
      expect(
        find.text('Are you sure you want to remove "Alpha"?'),
        findsOneWidget,
      );
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Remove'), findsOneWidget);
    });

    testWidgets('cancel dismiss dialog without removing squad', (tester) async {
      final squads = [
        const Squad(id: 1, name: 'Alpha', primaryRole: Role.gp, models: []),
      ];

      // Add a squad so we can verify it isn't removed
      cubit.addNewSquad(name: 'Alpha');
      await tester.pumpWidget(
        _testApp(
          child: SquadDisplay(squads: squads),
          cubit: cubit,
        ),
      );
      await tester.pumpAndSettle();

      // Tap the more_vert button to open the actions menu
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Tap the delete option in the actions menu
      await tester.tap(find.byIcon(Icons.delete_forever_outlined));
      await tester.pumpAndSettle();

      // Tap Cancel — this should close the dialog without removing squad
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Dialog should be dismissed, squad still visible
      expect(find.text('Remove Squad'), findsNothing);
      expect(find.text('Alpha'), findsOneWidget);
    });

    testWidgets('confirm dispatches RemoveSquad', (tester) async {
      final squads = [
        const Squad(id: 1, name: 'Alpha', primaryRole: Role.gp, models: []),
      ];

      await tester.pumpWidget(
        _testApp(
          child: SquadDisplay(squads: squads),
          cubit: cubit,
        ),
      );
      await tester.pumpAndSettle();

      // Tap the more_vert button to open the actions menu
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Tap the delete option in the actions menu
      await tester.tap(find.byIcon(Icons.delete_forever_outlined));
      await tester.pumpAndSettle();

      // Tap Remove — this calls removeSquad
      await tester.tap(find.text('Remove'));
      await tester.pumpAndSettle();

      // Dialog should be dismissed
      expect(find.text('Remove Squad'), findsNothing);
    });
  });

  group('AddSquadButton', () {
    late RosterCubit cubit;

    setUp(() {
      cubit = RosterCubit(MockUnitRepository());
    });

    tearDown(() {
      cubit.close();
    });

    testWidgets('shows Add Squad text', (tester) async {
      await tester.pumpWidget(
        _testApp(
          child: const AddSquadButton(squads: []),
          cubit: cubit,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Add Squad'), findsOneWidget);
    });

    testWidgets('calls addNewSquad on tap', (tester) async {
      await tester.pumpWidget(
        _testApp(
          child: const AddSquadButton(squads: []),
          cubit: cubit,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add Squad'));
      await tester.pumpAndSettle();

      // The cubit should now have a squad named 'Squad 1'
      expect(cubit.state.squads.length, 1);
      expect(cubit.state.squads.first.name, 'Squad 1');
    });

    testWidgets('generates unique squad name', (tester) async {
      final existingSquads = [
        const Squad(id: 1, name: 'Squad 1', primaryRole: Role.gp, models: []),
      ];

      await tester.pumpWidget(
        _testApp(
          child: AddSquadButton(squads: existingSquads),
          cubit: cubit,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add Squad'));
      await tester.pumpAndSettle();

      // Should skip 'Squad 1' (which is in the existing list) and create 'Squad 2'
      expect(cubit.state.squads.any((s) => s.name == 'Squad 2'), isTrue);
    });
  });
}
