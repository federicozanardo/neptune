import 'dart:async';
import 'dart:developer';
import 'dart:io';

import '../models/repository/repository_data_model.dart';
import '../models/repository/timestamp.dart';

/// This class represents a service that provides a socket and it is used by
/// the Repository layer. It's part of Service layer.
class SocketService {
  String serverIPAddress;
  int serverPort;

  /// This method permits to get the data from the socket.
  ///
  /// It establishes a connection with the remote server through the socket.
  /// Read the thesis to understand how the protocol implemented between client
  /// and server works.
  Future<RepositoryDataModel> getData() async {
    Completer<RepositoryDataModel> repositoryData =
        Completer<RepositoryDataModel>();

    try {
      // Establish a new connection.
      Socket socket = await Socket.connect(serverIPAddress, serverPort, timeout: Duration(seconds: 2));
      log("Socket connected", name: "SailingSocket");

      // Listen the channel and save the data received.
      socket.listen((data) async {
        repositoryData.complete(RepositoryDataModel(
          jsonData: String.fromCharCodes(data).trim(),
          timestamp: Timestamp(dateTime: DateTime.now()),
        ));
      });

      // Close the socket.
      socket.close();
      log("Socket closed", name: "SailingSocket");
    } on SocketException catch (e) {
      rethrow;
    } on TimeoutException catch (e) {
      rethrow;
    }
    return repositoryData.future;
  }
}
