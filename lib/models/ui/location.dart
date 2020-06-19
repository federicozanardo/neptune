import 'base_model.dart';

/// Model for [LocationWidgetBloc].
class Location extends BaseModel {
  final String latitude;
  final String longitude;

  /// Constructor.
  Location({this.latitude = "0", this.longitude = "0"});

  /// Return the data saved in a map.
  ///
  /// This is the implementation of superclass' method.
  @override
  Map<String, dynamic> toMap() {
    return null;
  }
}