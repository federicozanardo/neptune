import 'dart:ui';

import 'package:flutter/material.dart';

import '../colors_palette.dart';
import 'custom_theme.dart';

/// Implementation of 'DefaultTheme'.
class DefaultTheme implements CustomTheme {

  @override
  Color getBackgroundColorOfBox() {
    return ColorsPalette.softGrey;
  }

  @override
  Color getBackgroundBorderOfBox() {
    return ColorsPalette.softGrey;
  }

  @override
  Color getBackgroundColorOfSensorData() {
    return ColorsPalette.blueSky;
  }

  @override
  Color getBorderColorOfSensorData() {
    return ColorsPalette.blueSky;
  }

  @override
  Color getTextColorOfLocation() {
    return ColorsPalette.intenseBlue;
  }

  @override
  Color getTextColorOfSensorValues() {
    return Colors.white;
  }

  @override
  Color getTitleColorOfSensorData() {
    return Colors.black;
  }

  @override
  Color getTitleOfSensorDataInDashboard() {
    return Colors.white;
  }
}