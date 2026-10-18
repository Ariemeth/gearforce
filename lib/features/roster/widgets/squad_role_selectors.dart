import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/role_selector.dart';

class SquadRoleSelectors extends StatelessWidget {
  final Squad squad;

  const SquadRoleSelectors({super.key, required this.squad});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SquadRoleSelector(
            selectedRole: squad.primaryRole,
            label: context.l10n.squadPrimaryRoleLabelText,
            allowNone: false, // Disallow "None" for primary role
            onChanged: (Role? newPrimaryRole) {
              if (newPrimaryRole != null) {
                context.read<RosterCubit>().updateSquadRoles(
                  squad: squad,
                  primaryRole: newPrimaryRole,
                  secondaryRole: squad.secondaryRole,
                );
              }
            },
          ),
          SquadRoleSelector(
            selectedRole: squad.secondaryRole,
            label: context.l10n.squadSecondaryRoleLabelText,
            allowNone: true,
            onChanged: (Role? newSecondaryRole) {
              if (newSecondaryRole != squad.primaryRole) {
                context.read<RosterCubit>().updateSquadRoles(
                  squad: squad,
                  primaryRole: squad.primaryRole,
                  secondaryRole: newSecondaryRole,
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
