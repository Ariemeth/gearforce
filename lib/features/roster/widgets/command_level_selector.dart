import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/domain/entities/attribute/command.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';

class CommandLevelSelector extends StatelessWidget {
  final Model model;
  final Squad squad;

  const CommandLevelSelector({
    super.key,
    required this.squad,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RosterCubit, RosterState>(
      builder: (context, state) {
        return DropdownButton<Command>(
          value: model.command,
          menuWidth: 90.0,
          items: Command.values.map((command) {
            final canSelect = state.ruleSet.canAssignCommandLevel(
              model: model,
              newCommandLevel: command,
              squad: squad,
              allSquads: state.squads,
            );

            return DropdownMenuItem<Command>(
              value: command,
              enabled: canSelect,
              child: Text(_labelForCommand(command)),
            );
          }).toList(),
          onChanged: (newCommand) {
            if (newCommand == null || newCommand == model.command) {
              return;
            }
            context.read<RosterCubit>().updateModelCommandLevel(
              model: model,
              squad: squad,
              commandLevel: newCommand,
            );
          },
        );
      },
    );
  }

  String _labelForCommand(Command command) {
    if (command == Command.none) {
      return 'None';
    }
    return command.name;
  }
}
