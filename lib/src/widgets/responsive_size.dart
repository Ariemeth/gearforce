import 'package:flutter/widgets.dart';

enum ScreenSize { small, large }

class ResponsiveSize {
  static const int smallBreakpointWidth = 850;
  static const int smallBreakpointHeight = 450;

  static ScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (width < smallBreakpointWidth || height < smallBreakpointHeight) {
      return ScreenSize.small;
    } else {
      return ScreenSize.large;
    }
  }
}
