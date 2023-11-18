import 'package:flutter/material.dart';

import '../../application/config/theme/app_color_scheme.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  AppColorScheme get colors => Theme.of(this).extension<AppColorScheme>()!;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  ThemeData get appTheme => Theme.of(this);

  TextTheme get appTextTheme => appTheme.textTheme;
}
