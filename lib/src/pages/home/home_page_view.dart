import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gearforce/src/pages/home/home_page_drawer.dart';
import 'package:gearforce/src/pages/settings/settings_page_view.dart';
import 'package:gearforce/src/widgets/responsive_size.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
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
          final rosterMetaData = Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(child: Text('Gearforce')),
                Text('W:${constraints.minWidth}/${constraints.maxWidth}'),
                Text('H:${constraints.minHeight}/${constraints.maxHeight}'),
              ],
            ),
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
      drawer: HomePageDrawer(title: AppLocalizations.of(context)!.appTitle),
    );
  }
}
