import 'package:flutter/material.dart';
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
    return DropdownButton<Command>(
      value: model.command,
      menuWidth: 90.0,
      items: Command.values
          .map(
            (command) => DropdownMenuItem<Command>(
              value: command,
              child: Text(_labelForCommand(command)),
            ),
          )
          .toList(),
      onChanged: (newCommand) {
        if (newCommand == null || newCommand == model.command) {
          return;
        }
        context.read<RosterBloc>().add(
          UpdateModelCommandLevel(
            model: model,
            squad: squad,
            commandLevel: newCommand,
          ),
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
