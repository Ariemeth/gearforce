import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';

class DuelistToggle extends StatelessWidget {
  final Model model;
  final Squad squad;

  const DuelistToggle({super.key, required this.squad, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RosterCubit, RosterState>(
      builder: (context, state) {
        final canToggle = state.ruleSet.canAssignDuelist(
          model: model,
          newDuelistStatus: !model.isDuelist,
          squad: squad,
          allSquads: state.squads,
        );

        return Tooltip(
          message: model.isDuelist
              ? 'Duelist'
              : (canToggle ? 'Make Duelist (+1 TV)' : 'Cannot be Duelist'),
          child: IconButton(
            icon: Icon(
              model.isDuelist ? Icons.circle : Icons.circle_outlined,
              color: model.isDuelist
                  ? Colors.blue
                  : (canToggle ? Colors.blue : Colors.grey),
            ),
            iconSize: 20,
            onPressed: canToggle
                ? () {
                    context.read<RosterCubit>().updateModelIsDuelist(
                      model: model,
                      squad: squad,
                      isDuelist: !model.isDuelist,
                    );
                  }
                : null,
          ),
        );
      },
    );
  }
}
