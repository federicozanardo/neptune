import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/repository/repository_data_model.dart';
import '../models/ui/base_model.dart';
import '../repositories/repository_socket.dart';

/// Abstraction of BLoC component.
///
/// It allows to have a general abstraction for the building of specific BLoCs.

abstract class Bloc<T extends BaseModel> {

  /// Constructor.
  ///
  /// Set up the listener when new data are available in [socketData].
  Bloc({@required this.repository, @required this.socketData}) {
    socketData.addListener(onReceived);
  }

  final RepositorySocket repository;
  final ValueNotifier<RepositoryDataModel> socketData;
  final StreamController _streamController = StreamController<T>();

  /// It returns the [Stream] of the [StreamController].
  Stream<T> get stream => _streamController.stream;

  /// Forward data to the [Stream].
  ///
  /// This method is used by the constructor. This method is called when a new
  /// data has been introduced in [socketData]. In this way, this method
  /// forwards the last data in [socketData] to the [Stream].
  void onReceived() {
    _streamController.add(getDataFromJSON(socketData.value));
  }

  /// Dispose listener and [Stream].
  ///
  /// It's very important to close correctly the [Stream]. The environment
  /// notify you if you don't close the [Stream]. Moreover, this method removes
  /// the listener set by the constructor and disposes the channel created
  /// between BLoC and Repository.
  void dispose() {
    socketData.removeListener(onReceived);
    socketData.dispose();
    _streamController.close();
  }

  /// Parametric method to retrieve data from JSON
  ///
  /// This method must be implemented by the classes that extend this class.
  /// With this method, the subclasses can parse JSON data for retrieving
  /// the data they need.
  T getDataFromJSON(RepositoryDataModel repositoryData);
}
