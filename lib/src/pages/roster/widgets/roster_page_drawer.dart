import 'package:flutter/material.dart';
import 'package:gearforce/src/pages/app_settings/screens/app_settings_screen.dart';
import 'package:gearforce/src/theme/app_theme.dart';

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
            leading: Text('$title Settings', style: AppTheme.menuStyle),
            onTap: () {
              Navigator.pop(context);
              Navigator.restorablePushNamed(
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
