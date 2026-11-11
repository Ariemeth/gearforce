import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

/// Utilities for detecting the current platform and providing
/// platform-appropriate defaults.
///
/// **Platform vs screen size:**
/// - [isDesktop], [isMobile], [isWeb] detect the OS / runtime environment.
/// - [isTabletSize] detects large-screen touch devices (tablets) using the
///   screen's shortest dimension. This is a heuristic — Flutter has no
///   built-in tablet flag since tablets share Android/iOS with phones.
/// - Layout adaptation (compact / medium / expanded) is handled by
///   `ResponsiveSize` / `ResponsiveLayout` using available width, which
///   naturally puts tablets into the medium or expanded tier.
class PlatformUtils {
  // Shortest side threshold (in dp) for considering a device a tablet.
  // 600dp is the Material Design canonical breakpoint for "medium" devices.
  static const double _tabletShortestSideThreshold = 600;

  /// Whether the app is running on a desktop OS (Windows, macOS, Linux)
  /// and NOT in a web browser.
  static bool get isDesktop =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS);

  /// Whether the app is running on a mobile OS (Android, iOS)
  /// and NOT in a web browser. This includes both phones and tablets.
  static bool get isMobile =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  /// Whether the app is running in a web browser.
  static bool get isWeb => kIsWeb;

  /// Whether the device has a tablet-sized screen.
  ///
  /// Uses the shortest side of the screen (so it works in both portrait
  /// and landscape). A device whose shortest side is >= 600dp is considered
  /// a tablet, which matches the Material 3 "medium" window size class.
  ///
  /// Requires a [BuildContext] because it reads [MediaQuery].
  static bool isTabletSize(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide >= _tabletShortestSideThreshold;
  }

  /// Whether this is a phone-sized mobile device (mobile OS + small screen).
  static bool isPhone(BuildContext context) =>
      isMobile && !isTabletSize(context);

  /// Whether the primary input is touch (mobile or web on a touch device).
  ///
  /// On desktop this is false (mouse/trackpad), on mobile/tablet it's true.
  /// On web this errs on the side of touch-friendly since we can't reliably
  /// detect the input device.
  static bool get isTouchPrimary => isMobile || isWeb;

  /// Returns [VisualDensity.compact] for desktop platforms (denser UI with
  /// smaller touch targets since mouse input is precise) and
  /// [VisualDensity.standard] for mobile / web (including tablets).
  static VisualDensity get adaptiveVisualDensity =>
      isDesktop ? VisualDensity.compact : VisualDensity.standard;
}
