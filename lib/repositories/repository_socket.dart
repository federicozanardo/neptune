import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/repository/repository_data_model.dart';
import '../models/settings/cache/cache.dart';
import '../models/settings/server/server_settings.dart';
import '../services/socket_service.dart';

/// This class represents a Repository for [SocketService]. It's part of
/// Repository layer.
class RepositorySocket {
  final SocketService socketService = SocketService();
  final ServerSettings serverSettings;
  int pollingInterval;
  Timer _timer;
  bool _isTimerActive = false;
  bool _internetConnection;
  bool _timeoutSocket;
  Cache cache = Cache<RepositoryDataModel>();
  ValueNotifier<RepositoryDataModel> socketData =
      ValueNotifier<RepositoryDataModel>(null);

  /// Constructor.
  RepositorySocket({this.serverSettings}) {
    socketService.serverIPAddress = serverSettings.ipAddress;
    socketService.serverPort = int.parse(serverSettings.port);
    pollingInterval = int.parse(serverSettings.pollingInterval);
  }

  /// This method permits to start [Timer] and polling.
  ///
  /// Verify that the timer has not been started before.
  Future<void> start() async {
    if (!_isTimerActive) {
      _isTimerActive = true;
      log("Start", name: "Repository");

      _internetConnection = true;
      _timeoutSocket = true;

      // Get data immediately at startup stage of the app
      // Don't wait 'pollingInterval' seconds to get the data
      await _getDataFromSocket();

      if (_internetConnection && _timeoutSocket) {
        // Start the timer
        _timer = Timer.periodic(
          Duration(seconds: pollingInterval),
          (Timer timer) => _getDataFromSocket(),
        );
      }
    }
  }

  /// This method permits to stop [Timer] and polling.
  ///
  /// Verify that the timer has not been stopped before.
  void stop() {
    if (_isTimerActive) {
      _isTimerActive = false;
      log("Stop", name: "Repository");

      if (_timer != null) {
        _timer.cancel();
      }
    }
  }

  /// This method uses methods of [SocketService].
  ///
  /// It retrieves data from the socket. It saves the data received in cache
  /// and sends them through the [ValueNotifier<RepositoryDataModel>] channel.
  Future<void> _getDataFromSocket() async {
    RepositoryDataModel repositoryData;

    if (_internetConnection && _timeoutSocket) {
      try {
        repositoryData = await socketService.getData();
        cache.save(repositoryData);
        socketData.value = repositoryData;

        _internetConnection = true;
        _timeoutSocket = true;
      } on SocketException catch (e) {
        _internetConnection = false;
        print("No internet connection");
      } on TimeoutException catch (e) {
        _timeoutSocket = false;
        print("Timeout");
      }
    }
  }

  /// This method stops the [Timer].
  ///
  /// It's necessary when the object has to be de-allocated.
  void dispose() {
    this.stop();
  }
}
