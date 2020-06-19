import 'package:flutter/foundation.dart';

import 'timestamp.dart';

/// This class is used to envelope the data taken from [SocketService].
class RepositoryDataModel {
  final String jsonData;
  final Timestamp timestamp;
  // I need this to know what time I requested the data from the socket
  // So this way I can build a chart

  RepositoryDataModel({@required this.jsonData, @required this.timestamp});

  @override
  String toString() {
    return jsonData + "\n" + timestamp.toString();
  }
}
