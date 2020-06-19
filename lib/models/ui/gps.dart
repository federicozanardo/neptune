import 'base_model.dart';

/// Model for [GPSBloc].
class GPS extends BaseModel {
  final int curseOverGround;
  final int magneticHeading;
  final double speedOverGround;
  final double speedOverWater;

  /// Constructor.
  GPS(
      {this.curseOverGround = 0,
      this.magneticHeading = 0,
      this.speedOverGround = 0.0,
      this.speedOverWater = 0.0});

  /// Retrieve the data the model needs from JSON data.
  factory GPS.fromJson(Map<String, dynamic> json) {
    return GPS(
      curseOverGround: int.parse(json['cog']),
      magneticHeading: int.parse(json['mh']),
      speedOverGround: double.parse(json['sog']),
      speedOverWater: double.parse(json['sow']),
    );
  }

  /// Return the data saved in a map.
  ///
  /// This is the implementation of superclass' method.
  @override
  Map<String, dynamic> toMap() {
    return {
      'cog': curseOverGround,
      'mh': magneticHeading,
      'sog': speedOverGround,
      'sow': speedOverWater,
    };
  }
}
