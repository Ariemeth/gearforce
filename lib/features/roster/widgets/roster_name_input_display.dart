import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/core/theme/app_theme.dart';
import 'package:gearforce/core/widgets/labelled_row.dart';

class RosterNameInputDisplay extends StatelessWidget {
  const RosterNameInputDisplay({super.key, required this.rosterNameController});

  final TextEditingController rosterNameController;

  @override
  Widget build(BuildContext context) {
    return LabelledRow(
      padding: AppTheme.rosterNameSectionPadding,
      label: context.l10n.rosterNameField,
      gap: 8.0,
      child: TextField(
        controller: rosterNameController,
        decoration: InputDecoration(
          hintText: context.l10n.rosterNameInputFieldHint,
          border: OutlineInputBorder(),
          isDense: false,
          hintStyle: AppTheme.textHintStyle,
          // contentPadding: AppTheme.defaultPadding,
        ),
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.bottom,
        style: AppTheme.textInputFieldStyle,
        onSubmitted: (newName) {
          context.read<RosterBloc>().add(UpdateRosterName(rosterName: newName));
        },
      ),
    );
  }
}
