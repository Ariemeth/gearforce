import 'package:material_ui/material_ui.dart';
import 'package:gearforce/core/widgets/responsive_size.dart';

/// A reusable layout widget that selects between [compact], [medium], and
/// [expanded] child widgets based on the available width using [LayoutBuilder].
///
/// If [medium] is not provided it falls back to [compact].
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.compact,
    this.medium,
    required this.expanded,
  });

  /// Widget shown on compact screens (width < 600).
  final Widget compact;

  /// Widget shown on medium screens (600 <= width < 840).
  /// Falls back to [compact] if not provided.
  final Widget? medium;

  /// Widget shown on expanded screens (width >= 840).
  final Widget expanded;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = ResponsiveSize.fromConstraints(constraints);
        return switch (screenSize) {
          ScreenSize.compact => compact,
          ScreenSize.medium => medium ?? compact,
          ScreenSize.expanded => expanded,
        };
      },
    );
  }
}
