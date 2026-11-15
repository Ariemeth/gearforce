import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gearforce/core/models/rule_version.dart';
import 'package:gearforce/versions/v4/features/settings/bloc/app_settings_bloc.dart';

class VersionSelector extends StatelessWidget {
  const VersionSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final currentVersion = context.select(
      (AppSettingsCubit cubit) => cubit.state.ruleVersion,
    );

    return DropdownButton<RuleVersion>(
      value: currentVersion,
      underline: const SizedBox.shrink(),
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
      items: RuleVersion.values.map((RuleVersion version) {
        return DropdownMenuItem<RuleVersion>(
          value: version,
          child: Text('Version ${version.versionName}'),
        );
      }).toList(),
      onChanged: (RuleVersion? newVersion) {
        if (newVersion != null && newVersion != currentVersion) {
          context.read<AppSettingsCubit>().updateRuleVersion(newVersion);
          context.go(newVersion.routePath);
        }
      },
    );
  }
}
