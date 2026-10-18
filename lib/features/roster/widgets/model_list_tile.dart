import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/command_level_selector.dart';
import 'package:gearforce/features/roster/widgets/unit_level_selector.dart';
import 'package:gearforce/features/roster/widgets/duelist_toggle.dart';
import 'package:gearforce/core/theme/app_theme.dart';

/// A list tile displaying a model's name, TV, level selector, and delete button.
class ModelListTile extends StatelessWidget {
  final Squad squad;
  final Model model;

  const ModelListTile({super.key, required this.squad, required this.model});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(model.name, style: AppTheme.squadUnitNameStyle),
      onTap: () {
        context.push('/squad/${squad.id}/model/${model.id}');
      },
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            context.l10n.tvLabel(model.tv),
            style: AppTheme.squadUnitBodyStyle,
          ),
          const Spacer(),
          DuelistToggle(squad: squad, model: model),
          const SizedBox(width: 8),
          CommandLevelSelector(squad: squad, model: model),
          const SizedBox(width: 8),
          UnitLevelSelector(squad: squad, model: model),
          IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: context.l10n.modelActionsTooltip,
            iconSize: 20,
            onPressed: () async {
              final action = await showDialog<_ModelTileAction>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: Text(context.l10n.modelActionsTitle),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(
                          Icons.delete_forever_outlined,
                          color: AppTheme.deleteIconColor,
                        ),
                        title: Text(context.l10n.deleteButtonText),
                        onTap: () => Navigator.of(
                          dialogContext,
                        ).pop(_ModelTileAction.delete),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.copy_outlined),
                        title: Text(context.l10n.duplicateButtonText),
                        onTap: () => Navigator.of(
                          dialogContext,
                        ).pop(_ModelTileAction.duplicate),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      child: Text(context.l10n.cancelButtonText),
                    ),
                  ],
                ),
              );

              if (!context.mounted || action == null) {
                return;
              }

              if (action == _ModelTileAction.delete) {
                context.read<RosterBloc>().add(
                  RemoveModel(squad: squad, model: model),
                );
                return;
              }

              if (action == _ModelTileAction.duplicate) {
                context.read<RosterBloc>().add(
                  DuplicateModel(squad: squad, model: model),
                );
              }
            },
          ),
        ],
      ),
      contentPadding: AppTheme.listTilePadding,
    );
  }
}

enum _ModelTileAction { delete, duplicate }
