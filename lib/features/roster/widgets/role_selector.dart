import 'package:flutter/material.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';

const double _gapBetweenRoleLabelAndDropdown = 8.0;
const double _regularMenuWidth = 60.0;
const double _noneMenuWidth = 75.0;

class SquadRoleSelector extends StatelessWidget {
  final Role? selectedRole;
  final String label;
  final bool allowNone;
  final ValueChanged<Role?> onChanged;
  final List<Role> roles; // Custom list of roles to display

  const SquadRoleSelector({
    super.key,
    required this.selectedRole,
    required this.label,
    this.allowNone = false,
    required this.onChanged,
    this.roles = Role.values, // Default to all roles
  });

  @override
  Widget build(BuildContext context) {
    final validSelectedRole = !roles.contains(selectedRole)
        ? null
        : selectedRole;

    return Row(
      children: [
        Text(label),
        const SizedBox(width: _gapBetweenRoleLabelAndDropdown),
        DropdownButton<Role?>(
          isDense: false,
          menuWidth: allowNone ? _noneMenuWidth : _regularMenuWidth,
          value: validSelectedRole,
          items:
              [
                    if (allowNone) null, // Include "None" as null
                    ...roles,
                  ]
                  .map(
                    (role) => DropdownMenuItem(
                      value: role,
                      child: Text(
                        role?.abbreviation ?? context.l10n.squadRoleNoneText,
                      ), // Display "None" for null
                    ),
                  )
                  .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
