import 'package:flutter/material.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/faction_selector.dart';
import 'package:gearforce/features/roster/widgets/roster_name_input_display.dart';
import 'package:gearforce/features/roster/widgets/sub_faction_selector.dart';
import 'package:gearforce/core/widgets/display_layout_constraints.dart';
import 'package:gearforce/features/roster/widgets/squad_display.dart';

class SmallRosterDisplay extends StatefulWidget {
  const SmallRosterDisplay({
    super.key,
    required this.rosterMetaData,
    required this.state,
  });

  final DisplayLayoutConstraints rosterMetaData;
  final RosterState state;

  @override
  State<SmallRosterDisplay> createState() => _SmallRosterDisplayState();
}

class _SmallRosterDisplayState extends State<SmallRosterDisplay> {
  late final TextEditingController _rosterNameController;

  @override
  void initState() {
    super.initState();
    _rosterNameController = TextEditingController(
      text: widget.state.rosterName,
    );
  }

  @override
  void didUpdateWidget(SmallRosterDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state.rosterName != widget.state.rosterName &&
        _rosterNameController.text != widget.state.rosterName) {
      _rosterNameController.text = widget.state.rosterName;
    }
  }

  @override
  void dispose() {
    _rosterNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RosterNameInputDisplay(rosterNameController: _rosterNameController),
        FactionSelector(state: state),
        SubFactionSelector(state: state),
        Expanded(child: SquadDisplay(squads: state.squads)),
        widget.rosterMetaData,
      ],
    );
  }
}
