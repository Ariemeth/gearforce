import 'package:flutter/material.dart';
import 'package:gearforce/src/generated/i18n/app_localizations.dart';
import 'package:gearforce/src/pages/roster/models/role.dart';

class SquadRoleSelector extends StatelessWidget {
  final Role? selectedRole;
  final String label;
  final bool allowNone;
  final ValueChanged<Role?> onChanged;

  const SquadRoleSelector({
    super.key,
    required this.selectedRole,
    required this.label,
    this.allowNone = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$label: '),
        DropdownButton<Role?>(
          value: selectedRole,
          items: [
            if (allowNone) null, // Include "None" as null
            ...Role.values,
          ]
              .map(
                (role) => DropdownMenuItem(
                  value: role,
                  child: Text(role?.abbreviation ??
                      AppLocalizations.of(context)!
                          .squadRoleNoneText), // Display "None" for null
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
