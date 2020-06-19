import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'custom_theme.dart';
import 'default_theme.dart';
import 'high_contrast_theme.dart';
import 'themes.dart';

/// This class allows to handle app themes.
class ThemeHandler implements CustomTheme {
  CustomTheme theme;
  Themes _themeChosen;

  /// Constructor.
  ThemeHandler({@required this.theme});

  /// Get the theme chosen.
  Themes get themeChosen => _themeChosen;

  /// This method checks if the dark mode is active or not.
  ///
  /// This method may be useful in the future if you want to change the color
  /// of elements whenever the theme changes.
  static bool isDarkModeActive(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  /// This method allows you to apply a new theme selected by the user.
  void applyTheme(Themes themeChosen) {
    switch (themeChosen) {
      case Themes.DEFAULT:
        _themeChosen = Themes.DEFAULT;
        theme = DefaultTheme();
        break;
      case Themes.HIGH_CONTRAST:
        _themeChosen = Themes.HIGH_CONTRAST;
        theme = HighContrastTheme();
        break;
    }
  }

  /// All these override methods are used to call the respective methods of the
  /// selected theme.
  @override
  Color getBackgroundColorOfBox() {
    return theme.getBackgroundColorOfBox();
  }

  @override
  Color getBackgroundBorderOfBox() {
    return theme.getBackgroundBorderOfBox();
  }

  @override
  Color getBackgroundColorOfSensorData() {
    return theme.getBackgroundColorOfSensorData();
  }

  @override
  Color getBorderColorOfSensorData() {
    return theme.getBorderColorOfSensorData();
  }

  @override
  Color getTextColorOfLocation() {
    return theme.getTextColorOfLocation();
  }

  @override
  Color getTextColorOfSensorValues() {
    return theme.getTextColorOfSensorValues();
  }

  @override
  Color getTitleColorOfSensorData() {
    return theme.getTitleColorOfSensorData();
  }

  @override
  Color getTitleOfSensorDataInDashboard() {
    return theme.getTitleOfSensorDataInDashboard();
  }
}
