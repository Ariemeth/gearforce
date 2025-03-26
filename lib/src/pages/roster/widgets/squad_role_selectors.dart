import 'package:flutter/material.dart';
import 'package:gearforce/src/generated/i18n/app_localizations.dart';
import 'package:gearforce/src/pages/roster/models/role.dart';
import 'package:gearforce/src/pages/roster/models/squad.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/pages/roster/widgets/role_selector.dart';

class SquadRoleSelectors extends StatelessWidget {
  final Squad squad;

  const SquadRoleSelectors({super.key, required this.squad});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SquadRoleSelector(
            selectedRole: squad.primaryRole,
            label: AppLocalizations.of(context)!.squadPrimaryRoleLabelText,
            allowNone: false, // Disallow "None" for primary role
            onChanged: (Role? newPrimaryRole) {
              if (newPrimaryRole != null) {
                final updatedSquad = squad.copyWith(
                  primaryRole: newPrimaryRole,
                  secondaryRole: newPrimaryRole == squad.secondaryRole
                      ? null
                      : squad
                          .secondaryRole, // Reset secondary role if it matches the new primary role
                  allowSecondaryRoleToBeNull:
                      newPrimaryRole == squad.secondaryRole,
                );
                context.read<RosterBloc>().add(UpdateSquad(updatedSquad));
              }
            },
          ),
        ),
        const SizedBox(width: 16), // Add spacing between selectors
        Expanded(
          child: SquadRoleSelector(
            selectedRole: squad.secondaryRole,
            label: AppLocalizations.of(context)!.squadSecondaryRoleLabelText,
            allowNone: true,
            onChanged: (Role? newSecondaryRole) {
              if (newSecondaryRole != squad.primaryRole) {
                final updatedSquad = squad.copyWith(
                  secondaryRole: newSecondaryRole,
                  allowSecondaryRoleToBeNull: newSecondaryRole == null,
                );
                context.read<RosterBloc>().add(UpdateSquad(updatedSquad));
              }
            },
            roles: Role.values
                .where((role) => role != squad.primaryRole)
                .toList(), // Exclude primary role
          ),
        ),
      ],
    );
  }
}
