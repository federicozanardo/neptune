import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../models/repository/repository_data_model.dart';
import '../../models/ui/wind.dart';
import '../../repositories/repository_socket.dart';
import '../bloc.dart';

/// BLoC for [WindPage].
class WindBloc extends Bloc<Wind> {
  WindBloc({@required this.repository, @required socketData})
      : super(repository: repository, socketData: socketData);
  final RepositorySocket repository;

  /// It defines a way to retrieve data from JSON
  ///
  /// This method permits to parse JSON data and retrieve the data the BLoC
  /// need.
  @override
  Wind getDataFromJSON(RepositoryDataModel repositoryData) {
    Map<String, dynamic> map = jsonDecode(repositoryData.jsonData);
    return Wind.fromJson(map);
  }
}
