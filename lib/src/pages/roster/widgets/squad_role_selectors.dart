import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/generated/i18n/app_localizations.dart';
import 'package:gearforce/src/models/roster/squad.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/pages/roster/widgets/role_selector.dart';

const _squadRoleSelectionRowMaxWidth = 450.0;

class SquadRoleSelectors extends StatelessWidget {
  final Squad squad;

  const SquadRoleSelectors({super.key, required this.squad});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _squadRoleSelectionRowMaxWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SquadRoleSelector(
            selectedRole: squad.primaryRole,
            label: AppLocalizations.of(context)!.squadPrimaryRoleLabelText,
            allowNone: false, // Disallow "None" for primary role
            onChanged: (Role? newPrimaryRole) {
              if (newPrimaryRole != null) {
                context.read<RosterBloc>().add(
                  UpdateSquadRoles(
                    squad: squad,
                    primaryRole: newPrimaryRole,
                    secondaryRole: squad.secondaryRole,
                  ),
                );
              }
            },
          ),
          SquadRoleSelector(
            selectedRole: squad.secondaryRole,
            label: AppLocalizations.of(context)!.squadSecondaryRoleLabelText,
            allowNone: true,
            onChanged: (Role? newSecondaryRole) {
              if (newSecondaryRole != squad.primaryRole) {
                context.read<RosterBloc>().add(
                  UpdateSquadRoles(
                    squad: squad,
                    primaryRole: squad.primaryRole,
                    secondaryRole: newSecondaryRole,
                  ),
                );
              }
            },
            roles: Role.values
                .where((role) => role != squad.primaryRole)
                .toList(), // Exclude primary role
          ),
        ],
      ),
    );
  }
}
