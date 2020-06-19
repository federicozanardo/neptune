import 'base_model.dart';

/// Model for [WindBloc].
class Wind extends BaseModel {
  final double apparentWindSpeed;
  final double trueWindSpeed;
  final int apparentWindAngle;
  final int trueWindAngle;

  /// Constructor.
  Wind(
      {this.apparentWindSpeed = 0.0,
      this.trueWindSpeed = 0.0,
      this.apparentWindAngle = 0,
      this.trueWindAngle = 0});

  /// Retrieve the data the model needs from JSON data.
  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      apparentWindSpeed: double.parse(json['aws']),
      trueWindSpeed: double.parse(json['tws']),
      apparentWindAngle: int.parse(json['awa']),
      trueWindAngle: int.parse(json['twa']),
    );
  }

  /// Return the data saved in a map.
  ///
  /// This is the implementation of superclass' method.
  @override
  Map<String, dynamic> toMap() {
    return {
      'aws': apparentWindSpeed,
      'tws': trueWindSpeed,
      'awa': apparentWindAngle,
      'twa': trueWindAngle,
    };
  }
}
