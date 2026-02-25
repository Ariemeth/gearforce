import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/generated/i18n/app_localizations.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/screens/squad_details_screen.dart';
import 'package:gearforce/features/roster/widgets/add_squad_button.dart';
import 'package:gearforce/core/theme/app_theme.dart';

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
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_forever_outlined,
                          color: AppTheme.deleteIconColor,
                        ),
                        onPressed: () async {
                          final l10n = AppLocalizations.of(context)!;
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(l10n.removeSquadConfirmTitle),
                              content: Text(
                                l10n.removeSquadConfirmMessage(squad.name),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text(l10n.cancelButtonText),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: Text(l10n.removeButtonText),
                                ),
                              ],
                            ),
                          );
                          if (confirmed == true && context.mounted) {
                            context.read<RosterBloc>().add(
                              RemoveSquad(squad: squad),
                            );
                          }
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SquadDetailsScreen(squadId: squad.id),
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
