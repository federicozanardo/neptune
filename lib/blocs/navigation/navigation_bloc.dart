import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../models/repository/repository_data_model.dart';
import '../../models/ui/navigation.dart';
import '../../repositories/repository_socket.dart';
import '../bloc.dart';

/// BLoC for [NavigationPage].
class NavigationBloc extends Bloc<Navigation> {
  NavigationBloc({@required this.repository, @required socketData})
      : super(repository: repository, socketData: socketData);
  final RepositorySocket repository;

  /// It defines a way to retrieve data from JSON
  ///
  /// This method permits to parse JSON data and retrieve the data the BLoC
  /// need.
  @override
  Navigation getDataFromJSON(RepositoryDataModel repositoryModel) {
    Map<String, dynamic> map = jsonDecode(repositoryModel.jsonData);
    return Navigation.fromJson(map);
  }
}
