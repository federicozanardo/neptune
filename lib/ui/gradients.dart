import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

class Gradients {
  static LinearGradient getLinearGradient(
      {@required Alignment beginAlignment,
      @required Alignment endAlignment,
      @required List<Color> colors}) {
    return LinearGradient(
      begin: beginAlignment,
      end: endAlignment,
      colors: colors,
    );
  }

  static List<Color> crazyOrange() {
    return [Color.fromRGBO(211, 131, 18, 1), Color.fromRGBO(168, 50, 121, 1)];
  }

  static List<Color> blueSky() {
    return [Color.fromRGBO(19, 241, 252, 1), Color.fromRGBO(4, 112, 220, 1)];
  }

  static List<Color> blueRaspberry() {
    return [Color.fromRGBO(0, 180, 219, 1), Color.fromRGBO(0, 131, 176, 1)];
  }

  static List<Color> softBlueSky() {
    return [Color.fromRGBO(23, 234, 217, 1), Color.fromRGBO(96, 120, 234, 1)];
  }

  static List<Color> seaWater() {
    return [Color.fromRGBO(15, 240, 179, 1), Color.fromRGBO(9, 182, 195, 1)];
  }

  static List<Color> blueMarine() {
    return [Color.fromRGBO(15, 240, 179, 1), Color.fromRGBO(3, 110, 217, 1)];
  }

  static List<Color> freshGreen() {
    return [Color.fromRGBO(66, 230, 149, 1), Color.fromRGBO(59, 178, 184, 1)];
  }

  static List<Color> softOrange() {
    return [Color.fromRGBO(250, 217, 97, 1), Color.fromRGBO(247, 107, 28, 1)];
  }

  static List<Color> strongOrange() {
    return [Color.fromRGBO(242, 213, 15, 1), Color.fromRGBO(218, 6, 65, 1)];
  }

  static List<Color> deepPurpleBlue() {
    return [Color.fromRGBO(91, 36, 122, 1), Color.fromRGBO(27, 206, 223, 1)];
  }

  static List<Color> purplePink() {
    return [Color.fromRGBO(240, 47, 194, 1), Color.fromRGBO(96, 148, 234, 1)];
  }

  static List<Color> sea() {
    return [Color.fromRGBO(28, 78, 104, 1), Color.fromRGBO(255, 255, 255, 1)];
  }
}
