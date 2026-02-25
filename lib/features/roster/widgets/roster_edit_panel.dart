import 'package:flutter/material.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/faction_selector.dart';
import 'package:gearforce/features/roster/widgets/roster_name_input_display.dart';
import 'package:gearforce/features/roster/widgets/sub_faction_selector.dart';
import 'package:gearforce/features/roster/widgets/squad_display.dart';

/// The left-column editing panel shared by both small and large roster layouts.
///
/// Manages the [TextEditingController] lifecycle for the roster name field
/// and renders: name input, faction selector, sub-faction selector, squad list.
class RosterEditPanel extends StatefulWidget {
  const RosterEditPanel({super.key, required this.state});

  final RosterState state;

  @override
  State<RosterEditPanel> createState() => _RosterEditPanelState();
}

class _RosterEditPanelState extends State<RosterEditPanel> {
  late final TextEditingController _rosterNameController;

  @override
  void initState() {
    super.initState();
    _rosterNameController = TextEditingController(
      text: widget.state.rosterName,
    );
  }

  @override
  void didUpdateWidget(RosterEditPanel oldWidget) {
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
      ],
    );
  }
}
