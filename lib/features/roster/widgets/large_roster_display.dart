import 'package:material_ui/material_ui.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/roster_edit_panel.dart';
import 'package:gearforce/core/theme/app_theme.dart';

class LargeRosterDisplay extends StatelessWidget {
  const LargeRosterDisplay({super.key, required this.state});

  final RosterState state;

  @override
  Widget build(BuildContext context) {
    final totalTv = state.squads.fold<int>(0, (sum, s) => sum + s.tv);
    final totalModels = state.squads.fold<int>(
      0,
      (sum, s) => sum + s.models.length,
    );
    final totalActions = state.squads.fold<int>(
      0,
      (sum, s) => sum + s.totalActions,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: RosterEditPanel(state: state, showTotalTv: false),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.rosterSummaryTitle,
                  style: AppTheme.titleStyle,
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.factionFieldLabel(
                            state.selectedFaction.displayName,
                          ),
                          style: AppTheme.subtitleStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          context.l10n.subFactionFieldLabel(
                            state.selectedSubfaction.displayName,
                          ),
                          style: AppTheme.subtitleStyle,
                        ),
                        const Divider(),
                        Text(
                          context.l10n.tvLabel(totalTv),
                          style: AppTheme.subtitleStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          context.l10n.totalSquadsLabel(state.squads.length),
                          style: AppTheme.subtitleStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          context.l10n.totalModelsLabel(totalModels),
                          style: AppTheme.subtitleStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          context.l10n.actionsLabel(totalActions),
                          style: AppTheme.subtitleStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
