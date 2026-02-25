import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/faction/subfaction.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/core/theme/app_theme.dart';

class SubFactionSelector extends StatelessWidget {
  const SubFactionSelector({super.key, required this.state});

  final RosterState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppTheme.subfactionSelectorPadding,
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              context.l10n.subFactionLabel,
              style: AppTheme.subtitleStyle,
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(width: 6),
          Expanded(
            child: DropdownButton<Subfaction>(
              isExpanded: true,
              value: state.selectedSubfaction,
              items: state.selectedFaction.subfactions
                  .map(
                    (subfaction) => DropdownMenuItem(
                      value: subfaction,
                      child: Padding(
                        padding: AppTheme.dropdownTextPadding,
                        child: Text(
                          subfaction.displayName,
                          style: AppTheme.subtitleStyle,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (Subfaction? newSubfaction) {
                if (newSubfaction != null) {
                  context.read<RosterBloc>().add(
                    UpdateSubfaction(subfaction: newSubfaction),
                  );
                }
              },
              hint: Padding(
                padding: AppTheme.subfactionSelectorPadding,
                child: Text(
                  context.l10n.subfactionSelectDropdownHint,
                  style: AppTheme.dropdownHintTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
