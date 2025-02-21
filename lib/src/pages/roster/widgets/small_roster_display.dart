import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/generated/i18n/app_localizations.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/pages/roster/widgets/combat_group_display.dart';
import 'package:gearforce/src/widgets/display_layout_constraints.dart';
import 'package:gearforce/src/theme/app_theme.dart';

class SmallRosterDisplay extends StatelessWidget {
  const SmallRosterDisplay({
    super.key,
    required this.rosterMetaData,
  });

  final DisplayLayoutConstraints rosterMetaData;

  @override
  Widget build(BuildContext context) {
    final state = context.read<RosterBloc>().state;
    final TextEditingController rosterNameController =
        TextEditingController(text: state.rosterName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.rosterNameField,
              style: AppTheme.titleStyle,
            ),
            Expanded(
              child: TextField(
                controller: rosterNameController,
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(context)!.rosterNameInputFieldHint,
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: AppTheme.defaultPadding,
                ),
                style: AppTheme.textInputStyle,
                onSubmitted: (newName) {
                  context.read<RosterBloc>().add(UpdateRosterName(newName));
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: CombatGroupDisplay(
            combatGroups: state.combatGroups,
          ),
        ),
        rosterMetaData,
      ],
    );
  }
}
