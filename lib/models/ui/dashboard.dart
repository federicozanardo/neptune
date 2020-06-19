import 'base_model.dart';

/// Model for [DashboardWidgetBloc].
class Dashboard extends BaseModel {
  final String apparentWindSpeed;
  final String apparentWindAngle;
  final String speedOverGround;
  final String curseOverGround;
  final String magneticHeading;
  final String speedOverWater;
  final String trueWindSpeed;
  final String trueWindAngle;
  final String imu_heading;
  final String calypso_ang;
  final String calypso_amp;
  final String nwang;
  //final String countdown;
  //final String tLine;

  /// Constructor.
  Dashboard({
    this.apparentWindSpeed = "0",
    this.apparentWindAngle = "0",
    this.speedOverGround = "0",
    this.curseOverGround = "0",
    this.magneticHeading = "0",
    this.speedOverWater = "0",
    this.trueWindSpeed = "0",
    this.trueWindAngle = "0",
    this.imu_heading = "0",
    this.calypso_ang = "0",
    this.calypso_amp = "0",
    this.nwang = "0",
  });

  /// Retrieve the data the model needs from JSON data.
  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
      apparentWindSpeed: json['aws'],
      speedOverGround: json['sog'],
      curseOverGround: json['cog'],
      magneticHeading: json['mh'],
      speedOverWater: json['sow'],
      trueWindSpeed: json['tws'],
      trueWindAngle: json['twa'],
      imu_heading: json['imu_heading'],
      calypso_ang: json['calypso_ang'],
      calypso_amp: json['calypso_amp'],
      nwang: json['nwang'],
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
      'sog': speedOverGround,
      'cog': curseOverGround,
      'mh': magneticHeading,
      'sow': speedOverWater,
      'tws': trueWindSpeed,
      'twa': trueWindAngle,
      'imu_heading': imu_heading,
      'calypso_ang': calypso_ang,
      'calypso_amp': calypso_amp,
      'nwang': nwang,
    };
  }
}
