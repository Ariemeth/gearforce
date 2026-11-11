import 'package:material_ui/material_ui.dart';
import 'package:gearforce/core/generated/i18n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
