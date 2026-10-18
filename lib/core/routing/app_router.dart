import 'package:go_router/go_router.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/features/roster/screens/model_details_screen.dart';
import 'package:gearforce/features/roster/screens/roster_screen.dart';
import 'package:gearforce/features/roster/screens/squad_details_screen.dart';
import 'package:gearforce/features/roster/screens/unit_selection_screen.dart';
import 'package:gearforce/features/roster/screens/weapon_display_screen.dart';
import 'package:gearforce/features/settings/screens/app_settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: RosterScreen.routeName,
      builder: (context, state) => const RosterScreen(),
      routes: [
        GoRoute(
          path: 'squad/:squadId',
          builder: (context, state) {
            final squadId = int.parse(state.pathParameters['squadId']!);
            return SquadDetailsScreen(squadId: squadId);
          },
          routes: [
            GoRoute(
              path: 'model/:modelId',
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
          builder: (context, state) {
            final squad = state.extra as Squad;
            return UnitSelectionScreen(updatedSquad: squad);
          },
        ),
      ],
    ),
    GoRoute(
      path: WeaponDisplayScreen.routeName,
      builder: (context, state) => const WeaponDisplayScreen(),
    ),
    GoRoute(
      path: AppSettingScreen.routeName,
      builder: (context, state) => const AppSettingScreen(),
    ),
  ],
);
