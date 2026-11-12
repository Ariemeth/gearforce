import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:gearforce/core/widgets/responsive_layout.dart';
import 'package:gearforce/features/settings/bloc/app_settings_bloc.dart';
import 'package:gearforce/features/settings/bloc/app_settings_repository.dart';
import 'package:gearforce/features/settings/bloc/app_settings_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ResponsiveLayout Override', () {
    late AppSettingsRepository repository;
    late AppSettingsCubit settingsCubit;

    setUp(() {
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.empty();
      repository = AppSettingsRepository();
      settingsCubit = AppSettingsCubit(repository);
    });

    tearDown(() {
      settingsCubit.close();
    });

    Widget buildTestWidget({required double width}) {
      return MaterialApp(
        home: BlocProvider<AppSettingsCubit>.value(
          value: settingsCubit,
          child: Scaffold(
            body: Center(
              child: SizedBox(
                width: width,
                height: 800,
                child: const ResponsiveLayout(
                  compact: Text('Compact View'),
                  expanded: Text('Expanded View'),
                ),
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('renders based on width when UiDisplayMode is auto', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestWidget(width: 400));
      expect(find.text('Compact View'), findsOneWidget);
      expect(find.text('Expanded View'), findsNothing);

      await tester.pumpWidget(buildTestWidget(width: 1000));
      expect(find.text('Expanded View'), findsOneWidget);
      expect(find.text('Compact View'), findsNothing);
    });

    testWidgets(
      'forces Mobile layout regardless of width when UiDisplayMode is mobile',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await settingsCubit.updateUiDisplayMode(UiDisplayMode.mobile);

        await tester.pumpWidget(buildTestWidget(width: 1000));
        await tester.pumpAndSettle();

        expect(find.text('Compact View'), findsOneWidget);
        expect(find.text('Expanded View'), findsNothing);
      },
    );

    testWidgets(
      'forces Desktop layout regardless of width when UiDisplayMode is desktop',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await settingsCubit.updateUiDisplayMode(UiDisplayMode.desktop);

        await tester.pumpWidget(buildTestWidget(width: 400));
        await tester.pumpAndSettle();

        expect(find.text('Expanded View'), findsOneWidget);
        expect(find.text('Compact View'), findsNothing);
      },
    );
  });
}
