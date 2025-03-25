import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/pages/roster/widgets/combat_group_display.dart';
import 'package:gearforce/src/pages/roster/widgets/faction_selector.dart';
import 'package:gearforce/src/pages/roster/widgets/roster_name_input_display.dart';
import 'package:gearforce/src/pages/roster/widgets/sub_faction_selector.dart';
import 'package:gearforce/src/widgets/display_layout_constraints.dart';

class SmallRosterDisplay extends StatelessWidget {
  const SmallRosterDisplay({
    super.key,
    required this.rosterMetaData,
  });

  final DisplayLayoutConstraints rosterMetaData;

  @override
  Widget build(BuildContext context) {
    final state = context.read<RosterBloc>().state;
    final TextEditingController rosterNameController =
        TextEditingController(text: state.rosterName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RosterNameInputDisplay(rosterNameController: rosterNameController),
        FactionSelector(state: state),
        SubFactionSelector(state: state),
        Expanded(
          child: CombatGroupDisplay(
            combatGroups: state.combatGroups,
          ),
        ),
        rosterMetaData,
      ],
    );
  }
}
