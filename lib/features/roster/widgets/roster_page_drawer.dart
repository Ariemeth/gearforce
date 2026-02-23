import 'package:flutter/material.dart';
import 'package:gearforce/features/settings/screens/app_settings_screen.dart';
import 'package:gearforce/features/roster/screens/weapon_display_screen.dart';
import 'package:gearforce/core/theme/app_theme.dart';
import 'package:gearforce/core/widgets/responsive_size.dart';

const _drawerHeaderHeight = 60.0;

class RosterPageDrawer extends StatelessWidget {
  const RosterPageDrawer({
    super.key,
    required this.title,
    required this.screenSize,
  });

  final String title;
  final ScreenSize screenSize;

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
          if (screenSize == ScreenSize.small)
            ListTile(
              leading: Text('Weapons Table', style: AppTheme.menuStyle),
              onTap: () {
                print('weapons table selected');
                Navigator.restorablePopAndPushNamed(
                  context,
                  WeaponDisplayScreen.routeName,
                );
              },
            ),
          ListTile(
            leading: Text('$title Settings', style: AppTheme.menuStyle),
            onTap: () {
              Navigator.restorablePopAndPushNamed(
                context,
                AppSettingScreen.routeName,
              );
            },
          ),
          AboutListTile(
            applicationName: title,
            child: Text('About $title', style: AppTheme.menuStyle),
          ),
        ],
      ),
    );
  }
}
