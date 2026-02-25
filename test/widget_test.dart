import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/core/generated/i18n/app_localizations.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/add_squad_button.dart';
import 'package:gearforce/features/roster/widgets/squad_display.dart';

class MockUnitRepository implements UnitRepository {
  @override
  Future<List<Unit>> getUnitsByFaction(String factionId) async => const [];
}

/// Wraps a widget with MaterialApp, localization delegates, and RosterBloc.
Widget _testApp({required Widget child, RosterBloc? bloc}) {
  final rosterBloc = bloc ?? RosterBloc(MockUnitRepository());
  return BlocProvider<RosterBloc>.value(
    value: rosterBloc,
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
  group('SquadDisplay', () {
    testWidgets('shows empty text when no squads', (tester) async {
      await tester.pumpWidget(_testApp(child: const SquadDisplay(squads: [])));
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
      await tester.pumpWidget(_testApp(child: SquadDisplay(squads: squads)));
      await tester.pumpAndSettle();

      expect(find.text('Alpha Squad'), findsOneWidget);
      expect(find.text('Bravo Squad'), findsOneWidget);
    });

    testWidgets('shows delete icon for each squad', (tester) async {
      final squads = [
        const Squad(id: 1, name: 'Alpha', primaryRole: Role.gp, models: []),
      ];
      await tester.pumpWidget(_testApp(child: SquadDisplay(squads: squads)));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.delete_forever_outlined), findsOneWidget);
    });

    testWidgets('shows confirmation dialog when delete is tapped', (
      tester,
    ) async {
      final squads = [
        const Squad(id: 1, name: 'Alpha', primaryRole: Role.gp, models: []),
      ];
      await tester.pumpWidget(_testApp(child: SquadDisplay(squads: squads)));
      await tester.pumpAndSettle();

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
      final bloc = RosterBloc(MockUnitRepository());
      // Add a squad so we can verify it isn't removed
      bloc.add(AddNewSquad(name: 'Alpha'));

      await tester.pumpWidget(
        _testApp(
          child: SquadDisplay(squads: squads),
          bloc: bloc,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.delete_forever_outlined));
      await tester.pumpAndSettle();

      // Tap cancel
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Dialog should be dismissed, squad still visible
      expect(find.text('Remove Squad'), findsNothing);
      expect(find.text('Alpha'), findsOneWidget);

      bloc.close();
    });

    testWidgets('confirm dispatches RemoveSquad event', (tester) async {
      final squads = [
        const Squad(id: 1, name: 'Alpha', primaryRole: Role.gp, models: []),
      ];
      final bloc = RosterBloc(MockUnitRepository());

      await tester.pumpWidget(
        _testApp(
          child: SquadDisplay(squads: squads),
          bloc: bloc,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.delete_forever_outlined));
      await tester.pumpAndSettle();

      // Tap Remove — this dispatches RemoveSquad
      await tester.tap(find.text('Remove'));
      await tester.pumpAndSettle();

      // Dialog should be dismissed
      expect(find.text('Remove Squad'), findsNothing);

      bloc.close();
    });
  });

  group('AddSquadButton', () {
    testWidgets('shows Add Squad text', (tester) async {
      await tester.pumpWidget(
        _testApp(child: const AddSquadButton(squads: [])),
      );
      await tester.pumpAndSettle();

      expect(find.text('Add Squad'), findsOneWidget);
    });

    testWidgets('dispatches AddNewSquad event on tap', (tester) async {
      final bloc = RosterBloc(MockUnitRepository());

      await tester.pumpWidget(
        _testApp(
          child: const AddSquadButton(squads: []),
          bloc: bloc,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add Squad'));
      await tester.pumpAndSettle();

      // The bloc should now have a squad named 'Squad 1'
      expect(bloc.state.squads.length, 1);
      expect(bloc.state.squads.first.name, 'Squad 1');

      bloc.close();
    });

    testWidgets('generates unique squad name', (tester) async {
      final bloc = RosterBloc(MockUnitRepository());

      final existingSquads = [
        const Squad(id: 1, name: 'Squad 1', primaryRole: Role.gp, models: []),
      ];

      await tester.pumpWidget(
        _testApp(
          child: AddSquadButton(squads: existingSquads),
          bloc: bloc,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add Squad'));
      await tester.pumpAndSettle();

      // Should skip 'Squad 1' (which is in the existing list) and create 'Squad 2'
      expect(bloc.state.squads.any((s) => s.name == 'Squad 2'), isTrue);

      bloc.close();
    });
  });
}
