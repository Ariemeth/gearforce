import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/screens/unit_selection_screen.dart';
import 'package:gearforce/core/theme/app_theme.dart';

class SelectModelButton extends StatelessWidget {
  const SelectModelButton({super.key, required this.updatedSquad});

  final Squad updatedSquad;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RosterBloc, RosterState, bool>(
      selector: (state) {
        return state.ruleSet.canAddAnyUnitToSquad(squad: updatedSquad);
      },
      builder: (context, canAddUnits) {
        return ElevatedButton(
          onPressed: canAddUnits
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) =>
                          UnitSelectionScreen(updatedSquad: updatedSquad),
                    ),
                  );
                }
              : null,
          child: Text(
            context.l10n.squadAddUnitButtonText,
            style: AppTheme.buttonTextStyle,
          ),
        );
      },
    );
  }
}
