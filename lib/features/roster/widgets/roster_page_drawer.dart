import 'package:flutter/material.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/features/settings/screens/app_settings_screen.dart';
import 'package:gearforce/features/roster/screens/weapon_display_screen.dart';
import 'package:gearforce/core/theme/app_theme.dart';

const _drawerHeaderHeight = 60.0;

class RosterPageDrawer extends StatelessWidget {
  const RosterPageDrawer({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: AppTheme.drawerPadding,
        children: [
          SizedBox(
            height: _drawerHeaderHeight,
            child: DrawerHeader(
              padding: AppTheme.drawerHeaderPadding,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Center(child: Text(title)),
            ),
          ),
          ListTile(
            leading: Text(
              context.l10n.weaponsTableTitle,
              style: AppTheme.menuStyle,
            ),
            onTap: () {
              Navigator.restorablePopAndPushNamed(
                context,
                WeaponDisplayScreen.routeName,
              );
            },
          ),
          ListTile(
            leading: Text(
              context.l10n.appSettingsTitle(title),
              style: AppTheme.menuStyle,
            ),
            onTap: () {
              Navigator.restorablePopAndPushNamed(
                context,
                AppSettingScreen.routeName,
              );
            },
          ),
          AboutListTile(
            applicationName: title,
            child: Text(
              context.l10n.aboutAppTitle(title),
              style: AppTheme.menuStyle,
            ),
          ),
        ],
      ),
    );
  }
}
