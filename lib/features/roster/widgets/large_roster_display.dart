import 'package:flutter/material.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/squad_display.dart';
import 'package:gearforce/core/widgets/display_layout_constraints.dart';

const _leftPanelMinWidth = 400.0;

class LargeRosterDisplay extends StatelessWidget {
  const LargeRosterDisplay({
    super.key,
    required this.rosterMetaData,
    required this.state,
  });

  final DisplayLayoutConstraints rosterMetaData;
  final RosterState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: _leftPanelMinWidth,
          child: Column(
            children: [
              Expanded(child: SquadDisplay(squads: state.squads)),
              rosterMetaData,
            ],
          ),
        ),
        Expanded(child: Container(color: Colors.blueGrey)),
      ],
    );
  }
}
