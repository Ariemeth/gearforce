import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:gearforce/core/routing/app_route_names.dart';
import 'package:gearforce/core/widgets/version_selector.dart';
import 'package:gearforce/versions/v4/domain/entities/unit/squad.dart';
import 'package:gearforce/versions/v4/features/roster/screens/model_details_screen.dart';
import 'package:gearforce/versions/v4/features/roster/screens/roster_screen.dart';
import 'package:gearforce/versions/v4/features/roster/screens/squad_details_screen.dart';
import 'package:gearforce/versions/v4/features/roster/screens/unit_selection_screen.dart';
import 'package:gearforce/versions/v4/features/roster/screens/weapon_display_screen.dart';
import 'package:gearforce/versions/v4/features/settings/screens/app_settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/v4',
  routes: [
    GoRoute(path: '/', redirect: (context, state) => '/v4'),
    GoRoute(
      path: '/settings',
      name: AppRouteNames.settings,
      builder: (context, state) => const AppSettingScreen(),
    ),
    GoRoute(
      path: '/v4',
      name: V4RouteNames.roster,
      builder: (context, state) => const RosterScreen(),
      routes: [
        GoRoute(
          path: 'weapons',
          name: V4RouteNames.weapons,
          builder: (context, state) => const WeaponDisplayScreen(),
        ),
        GoRoute(
          path: 'squad/:squadId',
          name: V4RouteNames.squadDetails,
          builder: (context, state) {
            final squadId = int.parse(state.pathParameters['squadId']!);
            return SquadDetailsScreen(squadId: squadId);
          },
          routes: [
            GoRoute(
              path: 'model/:modelId',
              name: V4RouteNames.modelDetails,
              builder: (context, state) {
                final squadId = int.parse(state.pathParameters['squadId']!);
                final modelId = int.parse(state.pathParameters['modelId']!);
                return ModelDetailsScreen(squadId: squadId, modelId: modelId);
              },
            ),
          ],
        ),
        GoRoute(
          path: 'select-unit',
          name: V4RouteNames.selectUnit,
          builder: (context, state) {
            final squad = state.extra as Squad;
            return UnitSelectionScreen(updatedSquad: squad);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/v3',
      name: V3RouteNames.roster,
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Gearforce v3.1'),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: VersionSelector(),
            ),
          ],
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.construction, size: 64, color: Colors.amber),
              SizedBox(height: 16),
              Text(
                'Version 3.1 Rules & Engine',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'This section is prepared for importing legacy v3.1 models and data.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    ),
  ],
);
