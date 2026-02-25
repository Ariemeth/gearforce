import 'package:flutter/material.dart';

/// A centered, max-width-constrained wrapper for screen body content.
///
/// Use this to ensure content doesn't stretch edge-to-edge on large screens
/// while staying centered horizontally. By default content aligns to the top.
///
/// Example:
/// ```dart
/// body: ConstrainedContent(
///   maxWidth: 800,
///   padding: EdgeInsets.all(16),
///   child: MyContentWidget(),
/// )
/// ```
class ConstrainedContent extends StatelessWidget {
  const ConstrainedContent({
    super.key,
    required this.maxWidth,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.topCenter,
    required this.child,
  });

  /// Maximum width the content can occupy.
  final double maxWidth;

  /// Padding around the child inside the constraint box.
  final EdgeInsetsGeometry padding;

  /// Alignment within the available space. Defaults to [Alignment.topCenter].
  final AlignmentGeometry alignment;

  /// The content widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
