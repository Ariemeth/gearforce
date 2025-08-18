import 'package:flutter/material.dart';
import 'package:gearforce/src/generated/i18n/app_localizations.dart';
import 'package:gearforce/src/models/roster/squad.dart';
import 'package:gearforce/src/theme/app_theme.dart';
import 'package:gearforce/src/pages/roster/widgets/unit_selection_screen.dart';

class SelectModelButton extends StatelessWidget {
  const SelectModelButton({super.key, required this.updatedSquad});

  final Squad updatedSquad;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                UnitSelectionScreen(updatedSquad: updatedSquad),
          ),
        );
      },
      child: Text(
        AppLocalizations.of(context)!.squadAddUnitButtonText,
        style: AppTheme.buttonTextStyle,
      ),
    );
  }
}
