import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/core/theme/app_theme.dart';
import 'package:gearforce/core/widgets/labelled_row.dart';

class FactionSelector extends StatelessWidget {
  const FactionSelector({super.key, required this.state});

  final RosterState state;

  @override
  Widget build(BuildContext context) {
    return LabelledRow(
      padding: AppTheme.factionSelectorPadding,
      label: context.l10n.factionLabel,
      child: DropdownButton<Faction>(
        value: state.selectedFaction,
        isExpanded: true,
        items: Faction.values
            .map(
              (faction) => DropdownMenuItem(
                value: faction,
                child: Padding(
                  padding: AppTheme.dropdownTextPadding,
                  child: Text(
                    faction.displayName,
                    style: AppTheme.subtitleStyle,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (Faction? newFaction) {
          if (newFaction != null) {
            context.read<RosterBloc>().add(UpdateFaction(faction: newFaction));
          }
        },
        hint: Padding(
          padding: AppTheme.factionSelectorPadding,
          child: Text(
            context.l10n.factionSelectDropdownHint,
            style: AppTheme.dropdownHintTextStyle,
          ),
        ),
      ),
    );
  }
}
