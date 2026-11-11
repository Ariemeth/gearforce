import 'package:material_ui/material_ui.dart';
import 'package:gearforce/core/generated/i18n/app_localizations.dart';

/// Shows a confirmation dialog for removing a squad.
///
/// Returns `true` if the user confirms, `false` or `null` otherwise.
Future<bool?> showRemoveSquadDialog({
  required BuildContext context,
  required String squadName,
}) {
  final l10n = AppLocalizations.of(context)!;
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Center(child: Text(l10n.removeSquadConfirmTitle)),
      content: Text(l10n.removeSquadConfirmMessage(squadName)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancelButtonText),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.removeButtonText),
        ),
      ],
    ),
  );
}
