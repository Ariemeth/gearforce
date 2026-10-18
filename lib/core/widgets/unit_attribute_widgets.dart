import 'package:flutter/material.dart';
import 'package:gearforce/core/theme/app_theme.dart';

/// A label widget used in unit stat tables (e.g. "TV", "Arm", "Gu").
///
/// Renders bold text at [AppTheme.attributeLabelFontSize].
class UnitAttributeLabel extends StatelessWidget {
  const UnitAttributeLabel(
    this.labelText, {
    super.key,
    this.textAlign = TextAlign.center,
  });

  final String labelText;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText,
      textAlign: textAlign,
      style: const TextStyle(
        fontSize: AppTheme.attributeLabelFontSize,
        fontWeight: AppTheme.attributeLabelFontWeight,
      ),
    );
  }
}

/// A value widget used in unit stat tables (e.g. "6", "4+", "W/G:7").
///
/// Optionally wraps in a [Tooltip] when [tooltipMessage] is provided.
class UnitAttributeValue extends StatelessWidget {
  const UnitAttributeValue(
    this.labelText, {
    super.key,
    this.textAlign = TextAlign.center,
    this.tooltipMessage,
  });

  final String labelText;
  final TextAlign textAlign;
  final String? tooltipMessage;

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      labelText,
      textAlign: textAlign,
      style: const TextStyle(
        fontSize: AppTheme.attributeValueFontSize,
        fontWeight: AppTheme.attributeValueFontWeight,
      ),
    );

    return tooltipMessage == null
        ? textWidget
        : Tooltip(message: tooltipMessage, child: textWidget);
  }
}
