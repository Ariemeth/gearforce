import 'package:flutter/material.dart';
import 'package:gearforce/src/generated/i18n/app_localizations.dart';
import 'package:gearforce/src/models/roster/squad.dart';
import 'package:gearforce/src/pages/roster/screens/squad_details_screen.dart';
import 'package:gearforce/src/pages/roster/widgets/add_squad_button.dart';
import 'package:gearforce/src/theme/app_theme.dart';

class SquadDisplay extends StatelessWidget {
  final List<Squad> squads;

  const SquadDisplay({super.key, required this.squads});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: squads.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.noSquadsText,
                    style: AppTheme.subtitleStyle,
                  ),
                )
              : ListView.builder(
                  itemCount: squads.length,
                  itemBuilder: (context, index) {
                    final squad = squads[index];

                    return ListTile(
                      title: Text(
                        squad.name, // Use name instead of id
                        style: AppTheme.subtitleStyle,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SquadDetailsScreen(squad: squad),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
        AddSquadButton(squads: squads),
      ],
    );
  }
}
