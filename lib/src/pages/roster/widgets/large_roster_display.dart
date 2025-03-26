import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/pages/roster/widgets/squad_display.dart';
import 'package:gearforce/src/widgets/display_layout_constraints.dart';

const _leftPanelMinWidth = 400.0;

class LargeRosterDisplay extends StatelessWidget {
  const LargeRosterDisplay({
    super.key,
    required this.rosterMetaData,
  });

  final DisplayLayoutConstraints rosterMetaData;

  @override
  Widget build(BuildContext context) {
    final state = context.read<RosterBloc>().state;
    return Row(
      children: [
        SizedBox(
          width: _leftPanelMinWidth,
          child: Column(
            children: [
              Expanded(
                child: SquadDisplay(
                  squads: state.squads,
                ),
              ),
              rosterMetaData,
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}
