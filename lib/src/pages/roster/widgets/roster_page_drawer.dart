import 'package:flutter/material.dart';
import 'package:gearforce/src/theme/app_theme.dart';

final _drawerHeaderHeight = 60.0;

class RosterPageDrawer extends StatelessWidget {
  const RosterPageDrawer({
    super.key,
    required this.title,
  });

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
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Text(title),
              ),
            ),
          ),
          AboutListTile(
            applicationName: title,
          ),
        ],
      ),
    );
  }
}
