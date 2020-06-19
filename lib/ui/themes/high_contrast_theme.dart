import 'dart:ui';

import 'package:flutter/material.dart';

import 'custom_theme.dart';

/// Implementation of 'HighContrastTheme'.
class HighContrastTheme implements CustomTheme {

  @override
  Color getBackgroundColorOfBox() {
    return Colors.white;
  }

  @override
  Color getBackgroundBorderOfBox() {
    return Colors.black;
  }

  @override
  Color getBackgroundColorOfSensorData() {
    return Colors.white;
  }

  @override
  Color getBorderColorOfSensorData() {
    return Colors.black;
  }

  @override
  Color getTextColorOfLocation() {
    return Colors.black;
  }

  @override
  Color getTextColorOfSensorValues() {
    return Colors.black;
  }

  @override
  Color getTitleColorOfSensorData() {
    return Colors.black;
  }

  @override
  Color getTitleOfSensorDataInDashboard() {
    return Colors.black;
  }
}