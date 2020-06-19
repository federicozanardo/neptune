import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../models/repository/repository_data_model.dart';
import '../../models/ui/dashboard.dart';
import '../../repositories/repository_socket.dart';
import '../bloc.dart';

/// BLoC for [DashboardWidget].
class DashboardWidgetBloc extends Bloc<Dashboard> {
  DashboardWidgetBloc({@required this.repository, @required socketData})
      : super(repository: repository, socketData: socketData);
  final RepositorySocket repository;

  /// It defines a way to retrieve data from JSON
  ///
  /// This method permits to parse JSON data and retrieve the data the BLoC
  /// need.
  @override
  Dashboard getDataFromJSON(RepositoryDataModel repositoryModel) {
    Map<String, dynamic> map = jsonDecode(repositoryModel.jsonData);
    return Dashboard.fromJson(map);
  }

  /// It allows to start the [Timer].
  void start() {
    repository.start();
  }

  /// It allows to stop the [Timer].
  void stop() {
    repository.stop();
  }
}
