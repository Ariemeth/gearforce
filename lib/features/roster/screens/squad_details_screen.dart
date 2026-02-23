import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/select_model_button.dart';
import 'package:gearforce/features/roster/widgets/squad_role_selectors.dart';
import 'package:gearforce/features/roster/widgets/unit_level_selector.dart';
import 'package:gearforce/core/theme/app_theme.dart';

const _pagePadding = EdgeInsets.fromLTRB(8, 5, 8, 5);

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
            appBar: AppBar(title: Text('Squad $squadId')),
            body: Center(child: Text('No Squad with id $squadId is found')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Expanded(child: Center(child: Text(squad.name))),
                Text('TV: ${squad.tv}'),
              ],
            ),
            actions: [],
          ),
          body: Padding(
            padding: _pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SquadRoleSelectors(squad: squad),
                Divider(color: Colors.grey.shade400),
                Expanded(
                  child: ListView.builder(
                    itemCount: squad.models.length,
                    itemBuilder: (context, index) {
                      final model = squad.models[index];
                      return ListTile(
                        title: Text(model.name, style: AppTheme.bodyStyle),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('TV: ${model.tv}'),
                            UnitLevelSelector(squad: squad, model: model),
                          ],
                        ),
                        contentPadding: AppTheme.listTilePadding,
                      );
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
