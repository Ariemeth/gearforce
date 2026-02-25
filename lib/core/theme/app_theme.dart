import 'package:flutter/material.dart';

class AppTheme {
  // ============================================================================
  // General Text Styles
  // ============================================================================

  static const TextStyle titleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle menuStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textHintStyle = TextStyle(
    fontSize: bodyStyle.fontSize,
    fontWeight: bodyStyle.fontWeight,
    fontStyle: FontStyle.italic,
  );

  static TextStyle textInputFieldStyle = TextStyle(fontSize: 14);

  static const TextStyle dropdownHintTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );

  // ============================================================================
  // Roster & Squad Text Styles
  // ============================================================================

  static const TextStyle rosterNameTextStyle = titleStyle;

  static const TextStyle squadNameStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle squadNameEditingStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle squadInfoStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle squadUnitNameStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle squadUnitBodyStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  // ============================================================================
  // Spacing (Paddings)
  // ============================================================================

  static const EdgeInsets defaultPadding = EdgeInsets.all(0);
  static const EdgeInsets listTilePadding = defaultPadding;

  static const EdgeInsets defaultPagePadding = EdgeInsets.fromLTRB(5, 3, 5, 3);

  static const EdgeInsets rosterNameSectionPadding = EdgeInsets.symmetric(
    vertical: 2.0,
    horizontal: 5.0,
  );

  static const EdgeInsets dropdownTextPadding = EdgeInsets.fromLTRB(
    5.0,
    1.0,
    1.0,
    1.0,
  );

  static const EdgeInsets factionSelectorPadding = EdgeInsets.only(left: 5.0);

  static const EdgeInsets subfactionSelectorPadding = EdgeInsets.only(
    left: 5.0,
  );

  static const EdgeInsets drawerHeaderPadding = EdgeInsets.all(4.0);
  static const EdgeInsets drawerPadding = EdgeInsets.all(4.0);

  // ============================================================================
  // Sizing
  // ============================================================================

  // Form Layout
  static const double defaultLabelWidth = 90.0;

  // Unit Card Attributes
  static const double attributeLabelFontSize = 14;
  static const FontWeight attributeLabelFontWeight = FontWeight.w700;
  static const double attributeValueFontSize = 14;
  static const FontWeight attributeValueFontWeight = FontWeight.normal;

  // Weapon and Trait Display
  static const double weaponAndTraitLabelWidth = 134.0;
  static const double weaponAndTraitLabelGap = 4.0;

  // ============================================================================
  // Colors
  // ============================================================================

  static const Color deleteIconColor = Color.fromARGB(255, 190, 22, 10);

  // ============================================================================
  // Tooltip Configuration
  // ============================================================================

  static const Duration tooltipWaitDuration = Duration(milliseconds: 600);
}
