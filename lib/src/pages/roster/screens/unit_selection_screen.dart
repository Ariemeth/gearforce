import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/models/roster/squad.dart';
import 'package:gearforce/src/models/roster/unit/model.dart';
import 'package:gearforce/src/models/roster/unit/unit.dart';
import 'package:gearforce/src/models/roster/unit/unit_list_extensions.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/pages/roster/widgets/model_list_card.dart';
import 'package:gearforce/src/predefined/filters/unit_filters.dart';
import 'package:gearforce/src/theme/app_theme.dart';

const double _modelListIndentWidth = 10.0;

class UnitSelectionScreen extends StatefulWidget {
  const UnitSelectionScreen({super.key, required this.updatedSquad});

  final Squad updatedSquad;

  @override
  State<UnitSelectionScreen> createState() => _UnitSelectionScreenState();
}

class _UnitSelectionScreenState extends State<UnitSelectionScreen> {
  final List<bool> _expandedStates = [];

  @override
  Widget build(BuildContext context) {
    final rosterState = context.read<RosterBloc>().state;

    final squadRoles = {
      widget.updatedSquad.primaryRole,
      if (widget.updatedSquad.secondaryRole != null)
        widget.updatedSquad.secondaryRole!,
    };

    // Fetch available units from the rule set
    final availableUnits = rosterState.ruleSet
        .getAvailableUnits()
        .filterBy(UnitFilters.matchByUnitAndVariantRoles(squadRoles))
        .toList();

    // Initialize expanded states
    if (_expandedStates.isEmpty ||
        _expandedStates.length != availableUnits.length) {
      _expandedStates.addAll(List<bool>.filled(availableUnits.length, false));
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text('Select a Unit', style: AppTheme.titleStyle),
        ),
      ),
      body: Padding(
        padding: AppTheme.defaultPagePadding,
        child: SingleChildScrollView(
          child: ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.fromLTRB(2, 0, 4, 2),
            expansionCallback: (index, isExpanded) {
              setState(() {
                _expandedStates[index] = isExpanded;
              });
            },
            children: availableUnits.map((unit) {
              final index = availableUnits.indexOf(unit);
              return ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return _UnitListHeader(unit);
                },
                body: Padding(
                  padding: const EdgeInsets.only(left: _modelListIndentWidth),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _UnitModelList(unit, widget.updatedSquad),
                  ),
                ),

                splashColor: Colors.blue.shade200,
                isExpanded: _expandedStates[index],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _UnitListHeader extends StatelessWidget {
  final Unit unit;
  const _UnitListHeader(this.unit);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade100,
      child: Column(
        children: [
          Text(unit.name, style: AppTheme.titleStyle),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${unit.variants.length} variants',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _UnitModelList extends StatelessWidget {
  const _UnitModelList(this.unit, this.updatedSquad);

  final Squad updatedSquad;
  final Unit unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: unit.variants.map((variant) {
        bool isHovered = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return MouseRegion(
              onEnter: (_) {
                setState(() {
                  isHovered = true;
                });
              },
              onExit: (_) {
                setState(() {
                  isHovered = false;
                });
              },
              child: GestureDetector(
                onTap: () {
                  final model = Model(base: unit.base, variant: variant);
                  context.read<RosterBloc>().add(
                    AddModel(squad: updatedSquad, model: model),
                  );

                  Navigator.pop(context);
                },
                child: Container(
                  color: isHovered
                      ? Theme.of(
                          context,
                        ).colorScheme.secondaryContainer.withAlpha(90)
                      : Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 3.0,
                  ),
                  child: ModelListCard(
                    model: Model(base: unit.base, variant: variant),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
