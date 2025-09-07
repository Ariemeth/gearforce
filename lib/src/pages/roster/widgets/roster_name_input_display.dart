import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/generated/i18n/app_localizations.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/theme/app_theme.dart';

class RosterNameInputDisplay extends StatelessWidget {
  const RosterNameInputDisplay({super.key, required this.rosterNameController});

  final TextEditingController rosterNameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppTheme.rosterNameSectionPadding,
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            SizedBox(
              width: 90,
              child: Text(
                AppLocalizations.of(context)!.rosterNameField,
                style: AppTheme.subtitleStyle,
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: rosterNameController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(
                    context,
                  )!.rosterNameInputFieldHint,
                  border: OutlineInputBorder(),
                  isDense: false,
                  hintStyle: AppTheme.textHintStyle,
                  // contentPadding: AppTheme.defaultPadding,
                ),
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.bottom,
                style: AppTheme.textInputFieldStyle,
                onSubmitted: (newName) {
                  context.read<RosterBloc>().add(
                    UpdateRosterName(rosterName: newName),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
