import 'package:flutter/material.dart';

Color getAppBarColor(BuildContext context) {
  final Brightness brightness = Theme.of(context).brightness;
  // Default theme
  // return brightness == Brightness.light
  //     ? Theme.of(context).primaryColor
  //     : Theme.of(context).bottomAppBarColor;
  // working for flex_color_scheme package
  return brightness == Brightness.light
      ? Theme.of(context).appBarTheme.backgroundColor!.withOpacity(1)
      : Theme.of(context).appBarTheme.backgroundColor!;
}
