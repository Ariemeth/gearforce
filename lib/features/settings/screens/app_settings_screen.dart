import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/features/settings/bloc/app_settings_bloc.dart';
import 'package:gearforce/features/settings/bloc/app_settings_state.dart';
import 'package:gearforce/core/widgets/constrained_content.dart';

const _pagePadding = EdgeInsets.all(16);
const double _maxContentWidth = 600;

class AppSettingScreen extends StatelessWidget {
  const AppSettingScreen({super.key});

  static const routeName = '/app_settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.appSettingsTitle(context.l10n.appTitle)),
      ),
      body: ConstrainedContent(
        maxWidth: _maxContentWidth,
        padding: _pagePadding,
        child: BlocBuilder<AppSettingsCubit, AppSettingsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<ThemeMode>(
                  initialValue: state.themeMode,
                  onChanged: (newThemeMode) {
                    if (newThemeMode != null &&
                        newThemeMode != state.themeMode) {
                      context.read<AppSettingsCubit>().updateThemeMode(
                        newThemeMode,
                      );
                    }
                  },
                  decoration: InputDecoration(
                    labelText: context.l10n.settingsThemeLabel,
                    helperText: context.l10n.settingsThemeHelper,
                    border: const OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text(context.l10n.settingsThemeSystem),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text(context.l10n.settingsThemeLight),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text(context.l10n.settingsThemeDark),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<UiDisplayMode>(
                  initialValue: state.uiDisplayMode,
                  onChanged: (newDisplayMode) {
                    if (newDisplayMode != null &&
                        newDisplayMode != state.uiDisplayMode) {
                      context.read<AppSettingsCubit>().updateUiDisplayMode(
                        newDisplayMode,
                      );
                    }
                  },
                  decoration: InputDecoration(
                    labelText: context.l10n.settingsDisplayModeLabel,
                    helperText: context.l10n.settingsDisplayModeHelper,
                    border: const OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: UiDisplayMode.auto,
                      child: Text(context.l10n.settingsDisplayModeAuto),
                    ),
                    DropdownMenuItem(
                      value: UiDisplayMode.mobile,
                      child: Text(context.l10n.settingsDisplayModeMobile),
                    ),
                    DropdownMenuItem(
                      value: UiDisplayMode.desktop,
                      child: Text(context.l10n.settingsDisplayModeDesktop),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
