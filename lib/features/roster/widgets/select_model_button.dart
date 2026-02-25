import 'package:flutter/material.dart';
import 'package:gearforce/core/generated/i18n/app_localizations.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/features/roster/screens/unit_selection_screen.dart';
import 'package:gearforce/core/theme/app_theme.dart';

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
