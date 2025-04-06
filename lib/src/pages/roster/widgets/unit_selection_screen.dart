import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/models/roster/squad.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/theme/app_theme.dart';

class UnitSelectionScreen extends StatelessWidget {
  const UnitSelectionScreen({
    super.key,
    required this.updatedSquad,
  });

  final Squad updatedSquad;

  @override
  Widget build(BuildContext context) {
    final rosterState = context.read<RosterBloc>().state;

    // Fetch available units from the rule set
    final availableUnits = rosterState.ruleSet.getAvailableUnits();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Unit'),
      ),
      body: ListView.builder(
        itemCount: availableUnits.length,
        itemBuilder: (context, index) {
          final unit = availableUnits[index];
          return ListTile(
            title: Center(
              child: Text(
                unit.name,
                style: AppTheme.subtitleStyle,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          print(
                              'Adding unit: ${variant.name} to squad: ${updatedSquad.name}');
                          Navigator.pop(context, updatedSquad);
                        },
                        child: Container(
                          color: isHovered
                              ? Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer
                                  .withAlpha(100)
                              : Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            variant.name,
                            style: AppTheme.bodyStyle
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
