import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/widgets/responsive_size.dart';
import 'package:gearforce/features/settings/bloc/app_settings_bloc.dart';
import 'package:gearforce/features/settings/bloc/app_settings_state.dart';

/// A reusable layout widget that selects between [compact], [medium], and
/// [expanded] child widgets based on user settings override or screen width.
///
/// If [AppSettingsState.uiDisplayMode] is set to [UiDisplayMode.mobile] or
/// [UiDisplayMode.desktop], it forces that display mode. Otherwise, it defaults
/// to [UiDisplayMode.auto] and uses [LayoutBuilder] constraints.
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.compact,
    this.medium,
    required this.expanded,
  });

  /// Widget shown on compact screens (width < 600).
  final Widget compact;

  /// Widget shown on medium screens (600 <= width < 840).
  /// Falls back to [compact] if not provided.
  final Widget? medium;

  /// Widget shown on expanded screens (width >= 840).
  final Widget expanded;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, settingsState) {
        if (settingsState.uiDisplayMode == UiDisplayMode.mobile) {
          return compact;
        }
        if (settingsState.uiDisplayMode == UiDisplayMode.desktop) {
          return expanded;
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final screenSize = ResponsiveSize.fromConstraints(constraints);
            return switch (screenSize) {
              ScreenSize.compact => compact,
              ScreenSize.medium => medium ?? compact,
              ScreenSize.expanded => expanded,
            };
          },
        );
      },
    );
  }
}
