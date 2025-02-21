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

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle rosterNameTextStyle = titleStyle;

  static TextStyle textInputStyle = TextStyle(
    fontSize: bodyStyle.fontSize,
    fontWeight: bodyStyle.fontWeight,
    fontStyle: FontStyle.italic,
  );

  // Paddings
  static const EdgeInsets defaultPadding = EdgeInsets.all(2);
  static const EdgeInsets listTilePadding = defaultPadding;

  static const EdgeInsets drawerHeaderPadding = EdgeInsets.all(4.0);
  static const EdgeInsets drawerPadding = EdgeInsets.all(4.0);
}
