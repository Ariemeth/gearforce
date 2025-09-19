import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/models/roster/squad.dart';
import 'package:gearforce/src/models/roster/unit/model.dart';
import 'package:gearforce/src/models/roster/unit/unit_list_extensions.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/pages/roster/widgets/unit_list_card.dart';
import 'package:gearforce/src/predefined/filters/unit_filters.dart';
import 'package:gearforce/src/theme/app_theme.dart';

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
        .filterBy(UnitFilters.matchByRoles(squadRoles))
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
            expandedHeaderPadding: EdgeInsets.all(0),
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
                  return ListTile(
                    contentPadding: EdgeInsets.all(0),
                    titleAlignment: ListTileTitleAlignment.center,
                    title: UnitListCard.header(unit: unit),
                    tileColor: Colors.blue.shade100,
                  );
                },
                body: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
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
                                final model = Model(
                                  base: unit.base,
                                  variant: variant,
                                );
                                context.read<RosterBloc>().add(
                                  AddModel(
                                    squad: widget.updatedSquad,
                                    model: model,
                                  ),
                                );

                                Navigator.pop(context);
                              },
                              child: Container(
                                color: isHovered
                                    ? Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer
                                          .withAlpha(90)
                                    : Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                  horizontal: 3.0,
                                ),
                                child: UnitListCard.variant(variant: variant),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                isExpanded: _expandedStates[index],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
