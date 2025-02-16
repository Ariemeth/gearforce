import 'package:flutter/widgets.dart';

enum ScreenSize {
  small,
  large,
}

class ResponsiveSize {
  static const int smallBreakpoint = 1000;

  static ScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < smallBreakpoint) {
      return ScreenSize.small;
    } else {
      return ScreenSize.large;
    }
  }
}
