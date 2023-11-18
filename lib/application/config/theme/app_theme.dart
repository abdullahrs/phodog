import 'package:flutter/material.dart';
import 'app_color_scheme.dart';

final ThemeData _appTheme = ThemeData(
  fontFamily: 'Mulish',
);

final ThemeData appDarkTheme = _appTheme.copyWith(
  brightness: Brightness.dark,
  useMaterial3: true,
  extensions: <ThemeExtension<dynamic>>[
    AppColorScheme.dark,
  ],
);
final ThemeData appLightTheme = _appTheme.copyWith(
  brightness: Brightness.light,
  useMaterial3: true,
  extensions: <ThemeExtension<dynamic>>[
    AppColorScheme.light,
  ],
);
