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
      body: LayoutBuilder(builder: (context, constraints) {
        final screenSize = ResponsiveSize.getScreenSize(constraints.maxWidth);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
                child: Text(
                    'Gearforce W:${constraints.minWidth}/${constraints.maxWidth}, H:${constraints.minHeight}/${constraints.maxHeight}')),
          ],
        );
      }),
    );
  }
}
