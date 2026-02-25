import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/model_list_tile.dart';
import 'package:gearforce/features/roster/widgets/remove_squad_dialog.dart';
import 'package:gearforce/features/roster/widgets/select_model_button.dart';
import 'package:gearforce/features/roster/widgets/squad_role_selectors.dart';
import 'package:gearforce/core/theme/app_theme.dart';
import 'package:gearforce/core/widgets/constrained_content.dart';

const _pagePadding = EdgeInsets.fromLTRB(8, 5, 8, 5);
const double _maxContentWidth = 800;

class SquadDetailsScreen extends StatelessWidget {
  final int squadId;

  const SquadDetailsScreen({super.key, required this.squadId});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RosterBloc, RosterState, Squad?>(
      selector: (state) {
        if (!state.squads.any((s) => s.id == squadId)) {
          return null;
        }
        return state.squads.firstWhere((s) => s.id == squadId);
      },
      builder: (context, squad) {
        if (squad == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text(context.l10n.squadNotFoundTitle(squadId)),
            ),
            body: Center(
              child: Text(context.l10n.squadNotFoundMessage(squadId)),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Center(child: _EditableSquadName(squad: squad)),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.delete_forever_outlined,
                  color: AppTheme.deleteIconColor,
                ),
                onPressed: () async {
                  final confirmed = await showRemoveSquadDialog(
                    context: context,
                    squadName: squad.name,
                  );
                  if (confirmed == true && context.mounted) {
                    context.read<RosterBloc>().add(RemoveSquad(squad: squad));
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                },
              ),
            ],
          ),
          body: ConstrainedContent(
            maxWidth: _maxContentWidth,
            padding: _pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      context.l10n.tvLabel(squad.tv),
                      style: AppTheme.squadInfoStyle,
                    ),
                    Text(
                      context.l10n.actionsLabel(squad.totalActions),
                      style: AppTheme.squadInfoStyle,
                    ),
                  ],
                ),
                SquadRoleSelectors(squad: squad),
                Divider(color: Colors.grey.shade400),
                Expanded(
                  child: ListView.builder(
                    itemCount: squad.models.length,
                    itemBuilder: (context, index) {
                      final model = squad.models[index];
                      return ModelListTile(squad: squad, model: model);
                    },
                  ),
                ),
                Center(child: SelectModelButton(updatedSquad: squad)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EditableSquadName extends StatefulWidget {
  final Squad squad;

  const _EditableSquadName({required this.squad});

  @override
  State<_EditableSquadName> createState() => _EditableSquadNameState();
}

class _EditableSquadNameState extends State<_EditableSquadName> {
  bool _isEditing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.squad.name);
  }

  @override
  void didUpdateWidget(covariant _EditableSquadName oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isEditing && oldWidget.squad.name != widget.squad.name) {
      _controller.text = widget.squad.name;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitName() {
    final newName = _controller.text.trim();
    if (newName.isNotEmpty && newName != widget.squad.name) {
      context.read<RosterBloc>().add(
        RenameSquad(squad: widget.squad, newName: newName),
      );
    } else {
      _controller.text = widget.squad.name;
    }
    setState(() => _isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      return TextField(
        controller: _controller,
        autofocus: true,
        textAlign: TextAlign.center,
        style: AppTheme.squadNameEditingStyle,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 4),
        ),
        onSubmitted: (_) => _submitName(),
        onTapOutside: (_) => _submitName(),
      );
    }

    return GestureDetector(
      onTap: () => setState(() => _isEditing = true),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.squad.name, style: AppTheme.squadNameStyle),
          const SizedBox(width: 4),
          const Icon(Icons.edit, size: 16),
        ],
      ),
    );
  }
}
