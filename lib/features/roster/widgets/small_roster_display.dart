import 'package:flutter/material.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/roster_edit_panel.dart';

class SmallRosterDisplay extends StatelessWidget {
  const SmallRosterDisplay({super.key, required this.state});

  final RosterState state;

  @override
  Widget build(BuildContext context) {
    return RosterEditPanel(state: state);
  }
}
