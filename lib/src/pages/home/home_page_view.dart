import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gearforce/src/pages/home/widgets/home_page_drawer.dart';
import 'package:gearforce/src/pages/settings/settings_page_view.dart';
import 'package:gearforce/src/widgets/display_layout_constraints.dart';
import 'package:gearforce/src/widgets/responsive_size.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final title = AppLocalizations.of(context)!.appTitle;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(
                  context, SettingsPageView.routeName);
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenSize = ResponsiveSize.getScreenSize(context);
          final rosterMetaData = DisplayLayoutConstraints(
            minScreenWidth: constraints.minWidth,
            maxScreenWidth: constraints.maxWidth,
            minScreenHeight: constraints.minHeight,
            maxScreenHeight: constraints.maxHeight,
          );

          switch (screenSize) {
            case ScreenSize.small:
              return rosterMetaData;
            case ScreenSize.large:
              return Row(
                children: [
                  rosterMetaData,
                  Expanded(
                    child: Container(
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              );
          }
        },
      ),
      drawer: HomePageDrawer(title: title),
    );
  }
}
