import 'base_model.dart';

/// Model for [NavigationBloc].
class Navigation extends BaseModel {
  final double apparentWindSpeed;
  final double speedOverWater;
  final int apparentWindAngle;
  final int magneticHeading;

  /// Constructor.
  Navigation(
      {this.apparentWindSpeed = 0.0,
      this.magneticHeading = 0,
      this.speedOverWater = 0.0,
      this.apparentWindAngle = 0});

  /// Retrieve the data the model needs from JSON data.
  factory Navigation.fromJson(Map<String, dynamic> json) {
    return Navigation(
      apparentWindSpeed: double.parse(json['aws']),
      speedOverWater: double.parse(json['sow']),
      apparentWindAngle: int.parse(json['awa']),
      magneticHeading: int.parse(json['mh']),
    );
  }

  /// Return the data saved in a map.
  ///
  /// This is the implementation of superclass' method.
  @override
  Map<String, dynamic> toMap() {
    return {
      'aws': apparentWindSpeed,
      'awa': apparentWindAngle,
      'mh': magneticHeading,
      'sow': speedOverWater,
    };
  }
}
