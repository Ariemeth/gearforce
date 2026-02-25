import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/unit_level_selector.dart';
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
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            context.l10n.tvLabel(model.tv),
            style: AppTheme.squadUnitBodyStyle,
          ),
          const Spacer(),
          UnitLevelSelector(squad: squad, model: model),
          IconButton(
            icon: const Icon(
              Icons.delete_forever_outlined,
              color: AppTheme.deleteIconColor,
            ),
            tooltip: context.l10n.removeUnitTooltip,
            iconSize: 20,
            onPressed: () {
              context.read<RosterBloc>().add(
                RemoveModel(squad: squad, model: model),
              );
            },
          ),
        ],
      ),
      contentPadding: AppTheme.listTilePadding,
    );
  }
}
