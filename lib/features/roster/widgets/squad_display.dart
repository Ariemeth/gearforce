import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/screens/squad_details_screen.dart';
import 'package:gearforce/features/roster/widgets/add_squad_button.dart';
import 'package:gearforce/features/roster/widgets/remove_squad_dialog.dart';
import 'package:gearforce/core/theme/app_theme.dart';

class SquadDisplay extends StatelessWidget {
  final List<Squad> squads;

  const SquadDisplay({super.key, required this.squads});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: squads.isEmpty
              ? Center(
                  child: Text(
                    context.l10n.noSquadsText,
                    style: AppTheme.subtitleStyle,
                  ),
                )
              : ReorderableListView.builder(
                  itemCount: squads.length,
                  buildDefaultDragHandles: false,
                  onReorder: (oldIndex, newIndex) {
                    context.read<RosterBloc>().add(
                      ReorderSquad(oldIndex: oldIndex, newIndex: newIndex),
                    );
                  },
                  itemBuilder: (context, index) {
                    final squad = squads[index];

                    return ReorderableDragStartListener(
                      key: ValueKey(squad.id),
                      index: index,
                      child: ListTile(
                        contentPadding: AppTheme.listTilePadding,
                        title: Text(squad.name, style: AppTheme.subtitleStyle),
                        subtitle: Wrap(
                          spacing: 12,
                          runSpacing: 4,
                          children: [
                            Text(
                              context.l10n.tvLabel(squad.tv),
                              style: AppTheme.squadUnitBodyStyle,
                            ),
                            Text(
                              context.l10n.totalUnitsLabel(squad.models.length),
                              style: AppTheme.squadUnitBodyStyle,
                            ),
                            Text(
                              context.l10n.actionsLabel(squad.totalActions),
                              style: AppTheme.squadUnitBodyStyle,
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              squad.primaryRole.abbreviation,
                              style: AppTheme.squadUnitBodyStyle,
                            ),
                            if (squad.secondaryRole != null) ...[
                              const SizedBox(width: 4),
                              Text('/', style: AppTheme.squadUnitBodyStyle),
                              const SizedBox(width: 4),
                              Text(
                                squad.secondaryRole!.abbreviation,
                                style: AppTheme.squadUnitBodyStyle,
                              ),
                            ],
                            const SizedBox(width: 4),
                            IconButton(
                              icon: const Icon(Icons.more_vert),
                              tooltip: context.l10n.modelActionsTooltip,
                              onPressed: () async {
                                final action =
                                    await showDialog<_SquadTileAction>(
                                      context: context,
                                      builder: (dialogContext) => AlertDialog(
                                        title: Text(
                                          context.l10n.modelActionsTitle,
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              leading: const Icon(
                                                Icons.delete_forever_outlined,
                                                color: AppTheme.deleteIconColor,
                                              ),
                                              title: Text(
                                                context.l10n.deleteButtonText,
                                              ),
                                              onTap: () => Navigator.of(
                                                dialogContext,
                                              ).pop(_SquadTileAction.delete),
                                            ),
                                            ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              leading: const Icon(
                                                Icons.copy_outlined,
                                              ),
                                              title: Text(
                                                context
                                                    .l10n
                                                    .duplicateButtonText,
                                              ),
                                              onTap: () => Navigator.of(
                                                dialogContext,
                                              ).pop(_SquadTileAction.duplicate),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(
                                              dialogContext,
                                            ).pop(),
                                            child: Text(
                                              context.l10n.cancelButtonText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );

                                if (!context.mounted || action == null) {
                                  return;
                                }

                                if (action == _SquadTileAction.delete) {
                                  final confirmed = await showRemoveSquadDialog(
                                    context: context,
                                    squadName: squad.name,
                                  );
                                  if (confirmed == true && context.mounted) {
                                    context.read<RosterBloc>().add(
                                      RemoveSquad(squad: squad),
                                    );
                                  }
                                  return;
                                }

                                if (action == _SquadTileAction.duplicate) {
                                  final duplicateName =
                                      generateUniqueDefaultSquadName(
                                        context,
                                        squads,
                                      );
                                  context.read<RosterBloc>().add(
                                    DuplicateSquad(
                                      squad: squad,
                                      name: duplicateName,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SquadDetailsScreen(squadId: squad.id),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
        AddSquadButton(squads: squads),
      ],
    );
  }
}

enum _SquadTileAction { delete, duplicate }
