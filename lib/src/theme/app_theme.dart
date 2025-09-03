import 'package:flutter/material.dart';

class AppTheme {
  // Text Styles
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

  static const TextStyle rosterNameTextStyle = titleStyle;

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

  // Paddings
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
}
