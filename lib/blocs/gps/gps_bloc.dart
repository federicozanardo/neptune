import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../models/repository/repository_data_model.dart';
import '../../models/ui/gps.dart';
import '../../repositories/repository_socket.dart';
import '../bloc.dart';

/// BLoC for [GPSPage].
class GPSBloc extends Bloc<GPS> {
  GPSBloc({@required this.repository, @required socketData})
      : super(repository: repository, socketData: socketData);
  final RepositorySocket repository;

  /// It defines a way to retrieve data from JSON
  ///
  /// This method permits to parse JSON data and retrieve the data the BLoC
  /// need.
  @override
  GPS getDataFromJSON(RepositoryDataModel repositoryModel) {
    Map<String, dynamic> map = jsonDecode(repositoryModel.jsonData);
    return GPS.fromJson(map);
  }
}
