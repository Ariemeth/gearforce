import 'package:flutter/material.dart';
import 'package:gearforce/core/theme/app_theme.dart';

/// A row with a fixed-width right-aligned label and an expanded child.
///
/// Used for form fields like "Faction: [dropdown]" or "Roster Name: [input]".
/// Provides a consistent label-to-field layout across the app.
class LabelledRow extends StatelessWidget {
  const LabelledRow({
    super.key,
    required this.label,
    required this.child,
    this.labelWidth = AppTheme.defaultLabelWidth,
    this.gap = 6.0,
    this.padding = EdgeInsets.zero,
  });

  /// The label text shown on the left.
  final String label;

  /// The form widget (dropdown, text field, etc.) filling the remaining space.
  final Widget child;

  /// Width of the label area. Defaults to [AppTheme.defaultLabelWidth].
  final double labelWidth;

  /// Gap between the label and the child.
  final double gap;

  /// Outer padding for the entire row.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          SizedBox(
            width: labelWidth,
            child: Text(
              label,
              style: AppTheme.subtitleStyle,
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(width: gap),
          Expanded(child: child),
        ],
      ),
    );
  }
}
