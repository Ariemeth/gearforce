import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/generated/i18n/app_localizations.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/models/roster/faction.dart';
import 'package:gearforce/src/theme/app_theme.dart';

class FactionSelector extends StatelessWidget {
  const FactionSelector({
    super.key,
    required this.state,
  });

  final RosterState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppTheme.factionSelectorPadding,
      child: SizedBox(
        width: 120,
        child: DropdownButton<Faction>(
          value: state.selectedFaction,
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
              context.read<RosterBloc>().add(UpdateFactionEvent(newFaction));
            }
          },
          hint: Padding(
            padding: AppTheme.factionSelectorPadding,
            child: Text(
              AppLocalizations.of(context)!.factionSelectDropdownHint,
              style: AppTheme.dropdownHintTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
