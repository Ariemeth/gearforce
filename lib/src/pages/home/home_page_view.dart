import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
          final rosterMetaData = Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                      'Gearforce W:${constraints.minWidth}/${constraints.maxWidth}, H:${constraints.minHeight}/${constraints.maxHeight}')),
            ],
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 50,
              child: DrawerHeader(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Center(
                  child: Text(AppLocalizations.of(context)!.appTitle),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: AboutListTile(
                applicationName: AppLocalizations.of(context)!.appTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
