import 'package:flutter/widgets.dart';

/// Screen size classification following Material 3 canonical window size classes.
enum ScreenSize { compact, medium, expanded }

class ResponsiveSize {
  // Material 3 canonical window size class breakpoints
  static const double compactMaxWidth = 600;
  static const double mediumMaxWidth = 840;

  /// Get screen size from [BoxConstraints] (preferred).
  ///
  /// Responds to the actual available space rather than the full window,
  /// which is important when the widget is inside another constrained container.
  static ScreenSize fromConstraints(BoxConstraints constraints) {
    final width = constraints.maxWidth;
    if (width < compactMaxWidth) return ScreenSize.compact;
    if (width < mediumMaxWidth) return ScreenSize.medium;
    return ScreenSize.expanded;
  }

  /// Get screen size from [BuildContext] via [MediaQuery].
  ///
  /// Use this when [BoxConstraints] are not available, e.g. outside a
  /// [LayoutBuilder].
  static ScreenSize fromContext(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < compactMaxWidth) return ScreenSize.compact;
    if (width < mediumMaxWidth) return ScreenSize.medium;
    return ScreenSize.expanded;
  }
}
