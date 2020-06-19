import 'dart:ui';

import 'package:flutter/material.dart';

/// This is a common class for building themes.
abstract class CustomTheme {

  /// Get the background color of the element that contains the data of the
  /// sensor.
  Color getBackgroundColorOfSensorData();

  /// Get the border color of the element that contains the data of the
  /// sensor.
  Color getBorderColorOfSensorData();

  /// Get the background color of the box.
  Color getBackgroundColorOfBox();

  /// Get the background border color of the box.
  Color getBackgroundBorderOfBox();

  /// Get the color of sensor values.
  Color getTextColorOfSensorValues();

  /// Get the color of sensor data title.
  Color getTitleColorOfSensorData();

  /// Get the color of sensor data title in [DashboardPage].
  Color getTitleOfSensorDataInDashboard();

  /// Get the color of text in [LocationWidget].
  Color getTextColorOfLocation();
}
