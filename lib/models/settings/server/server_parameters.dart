import 'package:flutter/foundation.dart';

import '../../../repositories/repository_socket.dart';

/// This class permits to check the input values for [ipAddress], [port] and
/// [pollingInterval].
class ServerParameters {
  final RepositorySocket repositorySocket;
  String ipAddress;
  int port;
  int pollingInterval;

  List<String> _textError = List<String>();

  /// Constructor.
  ServerParameters({@required this.repositorySocket}) {
    this.ipAddress = repositorySocket.socketService.serverIPAddress;
    this.port = repositorySocket.socketService.serverPort;
    this.pollingInterval = repositorySocket.pollingInterval;
  }

  /// Get error messages.
  ///
  /// It groups all the error sentences.
  String get textError {
    String tempErrorString = "";

    _textError.forEach((error) {
      tempErrorString += error + "\n";
    });

    // Clear the buffer.
    _textError.clear();

    // Return the errors caught.
    return tempErrorString.substring(0, tempErrorString.length - 1);
  }

  /// Check if the input value respects the constraints of [ipAddress].
  ///
  /// [ipAddress] has two constraints:
  /// 1. Do not enter the same value set in the file yet
  /// 4. Input value must not be empty
  bool canUpdateIPAddress(String ipAddress) {
    // Check if the input value is empty.
    if (ipAddress.trim() != "") {

      // Check that the input value is not the same as the previous one.
      if (ipAddress != this.ipAddress) {
        return true;
      } else {
        _textError.add("The IP insert is equal to the old");
        return false;
      }
    } else {
      _textError.add("IP Address field is empty");
      return false;
    }
  }

  /// Check if the input value respects the constraints of [port].
  ///
  /// [port] has four constraints:
  /// 1. Do not enter the same value set in the file yet
  /// 2. Do not use floating values
  /// 3. Input value must me greater than zero and less than 65536
  /// 4. Input value must not be empty
  bool canUpdatePort(String port) {
    if (isPortEmpty(port)) {
      return true;
    } else {
      // Check if the input value is empty.
      if (port.trim() != "") {

        // Parse the value from string to int.
        int tempPort = int.parse(port);

        // Check that the input value is greater than zero and less than 65536.
        if (tempPort > 0 && tempPort < 65536) {

          // Check that the input value is not the same as the previous one.
          if (tempPort != this.port) {
            return true;
          } else {
            _textError.add("The port insert is equal to the old");
            return false;
          }
        } else {
          _textError.add("The port insert is out of range");
          return false;
        }
      } else {
        _textError.add("Port field is empty");
        return false;
      }
    }
  }

  /// Check if the input value respects the constraints of [pollingInterval].
  ///
  /// [pollingInterval] has four constraints:
  /// 1. Do not enter the same value set in the file yet
  /// 2. Do not use floating values
  /// 3. Input value must me greater than zero
  /// 4. Input value must not be empty
  bool canUpdatePollingInterval(String pollingInterval) {
    if (isPollingIntervalEmpty(pollingInterval)) {
      return true;
    } else {

      // Check if the input value is empty.
      if (pollingInterval.trim() != "") {

        // Parse the value from string to int.
        int tempPollingValue = int.parse(pollingInterval);

        // Check that the input value is greater than zero.
        if (tempPollingValue > 0) {

          // Check that the input value is not the same as the previous one.
          if (tempPollingValue != this.pollingInterval) {
            return true;
          } else {
            _textError.add("The polling interval insert is equal to the old");
            return false;
          }
        } else {
          _textError.add("You can only insert an integer grater than zero");
          return false;
        }
      } else {
        _textError.add("Port field is empty");
        return false;
      }
    }
  }

  /// Check if [ipAddress] variable is empty.
  bool isIPAddressEmpty(String ipAddress) {
    return ipAddress == "";
  }

  /// Check if [port] variable is empty.
  bool isPortEmpty(String port) {
    return port == "";
  }

  /// Check if [pollingInterval] variable is empty.
  bool isPollingIntervalEmpty(String pollingInterval) {
    return pollingInterval == "";
  }

  /// Check it there are any empty field.
  bool isSomeoneFilled(String ipAddress, String port, String pollingInterval) {
    return !isIPAddressEmpty(ipAddress) ||
        !isPortEmpty(port) ||
        !isPollingIntervalEmpty(pollingInterval);
  }

  /// Update the value of [serverIPAddress].
  void updateIP(String rawIPAddress) {
    repositorySocket.socketService.serverIPAddress = rawIPAddress.trim();
  }

  /// Update the value of [serverPort].
  void updatePort(String rawPort) {
    repositorySocket.socketService.serverPort = int.parse(rawPort.trim());
  }

  /// Update the value of [pollingInterval].
  void updatePollingInterval(String rawPollingInterval) {
    repositorySocket.pollingInterval = int.parse(rawPollingInterval.trim());
  }
}
